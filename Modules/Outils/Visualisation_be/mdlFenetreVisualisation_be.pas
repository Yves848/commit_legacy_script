unit mdlFenetreVisualisation_be;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, mdlProjet, mdlFrameVisualisation_be,
  JvComponentBase, JvNavigationPane, JvExControls, JvOutlookBar, JvJVCLUtils,
  StdCtrls, JvXPCore;

type
  TfrmFenetreVisualisation = class(TForm)
    iLstViewData: TImageList;
    limgCategorie: TImageList;
    npsmStyle: TJvNavPaneStyleManager;
    obNavigation: TJvOutlookBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure obNavigationCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; AStage: TJvOutlookBarCustomDrawStage; AIndex: Integer;
      ADown, AInside: Boolean; var DefaultDraw: Boolean);
    procedure obNavigationButtonClick(Sender: TObject; Index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure obNavigationPageChange(Sender: TObject; Index: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
    FFrames : array of array of TfrFrameVisualisation_be;
    FFrameActive : TfrFrameVisualisation_be;
    FProjet: TProjet;
  public
    { Déclarations publiques }
    property Projet : TProjet read FProjet;
    property FrameActive : TfrFrameVisualisation_be read FFrameActive;
    constructor Create(AOwner : TComponent; AProjet : TProjet); reintroduce;
  end;

  function frmFenetreVisualisation(AProjet : TProjet) : TfrmFenetreVisualisation;

const
  C_PAGE_GESTION_CLIENTS = 0;
  C_BOUTON_CLIENTS = 0;
  C_BOUTON_ORGANISMES = 1;
  C_BOUTON_PRATICIENS = 2;
  C_BOUTON_RISTOURNES = 3;


  C_PAGE_GESTION_PRODUITS = 1;
  C_BOUTON_PRODUITS = 0;
  C_BOUTON_FOURNISSEURS = 1;
  C_BOUTON_PROMOTIONS = 2;

  C_PAGE_GESTION_HISTORIQUES = 2;
  C_BOUTON_DELIVRANCES = 0;

  C_PAGE_GESTION_ENCOURS = 3;
  C_BOUTON_CREDITS = 0;
  C_BOUTON_VIGNETTES_AVANCEES = 1;
  C_BOUTON_PRODUITS_DUS = 2;

  ITEM_DESTINATAIRES = 3;
  ITEM_COMPTES = 0;

  ITEM_FOURNISSEURS = 1;
  ITEM_CODIFICATIONS = 2;
  ITEM_CLASSIFINT = 3;
  ITEM_PROMOTIONS = 4;

implementation

uses mdlristournes_be,mdlClients_be,
  {mdlOrganismes, mdlPraticiens,
  mdlProduits, mdlFournisseurs,
  mdlCodifications, mdlHistoDelivrances,
  mdlCredits, mdlVignettesAvancees,
  mdlPromotions, mdlProduitsDus,
  mdlFacturesAttentes, mdlCommandesEnCours, }
  mdlVisualisationPHA_be;

{$R *.dfm}

var
  FfrmFenetreVisualisation: TfrmFenetreVisualisation;

function frmFenetreVisualisation(AProjet : TProjet) : TfrmFenetreVisualisation;
begin
  if not Assigned(FfrmFenetreVisualisation) then
    FfrmFenetreVisualisation := TfrmFenetreVisualisation.Create(Application.MainForm, AProjet);
  Result := FfrmFenetreVisualisation;
end;

procedure TfrmFenetreVisualisation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FFrameActive.Hide;
  dmVisualisationPHA_be.trPHA.Commit;
end;

procedure TfrmFenetreVisualisation.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := mrOk;
end;

procedure TfrmFenetreVisualisation.FormShow(Sender: TObject);
begin
  // Démarrage de la visu
  dmVisualisationPHA_be.trPHA.StartTransaction;
  obNavigation.ActivePageIndex := C_PAGE_GESTION_CLIENTS;
  obNavigationButtonClick(Sender, C_BOUTON_CLIENTS);
end;

procedure TfrmFenetreVisualisation.obNavigationCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; AStage: TJvOutlookBarCustomDrawStage;
  AIndex: Integer; ADown, AInside: Boolean; var DefaultDraw: Boolean);
begin
  DefaultDraw := False;
  case AStage of
  odsBackground:
     with npsmStyle.Colors do
       GradientFillRect(ACanvas, ARect, HeaderColorFrom, HeaderColorTo, fdTopToBottom, 255);
  odsPage:
     with npsmStyle.Colors do
       GradientFillRect(ACanvas,ARect, ButtonColorFrom, ButtonColorTo, fdTopToBottom, 255);
  odsPageButton:
  begin
     with npsmStyle.Colors do
       GradientFillRect(ACanvas,ARect, HeaderColorFrom, HeaderColorTo, fdTopToBottom, 255);
     if ADown then
       OffsetRect(ARect,1,1);
     ACanvas.Font.Color := clWhite;
     DrawText(ACanvas.Handle, PChar(obNavigation.Pages[AIndex].Caption),
       Length(obNavigation.Pages[AIndex].Caption), ARect, DT_SINGLELINE or DT_VCENTER or DT_CENTER);
  end;
  odsButtonFrame:
  begin
    if ADown then
      ACanvas.Brush.Color := clNavy
    else
      ACanvas.Brush.Color := clBlack;
    ACanvas.FrameRect(ARect);
    InflateRect(ARect,-1,-1);
    if not ADown then
      ACanvas.Brush.Color := clWhite;
    ACanvas.FrameRect(ARect);
  end;
  odsButton:
    DefaultDraw := True;
  end;
end;

procedure TfrmFenetreVisualisation.obNavigationButtonClick(Sender: TObject;
  Index: Integer);

  procedure ChargerFrame(AFrameVisualisation : TfrFrameVisualisationClasse);
  begin
    if Assigned(FFrameActive) then
      FFrameActive.Hide;

    if not Assigned(FFrames[obNavigation.ActivePageIndex, Index]) then
    begin
      FFrames[obNavigation.ActivePageIndex, Index] := AFrameVisualisation.Create(Self, FProjet);
      FFrames[obNavigation.ActivePageIndex, Index].Parent := Self;
    end;
    FFrameActive := FFrames[obNavigation.ActivePageIndex, Index];

    FFrameActive.Show;
  end;

begin
  case obNavigation.ActivePageIndex of
    C_PAGE_GESTION_CLIENTS :
      case Index of
     //   C_BOUTON_CLIENTS : ChargerFrame(TfrClients);
    //    C_BOUTON_ORGANISMES : ChargerFrame(TfrOrganismes);
    //    C_BOUTON_PRATICIENS : ChargerFrame(TfrPraticiens);
        C_BOUTON_RISTOURNES : ChargerFrame(TfrRistournes);
      end;
           {
    C_PAGE_GESTION_PRODUITS :
      case Index of
        C_BOUTON_PRODUITS : 0; //ChargerFrame(TfrProduits);
        C_BOUTON_FOURNISSEURS : ChargerFrame(TfrFournisseurs);
        C_BOUTON_PROMOTIONS : ChargerFrame(TfrPromotions);
      end;

    C_PAGE_GESTION_HISTORIQUES :
      case Index of
        C_BOUTON_DELIVRANCES : ChargerFrame(TfrHistoDelivrances);
      end;

    C_PAGE_GESTION_ENCOURS :
      case Index of
        C_BOUTON_CREDITS : ChargerFrame(TfrCredit);
        C_BOUTON_VIGNETTES_AVANCEES : ChargerFrame(TfrVignettesAvancees);
        C_BOUTON_PRODUITS_DUS : ChargerFrame(TfrProduitsDus);
      end;      }
  end;
end;

procedure TfrmFenetreVisualisation.FormCreate(Sender: TObject);
var
  i, lIntNbOcc : Integer;
begin
  //dmVisualisationPHA_be.ConstruireVuesPrestations;

  SetLength(FFrames, obNavigation.Pages.Count);

  lIntNbOcc := obNavigation.Pages.Count - 1;
  for i := 0 to lIntNbOcc do
    SetLength(FFrames[i], obNavigation.Pages[i].Buttons.Count);
end;

constructor TfrmFenetreVisualisation.Create(AOwner: TComponent;
  AProjet: TProjet);
begin
  inherited Create(AOwner);

  FProjet := AProjet;
  FFrameActive := nil;
end;

procedure TfrmFenetreVisualisation.FormDestroy(Sender: TObject);
var
  i, j : Integer;
begin
  for i := 0 to High(FFrames) do
    for j := 0 to High(FFrames[i]) do
      if Assigned(FFrames[i, j]) then
      begin
        FFrames[i, j].Hide;
        FreeAndNil(FFrames[i, j]);
      end;
end;

procedure TfrmFenetreVisualisation.obNavigationPageChange(Sender: TObject;
  Index: Integer);
begin
  obNavigationButtonClick(Sender, 0);
end;

initialization

finalization
  if Assigned(FfrmFenetreVisualisation) then
    FreeAndNil(FfrmFenetreVisualisation);

end.
