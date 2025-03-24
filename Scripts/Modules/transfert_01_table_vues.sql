set sql dialect 3;

/* ********************************************************************************************** */
create exception exp_transfert_tr_non_ex 'Traitement inexistant !';
 
/* ********************************************************************************************** */
create table t_transfert_traitement (
  t_transfert_traitement_id dm_cle not null,
  procedure_selection dm_nom_procedure,
  procedure_creation varchar(200),
  table_correspondance dm_nom_table,
  fusion dm_boolean,
  tables_a_verifier varchar(500),
  t_fct_fichier_id dm_cle,
  constraint pk_ulti_traitement primary key (t_transfert_traitement_id));

alter table t_transfert_traitement
add constraint fk_traitement_fichier
foreign key (t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_transfert_traitement;

/* ********************************************************************************************** */
recreate view v_traitement_2(
    t_fct_fichier_id,
    type_fichier,
    libelle,
    grille,
    ligne,
    t_traitement_id,
    requete_selection,
    table_correspondance,
    fusion,
    tables_a_verifier,
    procedure_creation,
    nom)
as
select
    f.t_fct_fichier_id,
    f.type_fichier,
    f.libelle,
    f.grille,
    f.ligne,
    t.t_transfert_traitement_id,
    t.procedure_selection,
    t.table_correspondance,
    t.fusion,
    t.tables_a_verifier,
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_transfert_traitement t
on t.t_fct_fichier_id = f.t_fct_fichier_id
where type_fichier like '2%';