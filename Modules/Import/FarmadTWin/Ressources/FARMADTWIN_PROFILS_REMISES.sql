select 
  distinct (k_kortingspercent)
from 
  ftbklanten 
where 
 k_kortingspercent is not null and 
 k_kortingspercent <> 0
union 
select 
  distinct(fg_korting1) 
from 
  FTBFACTGROEPEN
where 
  fg_korting1 > 0
