select mem_primkey,
       mem_prd_primkey,
       mem_pat_primkey,
       mem_attestnr,
       mem_vervaldatum,
       mem_attestcategorie,
       mem_attestvoorwaarde,--condition,
       mem_opmerking,
       mem_type
from memopatient
where ((mem_type=1 and (mem_vervaldatum>(getdate()-365*2)) ) 
  or mem_type=10)
  and mem_attestnr <> ''
