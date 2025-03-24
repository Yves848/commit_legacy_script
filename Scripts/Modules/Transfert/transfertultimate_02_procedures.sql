set sql dialect 3;

/* **************************************************************************** */
create or alter procedure SelectionProfilRemiseSuppl
returns(
  APROFILREMISESUPPL VARCHAR(50) ,
  APROFILREMISE VARCHAR(50) ,
  ATYPEREGLE NUMERIC(5,0),
  AORDRE NUMERIC(5,0),
  ATYPERIST CHAR(1) ,
  APLAFRIST NUMERIC(5,3),
  ATAUX NUMERIC(5,0),
  ACATPROD CHAR(1) ,
  AUSAGE CHAR(1) ,
  ACLASSINT NUMERIC(9,0))
AS
begin
  for select profsup.PROFILREMISESUPPL,
             prrm_lgpi,
             profsup.TYPEREGLE,
             profsup.ORDRE,
	     			 profsup.TYPERIST,
	    			 profsup.PLAFRIST,
	     			 profsup.TAUX,
	     			 profsup.CATPROD,
	     			 profsup.USAGE,
	     			 classif.CLASSIFICATIONINTERNE_LGPI
      from T_PROFILREMISESUPPL profsup
      left outer join tw_profilremise prof ON profsup.profilremise = prof.profilremise
      left outer join tw_classificationinterne classif ON classif.classificationinterne = profsup.CLASSINT
      into :APROFILREMISESUPPL,
           :APROFILREMISE,
           :ATYPEREGLE,
           :AORDRE,
				   :ATYPERIST,
				   :APLAFRIST,
				   :ATAUX,
				   :ACATPROD,
				   :AUSAGE,
				   :ACLASSINT
           do
    suspend;
END;

/* **************************************************************************** */
create or alter procedure SelectionProfilRemise
returns(
  APROFILREMISE VARCHAR(50) ,
  ADEFAULTOFFICINE CHAR(1) ,
  ALIBELLE VARCHAR(100) ,
  ATAUXREGLEGEN NUMERIC(5,2),
  ATYPERISTOURNE CHAR(1) ,
  APLAFONDRISTOURNE NUMERIC(5,2)
)
AS
begin
   for select profrem.PROFILREMISE,
             profrem.DEFAULTOFFICINE,
             profrem.LIBELLE,
	           profrem.TAUXREGLEGEN,
             profrem.TYPERISTOURNE,
	           profrem.PLAFONDRISTOURNE
      from T_PROFILREMISE profrem
      into :APROFILREMISE,
           :ADEFAULTOFFICINE,
           :ALIBELLE,
           :ATAUXREGLEGEN,
	   :ATYPERISTOURNE,
	   :APLAFONDRISTOURNE
           do
    suspend;
END;

/******************************************************************************/
/* alter procedure SelectionFamille
returns(
  AFamille VARCHAR(50)
)
AS
begin
   for select fam.famille
      from t_famille fam
      into :AFamille
           do
    suspend;
end
*/

/* **************************************************************************** */
create or alter procedure ps_transfertulti_praticien
returns(
	AMedecin varchar(50),
 ANom varchar(50),
 APrenom varchar(50),
 ACommentaires varchar(200),
 AIdentifiant varchar(11),
 AMatricule varchar(8),
 ASpecialite varchar(3),
 ARue1 varchar(70),
 ARue2 varchar(70),
 ACodePostal varchar(10),
 ANomVille varchar(40),
 ACodePays varchar(5),
 ATelPersonnel varchar(20),
 ATelStandard varchar(20),
 ATelMobile varchar(20),
 AEmail varchar(50),
 AFax varchar(20),
 ASiteWeb varchar(200),
 ADentiste varchar(1),
 AMedecinFrontalier varchar(1),
 ACategorie numeric(1,0)
)
as
begin
  for select med.medecin,
             med.nom,
             med.prenom,
             med.commentaires,
             med.identifiant,
             med.matricule,
             med.codespec,
             med.rue1,
             med.rue2,
             med.cp,
			 med.ville,
             med.codepays,
			 med.tel1,
             med.tel2,
             med.gsm,
             med.email,
             med.fax,
         
             med.site,
             
             med.isdentiste,
             med.ismedfront,
             med.categorie
      from t_medecin med
      into :AMedecin,
           :ANom,
           :APrenom,
           :ACommentaires,
           :AIdentifiant,
           :AMatricule,
           :ASpecialite,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ACodePays,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AEmail,
           :AFax,
           :ASiteWeb,
           :ADentiste,
           :AMedecinFrontalier,
           :ACategorie do
        suspend;
end;


