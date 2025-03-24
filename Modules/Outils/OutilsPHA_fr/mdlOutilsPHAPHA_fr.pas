unit mdlOutilsPHAPHA_fr;

interface

uses
  SysUtils, Classes, DB, mdlModuleOutils, mdlProjet, uib, uibdataset,
  Menus, JvMenus, mydbunit, fbcustomdataset, StrUtils, mdlPIImpression,
  Provider, DBClient;

type
  TdmOutilsPHAPHA_fr = class(TdmModuleOutils)
    setOrganismesAMC: TUIBDataSet;
    sp: TUIBQuery;
    setOrganismesAMCAORGANISMEAMCID: TWideStringField;
    setOrganismesAMCANOM: TWideStringField;
    setOrganismesAMCANOMREDUIT: TWideStringField;
    setOrganismesAMCAIDENTIFIANTNATIONAL: TWideStringField;
    setOrganismesAMCACODEPOSTALVILLE: TWideStringField;
    setOrganismesAMCACOMMENTAIRE: TWideStringField;
    setClients: TUIBDataSet;
    setClientsANOM: TWideStringField;
    setClientsAPRENOM: TWideStringField;
    setClientsANUMEROINSEE: TWideStringField;
    setClientsADATEDERNIEREVISITE: TDateField;
    setProduits: TUIBDataSet;
    setProduitsACODECIP: TWideStringField;
    setProduitsADESIGNATION: TWideStringField;
    setProduitsAPRIXACHATCATALOGUE: TUIBBCDField;
    setProduitsAPRIXVENTE: TUIBBCDField;
    setProduitsAPAMP: TUIBBCDField;
    setProduitsAPRESTATION: TWideStringField;
    setProduitsADATEDERNIEREVENTE: TDateField;
    setProduitsASTOCKTOTAL: TIntegerField;
    setFournisseursDirect: TFBDataSet;
    setFournisseursDirectLIBELLE: TFBAnsiField;
    trAnnexe: TUIBTransaction;
    setFournisseursDirectID: TIntegerField;
    trDataset: TUIBTransaction;
    trSP: TUIBTransaction;
    setRepartiteur: TFBDataSet;
    setRepartiteurT_REPARTITEUR_ID: TFBAnsiField;
    setRepartiteurRAISON_SOCIALE: TFBAnsiField;
    setRepartiteurDEFAUT: TStringField;
    setRepartiteurIDENTIFIANT_171: TFBAnsiField;
    setRepartiteurCODE_POSTAL_VILLE: TFBAnsiField;
    setProduitsAFOURNISSEUR: TWideStringField;
    setProduitsAREPARTITEUR: TWideStringField;
    setProduitsAPRIXACHATREMISE: TUIBBCDField;
    setProduitsATYPEHOMEO: TWideStringField;
    setAuditHomeoCIP: TUIBDataSet;
    setAuditHomeoFD: TUIBDataSet;
    setFournisseursDirectNOMBRE_PRODUITS: TIntegerField;
    setAuditHomeoCIPCIP_1: TWideStringField;
    setAuditHomeoCIPTYPE_HOMEO: TWideStringField;
    setAuditHomeoCIPTOTAL: TIntegerField;
    setAuditHomeoFDRAISON_SOCIALE: TWideStringField;
    setAuditHomeoFDTOTAL: TIntegerField;
    setAuditHomeoFDTYPE_HOMEO: TWideStringField;
    setOrganismes: TFBDataSet;
    setOrganismesT_ORGANISME_ID: TFBAnsiField;
    setOrganismesTYPE_ORGANISME: TFBAnsiField;
    setOrganismesNOM: TFBAnsiField;
    setOrganismesIDENTIFIANT_NATIONAL: TFBAnsiField;
    setOrganismesCODE_POSTAL_VILLE: TFBAnsiField;
    setOrganismesDESTINATAIRE: TFBAnsiField;
    setOrganismesT_DESTINATAIRE_ID: TFBAnsiField;
    setDestinataires: TFBDataSet;
    setDestinatairesID: TFBAnsiField;
    setDestinatairesLIBELLE: TFBAnsiField;
    setOrganismesORG_SANTE_PHARMA: TStringField;
    setDepartements: TFBDataSet;
    StringField1: TFBAnsiField;
    StringField2: TFBAnsiField;
    setClientsACLIENTID: TWideStringField;
    setProduitsAPRODUITID: TWideStringField;
    setHistoriques: TUIBDataSet;
    setHistoriquesANUMEROFACTURE: TLargeintField;
    setHistoriquesADATEACTE: TDateField;
    setHistoriquesADATEPRESCRIPTION: TDateField;
    setHistoriquesANOMCLIENT: TWideStringField;
    setHistoriquesAPRENOMCLIENT: TWideStringField;
    setInventaire: TUIBDataSet;
    setInventaireTAUX_TVA: TUIBBCDField;
    setInventaireTOTAL_PRIX_ACHAT_CATALOGUE: TUIBBCDField;
    setInventaireTOTAL_PRIX_VENTE: TUIBBCDField;
    setInventaireTOTAL_PAMP: TUIBBCDField;
    setInventaireNB_PRODUITS: TLargeintField;
    setInventaireNB_UNITES: TLargeintField;
    impDonnees: TPIImpression;
    setOrganismesAMCARUE1: TWideStringField;
    setOrganismesAMCARUE2: TWideStringField;
    setCredits: TClientDataSet;
    setEncours: TUIBDataSet;
    setEncoursT_CLIENT_ID: TWideStringField;
    setEncoursNOM_CLIENT: TWideStringField;
    setEncoursPRENOM_CLIENT: TWideStringField;
    setEncoursT_CREDIT_ID: TIntegerField;
    setEncoursMONTANT_CREDIT: TUIBBCDField;
    setEncoursDATE_CREDIT: TDateField;
    setEncoursT_VIGNETTE_AVANCEE_ID: TIntegerField;
    setEncoursCODE_CIP_AVANCE: TWideStringField;
    setEncoursQUANTITE_AVANCEE: TIntegerField;
    setEncoursDATE_AVANCE: TDateField;
    setEncoursT_FACTURE_ATTENTE_ID: TWideStringField;
    setEncoursDATE_FACTURE: TDateField;
    setEncoursT_PRODUIT_DU_ID: TWideStringField;
    setEncoursCODE_CIP_DU: TWideStringField;
    setEncoursQUANTITE_DU: TIntegerField;
    setEncoursDATE_DU: TDateField;
    setCreditsT_CLIENT_ID: TWideStringField;
    setCreditsNOM_CLIENT: TWideStringField;
    setCreditsPRENOM_CLIENT: TWideStringField;
    setCreditsT_CREDIT_ID: TIntegerField;
    setCreditsMONTANT_CREDIT: TBCDField;
    setCreditsDATE_CREDIT: TDateField;
    setVignettes: TClientDataSet;
    setVignettesT_VIGNETTE_AVANCEE_ID: TIntegerField;
    setVignettesCODE_CIP_AVANCE: TWideStringField;
    setVignettesQUANTITE_AVANCEE: TIntegerField;
    setVignettesDATE_AVANCE: TDateField;
    setFactures: TClientDataSet;
    setFacturesT_FACTURE_ATTENTE_ID: TWideStringField;
    setFacturesDATE_FACTURE: TDateField;
    setProduitsDus: TClientDataSet;
    setProduitsDusT_PRODUIT_DU_ID: TWideStringField;
    setProduitsDusCODE_CIP_DU: TWideStringField;
    setProduitsDusQUANTITE_DU: TIntegerField;
    setProduitsDusDATE_DU: TDateField;
    SetPraticiens: TUIBDataSet;
    SetPraticiensAPRATICIENID: TWideStringField;
    SetPraticiensANOM: TWideStringField;
    SetPraticiensAPRENOM: TWideStringField;
    SetPraticiensANOFINESS: TWideStringField;
    SetPraticiensANumRPPS: TWideStringField;
    setPraticiensADATEDERNIEREPRESCRIPTION: TDateField;
    setHistoriquesAPURGECLIENT: TWideStringField;
    setCommandes: TUIBDataSet;
    setCommandesACOMMANDEID: TWideStringField;
    setCommandesADATECOMMANDE: TDateField;
    setCommandesADATERECEPTION: TDateField;
    setCommandesANOMFOURNISSEUR: TWideStringField;
    setCommandesAMONTANT: TUIBBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure setRepartiteurAfterPost(DataSet: TDataSet);
    procedure trDatasetEndTransaction(Sender: TObject;
      var Mode: TEndTransMode);
    procedure setRepartiteurAfterOpen(DataSet: TDataSet);
    procedure setRepartiteurBeforeClose(DataSet: TDataSet);
    procedure setOrganismesAfterPost(DataSet: TDataSet);
    procedure setOrganismesAfterOpen(DataSet: TDataSet);
    procedure setEncoursAfterOpen(DataSet: TDataSet);
  private
    { Déclarations privées }
    FChangementRepDefaut: Boolean;
    FRepartiteurDefaut: TBookMark;
    FChangementOrganismes: Boolean;
  public
    { Déclarations publiques }
    property ChangementRepDefaut : Boolean read FChangementRepDefaut;
    property ChangementOrganismes : Boolean read FChangementOrganismes;
    property RepartiteurDefaut : TBookMark read FRepartiteurDefaut;
 end;

