select 
  d.vente_id, 
  d.date_vente, 
  d.personne_id,
  d.date_prescription, 
  p.nom,
  p.prenom, 
  d.numero_ordonnance
from 
  vente d
  left join prescripteur m on m.prescripteur_id = d.prescripteur_id
  left join personne p on p.personne_id = d.personne_id