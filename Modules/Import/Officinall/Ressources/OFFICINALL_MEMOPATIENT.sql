select mem_primkey ,
       mem_type ,
       mem_pat_primkey ,
       mem_omschrijving ,
       mem_attestnr ,
       mem_vervaldatum ,
       mem_attestcategorie ,
       mem_aantal
from dbo.memopatient
inner join patient on pat_primkey = mem_pat_primkey
where mem_type=7
  or mem_type=8
  or mem_type=9