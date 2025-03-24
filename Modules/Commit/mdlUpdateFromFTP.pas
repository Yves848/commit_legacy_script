unit mdlUpdateFromFTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, StrUtils;

type
  TfrmUpdateFromFTP = class(TForm)
    gBxInfoConnect: TGroupBox;
    lblServer: TLabel;
    edtServer: TEdit;
    btnOK: TButton;
    btnAnnuler: TButton;
    bvlSeparator_1: TBevel;
    chkPassword: TCheckBox;
    lblUtilisateur: TLabel;
    lblMotdepasse: TLabel;
    edtUtilisateur: TEdit;
    edtMotdePasse: TEdit;
    procedure chkPasswordClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    function ShowModal(var AServer : string; var AUserName : string; var APassword : string) : Integer; reintroduce;
  end;

var
  frmUpdateFromFTP: TfrmUpdateFromFTP;

implementation

{$R *.dfm}

function TfrmUpdateFromFTP.ShowModal(var AServer : string; var AUserName : string; var APassword : string): Integer;
begin
  Result := inherited ShowModal;

  if Result = mrOk then
  begin
    AServer :=edtServer.Text;

    if chkPassword.Checked then
    begin
      AUserName := edtUtilisateur.Text;
      APassword := edtMotdePasse.Text;
    end
    else
    begin
      AUserName := 'upd_ftp';
      APassword := 'upd_ftp';
    end;
  end;
end;

procedure TfrmUpdateFromFTP.chkPasswordClick(Sender: TObject);
begin
  if chkPassword.Checked then
  begin
    edtUtilisateur.Enabled := True; edtUtilisateur.Color := clWindow;
    edtMotdePasse.Enabled := True; edtMotdePasse.Color := clWindow;
  end
  else
  begin
    edtUtilisateur.Enabled := False; edtUtilisateur.Color := clInactiveCaption; edtUtilisateur.Text := '';
    edtMotdePasse.Enabled := False; edtMotdePasse.Color := clInactiveCaption; edtMotdePasse.Text := '';
  end;
end;

end.
