unit mdlHyperFileConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, Mask, JvExMask, JvToolEdit;

type
  TfrmHyperFileConnexionServeur = class(TfrmConnexionServeur)
    edtAnalyse: TJvFilenameEdit;
    lblAnalyse: TLabel;
    edtCheminBD: TJvDirectoryEdit;
    procedure chkConnexionLocaleClick(Sender: TObject);
    procedure edtAnalyseChange(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; override;
  end;

var
  frmHyperFileConnexionServeur: TfrmHyperFileConnexionServeur;

implementation

{$R *.dfm}

procedure TfrmHyperFileConnexionServeur.chkConnexionLocaleClick(
  Sender: TObject);
begin
 { if not chkConnexionLocale.Checked then
  begin
    edtServeur.Enabled := True;
    edtBD.EditLabel.Caption := 'Base de données';
    edtCheminBD.ShowButton := False;

    edtUtilisateur.Enabled := True;
    edtMotDePasse.Enabled := True;
  end
  else
  begin   }
    edtServeur.Enabled := False;
    edtBD.EditLabel.Caption := 'Répertoire des données';
    edtCheminBD.ShowButton := True;

    edtUtilisateur.Enabled := true;      //avant c etait false
    edtMotDePasse.Enabled := true;  //avant c etait false
  //end;
end;

procedure TfrmHyperFileConnexionServeur.edtAnalyseChange(Sender: TObject);
begin
  inherited;

  //if chkConnexionLocale.Checked then
  //  edtCheminBD.Text := ExtractFilePath(edtAnalyse.Text);
end;

function TfrmHyperFileConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  edtCheminBD.Text := AParametres.Values['bd'];
 // edtAnalyse.Text := AParametres.Values['analyse'];
//  edtServeur.Text := AParametres.Values['serveur'];
 // edtUtilisateur.Text := AParametres.Values['utilisateur'];
 // edtMotDePasse.Text := AParametres.Values['mot_de_passe'];
  //chkConnexionLocale.Checked := AParametres.Values['connexion_locale'] = '1';
  result := inherited ShowModal(AParametres);
  AParametres.Values['bd'] := edtCheminBD.Text;
 //AParametres.Values['analyse'] := edtAnalyse.Text;
//  AParametres.Values['serveur'] := edtServeur.Text;
 // AParametres.Values['utilisateur'] := edtUtilisateur.Text;
 // AParametres.Values['mot_de_passe'] := edtMotDePasse.Text;
//  AParametres.Values['connexion_locale'] := '1';//IntToStr(Ord(chkConnexionLocale.Checked));
end;

end.
