select
  m.med_num_id,
  sm.specmed_cde_codespecialite,
  cp.cpos_car_codepostal,
  cp.cpos_car_ville,
  cast(m.med_num_codenational as char(9)) FINESS,
  m.med_car_nom,
  m.med_car_chu,
  m.med_car_adresse1,
  m.med_car_adresse2,
  m.med_car_adresse3,
  m.med_tel_telephone,
  m.med_tel_fax,
  m.med_tel_portable,
  m.med_car_email,
  m.med_mem_memo,
  m.med_num_typeprescripteur,
  m.med_car_rpps,
  ets.finess_site
from
  tbl_medecin m
  inner join tbl_specialite_medecin sm on (sm.specmed_num_id = m.med_num_specmed_fk)
  left join tbl_codepostal cp on (cp.cpos_num_id = m.med_num_cpos_fk)
  left join TBL_ETABLISSEMENT_medecin ets_med on ets_med.tbl_medecin_id = m.med_num_id
  left join TBL_ETABLISSEMENT ets on ets_med.tbl_etablissement_id = ets.id
where
  m.med_bol_deleted = 0