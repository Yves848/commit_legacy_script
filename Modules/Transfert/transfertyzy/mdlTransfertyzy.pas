unit mdlTransfertYZY;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, IniFiles, StdCtrls, Buttons, DB, ExtCtrls, Grids, uib, uibase,
  ComCtrls, mdlProjet, mdlModule, ActnList, JvXPBar, ImgList,
  PdfDoc, PReport, Menus, JvMenus, mdlPIPanel, JvXPCore, JvXPContainer, mdlLectureFichierBinaire,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, JvExControls, UIBLib, SynHighlighterSQL,
  mdlModuleImport, Ora, OraError, mdlTypes, XMLIntf, mdlModuleTransfertyzy, mdlModuleTransfertPHAyzy,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, IdURI, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, JclPeImage, JclStrings ;

type
  TdmTransfertYZYPHA = class(TdmModuleTransfertPHAyzy)
    procedure frTransfertYZYPHA_AvantSelectionDonnees(Sender : TObject; ATraitement : TTraitement);
  public
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

  TfrTransfertYZY = class(TfrModuleTransfertyzy)
    wipProgrammesFidelites: TJvWizardInteriorPage;
    grdProgrammesFidelites: TPIStringGrid;
    actAccesYZYEtatFusion: TAction;
    idHttp1: TIdHTTP;
    procedure wzDonneesActivePageChanged(Sender: TObject);
    procedure actAccesYZYEtatFusionExecute(Sender: TObject);
    procedure frModuleTransfert_SurConnecter(Sender : TObject);
    procedure frModuleTransfert_SurDeConnecter(Sender : TObject);
  private
    { Déclarations privées }
    versioncommit : string;
  protected
    procedure TraiterDonneesPraticiens; override;
    procedure TraiterDonneesOrganismes; override;
    procedure TraiterDonneesClients; override;
    procedure TraiterDonneesProduits; override;
    procedure TraiterDonneesEncours; override;
    procedure TraiterAutresDonnees; override;
    procedure TraiterDonnees(ATraitement: TTraitement); reintroduce;
    procedure TraiterProgrammesFidelites;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
    procedure Connecter; override;
  end;

const
  C_INDEX_PAGE_PROGRAMMES_FIDELITES = 7;

var
  frTransfertYZY : TfrTransfertYZY;
  reponse, url, etape, message_jet, serveur : string;
  httpCode : integer;
implementation

uses mdlTransfertYZYConfiguration, mdlEtatFusion;

{$R *.dfm}
{$R logo.res}

{ TfrTransfertYZY }


procedure TfrTransfertYZY.actAccesYZYEtatFusionExecute(Sender: TObject);
begin
  inherited;

  TfrmEtatFusion.Create(Self, Module.Projet).ShowModal;
end;

constructor TfrTransfertYZY.Create(AOwner: TComponent; AModule: TModule);
var
  info: TJclPeImage;
begin

  info := TJclPeImage.Create;
  info.FileName := ParamStr(0);
  with info do
  begin
    versioncommit := VersionInfo.FileVersion;
    Free;
  end;

  AModule.Logo.LoadFromResourceName(hInstance, 'LOGO');
  AModule.Icone.LoadFromResourceName(hInstance, 'ICONE');

  inherited;
  SurApresConnecter := nil;
  SurDeConnecter := nil;

  ModesGeres := [mtNormal, mtMAJ, mtFusion];

  grdPraticiens.Tag := Ord(suppPraticiens);
  grdOrganismes.Tag := Ord(suppOrganismes);
  grdClients.Tag := Ord(suppClients);
  grdProduits.Tag := Ord(suppProduits);
  grdAutresDonnees.Tag := Ord(suppHistoriques);
  grdEnCours.Tag := Ord(suppEnCours);
  grdProgrammesFidelites.Tag := Ord(suppCarteFidelite);  //laissé en carte fid car ça vient de mdlprojet

  wipProgrammesFidelites.PageIndex := wipRecapitulatif.PageIndex;
end;

procedure TfrTransfertYZY.frModuleTransfert_SurConnecter(Sender: TObject);
begin
  inherited;

  //actAccesYZYEtatFusion.Enabled := TdmModuleTransfertPHA(PHA).dbYZY.Connected;
end;

procedure TfrTransfertYZY.frModuleTransfert_SurDeConnecter(Sender: TObject);
begin
  inherited;

  //actAccesYZYEtatFusion.Enabled := TdmModuleTransfertPHA(PHA).dbYZY.Connected;
end;

