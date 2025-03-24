unit mdlBDEConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, Mask, JvExMask, JvToolEdit;

type
  TfrmBDEConnexionServeur = class(TfrmConnexionServeur)
    edtCheminBD: TJvDirectoryEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; override;
  end;

var
  frmBDEConnexionServeur: TfrmBDEConnexionServeur;

implementation

{$R *.dfm}
function TfrmBDEConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  edtCheminBD.Text := AParametres.Values['bd'];
  result := inherited ShowModal(AParametres);
  AParametres.Values['bd'] := edtCheminBD.Text;
  end;

end.