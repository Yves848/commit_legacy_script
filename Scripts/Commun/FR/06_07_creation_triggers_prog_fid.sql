set sql dialect 3;

create or alter trigger trg_cf_client for t_programme_avantage_client
active before insert position 0
as
declare variable p integer;
declare variable t integer;
begin
  if ((new.encours_ca > 0) and not (exists (select null from t_produit where t_produit_id = 'Produit encours fidelite'))) then
  begin 
    execute procedure ps_renvoyer_id_prestation('PHN') returning_values :p;  
    execute procedure ps_renvoyer_id_tva(19.6) returning_values :t;  
    
    insert into t_produit(t_produit_id,
                          designation,
                          liste,
                          t_ref_prestation_id,
                          type_homeo,
                          prix_achat_catalogue,
                          prix_vente,
                          base_remboursement,
                          t_ref_tva_id,
                          profil_gs,
                          calcul_gs)
    values('Produit encours fidelite',
           'Produit reprise d encours programme fidelite',
           '0',
           :p,
           '0', 
           0,
           0,
           0,
           :t,
           '0',
           '0');
  end
end;