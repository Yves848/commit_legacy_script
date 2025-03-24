set sql dialect 3;

/* ********************************************************************************************** */
create table t_farmadtwin_traitement(
t_farmadtwin_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_farmadtwin_traitement primary key(t_farmadtwin_traitement_id));

alter table t_farmadtwin_traitement
add constraint fk_farmadtwin_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

CREATE TABLE T_FARMAD_LANGUE 
(
  LANGUE             DM_CHAR2 NOT NULL,
 CONSTRAINT PK_T_FARMAD_LANGUE PRIMARY KEY (LANGUE)
);

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
    t.t_farmadtwin_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_farmadtwin_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;

/* ********************************************************************************************** */

create sequence seq_farmadtwin_traitement;

/* ********************************************************************************************** */

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FARMADWIN2.FDB', '10', '1', 'Base de données Farmadtwin', 'Base de données farmadtwin', null, next value for seq_grille_imp_fichiers);
--langue Farmad
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LANGUE', '12', '1', 'Langue', 'Langue', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_LANGUE', 'ps_farmadtwin_creer_langue', gen_id(seq_fct_fichier, 0));
--praticiens
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Médecins', 'Médecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_MEDECINS', 'ps_farmadtwin_creer_medecin', gen_id(seq_fct_fichier, 0));
--grdclients
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PROFILS_REMISES', '12', '1', 'Profils de remises', 'Profils de remises', 'grdClients', next value for seq_grille_imp_clients );
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_PROFILS_REMISES', 'ps_farmadtwin_creer_profil_rem', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COLLECTIVITES', '12', '1', 'Collectivités', 'Collectivités', 'grdClients', next value for seq_grille_imp_clients);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_COLLECTIVITES', 'ps_farmadtwin_creer_collect', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PATIENTS', '12', '1', 'Patients', 'Patients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_PATIENTS', 'ps_farmadtwin_creer_patient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARMACIEN_REFERENCE', '12', '1', 'Pharmacien de référence', 'Pharmacien de référence', 'grdClients', next value for seq_grille_imp_clients);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_PHARMACIEN_REFERENCE', 'ps_farmadtwin_upd_pha_ref', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTES_RISTOURNES', '12', '1', 'Comptes ristournes', 'Comptes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_COMPTES_RISTOURNES', 'ps_farmadtwin_creer_compte_rist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CARTES_RISTOURNES', '12', '1', 'Cartes ristournes', 'Cartes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_CARTES_RISTOURNES', 'ps_farmadtwin_creer_carte_rist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TRANSACTIONS_RISTOURNES', '12', '1', 'Transactions ristournes', 'Transactions ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_TRANSACTIONS_RISTOURNES', 'ps_farmadtwin_creer_trans_rist', gen_id(seq_fct_fichier, 0));

 --grdproduits
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_FOURNISSEURS', 'ps_farmadtwin_creer_fournisseur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TEL FOURNISSEURS', '12', '1', 'Fournisseurs', 'Téléphones fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_TELEPHONES_FOUR', 'ps_farmadtwin_maj_tel_four', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONES_GEOGRAPHIQUES', '12', '1', 'Zones géographiques', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_ZONES_GEOGRAPHIQUES', 'ps_farmadtwin_creer_zone_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_PRODUITS', 'ps_farmadtwin_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TARIFS_PRODUITS', '12', '1', 'Tarifs produits', 'Tarifs produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_TARIFS_PRODUITS', 'ps_farmadtwin_creer_tarif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MAJ_FOURNISSEURS', '12', '1', 'Mises à jour fournisseurs', 'Mises à jour fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_PRODUITS_FOURNISSEURS', 'ps_farmadtwin_maj_fournisseur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODES_BARRES', '12', '1', 'Codes barres', 'Codes barres', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_CODES_BARRES', 'ps_farmadtwin_creer_ean', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES_VENTES', '12', '1', 'Historiques de ventes', 'Historiques de ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_HISTORIQUES_VENTES', 'ps_farmadtwin_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCHEMA_PRODUIT', '12', '1', 'Schéma de médication - Produit', 'Schéma de médication - Produit', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_SCHEMA_PRODUIT', 'ps_creer_schema_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCHEMA_PRISE', '12', '1', 'Schéma de médication - Prise', 'Schéma de médication - Prise', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_SCHEMA_PRISE', 'ps_creer_schema_prise', gen_id(seq_fct_fichier, 0));


--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FICHE_ANALYSE', '12', '1', 'Fiche d analyse', 'Fiche d analyse', 'grdProduits', next value for seq_grille_imp_produits);
--insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_FICHEANALYSE', 'ps_farmadtwin_creer_fiche_analyse', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITS', '12', '1', 'Crédits', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_CREDITS', 'ps_farmadtwin_creer_credit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LITIGES', '12', '1', 'Litiges', 'Litiges', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_LITIGES', 'ps_farmadtwin_creer_litige', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELIVRANCES_DIFFEREES', '12', '1', 'Délivrances différées', 'Délivrances différées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_DELIVRANCES_DIFFEREES', 'ps_farmadtwin_creer_del_diff', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AUTRES_LITIGES', '12', '1', 'Manque attestation', 'Manque attestation', 'grdEncours', next value for seq_grille_imp_encours);
--insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_AUTRES_LITIGES', 'ps_creer_autre_litige', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES_DELIVRANCES', '12', '1', 'Historiques de délivrances', 'Historiques de délivrances', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_HISTORIQUES_DELIVRANCES', 'ps_farmadtwin_creer_histo_del', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES_DELIVRANCES_LIGNES', '12', '1', 'Historiques de délivrances lignes', 'Historiques de délivrances lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_HISTORIQUES_DELIVRANCES_LIGNES', 'ps_farmadtwin_creer_hist_dlig', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUES_DELIVRANCES_MAG', '12', '1', 'Historiques magistrales', 'Historiques magistrales', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_HISTORIQUES_DELIVRANCES_MAG', 'ps_farmadtwin_creer_hist_mag', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ANALYSES_CHIMIQUES', '12', '1', 'Analyses Chimiques', 'Analyses Chimiques', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_ANALYSES_CHIMIQUES', 'ps_creer_ficheanalyse', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATIONS_PRODUITS', '12', '1', 'Attestations produits', 'Attestations produits', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_farmadtwin_traitement (t_farmadtwin_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_farmadtwin_traitement, 'FARMADTWIN_ATTESTATIONS_PRODUITS', 'ps_farmadtwin_creer_attestation', gen_id(seq_fct_fichier, 0));
