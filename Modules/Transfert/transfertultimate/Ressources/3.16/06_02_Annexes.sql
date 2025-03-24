CREATE OR REPLACE package body migration.pk_annexes as

  sequence_inexistante exception; pragma exception_init(sequence_inexistante, -02289);
  /******************************************/
  /*            ENREGISTREDEPOT             */
  /******************************************/
  /* Enregistre un depot                    */
  /* Si celui-ci est<NULL>, alors on renvoie*/
  /* l'ID de PHARMACIE                      */
  /******************************************/
  FUNCTION EnregistreDepot(ALibelle in bel.t_depot.libelle%TYPE)
                          return bel.t_depot.t_depot_id%TYPE as

    lIntDepot bel.t_depot.t_depot_id%TYPE;

  begin
    if ALibelle is not null then
       -- Vérification si le depot existe déjà
       begin
         select t_depot_id
         into lIntDepot
         from bel.t_depot
         where libelle = initcap(trim(ALibelle));

         erreur.err_code := 0; erreur.err_msg := '';
       exception
         when no_data_found then
           -- Création du depot
           begin
             INSERT INTO bel.t_depot(t_depot_id,
                                     libelle,
                                     datemajdepot)
             values(bel.seq_id_depot.nextval,
                    initcap(ALibelle),
                    to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'))
             returning t_depot_id into lIntDepot;

             erreur.err_code := 0; erreur.err_msg := '';
           exception
             when others then
               lIntDepot := null;
               erreur.err_code := sqlcode; erreur.err_msg := sqlerrm;
           end;

        when others then
          -- Renvoie de l'erreur
          lIntDepot := null;
          erreur.err_code := sqlcode; erreur.err_msg := sqlerrm;
      end;
    else
      lIntDepot := null;
      erreur.err_code := 0; erreur.err_msg := '';
    end if;

    return lIntDepot;

  end EnregistreDepot;

  /******************************************/
  /*            ENREGISTRECONTACT           */
  /******************************************/
  /* Enregistre les contacts des            */
  /* organismes et destinataires            */
  /******************************************/
  FUNCTION EnregistreContact(ATypeContact in number,
                             AOrganisme in bel.t_contact.t_organisme_id%TYPE,
                             ADestintaire in bel.t_contact.t_destinataire_id%TYPE,
                             ANom in bel.t_contact.nom%TYPE,
                             APrenom in bel.t_contact.prenom%TYPE,
                             AService in bel.t_contact.service%TYPE,
                             ANoTelephone in bel.t_contact.notelephone%TYPE,
                             AEMail in bel.t_contact.email%TYPE)
                            return boolean as

    lIntCountContact bel.t_contact.t_contact_id%TYPE;
    lBoolContact boolean;

  begin
    if (ANom is not null) and ((AOrganisme is not null) or (ADestintaire is not null)) then
      -- Vérification si le contact existe déjà
      begin
        select count(*)
        into lIntCountContact
        from bel.t_contact
        where decode(ATypeContact, CONTACT_ORGANISME, AOrganisme,
                                   CONTACT_DESTINATAIRE, ADestintaire) = decode(ATypeContact, CONTACT_ORGANISME, AOrganisme,
                                                                                              CONTACT_DESTINATAIRE, ADestintaire)
          and nom = ANom
          and prenom = APrenom
          and service = AService;

        if lIntCountContact = 0 then
          begin
            INSERT INTO bel.t_contact(t_contact_id,
                                      nom,
                                      prenom,
                                      service,
                                      notelephone,
                                      email,
                                      datemajcontact,
                                      t_organisme_id,
                                      t_destinataire_id)
            values(bel.seq_contact.nextval,
                   upper(ANom),
                   upper(APrenom),
                   AService,
                   ANoTelephone,
                   AEMail,
                   to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),
                   decode(ATypeContact, CONTACT_ORGANISME, AOrganisme, null),
                   decode(ATypeContact, CONTACT_DESTINATAIRE, ADestintaire, null));

            lBoolContact := true;
            erreur.err_code := 0; erreur.err_msg := '';
          exception
            when others then
              lBoolContact := false;
              erreur.err_code := sqlcode; erreur.err_msg := sqlerrm;
          end;
        else
          lBoolContact := true;
          erreur.err_code := 0; erreur.err_msg := '';
        end if;
      exception
        when others then
          -- Renvoie de l'erreur
          lBoolContact := false;
          erreur.err_code := sqlcode; erreur.err_msg := sqlerrm;
      end;
    else
      lBoolContact := true;
      erreur.err_code := 0; erreur.err_msg := '';
    end if;

    return lBoolContact;
  end EnregistreContact;

  /******************************************/
  /*            ENREGISTREACTIVITE          */
  /******************************************/
  /* Enregistre les activités des assurés   */
  /* et des produits (A=>assure P=>produits */
  /******************************************/
  FUNCTION EnregistreActivite(ALibelle in bel.t_activite.libelle%TYPE,
                              AType in bel.t_activite.type%TYPE)
                             return bel.t_activite.t_activite_id%TYPE as

    lIntActivite bel.t_activite.t_activite_id%TYPE;

  begin
    if (ALibelle is not null) and (AType is not null) then
      begin
        select t_activite_id
        into lIntActivite
        from bel.t_activite
        where upper(libelle) = upper(trim(ALibelle))
          and upper(type) = upper(AType);

        erreur.err_code := 0; erreur.err_msg := '';
      exception
        when no_data_found then
          begin
            INSERT INTO bel.t_activite(t_activite_id,
                                       libelle,
                                       datemajactivite,
                                       type)
            values(bel.seq_id_activite.nextval,
                   upper(ALibelle),
                   to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),
                   upper(AType))
            returning t_activite_id into lIntActivite;

            erreur.err_code := 0; erreur.err_msg := '';
          exception
            when others then
              lIntActivite := null;
              erreur.err_code := sqlcode; erreur.err_msg := sqlerrm;
          end;
        when others then
          lIntActivite := null;
          erreur.err_code := sqlcode; erreur.err_msg := sqlerrm;
      end;
    else
      lIntActivite := null;
      erreur.err_code := 0; erreur.err_msg := '';
    end if;

    return lIntActivite;
  end EnregistreActivite;

