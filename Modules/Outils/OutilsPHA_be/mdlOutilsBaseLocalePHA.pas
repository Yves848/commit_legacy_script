unit mdlOutilsBaseLocalePHA;

interface

uses
  SysUtils, Classes, DB, mdlModuleOutils, mdlProjet, uib, uibdataset,
  Menus, JvMenus, mydbunit, fbcustomdataset, StrUtils, mdlPIImpression;

type
  TdmOutilsBaseLocalePHA = class(TdmModuleOutils)
    setOrganismesAMC: TUIBDataSet;
    sp: TUIBQuery;
    setOrganismesAMCAORGANISMEAMCID: TStringField;
    setOrganismesAMCANOM: TStringField;
    setOrganismesAMCANOMREDUIT: TStringField;
    setOrganismesAMCAIDENTIFIANTNATIONAL: TStringField;
    setOrganismesAMCACODEPOSTALVILLE: TStringField;
    setOrganismesAMCACOMMENTAIRE: TStringField;
    setClients: TUIBDataSet;
    setClientsANOM: TStringField;
    setClientsAPRENOM: TStringField;
    setClientsANUMEROINSEE: TStringField;
    setClientsADATEDERNIEREVISITE: TDateField;
    setProduits: TUIBDataSet;
    setProduitsACODECIP: TStringField;
    setProduitsADESIGNATION: TStringField;
    setProduitsAPRIXACHATCATALOGUE: TUIBBCDField;
    setProduitsAPRIXVENTE: TUIBBCDField;
    setProduitsAPAMP: TUIBBCDField;
    setProduitsAPRESTATION: TStringField;
    setProduitsADATEDERNIEREVENTE: TDateField;
    setProduitsASTOCKTOTAL: TIntegerField;
    setFournisseursDirect: TFBDataSet;
    setFournisseursDirectLIBELLE: TStringField;
    trAnnexe: TUIBTransaction;
    setFournisseursDirectID: TStringField;
    trDataset: TUIBTransaction;
    trSP: TUIBTransaction;
    setRepartiteur: TFBDataSet;
    setRepartiteurT_REPARTITEUR_ID: TStringField;
    setRepartiteurRAISON_SOCIALE: TStringField;
    setRepartiteurDEFAUT: TStringField;
    setRepartiteurIDENTIFIANT_171: TStringField;
    setRepartiteurCODE_POSTAL_VILLE: TStringField;
    setProduitsAFOURNISSEUR: TStringField;
    setProduitsAREPARTITEUR: TStringField;
    setProduitsAPRIXACHATREMISE: TUIBBCDField;
    setProduitsATYPEHOMEO: TStringField;
    setAuditHomeoCIP: TUIBDataSet;
    setAuditHomeoFD: TUIBDataSet;
    setFournisseursDirectNOMBRE_PRODUITS: TIntegerField;
    setAuditHomeoCIPCIP_1: TStringField;
    setAuditHomeoCIPTYPE_HOMEO: TStringField;
    setAuditHomeoCIPTOTAL: TIntegerField;
    setAuditHomeoFDRAISON_SOCIALE: TStringField;
    setAuditHomeoFDTOTAL: TIntegerField;
    setAuditHomeoFDTYPE_HOMEO: TStringField;
    setOrganismes: TFBDataSet;
    setOrganismesT_ORGANISME_ID: TStringField;
    setOrganismesTYPE_ORGANISME: TStringField;
    setOrganismesNOM: TStringField;
    setOrganismesIDENTIFIANT_NATIONAL: TStringField;
    setOrganismesCODE_POSTAL_VILLE: TStringField;
    setOrganismesDESTINATAIRE: TStringField;
    setOrganismesT_DESTINATAIRE_ID: TStringField;
    setDestinataires: TFBDataSet;
    setDestinatairesID: TStringField;
    setDestinatairesLIBELLE: TStringField;
    setOrganismesORG_SANTE_PHARMA: TStringField;
    setDepartements: TFBDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    setClientsACLIENTID: TStringField;
    setProduitsAPRODUITID: TStringField;
    setHistoriques: TUIBDataSet;
    setHistoriquesANUMEROFACTURE: TLargeintField;
    setHistoriquesADATEACTE: TDateField;
    setHistoriquesADATEPRESCRIPTION: TDateField;
    setHistoriquesANOMCLIENT: TStringField;
    setHistoriquesAPRENOMCLIENT: TStringField;
    setHistoriquesACODECIP: TStringField;
    setHistoriquesADESIGNATION: TStringField;
    setHistoriquesAQUANTITEFACTUREE: TIntegerField;
    setInventaire: TUIBDataSet;
    setInventaireTAUX_TVA: TUIBBCDField;
    setInventaireTOTAL_PRIX_ACHAT_CATALOGUE: TUIBBCDField;
    setInventaireTOTAL_PRIX_VENTE: TUIBBCDField;
    setInventaireTOTAL_PAMP: TUIBBCDField;
    setInventaireNB_PRODUITS: TLargeintField;
    setInventaireNB_UNITES: TLargeintField;
    impDonnees: TPIImpression;
    setOrganismesAMCARUE1: TStringField;
    setOrganismesAMCARUE2: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure setRepartiteurAfterPost(DataSet: TDataSet);
    procedure trDatasetEndTransaction(Sender: TObject;
      var Mode: TEndTransMode);
    procedure setRepartiteurAfterOpen(DataSet: TDataSet);
    procedure setRepartiteurBeforeClose(DataSet: TDataSet);
    procedure setOrganismesAfterPost(DataSet: TDataSet);
    procedure setOrganismesAfterOpen(DataSet: TDataSet);
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
  dmOutilsBaseLocalePHA: TdmOutilsBaseLocalePHA;

