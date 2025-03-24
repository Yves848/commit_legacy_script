set sql dialect 3;

/* ********************************************************************************************** */
create table t_parametre(
cle dm_code not null,
valeur dm_varchar150 not null);

create unique index unq_parametre on t_parametre(cle);

/* ********************************************************************************************** */
create table t_operateur(
t_operateur_id dm_varchar50 not null,
code_operateur dm_varchar10 not null,
nom dm_libelle not null,
prenom dm_libelle default '_' not null,
mot_de_passe dm_varchar50 not null,
activation_operateur dm_boolean default '1',
gravite_int dm_liste, -- inutile a effacer a terme 
recherche_int dm_liste,
constraint pk_operateur primary key (t_operateur_id));

alter table t_operateur
add constraint chk_op_not_null
check ((trim(t_operateur_id) <> '') and
       (trim(nom) <> ''));

alter table t_operateur
add constraint chk_op_gravite_int
check (gravite_int in ('0', '1', '2', '3', '4'));

create unique index unq_operateur on t_operateur(code_operateur);

/* ********************************************************************************************** */
create table t_destinataire(
t_destinataire_id dm_code not null,
num_ident dm_varchar20,
nom_util dm_varchar50,
mot_passe dm_varchar50,
serv_smtp dm_varchar50,
serv_pop3 dm_varchar50,
serv_dns dm_varchar50,
utilisateur_pop3 dm_varchar100,
mot_passe_pop3 dm_varchar50,
adresse_bal dm_varchar50,
no_appel dm_varchar50,
tempo dm_numeric4 default 60,
email_oct dm_varchar50,
nom dm_libelle not null,
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone,
tel_mobile dm_telephone,
fax dm_telephone,
application_oct dm_varchar2,
num_dest_oct dm_varchar20,
norme dm_liste,
norme_retour dm_liste,
nom_fic_aller dm_nom_fichier,
nom_fic_retour dm_nom_fichier,
commentaire dm_varchar100,
flux dm_varchar30,
zone_message varchar(37) default 'LGPI',
oct dm_boolean,
authentification dm_boolean,
typ dm_varchar2,
refuse_htp dm_boolean,
gestion_num_lots dm_boolean,
xsl dm_varchar50,
constraint pk_destinataire primary key (t_destinataire_id));

alter table t_destinataire
add constraint chk_dest_not_null
check (trim(nom) <> '');

alter table t_destinataire
add constraint chk_dest_norme 
check (norme in ('0', '1', '2', '3', '4'));

alter table t_destinataire
add constraint chk_dest_norme_retour 
check (norme_retour in ('0', '1', '2', '3', '4'));

alter table t_destinataire
add constraint fk_dest_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) 
on delete set null;

/* ********************************************************************************************** */
create table t_organisme(
t_organisme_id dm_code not null,
type_organisme dm_liste,
nom_reduit dm_varchar20 not null,
commentaire dm_commentaire,
commentaire_bloquant dm_commentaire,
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone, 
tel_mobile dm_telephone,
fax dm_telephone,
org_reference dm_boolean,
mt_seuil_tiers_payant dm_prix_vente,
accord_tiers_payant dm_boolean,
t_destinataire_id dm_code,
doc_facturation dm_numeric3,
type_releve dm_varchar10,
edition_releve dm_boolean,
frequence_releve dm_numeric3,
mt_seuil_ed_releve numeric(7,2),
t_ref_regime_id dm_cle,
caisse_gestionnaire dm_varchar3,
centre_gestionnaire dm_varchar4,
fin_droits_org_amc dm_boolean,
top_r dm_boolean,
org_circonscription dm_boolean,
org_conventionne dm_3etat,
nom dm_libelle,
org_sante_pharma dm_boolean,
identifiant_national dm_varchar9,
prise_en_charge_ame dm_boolean,
application_mt_mini_pc dm_liste,
type_contrat dm_numeric2 default 0,
saisie_no_adherent dm_boolean,
repris dm_boolean default '1',
t_ref_organisme_id dm_cle,
constraint pk_organisme primary key (t_organisme_id));

alter table t_organisme
add constraint chk_org_nom
check (trim(nom) <> '');

