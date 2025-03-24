unit mdlModule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Menus, StdCtrls, ExtCtrls, Grids, XMLIntf,
  JvWizard, JvWizardRouteMapNodes, JvExControls, Contnrs, mdlGrille, DB,
  JvComponent, mdlPIPanel, StrUtils, mdlLectureFichierBinaire, mdlProjet,
  JvMenus, mdlPIStringGrid, DBGrids, mdlPIDBGrid, PReport, PdfDoc, ShellAPI,
  JvXPBar, JvXPCore, JvXPContainer, ImgList, ActnList, mdlTypes, mdlPHA, UIBLib,
  uib, MMSystem, Math, mdlPIButton, Generics.Collections, mdlConnexionServeur,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, Sockets;

type
  TProcedureTraitement = procedure of object;

  tTCPServerGeneric = procedure(Sender: TObject) of object;
  tTCPServerAccept = procedure(Sender: TObject; ClientSocket: TCustomIpClient) of object;

  EAffichageResultat = class(Exception);
  ETraitement = class(Exception);
  ETraitements = class(Exception);

  TAffichageResultat = class
  private
    FGrille: TStringGrid;
    FLigne: Integer;
    FLibelle: string;
  public
    property Grille : TStringGrid read FGrille;
    property Ligne : Integer read FLigne;
    property Libelle : string read FLibelle;
    constructor Create(AGrille : TStringGrid; ALigne: Integer; ALibelle : string);
  end;

  TTypeTraitement = (ttFichier, ttFichierTraitement, ttTraitement, ttProcedure);

  TTraitement = class
  private
    FAffichageResultat: TAffichageResultat;
    FErreurs: Integer;
    FSucces: Integer;
    FRejets: Integer;
    FFait: Boolean;
    FProcedureTraitement: TProcedureTraitement;
    FFichierPresent: Boolean;
    FFichier: string;
    FPeriodeRafraichissement: Integer;
    FFin: TDateTime;
    FDebut: TDateTime;
    FAvertissements: Integer;
    FTypeTraitement: TTypeTraitement;
    procedure SetErreurs(const Value: Integer);
    procedure SetRejets(const Value: Integer);
    procedure SetSucces(const Value: Integer);
    procedure SetFait(const Value: Boolean);
    procedure SetFichierPresent(const Value: Boolean);
    procedure SetDebut(const Value: TDateTime);
    procedure SetFin(const Value: TDateTime);
    procedure SetAvertissements(const Value: Integer);
  public
    property TypeTraitement : TTypeTraitement read FTypeTraitement;
    property Succes : Integer read FSucces write SetSucces;
    property Avertissements : Integer read FAvertissements write SetAvertissements;
    property Rejets : Integer read FRejets write SetRejets;
    property Erreurs : Integer read FErreurs write SetErreurs;
    property Debut : TDateTime read FDebut write SetDebut;
    property Fin : TDateTime read FFin write SetFin;
    property Fait : Boolean read FFait write SetFait;
    property Fichier : string read FFichier;
    property PeriodeRafraichissement : Integer read FPeriodeRafraichissement write FPeriodeRafraichissement;
    property FichierPresent : Boolean read FFichierPresent write SetFichierPresent;
    property AffichageResultat : TAffichageResultat read FAffichageResultat;
    property ProcedureTraitement : TProcedureTraitement read FProcedureTraitement write FProcedureTraitement;
    constructor Create(AFichier : string; ATypeTraitement : TTypeTraitement; AGrille : TStringGrid;
      ALigne: Integer; ALibelle : string); virtual;
    procedure InitialisationResultat; virtual;
    procedure CompleterTraitement(F : TSQLResult); virtual;
  end;
  TClasseTraitement = class of TTraitement;

  TTraitementBD = class(TTraitement)
  private
    FProcedureCreation: string;
    FIndex: Integer;
    FRequeteSelection: string;
  public
    property Index : Integer read FIndex write FIndex;
    property RequeteSelection : string read FRequeteSelection write FRequeteSelection;
    property ProcedureCreation : string read FProcedureCreation write FProcedureCreation;
  end;

  TTraitements = class(TObjectList)
  private
    function GetTraitement(AFichier: string): TTraitement;
    function GetTraitementParGrille(AGrille: string; ALigne: Integer): TTraitement;
    function GetItem(Index: Integer): TTraitement;
  public
    property Items[Index: Integer]: TTraitement read GetItem; default;
    property Traitements[ALibelle : string] : TTraitement read GetTraitement;
    property TraitementsParGrille[AGrille : string; ALigne : Integer] : TTraitement read GetTraitementParGrille;
    procedure Add(ATraitement : TTraitement);
  end;

  TSurTraiterDonneesEvent = procedure(Sender : TObject; AResultat : TResultatCreationDonnees) of object;
  TSurAvantConnecterEvent = procedure(Sender : TObject; var AAutorise : Boolean) of object;
  TSurApresConnecterEvent = procedure(Sender : TObject) of object;

  TCouleurModule = array[TTypeModule] of TColor;

  TModeTraitement = (mtNormal, mtMAJ, mtFusion);
  TLibelleModeTraitement = array[TModeTraitement] of string;

  TModesTraitement = set of TModeTraitement;

  TModeConnexion = (mcDirecte, mcBaseSQL, mcServeurSQL);


  TfrModule = class(TFrame)
    mnuMenuPrincipale: TJvMainMenu;
    pmnuMenuContextuel: TPopupMenu;
    wzDonnees: TJvWizard;
    wipBienvenue: TJvWizardInteriorPage;
    wipPraticiens: TJvWizardInteriorPage;
    grdPraticiens: TPIStringGrid;
    wipOrganismes: TJvWizardInteriorPage;
    grdOrganismes: TPIStringGrid;
    wipClients: TJvWizardInteriorPage;
    grdClients: TPIStringGrid;
    wipProduits: TJvWizardInteriorPage;
    grdProduits: TPIStringGrid;
    wipAutresDonnees: TJvWizardInteriorPage;
    grdAutresDonnees: TPIStringGrid;
    wipRecapitulatif: TJvWizardInteriorPage;
    sbxRecapitulatif: TScrollBox;
    prpRecapitulatif: TPRPage;
    prlpRecapitulatif: TPRLayoutPanel;
    prRecapitulatif: TPReport;
    prlNonImportees: TPRLabel;
    prlImportees: TPRLabel;
    rmnDonnees: TJvWizardRouteMapNodes;
    xpcOutils: TJvXPContainer;
    pnlTitre: TPIPanel;
    limOutils: TImageList;
    lacOutils: TActionList;
    wipEnCours: TJvWizardInteriorPage;
    grdEnCours: TPIStringGrid;
    prlRejetees: TPRLabel;
    sbxTraitements: TScrollBox;
    xpbTraitements: TJvXPBar;
    xpbEntetesTraitements: TJvXPBar;
    actAccesBDConnexion: TAction;
    actAccesBDDeconnexion: TAction;
    actAccesBDParametres: TAction;
    xpbAccesBD: TJvXPBar;
    bvlSeparateur_2: TBevel;
    bvlSeparateur_1: TBevel;
    PIPanel1: TPIPanel;
    vstMAJModule: TVirtualStringTree;
    StaticText1: TStaticText;
    spl1: TJvNetscapeSplitter;
    procedure wzDonneesCancelButtonClick(Sender: TObject);
    procedure wzDonneesActivePageChanged(Sender: TObject);
    procedure PagePrecSuiv(Sender : TObject; var Stop : Boolean);
    procedure FrameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SurAlarmeInactivite(Sender : TObject);
    procedure wipRecapitulatifEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure sbxRecapitulatifResize(Sender: TObject);
    procedure GrilleDblClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure wzDonneesActivePageChanging(Sender: TObject;
      var ToPage: TJvWizardCustomPage);
    procedure wzDonneesHelpButtonClick(Sender : TObject;
      var Stop : Boolean);
    procedure xpbTraitementsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actAccesBDConnexionExecute(Sender: TObject);
    procedure actAccesBDDeconnexionExecute(Sender: TObject);
    procedure actAccesBDParametresExecute(Sender: TObject); virtual;
    procedure vstMAJModuleGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vstMAJModuleFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
  private
    FModule: TModule;
    FPHA: TdmPHA;
    FAnnulation : Boolean;
    FEnTraitement: Boolean;
    FSurAvantConnecter: TSurAvantConnecterEvent;
    FSurApresConnecter: TSurApresConnecterEvent;
    FSurDeconnecter: TNotifyEvent;
    FSurAnnulerTraitement: TNotifyEvent;
    FTraitements: TTraitements;
    FSurAvantTraiterDonnees: TNotifyEvent;
    FSurApresTraiterDonnees: TSurTraiterDonneesEvent;
    FSecInactivite : Integer;
    FTraitement: TTraitement;
    FTimerInactivite : TTimer;
    FTraitementAutomatique: Boolean;
    FMode: TModeTraitement;
    FModesGeres: TModesTraitement;
    FSurEnregistrerConfiguration: TNotifyEvent;
    FModeConnexion: TModeConnexion;
    FMinimize : Boolean;
    procedure SetAnnulation(const Value: Boolean);
    procedure AfficherTraitements;
    procedure SetTraitementEnCours(const Value: TTraitement);
  protected
    FConnecte : Boolean;
    FResultat: TResultatCreationDonnees;
    FInterfaceConnexion: TfrmConnexionServeurClasse;
    procedure ParametrerAccesBD(AInitialisation : Boolean = False); virtual;
    procedure RenvoyerParametresConnexion; virtual; abstract;
    procedure StockerParametresConnexion; virtual; abstract;
    procedure SetMode(const Value: TModeTraitement); virtual;
    procedure FaireApresTraiterDonnees; virtual;
    function FaireTraitementDonnees(ADonnees : TFields) : TResultatCreationDonnees; overload; virtual;
    procedure FinTraitement(ADataSet : TDataSet); overload; virtual;
    procedure TraiterDonnees(APage : TJvWizardCustomPage; AGrille : TStringGrid;
      AReset : Boolean; ADonneesASupprimees : TList<Integer>; AProcedureTraitement : TProcedureTraitement);
    procedure TraiterDonnee(ATraitement: TTraitement); overload; virtual;
    procedure TraiterDonnee(ATraitement: TTraitement; ADataSet : TDataSet); overload; virtual;
    procedure TraiterDonneesPraticiens; virtual; abstract;
    procedure TraiterDonneesOrganismes; virtual; abstract;
    procedure TraiterDonneesClients; virtual; abstract;
    procedure TraiterDonneesProduits; virtual; abstract;
    procedure TraiterDonneesEncours; virtual; abstract;
    procedure TraiterAutresDonnees; virtual; abstract;
    function RenvoyerClasseTraitement : TClasseTraitement; virtual;
  public
    { Déclarations publiques }
    const LibelleModeTraitement : TLibelleModeTraitement = ('Normal', 'Mise à jour', 'Fusion');
    const CouleurModule : TCouleurModule = (clNone, clLime, clPurple, clNone);
    property Annulation : Boolean read FAnnulation write SetAnnulation;
    property Mode : TModeTraitement read FMode write SetMode;
    property ModesGeres : TModesTraitement read FModesGeres write FModesGeres;
    property ModeConnexion : TModeConnexion read FModeConnexion write FModeConnexion;
    property TraitementAutomatique : Boolean read FTraitementAutomatique;
    property EnTraitement : Boolean read FEnTraitement write FEnTraitement;
    property Minimize : Boolean read FMinimize write FMinimize;
    property Connecte : Boolean read FConnecte;
    property Module : TModule read FModule;
    property PHA : TdmPHA read FPHA;
    property InterfaceConnexion : TfrmConnexionServeurClasse read FInterfaceConnexion;
    property TimerInactivite : TTimer read FTimerInactivite;
    property Traitements : TTraitements read FTraitements;
    property TraitementEnCours : TTraitement read FTraitement write SetTraitementEnCours;
    property SurAnnulerTraitement : TNotifyEvent read FSurAnnulerTraitement write FSurAnnulerTraitement;
    property SurAvantConnecter : TSurAvantConnecterEvent read FSurAvantConnecter write FSurAvantConnecter;
    property SurApresConnecter : TSurApresConnecterEvent read FSurApresConnecter write FSurApresConnecter;
    property SurDeconnecter : TNotifyEvent read FSurDeconnecter write FSurDeconnecter;
    property SurAvantTraiterDonnees : TNotifyEvent read FSurAvantTraiterDonnees write FSurAvantTraiterDonnees;
    property SurApresTraiterDonnees : TSurTraiterDonneesEvent read FSurApresTraiterDonnees write FSurApresTraiterDonnees;
    property SurEnregistrerConfiguration : TNotifyEvent read FSurEnregistrerConfiguration write FSurEnregistrerConfiguration;
    constructor Create(AOwner : TComponent; AModule : TModule); reintroduce; virtual;
    destructor Destroy; override;
    procedure Show; virtual;
    procedure Hide; virtual;
    procedure Connecter; virtual;
    procedure Deconnecter; virtual;
    procedure RenvoyerTraitements;
    procedure InitialisationAffichage; virtual;
    procedure TraiterToutesLesDonnees; virtual;
  end;

  TfrModuleClasse = class of TfrModule;

