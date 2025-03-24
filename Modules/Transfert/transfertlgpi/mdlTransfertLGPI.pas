unit mdlTransfertLGPI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, StrUtils,
  Dialogs, IniFiles, StdCtrls, Buttons, DB, ExtCtrls, Grids, uib, uibase,
  ComCtrls, mdlProjet, mdlModule, ActnList, JvXPBar, ImgList,
  PdfDoc, PReport, Menus, JvMenus, mdlPIPanel, JvXPCore, JvXPContainer, mdlLectureFichierBinaire,
  JvWizard, JvWizardRouteMapNodes, mdlPIStringGrid, JvExControls, UIBLib, SynHighlighterSQL,
  mdlModuleImport, Ora, OraError, mdlTypes, XMLIntf, mdlModuleTransfert, mdlModuleTransfertPHA,
  VirtualTrees, JvExExtCtrls, JvNetscapeSplitter, IdURI, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, JclPeImage, JclStrings, Sockets ;

type
  TdmTransfertLGPIPHA = class(TdmModuleTransfertPHA)
    procedure frTransfertLGPIPHA_AvantSelectionDonnees(Sender : TObject; ATraitement : TTraitement);
  public
    constructor Create(AOwner : TComponent; AModule : TModule); override;
  end;

  TfrTransfertLGPI = class(TfrModuleTransfert)
    wipProgrammesFidelites: TJvWizardInteriorPage;
    grdProgrammesFidelites: TPIStringGrid;
    actAccesLGPIEtatFusion: TAction;
    idHttp1: TIdHTTP;
    procedure wzDonneesActivePageChanged(Sender: TObject);
    procedure actAccesLGPIEtatFusionExecute(Sender: TObject);
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
    procedure TraiterProgrammesFidelites;
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; AModule: TModule); override;
  end;

const
  C_INDEX_PAGE_PROGRAMMES_FIDELITES = 7;

var
  frTransfertLGPI : TfrTransfertLGPI;
  reponse, url, etape, message_jet, serveur : string;
  httpCode : integer;
implementation

uses mdlTransfertLGPIConfiguration, mdlEtatFusion;

{$R *.dfm}
{$R logo.res}

{ TfrTransfertLGPI }


procedure TfrTransfertLGPI.actAccesLGPIEtatFusionExecute(Sender: TObject);
begin
  inherited;

  TfrmEtatFusion.Create(Self, Module.Projet).ShowModal;
end;

constructor TfrTransfertLGPI.Create(AOwner: TComponent; AModule: TModule);
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

procedure TfrTransfertLGPI.frModuleTransfert_SurConnecter(Sender: TObject);
begin
  inherited;

  actAccesLGPIEtatFusion.Enabled := TdmModuleTransfertPHA(PHA).dbLGPI.Connected;
end;

procedure TfrTransfertLGPI.frModuleTransfert_SurDeConnecter(Sender: TObject);
begin
  inherited;

  actAccesLGPIEtatFusion.Enabled := TdmModuleTransfertPHA(PHA).dbLGPI.Connected;
end;

procedure TfrTransfertLGPI.TraiterDonneesPraticiens;
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

procedure TfrTransfertLGPI.TraiterDonneesOrganismes;
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

procedure TfrTransfertLGPI.TraiterDonneesClients;
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

procedure TfrTransfertLGPI.TraiterDonneesProduits;
var
  lBoolOptionStup : boolean ;
