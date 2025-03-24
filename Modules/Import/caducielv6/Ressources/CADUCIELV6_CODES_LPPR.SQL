select
  pllp.prolppr_num_produit_pk,
  lpp.lppr_cde_code,
  a.act_cde_code,
  s.serv_cde_code,
  lpp.lppr_num_prixvente,
  pllp.prolppr_num_quantite
from 
  tbl_produit_lppr pllp
  inner join tbl_code_lppr lpp on (lpp.lppr_num_id = pllp.prolppr_num_codelppr_pk)
  inner join tbl_acte a on (a.act_num_id = lpp.lppr_num_act_fk)
  inner join tbl_service s on (s.serv_num_id = lpp.lppr_num_serv_fk)
  inner join tbl_produit p on (p.pro_num_id = pllp.prolppr_num_produit_pk)
where
  p.pro_bol_deleted = 0 
  and (p.pro_dti_datedernierevente > dateadd(-48 month to current_date)  or p.pro_num_stocktotal>0 )