/******************************************************************************/
create or alter procedure SelectionClient
returns(
  ACLIENT VARCHAR(50) ,
  ANOM VARCHAR(30) ,
  APRENOM VARCHAR(35) ,
  ASEXE CHAR(1) ,
  ALANGUE CHAR(1) ,
  ADATENAISSANCE DATE,
  ANISS VARCHAR(11) ,
  AINAMI VARCHAR(11) ,
  ARUE1 VARCHAR(70) ,
  ARUE2 VARCHAR(70) ,
  ACODEPOSTAL VARCHAR(10) ,
  ANOMVILLE VARCHAR(40) ,
  ACODEPAYS VARCHAR(5) ,
  ATELPERSONNEL VARCHAR(20) ,
  ATELSTANDARD VARCHAR(20) ,
  ATELMOBILE VARCHAR(20) ,
  AEMAIL VARCHAR(50) ,
  AFAX VARCHAR(20) ,
  ASITEWEB VARCHAR(200) ,
  AOA VARCHAR(7) ,
  AOACPAS NUMERIC(9,0),
  AMatOA  VARCHAR(13) ,
  ADateDebOA  DATE,
  ADateFinOA  DATE,
  AOC VARCHAR(7) ,
  AOCCPAS NUMERIC(9,0),
  AMatOC  VARCHAR(13) ,
  ACatOC VARCHAR(7) ,
  ADateDebOC  DATE,
  ADateFinOC  DATE,
  AOAT VARCHAR(7) ,
  AMatAT  VARCHAR(13) ,
  ACatAT VARCHAR(7) ,
  ADateDebAT  DATE,
  ADateFinAT  DATE,
  ACT1 NUMERIC(3,0),
  ACT2 NUMERIC(3,0),
  ACOLLECTIVITE CHAR(1) ,
  AVERSIONASSUR NUMERIC(2,0),
  ACERTIFICAT VARCHAR(32) ,
  ANUMCARTESIS NUMERIC(10,0),
  ADERNIERELECTURE DATE,
  ADATEDEBVALPIECE DATE,
  ADATEFINVALPIECE DATE,
  APAYEUR CHAR(1) ,
  ANUMTVA VARCHAR(15) ,
  ACommIndiv VARCHAR(500) ,
  ACommBloqu CHAR(1) ,
  ANatPieceJustifDroit NUMERIC(1,0),
  ANumGroupe VARCHAR(50) ,
  AIDPROFILREMISE NUMERIC(7,0),
  AIDFAMILLE VARCHAR(13) ,
  ADATEDERNIEREVISITE DATE,
  AEDITIONBVAC VARCHAR(1) ,
  AEDITIONCBL	VARCHAR(1) ,
  AEDITION704 VARCHAR(1) ,
  ATYPEPROFILFACTURATION NUMERIC(1,0),
  ACOPIESCANEVASFACTURE NUMERIC(3,0),
  AEDITIONIMMEDIATE char(1),
  AMOMENT_FACTURATION numeric(1),
  AJOUR_FACTURATION numeric(2),
  APLAFOND_CREDIT numeric(10, 2),
  ACREDIT_EN_COURS numeric(10, 2),
  ADATE_DELIVRANCE char(1),
  ANUMCHAMBRE VARCHAR(24),
  AETAGE varchar(6),
  AMAISON varchar(6),
  ALIT varchar(6),  
  ACodeCourt varchar(20),
  ANB_TICKET_NOTEENVOI numeric(2,0),
  ANB_ETIQ_NOTEENVOI numeric(2,0),
  ADELAIPAIEMENT numeric(3,0),
  ASCH_POSOLOGIE numeric(1,0),
  APH_REF numeric(2,0),
  ASEJOUR_COURT char(1),
  ATUH_BOITE_PLEINE char(1),
  ADECOND_FOUR char(1),
  AETAT varchar(1),
  AIDENTIFIANT_EXTERNE varchar(20),
  Asch_commentaire varchar(500),
  Anumero_passport_cni varchar(25)
)
AS
begin
 for SELECT cli.CLIENT,
			cli.NOM,
			cli.PRENOM1,
			cli.SEXE,
			cli.LANGUE,
			cli.DATENAISSANCE,
			cli.NISS,
			cli.INAMI,
			cli.RUE1,
			cli.RUE2,
			cli.CP,
			cli.LOCALITE,
			cli.CODEPAYS,
			cli.TEL1,
			cli.TEL2,
			cli.GSM,
			cli.EMAIL,
			cli.FAX,
			cli.URL,
			cli.OA,
			amo.organisme_cpas_oa_lgpi,
			cli.MATOA,
			cli.DATEDEBOA,
			cli.DATEFINOA,
			cli.OC,
			amc.organisme_cpas_oc_lgpi,
			cli.MATOC,
			cli.CATOC,
			cli.DATEDEBOC,
			cli.DATEFINOC,
			cli.OAT,
			cli.MATAT,
			cli.CATAT,
			cli.DATEDEBAT,
			cli.DATEFINAT,
			cli.CT1,
			cli.CT2,
			cli.COLLECTIVITE,
			cli.VERSIONASSURABILITE,
			cli.CERTIFICAT,
			cli.NUMEROCARTESIS,
			cli.DERNIERE_LECTURE,
			cli.DATEDEBUTVALIDITEPIECE,
			cli.DATEFINVALIDITEPIECE,
			cli.PAYEUR,
			cli.NUM_TVA,
			cli.CommentaireIndiv,
			cli.CommentaireBloqu,
			cli.NatPieceJustifDroit,
			cli.NumGroupe,
			prof.prrm_lgpi,
			cli.IDFamille,
			cli.DATEDERNIEREVISITE,
			cli.EDITIONBVAC,
			cli.EDITIONCBL,
			cli.EDITION704,
			cli.TYPEPROFILFACTURATION,
			cli.COPIESCANEVASFACTURE,
			cli.EDITIONIMMEDIATE,
			cli.MOMENT_FACTURATION,
			cli.JOUR_FACTURATION,
			cli.PLAFOND_CREDIT,
			cli.CREDIT_EN_COURS,
			cli.DATE_DELIVRANCE,
			cli.NUMCHAMBRE,
			cli.ETAGE,
			cli.MAISON,
			cli.LIT,
			cli.code_court,
			cli.NB_TICKET_NOTEENVOI,
			cli.NB_ETIQ_NOTEENVOI,
			cli.DELAIPAIEMENT,
			cli.SCH_POSOLOGIE,
			cli.PH_REF,
			cli.SEJOUR_COURT,
			cli.TUH_BOITE_PLEINE,
			cli.DECOND_FOUR,
			cli.etat,
			cli.IDENTIFIANT_EXTERNE,
			cli.sch_commentaire,
			cli.numero_passport_cni
      FROM t_client cli
      LEFT OUTER JOIN tw_profilremise prof ON cli.IDPROFILREMISE = prof.profilremise
      LEFT OUTER JOIN tw_organismeCPAS_OA amo ON amo.organisme_cpas_oa = cli.OACPAS
      LEFT OUTER JOIN tw_organismeCPAS_OC amc ON amc.organisme_cpas_oc = cli.OCCPAS
      ORDER BY cli.collectivite DESC
      INTO :AClient,
           :ANom,
           :APrenom,
           :ASexe,
	   	   :ALangue,
           :ADateNaissance,
           :ANiss,
		   :AInami,
           :ARUE1,
		   :ARUE2,
		     :ACODEPOSTAL,
		  	:ANOMVILLE,
			   :ACODEPAYS,
           	   :ATELPERSONNEL,
		  	   :ATELSTANDARD,
		  	   :ATELMOBILE,
		  	 :AEMAIL,
		  	   :AFAX,
		  	   :ASITEWEB,
		  	   :AOA,
				   :AOACPAS,
				   :AMatOA,
		  	   :ADateDebOA,
		  	   :ADateFinOA,
	   			 :AOC,
				 :AOCCPAS,
  	   		 :AMatOC,
  	   		 :ACatOC,
	   			 :ADateDebOC,
  	   		 :ADateFinOC,
	   			 :AOAT,
  	   		 :AMatAT,
  	   		 :ACatAT,
		  	   :ADateDebAT,
		  	   :ADateFinAT,
		  	   :ACT1,
		  	   :ACT2,
	   			 :ACOLLECTIVITE,
           :AVERSIONASSUR,
           :ACERTIFICAT,
           :ANUMCARTESIS,
           :ADERNIERELECTURE,
           :ADATEDEBVALPIECE,
           :ADATEFINVALPIECE,
           :APAYEUR,
           :ANUMTVA,
           :ACommIndiv,
           :ACommBloqu,
           :ANatPieceJustifDroit,
				   :ANumGroupe,
				   :AIDPROFILREMISE,
				   :AIDFAMILLE,
				   :ADATEDERNIEREVISITE,
				   :AEDITIONBVAC,
				   :AEDITIONCBL,
				   :AEDITION704,
				   :ATYPEPROFILFACTURATION,
					 :ACOPIESCANEVASFACTURE,
			:AEDITIONIMMEDIATE,
			:AMOMENT_FACTURATION,
			:AJOUR_FACTURATION,
			:APLAFOND_CREDIT,
			:ACREDIT_EN_COURS,
			:ADATE_DELIVRANCE,
					 :ANUMCHAMBRE,
					  :AETAGE,
  :AMAISON,
  :ALIT,  
      :ACodeCourt,
	  :ANB_TICKET_NOTEENVOI,
	  :ANB_ETIQ_NOTEENVOI,
	  :ADELAIPAIEMENT,
	  :ASCH_POSOLOGIE,
			:APH_REF,
			:ASEJOUR_COURT,
			:ATUH_BOITE_PLEINE,
			:ADECOND_FOUR,
	  :AETAT,
	  :AIDENTIFIANT_EXTERNE,
	  :Asch_commentaire,
	  :Anumero_passport_cni
           do
    suspend;
END;


/* **************************************************************************** */
create or alter procedure ps_transfertulti_pathologie
returns(
  AIDClient integer,
  APathologie varchar(2))
as
begin
  for select lg.cli_lgpi,
             pp.pathologie
      from t_patient_pathologie pp
           inner join tw_client lg on (lg.client = pp.t_client_id)
      into :AIDClient,
           :APathologie do
    suspend;
end;

/* **************************************************************************** */
create or alter procedure ps_transfertulti_allergie_atc
returns(
  AIDClient integer,
  AClassificationATC varchar(7))
as
begin
  for select lg.cli_lgpi,
             al.classification_atc
      from t_patient_allergie_atc al
           inner join tw_client lg on (lg.client = al.t_client_id)
      into :AIDClient,
           :AClassificationATC do
    suspend;
end;

