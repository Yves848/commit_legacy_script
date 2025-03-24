select 
  customer, 
  index, 
  amc, 
  camc, 
  startday, 
  stopday, 
  cast(contrat as varchar(30))
from "LGO2".csamc
order by customer asc, stopday asc