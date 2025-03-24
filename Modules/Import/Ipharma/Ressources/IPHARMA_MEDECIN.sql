select distinct 
  p.prescripteur_id, 
  p.personne_id, 
  p.cabinet_id, 
  p.matricule, 
  p.veterinaire,
  a.adresse, 
  l.cp,
  l.pays,
  l.nom localite, 
  per.nom, 
  per.prenom,
  t.telephone,
  g.gsm,
  fx.telefax
from 
  prescripteur p
  inner join vente v on v.prescripteur_id = p.prescripteur_id
  inner join personne per on per.personne_id = p.personne_id
  left join adresse a on a.adresse_id = p.cabinet_id
  left join localite l on l.localite_id = a.localite_id
  left join telephone t on t.owner_id = p.cabinet_id and t.owner_type ='ADRESSE'
  left join gsm g on g.owner_id = p.cabinet_id and g.owner_type ='ADRESSE'
  left join telefax fx on fx.owner_id = p.cabinet_id and fx.owner_type ='ADRESSE'
where 
  p.visible = 1
order by 
  p.cabinet_id desc
