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
  p.prim_num_codegrandreg,
  p.prim_num_codeprim,
  p.prim_num_codecentre,
  p.prim_num_orgb2_fk
from
  tbl_primaire p
  inner join tbl_caisse c on (c.cai_num_id = p.prim_num_id_pk)
  left join tbl_adrcaisse a on (a.adrcai_num_id = c.cai_num_adrcai_fk)
  left join tbl_codepostal cp on (cp.cpos_num_id = a.adrcai_num_cpos_fk) 