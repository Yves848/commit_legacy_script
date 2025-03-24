unit mdlListesFichiers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VirtualTrees, IdBaseComponent, IdComponent, IdTCPConnection, Math,
  IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, IdFTPList, ExtCtrls, StrUtils,
  IdAntiFreezeBase, IdException, JclFileUtils, IdFTPCommon;

type
  TSensTelechargement = (stDownload, stUpload);

  PrecFichier = ^TrecFichier;
  TrecFichier = record
    Nom: string;
    Source : string;
    Destination : string;
    TypeFichier : TIdDirItemType;
    Taille : Int64;
    Modification : TDateTime;
    Progression : Integer;
    SensTelechargement : TSensTelechargement;
    Resursif : Boolean;
    Verification : Boolean;
  end;

  TfrmListeFichiers = class(TForm)
    vstListesFichiers: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure ftpClientWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure ftpClientWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure vstListesFichiersBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure vstListesFichiersPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstListesFichiersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure vstListesFichiersGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
  private
    FNoeudEnCours : PVirtualNode;
    FSourceEnCours: PrecFichier;
    FEnTelechargement : Boolean;
    FUtilisationListe : Boolean;
    FAnnule : Boolean;
    FftpClient: TIdFTP;
    FFichierEnCours: string;
    FSurFinTelechargement: TNotifyEvent;
    procedure CreateFTPClient(AAutoLogin : Boolean = False);
  public
    { Déclarations publiques }
    property Annule : Boolean read FAnnule;
    property EnTelechargement : Boolean read FEnTelechargement;
    property NoeudEnCours : PVirtualNode read FNoeudEnCours;
    property UtilisationListe : Boolean read FUtilisationListe write FUtilisationListe;
    property ftpClient : TIdFTP read FftpClient;
    property FichierEnCours : string read FFichierEnCours;
    procedure Telecharger;
    procedure AnnulerTelechargement;
    property SurFinTelechargement : TNotifyEvent read FSurFinTelechargement write FSurFinTelechargement;
  end;

var
  frmListeFichiers: TfrmListeFichiers;

implementation

{$R *.dfm}

const
  C_COLONNE_SOURCE = 0;
  C_COLONNE_DESTINATION = 1;
  C_COLONNE_PROGRESSION = 2;


procedure TfrmListeFichiers.FormCreate(Sender: TObject);
begin
  vstListesFichiers.NodeDataSize := SizeOf(TrecFichier);

  FEnTelechargement := False;
  CreateFTPClient;
end;

