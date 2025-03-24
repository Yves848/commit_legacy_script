set sql dialect 3;

/* ********************************************************************************************** */
create table t_winpharma_traitement(
t_winpharma_traitement_id dm_cle not null,
champ_facteur_decoupage dm_varchar150,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_winpharma_traitement primary key(t_winpharma_traitement_id));

alter table t_winpharma_traitement
add constraint fk_winpharma_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;
create table t_winpharma_com_cli(

t_commentaire_id dm_code not null,
t_client_id dm_code not null,
constraint pk_winpharma_com_cli primary key(t_commentaire_id,t_client_id));

alter table t_winpharma_com_cli
add constraint fk_winpharma_cli_com foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

create table t_winpharma_fac_cli(
numero_facture dm_code not null,
t_client_id dm_code not null,
constraint pk_winpharma_fac_cli primary key(numero_facture));

alter table t_winpharma_fac_cli
add constraint fk_winpharma_cli_fac foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

create sequence seq_winpharma_traitement;

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
--values(next value for seq_fct_fichier, 'BLOBBINI.MB', '10', '0','Documents TIFF Clients', null, next value for seq_grille_imp_fichiers);
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
--values(next value for seq_fct_fichier, 'BLOBBINJ.MB', '10', '0','Documents TIFF Clients (suite)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Hopitaux', '12', '0', 'Hopitaux', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id) 	
values (next value for seq_winpharma_traitement, 'wp_mysql_hopital', 'Code', 'ps_wp_creer_medecin', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id) 	
values (next value for seq_winpharma_traitement, 'wp_mysql_medecin', 'med.Code', 'ps_wp_creer_medecin', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 	
values(next value for seq_fct_fichier, 'Organismes AMO', '12', '0', 'Organismes AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_organisme_amo', 'ps_wp_creer_organisme_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Organismes AMC', '12', '0', 'Organismes AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_organisme_amc', 'ps_wp_creer_organisme_amc', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Couvertures', '12', '0', 'Couvertures', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_couverture', 'ps_wp_creer_couverture', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '0', 'Couvertures AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_couverture_amo', 'ps_wp_creer_couverture_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '0', 'Couvertures AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_couverture_amc', 'ps_wp_creer_couverture_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Clients Assures', '12', '0', 'Clients Assures', 'grdClients', next value for seq_grille_imp_clients);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_assure', 'cli.ti', 'ps_wp_creer_assure', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Clients Beneficiaires', '12', '0', 'Clients Beneficiaires', 'grdClients', next value for seq_grille_imp_clients);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_benef', 'cli.ti', 'ps_wp_creer_benef', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Clients Comptes', '12', '0', 'Clients Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_compte', 'ps_wp_creer_compte_collec', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Clients Comptes adherents', '12', '0', 'Clients Comptes adherents', 'grdClients', next value for seq_grille_imp_clients);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_compte_adh', 'ps_wp_creer_compte_adh', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Commentaires', '12', '0', 'Commentaires', 'grdClients', next value for seq_grille_imp_clients);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_winpharma_traitement, 'wp_mysql_commentaire', 'ps_wp_creer_commentaire', gen_id(seq_fct_fichier, 0));
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
--values(next value for seq_fct_fichier, 'Mandataires', '12', '0', 'Mandataires', 'grdClients', next value for seq_grille_imp_clients);
--insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
--values (next value for seq_winpharma_traitement, 'wp_mysql_mandataire', 'ps_wp_creer_mandataire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Dépots', '12', '0', 'Dépots Zones de Stockage ', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_depot', 'ps_wp_creer_depot', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Prestations', '12', '0', 'Prestations', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_prestation', 'ps_wp_creer_prestation', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Répartiteurs', '12', '0', 'Répartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_repartiteur', 'ps_wp_creer_repartiteur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Fournisseurs', '12', '0', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_fournisseur', 'fou.Code', 'ps_wp_creer_fournisseur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Zones géographiques', '12', '0', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_zonegeo', 'ps_wp_creer_zonegeo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_produit', 'prd.cip', 'ps_wp_creer_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Stocks', '12', '0', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection,  procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_stock', 'ps_wp_creer_stock', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Codifications', '12', '0', 'Codifications', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_codification', 'ps_wp_creer_codif', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Codifications produits', '12', '0', 'Codifications produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_codif_produit', 'ps_wp_creer_codif_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Codes LPP', '12', '0', 'Codes LPP', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_code_lpp', 'ps_wp_creer_code_lpp', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Codes EAN13', '12', '0', 'Codes EAN13', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_code_ean13', 'ps_wp_creer_code_ean13', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historiques ventes', '12', '0', 'Historiques ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_historique_vente', 'histo.cip', 'ps_wp_creer_historique_vente', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Catalogues', '12', '0', 'Catalogues', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection,procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_catalogue', 'ps_wp_creer_catalogue', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Opérateurs', '12', '0', 'Opérateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_operateur', 'ps_wp_creer_operateur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Vignettes Avancées', '12', '0', 'Vignettes Avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_avance_v', 'ps_wp_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Factures en attente', '12', '0', 'Factures en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_fact_att', 'ps_wp_creer_fact_att', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Factures en attente lignes', '12', '0', 'Factures en attente lignes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_fact_att_ligne', 'ps_wp_creer_fact_att_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Produits dus', '12', '0', 'Produits dus', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_produit_du', 'ps_wp_creer_produit_du', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Historiques délivrances entêtes', '12', '0', 'Historiques délivrances entêtes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_historique_client', 'ti', 'ps_wp_creer_historique_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Historiques délivrances lignes', '12', '0', 'Historiques délivrances lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, champ_facteur_decoupage, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_histo_client_ligne', 'order_ti', 'ps_wp_creer_histo_client_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CREDITS.TXT', '11', '1', 'Crédits Clients', 'Crédits Clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'CREDITS_COMPTES.TXT', '11', '1', 'Crédits Comptes', 'Crédits Comptes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Commandes', '12', '0', 'Commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_commande', 'ps_wp_creer_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Commandes lignes', '12', '0', 'Commandes lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_commande_ligne', 'ps_wp_creer_commande_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Commandes lignes groupe', '12', '0', 'Commandes lignes groupe', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_commande_groupe', 'ps_wp_maj_ligne_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Programmes Avantages', '12', '0', 'Programmes Avantages', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_prog_avantage', 'ps_wp_creer_programme_avantage', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Cartes Programme Relationnel', '12', '0', 'Cartes Programme Relationnel', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_prog_relationnel', 'ps_wp_creer_carte_prog_rel', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)	
values(next value for seq_fct_fichier, 'Documents scannés', '12', '0', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_winpharma_traitement (t_winpharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id)	
values (next value for seq_winpharma_traitement, 'wp_mysql_documents_tiff', 'ps_wp_creer_document', gen_id(seq_fct_fichier, 0));

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
    nom,
    champ_facteur_decoupage)
as
select
  f.type_fichier,
  f.libelle,
  f.grille,
  f.ligne,
  t.t_winpharma_traitement_id,
  t.requete_selection || '.sql',
  t.procedure_creation,
  f.nom,
  t.CHAMP_FACTEUR_DECOUPAGE
from
  t_fct_fichier f
  left join t_winpharma_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where
  f.type_fichier like '1%';

create table t_wp_prestation (
    t_prestation_wp_id  varchar(50) not null,
    t_prestation_id     integer not null,
    libelle             varchar(50),
    vignette            smallint not null,
	  coef				        float
);

alter table t_wp_prestation add constraint pk_wp_prestation primary key (t_prestation_wp_id,vignette);
alter table t_wp_prestation add constraint fk_t_wp_prestation_1 foreign key (t_prestation_id) references t_ref_prestation (t_ref_prestation_id);

create table t_wp_couverture_sesam (
    t_couverture_id  varchar(50) not null,
    code_sesam       varchar(5) not null
);

alter table t_wp_couverture_sesam add constraint pk_t_wp_couverture_sesam primary key (t_couverture_id);

insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1001', '00100');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1002', '10100');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1003', '00102');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1004', '00101');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1005', '00103');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1006', '00300');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1009', '00104');
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1010', '00400');

insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1015', '00105'); -- CV ALSACE
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1016', '01000'); -- CV CRPCEN
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1017', '00400'); -- CV 100%	( sncf )

insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1021', '00206'); -- CV ALSACE+INV ( Agri)		
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1024', '00206');	
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1025', '00700'); -- CV 100% SNCF MINES

insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1032', '00107'); -- CV ALSACE+GROSS	
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1034', '10105'); -- CV ALSACE+ALD	
--insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1035', '00105'); -- CV MATERNITE

insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1041', '00404'); -- CV 100% ou A115
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1043', '00205'); -- CV ALSACE/AGR
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1044', '00106'); -- CV ALSACE+INV 		
insert into t_wp_couverture_sesam (t_couverture_id, code_sesam) values ('1046', '00207'); -- CV ALSACE+GROSS 		
	
create table t_wp_categorie(
  t_categorie_id integer not null,
  t_categorie_parent_id integer,
  code varchar(10),
  libelle varchar(64),
  type_categorie char(1), /* 0->INTERNE, 1->GAMME FOURNISSEUR, 2->GENERIQUES, 3->GESTION MARGE, 4->LIBRE */
  constraint pk_wp_categorie primary key(t_categorie_id)); 