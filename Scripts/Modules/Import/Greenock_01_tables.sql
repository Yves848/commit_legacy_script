set sql dialect 3;

/* ********************************************************************************************** */
create table t_greenock_traitement(
t_greenock_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_greenock_traitement primary key(t_greenock_traitement_id));

alter table t_greenock_traitement
add constraint fk_greenock_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

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
    t.t_greenock_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_greenock_traitement t
inner join t_fct_fichier f on t.t_fct_fichier_id = f.t_fct_fichier_id;

/* ********************************************************************************************** */

create sequence seq_greenock_traitement;

/*grdPraticiens*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Medecins', 'Medecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_MEDECINS', 'ps_creer_medecins', gen_id(seq_fct_fichier, 0));

/*grdOrganismes*/


/* grdClients*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PATIENTS', '12', '1', 'Patients', 'Patients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_PATIENTS', 'ps_creer_patients', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTS', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_CLIENTS', 'ps_creer_patients', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTERIST', '12', '1', 'Comptes Ristournes', 'Comptes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_COMPTERIST', 'ps_creer_compterist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CARTERIST', '12', '1', 'Cartes Ristournes', 'Cartes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_CARTERIST', 'ps_creer_carterist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TRANSACTIONRIST', '12', '1', 'Transactions Ristournes', 'Transactions ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_TRANSACTIONRIST', 'ps_creer_transactionrist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATION', '12', '1', 'Attestations Patient', 'Attestations Patient', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_ATTESTATION', 'ps_creer_attestation', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PROFILREMISE', '12', '1', 'Profil de remise', 'Profil de remise', 'grdClients', next value for seq_grille_imp_clients);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_PROFILREMISE', 'ps_creer_profilremise', gen_id(seq_fct_fichier, 0));

/*grdProduits*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DEPOT', '12', '1', 'Dépot', 'Dépot', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_DEPOT', 'ps_creer_greenock_depot', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONEGEO', '12', '1', 'Zone Géo', 'Zone Géo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_ZONEGEO', 'ps_creer_zonegeo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_PRODUITS', 'ps_creer_produits', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'STOCKS', '12', '1', 'Stocks Produits', 'Stocks Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_STOCKS', 'ps_creer_stocks', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITFOURNISSEURS', '12', '1', 'Produits-Fournisseurs', 'Produits-Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_TARIF_PRODUIT', 'ps_creer_tarif_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REPARTITEURS', '12', '1', 'Repartiteurs', 'Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_REPARTITEURS', 'ps_creer_repartiteurs', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_FOURNISSEURS', 'ps_creer_fournisseurs', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODESBARRES', '12', '1', 'Codes-Barres', 'Codes-Barres', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_CODESBARRES', 'ps_creer_codesbarres', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCHEMA_PRODUIT', '12', '1', 'Schéma de médication - Produit', 'Schéma de médication - Produit', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_SCHEMA_PRODUIT', 'ps_creer_schema_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCHEMA_PRISE', '12', '1', 'Schéma de médication - Prise', 'Schéma de médication - Prise', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_SCHEMA_PRISE', 'ps_creer_schema_prise', gen_id(seq_fct_fichier, 0));

/*grdEncours*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AVANCEPRODUIT', '12', '1', 'Avance Produit', 'Avance Produit', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_AVANCEPRODUIT', 'ps_creer_avance_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELDIF', '12', '1', 'Delivrances differees', 'Delivrances differees', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_DELDIF', 'ps_creer_deldif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITCLIENT', '12', '1', 'Credit Client', 'Credit Client', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_CREDITCLIENT', 'ps_creer_creditclient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEMO', '12', '1', 'Memo Patient', 'Memo Patient', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_MEMOPATIENT', 'ps_creer_memopatient', gen_id(seq_fct_fichier, 0));

/*grdAutresDonnees*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELGENERAL', '12', '1', 'Historiques Patients', 'Historiques Patients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_HISTODELGENERAL', 'ps_creer_histodelgeneral', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELDETAILS', '12', '1', 'Historiques Patients Lignes', 'Historiques Patients Lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_HISTODELDETAILS', 'ps_creer_histodeldetails', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELMAG', '12', '1', 'Historiques Patients Magistrales', 'Historiques Patients Magistrales', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_HISTODELMAG', 'ps_creer_histodelmagistrale', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTOVENTE', '12', '1', 'Historiques de ventes', 'Historiques de ventes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_greenock_traitement (t_greenock_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_greenock_traitement, 'GREENOCK_HISTOVENTE', 'ps_creer_histovente', gen_id(seq_fct_fichier, 0));