/******************************************/
FUNCTION isNumeric(x IN VARCHAR2) RETURN NUMBER
AS
   nb NUMBER;
BEGIN
 BEGIN
   nb := TO_NUMBER(x);
   RETURN 1;
 EXCEPTION
   WHEN OTHERS THEN
      RETURN 0;
 END;
END isNumeric;

/******************************************/
PROCEDURE MAJPARAMSRIST AS
    nbCartes NUMBER;
    maxIDCompte NUMBER;
    stmt VARCHAR2(300);
    stmt2 VARCHAR2(50);
    numAPB VARCHAR2(10);

	BEGIN
        nbCartes := 0;
        maxIDCompte := 0;
        SELECT COUNT(*) INTO nbCartes FROM bel.t_crist_cartes WHERE num_carte LIKE 'VIRTUAL%';

     IF nbCartes > 0 THEN
        UPDATE BEL.T_PARAMETRES
        SET valeur = '1'
        WHERE cle = 'crist.typeCarte';

        UPDATE BEL.T_PARAMETRES
        SET valeur = 'VIRTUAL'
        WHERE cle = 'crist.prefixeCarte';

/* => Fixer la valeur de la séquence seq_no_crist avec la derniere valeur de carte virtuelle */
        /* stmt2 := 'DROP SEQUENCE BEL.SEQ_NO_CRIST';
        EXECUTE IMMEDIATE stmt2;

        SELECT MAX(t_crist_compte_id) INTO maxIDCompte FROM BEL.t_crist_comptes;
        maxIDCompte := maxIDCompte + 1;

        stmt := 'CREATE SEQUENCE BEL.SEQ_NO_CRIST START
                     WITH ' || maxIDCompte || '
                     MAXVALUE 999999999999999999999999999
                     MINVALUE 1
                     NOCYCLE
                     NOCACHE
                     NOORDER';
     EXECUTE IMMEDIATE stmt; */

     END IF;
END MAJPARAMSRIST;

