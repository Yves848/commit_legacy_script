set sql dialect 3;

create or alter procedure ps_separer_valeurs(
  AValeurs varchar(5000),
  ASeparateur varchar(20))
returns(
  AValeur varchar(5000))
as
declare variable p integer;
declare variable s varchar(5000);
begin
  s = AValeurs;
  p = position(ASeparateur in s);
  while (p > 0) do
  begin
    AValeur = substring(s from 1 for p - 1);
    suspend;

    s = substring(s from p + char_length(ASeparateur) for char_length(s));
    p = position(ASeparateur in s);
  end

  AValeur = s;
  suspend;
end;


/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_medecin(
  a_artsnummer integer,
  a_naam varchar(40),
  a_voornaam varchar(40), 
  a_rizivnr char(8),
  a_kwalificatie char(3),
  a_email_adres varchar(50), 
  a_tekst varchar(5000), 
  a_straat varchar(80),
  pc_nummer varchar(8),
  pc_gemeente varchar(40),
  t_telefoonnummer varchar(20))
as
declare codesp varchar(3);
declare inaminr varchar(8);
begin

--if (substring(a_kwalificatie from 3 for 1) not similar to '[[:DIGIT:]]*') then 
-- inutile de decouper la chaine avec une regex 
-- '__[[:DIGIT:]]%' = le 3 eme caractere est un chiffre
if ( a_kwalificatie not similar to '__[[:DIGIT:]]%') then 
  codesp = substring(trim(a_kwalificatie) from 1 for 2)||'0';
else 
  codesp = a_kwalificatie;

if (a_rizivnr is null or a_rizivnr = '') THEN
  inaminr = '10000205';
ELSE 
  inaminr = a_rizivnr;

  insert into t_medecin (
    medecin,
    nom,
    prenom,
    identifiant,
    matricule,
    codespec,
    commentaires,
    email,
    rue1,
    tel1,
    cp,
    ville,
    categorie
    ) 
  values (
    :a_artsnummer, 
    :a_naam,
    :a_voornaam, 
    :inaminr||:codesp,
    :inaminr, 
    coalesce(:codesp,'999'),
    substring(f_rtf_vers_text(:a_tekst) from 1 for 500), 
    :a_email_adres, 
    substring(:a_straat from 1 for 70),
    :t_telefoonnummer,
    :pc_nummer,
    :pc_gemeente,
    case when (trim(:inaminr))='10000205' then '3'
	   	 
		  else '1'
	 end
    );
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_patient(
  k_klantnummer integer,
  k_familienaam varchar(40),
  k_voornaam varchar(40),
  k_email_adres varchar(50),
  k_familie_id integer,
  k_704 char(1),
  k_taal_cbl varchar(2),
  k_insz char(11),
  k_tekst varchar(5000),
  k_afschrift char(1),
  k_laatste_bezoek date,
  a_straat varchar(80), 
  pc_nummer varchar(8),
  pc_gemeente varchar(40),
  ks_geboortedatum date,
  ks_geslacht smallint,
  ks_sis_gelezen date,
  ks_nr_sis char(10),
  ks_certificaat char(32),
  ks_cg1 char(3),
  ks_cg2 char(3),
  ks_versie_verz char(2),
  ks_stamnummer varchar(20),
  ks_categorie varchar(3),
  K_MUT2_STAMNUMMER varchar(20),
  K_MUT2_SOORT smallint,
  ks_sisgeldigheid date,
  ks_mut integer,
  k_factgroep integer,
  k_kortingspercent numeric(9,2), -- remise 
  k_taalcode varchar(2),
  t_telefoonnummer varchar(20))
as
declare variable lChNatPieceJustif char(1);
declare variable OC char(3);
begin
  if (ks_sis_gelezen is null) then
    if ((ks_sisgeldigheid is not null) and (char_length(ks_cg1) > 0) and (char_length(ks_cg2) > 0)) then
      lChNatPieceJustif = '2';
    else
      lChNatPieceJustif = '0';
  else
    if (ks_sisgeldigheid is not null) then
      lChNatPieceJustif = '1';
    else
      lChNatPieceJustif = '2';
      
  insert into t_client (
    client, 
    nom, 
    prenom1,
    payeur,
    langue, 
    email, 
    idfamille, 
    edition704, 
    editioncbl, 
    editionbvac, 
    niss, 
    commentaireindiv, 
    rue1, 
    cp, 
    localite, 
    sexe, 
    datenaissance, 
    derniere_lecture, 
    numerocartesis,
    certificat, 
    ct1, 
    ct2, 
    versionassurabilite, 
    MATOC,
    OC,
    CATOC,
    matoa, 
    datefinoa, 
    tel1, 
    natpiecejustifdroit,
    oa,
    datedernierevisite,
    numgroupe,
    idprofilremise) 
  values (
   :k_klantnummer,
   substring(iif(:k_familienaam is null, '', :k_familienaam) from 1 for 30), 
   substring(:k_voornaam from 1 for 35),
   'A', 
   iif(:k_taalcode = 'FR', '0', '1'), 
   :k_email_adres, 
   :k_familie_id, 
   iif(:k_704 = 'Y', '1', '0'),
   iif(:k_taal_cbl in ('FR', 'DE'), '1', '0'),
   iif(:k_afschrift = 'Y', '1', '0'),
   iif(:k_insz similar to '[[:DIGIT:]]*', :k_insz, null),
   substring(f_rtf_vers_text(:k_tekst) from 1 for 500), 
   substring(:a_straat from 1 for 70), 
   trim(:pc_nummer), 
   trim(:pc_gemeente), 
   iif(:ks_geslacht similar to '[[:DIGIT:]]*', :ks_geslacht, 0), 
   :ks_geboortedatum, 
   coalesce(:ks_sis_gelezen, '1980-01-01'), 
   iif(:ks_nr_sis similar to '[[:DIGIT:]]*', :ks_nr_sis, null),
   substring(:ks_certificaat from 1 for 6), 
   iif(:ks_cg1 similar to '[[:DIGIT:]]*', :ks_cg1, null), 
   iif(:ks_cg2 similar to '[[:DIGIT:]]*', :ks_cg2, null), 
   iif(:ks_versie_verz similar to '[[:DIGIT:]]*', :ks_versie_verz, 0),
   :K_MUT2_STAMNUMMER,
   case
    when :K_MUT2_SOORT='1' then '993'
    when :K_MUT2_SOORT='2' then '993'
    --when :CATOC='CP' then 0
    else null
    end,
   case
    when :K_MUT2_SOORT='1' then 93
    when :K_MUT2_SOORT='2' then 91
    --when :CATOC='CP' then 0
    else null
    end,
   substring(:ks_stamnummer from 1 for 13), 
   :ks_sisgeldigheid, 
   :t_telefoonnummer, 
   :lChNatPieceJustif,
   substring(cast(:ks_mut as varchar(20)) from 1 for 3),
   :k_laatste_bezoek,
   '99999' || :k_factgroep,
   iif(:k_kortingspercent = 0, null, :k_kortingspercent));
