select distinct 
  k.tar_id, 
  k.fournisseur_preferentiel
from 
  stock k 
where 
  k.fournisseur_preferentiel is not null and 
  k.fournisseur_preferentiel > 0