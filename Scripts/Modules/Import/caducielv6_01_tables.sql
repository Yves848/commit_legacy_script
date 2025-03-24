set sql dialect 3;

/* ********************************************************************************************** */
create table t_caducielv6_traitement(
t_caducielv6_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_caducielv6_traitement primary key(t_caducielv6_traitement_id));

alter table t_caducielv6_traitement
add constraint fk_caducielv6_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_caducielv6_traitement;

/* ********************************************************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'BDCADV6.FDB', '10', '1', 'Base de données Caduciel V6', 'Médecins, Organismes, Clients, Produits, etc ...', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HOPITAUX', '12', '1', 'Hopitaux', 'Hopitaux', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_Hopitaux', 'ps_caducielv6_creer_hopital', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Médecins', 'Médecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_medecins', 'ps_caducielv6_creer_medecin', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DESTINATAIRES', '12', '1', 'Destinataires de télétransmissions', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_destinataires', 'ps_caducielv6_creer_dest', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISMES AMO', '12', '1', 'Organismes AMO', 'Organismes AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_organismes_amo', 'ps_caducielv6_creer_org_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISMES AMC', '12', '1', 'Organismes AMC', 'Organismes AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_organismes_amc', 'ps_caducielv6_creer_org_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COUVERTURES', '12', '1', 'Couvertures AMO et AMC', 'Couvertures AMO et AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_couvertures', 'ps_caducielv6_creer_couverture', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TAUX PRISE EN CHARGE', '12', '1', 'Taux prise en charge', 'Taux prise en charge', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_taux_prise_en_charge', 'ps_caducielv6_creer_taux', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTES', '12', '1', 'Comptes', 'Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_comptes', 'ps_caducielv6_creer_compte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTS', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_clients', 'ps_caducielv6_creer_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PS_CADUCIEL_SP_SANTE', '13', '1', 'Eclatement SP Sante', 'Eclatement SP Sante', 'grdClients', next value for seq_grille_imp_clients);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, null, 'PS_CADUCIEL_SP_SANTE', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LINEAIRES', '12', '1', 'Linéaires', 'Linéaires', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_lineaires', 'ps_caducielv6_creer_lineaire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CATEGORIES', '12', '1', 'Catégories', 'Catégories', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_categories', 'ps_caducielv6_creer_codif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FAMILLES', '12', '1', 'Familles', 'Familles', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_familles', 'ps_caducielv6_creer_codif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs et répartiteurs', 'Fournisseurs et répartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_fournisseurs', 'ps_caducielv6_creer_fournisseur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_produits', 'ps_caducielv6_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODES PRODUITS', '12', '1', 'Codes produits', 'Codes produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_codes_produits', 'ps_caducielv6_creer_code_prod', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODES LPPR', '12', '1', 'Codes LPPR', 'Codes LPPR', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_codes_lppr', 'ps_caducielv6_creer_code_lppr', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES VENTE', '12', '1', 'Historiques vente', 'Historiques vente', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_historiques_vente', 'ps_caducielv6_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'OPERATEURS', '12', '1', 'Opérateurs', 'Opérateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_operateurs', 'ps_caducielv6_creer_operateur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITS CLIENTS', '12', '1', 'Crédits clients', 'Crédits clients', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_credits_clients', 'ps_caducielv6_creer_credit_cli', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITS COMPTES', '12', '1', 'Crédits comptes', 'Crédits comptes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_credits_comptes', 'ps_caducielv6_creer_credit_cpt', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'VIGNETTES AVANCEES', '12', '1', 'Vignettes avancées', 'Vignettes avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_vignettes_avancees', 'ps_caducielv6_creer_avance', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS DUS', '12', '1', 'Produits dus', 'Produits dus', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_produits_dus', 'ps_caducielv6_creer_du', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FACTURES ATTENTE', '12', '1', 'Factures en attente', 'Factures en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_factures_attente', 'ps_caduciel_creer_attente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FACTURES ATTENTE LIGNES', '12', '1', 'Produits dus', 'Factures en attente Lignes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_factures_attente_lignes', 'ps_caduciel_creer_attente_ligne', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCUMENTS SCANNEES', '12', '1', 'Documents scannées', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_documents_scannees', 'ps_caducielv6_creer_document', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS ENTETES', '12', '1', 'Historiques clients entetes', 'Historiques clients entetes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_historiques', 'ps_caducielv6_creer_hist_entete', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS LIGNES', '12', '1', 'Historiques clients lignes', 'Historiques clients lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_historiques_lignes', 'ps_caducielv6_creer_hist_ligne', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES ENTETES', '12', '1', 'Commande entetes', 'Commande entetes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_commandes', 'ps_caducielv6_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES LIGNES', '12', '1', 'Commande lignes', 'Commande lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_caducielv6_traitement (t_caducielv6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_caducielv6_traitement, 'caducielv6_lignes_commandes', 'ps_caducielv6_creer_com_ligne', gen_id(seq_fct_fichier, 0));

/* ********************************************************************************************** */
recreate view v_traitement_1(
    type_fichier,
    libelle,
    grille,
    ligne,
    t_traitement_id,
    requete_selection,
    procedure_creation,
    nom)
as
select
    f.type_fichier,
    f.libelle,
    f.grille,
    f.ligne,
    t.t_caducielv6_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_caducielv6_traitement t
inner join t_fct_fichier f
on t.t_fct_fichier_id = f.t_fct_fichier_id;

/* ********************************************************************************************** */
create global temporary table t_caducielv6_couv_amc_client(
  t_client_id integer not null,
  t_organisme_amc_id integer not null,
  t_couverture_amc_id integer,
  debut_droit_amc date,
  fin_droit_amc date);

create index idx_cad_couv_amc_cli_numero on t_caducielv6_couv_amc_client(t_client_id);
create desc index idx_cad_couv_amc_cli_fin_droit on t_caducielv6_couv_amc_client(fin_droit_amc);

/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));

insert into t_depot ( t_depot_id, libelle, type_depot, automate ) values ( next value for seq_depot , 'AUTOMATE' , 'SUVE', 1);