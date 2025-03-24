unit mdlBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlProjet;

type
  TfrmBase = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FProjet: TProjet;
    FModule: TModule;
    { Déclarations privées }
  protected
    property Projet : TProjet read FProjet;
    property Module : TModule read FModule;
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); reintroduce; overload; virtual;
    constructor Create(Aowner : TComponent; AModule : TModule); reintroduce; overload; virtual;
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

{ TfrmBase }

constructor TfrmBase.Create(Aowner: TComponent; AModule : TModule);
begin
  inherited Create(AOwner);

  FModule := AModule;
  if Assigned(FModule) then
    FProjet := FModule.Projet;
end;

constructor TfrmBase.Create(Aowner: TComponent; AProjet: TProjet);
begin
  inherited Create(AOwner);

  FProjet := AProjet;
end;

procedure TfrmBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) or
     ((Key = VK_F4) and (ssAlt in Shift)) then
    ModalResult := mrCancel;
end;

end.