end;

create or alter procedure ps_farmadtwin_upd_pha_ref(
  client_id integer,
  dateo date,
  cnk varchar(7)
)
as
  declare variable pha_ref integer;
begin
   --'5520689','5520705','5520721', '5520739','5520788','5521059'
   pha_ref = 0;
   if (:cnk in ('5520689','5520705','5520739','5521059') ) then pha_ref = 2;       
   if (:cnk in ('5520721','5520788') ) then pha_ref = 6;
   
   
   update t_client
   set ph_ref = :pha_ref
   where client = :client_id;
end;

  /* ********************************************************************************************** */
  create or alter procedure ps_farmadtwin_creer_collect(
    fg_id integer,
    fg_titularis varchar(40),
    fg_adres varchar(80),
    pc_nummer varchar(8),
    pc_gemeente varchar(40),
    fg_telefoonnummer char(20),
    fg_btwnummer varchar(20),
    fg_taal varchar(2),
    fg_email varchar(50))
  as
  begin
    insert into t_client(
      client, 
      nom, 
      payeur, 
      rue1, 
      cp, 
      localite, 
      tel1, 
      num_tva, 
      collectivite,
      langue,
      email) 
    values (
      '99999' || :fg_id,
      substring(trim(:fg_titularis) from 1 for 30), 
      'A',
      substring(:fg_adres from 1 for 70), 
      trim(:pc_nummer), 
      trim(:pc_gemeente), 
      trim(:fg_telefoonnummer), 
      substring(:fg_btwnummer from 1 for 15), 
      '1',
      iif(:fg_taal = 'FR', '0', '1'),
      :fg_email 
    );
  end;
  
  
/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_profil_rem(
  k_kortingspercent numeric(9, 2))
as
begin
  insert into t_profilremise(
    profilremise,
    defaultofficine,
    libelle,
    tauxreglegen,
    typeristourne,
    plafondristourne) 
  values(
    :k_kortingspercent,
    '0',
    :k_kortingspercent || ' %',
    :k_kortingspercent,
    '0',
    0);
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_carte_rist(
  sk_id varchar(13), 
  sk_klantid integer, 
  sk_spaarrekeningid integer)
