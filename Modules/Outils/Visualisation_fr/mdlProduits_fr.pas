unit mdlProduits_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPiSpeedButton, ExtCtrls, mdlPIStringGrid, ComCtrls,
  DBCtrls, Mask, ImgList, StrUtils, mdlProjet,
  JvMenus, mdlPHA, mdlFrameVisualisation_fr, mdlStock_fr;

type
  TfrProduits = class(TfrFrameVisualisation)
    lblDesignation: TLabel;
    lblCodeCIPHomeo: TLabel;
    pCtrlDetailProduits: TPageControl;
    tShGestion: TTabSheet;
    tShDivers: TTabSheet;
    tShCommentaires: TTabSheet;
    tShStock: TTabSheet;
    lblTVA: TLabel;
    lblListe: TLabel;
    lblPrestation: TLabel;
    lblPrixVente: TLabel;
    lblPrixAchat: TLabel;
    lblPAMP: TLabel;
    lblBaseRbt: TLabel;
    dbGrdTarifs: TPIDBGrid;
    lblContenance: TLabel;
    lblDelaiLait: TLabel;
    lblDelaiViande: TLabel;
    lblCommVente: TLabel;
    lblCommCommande: TLabel;
    lblCommGestion: TLabel;
    lblProfilGS: TLabel;
    lblNbMoisCalcul: TLabel;
    lblCalcul: TLabel;
    txtDesignation: TDBEdit;
    txtCodeCIP: TDBEdit;
    txtTauxTVA: TDBEdit;
    txtPrestation: TDBEdit;
    txtBaseRbt: TDBEdit;
    txtPVTTC: TDBEdit;
    txtPAHT: TDBEdit;
    txtPAMP: TDBEdit;
    txtContenance: TDBEdit;
    txtDelaiLait: TDBEdit;
    txtDelaiViande: TDBEdit;
    mmCommVente: TDBMemo;
    mmCommCommande: TDBMemo;
    mmCommGestion: TDBMemo;
    txtUniteMesure: TDBEdit;
    txtTypeHomeo: TDBEdit;
    txtListe: TDBEdit;
    chkSoumisMDL: TDBCheckBox;
    chkPxAchTarif: TDBCheckBox;
    chkVeterinaire: TDBCheckBox;
    chkGereInteressement: TDBCheckBox;
    chkTracabilite: TDBCheckBox;
    chkGereSuiviClient: TDBCheckBox;
    chkGerePFC: TDBCheckBox;
    txtProfilGSLibelle: TDBText;
    mnuProfilProduit: TMenuItem;
    mnuHistoAchat: TMenuItem;
    mnuHistoClient: TMenuItem;
    lblTypeHomeo: TLabel;
    lblEtat: TLabel;
    txtEtat: TDBEdit;
    dbGrdCodeEAN13: TPIDBGrid;
    lblCodificationsLibre: TLabel;
    lblCodif1: TDBText;
    lblCodif2: TDBText;
    lblCodif4: TDBText;
    lblCodif3: TDBText;
    lblCodif5: TDBText;
    lblCodif7: TLabel;
    edtCodif1: TDBEdit;
    edtCodif2: TDBEdit;
    edtCodif3: TDBEdit;
    edtCodif4: TDBEdit;
    edtCodif5: TDBEdit;
    edtCodif7: TDBEdit;
    chkKit: TDBCheckBox;
    dbGrdCodeLPP: TPIDBGrid;
    mnuPromotions: TMenuItem;
    dsProduitsLPP: TDataSource;
    dsCodesEAN13: TDataSource;
    dsLibellesCodifications: TDataSource;
    frStock: TfrStock;
    edtProfilGS: TDBEdit;
    edtCalculGS: TDBEdit;
    pnlFournisseurs: TPanel;
    lblRepartiteurAttitre: TLabel;
    lblMarque: TLabel;
    edtRepartiteurAttitre: TDBEdit;
    edtMarque: TDBEdit;
    edtNbMoisCalcul: TDBEdit;
    txtDateDernVte: TDBEdit;
    lblDateDernVte: TLabel;
    DBNavigator1: TDBNavigator;
    pnlInfoprix: TPanel;
    Label2: TLabel;
    pnlInfoFou: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    txtCodeCIP7: TDBEdit;
    procedure btnChercherClick(Sender: TObject);
    procedure mnuProfilProduitClick(Sender: TObject);
    procedure mnuHistoAchatClick(Sender: TObject);
    procedure mnuPromotionsClick(Sender: TObject);
    procedure pCtrlDetailProduitsDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
  private
    { Déclarations privées }
    FSQLCommandesEnCours : string;
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
    destructor Destroy; override;
    procedure Show; override;
    procedure Hide; override;
  end;

const
  C_PAGE_GESTION = 0;
  C_PAGE_DIVERS = 1;
  C_PAGE_COMMENTAIRE = 2;
  C_PAGE_STOCK = 3;

var
  frProduits: TfrProduits;

implementation

