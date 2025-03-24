set sql dialect 3;
/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_medecin(
  prescripteur_id integer, 
  personne_id integer,  
  cabinet_id integer, 
  matricule varchar(15), 
  veterinaire integer,
  adresse varchar(64), 
  cp varchar(5),
  pays varchar(3),
  localite varchar(64),
  nom varchar(32), 
  prenom varchar(32),
  telephone varchar(16),
  gsm varchar(16),
  telefax varchar(16))
as
declare variable commentaire_ varchar(200);
declare variable telephone_ varchar(16);
declare variable gsm_ varchar(16);
declare variable telefax_ varchar(16);
declare variable ligne varchar(100);
declare variable spacer varchar(1);
declare variable newline varchar(2);
declare variable c varchar(50);
begin
  newline = ASCII_CHAR(13)||ASCII_CHAR(10);  
  c = cast(prescripteur_id as varchar(50));
  -- La première ligne du select entraine la création du medecin, les autres n'existent que si il a plusieurs num de tél donc on les met en commentaire uniquement
  if (exists (select * from t_medecin where medecin=:c)) then  
  begin
    
    select commentaires from t_medecin where medecin=:c into :commentaire_;
    

    if (telephone is not null) then
    begin
      if (char_length(ligne) > 0) then
        spacer = '   ';
      else
        spacer = '';
      ligne = substring('tel:' || :telephone from 1 for 100);
    end

    if (gsm is not null) then
    begin
      if (char_length(ligne) > 0) then
        spacer = '   ';
      else
        spacer = '';

      ligne = substring(:ligne || :spacer || 'gsm:' || gsm from 1 for 100);
    end

    if (telefax is not null) then
    begin
      if (char_length(ligne) > 0) then
        spacer = '   ';
      else
        spacer = '';

      ligne = substring(:ligne || :spacer || 'fax:' || telefax from 1 for 100);
    end

    if (commentaire_ is null) then
      commentaire_ = substring(ligne from 1 for 200);
    else
      commentaire_ = substring(:commentaire_ || newline || ligne from 1 for 200);

      
    update t_medecin 
    set commentaires = :commentaire_
    where medecin = :c;
    
  end
  else  
  begin
    insert into t_medecin(
      medecin,
      nom,
      prenom,
      identifiant,
      matricule,
      codespec,
      fax,
      ville,
      cp,
      tel1,
      gsm,
      rue1,
      categorie,
      codepays)
    values(
      :prescripteur_id,
      :nom,
      :prenom,
      iif(:matricule is null or :matricule ='','00000000000',substring(:matricule from 1 for 11)),
      iif(:matricule is null or :matricule ='','00000000',substring(:matricule from 1 for 8)),
      iif(:matricule is null or :matricule ='','000',substring(:matricule from 9 for 3)),
      :telefax,
      :localite,
      :cp,
      :telephone,
      :gsm,
      :adresse,
      '1',
      case
        when :pays = 'B' then 'BE'
        when :pays = 'D' then 'DE'
        when :pays = 'F' then 'FR'
        when :pays = 'L' then 'LU'
        when :pays = 'I' then 'IT'
        when :pays = 'GB' then 'GB'
        else 'BE'
      end
      );     
    end
end;


/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_notes(
      typenote integer,
      personne_id integer, 
      memo varchar(5000)
)
as
declare variable commentaires_ varchar(500);
declare variable notes varchar(500);
declare variable c varchar(50);
declare variable newline varchar(2);
begin
  newline = ASCII_CHAR(13)||ASCII_CHAR(10);
  if (:typenote = '1') then -- Prescipteurs
  begin
    -- PAS DE COMMENTAIRES DANS LA TABLE T_PRESCRIPTEUR
  end

  if (:typenote = '2') then -- Clients
  begin
      
    c = cast(personne_id as varchar(50));
    select COMMENTAIREINDIV from t_client where client=:c into :commentaires_;
      if (commentaires_ is null) then
        commentaires_ = substring(:memo from 1 for 500);
      else
        commentaires_ = substring(:commentaires_ || newline || memo from 1 for 500);

      update t_client
      set commentaireindiv = :commentaires_
      where client = :c;
  end

  
