set sql dialect 3;

/* ********************************************************************************************** */
create index idx_prat_vslt_recherche on t_praticien(nom, prenom);
create index idx_org_vslt_recherche on t_organisme(nom);
create index idx_cli_vslt_recherche on t_client(nom, prenom, repris);
create index idx_cli_vslt_famille on t_client(numero_insee);

create index idx_fd_vslt_raison_sociale on t_fournisseur_direct(raison_sociale);
create index idx_rep_vslt_raison_sociale on t_repartiteur(raison_sociale);

create index idx_prd_vslt_recherche on t_produit(code_cip, code_cip7, designation);

/* ********************************************************************************************** */
recreate view v_vslt_praticien(  
  t_praticien_id,
  type_praticien,
  libelle_type_praticien,
  nom,
  prenom,
  no_finess,
  specialite,
  agree_ratp,
  rue_1,
  rue_2,
  code_postal,
  nom_ville,
  code_postal_ville,
  tel_standard,
  tel_personnel,
  tel_mobile,
  fax,
  commentaire,
  t_hopital_id,
  nom_hopital,
  rpps,
  email)
as
select pra.t_praticien_id,
       iif( cnv.numero_finess is null ,'1','2' ),
       iif( cnv.numero_finess is null ,'Privé','Hospitalier' ),
       pra.nom,
       pra.prenom,
       iif( cnv.numero_finess is null , pra.no_finess,cnv.numero_finess),
       sp.libelle,
       pra.agree_ratp,
       iif( cnv.numero_finess is null ,pra.rue_1, cnv.rue_1),
       iif( cnv.numero_finess is null ,pra.rue_2, cnv.rue_2),
       iif( cnv.numero_finess is null ,pra.code_postal,cnv.code_postal),
       iif( cnv.numero_finess is null ,pra.nom_ville, cnv.nom_ville),
       iif( cnv.numero_finess is null ,coalesce(pra.code_postal,'')||' '||coalesce(pra.nom_ville,''),coalesce(cnv.code_postal,'')||' '||coalesce(cnv.nom_ville,'')),
       iif( cnv.numero_finess is null ,pra.tel_standard,cnv.tel_standard),
       iif( cnv.numero_finess is null ,pra.tel_personnel,cnv.tel_personnel),
       iif( cnv.numero_finess is null , pra.tel_mobile,cnv.tel_mobile),
       iif( cnv.numero_finess is null ,pra.fax,cnv.fax),
       pra.commentaire,
       cnv.t_cnv_hopital_id,
       cnv.nom,
	   pra.num_rpps,
       pra.email
from t_praticien pra
     left join t_cnv_hopital cnv on  pra.no_finess = cnv.numero_finess 
     inner join t_ref_specialite sp on (sp.t_ref_specialite_id = pra.t_ref_specialite_id)
     left join t_hopital hop on (hop.t_hopital_id = pra.t_hopital_id)
order by pra.nom, pra.prenom;

/* ********************************************************************************************** */
recreate view v_vslt_praticien_hospitalier(
  t_hopital_id,
  nom,
  prenom,
  specialite)
as
select t_cnv_hopital_id,
       pra.nom,
       pra.prenom,
       sp.libelle
from t_praticien pra
     left join t_cnv_hopital cnv on  pra.no_finess = cnv.numero_finess 
     inner join t_ref_specialite sp on (sp.t_ref_specialite_id = pra.t_ref_specialite_id)
order by pra.nom, pra.prenom;

/* ********************************************************************************************** */
recreate view v_vslt_organisme(
  t_organisme_id,
  type_organisme,
  libelle_type_organisme,
  nom,
  nom_reduit,
  regime,
  caisse_gestionnaire,
  centre_gestionnaire,
  identifiant_national,
  nom_destinataire,
  rue_1,
  rue_2,
  code_postal_ville,
  code_postal,
  nom_ville,
  tel_personnel,
  tel_standard,
  tel_mobile,
  fax,
  org_conventionne,
  org_circonscription,
  org_reference,
  top_r,
  accord_tiers_payant,
  mt_seuil_tiers_payant,
  application_mt_mini_pc,
  doc_facturation,
  mt_seuil_ed_releve,
  edition_releve,
  type_releve,
  frequence_releve,
  commentaire,
  commentaire_bloquant,
  prise_en_charge_ame,
  type_contrat,
  fin_droits_org_amc,
  org_sante_pharma,
  saisie_no_adherent)
as
select org.t_organisme_id,
       org.type_organisme,
       iif(org.type_organisme = '1', 'AMO', 'AMC'),
       org.nom,
       org.nom_reduit,
       reg.code,
       org.caisse_gestionnaire,
       org.centre_gestionnaire,
       iif (org.type_organisme = '1', coalesce(reg.code, '') || coalesce(org.caisse_gestionnaire, '') || coalesce(org.centre_gestionnaire, ''), org.identifiant_national),
       dest.nom destinataire,
       org.rue_1,
       org.rue_2,
       case
         when ((org.code_postal is null) or (org.code_postal = '')) then org.nom_ville
         else org.code_postal || ' ' || org.nom_ville
       end,
       org.code_postal,
       org.nom_ville,
       org.tel_personnel,
       org.tel_standard,
       org.tel_mobile,
       org.fax,
       org.org_conventionne,
       org.org_circonscription,
       org.org_reference,
       org.top_r,
       org.accord_tiers_payant,
       org.mt_seuil_tiers_payant,
       org.application_mt_mini_pc,
       org.doc_facturation,
       org.mt_seuil_ed_releve,
       org.edition_releve,
       org.type_releve,
       org.frequence_releve,
       org.commentaire,
       org.commentaire_bloquant,
       org.prise_en_charge_ame,
       org.type_contrat,
       org.fin_droits_org_amc,
       org.org_sante_pharma,
       org.saisie_no_adherent
from t_organisme org
     left join t_ref_regime reg on (reg.t_ref_regime_id = org.t_ref_regime_id)
     left join t_destinataire dest on (dest.t_destinataire_id = org.t_destinataire_id);

/* ********************************************************************************************** */
recreate view v_vslt_organisme_amo_ass_amc(
  t_organisme_amc_id,
  t_organisme_amo_id,
  nom_organisme_amo,
  top_mutualiste,
  type_contrat,
  regime,
  caisse_gestionnaire,
  centre_gestionnaire,
  t_destinataire_id,
  nom_destinataire,
  type_debiteur)
as
select amoamc.t_organisme_amc_id,
       amoamc.t_organisme_amo_id,
       orgamo.nom,
       amoamc.top_mutualiste,
       amoamc.type_contrat,
       reg.code,
       orgamo.caisse_gestionnaire,
       orgamo.centre_gestionnaire,
       orgamo.t_destinataire_id,
       dest.nom destinataire,
       case
         when amoamc.type_debiteur = '0' then 'AMO AMC'
         when amoamc.type_debiteur = '1' then 'AMO'         
         when amoamc.type_debiteur = '2' then 'AMC'
       end
from t_organisme_amo_ass_amc amoamc
     inner join t_organisme orgamo on (orgamo.t_organisme_id = amoamc.t_organisme_amo_id)
     left join t_destinataire dest on (dest.t_destinataire_id = orgamo.t_destinataire_id)
     left join t_ref_regime reg on (reg.t_ref_regime_id = orgamo.t_ref_regime_id);
     
/* ********************************************************************************************** */