procedure TfrTransfertYZY.TraiterDonneesPraticiens;
begin
  inherited;


  IdHTTP1.Request.BasicAuthentication := true;
  IdHTTP1.Request.Username := 'test';
  IdHTTP1.Request.Password := 'emu';
  IdHTTP1.Request.UserAgent := 'Commit4.8';
  IdHTTP1.Request.ContentType := 'application/x-www-form-urlencoded';

  with module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['acces_base'] do
    if Attributes['serveur'] <> '' then serveur := Attributes['serveur'];

  url := 'http://'+serveur+'/lgpi.query/rest/v1/nfcommit/sendjet/' ;
  message_jet := 'de transfert de données ';

  if (Mode = mtFusion) then
    message_jet := message_jet + 'fusion '
  else if(Mode = mtMAJ) then
    message_jet := message_jet + 'mise à jour '
  else
    message_jet := message_jet + 'standard ';

  message_jet := message_jet + ' origine : "' + Module.Projet.ModuleImport.NomModule + '" ';
  message_jet := message_jet + ' Commit version '+ versioncommit  ;
  message_jet := message_jet + ' module transfert version '+ Module.Projet.ModuleTransfert.Version  ;

  etape := 'Début ';
  reponse := IdHTTP1.get(TIDUri.UrlEncode(url+etape+message_jet));
  httpCode := IdHTTP1.ResponseCode;
  if (httpCode = 200) then
    Module.Projet.Console.AjouterLigne('Evenement 210 créé dans le JET : '+ message_jet +' ' +reponse)
  else
    MessageDlg('Impossible de continuer le transfert, impossible de creer l evenement dans le JET !'#13#10#13#10'Message : ' + reponse,
                       mtError, [mbOk], 0);

  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['HOPITAUX']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PRATICIENS']));
end;

procedure TfrTransfertYZY.TraiterDonneesOrganismes;
var
  lBoolConversion : Boolean;

  procedure AfficherDemandeConversion;
  begin
    EnTraitement := False; Annulation := True;
    lBoolConversion := MessageDlg('Vous devez avoir convertis les organismes et couvertures AMO/AMC avant de transférer les données organismes et/ou clients'#13#10 +
                                  'Voulez-vous retourner en conversions ?', mtWarning, [mbYes, mbNo], 0) = mrYes;
  end;

begin
  inherited;

  lBoolConversion := False;
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'] do
    if HasAttribute('date_conversions') then
      //if Attributes['date_conversions'] <> '' then
      begin
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['DESTINATAIRES']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['ORGANISMES']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['COUVERTURES AMC']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['TAUX PRISE EN CHARGE']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['pk_organismes.ajuster_couvertures_amc']));
      end
    //  else
    //    AfficherDemandeConversion                 DEBUGNF 525
    else
      AfficherDemandeConversion;


  if lBoolConversion then
  begin
    Module.Projet.ModuleEnCours := Module.Projet.ModuleImport;
    with (Module.Projet.ModuleImport.IHM as TfrModuleImport) do
      wzDonnees.ActivePage := wipConversions;
  end;
end;

procedure TfrTransfertYZY.TraiterDonneesClients;
var
  lBoolConversion : Boolean;

  procedure AfficherDemandeConversion;
  begin
    lBoolConversion := MessageDlg('Vous devez avoir convertis les organismes et couvertures AMO/AMC avant de transférer les données organismes et/ou clients'#13#10 +
                                  'Voulez-vous retourner en conversions ?', mtWarning, [mbYes, mbNo], 0) = mrYes;
  end;

begin
  inherited;

  lBoolConversion := False;
  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['informations_generales'] do
    if HasAttribute('date_conversions') then
    begin
      if Attributes['informations_generales'] <> '' then
      begin
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['REMISES FIXES']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROFILS DE REMISE']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CLIENTS']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['ASSURES RATTACHES']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['COUVERTURES CLIENTS']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['COMPTES']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['ADHERENTS COMPTES']));
        TraiterDonnee(TTraitementTransfert(Traitements.Traitements['MANDATAIRES']));

      end
      else
        AfficherDemandeConversion;
    end
    else
      AfficherDemandeConversion;

  if lBoolConversion then
  begin
    Module.Projet.ModuleEnCours := Module.Projet.ModuleImport;
    with (Module.Projet.ModuleImport.IHM as TfrModuleImport) do
      wzDonnees.ActivePage := wipConversions;
  end;
end;

procedure TfrTransfertYZY.TraiterDonneesProduits;
var
  lBoolOptionStup : boolean ;
