set sql dialect 3;

/* ********************************************************************************************** */
create table t_dyna_traitement(
t_dyna_traitement_id dm_cle not null,
requete_selection dm_varchar150,
procedure_creation dm_nom_procedure not null,
t_fct_fichier_id dm_cle not null,
constraint pk_dyna_traitement primary key(t_dyna_traitement_id));

alter table t_dyna_traitement
add constraint fk_dyna_traitement_fichier foreign key(t_fct_fichier_id)
references t_fct_fichier(t_fct_fichier_id)
on delete cascade;

create sequence seq_dyna_traitement;
  
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'clients.csv', '10', '1', 'Table Clients', 'Clients', null, next value for seq_grille_imp_fichiers);
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, commentaire, libelle, grille, ligne) values(next value for seq_fct_fichier, 'produits.csv', '10', '1', 'Table produit', 'Produit', null, next value for seq_grille_imp_fichiers);

/* ************************************************** Clients ***************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne)  
values(next value for seq_fct_fichier, 'Clients', '12', '0', 'Clients et Comptes', 'grdClients', next value for seq_grille_imp_clients);
insert into t_dyna_traitement (t_dyna_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_dyna_traitement, 'dyna_clients', 'ps_dyna_creer_client', gen_id(seq_fct_fichier, 0));

/* ************************************************** Produits ***************************************************** */
insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'Produits', '12', '0', 'Produits', 'grdProduits', next value for seq_grille_imp_produits);
insert into t_dyna_traitement (t_dyna_traitement_id, requete_selection, procedure_creation, t_fct_fichier_id) 
values (next value for seq_dyna_traitement, 'dyna_produits', 'ps_dyna_creer_produit', gen_id(seq_fct_fichier, 0));

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
    t.t_dyna_traitement_id,
    t.requete_selection||'.sql',
    t.procedure_creation,
    f.nom
from t_fct_fichier f
left join t_dyna_traitement t on t.t_fct_fichier_id = f.t_fct_fichier_id
where f.type_fichier like '1%';

/* ********************************************************************************************** */
update t_cfg_prestation set utilisable_conversion = '0';
update t_cfg_prestation set utilisable_conversion = '1'  where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code in('PH1','PH2','PH4','PH7','PMR','AAD' ));

/* ********************************************************************************************** */
create table t_dyna_acte(
  id integer,
  code varchar(5),
  constraint pk_dyna_acte primary key(id));

