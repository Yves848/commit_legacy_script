select 
  lig.comgros,
  lig.cip,
  lig.qteC,
  lig.qteR,
  lig.qteUG,
  lig.prixachatht,
  lig.remisefinal,
  prd.prix_public,
  lig.dtLivraison,
  lig.dtLivraison
from 
  stachat lig
  left join produit prd on lig.cip =prd.cip  
where 
  lig.cip > 0 and   lig.qteC >0