/* **************************************************************************** */
create or alter procedure SelectionCompte
returns(
  ACOMPTE varchar(50) ,
  ACLIID NUMERIC(9,0),
  ALIBERTYPE varchar(1) ,
  ALIBERVAL varchar(10) ,
  AETAT varchar(1),
  AId_centralisation numeric(9,0)
)
AS
begin
  for select cpt.compte,
  		cli.cli_lgpi,
  		cpt.liberType,
  		cpt.liberVal,
  		cpt.etat,
		cpt.id_centralisation
      from T_COMPTE cpt, tw_client cli
      WHERE cpt.cliID = cli.client
      into :ACOMPTE,
           :ACLIID,
           :ALIBERTYPE,
           :ALIBERVAL,
			:AETAT,
			:AId_centralisation
           do
    suspend;
END;



/* **************************************************************************** */
create or alter procedure SelectionAttestation
returns(
  AATTESTATION varchar(50) ,
  ASPEID NUMERIC(9,0),
  ACLIID NUMERIC(9,0),
  ANUMATT varchar(20) ,
  ASCANNE varchar(1) ,
  ADATELIMITE DATE,
  ACATREMB NUMERIC(2,0),
  ACONDREMB NUMERIC(2,0),
  ANBCOND NUMERIC(2,0),
  ANBMAXCOND NUMERIC(2,0),
  ACODASSURSOCIAL varchar(1)
)
AS
BEGIN
  for SELECT att.attestation,
  		pdt.prod_lgpi,
  		cli.cli_lgpi,
  		att.numAtt,
  		att.scanne,
  		att.dateLimite,
  		att.catRemb,
  		att.condRemb,
  		att.nbCond,
  		att.nbMaxCond,
  		att.codAssurSocial
      FROM t_attestation att, tw_produit pdt, tw_client cli
      WHERE att.speID = pdt.produit
      AND att.cliID = cli.client
      INTO :AATTESTATION,
           :ASPEID,
           :ACLIID,
           :ANUMATT,
           :ASCANNE,
				   :ADATELIMITE,
				   :ACATREMB,
				   :ACONDREMB,
				   :ANBCOND,
				   :ANBMAXCOND,
				   :ACODASSURSOCIAL
           do
    suspend;
END;




/* **************************************************************************** */
create or alter procedure SelectionCarteRist
returns(
  ACARTERIST varchar(50) ,
  ACOMPTEID NUMERIC(9,0),
  ACLIID NUMERIC(9,0),
  ADATEEMIS DATE,
  ANUMCARTE varchar(13) ,
  AVIRTUEL varchar(1) ,
  AETAT varchar(1) ,
  ASYNONYME varchar(1) ,
  ANUMAPBOFFICINE varchar(7)
)
AS
BEGIN
  for SELECT cart.carterist,
  		cpt.cpt_lgpi,
  		cli.cli_lgpi,
  		cart.dateEmis,
  		cart.numCarte,
  		cart.virtuel,
  		cart.etat,
  		cart.synonyme,
  		cart.numAPBOfficine
      FROM t_carterist cart, tw_compte cpt, tw_client cli
      WHERE cart.compteID = cpt.compte
      AND cart.cliID = cli.client
      INTO :ACARTERIST,
           :ACOMPTEID,
           :ACLIID,
           :ADATEEMIS,
           :ANUMCARTE,
           :AVIRTUEL,
				   :AETAT,
				   :ASYNONYME,
				   :ANUMAPBOFFICINE
           do
    suspend;
END;

/* **************************************************************************** */
create or alter procedure SelectionTransactRist
returns(
	ATRANSACTIONRIST varchar(100) ,
    ANUMCARTE varchar(13) ,
	ACOMPTEID NUMERIC(9,0),
	AMONTANTRIST NUMERIC(10,2),
	ATYPETRANSACT varchar(1) ,
	ATAUXTVA NUMERIC(5,2),
	ATOTALTICKET NUMERIC(10,2),
	AJUSTIFICATIF varchar(50) ,
	ADATETICKET date
)
AS
BEGIN
  for SELECT trans.transactionrist,
  		trans.numcarte,
  		cpt.cpt_lgpi,
  		trans.montantRist,
  		trans.typeTransact,
  		trans.tauxTVA,
  		trans.totalTicket,
  		trans.justificatif,
  		trans.dateTicket
      FROM t_transactionrist trans, tw_compte cpt
      WHERE trans.compteID = cpt.compte
      INTO :ATRANSACTIONRIST,
           :ANUMCARTE,
           :ACOMPTEID,
           :AMONTANTRIST,
           :ATYPETRANSACT,
				   :ATAUXTVA,
				   :ATOTALTICKET,
				   :AJUSTIFICATIF,
				   :ADATETICKET
           do
    suspend;
END;

/* **************************************************************************** */
create or alter procedure SelectionProduitGeographique
returns(
  AStock varchar(50) ,
  AStockQuantite NUMERIC(5,0),
  AStockMini NUMERIC(5,0),
  AStockMaxi NUMERIC(5,0),
  /* AStockQtePromise NUMERIC(5,0), */
  ADepot varchar(50) ,
  AZoneGeo varchar(50) ,
  AProduit varchar(50) ,
  APriorite NUMERIC(3,0),
  ADepotVente varchar(50)
)
AS
begin

	for select 	stk.stock
				,stk.qteEnStk
				,stk.stkMin
				,stk.stkMax
				/* ,stk.qtePromise */
				,ds.depot_lgpi
				,z.zonegeo_lgpi
				,prod.prod_lgpi
				,stk.priorite
				,stk.depotvente
      from t_stock stk
      INNER JOIN tw_produit prod on stk.produit = prod.produit
      left outer join tw_zonegeo z On stk.zoneGeo = z.zonegeo
      left outer join tw_depot ds on stk.depot = ds.depot
      /*left outer join tw_depot dv on stk.depotvente = dv.depot*/
      into :AStock
           ,:AStockQuantite
           ,:AStockMini
           ,:AStockMaxi
           /* ,:AStockQtePromise */
		   ,:ADepot
		   ,:AZoneGeo
		   ,:AProduit
		   ,:APriorite
		   ,:ADepotVente
           do
    suspend;
END;



/* **************************************************************************** */
create or alter procedure SelectionHistoVente
returns(
  AHISTOVENTE varchar(50) ,
  AANNEE numeric(4),
  AMOIS numeric(2),
  APERIODE date,
  ASPESERIE numeric(9),
  AQTEVENDUE numeric(5),
  ANBVENTE numeric(5)
)
AS
begin
  for select histo.histovente,
  		 histo.annee,
  		 histo.mois,
  		 histo.periode,
  		 prod.prod_lgpi,
       histo.qteVendue,
       histo.nbVentes
      from T_HISTOVENTE histo, tw_produit prod
      WHERE histo.speSerie = prod.produit
      into :AHISTOVENTE,
           :AANNEE,
           :AMOIS,
           :APERIODE,
				   :ASPESERIE,
				   :AQTEVENDUE,
				   :ANBVENTE
           do
    suspend;
END;


/* **************************************************************************** */
create or alter procedure SelectionHisto_Client_Entete
returns (
  AHisto_Client_Entete varchar(50),
  AClient integer,
  ANumero_Facture numeric(10),
  ACode_Operateur varchar(10),
  APraticien_Nom varchar(50),
  APraticien_Prenom varchar(50),
  AThe_Type_Facturation numeric(2),
  ADate_Prescription date,
  ADate_Acte date)
