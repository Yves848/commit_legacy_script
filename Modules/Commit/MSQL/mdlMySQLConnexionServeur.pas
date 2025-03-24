unit mdlMySQLConnexionServeur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlConnexionServeur, StdCtrls, ExtCtrls, jpeg, Mask, JvExMask,
  JvToolEdit;

type
  TfrmMySQLConnexionServeur = class(TfrmConnexionServeur)
    lblOptions: TLabel;
    mmOptions: TMemo;
    lblDumpSQL: TLabel;
    edtDumpSQL: TJvFilenameEdit;
    Bevel2: TBevel;
    procedure chkConnexionLocaleClick(Sender : TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(AParametres : TStringList) : Integer; override;
  end;

var
  frmMySQLConnexionServeur: TfrmMySQLConnexionServeur;

implementation

{$R *.dfm}

procedure TfrmMySQLConnexionServeur.chkConnexionLocaleClick(Sender: TObject);
begin
  inherited;

  edtServeur.Enabled := not chkConnexionLocale.Checked;
  edtUtilisateur.Enabled := not chkConnexionLocale.Checked;
  edtMotDePasse.Enabled := not chkConnexionLocale.Checked;
  lblOptions.Enabled := chkConnexionLocale.Checked;
  mmOptions.Enabled := chkConnexionLocale.Checked;
  lblDumpSQL.Enabled := chkConnexionLocale.Checked;
  edtDumpSQL.Enabled := chkConnexionLocale.Checked;
end;

function TfrmMySQLConnexionServeur.ShowModal(
  AParametres: TStringList): Integer;
begin
  mmOptions.Lines.Text := AParametres.Values['options'];
  edtDumpSQL.Text := AParametres.Values['dump_sql'];
  Result := inherited ShowModal(AParametres);
  AParametres.Values['options'] := mmOptions.Lines.Text;
  AParametres.Values['dump_sql'] := edtDumpSQL.Text;
end;

end.
