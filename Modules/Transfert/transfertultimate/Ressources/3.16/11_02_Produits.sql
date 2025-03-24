CREATE OR REPLACE package body MIGRATION.pk_produits as

FUNCTION CreationDepot(
	ADEPOT IN VARCHAR2,
	ALIBELLE IN VARCHAR2,
	AAUTOMATE IN NUMBER,
	T_Depot_ID OUT NUMBER
)RETURN NUMBER
AS
	idDepot BEL.T_DEPOT.T_DEPOT_ID%TYPE;
	idDep BEL.T_DEPOT.T_DEPOT_ID%TYPE;

	CURSOR cursDep (lib IN VARCHAR2) IS SELECT t_depot_id FROM bel.t_depot WHERE libelle = trim(lib);
BEGIN
	idDepot := 0;
	OPEN cursDep(ALIBELLE);
	FETCH cursDep INTO idDepot;
	CLOSE cursDep;

    IF (idDepot = 0) THEN
		INSERT INTO bel.t_depot(
			t_depot_id,
			libelle,
			datemajdepot,
			pourcentage,
			automate)
		VALUES(
			bel.seq_id_depot.NEXTVAL,
			trim(ALIBELLE),
			to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
			NULL,
			AAUTOMATE)
			RETURNING t_depot_id into T_Depot_ID;
	ELSE
		T_Depot_ID := idDepot;
	END IF;

	RETURN T_Depot_ID;
	EXCEPTION
    WHEN OTHERS then
		raise;
END CreationDepot;

FUNCTION CreationZoneGeo(
	AZoneGeo IN VARCHAR2,
	ALibelle IN VARCHAR2,
	T_zonegeo_ID OUT NUMBER
	) RETURN NUMBER
AS
    /*lIntzonegeo bel.t_zonegeographique.t_zonegeo_id%TYPE;*/
BEGIN
    /* lIntzonegeo := 0;
    SELECT COUNT(*) INTO lIntzonegeo FROM bel.t_zonegeographique WHERE libelle = ALibelle;

 	IF (lIntzonegeo = 0) THEN */
	INSERT INTO bel.t_zonegeographique(
		t_zonegeo_id,
		datemajzonegeo,
		libelle)
	VALUES(
		bel.seq_id_zonegeographique.NEXTVAL,
		to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
		ALibelle)
        RETURNING t_zonegeo_id into T_zonegeo_ID;
	--INSERT INTO tw_zonegeo(zonegeo,zonegeo_lgpi) VALUES(AZoneGeo,T_zonegeo_ID);
	RETURN T_zonegeo_ID;
  /*ELSE
		INSERT INTO tw_zonegeo(zonegeo,zonegeo_lgpi)
		VALUES(AZoneGeo,lIntzonegeo);
    RETURN 0;
  END IF;*/

  EXCEPTION
    WHEN OTHERS then
    	raise;
END CreationZoneGeo;

FUNCTION CreationProduit(
	APRODUIT IN VARCHAR2,
	ACODECNK IN VARCHAR2,
	ADESIGNATION IN VARCHAR2,
	ADESIGNATIONNL IN VARCHAR2,
	AAVEC_CBU IN VARCHAR2,
	AGEREINTERESSEMENT IN VARCHAR2,
	ACOMMENTAIREVENTE IN VARCHAR2,
	AGERESUIVICLIENT IN VARCHAR2,
	ATRACABILITE IN VARCHAR2,
	APROFILGS IN VARCHAR2,
	ACALCULGS IN VARCHAR2,
	AVETERINAIRE IN VARCHAR2,
	AVIDEO IN VARCHAR2,
	ADESIGNATIONLIBREPOSSIBLE IN VARCHAR2,
	AFRIGO IN VARCHAR2,
	APEREMPTIONCOURTE IN VARCHAR2,
	ACATPROD IN VARCHAR2,
	ASTATUTCOMMERC IN VARCHAR2,
	AUSAGEPROD IN VARCHAR2,
	AREMISEINTERDITE IN VARCHAR2,
	ARISTOURNEINTERDITE IN VARCHAR2,
	APDTPROPRE IN VARCHAR2,
	ATVA IN NUMBER,
	APRIXVENTE IN NUMBER,
	APRIXACHATCATALOGUE    IN NUMBER,
	ALABO IN VARCHAR2,
	ACONCESS IN VARCHAR2,
	ASTOCKMINI IN NUMBER,
	ASTOCKMAXI IN NUMBER,
	ADATEDERNDELIV IN DATE,
	ADATEPEREMPTION IN DATE,
	AZONELIBRE IN VARCHAR2,
	ATAUXREMISE IN NUMBER,
	ATAUXRIST IN NUMBER,
	AVENTILATION IN VARCHAR2,
	ACREATIONLGCMD IN VARCHAR2,
	ACLASSIFINT IN NUMBER,
	ATYPEPRIXBLOQUE IN NUMBER,
	ADESIGNATIONBLOQUEE IN VARCHAR2,
	AFICHEBLOQUEE IN VARCHAR2,
	AFUSION IN CHAR
) RETURN NUMBER
AS
idTVA BEL.T_TVA.T_TVA_ID%TYPE;
idCateg BEL.T_CATEGORIE_PRODUIT.T_CATEGORIE_PRODUIT_ID%TYPE;
idUsage BEL.T_USAGE_PRODUIT.T_USAGE_PRODUIT_ID%TYPE;
idStatusComm BEL.T_STATUT_COMMERCIAL.T_STATUT_COMMERCIAL_ID%TYPE;
/*idLabo bel.t_laboratoire.t_laboratoire_id%TYPE;*/  /* V1.02 b5 patch3 */
idFou BEL.t_fournisseurdirect.t_fournisseurdirect_id%TYPE;  /* V1.03 b1 */
idCodif bel.t_codif2.t_codif2_id%TYPE;
idCodif2 bel.t_produit.t_codif2_id%TYPE;
idCodif3 bel.t_produit.t_codif3_id%TYPE;
idCodif4 bel.t_produit.t_codif4_id%TYPE;
codeCNK bel.t_produit.codecip%TYPE;
DateDernvente bel.t_produit.datedernvte%TYPE;
t_produit_id number;
tmpCNK VARCHAR2(6);
i NUMBER;
lenCnk NUMBER;
cnkCorrect VARCHAR2(7);
chifferCNK NUMBER;
checkSumCNK NUMBER;

