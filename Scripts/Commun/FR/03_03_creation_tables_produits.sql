set sql dialect 3;



create table t_promotion_entete(
t_promotion_id dm_code not null,
libelle dm_varchar50 not null,
date_debut dm_date not null,
date_fin dm_date not null,
type_promotion dm_type_promotion, -- '1:Promotion produit sans panachage / 2:Promotion lot ferme / 3:Promotion avec panachage'
date_creation dm_date not null,
date_maj dm_date not null,
commentaire dm_commentaire,
autorise_panachage_declencheur char default '0',
nombre_lots_affectes dm_quantite default 0,
lot_qte_affectee dm_quantite default 0,
lot_qte_vendue dm_quantite default 0,
lot_stock_alerte dm_quantite default 0,
constraint pk_promotion_entete primary key(t_promotion_id));

alter table t_promotion_entete
add constraint chk_promo_ent_libelle
check(trim(libelle) <> '');

alter table t_promotion_entete
add constraint chk_promo_ent_periode
check (date_debut <= date_fin);


/* ********************************************************************************************** */
create table t_promotion_produit
(
t_promotion_produit_id dm_cle not null,
t_produit_id dm_code not null,
t_promotion_id dm_code not null,
date_entree dm_date not null,
date_retrait dm_date,
qte_affectee dm_quantite default 1,
qte_vendue dm_quantite default 0,
stock_alerte dm_quantite default 0,
declencheur char default '1' not null,
panier char default '0' not null,
lot_prixvente_hors_promo dm_prix_vente default 0,
lot_qte_promo dm_quantite default 0,
lot_remise dm_remise default 0,
lot_prixvente_promo dm_prix_vente default 0,
date_maj dm_date,
constraint pk_promotion_produit primary key(t_promotion_produit_id));

