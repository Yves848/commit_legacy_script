select 
  cp.codeprod_num_produit_fk,
  tcp.typcodprod_num_code,
  lpad(cp.codeprod_cde_code, 13, '0')
from 
  tbl_code_produit cp
  inner join tbl_type_code_produit tcp on (tcp.typcodprod_num_id = cp.codeprod_num_type_fk)
  inner join tbl_produit p on cp.codeprod_num_produit_fk = p.pro_num_id
 where
  tcp.typcodprod_num_code in (3, 4, 5, 6) 
  and p.pro_bol_deleted = 0  
  and (p.pro_dti_datedernierevente > dateadd(-48 month to current_date)   or p.pro_num_stocktotal>0 )
  order by tcp.typcodprod_num_code desc