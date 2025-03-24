select 
  d.du_code, -- attention
  d.du_libel, -- les champs sont reconnus par Fiedlbyname
  g.dg_fic
from 
  document d
  inner join docpage g on (g.du_num = d.du_num)
where 
d.du_date >=add_months(sysdate,-12) and  
  d.td_code in (300 ,302 )  -- attestations mutuelles