PROCEDURE researchIDCategProd(code IN VARCHAR2)
	AS
	categ BEL.T_CATEGORIE_PRODUIT.T_CATEGORIE_PRODUIT_ID%TYPE;
	CURSOR cursCateg(codeCat IN VARCHAR2) IS SELECT T_CATEGORIE_PRODUIT_ID from BEL.T_CATEGORIE_PRODUIT where code = trim(codeCat);

	BEGIN
		categ  := 0;
		OPEN cursCateg(code);
		FETCH cursCateg INTO categ;
		CLOSE cursCateg;

		IF (categ  <> 0) THEN
			idCateg := categ;
		ELSE
			idCateg := NULL;
		END IF;
	END researchIDCategProd;

PROCEDURE researchIDUsageProd(code IN VARCHAR2)
	AS
	usage BEL.T_USAGE_PRODUIT.T_USAGE_PRODUIT_ID%TYPE;
	CURSOR cursUsag(codeUsage IN VARCHAR2) IS SELECT T_USAGE_PRODUIT_ID from BEL.T_USAGE_PRODUIT where code = trim(codeUsage);

	BEGIN
		usage := 0;
		OPEN cursUsag(code);
		FETCH cursUsag INTO usage;
		CLOSE cursUsag;

		IF (usage  <> 0) THEN
		  idUsage := usage;
		ELSE
		  idUsage := 1;
		END IF;
	END researchIDUsageProd;

PROCEDURE researchIDStatusCommProd(code IN VARCHAR2)
	AS
		stat BEL.T_STATUT_COMMERCIAL.T_STATUT_COMMERCIAL_ID%TYPE;
		CURSOR cursStat(codeStat IN VARCHAR2) IS SELECT T_STATUT_COMMERCIAL_ID from BEL.T_STATUT_COMMERCIAL where code = trim(codeStat);
	BEGIN
		stat := 0;
		OPEN cursStat(code);
		FETCH cursStat INTO stat;
		CLOSE cursStat;

		IF (stat <> 0) THEN
		  idStatusComm := stat;
		ELSE
		  idStatusComm := NULL;
		END IF;
	END researchIDStatusCommProd;

PROCEDURE researchIDTauxTVA(taux IN VARCHAR2)
	AS
		tvaID BEL.T_TVA.T_TVA_ID%TYPE;
		CURSOR cursTva(taux IN VARCHAR2) IS SELECT T_TVA_ID from BEL.T_TVA where tauxtva = taux;

	BEGIN
		tvaID := 0;
		OPEN cursTva(taux);
		FETCH cursTva INTO tvaID;
		CLOSE cursTva;

		IF (tvaID <> 0) THEN
			idTVA := tvaID;
		ELSE
			idTVA := NULL;
		END IF;
	END researchIDTauxTVA;