type
  TrecMAJ = record
    NumeroVersion : Integer;
    DateDiffusion : TDateTime;
    Contenu : string;
  end;
  PrecMAJ = ^TrecMAJ;

const
  CM_MODULE_AIDE = WM_USER + $10;

  C_PERIODE_INACTIVITE = 30;

  C_COLONNE_LIBELLE = 1;
  C_COLONNE_FICHIER_PRESENT = 2;
  C_COLONNE_SUCCES = 3;
  C_COLONNE_AVERTISSEMENT = 4;
  C_COLONNE_REJETS = 5;
  C_COLONNE_ERREURS = 6;
  C_COLONNE_DEBUT = 7;
  C_COLONNE_FIN = 8;
  C_COLONNE_FAIT = 9;

  C_INDEX_PAGE_BIENVENUE = 0;
  C_INDEX_PAGE_PRATICIENS = 1;
  C_INDEX_PAGE_ORGANISMES = 2;
  C_INDEX_PAGE_CLIENTS = 3;
  C_INDEX_PAGE_PRODUITS = 4;
  C_INDEX_PAGE_ENCOURS = 5;
  C_INDEX_PAGE_AUTRES_DONNEES = 6;

var
  frModule : TfrModule;

implementation

uses mdlErreurs;

{$R *.dfm}

