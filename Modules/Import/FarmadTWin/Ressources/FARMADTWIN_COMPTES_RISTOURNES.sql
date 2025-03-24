select 
  distinct skr.skr_id, 
  skr.skr_hoofdklant 
from 
  ftbspaarkaartrekening skr
  left join ftbklanten c on c.k_klantnummer = skr.skr_hoofdklant