implementation

{$R *.dfm}

procedure TdmOutilsBaseLocalePHA.DataModuleCreate(Sender: TObject);
begin
  inherited;

  trSP.Database := Projet.PHAConnexion;
  sp.DataBase := Projet.PHAConnexion;

  trDataset.DataBase := Projet.PHAConnexion;
  setClients.Database := Projet.PHAConnexion;
  setOrganismesAMC.Database := Projet.PHAConnexion;
  setProduits.Database := Projet.PHAConnexion;
  setRepartiteur.Database := Projet.PHAConnexion;
  setAuditHomeoCIP.Database := Projet.PHAConnexion;
  setAuditHomeoFD.Database := Projet.PHAConnexion;
  setOrganismes.Database := Projet.PHAConnexion;
  setInventaire.Database := Projet.PHAConnexion;

  trAnnexe.Database := Projet.PHAConnexion;
  setFournisseursDirect.Database := Projet.PHAConnexion;
  setDestinataires.Database := Projet.PHAConnexion;
end;

procedure TdmOutilsBaseLocalePHA.setRepartiteurAfterPost(
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

procedure TdmOutilsBaseLocalePHA.trDatasetEndTransaction(Sender: TObject;
  var Mode: TEndTransMode);
begin
  inherited;

  FChangementRepDefaut := False;
  FChangementOrganismes := False;
end;

procedure TdmOutilsBaseLocalePHA.setRepartiteurAfterOpen(
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

procedure TdmOutilsBaseLocalePHA.setRepartiteurBeforeClose(
  DataSet: TDataSet);
begin
  inherited;

  setRepartiteur.FreeBookmark(FRepartiteurDefaut);
end;

procedure TdmOutilsBaseLocalePHA.setOrganismesAfterPost(DataSet: TDataSet);
begin
  inherited;

  if not FChangementOrganismes then FChangementOrganismes := True;
end;

procedure TdmOutilsBaseLocalePHA.setOrganismesAfterOpen(DataSet: TDataSet);
begin
  inherited;

  FChangementOrganismes := False;
end;

end.


