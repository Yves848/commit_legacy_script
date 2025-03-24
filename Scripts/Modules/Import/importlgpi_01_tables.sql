set sql dialect 3;

/* ********************************************************************************************** */
create table t_importlgpi_traitement(
t_importlgpi_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_importlgpi_traitement primary key(t_importlgpi_traitement_id));

alter table t_importlgpi_traitement
add constraint fk_importlgpi_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_importlgpi_traitement;

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Hopitaux', '12', '0', 'Hopitaux', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_hopital', 'ps_importlgpi_creer_hopital', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_praticien', 'ps_importlgpi_creer_praticien', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Destinataires', '12', '0', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_destinataire', 'ps_importlgpi_creer_dest', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes', '12', '0', 'Organismes', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_organisme', 'ps_importlgpi_creer_organisme', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Associations AMO AMC', '12', '0', 'Associations AMO AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_association_amo_amc', 'ps_importlgpi_ass_org_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '0', 'Couvertures AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_couverture_amo', 'ps_importlgpi_creer_couv_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '0', 'Couvertures AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_couverture_amc', 'ps_importlgpi_creer_couv_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Taux de prise en charge', '12', '0', 'Taux de prise en charge', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_taux_pc', 'ps_importlgpi_creer_taux_pc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_client', 'ps_importlgpi_creer_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Adhérent comptes', '12', '0', 'Adhérent comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_compte_client', 'ps_importlgpi_creer_cpt_cli', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures clients', '12', '0', 'Couvertures clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_couverture_amo_client', 'ps_importlgpi_creer_couv_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Commentaires clients', '12', '0', 'Commentaires clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_commentaire', 'ps_importlgpi_creer_commentaire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Mandataires', '12', '0', 'Mandataires', 'grdClients', next value for seq_grille_imp_clients);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_mandataire', 'ps_importlgpi_creer_mandataire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs directs', '12', '0', 'Fournisseurs directs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_fourn_direct', 'ps_importlgpi_creer_fourn_dir', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Répartiteurs', '12', '0', 'Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_repartiteur', 'ps_importlgpi_creer_repartiteur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Répartiteurs manquants', '12', '0', 'Repartiteurs pour les produits manquants', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_repartiteur_manquants', 'ps_importlgpi_maj_repartiteur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Codifications', '12', '0', 'Codifications', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_codification', 'ps_importlgpi_creer_codif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Classifications internes', '12', '0', 'Classifications internes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_classif_interne', 'ps_importlgpi_creer_cl_int', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Depots', '12', '0', 'Depots', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_depot', 'ps_importlgpi_creer_depot', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Zones géographiques', '12', '0', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_zone_geo', 'ps_importlgpi_creer_zone_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_produit', 'ps_importlgpi_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Stocks secondaires', '12', '0', 'Stocks secondaires', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_info_stock', 'ps_importlgpi_creer_info_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Codes Ean13', '12', '0', 'Codes Ean13', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_code_ean13', 'ps_importlgpi_creer_code_ean13', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Codes LPP', '12', '0', 'Codes LPP', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_code_lpp', 'ps_importlgpi_creer_code_lpp', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques ventes', '12', '0', 'Historiques de ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_historique_ventes', 'ps_importlgpi_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Catalogues', '12', '0', 'Catalogues', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_catalogue', 'ps_importlgpi_creer_catalogue', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Classifications fournisseurs', '12', '0', 'Classifications fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_classif_fournisseur', 'ps_importlgpi_creer_cl_four', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lignes catalogues', '12', '0', 'Lignes catalogues', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_ligne_catalogue', 'ps_importlgpi_creer_lig_catal', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques délivrances entêtes', '12', '0', 'Historique délivrances entêtes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_histo_client', 'ps_importlgpi_creer_histo_cli', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques délivrances lignes', '12', '0', 'Historique délivrances lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_histo_client_ligne', 'ps_importlgpi_creer_his_cli_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique achats entêtes', '12', '0', 'Historique achats entêtes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_histo_achats', 'ps_importlgpi_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique achats lignes', '12', '0', 'Historique achats lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_histo_achats_ligne', 'ps_importlgpi_creer_cmd_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Attestations mutuelles', '12', '0', 'Attestations mutuelles', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_documents_mut', 'ps_importlgpi_creer_doc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Scans Ordonnances', '12', '0', 'Scans Ordonnances', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_documents_ord', 'ps_importlgpi_creer_doc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Attestations mutuelles MUSE', '12', '0', 'Attestations mutuelles MUSE', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_documents_mut_muse', 'ps_importlgpi_creer_doc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Scans Ordonnances MUSE', '12', '0', 'Scans Ordonnances MUSE', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_documents_ord_muse', 'ps_importlgpi_creer_doc', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Opérateurs', '12', '0', 'Opérateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_operateur', 'ps_importlgpi_creer_operateur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Crédits', '12', '0', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_credit', 'ps_importlgpi_creer_credit', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente entetes', '1', '0', 'Factures en attente entetes', 'grdEncours', next value for seq_grille_imp_encours);
--insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_facture_attente', 'ps_importlgpi_creer_fac_att', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente lignes', '1', '0', 'Factures en attente lignes', 'grdEncours', next value for seq_grille_imp_encours);
--insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_facture_attente_lig', 'ps_importlgpi_creer_fac_att_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Vignettes avancées', '12', '0', 'Vignettes avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_vignette_avancee', 'ps_importlgpi_creer_vign_av', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits dus', '1', '0', 'Produit dus', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
--insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_produit_du', 'ps_importlgpi_creer_produit_du', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Programmes relationnels', '12', '0', 'Programmes relationnels', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_importlgpi_traitement (t_importlgpi_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_importlgpi_traitement, 'importlgpi_prog_relationnel', 'ps_importlgpi_creer_prog_rel', gen_id(seq_fct_fichier, 0));


/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));


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
    t.t_importlgpi_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_importlgpi_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;