alter table t_organisme
add constraint chk_org_type_organisme
check (((type_organisme = '1') and ((fin_droits_org_amc is not null) and
                                    (top_r is not null) and
                                    (org_circonscription is not null))) or
       ((type_organisme = '2') and ((nom is not null) and
                                    (org_sante_pharma is not null) and
                                    (prise_en_charge_ame is not null) and
                                    (type_contrat is not null) and
                                    (saisie_no_adherent is not null))));

alter table t_organisme
add constraint chk_org_applicationmtminipc
check (((type_organisme = '1') and (application_mt_mini_pc in ('0', '1'))) or
       ((type_organisme = '2') and (application_mt_mini_pc in ('0', '2'))) or
       (application_mt_mini_pc is null));

alter table t_organisme
add constraint chk_org_doc_facturation
check (((type_organisme = '1') and (doc_facturation in (162, 204, -1))) or
       ((type_organisme = '2') and (doc_facturation in (5, -1))) or
       (doc_facturation is null));

alter table t_organisme
add constraint chk_org_identifiant_national
check ((type_organisme = '1') or
       ((type_organisme = '2') and (identifiant_national like '________%')));

alter table t_organisme
add constraint chk_org_type_releve
check (((type_organisme = '1') and (type_releve in ('0', '1', '2', '5'))) or
       ((type_organisme = '2') and (type_releve in ('0', '1', '2', '3', '4', '5'))) or
       (type_releve is null));

alter table t_organisme
add constraint fk_org_destinataire foreign key (t_destinataire_id)
references t_destinataire(t_destinataire_id)
on delete set null;

alter table t_organisme
add constraint fk_org_ref_regime foreign key(t_ref_regime_id)
references t_ref_regime(t_ref_regime_id)
on delete set null;

alter table t_organisme
add constraint fk_org_ref_organisme foreign key(t_ref_organisme_id)
references t_ref_organisme(t_ref_organisme_id)
on delete set null;

alter table t_organisme
add constraint fk_org_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) on delete set null;

create index idx_org_recherche_organisme_amo on t_organisme(t_ref_regime_id, caisse_gestionnaire, centre_gestionnaire);
create index idx_org_recherche_organisme_amc on t_ref_organisme(type_organisme, identifiant_national);

/* ********************************************************************************************** */
create table t_organisme_amo_ass_amc(
t_organisme_amo_ass_amc_id dm_cle not null,
t_organisme_amo_id dm_code not null,
t_organisme_amc_id dm_code not null,
top_mutualiste dm_boolean,
type_debiteur dm_liste,
type_contrat dm_numeric2 not null,
constraint pk_organisme_amo_ass_amc primary key (t_organisme_amo_ass_amc_id));

alter table t_organisme_amo_ass_amc
add constraint chk_amo_ass_amc_type_debiteur
check (type_debiteur in ('0', '1', '2'));

alter table t_organisme_amo_ass_amc
add constraint fk_amoassamc_organisme_amo foreign key (t_organisme_amo_id)
references t_organisme(t_organisme_id)
on delete cascade;

alter table t_organisme_amo_ass_amc
add constraint fk_amoassamc_organisme_amc foreign key (t_organisme_amc_id)
references t_organisme(t_organisme_id)
on delete cascade;

create unique index unq_organisme_amo_ass_amc on t_organisme_amo_ass_amc(t_organisme_amo_id, t_organisme_amc_id);

create sequence seq_organisme_amo_ass_amc;

/* ********************************************************************************************** */
create table t_couverture_amo(
t_couverture_amo_id dm_code not null,
t_organisme_amo_id dm_code,
ald dm_boolean,
libelle dm_libelle not null,
nature_assurance dm_numeric2,
justificatif_exo dm_justificatif_exo,
repris dm_boolean default '1',
t_ref_couverture_amo_id dm_cle,
constraint pk_couverture_amo primary key (t_couverture_amo_id));

alter table t_couverture_amo
add constraint chk_couvamo_libelle
check (trim(libelle) <> '');

alter table t_couverture_amo
add constraint fk_couv_amo_organisme_amo foreign key (t_organisme_amo_id)
references t_organisme(t_organisme_id)
on delete cascade;

alter table t_couverture_amo
add constraint fk_couv_amo_ref_couv_amo foreign key(t_ref_couverture_amo_id)
references t_ref_couverture_amo(t_ref_couverture_amo_id)
on delete set null;

create unique index idx_couverture_amo on t_couverture_amo(t_couverture_amo_id, t_organisme_amo_id);

