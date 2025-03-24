select 
ent.cli_ti,
cast(ent.ben_ti as signed ),
ent.date_order,
ent.ti
from orders0 Ent 
where attente = 'A'
and (flags2 >> 11)&1 = 0
