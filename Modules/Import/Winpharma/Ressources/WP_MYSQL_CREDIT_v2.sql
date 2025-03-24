select  
	cli_ti,
	ben_ti,
	date(from_unixtime(time_modif)) ,
	sum(total0)
from orders0 Ent 
left join  regord reg on (  reg.order_ti = ent.ti and reg.regletype = 'D' )
where  next_ti = 0 and attente = 'D'  and code_subro <> 'RETF' and base_ti = 0
group by  ent.ti 
having sum(total0) <> 0