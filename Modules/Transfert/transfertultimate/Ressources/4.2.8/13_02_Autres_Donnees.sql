create or replace package body migration.pk_autres_donnees as

	type tab_adresse is varray(8) of varchar(40);

	/* ********************************************************************************************** */
	procedure maj_parametre(
		acle in varchar2,
		avaleur in varchar2) 
	as                          
		ladresse tab_adresse;
		lintidadresse integer;
		lintidcpville integer;

		c_parametre_adresse constant varchar2(50) := 'pha.adresse';
		c_num_bloc constant varchar2(8) := 'num_bloc';
		c_num_ordo constant varchar2(8) := 'num_ordo';

		c_adresse_rue_1 constant integer := 1;
		c_adresse_rue_2 constant integer := 2;
		c_adresse_code_postal constant integer := 3;
		c_adresse_nom_ville constant integer := 4;
		c_adresse_tel_standard constant integer := 5;
		c_adresse_tel_personnel constant integer := 6;
		c_adresse_tel_mobile constant integer := 7;
		c_adresse_fax constant integer := 8;

		procedure decouper_chaine(
			achaine in varchar,
			aseparateur in char)
		as      
			lstrchaine varchar2(300) := achaine;
			i integer; lintpos integer;
		begin      
			ladresse := tab_adresse(); i := 0;
			while i < c_adresse_fax loop
				lintpos := instr(lstrchaine, aseparateur); 
				ladresse.extend(1); i := i + 1;        
				if lintpos > 0 then
					ladresse(i) := substr(lstrchaine, 1, lintpos - 1);
					lstrchaine := substr(lstrchaine, lintpos + 1, length(lstrchaine) - lintpos + 1);
				else
					ladresse(i) := lstrchaine;
					lstrchaine := '';
				end if;        
			end loop;
		end;

	begin
		if avaleur is not null then
			-- traitement de l'adresse    
			if lower(acle) = c_parametre_adresse then
				select valeur
				into lintidadresse
				from bel.t_parametres
				where cle = c_parametre_adresse;

				if lintidadresse is not null then
					select t_cpville_id
					into lintidcpville
					from bel.t_adresse
					where t_adresse_id = lintidadresse;

					decouper_chaine(avaleur, '|');
					update bel.t_cpville
					set codepostal = substr(ladresse(c_adresse_code_postal), 1, 5),
						nomville = substr(ladresse(c_adresse_nom_ville), 1, 30)
					where t_cpville_id = lintidcpville;

					update bel.t_adresse
					set rue1 = substr(ladresse(c_adresse_rue_1), 1, 40),
						rue2 = substr(ladresse(c_adresse_rue_2), 1, 40),
						telstandard = substr(ladresse(c_adresse_tel_standard), 1, 20),
						telpersonnel = substr(ladresse(c_adresse_tel_personnel), 1, 20),
						telmobile = substr(ladresse(c_adresse_tel_mobile), 1, 20),
						fax = substr(ladresse(c_adresse_fax), 1, 20)
					where t_adresse_id = lintidadresse;
				end if;
			elsif lower(acle) = c_num_bloc then
						pk_supprimer.initialiser_sequence('BEL.SEQ_NO_SCHEMA_MEDICATION',avaleur);
			elsif lower(acle) = c_num_ordo then
						pk_supprimer.initialiser_sequence('BEL.SEQ_NO_ORDONNANCE',avaleur);
			else -- maj parametre
					update bel.t_parametres
					set valeur = avaleur
					where lower(cle) = lower(acle);     
			end if;
		end if;
	end;
	
/* ********************************************************************************************** */
	function creationhisto_client_entete(
		ahisto_client_entete in varchar2,
		aclient in number,
		anumero_facture in number,
		acode_operateur in varchar2,
		apraticien_nom in varchar2,
		apraticien_prenom in varchar2,
		athe_type_facturation in number,
		adate_prescription in date,
		adate_acte in date,
		afusion in char) return number
	as
		chetat char(1);
		t_histo_client_entete_id number;
	begin
		begin
			select etat
			into chetat
			from migration.t_fusion_client
			where t_client_id = aclient;
		exception
			when no_data_found or too_many_rows then 
				chetat := '';   
		END;
		
		insert into bel.t_histo_client_entete(
			t_histo_client_entete_id,
			t_client_id,
			numero_facture,
			code_operateur,
			date_acte,
			date_prescription,
			date_maj,
			nom_medecin,
			prenom_medecin,
			the_type_facturation)
		values
			(bel.seq_pk_histo_client_entete.nextval,
			aclient,
			anumero_facture,
			acode_operateur,
			adate_acte,
			adate_prescription,
			to_date(to_char(sysdate, 'dd/mm/yyyy') || ' 00:00', 'dd/mm/yyyy hh24:mi'),
			apraticien_nom,
			apraticien_prenom,
			athe_type_facturation)
		returning t_histo_client_entete_id into t_histo_client_entete_id;


		return t_histo_client_entete_id;
	exception
		when others then
		raise;
	end;