alter table t_promotion_produit
add constraint fk_prd_produit_promo foreign key(t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_promotion_produit
add constraint fk_prd_promotion_promo foreign key(t_promotion_id)
references t_promotion_entete(t_promotion_id)
on delete cascade;

create unique index unq_promotionproduit on t_promotion_produit(t_promotion_produit_id, t_produit_id);

create sequence seq_promotion_produit;
/* ********************************************************************************************** */
create table t_promotion_avantage
(
t_promotion_avantage_id dm_cle not null,
t_promotion_id dm_code not null,
a_partir_de dm_quantite not null,
type_avantage_promo dm_type_avantage_promo not null,
val_avantage dm_prix_vente,
nb_offert dm_quantite,
avec_arrondi dm_boolean
);

alter table t_promotion_avantage
add constraint fk_avantage_promo foreign key(t_promotion_id)
references t_promotion_entete(t_promotion_id)
on delete cascade;


create sequence seq_promotion_avantage;
/* ********************************************************************************************** */

/* ********************************************************************************************** */
create table t_rotation(
t_rotation_id dm_cle not null,
moyenne_vente dm_moyenne_vente not null,
stock_mini dm_quantite,
consommation dm_quantite,
constraint pk_rotation primary key (t_rotation_id));

create unique index unq_rotation on t_rotation(moyenne_vente);

/* ********************************************************************************************** */
create table t_ponderation(
t_ponderation_id dm_cle not null,
no_mois dm_numeric2 not null,
poids dm_numeric2,
constraint pk_ponderation primary key (t_ponderation_id));

alter table t_ponderation
add constraint chk_pond_no_mois
check ((no_mois <= 1) and (no_mois >= -23));

create unique index unq_ponderation on t_ponderation(no_mois);

/* ********************************************************************************************** */
create table t_produit_lpp(
t_produit_lpp_id dm_cle not null,
t_produit_id dm_code not null,
type_code dm_liste default '2',
code_lpp varchar(13) not null,
quantite dm_quantite,
tarif_unitaire dm_prix_vente,
t_ref_prestation_id dm_cle,
service_tips dm_service_tips,
libelle dm_varchar100,
periodicite dm_periodicite,
de dm_numeric3,
a dm_numeric3,
prix_vente dm_prix_vente,
t_produit_lpp_suivant_id dm_cle,
constraint pk_produitlpp primary key (t_produit_lpp_id));

alter table t_produit_lpp
add constraint fk_prdlpp_produit foreign key(t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_produit_lpp
add constraint fk_prdlpp_suivant foreign key(t_produit_lpp_suivant_id)
references t_produit_lpp(t_produit_lpp_id)
on delete set null;

alter table t_produit_lpp
add constraint fk_prdlpp_prestation foreign key(t_ref_prestation_id)
references t_ref_prestation(t_ref_prestation_id)
on delete cascade;

alter table t_produit_lpp
add constraint chk_prdlpp_type_code
check (((type_code = '0') and (quantite is not null)
                         and (char_length(code_lpp) = 7)) or
       ((type_code = '1') and (quantite is not null)
                         and (tarif_unitaire is not null)
                         and (t_ref_prestation_id is not null)
                         and (service_tips is not null)) or
       ((type_code = '2') and (char_length(code_lpp) <= 13)));

create unique index unq_produit_lpp on t_produit_lpp(t_produit_id, code_lpp);

create sequence seq_produit_lpp;

/* ********************************************************************************************** */
create table t_catalogue(
t_catalogue_id dm_code not null,
designation dm_libelle not null,
date_debut dm_date,
date_fin dm_date,
t_fournisseur_id dm_code not null,
date_creation dm_date,
date_fin_validite dm_date,
constraint pk_catalogue primary key(t_catalogue_id),
constraint fk_cat_fournisseur foreign key(t_fournisseur_id) references t_fournisseur_direct(t_fournisseur_direct_id) on delete cascade);

/* ********************************************************************************************** */
create table t_classification_fournisseur(
t_classification_fournisseur_id dm_code not null,
designation dm_varchar100 not null,
date_debut_marche dm_date,
duree_marche dm_numeric3,
t_classification_parent_id dm_code,
t_catalogue_id dm_code not null,
constraint pk_classification_fournisseur primary key (t_classification_fournisseur_id),
constraint fk_cl_fou_catalogue foreign key(t_catalogue_id) references t_catalogue(t_catalogue_id) on delete cascade);

alter table t_classification_fournisseur
add constraint fk_cl_fou_parent
foreign key(t_classification_parent_id)
references t_classification_fournisseur(t_classification_fournisseur_id);

/* ********************************************************************************************** */
create table t_catalogue_ligne(
t_catalogue_ligne_id dm_cle not null,
t_catalogue_id dm_code not null,
t_classification_fournisseur_id dm_code,
no_ligne dm_numeric5 not null,
t_produit_id dm_code not null,
quantite dm_quantite default 1 not null,
prix_achat_catalogue dm_prix_achat not null,
prix_achat_remise dm_prix_achat not null,
remise_simple dm_remise not null,
date_maj_tarif dm_date,
date_creation dm_date,
colisage dm_numeric5,
constraint pk_catalogue_ligne primary key(t_catalogue_ligne_id),
constraint fk_cat_lig_catalogue foreign key(t_catalogue_id) references t_catalogue(t_catalogue_id) on delete cascade,
constraint fk_cat_lig_produit foreign key(t_produit_id) references t_produit(t_produit_id) on delete cascade,
constraint fk_cat_lig_classif_four foreign key(t_classification_fournisseur_id) references t_classification_fournisseur(t_classification_fournisseur_id) on delete set null);

create unique index unq_produit_catalogue on t_catalogue_ligne(t_produit_id, t_catalogue_id);

create sequence seq_catalogue_ligne;

/* ********************************************************************************************** */
create table t_g9_historique_stock(
  t_g9_historique_stock_id integer not null,
  t_fournisseur_direct_id dm_code not null,
  mois numeric(2) not null,
  annee numeric(4) not null,
  valeur_stock dm_prix_achat not null,
  constraint pk_g9_historique_stock primary key(t_g9_historique_stock_id),
  constraint fk_g9_hist_stk_fournisseur foreign key(t_fournisseur_direct_id) references t_fournisseur_direct(t_fournisseur_direct_id) on delete cascade,
  constraint chk_g9_hist_periode check ((mois between 1 and 12) and (annee between 1 and 9999)),
  constraint chk_g9_hist_stock check(valeur_stock > 0));  

create sequence seq_g9_historique_stock;

commit;
