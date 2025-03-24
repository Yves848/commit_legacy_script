set sql dialect 3;


alter table t_client add t_famille_id dm_code;
create index idx_assure_famille on t_client(t_famille_id);

/* ********************************************************************************************** */
create table t_opus_tva(
  code integer not null,
  valeur dm_tva not null,
  constraint pk_opus_tva primary key(code));

create index idx_opus_valeur on t_opus_tva(valeur);

/* ********************************************************************************************** */
create table t_opus_traitement(
t_opus_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_opus_traitement primary key(t_opus_traitement_id));

alter table t_opus_traitement
add constraint fk_opus_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_opus_traitement;

/* ********************************************************************************************** */
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'pharma.wdd', '10', '1', 'Fichier d analyse de la base de données', 'Fichier d analyse de la base de données', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECIN.FIC', '10', '1', 'Hôpitaux et Praticiens (données)', 'Hôpitaux et Praticiens (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECIN.NDX', '10', '1', 'Hôpitaux et Praticiens (index)', 'Hôpitaux et Praticiens (index)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CONCENTR.FIC', '10', '1', 'Destinataires (données)', 'Destinataires (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CONCENTR.NDX', '10', '1', 'Destinataires (index)', 'Destinataires (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISM.FIC', '10', '1', 'Organismes AMO (données)', 'Organismes AMO (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISM.NDX', '10', '1', 'Organismes AMO (index)', 'Organismes AMO (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MUTUELLE.FIC', '10', '1', 'Organismes AMC (données)', 'Organismes AMC (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MUTUELLE.NDX', '10', '1', 'Organismes AMC (index)', 'Organismes AMC (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'STATUT.FIC', '10', '1', 'Couvertures AMO (données)', 'Couvertures AMO (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'STATUT.NDX', '10', '1', 'Couvertures AMO (index)', 'Couvertures AMO (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DROITAMO.FIC', '10', '1', 'Droits AMO (données)', 'Droits AMO (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DROITAMO.NDX', '10', '1', 'Droits AMO (index)', 'Droits AMO (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DROITCLI.FIC', '10', '1', 'Droits Clients (données)', 'Droits Clients (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DROITCLI.NDX', '10', '1', 'Droits Clients (index)', 'Droits Clients (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DROITAMC.FIC', '10', '1', 'Droits AMC (données)', 'Droits AMC (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DROITAMC.NDX', '10', '1', 'Droits AMC (index)', 'Droits AMC (index)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'BENEFICE.FIC', '10', '1', 'Clients (données)', 'Clients (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'BENEFICE.NDX', '10', '1', 'Clients (index)', 'Clients (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ASSURE.FIC', '10', '1', 'Assurés (données)', 'Assurés (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ASSURE.NDX', '10', '1', 'Assurés (index)', 'Assurés (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REGROUP.FIC', '10', '1', 'Comptes (données)', 'Comptes (Données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REGROUP.NDX', '10', '1', 'Comptes (index)', 'Comptes (index)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TVA.FIC', '10', '1', 'TVA (données)', 'TVA (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TVA.NDX', '10', '1', 'TVA (index)', 'TVA (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REP.FIC', '10', '1', 'Répartiteurs (données)', 'Répartiteurs (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REP.NDX', '10', '1', 'Répartiteurs (index)', 'Répartiteurs (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LAB.FIC', '10', '1', 'Fournisseurs (données)', 'Fournisseurs (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LAB.NDX', '10', '1', 'Fournisseurs (index)', 'Fournisseurs (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'GROUPE.FIC', '10', '1', 'Fournisseurs suite (données)', 'Fournisseurs suite(données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'GROUPE.NDX', '10', '1', 'Fournisseurs suite (index)', 'Fournisseurs suite(index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONEGEO.FIC', '10', '1', 'Zone Géographiques (données)', 'Zone Géographiques (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONEGEO.NDX', '10', '1', 'Zone Géographiques (index)', 'Zone Géographiques (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTICLE.FIC', '10', '1', 'Articles (données)', 'Articles (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTICLE.NDX', '10', '1', 'Articles (index)', 'Articles (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'VENTE.FIC', '10', '1', 'Ventes (données)', 'Ventes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'VENTE.NDX', '10', '1', 'Ventes (index)', 'Ventes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTLPP.FIC', '10', '1', 'LPP (données)', 'LPP (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ARTLPP.NDX', '10', '1', 'LPP (index)', 'LPP (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ART_CODE13.FIC', '10', '1', 'EAN (données)', 'EAN (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ART_CODE13.NDX', '10', '1', 'EAN (index)', 'EAN (index)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'OPERATEU.FIC', '10', '1', 'Opérateurs (données)', 'Opérateurs (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'OPERATEU.NDX', '10', '1', 'Opérateurs (index)', 'Opérateurs  (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'NOTEFAC.FIC', '10', '1', 'Historiques délivrance (données)', 'Historiques délivrance (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'NOTEFAC.NDX', '10', '1', 'Historiques délivrance (index)', 'Historiques délivrance (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LIGNEFAC.FIC', '10', '1', 'Historiques délivrance lignes(données)', 'Historiques délivrance lignes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LIGNEFAC.NDX', '10', '1', 'Historiques délivrance lignes(index)', 'Historiques délivrance lignes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FAMILLE.FIC', '10', '1', 'Codifications (données)', 'Codifications (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FAMILLE.NDX', '10', '1', 'Codifications (index)', 'Codifications (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDIT.FIC', '10', '1', 'Crédits (données)', 'Crédits (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDIT.NDX', '10', '1', 'Crédits (index)', 'Crédits (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LCREDIT.FIC', '10', '1', 'Lignes Crédits (données)', 'Lignes Crédits (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LCREDIT.NDX', '10', '1', 'Lignes Crédits (index)', 'Lignes Crédits (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCUMENT.FIC', '10', '1', 'Documents (données)', 'Documents (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCUMENT.NDX', '10', '1', 'Documents (index)', 'Documents (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCPAGE.FIC', '10', '1', 'Liaison documents clients (données)', 'Documents - Suite (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCPAGE.NDX', '10', '1', 'Liaison documents clients (index)', 'Documents - Suite (index)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPROD.FIC', '10', '1', 'Commandes fournisseurs entêtes (données)', 'Commandes fournisseurs entêtes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPROD.NDX', '10', '1', 'Commandes fournisseurs entêtes (index)', 'Commandes fournisseurs entêtes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMARTIC.FIC', '10', '1', 'Commandes répartiteurs entêtes (données)', 'Commandes répartiteurs entêtes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMARTIC.NDX', '10', '1', 'Commandes répartiteurs entêtes (index)', 'Commandes répartiteurs entêtes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMECH.FIC', '10', '1', 'Commandes groupements entêtes (données)', 'Commandes groupements entêtes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMECH.NDX', '10', '1', 'Commandes groupements entêtes (index)', 'Commandes groupements entêtes (index)', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMLAB.FIC', '10', '1', 'Commandes fournisseurs lignes (données)', 'Commandes fournisseurs lignes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMLAB.NDX', '10', '1', 'Commandes fournisseurs lignes (index)', 'Commandes fournisseurs lignes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMREP.FIC', '10', '1', 'Commandes répartiteurs lignes (données)', 'Commandes répartiteurs lignes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMREP.NDX', '10', '1', 'Commandes répartiteurs lignes (index)', 'Commandes répartiteurs lignes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMGRP.FIC', '10', '1', 'Commandes groupements lignes (données)', 'Commandes groupements lignes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMGRP.NDX', '10', '1', 'Commandes groupements lignes (index)', 'Commandes groupements lignes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRIVILEG.FIC', '10', '1', 'Encours programme avantage lignes (données)', 'Encours carte fidélite lignes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRIVILEG.NDX', '10', '1', 'Encours programme avantage lignes (index)', 'Encours carte fidélite lignes (index)', null, next value for seq_grille_imp_fichiers);

--grdPraticiens
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Medecins', '12', '1', 'Hôpitaux et Praticiens', 'Hôpitaux et Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_medecin', 'ps_opus_creer_medecin', gen_id(seq_fct_fichier, 0));

--grdOrganismes
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Destinataires', '12', '1', 'Destinataires', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_destinataire', 'ps_opus_creer_destinataire', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMO', '12', '1', 'Organismes AMO', 'Organismes AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_organisme_amo', 'ps_opus_creer_organisme_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMC', '12', '1', 'Organismes AMC', 'Organismes AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_organisme_amc', 'ps_opus_creer_organisme_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '1', 'Couvertures AMO', 'Couverture AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_couverture_amo', 'ps_opus_creer_couverture_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couv Org AMO', '12', '1', 'Couv Org AMO', 'Couv Org AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_couv_org_amo', 'ps_opus_creer_couv_org_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '1', 'Couvertures AMC', 'Couverture AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_couverture_amc', 'ps_opus_creer_couverture_amc', gen_id(seq_fct_fichier, 0));

--grdClients
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Comptes', '12', '1', 'Comptes', 'Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_compte', 'ps_opus_creer_compte', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Clients', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_client', 'ps_opus_creer_client', gen_id(seq_fct_fichier, 0));
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures Clients', '12', '1', 'Couvertures Clients', 'Couvertures Clients', 'grdClients', next value for seq_grille_imp_clients);
--insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_couverture_client', 'ps_opus_creer_couv_client', gen_id(seq_fct_fichier, 0));

--grdProduits
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Familles', '12', '1', 'Familles', 'Familles', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_famille', 'ps_opus_creer_famille', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Zones Géographiques', '12', '1', 'Zones Géographiques', 'Zones Géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_zone_geographique', 'ps_opus_creer_zonegeo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Répartiteurs', '12', '1', 'Répartiteurs', 'Répartiteur', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_repartiteur', 'ps_opus_creer_repartiteur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_fournisseur', 'ps_opus_creer_fournisseur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_produit', 'ps_opus_creer_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Ean', '12', '1', 'Ean', 'Ean', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_ean', 'ps_opus_creer_ean', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques Vente', '12', '1', 'Historiques Vente', 'Historiques Vente', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_histo_vente', 'ps_opus_creer_histo_vente', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lpp', '12', '1', 'Lpp', 'Lpp', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_lpp', 'ps_opus_creer_lpp', gen_id(seq_fct_fichier, 0));

--grdEncours
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Opérateurs', '12', '1', 'Opérateurs', 'Opérateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_operateur', 'ps_opus_creer_operateur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Commandes En Cours', '12', '1', 'Commandes En Cours', 'Commandes En Cours', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_commandes', 'ps_opus_creer_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lignes Commandes En Cours', '12', '1', 'Lignes Commandes En Cours', 'Lignes Commandes En Cours', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_commandes_ligne', 'ps_opus_creer_commande_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Avances Vignettes', '12', '1', 'Avances Vignettes', 'Avances Vignettes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_avance', 'ps_opus_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente', '12', '1', 'Factures en attente', 'Factures en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_attente', 'ps_opus_creer_attente', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Factures en attente lignes', '12', '1', 'Factures en attente lignes', 'Factures en attente lignes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_attente_ligne', 'ps_opus_creer_attente_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Crédits', '12', '1', 'Crédits', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_credit', 'ps_opus_creer_credit', gen_id(seq_fct_fichier, 0));

-- Autres Donnees : delivrances
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques Délivrance', '12', '1', 'Historiques Délivrance', 'Historiques Délivrance', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_histo_client', 'ps_opus_creer_histo_entete', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques Délivrance Lignes', '12', '1', 'Historiques Délivrance Lignes', 'Historiques Délivrance Lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_histo_client_ligne', 'ps_opus_creer_histo_ligne', gen_id(seq_fct_fichier, 0));
-- histo achats
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historiques Achats', '12', '1', 'Historiques Achats', 'Historiques Achats', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_histo_achats', 'ps_opus_creer_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lignes Historiques Achats', '12', '1', 'Lignes Historiques Achats', 'Lignes Historiques Achats', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_histo_achats_ligne', 'ps_opus_creer_commande_ligne', gen_id(seq_fct_fichier, 0));
-- scans 
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Documents Mut', '12', '1', 'Scans Attestations Mutuelle', 'Scans Attestations Mutuelle', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_documents_mut', 'ps_opus_creer_document', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Documents Ord', '12', '1', 'Scans Ordonnances', 'Scans Ordonnances', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_documents_ord', 'ps_opus_creer_document', gen_id(seq_fct_fichier, 0));


-- Programmes fidelites
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Programme avantage', '12', '1', 'Programme avantage', 'Programme avantage', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement,'opus_pa', 'ps_opus_creer_prog_avantage', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Encours clients programme avantage', '12', '1', 'Encours clients programme avantage', 'Encours clients programme avantage', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_pa_client', 'ps_opus_creer_prog_av_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits programme avantage', '12', '1', 'Produits programme avantage', 'Produits programme avantage', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement, 'opus_pa_produit', 'ps_opus_creer_prog_av_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Programme relationnel', '12', '1', 'Programme relationnel', 'Programme relationnel', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_opus_traitement (t_opus_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_opus_traitement,'opus_programme_relationnel', 'ps_opus_creer_carte_prog_rel', gen_id(seq_fct_fichier, 0));

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
    t.t_opus_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_opus_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;

commit;