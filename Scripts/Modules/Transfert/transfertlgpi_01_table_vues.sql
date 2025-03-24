set sql dialect 3;

/* ********************************************************************************************** */
create table t_transfertlgpi_hopital (
  t_hopital_id dm_code not null,
  t_transfertlgpi_hopital_id dm_cle not null,
  constraint pk_lgpi_hopital primary key (t_hopital_id,t_transfertlgpi_hopital_id));

alter table t_transfertlgpi_hopital
add constraint fk_lgpi_hop_hopital
foreign key (t_hopital_id)
references t_cnv_hopital(t_cnv_hopital_id)
on delete cascade;
  
/* ********************************************************************************************** */
create table t_transfertlgpi_praticien (
  t_praticien_id dm_code not null,
  t_transfertlgpi_praticien_id dm_cle not null,
  constraint pk_lgpi_praticien primary key (t_praticien_id, t_transfertlgpi_praticien_id));

alter table t_transfertlgpi_praticien
add constraint fk_lgpi_prat_praticien
foreign key (t_praticien_id)
references t_praticien(t_praticien_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_destinataire (
  t_destinataire_id dm_code not null,
  t_transfertlgpi_destinataire_id dm_cle not null,
  constraint pk_lgpi_destinataire primary key (t_destinataire_id, t_transfertlgpi_destinataire_id));

alter table t_transfertlgpi_destinataire
add constraint fk_lgpi_dest_destinataire
foreign key (t_destinataire_id)
references t_destinataire(t_destinataire_id)
on delete cascade;

/* ********************************************************************************************** */
--create table t_transfertlgpi_organisme_payeur (
--  t_organisme_payeur_id dm_cle not null,
--  t_transfertlgpi_organisme_payeur_id dm_cle not null,
--  constraint pk_lgpi_organisme_payeur primary key (t_organisme_payeur_id, t_transfertlgpi_organisme_payeur_id));

--alter table t_transfertlgpi_organisme_payeur
--add constraint fk_lgpi_orgpay_organisme_payeur
--foreign key (t_organisme_payeur_id)
--references t_organisme_payeur(t_organisme_payeur_id)
--on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_organisme (
  t_organisme_id dm_code not null,
  t_transfertlgpi_organisme_id dm_cle not null,
  constraint pk_lgpi_organisme primary key (t_organisme_id, t_transfertlgpi_organisme_id));

alter table t_transfertlgpi_organisme
add constraint fk_lgpi_org_organisme
foreign key (t_organisme_id)
references t_organisme(t_organisme_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_couverture_amc (
  t_couverture_amc_id dm_code not null,
  t_transfertlgpi_couv_amc_id dm_cle not null,
  constraint pk_lgpi_couverture_amc primary key (t_couverture_amc_id, t_transfertlgpi_couv_amc_id));

alter table t_transfertlgpi_couverture_amc
add constraint fk_lgpi_couv_amc_couverture_amc
foreign key (t_couverture_amc_id)
references t_cnv_couverture_amc(t_cnv_couverture_amc_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_client (
  t_client_id dm_code not null,
  t_transfertlgpi_client_id dm_cle not null,
  constraint pk_lgpi_client primary key (t_client_id, t_transfertlgpi_client_id));

alter table t_transfertlgpi_client
add constraint fk_lgpi_cli_client
foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_profil_edition (
  t_profil_edition_id dm_code not null,
  t_transfertlgpi_profil_ed_id dm_cle not null,
  constraint pk_lgpi_profil_edition primary key (t_profil_edition_id, t_transfertlgpi_profil_ed_id));

alter table t_transfertlgpi_profil_edition
add constraint fk_lgpi_pred_profil_edition
foreign key (t_profil_edition_id)
references t_profil_edition(t_profil_edition_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_profil_remise (
  t_profil_remise_id dm_code not null,
  t_transfertlgpi_profil_rem_id dm_cle not null,
  constraint pk_lgpi_profil_remise primary key (t_profil_remise_id, t_transfertlgpi_profil_rem_id));

alter table t_transfertlgpi_profil_remise
add constraint fk_lgpi_prrm_profil_remise
foreign key (t_profil_remise_id)
references t_profil_remise(t_profil_remise_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_param_rem_fixe (
  t_param_remise_fixe_id dm_code not null,
  t_transfertlgpi_prm_rem_fixe_id dm_cle not null,
  constraint pk_transfertlgpi_param_rem_fixe primary key (t_param_remise_fixe_id, t_transfertlgpi_prm_rem_fixe_id));

alter table t_transfertlgpi_param_rem_fixe
add constraint fk_transfertlgpi_prrmf_prm_rm_f
foreign key (t_param_remise_fixe_id)
references t_param_remise_fixe(t_param_remise_fixe_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_art_rem (
  t_article_remise_id dm_code not null,
  t_transfertlgpi_art_rem_id dm_cle not null,
  constraint pk_lgpi_art_rem primary key (t_article_remise_id, t_transfertlgpi_art_rem_id));

alter table t_transfertlgpi_art_rem
add constraint fk_lgpi_cpt_art_rem
foreign key (t_article_remise_id)
references t_article_remise(t_article_remise_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_compte (
  t_compte_id dm_code not null,
  t_transfertlgpi_compte_id dm_cle not null,
  constraint pk_lgpi_compte primary key (t_compte_id, t_transfertlgpi_compte_id));

alter table t_transfertlgpi_compte
add constraint fk_lgpi_cpt_compte
foreign key (t_compte_id)
references t_compte(t_compte_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_fourn_direct (
  t_fournisseur_direct_id dm_code not null,
  t_transfertlgpi_fourn_direct_id dm_cle not null,
  constraint pk_lgpi_fournisseur_direct primary key (t_fournisseur_direct_id, t_transfertlgpi_fourn_direct_id));

alter table t_transfertlgpi_fourn_direct
add constraint fk_lgpi_foudir_fournisseur
foreign key (t_fournisseur_direct_id)
references t_fournisseur_direct(t_fournisseur_direct_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_repartiteur (
  t_repartiteur_id dm_code not null,
  t_transfertlgpi_repartiteur_id dm_cle not null,
  constraint pk_lgpi_repartiteur primary key (t_repartiteur_id, t_transfertlgpi_repartiteur_id));

alter table t_transfertlgpi_repartiteur
add constraint fk_lgpi_rep_repartiteur
foreign key (t_repartiteur_id)
references t_repartiteur(t_repartiteur_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_zone_geo (
  t_zone_geographique_id dm_code not null,
  t_transfertlgpi_zone_geo_id dm_cle not null,
  constraint pk_lgpi_zone_geographique primary key (t_zone_geographique_id, t_transfertlgpi_zone_geo_id));

alter table t_transfertlgpi_zone_geo
add constraint fk_lgpi_zonegeo_zone_geo
foreign key (t_zone_geographique_id)
references t_zone_geographique(t_zone_geographique_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_classifint(
t_classification_interne_id varchar(50),
t_transfertlgpi_classifint_id integer,
constraint pk_transfertlgpi_classifint primary key(t_classification_interne_id, t_transfertlgpi_classifint_id));

alter table t_transfertlgpi_classifint
add constraint fk_lgpi_clint_classifint
foreign key (t_classification_interne_id)
references t_classification_interne(t_classification_interne_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_codification (
  t_codification_id dm_cle not null,
  t_transfertlgpi_codification_id dm_cle not null,
  constraint pk_lgpi_codification primary key (t_codification_id, t_transfertlgpi_codification_id));

alter table t_transfertlgpi_codification
add constraint fk_lgpi_cdf_codification
foreign key (t_codification_id)
references t_codification(t_codification_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_produit (
  t_produit_id dm_code not null,
  t_transfertlgpi_produit_id dm_cle not null,
  constraint pk_lgpi_produit primary key (t_produit_id, t_transfertlgpi_produit_id));

alter table t_transfertlgpi_produit
add constraint fk_lgpi_prd_produit
foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_depot (
  t_depot_id dm_code not null,
  t_transfertlgpi_depot_id dm_cle not null,
  constraint pk_lgpi_depot primary key (t_depot_id, t_transfertlgpi_depot_id));

alter table t_transfertlgpi_depot
add constraint fk_lgpi_prd_depot
foreign key (t_depot_id)
references t_depot(t_depot_id)
on delete cascade;


/* ********************************************************************************************** */
create table t_transfertlgpi_catalogue(
  t_catalogue_id dm_code not null,
  t_transfertlgpi_catalogue_id dm_cle not null,
  constraint pk_lgpi_catalogue primary key (t_catalogue_id, t_transfertlgpi_catalogue_id),
  constraint fk_lgpi_cat_catalogue foreign key(t_catalogue_id) references t_catalogue(t_catalogue_id) on delete cascade);
  
/* ********************************************************************************************** */
create table t_transfertlgpi_classif_four(
  t_classification_fournisseur_id dm_code not null,
  t_transfertlgpi_classif_four_id dm_cle not null,
  constraint pk_lgpi_classif_four primary key (t_classification_fournisseur_id, t_transfertlgpi_classif_four_id),
  constraint fk_lgpi_cl_fou_catalogue foreign key(t_classification_fournisseur_id) 
  references t_classification_fournisseur(t_classification_fournisseur_id) on delete cascade);
  
/* ********************************************************************************************** */
create table t_transfertlgpi_commande (
  t_commande_id dm_code not null,
  t_transfertlgpi_commande_id dm_cle not null,
  constraint pk_lgpi_commande primary key (t_commande_id, t_transfertlgpi_commande_id));
  
alter table t_transfertlgpi_commande
add constraint fk_lgpi_cmd_commande
foreign key (t_commande_id)
references t_commande(t_commande_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_histo_client (
  t_historique_client_id dm_code not null,
  t_transfertlgpi_histo_client_id dm_cle not null,
  constraint pk_lgpi_historique_client primary key (t_historique_client_id, t_transfertlgpi_histo_client_id));

alter table t_transfertlgpi_histo_client
add constraint fk_lgpi_hist_cli_hist_client
foreign key (t_historique_client_id)
references t_historique_client(t_historique_client_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_promotion (
  t_promotion_id dm_code not null,
  t_transfertlgpi_promotion_id dm_cle not null,
  constraint pk_lgpi_promotion primary key (t_promotion_id, t_transfertlgpi_promotion_id));

alter table t_transfertlgpi_promotion
add constraint fk_lgpi_promo_promotion
foreign key (t_promotion_id)
references t_promotion_entete(t_promotion_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_operateur (
  t_operateur_id dm_code not null,
  t_transfertlgpi_operateur_id dm_cle not null,
  constraint pk_lgpi_operateur primary key (t_operateur_id, t_transfertlgpi_operateur_id));

alter table t_transfertlgpi_operateur
add constraint fk_lgpi_op_operateur
foreign key (t_operateur_id)
references t_operateur(t_operateur_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_credit (
  t_credit_id dm_code not null,
  t_transfertlgpi_acte_id dm_cle not null,
  constraint pk_lgpi_credit primary key (t_credit_id, t_transfertlgpi_acte_id));

alter table t_transfertlgpi_credit
add constraint fk_lgpi_credit
foreign key (t_credit_id)
references t_credit(t_credit_id)
on delete cascade;


/* ********************************************************************************************** */
create table t_transfertlgpi_fact_attente (
  t_facture_attente_id dm_code not null,
  t_transfertlgpi_fact_attente_id dm_cle not null,
  constraint pk_lgpi_facture_attente primary key (t_facture_attente_id, t_transfertlgpi_fact_attente_id));

alter table t_transfertlgpi_fact_attente
add constraint fk_lgpi_facatt_facture_attente
foreign key (t_facture_attente_id)
references t_facture_attente(t_facture_attente_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_produit_du (
  t_produit_du_id dm_code not null,
  t_transfertlgpi_produit_du_id dm_cle not null,
  constraint pk_lgpi_produit_du primary key (t_produit_du_id, t_transfertlgpi_produit_du_id));

alter table t_transfertlgpi_produit_du
add constraint fk_lgpi_prdu_produit_du
foreign key (t_produit_du_id)
references t_produit_du(t_produit_du_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_prog_avantage (
  t_programme_avantage_id dm_code not null,
  t_transfertlgpi_prog_avantag_id  dm_cle not null,
  constraint pk_lgpi_programme_avantage primary key (t_programme_avantage_id, t_transfertlgpi_prog_avantag_id));
    
alter table t_transfertlgpi_prog_avantage
add constraint fk_lgpi_cli_programme_avantage 
foreign key (t_programme_avantage_id) 
references t_programme_avantage (t_programme_avantage_id) 
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_commentaire (
  t_commentaire_id dm_code not null,
  t_transfertlgpi_commentaire_id  dm_cle not null,
  constraint pk_lgpi_commentaire primary key (t_commentaire_id, t_transfertlgpi_commentaire_id));
    
alter table t_transfertlgpi_commentaire
add constraint fk_lgpi_com_commentaire
foreign key (t_commentaire_id) 
references t_commentaire(t_commentaire_id) 
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertlgpi_document (
  t_document_id dm_cle not null,
  t_transfertlgpi_document_id  dm_cle not null,
  constraint pk_lgpi_document primary key (t_document_id, t_transfertlgpi_document_id));
    
alter table t_transfertlgpi_document
add constraint fk_lgpi_doc_document
foreign key (t_document_id) 
references t_document(t_document_id) 
on delete cascade;

/* ********************************************************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HOPITAUX', '22', '1', 'Hopitaux', 'grdPraticiens', next value for seq_grille_trf_praticiens);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_hopital', 'pk_praticiens.creer_hopital', 't_transfertlgpi_hopital', '1', 'erp.t_structure', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRATICIENS', '22', '1', 'Praticiens prives hospitaliers', 'grdPraticiens', next value for seq_grille_trf_praticiens);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_praticien', 'pk_praticiens.creer_praticien', 't_transfertlgpi_praticien', '1', 'erp.t_praticien', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DESTINATAIRES', '22', '1', 'Destinataires', 'grdOrganismes', next value for seq_grille_trf_organismes);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_destinataire', 'pk_organismes.creer_destinataire', 't_transfertlgpi_destinataire', '0', 'erp.t_destinataire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ORGANISMES', '22', '1', 'Organismes AMO AMC', 'grdOrganismes', next value for seq_grille_trf_organismes);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_organisme', 'pk_organismes.creer_organisme', 't_transfertlgpi_organisme', '1', 'erp.t_organismeamo where orgreference = ''0'';erp.t_organismeamc where orgreference = ''0''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COUVERTURES AMC', '22', '1', 'Couvertures AMC', 'grdOrganismes', next value for seq_grille_trf_organismes);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_couverture_amc', 'pk_organismes.creer_couverture_amc', 't_transfertlgpi_couverture_amc', '1', 'erp.t_couvertureamc where couvreference = ''0''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'TAUX PRISE EN CHARGE', '22', '1', 'Taux de prise en charge', 'grdOrganismes', next value for seq_grille_trf_organismes);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_taux_pc', 'pk_organismes.creer_taux_prise_en_charge', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pk_organismes.ajuster_couvertures_amc', '23', '1', 'Ajustement taux de prise en charge', 'grdOrganismes', next value for seq_grille_trf_organismes);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CLIENTS', '22', '1', 'Clients', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_client', 'pk_clients.creer_client', 't_transfertlgpi_client', '1', 'erp.t_assureayantdroit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ASSURES RATTACHES', '22', '1', 'Assurés rattachés', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_ass_rattache', 'pk_clients.rattacher_assure', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COUVERTURES CLIENTS', '22', '1', 'Couvertures AMO clients', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_couv_amo_cli', 'pk_clients.creer_couverture_amo_client', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'REMISES FIXES', '22', '1', 'Remises fixes', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_param_rem_fixe', 'pk_comptes.creer_param_remise_fixe', 't_transfertlgpi_param_rem_fixe', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROFILS DE REMISE', '22', '1', 'Profils de remise', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_profil_remise', 'pk_comptes.creer_profil_remise', 't_transfertlgpi_profil_remise', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMPTES', '22', '1', 'Comptes', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_compte', 'pk_comptes.creer_compte', 't_transfertlgpi_compte', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ADHERENTS COMPTES', '22', '1', 'Adherents comptes', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_client_compte', 'pk_comptes.rattacher_client', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'MANDATAIRES', '22', '1', 'Mandataires', 'grdClients', next value for seq_grille_trf_clients);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_mandataire', 'pk_clients.creer_mandataire', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DEPOTS', '22', '1', 'Depots', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_depot', 'pk_produits.creer_depot', 't_transfertlgpi_depot', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'FOURNISSEURS DIRECTS', '22', '1', 'Fournisseurs', 'grdProduits', next value for seq_grille_trf_produits);
--insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
--values(next value for seq_transfert_traitement, 'ps_transfertlgpi_fourn_direct', 'pk_produits.creer_fournisseur', 't_transfertlgpi_fourn_direct', '0', 'erp.t_fournisseur where type_fournisseur = ''D'' and foud_partenaire = ''0''', gen_id(seq_fct_fichier, 0));
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_fourn_direct', 'pk_produits.creer_fournisseur', 't_transfertlgpi_fourn_direct', '1', 'erp.t_fournisseur where type_fournisseur = ''D''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HISTO STOCK FOURNISSEURS', '22', '1', 'Historique de stock fournisseurs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_histo_stock', 'pk_produits.creer_histo_stock', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'REPARTITEURS', '22', '1', 'Répartiteurs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_repartiteur', 'pk_produits.creer_fournisseur', 't_transfertlgpi_repartiteur', '1', 'erp.t_fournisseur where type_fournisseur = ''R''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CODIFICATIONS', '22', '1', 'Codifications', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_codification', 'pk_produits.creer_codification', null, '0', 'erp.t_codif1;erp.t_codif2;erp.t_codif3;erp.t_codif5;erp.t_codif6', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ZONES GEOGRAPHIQUES', '22', '1', 'Zones géographiques', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_zone_geo', 'pk_produits.creer_zone_geographique','t_transfertlgpi_zone_geo', '1', 'erp.t_zonegeographique', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'REMISES ARTICLES', '22', '1', 'Remises articles se lance en 2.31 uniquement', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_article_remise', 'pk_produits.creer_article_remise', 't_transfertlgpi_art_rem', '0', 'erp.t_article_remise', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRODUITS', '22', '1', 'Produits', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_produit', 'pk_produits.creer_produit', 't_transfertlgpi_produit', '1', 'erp.t_produit where reference = ''0''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DECONDITIONNEMENT STUP', '22', '1', 'Déconditionement Stupéfiant', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_stup', 'pk_produits.maj_produit_stup', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'STOCKS', '22', '1', 'Stocks', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_info_stock', 'pk_produits.creer_information_stock', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HISTORIQUES VENTES', '22', '1', 'Historiques ventes', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_histo_vente', 'pk_produits.creer_historique_vente', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CODES EAN13', '22', '1', 'Codes EAN13', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_code_ean13', 'pk_produits.creer_code_ean13', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CODES LPP', '22', '1', 'Codes LPP', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_code_lpp', 'pk_produits.creer_code_lpp', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CATALOGUES', '22', '1', 'Catalogues', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_catalogue', 'pk_produits.creer_catalogue', 't_transfertlgpi_catalogue', '0', 'erp.t_catalogue_entete', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CLASSIF FOURNISSEURS', '22', '1', 'Classifications fournisseurs', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_classif_four', 'pk_produits.creer_classif_fournisseur', 't_transfertlgpi_classif_four', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CLASSIF INTERNES', '22', '1', 'Classifications internes', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_classif_int', 'pk_produits.creer_classif_interne', 't_transfertlgpi_classifint', '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'LIGNES CATALOGUES', '22', '1', 'Lignes catalogues', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_catalogue_lig', 'pk_produits.creer_ligne_catalogue', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pk_produits.maj_dictionnaire', '23', '1', 'Creation Dictionnaire BDM', 'grdProduits', next value for seq_grille_trf_produits);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PARAMETRES', '22', '1', 'Parametres', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_parametre', 'pk_autres_donnees.maj_parametre', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMMENTAIRES', '22', '1', 'Commentaires', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_commentaire', 'pk_autres_donnees.creer_commentaire', 't_transfertlgpi_commentaire', '1', 'erp.t_commentaire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS', '22', '1', 'Historique clients', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_histo_client', 'pk_autres_donnees.creer_historique_client', 't_transfertlgpi_histo_client', '1', 'erp.t_histo_client_entete', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'LIGNES HISTORIQUES CLIENTS', '22', '1', 'Lignes historiques clients', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_histo_cli_lig', 'pk_autres_donnees.creer_historique_client_ligne', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMMANDES', '22', '1', 'Commandes', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_commande', 'pk_produits.creer_commande', 't_transfertlgpi_commande', '1', 'erp.t_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'LIGNES COMMANDES', '22', '1', 'Lignes de commandes', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_commande_ligne', 'pk_produits.creer_ligne_commande', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pk_produits.maj_commandes', '23', '1', 'Finalisation commandes', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROMOTIONS', '22', '1', 'Promotions', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_promotion', 'pk_promotions.creer_promotion', 't_transfertlgpi_promotion', '0', 'erp.t_promotion', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROMOTIONS AVANTAGES', '22', '1', 'Promotions Avantages', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_promo_avantage', 'pk_promotions.creer_promotion_avantage', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROMOTIONS PRODUITS', '22', '1', 'Promotions Produits', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_promo_produit', 'pk_promotions.creer_promotion_produit', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DOCUMENTS SCANNES', '22', '1', 'Documents scannées', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_document', 'pk_autres_donnees.creer_document', 't_transfertlgpi_document', '1', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pk_autres_donnees.reactive_migration_muse', '23', '1', 'Activation Migration MUSE', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);

-- insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
--values(next value for seq_fct_fichier, 'DOCUMENTS', '22', '1', 'Attestations mutuelles', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
-- insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
--values(next value for seq_transfert_traitement, 'ps_transfertlgpi_doc_scannes', 'pk_autres_donnees.creer_document_client', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pk_autres_donnees.completer_histo_client', '23', '1', 'Syncronisation ventes rotations', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pk_autres_donnees.calc_stat', '23', '1', 'Calc stat', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'OPERATEURS', '22', '1', 'Operateurs', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_operateur', 'pk_autres_donnees.creer_operateur', 't_transfertlgpi_operateur', '0', 'erp.t_operateur where codeoperateur <> ''.''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'VIGNETTES AVANCEES', '22', '1', 'Vignettes avancees', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_vign_avancee', 'pk_encours.creer_vignette_avancee', null, '1', 'erp.t_vignetteavancee', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CREDITS', '22', '1', 'Credits', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_credit', 'pk_encours.creer_credit', 't_transfertlgpi_credit', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRODUITS DUS', '22', '1', 'Produits dus factures', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_produit_du', 'pk_encours.creer_produit_du', ' t_transfertlgpi_produit_du', '0', 'erp.t_produitdu', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRODUITS DUS LIGNES', '22', '1', 'Produits dus lignes', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_produit_du_lig', 'pk_encours.creer_produit_du_ligne', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'FACTURES ATTENTE', '22', '1', 'Factures en attente', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_fact_attente', 'pk_encours.creer_facture_attente', 't_transfertlgpi_fact_attente', '1', 'erp.t_dossierattente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'LIGNES FACTURES ATTENTE', '22', '1', 'Lignes de factures en attente', 'grdEncours', next value for seq_grille_trf_encours);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_fact_att_ligne', 'pk_encours.creer_facture_attente_ligne', null, '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROGRAMMES AVANTAGE', '22', '1', 'Programmes avantage', 'grdProgrammesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_prog_avantage', 'pk_programmes_fidelites.creer_prog_avantage', 't_transfertlgpi_prog_avantage', '0', 'erp.t_cartefi', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROGRAMMES AVANTAGE CLIENTS', '22', '1', 'Programmes avantage clients', 'grdProgrammesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_prog_av_cli', 'pk_programmes_fidelites.creer_prog_avantage_client', null, '0', 'erp.t_cartefi_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROGRAMMES AVANTAGE PRODUITS', '22', '1', 'Programmes avantage produits', 'grdProgrammesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_prog_av_prod', 'pk_programmes_fidelites.creer_prog_avantage_produit', null, '0', 'erp.t_cartefi_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CARTES PROGR RELATIONNEL', '22', '1', 'Cartes du programme relationnel', 'grdProgrammesFidelites', next value for seq_grille_trf_avantages);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertlgpi_carte_prog_rel', 'pk_programmes_fidelites.creer_carte_prog_rel', null, '0', 'erp.t_aad_pfi', gen_id(seq_fct_fichier, 0));
