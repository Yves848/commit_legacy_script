unit mdlPromotions_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, ExtCtrls, Menus, DB,
  Grids, DBGrids, mdlPIDBGrid, Buttons, mdlPISpeedButton, mdlProjet,
  JvMenus, mdlPIPanel, mdlFrameVisualisation_fr;

type
  TfrPromotions = class(TfrFrameVisualisation)
    lblLibelle: TLabel;
    lblDebutValidite: TLabel;
    lblFinValidite: TLabel;
    edtLibelle: TDBEdit;
    edtDebutValidite: TDBEdit;
    edtFinValidite: TDBEdit;
    dsPanierPromotion: TDataSource;
    dsAvantage: TDataSource;
    pnlDates: TPIPanel;
    lblMAJ: TLabel;
    edtMAJ: TDBEdit;
    Label2: TLabel;
    edtDateCreation: TDBEdit;
    gbxProduitsPromotion: TGroupBox;
    Label1: TLabel;
    edtTypePromo: TDBEdit;
    grdPanierPromo: TPIDBGrid;
    grdAvantagePromotion: TGroupBox;
    grdAvantagePromo: TPIDBGrid;
    procedure btnChercherClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
  end;

var
  frPromotions: TfrPromotions;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

{ TfrViewDataPromotion }

constructor TfrPromotions.Create(Aowner: TComponent;
  AProjet : TProjet);
begin
  inherited;

  Caption := 'Promotions';

  // Taille par défaut
  FClientHeight := 315;
  FClientWidth := 680;
end;

procedure TfrPromotions.btnChercherClick(Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr.dSetPromotions do
  begin
    Params.ByNameAsString['ALIBELLE'] := edtCritere.Text;
    Open;
  end;
end;

end.