end;


/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_profil_remise(
  escompte_profil_id integer, 
  libelle varchar(64))
as
begin
  insert into t_profilremise (
  	  profilremise,
  	  defaultofficine,
  	  libelle,
  	  tauxreglegen,
  	  typeristourne,
  	  plafondristourne)
  values(
  	  :escompte_profil_id,
  	  iif(:escompte_profil_id = 0, '1', '0'),
  	  :libelle,
  	  0,
  	  '0',
  	  0);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_groupe(
  institution_id integer, 
  nom varchar(64),
  tva varchar(15), 
  adresse varchar(64),
  cp varchar(5),
  pays varchar(3),
  localite varchar(64), 
  telephone varchar(16),
  gsm varchar(16),
  telefax varchar(16))
as
begin
  insert into t_client(
  	client,
  	collectivite,
  	nom,
  	rue1,
  	tel1,
  	gsm,
    fax,
    num_tva,
    cp,
    localite,
    payeur,
    langue,
    codepays) 
  values(
  	iif(:institution_id > 0, '9999' || :institution_id, :institution_id),
  	'1',
  	substring(:nom from 1 for 30),
  	:adresse,
  	:telephone,
  	:gsm,
    :telefax,
    null,------------------------------------------------------------------------a revoir iif(char_length(:tva) >= 9, f_renvoyer_num_tva(:tva), null),
    :cp,
    substring(:localite from 1 for 40),
    'A',
    '0',
    case
      when :pays = 'B' then 'BE'
      when :pays = 'D' then 'DE'
      when :pays = 'F' then 'FR'
      when :pays = 'L' then 'LU'
      when :pays = 'I' then 'IT'
      when :pays = 'GB' then 'GB'
      else 'BE'
  	end);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_client(
  personne_id integer, 
  nom varchar(32), 
  prenom varchar(32), 
  adresse varchar(64), 
  famille_id integer,
  langue char(1), 
  date_naissance date, 
  institution_id integer, 
  niss varchar(11), 
  escompte_profil_id integer,  
  carte_ristourne integer, 
  print_mo_704 char(1),
  print_mo_cbl char(1), 
  print_mo_bvac char(1),
  visible integer, 
  --blobcontent varchar(5000), 
  email varchar(128), 
  cp varchar(5),
  pays varchar(3),
  localite varchar(64),
  telephone varchar(16),
  gsm varchar(16),
  telefax varchar(16))
as
declare variable commentaire_ varchar(500);
declare variable telephone_ varchar(16);
declare variable gsm_ varchar(16);
declare variable telefax_ varchar(16);
declare variable ligne varchar(100);
declare variable spacer varchar(1);
declare variable newline varchar(2);
declare variable c varchar(50);
begin
  newline = ASCII_CHAR(13)||ASCII_CHAR(10);  
  c = cast(personne_id as varchar(50));

  if (exists (select * from t_client where client=:c)) then  
  begin
    
    select commentaireindiv from t_client where client=:c into :commentaire_;
    

    if (telephone is not null) then
    begin
      if (char_length(ligne) > 0) then
        spacer = '   ';
      else
        spacer = '';
      ligne = substring('tel : ' || :telephone from 1 for 100);
    end

    if (gsm is not null) then
    begin
      if (char_length(ligne) > 0) then
        spacer = '   ';
      else
        spacer = '';

      ligne = substring(:ligne || :spacer || 'gsm : ' || gsm from 1 for 100);
    end

    if (telefax is not null) then
    begin
      if (char_length(ligne) > 0) then
        spacer = '   ';
      else
        spacer = '';

      ligne = substring(:ligne || :spacer || 'fax : ' || telefax from 1 for 100);
    end

    if (commentaire_ is null) then
      commentaire_ = substring(ligne from 1 for 2000);
    else
      commentaire_ = substring(:commentaire_ || newline || ligne from 1 for 2000);

      
    update t_client 
    set commentaireindiv = :commentaire_
    where client = :c;
    
  end
  else
  begin

  insert into t_client(
  	client,
  	collectivite,
  	nom,
  	prenom1,
  	langue,
  	datenaissance,
  	rue1,
  	tel1,
  	gsm,
    fax,
    email,
    cp,
    localite,
    --commentaireindiv, 
    payeur, 
    numgroupe, 
    idprofilremise,
    idfamille,
    codepays,
    editionbvac,
    editioncbl,
    edition704,
    niss) 
  values(
  	:personne_id,
  	'0',
  	substring(:nom from 1 for 30),
  	substring(:prenom from 1 for 35),
  	case
  	  when :langue = 'F' then '0'
  	  when :langue = 'N' then '1'
  	  else '0'
  	end,
  	:date_naissance,
  	substring(:adresse from 1 for 40),
  	:telephone,
  	:gsm,
    :telefax,
    substring(:email from 1 for 50),
    :cp,
    substring(:localite from 1 for 40),
    --:blobcontent,
    'A',
    iif(:institution_id > 0, '9999' || :institution_id, :institution_id),
    :escompte_profil_id,
    :famille_id,
    case
      when :pays = 'B' then 'BE'
      when :pays = 'D' then 'DE'
      when :pays = 'F' then 'FR'
	  when :pays = 'L' then 'LU'
      when :pays = 'I' then 'IT'
      when :pays = 'GB' then 'GB'
      else 'BE'
  	end,
    iif((:print_mo_bvac is null) or (:print_mo_bvac = 'T'), '1', '0'),
    iif((:print_mo_cbl is null) or (:print_mo_cbl = 'T'), '1', '0'),
    iif((:print_mo_704 is null) or (:print_mo_704 = 'T'), '1', '0'),
    :niss);
    end
