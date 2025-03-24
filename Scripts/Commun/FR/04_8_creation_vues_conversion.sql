set sql dialect 3;

/* ********************************************************************************************** */
recreate view v_organisme_amo(t_organisme_amo_id,
                              nom,
                              nom_reduit,
                              t_ref_organisme_amo_id,
                              sans_centre_gestionnaire,
                              identifiant_national,
                              rue_1,
                              rue_2,
                              code_postal_ville,
                              code_postal,
                              nom_ville,
                              commentaire,
                              repris)
as
select o.t_organisme_id,
       o.nom,
       o.nom_reduit,
       o.t_ref_organisme_id,
       case
         when o.t_ref_organisme_id is null then o_rr.sans_centre_gestionnaire
         else oref_rr.sans_centre_gestionnaire
       end,
       case
         when o.t_ref_organisme_id is null then o_rr.code || o.caisse_gestionnaire || coalesce(o.centre_gestionnaire, '')
         else oref_rr.code || oref.caisse_gestionnaire || coalesce(oref.centre_gestionnaire, '')
       end,
       o.rue_1,
       o.rue_2,
       case
         when ((o.code_postal is null) or (o.code_postal = '')) then o.nom_ville
         else o.code_postal || ' ' || o.nom_ville
       end,
       o.code_postal,
       o.nom_ville,
       o.commentaire,
       o.repris
from t_organisme o
     left join t_ref_regime o_rr on (o_rr.t_ref_regime_id = o.t_ref_regime_id)
     left join t_ref_organisme oref on (oref.t_ref_organisme_id = o.t_ref_organisme_id)
     left join t_ref_regime oref_rr on (oref_rr.t_ref_regime_id = oref.t_ref_regime_id)
where o.type_organisme = '1'
  and exists(select *
             from t_client c 
             where c.t_organisme_amo_id = o.t_organisme_id);

/* ********************************************************************************************** */
recreate view v_cnv_organisme_amo(t_organisme_amo_id,
                                  nom,
                                  nom_reduit,
                                  t_ref_organisme_amo_id,
                                  sans_centre_gestionnaire,
                                  identifiant_national,
                                  rue_1,
                                  rue_2,
                                  code_postal_ville,
                                  code_postal,
                                  nom_ville,
                                  commentaire,
                                  repris,
                                  nombre_clients)
as
select o.*,
       c.nombre_clients
from v_organisme_amo o
     inner join (select t_organisme_amo_id, count(*) nombre_clients
                 from t_client
                 group by t_organisme_amo_id) c on (c.t_organisme_amo_id = o.t_organisme_amo_id);

/* ********************************************************************************************** */
recreate view v_couverture_amo(t_organisme_amo_id,
                               nom_organisme,
                               identifiant_national,
                               t_ref_organisme_amo_id,
                               t_couverture_amo_id,
                               libelle,
                               code_couverture,
                               nature_assurance,
                               ald,
                               justificatif_exo,
                               t_ref_couverture_amo_id,
                               repris)
as
select distinct cast(substring(couvamo.t_organisme_amo_id from 1 for 20) as varchar(20)),
                org.nom,
                reg.code || r_org.caisse_gestionnaire || coalesce(r_org.centre_gestionnaire, ''),
                org.t_ref_organisme_id,
                couvamo.t_couverture_amo_id,
                cast(substring(couvamo.libelle from 1 for 30) as varchar(30)),
                cast(r_couvamo.code_couverture as varchar(10)),
                couvamo.nature_assurance,
                couvamo.ald,
                couvamo.justificatif_exo,
                couvamo.t_ref_couverture_amo_id,
                iif(org.repris = '1', couvamo.repris, '0')
