select
  va.indexVA,
  va.index_assure,
  va.datefacture,
  va.cip_prod,
  p.nom_prod,
  va.prixttc,
  p.prix_ht,
  p.code_acte,
  va.code_uv,
  va.num_ope,
  va.quantite,
  p.base
from 
  dbo.vignavancee va
  inner join dbo.produit p on p.code_uv = va.code_uv
where va.etat =''