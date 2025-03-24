select c.t_produit_id,
       c.code_ean13,
       c.referent
from erp.t_code_ean13 c
   inner join erp.t_produit p on c.t_produit_id = p.t_produit_id
where c.t_produit_id <> -1
  and p.id_del is null
  and p.reference = '0'