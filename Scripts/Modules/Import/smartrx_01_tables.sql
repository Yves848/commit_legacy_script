set sql dialect 3;

/* ********************************************************************************************** */
create table t_smartrx_traitement(
t_smartrx_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_smartrx_traitement primary key(t_smartrx_traitement_id));

alter table t_smartrx_traitement
add constraint fk_smartrx_traitement_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_smartrx_traitement;
/* ************************************************** Fichiers CSV ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af04.csv', '10', '1', 'Table Clients décryuptée', 'Clients', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'af25.csv', '10', '1', 'Table Histo Clients détail décryptée', 'Histo client', null, next value for seq_grille_imp_fichiers);


/* ************************************************** Praticiens ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_praticiens', 'ps_smartrx_creer_praticien', gen_id(seq_fct_fichier, 0));
 
/* ************************************************** Organismes ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Destinataires', '12', '0', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_destinataires', 'ps_smartrx_creer_destinataire', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Organismes', '12', '0', 'Organismes', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_organismes', 'ps_smartrx_creer_organisme', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Contrats', '12', '0', 'Contrats', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_contrats', 'ps_smartrx_creer_contrat', gen_id(seq_fct_fichier, 0));

/* ************************************************** Clients ***************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients et Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_clients', 'ps_smartrx_creer_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Liaisons', '12', '0', 'Liaisons Collectivités Adhérents', 'grdClients', next value for seq_grille_imp_clients);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_clients_liaisons', 'ps_smartrx_creer_client_liaison', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Contrats clients', '12', '0', 'Contrats clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_clients_contrats', 'ps_smartrx_creer_client_contrat', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Maj Org clients', '12', '1', 'Maj Organismes clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_clients_maj_organismes', 'ps_smartrx_maj_org_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Maj Couv clients', '12', '1', 'Maj Couvertures clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_clients_maj_couvertures', 'ps_smartrx_maj_couv_client', gen_id(seq_fct_fichier, 0));

/* ************************************************** Produits ***************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Fournisseurs - Répartiteurs', '12', '0', 'Fournisseurs Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_fournisseurs', 'ps_smartrx_creer_fournisseur', gen_id(seq_fct_fichier, 0));

-- Pas maintenu
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'RESFAM.D', '11', '1', 'Familles issues de la base "Claude Bernard"', 'Familles BCB', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Familles Internes', '12', '0', 'Familles Internes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_produits_familles', 'ps_smartrx_creer_famille', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Zones Geo', '12', '0', 'Zones Geo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_zones_geo', 'ps_smartrx_creer_zone_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_produits', 'ps_smartrx_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Stocks', '12', '0', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_produits_stocks', 'ps_smartrx_creer_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Codes Produits', '12', '0', 'Codes Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_produits_codes', 'ps_smartrx_creer_produit_code', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Histo Ventes', '12', '0', 'Histo Ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_produits_histo_ventes', 'ps_smartrx_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Produits - Lpp', '12', '0', 'Produits - Lpp', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_produits_lpp', 'ps_smartrx_creer_produits_lpp', gen_id(seq_fct_fichier, 0));

-- Pas sure que ça serve encore ....
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'A_FLSPRO.D', '11', '1', 'MAJ Zone Géo Produits', 'MAJ Zone Géo Produits', 'grdProduits', next value for seq_grille_imp_produits);

/* ************************************************** Encours ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Vignettes Avancées', '12', '0', 'Vignettes Avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_encours_vignettes_av', 'ps_smartrx_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Produits Dus', '12', '0', 'Produits Dus', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_encours_produits_dus', 'ps_smartrx_creer_produit_du', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Credits', '12', '0', 'Crédits Clients', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_encours_credits', 'ps_smartrx_creer_credit', gen_id(seq_fct_fichier, 0));

/* ************************************************** Autres données  ******************************************* */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Opérateurs', '12', '0', 'Opérateurs', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_operateurs', 'ps_smartrx_creer_operateur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historique délivrances entêtes', '12', '0', 'Historique délivrances entêtes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_histo_entetes', 'ps_smartrx_creer_histo_ent', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historique délivrances lignes', '12', '0', 'Historique délivrances lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_histo_lignes', 'ps_smartrx_creer_histo_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Commandes', '12', '0', 'Commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_commandes', 'ps_smartrx_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Commandes lignes', '12', '0', 'Commandes lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_commandes_lignes', 'ps_smartrx_creer_comm_ligne', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Catalogues fournisseurs', '12', '0', 'Catalogues fournisseurs', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_catalogues', 'ps_smartrx_creer_catalogue', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Catalogues fourn - Prod', '12', '0', 'Catalogues fournisseurs - Produits', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_catalogues_produits', 'ps_smartrx_creer_catalogue_prod', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'SCANS', '12', '1', 'SCANS', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);

/* ************************************************** Progammes Fidélités   ******************************************* */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Programmes Avantages', '12', '0', 'Programmes Avantages', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_programmes_avantages', 'ps_smartrx_creer_prog_avantage', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Programmes Avantages Clients', '12', '0', 'Programmes Avantages Clients', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_prog_avantages_clients', 'ps_smartrx_creer_avantage_cli', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Programmes Avantages Produits', '12', '0', 'Produits liés', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_prog_avantages_produits', 'ps_smartrx_creer_prog_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Cartes Programmes Relationnels', '12', '0', 'Cartes Programmes Relationnels', 'grdProgrammesFidelites', next value for seq_grille_imp_avantages);
insert into t_smartrx_traitement (t_smartrx_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_smartrx_traitement, 'smartrx_carte_prog_relationnel', 'ps_smartrx_creer_carte_prog_rel', gen_id(seq_fct_fichier, 0));

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
    t.t_smartrx_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_smartrx_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';

/* ************************************************************************************************************** */
/* pas besoin des triggers de creation de catalogue puisqu'un traitement le fait */
alter trigger trg_cmd_creation_catalogue inactive;
alter trigger trg_cmdlig_creation_lig_cat inactive;