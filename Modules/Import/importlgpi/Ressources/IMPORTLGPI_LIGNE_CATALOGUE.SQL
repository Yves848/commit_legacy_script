select 
  cl.t_catalogue_id,
  cl.t_gamme_id,
  cl.no_ligne,
  cr.t_produit_id,
  cl.prixachatcatalogue,
  cl.prix_achat_remise,
  cl.remisesimple,
  cl.date_maj_tarif,
  cl.date_creation,
  cl.colisage
from
  erp.t_catalogue_ligne cl
  inner join erp.t_catalogue_reference cr on (cr.t_lignecatalogue_id = cl.t_lignecatalogue_id)
  inner join erp.t_produit p on p.t_produit_id = cr.t_produit_id
where
  cr.t_produit_id is not null
  and p.id_del is null
  and p.reference = '0'