create or alter procedure v_vslt_client(  
ANom dm_varchar30 ,
APrenom dm_varchar20 
)
returns (
    t_client_id dm_code,
    nom dm_varchar30,
    prenom dm_varchar20,
    nom_jeune_fille dm_varchar30,
    numero_insee dm_varchar15,
    date_naissance dm_date_naissance,
    commentaire_global dm_commentaire_long,
    commentaire_global_bloquant dm_boolean,
    commentaire_individuel dm_commentaire_long,
    commentaire_individuel_bloquant dm_boolean,
    qualite dm_varchar2,
    type_qualite varchar(50),
    libelle_qualite varchar(50),
    rang_gemellaire dm_numeric1,
    nat_piece_justif_droit varchar(60),
    date_validite_piece_justif dm_date,
    t_organisme_amo_id dm_code,
    nom_organisme_amo dm_libelle,
    nom_reduit_organisme_amo dm_varchar20,
    sans_centre_gestionnaire dm_boolean,
    identifiant_national_org_amo varchar(6),
    centre_gestionnaire varchar(4),
    t_organisme_amc_id dm_code,
    nom_organisme_amc dm_libelle,
    nom_reduit_organisme_amc dm_varchar20,
    identifiant_national_org_amc dm_varchar9,
    numero_adherent_mutuelle dm_numero_adherent,
    contrat_sante_pharma dm_contrat_sante_pharma,
    mutuelle_lue_sur_carte dm_boolean,
    date_derniere_visite dm_date,
    assure_rattache dm_code,
    nom_assure dm_varchar30,
    prenom_assure dm_varchar20,
    rue_1 dm_rue,
    rue_2 dm_rue,
    code_postal dm_code_postal,
    nom_ville dm_nom_ville,
    code_postal_ville varchar(50),
    tel_personnel dm_telephone,
    tel_standard dm_telephone,
    tel_mobile dm_telephone,
    fax dm_telephone,
    email dm_varchar50,
    activite dm_varchar50,
    delai_paiement numeric(4,0),
    fin_de_mois dm_boolean,
    payeur varchar(12),
    profil_remise dm_code,
    profil_edition dm_code,
    releve_de_facture integer,
    collectif varchar(11),
    document varchar(200))
as
declare variable commentaire dm_commentaire_long;
begin
        for select cli.t_client_id,
               cli.nom,
               cli.prenom,
               cli.nom_jeune_fille,
               cli.numero_insee,
               cli.date_naissance,
               cli.commentaire_global_bloquant,
               cli.commentaire_individuel_bloquant,
               cli.qualite,
               cli.rang_gemellaire,
               cli.nat_piece_justif_droit,
               cli.date_validite_piece_justif,
               cli.t_organisme_amo_id,
               orgamo.nom,
               orgamo.nom_reduit,
               coalesce(reg.sans_centre_gestionnaire,'0'),
               reg.code || ' ' || orgamo.caisse_gestionnaire,
               iif(reg.sans_centre_gestionnaire = '0', orgamo.centre_gestionnaire, cli.centre_gestionnaire),
               cli.t_organisme_amc_id,
               orgamc.nom,
               orgamc.nom_reduit,
               orgamc.identifiant_national,
               cli.numero_adherent_mutuelle,
               cli.contrat_sante_pharma,
               cli.mutuelle_lue_sur_carte,
               cli.date_derniere_visite,
               assrat.prenom || ' ' || assrat.nom,
               ass.nom,
               ass.prenom,
               cli.rue_1,
               cli.rue_2,
               cli.code_postal,
               cli.nom_ville,
               coalesce(cli.code_postal,'') || ' ' || coalesce(cli.nom_ville,''),
               cli.tel_personnel,
               cli.tel_standard,
               cli.tel_mobile,
               cli.fax,
               cli.email,
               cli.activite,
               doc.document
        from t_client cli
             left join t_organisme orgamo on (orgamo.t_organisme_id = cli.t_organisme_amo_id)
             left join t_ref_regime reg on (reg.t_ref_regime_id = orgamo.t_ref_regime_id)
             left join t_organisme orgamc on (orgamc.t_organisme_id = cli.t_organisme_amc_id)
             left join t_client ass on (ass.numero_insee = cli.numero_insee and ass.qualite = '0' and cli.numero_insee is not null and cli.numero_insee <> '')
             left join t_client assrat on (assrat.t_client_id = cli.t_assure_rattache_id)
             left join t_document doc on (doc.t_entite_id = cli.t_client_id)

        where cli.repris = '1'
    and cli.nom starting with :Anom 
    and cli.prenom starting with :Aprenom
    order by cli.nom , cli.prenom
        into
            t_client_id ,
            nom ,
            prenom ,
            nom_jeune_fille ,
            numero_insee ,
            date_naissance ,
            commentaire_global_bloquant ,
            commentaire_individuel_bloquant ,
            qualite ,
            rang_gemellaire ,
            nat_piece_justif_droit,
            date_validite_piece_justif ,
            t_organisme_amo_id ,
            nom_organisme_amo ,
            nom_reduit_organisme_amo ,
            sans_centre_gestionnaire ,
            identifiant_national_org_amo,
            centre_gestionnaire ,
            t_organisme_amc_id ,
            nom_organisme_amc ,
            nom_reduit_organisme_amc ,
            identifiant_national_org_amc ,
            numero_adherent_mutuelle ,
            contrat_sante_pharma ,
            mutuelle_lue_sur_carte ,
            date_derniere_visite ,
            assure_rattache ,
            nom_assure ,
            prenom_assure ,
            rue_1 ,
            rue_2 ,
            code_postal ,
            nom_ville ,
            code_postal_ville, 
            tel_personnel ,
            tel_standard ,
            tel_mobile ,
            fax ,
            email,
            activite,
            document
            do
            begin

             if (qualite = '0') then
                type_qualite = 'Assuré';
             else
                type_qualite = 'Ayant-droit';

             if ( qualite = '0' ) then libelle_qualite = 'Assuré' ;
             if ( qualite = '1' ) then libelle_qualite = 'Ascendant,descendant, collatéraux ascendants';
             if ( qualite = '2' ) then libelle_qualite = 'Conjoint';
             if ( qualite = '3' ) then libelle_qualite = 'Conjoint divorcé';
             if ( qualite = '4' ) then libelle_qualite = 'Concubin';
             if ( qualite = '5' ) then libelle_qualite = 'Conjoint séparé';
             if ( qualite = '6' ) then libelle_qualite = 'Enfant';
             if ( qualite = '7' ) then libelle_qualite = 'Bénéficiaire hors article 313';
             if ( qualite = '8' ) then libelle_qualite = 'Conjoint veuf';
             if ( qualite = '9' ) then libelle_qualite = 'Autre ayant-droit';

             if ( nat_piece_justif_droit = ' ') then nat_piece_justif_droit = 'Aucune pièce justificative';
             if ( nat_piece_justif_droit = '1') then nat_piece_justif_droit = 'Bulletin salaire, attestation droits, prise en charge';
             if ( nat_piece_justif_droit = '2') then nat_piece_justif_droit = 'Attestation carte assuré, consultation télématique';
             if ( nat_piece_justif_droit = '4') then nat_piece_justif_droit = 'Carte vitale';

             commentaire_global= '';     
             commentaire_individuel= '';  

             for select substring(commentaire from 1 for 50)||' (...)'|| ascii_char(13) || ascii_char(10)
                 from t_commentaire 
                 where type_entite =0 and est_global = 1 and t_entite_id = :t_client_id
                 into commentaire  
                 do 
                 begin
                  commentaire_global = substring( commentaire_global || commentaire from 1 for 2000);
                 end 
             
             for select substring(commentaire from 1 for 50)||' (...)'|| ascii_char(13) || ascii_char(10)
                 from t_commentaire 
                 where type_entite =0 and est_global = 0 and t_entite_id = :t_client_id
                 into commentaire  
                 do 
                 begin
                  commentaire_individuel = substring( commentaire_individuel || commentaire from 1 for 2000);
                 end 
        
              if (trim(commentaire_global) = '') then commentaire_global= 'Pas de commentaire global';     
             
              if (trim(commentaire_individuel) = '') then commentaire_individuel= 'Pas de commentaire individuel';     

             suspend;
            end



    for select 
         cpt.t_compte_id,
         cpt.nom,
         '' ,
         null ,
         null,
         null,
         null,
         0 ,
         null ,
         0 ,  
         '' ,    
         'Compte' as qualite,
         'Compte' ,
         null ,
         null ,
         null,
         null ,
         null ,
         null,
         0 ,
         null ,
         null ,
         null ,
         null, 
         null ,
         null ,
         null,
         null ,
         0 ,
         null ,
         cpt.t_client_id,
         null as assure_nom,
         null as assure_prenom,
         cpt.rue_1,
         cpt.rue_2,
         cpt.code_postal,
         cpt.nom_ville,
         coalesce(cpt.code_postal,'') || ' ' || coalesce(cpt.nom_ville,''),
         cpt.tel_personnel,
         cpt.tel_standard,
         cpt.tel_mobile,
         cpt.fax,
         cpt.activite,
         cpt.delai_paiement,
         cpt.fin_de_mois,
         iif(cpt.payeur='A','Adhérent','Collectivité'),
         pre.libelle,
         ped.libelle,
         1,
         cpt.collectif