end;
/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_pharmacien_referent(
personne_id integer)
as
begin
update t_client
set ph_ref = 2
where client = :personne_id;
end;
/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_maj_client_oa(
  personne_id integer,
  nomtitulaire varchar(48),
  prenomtitulaire varchar(24),
  ct1 varchar(3),
  ct2 varchar(3),
  assurabiliteversion varchar(2),
  sexe char(1),
  sisnumero varchar(10),
  certificat varchar(32),
  datelecture date,
  assureur varchar(3),
  matricule varchar(13),
  datevalidite date)
as
declare variable c varchar(50);
declare variable nat_piece char(1);
begin
  c = cast(personne_id as varchar(50));
  
  if (datelecture is null) then
    if ((datevalidite is not null) and (ct1 <> '') and (ct2 <> '')) then
    	nat_piece = '2';
    else 	
    	nat_piece = '0';
  else
    if (certificat = '') then
      nat_piece = '2';
    else
      nat_piece = '0';

  update t_client
  set nom = substring(coalesce(:nomtitulaire, nom) from 1 for 30),
      prenom1 = substring(coalesce(:prenomtitulaire, prenom1) from 1 for 20),
      sexe = iif(:sexe not in ('1', '2'), '0', :sexe),
      oa = :assureur,
      matoa = :matricule,
      datefinoa = :datevalidite,
      ct1 = iif(:ct1 not similar to '[[:DIGIT:]]*', '0', :ct1),
      ct2 = iif(:ct2 not similar to '[[:DIGIT:]]*', '0', :ct2),
      versionassurabilite = case
                              when :assurabiliteversion = '0A' then '10'
                              when :assurabiliteversion = '0B' then '11'
                              when :assurabiliteversion = '0C' then '12'
                              when :assurabiliteversion = '0D' then '13'
                              when :assurabiliteversion = '0E' then '14'
                              when :assurabiliteversion = '0F' then '15'
                              else null
                            end,
      certificat = :certificat,
      derniere_lecture = :datelecture,
      natpiecejustifdroit = :nat_piece,
      numerocartesis = iif(:sisnumero<>'',:sisnumero , null)
  where client = :c;
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_maj_client_oc(  
  personne_id integer,
  assureur varchar(3),
  matricule varchar(13),
  datevalidite date)
as
declare variable c varchar(50);
begin
  c = cast(personne_id as varchar(50));

  update t_client
  set oc = :assureur,
      matoa = :matricule,      
      datefinoc = :datevalidite
  where client = :c;
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_compte_rist(
  personne_id integer,
  ristourne_carte_id integer,
  datev date,
  numero_carte varchar(16)
  )
