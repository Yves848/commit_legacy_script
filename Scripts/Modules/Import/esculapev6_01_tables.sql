set sql dialect 3;

/* ********************************************************************************************** */
create table t_esculapev6_traitement(
t_esculapev6_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_esculapev6_traitement primary key(t_esculapev6_traitement_id));

alter table t_esculapev6_traitement
add constraint fk_esculapev6_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_esculapev6_traitement;

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
    t.t_esculapev6_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_esculapev6_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';

/* ********************************************************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'EV6.db3', '10', '1', 'Base de données Esculape V6', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Database', '10', '1', 'Base de données Esculape V6 fichiers', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbGR', '10', '1', 'Grands régimes', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbCSV', '10', '1', 'Situations', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbRisk', '10', '1', 'Risques', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbCAMC', '10', '1', 'Remboursements AMC', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbActe', '10', '1', 'Actes', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbTVA', '10', '1', 'TVA', null, next value for seq_grille_imp_fichiers);

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FtbSpeciality', '11', '1', 'Codes spécialités', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_prescripteur', 'ps_esculapev6_creer_medecin', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Destinataires', '12', '0', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_destinataire', 'ps_esculapev6_creer_dest', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMO', '12', '0', 'Organismes AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_amo', 'ps_esculapev6_creer_org_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMC', '12', '0', 'Organismes AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_amc', 'ps_esculapev6_creer_org_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_client', 'ps_esculapev6_creer_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ps_esculapev6_maj_comptes', '13', '0', 'Mise a jour comptes', 'grdClients', next value for seq_grille_imp_clients);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs', '12', '0', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_fournisseur', 'ps_esculapev6_creer_fournisseur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Zones Geographiques', '12', '0', 'Zones Geographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_zone_geographique', 'ps_esculapev6_creer_zone_geo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_produit', 'ps_esculapev6_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Avances', '12', '0', 'Avances', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_avance', 'ps_esculapev6_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Crédits', '12', '0', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_credit', 'ps_esculapev6_creer_credit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCANS', '12', '1', 'SCANS', 'Documents scannées', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Historique clients', '12', '0', 'Historique clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_historique_client', 'ps_esculapev6_creer_histo_cli', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Commentaires Clients', '12', '0', 'Commentaires Clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_esculapev6_traitement (t_esculapev6_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_esculapev6_traitement, 'esculapev6_commentaire', 'ps_esculapev6_comm_client', gen_id(seq_fct_fichier, 0));

/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));

/* ********************************************************************************************** */
create table t_esculapev6_specialite(
  id integer,
  code varchar(2),
  constraint pk_esculapev6_specialite primary key(id));

/* ********************************************************************************************** */
create table t_esculapev6_org_couv_amc(
  t_organisme_amc_id varchar(50),
  code_remboursement smallint,
  constraint pk_esculapev6_org_couv_amc primary key(t_organisme_amc_id));

/* ********************************************************************************************** */
create table t_esculapev6_taux_tva(
  code smallint,
  taux_tva float,
  constraint pk_esculapev6_taux_tva primary key(code));

/* ********************************************************************************************** */
create table t_esculapev6_acte(
  id integer,
  code varchar(5),
  constraint pk_esculapev6_acte primary key(id));
/* ********************************************************************************************** */
create table t_esculapev6_scan(
  t_client_id dm_code,
  t_document_id dm_code,
  constraint pk_esculapev6_scan primary key(t_client_id));  
  
alter table t_esculapev6_scan
add constraint fk_esculapev6_scan_cli foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;  
  
create index idx_document_id on t_esculapev6_scan(t_document_id);