from t_couverture_amo_client couvcli
     inner join t_couverture_amo couvamo on (couvamo.t_couverture_amo_id = couvcli.t_couverture_amo_id)
     inner join t_organisme org on (org.t_organisme_id = couvamo.t_organisme_amo_id)
     left join t_ref_organisme r_org on (r_org.t_ref_organisme_id = org.t_ref_organisme_id)
     left join t_ref_regime reg on (reg.t_ref_regime_id = r_org.t_ref_regime_id)
     left join t_ref_couverture_amo r_couvamo on (r_couvamo.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id)
;

/* ********************************************************************************************** */
recreate view v_cnv_couverture_amo(
  t_organisme_amo_id,
  nom_organisme,
  identifiant_national,
  t_ref_organisme_amo_id,
  t_couverture_amo_id,
  libelle,
  code_couverture,
  nature_assurance,
  ald,
  justificatif_exo,
  t_ref_couverture_amo_id,
  repris,
  nombre_clients)
as
select cv.*,
       c.nombre_clients
from v_couverture_amo cv
     inner join (select t_couverture_amo_id, count(*) nombre_clients
                 from t_couverture_amo_client
                 group by t_couverture_amo_id) c on (c.t_couverture_amo_id = cv.t_couverture_amo_id);

/* ********************************************************************************************** */
create view v_ref_organisme_amo(
  t_ref_organisme_amo_id,
  nom,
  regime,
  caisse_gestionnaire,
  centre_gestionnaire,
  code_postal,
  nom_ville)
as
select o.t_ref_organisme_id,  
       o.nom,  
       r.code,  
       o.caisse_gestionnaire,  
       o.centre_gestionnaire,  
       o.code_postal,  o.nom_ville
from t_ref_organisme o
     inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
where type_organisme = '1'
order by o.t_ref_regime_id, o.caisse_gestionnaire, o.centre_gestionnaire;

/* ********************************************************************************************** */
create view v_cnv_couverture_amc(
  t_couverture_amo_id,
  t_couverture_amc_id)
as
select distinct
  couvamo.t_ref_couverture_amo_id,
  cli.t_couverture_amc_id
from 
  t_couverture_amo_client couvamocli
  inner join t_client cli on (cli.t_client_id = couvamocli.t_client_id)
  inner join t_couverture_amo couvamo on (couvamo.t_couverture_amo_id = couvamocli.t_couverture_amo_id)
  inner join t_ref_couverture_amo refcouvamo on (refcouvamo.t_ref_couverture_amo_id = couvamo.t_ref_couverture_amo_id)
  inner join t_cnv_couverture_amc cnvcouvamc on (cnvcouvamc.t_couverture_amc_id = cli.t_couverture_amc_id)
where couvamo.ald = '0'
  and refcouvamo.code_couverture not like '90%'
   and cli.t_couverture_amc_id is not null
   and cnvcouvamc.formule = '021';
   
/* ********************************************************************************************** */
create view v_cnv_compte(
  t_compte_id,
  nom,
  code_postal_ville,
  collectif,
  t_client_id,
  nom_prenom_client,
  nombre_adherents,
  repris,
  credit)
as
select cpt.t_compte_id,
       cpt.nom,
       cpt.code_postal || ' ' || cpt.nom_ville,
       cpt.collectif,
       cpt.t_client_id,
       cli.nom || ' ' || cli.prenom,
       cptcli.nombre_adherents,
       cpt.repris,
       sum(cdt.montant) credit
from t_compte cpt
     left join (select t_compte_id, count(*) nombre_adherents
                from t_compte_client
                group by t_compte_id) cptcli on (cptcli.t_compte_id = cpt.t_compte_id)
     left join t_client cli on (cli.t_client_id = cpt.t_client_id)
     left join t_credit cdt on (cdt.t_compte_id = cpt.t_compte_id)
group by cpt.t_compte_id,
         cpt.nom,
         cpt.code_postal,
         cpt.nom_ville,
         cpt.collectif,
         cpt.t_client_id,
         cli.nom,
         cli.prenom,
         cptcli.nombre_adherents,
         cpt.repris;
