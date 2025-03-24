select 
  ent.nocomgros - (ent.nocomgros>>28)* 268435456,
  lig.cip,
  lig.quantite,
  lig.qte_r,
  lig.qteUG,
  lig.prix_HT,
  lig.remise1,
  lig.prixv_ttc,
  dtLivraison,
  dtLivraisonReel
from 
  COMGROit lig
  inner join COMGROS ent on lig.nocomgros =ent.nocomgros  
  left join produit prd on lig.cip =prd.cip  
where 
  lig.cip > 0 
  and etape in (1, 2, 3) 
  and ent.code_fourn > ''
  and datediff(current_date,cast(from_unixtime(lig.Create_Time) as date))<1095
 