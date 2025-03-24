set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_praticien(
  t_praticien_id varchar(50),
  nom varchar(50),
  prenom varchar(50),
  commentaire varchar(200),
  identifiant varchar(11),
  code_specialite varchar(3),
  email varchar(50),
  fax varchar(20),
  nom_ville varchar(30),
  code_postal char(5),
  code_pays varchar(2),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  rue_1 varchar(70),
  rue_2 varchar(70),
  site_web varchar(200),
  categorie numeric(1),
  dentiste char(1))
as
begin
  insert into t_medecin (
	medecin,
    nom,
    prenom,
    commentaires,
	matricule,
	identifiant,
	codespec,
	email,
    fax,
    ville,
    cp,
    tel1,
    tel2,
    gsm,
    rue1,
    rue2,
	site,
	categorie,
	isdentiste)
  values (
	:t_praticien_id,
    :nom,
    :prenom,
    :commentaire,
	'',
	:identifiant,
	:code_specialite,
	:email,
    :fax,
    :nom_ville,
    :code_postal,
    :tel_personnel,
    :tel_standard,
    :tel_mobile,
    :rue_1,
    :rue_2,
    :site_web,
    :categorie,
	:dentiste);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importultimate_creer_client(
  t_client_id varchar(50),
  nom varchar(30),
  prenom varchar(35),
  sexe char(1),
  langue char(1),
  date_naissance date,
  rue_1 varchar(70),
  rue_2 varchar(70),
  code_postal char(6),
  nom_ville varchar(150),
  --codepays varchar(5),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  fax varchar(20),
  email varchar(50),
  url varchar(200),
  oa varchar(3),
  oacpas varchar(4),
  matoa varchar(13),
  datedeboa date,
  datefinoa date,
  oc varchar(3),
  occpas varchar(4),
  matoc varchar(13),
  catoc varchar(6),
  datedeboc date,
  datefinoc date,
  ct1 numeric(3),
  ct2 numeric(3),
  versionassurabilite numeric(2),
  num_tva varchar(15),
  numerocartesis numeric(10),
  niss varchar(11),
  certificat varchar(32),
  derniere_lecture date,
  datedebutvaliditepiece date,
  datefinvaliditepiece date,
  nat_piece_justif_droit char(1),
  commentaire_individuel varchar(500),
  commentaire_individuel_bloquant char(1),
  payeur char(1),
  delai_paiement numeric(3),
  datedernierevisite date,
  collectivite char(1),
  numgroupe varchar(50),
  --idprofilremise  --non repris pour l instant
  idfamille varchar(50),
  editionbvac char(1),
  editioncbl char(1),
  editionrecu char(1),
  typeprofilfacturation char(1),
  copiescanevasfacture char(3),
  numchambre varchar(6),
  etage  varchar(6),
  maison varchar(6),
  lit  varchar(6),
  code_court varchar(20),
  nb_ticket_noteenvoi numeric(2),
  nb_etiq_noteenvoi numeric(2),
  etat char(1)
  )
as
begin
	insert into t_client (
		client,
		nom,
		prenom1,
		sexe,
		langue,
		datenaissance,
		rue1,
		rue2,
		cp,
		localite,
		tel1,
		tel2,
		gsm,
		fax,
		email,
		url,
		oa ,
		oacpas ,
		matoa ,
		datedeboa ,
		datefinoa ,
		oc ,
		occpas ,
		matoc ,
		catoc ,
		datedeboc ,
		datefinoc ,
		ct1 ,
		ct2 ,
		versionassurabilite ,
		num_tva ,
		numerocartesis ,
		niss ,
		certificat ,
		derniere_lecture ,
		datedebutvaliditepiece ,
		datefinvaliditepiece ,
		natpiecejustifdroit ,
		commentaireindiv ,
		commentairebloqu ,
		payeur,
		delaipaiement ,
		datedernierevisite ,
		collectivite ,
		numgroupe ,
		idfamille ,
		editionbvac ,
		editioncbl ,
		edition704 ,
		typeprofilfacturation ,
		copiescanevasfacture ,
		numchambre ,
		etage  ,
		maison ,
		lit  ,
		code_court ,
		nb_ticket_noteenvoi ,
		nb_etiq_noteenvoi,
		etat)
	values (
		:t_client_id,
		:nom,
		:prenom,
		:sexe,
		:langue,
		:date_naissance,
		:rue_1,
		:rue_2,
		:code_postal,
		:nom_ville,
		:tel_personnel,
		:tel_standard,
		:tel_mobile,
		:fax,
		:email,
		:url,
		:oa ,
		:oacpas ,
		:matoa ,
		:datedeboa ,
		:datefinoa ,
		:oc ,
		:occpas ,
		:matoc ,
		:catoc ,
		:datedeboc ,
		:datefinoc ,
		:ct1 ,
		:ct2 ,
		:versionassurabilite ,
		:num_tva ,
		:numerocartesis ,
		:niss ,
		:certificat ,
		:derniere_lecture ,
		:datedebutvaliditepiece ,
		:datefinvaliditepiece ,
		:nat_piece_justif_droit,
		:commentaire_individuel ,
		:commentaire_individuel_bloquant ,
		:payeur,
		:delai_paiement ,
		:datedernierevisite ,
		:collectivite ,
		:numgroupe ,
		:idfamille ,
		:editionbvac ,
		:editioncbl ,
		:editionrecu ,
		:typeprofilfacturation ,
		:copiescanevasfacture ,
		:numchambre ,
		:etage  ,
		:maison ,
		:lit  ,
		:code_court ,
		:nb_ticket_noteenvoi ,
		:nb_etiq_noteenvoi,
		:etat);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_etat_patho(
  t_etatpathoassaad_id integer,
  t_aad_id integer,
  code  varchar(2))
