select 
	fac.cli_ti , 
	fac.ben_ti ,
	fac.date_order ,
	sum(reg.total0) 

from orders0 fac
left join regord reg on reg.order_ti = fac.ti  

where  reg.regletype = 'D' and attente not in ( 'A', 'V' ) and flags2 not in ( 532480 , 598016 )
group by fac.cli_ti
having  abs(sum(reg.total0)) > 0.01