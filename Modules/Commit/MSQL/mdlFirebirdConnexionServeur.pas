unit mdlFirebirdConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, Mask, JvExMask, JvToolEdit;

type
  TfrmFirebirdConnexionServeur = class(TfrmConnexionServeur)
    edtCheminBD: TJvFilenameEdit;
    procedure chkConnexionLocaleClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; override;
  end;

var
  frmFirebirdConnexionServeur: TfrmFirebirdConnexionServeur;

implementation

{$R *.dfm}

procedure TfrmFirebirdConnexionServeur.chkConnexionLocaleClick(
  Sender: TObject);
begin
  edtServeur.Enabled := not chkConnexionLocale.Checked;
end;

function TfrmFirebirdConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  edtCheminBD.Text := AParametres.Values['bd'];
  result := inherited ShowModal(AParametres);
  AParametres.Values['bd'] := edtCheminBD.Text;
end;

end.