as
begin
  for select hist.histodelgeneral,
             cli.cli_lgpi,
             hist.facture,
             hist.codeOperateur,
             hist.nom_medecin,
             hist.prenom_medecin,
             hist.date_prescription,
             hist.date_acte,
             hist.theTypeFactur
      from t_histodelgeneral hist
           inner join tw_client cli on (cli.client = hist.clientID)
      into :AHisto_Client_Entete,
           :AClient,
           :ANumero_Facture,
           :ACode_Operateur,
           :APraticien_Nom,
           :APraticien_Prenom,
           :ADate_Prescription,
           :ADate_Acte,
           :AThe_Type_Facturation
		 do
    suspend;
END;


/* **************************************************************************** */
create or alter procedure SelectionHisto_Client_Ligne
returns (
  AHisto_Client_Ligne varchar(50),
  AEntete NUMERIC(9,0),
  ACodeCNK varchar(7),
  ADesignation varchar(100),
  AQtefacturee numeric(5),
  APrixVente numeric(10,2),
  AProduitID NUMERIC(9,0),
  AREMBOURSE varchar(1)
  )
as
begin
  for select hist_lg.histodeldetails,
             hist_ent.hist_ent_lgpi,
             hist_lg.cnkProduit,
             hist_lg.designation,
             hist_lg.qteFacturee,
             hist_lg.prixVte,
             prod.prod_lgpi,
			 hist_lg.rembourse
      from t_histodeldetails hist_lg
      left outer join tw_produit prod ON hist_lg.produitID = prod.produit
      inner join tw_histo_client_entete hist_ent ON hist_lg.histodelgeneralID = hist_ent.histo_client_entete
      into :AHisto_Client_Ligne,
           :AEntete,
           :ACodeCNK,
           :ADesignation,
           :AQtefacturee,
           :APrixVente,
           :AProduitID,
		   :AREMBOURSE
      DO
    suspend;
end;


/* **************************************************************************** */
create or alter procedure SelectionHisto_Client_Magis
returns (
	AHisto_Client_Magistrale varchar(50),
	AEntete NUMERIC(9,0),
	ADesignation varchar(100),
	AQtefacturee numeric(5),
	ADetail varchar(4000))
as
begin
  for select 	hist_mag.clemag,
				hist_ent.hist_ent_lgpi,
				hist_mag.designation,
				hist_mag.qteFacturee,
				hist_mag.detail
      from t_histodelmagistrale hist_mag
	  inner join tw_histo_client_entete hist_ent ON hist_mag.histodelgeneralID = hist_ent.histo_client_entete
      into :AHisto_Client_Magistrale,
           :AEntete,
           :ADesignation,
           :AQtefacturee,
           :ADetail
      DO
    suspend;
end;


/* **************************************************************************** */
create or alter procedure SelectionCodeBarre
returns(
  ACodeBarre varchar(50) ,
  AProduit NUMERIC(9,0),
	ACode varchar(20) ,
	AEan13 varchar(1) ,
	ACbu varchar(1) )
AS
BEGIN
  for select c.codebarre,
  		p.prod_lgpi,
  		c.code,
  		c.ean13,
  		c.cbu
      FROM T_CODEBARRE c
      INNER JOIN TW_PRODUIT p ON c.produit = p.produit
			where char_length(c.code) <= 20
      into :ACodeBarre,
           :AProduit,
           :ACode,
           :AEan13,
           :ACbu
           do
    suspend;
END;



/* **************************************************************************** */
create or alter procedure SelectionProduit
returns(
 APRODUIT varchar(50),
 ACODECNK varchar(7),
 ADESIGNATION varchar(100),
 ADESIGNATIONNL varchar(100),
 AAVEC_CBU CHAR(1),
 AGEREINTERESSEMENT CHAR(1),
 ACOMMENTAIREVENTE varchar(500),
 AGERESUIVICLIENT CHAR(1),
 ATRACABILITE CHAR(1),
 APROFILGS CHAR(1),
 ACALCULGS CHAR(1),
 AVETERINAIRE CHAR(1),
 AVIDEO CHAR(1),
 ADESIGNATIONLIBREPOSSIBLE CHAR(1),
 AFRIGO CHAR(1),
 APEREMPTIONCOURTE CHAR(1),
 ACATPROD CHAR(1),
 ASTATUTCOMMERC CHAR(1),
 AUSAGEPROD CHAR(1),
 AREMISEINTERDITE CHAR(1),
 ARISTOURNEINTERDITE CHAR(1),
 APDTPROPRE CHAR(1),
 ATVA NUMERIC(3),
 APRIXVENTE NUMERIC(10,2),
 APRIXACHATCATALOGUE	NUMERIC(10,3),
 ALABO varchar(4),
 ACONCESS varchar(4),
 ASTOCKMINI NUMERIC(5,0),
 ASTOCKMAXI NUMERIC(5,0),
 ADATEDERNDELIV DATE,
 ADATEPEREMPTION DATE,
 AZONELIBRE varchar(50),
 ATAUXREMISE NUMERIC(5,2),
 ATAUXRIST NUMERIC(5,2),
 AVENTILATION varchar(50),
 ACREATIONLGCMD CHAR(1),
 ACLASSIFINT NUMERIC(9,0),
 ATYPEPRIXBLOQUE NUMERIC(1,0),
 ADESIGNATIONBLOQUEE char(1),
 AFICHEBLOQUEE char(1)
 )
AS
begin
	for select prod.produit
		,prod.codeCNK_prod
		,prod.designCNKFR_prod
		,prod.designCNKNL_prod
		,prod.avec_cbu
		,prod.gereinteressement
		,prod.commentairevente
		,prod.geresuiviclient
		,prod.tracabilite
		,prod.profilgs
		,prod.calculgs
		,prod.veterinaire
		,prod.video
		,prod.designationlibrepossible
		,prod.frigo
		,prod.peremption_courte
		,prod.categ_prod
		,prod.statuscomm_prod
		,prod.usage_prod
		,prod.remise_interdite
		,prod.ristourne_interdite
		,prod.isPdtPropre
		,prod.tva
		,prod.prixvente
		,prod.prixachatcatalogue
		,prod.labo
		,prod.concess
		,prod.stockmini
		,prod.stockmaxi
		,prod.datederndeliv
		,prod.datePeremption
		,prod.zoneLibre
		,prod.tauxRemise
		,prod.tauxRist
		,prod.ventilation
		,prod.creationLgCmd
		,classif.classificationinterne_lgpi
		,prod.typePrixBloque
		,prod.designationBloquee
		,prod.ficheBloquee
      from T_PRODUIT prod
      left outer join tw_classificationinterne classif on prod.classifInt = classif.classificationinterne
      into  :APRODUIT
			,:ACODECNK
			,:ADESIGNATION
			,:ADESIGNATIONNL
			,:AAVEC_CBU
			,:AGEREINTERESSEMENT
			,:ACOMMENTAIREVENTE
			,:AGERESUIVICLIENT
			,:ATRACABILITE
			,:APROFILGS
			,:ACALCULGS
			,:AVETERINAIRE
			,:AVIDEO
			,:ADESIGNATIONLIBREPOSSIBLE
			,:AFRIGO
			,:APEREMPTIONCOURTE
			,:ACATPROD
			,:ASTATUTCOMMERC
			,:AUSAGEPROD
			,:AREMISEINTERDITE
			,:ARISTOURNEINTERDITE
			,:APDTPROPRE
			,:ATVA
			,:APRIXVENTE
			,:APRIXACHATCATALOGUE
			,:ALABO
			,:ACONCESS
			,:ASTOCKMINI
			,:ASTOCKMAXI
			,:ADATEDERNDELIV
			,:ADATEPEREMPTION
			,:AZONELIBRE
			,:ATAUXREMISE
			,:ATAUXRIST
			,:AVENTILATION
			,:ACREATIONLGCMD
			,:ACLASSIFINT
			,:ATYPEPRIXBLOQUE
			,:ADESIGNATIONBLOQUEE
			,:AFICHEBLOQUEE
           do
    suspend;
