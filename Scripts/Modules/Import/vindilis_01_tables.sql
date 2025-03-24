set sql dialect 3;

/* ********************************************************************************************** */
create table t_vindilis_traitement(
t_vindilis_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_vindilis_traitement primary key(t_vindilis_traitement_id));

alter table t_vindilis_traitement
add constraint fk_vindilis_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_vindilis_traitement;

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Praticiens', '12', '0', 'Praticiens Et Hopitaux', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_praticiens', 'ps_vindilis_creer_praticien', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Destinataires télétrans', '12', '0', 'Destinataires télétrans', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_destinataires', 'ps_vindilis_creer_destinataire', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMO', '12', '0', 'Organismes AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_organismes_amo', 'ps_vindilis_creer_organisme', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Organismes AMC', '12', '0', 'Organismes AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_organismes_amc', 'ps_vindilis_creer_organisme', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMO', '12', '0', 'Couverture AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_couvertures_amo', 'ps_vindilis_creer_couv_amo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMC', '12', '0', 'Couverture AMC', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_couvertures_amc', 'ps_vindilis_creer_couv_amc', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Comptes', '12', '0', 'Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_compte', 'ps_vindilis_creer_compte', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_client', 'ps_vindilis_creer_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Couvertures AMO Clients', '12', '0', 'Couvertures AMO Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_couv_amo_client', 'ps_vindilis_creer_couv_amo_cli', gen_id(seq_fct_fichier, 0));
  

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Fournisseurs', '12', '0', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_fournisseur', 'ps_vindilis_creer_fournisseur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Grossistes', '12', '0', 'Grossistes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_grossiste', 'ps_vindilis_creer_grossiste', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Codes géo', '12', '0', 'Codes géo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_codegeo', 'ps_vindilis_creer_code_geo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_produit', 'ps_vindilis_creer_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Code EAN13', '12', '0', 'Code EAN13', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_code_produit', 'ps_vindilis_creer_code_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Stocks', '12', '0', 'Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_stock', 'ps_vindilis_creer_info_stock', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Historiques ventes', '12', '0', 'Historiques ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_historique_vente', 'ps_vindilis_creer_histo_vente', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Historiques clients', '12', '0', 'Historiques clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_historique_client', 'ps_vindilis_creer_histo_client', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Historiques lignes', '12', '0', 'Historiques clients lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_histo_client_ligne', 'ps_vindilis_creer_histo_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Historiques achats', '12', '0', 'Historiques achats', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_commande', 'ps_vindilis_creer_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  values(next value for seq_fct_fichier, 'Historiques achats lignes', '12', '0', 'Historiques achats lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_ligne_commande', 'ps_vindilis_creer_cmd_ligne', gen_id(seq_fct_fichier, 0));
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCANS', '12', '1', 'SCANS', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Programme Relationnel', '12', '0', 'Programme Relationnel', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_carte_fidelite', 'ps_vindilis_creer_cf', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Opérateurs', '12', '0', 'Opérateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_operateur', 'ps_vindilis_creer_operateur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Commandes en attente', '12', '0', 'Commandes en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_commande_attente', 'ps_vindilis_creer_cmd_attente', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Lignes commandes en attente', '12', '0', 'Lignes commandes en attente', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_ligne_commande_attente', 'ps_vindilis_creer_ligcmd_att', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Avances vignettes', '12', '0', 'Avances vignettes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_avance_vignette', 'ps_vindilis_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Crédits', '12', '0', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_credits', 'ps_vindilis_creer_credit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Crédits comptes', '12', '0', 'Crédits comptes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_credits_comptes', 'ps_vindilis_creer_credit_compte', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Produits dus', '12', '0', 'Produits dus', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_vindilis_traitement (t_vindilis_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_vindilis_traitement, 'vindilis_produit_du', 'ps_vindilis_creer_produit_du', gen_id(seq_fct_fichier, 0));





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
    t.t_vindilis_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_vindilis_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;