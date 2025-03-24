unit mdlSQLServeurConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, jpeg;

type
  TfrmSQLServeurConnexionServeur = class(TfrmConnexionServeur)
    chkAuthWindows: TCheckBox;
    procedure chkAuthWindowsClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres: TStringList): Integer; override;
  end;

var
  frmSQLServeurConnexionServeur: TfrmSQLServeurConnexionServeur;

implementation

{$R *.dfm}

procedure TfrmSQLServeurConnexionServeur.chkAuthWindowsClick(Sender: TObject);
begin
  inherited;

  edtUtilisateur.Enabled := not chkAuthWindows.Checked;
  edtMotDePasse.Enabled := not chkAuthWindows.Checked;
end;

function TfrmSQLServeurConnexionServeur.ShowModal(AParametres: TStringList): Integer;
begin
  chkAuthWindows.Checked := AParametres.Values['authentification_windows'] = '1';
  result := inherited ShowModal(AParametres);
  AParametres.Values['authentification_windows'] := IntToStr(Ord(chkAuthWindows.Checked));
end;

end.
