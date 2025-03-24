 set sql dialect 3;

/* ********************************************************************************************** */
create table t_param_remise_fixe(
t_param_remise_fixe_id dm_code not null,
taux dm_remise not null,
constraint pk_param_remise_fixe primary key(t_param_remise_fixe_id));

/* ********************************************************************************************** */
create table t_profil_remise(
t_profil_remise_id dm_code not null,
libelle dm_libelle not null,
arrondi dm_remise default 0,
type_arrondi dm_liste,
t_param_remise_fixe_id dm_code,
type_remise dm_liste,
sur_vente_directe dm_boolean,
sur_facture_ciale dm_boolean,
sur_facture_retro dm_boolean,
sur_ordonnance dm_boolean,
sur_promo_ou_remise dm_boolean,
constraint pk_profil_remise primary key(t_profil_remise_id));

alter table t_profil_remise
add constraint chk_rfixe_libelle
check (trim(libelle) <> '');

alter table t_profil_remise
add constraint chk_rfixe_arrondi
check (type_arrondi in ('0', '1', '2'));

alter table t_profil_remise
add constraint chk_rfixe_remise
check (type_remise in ('0', '1', '2', '3', '4', '5'));

alter table t_profil_remise
add constraint fk_rfixe_remise_fixe foreign key (t_param_remise_fixe_id)
references t_param_remise_fixe(t_param_remise_fixe_id)
on delete set null;

/* ********************************************************************************************** */
create table t_fourchette_remise(
t_fourchette_remise_id dm_cle not null,
seuil_inferieur dm_seuil not null,
seuil_superieur dm_seuil not null,
t_profil_remise_id dm_code not null,
remise dm_remise default 0 not null,
taux_sur_preparation dm_remise default 0 not null,
taux_sur_specialite dm_remise default 0 not null,
constraint pk_fourchette_remise primary key (t_fourchette_remise_id));

alter table t_fourchette_remise
add constraint chk_rfour_seuil
check (seuil_inferieur <= seuil_superieur);

alter table t_fourchette_remise
add constraint fk_rfour_profil_remise foreign key(t_profil_remise_id)
references t_profil_remise(t_profil_remise_id)
on delete cascade;

create sequence seq_fourchette_remise;
create unique index unq_fourchette_remise on t_fourchette_remise(seuil_inferieur, seuil_superieur, t_profil_remise_id);


/* ********************************************************************************************** */
create table t_param_remise_tva(
t_param_remise_tva_id dm_code not null,
t_ref_tva_id dm_cle not null,
remise dm_remise not null,
t_profil_remise_id dm_code not null,
constraint pk_param_remise_tva primary key(t_param_remise_tva_id));

alter table t_param_remise_tva
add constraint fk_rtva_tva foreign key(t_ref_tva_id)
references t_ref_tva(t_ref_tva_id)
on delete cascade;

alter table t_param_remise_tva
add constraint fk_rtva_profil_remise foreign key (t_profil_remise_id)
references t_profil_remise(t_profil_remise_id)
on delete cascade;

create unique index unq_rtva_tauxtva on t_param_remise_tva(t_profil_remise_id, t_ref_tva_id);

/* ********************************************************************************************** */
create table t_profil_edition(
t_profil_edition_id dm_code not null,
libelle dm_libelle not null,
saut_page_client dm_boolean,
sous_total_client dm_boolean,
detail_produits dm_boolean,
type_de_tri dm_liste,
constraint pk_profil_edition primary key(t_profil_edition_id));

alter table t_profil_edition
add constraint chk_pedit_libelle
check (trim(libelle) <> '');

alter table t_profil_edition
add constraint chk_pedit_type_de_tri
check (type_de_tri in ('0', '1', '2', '3', '4'));
              
/* ********************************************************************************************** */
create table t_compte(
t_compte_id dm_code not null,
nom dm_varchar30 not null,
activite dm_varchar50,
rue_1 dm_rue,
rue_2 dm_rue,
code_postal dm_code_postal,
nom_ville dm_nom_ville,
t_ref_cp_ville_id dm_cle,
tel_personnel dm_telephone,
tel_standard dm_telephone,
tel_mobile dm_telephone,
fax dm_telephone,
delai_paiement dm_numeric3,
fin_de_mois dm_boolean,
collectif dm_boolean,
t_client_id dm_code,
payeur dm_liste default 'A',
t_profil_remise_id dm_code,
t_profil_edition_id dm_code,
repris dm_boolean default '1',
constraint pk_compte primary key (t_compte_id));

alter table t_compte
add constraint chk_cpt_nom
check (trim(nom) <> '');

alter table t_compte
add constraint chk_cpt_payeur 
check (payeur in ('A', 'C'));

alter table t_compte
add constraint fk_cpt_client foreign key (t_client_id)
references t_client(t_client_id)
on delete set null;

alter table t_compte
add constraint fk_cpt_pofile_remise foreign key(t_profil_remise_id)
references t_profil_remise(t_profil_remise_id)
on delete set null;

alter table t_compte
add constraint fk_cpt_profil_edition foreign key(t_profil_edition_id)
references t_profil_edition(t_profil_edition_id)
on delete set null;

alter table t_compte
add constraint fk_cpt_ref_cp_ville foreign key (t_ref_cp_ville_id) 
references t_ref_cp_ville (t_ref_cp_ville_id) 
on delete set null;

/* ********************************************************************************************** */
create table t_compte_client(
t_compte_client_id dm_cle not null,
t_compte_id dm_code not null,
t_client_id dm_code not null,
constraint pk_compte_client primary key(t_compte_client_id));

alter table t_compte_client
add constraint fk_cptcli_compte foreign key(t_compte_id)
references t_compte(t_compte_id)
on delete cascade;

alter table t_compte_client
add constraint fk_cptcli_client foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

create unique index unq_compte_client on t_compte_client(t_compte_id, t_client_id);

create sequence seq_compte_client;

/* ********************************************************************************************** */

alter table t_client
add t_profil_remise_id dm_code  ;

alter table t_client
add constraint fk_cli_profile_remise foreign key(t_profil_remise_id)
references t_profil_remise(t_profil_remise_id)
on delete set null;