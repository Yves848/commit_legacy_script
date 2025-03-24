unit mdlClients_fr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, mdlPIDBGrid, StdCtrls,
  Buttons, mdlPISpeedButton, ExtCtrls, Mask, DBCtrls,
  ComCtrls, ImgList, Menus, mdlProjet, mdlPIPopupMenu, UIBSQLParser,
  uibdataset, JvMenus, JvExStdCtrls, JvGroupBox, JvExControls, JvLabel,
  JvExDBGrids, JvDBGrid, JvDBImage, JvExExtCtrls, JvImage, JvDBLookup,
  Imaging, ImagingClasses, ImagingUtility, ImagingCanvases, ImagingFormats, ImagingTypes, ImagingComponents,
  mdlFrameVisualisation_fr, mdlAdresse_fr;

type
  TfrClients = class(TfrFrameVisualisation)
    lblNom: TLabel;
    lblQualite: TLabel;
    lblPrenom: TLabel;
    lblNomJeuneFille: TLabel;
    lblRangGemellaire: TLabel;
    lblNumeroInsee: TLabel;
    lblDateNaissance: TLabel;
    edtNom: TDBEdit;
    edtPrenom: TDBEdit;
    edtQualite: TDBEdit;
    edtNomJeuneFille: TDBEdit;
    edtRangGemellaire: TDBEdit;
    edtNumeroInsee: TDBEdit;
    edtDateNaissance: TDBEdit;
    gBxAssure: TGroupBox;
    lblNomAssure: TLabel;
    lblPrenomAssure: TLabel;
    edtNomAssure: TDBEdit;
    edtPrenomAssure: TDBEdit;
    pCtrlDetailClients: TPageControl;
    tShRemboursements: TTabSheet;
    lblNomIdNatAMO: TLabel;
    lblNomIdNatAMC: TLabel;
    lblPieceJustifDroit: TLabel;
    lbDateValiditePieceJ: TLabel;
    lblNAdhAMC: TLabel;
    lblCtrSPHAMC: TLabel;
    edtNomAMO: TDBEdit;
    edtNomReduitAMO: TDBEdit;
    edtIdNatAMO: TDBEdit;
    edtCtrGestAMO: TDBEdit;
    grdCouverturesAMOClient: TPIDBGrid;
    edtNomAMC: TDBEdit;
    edtNomReduitAMC: TDBEdit;
    edtIdNatAMC: TDBEdit;
    edtPieceJustifDroit: TDBEdit;
    edtDateValiditePieceJ: TDBEdit;
    grdCouvertureAMCClient: TPIDBGrid;
    edtNAdhAMC: TDBEdit;
    edtCtrSMHAMC: TDBEdit;
    tShCommentaires: TTabSheet;
    lblCommPerso: TLabel;
    lblCommGlobal: TLabel;
    mmCommPerso: TDBMemo;
    mmCommGlobal: TDBMemo;
    chkCommPersoBlq: TDBCheckBox;
    chkCommGlobBlq: TDBCheckBox;
    tShFamilles: TTabSheet;
    lblAutresBenef: TLabel;
    lblRattacheA: TLabel;
    dbGrdFamilles: TPIDBGrid;
    dsCouverturesAMOClient: TDataSource;
    dsFamilles: TDataSource;
    pnlSeparator: TPanel;
    dsCouverturesAMCClient: TDataSource;
    frAdresseClient: TfrAdresse;
    mnuVignettesAvancees: TMenuItem;
    mnuProduitsDus: TMenuItem;
    mnuHistoriquesDelivrances: TMenuItem;
    mnuCredits: TMenuItem;
    DBNavigator1: TDBNavigator;
    tShProfilcommercial: TTabSheet;
    edtPayeur: TDBEdit;
    edtProfilRemise: TDBEdit;
    edtProfilEdition: TDBEdit;
    edtDateDerniereVisite: TDBEdit;
    Label1: TLabel;
    lblActivite: TLabel;
    edtActivite: TDBEdit;
    lblPayeur: TLabel;
    lblProfilRemise: TLabel;
    Label3: TLabel;
    edtDelaiPaiement: TDBEdit;
    lbldelaipaiement: TLabel;
    cbxRelevedefacture: TDBCheckBox;
    cbxFinDeMois: TDBCheckBox;
    delai: TLabel;
    tshAdherent: TTabSheet;
    dsCollectivite: TDataSource;
    grdCollectivite: TPIDBGrid;
    dsAdherent: TDataSource;
    grdAdherent: TPIDBGrid;
    lblAdherent: TLabel;
    cbxCollectivite: TDBCheckBox;
    Label2: TLabel;
    grdAvantage: TPIDBGrid;
    dsCarteFiClient: TDataSource;
    tshDocument: TTabSheet;
    ImageList1: TImageList;
    dsDocumentClient: TDataSource;
    lstDocumentClient: TDBLookupListBox;
    Panel: TPanel;
    PaintBox: TPaintBox;
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure mnuProduitsDusClick(Sender: TObject);
    procedure btnChercherClick(Sender: TObject);
    procedure dsCouverturesAMOClientStateChange(Sender: TObject);
    procedure dsCouverturesAMCClientStateChange(Sender: TObject);
    procedure mnuVignettesAvanceesClick(Sender: TObject);
    procedure mnuCreditsClick(Sender: TObject);
    procedure mnuHistoriquesDelivrancesClick(Sender: TObject);
    procedure grdAdherentDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdResultatDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pCtrlDetailClientsDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure dbGrdFamillesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdCouvertureAMCClientDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure pCtrlDetailClientsChange(Sender: TObject);
    procedure grdAvantageDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdCollectiviteDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure lstDocumentClientDblClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure PanelResize(Sender: TObject);
  private
    { Déclarations privées }
    FSQLCredits, FSQLVignettesAvancees, FSQLProduitsDus, FSQLHistoriqueClient : string;
    FImage: ImagingClasses.TMultiImage;
    // Canvas for drawing on loaded images
    FImageCanvas: ImagingCanvases.TImagingCanvas;
    // Image background
    FBack: ImagingClasses.TSingleImage;
    // Canvas for background image
    FBackCanvas: ImagingCanvases.TImagingCanvas;
    FFileName: string;
    FLastTime: LongInt;
    FOriginalFormats: array of TImageFormat;
    FSupported: Boolean;
    procedure EffacerImage;
    procedure ChargerImage(F : string);
  public
    { Déclarations publiques }
    constructor Create(Aowner : TComponent; AProjet : TProjet); override;
    procedure Show; override;
    procedure Hide; override;
  end;

