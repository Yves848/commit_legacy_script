set sql dialect 3;

/* ********************************************************************************************** */
create table t_cnv_hopital(
    t_cnv_hopital_id dm_code not null,
	t_hopital_id   dm_code,
	t_praticien_id dm_code,
    nom            varchar(60),
    rue_1          dm_rue,
    rue_2          dm_rue,
	t_ref_cp_ville_id dm_cle,
    code_postal    dm_code_postal,
    nom_ville      dm_nom_ville,
    tel_personnel  dm_telephone,
	tel_standard   dm_telephone,
	tel_mobile     dm_telephone,
    fax            dm_telephone,
	commentaire    dm_commentaire,
    numero_finess  varchar(9) not null
);
alter table t_cnv_hopital add constraint pk_cnv_hopital primary key ( t_cnv_hopital_id );
create unique index unq_cnv_finess on t_cnv_hopital(numero_finess);

create sequence seq_cnv_hopital;

/* ********************************************************************************************** */
create table t_cnv_couverture_amc(
t_cnv_couverture_amc_id dm_code not null,
t_couverture_amc_id dm_code not null,
formule dm_formule,
constraint pk_c_couvertureamc primary key (t_cnv_couverture_amc_id));

alter table t_cnv_couverture_amc
add constraint fk_c_couvamc_couverture_amc foreign key(t_couverture_amc_id)
references t_couverture_amc(t_couverture_amc_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_cnv_taux_prise_en_charge(
t_cnv_taux_prise_en_charge_id dm_cle not null,
t_couverture_amc_id dm_code not null,
t_ref_prestation_id dm_cle not null,
taux dm_prix_vente not null,
formule dm_formule,
constraint pk_c_tauxpriseencharge primary key (t_cnv_taux_prise_en_charge_id));

alter table t_cnv_taux_prise_en_charge
add constraint fk_c_tauxpc_couverture_amc foreign key (t_couverture_amc_id)
references t_cnv_couverture_amc(t_cnv_couverture_amc_id)
on delete cascade;

alter table t_cnv_taux_prise_en_charge
add constraint fk_c_tauxpc_prestation foreign key (t_ref_prestation_id)
references t_ref_prestation (t_ref_prestation_id);

create sequence seq_cnv_taux_prise_en_charge;

alter table t_client add t_cnv_couverture_amc_id varchar(50);
alter table t_client add constraint fk_cli_cnv_couverture_amc foreign key(t_cnv_couverture_amc_id) references t_cnv_couverture_amc(t_cnv_couverture_amc_id) on delete set null;


commit;
