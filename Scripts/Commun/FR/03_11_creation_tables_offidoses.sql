      set sql dialect 3;

create table t_ofd_praticien(
  t_ofd_praticien_id dm_code not null,
  nom varchar(80),
  prenom varchar(80),
  adresse varchar(40),
  code_postal varchar(5),
  nom_ville varchar(40),
  numero_finess varchar(50),
  t_praticien_id dm_code,
  id_lgpi char(1));

alter table t_ofd_praticien add constraint pk_ofd_praticien primary key(t_ofd_praticien_id);
 
create table t_ofd_client(
  t_ofd_client_id dm_code not null,
  nom varchar(80),
  prenom varchar(80),
  ehpad varchar(40),
  numero_insee varchar(15),
  adresse varchar(40),
  code_postal varchar(5),
  nom_ville varchar(40),
  rang_gemellaire dm_numeric1,
  date_naissance varchar(8),
  derniere_prescription date,
  t_client_id dm_code,
  id_lgpi char(1));

alter table t_ofd_client add constraint pk_ofd_client primary key(t_ofd_client_id);

create table t_ofd_prescription(
  t_ofd_prescription_id dm_code not null,  
  numero_prescription integer not null,
  numero_facture dm_numeric10,
  t_ofd_client_id dm_code not null,
  t_ofd_praticien_id dm_code,
  date_delivrance date not null,
  fin_traitement date not null,
  duree integer not null,
  code_cip varchar(13) not null,
  designation varchar(50) not null,
  quantite dm_quantite default 1 not null,
  t_ligne_vente_id dm_code,
  id_lgpi char(1),
  constraint pk_ofd_prescription primary key(t_ofd_prescription_id),
  constraint fk_ofd_presc_client foreign key(t_ofd_client_id) references t_ofd_client(t_ofd_client_id) on delete cascade,
  constraint fk_ofd_presc_praticien foreign key(t_ofd_praticien_id) references t_ofd_praticien(t_ofd_praticien_id) on delete cascade);
  
create unique index unq_ofd_prescription on t_ofd_prescription(numero_prescription, code_cip);
create sequence seq_ofd_prescription;
  
create table t_ofd_posologie(
  t_ofd_posologie_id dm_cle not null,
  t_ofd_prescription_id dm_code not null,
  quantite numeric(5,2) not null,
  heure varchar(50),
  constraint pk_ofd_posologie primary key(t_ofd_posologie_id),
  constraint fk_ofd_pos_prescription foreign key(t_ofd_prescription_id) references t_ofd_prescription(t_ofd_prescription_id) on delete cascade);
  
create unique index unq_ofd_posologie on t_ofd_posologie(t_ofd_prescription_id, heure);
create sequence seq_ofd_posologie;