const
  C_COLONNE_NUMERO_VERSION = 0;
  C_COLONNE_DATE_DIFFUSION = 1;
  C_COLONNE_CONTENU = 2;

{ TTraitementDonnee }

procedure TTraitement.CompleterTraitement(F: TSQLResult);
begin

end;

constructor TTraitement.Create(AFichier : string; ATypeTraitement : TTypeTraitement; AGrille : TStringGrid;
  ALigne: Integer; ALibelle : string);
begin
  FFichier := AFichier;
  FTypeTraitement := ATypeTraitement;
  FPeriodeRafraichissement := 250;

  InitialisationResultat;
  FAffichageResultat := TAffichageResultat.Create(AGrille, ALigne, ALibelle);
  with FAffichageResultat do
    Grille.Objects[0, Ligne] := Self;
end;

procedure TTraitement.InitialisationResultat;
begin
  Succes := 0;
  Avertissements := 0;
  Rejets := 0;
  Erreurs := 0;
  Debut := 0;
  Fin := 0;
  Fait := False;
  FFichierPresent := False;
end;

procedure TTraitement.SetAvertissements(const Value: Integer);
begin
  if FAvertissements <> Value then
  begin
    FAvertissements := Value;
    FSucces := FSucces + 1;
    with FAffichageResultat do
      Grille.Cells[C_COLONNE_AVERTISSEMENT, Ligne] := IntToStr(FAvertissements);
//    Application.HandleMessage;
    if (FAvertissements mod FPeriodeRafraichissement) = 0 then
      Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetDebut(const Value: TDateTime);
begin
  if FDebut <> Value then
  begin
    FDebut := Value;
    with FAffichageResultat do
      FAffichageResultat.Grille.Cells[C_COLONNE_DEBUT, Ligne] := IfThen(Value <> 0, FormatDateTime('DD/MM/YYYY hh:nn:ss', FDebut));
    Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetErreurs(const Value: Integer);
begin
  if FErreurs <> Value then
  begin
    FErreurs := Value;
    with FAffichageResultat do
      Grille.Cells[C_COLONNE_ERREURS, Ligne] := IntToStr(FErreurs);
//    Application.HandleMessage;
    if (FErreurs mod FPeriodeRafraichissement) = 0 then
      Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetFait(const Value: Boolean);
begin
  if FFait <> Value then
  begin
    FFait := Value;
    with FAffichageResultat do
      Grille.Cells[C_COLONNE_FAIT, Ligne] := IntToStr(Ord(FFait));
    if FFait then
      Fin := Now;
    Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetFichierPresent(const Value: Boolean);
begin
  if FFichierPresent <> Value then
  begin
    FFichierPresent := Value;
    with FAffichageResultat do
      Grille.Cells[C_COLONNE_FICHIER_PRESENT, Ligne] := IntToStr(Ord(FFichierPresent));
    Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetFin(const Value: TDateTime);
begin
  if FFin <> Value then
  begin
    FFin := Value;
    with FAffichageResultat do
      FAffichageResultat.Grille.Cells[C_COLONNE_FIN, Ligne] := IfThen(Value <> 0, FormatDateTime('DD/MM/YYYY hh:nn:ss', FFin));
    Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetRejets(const Value: Integer);
begin
  if FRejets <> Value then
  begin
    FRejets := Value;
    with FAffichageResultat do
      Grille.Cells[C_COLONNE_REJETS, Ligne] := IntToStr(FRejets);
//    Application.HandleMessage;
    if (FRejets mod FPeriodeRafraichissement) = 0 then
      Application.ProcessMessages;
  end;
end;

procedure TTraitement.SetSucces(const Value: Integer);
begin
  if FSucces <> Value then
  begin
    FSucces := Value;
    with FAffichageResultat do
      Grille.Cells[C_COLONNE_SUCCES, Ligne] := IntToStr(FSucces);
//    Application.HandleMessage;
    if (FSucces mod FPeriodeRafraichissement) = 0 then
      Application.ProcessMessages;
  end;
end;

{ TAffichageResultat }

constructor TAffichageResultat.Create(AGrille: TStringGrid;
  ALigne: Integer; ALibelle : string);
begin
  // Validation de la grille
  if not Assigned(AGrille) then
    raise ETraitement.Create('Grille non affectée !')
  else
  begin
    FGrille := AGrille;
    if FGrille.RowCount < (ALigne + 1) then
      FGrille.RowCount := ALigne + 1;
    FLigne := ALigne;
    FGrille.Cells[C_COLONNE_LIBELLE, Ligne] := ALibelle;
    FLibelle := ALibelle;
  end;
end;

{ TfrModule }

procedure TfrModule.AfficherTraitements;
var
  lGrille : TStringGrid;
  i : Integer;
begin
  // Ajout des traitements individuels
  xpbTraitements.Items.Clear;
  lGrille := TStringGrid(wzDonnees.ActivePage.FindChildControl('grd' + RightStr(wzDonnees.ActivePage.Name, Length(wzDonnees.ActivePage.Name) - 3)));
  if Assigned(lGrille) then
  begin
    // Suppression
    with xpbTraitements.Items.Add do
    begin
      Caption := 'Suppression';
      Tag := 0;
    end;

    // Traitements
    for i := 1 to lGrille.RowCount do
      if Assigned(lGrille.Objects[0, i]) then
        with xpbTraitements.Items.Add do
        begin
          Caption := TTraitement(lGrille.Objects[0, i]).AffichageResultat.Libelle;
          Tag := i;
        end;

    sbxTraitements.VertScrollBar.Range := xpbTraitements.Items.Count * xpbTraitements.ItemHeight;
  end;
  xpbTraitements.Visible := xpbTraitements.Items.Count > 0;
  xpbEntetesTraitements.Visible := xpbTraitements.Items.Count > 0;
end;

procedure TfrModule.Connecter;
var
  a : Boolean;
  i : Integer;
  c : string;
