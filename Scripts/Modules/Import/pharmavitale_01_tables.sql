set sql dialect 3;

/* ********************************************************************************************** */
create table t_pharmavitale_traitement(
t_pharmavitale_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_pharmavitale_traitement primary key(t_pharmavitale_traitement_id));

alter table t_pharmavitale_traitement
add constraint fk_pharmavitale_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_pharmavitale_traitement;

/* ********************************************************************************************** */
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARMAVITALEBD.mdf', '10', '0', 'Fichier de base de données PharmaVitale', 'Fichier de base de données PharmaVitale', 'null', next value for seq_grille_imp_fichiers);

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Médecins', 'Médecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_medecins', 'ps_pharmavitale_creer_medecin', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DESTINATAIRES', '12', '1', 'Destinataire de télétransmissions', 'Destinataires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_destinataire', 'ps_pharmavitale_creer_dest', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ORGANISMES', '12', '1', 'Caisses primaires', 'Caisses primaires', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_organismes', 'ps_pharmavitale_creer_organisme', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MUTUELLES', '12', '1', 'Mutuelles', 'Mutuelles', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_mutuelles', 'ps_pharmavitale_creer_mutuelle', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'GRILLES MUTUELLES', '12', '1', 'Grilles mutuelles', 'Grilles mutuelles', 'grdOrganismes', next value for seq_grille_imp_organismes);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_grilles_mutuelles', 'ps_pharmavitale_creer_gr_mut', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ASSURES', '12', '1', 'Assurés', 'Assurés', 'grdClients', next value for seq_grille_imp_clients);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_assures', 'ps_pharmavitale_creer_assure', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DEPOTS', '12', '1', 'Dépôts', 'Dépôts', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_depots', 'ps_pharmavitale_creer_depots', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONES GEOGRAPHIQUES', '12', '1', 'Zones géographiques', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_codes_geographiques', 'ps_pharmavitale_creer_code_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CATEGORIES', '12', '1', 'Catégories', 'Catégories', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_categories', 'ps_pharmavitale_creer_categ', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_fournisseurs', 'ps_pharmavitale_creer_fourn', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_produits', 'ps_pharmavitale_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES VENTES', '12', '1', 'Historiques ventes', 'Historiques ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_historiques_ventes', 'ps_pharmavitale_creer_histo_vte', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DOCUMENTS SCANNES', '12', '1', 'Documents scannés', 'Documents scannés', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_scans', 'ps_pharmavitale_creer_scan', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES CLIENTS', '12', '1', 'Historiques clients', 'Historiques clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_historiques_clients', 'ps_pharmavitale_creer_histo_del', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES ACHATS', '12', '1', 'Historiques achats', 'Historiques achats', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_commandes', 'ps_pharmavitale_creer_commande', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES ACHATS LIGNES', '12', '1', 'Historiques achats lignes', 'Historiques achats lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_commandes_lignes', 'ps_pharmavitale_creer_com_lig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'OPERATEURS', '12', '1', 'Opérateurs', 'Opérateurs', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_operateurs', 'ps_pharmavitale_creer_operateur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'VIGNETTES AVANCEES', '12', '1', 'Vignettes avancées', 'Vignettes avancées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_vignettes_avancees', 'ps_pharmavitale_creer_va', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITS', '12', '1', 'Crédits', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_pharmavitale_traitement (t_pharmavitale_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_pharmavitale_traitement, 'pharmavitale_credits', 'ps_pharmavitale_creer_credit', gen_id(seq_fct_fichier, 0));

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
    t.t_pharmavitale_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom    
from t_pharmavitale_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;

/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));