/******************************************/
PROCEDURE CHOIXTYPECARTERIST(idTypeCarte VARCHAR2) AS
	 stmt2 VARCHAR2(300);
	 stmt VARCHAR2(300);
	 numAPB VARCHAR2(6);
	 suffNumCarte VARCHAR2(12);
	 numLastCarte VARCHAR2(13);
	 tmpCarte VARCHAR2(13);
	 tmp VARCHAR2(13);
	 seqChar VARCHAR2(15);
	 lenNumCarte INTEGER;
	 nbCartes INTEGER;
	 newIDSeqCarte INTEGER;
	 numSeq INTEGER;

	 CURSOR listNumCarte IS SELECT num_carte, t_crist_carte_id FROM BEL.t_crist_cartes;
	BEGIN

        suffNumCarte := '';
        numLastCarte := '';
        tmpCarte := '';
        newIDSeqCarte := 1;
        stmt2 := 'DROP SEQUENCE BEL.SEQ_NO_CRIST';
        nbCartes := 0;
        numSeq := 0;

        SELECT TRIM(valeur) INTO numAPB FROM BEL.T_PARAMETRES WHERE cle LIKE 'pha.apb';
        --Pas de gestion de cartes ristournes
        IF (idTypeCarte = '0') then
            UPDATE BEL.T_PARAMETRES
            SET valeur = NULL
            WHERE cle = 'crist.typeCarte';

            UPDATE BEL.T_PARAMETRES
            SET valeur = '0'
            WHERE cle = 'crist.utilisationCarte';

            UPDATE BEL.T_PARAMETRES
            SET valeur = NULL
            WHERE cle = 'crist.prefixeCarte';

        ELSE 
			IF (idTypeCarte = '1') THEN             --carte virtuel
				UPDATE BEL.T_PARAMETRES
				SET valeur = '1'
				WHERE cle = 'crist.typeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = 'VIRTUAL'
				WHERE cle = 'crist.prefixeCarte';

				--cartes imprimés en officine sur étqiuettes
			ELSIF (idTypeCarte = '2') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '2'
				WHERE cle = 'crist.typeCarte';

				IF (length(numAPB) = 6) THEN
					UPDATE BEL.T_PARAMETRES
					SET valeur = (SELECT CONCAT('A',numAPB) FROM DUAL)
					WHERE cle = 'crist.prefixeCarte';
				END IF;

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;
				 END LOOP;

				--cartes imprimés en officine et plastifié
			ELSIF (idTypeCarte = '3') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '3'
				WHERE cle = 'crist.typeCarte';

				IF (length(numAPB) = 6) THEN
					UPDATE BEL.T_PARAMETRES
					SET valeur = (SELECT CONCAT('A',numAPB) FROM DUAL)
					WHERE cle = 'crist.prefixeCarte';
				END IF;

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;
				 END LOOP;

			/* Cartes préimprimées */
			ELSIF (idTypeCarte = '4') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '4'
				WHERE cle = 'crist.typeCarte';

				IF (length(numAPB) = 6) THEN
					UPDATE BEL.T_PARAMETRES
					SET valeur = (SELECT CONCAT('A',numAPB) FROM DUAL)
					WHERE cle = 'crist.prefixeCarte';
				END IF;

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;

				 END LOOP;
			/* Carte Groupement */
			--Dans le cas des cartes suivantes il faut rajouter le parametre crist.gropement = à
			--0, "Dynaphar", "A"
			--1, "PharmaPass (APPL)", "B"
			--2, "Mon Pharmacien", "C"
			--3, "Lloydspharma" , "1"   ---inutile
			--4 Iasis ---> ?????
			--5 Vpharma    Axxxxxxxxxxxxxx

			--Mon pharmacien
			ELSIF (idTypeCarte = '5') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '5'
				WHERE cle = 'crist.typeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = 'C'
				WHERE cle = 'crist.prefixeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = '2'
				WHERE cle = 'crist.groupement';

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('C',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('C',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;

				 END LOOP;


			--PharmaPass
			ELSIF (idTypeCarte = '6') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '5'
				WHERE cle = 'crist.typeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = 'B'
				WHERE cle = 'crist.prefixeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = '1'
				WHERE cle = 'crist.groupement';

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('B',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('B',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;

				 END LOOP;
			--DynaPhar
			ELSIF (idTypeCarte = '7') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '5'
				WHERE cle = 'crist.typeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = 'A'
				WHERE cle = 'crist.prefixeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = '0'
				WHERE cle = 'crist.groupement';

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;

				 END LOOP;

			--Lloydspharma
			ELSIF (idTypeCarte = '8') THEN
				UPDATE BEL.T_PARAMETRES
				SET valeur = '5'
				WHERE cle = 'crist.typeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = '1'
				WHERE cle = 'crist.prefixeCarte';

				UPDATE BEL.T_PARAMETRES
				SET valeur = '5'
				WHERE cle = 'crist.groupement';

				FOR rec0 IN listNumCarte
				 LOOP
					 lenNumCarte := 0;
				   SELECT LENGTH(TRIM(rec0.num_carte)) INTO lenNumCarte FROM DUAL;

				   IF (lenNumCarte = 12) THEN
					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',TRIM(rec0.num_carte)) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;

					ELSIF (lenNumCarte = 13) THEN
					  SELECT SUBSTR(rec0.num_carte,2,12) INTO suffNumCarte FROM DUAL;

					   UPDATE BEL.t_crist_cartes
						SET num_carte = (SELECT CONCAT('A',suffNumCarte) FROM DUAL)
						WHERE t_crist_carte_id = rec0.t_crist_carte_id;
				   END IF;

				 END LOOP;

			END IF;

            UPDATE BEL.T_PARAMETRES
            SET valeur = '1'
            WHERE cle = 'crist.utilisationCarte';
        END IF;

        SELECT COUNT(*) INTO nbCartes    FROM BEL.t_crist_cartes;
        IF (nbCartes = 0) THEN
			begin
				savepoint sauvecrist;
			   EXECUTE IMMEDIATE stmt2;
				stmt := 'CREATE SEQUENCE BEL.SEQ_NO_CRIST
					START WITH 1
					 MAXVALUE 999999999999999999999999999
					 MINVALUE 1
					 NOCYCLE
					 NOCACHE
					 NOORDER';
				EXECUTE IMMEDIATE stmt;
				exception
					when sequence_inexistante then
						rollback to sauvecrist;      
			end;
        ELSE
          IF ((idTypeCarte = '2') OR (idTypeCarte = '3') OR (idTypeCarte = '4')) THEN
                SELECT max(num_carte) INTO numLastCarte FROM BEL.t_crist_cartes WHERE num_carte LIKE 'A' || numAPB || '%';
                SELECT SUBSTR(numLastCarte,8,6) INTO tmpCarte FROM DUAL;
             ELSIF (idTypeCarte = '1') THEN
              SELECT max(num_carte) INTO numLastCarte FROM BEL.t_crist_cartes WHERE num_carte LIKE 'VIRTUAL' || '%';
                SELECT SUBSTR(numLastCarte,8,6) INTO tmpCarte FROM DUAL;
          END IF;

            IF (length(tmpCarte) > 0) THEN
			    WHILE (length(tmpCarte) > 0) LOOP
                        tmp := '';
                        SELECT SUBSTR(tmpCarte,1,1) INTO tmp FROM DUAL;
                        IF ((tmp = '0') AND (length(tmpCarte) > 1)) THEN
                            SELECT SUBSTR(tmpCarte,2,(length(tmpCarte) - 1)) INTO tmpCarte FROM DUAL;
                        ELSE
                            EXIT;
                        END IF;
                END LOOP;

                SELECT (TO_NUMBER(tmpCarte) + 1) INTO numSeq FROM DUAL;
                SELECT TO_CHAR(numSeq) INTO seqChar FROM DUAL;

			
				begin
					savepoint sauvecrist;
					EXECUTE IMMEDIATE stmt2;
					stmt := 'CREATE SEQUENCE BEL.SEQ_NO_CRIST
						START WITH ' || seqChar || '
						 MAXVALUE 999999999999999999999999999
						 MINVALUE 1
						 NOCYCLE
						 NOCACHE
						 NOORDER';
					EXECUTE IMMEDIATE stmt;
					exception
						when sequence_inexistante then
							rollback to sauvecrist;  
				end;
			END IF;
        END IF;
  commit;
END CHOIXTYPECARTERIST;


FUNCTION Num_Max_Crist RETURN NUMBER
AS
 ipp number;
BEGIN
  begin
   select max(to_number(nvl(substr(num_carte,8,6),0))) into ipp from bel.t_crist_cartes where ISNUMERIC(nvl(substr(num_carte,8,6), 0)) = 1;
   RETURN ipp;
    exception
        when no_data_found then
           return 0;
    end; 
END Num_Max_Crist;

end pk_annexes;
/