set sql dialect 3;

/* ********************************************************************************************** */
create table t_officinall_traitement(
t_officinall_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_officinall_traitement primary key(t_officinall_traitement_id));

alter table t_officinall_traitement
add constraint fk_officinall_trait_fichier foreign key(t_fct_fichier_id)
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
    t.t_officinall_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_officinall_traitement t
inner join t_fct_fichier f
on t.t_fct_fichier_id = f.t_fct_fichier_id;

/* ********************************************************************************************** */

create sequence seq_officinall_traitement;

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, ligne) values(next value for seq_fct_fichier, 'officinall.bak', '10', '0', 'Backup SQL server', next value for seq_grille_imp_fichiers);

/*grdPraticiens*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Medecins', 'Medecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_MEDECINS', 'ps_creer_medecins', gen_id(seq_fct_fichier, 0));

/*grdOrganismes*/

/* grdClients*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PATIENTS', '12', '1', 'Patients', 'Patients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_PATIENTS', 'ps_creer_patients', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTS', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_CLIENTS', 'ps_creer_patients', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTERIST', '12', '1', 'Comptes Ristournes', 'Comptes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_COMPTERIST', 'ps_creer_compterist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CARTERIST', '12', '1', 'Cartes Ristournes', 'Cartes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_CARTERIST', 'ps_creer_carterist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TRANSACTIONRIST', '12', '1', 'Transactions Ristournes', 'Transactions ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_TRANSACTIONRIST', 'ps_creer_transactionrist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATION', '12', '1', 'Attestations Patient', 'Attestations Patient', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_ATTESTATION', 'ps_creer_attestation', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARMACIEN_REFERENCE', '12', '1', 'Pharmacien de référence', 'Pharmacien de référence', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_PHARMACIEN_REFERENCE', 'ps_officinall_upd_pha_ref', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PROFILREMISE', '12', '1', 'Profil de remise', 'Profil de remise', 'grdClients', next value for seq_grille_imp_clients);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_PROFILREMISE', 'ps_creer_profilremise', gen_id(seq_fct_fichier, 0));

/*grdProduits*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONEGEO', '12', '1', 'Zone Geo', 'Zone Geo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_ZONEGEO', 'ps_creer_zonegeo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_PRODUITS', 'ps_creer_produits', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITFOURNISSEURS', '12', '1', 'Produits-Fournisseurs', 'Produits-Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_TARIF_PRODUIT', 'ps_creer_tarif_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'REPARTITEURS', '12', '1', 'Repartiteurs', 'Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_REPARTITEURS', 'ps_creer_repartiteurs', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs', 'Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_FOURNISSEURS', 'ps_creer_fournisseurs', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODESBARRES', '12', '1', 'Codes-Barres', 'Codes-Barres', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_CODESBARRES', 'ps_creer_codesbarres', gen_id(seq_fct_fichier, 0));

/*grdEncours*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AVANCEPRODUIT', '12', '1', 'Avance Produit', 'Avance Produit', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_AVANCEPRODUIT', 'ps_creer_avance_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELDIF', '12', '1', 'Delivrances differees', 'Delivrances differees', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_DELDIF', 'ps_creer_deldif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITCLIENT', '12', '1', 'Credit Client', 'Credit Client', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_CREDITCLIENT', 'ps_creer_creditclient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEMO', '12', '1', 'Memo Patient', 'Memo Patient', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_MEMOPATIENT', 'ps_creer_memopatient', gen_id(seq_fct_fichier, 0));

/*grdAutresDonnees*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELGENERAL', '12', '1', 'Historiques Patients', 'Historiques Patients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_HISTODELGENERAL', 'ps_creer_histodelgeneral', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELDETAILS', '12', '1', 'Historiques Patients Lignes', 'Historiques Patients Lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_HISTODELDETAILS', 'ps_creer_histodeldetails', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTOVENTE', '12', '1', 'Historiques de ventes', 'Historiques de ventes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_officinall_traitement (t_officinall_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_officinall_traitement, 'OFFICINALL_HISTOVENTE', 'ps_creer_histovente', gen_id(seq_fct_fichier, 0));