as
begin
  INSERT INTO T_COMPTE(
  	compte,
  	cliID,
  	liberType,
  	liberVal,
  	etat) 
  VALUES(
  	:ristourne_carte_id,
  	:personne_id,
  	'1',
  	'5',
  	'1');	
	
insert into t_carterist(
  	carterist,
  	compteid,
  	cliid,
  	dateemis,
  	numcarte,
  	etat)
  values(
  	next value for seq_carte_ristourne,
  	:ristourne_carte_id,
  	:personne_id,
  	:datev,
  	:numero_carte,
  	'1');
	
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_trans_rist(
  ristourne_carte_id integer,
  numero_carte varchar(16),
  montant float,
  tva float)
as
begin
  INSERT INTO T_TRANSACTIONRIST(
  	transactionrist,
  	numcarte,
  	compteID,
  	montantRist,
  	typeTransact,
  	tauxTVA)
  VALUES(
  	next value for seq_transaction_ristourne,	
  	:numero_carte,
  	:ristourne_carte_id,
  	coalesce(:montant, 0),
  	'0',
  	coalesce(:tva, 0));
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_tarif(
  tar_id integer, 
  fournisseur_preferentiel integer)
as
begin
  insert into t_tarifpdt(
    tarifpdt,
    produit,
    fou,
    prxachat,
    isrepart,
    isattitre)
  values(
    :tar_id,
    :tar_id,
    :fournisseur_preferentiel,
    '0',
    '1',
    '1');
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_fournisseur(
  fournisseur_id integer,
  nom varchar(64),
  adresse varchar(64),
  localite varchar(64),
  cp varchar(5),
  pays varchar(3),
  telephone varchar(16),
  gsm varchar(16),
  telefax varchar(16))
as
declare variable nb_pdts integer;
begin
  select count(*)
  from t_tarifpdt
  where fou = :fournisseur_id
  into :nb_pdts;
  
  insert into t_repartiteur(
    repartiteur,
    nomrepart,
    ruerepart,
    locrepart,
    cprepart,
    tel,
    gsm,
    fax,
    nbpdtsassocies) 
  values(
  	:fournisseur_id,
  	:nom,
  	:adresse,
  	:localite,
    :cp,
    :telephone,
    :gsm,
    :telefax,
    :nb_pdts);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_zone_geo(
  rangement varchar(64))
as
begin
  insert into t_zonegeo(
    zonegeo,
    libelle) 
  values(
  	:rangement,
  	:rangement);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_stock(
  stock_id integer,
  tar_id integer,
  stock_reel integer,
  stock_reserve integer,
  stock_minimal integer,
  stock_ideal integer,
  rangement varchar(16),
  fournisseur_preferentiel integer,
  fournisseur_report integer,
  seuil_alerte integer,
  date_peremption date)
as
declare variable stk_min integer;
declare variable stk_max integer;
begin
  stk_min = iif(stock_minimal > 0, stock_minimal - 1, 0);
  stk_max = iif(stock_ideal > 0, stock_ideal, null);

  insert into t_produit(
  	produit,
  	designcnkfr_prod,
  	designcnknl_prod,
  	avec_cbu,
  	gereinteressement,
  	geresuiviclient,
  	tracabilite,
  	calculgs,
  	profilgs,
  	veterinaire,
  	video,
  	designationlibrepossible,
  	frigo,
  	peremption_courte,
  	remise_interdite,
  	ristourne_interdite,
  	ispdtpropre,
  	creationlgcmd,
  	dateperemption,
  	stockmini,
  	stockmaxi)
  values(
  	:tar_id,
  	:tar_id,
  	:tar_id,
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	'0',
  	:date_peremption,
  	:stk_min,
  	:stk_max);

  insert into t_stock(
    stock,
    qteEnStk,
    stkMin,
    stkMax,
    produit,
    zonegeo,
    priorite,
    depot,
    depotvente)
  values(
  	:tar_id,
  	:stock_reel,
  	0,
  	:stk_max,
  	:tar_id,
  	nullif(:rangement, ''),
  	'1',
  	'1',
  	'1');

  if (stock_reserve > 0) then
	  insert into t_stock(
	    stock,
	    qteEnStk,
	    stkMin,
	    stkMax,
	    produit,
	    priorite,
	    depot,
	    depotvente)
	  values(
	  	:tar_id || '-R',
	  	:stock_reserve,
	  	0,
	  	0,
	  	:tar_id,
	  	'2',
	  	'2',
	  	'0');  
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_maj_code_barre(
  tar_id integer,
  barcode varchar(13),
  barcode_type varchar(3))
