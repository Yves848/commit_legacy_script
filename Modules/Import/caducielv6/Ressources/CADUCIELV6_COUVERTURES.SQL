select distinct 
  r.reg_num_id,
  r.reg_car_nom,
  R.reg_num_nature,
  e.exo_cde_codeexo,
  r.reg_bol_am
from 
  tbl_regime r
  left join tbl_exoneration e on (e.exo_num_id = r.reg_num_exo_fk)
where
  r.reg_bol_deleted = 0  