/* ********************************************************************************************** */
create table t_couverture_amc(
t_couverture_amc_id dm_code not null,
t_organisme_amc_id dm_code,
libelle dm_varchar60 not null,
montant_franchise dm_prix_vente not null,
plafond_prise_en_charge dm_prix_vente not null,
formule dm_formule,
couverture_cmu dm_boolean,
constraint pk_couverture_amc primary key (t_couverture_amc_id));

alter table t_couverture_amc
add constraint chk_couvamc_libelle
check (trim(libelle) <> '');

alter table t_couverture_amc
add constraint fk_couv_amc_organisme_amc foreign key (t_organisme_amc_id)
references t_organisme(t_organisme_id)
on delete cascade;

create unique index idx_couverture_amc on t_couverture_amc(t_couverture_amc_id, t_organisme_amc_id);

/* ********************************************************************************************** */
create table t_taux_prise_en_charge(
t_taux_prise_en_charge_id dm_cle not null,
t_couverture_amo_id dm_code,
t_couverture_amc_id dm_code,
t_ref_prestation_id dm_cle not null,
taux dm_prix_vente not null,
formule dm_formule,
constraint pk_taux_prise_en_charge primary key (t_taux_prise_en_charge_id));

alter table t_taux_prise_en_charge
add constraint chk_taux_couverture
check ((t_couverture_amo_id is not null) or
       (t_couverture_amc_id is not null));

alter table t_taux_prise_en_charge
add constraint fk_taux_couverture_amo foreign key (t_couverture_amo_id)
references t_couverture_amo(t_couverture_amo_id)
on delete cascade;

alter table t_taux_prise_en_charge
add constraint fk_taux_couverture_amc foreign key (t_couverture_amc_id)
references t_couverture_amc(t_couverture_amc_id)
on delete cascade;

alter table t_taux_prise_en_charge
add constraint fk_taux_prestation foreign key (t_ref_prestation_id)
references t_ref_prestation(t_ref_prestation_id);

create unique index unq_taux_prise_en_charge on t_taux_prise_en_charge(t_couverture_amo_id, t_couverture_amc_id, t_ref_prestation_id);
create index idx_tpec_couverture_amo on t_taux_prise_en_charge(t_couverture_amo_id, t_ref_prestation_id);
create index idx_tpec_couverture_amc on t_taux_prise_en_charge(t_couverture_amc_id, t_ref_prestation_id);

create sequence seq_taux_prise_en_charge;

/* ********************************************************************************************** */
create table t_hopital(
t_hopital_id dm_code not null,
nom dm_libelle not null,
commentaire dm_commentaire,
no_finess dm_varchar9 not null,
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone, 
tel_mobile dm_telephone,
fax dm_telephone,
repris dm_boolean default '1',
constraint pk_hopital primary key (t_hopital_id));

alter table t_hopital
add constraint chk_hop_not_null
check ((trim(nom) <> '') and
       (trim(no_finess) <> ''));

alter table t_hopital
add constraint fk_hop_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) on delete set null;

/* ********************************************************************************************** */
create table t_praticien(
t_praticien_id dm_code not null,
type_praticien dm_liste default '1',
nom dm_libelle not null,--50
prenom dm_libelle default '_' not null,
t_ref_specialite_id dm_cle not null,
rue_1 dm_rue,--40
rue_2 dm_rue,
code_postal dm_code_postal,--5
nom_ville dm_nom_ville,--30
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,--20
tel_standard dm_telephone, 
tel_mobile dm_telephone,
fax dm_telephone,
email dm_varchar50,
t_hopital_id dm_code,
agree_ratp dm_boolean, --inutile
commentaire dm_commentaire,--200
no_finess dm_finess,--9,
num_rpps dm_rpps,--11
date_dern_prescription dm_date,
veterinaire dm_boolean, 

repris dm_boolean default '1',
constraint pk_praticien primary key (t_praticien_id));

alter table t_praticien
add constraint chk_prat_not_null
check ((trim(nom) <> '') and
       (trim(prenom) <> ''));
       
--alter table t_praticien add constraint chk_type_praticien_prive
--check (((type_praticien = '1') and ((num_rpps similar to '[[:DIGIT:]]{11}') or (num_rpps is null) )) or (type_praticien = '2'));
								  
alter table t_praticien add constraint chk_type_praticien_hosp
check (((type_praticien = '2') and (t_hopital_id is not null)) or (type_praticien = '1')) ;