as
begin
	insert into t_patient_pathologie(
		t_patient_pathologie_id,
		t_client_id,
		pathologie)
	values(
		:t_etatpathoassaad_id,
		:t_aad_id,
		:code);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_all_atc(
  t_allergiedelphiatcassaad_id integer,
  t_aad_id integer,
  code varchar(7))
as
begin
  insert into t_patient_allergie_atc(
	t_patient_allergie_atc_id,
	t_client_id,
	classification_atc)
  values(
	:t_allergiedelphiatcassaad_id,
	:t_aad_id,
	:code);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_histo_cli(
  t_facture_id varchar(50),
  t_client_id integer,
  numero_facture integer,
  date_prescription date,
  codeoperateur varchar(10),
  t_praticien_prive_id integer,
  nom_praticien varchar(50),
  prenom_praticien varchar(50),
  the_type_facturation smallint,
  dateacte date)
as
begin
	insert into t_histodelgeneral(
		histodelgeneral,
		clientid,
		facture,
		codeoperateur,
		date_acte,
		date_prescription,
		nom_medecin,
		prenom_medecin,
		thetypefactur)
	values(
		:t_facture_id,
		:t_client_id,
		:numero_facture,
		:codeoperateur,
		:dateacte,
		:date_prescription,
		:nom_praticien,
		:prenom_praticien,
		:the_type_facturation);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_his_cli_lig(
  t_lignevente_id varchar(50),
  t_facture_id varchar(50),
  codecip varchar(7),
  designation_fr varchar(100),
  qtefacturee integer,
  prixvente float)
as
declare variable p varchar(50);
begin
	select produit
	from t_produit
	where codeCNK_prod = :codecip
	into p;

	if (row_count = 0) then
	  p = null;

	insert into t_histodeldetails(
		histodeldetails,
		histodelgeneralID,
		cnkProduit,
		designation,
		qteFacturee,
		prixVte,
		produitID)
	values(
		:t_lignevente_id,
		:t_facture_id,
		:codecip,
		:designation_fr,
		:qtefacturee,
		:prixvente,
		:p);
end;

/* ******************************* NEW MAGISTRALES ********************************************** */

create or alter procedure ps_importulti_creer_his_cli_mag(
	t_lignevente_id varchar(50),  -- id ligne
  t_facture_id varchar(50), -- id entete
  designation_magistrale varchar(100), -- designation magistrale 
  quantite integer,
  detail varchar(2000))
as
begin
    insert into t_histodelmagistrale(
      histodelmagistrale,
      histodelgeneralid,
      designation,     
      qtefacturee, 
      detail,
      clemag
      ) 
    values(
      :t_lignevente_id,
      :t_facture_id,
      substring(:designation_magistrale from 1 for 50),
      :quantite,
      :detail,
      :t_lignevente_id
      );
end;


/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_avance(
	t_client_id integer,
	t_produit_id integer,
	designation varchar(100),
	code_cbu varchar(16),
	total_facture float,
	qtedelivree integer,
	qtemanquante integer,
	dateacte date)
as
begin
	insert into t_litige(
		litige,
		client,
		typeLitige,
		nomPdt,
		produit,
		cdbu,
		prixClient,
		qtedelivree,
		qtemanquante,
		dateVente)
	values(
		next value for seq_litige,
		:t_client_id,
		1,
		:designation,
		:t_produit_id,
		:code_cbu,
		:total_facture,
		:qtedelivree,
		:qtemanquante,
		:dateacte);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_del_diff(
  t_delivrancediff_id integer,
  t_produit_id integer,
  t_aad_id integer,
  t_praticien_id integer,
  no_ordonnance varchar(16),
  dateprescription date,
  dateacte date,
  quantite_differee integer,
  dateordonnance date)