uses mdlProfilProduit_fr,
  mdlDetails_fr, mdlHistoAchats_fr,
  mdlPromotions_fr, mdlVisualisationPHA_fr;

{$R *.dfm}

destructor TfrProduits.Destroy;
begin
  if dmVisualisationPHA_fr.dSetLibellesCodifications.Active then
    dmVisualisationPHA_fr.dSetLibellesCodifications.Close;

  inherited;
end;

constructor TfrProduits.Create(Aowner: TComponent;
  AProjet : TProjet);
begin
  inherited;

  dbGrdCodeEAN13.OnDrawColumnCell := self.grilleLGPIsimple ;
  dbGrdCodeLPP.OnDrawColumnCell := self.grilleLGPIsimple ;
  dbGrdTarifs.OnDrawColumnCell := self.grilleLGPIsimple ;
  frStock.dbGrdStock.OnDrawColumnCell := self.grilleLGPIsimple ;

  // Détails par défaut
  pCtrlDetailProduits.ActivePageIndex := C_PAGE_GESTION;

  with dmVisualisationPHA_fr.dSetLibellesCodifications do
  begin
    if Active then Close;
    Open;
  end;

  Caption := 'Visualisation produits';
end;

procedure TfrProduits.btnChercherClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_fr.dSetProduits.Active then dmVisualisationPHA_fr.dSetProduits.Close;

  // Modification requete
  with dmVisualisationPHA_fr.dSetProduits do
  begin
    Params.ByNameAsString['ACODECIP'] := Copy(edtCritere.Text, 1, 13);
    Params.ByNameAsString['ADESIGNATION'] := Copy(edtCritere.Text, 1, 50);
    Params.ByNameAsString['ACODECIP7'] := Copy(edtCritere.Text, 1, 7);
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TfrProduits.mnuProfilProduitClick(Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr do
  begin
    if dSetHistoriqueVentes.Active then
      dSetHistoriqueVentes.Close;
    dSetHistoriqueVentes.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    dSetHistoriqueVentes.Open;

    if dSetHistoriqueAchats.Active then
      dSetHistoriqueAchats.Close;
    dSetHistoriqueAchats.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    dSetHistoriqueAchats.Open;

    if dSetCommandesEnCours.Active then
      dSetCommandesEnCours.Close;
    dSetCommandesEnCours.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    dSetCommandesEnCours.Open;
  end;
  TfrmDetails.Create(Self, Projet, TfrProfilProduit).ShowModal;
end;

procedure TfrProduits.mnuHistoAchatClick(Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr do
  begin
    if dSetHistoAchats1.Active then
      dSetHistoAchats1.Close;
    dSetHistoAchats1.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    dSetHistoAchats1.Open;

    if dSetHistoAchats2.Active then
      dSetHistoAchats2.Close;
    dSetHistoAchats2.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    dSetHistoAchats2.Open;

    if dSetListeAchats.Active then
      dSetListeAchats.Close;
    dSetListeAchats.Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    dSetListeAchats.Open;
  end;
  TfrmDetails.Create(Self, Projet, TfrHistoAchat).ShowModal;
end;

procedure TfrProduits.mnuPromotionsClick(Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr, dSetPromotions do
  begin
    if Active then
      Close;
    Params.ByNameAsString['APRODUITID'] := dSetProduitsT_PRODUIT_ID.AsString;
    Open;
  end;
  TfrmDetails.Create(Self, Projet, TfrPromotions).ShowModal;
end;

procedure TfrProduits.pCtrlDetailProduitsDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  i, h, L , realindex : Integer;
begin
  RealIndex:=TabIndex;
  for i:=0 to (Control as TPageControl).PageCount-1 do
  begin
    if ( (RealIndex>=i) and ((Control as TPageControl).Pages[i].TabVisible=FALSE) ) then
      RealIndex:=RealIndex+1;
  end;

  if Active then
  begin
    Control.Canvas.Brush.Color := CL_ORANGE;
    Control.Canvas.Font.Color := clwhite;
  end
  else
  begin
    Control.Canvas.Brush.Color := $CBCBCB;
    Control.Canvas.Font.Color := clBLack;
  end;

  Control.Canvas.Pen.Style := psClear;
  Control.Canvas.Rectangle(Rect);
  h := Control.Canvas.TextHeight((Control as TPageControl).Pages[RealIndex].Caption);
  L := Rect.Left;
  if Active then Inc(L, 4);
  Control.Canvas.TextOut(L, Rect.Top + (Rect.Bottom - Rect.Top - h) div 2, (Control as TPageControl).Pages[RealIndex].Caption);
end;

procedure TfrProduits.Show;
begin
  inherited;

  with dmVisualisationPHA_fr do
  begin
    FSQLCommandesEnCours := dSetCommandesEnCours.SQL.Text; AjouterWhere(dSetCommandesEnCours.SQL, 't_produit_id = :APRODUITID');
  end;
end;

procedure TfrProduits.Hide;
begin
  inherited;

  with dmVisualisationPHA_fr do
  begin
    dSetCommandesEnCours.SQL.Text := FSQLCommandesEnCours;
  end;
end;

end.
