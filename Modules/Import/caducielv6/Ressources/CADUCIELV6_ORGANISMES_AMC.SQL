select
  c.cai_num_id,
  c.cai_car_nom,
  c.cai_car_abr,
  a.adrcai_car_adresse1,
  a.adrcai_car_adresse2,
  a.adrcai_car_adresse3,
  cp.cpos_car_codepostal,
  cp.cpos_car_ville,
  a.adrcai_tel_tel,
  a.adrcai_tel_fax,
  m.mut_cde_codepref,
  m.mut_num_typecontrat,
  m.mut_bol_estlieeavecprim,
  ame.ame_cde_code,
  m.mut_num_orgb2_fk
from
  tbl_mutuelle m
  inner join tbl_caisse c on (c.cai_num_id = m.mut_num_id_pk)
  inner join tbl_ame ame on (ame.ame_num_id = m.mut_num_ame_fk)
  left join tbl_adrcaisse a on (a.adrcai_num_id = c.cai_num_adrcai_fk)
  left join tbl_codepostal cp on (cp.cpos_num_id = a.adrcai_num_cpos_fk) 
  