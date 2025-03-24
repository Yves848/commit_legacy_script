select 
  d.vente_ligne_preparation_id, 
  d.vente_id, 
  d.libelle, 
  d.delivre, 
  d.FORME_GALENIQUE,
  d.NOMBRE_FORME,
  vdp.cnk,     
  iif(vdp.AD='T',2,1),
  vdp.dose,
  vdp.unite
  
from 
  vente_ligne_preparation d 
  inner join VENTE_DETAIL_PREPARATION vdp on d.vente_ligne_preparation_id = vdp.LIGNE_VENTE_PREPARATION_ID
where 
  d.delivre >= 0 and 
  d.parent_credit_ordo_id = 0
order by DETAIL_PREPARATION_ID