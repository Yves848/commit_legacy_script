select
  cast(t_catalogue_id as varchar(50)), 
  designation,
  date_debut,
  date_fin,
  cast(t_fournisseur_id as varchar(50)),
  date_creation,
  date_fin_validite
from 
  erp.t_catalogue_entete