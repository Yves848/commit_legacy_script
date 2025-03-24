select 
	ti t_historique_client_id,
	cli_ti,
	ben_ti,
	numfacture numero_facture, 
	ordon_date date_prescription,
	oper_code code_operateur,
	med_ti code_praticien,
	med_nomprenom praticien_nom,
	Date_order date_acte
from orders0
where datediff(current_date,date_order)<1095 and cli_ti >0 and base_ti=0

