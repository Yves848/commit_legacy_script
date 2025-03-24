select v .personne_id
,t1.ristourne_carte_id   
, max(date_enregistrement)  as datev
,t1.numero_carte
from 
  ristourne_carte t1
  inner join ristourne_carte_detail t2 on t1.ristourne_carte_id=t2.ristourne_carte_id
  inner join vente v on v.vente_id = t2.vente_id 
group by 
  v .personne_id,t1.ristourne_carte_id, t1.numero_carte
order by t1.ristourne_carte_id , datev desc