alter table t_praticien
add constraint fk_prat_hopital foreign key (t_hopital_id)
references t_hopital(t_hopital_id)
on delete cascade;


alter table t_praticien
add constraint fk_prat_specialite foreign key(t_ref_specialite_id)
references t_ref_specialite(t_ref_specialite_id)
on delete cascade;

alter table t_praticien
add constraint fk_prat_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) 
on delete set null;

create index idx_prat_finess on t_praticien(no_finess);
/* ********************************************************************************************** */
create table t_client(
t_client_id dm_code not null,
numero_insee dm_varchar15,
nom dm_varchar30 not null,
prenom dm_varchar30,
nom_jeune_fille dm_varchar30,
commentaire_global dm_commentaire_long,
commentaire_global_bloquant dm_boolean,
commentaire_individuel dm_commentaire_long,
commentaire_individuel_bloquant dm_boolean,
date_naissance dm_date_naissance,
qualite dm_varchar2 not null,
rang_gemellaire dm_numeric1 default 1 not null,
nat_piece_justif_droit dm_liste default '0',
date_validite_piece_justif dm_date,
t_organisme_amo_id dm_code,
t_organisme_at_id dm_code,
t_organisme_a115_id dm_code,
centre_gestionnaire dm_varchar4,
t_organisme_amc_id dm_code,
numero_adherent_mutuelle dm_numero_adherent,
contrat_sante_pharma dm_contrat_sante_pharma,
t_couverture_amc_id dm_code,
debut_droit_amc dm_date,
attestation_ame_complementaire dm_liste default null,
fin_droit_amc dm_date,
mutuelle_lue_sur_carte dm_liste,
mode_gestion_amc dm_mode_gestion_amc default '2',
date_derniere_visite dm_date,
t_assure_rattache_id dm_code,
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone,
tel_mobile dm_telephone,
fax dm_telephone,
email dm_varchar50,
activite dm_varchar50,
date_creation dm_date,
genre dm_liste default null,
ref_externe varchar(20),
repris dm_boolean default '1',
constraint pk_client primary key (t_client_id));

alter table t_client
add constraint chk_cli_not_null
check (trim(nom) <> '');

alter table t_client
add constraint chk_cli_qualite
check (qualite in ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9'));

alter table t_client
add constraint chk_cli_mutuelle_lue_sur_carte
check (mutuelle_lue_sur_carte in ('0', '1', '2'));

alter table t_client
add constraint chk_cli_nat_piece_justif_droit
check (nat_piece_justif_droit in ('0', '1', '2', '4', ' '));
-- Cas 5 = ADRI mais remis à 0 car pas droit jorunalier donc pas besoin de la reprendre 
   
alter table t_client
add constraint chk_cli_genre
check ((genre in ('F', 'H')) or
       (genre is null));

alter table t_client
add constraint chk_cli_rang_gemellaire
check ((rang_gemellaire >= 1) and (rang_gemellaire <=9));

alter table t_client
add constraint fk_cli_organisme_amo foreign key (t_organisme_amo_id)
references t_organisme(t_organisme_id)
on delete set null;

alter table t_client
add constraint fk_cli_organisme_at foreign key (t_organisme_at_id)
references t_organisme(t_organisme_id)
on delete set null;

alter table t_client
add constraint fk_cli_organisme_a115 foreign key (t_organisme_a115_id)
references t_organisme(t_organisme_id)
on delete set null;

alter table t_client
add constraint fk_cli_organisme_amc foreign key (t_organisme_amc_id)
references t_organisme(t_organisme_id)
on delete set null;

alter table t_client
add constraint fk_cli_couverture_amc foreign key (t_couverture_amc_id)
references t_couverture_amc(t_couverture_amc_id)
on delete set null;

alter table t_client
add constraint fk_cli_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) 
on delete set null;


create index idx_assure_rattache on t_client(t_assure_rattache_id);


/* ********************************************************************************************** */

create table t_mandataire( 
t_client_id dm_code not null,
t_mandataire_id dm_code,
type_lien integer,
constraint pk_client_mandataire primary key (t_client_id));

