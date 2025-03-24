select
  p.code_uv,
  p.nom_prod,
  p.cip,
  p.cip13,  
  p.liste,
  t.libelle_tva,
  p.base,
  p.prix_ttc,
  p.code_acte,
  p.ean,
  p.prix_ht,
  p.code_categorie,
  p.commentaire,
  p.code_geo,
  p.code_lpp,
  p.commentaire2,
  p.delai_lait,
  p.delai_viande,
  p.delai_oeuf,
  p.code_georeserve,
  s.code_fournisseur,
  s.nb_stock,
  s.mini_stock,
  s.maxi_stock,
  s.dernprixd_stock,
  s.dernprixg_stock,
  s.datedernvente_stock,
  s.stock_robot,
  s.grosexclu_stock,
  s.stock_minirobot,
  s.minirayon_stock,
  s.maxirayon_stock,
  s.flreserve_stock,
  s.nbstock_rayon,
  (select valeur_param
   from dbo.parametre
   where code_param = 'GESTSTOCK') geststock,
  (select valeur_param
   from dbo.parametre
   where code_param = 'STOCKRESER') stockreserv,
  (select valeur_param
   from dbo.parametre
   where code_param = 'GESTROBOT') stockrobot
from 
  dbo.produit p
  inner join dbo.tva t on (t.code_tva = p.code_tva)
  inner join dbo.stock s on (s.code_uv = p.code_uv)

where p.code_uv in (select code_uv from statprod) -- deja vendu
or s.nb_stock > 0 -- ou avec du stock