from t_compte cpt
left join t_profil_remise pre on pre.t_profil_remise_id = cpt.t_profil_remise_id 
left join t_profil_edition ped on ped.t_profil_edition_id = cpt.t_profil_edition_id 
where cpt.repris = '1' 
and cpt.nom starting  with :Anom
order by cpt.nom
    into
      t_client_id ,
      nom ,
      prenom,
      nom_jeune_fille,
      numero_insee,
      date_naissance,
      commentaire_global,
      commentaire_global_bloquant,
      commentaire_individuel,
      commentaire_individuel_bloquant,  
      qualite,
      type_qualite ,
      libelle_qualite ,
      rang_gemellaire,
      nat_piece_justif_droit,
      date_validite_piece_justif,
      t_organisme_amo_id,
      nom_organisme_amo ,
      nom_reduit_organisme_amo ,
      sans_centre_gestionnaire ,
      identifiant_national_org_amo,
      centre_gestionnaire ,
      t_organisme_amc_id ,
      nom_organisme_amc ,
      nom_reduit_organisme_amc ,
      identifiant_national_org_amc ,
      numero_adherent_mutuelle,
      contrat_sante_pharma,
      mutuelle_lue_sur_carte,
      date_derniere_visite,
      assure_rattache,
      nom_assure,
      prenom_assure,
      rue_1 ,
      rue_2 ,
      code_postal ,
      nom_ville ,
      code_postal_ville,
      tel_personnel ,
      tel_standard ,
      tel_mobile ,
      fax ,
      activite ,
      delai_paiement ,
      fin_de_mois ,
      payeur ,
      profil_remise ,
      profil_edition ,
      releve_de_facture ,
      collectif 
      do
        suspend;
    
      

end;

/* ********************************************************************************************** */

recreate view v_vslt_collectivite as
select 
ccl.t_client_id,
cpt.nom
from T_COMPTE_CLIENT ccl
left join t_compte cpt  on cpt.t_compte_id = ccl.t_compte_id;


/* ********************************************************************************************** */
recreate view v_vslt_adherent as
select 
ccl.t_compte_id,
cli.nom, 
cli.prenom,
cli.date_naissance,
       case
         when cli.qualite = '0' then 'Assuré'
         when cli.qualite = '1' then 'Ascendant,descendant, collatéraux ascendants'
         when cli.qualite = '2' then 'Conjoint'
         when cli.qualite = '3' then 'Conjoint divorcé'
         when cli.qualite = '4' then 'Concubin'
         when cli.qualite = '5' then 'Conjoint séparé'
         when cli.qualite = '6' then 'Enfant'
         when cli.qualite = '7' then 'Bénéficiaire hors article 313'
         when cli.qualite = '8' then 'Conjoint veuf'
         when cli.qualite = '9' then 'Autre ayant-droit'
       end  as qualite
from T_COMPTE_CLIENT ccl
left join t_client cli  on cli.t_client_id = ccl.t_client_id;


/* ********************************************************************************************** */
recreate view v_vslt_prog_avantage_client
as
select 
cli.t_client_id,
pa.libelle,
pac.encours_initial,
pac.encours_ca,
pac.date_fin_validite
from t_client cli
inner join t_programme_avantage_client pac on ( pac.t_client_id = cli.t_client_id )
inner join t_programme_avantage pa on ( pa.t_programme_avantage_id = pac.t_programme_avantage_id);


/* ********************************************************************************************** */

recreate view v_vslt_prog_avantage(
    type_carte,
    code_externe,
    libelle,
    date_fin_validite,
    type_objectif,
    valeur_objectif,
    valeur_point,
    type_avantage,
    mode_calcul_avantage,
    valeur_avantage)
AS
select
type_carte,
code_externe,
libelle,
date_fin_validite,
case
         when type_objectif = '1' then '1 - Chiffre d affaire'
         when type_objectif = '2' then '2 - Nombre de Boites'
         when type_objectif = '3' then '3 - Nombre de Visites'
         when type_objectif = '4' then '4 - Nombre de points'

end,
case
         when type_objectif = '1' then valeur_objectif||' euros'
         when type_objectif = '2' then valeur_objectif||' boites'
         when type_objectif = '3' then valeur_objectif||' visites'
         when type_objectif = '4' then valeur_objectif||' points'

end,

VALEUR_POINT,
case
         when type_avantage = '1' then '1 - Remise sur % CA realise'
         when type_avantage = '2' then '2 - Cheque cadeau'
         when type_avantage = '3' then '3 - Cadeau'
         when type_avantage = '4' then '4 - Produit Offert '

end,
case
         when mode_calcul_avantage = '1' then '1 - % Réalisé sur Produits Fid.'
         when mode_calcul_avantage = '2' then '2 - % Réalisé sur Produits Fid. prochaine vente'
         when mode_calcul_avantage = '3' then '3 - Euros'
         when mode_calcul_avantage = '4' then '4 - Euro/Point'
end,
valeur_avantage
from t_programme_avantage;


/* ********************************************************************************************** */
create view v_vslt_prog_avantage_produit(
    code_cip,
    designation,
    libelle)
AS
select
prd.code_cip,
prd.designation,
pa.libelle
from
t_programme_avantage_produit pap
left join t_produit prd on prd.t_produit_id = pap.t_produit_id
left join t_programme_avantage pa on pa.t_programme_avantage_id = pap.t_programme_avantage_id;


/* ********************************************************************************************** */
create view v_vslt_famille_client(
  t_client_id,
  nom,
  prenom,
  numero_insee,
  qualite,
  libelle_qualite,
  date_naissance,
  rang_gemellaire,
  nom_organisme_amc)
as
select cli.t_client_id,
       cli.nom,
       cli.prenom,
       cli.numero_insee,
       cli.qualite,
       case
         when cli.qualite = '0' then 'Assuré'
         when cli.qualite = '1' then 'Ascendant,descendant, collatéraux ascendants'
         when cli.qualite = '2' then 'Conjoint'
         when cli.qualite = '3' then 'Conjoint divorcé'
         when cli.qualite = '4' then 'Concubin'
         when cli.qualite = '5' then 'Conjoint séparé'
         when cli.qualite = '6' then 'Enfant'
         when cli.qualite = '7' then 'Bénéficiaire hors article 313'
         when cli.qualite = '8' then 'Conjoint veuf'
         when cli.qualite = '9' then 'Autre ayant-droit'
       end,
       cli.date_naissance,
       cli.rang_gemellaire,
       orgamc.nom
