select cast(c.t_commande_id as varchar2(50)),
       c.datecreation,
       c.modetransmission,
       c.montantht,
       decode(f.type_fournisseur, 'D', cast(c.t_fournisseur_id as varchar2(50)), null),
       decode(f.type_fournisseur, 'R', cast(c.t_fournisseur_id as varchar2(50)), null),
       c.etat,
       c.datereception
from erp.t_commande c,
     erp.t_fournisseur f
where c.t_fournisseur_id = f.t_fournisseur_id
  and c.etat = '3'