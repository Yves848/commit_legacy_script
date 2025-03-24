set sql dialect 3;

/* ********************************************************************************************** */

create table t_ref_hopital(
    t_ref_hopital_id dm_cle not null,
    nom            varchar(60),
    rue_1          dm_rue,
    rue_2          dm_rue,
    code_postal    dm_code_postal,
    nom_ville      dm_nom_ville,
    telephone      dm_telephone,
    fax            dm_telephone,
    numero_finess  varchar(9) not null
);
alter table t_ref_hopital add constraint pk_ref_finess primary key ( numero_finess );
create unique index unq_ref_hopital_id on t_ref_hopital(t_ref_hopital_id);

create sequence seq_ref_hopitaux;

/* ********************************************************************************************** */
create table t_ref_specialite(
t_ref_specialite_id dm_cle not null,
code dm_char2 not null,
libelle dm_libelle not null,
constraint pk_ref_specialite primary key(t_ref_specialite_id));

create unique index unq_ref_specialite on t_ref_specialite(code);

create sequence seq_ref_specialite;

/* ********************************************************************************************** */
create table t_ref_prestation(
t_ref_prestation_id dm_cle not null,
code dm_code_prestation not null,
code_taux dm_liste not null,
est_tips dm_boolean  not null,
priorite dm_numeric3 not null,
est_lpp dm_boolean not null,
constraint pk_ref_prestation primary key (t_ref_prestation_id));

alter table t_ref_prestation
add constraint chk_r_prest_not_null
check ((trim(code) <> '') and
       (trim(code_taux) <> ''));
       
alter table t_ref_prestation
add constraint chk_r_prest_code_taux
check (code_taux in ('0', '1', '4', '5', '6', '7', '8'));

create unique index unq_ref_prestation on t_ref_prestation(code);
create unique index idx_r_prest_priorite on t_ref_prestation(priorite);

/* ********************************************************************************************** */
create table t_ref_regime(
t_ref_regime_id dm_cle not null,
code dm_varchar2 not null,
libelle dm_varchar80 not null,
sans_centre_gestionnaire dm_boolean not null,
constraint pk_ref_regime primary key(t_ref_regime_id));

alter table t_ref_regime
add constraint chk_r_reg_not_null
check ((trim(code) <> '') and 
       (trim(libelle) <> '') and
       (trim(sans_centre_gestionnaire) <> ''));

create unique index unq_ref_regime on t_ref_regime(code);

/* ********************************************************************************************** */
create table t_ref_cp_ville(
t_ref_cp_ville_id dm_cle not null,
code_postal dm_code_postal not null,
nom_ville dm_nom_ville not null,
constraint pk_ref_cpville primary key(t_ref_cp_ville_id));

create unique index unq_ref_cp_ville on t_ref_cp_ville(code_postal, nom_ville);

create sequence seq_ref_cp_ville;

/* ********************************************************************************************** */
create table t_ref_organisme(
t_ref_organisme_id dm_cle not null,
type_organisme dm_type_organisme,
t_ref_regime_id dm_cle,
caisse_gestionnaire dm_varchar3,
centre_gestionnaire dm_varchar4,
identifiant_national dm_varchar9,
nom dm_libelle not null,
nom_reduit dm_varchar20,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
tel_standard dm_telephone,
tel_personnel dm_telephone,
tel_mobile dm_telephone,
fax dm_telephone,
constraint pk_ref_organisme primary key (t_ref_organisme_id));

alter table t_ref_organisme
add constraint chk_r_org_not_null
check (trim(nom) <> '');

alter table t_ref_organisme
add constraint chk_r_org_type_organisme
check (((type_organisme = '1') and (t_ref_regime_id is not null) and
                                   (caisse_gestionnaire is not null) and (caisse_gestionnaire <> '') and
                                   (centre_gestionnaire is null) or (centre_gestionnaire <> '')) or
       ((type_organisme <> '2') and (identifiant_national is not null) and (identifiant_national <> '')));

alter table t_ref_organisme
add constraint fk_r_org_regime foreign key(t_ref_regime_id)
references t_ref_regime(t_ref_regime_id)
on delete cascade;

create unique index unq_ref_organisme on t_ref_organisme(t_ref_regime_id, caisse_gestionnaire, centre_gestionnaire);
create index idx_r_org_recherche_amc on t_ref_organisme(type_organisme, identifiant_national);
create sequence seq_ref_organisme;

/* ********************************************************************************************** */
create table t_ref_couverture_amo(
t_ref_couverture_amo_id dm_cle not null,
code_couverture dm_char5 not null,
libelle dm_varchar60 not null,
justificatif_exo dm_justificatif_exo not null,
constraint pk_ref_couverture_amo primary key (t_ref_couverture_amo_id));