const
  C_PARAMETRE_PURGE_DONNEES = 0;
  C_PARAMETRE_PURGE_TYPE = 1;
  C_PARAMETRE_PURGE_PARAMETRE = 2;
  C_PARAMETRE_PURGE_RESET = 3;

  C_PARAMETRE_PURGE_DONNEES_RESTANTES = 0;
  C_PARAMETRE_PURGE_DONNEES_SUPPRIMEES = 1;

var
  dmOutilsPHAPHA_fr: TdmOutilsPHAPHA_fr;

implementation

{$R *.dfm}

procedure TdmOutilsPHAPHA_fr.DataModuleCreate(Sender: TObject);
begin
  inherited;

  trSP.Database := Projet.PHAConnexion;
  sp.DataBase := Projet.PHAConnexion;

  trDataset.DataBase := Projet.PHAConnexion;
  setClients.Database := Projet.PHAConnexion;
  setOrganismesAMC.Database := Projet.PHAConnexion;
  setPraticiens.Database := Projet.PHAConnexion;
  setProduits.Database := Projet.PHAConnexion;
  setRepartiteur.Database := Projet.PHAConnexion;
  setAuditHomeoCIP.Database := Projet.PHAConnexion;
  setAuditHomeoFD.Database := Projet.PHAConnexion;
  setOrganismes.Database := Projet.PHAConnexion;
  setInventaire.Database := Projet.PHAConnexion;
  setEncours.Database := Projet.PHAConnexion;

  trAnnexe.Database := Projet.PHAConnexion;
  setFournisseursDirect.Database := Projet.PHAConnexion;
  setDestinataires.Database := Projet.PHAConnexion;
