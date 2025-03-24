select 
  sk_id, 
  sk_klantid, 
  sk_spaarrekeningid 
from 
  ftbspaarkaarten 
where 
  sk_id <>' ' and sk_id is not null
order by 
  sk_id, 
  sk_klantid