as
declare variable p varchar(50);
begin
  p = cast(tar_id as varchar(50));
  if (barcode_type = 'EAN') then
	  insert into t_codebarre(
	  	codebarre,
	  	produit,
	  	code,
	  	ean13,
	  	cbu)
	  values(
	  	:barcode,
	  	:p,
	  	trim(:barcode),
	  	'1',
	  	'0');
  else 
		update t_produit
		set codecnk_prod = iif((:barcode_type = 'CNK') and (trim(:barcode) similar to '[[:DIGIT:]]{7}'), trim(:barcode), codecnk_prod)
		where produit = :p;
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_maj_prix(
  tar_id integer,
  prix_public float,
  prix_base float,
  tva float)
as
declare variable p varchar(50);
begin
  p = cast(tar_id as varchar(50));
  update t_produit
  set prixvente = :prix_public,
      prixachatcatalogue = :prix_base,
      tva = :tva
  where produit = :p;
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_maj_categorie(
  tar_id integer,
  categorie char(1),
  usage char(1))
as
declare variable p varchar(50);
begin
  p = cast(tar_id as varchar(50));
  update t_produit
  set categ_prod = :categorie,
      usage_prod = :usage
  where produit = :p;
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_maj_designation(
  tar_id integer,
  langue char(1),
  libelle varchar(50))
as
declare variable p varchar(50);
begin
  p = cast(tar_id as varchar(50));
  if (langue = 'F') then
    update t_produit set designcnkfr_prod = :libelle where produit = :p;

  if (langue = 'N') then
    update t_produit set designcnknl_prod = :libelle where produit = :p;    		
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_attestation(
  medecin_conseil_id integer
  ,personne_id integer
  ,tar_id integer
  ,tar30_categorie_code varchar(1)
  ,tar30_condition_code varchar(1)
  ,limite_validite date
  ,numero_autorisation varchar(20)
  )
as
begin
  insert into t_attestation(
  	attestation,
  	speid,
  	cliid,
  	numatt,
  	datelimite,
  	catremb,
  	condremb)
  values(
  	:medecin_conseil_id,
  	:tar_id,
  	:personne_id,
  	:numero_autorisation,
  	:limite_validite,
  	case
  	  when :tar30_categorie_code='A' then 1
      when :tar30_categorie_code='B' then 2
      when :tar30_categorie_code='C' then 3
      when :tar30_categorie_code= 'S' then 4
      when :tar30_categorie_code= 'X' then 5
      when :tar30_categorie_code= 'D' then 6
      when :tar30_categorie_code= 'G' then 7
      when :tar30_categorie_code= 'W' then 8
      when :tar30_categorie_code= 'J' then 9
      else 0
    end,
  	case
  	  when :tar30_condition_code=' ' then 1
      when :tar30_condition_code= '?' then 2
      when :tar30_condition_code= 'N' then 3
      when :tar30_condition_code= 'V' then 4
      when :tar30_condition_code= 'A' then 5
      when :tar30_condition_code= '$' then 5
      when :tar30_condition_code= 'I' then 6
      when :tar30_condition_code= 'E' then 7
      when :tar30_condition_code= 'K' then 8
      when :tar30_condition_code= 'T' then 9
      when :tar30_condition_code= 'J' then 10
      when :tar30_condition_code= 'n' then 11
      else 0
    end);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_histo_vente(
  annee integer,
  mois integer,
  tar_id integer,
  quantite integer)
