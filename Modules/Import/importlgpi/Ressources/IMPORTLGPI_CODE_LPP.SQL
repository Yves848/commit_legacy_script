select cast(l.t_produit_id as varchar2(50)),
       l.typecode,
       l.code_lpp,
       l.qte,
       l.tarif_unitaire,
       pr.code,
       l.service
from erp.t_produit_lpp l,
     erp.t_produit p,
     erp.t_prestation pr
where l.t_produit_id = p.t_produit_id
  and l.t_prestation_id = pr.t_prestation_id(+)
  and p.materiel_location = '0'