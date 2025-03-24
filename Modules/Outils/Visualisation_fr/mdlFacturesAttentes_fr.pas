unit mdlFacturesAttentes_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, mdlPIPanel, JvMenus,
  mdlPIStringGrid, mdlPIDBStringGrid, mdlFrameVisualisation_fr;

type
  TfrFacturesAttentes = class(TfrFrameVisualisation)
    PIDBStringGrid1: TPIDBStringGrid;
    procedure sBtnSearchClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

var
  frFacturesAttentes: TfrFacturesAttentes;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

{ TfrFacturesAttentes }

constructor TfrFacturesAttentes.Create(Aowner : TComponent; AProjet : TProjet);
begin
  inherited;

  Caption := 'Factures en attente';

  FClientHeight := 372;
  FClientWidth := 655;
end;

procedure TfrFacturesAttentes.sBtnSearchClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;

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

  with dmVisualisationPHA_fr.dSetFacturesAttentes do
  begin
    if Active then
      Close;
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;
end;

end.
