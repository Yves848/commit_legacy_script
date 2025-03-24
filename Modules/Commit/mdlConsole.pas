unit mdlConsole;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, JvMenus, JvComponentBase;

type

  tConsoleToDB = procedure(sMessage : String;const bVisual:Boolean=true) of Object;

  TfrmConsole = class(TForm)
    mmConsole: TMemo;
    pmnuConsole: TJvPopupMenu;
    mnuSauvegarder: TMenuItem;
    mnuImprimer: TMenuItem;
    mnuSeparateur_1: TMenuItem;
    mnuVider: TMenuItem;
    sd: TSaveDialog;
    procedure mnuViderClick(Sender: TObject);
    procedure mnuSauvegarderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
    FTexteInit : string;
  public
    { Déclarations publiques }
  end;

  TConsole = class
  private
    FfrmConsole : TfrmConsole;
  public
    Console2DB : tConsoleToDB;
    property frmConsole : TfrmConsole read FfrmConsole;
    constructor Create;
    destructor Destroy; override;
    procedure Effacer;
    procedure Sauver(ANomFichier : string);
    procedure InitConsole(ACouleur : TColor; ATexte : string);
    procedure Ajouter(ATexte : string);
    procedure AjouterLigne(ATexte : string);
  end;

const
  CM_CONSOLE_FERMEE = WM_USER + $0;

implementation

{$R *.dfm}

{ TfrmConsole }

procedure TfrmConsole.mnuViderClick(Sender: TObject);
begin
  mmConsole.Clear;
  mmConsole.Lines.Add(FTexteInit);
end;

procedure TfrmConsole.mnuSauvegarderClick(Sender: TObject);
begin
  if sd.Execute then
    mmConsole.Lines.SaveToFile(sd.FileName);
end;

{ TConsole }

procedure TConsole.Ajouter(ATexte: string);
begin
  with FfrmConsole.mmConsole do
    Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + ATexte;

  Console2DB(ATexte);
end;

procedure TConsole.AjouterLigne(ATexte: string);
begin
  Ajouter(#13#10 + datetimetostr(now)+' '+ATexte);
end;

constructor TConsole.Create;
begin
  FfrmConsole := TfrmConsole.Create(Application.MainForm);
  FfrmConsole.Parent := Application.MainForm;
end;

destructor TConsole.Destroy;
begin
  if Assigned(FfrmConsole) then
    FreeAndNil(FfrmConsole);

  inherited;
end;

procedure TConsole.Effacer;
begin
  FfrmConsole.mmConsole.Lines.Clear;
end;

procedure TConsole.InitConsole(ACouleur: TColor; ATexte: string);
begin
  frmConsole.Color := ACouleur;
  frmConsole.mmConsole.Lines.Text := ATexte;

  frmConsole.FTexteInit := ATexte;
end;

procedure TConsole.Sauver(ANomFichier: string);
begin
  FfrmConsole.mmConsole.Lines.SaveToFile(ANomFichier);
end;

procedure TfrmConsole.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PostMessage(Application.MainForm.Handle, CM_CONSOLE_FERMEE, 0, 0)
end;

end.
