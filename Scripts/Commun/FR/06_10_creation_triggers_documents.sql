set sql dialect 3;

create or alter trigger trg_document for t_document
active before insert position 0
as
begin
  if (new.type_entite = '0') then
    if (not exists(select *
	               from t_client
				   where t_client_id = new.t_entite_id)) then
      exception exp_doc_entite_inconnue 'Client inconnu !';
  else if (new.type_entite = '1') then
    if (not exists(select *
	               from t_fournisseur_direct
				   where t_fournisseur_direct_id = new.t_entite_id)) then
      exception exp_doc_entite_inconnue 'Fournisseur inconnu !';				   
  else if (new.type_entite = '2') then
    if (not exists(select *
	               from t_repartiteur
				   where t_repartiteur_id = new.t_entite_id)) then
      exception exp_doc_entite_inconnue 'Répartiteur inconnu !';	  
end;