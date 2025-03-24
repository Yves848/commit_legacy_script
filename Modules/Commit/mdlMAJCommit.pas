unit mdlMAJCommit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, mdlBase, VirtualTrees, mdlListesFichiers, mdlClientFTP,
  IdComponent, IdFTPCommon, mdlAttenteModale, mdlProjet;

type
  TfrmMAJCommit = class(TfrmAttenteModale)
    procedure ftpClientOnWork(ASender: TObject;
      AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormFinTelechargement(Sender : TObject);
  private
    { Déclarations privées }
    FFTP : TfrmListeFichiers;
  public
    { Déclarations publiques }
    procedure Show(AProjet : TProjet; AServeur: TConnexion); reintroduce;
  end;

var
  frmMAJCommit: TfrmMAJCommit;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmMAJCommit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not FFTP.EnTelechargement;
  if CanClose then
    inherited;
end;

procedure TfrmMAJCommit.FormFinTelechargement(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmMAJCommit.ftpClientOnWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if Assigned(FFTP) and (FFTP.FichierEnCours <> '') then
  begin
    Panel2.Caption := FFTP.FichierEnCours + '(' + IntToStr(AWorkCount) + ')';
    Application.HandleMessage;
  end;
end;

procedure TfrmMAJCommit.Show(AProjet : TProjet; AServeur: TConnexion);
var
  n : PVirtualNode;
  s : string;
  lpFic : PRecFichier;
begin
  inherited Show;
  Update;

  FFTP := TfrmListeFichiers.Create(Self);
  FFTP.SurFinTelechargement := FormFinTelechargement;

  with FFTP do
  begin
    // Connexion
    with ftpClient do
    begin
      OnWork := ftpClientOnWork;
      TransferType := ftBinary;
      Host := AServeur.Serveur;
      Port := AServeur.Port;
      Username := AServeur.Utilisateur;
      Password := AServeur.MotDePasse;
      Connect;
    end;

    // Génération liste des majs
    n := FFTP.vstListesFichiers.AddChild(nil);
    if Assigned(n) then
    begin
      lpFic := FFTP.vstListesFichiers.GetNodeData(n);
      if Assigned(lpFic) then
      begin
        with lpFic^ do
        begin
          s := AServeur.RepertoireBase + '/*';
          Nom := ExtractFileName(StringReplace(s, '/', '\', [rfReplaceAll]));
          Source := StringReplace(ExtractFilePath(StringReplace(s, '/', '\', [rfReplaceAll])), '\', '/', [rfReplaceAll]);
          Destination := AProjet.RepertoireApplication;
          SensTelechargement := stDownload;
          Resursif := True;
          Verification := True;
        end;

        FFTP.Telecharger;
      end
      else
        FormFinTelechargement(Self);
    end
    else
      FormFinTelechargement(Self);
  end;
  Close;
end;

end.