procedure TfrmListeFichiers.Telecharger;
var
  lStrFiltre : string;

  procedure ParcourirRepertoire(ARepertoireDistant, ARepertoireLocal : string);
  var
    i : Integer;
    lListe : TStringList;
    lDtFichierLocal : TDateTime;

    function VerifierDateFichier(AFichierDistant, AFichierLocal : string) : Boolean;
    var
	  d : TDateTime;
	begin
      lDtFichierLocal := ftpClient.FileDate(AFichierDistant);
      if FSourceEnCours^.Verification then
        if FileExists(AFichierLocal) then
		begin
          FileAge(AFichierLocal, d);
		  Result := d <= lDtFichierLocal;
		 end
        else
          Result := True
      else
        Result := True;
    end;

  begin
    if not DirectoryExists(ARepertoireLocal) then
      ForceDirectories(ARepertoireLocal);

    with ftpClient do
    begin
      ChangeDir(ARepertoireDistant);
      lListe := TStringList.Create; List(lListe, lStrFiltre, False);
      for i := 0 to lListe.Count - 1 do
        if Size(lListe[i]) = -1 then
        begin
          if (lListe[i][1] = '_') and (lListe[i][Length(lListe[i])] = '_') then
            DeleteDirectory(ARepertoireLocal + '\' + Copy(lListe[i], 2, Length(lListe[i]) - 2), False)
          else
            if FSourceEnCours^.Resursif then
            begin
              ParcourirRepertoire(ARepertoireDistant + '/' + lListe[i],
                                  ARepertoireLocal + '\' + lListe[i]);
              ChangeDir(ARepertoireDistant);
            end
        end
        else
        begin
          FSourceEnCours^.Nom := lListe[i];
          if (lListe[i][1] = '_') and (lListe[i][Length(lListe[i])] = '_') then
            DeleteFile(ARepertoireLocal + '\' + Copy(lListe[i], 2, Length(lListe[i]) - 2))
          else
            if VerifierDateFichier(ARepertoireDistant + '/' + lListe[i], ARepertoireLocal + '\' + lListe[i]) then
            begin
              FFichierEnCours := ARepertoireDistant + '/' + lListe[i];
              ftpClient.Get(FFichierEnCours, ARepertoireLocal + '\' + lListe[i], True);
              SetFileLastWrite(ARepertoireLocal + '\' + lListe[i], lDtFichierLocal);
            end;
        end;
      end;
  end;

begin
  if not FEnTelechargement then
    with vstListesFichiers do
    begin
      FNoeudEnCours := GetFirstChild(nil);
      if Assigned(FNoeudEnCours) then
      begin
        FEnTelechargement := True;
        repeat
          FSourceEnCours := GetNodeData(FNoeudEnCours);
          if Assigned(FSourceEnCours) then
          begin
            with FSourceEnCours^ do
              try
                FAnnule := False;
                if SensTelechargement = stDownload then
                  if Pos('*', Nom) > 0 then
                  begin
                    lStrFiltre := Nom;
                    ParcourirRepertoire(Source, Destination);
                    FSourceEnCours^.Nom := lStrFiltre;
                  end
                  else
                  begin
                    FFichierEnCours := Source + '/' + Nom;
                    if FSourceEnCours^.Progression <> -10 then
                      ftpClient.Get(FFichierEnCours, Destination + '\' + Nom, True)
                    else
                      ftpClient.Get(FFichierEnCours, Destination + '\' + Nom, True, True)
                  end
                else
                  ftpClient.Put(Source + '\' + Nom, Destination + '/' + Nom, True);
              except
                on E:EIdConnClosedGracefully do
                begin
                  FSourceEnCours^.Progression := -10;
                  CreateFTPClient(True);
                end;

                on E:EIdException do
                begin
                  //MessageDlg('Transfert annulé : ' + E.Message, mtError, [mbOK], 0);
                  FSourceEnCours^.Progression := -1;
                  FAnnule := True;
                end;

                on E:Exception do
                  if FAnnule then
                  begin
                    FSourceEnCours^.Progression := -100;
                    if not FUtilisationListe then
                      CreateFTPClient(True)
                  end
              end;

            // Suivant
            if FSourceEnCours^.Progression <> -10 then
              FNoeudEnCours := GetNextSibling(FNoeudEnCours);
          end;
        until not Assigned(FNoeudEnCours);
        FEnTelechargement := False;

        if Assigned(FSurFinTelechargement) then
          FSurFinTelechargement(Self);

        // Suppression des téléchargement
        if not FUtilisationListe then
          vstListesFichiers.DeleteChildren(RootNode);
      end;
    end;
end;

procedure TfrmListeFichiers.ftpClientWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  if Assigned(FSourceEnCours) then
  begin
    if UtilisationListe then
      FSourceEnCours^.Progression := AWorkCount
    else
      FSourceEnCours^.Progression := Round(AWorkCount / FSourceEnCours^.Taille * 100);
    vstListesFichiers.RepaintNode(FNoeudEnCours);
    Application.ProcessMessages;
  end;
end;

procedure TfrmListeFichiers.ftpClientWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  if Assigned(FSourceEnCours) then FSourceEnCours^.Progression := 0;
end;

procedure TfrmListeFichiers.vstListesFichiersBeforeCellPaint(
  Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; CellRect: TRect);
var
  lpRecFichier : PRecFichier;
begin
  if not FUtilisationListe then
    case Column of
      C_COLONNE_PROGRESSION :
        begin
          lpRecFichier := vstListesFichiers.GetNodeData(Node);
          if Assigned(lpRecFichier) then
          begin
            InflateRect(CellRect, -2, -2);

            TargetCanvas.Brush.Color := clBtnFace;
            TargetCanvas.FillRect(CellRect);
            Frame3D(Canvas, CellRect, clBtnFace, clWindow, 1);

            if lpRecFichier^.SensTelechargement = stDownload then TargetCanvas.Brush.Color := clLime;
            if lpRecFichier^.SensTelechargement = stUpload then TargetCanvas.Brush.Color := clPurple;

            with CellRect do
              Right := Left + Round(((Right - Left) / 100) * lpRecFichier^.Progression);
            TargetCanvas.FillRect(CellRect);
          end;
        end;
    end;
end;

procedure TfrmListeFichiers.vstListesFichiersGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  lpRecFichier : PRecFichier;
begin
  lpRecFichier := vstListesFichiers.GetNodeData(Node);
  if Assigned(lpRecFichier) then
    with lpRecFichier^ do
      case Column of
        C_COLONNE_SOURCE : CellText := Source + Nom;
        C_COLONNE_DESTINATION : CellText := Destination + Nom;
        C_COLONNE_PROGRESSION :
          begin
            case Progression of
              -1 : CellText := 'Echec !';
              -100 : CellText := 'Annulé !';
            else
              CellText := IntToStr(Progression) +  IfThen(FUtilisationListe, ' octets', ' %');
            end;
          end;
      end;

end;

procedure TfrmListeFichiers.vstListesFichiersPaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
begin
  case Column of
    C_COLONNE_PROGRESSION :
      begin
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
        if FUtilisationListe then
          TargetCanvas.Font.Color := clWindowText
        else
          if vstListesFichiers.Selected[Node] then
            TargetCanvas.Font.Color := clWindow
          else
            TargetCanvas.Font.Color := clWindowText;
      end;
  end;
end;

procedure TfrmListeFichiers.vstListesFichiersKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  lNoeud : PVirtualNode;
begin
  if Key = VK_DELETE then
    if MessageDlg('Annuler/Supprimer ce fichier des téléchargements ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      lNoeud := vstListesFichiers.GetFirstSelected;
      if lNoeud = FNoeudEnCours then
        AnnulerTelechargement
      else
        vstListesFichiers.DeleteNode(lNoeud);
    end;
end;

procedure TfrmListeFichiers.AnnulerTelechargement;
begin
  FAnnule := True;
  FftpClient.Abort;
end;

procedure TfrmListeFichiers.FormDestroy(Sender: TObject);
begin
  if Assigned(FftpClient) then
  begin
    FftpClient.Disconnect;
    FreeAndNil(FftpClient);
  end;
end;

procedure TfrmListeFichiers.CreateFTPClient(AAutoLogin : Boolean = False);
var
  lStrServeur, lStrUtilisateur, lStrMotDePasse : string;
  lIntPort : Integer;
begin
  if AAutoLogin then
    with FftpClient do
    begin
      lStrServeur := Host;
      lIntPort := Port;
      lStrUtilisateur := Username;
      lStrMotDePasse := Password;
    end;

  FormDestroy(Self);

  FftpClient := TIdFTP.Create(Self);
  FftpClient.TransferType := ftBinary;
  FFtpClient.Passive := true;
  FftpClient.AutoLogin := True;
  FftpClient.OnWorkBegin := ftpClientWorkBegin;
  FftpClient.OnWork := ftpClientWork;

  if AAutoLogin then
    with FftpClient do
    begin
      Host := lStrServeur;
      Port := lIntPort;
      Username := lStrUtilisateur;
      Password := lStrMotDePasse;
      Connect;
    end;
end;

procedure TfrmListeFichiers.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
end;

end.