as
begin
  insert into t_histovente(
  	histovente,
  	periode,
  	annee,
  	mois,
  	speserie,
  	qtevendue,
  	nbventes)
  values(
  	next value for seq_historique_vente,
  	lpad(:annee, 4, '0') || '/' || lpad(:mois, 2, '0') || '/01',
  	:annee,
  	:mois,
  	:tar_id,
  	:quantite,
  	:quantite);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_histo_entete(
  vente_id integer, 
  date_vente date, 
  personne_id integer, 
  date_prescription date, 
  nom varchar(64),
  prenom varchar(64),
  numero_ordonnance integer)
as
begin
  insert into t_histodelgeneral(
  	histodelgeneral,
  	clientid,
  	facture,
    date_acte,
    date_prescription,
    nom_medecin,
    prenom_medecin,
    thetypefactur)
  values(
  	:vente_id,
  	:personne_id,
  	:numero_ordonnance,
  	:date_vente,
    :date_prescription,
    substring(:nom from 1 for 50),
    substring(:prenom from 1 for 50),
    iif(:numero_ordonnance = 0, '3', '2'));
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_histo_ligne(
  vente_ligne_specialite_id integer, 
  vente_id integer, 
  tar_id integer, 
  libelle varchar(64),
  delivre integer, 
  prix_public_piece float)
as
declare variable p varchar(50);
declare variable d varchar(50);
declare variable cnk varchar(7);
begin
  p = cast(tar_id as varchar(50));
  
  if (libelle is null) then
    select designcnkfr_prod, codecnk_prod 
    from t_produit
    where produit = :p
    into :d, :cnk;
  else
    d = libelle;

if (d is not null) then 
  insert into t_histodeldetails(
  	histodeldetails,
  	histodelgeneralid,
  	cnkproduit,
    designation,
    qtefacturee,
    prixvte,
    produitid)
  values(
  	:vente_ligne_specialite_id,
  	:vente_id,
  	:cnk,
    :d,
    :delivre,
    :prix_public_piece,
    :tar_id);
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_lib_chimique(
  cnk varchar(7), 
  denomination varchar(50),
  code_langue char(1),
  code_synonyme char(1))
as
begin
 
  insert into t_libelle_chimique ( libellechimique,
                                   chimique,
                                   designation,
                                   langue,
                                   synonyme ) 
  values (:cnk||:code_langue||:code_synonyme,
          :cnk,
          :denomination, 
          :code_langue,
          :code_synonyme );
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_histo_lig_mag(
  histodelmagistrale integer, 
  vente_id integer, 
  designation varchar(64),
  qteFacturee integer, 
  form integer,
  qtfaire integer,
  cnkProduit varchar(7),
  complement integer, ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
  quantite_prep float, ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
  unit int ---- Avérifier si c'est la bonne quantite dans le bon format / quantite
)
as
declare unite integer;
declare forme integer;
declare qtprep float;
declare libChimique varchar(50);

