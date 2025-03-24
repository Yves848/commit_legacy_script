set sql dialect 3;

/* ********************************************************************************************** */
create table t_vignette_avancee(
t_vignette_avancee_id dm_cle not null,
t_client_id dm_code not null,
date_avance dm_date not null,
code_cip dm_code_cip,
designation dm_libelle not null,
prix_vente dm_prix_vente not null,
prix_achat dm_prix_achat not null,
code_prestation dm_varchar3 not null,
t_produit_id dm_code not null,
t_operateur_id dm_varchar10,
quantite_avancee dm_quantite not null,
base_remboursement dm_prix_vente not null,
repris dm_boolean default '1' not null,
constraint pk_vignette_avancee primary key(t_vignette_avancee_id));

alter table t_vignette_avancee
add constraint fk_va_produit foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_vignette_avancee
add constraint fk_va_client foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_vignette_avancee
add constraint chk_va_quantite_avancee
check (quantite_avancee > 0);

alter table t_vignette_avancee
add constraint fk_va_operateur foreign key (t_operateur_id)
references t_operateur(t_operateur_id)
on delete set null;

create sequence seq_vignette_avancee;

/* ********************************************************************************************** */
create table t_credit(
t_credit_id dm_code not null,
date_credit dm_date not null,
t_client_id dm_code,
t_compte_id dm_code,
montant numeric(10,2) not null,
repris dm_boolean default '1' not null,
constraint pk_credit primary key (t_credit_id));

alter table t_credit
add constraint chk_cdt_clicpt
check ((t_client_id is not null) or
       (t_compte_id is not null));

alter table t_credit
add constraint fk_cdt_client foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_credit
add constraint fk_cdt_compte foreign key (t_compte_id)
references t_compte(t_compte_id)
on delete cascade;

create unique index unq_credit on t_credit(t_client_id, t_compte_id);

create sequence seq_credit;

/* ********************************************************************************************** */
create table t_produit_du(
t_produit_du_id dm_code not null,
t_client_id dm_code not null,
date_du dm_date not null,
t_produit_id dm_code not null,
quantite dm_quantite not null,
repris dm_boolean default '1' not null,
constraint pk_produit_du primary key (t_produit_du_id));

alter table t_produit_du
add constraint chk_prddu_quantite
check (quantite > 0);

alter table t_produit_du
add constraint fk_prddu_client foreign key (t_client_id)
references t_client(t_client_id)
on delete cascade;

alter table t_produit_du
add constraint fk_prddu_produit foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

create sequence seq_produit_du;

/* ********************************************************************************************** */
create table t_facture_attente(
t_facture_attente_id dm_code not null,
date_acte dm_date not null,
t_client_id dm_code not null,
repris dm_boolean default '1' not null,
constraint pk_facture_attente primary key (t_facture_attente_id));

alter table t_facture_attente
add constraint fk_factatt_client foreign key(t_client_id)
references t_client(t_client_id)
on delete cascade;

/* ********************************************************************************************** */
create table t_facture_attente_ligne(
t_facture_attente_ligne_id dm_cle not null,
t_facture_attente_id dm_code not null,
t_produit_id varchar(50),
quantite_facturee dm_quantite not null,
t_ref_prestation_id dm_cle not null,
prix_vente dm_prix_vente not null,
prix_achat dm_prix_achat not null,
constraint pk_facure_attente_ligne primary key(t_facture_attente_ligne_id));

alter table t_facture_attente_ligne
add constraint fk_factattlig foreign key(t_facture_attente_id)
references t_facture_attente(t_facture_attente_id)
on delete cascade;

-- alter table t_facture_attente_ligne
-- add constraint fk_factattlig_produit foreign key(t_produit_id)
-- references t_produit(t_produit_id)
-- on delete cascade;

alter table t_facture_attente_ligne
add constraint fk_factattlig_prestation foreign key(t_ref_prestation_id)
references t_ref_prestation(t_ref_prestation_id)
on delete cascade;

create sequence seq_facture_attente_ligne;

/* ********************************************************************************************** */
create table t_commande(
t_commande_id dm_code not null,
type_commande dm_liste,
date_creation dm_date not null,
mode_transmission dm_mode_transmission,
montant_ht dm_prix_vente not null,
commentaire dm_commentaire,
t_fournisseur_direct_id dm_code,
t_repartiteur_id dm_code,
etat dm_varchar2 not null,
date_reception dm_date,
date_reception_prevue dm_date,
numero dm_numeric10,
repris dm_boolean default '1',
constraint pk_commande primary key (t_commande_id));

alter table t_commande
add constraint chk_cmd_fd_rep
check (((type_commande = '1') and (t_fournisseur_direct_id is not null)) or
       ((type_commande = '2') and (t_repartiteur_id is not null)));
       
alter table t_commande
add constraint chk_cmd_etat
check (etat in ('0', '1', '2', '21', '22', '3'));
--0 - En attente / 1 - Validée / 2 - Transmise / 21 - Réc. partiel / 22 - Réc. quantitatif / 3 - Réceptionnée
       
alter table t_commande
add constraint fk_cmd_fourn foreign key(t_fournisseur_direct_id)
references t_fournisseur_direct(t_fournisseur_direct_id)
on delete cascade;

alter table t_commande
add constraint fk_cmd_repart foreign key(t_repartiteur_id)
references t_repartiteur(t_repartiteur_id)
on delete cascade;

create index idx_cmd_date_creation on t_commande(date_creation);

/* ********************************************************************************************** */
create table t_commande_ligne(
t_commande_ligne_id dm_cle not null,
t_commande_id dm_code not null,
t_produit_id dm_code not null,
quantite_commandee dm_quantite not null,
quantite_recue dm_quantite not null,
quantite_totale_recue dm_quantite not null,
prix_achat_tarif dm_prix_achat not null,
prix_achat_remise dm_prix_achat not null,
prix_vente dm_prix_vente not null,
reception_financiere dm_boolean,
choix_reliquat dm_liste,
unites_gratuites dm_quantite default 0 not null,
colisage dm_quantite,
constraint pk_commande_ligne primary key (t_commande_ligne_id));

alter table t_commande_ligne
add constraint fk_cmdlig_commande_ent foreign key(t_commande_id)
references t_commande(t_commande_id)
on delete cascade;  
     
alter table t_commande_ligne
add constraint fk_cmdlig_produit foreign key (t_produit_id)
references t_produit(t_produit_id)
on delete cascade;

alter table t_commande_ligne
add constraint fk_cmdlig_choix_reliquat
check (choix_reliquat in ('0', '1', '2', '3', '4'));

--create unique index unq_commande_ligne on t_commande_ligne(t_commande_id, t_produit_id);
create index idx_cmdlig_qte_totale_recue on t_commande_ligne(quantite_totale_recue);

create sequence seq_commande_ligne;