/* ********************************************************************************************** */
	function creationhisto_client_ligne(
		ahisto_client_ligne in varchar2,
		aentete in number,
		acodecnk in varchar2,
		adesignation in varchar2,
		aqtefacturee in number,
		aprixvente in number,
		aproduitid in number,
		ARembourse IN VARCHAR
		) return number
	as
		idprod bel.t_produit.t_produit_id%type;
		design bel.t_produit.designation%type;
		codecnk bel.t_produit.codecip%type;
		t_histo_client_ligne_id number;
		-- lencnk number;
		--  cnkcorrect varchar2(7);
		i number;
	begin
		codecnk := lpad(acodecnk,7,'0');
		/*  if (acodecnk is not null) then
		codecnk := acodecnk;
		i := 1;
		select length(codecnk) into lencnk from dual;

		cnkcorrect := codecnk;
		while i <= (7 - lencnk) loop
		cnkcorrect := '0' || cnkcorrect;
		i := i + 1;
		end loop;
		codecnk := cnkcorrect;
		end if;*/

		if (((aproduitid is null) or (adesignation is null)) and (codecnk is not null)) then
			begin
				select t_produit_id, designation 
				into idprod, design 
				from bel.t_produit 
				where codecip = codecnk;
			exception
				when no_data_found then
					idprod := null;
					design := null;
			end;
		else
			idprod := aproduitid;
			design := adesignation;
		end if;

		insert into bel.t_histo_client_ligne(
			t_histo_client_ligne_id,
			t_histo_client_entete_id,
			codecip,
			designation,
			qtefacturee,
			prixvente,
			t_produit_id,
			rembourse)
		values
			(bel.seq_pk_histo_client_ligne.nextval,
			aentete,
			codecnk,
			design,
			aqtefacturee,
			aprixvente,
			idprod,
			ARembourse  )
		returning t_histo_client_ligne_id into t_histo_client_ligne_id;

		return t_histo_client_ligne_id;
	exception
		when others then
		raise;
	end;

	function creationhisto_client_magis(
		ahisto_client_magistrale in varchar2,
		aentete in number,
		adesignation in varchar2,
		aqtefacturee in number,
		adetail in varchar2
		) return number
	as  
		t_histo_client_ligne_id number;
	begin
		insert into bel.t_histo_client_ligne(
			t_histo_client_ligne_id,
			t_histo_client_entete_id,
			designation,
			qtefacturee,
			detail)
		values (
			bel.seq_pk_histo_client_ligne.nextval,
			aentete,
			adesignation,
			aqtefacturee,
			adetail)
		returning t_histo_client_ligne_id into t_histo_client_ligne_id;
		
		return t_histo_client_ligne_id;
	exception
		when others then
		raise;
	end;

	function creationhistovente(
		ahistovente in varchar2,
		aannee in number,
		amois in number,
		aperiode in date,
		aspeserie in number,
		aqtevendue in number,
		anbvente in number
		) return number
	as
		t_histovente_id number;
	begin
		insert into bel.t_historiquevente (
			t_historiquevente_id,
			annee,
			mois,
			qtevendue,
			nbventes,
			datemajhistvte,
			t_produit_id,
			moisannee)
		values
			(bel.seq_id_historiquevente.nextval,
			aannee,
			amois,
			aqtevendue,
			anbvente,
			to_date(to_char(sysdate, 'dd/mm/yyyy') || ' 00:00', 'dd/mm/yyyy hh24:mi'),
			aspeserie,
			aperiode)
		returning t_historiquevente_id into t_histovente_id;

		return t_histovente_id;
	exception
		when others then
		raise;
	end;

	procedure creationhistoriqueachat(
		aidproduit in integer,
		anombreachatsrepartiteur in number,
		aquantiteacheteerepartiteur in number,
		anombreachatsdirecte in number,
		aquantiteacheteedirecte in number,
		amois in smallint,
		aannee in smallint) 
	as
	begin
		insert into bel.t_historiqueachatcumule(
			t_histachatcumule_id,
			moisannee,
			qteacheteerep,
			nbachatsrep,
			qteacheteedir,
			nbachatsdir,
			datemajhistachatcumule,
			t_produit_id)
		values(
			bel.seq_id_historiqueachatcumule.nextval,
			to_date('01' || lpad(amois, 2, '0') || aannee, 'ddmmyyyy'),
			aquantiteacheteerepartiteur,
			anombreachatsrepartiteur,
			aquantiteacheteedirecte,
			anombreachatsdirecte,
			sysdate,
			aidproduit);
	exception
		when others then
		raise;
	end;
	
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
) RETURN NUMBER
AS
BEGIN
	savepoint medproduit;