from t_client cli
     left join t_organisme orgamc on (orgamc.t_organisme_id = cli.t_organisme_amc_id)
where (cli.numero_insee is not null and cli.numero_insee <> '');

/* ********************************************************************************************** */
create or alter procedure ps_vslt_creer_vue_couvertures 
as
declare variable lstrsql varchar(3000);
declare variable lintprestationid integer;
declare variable lstrprestation varchar(3);
begin
  -- Couvertures organisme AMO
  lStrSQL = 'recreate view v_vslt_couverture_amo("N° d''organisme",
                                                 "Libéllé",
                                                 "Code SV",
                                                 "Nat. ass.",
                                                 "Exo."';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation;

  lStrSQL = lStrSQL || ') as
                        select couvamo.t_organisme_amo_id,
                               couvamo.libelle,
                               r_couvamo.code_couverture,
                               couvamo.nature_assurance,
                               couvamo.justificatif_exo';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', coalesce(r_' || lStrPrestation || '.taux, ' || lStrPrestation || '.taux) ';

  lStrSQL = lStrSQL || ' from t_couverture_amo couvamo
                             left join t_ref_couverture_amo r_couvamo on (r_couvamo.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id) ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'left join t_taux_prise_en_charge ' || lStrPrestation || ' on (' || lStrPrestation || '.t_couverture_amo_id = couvamo.t_couverture_amo_id and ' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';
    
  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'left join t_ref_taux_prise_en_charge r_' || lStrPrestation || ' on (r_' || lStrPrestation || '.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id and r_' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';

  execute statement lStrSQL;

  -- Couvertures organisme AMC
  lStrSQL = 'recreate view v_vslt_couverture_amc_conv("N° d''organisme",
                                                      "Libéllé"';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation;

  lStrSQL = lStrSQL || ') as
                        select couvamc.t_organisme_amc_id,
                               couvamc.libelle';
                               
  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation || '.taux';

  lStrSQL = lStrSQL || ' from t_cnv_couverture_amc ccouvamc 
                              inner join t_couverture_amc couvamc on (couvamc.t_couverture_amc_id = ccouvamc.t_couverture_amc_id) ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'inner join t_cnv_taux_prise_en_charge ' || lStrPrestation || ' on (' || lStrPrestation || '.t_couverture_amc_id = ccouvamc.t_cnv_couverture_amc_id and ' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';
  
  execute statement lStrSQL;

  lStrSQL = 'recreate view v_vslt_couverture_amc_non_conv("N° d''organisme",
                                                          "Libéllé"';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation;

  lStrSQL = lStrSQL || ') as
                        select couvamc.t_organisme_amc_id,
                               couvamc.libelle';
                               
  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation || '.taux';

  lStrSQL = lStrSQL || ' from t_couverture_amc couvamc ';                             

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'inner join t_taux_prise_en_charge ' || lStrPrestation || ' on (' || lStrPrestation || '.t_couverture_amc_id = couvamc.t_couverture_amc_id and ' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';
  
  execute statement lStrSQL;

  -- Couverture AMO Client
  lStrSQL = 'recreate view v_vslt_couverture_amo_client("N° de dossier",
                                                        "Libellé",
                                                        "Code SV" ';
  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation;

  lStrSQL = lStrSQL || ', "Début droit"
                        , "Fin droit") as
                        select couvcli.t_client_id,
                               cast(substring(couvamo.libelle from 1 for 20) as varchar(20)),
                               cast(r_couvamo.code_couverture as varchar(10))';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', coalesce(r_' || lStrPrestation || '.taux, ' || lStrPrestation || '.taux)';

  lStrSQL = lStrSQL || ', couvcli.debut_droit_amo
                        , couvcli.fin_droit_amo
                        from t_couverture_amo_client couvcli
                             inner join t_couverture_amo couvamo on (couvamo.t_couverture_amo_id = couvcli.t_couverture_amo_id)
                             left join t_ref_couverture_amo r_couvamo on (r_couvamo.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id) ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'left join t_taux_prise_en_charge ' || lStrPrestation || ' on (' || lStrPrestation || '.t_couverture_amo_id = couvamo.t_couverture_amo_id and ' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';

  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lIntPrestationID,
           :lStrPrestation do
    lStrSQL = lStrSQL || 'left join t_ref_taux_prise_en_charge r_' || lStrPrestation || ' on (r_' || lStrPrestation || '.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id and r_' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';

  execute statement lStrSQL;

  -- Couverture AMC Client
  lStrSQL = 'recreate view v_vslt_couverture_amc_client("N° de dossier",
                                                        "Libellé" ';
  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', ' || lStrPrestation;

  lStrSQL = lStrSQL || ', "Début droit"
                        , "Fin droit") as
                        select cli.t_client_id,
                             couvamc.formule ||  cast(substring(couvamc.libelle from 1 for 30) as varchar(30)) ';

  for select code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      order by priorite
      into :lStrPrestation do
    lStrSQL = lStrSQL || ', coalesce(c_' || lStrPrestation || '.taux, ' || lStrPrestation || '.taux)';

  lStrSQL = lStrSQL || ', cli.debut_droit_amc
                        , cli.fin_droit_amc
                        from t_client cli
                             inner join t_couverture_amc couvamc on (couvamc.t_couverture_amc_id = cli.t_couverture_amc_id) 
                     							 left join t_cnv_couverture_amc ccouvamc on (ccouvamc.t_cnv_couverture_amc_id = cli.t_cnv_couverture_amc_id) ';							 
  for select rp.t_ref_prestation_id,
             rp.code
      from t_ref_prestation rp
           inner join t_cfg_prestation cp on (cp.t_ref_prestation_id = rp.t_ref_prestation_id)
      where utilisable_conversion = '1'
      into :lintPrestationid,
           :lStrPrestation do
  begin
    lStrSQL = lStrSQL || 'inner join t_taux_prise_en_charge ' || lStrPrestation || ' on (' || lStrPrestation || '.t_couverture_amc_id = couvamc.t_couverture_amc_id and ' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';
    lStrSQL = lStrSQL || 'left join t_cnv_taux_prise_en_charge c_' || lStrPrestation || ' on (c_' || lStrPrestation || '.t_couverture_amc_id = ccouvamc.t_cnv_couverture_amc_id and c_' || lStrPrestation || '.t_ref_prestation_id = ' || lIntPrestationID || ') ';
  end
  
  execute statement lStrSQL;
end;

/* ********************************************************************************************** */
recreate view v_vslt_fournisseur as
select '1' as type_fournisseur,
       'Fournisseur direct' as  type_fournisseur_libelle,
       fou.t_fournisseur_direct_id as t_fournisseur_id ,
       fou.raison_sociale as raison_sociale,
       fou.identifiant_171 as identifiant_171,
       fou.numero_appel as numero_appel,
       fou.commentaire as commentaire,
       fou.vitesse_171 as vitesse_171,
       case
         when fou.mode_transmission = '1' then 'N171 Appel'
         when fou.mode_transmission = '2' then 'N171 Porteuse'
         when fou.mode_transmission = '3' then 'Fax'
         when fou.mode_transmission = '4' then 'E-Mail'
         when fou.mode_transmission = '5' then 'Manuel'
       end as mode_transmission,
       fou.rue_1 as rue_1,
       fou.rue_2 as rue_2,
       fou.code_postal as code_postal,
       fou.nom_ville as nom_ville,
       case
         when ((fou.code_postal is null) or (fou.code_postal = '')) then fou.nom_ville
         else fou.code_postal || ' ' || fou.nom_ville
       end as code_postal_ville,
       coalesce(fou.tel_personnel,       fou.tel_standard) as telephone,
       fou.tel_personnel,
       fou.tel_standard,
       fou.tel_mobile as tel_mobile,
      fou.fax as fax,
   fou.represente_par as represente_par ,
       fou.code_partenaire as code_partenaire,
       null as objectif_ca_mensuel, 
       fou.fournisseur_partenaire as defaut,
       fou.numero_fax  as numero_fax,
       fou.id_pharmacie as id_pharmacie,
      null as pharmaml_ref_id,
      null as pharmaml_url_1,   
