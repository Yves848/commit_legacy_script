select mem_primkey,
       case when mem_type = 3 then 
        -1*round(mem_bedrag,2) 
       else 
        round(mem_bedrag,2) 
       end as montant,
       mem_datechanged,
       mem_pat_primkey
from memopatient 
inner join patient on pat_primkey=mem_pat_primkey
where  (mem_type=2 or mem_type=3) and mem_bedrag<>0
