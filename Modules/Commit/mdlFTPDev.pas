unit mdlFTPDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlBase, ExtCtrls, pngimage, StdCtrls, XmlIntf;

type
  TfrmFTPDev = class(TfrmBase)
    Image1: TImage;
    rbStable: TRadioButton;
    rbDev: TRadioButton;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    pnFTPDev: TPanel;
    edtFtpHost: TLabeledEdit;
    edtFTPPort: TLabeledEdit;
    edtLogin: TLabeledEdit;
    edtPassword: TLabeledEdit;
    edtRepertoire: TLabeledEdit;
    procedure rbStableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmFTPDev: TfrmFTPDev;

implementation

{$R *.dfm}

procedure TfrmFTPDev.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmFTPDev.Button2Click(Sender: TObject);
begin
  modalREsult := mrOk;
end;

procedure TfrmFTPDev.FormShow(Sender: TObject);
begin

  if Projet.FichierProjet.DocumentElement.ChildNodes['ServeurMAJ'].HasAttribute('serveur') then
  begin
    with Projet.FichierProjet.DocumentElement.ChildNodes['ServeurMAJ'] do
    begin
      edtFtpHost.Text := Attributes['serveur'];
      edtFTPPort.Text := Attributes['port'];
      edtLogin.Text := Attributes['utilisateur'];
      edtPassword.Text := Attributes['mot_de_passe'];
      edtRepertoire.Text := Attributes['repertoire'];
    end;
  end
  else
  begin
    with Projet.FichierParametres.DocumentElement.ChildNodes['ServeursMAJ'].ChildNodes['ServeurMAJ'] do
    begin
      edtFtpHost.Text := Attributes['serveur'];
      edtFTPPort.Text := Attributes['port'];
      edtLogin.Text := Attributes['utilisateur'];
      edtPassword.Text := Attributes['mot_de_passe'];
      edtRepertoire.Text := Attributes['repertoire'];
    end;
  end;
end;

procedure TfrmFTPDev.rbStableClick(Sender: TObject);
begin
  pnFTPDev.Visible := rbDev.Checked;

end;

end.