END;



/* **************************************************************************** */
create or alter procedure SelectionRepartiteur
returns (
  ARepartiteur varchar(50),
  ANomRepart varchar(50),
  ARue1 varchar(70),
  ARue2 varchar(70),
  ACodePostal varchar(10),
  ANomVille varchar(40),
  --ACodePays varchar(2),  ---- a rajouter en dessous
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AEmail varchar(50),
  AFax varchar(20),
  AVitesse NUMERIC(1),
  APause CHAR(1) ,
  ANbTentatives NUMERIC(3),
  ARepDefaut CHAR(1) ,
  AObjCAMensuel NUMERIC(9,0),
  AModeTransmission CHAR(1) )
as
begin

  FOR SELECT repartiteur,
			nomRepart,
			rueRepart,
			rue2Repart,
			cpRepart,
			locRepart,
			tel,
			tel2,
			gsm,
			email,
			fax,
			vitesse,
			pause,
			nbTentatives,
			repDefaut,
			objMensuel,
			modeTransmission
	FROM t_repartiteur
	where tr_repartiteur is null and nbPdtsAssocies>0
	INTO 	 :ARepartiteur,
			 :ANomRepart,
			 :ARue1,
			 :ARue2,
			 :ACodePostal,
			 :ANomVille,
			 :ATelPersonnel,
			 :ATelStandard,
			 :ATelMobile,
			 :AEmail,
			 :AFax,
			 :AVitesse,
			 :APause,
			 :ANbTentatives,
			 :ARepDefaut,
			 :AObjCAMensuel,
			 :AModeTransmission
    do
    suspend;
END;



/* **************************************************************************** */
create or alter procedure SelectionFournisseur
returns (
  AFournisseur varchar(50),
  ANomFourn varchar(50),
  ARue1 varchar(70),
  ARue2 varchar(70),
  ACodePostal varchar(10),
  AnomVille varchar(40),
  --ACodePays varchar(2),   -- a rajouter en dessous
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AEmail varchar(50),
  AFax varchar(20),
  AVitesse NUMERIC(1),
  APause CHAR(1) ,
  ANbTentatives NUMERIC(3),
  AModeTransmission CHAR(1) ,
  AFouPartenaire CHAR(1) ,
  AMonoGamme CHAR(1) )
as
begin

	FOR SELECT  fournisseur,
				nomFourn,
				rueFourn,
				rue2Fourn,
				cpFourn,
				locFourn,
				tel,
				tel2,
				gsm,
				email,
				fax,
				vitesse,
				pause,
				nbTentatives,
				modeTransmission,
				fouPartenaire,
				monoGamme
	FROM t_fournisseur
	where tr_fournisseur is null and nbPdtsAssocies>0
	INTO :AFournisseur,
				 :ANomFourn,
				 :ARue1,
				 :ARue2,
				 :ACodePostal,
				 :ANomVille,
				 :ATelPersonnel,
				 :ATelStandard,
				 :ATelMobile,
				 :AEmail,
				 :AFax,
				 :AVitesse,
				 :APause,
				 :ANbTentatives,
				 :AModeTransmission,
				 :AFouPartenaire,
				 :AMonoGamme do
    suspend;
END;




/* **************************************************************************** */
create or alter procedure SelectionPdtFournisseur
RETURNS (
  APdtFournisseur varchar(50),
  AProduit numeric(10,0),
  AFournisseur numeric(9,0),
  APriorite numeric(1,0),
  APrixAchat numeric(10,3),
  ARemise numeric(5,2),
  APrixARemise numeric(10,3),
  AGereOffiCentral varchar(1))
AS
BEGIN
  FOR SELECT tarifpdt,
  					 p.prod_lgpi,
  					 r.tr_repartiteur,
  					 prxAchat,
  					 remise,
  					 prxAchtRemise,
  					 isAttitre,
  					 gereofficentral
      FROM t_tarifpdt t
      INNER JOIN tw_produit p ON t.produit = p.produit
      INNER JOIN t_repartiteur r ON t.fou = r.repartiteur
      WHERE t.isRepart = 1 AND r.tr_repartiteur IS NOT NULL AND t.isAttitre = 1

      UNION

      SELECT tarifpdt,
  					 p.prod_lgpi,
  					 f.tr_fournisseur,
  					 prxAchat,
  					 remise,
  					 prxAchtRemise,
  					 isAttitre,
  					 gereofficentral
      FROM t_tarifpdt t
      INNER JOIN tw_produit p ON t.produit = p.produit
      INNER JOIN t_fournisseur f ON t.fou = f.fournisseur
      WHERE t.isRepart = 0 AND f.tr_fournisseur IS NOT NULL AND t.isAttitre = 1

			INTO :APdtFournisseur,
					 :AProduit,
					 :AFournisseur,
					 :APrixAchat,
					 :ARemise,
					 :APrixARemise,
					 :APriorite,
					 :AGereOffiCentral
      DO SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure SelectionDepot
returns (
  ADepot varchar(50),
  ALibelle varchar(50),
  AAutomate numeric(10,0)
)
as
begin
  FOR SELECT depot,
  				libelle,
  				automate
      FROM t_depot
      INTO :ADepot,
					 :ALibelle,
					 :AAutomate
      DO
    	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure SelectionZoneGeo
returns (
  AZoneGeo varchar(50),
  ALibelle varchar(50)
)
as
begin
  FOR SELECT
  				zonegeo,
  				libelle
      FROM t_zonegeo
      INTO :AZoneGeo,
					 :ALibelle
      DO
    	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure SelectionDelDif
returns (
  ADelDif varchar(50),
  AProduit numeric(10,0),
  AClient numeric(10,0),
	AMedecin varchar(50),
	ANoOrdon varchar(16),
	ADatePrescr date,
	ADateDeliv date,
	AQttDiff numeric(7,0),
	ADateOrdon date,
	ATypeDeldif numeric(1,0)
)
as
begin
  FOR SELECT
  				d.deldif,
  				p.prod_lgpi,
  				c.cli_lgpi,
  				m.prat_lgpi,
  				d.noOrdon,
  				d.dateprescr,
  				d.datedeliv,
  				d.qttDiff,
  				d.dateOrdon,
				d.typeDeldif
      FROM t_deldif d
      INNER JOIN tw_produit p ON d.produit = p.produit
      INNER JOIN tw_client c ON d.client = c.client
	  INNER JOIN tw_praticien m ON d.MEDECIN = m.praticien
      INTO :ADelDif,
					:AProduit,
  				:AClient,
  				:AMedecin,
  				:ANoOrdon,
  				:ADatePrescr,
  				:ADateDeliv,
  				:AQttDiff,
  				:ADateOrdon,
				:ATypeDeldif
      DO
    	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure SelectionCredit
RETURNS (
	ACredit varchar(50),
	AMontant numeric(10,3),
	ADateCredit date,
	AClient numeric(10,0)
)
AS
BEGIN
  FOR SELECT cdt.credit,
  				cdt.montant,
  				cdt.datecredit,
  				cli.cli_lgpi
      FROM T_CREDIT cdt
      INNER JOIN tw_client cli ON cdt.client = cli.client
      INTO :ACredit,
					:AMontant,
					:ADateCredit,
  				:AClient
      DO
    	SUSPEND;
END;



/* **************************************************************************** */
create or alter procedure SelectionAvanceProduit
RETURNS (
	ALitige varchar(50),
	AClient numeric(10,0),
	AProduit numeric(10,0),
	ATypeLitige numeric(2,0),
	ADescriptionLitige varchar(50),
	ANomPdt varchar(50),
	ACDBU varchar(1000),
	ANoOrd varchar(10),
	APrixClient numeric(10,3),
	Aqtedelivree numeric(10),
	Aqtemanquante numeric(10),
	ADateVente date,
	AIsFacture varchar(1),
	Agtin varchar(1000),
	Anumero_serie varchar(1000)
)
AS
BEGIN

