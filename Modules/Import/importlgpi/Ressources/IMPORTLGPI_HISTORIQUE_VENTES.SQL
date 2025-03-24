select cast(h.t_produit_id as varchar2(50)),
       to_char(h.moisannee, 'MMYYYY'),
	      h.nbventes,
	      h.qtevendue
from erp.t_historiquevente	h
     inner join erp.t_produit p on p.t_produit_id = h.t_produit_id
where p.materiel_location = '0'
  and p.id_del is null
  and p.reference = '0'