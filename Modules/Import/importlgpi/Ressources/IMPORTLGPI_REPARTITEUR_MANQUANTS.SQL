select
  cast(t_fournisseur_id as varchar2(50)),
  cast(rep_t_fournisseur_reaffmqts_id as varchar2(50))
from 
  t_fournisseur
where type_fournisseur = 'R'