FOR SELECT lit.litige,
				cli.cli_lgpi,
				pdt.prod_lgpi,
				lit.typeLitige,
				lit.descriptionLitige,
				lit.nomPdt,
				lit.cdbu,
				lit.noOrd,
				lit.prixClient,
				lit.qtedelivree,
				lit.qtemanquante,
				lit.dateVente,
				lit.isFacture,
				lit.gtin,
				lit.numero_serie
    FROM T_LITIGE lit
    INNER JOIN tw_client cli ON lit.client = cli.client
    INNER JOIN tw_produit pdt ON pdt.produit = lit.produit
		--where cli.client in(1208216,1207819)
    INTO 	:ALitige,
			 :AClient,
			 :AProduit,
			 :ATypeLitige,
			 :ADescriptionLitige,
			 :ANomPdt,
			 :ACDBU,
			 :ANoOrd,
			 :APrixClient,
			 :Aqtedelivree,
			 :Aqtemanquante,
			 :ADateVente,
			 :AIsFacture,
			 :Agtin,
			 :Anumero_serie
	DO
	SUSPEND;
END;



/******************************************************************************/
create or alter procedure SelectionOrganismeCPAS
returns (
	AOrganismeCPAS VARCHAR(50) ,
	ANom VARCHAR(50) ,
	ANomReduit VARCHAR(20) ,
	AOrgReference VARCHAR(1) ,
	ATypeOA VARCHAR(20) ,
	AEmail VARCHAR(50) ,
	AGsm VARCHAR(20) ,
	ATel1 VARCHAR(20) ,
	ATel2 VARCHAR(20) ,
	ARue1 VARCHAR(70) ,
	ARue2 VARCHAR(70) ,
	AUrl VARCHAR(200) ,
	ALocalite VARCHAR(40) ,
	ACp VARCHAR(10) ,
	AFax VARCHAR(20),
	Anocpas int,
	Adlg_mttclient_cpas varchar(1)
)
AS
BEGIN
  FOR SELECT org.organismeCPAS,
	  				org.nom,
						org.nomreduit,
						org.orgreference,
						org.typeoa,
						org.email,
						org.gsm,
						org.tel1,
						org.tel2,
						org.rue1,
						org.rue2,
						org.url,
						org.localite,
						org.cp,
						org.fax,
						org.nocpas,
						org.dlg_mttclient_cpas
      FROM T_ORGANISMECPAS org
      INTO :AorganismeCPAS,
					 :ANom,
					 :ANomReduit,
					 :AOrgReference,
					 :ATypeOA,
					 :AEmail,
					 :AGsm,
					 :ATel1,
					 :ATel2,
					 :ARue1,
					 :ARue2,
					 :AUrl,
					 :ALocalite,
					 :ACp,
					 :AFax,
					 :Anocpas,
					 :Adlg_mttclient_cpas
			DO
    	SUSPEND;

END;

/******************************************************************************/
create or alter procedure SelectionMajCPAS
returns (
	 AOrganismeOA integer
	,AOrganismeOC integer
	,Adestinataire_facture integer
)
AS
BEGIN
  FOR SELECT OA.organisme_cpas_oa_lgpi
			 ,OC.organisme_cpas_oc_lgpi
	  		 ,cli.cli_lgpi
      FROM T_ORGANISMECPAS org
	  inner join tw_organismeCPAS_OA OA on org.organismeCPAS=OA.organisme_cpas_oa
	  inner join tw_organismeCPAS_OC OC on org.organismeCPAS=OC.organisme_cpas_oc
	  inner join tw_client cli on org.destinataire_facture=cli.client
	  where org.destinataire_facture <> ''
	  INTO :AOrganismeOA
			,:AOrganismeOC
			,:Adestinataire_facture
  DO
    	SUSPEND;

END;

/******************************************************************************/
/*create or alter procedure SelectionSynPdtChim
returns (
  ASynPdtChim VARCHAR(50) ,
  ALibelle VARCHAR(50) ,
  ANumAPB VARCHAR(7) ,
  ALang VARCHAR(1)
)
as
begin*/
/*
  FOR SELECT
  				s.synonyme_pdt_chim,
  				s.numAPB,
					s.langue,
					s.libelle
      FROM t_synonyme_pdt_chim s
      INTO :ASynPdtChim,
					:ANumAPB,
  				:ALang,
  				:ALibelle
      DO
    	SUSPEND;
END;*/

/* **************************************************************************** */
create or alter procedure SelectionClassificationInterne
returns (
  AClassificationInterne varchar(50) ,
  ALibelle varchar(50) ,
  ATauxMarque NUMERIC(4,3),
  ATauxMarge NUMERIC(7,3)
)
as
begin
  FOR SELECT c.classificationinterne,
					c.libelle,
					c.tauxmarque,
					c.tauxmarge
      FROM t_classificationinterne c
      INTO :AClassificationInterne,
					 :ALibelle,
  				 :ATauxMarque,
  				 :ATauxMarge
      DO
    	SUSPEND;
END;
/******************************************************************************/
/*create or alter procedure SelectionChimique
returns (
  AChimique VARCHAR(50) ,
  ACodeUnite NUMERIC(2,0),
  ACodeUnitePresc NUMERIC(2,0),
  APrixAchat NUMERIC(9,6),
  APrixComptoir NUMERIC(9,6),
  APrixOfficiel NUMERIC(9,6),
  ADensite NUMERIC(5,3),
	ADensiteTar NUMERIC(5,3)
)
as
begin*/
/*  FOR SELECT c.chimique,
					c.codeunite,
					c.codeunitepresc,
					c.prixachat,
					c.prixcomptoir,
					c.prixofficiel,
					c.densite,
					c.densitetar
      FROM t_chimique c
      INTO :AChimique,
  				 :ACodeUnite,
					 :ACodeUnitePresc,
  				 :APrixAchat,
					 :APrixComptoir,
  				 :APrixOfficiel,
  				 :ADensite,
  				 :ADensiteTar

      DO
    	SUSPEND;
END;*/

/******************************************************************************/
/*create or alter procedure SelectionLibelleChimique
returns (
  ALibelleChimique VARCHAR(50) ,
  AChimique VARCHAR(50) ,
  ADesignation  VARCHAR(50) ,
  ALangue VARCHAR(5),
  ASynonyme VARCHAR(5)
)
as
begin*/

/*
  FOR SELECT l.libellechimique,
						w.chim_lgpi,
						l.designation,
						l.langue,
						l.synonyme
      FROM t_libelle_chimique l
      INNER JOIN tw_chimique w ON w.chimique = l.chimique
      INTO :ALibelleChimique,
  				 :AChimique,
					 :ADesignation,
  				 :ALangue,
					 :ASynonyme
      DO
    	SUSPEND;
END;*/