alter table t_mandataire 
add constraint fk_mandataire_cli foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_mandataire 
add constraint fk_mandataire_man foreign key (t_mandataire_id)
references t_client(t_client_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_couverture_amo_client(
t_couverture_amo_client_id dm_cle not null,
t_client_id dm_code not null,
t_couverture_amo_id dm_code not null,
debut_droit_amo dm_date,
fin_droit_amo dm_date,
constraint pk_couverture_amo_client primary key(t_couverture_amo_client_id));

alter table t_couverture_amo_client
add constraint fk_couvcli_client foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_couverture_amo_client
add constraint fk_couvcli_couvertureamo foreign key (t_couverture_amo_id)
references t_couverture_amo(t_couverture_amo_id)
on delete cascade;

--create unique index unq_couverture_amo_client on t_couverture_amo_client(t_client_id, t_couverture_amo_id);

create sequence seq_couverture_amo_client;

/* ********************************************************************************************** */
create table t_historique_praticien(
t_historique_praticien_id dm_cle not null,
t_client_id dm_code not null,
t_praticien_id dm_code not null,
constraint pk_historique_praticien primary key(t_historique_praticien_id));

alter table t_historique_praticien
add constraint fk_hstprat_client foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_historique_praticien
add constraint fk_hstprat_praticien foreign key(t_praticien_id)
references t_praticien(t_praticien_id)
on delete cascade;

create unique index unq_historique_praticien on t_historique_praticien(t_client_id, t_praticien_id);

create sequence seq_historique_praticien;

/* ********************************************************************************************** */
create table t_fournisseur_direct(
t_fournisseur_direct_id dm_code not null,
raison_sociale dm_libelle not null,
identifiant_171 dm_identifiant_171,
numero_appel dm_telephone,
commentaire dm_commentaire,
commentaire_171 dm_commentaire,
vitesse_171 dm_vitesse_171 default '1',
pause_171 dm_boolean,
nombre_tentatives dm_numeric3 default 0 not null,
mode_transmission dm_mode_transmission,
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone,
tel_mobile dm_telephone,
fax dm_telephone,
fournisseur_partenaire dm_boolean,
represente_par dm_varchar50,
telephone_representant dm_telephone,
mobile_representant dm_telephone,
numero_fax dm_telephone,
email dm_varchar50,
email_representant dm_varchar50,
code_partenaire dm_numeric4,
monogamme dm_3etat,
id_pharmacie dm_varchar10,
code_sel dm_varchar20,
pharmaml_ref_id dm_numeric3,
pharmaml_url_1 dm_varchar150,
pharmaml_url_2 dm_varchar150,
pharmaml_id_officine dm_varchar20,
pharmaml_id_magasin dm_varchar20,
pharmaml_cle dm_varchar4,
constraint pk_fournisseur_direct primary key (t_fournisseur_direct_id));

alter table t_fournisseur_direct
add constraint chk_fd_raison_sociale
check (trim(raison_sociale) <> '');

alter table t_fournisseur_direct
add constraint fk_fd_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) 
on delete set null;

/* ********************************************************************************************** */
create table t_repartiteur(
t_repartiteur_id dm_code not null,
raison_sociale dm_libelle not null,
identifiant_171 dm_identifiant_171,
numero_appel dm_telephone,
commentaire dm_commentaire,
commentaire_171 dm_commentaire,
vitesse_171 dm_vitesse_171 default '1',
pause_171 dm_boolean,
nombre_tentatives dm_numeric3 default 0 not null,
mode_transmission dm_mode_transmission default '1',
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone,
tel_mobile dm_telephone,
fax dm_telephone,
defaut dm_boolean,
objectif_ca_mensuel dm_chiffre_affaire default 0 not null,
monogamme dm_char1 default null,
t_reaffectation_manquants_id dm_code,
numero_fax dm_telephone,
email dm_varchar50,
id_pharmacie dm_varchar10,
pharmaml_ref_id dm_numeric3,
pharmaml_url_1 dm_varchar150,
pharmaml_url_2 dm_varchar150,
pharmaml_id_officine dm_varchar20,
pharmaml_id_magasin dm_varchar20,
pharmaml_cle dm_varchar4,
constraint pk_repartiteur primary key (t_repartiteur_id));

alter table t_repartiteur
add constraint chk_rep_raison_sociale
check (trim(raison_sociale) <> '');

alter table t_repartiteur
add constraint fk_rep_reaffectation_manquants foreign key (t_reaffectation_manquants_id)
references t_repartiteur(t_repartiteur_id)
on delete set null;

alter table t_repartiteur
add constraint fk_rep_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) 
on delete set null;

