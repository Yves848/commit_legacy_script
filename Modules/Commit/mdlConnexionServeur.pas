unit mdlConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, mdlBase, StrUtils;

type
  TfrmConnexionServeur = class(TfrmBase)
    edtServeur: TLabeledEdit;
    edtBD: TLabeledEdit;
    btnAnnuler: TButton;
    btnOK: TButton;
    bvlSeparator_1: TBevel;
    bvlSeparateur_2: TBevel;
    edtUtilisateur: TLabeledEdit;
    edtMotDePasse: TLabeledEdit;
    chkConnexionLocale: TCheckBox;
    img: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; reintroduce; virtual;
  end;
  TfrmConnexionServeurClasse = class of TfrmConnexionServeur;

implementation

{$R *.dfm}

{ TfrmConnexionServeur }

procedure TfrmConnexionServeur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // inherited;
end;

procedure TfrmConnexionServeur.FormCreate(Sender: TObject);
begin
  inherited;

  if Assigned(Module) then
  begin
    Caption := 'Connexion à ' + Module.Description;
    if Module.Logo.HandleAllocated then
      img.Picture.Assign(Module.Logo);
  end;
end;

function TfrmConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  edtServeur.Text := AParametres.Values['serveur'];
  edtBD.Text := AParametres.Values['bd'];
  edtUtilisateur.Text := AParametres.Values['utilisateur'];
  edtMotDePasse.Text := AParametres.Values['mot_de_passe'];
  chkConnexionLocale.Checked := AParametres.Values['connexion_locale'] = '1';

  result := inherited ShowModal;

  AParametres.Values['serveur'] := edtServeur.Text;
  AParametres.Values['bd'] := edtBD.Text;
  AParametres.Values['utilisateur'] := edtUtilisateur.Text;
  AParametres.Values['mot_de_passe'] := edtMotDePasse.Text;
  AParametres.Values['connexion_locale'] := IfThen(chkConnexionLocale.Checked, '1', '0');
end;

end.
