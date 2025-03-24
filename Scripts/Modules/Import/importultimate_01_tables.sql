set sql dialect 3;

/* ********************************************************************************************** */
create table t_importultimate_traitement(
t_importultimate_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_importultimate_traitement primary key(t_importultimate_traitement_id));

alter table t_importultimate_traitement
add constraint fk_importultimate_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_importultimate_traitement;


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_praticien', 'ps_importulti_creer_praticien', gen_id(seq_fct_fichier, 0));
/*
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Destinataires', '12', '0', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_destinataire', 'ps_importultimate_creer_dest', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes', '12', '0', 'Organismes', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_organisme', 'ps_importultimate_creer_organisme', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Associations AMO AMC', '12', '0', 'Associations AMO AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_association_amo_amc', 'ps_importultimate_ass_org_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '0', 'Couvertures AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_couverture_amo', 'ps_importultimate_creer_couv_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '0', 'Couvertures AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_couverture_amc', 'ps_importultimate_creer_couv_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Taux de prise en charge', '12', '0', 'Taux de prise en charge', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_taux_pc', 'ps_importultimate_creer_taux_pc', gen_id(seq_fct_fichier, 0));
*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients - Patients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_client', 'ps_importultimate_creer_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Etats pathologies', '12', '0', 'Etats pathologies', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_etat_pathologique', 'ps_importulti_creer_etat_patho', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Allergies ATC', '12', '0', 'Allergies ATC', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_allergie_atc', 'ps_importulti_creer_all_atc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Comptes Ristournes', '12', '0', 'Comptes Ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_compte', 'ps_importulti_creer_compte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Cartes Ristournes', '12', '0', 'Cartes Ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_carte', 'ps_importulti_creer_carte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Transactions Ristournes', '12', '0', 'Transactions Ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_transaction', 'ps_importulti_creer_transaction', gen_id(seq_fct_fichier, 0));

/*
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs directs', '12', '0', 'Fournisseurs directs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_fourn_direct', 'ps_importultimate_creer_fourn_dir', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Répartiteurs', '12', '0', 'Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_repartiteur', 'ps_importultimate_creer_repartiteur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Répartiteurs manquants', '12', '0', 'Repartiteurs pour les produits manquants', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_repartiteur_manquants', 'ps_importultimate_maj_repartiteur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Codifications', '12', '0', 'Codifications', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_codification', 'ps_importultimate_creer_codif', gen_id(seq_fct_fichier, 0));
*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Depots', '12', '0', 'Depots', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_depot', 'ps_importulti_creer_depot', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Zones géographiques', '12', '0', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_zonegeo', 'ps_importultimate_creer_zonegeo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_produit', 'ps_importultimate_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Stocks', '12', '0', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_stock', 'ps_importulti_creer_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Codes Ean13', '12', '0', 'Codes Ean13', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_codebarre', 'ps_importultimate_creer_ean13', gen_id(seq_fct_fichier, 0));
/*
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Codes LPP', '12', '0', 'Codes LPP', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_code_lpp', 'ps_importultimate_creer_code_lpp', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques ventes', '12', '0', 'Historiques de ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_historique_ventes', 'ps_importultimate_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Tarifs', '12', '0', 'Tarifs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_tarif', 'ps_importultimate_creer_tarif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Catalogues', '12', '0', 'Catalogues', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_catalogue', 'ps_importultimate_creer_catalogue', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Classifications fournisseurs', '12', '0', 'Classifications fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_classif_fournisseur', 'ps_importultimate_creer_cl_four', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lignes catalogues', '12', '0', 'Lignes catalogues', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_ligne_catalogue', 'ps_importultimate_creer_lig_catal', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique achats entêtes', '12', '0', 'Historique achats entêtes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_histo_achats', 'ps_importultimate_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique achats lignes', '12', '0', 'Historique achats lignes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_histo_achats_ligne', 'ps_importultimate_creer_cmd_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Opérateurs', '12', '0', 'Opérateurs', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_operateur', 'ps_importultimate_creer_operateur', gen_id(seq_fct_fichier, 0));
*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques délivrances entêtes', '12', '0', 'Historique délivrances entêtes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_histo_client', 'ps_importulti_creer_histo_cli', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques délivrances lignes', '12', '0', 'Historique délivrances lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_histo_client_ligne', 'ps_importulti_creer_his_cli_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques délivrances magistrales', '12', '0', 'Historique délivrances magistrales', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_histo_client_mag', 'ps_importulti_creer_his_cli_mag', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Attestations patients', '12', '0', 'Attestations patients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_attestation', 'ps_importulti_creer_attestation', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Crédits', '12', '0', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_credit', 'ps_importulti_creer_credit', gen_id(seq_fct_fichier, 0));
/*
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente entetes', '1', '0', 'Factures en attente entetes', 'grdEncours', next value for seq_grille_imp_encours);
--insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_facture_attente', 'ps_importultimate_creer_fac_att', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente lignes', '1', '0', 'Factures en attente lignes', 'grdEncours', next value for seq_grille_imp_encours);
--insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_facture_attente_lig', 'ps_importultimate_creer_fac_att_lig', gen_id(seq_fct_fichier, 0));
*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Avances', '12', '0', 'Avances', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_avance', 'ps_importulti_creer_avance', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Délivrances différées', '12', '0', 'Délivrances différées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_delivrance_differee', 'ps_importulti_creer_del_diff', gen_id(seq_fct_fichier, 0));
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits dus', '1', '0', 'Produit dus', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
--insert into t_importultimate_traitement (t_importultimate_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importultimate_traitement, 'importultimate_produit_du', 'ps_importultimate_creer_produit_du', gen_id(seq_fct_fichier, 0));

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
    t.t_importultimate_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_importultimate_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;
