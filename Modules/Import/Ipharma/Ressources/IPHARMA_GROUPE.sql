select 
  g.institution_id, 
  g.nom,
  g.tva, 
  a.adresse,
  l.cp,
  l.pays,
  l.nom localite, 
  t.telephone,
  gsm.gsm,
  fx.telefax
from 
  institution g
  left join adresse a on a.adresse_id = g.adresse_id
  left join localite l on l.localite_id = a.localite_id
  left join telephone t on t.owner_id = g.adresse_id and t.owner_type ='ADRESSE'
  left join gsm on gsm.owner_id = g.adresse_id and gsm.owner_type ='ADRESSE'
  left join telefax fx on fx.owner_id = g.adresse_id and fx.owner_type ='ADRESSE'
where 
  g.visible > 0 and 
  g.nom is not null and g.nom <> ''