const
  C_PAGE_ADRESSE = 0;
  C_PAGE_REMBOURSEMENTS = 1;
  C_PAGE_COMMENTAIRES = 2;
  C_PAGE_FAMILLES = 3;

var
  frClients: TfrClients;
  tabencours:integer =0;
implementation

uses mdlPHA, mdlVisualisationPHA_fr, mdlDetails_fr,
  mdlVignettesAvancees_fr, mdlCredits_fr,
  mdlHistoDelivrances_fr, mdlProduitsDus_fr;

{$R *.dfm}

procedure TfrClients.dsResultDataChange(Sender: TObject;
  Field: TField);
var i,RealPageCount : integer;
begin
  inherited;

  // Affichage de l'assuré
  gBxAssure.Visible := not(dmVisualisationPHA_fr.dSetClientsQUALITE.AsString = '0');
  pCtrlDetailClients.Pages[5].TabVisible := dmVisualisationPHA_fr.dSetClientsRELEVE_DE_FACTURE.AsInteger = 1 ;
  pCtrlDetailClients.Pages[1].TabVisible := dmVisualisationPHA_fr.dSetClientsRELEVE_DE_FACTURE.AsInteger = 0;
  pCtrlDetailClients.Pages[3].TabVisible :=  dmVisualisationPHA_fr.dSetClientsRELEVE_DE_FACTURE.AsInteger = 0;

  for i:=0 to pCtrlDetailClients.PageCount-1 do
  begin
    if ( (RealPageCount>=i) and (pCtrlDetailClients.Pages[i].TabVisible=FALSE) ) then
      RealPageCount:=RealPageCount+1;
  end;

  if tabencours>RealPageCount then
    pCtrlDetailClients.TabIndex := tabencours
  else
    pCtrlDetailClients.TabIndex := RealPageCount;

  EffacerImage;
end;

procedure TfrClients.grdAdherentDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE;

  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);
end;

procedure TfrClients.grdAvantageDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);

end;

procedure TfrClients.grdCollectiviteDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);

end;

procedure TfrClients.grdCouvertureAMCClientDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

    if (TDBGrid(Sender).DataSource.DataSet.RecNo mod 2) = 0 then
      TDBGrid(Sender).Canvas.Brush.Color := CL_GRIS_CLAIR_GRILLE
    else
      TDBGrid(Sender).Canvas.Brush.Color := CL_VERT_GRILLE;

  TDBGrid(Sender).Canvas.Font.Color := TDBGrid(Sender).Canvas.Brush.Color;
  TDBGrid(Sender).DefaultDrawColumnCell(rect,datacol,column,state);
