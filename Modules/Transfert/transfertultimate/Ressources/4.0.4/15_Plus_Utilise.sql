/****************** PLUS UTILISE ACTUELLEMENT    ***********************************************************/
/*
create or replace package migration.pk_creationdonnees as


FUNCTION CreationSynPdtChim(
  ASynPdtChim IN VARCHAR2,
  ALibelle IN VARCHAR2,
  ANumAPB IN VARCHAR2,
  ALang IN VARCHAR2,
  T_SYNPDTCHIM_ID OUT NUMBER
) RETURN NUMBER;


FUNCTION CreationClassificationInterne(
  AClassificationInterne IN VARCHAR2,
  ALibelle IN VARCHAR2,
  ATauxMarque IN NUMBER,
  ATauxMarge IN NUMBER,
  T_classificationinterne_ID OUT NUMBER
 ) RETURN NUMBER;

FUNCTION CreationChimique(
  AChimique IN VARCHAR2,
  ACodeUnite IN NUMBER,
  ACodeUnitePresc IN NUMBER,
  APrixAchat IN NUMBER,
  APrixComptoir IN NUMBER,
  APrixOfficiel IN NUMBER,
  ADensite IN NUMBER,
  ADensiteTar IN NUMBER,
  T_chimique_ID OUT NUMBER
 ) RETURN NUMBER;

FUNCTION CreationLibelleChimique(
  ALibelleChimique IN VARCHAR2,
  AChimique IN VARCHAR2,
  ADesignation IN VARCHAR2,
  ALangue IN VARCHAR2,
  ASynonyme IN VARCHAR2,
  T_libellechimique_ID OUT NUMBER
 ) RETURN NUMBER;


	
PROCEDURE AJOUTHONORAIRES;

end pk_creationdonnees;
/


/*******************************************************/
/*                       BODY                             */
/*******************************************************/
/*create or replace package body migration.pk_creationdonnees as
  

FUNCTION CreationSynPdtChim(
  ASynPdtChim IN VARCHAR2,
  ALibelle IN VARCHAR2,
  ANumAPB IN VARCHAR2,
  ALang IN VARCHAR2,
  T_SYNPDTCHIM_ID OUT NUMBER
) RETURN NUMBER
AS
 nbPdt NUMBER;
 idPdt bel.t_chim_denomination.t_chim_produit_id%TYPE;
 idPdtChim bel.t_chim_produit.t_chim_produit_id%TYPE;
BEGIN
	nbPdt := 0;
	idPdt := 0;

    SELECT COUNT(*) INTO nbPdt FROM bel.t_chim_produit WHERE cnk = ANumAPB;

	IF (nbPdt > 0) THEN
        BEGIN
			SELECT DISTINCT t_chim_produit_id INTO idPdt
			FROM bel.t_chim_denomination
			WHERE t_chim_produit_id IN (SELECT DISTINCT t_chim_produit_id
																	FROM bel.t_chim_produit
																	WHERE cnk = ANumAPB)
			AND (codelangue = ALang OR codelangue IS NULL)
			AND denomination = ALibelle;

            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                idPdt := NULL;
		END;

		BEGIN
			SELECT DISTINCT t_chim_produit_id INTO idPdtChim
			FROM bel.t_chim_produit
			WHERE cnk = ANumAPB;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
				idPdtChim := NULL;
		END;

		IF (((idPdt IS NULL) OR (idPdt = 0)) AND (idPdtChim IS NOT NULL)) THEN
		  INSERT INTO bel.t_chim_denomination (t_chim_denomination_id,t_chim_produit_id,codelangue,codesynonyme,denomination,datemaj,etat)
		  VALUES(bel.seq_id_chim_denomination.nextval,idPdtChim,ALang,'1',ALibelle,to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),'0')
		  RETURNING t_chim_denomination_id INTO T_SYNPDTCHIM_ID;
	END IF;

	ELSE
         raise_application_error(-20200, 'Aucun produit !');
	END IF;

    RETURN T_SYNPDTCHIM_ID;

EXCEPTION
	WHEN OTHERS then
    raise;
END CreationSynPdtChim;


FUNCTION CreationClassificationInterne(
  AClassificationInterne IN VARCHAR2,
  ALibelle IN VARCHAR2,
  ATauxMarque IN NUMBER,
  ATauxMarge IN NUMBER,
  T_classificationinterne_ID OUT NUMBER
) RETURN NUMBER
AS
BEGIN
    savepoint classif;

    INSERT INTO bel.t_classificationinterne(t_classificationinterne_id,libelle,tauxmarque,tauxmarge,datemajclassinterne)
    VALUES(bel.seq_id_classificationinterne.nextval,ALibelle,ATauxMarque,ATauxMarge,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'))
    RETURNING t_classificationinterne_id INTO T_classificationinterne_ID;

	INSERT INTO tw_classificationinterne(classificationinterne,classificationinterne_lgpi) VALUES(AClassificationInterne,T_classificationinterne_ID);

    RETURN T_classificationinterne_ID;

  EXCEPTION
    WHEN OTHERS then
		ROLLBACK to classif;
		raise;
END CreationClassificationInterne;

PROCEDURE AJOUTHONORAIRES AS
    nb INTEGER;
    idProduit INTEGER;
    nbCompte INTEGER;
BEGIN

    SELECT COUNT(*) INTO nb FROM bel.t_produit WHERE codecip = '5510276';
    IF (nb = 0) then
        INSERT INTO BEL.T_PRODUIT(T_PRODUIT_ID,CODECIP, DESIGNATION, DESIGNATION_NL, AVEC_CBU, DELAIVIANDE, DELAILAIT, GEREINTERESSEMENT, GERESUIVICLIENT, DATEDERNMAJPRODUIT, TRACABILITE, LOTACHAT, LOTVENTE, STOCKMINI, STOCKMAXI, PROFILGS, CALCULGS, NBMOISCALCUL, CONDITIONNEMENT, MOYVTE, UMOYVTE, CONTENANCE, UNITEMESURE, PRIXACHATREMISE, VETERINAIRE, PCHAUT, PCBAS, PMC, VIDEO, DESIGNATIONLIBREPOSSIBLE, PC25MOY, PEREMPTION_COURTE, TYPE_ORIGINE, T_CATEGORIE_PRODUIT_ID, T_STATUT_COMMERCIAL_ID, T_USAGE_PRODUIT_ID, REMISE_INTERDITE, RISTOURNE_INTERDITE, TAUX_REMISE, TAUX_RISTOURNE, NB_UNITES_INSULINE, OXYGENE, HONO_URGENCE, TYPE_TEMPERATURE_CONSERV, HOMEO_REMB)
         VALUES(BEL.SEQ_ID_PRODUIT.nextval, '5510276', 'HONORAIRE TRAITEMENTS DE SUBSTITUTION METHADONE', 'HONORARIUM SUBSTITUTIEBEHANDELINGEN MET METHADON', '0', 0, 0, '0', '0', sysdate, '0', 0, 0, 0, 0, '0', '5', 0, 0, 0, 0, 0, '0', 0.73, '0', 0, 0, 0, '0', '0', 0, '0', 0, 14, 1, 1, '0', '0', 0, 0, 0, '0', '0', 0, '0');

        SELECT t_produit_id INTO idProduit FROM bel.t_produit WHERE codecip = '5510276';

        INSERT INTO BEL.T_TARIF_PRODUIT (T_TARIF_PRODUIT_ID, T_PRODUIT_ID, T_TVA_ID, PRIXVENTE, PRIXACHATCATALOGUE, PAMP, TARIFACHATUNIQUE, SOUMISMDL, MARGE_TAUX, MARGE_COEFF, PV_TTC_APB, DATE_VALID_DEBUT, DATEMAJ, TARIFACHAT_OFFIBASE)
        VALUES(BEL.SEQ_ID_TARIF_PRODUIT.nextVal, idProduit, 4, 0.73, 0.73, 0, '0', '0', 0, 0, 0, TO_DATE('01/01/1900 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), sysdate, 0);
    END IF;

    idProduit := NULL;

    SELECT COUNT(*) INTO nbCompte FROM bel.t_produit p , bel.t_remboursement r
    WHERE p.t_produit_id = r.t_produit_id AND p.codecip = '5510276';

    SELECT T_PRODUIT_ID INTO idProduit FROM BEL.T_PRODUIT p WHERE p.codecip = '5510276';

    IF(nbCompte = 0) THEN
        INSERT INTO BEL.T_REMBOURSEMENT ( T_REMBOURSEMENT_ID            ,             T_PRODUIT_ID, T_TYPE_ASSURANCE_SOCIALE_ID,  QTE_ADMISE, TM_ACTIF, TM_IPVO,  DATE_VALID_DEBUT, DATE_VALID_FIN, DATEMAJ,    TYPE_CAT_REMB, TYPE_COND_REMB, CLASSE,  REMB_MAX_ADMIS)
                                        VALUES (BEL.seq_id_remboursement.nextVal,    idProduit            ,     1                                    ,     'P'        ,    0        ,  0        ,     null                , null              ,  sysdate,         7                ,     1             ,  null    ,     null                );
        INSERT INTO BEL.T_REMBOURSEMENT ( T_REMBOURSEMENT_ID            ,             T_PRODUIT_ID, T_TYPE_ASSURANCE_SOCIALE_ID,  QTE_ADMISE, TM_ACTIF, TM_IPVO,  DATE_VALID_DEBUT, DATE_VALID_FIN, DATEMAJ,    TYPE_CAT_REMB, TYPE_COND_REMB, CLASSE,  REMB_MAX_ADMIS)
                                                VALUES (BEL.seq_id_remboursement.nextVal,    idProduit    ,     2                                    ,     'P'        ,    0        ,  0        ,     null                , null              ,  sysdate,         7                ,     1             ,  null    ,     null                );
        INSERT INTO BEL.T_REMBOURSEMENT ( T_REMBOURSEMENT_ID            ,             T_PRODUIT_ID, T_TYPE_ASSURANCE_SOCIALE_ID,  QTE_ADMISE, TM_ACTIF, TM_IPVO,  DATE_VALID_DEBUT, DATE_VALID_FIN, DATEMAJ,    TYPE_CAT_REMB, TYPE_COND_REMB, CLASSE,  REMB_MAX_ADMIS)
                                                VALUES (BEL.seq_id_remboursement.nextVal,    idProduit    ,     3                                    ,     'P'        ,    0        ,  0        ,     null                , null              ,  sysdate,         7                ,     1             ,  null    ,     null                );
        INSERT INTO BEL.T_REMBOURSEMENT ( T_REMBOURSEMENT_ID            ,             T_PRODUIT_ID, T_TYPE_ASSURANCE_SOCIALE_ID,  QTE_ADMISE, TM_ACTIF, TM_IPVO,  DATE_VALID_DEBUT, DATE_VALID_FIN, DATEMAJ,    TYPE_CAT_REMB, TYPE_COND_REMB, CLASSE,  REMB_MAX_ADMIS)
                                                VALUES (BEL.seq_id_remboursement.nextVal,    idProduit    ,     4                                    ,     'P'        ,    0        ,  0        ,     null                , null              ,  sysdate,         7                ,     1             ,  null    ,     null                );
        INSERT INTO BEL.T_REMBOURSEMENT ( T_REMBOURSEMENT_ID            ,             T_PRODUIT_ID, T_TYPE_ASSURANCE_SOCIALE_ID,  QTE_ADMISE, TM_ACTIF, TM_IPVO,  DATE_VALID_DEBUT, DATE_VALID_FIN, DATEMAJ,    TYPE_CAT_REMB, TYPE_COND_REMB, CLASSE,  REMB_MAX_ADMIS)
                                                VALUES (BEL.seq_id_remboursement.nextVal,    idProduit    ,     5                                    ,     'P'        ,    0        ,  0        ,     null                , null              ,  sysdate,         7                ,     1             ,  null    ,     null                );
    END IF;

    INSERT INTO bel.T_HONORAIRES_GARDE_PLGTRF ( DEBUT_HEURE, DEBUT_MINUTE, FIN_HEURE, FIN_MINUTE,
    TARIF_FERIE_DEFAUT, TARIF_HORS_FERIE_DEFAUT, ID_PRODUIT_FERIE,ID_PRODUIT_HORS_FERIE ) VALUES (
    19, 0, 8, 0, 4.45, 4.45, NULL, NULL);

    INSERT INTO BEL.T_HONORAIRES_GARDE_PLGTRF ( DEBUT_HEURE, DEBUT_MINUTE, FIN_HEURE, FIN_MINUTE,
    TARIF_FERIE_DEFAUT, TARIF_HORS_FERIE_DEFAUT, ID_PRODUIT_FERIE,
    ID_PRODUIT_HORS_FERIE ) VALUES (8, 0, 19, 0, 4.45, 4.45, NULL, NULL);

END AJOUTHONORAIRES;

FUNCTION CreationChimique(
	  AChimique IN VARCHAR2,
	  ACodeUnite IN NUMBER,
	  ACodeUnitePresc IN NUMBER,
	  APrixAchat IN NUMBER,
	  APrixComptoir IN NUMBER,
	  APrixOfficiel IN NUMBER,
	  ADensite IN NUMBER,
	  ADensiteTar IN NUMBER,
	  T_chimique_ID OUT NUMBER
	) RETURN NUMBER
	AS
	BEGIN
		savepoint chim;


    IF (APrixAchat = 0) THEN
        INSERT INTO bel.t_chim_produit(t_chim_produit_id,datemaj,deja_utilise,cnk,codeunitequantite,
        quantitepreparee,prixbloque
		--,prixachat
		,coeftc
		--,prixcomptoir,prixcomptoirbloque
		,uniteprescription,codetypehonoraire,
        codedosevariable,densitereelle,densitetarification,codeusageexterne,codeproduitstoxiques)
        VALUES(bel.seq_id_chim_produit.nextval,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),'0',NULL,ACodeUnite,
        0,'0'
		--,APrixAchat
		,0
		--,APrixComptoir,'0'
		,ACodeUnitePresc,0,
        '0',ADensite,ADensiteTar,'0',NULL) RETURNING t_chim_produit_id INTO T_chimique_ID;
    ELSE
        INSERT INTO bel.t_chim_produit(t_chim_produit_id,datemaj,deja_utilise,cnk,codeunitequantite,
        quantitepreparee,prixbloque
		--,prixachat
		,coeftc
		--,prixcomptoir,prixcomptoirbloque
		,uniteprescription,codetypehonoraire,
        codedosevariable,densitereelle,densitetarification,codeusageexterne,codeproduitstoxiques)
        VALUES(bel.seq_id_chim_produit.nextval,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),'0',NULL,ACodeUnite,
        0,'0'
		--,APrixAchat
		,(APrixComptoir / APrixAchat)
		--,APrixComptoir,'0'
		,ACodeUnitePresc,0,
        '0',ADensite,ADensiteTar,'0',NULL) RETURNING t_chim_produit_id INTO T_chimique_ID;
    END IF;

    INSERT INTO bel.t_chim_tarif(t_chim_tarif_id,t_chim_produit_id,prixofficiel,datemaj,dateapplication)
    VALUES(bel.seq_id_chim_tarif.nextval,T_chimique_ID,APrixOfficiel,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),NULL);

	INSERT INTO tw_chimique(chimique,chim_lgpi) VALUES(AChimique,T_chimique_ID);

    RETURN T_chimique_ID;

  EXCEPTION
    WHEN OTHERS then
		rollback to chim;
		raise;
END CreationChimique;

FUNCTION CreationLibelleChimique(
  ALibelleChimique IN VARCHAR2,
  AChimique IN VARCHAR2,
  ADesignation IN VARCHAR2,
  ALangue IN VARCHAR2,
  ASynonyme IN VARCHAR2,
  T_libellechimique_ID OUT NUMBER
) RETURN NUMBER
AS
BEGIN

    INSERT INTO bel.t_chim_denomination(t_chim_denomination_id,t_chim_produit_id,denomination,datemaj,codelangue,codesynonyme,etat,codesource)
    VALUES(bel.seq_id_chim_denomination.nextval,AChimique,ADesignation,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),ALangue,ASynonyme,'0','P')
    RETURNING t_chim_denomination_id INTO T_libellechimique_ID;

    RETURN T_libellechimique_ID;

  EXCEPTION
    WHEN OTHERS then
      raise;
END CreationLibelleChimique;




END PK_CREATIONDONNEES;
/