/* ********************************************************************************************** */
create table t_codification(
t_codification_id dm_cle not null,
code dm_code not null,
libelle dm_libelle not null,
rang dm_liste not null,
taux_marque dm_taux_marque,
constraint pk_codif primary key(t_codification_id));

alter table t_codification 
add constraint chk_cdf_libelle
check (trim(libelle) <> '');

alter table t_codification
add constraint chk_cdf_rang
check (rang in ('1', '2', '3', '4', '5', '6', '7'));

create unique index unq_codification on t_codification(code, rang);

create sequence seq_codification;

/* ********************************************************************************************** */
create table t_classification_interne(
t_classification_interne_id dm_code not null,
libelle dm_libelle not null,
taux_marque dm_taux_marque,
t_class_interne_parent_id dm_code,
constraint pk_t_classification_interne primary key (t_classification_interne_id));

alter table t_classification_interne
add constraint chk_clintprt_libelle
check (trim(libelle) <> '');

alter table t_classification_interne
add constraint chk_clintprt_parent
check (trim(t_class_interne_parent_id) <> '');

alter table t_classification_interne
add constraint fk_clintprt_clintprt foreign key(t_class_interne_parent_id)
references t_classification_interne(t_classification_interne_id)
on delete cascade;

create unique index unq_classification_interne on t_classification_interne(t_class_interne_parent_id, t_classification_interne_id);

/* ********************************************************************************************** */
create table t_article_remise(
t_article_remise_id dm_code not null,
code dm_varchar10 not null,
libelle dm_libelle,
constraint pk_article_remise primary key(t_article_remise_id));

/* ********************************************************************************************** */
create table t_produit(
t_produit_id dm_code not null,
code_cip dm_code_cip,
designation dm_libelle not null, 
prix_achat_catalogue dm_prix_achat not null,  
prix_vente dm_prix_vente not null, 
base_remboursement dm_prix_vente,
etat dm_liste default '1',
delai_viande dm_numeric3, 
delai_lait dm_numeric3, 
delai_oeuf dm_numeric3,
gere_interessement dm_boolean, 
commentaire_vente dm_commentaire, 
edition_etiquette dm_boolean,
commentaire_commande dm_commentaire, 
commentaire_gestion dm_commentaire, 
t_ref_prestation_id dm_cle not null, 
gere_suivi_client dm_boolean,
t_ref_tva_id dm_cle,
liste dm_liste, 
tracabilite dm_boolean, 
lot_achat dm_numeric5, 
lot_vente dm_numeric5, 
stock_mini dm_quantite default 0 not null, 
stock_maxi dm_quantite default 0,
pamp dm_prix_achat, 
tarif_achat_unique dm_3etat,
profil_gs dm_liste, 
calcul_gs dm_liste, 
nombre_mois_calcul dm_numeric2, 
gere_pfc dm_boolean, 
soumis_mdl dm_3etat, 
t_classification_interne_id dm_code,
conditionnement dm_numeric3, 
moyenne_vente dm_moyenne_vente ,
unite_moyenne_vente dm_quantite,
date_derniere_vente dm_date, 
contenance dm_quantite, 
unite_mesure dm_liste, 
prix_achat_remise dm_prix_achat default 0 not null,
veterinaire dm_boolean, 
service_tips dm_liste default null, 
type_homeo dm_liste,
t_repartiteur_id dm_code,
t_codif_1_id dm_cle,
t_codif_2_id dm_cle,
t_codif_3_id dm_cle,
t_codif_4_id dm_cle,
t_codif_5_id dm_cle,
t_codif_6_id dm_cle,
t_codif_7_id dm_cle,
mode_stockage dm_varchar50,
repris dm_boolean default '1',
materiel_location dm_boolean default '0',
caution dm_prix_vente, 
gere_par_no_serie dm_boolean default '0',
nombre_mois_renouvellement dm_quantite,
t_ref_produit_location_id dm_cle,
date_peremption dm_date,
prix_vente_metropole dm_prix_vente,
prix_achat_metropole dm_prix_achat,
code_cip7 dm_code_cip7,
t_article_remise_id dm_code,
t_produit_bdm_id dm_code,
t_package_bdm_id dm_code,
constraint pk_produit primary key (t_produit_id));

/* **************** */
-- 0 => En vigueur
-- 1 => En vigueur
-- 2 => Ne se fait plus
-- 3 => Fabrication suspendue
-- 4 => Produit en vente interdite
-- 5 => Produit remplac
-- 8 => Statut inconnu
/* **************** */
alter table t_produit
add constraint chk_prd_etat
check (etat in ('1', '2', '3', '4', '5', '8'));

