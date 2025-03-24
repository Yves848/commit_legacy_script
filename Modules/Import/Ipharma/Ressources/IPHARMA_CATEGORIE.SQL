select 
  t1.tar_id,
  t1.usage, 
  t1.categorie 
from 
  tar10 t1 
where 
  t1.date_validation = (select max(t2.date_validation)
	                    from tar10 t2 
	                    where t1.tar_id = t2.tar_id) and 
  t1.usage = 'F'