insert into BEL.t_sch_medication_produit(
	t_sch_medication_produit_id
	,t_aad_id
	,t_produit_id
	,libelle
	,typeformedpp
	,typemedication
	,date_debut
	,date_fin
	,commentaire
	,t_magi_formule_id
	,date_debut_susp
	,date_fin_susp
)
VALUES (
	bel.seq_id_sch_medication_produit.nextval
	,at_aad_id
	,at_produit_id
	,alibelle
	,atypeformedpp
	,atypemedication
	,adate_debut
	,adate_fin
	,acommentaire
	,at_formule_id
	,adate_debut_susp
	,adate_fin_susp
)
RETURNING t_sch_medication_produit_id INTO t_sch_medication_produit_id;

RETURN t_sch_medication_produit_id;

  EXCEPTION
    WHEN OTHERS then
     rollback to medproduit;
     raise;
END CreationMedicationProduit;

FUNCTION CreationMedicationPrise(
	aT_SCH_MEDICATION_PRISE_ID IN VARCHAR2, 
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
	aNB_JOURS IN NUMBER, 
	T_sch_medication_prise_id OUT NUMBER
) RETURN NUMBER
AS
BEGIN
	savepoint medprise;

	insert into BEL.t_sch_medication_prise(
		T_SCH_MEDICATION_PRISE_ID , 
		T_SCH_MEDICATION_PRODUIT_ID , 
		TYPE_FREQUENCE ,
		FREQUENCE_JOURS, 
		PRISE_LEVER , 
		PRISE_PTDEJ , 
		TYPE_MOMENT_PTDEJ , 
		PRISE_MIDI , 
		TYPE_MOMENT_MIDI , 
		PRISE_SOUPER , 
		TYPE_MOMENT_SOUPER , 
		PRISE_COUCHER , 
		NB_JOURS
	)
	VALUES (
		bel.seq_id_sch_medication_prise.nextval,
		aT_SCH_MEDICATION_PRODUIT_ID , 
		aTYPE_FREQUENCE ,
		aFREQUENCE_JOURS, 
		aPRISE_LEVER , 
		aPRISE_PTDEJ , 
		aTYPE_MOMENT_PTDEJ , 
		aPRISE_MIDI , 
		aTYPE_MOMENT_MIDI , 
		aPRISE_SOUPER , 
		aTYPE_MOMENT_SOUPER , 
		aPRISE_COUCHER , 
		aNB_JOURS
	)
	RETURNING t_sch_medication_prise_id INTO t_sch_medication_prise_id;

	if aPRISE_10HEURES > 0 then
		insert into bel.t_medication_heure_prise
			(t_medication_heure_prise_id, t_sch_medication_prise_id, qte_prise, heure_prise)
		values
			(bel.seq_id_medication_heure_prise.nextval, t_sch_medication_prise_id, aprise_10heures, '1000');
	end if;

	if aPRISE_16HEURES > 0 then
		insert into bel.t_medication_heure_prise
			(t_medication_heure_prise_id, t_sch_medication_prise_id, qte_prise, heure_prise)
		values
			(bel.seq_id_medication_heure_prise.nextval, t_sch_medication_prise_id, aprise_16heures, '1600');
	end if;
			
	if aPRISE_HEURE1 > 0 then
		insert into bel.t_medication_heure_prise
			(t_medication_heure_prise_id, t_sch_medication_prise_id, qte_prise, heure_prise)
		values
			(bel.seq_id_medication_heure_prise.nextval, t_sch_medication_prise_id, aprise_heure1, alibelle_heure1);
	end if;
			
	if aPRISE_HEURE2 > 0 then
		insert into bel.t_medication_heure_prise
			(t_medication_heure_prise_id, t_sch_medication_prise_id, qte_prise, heure_prise)
		values
			(bel.seq_id_medication_heure_prise.nextval, t_sch_medication_prise_id, aprise_heure2, alibelle_heure2);
	end if;
			
	if aPRISE_HEURE3 > 0 then
		insert into bel.t_medication_heure_prise
			(t_medication_heure_prise_id, t_sch_medication_prise_id, qte_prise, heure_prise)
		values
			(bel.seq_id_medication_heure_prise.nextval, t_sch_medication_prise_id, aprise_heure3, alibelle_heure3);
	end if;

	RETURN t_sch_medication_prise_id;

	EXCEPTION
	WHEN OTHERS then
		rollback to medprise;
		raise;
