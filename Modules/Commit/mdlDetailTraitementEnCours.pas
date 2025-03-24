unit mdlDetailTraitementEnCours;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, mdlModule, StdCtrls, ExtCtrls;

type
  TfrmDetailTraitementEnCours = class(TForm)
    lblSucces: TLabel;
    lblRejets: TLabel;
    lblErreurs: TLabel;
    txtSucces: TStaticText;
    txtRejets: TStaticText;
    txtErreurs: TStaticText;
    tmTraitement: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmTraitementTimer(Sender: TObject);
  private
    { Déclarations privées }
    FTraitement : TTraitement;
    procedure RafraichirResultats;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent; ATraitement : TTraitement); reintroduce;
  end;

var
  frmDetailTraitementEnCours: TfrmDetailTraitementEnCours;

implementation

{$R *.dfm}

constructor TfrmDetailTraitementEnCours.Create(AOwner: TComponent;
  ATraitement: TTraitement);
var
  lPoint : TPoint;
begin
  inherited Create(AOwner);

  // Information
  FTraitement := ATraitement;
  Caption := FTraitement.AffichageResultat.Libelle;
  RafraichirResultats;

  // Position
  GetCursorPos(lPoint);
  SetBounds(lPoint.X - Width, lPoint.Y - Height, Width, Height);
end;

procedure TfrmDetailTraitementEnCours.FormClose(Sender: TObject; var Action:
    TCloseAction);
begin
  tmTraitement.Enabled := False;
  Action := caFree;

  frmDetailTraitementEnCours := nil;
end;

procedure TfrmDetailTraitementEnCours.RafraichirResultats;
begin
  with FTraitement do
  begin
    txtSucces.Caption := IntToStr(Succes);
    txtRejets.Caption := IntToStr(Rejets);
    txtErreurs.Caption := IntToStr(Erreurs);
  end;
end;

procedure TfrmDetailTraitementEnCours.tmTraitementTimer(Sender: TObject);
begin
  RafraichirResultats;
end;

end.
