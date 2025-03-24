select 
ent.ti,
lig.cip,
lig.quantite,
lig.prix
from orders0 Ent 
left join orditem Lig
on ent.ti = lig.order_ti
where attente = 'A' and cip >0 
and (flags2 >> 11)&1 = 0