/*public static final int UNDEFINED                         = -6969; --forme galenique
     public static final int GEL_PER_OS                        = 0; // FMX = 45  // ultimate : 
     public static final int USAGE_EXTERNE_LIQUIDE             = 1; // FMX = 12  // ultimate : 
     public static final int GEL_DERMATO                       = 2; // FMX = 46  // ultimate : 16
     public static final int CREME                             = 3; // FMX = 21  // ultimate : 16
     public static final int PATE                              = 4; // FMX = 54  // ultimate : 
     public static final int ONGUENT                           = 5; // FMX = 20  // ultimate : 16
     public static final int POMMADE                           = 6; // FMX = 19  // ultimate : 16
     public static final int POTION                            = 7; // FMX = 11  // ultimate : 13
     public static final int SIROP                             = 8; // FMX = 11  // ultimate : 
     public static final int GOUTTES_ORALES                    = 9; // FMX = 11  // ultimate : 
     public static final int POUDRE_OU_PLANTES_UE              = 10; // FMX = 16  // ultimate : 15
     public static final int CAPSULE                           = 11; // FMX = 2  // ultimate : 1
     public static final int CACHET                            = 12; // FMX = 3  // ultimate : 3
     public static final int POMMADE_NASALE                    = 13; // FMX = 29  // ultimate : 
     public static final int POUDRE_DIVISEE_UE                 = 14; // FMX = 5  // ultimate : 5
     public static final int CAPSULE_GASTRO_RESISTANTE         = 15; // FMX = 26  // ultimate : 
     public static final int OVULE                             = 16; // FMX = 8  // ultimate : 
     public static final int SUPPOSITOIRE_NOURRISSON           = 17; // FMX = 43  // ultimate : 9 
     public static final int SUPPOSITOIRE_ENFANT               = 18; // FMX = 7  // ultimate : 8
     public static final int SUPPOSITOIRE_ADULTE               = 19; // FMX = 6  // ultimate : 6
     public static final int RECTIOLE                          = 20; // FMX = 47  // ultimate : 
     public static final int COLLYRE                           = 21; // FMX = 13  // ultimate : 17
     public static final int POMMADE_OPHTALMIQUE               = 22; // FMX = 29  // ultimate : 19
     public static final int LOTION_OPHTALMIQUE                = 23; // FMX = 14  // ultimate : 18
     public static final int TEL_QUEL                          = 24; // FMX = 25  // ultimate : 20
     public static final int TEL_QUEL_DERMATO_SOLIDE           = 25; // FMX = 58  // ultimate : 
     public static final int TEL_QUEL_DERMATO_LIQUIDE          = 26; // FMX = 59  // ultimate : 
     public static final int TEL_QUEL_POTION                   = 27; // FMX = 36  // ultimate : 
     public static final int TEL_QUEL_POUDRE_OU_PLANTE_UE      = 28; // FMX = 60  // ultimate : 
     public static final int GOUTTES_NASALES                   = 29; // FMX = 12  // ultimate : 12
     public static final int LAVEMENT                          = 30; // FMX =  // ultimate : 
     public static final int TEL_QUEL_POUDRE_OU_PLANTE_UI      = 31; // FMX = 61  // ultimate : 
     public static final int POUDRE_OU_PLANTES_UI              = 32; // FMX = 15  // ultimate : 14
     public static final int POUDRE_DIVISEE_UI                 = 33; // FMX = 4  // ultimate : 
     // NON REMBOURSE  
     public static final int GOMMETTE               = 34;  // ultimate : 
     public static final int PILULE                 = 35; // FMX = 1  // ultimate : 4
     public static final int GRANULE                = 36;  // ultimate : 
     public static final int COMPRIME               = 37;  // ultimate : 
     public static final int TABLETTE               = 38;  // ultimate : 
     public static final int AMPOULE                = 39;  // ultimate : 
     public static final int CIGARETTE              = 40;  // ultimate : 
     public static final int BERLINGOT              = 41;  // ultimate : 
*/

/*   unité : 
     public static final int MILLILITRE  = 0x0000;  // ultimate : 3
     public static final int MICROGRAMME = 0x0001;  // ultimate : 6
     public static final int MILLIGRAMME = 0x0002;  // ultimate : 2
     public static final int GRAMME      = 0x0003;  // ultimate : 1
     public static final int KILOGRAMME  = 0x1003; // uniquement pour le calcul tarification même si pas vraiment utile (magistrales de plus d'une tonne)
     public static final int PIECE       = 0x0004;  // ultimate : 5
     public static final int UNITE       = 0x0005;  // ultimate : 9
     public static final int KILOUNITE   = 0x0006;  // ultimate : 
     public static final int MEGAUNITE   = 0x0007;  // ultimate : 10
     public static final int LITRE       = 0x0008;  // ultimate : 
     public static final int METRE_CUBE  = 0x0009;  // ultimate : 8
     public static final int GOUGOUTTE   = 0x000A;  // ultimate : 4
     */ 
