unit mdlVignettesAvancees_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, Menus,
  JvMenus, mdlFrameVisualisation_fr;

type
  TfrVignettesAvancees = class(TfrFrameVisualisation)
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;  
  end;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

{ TfrViewDataVignAvanc }

procedure TfrVignettesAvancees.btnChercherClick(
  Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;

  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_fr.dSetVignettesAvancees.Active then dmVisualisationPHA_fr.dSetVignettesAvancees.Close;

  // Sépération des paramètres
  lStrNom := edtCritere.Text;
  lIntPos := Pos('+', lStrNom);
  if lIntPos > 0 then
  begin
    lStrPrn := Copy(lStrNom, lIntPos + 1, Length(lStrNom));
    lStrNom := Copy(lStrNom, 1, lIntPos - 1);
  end
  else
    lStrPrn := '';

  with dmVisualisationPHA_fr.dSetVignettesAvancees do
  begin
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

constructor TfrVignettesAvancees.Create(Aowner: TComponent;
  AProjet: TProjet);
begin
  inherited;

  Caption := 'Vignettes avancées';

  FClientHeight := 370;
  FClientWidth := 769;
end;

end.
