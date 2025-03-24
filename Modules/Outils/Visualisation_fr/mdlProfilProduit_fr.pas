unit mdlProfilProduit_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPISpeedButton, ExtCtrls, Mask, DBCtrls, mdlPIStringGrid,
  DbChart, TeEngine, Series, TeeProcs, Chart, dbcgrids,
  mdlProjet, JvMenus, mdlFrameVisualisation_fr,
  mdlStock_fr;

type
  TfrProfilProduit = class(TfrFrameVisualisation)
    lblDesignation: TLabel;
    edtDesignation: TDBEdit;
    lblCodeCIP: TLabel;
    edtCodeCIP: TDBEdit;
    lblDernVente: TLabel;
    edtDernVente: TDBEdit;
    lblCalculGS: TLabel;
    edtCalculGS: TDBEdit;
    lblCmdEnCours: TLabel;
    dbGrdCmdEnCours: TPIDBGrid;
    dsCommandesEnCours: TDataSource;
    dsHistoriqueVentes: TDataSource;
    sBxHistVteAch: TScrollBox;
    dbChHistoVente: TDBChart;
    Bevel1: TBevel;
    dsHistoriqueAchats: TDataSource;
    lblHistoVente: TLabel;
    lblHistoAchat: TLabel;
    DBCtrlGrid1: TDBCtrlGrid;
    DBCtrlGrid2: TDBCtrlGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Panel1: TPanel;
    frStock: TfrStock;
    dsProduits: TDataSource;
    Series2: TBarSeries;
    Series1: TBarSeries;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
    destructor Destroy; override;
  end;

var
  frProfilProduit: TfrProfilProduit;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

destructor TfrProfilProduit.Destroy;
begin
  // Fermture données
  if dmVisualisationPHA_fr.dSetCommandesEnCours.Active then dmVisualisationPHA_fr.dSetCommandesEnCours.Close;
  if dmVisualisationPHA_fr.dSetHistoriqueAchats.Active then dmVisualisationPHA_fr.dSetHistoriqueAchats.Close;
  if dmVisualisationPHA_fr.dSetHistoriqueVentes.Active then dmVisualisationPHA_fr.dSetHistoriqueVentes.Close;

  inherited;
end;

constructor TfrProfilProduit.Create(Aowner: TComponent;
  AProjet : TProjet);
begin
  inherited;

  dbGrdCmdEnCours.OnDrawColumnCell := self.grilleLGPIsimple ;
  frStock.dbGrdStock.OnDrawColumnCell := self.grilleLGPIsimple ;
  // Titre fenetre
  Caption := 'Profil produit';

  // Taille par défaut
  FClientHeight := 592;
  FClientWidth := 657;
end;

end.