BEGIN
	savepoint ProduitSP;
	--de 0900000 à  0999999
	if ((ACODECNK <10000) OR ((APDTPROPRE='1') and (ACODECNK <>''))) then --produit propre
		codeCNK :='09'||substr(lpad(ACODECNK,7,'0'), 3, 5);
	else
		codeCNK := lpad(ACODECNK,7,'0');
	end if;

	begin
		select T_PRODUIT_ID into T_PRODUIT_ID from bel.t_produit where codecip=codeCNK;
		EXCEPTION
		When NO_DATA_FOUND then
			T_PRODUIT_ID:=0;
	end;

	--IF afusion = '0' then    --Fusion des produits non fait

	researchIDTauxTVA(ATVA);
	researchIDCategProd(ACATPROD);
	researchIDUsageProd(AUSAGEPROD);
	researchIDStatusCommProd(ASTATUTCOMMERC);

	idCodif2 := NULL;
	idCodif3 := NULL;
	idCodif4 := NULL;
	idFou := NULL;


	idCodif := NULL;
	IF (AZONELIBRE IS NOT NULL) THEN
		begin
			SELECT t_codif2_id INTO idCodif FROM bel.T_CODIF2 WHERE libelle LIKE 'Zone libre: '||AZONELIBRE;
		exception
		when no_data_found then
			idCodif := NULL;
			end;

		IF (idCodif IS NULL) THEN
			INSERT INTO bel.t_codif2(t_codif2_id,libelle,datemajcodif2) VALUES(bel.seq_id_codif2.Nextval,'Zone libre: '||AZONELIBRE,to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'));
			SELECT bel.seq_id_codif2.Currval INTO idCodif2 FROM dual;
		ELSE
			idCodif2 := idCodif;
		END IF;
	END IF;

	idCodif := NULL;
	IF (AVENTILATION IS NOT NULL) THEN
		begin
			SELECT t_codif2_id INTO idCodif FROM bel.T_CODIF2 WHERE libelle LIKE AVENTILATION;
		exception
		when no_data_found then
			idCodif := NULL;
		end;

		IF (idCodif IS NULL) THEN
			INSERT INTO bel.t_codif2(t_codif2_id,libelle,datemajcodif2) VALUES(bel.seq_id_codif2.Nextval,AVENTILATION,to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'));
			SELECT bel.seq_id_codif2.Currval INTO idCodif2 FROM DUAL;
		ELSE
			idCodif2 := idCodif;
		END IF;
	END IF;

	IF (ALABO IS NOT NULL) THEN
		begin
			SELECT t_fournisseurdirect_id
			INTO idFou
			FROM bel.t_fournisseurdirect
			WHERE code_apb = trim(ALABO);
		exception
		when no_data_found then
			idFou:=null;
		end; /* V1.03 b1 */
	END IF;

	IF (ADATEDERNDELIV IS NULL) then
		DateDernvente := to_date('01/01/1900','DD/MM/YYYY');
	ELSE
		DateDernvente := ADATEDERNDELIV;
	END IF;

--codecnk = '' = null
	if (T_PRODUIT_ID=0 ) then

		INSERT INTO BEL.T_PRODUIT(
			t_produit_id,
			codecip,
			designation,
			designation_nl,
			avec_cbu,
			gereinteressement,
			commentairevente,
			geresuiviclient,
			datedernmajproduit,
			tracabilite,
			stockmini,
			stockmaxi,
			profilgs,
			calculgs,
			datedernvte,
			veterinaire,
			video,
			designationlibrepossible,
			peremption_courte,
			t_categorie_produit_id,
			t_statut_commercial_id,
			t_usage_produit_id,
			t_codif2_id,
			t_codif3_id,
			t_codif4_id,
			t_laboratoire_id,
			remise_interdite,
			ristourne_interdite,
			taux_remise,
			taux_ristourne,
			dateperemption,
			t_classificationint_id,
			TYPE_PRIX_BLOQUE,
			DESIGNATION_BLOQUEE,
			FICHE_BLOQUEE
			)
		VALUES
			(BEL.SEQ_ID_PRODUIT.NEXTVAL,
			codeCNK,
			ADESIGNATION,
			ADESIGNATIONNL,
			AAVEC_CBU,
			AGEREINTERESSEMENT,
			ACOMMENTAIREVENTE,
			AGERESUIVICLIENT,
			to_date('01/01/2015','DD/MM/YYYY'),
			ATRACABILITE,
			ASTOCKMINI,
			ASTOCKMAXI,
			decode(codeCNK,null,2 ,APROFILGS), --si produit propre alors GS = histo + stock
			ACALCULGS,
			DateDernvente,
			AVETERINAIRE,
			AVIDEO,
			ADESIGNATIONLIBREPOSSIBLE,
			APEREMPTIONCOURTE,
			idCateg,
			idStatusComm,
			idUsage,
			idCodif2,
			idCodif3,
			idCodif4,
			idFou,
			AREMISEINTERDITE,
			ARISTOURNEINTERDITE,
			ATAUXREMISE,
			ATAUXRIST,
			ADATEPEREMPTION,
			ACLASSIFINT,
			ATYPEPRIXBLOQUE,
			ADESIGNATIONBLOQUEE,
			AFICHEBLOQUEE )
		RETURNING t_produit_id into T_PRODUIT_ID;

		INSERT INTO BEL.T_TARIF_PRODUIT(
			t_tarif_produit_id,
			t_produit_id,
			t_tva_id,
			prixvente,
			prixachatcatalogue,
			baseremboursement,
			pamp,
			tarifachatunique,
			soumismdl,
			marge_taux,
			marge_coeff,
			pv_ttc_apb,
			date_valid_debut,
			datemaj,
			tarifachat_offibase
			)
		VALUES(
			BEL.SEQ_ID_TARIF_PRODUIT.nextval,
			T_PRODUIT_ID,
			idTVA,
			APRIXVENTE,
			APRIXACHATCATALOGUE,
			0,
			null,
			/*NULL,*/
			0,
			0,
			NULL,
			NULL,
			NULL,
			to_date('01/01/1900','DD/MM/YYYY'),
			to_date('01/01/2005','DD/MM/YYYY'),
			NULL);
--		else 
--			update bel.t_produit set stockmini = astockmini, stockmaxi=astockmaxi where t_produit_id = T_PRODUIT_ID;			  
	end if;

	if (((ACODECNK <10000) OR (APDTPROPRE='1')) and ACODECNK is not null) then --produit propre avec cnk
		INSERT INTO BEL.t_code_ean13(t_code_ean13_id,code_ean13,t_produit_id) VALUES(bel.seq_id_code_ean13.Nextval,ACODECNK,T_PRODUIT_ID);
	END IF;
--END IF;

	RETURN T_PRODUIT_ID;

	EXCEPTION
	WHEN OTHERS then
	  rollback to ProduitSP;
	  raise;
END CreationProduit;

FUNCTION CreationProduitGeographique(
  AStock IN VARCHAR2,
  AStockQuantite IN NUMBER,
  AStockMini IN NUMBER,
  AStockMaxi IN NUMBER,
  /* AStockQtePromise IN NUMBER, */
  ADepot IN VARCHAR2,
  AZoneGeo IN VARCHAR2,
  AProduit IN VARCHAR2,
  APriorite IN VARCHAR2,
  ADepotVente IN VARCHAR2,
  AFusion in char
) RETURN NUMBER
AS
  idDepot BEL.T_DEPOT.T_DEPOT_ID%TYPE;
  idDepotVente BEL.T_DEPOT.T_DEPOT_ID%TYPE;
  idProdgeo number;
BEGIN

  IF ADepot IS NULL THEN
	begin
        select t_depot_id
        into idDepot
        from BEL.t_depot
        where libelle = 'PHARMACIE';
    exception
        when no_data_found then
        	raise_application_error(-20200, 'Depot introuvable !');
    end;
    ELSE
        idDepot := ADepot;
    END IF;

 /*
    Depot vente n'est pas un id, c'est juste un boolean indiquant si le depot est un de vente ou non
    IF ADepotVente IS NULL THEN
    begin
        select t_depot_id
        into idDepotVente
        from BEL.t_depot
        where libelle = 'PHARMACIE';
    exception
        when no_data_found then
        	raise_application_error(-20200, 'Depot vente introuvable !');
    end;
    END IF;
	 */
	IF afusion = '0' then
		INSERT INTO BEL.T_PRODUITGEOGRAPHIQUE(
				t_prodgeo_id,
				stockmini,
				stockmaxi,
				priorite,
				datemajprodgeo,
				t_depot_id,
				t_produit_id,
				t_zonegeo_id,
				quantite,
				date_der_inv,
				depotvente
				)
				VALUES(
				BEL.SEQ_ID_PRODUITGEOGRAPHIQUE.NEXTVAL,
				AStockMini,
				AStockMaxi,
				APriorite,
				to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),
				idDepot,
				Aproduit,
				AZoneGeo,
				AStockQuantite,
				NULL,
				ADepotVente
				)
				RETURNING t_prodgeo_id into idProdgeo;
	else
		begin
			select t_prodgeo_id into idProdgeo from BEL.T_PRODUITGEOGRAPHIQUE where t_produit_id=Aproduit and t_depot_id=idDepot;
			exception
				when no_data_found then
				idProdgeo:=0;
		end;

		if (idProdgeo = 0) then
				INSERT INTO BEL.T_PRODUITGEOGRAPHIQUE(
				t_prodgeo_id,
				stockmini,
				stockmaxi,
				priorite,
				datemajprodgeo,
				t_depot_id,
				t_produit_id,
				t_zonegeo_id,
				quantite,
				date_der_inv,
				depotvente
				)
				VALUES(
				BEL.SEQ_ID_PRODUITGEOGRAPHIQUE.NEXTVAL,
				AStockMini,
				AStockMaxi,
				1,
				to_date(to_char(sysdate, 'DD/MM/YYYY') || ' 00:00', 'DD/MM/YYYY HH24:MI'),
				idDepot,
				Aproduit,
				AZoneGeo,
				AStockQuantite,
				NULL,
				ADepotVente
				)
				RETURNING t_prodgeo_id into idProdgeo;
		else
			update BEL.T_PRODUITGEOGRAPHIQUE set quantite=quantite+AStockQuantite where t_prodgeo_id=idProdgeo;
		end if;
	end if ;

	RETURN idProdgeo;

		EXCEPTION
			WHEN OTHERS then
			raise;
END CreationProduitGeographique;

FUNCTION CreationRepartiteur(
  ARepartiteur IN VARCHAR2,
  ANomRepart IN VARCHAR2,
  ARue1 IN VARCHAR2,
  ARue2 IN VARCHAR2,
  ACodePostal IN VARCHAR2,
  ANomVille IN VARCHAR2,
  --ACodePays in varchar2,
  ATelPersonnel IN VARCHAR2,
  ATelStandard IN VARCHAR2,
  ATelMobile IN VARCHAR2,
  AEmail IN VARCHAR2,
  AFax IN VARCHAR2,
  AVitesse IN NUMBER,
  APause IN VARCHAR2,
  ANbTentatives IN NUMBER,
  ARepDefaut IN VARCHAR2,
  AObjCAMensuel IN NUMBER,
  AModeTransmission IN VARCHAR2,
  T_Repartiteur_ID OUT NUMBER
) RETURN NUMBER
AS
    lIntAdresse bel.t_adresse.t_adresse_id%TYPE;

BEGIN
    savepoint repart;
    lIntAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AEmail, AFax,null);--, ACodePays);

	INSERT INTO bel.t_repartiteur(
        T_REPARTITEUR_ID,
        RAISONSOCIALE,
        VITESSE171,
        PAUSE171,
        NBTENTATIVES,
        REPDEFAUT,
        OBJECTIFCAMENSUEL,
        DATEMAJREPARTITEUR,
        MODETRANSMISSION,
        T_ADRESSE_ID
        )
    VALUES(
        bel.seq_id_fournisseur.NEXTVAL,
        ANomRepart,
        AVitesse,
        APause,
        ANbTentatives,
        ARepDefaut,
		AObjCAMensuel,
		to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
		AModeTransmission,
		lIntAdresse
      )
    RETURNING T_REPARTITEUR_ID into T_Repartiteur_ID;

	--INSERT INTO tw_repartiteur(repart, repart_lgpi) VALUES(ARepartiteur,T_Repartiteur_ID);

    RETURN T_Repartiteur_ID;
  	EXCEPTION
    WHEN OTHERS then
      rollback to repart;
      raise;
