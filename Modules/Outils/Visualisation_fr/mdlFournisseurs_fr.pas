unit mdlFournisseurs_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, Menus, DB, Grids, DBGrids, mdlProjet,
  mdlPIDBGrid, StdCtrls, Buttons, mdlPISpeedButton, ExtCtrls, DBCtrls,
  Mask, JvExStdCtrls, JvGroupBox,
  JvMenus, mdlFrameVisualisation_fr, mdlAdresse_fr;

type
  TfrFournisseurs = class(TfrFrameVisualisation)
    pCtrlDetailFour: TPageControl;
    tShGeneral: TTabSheet;
    tShTransmission: TTabSheet;
    dbGrdProduits: TPIDBGrid;
    edtRepresente: TDBEdit;
    edtRaisonSociale: TDBEdit;
    chkFouPartenaire: TDBCheckBox;
    lblModeTransmission: TLabel;
    Label3: TLabel;
    tShParticularites: TTabSheet;
    chkRepDefaut: TDBCheckBox;
    lblCAMensuel: TLabel;
    edtCAMensuel: TDBEdit;
    dsProduits: TDataSource;
    mmCommentaire: TDBMemo;
    gBoxProtocole171: TGroupBox;
    lblNoAppel: TLabel;
    edtNoAppel: TDBEdit;
    lblIdentifiant171: TLabel;
    edtIdentifiant171: TDBEdit;
    lblVitesse: TLabel;
    edtVitesse: TDBEdit;
    lblFax: TLabel;
    edtFax: TDBEdit;
    GroupBox1: TGroupBox;
    tSHCatalogues: TTabSheet;
    grdCatalogues: TPIDBGrid;
    dsCatalogues: TDataSource;
    frAdresse : TfrAdresse;
    lblLibelle: TDBText;
    lblNorme: TDBText;
    lblcontact: TLabel;
    pnlContact: TPanel;
    lbltypetrans: TLabel;
    edtModeTrans: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtRefpharmaml: TDBEdit;
    Label4: TLabel;
    lblURL1: TLabel;
    edtPharmamlurl1: TDBEdit;
    lblURL2: TLabel;
    edtPharmamlurl2: TDBEdit;
    lblnumclient: TLabel;
    dtpharmamlIdofficine: TDBEdit;
    lblidmag: TLabel;
    edtPharmamlIdmagasin: TDBEdit;
    edtPharmamlcle: TDBEdit;
    lblcle: TLabel;
    edtTelephone: TDBText;
    lblTel: TLabel;
    Label5: TLabel;
    edtfax2: TDBText;
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure sBtnSearchClick(Sender: TObject);
    procedure grdCataloguesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbGrdProduitsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdResultatDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pCtrlDetailFourDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(Aowner: TComponent; AProjet : TProjet); override;
  end;

const
  C_PAGE_CATALOGUE = 0;
  C_PAGE_GENERAL = 1;
  C_PAGE_TRANSMISSION = 2;
  C_PAGE_PARTICULARITES = 3;
  C_PAGE_PRODUITS = 4;

implementation

uses mdlVisualisationPHA_fr;

{$R *.dfm}

procedure TfrFournisseurs.dbGrdProduitsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    if (gdFocused in State)  or (gdSelected in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color := CL_JAUNE_SELECTION
      end
    else
    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);
end;

procedure TfrFournisseurs.dsResultDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  if trim(lblLibelle.Caption) = 'Répartiteur' then
  begin
    lblcontact.Caption := '  Contact';
    tSHCatalogues.Caption := 'Produits Exclusifs'
  end
  else
  begin
    lblcontact.Caption := '  Représentant' ;
    tSHCatalogues.Caption := 'Catalogue' ;
  end;



  if dmVisualisationPHA_fr.dSetFournisseursTYPE_FOURNISSEUR.AsString = C_TYPE_FOURNISSEUR_DIRECT then
  begin
    grdCatalogues.Visible := True;
    tShParticularites.TabVisible := False;
    dbGrdProduits.Visible := False;
  end
  else
  begin
    grdCatalogues.Visible := False;
    tShParticularites.TabVisible := True;
    dbGrdProduits.Visible := True;
  end;
end;

procedure TfrFournisseurs.grdCataloguesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    // OK
    if (gdFocused in State)  or (gdSelected in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color := CL_JAUNE_SELECTION
      end
    else
    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);
end;

procedure TfrFournisseurs.grdResultatDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    // OK
    if (gdFocused in State)  or (gdSelected in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color := CL_JAUNE_SELECTION
      end
    else
    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);

end;

procedure TfrFournisseurs.pCtrlDetailFourDrawTab(Control: TCustomTabControl;
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
  if Active then   Inc(L, 4);
  Control.Canvas.TextOut(L, Rect.Top + (Rect.Bottom - Rect.Top - h) div 2, (Control as TPageControl).Pages[RealIndex].Caption);


end;

constructor TfrFournisseurs.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited;
  grdCatalogues.OnDrawColumnCell := self.grilleLGPIsimple ;
  dbGrdProduits.OnDrawColumnCell := self.grilleLGPIsimple ;
  // Détails par défaut
  pCtrlDetailFour.ActivePageIndex := C_PAGE_GENERAL;
end;

procedure TfrFournisseurs.sBtnSearchClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crSQLWait;

  // Modification requete
  if dmVisualisationPHA_fr.dSetFournisseurs.Active then dmVisualisationPHA_fr.dSetFournisseurs.Close;

  with dmVisualisationPHA_fr.dSetFournisseurs do
  begin
    Params.ByNameAsString['ARAISONSOCIALE'] := edtCritere.Text;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

end.