end;



procedure TfrClients.grdResultatDrawColumnCell(Sender: TObject;
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


constructor TfrClients.Create(Aowner: TComponent; AProjet : TProjet);
begin
  inherited;

  grdCouverturesAMOClient.OnDrawColumnCell := self.grilleLGPIsimple ;
  // Détails par défaut
  pCtrlDetailClients.ActivePageIndex := C_PAGE_ADRESSE;

  FImage := TMultiImage.Create;
  FImageCanvas := TImagingCanvas.Create;
  FBack := TSingleImage.CreateFromParams(128, 128, ifA8R8G8B8);
  FBackCanvas := FindBestCanvasForImage(FBack).CreateForImage(FBack);
end;

procedure TfrClients.mnuProduitsDusClick(Sender: TObject);
begin
  with dmVisualisationPHA_fr, dSetProduitsDus do
  begin
    if Active then
      Close;
    Params.ByNameAsString['ACLIENTID'] := dSetClientsT_CLIENT_ID.AsString;
    Open;
  end;
  TfrmDetails.Create(Self, Projet, TfrProduitsDus).ShowModal;
end;

procedure TfrClients.btnChercherClick(Sender: TObject);
var
  lIntPos : Integer;
  lStrNom, lStrPrn : string;
begin
  inherited;

  Screen.Cursor := crSQLWait;
  if dmVisualisationPHA_fr.dSetClients.Active then dmVisualisationPHA_fr.dSetClients.Close;

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

  with dmVisualisationPHA_fr.dSetClients do
  begin
    Params.ByNameAsString['ANOM'] := lStrNom;
    Params.ByNameAsString['APRENOM'] := lStrPrn;
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TfrClients.dsCouverturesAMOClientStateChange(
  Sender: TObject);
begin
  inherited;

  if dsCouverturesAMOClient.State = dsBrowse then
  begin
    dsCouverturesAMOClient.DataSet.Fields[0].Visible := False;
    grdCouverturesAMOClient.AjusterLargeurColonnes;
  end;
end;

procedure TfrClients.dbGrdFamillesDrawColumnCell(Sender: TObject;
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

procedure TfrClients.dsCouverturesAMCClientStateChange(
  Sender: TObject);
begin
  inherited;

  if dsCouverturesAMCClient.State = dsBrowse then
  begin
    dsCouverturesAMCClient.DataSet.Fields[0].Visible := False;
    grdCouvertureAMCClient.AjusterLargeurColonnes;
  end;
end;

procedure TfrClients.mnuVignettesAvanceesClick(
  Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr, dSetVignettesAvancees do
  begin
    if Active then
      Close;
    Params.ByNameAsString['ACLIENTID'] := dSetClientsT_CLIENT_ID.AsString;
    Open;
  end;
  TfrmDetails.Create(Self, Projet, TfrVignettesAvancees).ShowModal(False, True);
end;

procedure TfrClients.EffacerImage;
const
  C_CHECKER_DENSITY = 8;
begin
  if Assigned(FImage) then
  begin
    FImage.CreateFromParams(C_CHECKER_DENSITY, C_CHECKER_DENSITY, ifA8R8G8B8, 1);
    FImageCanvas.Free;
    FImageCanvas := FindBestCanvasForImage(FImage).CreateForImage(FImage);
  end;
  // Paint current image
  PaintBox.Repaint;
end;

procedure TfrClients.PaintBoxPaint(Sender: TObject);
var
  R: TRect;
  Filter: TResizeFilter;
begin
  inherited;

  // Fill background with default color
  FBackCanvas.FillColor32 := ColorToRGB(clBtnFace);
  FBackCanvas.FillRect(Rect(0, 0, FBack.Width, FBack.Height));

  // Determine which stretching filter to use
  if FSupported {and CheckFilter.Checked} then
    Filter := rfBicubic
  else
    Filter := rfNearest;
  // Scale image to fit the paint box
  R := ImagingUtility.ScaleRectToRect(FImage.BoundsRect, PaintBox.ClientRect);
  // Create canvas for current image frame
  FImageCanvas.Free;
  FImageCanvas := FindBestCanvasForImage(FImage).CreateForImage(FImage);
  // Stretch image over background canvas
  FImageCanvas.StretchDrawAlpha(FImage.BoundsRect, FBackCanvas, R, Filter);

  // Draw image to canvas (without conversion) using OS drawing functions.
  // Note that DisplayImage only supports images in ifA8R8G8B8 format so
  // if you have image in different format you must convert it or
  // create standard TBitmap by calling ImagingComponents.ConvertImageToBitmap
  ImagingComponents.DisplayImage(PaintBox.Canvas, PaintBox.BoundsRect, FBack);
end;

procedure TfrClients.PanelResize(Sender: TObject);
begin
  inherited;

  // Resize background image to fit the paint box
  FBack.Resize(PaintBox.ClientWidth, PaintBox.ClientHeight, rfNearest);
  // Update back canvas state after resizing of associated image
  FBackCanvas.UpdateCanvasState;
end;

procedure TfrClients.pCtrlDetailClientsChange(Sender: TObject);
var i, realindex : Integer;
begin
  inherited;

  RealIndex:= (Sender as TPageControl).TabIndex;
  for i:=0 to (Sender as TPageControl).PageCount-1 do
  begin
    if ( (RealIndex>=i) and ((Sender as TPageControl).Pages[i].TabVisible=FALSE) ) then
      RealIndex:=RealIndex+1;
  end;

  tabencours := Realindex;
end;

procedure TfrClients.pCtrlDetailClientsDrawTab(Control: TCustomTabControl;
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


procedure TfrClients.mnuCreditsClick(Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr, dSetCredits do
  begin
    if Active then
      Close;
    Params.ByNameAsString['ACLIENTID'] := dSetClientsT_CLIENT_ID.AsString;
    Open;
  end;

  with TfrmDetails.Create(Self, Projet, TfrCredit) do
  begin
    TfrCredit(FrameDetails).pnlRecapitulatif.Hide;
    ShowModal(False, True);
  end;
end;

procedure TfrClients.mnuHistoriquesDelivrancesClick(
  Sender: TObject);
begin
  inherited;

  with dmVisualisationPHA_fr, dSetHistoriqueClient do
  begin
    if Active then
      Close;
    Params.ByNameAsString['ACLIENTID'] := dSetClientsT_CLIENT_ID.AsString;
    Open;
  end;
  TfrmDetails.Create(Self, Projet, TfrHistoDelivrances).ShowModal(False, True);
end;

procedure TfrClients.Show;
begin
  inherited;

  with dmVisualisationPHA_fr do
  begin
    FSQLCredits := dSetCredits.SQL.Text; AjouterWhere(dSetCredits.SQL, 't_client_id = :ACLIENTID');
    FSQLVignettesAvancees := dSetVignettesAvancees.SQL.Text; AjouterWhere(dSetVignettesAvancees.SQL, 't_client_id = :ACLIENTID');
    FSQLProduitsDus := dSetProduitsDus.SQL.Text; AjouterWhere(dSetProduitsDus.SQL, 't_client_id = :ACLIENTID');
    FSQLHistoriqueClient := dSetHistoriqueClient.SQL.Text; AjouterWhere(dSetHistoriqueClient.SQL, 't_client_id = :ACLIENTID');
  end;
end;

procedure TfrClients.Hide;
begin
  with dmVisualisationPHA_fr do
  begin
    dSetHistoriqueClient.SQL.Text := FSQLHistoriqueClient;
    dSetProduitsDus.SQL.Text := FSQLProduitsDus;
    dSetVignettesAvancees.SQL.Text := FSQLVignettesAvancees;
    dSetCredits.SQL.Text := FSQLCredits;
  end;

  inherited;
end;
procedure TfrClients.ChargerImage(F : string);
var
  I: LongInt;
begin
  try
    // DetermineFileFormat reads file header and returns image
    // file format identifier (like 'jpg', 'tga') if file is valid,
    // otherwise empty string is returned
    if Imaging.DetermineFileFormat(F) <> '' then
      try
        // Load all subimages in file
        FImage.LoadMultiFromFile(F);

        if not FImage.AllImagesValid then
          Exit;

        for I := 0 to FImage.ImageCount - 1 do
        begin
          FImage.ActiveImage := I;
          if not (FImage.Format in TImagingCanvas.GetSupportedFormats) then
            FImage.Format := ifA8R8G8B8;
        end;
        // Activate first image and update UI
        FImage.ActiveImage := 0;
        PaintBox.Repaint;
      except
        raise;
      end
    //else
      //SetUnsupported;
  except
    raise;
  end;
end;

procedure TfrClients.lstDocumentClientDblClick(Sender: TObject);begin
  inherited;

  ChargerImage(dmVisualisationPHA_fr.dSetDocumentClientDOCUMENT.AsString);
end;

end.