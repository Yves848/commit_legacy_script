select
  t1.ristourne_carte_id,
  t2.numero_carte,
  sum(t1.valeur),
  t1.tva
from
  ristourne_carte_detail t1
  inner join ristourne_carte t2 on t2.ristourne_carte_id = t1.ristourne_carte_id
where
  ristourne_execution_id = 0
group by
  t1.ristourne_carte_id,
  tva,
  numero_carte