END CreationRepartiteur;

FUNCTION CreationFournisseur(
	AFournisseur IN VARCHAR2,
	ANomFourn IN VARCHAR2,
	ARue1 IN VARCHAR2,
	ARue2 IN VARCHAR2,
	ACodePostal IN VARCHAR2,
	ANomVille IN VARCHAR2,
	--ACodePays in varchar2,
	ATelPersonnel IN VARCHAR2,
	ATelStandard IN VARCHAR2,
	ATelMobile IN VARCHAR2,
	AEmail IN VARCHAR2,
	AFax IN VARCHAR2,
	AVitesse IN NUMBER,
	APause IN VARCHAR2,
	ANbTentatives IN NUMBER,
	AModeTransmission IN VARCHAR2,
	AFouPartenaire IN VARCHAR2,
	AMonoGamme IN VARCHAR2,
	T_FOURNISSEUR_ID OUT NUMBER
	) RETURN NUMBER
AS
    lIntAdresse bel.t_adresse.t_adresse_id%TYPE;
BEGIN
    savepoint fourn;

	lIntAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AEmail, AFax,null);--, ACodePays);

	INSERT INTO bel.t_fournisseurdirect(
        T_FOURNISSEURDIRECT_ID,
        RAISONSOCIALE,
        VITESSE171,
        PAUSE171,
        NBTENTATIVES,
        DATEMAJFOURNISSEURDIRECT,
        MODETRANSMISSION,
        FOUPARTENAIRE,
        MONOGAMME,
        T_ADRESSE_ID
        )
	VALUES(
        bel.seq_id_fournisseur.NEXTVAL,
        ANomFourn,
        AVitesse,
        APause,
        ANbTentatives,
        to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),
		AModeTransmission,
		AFouPartenaire,
		AMonoGamme,
		lIntAdresse)
	RETURNING T_FOURNISSEURDIRECT_ID into T_FOURNISSEUR_ID;

	--INSERT INTO tw_fournisseur(fourn, fourn_lgpi) VALUES(AFournisseur,T_FOURNISSEUR_ID);

    RETURN T_FOURNISSEUR_ID;
	EXCEPTION
    WHEN OTHERS then
    	raise;
