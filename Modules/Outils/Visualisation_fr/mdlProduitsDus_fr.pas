unit mdlProduitsDus_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls, mdlProjet,
  Buttons, mdlPISpeedButton, ExtCtrls, JvMenus,
  mdlFrameVisualisation_fr;

type
  TfrProduitsDus = class(TfrFrameVisualisation)
    procedure sBtnSearchClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

var
  frProduitsDus: TfrProduitsDus;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

{ TfrProduitsDus }

constructor TfrProduitsDus.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited;

  Caption := 'Produits dus';

  FClientHeight := 370;
  FClientWidth := 769;
end;

procedure TfrProduitsDus.sBtnSearchClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;

  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_fr.dSetProduitsDus.Active then dmVisualisationPHA_fr.dSetProduitsDus.Close;

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

  with dmVisualisationPHA_fr.dSetProduitsDus do
  begin
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

end.
