/******************************************************************************/
create table migration.t_oraerreur( 
t_oraerreur_id number(20) not null, 
typedonnee varchar2(30) not null, 
msgstr varchar2(2000) not null, 
msgidora number(5) not null, 
msgstrora varchar2(2000), 
importance number(2) not null, 
dateheure date,
constraint pk_oraerreur primary key(t_oraerreur_id ));

create sequence migration.seq_id_oraerreur;


/******************************************************************************/
create table migration.tw_famille(
famille varchar2(50) not null,
fam_lgpi number(10) not null,
constraint pk_w_famille primary key (famille, fam_lgpi));

/******************************************************************************/
create table migration.tw_client(
client varchar2(50) not null,
cli_lgpi number(10) not null,
constraint pk_w_client primary key (client, cli_lgpi));


/******************************************************************************/
create table migration.tw_compte(
compte varchar2(50) not null,
cpt_lgpi number(10) not null,
constraint pk_w_compte primary key (compte, cpt_lgpi));

/******************************************************************************/
create table migration.tw_chimique(
chimique varchar2(50) not null,
chim_lgpi number(10) not null,
constraint pk_w_chimique primary key (chimique, chim_lgpi));


/******************************************************************************/
create table migration.tw_profilremise(
profilremise varchar2(50) not null,
prrm_lgpi number(10) not null,
constraint pk_w_profilremise primary key (profilremise, prrm_lgpi));


/******************************************************************************/
create table migration.tw_profilremisesuppl(
profilremisesuppl varchar2(50) not null,
prrmsup_lgpi number(10) not null,
constraint pk_w_profilremisesuppl primary key (profilremisesuppl,prrmsup_lgpi));


/******************************************************************************/
/*create table migration.tw_OrgAssurNotFound(
typeOrg varchar2(50) not null,
idOrg_BDClient varchar2(50));*/


/******************************************************************************/
create table migration.tw_histo_client_entete(
histo_client_entete varchar2(50) not null,
hist_ent_lgpi number(10) not null,
constraint pk_w_histo_client_entete primary key(histo_client_entete, hist_ent_lgpi));


/******************************************************************************/
create table migration.tw_produit(
produit varchar2(50) not null,
prod_lgpi number(10) not null,
constraint pk_w_produit primary key (produit, prod_lgpi));


/******************************************************************************/
create table migration.tw_produitgeographique(
prodgeo varchar2(50) not null,
prodgeo_lgpi number(10) not null,
constraint pk_w_produitgeographique primary key (prodgeo, prodgeo_lgpi));


/******************************************************************************/
create table migration.tw_repartiteur(
repart varchar2(50) not null,
repart_lgpi number(10) not null,
constraint pk_w_repart primary key (repart, repart_lgpi));


/******************************************************************************/
create table migration.tw_fournisseur(
fourn varchar2(50) not null,
fourn_lgpi number(10) not null,
constraint pk_w_fourn primary key (fourn, fourn_lgpi));


/******************************************************************************/
create table migration.tw_zonegeo(
zonegeo varchar2(50) not null,
zonegeo_lgpi number(10) not null,
constraint pk_w_zonegeo primary key (zonegeo,zonegeo_lgpi));


/******************************************************************************/
create table migration.tw_depot(
depot varchar2(50) not null,
depot_lgpi number(10) not null,
constraint pk_w_depot primary key (depot,depot_lgpi));


/******************************************************************************/
create table migration.tw_classificationinterne(
classificationinterne varchar2(50) not null,
classificationinterne_lgpi number(10) not null,
constraint pk_w_classificationinterne primary key (classificationinterne,classificationinterne_lgpi));

/* ********************************************************************************************** */
create table migration.t_tmp_client_fusionne(
  t_client_id integer);

/* ********************************************************************************************** */
create table migration.t_tmp_produit_fusionne(
  t_produit_id integer);

/* ********************************************************************************************** */
create table migration.t_erreur(t_erreur_id integer not null,
categorie varchar2(35) not null,  
donnees varchar2(500) not null,
texte varchar2(500) not null,
constraint pk_erreur primary key(t_erreur_id));

/* ********************************************************************************************** */
create sequence migration.seq_erreur;


/*****************************non utilisé*************************************/

/******************************************************************************/
create table migration.tw_destinataire(
destinataire varchar2(50) not null,
dest_lgpi number(10) not null,
constraint pk_w_destinataire primary key (destinataire, dest_lgpi));

/******************************************************************************/
create table migration.tw_hopital(
hopital varchar2(50) not null,
hop_lgpi number(10) not null,
constraint pk_w_hopital primary key (hopital, hop_lgpi));

/******************************************************************************/
create table migration.tw_praticien(
praticien varchar2(50) not null,
prat_lgpi number(10) not null,
constraint pk_w_praticien primary key (praticien, prat_lgpi));

/******************************************************************************/
create table migration.tw_organismepayeur(
organismepayeur varchar2(50) not null,
orgpayeur_lgpi number(10) not null,
constraint pk_w_organismepayeur primary key (organismepayeur, orgpayeur_lgpi));

create table migration.tw_r_organismepayeur( organismepayeur varchar2(50) not 
null, orgpayeur_lgpi number(10) not null, constraint pk_w_r_organismepayeur 
primary key (organismepayeur, orgpayeur_lgpi));

