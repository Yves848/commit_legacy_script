unit mdlInfosoftPHA;

interface

uses
  SysUtils, Classes, DB, mdlPHA, Dialogs, UIBDataSet, UIB, UIBLib, JvComponent,
  Variants, mydbUnit, FBCustomDataSet, mdlModuleImportPHA, mdlInfosoftLectureFichier,
  mdlProjet, DateUtils, IniFiles, mdlAttente, mdlTypes, XMLIntf, StrUtils, Generics.Collections,
  mdlInfosoftMEDECINS, mdlInfosoftORGANISM, mdlInfosoftLABFOUR, mdlInfosoftPRODUITS, mdlInfosoftASSURE,
  mdlInfosoftLIBCREMB, mdlInfosoftCODEREMB, mdlInfosoftHISTO, mdlInfosoftCREDITS, mdlInfosoftAVANCESV,
  mdlInfosoftSCANCLT, mdlInfosoftCOMMANDE, mdlInfosoftPERSONEL ,mdlInfosoftMESSAGES;

type
  TdmInfosoftPHA = class(TdmModuleImportPHA)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Déclarations privées }
    FHistoriqueClient : THashedStringList;
    FClients: THashedStringList;
  public
    { Déclarations publiques }
    property Clients : THashedStringList read FClients;
    property HistoriqueClient : THashedStringList read FHistoriqueClient;
    function CreerDonnees(AMEDECIN : TMEDECINS) : TResultatCreationDonnees; overload;
    function CreerDonnees(AORGANISM : TORGANISM) : TResultatCreationDonnees; overload;
    function CreerDonnees(ALIBCREMB : TLIBCREMB) : TResultatCreationDonnees; overload;
    function CreerDonnees(ACODEREMB : TCODEREMB) : TResultatCreationDonnees; overload;
    function CreerDonnees(AASSURES : TASSURES) : TResultatCreationDonnees; overload;
    function CreerDonnees(ALABFOUR : TLABFOUR) : TResultatCreationDonnees; overload;
    function CreerDonnees(APRODUITS : TPRODUITS ) : TResultatCreationDonnees; overload;
    function CreerDonnees(AMESSAGES : TMESSAGES ) : TResultatCreationDonnees; overload;
    function CreerDonnees(AHISTO : THISTO ) : TResultatCreationDonnees; overload;
    function CreerDonnees(ACREDITS : TCREDITS) : TResultatCreationDonnees; overload;
    function CreerDonnees(AAVANCESV : TAVANCESV) : TResultatCreationDonnees; overload;
    function CreerDonnees(ASCANCLT : TSCANCLT) : TResultatCreationDonnees; overload;
    function CreerDonnees(ACOMMANDE_LST : TCOMMANDE_LST) : TResultatCreationDonnees; overload;
    function CreerDonnees(APERSONEL : TPERSONEL) : TResultatCreationDonnees; overload;
    procedure SupprimerDonnees(ADonneesASupprimer: TList<Integer>); override;
  end;

var
  dmInfosoftPHA : TdmInfosoftPHA;

implementation

uses Contnrs;

{$R *.dfm}

function TdmInfosoftPHA.CreerDonnees(
  AMEDECIN: TMEDECINS): TResultatCreationDonnees;
begin
  if AMEDECIN.NumeroFiness > 0 then
    Result := ExecuterPS('MEDECINS.DBI', 'PS_INFOSOFT_CREER_MEDECIN',
                         VarArrayOf([AMEDECIN.ID,
                                     AMEDECIN.NumeroFiness,
                                     AMEDECIN.Nom,
                                     AMEDECIN.Prenom,
                                     AMEDECIN.Specialite,
                                     AMEDECIN.Rue,
                                     AMEDECIN.CodePostal,
                                     AMEDECIN.NomVille,
                                     AMEDECIN.Telephone,
                                     AMEDECIN.Fax]))
  else
    Result := rcdRejetee;
end;

function TdmInfosoftPHA.CreerDonnees(
  AORGANISM: TORGANISM): TResultatCreationDonnees;
