select 
ent.cli_ti,
ent.ben_ti,
ent.date_order,
ent.ti,
lig.cip,
cast(lig.quantite as signed),
lig.prix,
lig.base_rembt,
ent.oper_code 

from orders0 Ent 
left join orditem Lig
on ent.ti = lig.order_ti

 where attente = 'V'
 and total_general <>0
 and lig.quantite > 0
 and ent.Base_ti = 0
 and ent.next_ti = 0
and (flags2>>23)&1  = 0