null as pharmaml_url_2,      
       null as pharmaml_id_officine,
      null as pharmaml_id_magasin,
      null as pharmaml_cle

from t_fournisseur_direct fou
union
select '2' as type_fournisseur,  
       'Répartiteur' as type_fournisseur_libelle,
       rep.t_repartiteur_id as t_fournisseur_id ,
       rep.raison_sociale as raison_sociale ,
       rep.identifiant_171 as identifiant_171,
       rep.numero_appel as numero_appel,
       rep.commentaire as commentaire,
       rep.vitesse_171 as vitesse_171,
       case
         when rep.mode_transmission = '1' then 'N171 Appel'
         when rep.mode_transmission = '2' then 'N171 Porteuse'
         when rep.mode_transmission = '3' then 'Fax'
         when rep.mode_transmission = '4' then 'E-Mail'
         when rep.mode_transmission = '5' then 'Manuel'
       end as mode_transmission,
       rep.rue_1 as rue_1,
       rep.rue_2 as rue_2,
       rep.code_postal as code_postal,
       rep.nom_ville as nom_ville,
       case
         when ((rep.code_postal is null) or (rep.code_postal = '')) then rep.nom_ville
         else rep.code_postal || ' ' || rep.nom_ville
       end as code_postal_ville,
       coalesce(rep.tel_personnel,       rep.tel_standard) as telephone,

       rep.tel_personnel as tel_personnel,
       rep.tel_standard as tel_standard,
       rep.tel_mobile as tel_mobile,
       rep.fax as fax,
       null as represente_par,
       null as code_partenaire,
       rep.objectif_ca_mensuel as objectif_ca_mensuel,
       rep.defaut as defaut,
       rep.numero_fax as numero_fax,
       rep.id_pharmacie  as id_pharmacie,
       rep.pharmaml_ref_id as pharmaml_ref_id,
       rep.pharmaml_url_1 as pharmaml_url_1,   
      rep.pharmaml_url_2 as pharmaml_url_2,    
       rep.pharmaml_id_officine as pharmaml_id_officine,
       rep.pharmaml_id_magasin as pharmaml_id_magasin,
       rep.pharmaml_cle as pharmaml_cle

from t_repartiteur rep;


/* ********************************************************************************************** */
create procedure ps_vslt_renvoyer_libelles_cdfs
returns(
  ALibelleCdf1 varchar(50),
  ALibelleCdf2 varchar(50),
  ALibelleCdf3 varchar(50),
  ALibelleCdf4 varchar(50),
  ALibelleCdf5 varchar(50))
as
begin
  select valeur
  from t_parametre
  where upper(cle) = 'PROD.LIBELCODIF1'
  into :ALibelleCdf1;

  select valeur
  from t_parametre
  where upper(cle) = 'PROD.LIBELCODIF2'
  into :ALibelleCdf2;

  select valeur
  from t_parametre
  where upper(cle) = 'PROD.LIBELCODIF3'
  into :ALibelleCdf3;

  select valeur
  from t_parametre
  where upper(cle) = 'PROD.LIBELCODIF4'
  into :ALibelleCdf4;

  select valeur
  from t_parametre
  where upper(cle) = 'PROD.LIBELCODIF5'
  into :ALibelleCdf5;
  
  suspend;
end;

/* ********************************************************************************************** */
create view v_vslt_codification(
  t_codification_id,
  rang,
  libelle,
  taux_marque)
as  
select t_codification_id,
       rang,
       libelle,
       taux_marque
from  t_codification
union
select t_zone_geographique_id,
       0,
       libelle,
       null
from t_zone_geographique;
      
/* ********************************************************************************************** */
create view v_vslt_produit(
  t_produit_id,
  code_cip,
  code_cip7,
  designation,
  type_homeo,
  date_derniere_vente,
  taux_tva,
  liste,
  soumis_mdl,
  tarif_achat_unique,
  prix_vente,
  base_remboursement,
  prix_achat_catalogue,
  pamp,
  prestation,
  etat,
  contenance,
  unite_mesure,
  veterinaire,
  delai_lait,
  delai_viande,
  gere_interessement,
  tracabilite,
  gere_suivi_client,
  gere_pfc,
  commentaire_vente,
  commentaire_commande,
  commentaire_gestion,
  profil_gs,
  explication_profil_gs,
  marque,
  repartiteur_attitre,
  nombre_mois_calcul,
  calcul_gs,
  stock_mini,
  stock_maxi,
  conditionnement,
  lot_achat,
  lot_vente,
  unite_moyenne_vente,
  moyenne_vente,
  nombre_produit_du,
  quantite_pha,
  quantite_total,
  zone_geographique_pha,
  produit_kit,
  codification_1,
  codification_2,
  codification_3,
  codification_4,
  codification_5,
  codification_7,
  commandes_en_cours,
  date_peremption)
as
select prd.t_produit_id,
       iif( trim(prd.code_cip) = '',prd.code_cip7,prd.code_cip),
	   prd.code_cip7,
       prd.designation,
       case
         when prd.type_homeo = '0' then 'Hors homéopathie'
         when prd.type_homeo = '1' then 'Homéo. grand prix'
         when prd.type_homeo = '2' then 'Homéo. petit prix'
       end,
       prd.date_derniere_vente,
       tva.taux,
       case
         when prd.liste = '0' then 'Aucune'
         when prd.liste = '1' then 'Liste I'
         when prd.liste = '2' then 'Liste II'
         when prd.liste = '3' then 'Stupéfiants'
       end,
       prd.soumis_mdl,
       prd.tarif_achat_unique,
       prd.prix_vente,
       prd.base_remboursement,
       prd.prix_achat_catalogue,
       prd.pamp,
       pr.code,
       case
         when prd.etat = '1' then 'En vigueur'
         when prd.etat = '2' then 'Ne se fait plus'
         when prd.etat = '3' then 'Fabrication suspendue'
         when prd.etat = '4' then 'Vente interdite'
         when prd.etat = '5' then 'Produit remplacé'
       end,
       prd.contenance,
       case         
         when prd.unite_mesure = '0' then 'Unité'
         when prd.unite_mesure = '1' then 'Kilogramme'
         when prd.unite_mesure = '2' then 'Gramme'
         when prd.unite_mesure = '3' then 'Décigramme'
         when prd.unite_mesure = '4' then 'Centigramme'
         when prd.unite_mesure = '5' then 'Milligramme'
         when prd.unite_mesure = '6' then 'Litres'
         when prd.unite_mesure = '7' then 'Décilitres'
         when prd.unite_mesure = '8' then 'Centilitres'
         when prd.unite_mesure = '9' then 'Millilitres'
       else
         null
       end,
       prd.veterinaire,
       prd.delai_lait,
       prd.delai_viande,
       prd.gere_interessement,
       prd.tracabilite,
       prd.gere_suivi_client,
       prd.gere_pfc,
       prd.commentaire_vente,
       prd.commentaire_commande,
       prd.commentaire_gestion,
       case
         when prd.profil_gs = '0' then 'Profil par défaut'
         when prd.profil_gs = '1' then 'Historique seul'
         when prd.profil_gs = '2' then 'Historique + stock'
         when prd.profil_gs = '3' then 'Historique + stock + commande'
       end,
       iif (prd.profil_gs = '0',  'Historique + stock + commande', ''),
       cdf6.libelle,
       rep.raison_sociale,
       prd.nombre_mois_calcul,
       case
         when prd.calcul_gs = '0' then 'Calcul par défaut'
         when prd.calcul_gs = '1' then 'Automatique'
         when prd.calcul_gs = '4' then 'Fixé'
         when prd.calcul_gs = '5' then 'Commande = quantité vendue'
       end,
       prd.stock_mini,
       prd.stock_maxi,
       prd.conditionnement,
       prd.lot_achat,
       prd.lot_vente,
       prd.unite_moyenne_vente,
       prd.moyenne_vente,
       nb_prd_du.nombre_produit_du,
       stk_pha.quantite,
       stk_tot.quantite_total,
       zg.libelle,
       iif(lpp.nb_codes_lpp > 1, '1', '0'),
       cdf1.libelle,
       cdf2.libelle,
       cdf3.libelle,
       cdf4.libelle,
       cdf5.libelle,
       cdf7.libelle,
       cmd.nb_commandes_en_cours,
       prd.date_peremption
