select 
hl.lfdate,
hl.lfnochrono,
hl.lfnom,
ltrim(hl.lfcip, '0'),
hl.lfpuvente,
hl.lfqte
from af25 hl
left join af21 he on he.fdate = hl.lfdate and he.fchrono = hl.lfnochrono
where he.fdate > current_date - (365*2) 
and he.fnointerne > 0  
and he.fetatfacture <> 'A' 
and hl.lfcip <= '9' and hl.lfcip >= '0' 
and hl.lfqte > 0