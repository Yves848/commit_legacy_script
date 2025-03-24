unit mdlAttenteConnexion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TfrmAttenteConnexion = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
    FDansProc : Boolean;
  public
    { Déclarations publiques }
    procedure Show(AMessage : string; AProc : TProc); reintroduce;
  end;

var
  frmAttenteConnexion: TfrmAttenteConnexion;

implementation

{$R *.dfm}

{ TfrmAttenteConnexion }

procedure TfrmAttenteConnexion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  ClipCursor(nil);
end;

procedure TfrmAttenteConnexion.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not FDansProc;
end;

procedure TfrmAttenteConnexion.FormCreate(Sender: TObject);
begin
  FDansProc  := False;
end;

procedure TfrmAttenteConnexion.FormShow(Sender: TObject);
var
  r : TRect;
begin
  r := BoundsRect;
  SetCursorPos(r.Left + Width div 2, r.Top + Height div 2);
  ClipCursor(@r);
end;

procedure TfrmAttenteConnexion.Show(AMessage: string; AProc: TProc);
begin
  inherited Show;
  Panel2.Caption := AMessage;
  Update;

  FDansProc  := True;
  try
    AProc;
  finally
    FDansProc  := False;
    Close;
  end;
end;

end.