begin
  inherited;

    with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['options'].ChildNodes['sv140'] do
       lBoolOptionStup :=  Attributes['deconditionnement_stup'] = '1' ;


  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['DEPOTS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['FOURNISSEURS DIRECTS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['REPARTITEURS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CODIFICATIONS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['ZONES GEOGRAPHIQUES']));
  {if ( dmModuleTransfertPHA.versionLGPI >= '2.31' ) then
    TraiterDonnee(TTraitementTransfert(Traitements.Traitements['REMISES ARTICLES']));}
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PRODUITS']));
  if lBoolOptionStup then
  begin
      TraiterDonnee(TTraitementTransfert(Traitements.Traitements['DECONDITIONNEMENT STUP']));
  end;  
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['STOCKS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['HISTORIQUES VENTES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CODES EAN13']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CODES LPP']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CATALOGUES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['CLASSIF FOURNISSEURS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['LIGNES CATALOGUES']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['HISTO STOCK FOURNISSEURS']));

  dmModuleTransfertPHA.ExecuterPS('CREATION DICTIONNAIRE BDM', 'pk_produits.maj_dictionnaire', nil, True, True);



end;

procedure TfrTransfertLGPI.TraiterDonneesEncours;
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

procedure TfrTransfertLGPI.TraiterAutresDonnees;
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

procedure TfrTransfertLGPI.TraiterProgrammesFidelites;
var serveur, reponse : string;
begin
  inherited;

  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROGRAMMES AVANTAGE']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROGRAMMES AVANTAGE CLIENTS']));
  TraiterDonnee(TTraitementTransfert(Traitements.Traitements['PROGRAMMES AVANTAGE PRODUITS']));

  if ( dmModuleTransfertPHA.versionLGPI >= '2.6' ) then
    if TraitementAutomatique then
    begin
      etape := 'Fin ';
      reponse := IdHTTP1.get(TIDUri.UrlEncode(url+etape+message_jet));
      if (reponse = 'OK') then
        Module.Projet.Console.AjouterLigne('Evenement 210 créé dans le JET : '+reponse)
      else
        MessageDlg('Impossible de finaliser le transfert, impossible de creer l evenement dans le JET !'#13#10#13#10'Message : ' + reponse,
                       mtError, [mbOk], 0);
    end;
end;

procedure TfrTransfertLGPI.wzDonneesActivePageChanged(Sender: TObject);

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

{ TdmTransfertLGPIPHA }

constructor TdmTransfertLGPIPHA.Create(AOwner: TComponent; AModule : TModule);
begin
  inherited;

  SurAvantSelectionDonnees := frTransfertLGPIPHA_AvantSelectionDonnees;
end;

procedure TdmTransfertLGPIPHA.frTransfertLGPIPHA_AvantSelectionDonnees(
  Sender: TObject; ATraitement : TTraitement);
begin
  with dbLGPI.SQL do
  begin
      SQL.Clear;

      SQL.Add('declare');
      SQL.Add('  lOpt pk_commun.rec_options;');
      SQL.Add('begin');
      SQL.Add('  lOpt.hopitaux_creer_si_inexistant := :AHOPITAUXCREERSIINEXISTANT;');
      SQL.Add('  lOpt.praticiens_creer_si_inexistant := :APRATICIENSCREERSIINEXISTANT;');
      SQL.Add('  lOpt.produits_fusionner_stock := :APRODUISTFUSIONNERSTOCK;');
      SQL.Add('  lOpt.produits_ecraser_prix := :APRODUITSECRASERPRIX;');
      SQL.Add('  lOpt.progr_relationnel_id := :APROGRAMMERELATIONNEL;');
      SQL.Add('  pk_commun.initialiser_transfert(lOpt, :AMODE, :ASUPPRESSIONTABLETMP);');
      SQL.Add('end;');

      try
        with Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['options'].ChildNodes['fusion'] do
        begin
          ParamByName('AHOPITAUXCREERSIINEXISTANT').AsString := Attributes['creation_hopitaux_non_reconnus'];
          ParamByName('APRATICIENSCREERSIINEXISTANT').AsString := Attributes['creation_praticiens_non_reconnus'];
          ParamByName('APRODUISTFUSIONNERSTOCK').AsString := Attributes['fusion_stock'];
          ParamByName('APRODUITSECRASERPRIX').AsString := Attributes['ecraser_prix'];
        end;
        ParamByName('APROGRAMMERELATIONNEL').AsInteger := StrToInt(Module.Projet.FichierProjet.DocumentElement.ChildNodes['modules'].ChildNodes['transfert'].ChildNodes['options'].Attributes['programme_relationnel']);
        ParamByName('AMODE').AsInteger := Ord((Module.IHM as TfrModule).Mode);
        ParamByName('ASUPPRESSIONTABLETMP').AsString := IfThen((ATraitement.Fichier = 'CLIENTS') or (ATraitement.Fichier = 'PRODUITS'), '1', '0');
        Execute;
      except
        on E:EOraError do
        begin
          FBaseAlteree := True;
          MessageDlg('Impossible de continuer le transfert, base altérée !'#13#10#13#10'Message : ' + E.Message,
                     mtError, [mbOk], 0);
        end;

        on E:Exception do
          raise;
      end;
    end;
end;



initialization
  RegisterClasses([TfrTransfertLGPI, TdmTransfertLGPIPHA, TfrTransfertLGPIConfiguration]);

finalization
  UnRegisterClasses([TfrTransfertLGPI, TdmTransfertLGPIPHA, TfrTransfertLGPIConfiguration]);

end.