from t_produit prd
     left join t_ref_tva tva on (tva.t_ref_tva_id = prd.t_ref_tva_id)
     inner join t_ref_prestation pr on (pr.t_ref_prestation_id = prd.t_ref_prestation_id)
     left join t_produit_geographique stk_pha on (stk_pha.t_produit_id = prd.t_produit_id)
     left join t_depot d on (d.t_depot_id = stk_pha.t_depot_id)
     left join (select t_produit_id, sum(quantite) quantite_total
                from t_produit_geographique
                group by t_produit_id) stk_tot on (stk_tot.t_produit_id = prd.t_produit_id)
     left join t_zone_geographique zg on (zg.t_zone_geographique_id = stk_pha.t_zone_geographique_id)
     left join t_repartiteur rep on (rep.t_repartiteur_id = prd.t_repartiteur_id)
     left join (select t_produit_id, count(*) nombre_produit_du
                from t_produit_du
                group by t_produit_id) nb_prd_du on (nb_prd_du.t_produit_id = prd.t_produit_id)
     left join (select t_produit_id, count(*) nb_codes_lpp
                from t_produit_lpp
                group by t_produit_id) lpp on (lpp.t_produit_id = prd.t_produit_id)
     left join t_codification cdf1 on (cdf1.t_codification_id = prd.t_codif_1_id)
     left join t_codification cdf2 on (cdf2.t_codification_id = prd.t_codif_2_id)
     left join t_codification cdf3 on (cdf3.t_codification_id = prd.t_codif_3_id)
     left join t_codification cdf4 on (cdf4.t_codification_id = prd.t_codif_4_id)
     left join t_codification cdf5 on (cdf5.t_codification_id = prd.t_codif_5_id)
     left join t_codification cdf6 on (cdf6.t_codification_id = prd.t_codif_6_id)
     left join t_codification cdf7 on (cdf7.t_codification_id = prd.t_codif_7_id)
     left join (select t_produit_id, count(*) nb_commandes_en_cours
                from t_commande_ligne l
                     inner join t_commande c on (c.t_commande_id = l.t_commande_id)
                where c.etat <> '3'
                group by t_produit_id) cmd on (cmd.t_produit_id = prd.t_produit_id)
where prd.repris = '1' ;
   -- and ((d.type_depot = 'SUVE') or (d.type_depot is null)  );

/* ********************************************************************************************** */
create view v_vslt_code_ean13(
  t_produit_id,
  code_ean13)
as
select t_produit_id,
       code_ean13
from t_code_ean13;

/* ********************************************************************************************** */
create view v_vslt_produit_lpp(t_produit_id,
                                type_code,
                                code_lpp,
                                quantite,
                                tarif_unitaire,
                                prestation,
                                service_tips)
as                                
select lpp.t_produit_id,
       lpp.type_code,
       lpp.code_lpp,
       lpp.quantite,
       lpp.tarif_unitaire,
       pr.code,
       case 
         when service_tips = 'A' then 'A - Achat'
         when service_tips = 'E' then 'E - Entretien'
         when service_tips = 'L' then 'L - Livraison'
         when service_tips = 'F' then 'P - Frais de port'
         when service_tips = 'R' then 'R - Réparation'
         when service_tips = 'V' then 'V - Location'
         when service_tips = 'S' then 'S - Service'
       end
from t_produit_lpp lpp
     left join t_ref_prestation pr on (pr.t_ref_prestation_id = lpp.t_ref_prestation_id);

/* ********************************************************************************************** */
create view v_vslt_stock(
  t_produit_id,
  quantite,
  depot,
  stock_mini,
  stock_maxi,
  zone_geographique)
as  
select t_produit_id,
       quantite,
       d.libelle,
       stock_mini,
       stock_maxi,
       zg.libelle
from t_produit_geographique pg
     left join t_zone_geographique zg on (zg.t_zone_geographique_id = pg.t_zone_geographique_id)
     left join t_depot d on d.t_depot_id = pg.t_depot_id ;

/* ********************************************************************************************** */
create view v_vslt_tarif(
  type_tarif,
  t_fournisseur_id,
  raison_sociale,
  t_produit_id,
  code_cip,
  designation,
  prix_achat_catalogue,
  remise_simple,
  prix_achat_remise,
  date_maj_tarif)
as
select '1',
       c.t_fournisseur_id,
       fd.raison_sociale,
       cl.t_produit_id,
       p.code_cip,
       p.designation,
       cl.prix_achat_catalogue,
       cl.remise_simple,
       cl.prix_achat_remise,
       cl.date_maj_tarif
from t_catalogue_ligne cl
     inner join t_catalogue c on (c.t_catalogue_id = cl.t_catalogue_id)               
     inner join t_fournisseur_direct fd on (fd.t_fournisseur_direct_id = c.t_fournisseur_id)
     inner join t_produit p on (p.t_produit_id = cl.t_produit_id)
union 
select '2',
       c.t_repartiteur_id, 
       r.raison_sociale,
       l.t_produit_id,
       p.code_cip,
       p.designation,
       l.prix_achat_tarif,         
       (select Aremise from ps_calculer_remise(l.prix_achat_tarif,l.prix_achat_remise)),
       l.prix_achat_remise,
       coalesce(max(c.date_reception), max(c.date_creation))
from t_commande_ligne l
     inner join t_produit p on (p.t_produit_id = l.t_produit_id)
     inner join t_commande c on (c.t_commande_id = l.t_commande_id)
     inner join t_repartiteur r on (r.t_repartiteur_id = c.t_repartiteur_id)
where l.quantite_totale_recue <> 0
group by c.t_repartiteur_id, 
         r.raison_sociale,
         l.t_produit_id,
         p.code_cip,
         p.designation,
         l.prix_achat_tarif,         
         l.prix_achat_remise;
     
	 
/* ********************************************************************************************** */	 
recreate view v_vslt_catalogue
as
select 
cat.t_fournisseur_id,
fou.raison_sociale,
lig.t_produit_id,
prd.code_cip, 
prd.designation,
lig.prix_achat_catalogue,
lig.remise_simple,
lig.prix_achat_remise


