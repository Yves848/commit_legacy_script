select cast(p.t_aad_id as varchar2(50)),
       a.dateacte,
       cast(p.t_produit_id as varchar2(50)),
       p.qtedue
from erp.t_produitdu p,
     erp.t_acte a
where p.t_acte_id = a.t_acte_id