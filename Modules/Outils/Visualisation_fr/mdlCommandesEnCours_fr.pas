unit mdlCommandesEnCours_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPISpeedButton, ExtCtrls,mdlProjet, JvMenus, mdlPIStringGrid,
  mdlPIDBStringGrid, mdlPHA, mdlFrameVisualisation_fr;

type
  TfrCommandesEnCours = class(TfrFrameVisualisation)
    PIDBStringGrid1: TPIDBStringGrid;
    procedure sBtnSearchClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner: TComponent; AProjet : TProjet); override;
  end;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

constructor TfrCommandesEnCours.Create(Aowner: TComponent;
  AProjet : TProjet);
begin
  inherited;


  Caption := 'Visualisation commandes en attente';

  FClientHeight := 370;
  FClientWidth := 769;
end;

procedure TfrCommandesEnCours.sBtnSearchClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crSQLWait;
  with dmVisualisationPHA_fr.dSetCommandesEnCours do
  begin
    if Active then
      Close;
    Params.ByNameAsString['ARAISONSOCIALE'] := edtCritere.Text;
    Open;
  end;
  Screen.Cursor := crDefault;
end;

end.