alter table t_ref_couverture_amo
add constraint chk_r_couv_amo_not_null
check ((trim(code_couverture) <> '') and
       (trim(libelle) <> ''));

create unique index unq_ref_couvertureamo on t_ref_couverture_amo(code_couverture);

/* ********************************************************************************************** */
create table t_ref_couverture_organisme_amo(
t_ref_organisme_amo_id dm_cle not null,
t_ref_couverture_amo_id dm_cle not null,
constraint pk_ref_couverture_organisme_amo primary key(t_ref_organisme_amo_id, t_ref_couverture_amo_id));

alter table t_ref_couverture_organisme_amo
add constraint fk_r_couvorgamo_organisme_amo foreign key (t_ref_organisme_amo_id)
references t_ref_organisme (t_ref_organisme_id)
on delete cascade;

alter table t_ref_couverture_organisme_amo
add constraint fk_r_couvorgamo_couverture_amo foreign key (t_ref_couverture_amo_id)
references t_ref_couverture_amo (t_ref_couverture_amo_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_ref_couverture_amc(
t_ref_couverture_amc_id dm_cle not null,
t_ref_organisme_amc_id dm_cle,
libelle dm_varchar60 not null,
couverture_cmu dm_boolean,
constraint pk_ref_couverture_amc primary key (t_ref_couverture_amc_id));

alter table t_ref_couverture_amc
add constraint chk_r_couvamc_not_null
check (libelle <> '');

alter table t_ref_couverture_amc
add constraint fk_r_couvamc_organisme_amc foreign key(t_ref_organisme_amc_id)
references t_ref_organisme(t_ref_organisme_id)
on delete cascade;

create sequence seq_ref_couverture_amc;

/* ********************************************************************************************** */
create table t_ref_taux_prise_en_charge(
t_ref_taux_prise_en_charge_id dm_cle not null,
t_ref_couverture_amo_id dm_cle,
t_ref_couverture_amc_id dm_cle,
t_ref_prestation_id dm_cle not null,
taux dm_numeric3 not null,
constraint pk_ref_taux_prise_en_charge primary key(t_ref_taux_prise_en_charge_id));

alter table t_ref_taux_prise_en_charge
add constraint chk_r_taux_couverture
check ((t_ref_couverture_amo_id is not null) or
       (t_ref_couverture_amc_id is not null));

alter table t_ref_taux_prise_en_charge
add constraint fk_r_taux_couverture_amo foreign key (t_ref_couverture_amo_id)
references t_ref_couverture_amo(t_ref_couverture_amo_id)
on delete cascade;

alter table t_ref_taux_prise_en_charge
add constraint fk_r_taux_couverture_amc foreign key (t_ref_couverture_amc_id)
references t_ref_couverture_amc(t_ref_couverture_amc_id)
on delete cascade;

alter table t_ref_taux_prise_en_charge
add constraint fk_r_taux_prestation foreign key (t_ref_prestation_id)
references t_ref_prestation (t_ref_prestation_id)
on delete cascade;

create index unq_ref_taux_amo on t_ref_taux_prise_en_charge(t_ref_couverture_amo_id, t_ref_prestation_id);
create index unq_ref_taux_amc on t_ref_taux_prise_en_charge(t_ref_couverture_amc_id, t_ref_prestation_id);

create sequence seq_ref_taux_prise_en_charge;

/* ********************************************************************************************** */
create table t_ref_tva(
t_ref_tva_id dm_cle not null,
taux dm_tva not null,
soumis_mdl dm_boolean,
constraint pk_ref_tva primary key (t_ref_tva_id));

create unique index unq_ref_tva on t_ref_tva(taux);

create sequence seq_ref_tva;

/* ********************************************************************************************** */
create table t_ref_formule(
t_ref_formule_id dm_cle not null,
libelle dm_libelle not null,
numero_formule dm_char3,
calcul_theorique varchar(100),
constraint pk_ref_formule primary key(t_ref_formule_id));

create unique index unq_ref_formule on t_ref_formule(numero_formule);

create sequence seq_ref_formule;

/* ********************************************************************************************** */
create table t_ref_prog_relationnel(
t_ref_prog_rel_id dm_cle not null,
libelle dm_libelle not null,
constraint pk_ref_prog_rel primary key(t_ref_prog_rel_id));

/* ********************************************************************************************** */
create table t_ref_produit_stup(
code_cip dm_code_cip,
designation dm_libelle,
constraint pk_ref_prod_stup primary key(code_cip));
