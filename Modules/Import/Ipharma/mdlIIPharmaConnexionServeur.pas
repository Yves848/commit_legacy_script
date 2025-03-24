unit mdlIIPharmaConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlFirebirdConnexionServeur, Mask, JvExMask, JvToolEdit, StdCtrls,
  ExtCtrls;

type
  TfrmIIPharmaConnexionServeur = class(TfrmFirebirdConnexionServeur)
    edtCheminBDTarif: TJvFilenameEdit;
    lblCheminBDTarif: TLabel;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; override;

  end;

var
  frmIIPharmaConnexionServeur: TfrmIIPharmaConnexionServeur;

implementation

{$R *.dfm}
function TfrmIIPharmaConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  edtCheminBD.Text := AParametres.Values['bd'];
  edtCheminBDTarif.Text := AParametres.Values['bd_tarif'];
  result := inherited ShowModal(AParametres);
  AParametres.Values['bd'] := edtCheminBD.Text;
  AParametres.Values['bd_tarif'] := edtCheminBDTarif.Text;
end;
end.