as
begin
	insert into t_deldif(
		deldif,
		produit,
		client,
		medecin,
		noOrdon,
		dateprescr,
		dateDeliv,
		qttDiff,
		dateOrdon)
	values(
		:t_delivrancediff_id,
		:t_produit_id,
		:t_aad_id,
		:t_praticien_id,
		:no_ordonnance,
		:dateprescription,
		:dateacte,
		:quantite_differee,
		:dateordonnance);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_credit(
	t_aad_id integer,
	date_credit date,
	montant float)
as
begin
	insert into t_credit(
		credit,
		montant,
		client,
		datecredit)
	values(
		next value for seq_credit_id,
		:montant,
		:t_aad_id,
		:date_credit);
end;


/* ********************************************************************************************** */
create or alter procedure ps_importultimate_creer_produit(
  produit varchar(50),
  codeCNK_prod char(7),
  designCNKFR_prod varchar(100),
  designCNKNL_prod varchar(100),
  TVA float,
  TYPE_PRIX_BLOQUE numeric(1),
  DESIGNATION_BLOQUEE char(1),  
  FICHE_BLOQUEE char(1),
  stock_mini integer,
  stock_maxi integer
  /*,
  prix_achat_catalogue float,
  prix_vente float,
  base_remboursement float,
  etat char(1),
  delai_viande smallint,
  delai_lait smallint,
  gere_interessement char(1),
  commentaire_vente varchar(200),
  commentaire_commande varchar(200),
  commentaire_gestion varchar(200),
  prestation varchar(3),
  gere_suivi_client char(1),
  liste char(1),
  tracabilite char(1),
  lot_achat integer,
  lot_vente integer,
  pamp float,
  tarif_achat_unique char(1),
  profil_gs char(1),
  calcul_gs char(1),
  nombre_mois_calcul smallint,
  gere_pfc char(1),
  soumis_mdl char(1),
  conditionnement smallint,
  moyenne_vente float,
  unite_moyenne_vente integer,
  date_derniere_vente date,
  contenance integer,
  unite_mesure char(1),
  prix_achat_remise float,
  veterinaire char(1),
  service_tips char(1),
  type_homeo char(1),
  t_repartiteur_id varchar(50),
  t_codif_1_id integer,
  t_codif_2_id integer,
  t_codif_3_id integer,
  t_codif_4_id integer,
  t_codif_5_id integer,
  t_codif_6_id integer,
  date_peremption date*/
  )
as
declare variable intTVA integer;
declare variable c integer;
begin

  insert into t_produit (
        produit,
    codeCNK_prod,
	designCNKFR_prod,
	designCNKNL_prod,
	isPdtPropre, 
	tva,
	typePrixBloque,
	designationBloquee,
	ficheBloquee,
    stockmini,
    stockmaxi
	/*,
    prix_achat_catalogue,
    prix_vente,
    base_remboursement,
    etat,
    delai_viande,
    delai_lait,
    gere_interessement,
    commentaire_vente,
    commentaire_commande,
    commentaire_gestion,
    t_ref_prestation_id,
    gere_suivi_client,
    t_ref_tva_id,
    liste,
    tracabilite,
    lot_achat,
    lot_vente,
    pamp,
    tarif_achat_unique,
    profil_gs,
    calcul_gs,
    nombre_mois_calcul,
    gere_pfc,
    soumis_mdl,
    conditionnement,
    moyenne_vente,
    unite_moyenne_vente,
    date_derniere_vente,
    contenance,
    unite_mesure,
    prix_achat_remise,
    veterinaire,
    service_tips,
    type_homeo,
    t_repartiteur_id,
    t_codif_1_id,
    t_codif_2_id,
    t_codif_3_id,
    t_codif_4_id,
    t_codif_5_id,
    t_codif_6_id,
    date_peremption*/
	)
  values (
    :produit,
    :codeCNK_prod,
	:designCNKFR_prod,
	:designCNKNL_prod,
	0,
	:tva,
	:TYPE_PRIX_BLOQUE,
	:DESIGNATION_BLOQUEE,
	:FICHE_BLOQUEE,
    :stock_mini,
    :stock_maxi
	/*,
    :prix_achat_catalogue,
    :prix_vente,
    :base_remboursement,
    :etat,
    :delai_viande,
    :delai_lait,
    :gere_interessement,
    :commentaire_vente,
    :commentaire_commande,
    :commentaire_gestion,
    :intPrestation,
    :gere_suivi_client,
    :intTVA,
    :liste,
    :tracabilite,
    :lot_achat,
    :lot_vente,
    :pamp,
    :tarif_achat_unique,
    :profil_gs,
    :calcul_gs,
    :nombre_mois_calcul,
    :gere_pfc,
    :soumis_mdl,
    :conditionnement,
    :moyenne_vente,
    :unite_moyenne_vente,
    :date_derniere_vente,
    :contenance,
    :unite_mesure,
    :prix_achat_remise,
    :veterinaire,
    :service_tips,
    :type_homeo,
    :t_repartiteur_id,
    :intCodif1,
    :intCodif2,
    :intCodif3,
    :intCodif4,
    :intCodif5,
    :intCodif6,
    :date_peremption*/
	);
