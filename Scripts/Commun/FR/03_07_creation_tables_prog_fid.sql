set sql dialect 3;

/* ********************************************************************************************** */
create table t_programme_avantage( -- Prog privé de la pharmacie
t_programme_avantage_id dm_code not null,
type_carte dm_liste not null,
code_externe dm_varchar30,
libelle dm_varchar30 not null,
nombre_mois_validite numeric(3),
date_fin_validite dm_date,
desactivee dm_boolean,
type_objectif dm_liste not null,
valeur_objectif dm_numeric10 not null,
valeur_point dm_prix_vente,
nombre_point_tranche dm_numeric10,
valeur_tranche dm_numeric10,
valeur_arrondi dm_prix_vente,
type_avantage dm_liste not null,
mode_calcul_avantage dm_liste not null,
valeur_avantage dm_prix_vente,
valeur_ecart dm_prix_vente,
diff_assure dm_boolean,
valeur_carte dm_prix_vente,
constraint pk_programme_avantage primary key(t_programme_avantage_id));

alter table t_programme_avantage add constraint chk_type_carte check (type_carte in ('1', '2'));
-- 1 - Privée / 2 - Laboratoire  -- pas sur que ce soit encore valable ça

alter table t_programme_avantage
add constraint chk_type_objectif 
check (type_objectif in ('1', '2', '3', '4'));
-- 1=CA Réalisé / 2 = Nombre de boites / 3 = Nombre de visites / 4 = Nombre de points
-- 1/ on remplit encoursInitial ou encoursCA peu importe
-- 2/ montant_net_ttc de t_lignevente initialise le CA, qtt facture le nb de boite , donc encours_initial de t_programme_avantage_client  doit etre à 0
-- 3/ probablement multipler le nb de ligne de vente / passage et donc divisier le montant par nb passage 
--le 3 fait passer type_calcul_visite à 1 sinon null
    --TypeCalculVisite : 
        --1 - toutes ventes contenant des produits fidélité
        --2 - Ventes directes quels que soient les produits
        --3 - Toutes ventes quels que soient les produits

alter table t_programme_avantage
add constraint chk_type_avantage
check (type_avantage in ('1', '2', '3', '4'));
-- 1 - remise / 2 - chèque cadeau / 3 - Cadeau / 4 - Produit offert


alter table t_programme_avantage
add constraint chk_modecalcul_avantage 
check (mode_calcul_avantage in ('1', '2', '3', '4', '5'));
/*1 - "% sur CA réalisé par les produits fidélité"
2 - "% sur CA des produits fidélité de la prochaine vente"    
3, "Euros"
4, "Euros / Point"
5, "Un produit parmi la liste"*/

/* ********************************************************************************************** */
create table t_programme_avantage_client(
t_programme_avantage_client_id dm_cle not null,
t_programme_avantage_id dm_code not null,
t_client_id dm_code not null,
numero_carte dm_varchar13,
statut dm_liste not null,
date_creation dm_date not null,
date_creation_initiale dm_date,
date_fin_validite dm_date,
encours_initial numeric(9,2), -- contient l'encours du programme donc ca ou nb boite ou nb passage
t_operateur_id dm_varchar10,
encours_ca numeric(9,2),
cheque_bienvenue_utilise dm_boolean default '0',
constraint pk_programme_avantage_client primary key(t_programme_avantage_client_id));

alter table t_programme_avantage_client
add constraint chk_pacli_statut
check (statut in ('0', '1', '2'));

alter table t_programme_avantage_client
add constraint fk_pacli_programme_avantage foreign key(t_programme_avantage_id)
references t_programme_avantage(t_programme_avantage_id)
on delete cascade;

alter table t_programme_avantage_client
add constraint fk_pacli_client foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_programme_avantage_client
add constraint pk_pacli_operateur foreign key (t_operateur_id)
references t_operateur(t_operateur_id)
on delete set null;

create sequence seq_programme_avantage_client;

/******************************************************************************/
create table t_programme_avantage_produit(
t_programme_avantage_produit_id dm_cle not null,
t_programme_avantage_id dm_code not null,
t_produit_id dm_code not null,
gain dm_boolean default '1',
offert dm_boolean not null,
nombre_point_supp dm_quantite,
constraint pk_programme_avantage_produit primary key(t_programme_avantage_produit_id));

alter table t_programme_avantage_produit
add constraint fk_paprd_programme_avantage foreign key(t_programme_avantage_id)
references t_programme_avantage(t_programme_avantage_id)
on delete cascade;

alter table t_programme_avantage_produit
add constraint fk_paprd_produit foreign key(t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

create sequence seq_programme_avantage_produit;

/******************************************************************************/
create table t_carte_programme_relationnel(
t_carte_prog_relationnel_id dm_cle not null,
t_aad_id dm_code not null,
numero_carte dm_varchar13 not null,
t_pfi_lgpi_id dm_cle default 0,  -- si 0 on utilise la valeur de la fenetre d'options de transfert
constraint pk_programme_relationnel primary key(t_carte_prog_relationnel_id));

alter table t_carte_programme_relationnel
add constraint fk_prog_rel_client foreign key(t_aad_id)
references t_client(t_client_id)
on delete cascade;

create sequence seq_programme_relationnel;

commit;