set sql dialect 3;

/* ********************************************************************************************** */
create table t_ipharma_traitement(
t_ipharma_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_ipharma_traitement primary key(t_ipharma_traitement_id));

alter table t_ipharma_traitement
add constraint fk_ipharma_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_ipharma_traitement;

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'OFFICINE.FDB', '10', '1', 'BD gstion officine', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TARIF.FDB', '10', '1', 'BD tarifs', null, next value for seq_grille_imp_fichiers);	

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Médecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_medecin', 'ps_ipharma_creer_medecin', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PROFILSREMISES', '12', '1', 'Profils remises', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_profil_remise', 'ps_ipharma_creer_profil_remise', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'GROUPES', '12', '1', 'Groupes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_groupe', 'ps_ipharma_creer_groupe', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTS', '12', '1', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_client', 'ps_ipharma_creer_client', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARMACIEN_REFERENT', '12', '1', 'Pharmacien référent', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_pharmacien_referent', 'ps_ipharma_pharmacien_referent', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'NOTES', '12', '1', 'Notes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_notes', 'ps_ipharma_creer_notes', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTSOA', '12', '1', 'Maj Assurabilités OA', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_client_oa', 'ps_ipharma_maj_client_oa', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTSOC', '12', '1', 'Maj Assurabilités OC', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_client_oc', 'ps_ipharma_maj_client_oc', gen_id(seq_fct_fichier, 0));

--aucun interet de créer des comptes ristourne avec clients virtuels
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTSVIRTUELS', '12', '1', 'Clients virtuels', 'grdClients', next value for seq_grille_imp_clients);
--insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_client_virtuel', 'ps_ipharma_creer_client_virtuel', gen_id(seq_fct_fichier, 0));

-- Les cartes sont créées avec les comptes
--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CARTESRISTOURNES', '12', '1', 'Cartes ristournes', 'grdClients', next value for seq_grille_imp_clients);
--insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_carte_ristourne', 'ps_ipharma_creer_carte_rist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTESRISTOURNES', '12', '1', 'Comptes ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_compte_ristourne', 'ps_ipharma_creer_compte_rist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TRANSACTIONSRISTOURNES', '12', '1', 'Transactions ristournes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_transaction_ristourne', 'ps_ipharma_creer_trans_rist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TARIFSPRODUITS', '12', '1', 'Tarifs produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_tarif_produit', 'ps_ipharma_creer_tarif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOURNISSEURS', '12', '1', 'Fournisseurs répartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_fournisseur', 'ps_ipharma_creer_fournisseur', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONESGEOGRAPHIQUES', '12', '1', 'Zones géographiques', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_zone_geographique', 'ps_ipharma_creer_zone_geo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'STOCKS', '12', '1', 'Produits - Stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_stock', 'ps_ipharma_creer_stock', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODESBARRES', '12', '1', 'Codes barres - CNK', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_code_barre', 'ps_ipharma_maj_code_barre', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRIX', '12', '1', 'Prix', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_prix', 'ps_ipharma_maj_prix', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DESIGNATIONS', '12', '1', 'Désignations', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_designation', 'ps_ipharma_maj_designation', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATIONS', '12', '1', 'Attestations', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_attestation', 'ps_ipharma_creer_attestation', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUEVENTE', '12', '1', 'Historique ventes', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_historique_vente', 'ps_ipharma_creer_histo_vente', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELDIF', '12', '1', 'Délivrances différées', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_deldif', 'ps_ipharma_creer_deldif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDIT', '12', '1', 'Crédits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_credit', 'ps_ipharma_creer_credit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AVANCEPRODUIT', '12', '1', 'Avances produits', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_avanceproduit', 'ps_ipharma_creer_avanceproduit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUEENTETES', '12', '1', 'Historiques clients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_historique_client', 'ps_ipharma_creer_histo_entete', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUELIGNES', '12', '1', 'Historiques clients lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_historique_client_ligne', 'ps_ipharma_creer_histo_ligne', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'LIBELLECHIMIQUE', '12', '1', 'Libellés Chimiques', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_libelle_chimique', 'ps_ipharma_creer_lib_chimique', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTORIQUEMAGIS', '12', '1', 'Historiques magistrales', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_ipharma_traitement (t_ipharma_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_ipharma_traitement, 'ipharma_historique_client_magis', 'ps_ipharma_creer_histo_lig_mag', gen_id(seq_fct_fichier, 0));


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
    t.t_ipharma_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_ipharma_traitement t
inner join t_fct_fichier f
on t.t_fct_fichier_id = f.t_fct_fichier_id;