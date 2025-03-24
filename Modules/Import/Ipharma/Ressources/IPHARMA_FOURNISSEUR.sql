select
  f.fournisseur_id,
  f.nom,
  a.adresse,
  l.nom localite,
  l.cp,
  l.pays,
  t.telephone,
  g.gsm,
  fx.telefax
from
  fournisseur f
  left join adresse a on f.adresse_id = a.adresse_id
  left join localite l on l.localite_id = a.localite_id
  left join telephone t on t.owner_id = f.adresse_id and t.owner_type ='ADRESSE'
  left join gsm g on g.owner_id = f.adresse_id and g.owner_type ='ADRESSE'
  left join telefax fx on fx.owner_id = f.adresse_id and fx.owner_type ='ADRESSE'