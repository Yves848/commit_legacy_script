set sql dialect 3;

/* ********************************************************************************************* */
create table t_leo2_garantie_primaire(
  cge_id varchar(38),
  gpr_id varchar(38),
  t_couverture_amo_id varchar(50),
  gpp_codecouverture char(5),
  constraint pk_leo2_garantie_primaire primary key(t_couverture_amo_id));

alter table t_leo2_garantie_primaire
add constraint fk_leo2_gp_couverture_amo foreign key(t_couverture_amo_id)
references t_couverture_amo(t_couverture_amo_id)
on delete cascade;

create unique index unq_leo2_garantie_primaire on t_leo2_garantie_primaire(cge_id, gpr_id, gpp_codecouverture);

create sequence seq_leo2_garantie_primaire;

/* ********************************************************************************************* */
create table t_leo2_garantie_complementaire(
  cgc_id varchar(38),
  gco_id varchar(38),
  t_couverture_amc_id varchar(50),
  constraint pk_leo2_garantie_complementaire primary key(t_couverture_amc_id));

alter table t_leo2_garantie_complementaire
add constraint fk_leo2_gp_couverture_amc foreign key(t_couverture_amc_id)
references t_couverture_amc(t_couverture_amc_id)
on delete cascade;

create unique index unq_garantie_complementaire on t_leo2_garantie_complementaire(cgc_id, gco_id);

create sequence seq_leo2_garantie_compl;

/* ********************************************************************************************** */
create table t_leo2_traitement(
t_leo2_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_leo2_traitement primary key(t_leo2_traitement_id));

alter table t_leo2_traitement
add constraint fk_leo2_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_leo2_traitement;

/* ********************************************************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'leo2_data.mdf', '10', '0', 'Base de données leo2, non obligatoire si le serveur SQL connait les fichiers', 'Base de données leo2', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ETABLISSEMENTS', '12', '1', 'Etablissements', 'Etablissements', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_etablissements', 'ps_leo2_creer_etablissement', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRESCRIPTEURS', '12', '1', 'Prescripteurs', 'Prescripteurs', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_prescripteurs', 'ps_leo2_creer_prescripteur', gen_id(seq_fct_fichier, 0));

/* ********************************************************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DESTINATAIRES', '12', '1', 'Destinataires de télétransmissions', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_destinataires', 'ps_leo2_creer_destinataire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CAISSES PRIMAIRES', '12', '1', 'Caisses primaires', 'Caisses primaires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_caisses_primaires', 'ps_leo2_creer_caisse_primaire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CAISSES COMPLEMENTAIRES', '12', '1', 'Caisses complémentaires', 'Caisses complémentaires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_caisses_complementaires', 'ps_leo2_creer_caisse_comp', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'GARANTIES COMPLEMENTAIRES', '12', '1', 'Garanties complémentaires', 'Garanties complémentaires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_garanties_complementaires', 'ps_leo2_creer_garantie_comp', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'EXCEPTIONS TAUX COMPLEMENTAIRES', '12', '1', 'Exceptions taux complémentaires', 'Exceptions taux complémentaires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_exceptions_taux_complementaires', 'ps_leo2_maj_taux_comp', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ps_leo2_maj_destinataire', '13', '1', 'Forcer destinataire par défaut', 'Forcer destinataire par défaut', 'grdOrganismes', next value for seq_grille_imp_organismes);

/* ********************************************************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMPTES', '12', '1', 'Clients professionnels', 'Clients professionnels', 'grdClients', next value for seq_grille_imp_clients);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_comptes', 'ps_leo2_creer_compte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CLIENTS', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_clients', 'ps_leo2_creer_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'GARANTIES PRIMAIRES PATIENTS', '12', '1', 'Garanties primaires clients', 'Garanties primaires clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_garanties_primaires_patients', 'ps_leo2_creer_gar_prim_patient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'GARANTIES COMPLEMENTAIRES PATIENTS', '12', '1', 'Garanties complémentaires clients', 'Garanties complémentaires clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_garanties_complementaires_patients', 'ps_leo2_creer_gar_comp_patient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROG RELATIONNELS', '12', '1', 'Programmes relationnels', 'Programmes relationnels', 'grdClients', next value for seq_grille_imp_clients);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_prog_relationnels', 'ps_leo2_creer_prog_relationnel', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'ZONES GEOGRAPHIQUES', '12', '1', 'Zones géographiques', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_zones_geographiques', 'ps_leo2_creer_zone_geographique', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_fournisseurs', 'ps_leo2_creer_fournisseur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DEPOTS', '12', '1', 'Dépôts', 'Dépôts', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_lieux_stockage', 'ps_leo2_creer_depot', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_produits', 'ps_leo2_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMMENTAIRES PRODUITS', '12', '1', 'Commentaires produits', 'Commentaires produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_comm_produits', 'ps_leo2_creer_comm_produits', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'STOCKS', '12', '1', 'Stocks', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_stocks', 'ps_leo2_creer_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CODES LPP', '12', '1', 'Codes LPP', 'Codes LPP', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_codes_lpp', 'ps_leo2_creer_code_lpp', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HISTORIQUES VENTES', '12', '1', 'Historiques ventes', 'Historiques ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_historiques_ventes', 'ps_leo2_creer_historique_vente', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCUMENTS SCANNEES', '12', '1', 'Attestations mutuelles', 'Attestations mutuelles', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
--insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_leo2_traitement, 'leo2_documents_scannees', 'ps_leo2_creer_doc_scannee', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS', '12', '1', 'Historiques clients', 'Historiques clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_historiques_clients', 'ps_leo2_creer_historique_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS LIGNES', '12', '1', 'Historiques clients lignes', 'Historiques clients lignes','grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_historiques_clients_lignes', 'ps_leo2_creer_hist_client_ligne', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMMANDES', '12', '1', 'Commandes', 'Commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_commandes', 'ps_leo2_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'COMMANDES LIGNES', '12', '1', 'Lignes de commandes', 'Lignes de commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_lignes_commandes', 'ps_leo2_creer_ligne_commande', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CATALOGUES', '12', '1', 'Références fournisseurs', 'Références fournisseurs', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
--insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_leo2_traitement, 'leo2_catalogues', 'ps_leo2_creer_catalogue', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'UTILISATEURS', '12', '1', 'Utilisateurs', 'Utilisateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_utilisateurs', 'ps_leo2_creer_utilisateur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CREDITS', '12', '1', 'Crédits', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_credits', 'ps_leo2_creer_credit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'VIGNETTES AVANCEES', '12', '1', 'Vignettes avancées', 'Vignettes avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_vignettes_avancees', 'ps_leo2_creer_vignette_avancee', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRODUITS DUS', '12', '1', 'Produits dus', 'Produits dus', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_leo2_traitement (t_leo2_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_leo2_traitement, 'leo2_produits_dus', 'ps_leo2_creer_produit_du', gen_id(seq_fct_fichier, 0));

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
    t.t_leo2_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_leo2_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';
/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));

delete from t_depot; --parce qu'on a une reprise des depot dans le module  