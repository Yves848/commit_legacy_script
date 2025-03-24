select 
  extract(year from date_delivrance), 
  extract(month from date_delivrance),
  tar_id, 
  sum(delivre)
from 
  vente_ligne_specialite 
group by
  extract(year from date_delivrance), 
  extract(month from date_delivrance),
  tar_id
having sum(delivre) > 0