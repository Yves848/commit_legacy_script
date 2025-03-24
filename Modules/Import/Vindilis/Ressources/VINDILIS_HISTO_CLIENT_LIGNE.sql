select 
  lv.serialvente,
  lv.codeamm,
  prd.serial,
  prd.libellearticle,
  lv.prixachat,
  lv.prixbrut,
  lv.quantite
from   vente v
  inner join lignevente lv on lv.serialvente = v.serial
  inner join article prd on prd.serial = lv.serialarticle  
  inner join stock stk on stk.serialarticle = prd.serial
where v.serialclient is not null
  and v.serialclient <> 0
  and lv.typearticle='1'