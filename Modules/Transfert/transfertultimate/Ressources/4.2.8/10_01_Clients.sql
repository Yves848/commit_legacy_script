create or replace package migration.pk_clients as
 
 FUNCTION CreationClient (
    AClient IN VARCHAR2,
    ANom IN VARCHAR2,
    APrenom IN VARCHAR2,
    ASexe IN VARCHAR2,
    ALangue IN VARCHAR2,
    ADateNaissance IN DATE,
    ANISS IN VARCHAR2,
	  Ainami in varchar2,
    ARue1 IN VARCHAR2,
    ARue2 IN VARCHAR2,
    ACodePostal IN VARCHAR2,
    ANomVille IN VARCHAR2,
    ACodePays IN VARCHAR2,
    ATelPersonnel IN VARCHAR2,
    ATelStandard IN VARCHAR2,
    ATelMobile IN VARCHAR2,
    AEmail IN VARCHAR2,
    AFax IN VARCHAR2,
    ASiteWeb IN VARCHAR2,
    AOA IN VARCHAR2,
    AOACPAS IN NUMBER,
	  AMatOA IN VARCHAR2,
    --ACatOA IN VARCHAR2
    ADateDebOA IN DATE,
    ADateFinOA IN DATE,
    AOC IN VARCHAR2,
    AOCCPAS IN NUMBER,
  	AMatOC IN VARCHAR2,
    ACatOC IN VARCHAR2,
    ADateDebOC IN DATE,
    ADateFinOC IN DATE,
    AOAT IN VARCHAR2,
    AMatAT IN VARCHAR2,
    ACatAT IN VARCHAR2,
    ADateDebAT IN DATE,
    ADateFinAT IN DATE,
    ACT1 IN VARCHAR2,
    ACT2 IN VARCHAR2,
    ACOLLECTIVITE IN VARCHAR2,
    AVERSIONASSUR IN NUMBER,
    ACERTIFICAT IN VARCHAR2,
    ANUMCARTESIS IN VARCHAR2,
    ADERNIERELECTURE IN DATE,
    ADATEDEBVALPIECE IN DATE,
    ADATEFINVALPIECE IN DATE,
    APAYEUR IN VARCHAR2,
    ANUMTVA IN VARCHAR2,
    ACommIndiv IN VARCHAR2,
    ACommBloqu IN VARCHAR2,
    ANatPieceJustifDroit IN NUMBER,
    ANumGroupe IN VARCHAR2,
    AIDPROFILREMISE IN NUMBER,
    AIDFAMILLE IN VARCHAR2,
    ADATEDERNIEREVISITE IN DATE,
    AEDITIONBVAC IN VARCHAR2,
    AEDITIONCBL    IN VARCHAR2,
    AEDITION704 IN VARCHAR2,
    ATYPEPROFILFACTURATION IN NUMBER,
    ACOPIESCANEVASFACTURE IN NUMBER,
    AEDITIONIMMEDIATE varchar2,
    AMOMENT_FACTURATION number,
    AJOUR_FACTURATION number,
    APLAFOND_CREDIT number,
    ACREDIT_EN_COURS number,
    ADATE_DELIVRANCE in varchar2,
    ANumChambre IN VARCHAR2,
  	AETAGE IN VARCHAR2,
    AMAISON IN VARCHAR2,
    ALIT IN VARCHAR2,
    ACodeCourt in varchar2,
    ANB_TICKET_NOTEENVOI IN NUMBER,
    ANB_ETIQ_NOTEENVOI IN NUMBER,
    ADELAIPAIEMENT IN NUMBER,
    ASCH_POSOLOGIE IN NUMBER,
    APH_REF in number,
    asejour_court in varchar2,
    atuh_boite_pleine in varchar2,	
    aDECOND_FOUR in varchar2,
  	AETAT IN VARCHAR2,
    Aidentifiant_externe in varchar2,
    asch_commentaire in varchar2,
    anumero_passport_cni in varchar2,
    AFUSION IN CHAR
  ) RETURN NUMBER;

  
FUNCTION CreationProfilRemise(
  APROFILREMISE IN VARCHAR2,
  ADEFAULTOFFICINE IN VARCHAR2,
  ALIBELLE IN VARCHAR2,
  ATAUXREGLEGEN IN NUMBER,
  ATYPERISTOURNE IN VARCHAR2,
  APLAFONDRISTOURNE IN NUMBER,
  t_profilremise_id OUT NUMBER
 ) RETURN NUMBER ;



FUNCTION CreationProfilRemiseSuppl(
  APROFILREMISESUPPL IN VARCHAR2,
  APROFILREMISE IN VARCHAR2,
  ATYPEREGLE IN NUMBER,
  AORDRE IN NUMBER,
  ATYPERIST IN VARCHAR2,
  APLAFRIST IN NUMBER,
  ATAUX IN NUMBER,
  ACATPROD IN VARCHAR2,
  AUSAGE IN VARCHAR2,
  ACLASSINT IN NUMBER,
  T_PROFILREMISESUPPL_ID OUT NUMBER
  ) RETURN NUMBER ;
  
  
PROCEDURE MajCPAS(
    AOrganismeOA IN NUMBER,
    AOrganismeOC IN NUMBER,
    Adestinataire_facture IN NUMBER
);

 
  procedure creer_pathologie(AIDClient in integer,
                             APathologie in varchar2,
							               afusion in char);

  procedure creer_allergie_atc(AIDClient in integer,
                               AClassificationATC in varchar2,
							                 afusion in char);
end;
/