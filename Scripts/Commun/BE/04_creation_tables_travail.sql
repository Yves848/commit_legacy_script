set sql dialect 3;

/******************************************************************************/
create table tw_praticien(
praticien dm_code not null,
prat_lgpi dm_cle not null,
constraint pk_w_praticien primary key (praticien, prat_lgpi));

/******************************************************************************/
create table tw_famille(
famille dm_code not null,
fam_lgpi dm_cle not null,
constraint pk_w_famille primary key (famille, fam_lgpi));

/******************************************************************************/
create table tw_client(
client dm_code not null,
cli_lgpi dm_cle not null,
constraint pk_w_client primary key (client, cli_lgpi));


/******************************************************************************/
create table tw_chimique(
chimique dm_code not null,
chim_lgpi dm_cle not null,
constraint pk_w_chimique primary key (chimique, chim_lgpi));


/******************************************************************************/
create table tw_compte(
compte dm_code not null,
cpt_lgpi dm_cle not null,
constraint pk_w_compte primary key (compte, cpt_lgpi));


/******************************************************************************/
create table tw_profilremise(
profilremise dm_code not null,
prrm_lgpi dm_cle not null,
constraint pk_w_profilremise primary key (profilremise, prrm_lgpi));

/******************************************************************************/
create table tw_profilremisesuppl(
profilremisesuppl dm_code not null,
prrmsup_lgpi dm_cle not null,
constraint pk_w_profilremisesuppl primary key (profilremisesuppl,prrmsup_lgpi));

/******************************************************************************/
create table tw_histo_client_entete(
histo_client_entete dm_code not null,
hist_ent_lgpi dm_cle not null,
constraint pk_w_histo_client_entete primary key(histo_client_entete, hist_ent_lgpi));

alter table tw_histo_client_entete
add constraint fk_hist_ent_hist_ent foreign key(histo_client_entete)
references t_histodelgeneral(histodelgeneral)
on delete cascade;

/******************************************************************************/
create table tw_produit(
produit dm_code not null,
prod_lgpi dm_cle not null,
constraint pk_w_produit primary key (produit, prod_lgpi));

/******************************************************************************/
create table tw_produitgeographique(
prodgeo dm_code not null,
prodgeo_lgpi dm_cle not null,
constraint pk_w_produitgeographique primary key (prodgeo, prodgeo_lgpi));

/******************************************************************************/
create table tw_repartiteur(
repart dm_code not null,
repart_lgpi dm_cle not null,
constraint pk_w_repart primary key (repart, repart_lgpi));

/******************************************************************************/
create table tw_fournisseur(
fourn dm_code not null,
fourn_lgpi dm_cle not null,
constraint pk_w_fourn primary key (fourn, fourn_lgpi));

/******************************************************************************/
create table tw_zonegeo(
zonegeo dm_code not null,
zonegeo_lgpi dm_cle not null,
constraint pk_w_zonegeo primary key (zonegeo,zonegeo_lgpi));

/******************************************************************************/
create table tw_depot(
depot dm_code not null,
depot_lgpi dm_cle not null,
constraint pk_w_depot primary key (depot,depot_lgpi));

/******************************************************************************/
create table tw_organismeCPAS_OA(
organisme_cpas_oa dm_code not null,
organisme_cpas_oa_lgpi dm_cle not null,
constraint pk_w_organisme_cpas_oa primary key (organisme_cpas_oa,organisme_cpas_oa_lgpi));

/******************************************************************************/
create table tw_organismeCPAS_OC(
organisme_cpas_oc dm_code not null,
organisme_cpas_oc_lgpi dm_cle not null,
constraint pk_w_organisme_cpas_oc primary key (organisme_cpas_oc,organisme_cpas_oc_lgpi));

/******************************************************************************/
create table tw_classificationinterne(
classificationinterne dm_code not null,
classificationinterne_lgpi dm_cle not null,
constraint pk_w_classificationinterne primary key (classificationinterne,classificationinterne_lgpi));

/******************************************************************************/
create table tw_formulaire(
formulaire dm_code not null,
formulaire_lgpi dm_cle not null,
constraint pk_w_formulaire primary key (formulaire,formulaire_lgpi));

/******************************************************************************/
create table tw_formule(
formule dm_code not null,
formule_lgpi dm_cle not null,
constraint pk_w_formule primary key (formule,formule_lgpi));

/******************************************************************************/
create table tw_medication_produit(
medication_produit dm_code not null,
medication_produit_lgpi dm_cle not null,
constraint pk_w_medication_produit primary key (medication_produit,medication_produit_lgpi));