begin
  forme = case 
            when :form = 2 or :form = 3 or :form = 5 or :form = 6 then 16  
            when :form = 7 then 13  
            when :form = 10 then 15  
            when :form = 11 then 1  
            when :form = 12 then 3  
            when :form = 14 then 5  
            when :form = 17 then 9  
            when :form = 18 then 8  
            when :form = 19 then 6  
            when :form = 21 then 17  
            when :form = 22 then 19 
            when :form = 23 then 18 
            when :form = 24 then 20 
            when :form = 29 then 12  
            when :form = 32 then 14 
            when :form = 35 then 4  
            else null
          end;
  unite = case 
            when :unit = 0 then 3  
            when :unit = 1 then 6  
            when :unit = 2 then 2  
            when :unit = 3 then 1  
            when :unit = 4 then 5  
            when :unit = 5 then 9  
            when :unit = 6 then 9 -- attention à faire *100 sur la quantité  
            when :unit = 7 then 10  
            when :unit = 9 then 8  
            when :unit = 10 then 4  
            else null
          end;
  qtprep = case 
            when :unit = 6 then :quantite_prep*1000  
            else :quantite_prep
          end;

  select designation 
  from t_libelle_chimique
  where chimique = :cnkProduit 
  into :libChimique;
     
  if (libChimique is null) then libChimique = 'INCONNU';       

  -- if (not exists(select 1 from t_HISTODELMAGISTRALE where HISTODELMAGISTRALE=:histodelmagistrale)) then
    insert into T_HISTODELMAGISTRALE(histodelmagistrale,
                                     histodelgeneralID,
                                     designation,
                                     qteFacturee,
                                     detail,
                                     clemag
    )
    values(:histodelmagistrale,
           :vente_id,
           :designation,
           :qteFacturee,
           substring((:forme||';'||:qtfaire||'<BR>'||lpad(:cnkProduit,7,'0')||';'||trim(:libChimique)||';'||trim(:complement)||';'||:qtprep||';'||:unite||';;<BR>') from 1 for 4000),
           iif(:unite is null or :forme is null , null,:histodelmagistrale) -- on passe à null pour générer une erreur
    );
    when SQLCODE -803 do update T_HISTODELMAGISTRALE
      set detail = substring((detail||lpad(:cnkProduit,7,'0')||';'||trim(:libChimique)||';'||trim(:complement)||';'||:qtprep||';'||:unite||';;<BR>') from 1 for 4000)
      where histodelmagistrale=:histodelmagistrale;
end;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_deldif(
  vente_ligne_specialite_id integer, 
  produit integer, 
  client integer,
  medecin integer,
  noOrdon integer, 
  qttDiff integer,
  datedeliv date,
  dateprescr date)
as
begin
	INSERT INTO t_deldif(
		deldif
		,produit
		,client
		,medecin
		,noOrdon
		,qttDiff
		,datedeliv
		,dateprescr
		,dateOrdon)
	VALUES(
		next value for seq_deldif_id
		,:produit
		,:client
		,:medecin
		,:noOrdon
		,iif(:qttDiff is null, 0, :qttDiff )
		,:datedeliv
		,:dateprescr
		,:datedeliv);
End;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_credit(
	 credit int
	,montant float
	,datecredit date
	,client int
	)
as
begin

insert into t_CREDIT(
 credit
,montant
,datecredit
,client
)
values(
 :credit
,:montant
,:datecredit
,:client
);
End;

/* ******************************************************************************************************* */
create or alter procedure ps_ipharma_creer_avanceproduit(
	litige int
	,client int
    ,produit int
    ,nomPdt varchar(50)
    --,noOrd varchar(50)--int
    ,dateVente date
    ,prixClient float /* Montant que le client paye (tva comprise) sans le montant payé par le tiers payant*/
    --,qtedelivree float
    --,qtemanquante float
    --,isFacture char(1)
    ,cdbu varchar(16)
)
as
declare variable nb int;
begin

insert into t_litige(
	 litige
	,client
	,typeLitige  /* 1 => Manque ordonnance */
	,descriptionLitige
	,nomPdt
	,produit
	--,noOrd
	,prixClient  /* Montant que le client paye (tva comprise) sans le montant payé par le tiers payant*/
	,qtedelivree
	--,qtemanquante
	,dateVente
	--,isFacture
	,cdbu
)
values(
	 :litige
	,:client
	,1
	,''
	,:nomPdt
	,:produit
	--,:noOrd
	,:prixClient
	,1
	--,0
	,:dateVente
	--,:isFacture
	,:cdbu
    );
end;
