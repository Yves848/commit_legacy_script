select
  t1.tar_id,
  t1.prix_public,
  t1.prix_base,
  t1.tva
from
  tar21 t1
where
  t1.date_validation = (select max(t2.date_validation)
                        from tar21 t2 where t1.tar_id = t2.tar_id)