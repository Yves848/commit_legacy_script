create or replace package migration.pk_encours as

FUNCTION CreationAvanceProduit(
    ALitige IN VARCHAR2,
    AClient IN NUMBER,
    AProduit IN VARCHAR2,
    ATypeLitige IN NUMBER,
    ADescriptionLitige IN VARCHAR2,
    ANomPdt IN VARCHAR2,
    ACDBU IN VARCHAR2,
    ANoOrd IN VARCHAR2,
    APrixClient IN NUMBER,
    Aqtedelivree IN NUMBER,
    Aqtemanquante IN NUMBER,
    ADateVente IN DATE,
    AIsFacture IN VARCHAR2,
    Agtin IN VARCHAR2,
    Anumero_serie IN VARCHAR2,
    T_LITIGE_ID OUT NUMBER
 ) RETURN NUMBER;

FUNCTION CreationCredit(
    ACredit IN VARCHAR2,
    AMontant IN NUMBER,
    ADateCredit IN DATE,
    AClient IN NUMBER,
    T_ACTE_ID OUT NUMBER
 ) RETURN NUMBER;

FUNCTION CreationDelDif(
  ADelDif IN VARCHAR2,
  AProduit IN NUMBER,
  AClient IN NUMBER,
    AMedecin IN VARCHAR2,
    ANoOrdon IN VARCHAR2,
    ADatePrescr IN DATE,
    ADateDeliv IN DATE,
    AQttDiff IN NUMBER,
    ADateOrdon IN DATE,
	ATypeDeldif in number,
  T_DELDIF_ID OUT NUMBER
 ) RETURN NUMBER;

FUNCTION CreationAttestation(
  AATTESTATION IN VARCHAR2,
  ASPEID IN NUMBER,
  ACLIID IN NUMBER,
  ANUMATT IN VARCHAR2,
  ASCANNE IN VARCHAR2,
  ADATELIMITE IN DATE,
  ACATREMB IN NUMBER,
  ACONDREMB IN NUMBER,
  ANBCOND IN NUMBER,
  ANBMAXCOND IN NUMBER,
  ACODASSURSOCIAL IN VARCHAR2,
  t_attestation_id OUT NUMBER
 ) RETURN NUMBER;

 end;
/