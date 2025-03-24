set sql dialect 3;

/* ********************************************************************************************** */
create table t_pharmalandv7_tva(
  code integer not null,
  valeur dm_tva not null,
  constraint pk_pharmalandv7_tva primary key(code));

create index idx_pharmalandv7_valeur on t_pharmalandv7_tva(valeur);

/* ********************************************************************************************** */
create table t_pharmalandv7_traitement(
t_pharmalandv7_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_pharmalandv7_traitement primary key(t_pharmalandv7_traitement_id));

alter table t_pharmalandv7_traitement
add constraint fk_pharmalandv7_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_pharmalandv7_traitement;
insert into t_depot ( t_depot_id, libelle, type_depot, automate ) values ( next value for seq_depot , 'AUTOMATE' , 'SUVE', 1);

/* ********************************************************************************************** */
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARML.exe', '10', '0', 'Programme Pharmaland', 'Programme Pharmaland', null, next value for seq_grille_imp_fichiers);
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARML.wdd', '10', '1', 'Fichier analyse', 'Fichiers analyse', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECIN.FIC', '10', '1', 'Hôpitaux et Praticiens (données)', 'Hôpitaux et Praticiens (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECIN.MMO', '10', '1', 'Hôpitaux et Praticiens (memo)', 'Hôpitaux et Praticiens (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECIN.NDX', '10', '1', 'Hôpitaux et Praticiens (index)', 'Hôpitaux et Praticiens (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CENTRE.FIC', '10', '1', 'Organismes AMO et AMC (données)', 'Organismes AMO et AMC (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CENTRE.MMO', '10', '1', 'Organismes AMO et AMC (memo)', 'Organismes AMO et AMC (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CENTRE.NDX', '10', '1', 'Organismes AMO et AMC (index)', 'Organismes AMO et AMC (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SVSITU.FIC', '10', '1', 'Couvertures AMC (données)', 'Couvertures AMC (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SVSITU.NDX', '10', '1', 'Couvertures AMC (index)', 'Couvertures AMC (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SVSITU.MMO', '10', '1', 'Couvertures AMC (memo)', 'Couvertures AMC (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SVTAUXSI.FIC', '10', '1', 'Taux AMC (données)', 'Taux AMC (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SVTAUXSI.NDX', '10', '1', 'Taux AMC (index)', 'Taux AMC (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENT.FIC', '10', '1', 'Clients (données)', 'Clients (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENT.MMO', '10', '1', 'Clients (memo)', 'Clients (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENT.NDX', '10', '1', 'Clients (index)', 'Clients (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTSPLIB.FIC', '10', '1', 'Codifications produits (données)', 'Codifications produits  (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTSPLIB.MMO', '10', '1', 'Codifications produits  (memo)', 'Codifications produits  (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTSPLIB.NDX', '10', '1', 'Codifications produits  (index)', 'Codifications produits  (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PARAM.FIC', '10', '1', 'Paramètres (données)', 'Paramètres (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PARAM.MMO', '10', '1', 'Paramètres (memo)', 'Paramètres (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PARAM.NDX', '10', '1', 'Paramètres (index)', 'Paramètres (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISS.FIC', '10', '1', 'Fournisseurs (données)', 'Fournisseurs (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISS.MMO', '10', '1', 'Fournisseurs (memo)', 'Fournisseurs (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISS.NDX', '10', '1', 'Fournisseurs (index)', 'Fournisseurs (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTICLES.FIC', '10', '1', 'Articles (données)', 'Articles (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTICLES.MMO', '10', '1', 'Articles (memo)', 'Articles (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTICLES.NDX', '10', '1', 'Articles (index)', 'Articles (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CONSO.FIC', '10', '1', 'Historique ventes (données)', 'Historique ventes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CONSO.NDX', '10', '1', 'Historique ventes (index)', 'Historique ventes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LFACTURE.FIC', '10', '1', 'Lignes de factures (données)', 'Lignes de factures (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LFACTURE.MMO', '10', '1', 'Lignes de factures (memo)', 'Lignes de factures (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LFACTURE.NDX', '10', '1', 'Lignes de factures (index)', 'Lignes de factures (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FFACTURE.FIC', '10', '1', 'Entetes de factures (données)', 'Entetes de factures (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FFACTURE.MMO', '10', '1', 'Entetes de factures (memo)', 'Entetes de factures (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FFACTURE.NDX', '10', '1', 'Entetes de facture (index)', 'Entetes de factures (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FFATTENTE.FIC', '10', '1', 'Entetes de factures en attente (données)', 'Entetes de factures en attente (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FFATTENTE.MMO', '10', '1', 'Entetes de factures en attente (memo)', 'Entetes de factures en attente (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FFATTENTE.NDX', '10', '1', 'Entetes de facture en attente (index)', 'Entetes de factures en attente (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LFATTENTE.FIC', '10', '1', 'Lignes de factures en attente (données)', 'Lignes de factures en attente (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LFATTENTE.MMO', '10', '1', 'Lignes de factures en attente (memo)', 'Lignes de factures en attente (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LFATTENTE.NDX', '10', '1', 'Lignes de factures en attente (index)', 'Lignes de factures en attente (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES.FIC', '10', '1', 'Commandes (données)', 'Commandes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES.NDX', '10', '1', 'Commandes (index)', 'Commandes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES.MMO', '10', '1', 'Commandes (memo)', 'Commandes (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LIGART.FIC', '10', '1', 'Lignes Commandes (données)', 'Lignes commandes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LIGART.NDX', '10', '1', 'Lignes Commandes (index)', 'Lignes commandes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FCLIEN.FIC', '10', '1', 'Programme relationnel (données)', 'Programme relationnel (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FCLIEN.NDX', '10', '1', 'Programme relationnel (index)', 'Programme relationnel (index)', null, next value for seq_grille_imp_fichiers);
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LIGART.MMO', '10', '1', 'Lignes Commandes (memo)', 'Lignes commandes (memo)', null, next value for seq_grille_imp_fichiers);


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Medecins', '12', '1', 'Hôpitaux et Praticiens', 'Hôpitaux et Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_medecins', 'ps_pharmalandv7_creer_medecin', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMO et AMC', '12', '1', 'Organismes AMO et AMC', 'Organismes AMO et AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_centres', 'ps_pharmalandv7_creer_organisme', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '1', 'Couvertures AMO', 'Couvertures AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_couvertures_amo', 'ps_pharmalandv7_creer_couv_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '1', 'Couvertures AMC', 'Couvertures AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_couvertures_amc', 'ps_pharmalandv7_creer_couv_amc', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MAJ Couvertures AMC', '12', '1', 'MAJ Couvertures AMC', 'MAJ Couvertures AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_maj_couvertures_amc', 'ps_pharmalandv7_maj_couv_amc', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MAJ Taux AMC', '12', '1', 'MAJ Taux AMC', 'MAJ Taux AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_maj_taux_amc', 'ps_pharmalandv7_maj_taux_amc', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Clients', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_clients', 'ps_pharmalandv7_creer_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_fournisseurs', 'ps_pharmalandv7_creer_four', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Zones geographiques', '12', '1', 'Zones geographiques', 'Zones geographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_zones_geo', 'ps_pharmalandv7_creer_zone_geo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_produits', 'ps_pharmalandv7_creer_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique ventes', '12', '1', 'Historique ventes', 'Historique ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_historiques_ventes', 'ps_pharmalandv7_creer_histo_vte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique clients', '12', '1', 'Historique clients', 'Historique clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_historiques_clients', 'ps_pharmalandv7_creer_histo_cli', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Commandes', '12', '1', 'Commandes', 'Commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_commandes', 'ps_pharmalandv7_creer_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Commandes lignes', '12', '1', 'Commandes lignes', 'Commandes Lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_commandes_lignes', 'ps_pharmalandv7_creer_comm_lig', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values (next value for seq_fct_fichier, 'SCANS', '12', '1', 'SCANS', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Programme relationnel', '12', '1', 'Programme relationnel', 'Programme relationnel', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_CF_clients', 'ps_pharmalandv7_creer_CF_cli', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Operateurs', '12', '1', 'Operateurs', 'Operateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_operateurs', 'ps_pharmalandv7_creer_operateur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Credits', '12', '1', 'Credits', 'Credits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_credits', 'ps_pharmalandv7_creer_credit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente', '12', '1', 'Factures en attente', 'Factures en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_attentes', 'ps_pharmalandv7_creer_attente', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lignes factures en attente', '12', '1', 'Lignes factures en attente', 'Lignes factures en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmalandv7_traitement (t_pharmalandv7_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmalandv7_traitement, 'pharmalandv7_attentes_lig', 'ps_pharmalandv7_creer_att_lig', gen_id(seq_fct_fichier, 0));

/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));


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
    t.t_pharmalandv7_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom    
from t_fct_fichier f
left join t_pharmalandv7_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier = '12';
