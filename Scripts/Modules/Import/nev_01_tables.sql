set sql dialect 3;

/* ********************************************************************************************** */
create table t_nev_traitement(
t_nev_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_nev_traitement primary key(t_nev_traitement_id));

alter table t_nev_traitement
add constraint fk_nev_traitement_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_nev_traitement;
/* ************************************************** Fichiers CSV ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af04.csv', '10', '1', 'Table Clients décryuptée', 'Clients', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af25.csv', '10', '1', 'Table 25', 'Table 25', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af05.csv', '10', '1', 'Table Histo Clients détail décryptée', 'Histo client', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af07.csv', '10', '1', 'Table 07', 'Table 07', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af08.csv', '10', '1', 'Table 08', 'Table 08', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af09.csv', '10', '1', 'Table 09', 'Table 09', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af15.csv', '10', '1', 'Table 15', 'Table 15', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af21.csv', '10', '1', 'Table 21', 'Table 21', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af23.csv', '10', '1', 'Table 23', 'Table 23', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af30.csv', '10', '1', 'Table 30', 'Table 30', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af31.csv', '10', '1', 'Table Commandes', 'Commandes', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af32.csv', '10', '1', 'Table Commandes lignes', 'Commandes lignes', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af37.csv', '10', '1', 'Table Produits dus', 'Produits dus', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af50.csv', '10', '1', 'Table 50', 'Table 50', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afalfam.csv', '10', '1', 'Table ALFAM', 'Table ALFAM', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afb1.csv', '10', '1', 'Table B1', 'Table B1', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afb1cod.csv', '10', '1', 'Table B1 codes', 'Table B1 codes', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afb5.csv', '10', '1', 'Table B5', 'Table B5', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afcgeo.csv', '10', '1', 'Table Geo', 'Table Geo', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afconta.csv', '10', '1', 'Table Conta', 'Table Conta', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'aff5.csv', '10', '1', 'Catalogues produits', 'Catalogues produits', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'aff81lp.csv', '10', '1', 'Table 81lp', 'Table 81lp', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'aff82ps.csv', '10', '1', 'Table 82ps', 'Table 82ps', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afnota.csv', '10', '1', 'Table Nota', 'Table nota', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afnotap.csv', '10', '1', 'Table Notap', 'Table notap', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afsass.csv', '10', '1', 'Table Sass', 'Table sass', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afsben.csv', '10', '1', 'Table Ben', 'Table Ben', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afztab.csv', '10', '1', 'Table Ztab', 'Table Ztab', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'cff24.csv', '10', '1', 'Table cff24', 'Table cff24', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'cff26.csv', '10', '1', 'Table cff26', 'Table cff26', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'cff27.csv', '10', '1', 'Table cff27', 'Table cff27', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'fidrxcartes.csv', '10', '1', 'Programme relationnel', 'Programme relationnel', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'afpsdic.csv', '10', '1', 'Documents scannés', 'Documents scannés', null, next value for seq_grille_imp_fichiers);


/* ************************************************** Praticiens ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_praticiens', 'ps_nev_creer_praticien', gen_id(seq_fct_fichier, 0));
 
/* ************************************************** Organismes ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Destinataires', '12', '0', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_destinataires', 'ps_nev_creer_destinataire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Organismes', '12', '0', 'Organismes', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_organismes', 'ps_nev_creer_organisme', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Contrats', '12', '0', 'Contrats', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_contrats', 'ps_nev_creer_contrat', gen_id(seq_fct_fichier, 0));

/* ************************************************** Clients ***************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients et Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_clients', 'ps_nev_creer_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Liaisons', '12', '0', 'Liaisons Collectivités Adhérents', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_clients_liaisons', 'ps_nev_creer_client_liaison', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Contrats clients', '12', '0', 'Contrats clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_clients_contrats', 'ps_nev_creer_client_contrat', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Maj Org clients', '12', '1', 'Maj Organismes clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_clients_maj_organismes', 'ps_nev_maj_org_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Maj Couv clients', '12', '1', 'Maj Couvertures clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_clients_maj_couvertures', 'ps_nev_maj_couv_client', gen_id(seq_fct_fichier, 0));

/* ************************************************** Produits ***************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Fournisseurs - Répartiteurs', '12', '0', 'Fournisseurs Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_fournisseurs', 'ps_nev_creer_fournisseur', gen_id(seq_fct_fichier, 0));

-- Pas maintenu
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'RESFAM.D', '11', '1', 'Familles issues de la base "Claude Bernard"', 'Familles BCB', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Familles Internes', '12', '0', 'Familles Internes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_produits_familles', 'ps_nev_creer_famille', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Zones Geo', '12', '0', 'Zones Geo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_zones_geo', 'ps_nev_creer_zone_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_produits', 'ps_nev_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Stocks', '12', '0', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_produits_stocks', 'ps_nev_creer_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Codes Produits', '12', '0', 'Codes Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_produits_codes', 'ps_nev_creer_produit_code', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Histo Ventes', '12', '0', 'Histo Ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_produits_histo_ventes', 'ps_nev_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Produits - Lpp', '12', '0', 'Produits - Lpp', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_produits_lpp', 'ps_nev_creer_produits_lpp', gen_id(seq_fct_fichier, 0));

-- Pas sure que ça serve encore ....
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'A_FLSPRO.D', '11', '1', 'MAJ Zone Géo Produits', 'MAJ Zone Géo Produits', 'grdProduits', next value for seq_grille_imp_produits);

/* ************************************************** Encours ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Vignettes Avancées', '12', '0', 'Vignettes Avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_encours_vignettes_av', 'ps_nev_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Produits Dus', '12', '0', 'Produits Dus', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_encours_produits_dus', 'ps_nev_creer_produit_du', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Credits', '12', '0', 'Crédits Clients', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_encours_credits', 'ps_nev_creer_credit', gen_id(seq_fct_fichier, 0));
-- insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
-- values(next value for seq_fct_fichier, 'Factures en attente', '12', '0', 'Factures en attente', 'grdEncours', next value for seq_grille_imp_encours);
-- insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
-- values (next value for seq_nev_traitement, 'nev_encours_factures_attente', 'ps_nev_creer_fact_att', gen_id(seq_fct_fichier, 0));

/* ************************************************** Autres données  ******************************************* */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Opérateurs', '12', '0', 'Opérateurs', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_operateurs', 'ps_nev_creer_operateur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historique délivrances entêtes', '12', '0', 'Historique délivrances entêtes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_histo_entetes', 'ps_nev_creer_histo_ent', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historique délivrances lignes', '12', '0', 'Historique délivrances lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_histo_lignes', 'ps_nev_creer_histo_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Commandes', '12', '0', 'Commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_commandes', 'ps_nev_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Commandes lignes', '12', '0', 'Commandes lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_commandes_lignes', 'ps_nev_creer_comm_ligne', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Catalogues fournisseurs', '12', '0', 'Catalogues fournisseurs', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_catalogues', 'ps_nev_creer_catalogue', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Catalogues fourn - Prod', '12', '0', 'Catalogues fournisseurs - Produits', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_catalogues_produits', 'ps_nev_creer_catalogue_prod', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Documents scannés', '12', '0', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_documents', 'ps_nev_creer_document', gen_id(seq_fct_fichier, 0));

/* ************************************************** Progammes Fidélités   ******************************************* */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Cartes Programmes Relationnels', '12', '0', 'Cartes Programmes Relationnels', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_nev_traitement (t_nev_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_nev_traitement, 'nev_carte_prog_relationnel', 'ps_nev_creer_carte_prog_rel', gen_id(seq_fct_fichier, 0));

/* ************************************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));

/* ************************************************************************************************************** */
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
    t.t_nev_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_nev_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';

/* ************************************************************************************************************** */
/* pas besoin des triggers de creation de catalogue puisqu'un traitement le fait */
alter trigger trg_cmd_creation_catalogue inactive;
alter trigger trg_cmdlig_creation_lig_cat inactive;