select
  lpp.cip,
  lpp.code_lppr,
  lpp.qte,
  p.base_rembt
from 
  lppr_cip lpp
  left join produit p on (p.cip = lpp.cip)

where ( p.en_stock > 0 or datediff( current_date, p.Dernier_Vente) < 1095)