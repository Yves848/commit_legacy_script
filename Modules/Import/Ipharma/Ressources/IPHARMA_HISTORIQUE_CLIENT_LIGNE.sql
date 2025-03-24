select 
  d.vente_ligne_specialite_id, 
  d.vente_id, 
  d.tar_id, 
  null,
  d.delivre, 
  d.prix_public_piece
from 
  vente_ligne_specialite d 
  inner join vente v on v.vente_id = d.vente_id
where 
  d.delivre >= 0 and 
  d.parent_credit_ordo_id = 0