END CreationMedicationPrise;

--------------------------------------------------------

FUNCTION CreationSoldePatientTUH(
	AT_AAD_ID IN VARCHAR2,
	AT_PRODUIT_ID IN VARCHAR2,
	ASOLDE IN NUMBER,
	ANOORD IN NUMBER,
	ADATE_ORDO IN DATE,
	ACATREMB IN NUMBER,
	ACONDREMB IN NUMBER,
	AT_PRATICIEN_ID IN VARCHAR2,
	At_type_tuh IN NUMBER,  --1 patient, 2 boite mutu, 3 pmi pharmacie
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
) RETURN NUMBER
AS
    idOperateur INTEGER;
    idPosteTravail INTEGER;
    idActe INTEGER;
    idFacture INTEGER;
    idVente INTEGER;
	
    idaad bel.t_assureayantdroit.t_aad_id%TYPE;
    idprat bel.t_praticienprive.t_praticienprive_id%TYPE;
    idCollectivite bel.T_COLLECTIVITE.NO_COLLECTIVITE%TYPE :=0;
    acodecip bel.T_PRODUIT.CODECIP%TYPE;
    nomProduit bel.T_PRODUIT.DESIGNATION%TYPE;
    vCodeInami BDDB.T_APB_TAR43.CODEINAMI%TYPE;
	vNO_ATTESTATION bel.t_lignevente.NO_ATTESTATION%type;
	vFINVALIDITE_ATTEST bel.t_lignevente.FINVALIDITE_ATTEST%type;