alter table t_produit
add constraint chk_prd_liste
check (liste in ('0', '1', '2', '3'));

/* **************** */
-- 0 => Profil par défaut
-- 1 => Historique seul
-- 2 => Historique + stock
-- 3 => Historique + stock + commande
/* **************** */
alter table t_produit
add constraint chk_prd_profil_gs
check ((profil_gs in ('0', '1', '2', '3')) or
       (profil_gs is null));

/* **************** */
-- 0 => Calcul par défaut
-- 1 => Automatique
-- 4 => Fixé
-- 5 => Commande = quantité vendue
/* **************** */
alter table t_produit
add constraint chk_prd_calcul_gs
check ((calcul_gs in ('0', '1', '4', '5')) or
       (calcul_gs is null));

/* **************** */
-- 1 => Kilogramme
-- 2 => Gramme
-- 3 => Décigramme
-- 4 => Centigramme
-- 5 => Milligramme
-- 6 => Litres
-- 7 => Décilitres
-- 8 => Centilitres
-- 9 => Millilitres
/* **************** */
alter table t_produit
add constraint chk_prd_unite_mesure
check ((unite_mesure in ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')) or
       (unite_mesure is null));

/* **************** */
-- A => Achat
-- E => Entretien
-- L => Location
-- P => Frais de port
-- R => Rparation
-- S => Service
/* **************** */
alter table t_produit
add constraint chk_prd_service_tips
check ((service_tips in ('A', 'E', 'L', 'P', 'R', 'V', 'S')) or
       (service_tips is null));

alter table t_produit
add constraint chk_prd_type_homeo
check (type_homeo in ('0', '1', '2'));

alter table t_produit
add constraint fk_prd_prestation foreign key(t_ref_prestation_id)
references t_ref_prestation(t_ref_prestation_id)
on delete cascade;

alter table t_produit
add constraint fk_prd_repartiteur foreign key (t_repartiteur_id)
references t_repartiteur (t_repartiteur_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_1 foreign key (t_codif_1_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_2 foreign key (t_codif_2_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_3 foreign key (t_codif_3_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_4 foreign key (t_codif_4_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_5 foreign key (t_codif_5_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_6 foreign key (t_codif_6_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_prd_codif_7 foreign key (t_codif_7_id)
references t_codification(t_codification_id)
on delete set null;

alter table t_produit
add constraint fk_article_remise foreign key (t_article_remise_id)
references t_article_remise (t_article_remise_id)
on delete set null;

create index idx_prd_code_cip on t_produit(code_cip);
create index idx_prd_code_cip7 on t_produit(code_cip7);

/* ********************************************************************************************** */
create table t_code_ean13(
t_code_ean13_id dm_cle not null,
t_produit_id dm_code not null,
code_ean13 dm_varchar13 not null,
referent dm_boolean default 0 not null,
constraint pk_code_ean13 primary key(t_code_ean13_id));

alter table t_code_ean13
add constraint chk_ean_non_vide
check (trim(code_ean13) <> '');

alter table t_code_ean13
add constraint chk_ean_longueur_13
check (  code_ean13 SIMILAR TO '[[:DIGIT:]]{13}' );

alter table t_code_ean13
add constraint fk_ean_produit foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

create unique index unq_code_ean13 on t_code_ean13(t_produit_id, code_ean13);
create index idx_code_ean13 on t_code_ean13(code_ean13);

create sequence seq_code_ean13;

/* ********************************************************************************************** */
create table t_depot(
t_depot_id dm_code not null,
libelle dm_libelle not null,
automate dm_boolean,
type_depot dm_type_depot not null,
constraint pk_depot primary key(t_depot_id));

alter table t_depot
add constraint chk_depot_libelle
check (trim(libelle) <> '');

create sequence seq_depot;

/* ********************************************************************************************** */



create table t_zone_geographique(
t_zone_geographique_id dm_code not null,
libelle dm_libelle not null,
gestion_automate dm_varchar50, /*  a virer ? */
constraint pk_zonegeographique primary key(t_zone_geographique_id));

alter table t_zone_geographique
add constraint chk_zonegeo_libelle
check (trim(libelle) <> '');

/* ********************************************************************************************** */
create table t_produit_geographique(
t_produit_geographique_id dm_cle not null,
t_produit_id dm_code not null,
t_zone_geographique_id dm_code,
quantite dm_quantite not null,
t_depot_id dm_code not null,
stock_mini dm_quantite default 0 not null,
stock_maxi dm_quantite,
constraint pk_produitgeographique primary key(t_produit_geographique_id));

alter table t_produit_geographique
add constraint fk_prdgeo_produit foreign key(t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_produit_geographique
add constraint fk_prdgeo_zonegeo foreign key(t_zone_geographique_id)
references t_zone_geographique(t_zone_geographique_id)
on delete cascade;

alter table t_produit_geographique
add constraint fk_prdgeo_depot foreign key(t_depot_id)
references t_depot(t_depot_id)
on delete cascade;

create unique index unq_produit_geographique on t_produit_geographique(t_produit_id, t_zone_geographique_id, t_depot_id);

create sequence seq_produit_geographique;

/* ********************************************************************************************** */
create table t_historique_vente(
t_historique_vente_id dm_cle not null,
t_produit_id dm_code not null,
periode dm_periode not null,
periode_annee computed by (cast(substring(periode from 3 for 4) || '-' ||
                                substring(periode from 1 for 2) || '-01' as date)),
quantite_actes dm_quantite not null,
quantite_vendues dm_quantite not null,
repris dm_boolean default '1',
constraint pk_historiquevente primary key (t_historique_vente_id));

alter table t_historique_vente
add constraint chk_hstvte_quantite
check ((quantite_actes >= 0) and (quantite_vendues >= 0));

alter table t_historique_vente
add constraint fk_histvte_produit foreign key (t_produit_id)
references t_produit (t_produit_id)
on delete cascade;

create unique index unq_historique_vente on t_historique_vente(t_produit_id, periode);

create sequence seq_historique_vente;

/* ********************************************************************************************** */
create table t_historique_client(
t_historique_client_id dm_code not null,
t_client_id dm_code,
numero_facture dm_numeric10 not null,
date_prescription dm_date,
code_operateur dm_varchar10,
t_praticien_id dm_code,
nom_praticien dm_varchar50,
prenom_praticien dm_varchar50,
type_facturation dm_varchar2 not null,
date_acte date,
transferee dm_boolean,
repris dm_boolean default '1',
constraint pk_historique_client primary key (t_historique_client_id));

alter table t_historique_client
add constraint fk_client_histcli foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_historique_client
add constraint chk_histcli_type_facturation
check ((type_facturation in ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '14', '15', '16')) or
       (type_facturation is null));

create index idx_histcli_numero_facture on t_historique_client(numero_facture);

/* ********************************************************************************************** */
create table t_historique_client_ligne(
t_historique_client_ligne_id dm_cle not null,
t_historique_client_id dm_code not null,
code_cip numeric(18),
t_produit_id dm_code, 
designation dm_varchar50,
quantite_facturee dm_quantite,
prix_achat dm_prix_vente,
prix_vente dm_prix_vente,
montant_net_ht dm_prix_vente,
montant_net_ttc dm_prix_vente,
prix_achat_ht_remise dm_prix_achat,
transferee dm_boolean,
constraint pk_historique_client_ligne primary key (t_historique_client_ligne_id));

alter table t_historique_client_ligne
add constraint fk_histclil_histcli foreign key (t_historique_client_id)
references t_historique_client(t_historique_client_id)
on delete cascade;

alter table t_historique_client_ligne
add constraint fk_produit_histcli foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

--create unique index unq_historique_client_ligne on t_historique_client_ligne(t_historique_client_id, code_cip);

create sequence seq_historique_client_ligne;

/* ********************************************************************************************** */

create table t_commentaire(
t_commentaire_id dm_code not null,      
t_entite_id dm_code not null,
type_entite integer not null, -- 0 = client  1= fournisseur  le reste semble inutilisé pour l'instant  2=produit 3=FACTURE_MISE_EN_ATTENTE
commentaire blob sub_type 1,
est_global dm_boolean default '0',
est_bloquant dm_boolean default '0',
constraint pk_commentaire primary key (t_commentaire_id));

alter table t_commentaire add constraint chk_type_entite
check (type_entite in (0,1,2)); -- plus tard on ajoutera les autres types praticiens fournisseurs produits etc

create sequence seq_commentaire;

commit;
