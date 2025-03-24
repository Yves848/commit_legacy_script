select
  c.com_num_id,
  c.com_bol_cdedirecte,
  c.com_dte_datecreation,
  c.com_num_fournisseur_fk,
  c.com_num_etatcom_fk,
  bl.bl_dte_datecreation
from
  tbl_commande c
  inner join tbl_fournisseur f on (f.four_num_id = c.com_num_fournisseur_fk)
  left join tbl_bon_livraison bl on (bl.bl_num_commande_fk = c.com_num_id)
where 
  c.com_num_etatcom_fk in (3, 4, 6) 
  and f.four_bol_deleted = 0 
  and c.com_dte_datecreation > dateadd(-24 month to current_date)
