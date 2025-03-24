unit mdlSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, JclStrings, JclPeImage;

type
  TfrmSplash = class(TForm)
    pnl: TPanel;
    imgApp: TImage;
    lblNomApplication: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses mdlInformationFichier;

procedure TfrmSplash.FormCreate(Sender: TObject);
var
  p: Integer;
  info: TJclPeImage;
begin
  info := TJclPeImage.Create;
  info.FileName := ParamStr(0);
  with info do
  begin
    p := StrILastPos('.', VersionInfo.FileVersion);
    lblNomApplication.Caption := Description + ' (' + Copy
      (VersionInfo.FileVersion, 1, p - 1) + ')';
    Free;
  end;
end;



end.
