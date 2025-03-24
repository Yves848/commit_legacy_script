select 
coalesce(tar.code_fourn_obs,''), 
coalesce(tar.cip_obs,''),
coalesce(tar.prix_HT_DA_tarif,0),
coalesce(tar.remise,0),
coalesce(tar.prioritet,0)
from prodprix tar
left join produit prd on tar.cip_obs =prd.cip  
where ( flags <> 1 ) and ( prd.en_stock > 0 or datediff( current_date, prd.Dernier_Vente) < 1095 ) 