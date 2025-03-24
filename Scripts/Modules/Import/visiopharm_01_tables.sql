set sql dialect 3;

/* ********************************************************************************************** */
create table t_visiopharm_traitement(
t_visiopharm_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_visiopharm_traitement primary key(t_visiopharm_traitement_id));

alter table t_visiopharm_traitement
add constraint fk_visiopharm_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;


create sequence seq_visiopharm_traitement;

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARMACIE.FDB', '10', '1', 'Base de données VisioPharm', 'Medecins, Organismes, Clients, Produits, etc ...', null, next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Medecins', 'Medecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_medecins', 'ps_visiopharm_creer_medecin', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISMES', '12', '1', 'Organismes', 'Organismes', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_organismes', 'ps_visiopharm_creer_organisme', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COUVERTURES', '12', '1', 'Couvertures AMO', 'Couvertures AMO', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_couv_amo', 'ps_visiopharm_creer_couv_amo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ASSURES', '12', '1', 'Assures', 'Assures', 'grdClients', next value for seq_grille_imp_clients);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_assures', 'ps_visiopharm_creer_assure', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'BENEFICIAIRES', '12', '1', 'Beneficiaires', 'Beneficiaires', 'grdClients', next value for seq_grille_imp_clients);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_benefs', 'ps_visiopharm_creer_benef', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONES GEOGRAPHIQUES', '12', '1', 'Zones Geographiques', 'Zones geographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_zonegeo', 'ps_visiopharm_creer_zonegeo', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_fournisseurs', 'ps_visiopharm_creer_fournisseur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_produits', 'ps_visiopharm_creer_produit', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES VENTES', '12', '1', 'Historiques Ventes', 'Historiques Ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_histo_ventes', 'ps_visiopharm_creer_histo_vente', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS ENTETES', '12', '1', 'Historiques clients entetes', 'Historiques clients entetes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_historiques', 'ps_visiopharm_creer_hist_entete', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS LIGNES', '12', '1', 'Historiques clients lignes', 'Historiques clients lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_historiques_lignes', 'ps_visiopharm_creer_hist_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES', '12', '1', 'Commandes', 'Commandes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_commandes', 'ps_visiopharm_creer_commande', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMMANDES LIGNES', '12', '1', 'Commandes Lignes', 'Commandes Lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_commandes_lignes', 'ps_visiopharm_creer_comm_ligne', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) 
values (next value for seq_fct_fichier, 'SCANS', '12', '1', 'SCANS', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'OPERATEURS', '12', '1', 'Operateurs', 'Operateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_vendeurs', 'ps_visiopharm_creer_operateur', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AVANCES VIGNETTES', '12', '1', 'Avances Vignettes', 'Avances Vignettes', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_avances', 'ps_visiopharm_creer_avance', gen_id(seq_fct_fichier, 0));
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITS', '12', '1', 'Crédits', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_visiopharm_traitement (t_visiopharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_visiopharm_traitement, 'visiopharm_credits', 'ps_visiopharm_creer_credit', gen_id(seq_fct_fichier, 0));

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
    t.t_visiopharm_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_visiopharm_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';

