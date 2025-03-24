set sql dialect 3;

/* ********************************************************************************************** */
create table t_produit_no_serie(
t_produit_no_serie_id dm_code not null,
t_produit_id dm_code not null,
no_serie dm_varchar30 not null,
libelle dm_varchar30,
t_fournisseur_direct_id dm_code,
t_repartiteur_id dm_code,
proprietaire dm_boolean,
date_achat dm_date,
date_fin_garantie dm_date,
prix_achat dm_prix_achat,
constraint pk_produit_no_serie primary key(t_produit_no_serie_id));

alter table t_produit_no_serie
add constraint pk_prdser_produit foreign key(t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_produit_no_serie
add constraint fk_prdser_fournisseur_direct foreign key(t_fournisseur_direct_id)
references t_fournisseur_direct(t_fournisseur_direct_id)
on delete cascade;

alter table t_produit_no_serie
add constraint fk_prdser_repartiteur foreign key(t_repartiteur_id)
references t_repartiteur(t_repartiteur_id)
on delete cascade;

alter table t_produit_no_serie
add constraint chk_prdser_no_serie
check (no_serie <> '');

alter table t_produit_no_serie
add constraint chk_prdser_fournisseur
check (((t_fournisseur_direct_id is not null) and (t_repartiteur_id is null)) or
       ((t_fournisseur_direct_id is null) and (t_repartiteur_id is not null)) or
       ((t_fournisseur_direct_id is null) and (t_repartiteur_id is null)));

create unique index unq_produit_no_serie on t_produit_no_serie(t_produit_id, no_serie, t_fournisseur_direct_id, t_repartiteur_id);

/* ********************************************************************************************** */
create table t_dossier_location(
t_dossier_location_id dm_code not null,
t_client_id dm_code not null,
t_praticien_id dm_code,
nom_praticien dm_varchar50,
prenom_praticien dm_varchar50,
no_finess_praticien dm_varchar9,
specialite_praticien dm_varchar2,
date_debut dm_date,
date_fin dm_date,
date_ordonnance dm_date not null,
date_derniere_facturation dm_date,
caution dm_prix_vente,
constraint pk_dossier_location primary key(t_dossier_location_id));

alter table t_dossier_location
add constraint chk_dossloc_date_location 
check ((date_fin is null) or
       (date_fin >= date_debut));

alter table t_dossier_location
add constraint fk_dossloc_client foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_dossier_location
add constraint fk_dossloc_praticien foreign key(t_praticien_id)
references t_praticien(t_praticien_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_dossier_location_ligne(
t_dossier_location_ligne_id dm_cle not null,
t_dossier_location_id dm_code not null,
t_praticien_id dm_code,
date_ordonnance dm_date not null,
t_produit_id dm_code not null,
t_produit_no_serie_id dm_code,
code_tarif dm_varchar5,
reference_tips dm_varchar15,
type_code dm_liste,
prix_achat_tarif dm_prix_achat,
prix_vente dm_prix_vente,
date_debut dm_date,
date_fin dm_date,
date_derniere_facturation dm_date,
date_cloture dm_date,
t_produit_lpp_id integer,
constraint pk_dossier_location_ligne primary key(t_dossier_location_ligne_id));

alter table t_dossier_location_ligne
add constraint chk_dossloclg_date_location 
check ((date_fin is null) or
       (date_fin >= date_debut));

alter table t_dossier_location_ligne
add constraint fk_dossloclg_dossier_location foreign key(t_dossier_location_id)
references t_dossier_location(t_dossier_location_id)
on delete cascade;

alter table t_dossier_location_ligne
add constraint fk_dossloclg_praticien foreign key(t_praticien_id)
references t_praticien(t_praticien_id)
on delete cascade;

alter table t_dossier_location_ligne
add constraint fk_dossloclg_produit foreign key(t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_dossier_location_ligne
add constraint fk_dossloclg_no_serie foreign key(t_produit_no_serie_id)
references t_produit_no_serie(t_produit_no_serie_id)
on delete cascade;

alter table t_dossier_location_ligne
add constraint fk_dossloclg_produit_lpp foreign key(t_produit_lpp_id)
references t_produit_lpp(t_produit_lpp_id)
on delete cascade;

create sequence seq_dossier_location_ligne;

/* ********************************************************************************************** */
create table t_suspension_dossier_loc(
t_suspension_dossier_loc_id dm_cle not null,
t_dossier_location_id dm_code not null,
date_suspension dm_date not null,
date_reprise dm_date ,
commentaire dm_varchar100,
constraint pk_location_suspension primary key(t_suspension_dossier_loc_id));

alter table t_suspension_dossier_loc
add constraint fk_susdossl_dossier_location foreign key(t_dossier_location_id)
references t_dossier_location(t_dossier_location_id)
on delete cascade;

create sequence seq_suspension_dossier_loc;