/******************************************************************************/
create table migration.tw_couvertureamc(
couvertureamc varchar2(50) not null,
couvamc_lgpi number(10) not null,
constraint pk_w_couvertureamc primary key (couvertureamc, couvamc_lgpi));

create table migration.tw_r_couvertureamc(
couvertureamc varchar2(50) not null,
couvamc_lgpi number(10) not null,
constraint pk_w_r_couvertureamc primary key (couvertureamc, couvamc_lgpi));

/******************************************************************************/
create table migration.tw_organisme(
organisme varchar2(50) not null,
org_lgpi number(10) not null,
constraint pk_w_organisme primary key (organisme, org_lgpi));

create table migration.tw_r_organismeamc(
organismeamc varchar2(50) not null,
org_lgpi number(10) not null,
constraint pk_w_r_organismeamc primary key (organismeamc, org_lgpi));

/******************************************************************************/
create table migration.tw_produitlpp(
produitlpp varchar2(50) not null,
prdlpp_lgpi number(10) not null,
constraint pk_w_produitlpp primary key (produitlpp, prdlpp_lgpi));

/******************************************************************************/
create table migration.tw_produitnoserie(
produitnoserie varchar2(50) not null,
prdser_lgpi number(10) not null,
constraint pk_w_produitnoserie primary key (produitnoserie, prdser_lgpi));


/******************************************************************************/
create table migration.tw_operateur(
operateur varchar2(50) not null,
op_lgpi number(10) not null,
constraint pk_w_operateur primary key (operateur, op_lgpi));

/******************************************************************************/
create table migration.tw_factureattenteentete(
factureattenteentete varchar2(50) not null,
factattent_lgpi number(10) not null,
constraint pk_w_factureattenteentete primary key(factureattenteentete, factattent_lgpi));



/******************************************************************************/
create table migration.tw_dossierlocation(
dossierlocation varchar2(50) not null,
dosloc_lgpi number(10) not null,
constraint pk_w_dossierlocation primary key(dossierlocation, dosloc_lgpi));


/******************************************************************************/
create table migration.tw_commandeentete(
commandeentete varchar2(50) not null,
cmdent_lgpi number(10) not null,
constraint pk_w_commandeentete primary key(commandeentete, cmdent_lgpi));

/******************************************************************************/
create table migration.tw_produitdu(
produitdu varchar2(50) not null,
prddu_lgpi number(10) not null,
constraint pk_w_produitdu primary key(produitdu, prddu_lgpi));

/******************************************************************************/
create table migration.tw_promotion(
promotion varchar2(50) not null,
promo_lgpi number(10) not null,
constraint pk_w_promotion primary key(promotion, promo_lgpi));

/******************************************************************************/
create table migration.tw_paramremisetva(
paramremisetva varchar2(50) not null,
rmtva_lgpi number(10) not null,
constraint pk_w_paramremisetva primary key (paramremisetva, rmtva_lgpi));

/******************************************************************************/
create table migration.tw_paramremisefixe(
paramremisefixe varchar2(50) not null,
rmfx_lgpi number(10) not null,
constraint pk_w_paramremisefixe primary key (paramremisefixe, rmfx_lgpi));

/******************************************************************************/
create table migration.tw_fourchetteremise(
fourchetteremise varchar2(50) not null,
fourrm_lgpi number(10) not null,
constraint pk_w_fourchetteremise primary key (fourchetteremise, fourrm_lgpi));


/******************************************************************************/
create table migration.tw_profiledition(
profiledition varchar2(50) not null,
pred_lgpi number(10) not null,
constraint pk_w_profiledition primary key (profiledition, pred_lgpi));


/******************************************************************************/
create table migration.tw_codif1(
codif1 varchar2(50) not null,
cdf1_lgpi number(10) not null,
constraint pk_w_codif1 primary key(codif1, cdf1_lgpi));

create table migration.tw_codif2(
codif2 varchar2(50) not null,
cdf2_lgpi number(10) not null,
constraint pk_w_codif2 primary key(codif2, cdf2_lgpi));

create table migration.tw_codif3(
codif3 varchar2(50) not null,
cdf3_lgpi number(10) not null,
constraint pk_w_codif3 primary key(codif3, cdf3_lgpi));

create table migration.tw_codif4(
codif4 varchar2(50) not null,
cdf4_lgpi number(10) not null,
constraint pk_w_codif4 primary key(codif4, cdf4_lgpi));

create table migration.tw_codif5(
codif5 varchar2(50) not null,
cdf5_lgpi number(10) not null,
constraint pk_w_codif5 primary key(codif5, cdf5_lgpi));

create table migration.tw_codif6(
codif6 varchar2(50) not null,
cdf6_lgpi number(10) not null,
constraint pk_w_codif6 primary key(codif6, cdf6_lgpi));

create table migration.tw_codif7(
codif7 varchar2(50) not null,
cdf7_lgpi number(10) not null,
constraint pk_w_codif7 primary key(codif7, cdf7_lgpi));

/******************************************************************************/
create table migration.tw_classificationint(
classifintparent varchar2(50) not null,
classifintenfant varchar2(50),
classifint_lgpi number(10) not null);

create index idx_w_classifint_prtenf on migration.tw_classificationint(classifintparent, classifintenfant);

create table migration.t_fusion_client(
  t_client_id integer not null,
  etat char(1) not null,
  constraint pk_fusion_client primary key(t_client_id),
  constraint chk_fuscli_etat check(etat in ('C', 'F', 'R')));