unit mdlModuleTransfertConnexion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlOracleConnexionServeur, StdCtrls, ExtCtrls;

type
  TfrmModuleTrasfertConnexion = class(TfrmOracleConnexionServeur)
    edtCIPPharmacie: TLabeledEdit;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres: TStringList): Integer; override;
  end;

var
  frmModuleTrasfertConnexion: TfrmModuleTrasfertConnexion;

implementation

{$R *.dfm}

{ TfrmModuleTrasfertConnexion }

function TfrmModuleTrasfertConnexion.ShowModal(
  AParametres: TStringList): Integer;
begin
  edtCIPPharmacie.Text := AParametres.Values['cip'];
  Result := inherited ShowModal(AParametres);
  AParametres.Values['cip'] := edtCIPPharmacie.Text;
end;

end.
