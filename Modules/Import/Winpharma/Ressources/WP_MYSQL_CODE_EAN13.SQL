select 
  codeean.ean, 
  codeean.pro_cip
from 
  prodean codeean
  left join produit p on (p.cip = codeean.pro_cip)

where ( p.en_stock > 0 or datediff( current_date, p.Dernier_Vente) < 1095 )