end;

/**************************************   COMPTE RISTOURNE  *********************************************/
create or alter procedure ps_importulti_creer_compte(
  compte int
 ,cliID int
 ,liberType varchar(1)
 ,liberVal varchar(10)
 ,etat varchar(1)
 ,id_centralisation int
)
as
begin
insert into t_compte(
  compte
 ,cliID
 ,liberType
 ,liberVal
 ,etat
 ,id_centralisation
)
values(
  :compte
 ,:cliID
 ,:liberType
 ,:liberVal
 ,:etat
 ,:id_centralisation
);

end;

/**************************************   CARTES RISTOURNE  *********************************************/
create or alter procedure ps_importulti_creer_carte(
  carterist int
  ,compteid int
  ,cliID int
  ,dateEmis date
  ,numCarte varchar(13)
  ,etat varchar(1)
)
as
begin

insert into T_CARTERIST(
	 carterist
	,compteID
	,cliID
	,dateEmis
	,numCarte
	,etat
	)
	values (
	:carterist
	,:compteID
	,:cliID
	,:dateEmis
	,:numCarte
	,:etat
	);

end;

/**************************************   TRANSACTION RISTOURNES ****************************************/
create or alter procedure ps_importulti_creer_transaction(
 transactionrist int
,compteID int
,numcarte varchar(13)
,montantRist float
,typeTransact varchar(1)
,tauxTVA float
,totalTicket float
,dateTicket date
)
as
begin
--On passe toutes les tva à 6
  insert into T_TRANSACTIONRIST(
	 transactionrist
	,compteID
	,numcarte
	,montantRist
	,typeTransact
	,tauxTVA
	,totalTicket
	,justificatif
	,dateTicket
  )
  values(
    :transactionrist
   ,:compteID
   ,:numcarte
   ,:montantRist
   ,:typeTransact
   ,:tauxTVA
   ,:totalTicket
   ,'REPRISE DONNEES FUSION'
   ,:dateticket
  );
end;

/**************************************   Attestations  ************************************************/
create or alter procedure ps_importulti_creer_attestation(
	attestation int
	,speID int
	,cliID int
	,numAtt varchar(20)
	,scanne varchar(1)
	,dateLimite date
	,condRemb int
	,catRemb int
	,nbCond int
	,nbMaxCond int
)
as
begin
	insert into T_ATTESTATION(
		attestation
		,speID
		,cliID
		,numAtt
		,scanne
		,dateLimite
		,catRemb
		,condRemb
		,nbCond
		,nbMaxCond
	)
	values(
		:attestation
		,:speID
		,:cliID
		,:numAtt
		,:scanne
		,:dateLimite
		,:condRemb
		,:catRemb
		,:nbCond
		,:nbMaxCond
		 );
end;


create or alter procedure ps_importulti_creer_depot(
	depot int,
 	libelle varchar(30),
 	automate char(1))
as
begin
 insert into T_DEPOT(depot,
  									libelle,
  									automate)
  values(:depot,
    		 :libelle,
   	     :automate);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importulti_creer_stock(
	stock varchar(50),
	t_produit_id varchar(50),
	t_zone_geographique_id varchar(50),
	quantite integer,
	stock_mini integer,
	stock_maxi integer,
	priorite char(1),
	depotvente char(1),
	t_depot_id varchar(50))
as
begin
	-- if (Priorite = '1') then
	-- 	select depot from t_depot where libelle ='PHARMACIE' into :t_depot_id ;
	-- else
	-- 	select depot from t_depot where libelle ='RESERVE' into :t_depot_id ;

  insert into T_STOCK(stock,
									    produit,
									    zonegeo,
									    qteEnStk,
									    depot,
									    stkMin,
									    stkMax,
											priorite,
											depotvente) 
  values (:stock,
			    :t_produit_id,
			    :t_zone_geographique_id,
			    :quantite,
			    :t_depot_id,
			    :stock_mini,
			    :stock_maxi,
					:priorite,
					:depotvente);
end;


/* ********************************************************************************************** */
create or alter procedure ps_importultimate_creer_ean13(
  codebarre int ,
  code varchar(20),
  produit int)
as
begin
  insert into t_codebarre(codebarre,
													produit,
  												code)
	values (:codebarre,
					:produit,
					:code);
end;


/* ********************************************************************************************** */
create or alter procedure ps_importultimate_creer_zonegeo(
  zonegeo varchar(50),
	libelle varchar(50))
as
begin
  insert into t_zonegeo(zonegeo,
												libelle)
	values (:zonegeo,
					:libelle
	);
      
end;
