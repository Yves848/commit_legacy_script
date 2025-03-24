/* ********************************************************************************************** */
create or replace view migration.v_numero_lot(
  t_destinataire_id,
  nom,
  numero_lot)
as
select lot.t_destinataire_id,       
       dest.nom,
       lot.numlotfse 
  
from erp.t_sv_numlot lot,
     erp.t_destinataire dest
where lot.t_destinataire_id = dest.t_destinataire_id;

/* ********************************************************************************************** */
create or replace view migration.v_stat_clients_par_organismes(
type_organisme, 
nom, 
identifiant_national, 
nb_clients) 
as 
select 'AMO', 
       orgamo.nom, 
       reg.code || orgamo.caissegestionnaire || orgamo.centregestionnaire, 
       count(*)
from erp.t_assureayantdroit ass,
     erp.t_organismeamo orgamo,
     erp.t_regime reg,
     erp.t_organismeaadamo orgaadamo
where orgaadamo.t_organismeamo_id = orgamo.t_organismeamo_id
  and ass.t_aad_id = orgaadamo.t_aad_id
  and orgamo.t_regime_id = reg.t_regime_id
group by orgamo.nom, 
         reg.code, 
         orgamo.caissegestionnaire, 
         orgamo.centregestionnaire
union
select 'AMC', 
       orgamc.nom, 
       orgamc.identifiantnational, 
       count(*)
from erp.t_assureayantdroit ass,
     erp.t_organismeamc orgamc
where ass.t_organismeamc_id = orgamc.t_organismeamc_id
group by orgamc.nom, 
         orgamc.identifiantnational;
         
         
/* ********************************************************************************************** */
create or replace view migration.v_stat_inventaire_produits(
taux_tva, 
priorite,
nb_produits, 
nb_unites,
total_prix_achat_catalogue,
total_prix_vente, 
total_pamp) 
as 
select tva.tauxtva, 
       prdgeo.priorite,
       count(*), 
       sum(prdgeo.quantite),
       sum(prdgeo.quantite * prd.prixachatcatalogue),
       sum(prdgeo.quantite * prd.prixvente),
       sum(prdgeo.quantite * prd.pamp)
from erp.t_produit prd,
     erp.t_tva tva,
      erp.t_produitgeographique prdgeo
where prd.t_tva_id = tva.t_tva_id
  and prd.t_produit_id = prdgeo.t_produit_id(+)
  and prdgeo.quantite > 0
group by tva.tauxtva, prdgeo.priorite;                                                

/* ********************************************************************************************** */
create or replace view migration.v_ref_prestation(
  t_ref_prestation_id, 
  code, 
  code_taux, 
  est_tips, 
  priorite, 
  est_lpp)
as
select t_prestation_id, code, codetaux, esttips, priorite, estlpp
from erp.t_prestation
order by code;

create or replace view migration.v_ref_organisme_amo(
  t_ref_organisme_id,
  type_organisme,
  t_ref_regime_id,
  caisse_gestionnaire,
  centre_gestionnaire,
  identifiant_national,
  nom,
  nom_reduit,
  code_postal,
  nom_ville,
  tel_standard,
  tel_personnel,
  tel_mobile,
  fax)
as
select t_organismeamo_id, '1', t_regime_id, caissegestionnaire, centregestionnaire, null, nom, null, null, null, null, null , null , null
from erp.t_organismeamo
where orgreference = '1'
  and upper(nom) not like '%CNDA%'
  and t_regime_id is not null
order by t_regime_id, caissegestionnaire, centregestionnaire;

create or replace view migration.v_ref_couverture_amo(
  t_ref_couverture_amo_id, 
  code_couverture, 
  libelle, 
  justificatif_exo)
as
select t_couvertureamo_id, codecouverture, libelle, justificatifexo
from erp.t_couvertureamo
order by codecouverture;

create or replace view migration.v_ref_taux_prise_en_charge(
  t_ref_taux_prise_en_charge_id,
  t_ref_couverture_amo_id,
  t_ref_couverture_amc_id,
  t_ref_prestation_id,
  taux)
as 
select t_tauxpriseencharge_id, t_couvertureamo_id, null, t_prestation_id, tauxpriseencharge 
from erp.t_tauxpriseencharge
where ( t_couvertureamo_id, t_prestation_id, dateapplication ) in
(
select  
t_couvertureamo_id, t_prestation_id, max(dateapplication) 
from erp.t_tauxpriseencharge
group by t_couvertureamo_id, t_prestation_id
)
order by t_couvertureamo_id;

create or replace view migration.v_ref_organisme_couverture_amo(
  t_ref_organisme_amo_id,
  t_ref_couverture_amo_id)
as
select o.t_organismeamo_id, t.t_couvertureamo_id
from erp.t_organismeamo o
inner join erp.t_28 t on (t.t_regime_id = o.t_regime_id)
where o.orgreference = '1'
  and upper(o.nom) not like '%CNDA%';