begin
//  inherited;

    with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['options'].ChildNodes['sv140'] do
       lBoolOptionStup :=  Attributes['deconditionnement_stup'] = '1' ;


  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['DEPOTS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PRODUITS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['STOCKS']));

  dmModuleTransfertPHAyzy.ExecuterPS('CREATION DICTIONNAIRE BDM', 'pk_produits.maj_dictionnaire', nil, True, True);


//  if lBoolOptionStup then
//    begin
//      dmModuleTransfertPHAyzy.ExecuterPS('DECONDITIONNEMENT STUPEFIANTS', 'pk_produits.maj_produit_stup', nil, True, True);
//      dmModuleTransfertPHAyzy.ExecuterPS('DECONDITIONNEMENT STUPEFIANTS', 'pk_produits.maj_stock_stup', nil, True, True);
//    end
end;

procedure TfrTransfertYZY.TraiterDonneesEncours;
var
  lBoolOptionStup : boolean ;
begin
  inherited;

  with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['options'].ChildNodes['sv140'] do
       lBoolOptionStup :=  Attributes['deconditionnement_stup'] = '1' ;

  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['OPERATEURS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['VIGNETTES AVANCEES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CREDITS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PRODUITS DUS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PRODUITS DUS LIGNES']));
  //if lBoolOptionStup then
  //  dmModuleTransfertPHA.ExecuterPS('DECONDITIONNEMENT STUPEFIANTS', 'pk_encours.maj_produit_du_stup',nil, True, True);

  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['FACTURES ATTENTE']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['LIGNES FACTURES ATTENTE']));
end;

procedure TfrTransfertYZY.TraiterAutresDonnees;
var
  lBoolOptionStup : boolean ;
begin
  inherited;

  //with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['options'].ChildNodes['sv140'] do
  //     lBoolOptionStup :=  Attributes['deconditionnement_stup'] = '1' ;

  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PARAMETRES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['COMMENTAIRES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['HISTORIQUES CLIENTS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['LIGNES HISTORIQUES CLIENTS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['COMMANDES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['LIGNES COMMANDES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['pk_produits.maj_commandes']));

  //dmModuleTransfertPHA.ExecuterPS('HISTORIQUES ACHATS', 'pk_produits.maj_commandes', VarArrayOf([-1]), True, True);
 
  //Maj de qtevendue qui n'est pas transfèré donc maj_commande_stup ne sers plus à rien
  //if lBoolOptionStup then
  //  dmModuleTransfertPHA.ExecuterPS('DECONDITIONNEMENT STUPEFIANTS', 'pk_produits.maj_commande_stup', VarArrayOf([-1]), True, True);

  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROMOTIONS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROMOTIONS AVANTAGES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROMOTIONS PRODUITS']));
  if not TraitementAutomatique then
  begin
    TraiterDonnee(TTraitementTransfert(Traitements.Traitements['DOCUMENTS SCANNES']));
  end;
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['pk_autres_donnees.reactive_migration_muse']));

  //TraiterDonnee(TTraitementTransfert(Traitements.Traitements['pk_autres_donnees.completer_histo_client']));
end;

procedure TfrTransfertYZY.TraiterProgrammesFidelites;
var serveur, reponse : string;
begin
  inherited;


end;

procedure TfrTransfertYZY.wzDonneesActivePageChanged(Sender: TObject);

  // pages non traites en automatique Programmes Fidelites, location ...
  procedure TraiterDonnee;
  begin
     case wzDonnees.ActivePageIndex of
       C_INDEX_PAGE_PROGRAMMES_FIDELITES : TraiterProgrammesFidelites;
     end;
  end;

begin
  inherited;

  if Assigned(Module) and Module.Projet.Ouvert and (wzDonnees.ActivePageIndex >= C_INDEX_PAGE_PROGRAMMES_FIDELITES) and (wzDonnees.ActivePageIndex < wzDonnees.PageCount - 1) then
    if rmnDonnees.Enabled then
    begin
      if MessageDlg('Transférer les ' + LowerCase(wzDonnees.ActivePage.Caption) + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
         TraiterDonnee;
    end
    else
      TraiterDonnee;
end;

{ TdmTransfertYZYPHA }

constructor TdmTransfertYZYPHA.Create(AOwner: TComponent; AModule : TModule);
begin
  inherited;

  SurAvantSelectionDonnees := frTransfertYZYPHA_AvantSelectionDonnees;
end;

procedure TdmTransfertYZYPHA.frTransfertYZYPHA_AvantSelectionDonnees(
  Sender: TObject; ATraitement : TTraitement);
begin
      showmessage(ATraitement.Fichier);
end;

procedure TfrTransfertYZY.TraiterDonnees(ATraitement: TTraitement);
begin
     showmessage(ATraitement.Fichier);
end;

procedure TfrTransfertYZY.Connecter;
begin
    FConnecte := true;

end;

initialization
  RegisterClasses([TfrTransfertYZY, TdmTransfertYZYPHA, TfrTransfertYZYConfiguration]);

finalization
  UnRegisterClasses([TfrTransfertYZY, TdmTransfertYZYPHA, TfrTransfertYZYConfiguration]);

end.