END CreationFournisseur;

FUNCTION CreationPdtFournisseur(
	APdtFournisseur IN VARCHAR2,
	AProduit IN NUMBER,
	AFournisseur IN NUMBER,
	APriorite IN NUMBER,
	APrixAchat IN NUMBER,
	ARemise IN NUMBER,
	APrixARemise IN NUMBER,
	AGereOffiCentral IN VARCHAR2,
	T_PDTFOURNISSEUR_ID OUT NUMBER
	) RETURN NUMBER
AS
BEGIN

	INSERT INTO bel.t_produitfournisseur(t_produitfournisseur_id,priorite,prixachat,remise,prixaremise,datemajprodfou,t_fournisseur_id,t_produit_id,gere_officentral,DATEDEB,MARGE_TAUX,MARGE_COEFF,MARGE_TAUX_REMISE,MARGE_COEFF_REMISE)
    VALUES(bel.seq_id_produitfournisseur.nextval,APriorite,0,0,0,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY'),AFournisseur,AProduit,AGereOffiCentral,NULL,100,0,100,0)
    RETURNING t_produitfournisseur_id INTO T_PDTFOURNISSEUR_ID;

    RETURN T_PDTFOURNISSEUR_ID;

	EXCEPTION	
    WHEN OTHERS then
		raise;
END CreationPdtFournisseur;

FUNCTION CreationCodeBarre(
    ACodeBarre IN VARCHAR2,
    AProduit IN NUMBER,
    ACode IN VARCHAR2,
    AEan13 IN VARCHAR2,
    ACbu IN VARCHAR2,
	T_CODEBARRE_ID OUT NUMBER
) RETURN NUMBER
AS
	nbCB Integer;
BEGIN
    nbCB := 0;

    SELECT COUNT(*) INTO nbCB FROM bel.t_code_ean13 WHERE t_produit_id = AProduit and code_ean13 = AEan13;

    IF (nbCB = 0) THEN
        INSERT INTO BEL.t_code_ean13(t_code_ean13_id,code_ean13,t_produit_id) VALUES(bel.seq_id_code_ean13.Nextval,ACode,AProduit)
		RETURNING t_code_ean13_id into T_CODEBARRE_ID;
    END IF;

    RETURN T_CODEBARRE_ID;
    EXCEPTION
	WHEN OTHERS then
		raise;
END CreationCodeBarre;

FUNCTION CreationFicheAnalyse(
	Afiche_analyse_id IN VARCHAR2
	,Acnk_produit IN VARCHAR2
	,Ano_analyse IN  VARCHAR2
	,Ano_autorisation IN VARCHAR2
	,ATR_ReferenceAnalytique IN NUMBER
	,Adate_entree IN DATE
	,Afabricant_id IN VARCHAR2
	,Agrossiste_id IN VARCHAR2
	,Ano_lot IN VARCHAR2
	,Aprix_achat IN NUMBER
	,Acnk_lie IN VARCHAR2
	,Ano_bon_livraison IN VARCHAR2
	,Adate_ouverture IN DATE
	,Adate_peremption IN DATE
	,Adate_fermeture IN DATE
	,Aetat IN NUMBER
	,Aquantite_initial IN NUMBER
	,Aunite_qte IN VARCHAR2   ----------------------- A FAIRE
	,Aquantite_restante IN NUMBER
	,Aremarques IN VARCHAR2
	,Adatemaj IN DATE
	,Azonegeo_id IN VARCHAR2
	,T_chim_ficheana_ID OUT NUMBER
	) RETURN NUMBER
AS
	lt_chim_produit_id bel.t_chim_fiche_analyse.t_chim_produit_id%TYPE;
	codeCnk bel.t_chim_produit.cnk%type;
	idop bel.t_operateur.t_operateur_id%type;

BEGIN
	savepoint ficheana;

	select t_operateur_id into idop from bel.t_operateur where codeoperateur like '.';
	codeCnk := lpad(Acnk_produit,7,'0');
	--Recherche de l'ID du produit
	Begin
		select t_chim_produit_id into lt_chim_produit_id
		from bel.t_chim_produit p where p.cnk=codeCnk;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				lt_chim_produit_id := NULL;
				--On créé volontairement une erreur en le mettant à Null pour qu'elle remonte
	End;

	if Azonegeo_id is not null then
		update bel.t_chim_produit set t_zonegeo_id=Azonegeo_id where t_chim_produit_id=lt_chim_produit_id;
	end if;

insert into BEL.T_CHIM_FICHE_ANALYSE(
	T_CHIM_FICHE_ANALYSE_ID
	,T_CHIM_PRODUIT_ID
	,NO_ANALYSE
	,NO_AUTORISATION
	,REF_ANALYTIQUE
	,DATE_ENTREE
	,T_FABRICANT_ID
	,T_GROSSISTE_ID
	,NO_LOT
	,PRIX_ACHAT
	,CNK_LIE
	,NO_BON_LIVRAISON
	,DATE_OUVERTURE
	,DATE_PEREMPTION
	,DATE_FERMETURE
	,ETAT
	,QTE_INITIALE
	,QTE_RESTANTE
	,REMARQUES
	,DATEMAJ
)
VALUES (
	bel.seq_id_chim_fiche_analyse.nextval
	,lt_chim_produit_id
	,Ano_analyse
	,Ano_autorisation
	,ATR_ReferenceAnalytique
	,Adate_entree
	,Afabricant_id
	,Agrossiste_id
	,Ano_lot
	,Aprix_achat
	,lpad(Acnk_lie,7,'0')
	,Ano_bon_livraison
	,Adate_ouverture
	,Adate_peremption
	,Adate_fermeture
	,Aetat
	,Aquantite_initial
	,decode(Aetat, 2, 0, Aquantite_restante)
	,Aremarques
	,Adatemaj
)
RETURNING T_CHIM_FICHE_ANALYSE_ID INTO T_chim_ficheana_ID;

if (Aetat=1) then
	insert into bel.t_chim_manipulation(t_chim_manipulation_id,t_chim_fiche_analyse_id,type_manipulation, t_operateur_id, date_manipulation)
	values (bel.seq_id_chim_manipulation.nextval, T_chim_ficheana_ID, 1,idop,Adate_ouverture);
end if;

RETURN T_chim_ficheana_ID;

	EXCEPTION
    WHEN OTHERS then
		rollback to ficheana;
		raise;
END CreationFicheAnalyse;


FUNCTION CreationFormulaire(
     Aformulaire_id IN VARCHAR2
	,Alibelle_FR IN VARCHAR2
	,Alibelle_NL IN VARCHAR2
	,Anom_court_FR IN VARCHAR2
	,Anom_court_NL IN VARCHAR2
	,Atype_formulaire IN NUMBER
	,T_FORMULAIRE_ID OUT NUMBER
) RETURN NUMBER
AS
BEGIN
	savepoint formulaire;

	select nvl(min(T_MAGI_FORMULAIRE_ID),0) into T_FORMULAIRE_ID from BEL.T_MAGI_FORMULAIRE M where (M.TYPE_FORMULAIRE= ATYPE_FORMULAIRE) AND
		((Anom_court_FR=M.NOM_COURT_FR) OR (Anom_court_FR=M.NOM_COURT_NL) OR (Anom_court_NL=M.NOM_COURT_FR) OR (Anom_court_NL=M.NOM_COURT_NL));

	if (T_FORMULAIRE_ID=0) then
		insert into BEL.T_MAGI_FORMULAIRE(
			T_MAGI_FORMULAIRE_ID
			,DENOMINATION_FR
			,DENOMINATION_NL
			,NOM_COURT_FR
			,NOM_COURT_NL
			,TYPE_FORMULAIRE
			,DATEMAJ
			)
		VALUES (
			bel.seq_id_magi_formulaire.nextval
			,Alibelle_FR
			,Alibelle_NL
			,ANOM_COURT_FR
			,ANOM_COURT_NL
			,ATYPE_FORMULAIRE
			,to_date(to_char(sysdate, 'DD/MM/YYYY'),'DD/MM/YYYY')
			)
		RETURNING T_MAGI_FORMULAIRE_ID INTO T_FORMULAIRE_ID;
	end if;

	RETURN T_FORMULAIRE_ID;

	EXCEPTION
    WHEN OTHERS then
    	rollback to formulaire;
    	raise;
END CreationFormulaire;

FUNCTION CreationFormule(
	Aformule_id IN VARCHAR2
	,Aformulaire_id IN VARCHAR2
	,AFORMULE_UID IN NUMBER
	,Acnk IN VARCHAR2
	,Alibelle_FR IN VARCHAR2
	,Alibelle_NL IN VARCHAR2
	,ATYPE_FORME_GALENIQUE IN NUMBER
	,AQUANTITEPREPAREE IN NUMBER
	,AUNITEQUANTITE IN NUMBER
	,ACOMMENTAIRE IN VARCHAR2
	,AETAT IN VARCHAR2
	,ADATEMAJ IN DATE
	,T_FORMULE_ID OUT NUMBER
) RETURN NUMBER
AS
	lt_denom_fr bel.T_MAGI_FORMULE.DENOMINATION_FR%TYPE;
	 lt_denom_nl bel.T_MAGI_FORMULE.DENOMINATION_NL%TYPE;
BEGIN
	savepoint formule;

	if Alibelle_FR is null then
		lt_denom_fr:=Alibelle_NL;
	else
		lt_denom_fr:=Alibelle_FR;
	end if;

	if Alibelle_NL is null then
		lt_denom_nl:=Alibelle_FR;
	else
		lt_denom_nl:=Alibelle_NL;
	end if;

insert into BEL.T_MAGI_FORMULE(
	T_MAGI_FORMULE_ID
	,T_MAGI_FORMULAIRE_ID
	,FORMULE_UID
	,CNK
	,DENOMINATION_FR
	,DENOMINATION_NL
	,TYPE_FORME_GALENIQUE
	,QUANTITEPREPAREE
	,UNITEQUANTITE
	,COMMENTAIRE
	,ETAT
	,DATEMAJ
)
VALUES (
	bel.seq_id_magi_formule.nextval
	,Aformulaire_id
	,AFORMULE_UID
	,ACNK
	,lt_denom_fr
	,lt_denom_nl
	,ATYPE_FORME_GALENIQUE
	,AQUANTITEPREPAREE
	,AUNITEQUANTITE
	,ACOMMENTAIRE
	,AETAT
	,ADATEMAJ
)
RETURNING T_MAGI_FORMULE_ID INTO T_FORMULE_ID;


RETURN T_FORMULE_ID;

EXCEPTION
    WHEN OTHERS then
    rollback to formule;
    raise;
END CreationFormule;

FUNCTION CreationFormuleLigne(
	AFORMULE_LIGNE_ID IN VARCHAR2
	,AFORMULE_ID IN NUMBER
	,AORDRE IN NUMBER
	,ACHIM_PRODUIT_CNK IN VARCHAR2
	,APRODUIT_ID IN NUMBER
	,AFORMULE_INCORPOREE_ID IN NUMBER
	,AUNITEQUANTITE IN NUMBER
	,AQUANTITE IN NUMBER
	,AMENTION_COMPLEMENTAIRE IN VARCHAR2
	,ADATEMAJ IN DATE
	,T_FORMULE_LIGNE_ID OUT NUMBER
) RETURN NUMBER
AS
	lt_chim_produit_id bel.t_chim_produit.t_chim_produit_id%TYPE;
	lt_chim_produit_denom bel.t_chim_denomination.t_chim_denomination_id%type;
BEGIN
	savepoint formuleligne;

	if (ACHIM_PRODUIT_CNK is not null) then
		begin
			select p.t_chim_produit_id into lt_chim_produit_id from BEL.T_CHIM_PRODUIT p where p.cnk= ACHIM_PRODUIT_CNK;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			lt_chim_produit_id:=null;
		end;
	end if;

	if (lt_chim_produit_id is not null) then
		select nvl(min(d.t_chim_denomination_id),'') into lt_chim_produit_denom from BEL.T_CHIM_DENOMINATION d where d.t_chim_produit_id= lt_chim_produit_id and d.codelangue='F' and d.codesynonyme=0;
	end if;

	insert into BEL.T_MAGI_LIGNE_FORMULE(
		T_MAGI_LIGNE_FORMULE_ID
		,T_MAGI_FORMULE_ID
		,ORDRE
		,T_CHIM_PRODUIT_ID
		,T_CHIM_DENOMINATION_ID
		,T_PRODUIT_ID
		,T_FORMULE_INCORPOREE_ID
		,UNITEQUANTITE
		,QUANTITE
		,MENTION_COMPLEMENTAIRE
		,DATEMAJ
	)
	VALUES (
		bel.seq_id_magi_ligne_formule.nextval
		,AFORMULE_ID
		,AORDRE
		,lt_chim_produit_id
		,lt_chim_produit_denom
		,APRODUIT_ID
		,AFORMULE_INCORPOREE_ID
		,AUNITEQUANTITE
		,AQUANTITE
		,AMENTION_COMPLEMENTAIRE
		,ADATEMAJ
	)
	RETURNING T_MAGI_LIGNE_FORMULE_ID INTO T_FORMULE_LIGNE_ID;

	RETURN T_FORMULE_LIGNE_ID;

	EXCEPTION
	WHEN OTHERS then
		rollback to formuleligne;
		raise;
END CreationFormuleLigne;

end;