end;

procedure TdmOutilsPHAPHA_fr.setRepartiteurAfterPost(
  DataSet: TDataSet);
var
  lNouveauRepDefaut : TBookMark;
begin
  inherited;

  if not FChangementRepDefaut then FChangementRepDefaut := True;

  if setRepartiteurDEFAUT.AsString = '1' then
  begin
    if Assigned(FRepartiteurDefaut) then
    begin
      lNouveauRepDefaut := setRepartiteur.GetBookmark;

      setRepartiteur.DisableControls;
      setRepartiteur.GotoBookmark(FRepartiteurDefaut);
      setRepartiteur.Refresh;
      setRepartiteur.GotoBookmark(lNouveauRepDefaut);
      setRepartiteur.EnableControls;

      FRepartiteurDefaut := lNouveauRepDefaut;
    end;
  end;
end;

procedure TdmOutilsPHAPHA_fr.trDatasetEndTransaction(Sender: TObject;
  var Mode: TEndTransMode);
begin
  inherited;

  FChangementRepDefaut := False;
  FChangementOrganismes := False;
end;

procedure TdmOutilsPHAPHA_fr.setRepartiteurAfterOpen(
  DataSet: TDataSet);
begin
  inherited;

  FChangementRepDefaut := False;
  FRepartiteurDefaut := nil;
  with setRepartiteur do
  begin
    // Recherche du rép. par défaut
    DisableControls;
    First;

    while not Eof and not Assigned(FRepartiteurDefaut) do
    begin
      if setRepartiteurDEFAUT.AsString = '1' then
        FRepartiteurDefaut := GetBookmark;

      Next;
    end;

    First;
    EnableControls;
  end;
