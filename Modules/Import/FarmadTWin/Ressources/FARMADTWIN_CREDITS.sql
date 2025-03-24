select 
  cr.kr_id,
  cr.kr_klantnummer, 
  cr.kr_datum,
  cr.kr_nogtebetalen   
from 
  ftbkredieten cr
  inner join ftbklanten c on c.k_klantnummer = cr.kr_klantnummer 
where cr.kr_is_niet_betaald ='Y'
  