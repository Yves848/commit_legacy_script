set sql dialect 3;

/* ********************************************************************************************** */
create table t_nextpharm_traitement(
t_nextpharm_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure,
t_fct_fichier_id dm_cle not null,
constraint pk_nextpharm_traitement primary key(t_nextpharm_traitement_id));

alter table t_nextpharm_traitement
add constraint fk_nextpharm_trait_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_nextpharm_traitement;

/* ********************************************************************************************** */
recreate view v_traitement_1(
    t_fct_fichier_id,
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
    f.t_fct_fichier_id,
    f.type_fichier,
    f.libelle,
    f.grille,
    f.ligne,
    t.t_nextpharm_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_nextpharm_traitement t
inner join t_fct_fichier f
on t.t_fct_fichier_id = f.t_fct_fichier_id;

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Next.wdd', '10', '1', 'Analyse Windev pour NextPharma', 'Analyse Windev pour NextPharma', null, 1);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Médecins.FIC', '10', '1',  'Medecins (données)', 'Medecins (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Médecins.NDX', '10', '1',  'Medecins (index)', 'Medecins (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Médecins.MMO', '10', '1',  'Medecins (memo)', 'Medecins (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Médecins.FTX', '10', '1',  'Medecins (index full text)', 'Medecins (index full text)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Adresses.FIC', '10', '1',  'Adresses (données)', 'Adresses (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Adresses.NDX', '10', '1',  'Adresses (index)', 'Adresses (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MedNumInami.FIC', '10', '1',  'Inami Médecins (données)', 'Inami Médecins (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MedNumInami.NDX', '10', '1',  'Inami Médecins (index)', 'Inami Médecins (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Patients.FIC', '10', '1',  'Patients (données)', 'Patients (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Patients.NDX', '10', '1',  'Patients (index)', 'Patients (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Patients.MMO', '10', '1',  'Patients (memo)', 'Patients (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Patients.FTX', '10', '1',  'Patients (index full text)', 'Patients (index full text)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIHabituelsPAT.FIC', '10', '1',  'Patients - suite (données)', 'Patients - suite (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIHabituelsPAT.NDX', '10', '1',  'Patients - suite (index)', 'Patients - suite (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Client.FIC', '10', '1',  'Clients (données)', 'Clients (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Client.NDX', '10', '1',  'Clients (index)', 'Clients (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Client.MMO', '10', '1',  'Clients (memo)', 'Clients (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Client.FTX', '10', '1',  'Clients (index full text)', 'Clients (index full text)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AttestationsPatients.FIC', '10', '1',  'Attestations (données)', 'Attestations (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AttestationsPatients.NDX', '10', '1',  'Attestations (index)', 'Attestations (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Localisations.FIC', '10', '1',  'Zones géographiques (données)', 'Zones géographiques (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Localisations.NDX', '10', '1',  'Zones géographiques (index)', 'Zones géographiques (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TarSpe.FIC', '10', '1',  'Tarifs Produits (données)', 'Tarifs Produits (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TarSpe.NDX', '10', '1',  'Tarifs Produits (index)', 'Tarifs Produits (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TarSpe.MMO', '10', '1',  'Tarifs Produits (memo)', 'Tarifs Produits (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TarSpe.FTX', '10', '1',  'Tarifs Produits (index full text)', 'Tarifs Produits (index full text)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Stock.FIC', '10', '1',  'Stock (données)', 'Stock (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Stock.NDX', '10', '1',  'Stock (index)', 'Stock (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TarPrixFour.FIC', '10', '1',  'Tarifs fournisseurs (données)', 'Tarifs fournisseurs (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'TarPrixFour.NDX', '10', '1',  'Tarifs fournisseurs (index)', 'Tarifs fournisseurs (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs.FIC', '10', '1',  'Fournisseurs (données)', 'Fournisseurs (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs.NDX', '10', '1',  'Fournisseurs (index)', 'Fournisseurs (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Fournisseurs.MMO', '10', '1',  'Fournisseurs (memo)', 'Fournisseurs (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AutresCodesBarresSpe.FIC', '10', '1',  'Codes barres (données)', 'Codes barres (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AutresCodesBarresSpe.NDX', '10', '1',  'Codes barres (index)', 'Codes barres (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DatePeremptionSpe.FIC', '10', '1',  'Péremption produits (données)', 'Péremption produits (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DatePeremptionSpe.NDX', '10', '1',  'Péremption produits (index)', 'Péremption produits (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Agenda.FIC', '10', '1',  'Litiges (données)', 'Litiges (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Agenda.NDX', '10', '1',  'Litiges (index)', 'Litiges (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Agenda.MMO', '10', '1',  'Litiges (memo)', 'Litiges (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Ventes.FIC', '10', '1',  'Ventes (données)', 'Ventes (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Ventes.NDX', '10', '1',  'Ventes (index)', 'Ventes (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Ventes.MMO', '10', '1',  'Ventes (memo)', 'Ventes (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'VentesReportées.FIC', '10', '1',  'Ventes Reportées (données)', 'Ventes Reportées (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'VentesReportées.NDX', '10', '1',  'Ventes Reportées (index)', 'Ventes Reportées (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CompteFid.FIC', '10', '1',  'Comptes fidélités (données)', 'Comptes fidélités (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CompteFid.NDX', '10', '1',  'Comptes fidélités (index)', 'Comptes fidélités (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Param.FIC', '10', '1',  'Paramètres (données)', 'Paramètres (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Param.NDX', '10', '1',  'Paramètres (index)', 'Paramètres (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'Param.MMO', '10', '1',  'Paramètres (memo)', 'Paramètres (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CartesFid.FIC', '10', '1',  'Cartes fidélités (données)', 'Cartes fidélités (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CartesFid.NDX', '10', '1',  'Cartes fidélités (index)', 'Cartes fidélités (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'EnteteMag.FIC', '10', '1',  'Ventes magistrales (données)', 'Ventes magistrales (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'EnteteMag.NDX', '10', '1',  'Ventes magistrales (index)', 'Ventes magistrales (index)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'EnteteMag.MMO', '10', '1',  'Ventes magistrales (memo)', 'Ventes magistrales (memo)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DetailMag.FIC', '10', '1',  'Ventes magistrales détails (données)', 'Ventes magistrales détails (données)', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DetailMag.NDX', '10', '1',  'Ventes magistrales détails (index)', 'Ventes magistrales détails (index)', null, next value for seq_grille_imp_fichiers);

/* grdPraticiens */	
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEDECINS', '12', '1', 'Medecins', 'Medecins', 'grdPraticiens', next value for seq_grille_imp_praticiens);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_MEDECINS', 'ps_creer_medecin', gen_id(seq_fct_fichier, 0));

/* grdClients*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PROFILREMISE', '12', '1', 'Profil de remise', 'Profil de remise', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_PROFILREMISE', 'ps_creer_profilremise', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PATIENTS', '12', '1', 'Patients', 'Patients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_PATIENTS', 'ps_creer_patient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CLIENTS', '12', '1', 'Clients', 'Clients', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_CLIENTS', 'ps_creer_patient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATION', '12', '1', 'Attestations Patient', 'Attestations Patient', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_ATTESTATION', 'ps_creer_attestation', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PHARMACIEN_REFERENCE', '12', '1', 'Pharmacien de référence', 'Pharmacien de référence', 'grdClients', next value for seq_grille_imp_clients);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_PHARMACIEN_REFERENCE', 'ps_nextpharm_upd_pha_ref', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ATTESTATION2', '12', '1', 'Maj Attestations Patient ', 'Maj Attestations Patient', 'grdClients', next value for seq_grille_imp_clients);
--insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_ATTESTATION2', 'ps_creer_attestation2', gen_id(seq_fct_fichier, 0));

/*grdProduits*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'ZONEGEO', '12', '1', 'Zone Géo', 'Zone Géo', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_ZONEGEO', 'ps_creer_zonegeo', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITS', '12', '1', 'Produits - stocks', 'Produits - stocks', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_PRODUITS', 'ps_creer_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITFOURNISSEURS', '12', '1', 'Produits-Fournisseurs', 'Produits-Fournisseurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_TARIF_PRODUIT', 'ps_creer_tarif_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FOUREP', '12', '1', 'Fournisseurs - Repartiteurs', 'Fournisseurs - Repartiteurs', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_FOUREP', 'ps_creer_fourep', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CODESBARRES', '12', '1', 'Codes-Barres', 'Codes-Barres', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_CODESBARRES', 'ps_creer_codesbarre', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCHEMA_PRODUIT', '12', '1', 'Schéma de médication - Produit', 'Schéma de médication - Produit', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_SCHEMA_PRODUIT', 'ps_creer_schema_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'SCHEMA_PRISE', '12', '1', 'Schéma de médication - Prise', 'Schéma de médication - Prise', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_SCHEMA_PRISE', 'ps_creer_schema_prise', gen_id(seq_fct_fichier, 0));


--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'FICHEANALYSE', '12', '1', 'Fiches d analyse', 'Fiches d analyse', 'grdProduits', next value for seq_grille_imp_produits);
--insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_FICHEANALYSE', 'ps_creer_ficheanalyse', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'PRODUITPEREMPTION', '12', '1', 'Produits - Peremption', 'Produits - Peremption', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_PRODUITPEREMPTION', 'ps_creer_produit_peremption', gen_id(seq_fct_fichier, 0));

/*grdEncours*/
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'AVANCEPRODUIT', '12', '1', 'Avance Produit', 'Avance Produit', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_AVANCEPRODUIT', 'ps_creer_avance_produit', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELDIF', '12', '1', 'Delivrances differees', 'Delivrances differees', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_DELDIF', 'ps_creer_deldif', gen_id(seq_fct_fichier, 0));

--insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'DELDIF2', '12', '1', 'Delivrances differees - suite', 'Delivrances differees - suite', 'grdEncours', next value for seq_grille_imp_encours);
--insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_DELDIF2', 'ps_creer_deldif', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CREDITCLIENT', '12', '1', 'Credit Client', 'Credit Client', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_CREDITCLIENT', 'ps_creer_creditclient', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'MEMOPATIENT', '12', '1', 'Memo Patient', 'Memo Patient', 'grdEncours', next value for seq_grille_imp_encours);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_MEMOPATIENT', 'ps_creer_memopatient', gen_id(seq_fct_fichier, 0));

/*grdAutresDonnees*/

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'COMPTERIST', '12', '1', 'Comptes et transactions Ristournes', 'Comptes et transacation ristournes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_COMPTERIST', 'ps_creer_compterist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'CARTERIST', '12', '1', 'Cartes Ristournes', 'Cartes ristournes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_CARTERIST', 'ps_creer_carterist', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELGENERAL', '12', '1', 'Historiques Patients', 'Historiques Patients', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_HISTODELGENERAL', 'ps_creer_histodelgeneral', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELDETAILS', '12', '1', 'Historiques Patients Lignes', 'Historiques Patients Lignes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_HISTODELDETAILS', 'ps_creer_histodeldetails', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTODELMAGIS', '12', '1', 'Historiques Patients Lignes Magistrales', 'Historiques Patients Lignes Magistrales', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_HISTODELMAGISTRALE', 'ps_creer_histodelmagistrale', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'HISTOVENTE', '12', '1', 'Historiques de ventes', 'Historiques de ventes', 'grdAutresDonnees', next value for seq_grille_imp_autres_donnees);
insert into t_nextpharm_traitement (t_nextpharm_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) values (next value for seq_nextpharm_traitement, 'NEXTPHARM_HISTOVENTE', 'ps_creer_histovente', gen_id(seq_fct_fichier, 0));