begin
  Result := ExecuterPS('ORGANISM.DBI', 'PS_INFOSOFT_CREER_ORGANISME',
                       VarArrayOf([AORGANISM.ID,
                                   AORGANISM.Nom,
                                   AORGANISM.Rue1,
                                   AORGANISM.Rue2,
                                   AORGANISM.CodePostal,
                                   AORGANISM.NomVille,
                                   AORGANISM.Telephone,
                                   AORGANISM.Fax,
                                   AORGANISM.IdentifiantNationalAMO,
                                   AORGANISM.IdentifiantNationalAMC,
                                   AORGANISM.TypeContrat]));
end;

function TdmInfosoftPHA.CreerDonnees(
  ALABFOUR: TLABFOUR): TResultatCreationDonnees;
begin
  if not ALABFOUR.supprime then
  Result := ExecuterPS('LABFOUR.DBI', 'PS_INFOSOFT_CREER_FOURNISSEUR',
                       VarArrayOf([ALABFOUR.Id,
                                   ALABFOUR.FlagG,
                                   ALABFOUR.RaisonSociale,
                                   ALABFOUR.Rue,
                                   ALABFOUR.CodePostal,
                                   ALABFOUR.Ville,
                                   ALABFOUR.Telephone,
                                   ALABFOUR.Fax,
                                   ALABFOUR.NumeroAppel,
                                   ALABFOUR.Id171,
                                   ALABFOUR.Nom_Contact,
                                   ALABFOUR.pharmaml_ref_id,
                                   ALABFOUR.pharmaml_url_1,
                                   ALABFOUR.pharmaml_url_2,
                                   ALABFOUR.pharmaml_id_officine,
                                   ALABFOUR.pharmaml_id_magasin,
                                   ALABFOUR.pharmaml_cle,
                                   ALABFOUR.email
                                   ]))
    else
        Result := rcdRejetee;


end;

function TdmInfosoftPHA.CreerDonnees(
  APRODUITS: TPRODUITS): TResultatCreationDonnees;
begin

