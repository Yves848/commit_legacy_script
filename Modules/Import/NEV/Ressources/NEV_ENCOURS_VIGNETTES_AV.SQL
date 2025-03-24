select 
prmcode,
prmdate,
prmnocip,
prmqte,
prmpufact,
prmavance
from af37
where prmdate > current_date - (365*2)  
and prmindex = 2