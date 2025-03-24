create or replace package body migration.pk_cartes_ristournes as


/* Vérifier qu'il ne crée une ligne que qd libertype est <> 2 ou que ((libertype = 2) et que liberval est une valeur entière)*/
FUNCTION CreationCompte(
  ACOMPTE IN VARCHAR2,
  ACLIID IN NUMBER,
  ALIBERTYPE IN VARCHAR2,
  ALIBERVAL IN VARCHAR2,
  AETAT IN VARCHAR2,
  Aid_centralisation IN NUMBER,
  t_compte_id OUT NUMBER
) RETURN NUMBER
AS
    isNum NUMBER;
BEGIN
    savepoint comptePt;
    isNum := 0;

    IF (ALIBERTYPE <> '2') THEN
        isNum := 1;
    ELSE
        isNum := pk_annexes.isNumeric(ALIBERVAL); /*LENGTH(TRIM(TRANSLATE(ALIBERVAL,'0123456789',' ')));        */

    /*    IF ((INSTR(ALIBERVAL,',') > 0) OR (INSTR(ALIBERVAL,'.') > 0)) THEN
            isNum := 0;
        END IF;*/
    END IF;

    IF (isNum = 1) THEN
        INSERT INTO bel.t_crist_comptes(
            t_crist_compte_id,
            t_titulaire_aad_id,
            liber_type,
            liber_valeur,
            datemaj,
            etat,
			id_centralisation
            )
            VALUES(
            bel.seq_id_crist_comptes.NEXTVAL,
            ACLIID,
            ALIBERTYPE,
            REPLACE(ALIBERVAL,'/',''),
            to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
            AETAT,
			Aid_centralisation)
            RETURNING t_crist_compte_id into t_compte_id;

--        INSERT INTO tw_compte(compte,cpt_lgpi) VALUES(ACOMPTE,t_compte_id);
		
        RETURN t_compte_id;
    END IF;


    EXCEPTION
     WHEN OTHERS then
      rollback to comptePt;
      raise;
END CreationCompte;

FUNCTION CreationCarteRist(
  ACARTERIST IN VARCHAR2,
  ACOMPTEID IN NUMBER,
  ACLIID IN NUMBER,
  ADATEEMIS IN DATE,
  ANUMCARTE IN VARCHAR2,
  AVIRTUEL IN VARCHAR2,
  AETAT IN VARCHAR2,
  ASYNONYME IN VARCHAR2,
  ANUMAPBOFFICINE IN VARCHAR2,
  t_carterist_id OUT NUMBER
) RETURN NUMBER
AS
    StrComptID VARCHAR2(5);
    numCart VARCHAR2(13);
    numCartSyn VARCHAR2(13);
    lenComptID NUMBER;
    i NUMBER;
BEGIN
    numCart := '';
    lenComptID := 0;
    i := 1;

    IF AVIRTUEL = '1' THEN
          /* SELECT TO_CHAR(ACOMPTEID) INTO StrComptID FROM DUAL; */

      SELECT TO_CHAR(BEL.SEQ_NO_CRIST.NEXTVAL) INTO StrComptID FROM DUAL;
      SELECT LENGTH(StrComptID) INTO lenComptID FROM DUAL;

        WHILE i <= (6 - lenComptID) LOOP
            numCart := numCart || '0';
            i := i + 1;
        END LOOP;

        SELECT 'VIRTUAL' || numCart || StrComptID INTO numCart FROM DUAL;
    ELSE
        IF ((ASYNONYME = '1') AND (ANUMAPBOFFICINE IS NOT NULL)) THEN
             SELECT TO_CHAR(BEL.SEQ_NO_CRIST.NEXTVAL) INTO StrComptID FROM DUAL;
           SELECT LENGTH(StrComptID) INTO lenComptID FROM DUAL;

           WHILE i <= (6 - lenComptID) LOOP
               numCart :=  numCart || '0';
               i := i + 1;
           END LOOP;

            SELECT 'A' || ANUMAPBOFFICINE || numCart || StrComptID INTO numCart FROM DUAL;
        ELSE
            numCart := ANUMCARTE;
        END IF;
     END IF;

    INSERT INTO bel.t_crist_cartes(
        t_crist_carte_id,
        num_carte,
        t_crist_compte_id,
        t_titulaire_carte_aad_id,
        date_emission,
        datemaj,
        etat)
        VALUES(
        bel.seq_id_crist_cartes.NEXTVAL,
        numCart,
        ACOMPTEID,
        ACLIID,
        ADATEEMIS,
        to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),
        AETAT
        )
    RETURNING t_crist_carte_id into t_carterist_id;

         IF ((ASYNONYME = '1') AND (ANUMCARTE IS NOT NULL)) THEN
             SELECT '$' || ANUMCARTE INTO numCartSyn FROM DUAL;
             INSERT INTO bel.t_crist_cartes_syn(T_CRIST_CARTE_ID,NUM_CARTE) VALUES(t_carterist_id,numCartSyn);
         END IF;


    RETURN t_carterist_id;

    EXCEPTION
     WHEN OTHERS then
      raise;
END CreationCarteRist;

FUNCTION CreationTransactRist(
  ATRANSACTIONRIST IN VARCHAR2,
  ANUMCARTE IN VARCHAR2,
  ACOMPTEID IN NUMBER,
  AMONTANTRIST IN NUMBER,
  ATYPETRANSACT IN VARCHAR2,
  ATAUXTVA IN NUMBER,
  ATOTALTICKET IN NUMBER,
  AJUSTIFICATIF IN VARCHAR2,
  ADATETICKET IN DATE,
  t_transactrist_id OUT NUMBER
) RETURN NUMBER
AS
    idTva BEL.t_tva.t_tva_id%TYPE;
    dateTick BEL.t_crist_transaction.date_ticket%TYPE;
BEGIN

    begin
    SELECT t_tva_id
    INTO idTva
    FROM bel.t_tva
    WHERE tauxtva = ATAUXTVA;
  exception
    when no_data_found then
     raise_application_error(-20200, 'Taux TVA introuvable !');
  END;

    IF (ADATETICKET IS NULL) THEN
        dateTick := to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI');
    ELSE
        dateTick := ADATETICKET;
    END IF;

    INSERT INTO bel.t_crist_transaction(
        t_crist_transaction_id,
        t_crist_compte_id,
        t_facture_id,
        num_carte,
        date_ticket,
        t_tva_id,
        montant_ristourne,
        total_ticket,
        type_transaction,
        justificatif,
        datemaj,
        t_acte_id)
        VALUES(
        bel.seq_id_crist_transaction.NEXTVAL,
        ACOMPTEID,
        NULL,
        ANUMCARTE,
        dateTick,
        idTva,
        AMONTANTRIST,
        ATOTALTICKET,
        ATYPETRANSACT,
        AJUSTIFICATIF,
        to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),
        NULL)
    RETURNING t_crist_transaction_id into t_transactrist_id;

    RETURN t_transactrist_id;

    EXCEPTION
     WHEN OTHERS then
      raise;
END CreationTransactRist;


end;
/