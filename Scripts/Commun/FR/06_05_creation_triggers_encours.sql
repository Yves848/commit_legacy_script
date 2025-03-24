set sql dialect 3;

/* ********************************************************************************************** */
create or alter trigger trg_cmd_verification for t_commande
active before insert or update position 0
as
begin
  new.etat = trim(new.etat);
end;

/* ********************************************************************************************** */
create or alter trigger trg_cmd_creation_catalogue for t_commande
active after insert position 0
as
declare variable rs varchar(50);
begin
  select raison_sociale
  from t_fournisseur_direct
  where t_fournisseur_direct_id = new.t_fournisseur_direct_id
  into :rs;
  
  if (row_count <> 0) then
    if (not exists(select *
                   from t_catalogue
                   where t_catalogue_id = new.t_fournisseur_direct_id)) then
      insert into t_catalogue(t_catalogue_id,
                              designation,
                              t_fournisseur_id)
      values(new.t_fournisseur_direct_id,
             'Catalogue ' || :rs,
             new.t_fournisseur_direct_id);
end;  

/* ********************************************************************************************** */
create or alter trigger trg_cmdlig_creation_lig_cat for t_commande_ligne
active after insert position 0
as
declare variable f varchar(50);
declare variable dt date;
declare variable dtMAJ date;
declare variable id_l integer;
declare variable l integer;
declare variable r numeric(5,2);
begin
  -- Selection de la commande
  select t_fournisseur_direct_id, coalesce(date_creation, date_reception)
  from t_commande
  where t_commande_id = new.t_commande_id
  into :f, :dt;
  
  if ((f is not null) and (dt > dateadd(-5 year to current_date))) then
  begin
    execute procedure ps_calculer_remise(new.prix_achat_tarif, new.prix_achat_remise) returning_values :r;

    -- Verification du catalogue
    select t_catalogue_ligne_id, date_maj_tarif
    from t_catalogue_ligne
    where t_catalogue_id = :f
      and t_produit_id = new.t_produit_id
    into id_l, dtMAJ;
    
    if (row_count = 0) then
    begin
      select coalesce(max(no_ligne), 0) + 1
      from t_catalogue_ligne
      where t_catalogue_id = :f
      into :l;      
        
      insert into t_catalogue_ligne(t_catalogue_ligne_id,
                                    t_catalogue_id,
                                    no_ligne,
                                    t_produit_id,
                                    prix_achat_catalogue,
                                    prix_achat_remise,
                                    remise_simple,
                                    date_maj_tarif,
                                    colisage)
      values (next value for seq_catalogue_ligne,
              :f,
              :l,
              new.t_produit_id,
              new.prix_achat_tarif,
              new.prix_achat_remise,
              :r,
              :dt,
              new.colisage);
    end
    else
      if (dtMAJ < dt) then
        update t_catalogue_ligne
        set date_maj_tarif = :dt,
            prix_achat_catalogue = new.prix_achat_tarif,
            prix_achat_remise = new.prix_achat_remise,
            remise_simple = :r
        where t_catalogue_ligne_id = :id_l;            
  end
end;

create or alter trigger trg_va_operateur for t_vignette_avancee
active before insert or update
as
begin
  if (new.t_operateur_id is not null) then
    if (not exists(select null
	               from t_operateur
				   where t_operateur_id = new.t_operateur_id)) then
	  new.t_operateur_id = null;
end;