set sql dialect 3;

/* ********************************************************************************************** */
create table t_PharmonyFR_traitement(
t_PharmonyFR_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_PharmonyFR_traitement primary key(t_PharmonyFR_traitement_id));

alter table t_PharmonyFR_traitement
add constraint fk_PharmoFR_traitement_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_PharmonyFR_traitement;
/* ************************************************** Fichiers CSV ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'collectivities.csv', '10', '1', 'Collectivités', 'Clients', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'current_rentals.csv', '10', '1', 'current_rentals', 'current_rentals', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'fidelity_cards.csv', '10', '1', 'fidelity_cards', 'fidelity_cards', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'fidelity_profiles.csv', '10', '1', 'fidelity_profiles', 'fidelity_profiles', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'history_patients.csv', '10', '1', 'history_patients', 'history_patients', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'history_products.csv', '10', '1', 'history_products', 'history_products', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'insurance_covers.csv', '10', '1', 'insurance_covers', 'insurance_covers', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'invoice_relationships.csv', '10', '1', 'invoice_relationships', 'invoice_relationships', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'operators.csv', '10', '1', 'operators', 'operators', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'patients.csv', '10', '1', 'patients', 'patients', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'pending_documents.csv', '10', '1', 'pending_documents', 'pending_documents', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'prescribers.csv', '10', '1', 'prescribers', 'prescribers', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'product_codes.csv', '10', '1', 'product_codes', 'product_codes', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'product_lpps.csv', '10', '1', 'product_lpps', 'product_lpps', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'product_stocks.csv', '10', '1', 'product_stocks', 'product_stocks', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'products.csv', '10', '1', 'products', 'products', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'rental_invoicing_model_rows.csv', '10', '1', 'rental_invoicing_model_rows', 'rental_invoicing_model_rows', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'rental_invoicing_models.csv', '10', '1', 'rental_invoicing_models', 'rental_invoicing_models', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'rental_models.csv', '10', '1', 'rental_models', 'rental_models', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'rental_stocks.csv', '10', '1', 'rental_stocks', 'rental_stocks', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'storage_locations.csv', '10', '1', 'storage_locations', 'storage_locations', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'storage_spaces.csv', '10', '1', 'storage_spaces', 'storage_spaces', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'supplementary_insurances.csv', '10', '1', 'supplementary_insurances', 'supplementary_insurances', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'supplier_products.csv', '10', '1', 'supplier_products', 'supplier_products', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'suppliers.csv', '10', '1', 'suppliers', 'suppliers', null, next value for seq_grille_imp_fichiers);



/* ************************************************** Praticiens ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Hopitaux', '12', '0', 'Hopitaux', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_hopitaux', 'ps_PharmonyFR_creer_hopital', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_praticiens', 'ps_PharmonyFR_creer_praticien', gen_id(seq_fct_fichier, 0));



/* ************************************************** Organismes ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Organismes AMO', '12', '0', 'Organismes AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_organismes_amo', 'ps_PharmonyFR_creer_org_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Organismes AMC', '12', '0', 'Organismes AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_organismes_amc', 'ps_PharmonyFR_creer_org_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '0', 'Couvertures AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_couvertures_amo', 'ps_PharmonyFR_creer_couv_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '0', 'Couvertures AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_couvertures_amc', 'ps_PharmonyFR_creer_couv_amc', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'PS_PHARMONYFR_DESTINATAIRE', '13', '0', 'Destinataire', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, null, 'PS_PHARMONYFR_DESTINATAIRE', gen_id(seq_fct_fichier, 0));

/* ************************************************** Clients ************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Collectivités', '12', '0', 'Collectivités', 'grdClients', next value for seq_grille_imp_clients);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_collectivites', 'ps_PharmonyFR_creer_compte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_clients', 'ps_PharmonyFR_creer_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Couvertures Clients', '12', '0', 'Couvertures Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_couv_cli', 'ps_PharmonyFR_creer_couv_cli', gen_id(seq_fct_fichier, 0));

/* ************************************************** Produits ***************************************************** */

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Fournisseurs - Répartiteurs', '12', '0', 'Fournisseurs Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_fournisseurs', 'ps_creer_fournisseur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Zones Geo', '12', '0', 'Zones Geo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_zones_geo', 'ps_creer_zone_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_produits', 'ps_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Stocks', '12', '0', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_produits_stocks', 'ps_creer_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Historiques Ventes', '12', '0', 'Historiques Ventes Rotations', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_historiques_ventes', 'ps_PharmonyFR_creer_histo_vente', gen_id(seq_fct_fichier, 0));
                                                  
/* ************************************************** En Cours ***************************************************** */


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Crédits', '12', '0', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_credits', 'ps_PharmonyFR_creer_credit', gen_id(seq_fct_fichier, 0));
 

 /* ************************************************** En Cours ***************************************************** */

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historiques clients entetes', '12', '1', 'Historiques clients entetes', 'Historiques clients entetes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_historiques', 'ps_creer_hist_entete', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Historiques clients lignes', '12', '1', 'Historiques clients lignes', 'Historiques clients lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_PharmonyFR_traitement (t_PharmonyFR_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_PharmonyFR_traitement, 'PharmonyFR_historiques_lignes', 'ps_creer_hist_ligne', gen_id(seq_fct_fichier, 0));

                                                               
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
    t.t_PharmonyFR_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_PharmonyFR_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';

/* ************************************************************************************************************** */
/* pas besoin des triggers de creation de catalogue puisqu'un traitement le fait */
alter trigger trg_cmd_creation_catalogue inactive;
alter trigger trg_cmdlig_creation_lig_cat inactive;