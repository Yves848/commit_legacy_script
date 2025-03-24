select
  sisitu,
  silibel[1], 
  silibel[11]
from 
  svsitu
where 
  sireg = 'ZM' and
  silibel[1] <> '' and 
  silibel[11] <> ''  and    
  silibel[11] <> 100