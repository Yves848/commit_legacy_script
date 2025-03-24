/* ********************************************************************************************** */
create table migration.t_tmp_client_fusionne(
  t_client_id integer,
  etat char(1) not null,
  --constraint pk_fusion_client primary key(t_client_id),
  constraint chk_fuscli_etat check(etat in ('C', 'F', 'R')));

/* ********************************************************************************************** */
create table migration.t_tmp_produit_fusionne(
  t_produit_id integer,
  etat char(1) not null,
  --constraint pk_fusion_produit primary key(t_produit_id),
  constraint chk_fuspro_etat check(etat in ('C', 'F', 'R')));

/* ********************************************************************************************** */
create table migration.t_erreur(t_erreur_id integer not null,
categorie varchar2(35) not null,  
donnees varchar2(500) not null,
texte varchar2(500) not null,
constraint pk_erreur primary key(t_erreur_id));

/* ********************************************************************************************** */
create sequence migration.seq_erreur;

/* ********************************************************************************************** */
/* *                     MODIFICATION DES TABLES T_HISTO_CLIENT_XXXXXXX                         * */
/* ********************************************************************************************** */
alter table erp.t_histo_client_entete modify t_client_id number(10);

declare
  strSQL varchar2(500);
  
  function if_exists(objet in char, nom_table in varchar2, nom_objet in varchar2) return boolean as
    n integer;
  begin
    if objet = 'T' then
      select count(*)
      into n
      from sys.all_tables
      where owner = 'ERP' and table_name = upper(nom_table);      
    elsif objet = 'C' then
      select count(*)
      into n
      from sys.all_tab_columns 
      where owner = 'ERP' and table_name = upper(nom_table) and column_name = upper(nom_objet);
    elsif objet = 'S' then
      select count(*)
      into n
      from sys.all_sequences
      where sequence_owner = 'ERP' and sequence_name = upper(nom_objet);
    end if;
    
    return n > 0;
  end;
  
begin
  -- Modifications G9
  if not if_exists('C', 'T_HISTO_CLIENT_LIGNE', 'PRIX_ACHAT') then
    execute immediate 'alter table erp.t_histo_client_ligne add prix_achat number(10, 3)'; 
  end if;

  if not if_exists('C', 'T_HISTO_CLIENT_LIGNE', 'MONTANT_NET_HT') then
    execute immediate 'alter table erp.t_histo_client_ligne add montant_net_ht number(10, 2)';
  end if;

  if not if_exists('C','T_HISTO_CLIENT_LIGNE', 'MONTANT_NET_TTC') then
    execute immediate 'alter table erp.t_histo_client_ligne add montant_net_ttc number(10, 2)';
  end if;

  if not if_exists('C', 'T_HISTO_CLIENT_LIGNE', 'PRIX_ACHAT_HT_REMISE') then
    execute immediate 'alter table erp.t_histo_client_ligne add prix_achat_ht_remise number(5,2)';
  end if;
  
  if not if_exists('T', 'T_G9_HISTORIQUE_STOCK', null) then
    execute immediate 'create table erp.t_g9_historique_stock(
                         t_g9_historique_stock_id number(9) not null,
                         t_fournisseur_id number(9) not null,
                         mois number(2) not null,
                         annee number(4) not null,
                         valeur_stock number(10,3) not null,
                         constraint pk_g9_historique_stock primary key(t_g9_historique_stock_id),
                         constraint fk_g9_hist_stk_fournisseur foreign key(t_fournisseur_id) references erp.t_fournisseur(t_fournisseur_id) on delete cascade,
                         constraint chk_g9_hist_stk_periode check((mois between 1 and 12) and (annee between 1 and 9999)),
                         constraint chk_g9_hist_stk_stock check(valeur_stock > 0))';
  end if;
  
  if not if_exists('S', null, 'SEQ_G9_HISTORIQUE_STOCK') then
    execute immediate 'create sequence erp.seq_g9_historique_stock';
  end if;
  
  -- Modifications Offidoses
  if not if_exists('C', 'T_HISTO_CLIENT_LIGNE', 'T_POSOLOGIE_ORDO_ID') then
    execute immediate 'alter table erp.t_histo_client_ligne add t_posologie_ordo_id number(10)';
  end if;  
end;

