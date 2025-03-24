unit mdlModuleTransfertyzy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, IniFiles, StdCtrls, Buttons, DB, ExtCtrls, Grids, uib, uibase, mdlODACThread,
  ComCtrls, mdlProjet, mdlModule, ActnList, JvXPBar, ImgList, mdlAttente,
  PdfDoc, PReport, Menus, JvMenus, mdlPIPanel, JvXPCore, JvXPContainer, mdlLectureFichierBinaire,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, JvExControls, uibLib, SynHighlighterSQL,
  mdlModuleImport, Ora, mdlTypes, XMLIntf, Generics.Collections, mdlModuleTransfertPHAyzy,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, Math, Sockets, uYZYRecords;

type
  TfrModuleTransfertyzy = class(TfrModule)
    xpbKitMigration: TJvXPBar;
    actKitMigrationVisualisation: TAction;
    actKitMigrationInstallation: TAction;
    actAccesLGPIInitialisation: TAction;
    bvlSeparateur_3: TBevel;
    actKitMigrationAfficherErreurs: TAction;
    procedure actKitMigrationInstallationExecute(Sender: TObject);
    procedure actAccesLGPIInitialisationExecute(Sender: TObject);
    procedure wzDonneesActivePageChanged(Sender: TObject);
    procedure GrilleSurAppliquerProprietesCellule(Sender: TObject; ACol,
      ALig: Integer; ARect: TRect; var AFond: TColor; APolice: TFont;
      var AAlignement: TAlignment; AEtat: TGridDrawState);
    procedure actAccesBDParametresExecute(Sender: TObject);
  private
    { Déclarations privées }
//    function VerifierTables : Boolean;
  protected
    procedure SetMode(const Value: TModeTraitement); override;
    procedure RenvoyerParametresConnexion; override;
    procedure StockerParametresConnexion; override;
    function RenvoyerClasseTraitement: TClasseTraitement; override;
    procedure TraiterDonnee(ATraitement: TTraitement); override;
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
    destructor destroy; reintroduce;
    procedure Connecter; override;
  end;

const
  C_INDEX_PAGE_CARTES_FIDELITES = 7;

var
  frModuleTransfertyzy : TfrModuleTransfertyzy;

implementation
{$R *.dfm}

{ TfrModuleTransfert }


procedure TfrModuleTransfertyzy.GrilleSurAppliquerProprietesCellule(
  Sender: TObject; ACol, ALig: Integer; ARect: TRect; var AFond: TColor;
  APolice: TFont; var AAlignement: TAlignment; AEtat: TGridDrawState);
var
  t : TTraitementTransfert;
begin
  inherited;

  if ALig > 0 then

  with (Sender as TPIStringGrid) do
  begin
    t := TTraitementTransfert(Objects[0, ALig]);
   
    if Assigned(t) then
    begin
      if (Mode = mtFusion) and not t.Fusion and ((t.TypeTraitement <> ttProcedure) or (t.Fichier = 'pk_autres_donnees.completer_histo_client')) then
      begin
        APolice.Style := APolice.Style + [fsItalic, fsStrikeOut];
        APolice.Color := clInactiveCaption;
      end
    end;
  end;
end;

procedure TfrModuleTransfertyzy.Connecter;
begin

  if PHA.ParametresConnexion.Values['utilisateur'] = '' then
  begin
    PHA.ParametresConnexion.Values['utilisateur'] := 'migration';
    PHA.ParametresConnexion.Values['mot_de_passe'] := 'migration';
  end;

  inherited;
end;

constructor TfrModuleTransfertyzy.Create(AOwner: TComponent; AModule: TModule);
begin
//  FInterfaceConnexion := TfrmModuleTrasfertConnexion;
  ModeConnexion := mcDirecte;

  inherited;

end;

destructor TfrModuleTransfertyzy.destroy;
begin
  dmModuleTransfertPHAyzy.FreeYzyDll;
  inherited;
end;

procedure TfrModuleTransfertyzy.TraiterAutresDonnees;
begin
  inherited;

//  if VerifierTables then Exit;
end;

procedure TfrModuleTransfertyzy.TraiterDonnee(ATraitement: TTraitement);
const
  C_LIGNES_A_TRANSFERER = 50000;
var
  log : TYZYLog;
  lIntNbLignes : Integer;
  i, lIntNbBoucle : Integer;
  sql, sqlSkip : string;
begin

     Module.Projet.Console.AjouterLigne(ATraitement.Fichier);
     Module.Projet.Console.AjouterLigne('Transfert vers YZY : ' + ATraitement.Fichier);
     dmModuleTransfertPHAyzy.TransfertProduits;
     log.sType := etInfo;
     log.sMessage := 'Trasfert Produit effectue';
     dmModuleTransfertPHAyzy.YZYLogger(log);
end;

procedure TfrModuleTransfertyzy.TraiterDonneesClients;
begin
  inherited;

//  if VerifierTables then Exit;
end;

procedure TfrModuleTransfertyzy.TraiterDonneesEncours;
begin
  inherited;

//  if VerifierTables then Exit;
end;

procedure TfrModuleTransfertyzy.TraiterDonneesOrganismes;
begin
  inherited;

//  if VerifierTables then Exit;
end;

procedure TfrModuleTransfertyzy.TraiterDonneesPraticiens;
begin
  inherited;

//  if VerifierTables then Exit;
end;

procedure TfrModuleTransfertyzy.TraiterDonneesProduits;
begin
  inherited;

//  if VerifierTables then Exit;
end;

