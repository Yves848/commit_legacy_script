select 
  ean_code,
  ean_cnknummer
from 
  ftbeancodes 
where 
  ean_code is not null and trim(ean_code) <> '' and
  ean_cnknummer is not null and trim(ean_cnknummer) <> ''