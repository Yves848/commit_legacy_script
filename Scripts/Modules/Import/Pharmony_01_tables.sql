set sql dialect 3;

/*grdPraticiens*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'prescribers.csv', '11', '1', 'Praticiens', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);

/* grdClients*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'collectivities.csv', '11', '1', 'Collectivités', 'Collectivités', 'grdClients', next value for seq_grille_imp_clients);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'patients.csv', '11', '1', 'Patients', 'Patients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'invoice_relationships.csv', '11', '1', 'Liens', 'Liens patiens collectivités', 'grdClients', next value for seq_grille_imp_clients);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'fidelity_profiles.csv', '11', '1', 'Profils de remise', 'Profils de remise', 'grdClients', next value for seq_grille_imp_clients);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'fidelity_accounts.csv', '11', '1', 'Comptes fidélités', 'Comptes fidélités', 'grdClients', next value for seq_grille_imp_clients);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'fidelity_cards.csv', '11', '1', 'Cartes fidélités', 'Cartes fidélités', 'grdClients', next value for seq_grille_imp_clients);

/*grdProduits*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'storage_spaces.csv', '11', '1', 'Dépots', 'Dépots', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'storage_locations.csv', '11', '1', 'Zone géographiques', 'Zone géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'products.csv', '11', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'product_stocks.csv', '11', '1', 'Stocks', 'Stocks Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'schema.csv', '11', '1', 'Schémas de médication', 'Schémas de médication entête', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'schemadetail.csv', '11', '1', 'Schémas de médication', 'Schémas de médication détail', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'suppliers.csv', '11', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'product_codes.csv', '11', '1', 'Codes-Barres', 'Codes-Barres', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Analyses.csv', '11', '1', 'Analyses Chimiques', 'Analyses Chimiques', 'grdProduits', next value for seq_grille_imp_produits);

/*grdAutresDonnees*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'history_products.csv', '11', '1', 'Historiques produits', 'Historiques de vente produits', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'pending_documents.csv', '11', '1', 'Litiges', 'Litiges', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'history_patients.csv', '11', '1', 'Historiques patients', 'Historiques patients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'preparations.csv', '11', '1', 'Formules magistrales', 'Formules magistrales', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