/* **************************************************************************** */
create or alter procedure SelectionFicheAnalyse
returns (
   Afiche_analyse_id varchar(50)
  ,ACNK_produit numeric(10,0)
  ,Ano_analyse varchar(50)
  ,Ano_autorisation varchar(20)
  ,ATR_ReferenceAnalytique numeric(1)
  ,Adate_entree date
  ,Afabricant_id numeric(10,0)
  ,Agrossiste_id numeric(10,0)
  ,Ano_lot varchar(20)
  ,Aprix_achat numeric(9,6)
  ,Acnk_lie varchar(7)
  ,Ano_bon_livraison varchar(20)
  ,Adate_ouverture date
  ,Adate_peremption date
  ,Adate_fermeture date
  ,Aetat numeric(1)
  ,Aquantite_initial numeric(7,2)
  ,Aunite_qte varchar(5)
  ,Aquantite_restante numeric(7,2)
  ,Aremarques varchar(500)
  ,Adatemaj date
  ,Azonegeo_id varchar(50)
)
as
begin
FOR SELECT
	f.fiche_analyse_id,
 f.Cnk_produit,
 f.no_analyse,
 f.no_autorisation,
 f.TR_ReferenceAnalytique,
 f.date_entree,
 WF.fourn_lgpi,
 WR.repart_lgpi,
 f.no_lot,
 f.prix_achat,
 f.cnk_lie,
 f.no_bon_livraison,
 f.date_ouverture,
 f.date_peremption,
 f.date_fermeture,
 f.etat,
 f.quantite_initial,
 f.unite_qte,
 f.quantite_restante,
 f.remarques,
 f.datemaj,
 z.zonegeo_lgpi
FROM t_ficheanalyse f
LEFT JOIN tw_FOURNISSEUR WF ON WF.fourn = f.fabricant_id
LEFT JOIN tw_REPARTITEUR WR ON WR.repart = f.grossiste_id
LEFT JOIN tw_zonegeo z ON f.zonegeo=z.zonegeo
INTO :Afiche_analyse_id,
 :ACnk_produit,
 :Ano_analyse,
 :Ano_autorisation,
 :ATR_ReferenceAnalytique,
 :Adate_entree,
 :Afabricant_id,
 :Agrossiste_id,
 :Ano_lot,
 :Aprix_achat,
 :Acnk_lie,
 :Ano_bon_livraison,
 :Adate_ouverture,
 :Adate_peremption,
 :Adate_fermeture,
 :Aetat,
 :Aquantite_initial,
 :Aunite_qte,
 :Aquantite_restante,
 :Aremarques,
 :Adatemaj,
 :Azonegeo_id
DO
	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure Selection_Formulaire
returns (
		Aformulaire_id varchar(50)
		,Alibelle_FR varchar(50)
		,Alibelle_NL varchar(50)
		,Anom_court_FR varchar(10)
		,Anom_court_NL varchar(10)
		,Atype_formulaire int
	)
as
begin
FOR SELECT
	f.formulaire_id,
 f.libelle_FR,
 f.libelle_NL,
 f.nom_court_FR,
 f.nom_court_NL ,
 f.type_formulaire
FROM T_MAGISTRALE_FORMULAIRE f
INTO :Aformulaire_id,
 :Alibelle_FR,
 :Alibelle_NL,
 :Anom_court_FR,
 :Anom_court_NL ,
 :Atype_formulaire
DO
	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure Selection_Formule
returns (
  Aformule_id varchar(50)
  ,Aformulaire_id varchar(50)
  ,AFORMULE_UID INT
  ,Acnk varchar(7)
  ,Alibelle_FR varchar(50)
  ,Alibelle_NL varchar(50)
  ,ATYPE_FORME_GALENIQUE INT
  ,AQUANTITEPREPAREE numeric(9,6)
  ,AUNITEQUANTITE int
  ,ACOMMENTAIRE varchar(200)
  ,AETAT varchar(1)
  ,ADATEMAJ DATE
)
as 
begin
FOR SELECT
	f.formule_id,
 twf.formulaire_lgpi,
 f.FORMULE_UID,
 f.cnk,
 f.libelle_FR,
 f.libelle_NL,
 f.TYPE_FORME_GALENIQUE,
 f.QUANTITEPREPAREE,
 f.UNITEQUANTITE,
 f.COMMENTAIRE,
 f.ETAT,
 f.DATEMAJ
FROM T_MAGISTRALE_FORMULE f
INNER JOIN TW_FORMULAIRE twf ON twf.formulaire=f.formulaire_id
INTO :Aformule_id,
 :Aformulaire_id,
 :AFORMULE_UID,
 :Acnk,
 :Alibelle_FR,
 :Alibelle_NL,
 :ATYPE_FORME_GALENIQUE,
 :AQUANTITEPREPAREE,
 :AUNITEQUANTITE,
 :ACOMMENTAIRE,
 :AETAT,
 :ADATEMAJ
	DO
	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure Selection_Formule_Ligne
returns (
	Aformule_ligne_id varchar(50),
 Aformule_id varchar(50),
 Aordre int,
 Achim_produit_cnk varchar(7),
 Aproduit_id varchar(50),
 Aformule_incorporee_id varchar(50),
 Aunitequantite int,
 Aquantite numeric(9,6),
 Amention_complementaire varchar(1),
 Adatemaj date
)
as 
begin
FOR SELECT
	f.formule_ligne_id,
 twf.formule_lgpi ,
 f.ordre ,
 f.chim_produit_cnk,
 twp.prod_lgpi,
 twff.formule_lgpi,
 f.unitequantite ,
 f.quantite ,
 f.mention_complementaire ,
 f.datemaj 
FROM T_MAGISTRALE_FORMULE_LIGNE f
INNER JOIN TW_FORMULE twf ON twf.formule=f.formule_id
left outer join TW_FORMULE twff ON twff.formule=f.formule_incorporee_id
left outer join tw_produit twp on twp.produit=f.produit_id
INTO
	:Aformule_ligne_id,
 :Aformule_id ,
 :Aordre ,
 :Achim_produit_cnk,
 :Aproduit_id ,
 :Aformule_incorporee_id ,
 :Aunitequantite ,
 :Aquantite ,
 :Amention_complementaire ,
 :Adatemaj 
	DO
	SUSPEND;
END;

/* **************************************************************************** */
create or alter procedure ps_transfertulti_histo_achat
returns(
  AIDProduit integer,
  ANombreAchatsRepartiteur numeric(5),
  AQuantiteAcheteeRepartiteur numeric(5),
  ANombreAchatsDirecte numeric(5),
  AQuantiteAcheteeDirecte numeric(5),
  AMois smallint,
  AAnnee smallint)
as
begin
  for select w.prod_lgpi,
             h.nombre_achats_repartiteur,
			 h.quantite_achetee_repartiteur,
			 h.nombre_achats_directe,
			 h.quantite_achetee_directe,
			 h.mois,
			 h.annee
      from t_historique_achat h
	       inner join tw_produit w on (w.produit = h.t_produit_id)
      into :AIDProduit,
	       :ANombreAchatsRepartiteur,
		   :AQuantiteAcheteeRepartiteur,
		   :ANombreAchatsDirecte,
		   :AQuantiteAcheteeDirecte,
		   :AMois,
		   :AAnnee do
    suspend;
end;

/* **************************************************************************** */
create or alter procedure ps_transfertulti_parametres
returns(
  ACle varchar(50),
  AValeur varchar(500))
as
begin
  for select cle, valeur from t_parametres
      into :ACle, :AValeur do
    suspend;
end;

/* **************************************************************************** */
create or alter procedure Selection_Medication_Produit
returns(
  	at_sch_medication_produit_id varchar(50),
	at_aad_id varchar(50),
	at_produit_id varchar(50),
	alibelle varchar(250),
	atypeformedpp varchar(50),
	atypemedication varchar(50),
	adate_debut date,
	adate_fin date,
	acommentaire varchar(200),
	at_formule_id varchar(50),
	adate_debut_susp date,
	adate_fin_susp date
  )