end;

procedure TdmOutilsPHAPHA_fr.setRepartiteurBeforeClose(
  DataSet: TDataSet);
begin
  inherited;

  setRepartiteur.FreeBookmark(FRepartiteurDefaut);
end;

procedure TdmOutilsPHAPHA_fr.setOrganismesAfterPost(DataSet: TDataSet);
begin
  inherited;

  if not FChangementOrganismes then FChangementOrganismes := True;
end;

procedure TdmOutilsPHAPHA_fr.setEncoursAfterOpen(DataSet: TDataSet);
begin
  inherited;

  setCredits.Close; setVignettes.Close; setFactures.Close; setProduitsDus.Close;
  setCredits.CreateDataSet; setVignettes.CreateDataSet; setFactures.CreateDataSet; setProduitsDus.CreateDataSet;
  setCredits.DisableControls; setVignettes.DisableControls; setFactures.DisableControls; setProduitsDus.DisableControls;
  while not setEncours.Eof do
  begin
    if not setEncoursT_CREDIT_ID.IsNull then
      setCredits.InsertRecord([setEncoursT_CLIENT_ID.Value, setEncoursNOM_CLIENT.Value, setEncoursPRENOM_CLIENT.Value,
                               setEncoursT_CREDIT_ID.Value, setEncoursMONTANT_CREDIT.Value, setEncoursDATE_CREDIT.Value])
    else if not setEncoursT_VIGNETTE_AVANCEE_ID.IsNull then
      setVignettes.InsertRecord([setEncoursT_CLIENT_ID.Value, setEncoursNOM_CLIENT.Value, setEncoursPRENOM_CLIENT.Value,
                                 setEncoursT_VIGNETTE_AVANCEE_ID.Value, setEncoursCODE_CIP_AVANCE.Value, setEncoursQUANTITE_AVANCEE.Value,  setEncoursDATE_AVANCE.Value])
    else if not setEncoursT_FACTURE_ATTENTE_ID.IsNull then
      setFactures.InsertRecord([setEncoursT_CLIENT_ID.Value, setEncoursNOM_CLIENT.Value, setEncoursPRENOM_CLIENT.Value,
                                setEncoursT_FACTURE_ATTENTE_ID.Value, setEncoursDATE_FACTURE.Value])
    else if not setEncoursT_PRODUIT_DU_ID.IsNull then
      setProduitsDus.InsertRecord([setEncoursT_CLIENT_ID.Value, setEncoursNOM_CLIENT.Value, setEncoursPRENOM_CLIENT.Value,
                                setEncoursT_PRODUIT_DU_ID.Value, setEncoursCODE_CIP_DU.Value, setEncoursQUANTITE_DU.Value,  setEncoursDATE_DU.Value]);
    setEncours.Next;
  end;
  setCredits.First; setVignettes.First; setFactures.First; setProduitsDus.First;
  setCredits.EnableControls; setVignettes.EnableControls; setFactures.EnableControls; setProduitsDus.EnableControls;
  setEncours.Close;
end;

procedure TdmOutilsPHAPHA_fr.setOrganismesAfterOpen(DataSet: TDataSet);
begin
  inherited;

  FChangementOrganismes := False;
end;

end.