if (not APRODUITS.Supprime) then
  Result := ExecuterPS('PRODUITS.DBI', 'PS_INFOSOFT_CREER_PRODUIT',
                       VarArrayOf([APRODUITS.Fichier.EnregNo,
                                   APRODUITS.CodeCip,
                                   APRODUITS.Designation,
                                   APRODUITS.CodeEan,
                                   APRODUITS.CodeTva,
                                   APRODUITS.liste,
                                   APRODUITS.CodeLabo,
                                   APRODUITS.Prestation,
                                   APRODUITS.BaseRemboursement,
                                   APRODUITS.PrixAchat,
                                   APRODUITS.PrixAchatRemise,
                                   APRODUITS.Pamp,
                                   APRODUITS.PrixVente,
                                   APRODUITS.DateDerniereVente,
                                   APRODUITS.zonegeo,
                                   APRODUITS.CodeTipsLpp,
                                   APRODUITS.stock,
                                   APRODUITS.stockMini,
                                   APRODUITS.stockMaxi,
                                   APRODUITS.Vente[0],
                                   APRODUITS.Vente[1],
                                   APRODUITS.Vente[2],
                                   APRODUITS.Vente[3],
                                   APRODUITS.Vente[4],
                                   APRODUITS.Vente[5],
                                   APRODUITS.Vente[6],
                                   APRODUITS.Vente[7],
                                   APRODUITS.Vente[8],
                                   APRODUITS.Vente[9],
                                   APRODUITS.Vente[10],
                                   APRODUITS.Vente[11],
                                   APRODUITS.Vente[12],
                                   APRODUITS.Vente[13],
                                   APRODUITS.Vente[14],
                                   APRODUITS.Vente[15],
                                   APRODUITS.Vente[16],
                                   APRODUITS.Vente[17],
                                   APRODUITS.Vente[18],
                                   APRODUITS.Vente[19],
                                   APRODUITS.Vente[20],
                                   APRODUITS.Vente[21],
                                   APRODUITS.Vente[22],
                                   APRODUITS.Vente[23],
                                   APRODUITS.Repartiteur,
                                   APRODUITS.AchatFournisseur[0],
                                   APRODUITS.AchatPrix[0],
                                   APRODUITS.AchatDate[0],
                                   APRODUITS.AchatQuantite[0],
                                   APRODUITS.AchatFournisseur[1],
                                   APRODUITS.AchatPrix[1],
                                   APRODUITS.AchatDate[1],
                                   APRODUITS.AchatQuantite[1],
                                   APRODUITS.AchatFournisseur[2],
                                   APRODUITS.AchatPrix[2],
                                   APRODUITS.AchatDate[2],
                                   APRODUITS.AchatQuantite[2],
                                   APRODUITS.AchatFournisseur[3],
                                   APRODUITS.AchatPrix[3],
                                   APRODUITS.AchatDate[3],
                                   APRODUITS.AchatQuantite[3],
                                   APRODUITS.AchatFournisseur[4],
                                   APRODUITS.AchatPrix[4],
                                   APRODUITS.AchatDate[4],
                                   APRODUITS.AchatQuantite[4],
                                   APRODUITS.AchatFournisseur[5],
                                   APRODUITS.AchatPrix[5],
                                   APRODUITS.AchatDate[5],
                                   APRODUITS.AchatQuantite[5],
                                   APRODUITS.AchatFournisseur[6],
                                   APRODUITS.AchatPrix[6],
                                   APRODUITS.AchatDate[6],
                                   APRODUITS.AchatQuantite[6],
                                   APRODUITS.AchatFournisseur[7],
                                   APRODUITS.AchatPrix[7],
                                   APRODUITS.AchatDate[7],
                                   APRODUITS.AchatQuantite[7],
                                   APRODUITS.AchatFournisseur[8],
                                   APRODUITS.AchatPrix[8],
                                   APRODUITS.AchatDate[8],
                                   APRODUITS.AchatQuantite[8],
                                   APRODUITS.AchatFournisseur[9],
                                   APRODUITS.AchatPrix[9],
                                   APRODUITS.AchatDate[9],
                                   APRODUITS.AchatQuantite[9],
                                   APRODUITS.AchatFournisseur[10],
                                   APRODUITS.AchatPrix[10],
                                   APRODUITS.AchatDate[10],
                                   APRODUITS.AchatQuantite[10],
                                   APRODUITS.AchatFournisseur[11],
                                   APRODUITS.AchatPrix[11],
                                   APRODUITS.AchatDate[11],
                                   APRODUITS.AchatQuantite[11],
                                   APRODUITS.AchatFournisseur[12],
                                   APRODUITS.AchatPrix[12],
                                   APRODUITS.AchatDate[12],
                                   APRODUITS.AchatQuantite[12],
                                   APRODUITS.AchatFournisseur[13],
                                   APRODUITS.AchatPrix[13],
                                   APRODUITS.AchatDate[13],
                                   APRODUITS.AchatQuantite[13],
                                   APRODUITS.AchatFournisseur[14],
                                   APRODUITS.AchatPrix[14],
                                   APRODUITS.AchatDate[14],
                                   APRODUITS.AchatQuantite[14],
                                   APRODUITS.AchatFournisseur[15],
                                   APRODUITS.AchatPrix[15],
                                   APRODUITS.AchatDate[15],
                                   APRODUITS.AchatQuantite[15],
                                   APRODUITS.AchatFournisseur[16],
                                   APRODUITS.AchatPrix[16],
                                   APRODUITS.AchatDate[16],
                                   APRODUITS.AchatQuantite[16],
                                   APRODUITS.AchatFournisseur[17],
                                   APRODUITS.AchatPrix[17],
                                   APRODUITS.AchatDate[17],
                                   APRODUITS.AchatQuantite[17]
                                   ]))
                                     else
    Result := rcdRejetee;

end;

function TdmInfosoftPHA.CreerDonnees(
  AASSURES: TASSURES): TResultatCreationDonnees;
