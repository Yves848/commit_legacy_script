set sql dialect 3;

create or alter procedure ps_convertir_varchar_vers_date(
  AInDate varchar(10))
returns(
  AOutDate date)
as
declare variable d varchar(8);
begin
  d = cast(AInDate as varchar(8));
  AOutDate = cast(substring(d from 7 for 4) || '-' ||
                  substring(d from 4 for 2) || '-' ||
				  substring(d from 1 for 2) as date);

  when any do
    AOutDate = null;  
end;

create or alter procedure ps_dyna_creer_client(
	code varchar(8),
	nom varchar(50),
	prenom varchar(50),
	civilite varchar(15),
	voie varchar(100),
	codepostal varchar(7),
	ville varchar(50),
	telephone varchar(50),
	portable varchar(50),
	email varchar(50),
	datenaissance varchar(12),
	points integer,
	credit float,
	dummy varchar(10))
as
declare variable dn date;
begin
  execute procedure ps_convertir_varchar_vers_date(:datenaissance) returning_values :dn;

  insert into t_client(t_client_id,
  	nom,
  	prenom,
  	date_naissance,
  	rue_1,  	
  	rue_2,
  	code_postal,
  	nom_ville,
  	tel_standard,
  	tel_mobile)
  values(
  	trim(:code),
  	trim(substring(:nom from 1 for 30)),
  	trim(substring(:prenom from 1 for 30)),
  	:dn,
	trim(substring(:voie from 1 for 40)),
  	trim(substring(:voie from 41 for 40)),
  	trim(substring(:codepostal from 1 for 5)),
  	trim(substring(:ville from 1 for 30)),
  	trim(substring(:telephone from 1 for 20)),
  	trim(substring(:portable from 1 for 20)));

    insert into t_commentaire (t_commentaire_id,
                             t_entite_id,
                             type_entite,
                             commentaire,
                             est_global )
  	values (next value for seq_commentaire,
          trim(:code),
          '0', -- client 
          cast('Points de fidélite :' || :points as blob),
          '0');  
end;

create or alter procedure ps_dyna_creer_produit(
	code varchar(13),
	reference varchar(20),
	codebarre varchar(13),
	numfour varchar(10),
	nomfour varchar(50),
	designation varchar(50),
	libcourt varchar(50),
	pxrevient float,
	pxpublic float,
	txtva float,
	stockqte integer,
	stockmin integer,
	stockmax integer,
	cmd integer,
	emb integer,
	dummy varchar(30))
as  
declare variable intTVA integer;
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_tva(txtva) returning_values :intTVA;
  execute procedure ps_renvoyer_id_prestation('PHN') returning_values :intPrestation;

  insert into t_produit(t_produit_id,
  	code_cip,
  	designation,
  	prix_vente,
  	prix_achat_catalogue,
  	t_ref_tva_id,
    t_ref_prestation_id)
  values(:code,
  	iif((:code similar to '340[01][[:DIGIT:]]{9}') or (:code similar to '[[:DIGIT:]]{7}') ,:code ,null ) ,
  	trim(:designation),
  	:pxpublic,
  	:pxrevient,
  	:intTVA,
    :intPrestation);

  if (((numfour is not null) and (trim(numfour) <> '')) and
      ((nomfour is not null) and (trim(nomfour) <> ''))) then
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
  	  raison_sociale)
    values(:numfour,
  	  trim(:nomfour));



 if ((code similar to '[[:DIGIT:]]{13}' ) and not(:code similar to '340[01][[:DIGIT:]]{9}'))   then
    insert into t_code_ean13(t_code_ean13_id,
    	t_produit_id,
    	code_ean13)
    values(next value for seq_code_ean13,
    	:code,
    	:code);


  if ((codebarre similar to '[[:DIGIT:]]{13}') and (codebarre<>code)) then
    insert into t_code_ean13(t_code_ean13_id,
    	t_produit_id,
    	code_ean13)
    values(next value for seq_code_ean13,
    	:code,
    	:codebarre);
  
  if ((stockqte is not null) and (stockqte > 0)) then
    insert into t_produit_geographique(t_produit_geographique_id,
      t_produit_id,
      quantite,
      stock_mini,
      stock_maxi,
      t_depot_id)
    values(next value for seq_produit_geographique,
      :code,
      :stockqte,
      :stockmin,
      :stockmax,
      '1');
end;