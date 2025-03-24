unit mdlHistoDelivrances_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPISpeedButton, ExtCtrls,
  Menus, mdlProjet, JvMenus, mdlFrameVisualisation_fr;

type
  TfrHistoDelivrances = class(TfrFrameVisualisation)
    edtProduit: TEdit;
    procedure btnChercherClick(Sender: TObject);
    procedure edtProduitEnter(Sender: TObject);
    procedure edtProduitExit(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; TProjet : TProjet); override;
  end;

var
  frHistoDelivrances: TfrHistoDelivrances;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

{ TfrViewFrameHistoClients }

procedure TfrHistoDelivrances.btnChercherClick(
  Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;

  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_fr.dSetHistoriqueClient.Active then dmVisualisationPHA_fr.dSetHistoriqueClient.Close;

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

  with dmVisualisationPHA_fr.dSetHistoriqueClient do
  begin
    Params.ByNameAsString['ACODECIP'] := edtProduit.Text;
    Params.ByNameAsString['ANOMCLIENT'] := lStrNom;
    Params.ByNameAsString['APRENOMCLIENT'] := lStrPrn;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

constructor TfrHistoDelivrances.Create(Aowner: TComponent;
  TProjet: TProjet);
begin
  inherited;

  Caption := 'Historique délivrance';

  FClientHeight := 600;
  FClientWidth := 800;
end;

procedure TfrHistoDelivrances.edtProduitEnter(Sender: TObject);
begin
  inherited;
   edtProduit.Color := CL_JAUNE_SELECTION;
end;

procedure TfrHistoDelivrances.edtProduitExit(Sender: TObject);
begin
  inherited;
  edtProduit.Color := CL_GRIS_CLAIR;
end;

end.
