select 
  f.be_code du_code, -- id client DOIT se nommer DU_CODE
  d.du_libel,  -- les champs sont reconnus par Fiedlbyname
  g.dg_fic 
from 
  document d
  inner join docpage g on (g.du_num = d.du_num)
  inner join notefac f on (f.no_nsubr = d.du_code )
where 
d.du_date >=add_months(sysdate,-12) and  
  d.td_code in (400, 402, 404, 406 , 403, 408) -- Ordonnances