begin
  FConnecte := False;
  try
    case FModeConnexion of
      mcBaseSQL :
        FPHA.ConnexionBD;
      mcServeurSQL :
        begin
          ParametrerAccesBD(False);
          a := True;
          if Assigned(FSurAvantConnecter) then FSurAvantConnecter(Self, a);
          if a then
          begin
            FPHA.ConnexionBD;

            actAccesBDConnexion.Enabled := False;
            actAccesBDDeconnexion.Enabled := True;

            c := FPHA.RenvoyerChaineConnexion;
            for i := 0 to wzDonnees.PageCount - 1 do
            //if wzDonnees.Pages[i].Tag = 0 then
              begin
                wzDonnees.Pages[i].Subtitle.Visible := True;
                wzDonnees.Pages[i].Subtitle.Text := c;
              end;

          end
          else
            ParametrerAccesBD(True);
        end;
    end;
    FConnecte := True;

    if Assigned(FSurApresConnecter) then
      FSurApresConnecter(Self);
  except
    on E:Exception do
    begin
      MessageDlg('Erreur de connexion : ' + E.Message, mtError, [mbOk], 0);
      FConnecte := False;
      ParametrerAccesBD(True);
    end;
  end;
end;

procedure TfrModule.Deconnecter;
var
  i : Integer;
begin
  case FModeConnexion of
    mcBaseSQL :
      PHA.DeconnexionBD;
    mcServeurSQL :
      begin
        FPHA.DeconnexionBD;
        FConnecte := False;

        for i := 0 to wzDonnees.PageCount - 1 do
        begin
          //if wzDonnees.Pages[i].Tag = 0 then
            wzDonnees.Pages[i].Subtitle.Visible := False;
            wzDonnees.Pages[i].Subtitle.Text := '';
        end;

        actAccesBDConnexion.Enabled := True;
        actAccesBDDeconnexion.Enabled := False;

        if Assigned(FSurDeconnecter) then
          FSurDeconnecter(Self);
      end;
  end;
end;

procedure TfrModule.SetAnnulation(const Value: Boolean);
begin
  FAnnulation := Value;
  if FAnnulation and Assigned(FSurAnnulerTraitement) then
    FSurAnnulerTraitement(Self);
end;

constructor TfrModule.Create(AOwner : TComponent; AModule : TModule);
var
  lClasse : TClass;
  lStrVersion : string;
  i, lIntPos : Integer;
begin
  inherited Create(AOwner);

  if not (AModule.TypeModule in [tmImport, tmTransfert]) then
    EModule.Create('Impossible de créer une interface de ce type avec ce type de module !');

  frModule := Self;
  FModule := AModule;

  FAnnulation := False;
  FEnTraitement := False;

  Parent := Application.MainForm;
  Align := alClient;

  // Mise en forme de l'assistant
  lStrVersion := ReverseString(FModule.Version);
  lIntPos := Pos('.', lStrVersion);
  pnlTitre.Caption := FModule.Description + ' (ver. ' + ReverseString(Copy(lStrVersion, 1, lIntPos - 1)) + ')';
  pnlTitre.Degrade.CouleurFin := CouleurModule[FModule.TypeModule];
  wipBienvenue.Title.Text := AModule.LibelleTypeModule[FModule.TypeModule] + ' des données';
  for i := 0 to rmnDonnees.PageCount - 1 do
  begin
    // Titre
    rmnDonnees.Pages[i].Title.Alignment := taLeftJustify;
    if rmnDonnees.Pages[i].Tag = 0 then
      rmnDonnees.Pages[i].Title.Text := AModule.LibelleTypeModule[FModule.TypeModule] + ' des données ' + LowerCase(rmnDonnees.Pages[i].Caption)
    else
      rmnDonnees.Pages[i].Title.Text := rmnDonnees.Pages[i].Caption;

    // Sous-titre
    rmnDonnees.Pages[i].Subtitle.Alignment := taLeftJustify;
    rmnDonnees.Pages[i].Subtitle.Visible := False;
  end;
  rmnDonnees.NodeColors.Selected := CouleurModule[FModule.TypeModule];

  prRecapitulatif.FileName := FModule.Projet.RepertoireProjet + AModule.LibelleTypeModule[FModule.TypeModule] + '.pdf';
  prRecapitulatif.Title := AModule.LibelleTypeModule[FModule.TypeModule] + ' des données ' + UpperCase(FModule.NomModule);

  if FModeConnexion = mcServeurSQL then
  begin
    xpbAccesBD.Visible := True;
    xpbAccesBD.Caption := Module.Description;
    if FModule.Icone.HandleAllocated then
      xpbAccesBD.Icon.Assign(FModule.Icone);
  end
  else
    xpbAccesBD.Visible := False;

  // Recherche du module de données
  FConnecte := FModeConnexion = mcDirecte;
  try
    lClasse := GetClass('Tdm' + FModule.NomModule + 'PHA');
    if Assigned(lClasse) then
      FPHA := TdmPHAClasse(lClasse).Create(Self, FModule)
    else
      raise EModule.Create('Module de données PHA introuvable !');
  except
    on E:Exception do
      raise EModule.Create('Impossible de créer le module d''accès à la base locale !'#13#10#13#10 +
                           'Message : ' + E.Message);
  end;

  // Traitements
  FTraitements := TTraitements.Create;
  RenvoyerTraitements;

  // Création Timer d'inactivité
  FTimerInactivite := TTimer.Create(nil);
  FTimerInactivite.Enabled := False;
  FTimerInactivite.OnTimer := SurAlarmeInactivite;

  Enabled := False;

  FModesGeres := [mtNormal];
  FMode := FModule.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes[LowerCase(AModule.LibelleTypeModule[FModule.TypeModule])].Attributes['mode'];

  vstMAJModule.NodeDataSize := SizeOf(TrecMAJ);
end;