from T_CATALOGUE cat 
left join T_CATALOGUE_LIGNE lig ON cat.t_catalogue_id = lig.t_catalogue_id 
left join T_PRODUIT prd ON lig.t_produit_id = prd.t_produit_id
left join T_FOURNISSEUR_DIRECT fou on fou.t_fournisseur_direct_id =cat.t_fournisseur_id;
	 
/* ********************************************************************************************** */
create or alter procedure ps_vslt_renvoyer_histo_ventes(
  AProduitID varchar(50) character set none default null)
returns(
  AMois integer,
  AAnnee integer,
  AQuantiteActes integer,
  AQuantiteVendues integer)
as
declare variable i integer;
declare variable strDateEnCours varchar(10);
declare variable intAnneEenCours integer;
declare variable intMoisEnCours integer;
declare variable intMois integer;
declare variable intAnnee integer;
declare variable intNbActes integer;
declare variable intNbVendues integer;
begin
  strDateEnCours = cast(current_date as varchar(10));
  intMoisEnCours = cast(substring(strDateEnCours from 6 for 2) as integer);
  intAnneeEnCours = cast(substring(strDateEnCours from 1 for 4) as integer);

  i = 0;
  for select cast(substring(periode from 1 for 2) as integer),
             cast(substring(periode from 3 for 4) as integer),
             quantite_actes,
             quantite_vendues
      from t_historique_vente
      where t_produit_id = :AProduitID
      order by cast(substring(periode from 3 for 4) as integer) desc,
               cast(substring(periode from 1 for 2) as integer) desc
      into :intMois,
           :intAnnee,
           :intNbActes,
           :intNbVendues do
  begin
    while ((intMois <> intMoisEnCours) or (intAnnee <> intAnneeEnCours)) do
    begin
      i = i + 1;

      /* génération de la ligne vide */
      AMois = intMoisEnCours;
      AAnnee = intAnneeEnCours;
      AQuantiteActes = 0;
      AQuantiteVendues = 0;

      /* décrémentation mois/annee */
      if (intMoisEnCours > 1) then
        intMoisEnCours = intMoisEnCours - 1;
      else
      begin
        intMoisEnCours = 12;
        intAnneeEnCours = intAnneeEnCours - 1;
      end

      suspend;
    end

    i = i + 1;

    /* Génération ligne d'histo. */
    AMois = intMois;
    AAnnee = intAnnee;
    AQuantiteActes = intNbActes;
    AQuantiteVendues = intNbVendues;

    /* décrémentation mois/annee */
    if (intMoisEnCours > 1) then
      intMoisEnCours = intMoisEnCours - 1;
    else
    begin
      intMoisEnCours = 12;
      intAnneeEnCours = intAnneeEnCours - 1;
    end

    suspend;
  end

  if (i < 24) then
    while (i < 24) do
    begin
      i = i + 1;

      /* génération de la ligne vide */
      AMois = intMoisEnCours;
      AAnnee = intAnneeEnCours;
      AQuantiteActes = 0;
      AQuantiteVendues = 0;

      /* décrémentation mois/annee */
      if (intMoisEnCours > 1) then
        intMoisEnCours = intMoisEnCours - 1;
      else
      begin
        intMoisEnCours = 12;
        intAnneeEnCours = intAnneeEnCours - 1;
      end

      suspend;
    end
end;

/* ********************************************************************************************** */
create or alter procedure ps_vslt_renvoyer_histo_achats(
  AProduitID varchar(50))
returns(
  AMois integer,
  AAnnee integer,
  AQuantiteRecues integer)
as
declare variable i integer;
declare variable strDateEnCours varchar(10);
declare variable intAnneeEnCours integer;
declare variable intMoisEnCours integer;
declare variable intMois integer;
declare variable intAnnee integer;
declare variable intQteRecues integer;
begin
  strDateEnCours = cast(current_date as varchar(10));
  intMoisEnCours = cast(substring(strDateEnCours from 6 for 2) as integer);
  intAnneeEnCours = cast(substring(strDateEnCours from 1 for 4) as integer);

  i = 0;
  for select mois,
             annee,
             quantite_commandee
      from (select cast(substring(cast(c.date_creation as varchar(10)) from 6 for 2) as integer) mois,
                   cast(substring(cast(c.date_creation as varchar(10)) from 1 for 4) as integer) annee,
                   sum(l.quantite_commandee) quantite_commandee
            from t_commande_ligne l
                 inner join t_commande c on (c.t_commande_id = l.t_commande_id)
            where l.t_produit_id = :AProduitID
            group by substring(cast(c.date_creation as varchar(10)) from 6 for 2),
                     substring(cast(c.date_creation as varchar(10)) from 1 for 4))
      order by annee desc, mois desc
      into :intMois,
           :intAnnee,
           :intQteRecues do
  begin
    while ((intMois <> intMoisEnCours) or (intAnnee <> intAnneeEnCours)) do
    begin
      i = i + 1;

      /* génération de la ligne vide */
      AMois = intMoisEnCours;
      AAnnee = intAnneeEnCours;
      AQuantiteRecues = 0;

      /* décrémentation mois/annee */
      if (intMoisEnCours > 1) then
        intMoisEnCours = intMoisEnCours - 1;
      else
      begin
        intMoisEnCours = 12;
        intAnneeEnCours = intAnneeEnCours - 1;
      end

      suspend;
    end

    i = i + 1;
      
    /* Génération ligne d'histo. */
    AMois = intMois;
    AAnnee = intAnnee;
    AQuantiteRecues = intQteRecues;
    
    /* décrémentation mois/annee */
    if (intMoisEnCours > 1) then
      intMoisEnCours = intMoisEnCours - 1;
    else
    begin
      intMoisEnCours = 12;
      intAnneeEnCours = intAnneeEnCours - 1;
    end
    
    suspend;
  end
  
  if (i < 24) then
    while (i < 24) do
    begin
      i = i + 1;

      /* génération de la ligne vide */
      AMois = intMoisEnCours;
      AAnnee = intAnneeEnCours;
      AQuantiteRecues = 0;

      /* décrémentation mois/annee */
      if (intMoisEnCours > 1) then
        intMoisEnCours = intMoisEnCours - 1;
      else
      begin
        intMoisEnCours = 12;
        intAnneeEnCours = intAnneeEnCours - 1;
      end

      suspend;
    end
end;

/* ********************************************************************************************** */
create view v_vslt_commandes_en_cours(
  t_commande_id,
  raison_sociale,
  mode_transmission,
  montant_ht,
  t_produit_id,
  code_cip,
  designation,
  quantite_commandee,
  quantite_totale_recue,
  prix_achat_tarif,
  prix_achat_remise,
  prix_vente,
  date_creation)
as
select
  c.t_commande_id, 
  coalesce(f.raison_sociale, r.raison_sociale),
  case
    when c.mode_transmission = '1' then 'N171 Appel'
    when c.mode_transmission = '2' then 'N171 Porteuse'
    when c.mode_transmission = '3' then 'Fax'
    when c.mode_transmission = '4' then 'E-Mail'
    when c.mode_transmission = '5' then 'Manuel'
  end,
  c.montant_ht,
  l.t_produit_id,
  p.code_cip,
  p.designation,
  l.quantite_commandee,
  l.quantite_totale_recue,
  l.prix_achat_tarif,
  l.prix_achat_remise,
  l.prix_vente,
  c.date_creation
from
  t_commande_ligne l
  inner join t_commande c on (c.t_commande_id = l.t_commande_id)
  inner join t_produit p on (p.t_produit_id = l.t_produit_id)
  left join t_fournisseur_direct f on (f.t_fournisseur_direct_id = c.t_fournisseur_direct_id)
  left join t_repartiteur r on (r.t_repartiteur_id = c.t_repartiteur_id)
where 
  c.etat <> 3;