BEGIN
    savepoint soldetuh;
		
    select t_operateur_id into idOperateur from bel.t_operateur where codeoperateur = '.';
    select T_ID_POSTEDETRAVAIL into idPosteTravail from bel.t_postedetravail where rownum=1 order by T_ID_POSTEDETRAVAIL;   

	begin
		select t_aad_id into idaad from bel.t_assureayantdroit where t_aad_id = AT_AAD_ID;
	EXCEPTION
		When NO_DATA_FOUND then 
			raise_application_error(-20100, 'ID du Patient non trouvé !');
	end;
	
	begin
		select t_praticienprive_id into idprat from bel.t_praticienprive where t_praticienprive_id = AT_PRATICIEN_ID;
	EXCEPTION
		When NO_DATA_FOUND then 
			raise_application_error(-20100, 'ID du Praticien non trouvé !');
	end;

	IF (ACATREMB =0 ) THEN
		RAISE_APPLICATION_ERROR (-20100, 'Catégorie produit obligatoire !');
    END IF;
		
    begin 
		select t_facture_id, ID_ACTE into idFacture, idacte  from bel.t_facture where numero_facture=ANOORD;	
	EXCEPTION
		When NO_DATA_FOUND then 
		  idfacture:=0;idacte:=0;
	end;
	
	--création nouvelle acte nouvelle facture pour nouvelle ordo 
	if(idfacture=0) then
		
		Insert into BEL.T_ACTE  
			(T_ACTE_ID, T_OPERATEUR_ID, T_POSTEDETRAVAIL_ID, DATEACTE, TERMINE, VALIDE, SIGNE, T_TIROIRCAISSE_ID, TYPEACTE, OSPHARM, PFC, QUALIPHARMA, PHARMASTAT, NEPENSTAT_VENTE, NEPENSTAT_STOCK, PIERREFABRE, ACNIELSEN, TRACE_DEL)
		 Values
			(bel.SEQ_ID_ACTE.nextVal, idOperateur, idPosteTravail, sysdate, '1', '0', '0', 0, '1', '0', '0', '0', '0', '0', '0', '0', '0', '0')
		RETURNING T_ACTE_ID INTO idacte;
		
		begin
			select NO_COLLECTIVITE into idCollectivite from bel.T_COLLECTIVITE where t_aad_id = idAad and rownum = 1;
		EXCEPTION
		When NO_DATA_FOUND then 
			raise_application_error(-20100, 'Collectivité du patient non trouvé !');
		end;
		
		update bel.t_assureayantdroit set MRS = '1' where t_aad_id = idCollectivite;
		
		Insert into BEL.T_FACTURE    -- date_execution = date ordo
			(T_FACTURE_ID, DATE_MAJ, ID_ACTE, T_OPERATEUR_ID, ETAT_FACTURE, DATE_EXECUTION, CODE_OPERATEUR, THE_TYPE_FACTURATION, TOTAL_FACTURE, MONTANT_ASSURE, 
				REMISE, TYPE_REMISE, TOTAL_REMISE, EXONERATION_TVA, T_CLIENT_ID, NOM_CLIENT, PRENOM_CLIENT, NUMERO_INSEE, DATE_NAISSANCE, sexe, numero_facture, t_aad_destinataire_id,
				t_organisme_amo_id, identifiantoa, t_typeoa_oa_id, categoriebenef_oa, noinscription_oa, date_debut_ass_oa, date_fin_ass_oa, ct1, ct2, version_assurabilite, dern_lecture_sis, no_carte_sis, 
				certificat_lecture, typepiecejustificative , t_organisme_amc_id, identifiantoc, t_typeoa_oc_id, categoriebenef_oc, noinscription_oc, date_debut_ass_oc, date_fin_ass_oc, payeur, 
				t_praticien_prive_id,nom_praticien, prenom_praticien, identification_praticien, code_specialite_praticien, categorie_praticien, suspend_manuel, DATEDEBVALIDITEPIECE, DATEFINVALIDITEPIECE, DATEDERNCONSULT_MYCARENET) 
				select  BEL.SEQ_ID_FACTURE.nextVal, sysdate, idActe, idOperateur, 'V', ADATE_ORDO, '.', 2, 0, 0,
				0, 'P', 0, '0', AT_AAD_ID, a.nom, a.prenom, a.numeroinsee,a.datenaissance , a.sexe, coalesce(ANOORD, (select max(numero_facture) + 1 from bel.t_facture)), idCollectivite,
				a.t_organismeamo_id, oa.identifiant, oa.t_typeoa_id, a.categoriebenefoa, aoa.num_inscription, ADATE_DEBUT_ASS_OA, ADATE_FIN_ASS_OA, ACT1, ACT2, a.versionassurabilite, a.datedernierelecturesis, a.numerocartesis, 
				a.certificatcartesis, a.natpiecejustifdroit, a.t_organismeamc_id, oc.identifiant, oc.t_typeoa_id, a.categoriebenefoc, aoc.num_inscription, aoc.datedebutdroit, aoc.datefindroit,'C',
				pp.t_praticienprive_id,pp.nom, pp.prenom, pp.identification, pp.t_specialite_id, pp.categorie, AOrdo_Suspendu, ADATEDEBVALIDITEPIECE, ADATEFINVALIDITEPIECE, ADATEDERNCONSULT_MYCARENET
			from bel.t_praticienprive pp, bel.t_assureayantdroit a
			left join bel.t_organismeamo oa on (oa.t_organismeamo_id=a.t_organismeamo_id)
			left join bel.t_assurabilite aoa on (aoa.t_assurabilite_id=a.t_assurabiliteoa_id)
			left join bel.t_organismeamc oc on (oc.t_organismeamc_id=a.t_organismeamc_id)
			left join bel.t_assurabilite aoc on (aoc.t_assurabilite_id=a.t_assurabiliteoc_id)
			where t_aad_id = AT_AAD_ID and t_praticienprive_id= at_praticien_id;
			
			select bel.SEQ_ID_FACTURE.currVal into idfacture from dual;
							
			Insert into BEL.T_VENTILATION_TVA_FACTURE
			   	(T_FACTURE_ID, T_TVA_ID, MONTANT_HT, MONTANT_TTC, MONTANT_TVA, TAUX_TVA, REMISE_TTC, REMISE_HT, REMISE_TVA, T_VENTILATION_TVA_FACTURE_ID, REMB_TTC, REMB_HT, RISTOURNE_TTC, RISTOURNE_HT, RISTOURNE_TVA, 
				MTCLIENT_TTC, MTCLIENT_HT, REMBAMO_HT, REMBAMO_TTC, REMBAMC_HT, REMBAMC_TTC)
			Values
				(idFacture, 4, 0, 0, 0, 6, 0, 0, 0, bel.SEQ_ID_VENTILATION.nextVal, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	end if;
            
	if(idFacture > 0) then
	
		begin
			select codecip,substr(DESIGNATION,1,99) into acodecip,nomProduit from bel.t_produit where t_produit_id = AT_PRODUIT_ID; 
		EXCEPTION
			when NO_DATA_FOUND then
				raise_application_error(-20100, 'Produit non trouvé');
		end;
				
		begin
			select codeinami into vCodeInami from bddb.t_apb_tar43 where cnk = acodecip;
		EXCEPTION
			when NO_DATA_FOUND then
				vCodeInami := null;
		end;
		
		if (ACONDREMB in (2,5,7)) then 
			begin
				select max(noattestation), max(datefinvalidite) into vNO_ATTESTATION,vFINVALIDITE_ATTEST from bel.t_attestationremb where t_produit_id = at_produit_id and t_aad_id = AT_AAD_ID;
			EXCEPTION
				when NO_DATA_FOUND then
					vNO_ATTESTATION :=null;
					vFINVALIDITE_ATTEST := null;
			end;		
		end if;		
				
		Insert into BEL.T_LIGNEVENTE
		  	(T_LIGNEVENTE_ID, QTEFACTUREE, NOORDONNANCIER, QTEDELIVREE, QTEMANQUANTE, DATEMAJLIGNEVENTE, T_FACTURE_ID, TYPEFACTURATION, T_PRODUIT_ID, T_TVA_ID, POURCENTAGE_REMISE, PRIXVENTE, BASEREMBOURSEMENT, MONTANTLIGNE, 
			REMBAMO, REMBAMC, TM_OA, TM_OC, PAHT_BRUT, TAUXTVA, SAISIR_CBU, SAISIR_NOLOT, SUIVI_INTERESSEMENT, VETERINAIRE, DELAILAIT, DELAIVIANDE, PVTTC_FICHIER, PAHT_REMISE, PAMP, PVHT, PVHTREMISE, QUANTITE_REGUL_VA_PAYEE, 
			DESIGNATION_FR, DESIGNATION_NL, T_CATEGORIE_PRODUIT_ID, EDITION_704, EDITION_BVAC, QUANTITE_DIFFEREE, DETTE_CBU, REMISEDIRECTE, RISTOURNEFINANNEE, PRIXCLIENT, PRESCRIPTION_DCI, DELDIFF_REMB_INAMI, COMPRESSE_CHIMIQUE, 
			DETTE_NOLOT, REMMANUEL, RISTMANUEL, HONO_URGENCE, HOMEO_REMB, MTASSUREHT, TYPE_DEMANDE_ECRITE, PRESTATION_OXYGENE, REMBAMOHT, REMBAMCHT, SAISIE_MANUELLE_PEC_CPAS, QTERESERVEE, RESERV_NONPAYEE, INFO_TP_DDIFF_APPLICABLE, 
			MASQUER_RENOUVELLEMENT, FORCAGE_REGISTRE_STUP, FORCER_SANS_NOLOT, IS_AVEC_HONO_DCI_NSR, IS_AVEC_HONO_CHAP_IV_NSR, IS_AVEC_FIRST_DATA_NSR, PV_EX_USINE_NSR, MARGE_GROSSISTE_NSR, MARGE_ECO_NSR, HONO_DISPENSATION_NSR, 
			ID_LIGNEVENTE_NSR, PORTEUSE_AVANTAGE_PROMOTION, ID_LV_INITIATRICE_PROMOTION, REMPROMO, RISTPROMO, TARIF_PERSONNALISE, FACTURABLE, T_LIGNEVENTE_MATLOC_ID, APPEL_AEGATE, DECOND_FOUR, CLUSTERDCI, STATUTDPP, FORCER_DESTOCKAGE, 
			MAX_OA_TENSIOMETRE, TRAJETSOIN_ID, TUH, FORCE_TUH, TUH_PRODUIT, QTEDELIVREE_TUH,CODECIP,CODEINAMI,TYPE_CAT_REMB,TYPE_COND_REMB, NO_ATTESTATION , FINVALIDITE_ATTEST)
		 Values
			(bel.SEQ_ID_LIGNEVENTE.nextVal, 1, 0, 1, 0, sysdate, idFacture, 2, at_produit_id, 4, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 6, decode(acbu,null,'0','1'), '0', '0', '0', 0, 0, 0, 0, 0, 0, 0, 0, nomProduit, nomProduit, 14, '0', '0', 0, '0', 0, 0, 0,
			'0', '0', '0', '0', '0', '0', '0', '0', 0, 0, '0', 0, 0, '0', 0, '0', '0', '0', '0', '0', '0', '0', '0', 0, 0, 0, 0, 0, '0', 0, '0', '0', '0', '1', 0, '0', '0', 0, 1, '0',
			'0', 0, decode(At_type_tuh,1,1,3), '0', '1', ASOLDE,acodecip,vCodeInami,ACATREMB, ACONDREMB, vNO_ATTESTATION, vFINVALIDITE_ATTEST)
		RETURNING T_LIGNEVENTE_ID INTO idvente;
		
		if (acbu is not null) then
			insert into bel.t_lignevente_cbu(
				t_lignevente_cbu_id,
				code,
				t_lignevente_id,
				datemaj)
			values(
				bel.seq_id_lignevente_cbu.nextval,
				trim(acbu),
				idvente,
				to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'));
		end if;
		
		if (At_type_tuh=1) then --on ne créé la boite tuh que si on est en stock patient
			Insert into BEL.T_BOITE_TUH
				(T_BOITE_TUH_ID, T_PRODUIT_ID, SAISIR_CBU, CBU, CODE_INAMI, PAHT_BRUT, PAHT_REMISE, PAMP, CONTENANCE_INITIALE, STOCK_RESTANT, DATE_DESTOCKAGE, T_ADHERENT_ID)
			Values
				(bel.SEQ_ID_BOITE_TUH.nextVal, at_Produit_id, decode(acbu,null,'0','1') , acbu, vCodeInami, 0, 0, 0, ASOLDE, ASOLDE, sysdate, AT_AAD_ID);
		end if;
	end if;

	RETURN idvente;
	
    EXCEPTION
	WHEN OTHERS then
		rollback to soldetuh;
		raise;
end CreationSoldePatientTUH;    


FUNCTION CreationSoldeBoiteTUH(
	AT_COLLECTIVITE_ID IN VARCHAR2, --si null stock pharmacie
	AT_PRODUIT_ID IN VARCHAR2,
	ASOLDE IN NUMBER,
	T_TUH_SOLDE_BOITE_ID OUT NUMBER
) RETURN NUMBER
AS
    acodecip bel.T_PRODUIT.CODECIP%TYPE;
    vCodeInami BDDB.T_APB_TAR43.CODEINAMI%TYPE;
	idboite integer;
BEGIN
    savepoint soldetuh;

	begin
		select codecip into acodecip from bel.t_produit where t_produit_id = AT_PRODUIT_ID; 
	EXCEPTION
		when NO_DATA_FOUND then
			raise_application_error(-20100, 'Produit non trouvé');
	end;
			
	begin
		select codeinami into vCodeInami from bddb.t_apb_tar43 where cnk = acodecip;
	EXCEPTION
		when NO_DATA_FOUND then
			vCodeInami := null;
	end;
	
	Insert into BEL.T_BOITE_TUH
	  	(T_BOITE_TUH_ID, T_PRODUIT_ID, SAISIR_CBU, CODE_INAMI, PAHT_BRUT, PAHT_REMISE, PAMP, CONTENANCE_INITIALE, STOCK_RESTANT, DATE_DESTOCKAGE, T_COLLECTIVITE_ID, PHARMACIE)
	 Values
	   	(bel.SEQ_ID_BOITE_TUH.nextVal, at_Produit_id, '0', vCodeInami, 0, 0, 0, ASOLDE, ASOLDE, sysdate, AT_COLLECTIVITE_ID,decode(AT_COLLECTIVITE_ID,null,'1','0'))
	RETURNING T_BOITE_TUH_ID INTO idboite;
	
	RETURN idboite;
	
    EXCEPTION
	WHEN OTHERS then
		rollback to soldetuh;
		raise;
end CreationSoldeBoiteTUH;    

end;
/