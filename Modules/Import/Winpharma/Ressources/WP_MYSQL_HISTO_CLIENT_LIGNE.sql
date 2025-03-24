select 
order_ti t_historique_client_id,
cip ,
quantite ,
prix 
from orditem lig 
inner join orders0 ent on lig.order_ti = ent.ti
where quantite > 0 and datediff(current_date,ent.date_order)<1095 and cip > 0 and cli_ti > 0 and base_ti=0
