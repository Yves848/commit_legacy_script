set sql dialect 3;


/* ********************************************************************************************** */
create table t_transfertyzy_produit (
  t_produit_id dm_code not null,
  t_transfertyzy_produit_id dm_code not null,
  constraint pk_yzy_produit primary key (t_produit_id, t_transfertyzy_produit_id));

alter table t_transfertyzy_produit
add constraint fk_yzy_prd_produit
foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_transfertyzy_depot (
  t_depot_id dm_code not null,
  t_transfertyzy_depot_id dm_code not null,
  constraint pk_yzy_depot primary key (t_depot_id, t_transfertyzy_depot_id));

alter table t_transfertyzy_depot
add constraint fk_yzy_prd_depot
foreign key (t_depot_id)
references t_depot(t_depot_id)
on delete cascade;
/* ********************************************************************************************** */
create table t_transfertyzy_stock (
  t_produit_geographique_id dm_cle not null,
  t_transfertyzy_stock_id dm_code not null,
  constraint pk_yzy_stock primary key (t_produit_geographique_id, t_transfertyzy_stock_id));

alter table t_transfertyzy_stock
add constraint fk_yzy_prd_stock
foreign key (t_produit_geographique_id)
references t_produit_geographique(t_produit_geographique_id)
on delete cascade;
/* ********************************************************************************************** */
create table t_transfertyzy_promotion (
  t_promotion_id dm_code not null,
  t_transfertyzy_promotion_id dm_code not null,
  constraint pk_yzy_promotion primary key (t_promotion_id, t_transfertyzy_promotion_id));

alter table t_transfertyzy_promotion
add constraint fk_yzy_promo_promotion
foreign key (t_promotion_id)
references t_promotion_entete(t_promotion_id)
on delete cascade;


/* ********************************************************************************************** */

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'DEPOTS', '22', '1', 'Depots', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertyzy_depot', 'pk_produits.creer_depot', 't_transfertyzy_depot', '1', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PRODUITS', '22', '1', 'Produits', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertyzy_produit', 'pk_produits.creer_produit', 't_transfertyzy_produit', '1', 'erp.t_produit where reference = ''0''', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'STOCKS', '22', '1', 'Stocks', 'grdProduits', next value for seq_grille_trf_produits);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertyzy_info_stock', 'pk_produits.creer_information_stock', null, '1', gen_id(seq_fct_fichier, 0));


insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROMOTIONS', '22', '1', 'Promotions', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, tables_a_verifier, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertyzy_promotion', 'pk_promotions.creer_promotion', 't_transfertyzy_promotion', '0', 'erp.t_promotion', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROMOTIONS AVANTAGES', '22', '1', 'Promotions Avantages', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertyzy_promo_avantage', 'pk_promotions.creer_promotion_avantage', null, '0', gen_id(seq_fct_fichier, 0));

insert into t_fct_fichier(t_fct_fichier_id, nom, type_fichier, requis, libelle, grille, ligne) 
values(next value for seq_fct_fichier, 'PROMOTIONS PRODUITS', '22', '1', 'Promotions Produits', 'grdAutresDonnees', next value for seq_grille_trf_autres_donnees);
insert into t_transfert_traitement(t_transfert_traitement_id, procedure_selection, procedure_creation, table_correspondance, fusion, t_fct_fichier_id) 
values(next value for seq_transfert_traitement, 'ps_transfertyzy_promo_produit', 'pk_promotions.creer_promotion_produit', null, '0', gen_id(seq_fct_fichier, 0));