begin
  if (not AASSURES.Supprime) then
  begin
    Result := ExecuterPS('ASSURES.DBI', 'PS_INFOSOFT_CREER_CLIENT',
                         VarArrayOf([AASSURES.Fichier.EnregNo,
                                     AASSURES.NumeroInsee,
                                     AASSURES.DateNaissance,
                                     AASSURES.RangGemellaire,
                                     AASSURES.Qualite,
                                     AASSURES.Nom,
                                     AASSURES.NomJeuneFille,
                                     AASSURES.Prenom,
                                     AASSURES.Rue,
                                     AASSURES.CodePostal,
                                     AASSURES.NomVille,
                                     AASSURES.Telephone,
                                     AASSURES.Portable,
                                     AASSURES.Fax,
                                     AASSURES.IDOrganismeAMO,
                                     AASSURES.IDCouvertureAMO,
                                     AASSURES.CodesSituationsAMO[0],
                                     AASSURES.ALDs[0],
                                     AASSURES.DebutsDroitsAMO[0],
                                     AASSURES.FinsDroitsAMO[0],
                                     AASSURES.CodesSituationsAMO[1],
                                     AASSURES.ALDs[1],
                                     AASSURES.DebutsDroitsAMO[1],
                                     AASSURES.FinsDroitsAMO[1],
                                     AASSURES.CodesSituationsAMO[2],
                                     AASSURES.ALDs[2],
                                     AASSURES.DebutsDroitsAMO[2],
                                     AASSURES.FinsDroitsAMO[2],
                                     AASSURES.CodesSituationsAMO[3],
                                     AASSURES.ALDs[3],
                                     AASSURES.DebutsDroitsAMO[3],
                                     AASSURES.FinsDroitsAMO[3],
                                     AASSURES.CodesSituationsAMO[4],
                                     AASSURES.ALDs[4],
                                     AASSURES.DebutsDroitsAMO[4],
                                     AASSURES.FinsDroitsAMO[4],
                                     AASSURES.IDOrganismeAMC,
                                     AASSURES.IDCouvertureAMC,
                                     AASSURES.CodesSituationsAMC[0],
                                     AASSURES.DebutsDroitsAMC[0],
                                     AASSURES.FinsDroitsAMC[0],
                                     AASSURES.NumeroAdherentMutuelle,
                                     AASSURES.NumeroSPSante]));
    if Result = rcdImportee then
      FClients.Add(IntToStr(AASSURES.Fichier.EnregNo));
  end
  else
    Result := rcdRejetee;
end;

function TdmInfosoftPHA.CreerDonnees(
  ALIBCREMB: TLIBCREMB): TResultatCreationDonnees;
begin
  if (ExtractFileName(ALIBCREMB.Fichier.Fichier) = 'LIBCREMB.AMO') then
    Result := ExecuterPS('LIBCREMB.AMO', 'PS_INFOSOFT_CREER_COUV_AMO',
                         VarArrayOf([ALIBCREMB.ID,
                                     ALIBCREMB.Libelle]))
  else
    Result := ExecuterPS('LIBCREMB.AMC', 'PS_INFOSOFT_CREER_COUV_AMC',
                         VarArrayOf([ALIBCREMB.ID,
                                     ALIBCREMB.Libelle]))
end;

function TdmInfosoftPHA.CreerDonnees(
  ACODEREMB: TCODEREMB): TResultatCreationDonnees;
begin
  if (ExtractFileName(ACODEREMB.Fichier.Fichier) = 'CODEREMB.AMO') then
    Result := ExecuterPS('CODEREMB.AMO', 'PS_INFOSOFT_CREER_TAUX_PC',
                         VarArrayOf([ACODEREMB.IDCouverture,
                                     null,
                                     ACODEREMB.Acte,
                                     ACODEREMB.Taux]))
  else
    Result := ExecuterPS('CODEREMB.AMC', 'PS_INFOSOFT_CREER_TAUX_PC',
                         VarArrayOf([null,
                                     ACODEREMB.IDCouverture,
                                     ACODEREMB.Acte,
                                     ACODEREMB.Taux]))
end;

procedure TdmInfosoftPHA.DataModuleCreate(Sender: TObject);
begin
 inherited;

 dmInfosoftPHA := Self;
 FClients := THashedStringList.Create;
 FHistoriqueClient := THashedStringList.Create;
end;

procedure TdmInfosoftPHA.DataModuleDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FHistoriqueClient) then FreeAndNil(FHistoriqueClient);
  if Assigned(FClients) then FreeAndNil(FClients);
end;

procedure TdmInfosoftPHA.SupprimerDonnees(ADonneesASupprimer: TList<Integer>);
var
  idx : Integer;
begin
  idx := ADonneesASupprimer.IndexOf(Ord(suppHistoriques));
  if idx <> -1 then ADonneesASupprimer[idx] := 101;

  inherited;
end;

function TdmInfosoftPHA.CreerDonnees(AHISTO: THISTO): TResultatCreationDonnees;
var
  c : Integer;
