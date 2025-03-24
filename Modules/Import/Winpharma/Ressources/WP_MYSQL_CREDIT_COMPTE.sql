select  
	cli_ti,
	date(from_unixtime(time_change)) ,
	total_compte-regle_compte-total_remise_M2
from orders0 Ent 
where code_subro <> 'RETF' and base_ti = 0
and total_compte-regle_compte-total_remise_M2>0
