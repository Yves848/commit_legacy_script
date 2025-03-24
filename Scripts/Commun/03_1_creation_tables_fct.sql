set sql dialect 3;

/* ********************************************************************************************** */
create table t_fct_fichier(
t_fct_fichier_id dm_cle not null,
nom dm_varchar100 not null,
type_fichier char(2) not null,
requis dm_boolean not null,
validation_absence dm_boolean not null,
commentaire dm_commentaire,
libelle dm_libelle not null,
grille dm_varchar50,
ligne dm_numeric3,
constraint pk_fct_fichier primary key(t_fct_fichier_id));

/* ********************** */
-- 10 => fichier du module d'import sans traitement associé
-- 11 => fichier du module d'import avec traitement associé
-- 12 => traitement du module d'import

-- 20 => fichier du module de transfert sans traitement asocié
-- 21 => fichier du module de transfert avec traitement associé
-- 22 => traitement du module de transfert
/* ********************** */

alter table t_fct_fichier
add constraint chk_f_fich_type_fichier
check (type_fichier in ('10', '11', '12', '13', '20', '21', '22', '23'));

create unique index unq_fct_fichier on t_fct_fichier(type_fichier, nom);
create unique index unq_fct_libelle on t_fct_fichier(type_fichier, libelle);
create unique index unq_fct_affichage_grille on t_fct_fichier(type_fichier, grille, ligne);

create sequence seq_fct_fichier;

/* ********************************************************************************************** */
create table t_fct_erreur (
t_fct_erreur_id dm_cle not null,
type_erreur dm_liste not null,
t_fct_fichier_id dm_cle,
message_erreur_sql varchar(1000) not null,
code_erreur_sql integer not null,
importance dm_liste not null,
donnees blob sub_type text,
instruction blob sub_type text,
constraint pk_fct_erreur primary key(t_fct_erreur_id));

alter table t_fct_erreur
add constraint chk_f_err_type_erreur
check (type_erreur in ('1', '2'));

alter table t_fct_erreur
add constraint fk_err_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_fct_erreur;


create index idx_f_err_erreur on t_fct_erreur(type_erreur, t_fct_fichier_id);

create table t_fct_console(
  t_fct_console_id dm_cle not null,
  date_console dm_date_heure,
  msg varchar(1000),
  visuel dm_boolean default '1',
  constraint pk_fct_console primary key(t_fct_console_id) 
);

create sequence seq_fct_console;

/* ********************************************************************************************** */
create table t_fct_astuce(
  t_fct_astuce_id dm_cle not null,
  type_astuce dm_liste not null,
  message varchar(1000),
  constraint pk_fct_astuce primary key(t_fct_astuce_id));
  
alter table t_fct_astuce
add constraint chk_f_ast_type_astuce
check (type_astuce in ('1', '2', '3'));

create sequence seq_fct_astuce;
  
/* ********************************************************************************************** */
create table t_fct_message_erreur(
  t_fct_message_erreur_id dm_cle not null,
  type_message dm_liste,
  nom_contrainte varchar(31) not null,
  message varchar(500) not null,
  constraint pk_fct_message_erreur primary key(t_fct_message_erreur_id));
  
alter table t_fct_message_erreur
add constraint chk_msgerr_type_message
check (type_message in ('1', '2'));

create sequence seq_fct_message_erreur;

create sequence seq_grille_imp_fichiers;
create sequence seq_grille_imp_praticiens;
create sequence seq_grille_imp_organismes;
create sequence seq_grille_imp_clients;
create sequence seq_grille_imp_produits;	
create sequence seq_grille_imp_autres_donnees;
create sequence seq_grille_imp_encours;
create sequence seq_grille_imp_avantages;	
	
create sequence seq_grille_trf_praticiens;
create sequence seq_grille_trf_organismes;
create sequence seq_grille_trf_clients;
create sequence seq_grille_trf_produits;	
create sequence seq_grille_trf_autres_donnees;
create sequence seq_grille_trf_encours;
create sequence seq_grille_trf_avantages;	
