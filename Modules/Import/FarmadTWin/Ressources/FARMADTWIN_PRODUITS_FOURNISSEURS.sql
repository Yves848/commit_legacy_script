select -- Produits 
  p_levnum, 
  count(*)
from 
  ftbproducten
where 
  p_cnknummer is not null and 
  p_levnum <> 0
group by 
  p_levnum       

union

select -- fiches analyse chimiques 
  an_levnummer, 
  count(*) 
from 
  FTBANALYSEREG
group by 
  AN_LEVNUMMER