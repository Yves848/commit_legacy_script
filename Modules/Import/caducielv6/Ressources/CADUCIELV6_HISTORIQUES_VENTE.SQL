select
  h.histpro_num_produit_fk,
  h.histpro_num_mois,
  h.histpro_num_annee,
  h.histpro_num_qtevendue
from
  tbl_historique_produit h
  inner join tbl_produit p on (p.pro_num_id = h.histpro_num_produit_fk)
where
  p.pro_bol_deleted = 0  
  and (p.pro_dti_datedernierevente > dateadd(-48 month to current_date)  or p.pro_num_stocktotal>0 )