as
begin
  insert into t_carterist(
    carterist, 
    compteid, 
    cliid, 
    dateemis, 
    etat, 
    numcarte) 
  values(
    :sk_id,
    :sk_spaarrekeningid,
    :sk_klantid,
    current_date,
    '1', 
    :sk_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_compte_rist(
  skr_id integer, 
  skr_hoofdklant integer)
as
begin
  INSERT INTO T_COMPTE(
    compte,
    cliID,
    liberType,
    liberVal,
    etat) 
  VALUES (
    :skr_id,
    :skr_hoofdklant,
    '1',
    5,
    '1');
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_trans_rist(
  compteid integer,
  somme_type0 integer,  
  somme_type2 integer,
  tauxtva integer
  )
as
declare variable mnt0 float;
declare variable mnt2 float;
declare variable ttva integer;
declare variable i integer=0;
begin

  ttva = case 
      when :tauxtva=2 then 12
      when :tauxtva=3 then 21
      else 6 
      end;

  --creation des transactions de type 0
  mnt0 = cast(somme_type0 as float)/100; 
  while (mnt0 > 0) do
  begin    
    insert into t_transactionrist(
      transactionrist,
      compteid,
      montantrist,
      typetransact,
      tauxtva) 
    values (
      next value for seq_transaction_ristourne,
      :compteid,
      iif(:mnt0 < 900, :mnt0, 900),
      0,
    :ttva
      );      
    mnt0 = mnt0 - 900;
  end
  
  --creation des transactions de type 2, on rajoute une ligne en 0 et 1 pour équilibrer le compte
  mnt2 = cast(somme_type2 as float)/100; 
  while (mnt2 > 0) do
  begin    
  while (i < 3) do 
    begin
    insert into t_transactionrist(
      transactionrist,
      compteid,
      montantrist,
      typetransact,
      tauxtva ) 
    values (
      next value for seq_transaction_ristourne,
      :compteid,
      iif(:mnt2 < 900, :mnt2, 900),
      :i,
      :ttva
      );   

      i=i+1;
    end
  
    mnt2 = mnt2 - 900;
  end
end;

/* ******************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_fournisseur(
  l_type_leverancier smallint,
  l_levnummer integer,
  l_leverancier varchar(40),
  l_adres varchar(40),
  l_postcodenummer varchar(6),
  l_gemeente varchar(40), 
  l_email_adres varchar(50),
  l_klantnummer char(15))
as
begin   
  if (l_type_leverancier = 6) then
    insert into t_fournisseur(
      fournisseur,
      nomfourn,
      ruefourn,
      locfourn,
      cpfourn,
      nbpdtsassocies,
      numapb,
      email) 
    values(
      :l_levnummer,
      :l_leverancier,
      :l_adres,
      :l_gemeente,
      :l_postcodenummer,
      0,
      iif(char_length(:l_klantnummer)>4,null, :l_klantnummer),
      :l_email_adres);
  else if (l_type_leverancier = 2) then
    insert into t_repartiteur(
      repartiteur,
      nomrepart,
      ruerepart,
      locrepart,
      cprepart,
      nbPdtsAssocies,
      email) 
    values(
      :l_levnummer,
      :l_leverancier,
      :l_adres,
      :l_gemeente,
      :l_postcodenummer,
      0,
      :l_email_adres);
end;

create or alter procedure ps_farmadtwin_maj_tel_four(
  lt_levnummer integer,
  l_type_leverancier smallint,
  lt_telefoonnummer varchar(20))
as
declare variable v varchar(30);
declare variable ChTypeTelephone char(1);
declare variable strTelephone varchar(20);
declare variable tel1 varchar(20);
declare variable tel2 varchar(20);
declare variable gsm varchar(20);
declare variable fax varchar(20);
begin
  if (lt_telefoonnummer <> '') then  
    for select AValeur
        from ps_separer_valeurs(:lt_telefoonnummer, ',')
        into :v do
    begin
      chTypeTelephone = substring(v from 1 for 1);
      strTelephone = substring(v from 3 for 20);
      if (chTypeTelephone = 1) then
        tel1 = strTelephone;
      else if(chTypeTelephone = 2) then
        tel2 = strTelephone;
      else if(chTypeTelephone = 3) then
        fax = strTelephone;
      else if(chTypeTelephone = 4) then
        gsm = strTelephone;
    end
  
  if (l_type_leverancier = 6) then
    update t_fournisseur
    set tel = :tel1,
        tel2 = :tel2,
        gsm = :gsm,
        fax = :fax
    where fournisseur = :lt_levnummer;
  else if (l_type_leverancier = 2) then
    update t_repartiteur
    set tel = :tel1,
        tel2 = :tel2,
        gsm = :gsm,
        fax = :fax
    where repartiteur = :lt_levnummer;    
end;

create or alter procedure ps_farmadtwin_maj_fournisseur(
  p_levnum integer,
  nb_p integer)
as
begin
  update t_fournisseur
  set nbpdtsassocies = :nb_p
  where fournisseur = :p_levnum;

  update t_repartiteur
  set nbpdtsassocies = :nb_p
  where repartiteur = :p_levnum;
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_tarif(
  p_levnum integer,
  p_cnknummer char(7),
  p_prijs numeric(15, 4),
  l_type_leverancier smallint,
  p_kritieklevnum integer,
  l_type_leverancier2 smallint
  )
as
begin
  INSERT INTO t_tarifpdt(
    tarifpdt,
    produit,
    fou,
    prxAchat,
    isRepart,
    isAttitre) 
  VALUES(
    next value for seq_tarif_produit,
    :p_cnknummer,
    :p_levnum,
    :p_prijs,
    iif(:l_type_leverancier = 2, '1', '0'),
    '1');
  
  if  (p_kritieklevnum <>0 and p_kritieklevnum is not null) then
    INSERT INTO t_tarifpdt(
    tarifpdt,
    produit,
    fou,
    prxAchat,
    isRepart,
    isAttitre) 
    VALUES(
    next value for seq_tarif_produit,
    :p_cnknummer,
    :p_kritieklevnum,
    :p_prijs,
    iif(:l_type_leverancier2 = 2, '1', '0'),
    '1');
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_stock(
  AProduit char(7),
  AStockMini integer,
  AStockMaxi integer,
  AStock integer,
  APriorite char(1),
  ADepot varchar(50),
  ADepotVente char(1),
  AZoneGeographique integer)
as
begin
  INSERT INTO t_stock(
    stock,
    qteEnStk,
    stkMin,
    stkMax,
    produit,
    zonegeo,
    priorite,
    depot,
    depotvente) 
  VALUES(
    :AProduit || '-' || :ADepot,
    coalesce(:AStock, iif(:AStock > 0, :AStock, 0)),
    coalesce(:AStockMini, 0),
    coalesce(:AStockMaxi, 0),
    :AProduit,
    :AZoneGeographique,
    :APriorite,
    :ADepot,
    :ADepotVente);
end;


/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_produit(
  pt_cnknummer char(7),
  pt_omschrijvingfr varchar(80),
  pt_omschrijving$$ varchar(80),
  p_verkoopprijs numeric(15,4),
  bk_bestelpunt integer,
  bk_bestelparameter integer,
  btw_percentage numeric(5,2),
  p_vervaldatum date,
  p_labo integer,
  p_tekst varchar(5000),
  ps_apotheek_stock integer,
  vr_plaatsnummer integer,
  ps_buffer_stock integer,
  p_robot_stock integer,
  ps_dubbelestock char(1),
  propre char(1))
as
declare variable libzonegeo varchar(50);
begin

  select libelle from t_zonegeo
  where zonegeo = :vr_plaatsnummer
  into :libzonegeo ;

  insert into t_produit(
    produit,
    codeCNK_prod,
    designCNKFR_prod,
    designCNKNL_prod,
    isPdtPropre,
    prixachatcatalogue,
    prixvente,
    baseremboursement,
    tva,
    labo,
    stockmini,
    stockmaxi,
    commentairevente,
    datePeremption,
    calculgs,
    creationLgCmd) 
  values(
    :pt_cnknummer,
    :pt_cnknummer,
    substring(:pt_omschrijvingfr from 1 for 50),
    substring(:pt_omschrijving$$ from 1 for 50), 
    iif(:propre='Y',1,0),
    '0',
    coalesce(:p_verkoopprijs, 0),
    '0',
    :btw_percentage,
    coalesce(:p_labo, 0) ,
    coalesce(:bk_bestelpunt, 0),
    coalesce(:bk_bestelparameter, 0),
    substring(f_rtf_vers_text(:p_tekst) from 1 for 200),
    :p_vervaldatum,
    '0',
    '0');

  --La gestion du stock robot est temporairement supprimé en attendant de trouver comment ça fonctionne exactement , je n'arrive pas à savoir si le stock robot est inclu ou pas dans le stock pharma et si le triple stock est possible ou pas
  
    if (trim(upper(libzonegeo)) = 'ROBOT') then
    begin  
      execute procedure ps_farmadtwin_creer_stock(:pt_cnknummer, :bk_bestelpunt, :bk_bestelparameter, :p_robot_stock, '2', '3', '1', null);  
      execute procedure ps_farmadtwin_creer_stock(:pt_cnknummer, :bk_bestelpunt, :bk_bestelparameter, :ps_apotheek_stock-:p_robot_stock, '1', '1', '1', null);
    end   
    else  
      execute procedure ps_farmadtwin_creer_stock(:pt_cnknummer, :bk_bestelpunt, :bk_bestelparameter, :ps_apotheek_stock, '1', '1', '1', :vr_plaatsnummer);

  if (ps_dubbelestock = 'Y') then
    execute procedure ps_farmadtwin_creer_stock(:pt_cnknummer, 0, 0, :ps_buffer_stock, '2', '2', '0', null);
end;


/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_ean(
  ean_code char(15),
  ean_cnknummer char(7))
as
begin
  insert into t_codebarre(
    codebarre,
    produit,
    code,
    ean13,
    cbu) 
  values(
    :ean_code || '-' || :ean_cnknummer,
    :ean_cnknummer,
    substring(:ean_code from 1 for 13),
    '1',
    '0');
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_zone_geo(
  vr_plaatsnummer integer,
  vr_tekstnl char(20))
as
begin
  insert into t_zonegeo(
    zonegeo,
    libelle)
  values(
    :vr_plaatsnummer,
    trim(:vr_tekstnl));
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_del_diff(
  kr_verkoopitem integer,
  kr_cnknummer char(7),
  kr_klantnummer integer,
  medecin integer,
  kr_voorschriftnr integer,
  kr_aantal integer,
  kr_datum date,
  vo_datum date,
  vo_vsdatum date)
as
begin
  insert into t_deldif(
    deldif,
    produit,
    client,
    medecin,
    noordon,
    dateprescr,
    qttdiff,
    dateordon) 
  values (
    :kr_verkoopitem,
    :kr_cnknummer,
    :kr_klantnummer,
    :medecin,
    :kr_voorschriftnr,
    :vo_vsdatum,
    iif(:kr_aantal=0,1, :kr_aantal),
    :kr_datum);
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_histo_vente(
  AAnnee smallint,
  AMois smallint,
  AProduit char(7),
  AQuantite integer)
as
begin
  INSERT INTO t_histovente(
    histovente,
    periode,
    annee,
    mois,
    speSerie,
    qteVendue,
    nbVentes) 
  VALUES(
    :AProduit || '-' || :AAnnee || '-' || :AMois,
    :AAnnee || '/' || lpad(:AMois, 2, '0') || '/01',
    :AAnnee,
    :AMois,
    :AProduit,
    :AQuantite,
    :AQuantite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_histo_del(
  vi_id integer, 
  vi_datum date, 
  vo_klantnummer integer,
  a_voornaam varchar(40), 
  a_naam varchar(40), 
  vo_vsdatum date, 
  vo_vsnummer integer)
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
    :vi_id,
    :vo_klantnummer,
    coalesce(:vo_vsnummer, 0),
    :vi_datum,
    :vo_vsdatum,
    :a_naam,
    :a_voornaam,
    iif(:vo_vsnummer >= 0 ,2 ,3) );

end;

/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_hist_dlig(
  vi_id integer,
  vi_cnknummer char(7),
  pt_omschrijvingfr varchar(80),
  vi_aantal_afgelev integer,
  vi_publieksprijs numeric(15,4))
as
declare variable clientid int;
declare variable ordoid int;
begin
  insert into t_histodeldetails(
    histodeldetails,
    histodelgeneralid,
    cnkproduit,
    designation,
    qtefacturee,
    prixvte,
    produitid) 
  values(
    next value for seq_historique_client_ligne,
    :vi_id,
    :vi_cnknummer,
    substring(:pt_omschrijvingfr from 1 for 50),
    :vi_aantal_afgelev,
    :vi_publieksprijs,
    :vi_cnknummer);

end;



/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_hist_mag(
  vi_id integer, -- entete
  vi_cnknummer char(7), -- numero magistrale
  designation_magistrale varchar(80), -- designation magistrale si vide alors cest un ingredient
  forme_galenique varchar(50), -- si pas de designation on reprend la form galenique en guise de titre 
  fmd_cnkdetail char(7), -- cnk produit
  ligne_magistrale varchar(80),
  quantite double precision,
  unite varchar(10),
  formule varchar(2000))
as
begin

 if (not exists(select null from t_HISTODELMAGISTRALE where HISTODELMAGISTRALE=:vi_id||'-'||:vi_cnknummer)) then
  if( :forme_galenique is not null ) then 
    insert into t_histodelmagistrale(
      histodelmagistrale,
      histodelgeneralid,
      designation,     
      qtefacturee, 
      clemag
      ) 
    values(
      :vi_id||'-'||:vi_cnknummer,
      :vi_id,
      coalesce(substring(:designation_magistrale from 1 for 50), :forme_galenique),
      :quantite,
      :vi_id||'-'||:vi_cnknummer
      );
    else
     insert into t_histodelmagistrale(
      histodelmagistrale,
      histodelgeneralid,      
      designation,
      qtefacturee, 
      detail,
      clemag
      ) 
    values(
      :vi_id||'-'||:vi_cnknummer,
      :vi_id,       
      :vi_id,
      1,
      iif(:forme_galenique is null, :fmd_cnkdetail||' '||:ligne_magistrale||' '||trim(trailing '.' from trim(trailing '0' from :quantite)  )||' '||:unite||'<BR>', ''),
      :vi_id||'-'||:vi_cnknummer
      );
  else  
  if (:forme_galenique is not null ) then 
    update t_histodelmagistrale
    set designation = coalesce(substring(:designation_magistrale from 1 for 50), :forme_galenique),
    qtefacturee = :quantite
    where histodelmagistrale = :vi_id||'-'||:vi_cnknummer ;
  else
    update t_histodelmagistrale
    set detail = detail||:fmd_cnkdetail||' '||:ligne_magistrale||' '||trim(trailing '.' from trim(trailing '0' from :quantite)  )||' '||:unite||'<BR> '
    where histodelmagistrale = :vi_id||'-'||:vi_cnknummer ;  

end;



/* ********************************************************************************************** */
create or alter procedure ps_farmadtwin_creer_attestation(
  at_attestid integer, 
  k_klantnummer integer, 
  kpa_cnknummer char(7), 
  at_categorie char(2), 
  vi_aflevering char(2),
  at_attestnummer varchar(40),
  at_vervaldatum date)
as
begin
  if ((select count(*) from t_attestation where NUMATT=substring(:at_attestnummer from 1 for 20)) = 0) then
  insert into t_attestation(
    attestation,
    speid,
    cliid,
    numatt,
    datelimite,
    catremb,
    condremb) 
  values(
    next value for seq_attestation,
    :kpa_cnknummer,
    :k_klantnummer,
    substring(:at_attestnummer from 1 for 20),
    :at_vervaldatum,
    case :at_categorie
      when 'A' then '1'
      when 'B' then '2'
      when 'C' then '3'
      when 'S' then '4'
      when 'X' then '5'
      when 'D' then '6'
      when 'G' then '7'
      when 'W' then '8'
      when 'J' then '9'
      else '99'
    end,
    case :vi_aflevering
      when ' ' then '1'
      when '?' then '2'
      when 'N' then '3'
      when 'V' then '4'
      when 'A' then '5'
      when '$' then '5'
      when 'I' then '6'
      when 'E' then '7'
      when 'K' then '8'
      when 'T' then '9'
      when 'J' then '10'
      when 'n' then '11'
      else '0'
    end);
end;


/**************************************   CREDIT  ************************************************/
create or alter procedure ps_farmadtwin_creer_credit(
   credit int
  ,client int
  ,datecredit date
  ,montant float
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


/********************************************************************************************************/
/**************************************   AVANCE PRODUIT ************************************************/
/********************************************************************************************************/
create or alter procedure ps_farmadtwin_creer_litige(
 client int
 ,produit char(7)
 ,nomPdt varchar(80)
 --,descriptionLitige varchar(200) --50
 ,qtedelivree int
 ,qtemanquante int
 ,prixClient float -- Montant que le client paye (tva comprise) sans le montant payé par le tiers payant
 ,dateVente date
 ,cdbu varchar(16)
 ,noOrd int
)
as
declare variable nb int;

begin
    insert into t_litige(
         litige
        ,client
        ,produit
        ,typeLitige  -- 1 => Manque ordonnance
   --     ,descriptionLitige
        ,nomPdt
        ,noOrd
        ,prixClient -- Montant que le client paye (tva comprise) sans le montant payé par le tiers payant
        ,qtedelivree
    ,qtemanquante
        ,dateVente
        ,isFacture
        ,cdbu
    )
    values(
         next value for seq_litige
        ,:client
        ,:produit
        ,1
     --   ,substring(trim(:descriptionLitige) from 1 for 50)
        ,substring(trim(:nomPdt) from 1 for 50)
        ,:noOrd
        ,:prixClient
        ,iif(:qtedelivree>0,:qtedelivree,0)
    ,iif(:qtemanquante>0,:qtemanquante,0)
        ,:dateVente
        ,1
        ,:cdbu
        );
end;

/**************************************   Autre litige  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_autre_litige(
  patient int
  ,cnkproduit  varchar(7) 
  ,nom_prd char(80)
  ,qte int
  ,datelitige date
  ,noOrd int
)
as
  declare variable comm varchar(500);
  declare variable blo int;
begin
  comm = 'Att Manq. ';
         
  if (cnkproduit<>'' and cnkproduit is not null) then comm = comm||'Pdt:'||trim(:cnkproduit);
  if (nom_prd<>'' and nom_prd is not null) then comm = comm||' '||trim(:nom_prd);
  if (qte<>0 and qte is not null) then comm = comm||' Qte:'||:qte;
  if (datelitige is not null) then  comm = comm||' Date:'||:datelitige;
  if (noOrd<>0 and noOrd is not null) then comm = comm||' Ordo N°'||trim(:noOrd);
  
  
  update t_client set COMMENTAIREINDIV = iif(COMMENTAIREINDIV is null or trim(COMMENTAIREINDIV)='',substring(:comm from 1 for 500),
         substring(COMMENTAIREINDIV||' - '||:comm from 1 for 500)) where client=:patient;

  update t_client set COMMENTAIREBLOQU=1 where client=:patient;

end;


/********************************************************************************************************/
/**************************************   fiche analyse  ************************************************/
/********************************************************************************************************/
create or alter procedure ps_creer_ficheanalyse(
   no_analyse int
  ,cnk_produit int
  ,no_autorisation varchar(20)
  ,ReferenceAnalytique varchar(20)
  ,date_entree date
  ,fabricant_id varchar(4)
  ,grossiste_id varchar(4)
  ,no_lot varchar(20)
  ,prix_achat_total float
 -- ,cnk_lie dm_varchar7 NOT NULL
  ,no_bon_livraison varchar(20)
  ,date_ouverture date
  ,date_peremption date
  ,date_fermeture date
--  ,etat dm_numeric1 DEFAULT 0
  ,quantite_initial float
--  ,quantite_restante dm_float7_2
  ,remarques varchar(5000)
--  ,datemaj dm_dateheure NOT NULL
)
as
begin
insert into T_FICHEANALYSE(
   fiche_analyse_id
  ,no_analyse
  ,cnk_produit
  ,no_autorisation
  ,ReferenceAnalytique
  ,date_entree
  ,fabricant_id
  ,grossiste_id
  ,no_lot
  ,prix_achat
  ,no_bon_livraison
  ,date_ouverture
  ,date_peremption
  ,date_fermeture
  ,etat
  ,quantite_initial
  ,quantite_restante
  ,remarques
  ,datemaj
)
values(
   :no_analyse
  ,:no_analyse
  ,:cnk_produit
  ,:no_autorisation
  ,:ReferenceAnalytique
  ,coalesce(:date_entree, coalesce(:date_ouverture,current_date))
  ,:fabricant_id
  ,:grossiste_id
  ,:no_lot
  ,iif(:quantite_initial=0,:prix_achat_total,:prix_achat_total/:quantite_initial)
  ,:no_bon_livraison
  ,:date_ouverture
  ,:date_peremption
  ,:date_fermeture
  ,iif(:date_fermeture is not null or :quantite_initial=0,2,iif(:date_ouverture is not null,1,0))
  ,:quantite_initial
  ,:quantite_initial
  ,substring(:remarques from 1 for 500)
  ,current_date
);
end;


/**************************************   Schema de medication produit  ************************************************/
create or alter procedure ps_creer_schema_produit(
  t_sch_medication_produit_id int
  ,t_produit_id int
  ,t_aad_id int
  ,date_debut date
  ,date_fin date
  ,commentaire varchar(200)
  ,libelle varchar(50)
)
as
--declare variable comm varchar(500);
begin

insert into t_sch_medication_produit(
  t_sch_medication_produit_id
  ,t_produit_id
  ,t_aad_id
  ,date_debut
  ,date_fin
  ,commentaire
  ,libelle
  ,typemedication
  )
values(
  :t_sch_medication_produit_id
  ,:t_produit_id
  ,:t_aad_id
  ,:date_debut
  ,:date_fin
  ,substring(:commentaire from 1 for 200)
  ,substring(:libelle from 1 for 50)
  ,1
 );
 
update t_client set SCH_POSOLOGIE= 1 where client = :t_aad_id;
 
End;



/**************************************   Schema de medication prise  ************************************************/

/*
  TABLE DES FREQUENCES

    MSF_ID      MSF_INTERVAL         MSF_FREQUENTIEFR        MSF_DAGEN  
    --------------------------------------------------------------------
    1           1                    quotidien               1          
    2           8                    tous les 8 jours        8          
    3           3                    tous les 3 jours        3          
    4           11                   tous les 11 jours       11         
    5           9                    tous les 9 jours        9          
    6           5                    tous les 5 jours        5          
    7           2                    tous les 2 jours        2          
    8           4                    tous les 4 jours        4          
    9           12                   tous les 12 jours       12         
    10          10                   tous les 10 jours       10         
    11          6                    tous les 6 jours        6          
    12          1                    annuellement            365        
    13          3                    tous les 3 ans          1095       
    14          6                    semestriel              183        
    15          5                    tous les 5 ans          1825       
    16          2                    tous les 2 ans          730        
    17          4                    tous les 4 ans          1460       
    18          6                    tous les 6 ans          2190       
    19          1                    mensuel                 30         
    20          8                    tous les 8 mois         240        
    21          18                   tous les 18 mois        540        
    22          3                    tous les 3 mois         90         
    23          11                   tous les 11 mois        330        
    24          9                    tous les 9 mois         270        
    25          5                    tous les 5 mois         150        
    26          7                    tous les 7 mois         210        
    27          2                    tous les 2 mois         60         
    28          4                    tous les 4 mois         120        
    29          10                   tous les 10 mois        300        
    30          6                    tous les 6 mois         180        
    31          2                    tous les 2 jours        2          
    32          0                    horaire                 1          
    33          0                    toutes les 8 heures     1          
    34          0                    toutes les 3 heures     1          
    35          0                    toutes les demi-heures  1          
    36          0                    toutes les 2 heures     1          
    37          0                    toutes les 4 heures     1          
    38          0                    toutes les 12 heures    1          
    39          0                    toutes les 6 heures     1          
    40          1                    hebdomadaire            7          
    41          8                    toutes les 8 semaines   56         
    42          3                    toutes les 3 semaines   21         
    43          11                   toutes les 11 semaines  77         
    44          9                    toutes les 9 semaines   63         
    45          24                   toutes les 24 semaines  168        
    46          5                    toutes les 5 semaines   35         
    47          7                    toutes les 7 semaines   49         
    48          2                    toutes les 2 semaines   14         
    49          4                    toutes les 4 semaines   28         
    50          12                   toutes les 12 semaines  84         
    51          10                   toutes les 10 semaines  70         
    52          6                    toutes les 6 semaines   42         
    58          0                    [Aucun]                 9999       

  TABLE DES MOMENTS

      MSM_ID      MSM_NAAMFR        
    ------------------------------
    1           matin             
    2           avant dejeuner     | 2 
    3           avec dejeuner      | 3
    4           après dejeuner     | 4
    5           10h00             
    6           avant dîner        | 2
    7           avec dîner         | 3
    8           après dîner        | 4
    9           16h00             
    10          avant souper       | 2
    11          avec souper        | 3
    12          après souper       | 4
    13          20h00             
    14          avant dormir      
    15          00h00             
    16          00h15             
    17          00h30             
    18          00h45             
    19          01h00             
    20          01h15             
    21          01h30             
    22          01h45             
    23          02h00             
    24          02h15             
    25          02h30             
    26          02h45             
    27          03h00             
    28          03h15             
    29          03h30             
    30          03h45             
    31          04h00             
    32          04h15             
    33          04h30             
    34          04h45             
    35          05h00             
    36          05h15             
    37          05h30             
    38          05h45             
    39          06h00             
    40          06h15             
    41          06h30             
    42          06h45             
    43          07h00             
    44          07h15             
    45          07h30             
    46          07h45             
    47          08h00             
    48          08h15             
    49          08h30                                                                                               
    50          08h45                                                                                               
    51          09h00                                                                                               
    52          09h15                                                                                               
    53          09h30                                                                                               
    54          09h45                                                                                               
    55          10h15                                                                                               
    56          10h30                                                                                               
    57          10h45                                                                                               
    58          11h00                                                                                               
    59          11h15                                                                                               
    60          11h30                                                                                               
    61          11h45                                                                                               
    62          12h00                                                                                               
    63          12h15                                                                                               
    64          12h30                                                                                               
    65          12h45                                                                                               
    66          13h00                                                                                               
    67          13h15                                                                                               
    68          13h30                                                                                               
    69          13h45                                                                                               
    70          14h00                                                                                               
    71          14h15                                                                                               
    72          14h30                                                                                               
    73          14h45                                                                                               
    74          15h00                                                                                               
    75          15h15                                                                                               
    76          15h30                                                                                               
    77          15h45                                                                                               
    78          16h15                                                                                               
    79          16h30                                                                                               
    80          16h45                                                                                               
    81          17h00                                                                                               
    82          17h15                                                                                               
    83          17h30                                                                                               
    84          17h45                                                                                               
    85          18h00                                                                                               
    86          18h15                                                                                               
    87          18h30                                                                                               
    88          18h45                                                                                               
    89          19h00                                                                                               
    90          19h15                                                                                               
    91          19h30                                                                                               
    92          19h45                                                                                               
    93          20h15                                                                                               
    94          20h30                                                                                               
    95          20h45                                                                                               
    96          21h00                                                                                               
    97          21h15                                                                                               
    98          21h30                                                                                               
    99          21h45                                                                                               
    100         22h00                                                                                               
    101         22h15                                                                                               
    102         22h30                                                                                               
    103         22h45                                                                                               
    104         23h00                                                                                               
    105         23h15                                                                                               
    106         23h30                                                                                               
    107         23h45                                                                                               

*/

create or alter procedure ps_creer_schema_prise(
  SCHEMA_ID INT,
  JOUR_SEMAINE INT,
  MOMENT_JOUR INT,
  DOSE FLOAT,
  JOUR_FREQUENCE INT,
  REMARQUE VARCHAR(200),
  FREQUENCE_ID INT
)
as
declare variable FREQUENCE_JOURS varchar(7);
begin
  if (not(exists(select * from t_sch_medication_prise where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID))) then
  begin 
   if (JOUR_SEMAINE = 0) then FREQUENCE_JOURS = '1111111';
   if (JOUR_SEMAINE = 1) then FREQUENCE_JOURS = '1000000';
   if (JOUR_SEMAINE = 2) then FREQUENCE_JOURS = '0100000';
   if (JOUR_SEMAINE = 3) then FREQUENCE_JOURS = '0010000';
   if (JOUR_SEMAINE = 4) then FREQUENCE_JOURS = '0001000';
   if (JOUR_SEMAINE = 5) then FREQUENCE_JOURS = '0000100';
   if (JOUR_SEMAINE = 6) then FREQUENCE_JOURS = '0000010';
   if (JOUR_SEMAINE = 7) then FREQUENCE_JOURS = '0000001';
    insert into t_sch_medication_prise(
        T_SCH_MEDICATION_PRISE_ID
        ,T_SCH_MEDICATION_PRODUIT_ID
        ,TYPE_FREQUENCE
        ,FREQUENCE_JOURS
        ,PRISE_LEVER 
        ,PRISE_PTDEJ 
        ,TYPE_MOMENT_PTDEJ 
        ,PRISE_MIDI 
        ,TYPE_MOMENT_MIDI 
        ,PRISE_SOUPER 
        ,TYPE_MOMENT_SOUPER 
        ,PRISE_COUCHER 
        ,PRISE_10HEURES 
        ,PRISE_16HEURES 
    ,PRISE_HEURE1
    ,LIBELLE_HEURE1
        )
    values(
         :SCHEMA_ID
        ,:SCHEMA_ID
        ,case when :JOUR_FREQUENCE = 0 then 2 when  :JOUR_FREQUENCE = 1 then 1 else 4 end 
        ,:FREQUENCE_JOURS
        ,iif(:moment_jour=1, :DOSE, 0) --PRISE_LEVER
        ,iif(:moment_jour=2 or :moment_jour=3 or :moment_jour=4, :DOSE, 0)
        --,iif(:moment_jour=2 or :moment_jour=3 or :moment_jour=4, :moment_jour-1, 0) --TYPE_MOMENT_PTDEJ
        ,:moment_jour
        ,iif(:moment_jour=6 or :moment_jour=7 or :moment_jour=8, :DOSE, 0) --PRISE_MIDI
        ,case when :moment_jour=6 then 2  when :moment_jour=7 then 3 when :moment_jour=8 then 4 else 1 end
        --,iif(:moment_jour=6 or :moment_jour=7 or :moment_jour=8, :moment_jour-5, 0) --TYPE_MOMENT_MIDI
        ,iif(:moment_jour=10 or :moment_jour=11 or :moment_jour=12, :DOSE, 0) --souper
        ,case when :moment_jour=10 then 2  when :moment_jour=11 then 3 when :moment_jour=12 then 4 else 1 end
        --,iif(:moment_jour=10 or :moment_jour=11 or :moment_jour=12, :moment_jour-9, 0) --TYPE_MOMENT_SOUPER
        ,iif(:moment_jour=14, :DOSE, 0) --PRISE_COUCHER (AVANT DORMIR)
        ,iif(:moment_jour=5, :DOSE, 0) -- PRISE_10HEURES
        ,iif(:moment_jour=9, :DOSE, 0) -- PRISE_16HEURES   
        ,iif(:moment_jour=13, :DOSE, 0) -- 20h   
    ,iif(:moment_jour=13, '20H', '') -- 20h   
  );
  end
  else
  begin
    select FREQUENCE_JOURS from T_SCH_MEDICATION_PRISE where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID into :FREQUENCE_JOURS;
    if (JOUR_SEMAINE <> 0) then
    begin
       FREQUENCE_JOURS = overlay(:FREQUENCE_JOURS placing '1' from :JOUR_SEMAINE);  
       
      update T_SCH_MEDICATION_PRISE set FREQUENCE_JOURS = :FREQUENCE_JOURS 
      where T_SCH_MEDICATION_PRODUIT_ID=:SCHEMA_ID and T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID;
    end
      
    if (:moment_jour = 1) then
        update T_SCH_MEDICATION_PRISE set PRISE_LEVER=:DOSE
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID;
    else if (:moment_jour=2 or :moment_jour=3 or :moment_jour=4) then 
        update t_sch_medication_prise set PRISE_PTDEJ=:DOSE, TYPE_MOMENT_PTDEJ=:moment_jour-1 
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --PTDEJ
    else if (:moment_jour=5) then  
        update t_sch_medication_prise set PRISE_10HEURES=:DOSE 
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --PRISE_10h
    else if (:moment_jour=6 or :moment_jour=7 or :moment_jour=8) then 
        update t_sch_medication_prise set PRISE_MIDI=:DOSE, TYPE_MOMENT_MIDI=:moment_jour-5  
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --midi
    else if (:moment_jour=9) then  
        update t_sch_medication_prise set PRISE_16HEURES=:DOSE 
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --PRISE_16h
    else if (:moment_jour=10 or :moment_jour=11 or :moment_jour=12) then 
        update t_sch_medication_prise set PRISE_SOUPER=:DOSE, TYPE_MOMENT_SOUPER=:moment_jour-9  
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --midi
    else if (:moment_jour=13) then  
        update t_sch_medication_prise set PRISE_HEURE1=:DOSE , LIBELLE_HEURE1 = '20H'
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --PRISE_COUCHER
  else if (:moment_jour=14) then  
        update t_sch_medication_prise set PRISE_COUCHER=:DOSE 
        where T_SCH_MEDICATION_PRISE_ID=:SCHEMA_ID; --PRISE_COUCHER
  end
  

End;

create or alter procedure ps_creer_ficheanalyse(
  no_analyse dm_code,
  cnk_produit dm_code,
  cnk_lien dm_code,
  no_autorisation varchar(20),
  ReferenceAnalytique varchar(20),
  date_entree date,
  fabricant_id dm_code,
  grossiste_id dm_code,
  no_lot varchar(20),
  prix_achat_total float,
  no_bon_livraison varchar(20),
  date_peremption varchar(20),
  quantite_initial float,
  unites dm_code
)
as
  declare variable unite_qte integer;
begin
  unite_qte = 0;
  if (unites = 'LITR') THEN unite_qte = 7;
  else if (unites = 'KG') THEN unite_qte = 84;
  

insert into T_FICHEANALYSE(
   fiche_analyse_id
  ,no_analyse
  ,cnk_produit
  ,no_autorisation
  ,ReferenceAnalytique
  ,date_entree
  ,fabricant_id
  ,grossiste_id
  ,no_lot
  ,prix_achat
  ,no_bon_livraison
  ,date_peremption
  ,date_ouverture
  ,etat
  ,quantite_initial
  ,unite_qte
  ,cnk_lie
  ,datemaj
)
values(
   :no_analyse
  ,:no_analyse
  ,:cnk_produit
  ,:no_autorisation
  ,:ReferenceAnalytique
  ,coalesce(:date_entree, current_date)
  ,:fabricant_id
  ,:grossiste_id
  ,:no_lot
  ,iif(:quantite_initial=0,:prix_achat_total,:prix_achat_total/:quantite_initial)
  ,:no_bon_livraison
  ,:date_peremption
  ,:date_entree
  ,1 --,iif(:date_ferme is not null or :quantite_initial=0,2,iif(:date_ouvre is not null,1,0))
  ,:quantite_initial
  ,:unite_qte
  ,:cnk_lien
  ,current_date
);
end;

create or alter procedure ps_farmadtwin_creer_langue(
  langue dm_char2
)
as
begin
  delete from t_farmad_langue;
  insert into t_farmad_langue (langue) VALUES (:langue);
end;







/************************* RAJOUTER LES SORTE D'AGENDA PATIENT   *********************************/