//function TfrModuleTransfertyzy.VerifierTables : Boolean;
//const
//  C_NB_ENREG_TABLES = '%s : %d enregistrement(s)'#13#10;
//var
//  g : TStringGrid;
//  i, j: Integer;
//  t : TTraitementTransfert;
//  ko : Boolean;
//  msg : string;
//  p : TPair<string, Integer>;
//begin
//  if not (Mode in [mtMAJ, mtFusion]) and not TraitementAutomatique then
//  begin
//    i := 0; g := nil;
//    with wzDonnees.ActivePage do
//      while (i < ControlCount) and not Assigned(g) do
//        if Controls[i] is TStringGrid then
//          g := Controls[i] as TStringGrid
//        else
//          Inc(i);
//
//    if Assigned(g) then
//    begin
//      ko := True;
//      for i := 0 to Traitements.Count - 1 do
//      begin
//        t := Traitements[i] as TTraitementTransfert;
//        if (t.AffichageResultat.Grille = g) and (t.TablesAVerifier.Count > 0) then
//        begin
//          dmModuleTransfertPHAyzy.VerifierTables(t.TablesAVerifier);
//          if ko then
//            for j in t.TablesAVerifier.Values do
//              ko := ko and (j = 0);
//        end;
//      end;
//
//
//      if not ko then
//      begin
//        msg := 'Certaines tables de la base de transfert ne sont pas vides :'#13#10#13#10;
//        for i := 0 to Traitements.Count - 1 do
//        begin
//          t := Traitements[i] as TTraitementTransfert;
//          if (t.AffichageResultat.Grille = g) and (t.TablesAVerifier.Count > 0) then
//            for p in t.TablesAVerifier do
//              if p.Value > 0 then
//                msg := msg + Format(C_NB_ENREG_TABLES, [p.Key, p.Value]) + #13#10;
//        end;
//        msg := msg + #13#10'Voulez-vous continuer le transfert ?';
//        Result := MessageDlg(msg, mtWarning, [mbYes, mbNo], 0) = mrYes;
//      end
//      else
//        Result := True;
//    end
//    else
//      Result := False;
//  end
//  else
//    Result := True;
//end;

procedure TfrModuleTransfertyzy.wzDonneesActivePageChanged(Sender: TObject);
begin
  inherited;

  xpcOutils.Visible := wzDonnees.ActivePageIndex < wzDonnees.PageCount - 1;
end;

function TfrModuleTransfertyzy.RenvoyerClasseTraitement: TClasseTraitement;
begin
  Result := TTraitementTransfert;
end;

procedure TfrModuleTransfertyzy.RenvoyerParametresConnexion;
begin
  if PHA.ParametresConnexion.IndexOfName('serveur') = -1 then
    PHA.ParametresConnexion.Add('serveur=');
  if PHA.ParametresConnexion.IndexOfName('cip') = -1 then
    PHA.ParametresConnexion.Add('cip=');

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['acces_base'] do
  begin
    if HasAttribute('serveur') then
      PHA.ParametresConnexion.Values['serveur'] :=  Attributes['serveur']
    else
      PHA.ParametresConnexion.Values['serveur'] := '192.168.0.100';

    if HasAttribute('cip') then PHA.ParametresConnexion.Values['cip'] :=  Attributes['cip'] ;


  end;
end;

procedure TfrModuleTransfertyzy.StockerParametresConnexion;
begin
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['acces_base'] do
  begin
    Attributes['serveur'] := PHA.ParametresConnexion.Values['serveur'];
    Attributes['cip'] := PHA.ParametresConnexion.Values['cip'];
  end;
end;

procedure TfrModuleTransfertyzy.actKitMigrationInstallationExecute(Sender: TObject);
var
  lBoolDejaConnecte : Boolean;
  lStrScriptsSQL : string;
  lStrRepScriptSQL : string;
  lScriptSQL : TSearchRec;
  lBoolArret : Boolean;
begin
  inherited;

  //TODO recupere les infos de connexion AVANT

end;

procedure TfrModuleTransfertyzy.actAccesBDParametresExecute(Sender: TObject);
begin
  // remettre les login migration quand on ouvre la fenetre parametre
  //Module.Projet.ModuleTransfert.

  PHA.ParametresConnexion.Values['utilisateur'] := 'migration';
  PHA.ParametresConnexion.Values['mot_de_passe'] := 'migration';

  inherited;
end;

procedure TfrModuleTransfertyzy.actAccesLGPIInitialisationExecute(Sender: TObject);

  function OKPourInit : Boolean;
  begin
    if not dmModuleTransfertPHAyzy.dbLGPI.Connected then
    begin
      actAccesBDConnexion.Execute;
      Result := dmModuleTransfertPHAyzy.dbLGPI.Connected;
    end
    else
      Result := True;

    Result := Result and (MessageDlg('L''initialisation va supprimer toutes les données du serveur de transfert ! Voulez-vous continuer ?', mtWarning, [mbYes, mbNo], 0) = mrYes);
  end;

begin
  inherited;

  if  (Mode in [mtMAJ, mtFusion]) then
    showmessage('Initialisation non autorisée en mode Fusion ou Mise à jour ')
  else
    if OKPourInit  then
      dmModuleTransfertPHAyzy.InitialiserLGPI;
end;

procedure TfrModuleTransfertyzy.SetMode(const Value: TModeTraitement);
var
  i : Integer;
begin
  inherited;

  for i := 0 to wzDonnees.ActivePage.ControlCount - 1 do
    if wzDonnees.ActivePage.Controls[i] is TPIStringGrid then
      wzDonnees.ActivePage.Controls[i].Refresh;
end;

initialization
  RegisterClasses([TfrModuleTransfertyzy, TdmModuleTransfertPHAyzy]);

finalization
  UnRegisterClasses([TfrModuleTransfertyzy, TdmModuleTransfertPHAyzy]);

end.