/* ********************************************************************************************** */
create view v_vslt_historiques_achats(
  raison_sociale,
  prix_achat_tarif,
  prix_achat_remise,
  t_produit_id,
  quantite_commandee,
  quantite_recue,
  quantite_a_recevoir,
  t_commande_id,
  date_creation,
  etat)
as
select coalesce(f.raison_sociale, r.raison_sociale),
       l.prix_achat_tarif,
       l.prix_achat_remise,
       l.t_produit_id,
       l.quantite_commandee,
       l.quantite_recue,
       l.quantite_commandee - l.quantite_recue,
       c.t_commande_id,
       c.date_creation,
       c.etat
from t_commande_ligne l
     inner join t_commande c on (c.t_commande_id = l.t_commande_id)
     left join  t_repartiteur r on (r.t_repartiteur_id = c.t_repartiteur_id)
     left join t_fournisseur_direct f on (f.t_fournisseur_direct_id = c.t_fournisseur_direct_id)
order by c.date_creation desc;

/* ********************************************************************************************** */
create view v_vslt_historique_client
(
  numero_facture,
  type_facturation,
  date_acte,
  praticien,
  date_prescription,
  t_client_id,
  nom_client,
  prenom_client,
  nom_prenom_client,
  code_operateur,
  code_cip,
  designation,
  quantite_facturee,
  prix_vente
)
as
select he.numero_facture,
he.type_facturation,
he.date_acte,
iif(he.t_praticien_id is null, he.nom_praticien || ' ' || he.prenom_praticien, p.nom || ' ' || p.prenom),
he.date_prescription,
he.t_client_id,
c.nom,
c.prenom,
c.nom || ' ' || c.prenom,
he.code_operateur,
iif( char_length(code_cip)<7 , lpad(cast(hl.code_cip as varchar(7)), 7, '0') , hl.code_cip ),
hl.designation,
hl.quantite_facturee,
hl.prix_vente
from t_historique_client he
     left join t_praticien p on (p.t_praticien_id = he.t_praticien_id)
     inner join t_historique_client_ligne hl on (hl.t_historique_client_id = he.t_historique_client_id)
     inner join t_client c on (c.t_client_id = he.t_client_id);


/* ********************************************************************************************** */
create view v_vslt_credit(
  t_client_id,
  t_compte_id,
  type_client,
  type_client_libelle,
  nom_client,
  date_credit,
  montant)
as
select cr.t_client_id,
       cr.t_compte_id,
       iif(cr.t_compte_id is null, '1', '2'),
       iif(cr.t_compte_id is null, 'Assuré/Bénéficaire', 'Collectivité'),
       iif(cr.t_compte_id is null, cl.nom || ' ' || cl.prenom, cp.nom),    
       cr.date_credit,
       cr.montant       
from t_credit cr
     left join t_client cl on (cl.t_client_id = cr.t_client_id)
     left join t_compte cp on (cp.t_compte_id = cr.t_compte_id)
where cr.repris = '1';
     
/* ********************************************************************************************** */
create view v_vslt_promotion(
  t_promotion_id,
  libelle,
  type_promotion,
  commentaire,
  date_debut,
  date_fin,
  date_creation,
  date_derniere_maj)
as
select t_promotion_id,
       libelle,
       case 
       when	type_promotion = '1' then 'Promotion produit sans panachage'
       when	type_promotion = '2' then 'Promotion lot ferme'
       when	type_promotion = '3' then 'Promotion avec panachage'
       end,
       commentaire,
       date_debut,
       date_fin,
       date_creation,
       date_maj
from t_promotion_entete;

/* ********************************************************************************************** */
create view v_vslt_panier_promotion(
  t_promotion_id,
  t_produit_id,
  designation,
  declencheur,
  quantite,
  stock_alerte,
  prix_vente)
as  
select pr.t_promotion_id,
       pr.t_produit_id,
       prd.designation,
       pr.declencheur,
       pr.qte_affectee,
       pr.stock_alerte,
       pr.lot_prixvente_hors_promo
from t_promotion_produit pr
     inner join t_produit prd on (prd.t_produit_id = pr.t_produit_id);

/* ********************************************************************************************** */
create view v_vslt_avantage_promotion(
  t_promotion_id,
  a_partir_de,
  type_avantage_promo,
  val_avantage)
as  
select  t_promotion_id,
  a_partir_de,
  case
  when type_avantage_promo ='1' then 'Nombre de produit(s) identique(s) offert(s)'  
  when type_avantage_promo ='2' then 'Montant du lot'  
  when type_avantage_promo ='3' then 'Remise sur le lot'  
  when type_avantage_promo ='4' then 'Remise unitaire en montant'  
  when type_avantage_promo ='5' then 'Remise unitaire en pourcentage'  
  when type_avantage_promo ='6' then 'Nombre de produit(s) au choix offert(s)'  
  when type_avantage_promo ='7' then 'Montant du produit au choix' 
  when type_avantage_promo ='8' then 'Remise sur produit au choix' 
  when type_avantage_promo ='9' then 'Produit offert autre que ceux delivres' 
  when type_avantage_promo ='10' then 'Produit offert le moins cher'
  end,
  val_avantage
from t_promotion_avantage;


/* ********************************************************************************************** */


create view v_vslt_vignette_avancee(
  t_client_id,
  nom,
  prenom,       
  code_cip,
  designation,
  quantite_avancee, 
  prix_vente,
  date_avance)
as
select v.t_client_id,
       c.nom,
       c.prenom,       
       v.code_cip,
       v.designation,
       v.quantite_avancee, 
       v.prix_vente,
       v.date_avance
from t_vignette_avancee v
     inner join t_client c on (c.t_client_id = v.t_client_id)
where v.repris = '1';
     
/* ********************************************************************************************** */
create view v_vslt_produit_du(
  t_client_id,
  numero_insee,
  prenom,
  nom,
  date_du,
  quantite,
  code_cip,
  designation,
  prix_vente)
as
select  pd.t_client_id, c.numero_insee, c.prenom, c.nom, pd.date_du, pd.quantite, p.code_cip, p.designation, p.prix_vente
from t_produit_du pd
      inner join t_client c on (c.t_client_id = pd.t_client_id)
      inner join t_produit p on (p.t_produit_id = pd.t_produit_id)
where pd.repris = '1';

/* ********************************************************************************************** */
create view v_vslt_facture_attente(
  t_facture_attente_id,
  prenom_client,
  nom_client,
  assure,
  rue_1,
  code_postal_ville,
  date_acte,
  code_cip,
  designation,
  quantite_facturee,
  prestation,
  prix_vente,
  prix_achat)
as
select 
  e.t_facture_attente_id,
  c.prenom,
  c.nom,
  a.nom || ' ' || a.prenom,
  c.rue_1 adresse,
  c.code_postal || ' ' || c.nom_ville,
  e.date_acte,
  p.code_cip,
  p.designation,
  l.quantite_facturee,
  pr.code,
  l.prix_vente,
  l.prix_achat
from 
  t_facture_attente_ligne l
  inner join t_facture_attente e on (e.t_facture_attente_id = l.t_facture_attente_id)
  inner join t_client c on (c.t_client_id = e.t_client_id)
  left join t_client a on (a.numero_insee = c.numero_insee and a.qualite = '0' and a.t_client_id <> c.t_client_id and  a.numero_insee <> '')
  inner join t_produit p on (p.t_produit_id = l.t_produit_id)
  inner join t_ref_prestation pr on (pr.t_ref_prestation_id = l.t_ref_prestation_id)
where e.repris = '1';

recreate view v_vslt_document_client as 
select 
t_document_id,t_entite_id,document from t_document ;