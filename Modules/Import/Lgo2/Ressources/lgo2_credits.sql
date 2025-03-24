  select
  customer,
  sum(ttc - pay),
  max(day)
from
  "LGO2".credits c
where  c.state = 0 
	and ( c.tuteur = 0 or c.customer = c.tuteur )  
	and c.type not in ( 8 )  
	-- and day > '01-01-2020' si filtrage en amont
group by
  customer