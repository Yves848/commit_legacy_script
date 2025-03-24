select 
prmcode,
prmdate,
prmnocip,
prmqte,
prmpufact,
prmavance
from af37
where prmdate > current_date - (365)  
and prmindex = 1
and prmvenddeliv = 0