as
begin
  for 
	select 
		t_sch_medication_produit_id ,
		twc.cli_lgpi,
		twp.prod_lgpi ,
		libelle ,
		typeformedpp,
		typemedication ,
		date_debut ,
		date_fin ,
		commentaire ,
		twf.formule_lgpi ,
		date_debut_susp ,
		date_fin_susp
	from t_sch_medication_produit m
	inner join tw_produit twp on (twp.produit = cast(m.t_produit_id as integer))
	inner join tw_client twc on (twc.client = m.t_aad_id)
	left join tw_formule twf on (twf.formule = m.t_formule_id)
    into 
		:at_sch_medication_produit_id ,
		:at_aad_id ,
		:at_produit_id ,
		:alibelle ,
		:atypeformedpp,
		:atypemedication ,
		:adate_debut ,
		:adate_fin ,
		:acommentaire ,
		:at_formule_id ,
		:adate_debut_susp ,
		:adate_fin_susp	
	do suspend;
end;

/* **************************************************************************** */
create or alter procedure Selection_Medication_Prise
returns(
	aT_SCH_MEDICATION_PRISE_ID varchar(50), 
	aT_SCH_MEDICATION_PRODUIT_ID varchar(50), 
	aTYPE_FREQUENCE numeric(2),
	aFREQUENCE_JOURS varchar(7), 
	aPRISE_LEVER numeric(6,3), 
	aPRISE_PTDEJ numeric(6,3), 
	aTYPE_MOMENT_PTDEJ numeric(2), 
	aPRISE_MIDI numeric(6,3), 
	aTYPE_MOMENT_MIDI numeric(2), 
	aPRISE_SOUPER numeric(6,3), 
	aTYPE_MOMENT_SOUPER numeric(2), 
	aPRISE_COUCHER numeric(6,3), 
	aPRISE_HEURE1 numeric(6,3), 
	aPRISE_HEURE2 numeric(6,3), 
	aPRISE_HEURE3 numeric(6,3), 
	aPRISE_10HEURES numeric(6,3), 
	aPRISE_16HEURES numeric(6,3), 
	aLIBELLE_HEURE1 varchar(200), 
	aLIBELLE_HEURE2 varchar(200), 
	aLIBELLE_HEURE3 varchar(200), 
	aNB_JOURS numeric(4)  
  )
as
begin
  for 
	select 
		p.T_SCH_MEDICATION_PRISE_ID , 
		tw.medication_produit_lgpi , 
		p.TYPE_FREQUENCE,
		p.FREQUENCE_JOURS , 
		p.PRISE_LEVER , 
		p.PRISE_PTDEJ , 
		p.TYPE_MOMENT_PTDEJ , 
		p.PRISE_MIDI , 
		p.TYPE_MOMENT_MIDI , 
		p.PRISE_SOUPER , 
		p.TYPE_MOMENT_SOUPER , 
		p.PRISE_COUCHER , 
		p.PRISE_HEURE1 , 
		p.PRISE_HEURE2 , 
		p.PRISE_HEURE3 , 
		p.PRISE_10HEURES , 
		p.PRISE_16HEURES , 
		p.LIBELLE_HEURE1 , 
		p.LIBELLE_HEURE2 , 
		p.LIBELLE_HEURE3 , 
		p.NB_JOURS 
	from T_SCH_MEDICATION_PRISE p
	inner join tw_medication_produit tw on (tw.medication_produit=p.T_SCH_MEDICATION_PRODUIT_ID)
    into 
		:AT_SCH_MEDICATION_PRISE_ID , 
		:AT_SCH_MEDICATION_PRODUIT_ID , 
		:ATYPE_FREQUENCE,
		:AFREQUENCE_JOURS , 
		:APRISE_LEVER , 
		:APRISE_PTDEJ , 
		:ATYPE_MOMENT_PTDEJ , 
		:APRISE_MIDI , 
		:ATYPE_MOMENT_MIDI , 
		:APRISE_SOUPER , 
		:ATYPE_MOMENT_SOUPER , 
		:APRISE_COUCHER , 
		:APRISE_HEURE1 , 
		:APRISE_HEURE2 , 
		:APRISE_HEURE3 , 
		:APRISE_10HEURES , 
		:APRISE_16HEURES , 
		:ALIBELLE_HEURE1 , 
		:ALIBELLE_HEURE2 , 
		:ALIBELLE_HEURE3 , 
		:ANB_JOURS 
	do suspend;
end;

/* **************************************************************************** */
create or alter procedure Selection_Solde_TUH_Patient
returns(
	AT_AAD_ID VARCHAR(50), 
	AT_PRODUIT_ID VARCHAR(50), 
	ASOLDE NUMERIC(10,0),    
	ANOORD NUMERIC(9,0),
	ADATE_ORDO DATE,
	ACATREMB NUMERIC(2,0),
	ACONDREMB NUMERIC(2,0),
	AT_PRATICIEN_ID VARCHAR(50),
	At_type_tuh numeric(1,0),
	At_collectivite_id varchar(50),
	AOrdo_Suspendu numeric(1,0),
	ACBU varchar(16),
	ADATE_DEBUT_ASS_OA date,
	ADATE_FIN_ASS_OA date,
	ADATEDEBVALIDITEPIECE date,
	ADATEFINVALIDITEPIECE date,
	ADATEDERNCONSULT_MYCARENET date,
	ACT1 numeric(3,0),
	ACT2 numeric(3,0)
  )
as
begin
  for 
	select 
  		cli.cli_lgpi
  		,prd.prod_lgpi
		,s.solde
		,s.noord
		,s.date_ordo
		,s.catRemb
		,s.condRemb
		,pra.prat_lgpi
		,s.t_type_tuh
		,coll.cli_lgpi
		,s.ordo_suspendu
		,s.cbu
		,s.DATE_DEBUT_ASS_OA 
		,s.DATE_FIN_ASS_OA 
		,s.DATEDEBVALIDITEPIECE 
		,s.DATEFINVALIDITEPIECE 
		,s.DATEDERNCONSULT_MYCARENET 
		,s.CT1  
		,s.CT2  
	from T_SOLDE_TUH_PATIENT S
	inner join tw_produit prd on (prd.produit = s.t_produit_id)
	inner join tw_client cli on (cli.client = s.t_aad_id)
	left join tw_praticien pra on (pra.praticien = s.t_praticien_id)
	inner join tw_client coll on (coll.client = s.t_collectivite_id)
	inner join t_client c on (s.t_aad_id = c.client) 
	where c.etat in (0,3)
	order by s.ordo_suspendu  -- Car dans le kit de migration  le numero d ordo est cree a partir de ceux existant donc il faut qu elle soit cree APRES les tuh normal
	into 
		:AT_AAD_ID
		,:AT_PRODUIT_ID
		,:ASOLDE
		,:ANOORD	
		,:ADATE_ORDO
		,:ACATREMB
		,:ACONDREMB
		,:AT_PRATICIEN_ID
		,:At_type_tuh
		,:At_collectivite_id
		,:AOrdo_Suspendu    
		,:ACBU
		,:ADATE_DEBUT_ASS_OA 
		,:ADATE_FIN_ASS_OA 
		,:ADATEDEBVALIDITEPIECE 
		,:ADATEFINVALIDITEPIECE 
		,:ADATEDERNCONSULT_MYCARENET 
		,:ACT1  
		,:ACT2  
	do suspend;
end;

/* **************************************************************************** */
create or alter procedure Selection_Solde_TUH_Boite
returns(
	At_collectivite_id varchar(50),
	AT_PRODUIT_ID VARCHAR(50), 
	ASOLDE NUMERIC(10,0)  
  )
as
begin
  for 
	select 
		coll.cli_lgpi -- si null stock pharmacie
  		,prd.prod_lgpi
		,s.solde
	from T_SOLDE_TUH_BOITE S
	inner join tw_produit prd on (prd.produit = s.t_produit_id)
	left join tw_client coll on (coll.client = s.t_collectivite_id)
	into 
		:At_collectivite_id
		,:AT_PRODUIT_ID
		,:ASOLDE
	do suspend;
end;