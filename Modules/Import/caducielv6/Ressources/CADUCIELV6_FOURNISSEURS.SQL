select
  f.four_num_id,
  f.four_car_nom,
  null cpos_car_codepostal,
  null cpos_car_ville,
  null four_car_adresse1,
  null four_car_adresse2,
  null four_car_adresse3,
  tf.typfour_cde_code,
  f.four_num_typeprotocole,
  f.four_tel_telephone,
  f.four_tel_fax,
  null four_tel_portable,
  f.four_car_adrinternet,
  f.FOUR_CDE_PMLCODEREPARTITEUR,
  f.FOUR_CAR_PMLSERVEURPRINCIPAL,
  f.FOUR_CAR_PMLSERVEURSECONDAIRE,
  f.FOUR_CAR_PMLIDOFFICINE,
  f.FOUR_CAR_PMLIDREPARTITEUR,
  f.FOUR_CAR_PMLCLEFOFFICINE,
  f.four_mem_memo
from
  tbl_fournisseur f
  inner join tbl_type_fournisseur tf on (tf.typfour_num_id = f.four_num_type_fk)
where
  f.four_bol_deleted = 0  