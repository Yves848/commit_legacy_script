create or replace package migration.pk_autres_donnees as

procedure maj_parametre(ACle in varchar2, 
                          AValeur in varchar2);
						  

FUNCTION CreationHisto_Client_Entete(
  AHisto_Client_Entete IN VARCHAR2,
  AClient IN NUMBER,
  ANumero_Facture IN NUMBER,
  ACode_Operateur IN VARCHAR2,
  APraticien_Nom IN VARCHAR2,
  APraticien_Prenom IN VARCHAR2,
  AThe_Type_Facturation IN NUMBER,
  ADate_Prescription IN DATE,
  ADate_Acte IN DATE,
  afusion in char
  ) RETURN NUMBER;

FUNCTION CreationHisto_Client_Ligne(
  AHisto_Client_Ligne IN VARCHAR2,
  AEntete IN NUMBER,
  ACodeCNK IN VARCHAR2,
  ADesignation IN VARCHAR2,
  AQtefacturee IN NUMBER,
  APrixVente IN NUMBER,
  AProduitID IN NUMBER,
  ARembourse IN VARCHAR
  ) RETURN NUMBER;

 

FUNCTION CreationHisto_Client_Magis(
  AHisto_Client_Magistrale IN VARCHAR2,
  AEntete IN NUMBER,
  ADesignation IN VARCHAR2,
  AQtefacturee IN NUMBER,
  ADetail IN VARCHAR2
  ) RETURN NUMBER;


FUNCTION CreationHistoVente(
  AHISTOVENTE IN VARCHAR2,
  AANNEE IN NUMBER,
  AMOIS IN NUMBER,
  APERIODE IN DATE,
  ASPESERIE IN NUMBER,
  AQTEVENDUE IN NUMBER,
  ANBVENTE IN NUMBER
  ) RETURN NUMBER;
 
 PROCEDURE CreationHistoriqueAchat(
	  AIDProduit in integer,
	  ANombreAchatsRepartiteur in number,
	  AQuantiteAcheteeRepartiteur in number,
	  ANombreAchatsDirecte in number,
	  AQuantiteAcheteeDirecte in number,
	  AMois in smallint,
	  AAnnee in smallint);

FUNCTION CreationMedicationProduit(
	at_sch_medication_produit_id IN VARCHAR2,
	at_aad_id IN VARCHAR2,
	at_produit_id IN VARCHAR2,
	alibelle IN VARCHAR2,
	atypeformedpp in VARCHAR2,
	atypemedication IN VARCHAR2,
	adate_debut in date,
	adate_fin in date,
	acommentaire IN VARCHAR2,
	at_formule_id IN VARCHAR2,
	adate_debut_susp in date,
	adate_fin_susp in date,
	T_sch_medication_produit_id OUT NUMBER
) RETURN NUMBER;

FUNCTION CreationMedicationPrise(
	aT_SCH_MEDICATION_PRISE_ID IN VARCHAR2, --SEQ_ID_MEDICATION_HEURE_PRISE
	aT_SCH_MEDICATION_PRODUIT_ID IN VARCHAR2, 
	aTYPE_FREQUENCE IN NUMBER,
	aFREQUENCE_JOURS IN VARCHAR2, 
	aPRISE_LEVER IN NUMBER, 
	aPRISE_PTDEJ IN NUMBER, 
	aTYPE_MOMENT_PTDEJ IN NUMBER, 
	aPRISE_MIDI IN NUMBER, 
	aTYPE_MOMENT_MIDI IN NUMBER, 
	aPRISE_SOUPER IN NUMBER, 
	aTYPE_MOMENT_SOUPER IN NUMBER, 
	aPRISE_COUCHER IN NUMBER, 
	aPRISE_HEURE1 IN NUMBER, -- Champs inexistant sur ultimate, laissé en attendant maj
	aPRISE_HEURE2 IN NUMBER, -- Champs inexistant sur ultimate, laissé en attendant maj
	aPRISE_HEURE3 IN NUMBER, -- Champs inexistant sur ultimate, laissé en attendant maj
	aPRISE_10HEURES IN NUMBER, -- Champs inexistant sur ultimate, laissé en attendant maj
	aPRISE_16HEURES IN NUMBER, -- Champs inexistant sur ultimate, laissé en attendant maj
	aLIBELLE_HEURE1 IN VARCHAR2, -- Champs inexistant sur ultimate, laissé en attendant maj
	aLIBELLE_HEURE2 IN VARCHAR2, -- Champs inexistant sur ultimate, laissé en attendant maj
	aLIBELLE_HEURE3 IN VARCHAR2, -- Champs inexistant sur ultimate, laissé en attendant maj
	aNB_JOURS IN NUMBER, --(number4 maintenant)
	T_sch_medication_prise_id OUT NUMBER
) RETURN NUMBER;

FUNCTION CreationSoldePatientTUH(
	AT_AAD_ID IN VARCHAR2,
	AT_PRODUIT_ID IN VARCHAR2,
	ASOLDE IN NUMBER,
	ANOORD IN NUMBER,
	ADATE_ORDO IN DATE,
	ACATREMB IN NUMBER,
	ACONDREMB IN NUMBER,
	AT_PRATICIEN_ID IN VARCHAR2,
	At_type_tuh IN NUMBER,
	At_collectivite_id IN VARCHAR2,
	AOrdo_Suspendu IN NUMBER,
	ACBU IN VARCHAR2,
	ADATE_DEBUT_ASS_OA IN DATE,
	ADATE_FIN_ASS_OA IN DATE,
	ADATEDEBVALIDITEPIECE IN DATE,
	ADATEFINVALIDITEPIECE IN DATE,
	ADATEDERNCONSULT_MYCARENET IN DATE,
	ACT1  IN NUMBER,
	ACT2  IN NUMBER,
	T_TUH_SOLDE_PATIENT_ID OUT NUMBER
) RETURN NUMBER;

FUNCTION CreationSoldeBoiteTUH(
	AT_COLLECTIVITE_ID IN VARCHAR2,
	AT_PRODUIT_ID IN VARCHAR2,
	ASOLDE IN NUMBER,
	T_TUH_SOLDE_BOITE_ID OUT NUMBER
) RETURN NUMBER;
						  
end;
/