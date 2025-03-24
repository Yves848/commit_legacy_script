select 
he.fdate,
he.fchrono,
he.fnointerne,
he.fnomedecin,
he.ffactorg,
he.fdelivrance, 
he.fdateordonnance,
he.ftypefacture
from af21 he
where fdate > current_date - (365*2)
and he.fnointerne > 0  
and he.fetatfacture not in ('A','0')