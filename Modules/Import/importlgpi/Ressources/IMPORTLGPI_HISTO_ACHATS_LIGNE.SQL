select cast(l.t_commande_id as varchar2(50)),
       cast(l.t_produit_id as varchar2(50)),
       l.qtecdee,
       l.qterecue,
       l.qtetotalerecue,
       l.prixachattarif,
       l.prixachatremise,
       l.prixvente,
       l.receptionfinanciere,
       l.choixreliquat,
       l.qteug
from erp.t_lignecommande l
     inner join erp.t_commande e on e.t_commande_id = l.t_commande_id
     inner join erp.t_produit p on p.t_produit_id = l.t_produit_id
where e.etat = '3'
  and p.id_del is null
  and p.reference = '0'