begin

  case AHISTO.TypeEntete of
    1 :
      if (AHISTO.IDClient <> 0) and
         (AHISTO.NumeroFacture <> 0) and
         (DaysBetween(now, AHISTO.DateFacture) < 730) then
      begin
        Result := ExecuterPS('HISTO.DBI', 'PS_INFOSOFT_CREER_HISTO_ENTETE',
                             VarArrayOf([AHISTO.NumeroFacture,
                                         AHISTO.NumeroOrdo,
                                         AHISTO.IDClient,
                                         AHISTO.DatePrescription,
                                         AHISTO.DateFacture,
                                         AHISTO.IDPraticien,
                                         AHISTO.NomPrenomPraticien]));
        if Result = rcdImportee then
          FHistoriqueClient.Add(IntToStr(AHISTO.NumeroFacture));
      end
      else
        Result := rcdRejetee;
    2 :
      if (FHistoriqueClient.IndexOf(IntToStr(AHISTO.NumeroFacture)) <> -1) and
         ((TryStrToInt(AHISTO.CodeCIP, c)) or (copy(AHISTO.CodeCIP,1,2) ='34') )  and
         (now - AHISTO.DateFacture < 730)  then
        Result := ExecuterPS('HISTO.DBI', 'PS_INFOSOFT_CREER_HISTO_LIGNE',
                             VarArrayOf([AHISTO.DateFacture,
                                         AHISTO.NumeroFacture,
                                         AHISTO.CodeCIP,
                                         AHISTO.Designation,
                                         AHISTO.PrixVente,
                                         AHISTO.Quantite]))
      else
        Result := rcdRejetee;
  else
    Result := rcdRejetee;
  end;
end;

function TdmInfosoftPHA.CreerDonnees(
  ACREDITS: TCREDITS): TResultatCreationDonnees;
begin
  Result := ExecuterPS('CREDITS.DBI', 'PS_INFOSOFT_CREER_CREDIT',
                       VarArrayOf([ACREDITS.IDClient, ACREDITS.DateCredit, ACREDITS.Montant]));
end;

function TdmInfosoftPHA.CreerDonnees(
  AMESSAGES: TMESSAGES): TResultatCreationDonnees;
begin
  Result := ExecuterPS('MESSAGES.PDT', 'PS_INFOSOFT_CREER_COM_PROD',
                       VarArrayOf([AMESSAGES.CodeCip,
                                   AMESSAGES.Commentaire]));
end;

function TdmInfosoftPHA.CreerDonnees(
  AAVANCESV: TAVANCESV): TResultatCreationDonnees;
begin
   if (AAVANCESV.Quantite > 0 ) then
  Result := ExecuterPS('AVANCESV.DBI', 'PS_INFOSOFT_CREER_AVANCES',
                       VarArrayOf([AAVANCESV.IDClient,
                                   AAVANCESV.DateAvance,
                                   AAVANCESV.CodeCip ,
                                   AAVANCESV.Designation,
                                   AAVANCESV.Quantite,
                                   AAVANCESV.PrixVente,
                                   AAVANCESV.PrixAchat,
                                   AAVANCESV.BaseRemboursement,
                                   AAVANCESV.Prestation,
                                   AAVANCESV.Operateur ]))
                                     else
    Result := rcdRejetee;
end;

function TdmInfosoftPHA.CreerDonnees(
  ASCANCLT: TSCANCLT): TResultatCreationDonnees;
begin
  if ASCANCLT.IDClient <> 0 then
    Result := ExecuterPS('SCANCLT', 'PS_INFOSOFT_CREER_DOCUMENT',
                         VarArrayOf([ASCANCLT.IDClient, ASCANCLT.IDDocument]))
  else
    Result := rcdRejetee;
end;

function TdmInfosoftPHA.CreerDonnees(
  ACOMMANDE_LST: TCOMMANDE_LST): TResultatCreationDonnees;
begin
  Result := ExecuterPS('COMMANDE.LST', 'PS_INFOSOFT_CREER_COMMANDE',
                       VarArrayOf([ACOMMANDE_LST.ID, ACOMMANDE_LST.Reception,
                                   ACOMMANDE_LST.Fournisseur, ACOMMANDE_LST.Date]));
end;

function TdmInfosoftPHA.CreerDonnees(
  APERSONEL: TPERSONEL): TResultatCreationDonnees;
begin
  Result := ExecuterPS('PERSONEL.IDX', 'PS_INFOSOFT_CREER_OPERATEUR',
                       VarArrayOf([APERSONEL.CodeOperateur, APERSONEL.Nom, APERSONEL.Prenom]))
end;

end.