procedure TfrModule.wzDonneesCancelButtonClick(Sender: TObject);
begin
  if FEnTraitement then
    Annulation := MessageDlg('Annulez le traitement en cours ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TfrModule.RenvoyerTraitements;
var
  lClasseTraitement : TClasseTraitement;
  lTraitement : TTraitement;
  lStrTypeModule : string;
  lIntRatioTT : Integer;
  idx : Word;

  function ChercherComposant(const AName: string): TComponent;
  var
    I: Integer;
  begin
    if (AName <> '') then
      for I := 0 to ComponentCount - 1 do
      begin
        Result := Components[I];
        if SameText(Result.Name, AName) then Exit;
      end;
    Result := nil;
  end;

begin
  FTraitements.Clear;
  with FPHA.qryPHA do
  begin
    lIntRatioTT := Ord(FModule.TypeModule);
    lStrTypeModule := IntToStr(lIntRatioTT);
    lIntRatioTT := lIntRatioTT * 10;

    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('select *');
    SQL.Add('from v_traitement_' + lStrTypeModule);
    SQL.Add('where substring(type_fichier from 2 for 1) in (1, 2, 3)');
    Open;

    lClasseTraitement := RenvoyerClasseTraitement;
    while not EOF do
    begin
      lTraitement := lClasseTraitement.Create(Fields.ByNameAsString['NOM'],
                                              TTypeTraitement(Fields.ByNameAsInteger['TYPE_FICHIER'] - lIntRatioTT),
                                              TStringGrid(ChercherComposant(Fields.ByNameAsString['GRILLE'])),
                                              Fields.ByNameAsInteger['LIGNE'],
                                              Fields.ByNameAsString['LIBELLE']);
      if lClasseTraitement.InheritsFrom(TTraitementBD) then
        with lTraitement as TTraitementBD do
        begin
          Index := Fields.ByNameAsInteger['T_TRAITEMENT_ID'];
          if Fields.TryGetFieldIndex('REQUETE_SELECTION', idx) then RequeteSelection := Fields.ByNameAsString['REQUETE_SELECTION'];
          ProcedureCreation := Fields.ByNameAsString['PROCEDURE_CREATION'];

          CompleterTraitement(Fields);
        end;
      FTraitements.Add(lTraitement);
      Next;
    end;

    Close(etmCommit);
  end;
end;

procedure TfrModule.InitialisationAffichage;
var
  i, lIntNbOcc : Integer;

  function StrToDateTime(v : OleVariant) : TDateTime;
  var
    d : TDateTime;
  begin
    TryStrToDateTime(v, d);
    Result := d;
  end;

begin
  lIntNbOcc := FTraitements.Count - 1;
  for i := 0 to lIntNbOcc do
    with TTraitement(FTraitements[i]), TTraitement(FTraitements[i]).AffichageResultat do
      with FModule.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes[LowerCase(TModule.LibelleTypeModule[FModule.TypeModule])].ChildNodes['resultats'].ChildNodes[LowerCase(StringReplace(Libelle, ' ', '_', [rfReplaceAll]))] do
      begin
        // Chargement des données
        if HasAttribute('fichier_present') then FichierPresent := Attributes['fichier_present'];
        if HasAttribute('succes') then Succes := Attributes['succes'];
        if HasAttribute('avertissements') then Rejets := Attributes['avertissements'];
        if HasAttribute('rejets') then Rejets := Attributes['rejets'];
        if HasAttribute('erreurs') then Erreurs := Attributes['erreurs'];
        if HasAttribute('fait') then Fait := Attributes['fait'];
        if HasAttribute('debut') then Debut := StrToDateTime(Attributes['debut']);
        if HasAttribute('fin') then Fin := StrToDateTime(Attributes['fin']);
      end;

   OnResize(Self);
end;

procedure TfrModule.TraiterToutesLesDonnees;
var
  i : Integer;
begin
  if not FConnecte then
    Connecter;

  if FConnecte then
  begin
    FAnnulation := False; FTraitementAutomatique := True;
    rmnDonnees.Enabled := False; Annulation := False;
    wzDonnees.SelectFirstPage;

    i := 0;
    while (i < wzDonnees.PageCount) and not Annulation do
    begin
      if (wzDonnees.Pages[i].Tag = 0) and wzDonnees.Pages[i].Enabled then
        wzDonnees.ActivePage := wzDonnees.Pages[i];
      Inc(i);
    end;
    rmnDonnees.Enabled := True;
    FTraitementAutomatique := False;

    if not FAnnulation then
    begin
      if FileExists(FModule.Projet.RepertoireApplication + 'alerte.wav') then
        PlaySound(PChar(FModule.Projet.RepertoireApplication + 'alerte.wav'), 0, SND_ASYNC or SND_FILENAME);
      MessageDlg(TModule.LibelleTypeModule[FModule.TypeModule] + ' terminé !', mtInformation, [mbOk], 0);
    end;
    FAnnulation := False;
  end;
end;

procedure TfrModule.vstMAJModuleFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  lp : PrecMAJ;
begin
  lp := vstMAJModule.GetNodeData(Node);
  if Assigned(lp) then
    with lp^ do
    begin
      NumeroVersion := 0;
      DateDiffusion := 0;
      Contenu := '';
    end;
end;

procedure TfrModule.vstMAJModuleGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  lp : PrecMAJ;
begin
  lp := vstMAJModule.GetNodeData(Node);
  case Column of
    C_COLONNE_NUMERO_VERSION : CellText := IntToStr(lp^.NumeroVersion);
    C_COLONNE_DATE_DIFFUSION : CellText := FormatDateTime('DD/MM/YYYY', lp^.DateDiffusion);
    C_COLONNE_CONTENU : CellText := lp^.Contenu;
  end;
end;

destructor TfrModule.Destroy;
var
  i, lIntNbOcc : Integer;
  lNoeudResultats : IXMLNode;
begin
  Deconnecter;

  if Assigned(FTimerInactivite) then
    FreeAndNil(FTimerInactivite);

  // Sauvegarde des résultats d'import
  if Assigned(FTraitements) then
  begin
    if FModule.Projet.Ouvert then
    begin
      lNoeudResultats := FModule.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes[LowerCase(TModule.LibelleTypeModule[FModule.TypeModule])].ChildNodes['resultats'];
      with lNoeudResultats do
      begin
        lIntNbOcc := Traitements.Count - 1;
        for i := 0 to lIntNbOcc do
          with ChildNodes[LowerCase(StringReplace(Traitements[i].AffichageResultat.Libelle, ' ', '_', [rfReplaceAll]))] do
          begin
            Attributes['fichier_present'] := Ord(Traitements[i].FichierPresent);
            Attributes['succes'] := Traitements[i].Succes;
            Attributes['avertissements'] := Traitements[i].Avertissements;
            Attributes['rejets'] := Traitements[i].Rejets;
            Attributes['erreurs'] := Traitements[i].Erreurs;
            Attributes['debut'] := FormatDateTime('YYYY/MM/DD hh:nn:ss', Traitements[i].Debut);
            Attributes['fin'] := FormatDateTime('YYYY/MM/DD hh:nn:ss', Traitements[i].Fin);
            Attributes['fait'] := Ord(Traitements[i].Fait);
          end;
      end;

      FModule.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes[LowerCase(TModule.LibelleTypeModule[FModule.TypeModule])].Attributes['mode'] := Ord(Mode);
    end;

    FreeAndNil(FTraitements);
  end;

  if Assigned(FPHA) then FreeAndNil(FPHA);

  inherited;
end;

procedure TfrModule.wzDonneesActivePageChanged(Sender: TObject);
var
  lBoolReset : Boolean;
  cip: String;
begin
  if Assigned(FModule) and FModule.Projet.Ouvert then
  begin
    AfficherTraitements;

    // Lancement du traitements associé à la page
    if (FModule.Projet.ModuleImport.IHM as TfrModule).EnTraitement or
       (FModule.Projet.ModuleTransfert.IHM as TfrModule).EnTraitement then
      MessageDlg('Impossible de lancer un traitement pendant l''éxécution d''un autre !', mtWarning, [mbOk], 0)
    else
    begin
      lBoolReset := not Assigned(Sender);
      case wzDonnees.ActivePageIndex of
        C_INDEX_PAGE_PRATICIENS : TraiterDonnees(wzDonnees.ActivePage, grdPraticiens, lBoolReset, TPIList<Integer>.Create([Ord(suppPraticiens)]), TraiterDonneesPraticiens);
        C_INDEX_PAGE_ORGANISMES : TraiterDonnees(wzDonnees.ActivePage, grdOrganismes, lBoolReset, TPIList<Integer>.Create([Ord(suppOrganismes)]), TraiterDonneesOrganismes);
        C_INDEX_PAGE_CLIENTS : TraiterDonnees(wzDonnees.ActivePage, grdClients, lBoolReset, TPIList<Integer>.Create([Ord(suppEnCours), Ord(SuppCarteFidelite), Ord(suppHistoriques), Ord(suppClients)]), TraiterDonneesClients);
        C_INDEX_PAGE_PRODUITS : TraiterDonnees(wzDonnees.ActivePage, grdProduits, lBoolReset, TPIList<Integer>.Create([Ord(suppEnCours), Ord(SuppCarteFidelite), Ord(suppHistoriques), Ord(suppProduits)]), TraiterDonneesProduits);
        C_INDEX_PAGE_ENCOURS : TraiterDonnees(wzDonnees.ActivePage, grdEnCours, lBoolReset, TPIList<Integer>.Create([Ord(suppEnCours)]), TraiterDonneesEnCours);
        C_INDEX_PAGE_AUTRES_DONNEES : TraiterDonnees(wzDonnees.ActivePage, grdAutresDonnees, lBoolReset, TPIList<Integer>.Create([Ord(suppParametre), Ord(SuppCarteFidelite), Ord(suppHistoriques)]), TraiterAutresDonnees);
      else
        if wzDonnees.ActivePageIndex = wzDonnees.PageCount - 1 then
        begin
          with prRecapitulatif do
          begin
            BeginDoc;
            Print(prpRecapitulatif);
            EndDoc;
          end;

          if MessageDlg('Transmettre les tables de correspondance à Giphar ? Ne cliquez sur OUI que s''il s''agit d''une pharma Giphar et du transfert définitif.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
            PHA.DeconnexionBD;
            cip := Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['acces_base'].Attributes['cip'];
            if ((cip = '9999999') or (IsCharAlpha(cip[1])))
              then ShowMessage('Le CIP semble être celui d''une machine de test. Le transfert des tables de correspondance ne sera pas effectué')
              else ShellExecute(0, 'open', PChar('"'+Module.Projet.RepertoireApplication+'\extractCorr.bat"'),PChar('"'+Module.Projet.RepertoireApplication+'" "'+Module.Projet.RepertoireProjet+'" "'+cip+'"'), nil, SW_SHOW);

            PHA.ConnexionBD;
            end;
          if MessageDlg('Imprimez le récapitulatif ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            if ShellExecute(Application.MainForm.Handle, 'print', PChar(prRecapitulatif.FileName), nil, PChar(FModule.Projet.RepertoireProjet), SW_SHOWNORMAL) <= 32 then
              MessageDlg('Le récapitulatif du traitement des données ' + UpperCase(FModule.NomModule) + ' n''a pu être imprimée !'#13#10 +
                         'Erreur ' + IntToStr(GetLastError) + ' - ' + SysErrorMessage(GetLastError) + #13#10#13#10 +
                         'Le fichier "' + prRecapitulatif.FileName + '" a cependant été généré.',
                         mtError, [mbOk], 0);
          end;
      end;
    end;
  end;
end;

procedure TfrModule.FaireApresTraiterDonnees;
begin
  with Module.Projet.FichierProjet do SaveToFile(FileName);
  if Assigned(FSurApresTraiterDonnees) then
    FSurApresTraiterDonnees(Self, FResultat);
end;

function TfrModule.FaireTraitementDonnees(
  ADonnees: TFields): TResultatCreationDonnees;
begin
  with TTraitementBD(TraitementEnCours) do
    Result := FPHA.ExecuterPS(Fichier, ProcedureCreation, ADonnees);
end;

procedure TfrModule.FinTraitement(ADataSet: TDataSet);
begin
  FPHA.DePreparerCreationDonnees(FResultat <> rcdErreurSysteme);
  if ADataSet.Active then
    ADataSet.Close;
  if Assigned(TraitementEnCours) then
    TraitementEnCours.Fait := (FResultat <> rcdErreurSysteme) and not Annulation;
end;

procedure TfrModule.TraiterDonnee(ATraitement: TTraitement);
begin
   if not Annulation and FConnecte then
   begin
     FTraitement := ATraitement;
     if FTraitement.TypeTraitement = ttProcedure then
       FTraitement.Fait := not (FPHA.ExecuterPS('TRAITEMENT_' + Module.NomModule, FTraitement.Fichier, null, True, etmCommit) in [rcdErreur, rcdErreurSysteme])
   end
   else
     Exit;
end;

procedure TfrModule.TraiterDonnee(ATraitement: TTraitement;
  ADataSet: TDataSet);
begin
  if not FConnecte then
    Connecter;

  if not Annulation and FConnecte then
  begin
    try
      TraitementEnCours := ATraitement;
      TraitementEnCours.Fait := False;

      ADataSet.Open;
      ADataSet.First;
      while not ADataSet.Eof and not Annulation do
      begin
         FResultat := FaireTraitementDonnees(ADataSet.Fields);
        case FResultat of
          rcdImportee, rcdTransferee : TraitementEnCours.Succes := TraitementEnCours.Succes + 1;
          rcdAvertissement : TraitementEnCours.Avertissements := TraitementEnCours.Avertissements + 1;
          rcdRejetee : TraitementEnCours.Rejets := TraitementEnCours.Rejets + 1;
          rcdErreur : TraitementEnCours.Erreurs := TraitementEnCours.Erreurs + 1;
        else
          Abort;
        end;

        if ADataSet.RecNo mod 20000 = 0 then
          FPHA.DePreparerCreationDonnees(True);

        ADataSet.Next;
      end;
    except
      on E:Exception do
      begin
        Module.Projet.Console.AjouterLigne(ATraitement.Fichier + ' : ' + E.Message);
        FResultat := rcdErreurSysteme;
      end;
    end;
    FinTraitement(ADataSet);
  end;
end;

procedure TfrModule.TraiterDonnees(APage: TJvWizardCustomPage;
  AGrille: TStringGrid; AReset : Boolean; ADonneesASupprimees: TList<Integer>;
  AProcedureTraitement: TProcedureTraitement);

  function VerifierDonneesTraitees : Boolean;
  var
    i : Integer;
  begin
    i := 1; Result := True;
    while (i < AGrille.RowCount) and Result do
      if Assigned(AGrille.Objects[0, i]) then
        if not TTraitement(AGrille.Objects[0, i]).Fait then
          Result := False
        else
          Inc(i)
      else
        Inc(i);
  end;

  procedure LancerTraitement;
  var
    i : Integer;
  begin
    if not FConnecte then
      Connecter;

    if FConnecte then
    begin
      if FMode = mtNormal then
        FPHA.SupprimerDonnees(ADonneesASupprimees);
      FreeAndNil(ADonneesASupprimees);

      // Initilisation
      for i := 1 to AGrille.RowCount - 1 do
        if Assigned(AGrille.Objects[0, i]) then
          TTraitement(AGrille.Objects[0, i]).InitialisationResultat;

      // Avant
      if Assigned(FSurAvantTraiterDonnees) then
        FSurAvantTraiterDonnees(Self);

      // Pendant
      if not FTraitementAutomatique then
        Annulation := False;
      EnTraitement := True;
      FResultat := rcdErreur;
      AProcedureTraitement;

      // Mise à jour de la version
      Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes[LowerCase(TModule.LibelleTypeModule[Module.TypeModule])].Attributes['version'] := Module.Version;

      EnTraitement := False;
      if not FTraitementAutomatique then
        Annulation := False;

      // Apres
      FaireApresTraiterDonnees;
    end
    else
      MessageDlg('Impossible de traiter les ' + LowerCase(APage.Caption) + ' sans être connecté à la source de données !', mtError, [mbOk], 0);
  end;

begin
  if AReset or not rmnDonnees.Enabled then
    LancerTraitement
  else
    if not VerifierDonneesTraitees and not EnTraitement then
    begin
      if MessageDlg(TModule.LibelleTypeModule[FModule.TypeModule] + ' des ' + LowerCase(APage.Caption) + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        LancerTraitement;
    end;
end;

procedure TfrModule.Show;
begin
  inherited;

  FSecInactivite := 0;
  // rendre le timer d'inactivité paramétrable .....

  if FMinimize then
     FTimerInactivite.Enabled := True;


  Enabled := True;

  BringToFront;

  AfficherTraitements;
  FrameResize(Self);
end;

procedure TfrModule.PagePrecSuiv(Sender: TObject; var Stop: Boolean);
begin
  Stop := not rmnDonnees.Enabled;
end;

procedure TfrModule.ParametrerAccesBD(AInitialisation: Boolean);
var
  i : TfrmConnexionServeurClasse;
begin
  if not Assigned(FInterfaceConnexion) then
    i := TfrmConnexionServeur
  else
    i := FInterfaceConnexion;

  RenvoyerParametresConnexion;
  if AInitialisation then
    with i.Create(Self, Module) do
    begin
      if ShowModal(FPHA.ParametresConnexion) = mrOk then
      begin
        StockerParametresConnexion;
        if MessageDlg('Voulez-vous vous (re)connecter ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          Connecter;
      end;

      Free;
    end
end;

procedure TfrModule.SurAlarmeInactivite(Sender: TObject);
begin
  Inc(FSecInactivite);
  if (FSecInactivite = C_PERIODE_INACTIVITE) and FEnTraitement then
    Application.Minimize;
end;

function TfrModule.RenvoyerClasseTraitement: TClasseTraitement;
begin
  if FModeConnexion = mcDirecte then
    Result := TTraitement
  else Result := TTraitementBD;
end;

procedure TfrModule.Hide;
begin
  inherited;
  
  TimerInactivite.Enabled := False;
  Enabled := False;
end;

procedure TfrModule.SetMode(const Value: TModeTraitement);
begin
  if Value in FModesGeres then
    FMode := Value;
end;

procedure TfrModule.SetTraitementEnCours(const Value: TTraitement);
begin
  FTraitement := Value;
  FTraitement.Debut := Now;
end;

procedure TfrModule.wzDonneesHelpButtonClick(Sender: TObject;
  var Stop : Boolean);
begin
  PostMessage(Application.MainForm.Handle, CM_MODULE_AIDE, wzDonnees.ActivePageIndex, 0);
end;

procedure TfrModule.xpbTraitementsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lItem : TJvXPBarItem;
  lGrille : TStringGrid;
  lSuppression : TList<Integer>;
  i : Integer;
  t : TTraitement;
begin
  inherited;

  if Y > 6 then
  begin
    with xpbTraitements do
    begin
      i := (Y-7) div ItemHeight;
      if i < Items.Count then
        lItem := Items[i]
      else
        lItem := nil;
    end;


    if Assigned(lItem) then
    begin
      with wzDonnees.ActivePage do
        lGrille := TStringGrid(FindChildControl('grd' + RightStr(Name, Length(Name) - 3)));

      if Assigned(lGrille) then
      begin
        if not FConnecte then Connecter;
        if FConnecte then
          if lItem.Tag = 0 then
          begin
            if MessageDlg('Suppression des ' + LowerCase(wzDonnees.ActivePage.Caption) + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
              lSuppression := TPIList<Integer>.Create([lGrille.Tag]);
              FPHA.SupprimerDonnees(lSuppression);
              for i := 1 to lGrille.RowCount - 1 do
                if Assigned(lGrille.Objects[0, i]) then
                  TTraitement(lGrille.Objects[0, i]).InitialisationResultat;
              FreeAndNil(lSuppression);
            end
          end
          else
          begin
            FEnTraitement := True;
            t := TTraitement(lGrille.Objects[0, lItem.Tag]);
            t.InitialisationResultat;
            TraiterDonnee(t);
            FEnTraitement := False;
            Annulation := False;
          end;
      end;
    end;
  end;
end;

{ TTraitements }

procedure TTraitements.Add(ATraitement: TTraitement);
var
  i : Integer;
begin
  i := 0;
  while (i < Count) do
    with TTraitement(Items[i]).AffichageResultat do
      if (Libelle = ATraitement.AffichageResultat.Libelle) or
         ((Grille = ATraitement.AffichageResultat.Grille) and (Ligne = ATraitement.AffichageResultat.Ligne)) then
        raise ETraitements.Create('Mauvaise définition de traitement !')
      else
        Inc(i);

  inherited Add(ATraitement);
end;

function TTraitements.GetItem(Index: Integer): TTraitement;
begin
  Result := inherited GetItem(Index) as TTraitement;
end;

function TTraitements.GetTraitement(
  AFichier: string): TTraitement;
var
  i : Integer;
begin
  i := 0; Result := nil;
  while not Assigned(Result) and (i < Count) do
    if TTraitement(Items[i]).Fichier = AFichier then
    begin
      Result := TTraitement(Items[i]);
      Result.AffichageResultat.Grille.Row := Result.AffichageResultat.Ligne;
    end
    else
      Inc(i);

  if not Assigned(Result) then
    raise Exception.Create('Traitement ' + AFichier + ' introuvable !');
end;

procedure TfrModule.FrameMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Application.MainForm.Tag = 0 then
    FSecInactivite := 0;
end;

procedure TfrModule.wipRecapitulatifEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
const
  C_HAUTEUR_LABEL = 19;
  C_LARGEUR_LIBELLE = 378;
var
  i, lIntTotal : Integer;
  lCouleur : TColor;
begin
  i := 0;
  while i < prlpRecapitulatif.ControlCount - 2 do
    if prlpRecapitulatif.Controls[i].Tag = 0 then
      prlpRecapitulatif.Controls[i].Free
    else
      Inc(i);

  for i := 0 to FTraitements.Count - 1 do
    with FTraitements[i] do
    begin
      lIntTotal := Succes + Erreurs + Rejets;
      if lIntTotal > 0 then
        if ((Rejets + Erreurs) / lIntTotal) * 100 > 10 then
          lCouleur := clRed
        else
          lCouleur := clWindowText
      else
        lCouleur := clWindowText;

      with TPRLabel.Create(Self) do
      begin
        Parent := prlpRecapitulatif;
        SetBounds(0, 48 + (i * C_HAUTEUR_LABEL) + 4, C_LARGEUR_LIBELLE, C_HAUTEUR_LABEL);
        Caption := FTraitements[i].AffichageResultat.Libelle;
        FontColor := lCouleur;
        Printable := True;
      end;

      with TPRLabel.Create(Self) do
      begin
        Parent := prlpRecapitulatif;
        SetBounds(prlImportees.Left, 48 + (i * C_HAUTEUR_LABEL) + 4, prlImportees.Width, C_HAUTEUR_LABEL);
        Caption := IntToStr(FTraitements[i].Succes);
        FontColor := lCouleur;
        FontBold := True;
        Alignment := taCenter;
      end;

      with TPRLabel.Create(Self) do
      begin
        Parent := prlpRecapitulatif;
        SetBounds(prlRejetees.Left, 48 + (i * C_HAUTEUR_LABEL) + 4, prlRejetees.Width, C_HAUTEUR_LABEL);
        Caption := IntToStr(FTraitements[i].Rejets);
        FontColor := lCouleur;                           
        FontBold := True;
        Alignment := taCenter;
      end;

      with TPRLabel.Create(Self) do
      begin
        Parent := prlpRecapitulatif;
        SetBounds(prlNonImportees.Left, 48 + (i * C_HAUTEUR_LABEL) + 4, prlNonImportees.Width, C_HAUTEUR_LABEL);
        Caption := IntToStr(FTraitements[i].Erreurs);
        FontColor := lCouleur;
        FontBold := True;
        Alignment := taCenter;
      end;

      with TPRRect.Create(Self) do
      begin
        Parent := prlpRecapitulatif;
        SetBounds(0, 48 + ((i + 1) * C_HAUTEUR_LABEL), prlpRecapitulatif.Width, 1);
      end;
    end;
end;

procedure TfrModule.sbxRecapitulatifResize(Sender: TObject);
begin
  prpRecapitulatif.Width := sbxRecapitulatif.Width - 20;
  prlImportees.Left := prpRecapitulatif.Width - 301;
  prlRejetees.Left := prpRecapitulatif.Width - 229;
  prlNonImportees.Left := prpRecapitulatif.Width - 161;

  wipRecapitulatifEnterPage(Self, wipRecapitulatif);
end;

procedure TfrModule.GrilleDblClick(Sender: TObject);
begin
  with (Sender as TStringGrid) do
    FModule.Projet.AfficherErreurs(FModule.TypeModule, TTraitement(Objects[Col, Row]).Fichier);
end;

procedure TfrModule.FrameResize(Sender: TObject);
var
  i : Integer;

  procedure AppliquerStyle(AGrille : TPIStringGrid);
  begin
    if FModeConnexion <> mcDirecte then
    begin
      AGrille.Colonnes[C_COLONNE_REJETS].Largeur := 0;
      AGrille.Colonnes[C_COLONNE_FICHIER_PRESENT].Largeur := 0;
    end
    else
    begin
      AGrille.Colonnes[C_COLONNE_REJETS].Largeur := 75;
      AGrille.Colonnes[C_COLONNE_FICHIER_PRESENT].Largeur := 85;
    end;

    AGrille.Width := AGrille.Parent.ClientWidth;
    AGrille.Colonnes[0].Indicateur := True;
    AGrille.Colonnes[C_COLONNE_LIBELLE].Largeur := 195;
    AGrille.Colonnes[C_COLONNE_LIBELLE].Controle := ccAucun;
    AGrille.Colonnes[C_COLONNE_FICHIER_PRESENT].Controle := ccCheckBox;
    AGrille.Colonnes[C_COLONNE_SUCCES].Largeur := 75;
    AGrille.Colonnes[C_COLONNE_SUCCES].Controle := ccPerso;
    AGrille.Colonnes[C_COLONNE_AVERTISSEMENT].Largeur := 75;
    AGrille.Colonnes[C_COLONNE_AVERTISSEMENT].Controle := ccPerso;
    AGrille.Colonnes[C_COLONNE_REJETS].Controle := ccPerso;
    AGrille.Colonnes[C_COLONNE_ERREURS].Largeur := 75;
    AGrille.Colonnes[C_COLONNE_ERREURS].Controle := ccPerso;
    AGrille.Colonnes[C_COLONNE_DEBUT].Largeur := 140;
    AGrille.Colonnes[C_COLONNE_DEBUT].Controle := ccPerso;
    AGrille.Colonnes[C_COLONNE_DEBUT].Alignement := taCenter;
    AGrille.Colonnes[C_COLONNE_FIN].Largeur := 140;
    AGrille.Colonnes[C_COLONNE_FIN].Controle := ccPerso;
    AGrille.Colonnes[C_COLONNE_FIN].Alignement := taCenter;
    AGrille.Colonnes[C_COLONNE_FAIT].Largeur := 50;
    AGrille.Colonnes[C_COLONNE_FAIT].Controle := ccCheckBox;

    AGrille.Invalidate;
    //AGrille.AjusterLargeurColonnes;
  end;

begin
  // Grille
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TPIStringGrid then
      AppliquerStyle(TPIStringGrid(Components[i]));
end;

procedure TfrModule.wzDonneesActivePageChanging(Sender: TObject;
  var ToPage: TJvWizardCustomPage);
begin
  if EnTraitement then
    ToPage := wzDonnees.ActivePage
end;

function TTraitements.GetTraitementParGrille(AGrille: string;
  ALigne: Integer): TTraitement;
var
  i : Integer;
begin
  i := 0; Result := nil;
  while not Assigned(Result) and (i < Count) do
    if (UpperCase(TTraitement(Items[i]).AffichageResultat.Grille.Name) = UpperCase(AGrille)) and
       (TTraitement(Items[i]).AffichageResultat.Ligne = ALigne) then
    begin
      Result := TTraitement(Items[i]);
      Result.AffichageResultat.Grille.Row := Result.AffichageResultat.Ligne;
    end
    else
      Inc(i);

  if not Assigned(Result) then
    raise Exception.Create('Traitement ' + AGrille + '/' + IntToStr(ALigne) + ' introuvable !');
end;

procedure TfrModule.actAccesBDConnexionExecute(Sender: TObject);
begin
  Connecter;
end;

procedure TfrModule.actAccesBDDeconnexionExecute(Sender: TObject);
begin
  Deconnecter;
end;

procedure TfrModule.actAccesBDParametresExecute(Sender: TObject);
begin
  ParametrerAccesBD(True);
end;

end.
