select
  ot.orgtra_num_id,
  ot.orgtra_car_nom,
  ot.orgtra_car_adresse1,
  ot.orgtra_car_adresse2,
  ot.orgtra_car_adresse3,
  cp.cpos_car_codepostal,
  cp.cpos_car_ville,
  ot.orgtra_tel_telephone,
  ot.orgtra_tel_fax,
  ot.orgtra_car_loginbal,
  ot.orgtra_car_mdpbal,
  ot.orgtra_car_emailbal,
  ot.orgtra_car_nombal,
  ot.orgtra_car_serveurpop,
  ot.orgtra_car_serveursmtp
from
  tbl_organisme_transmission ot
  left join tbl_codepostal cp on (cp.cpos_num_id = ot.orgtra_num_codepos_fk)