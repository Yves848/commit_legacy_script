select
  c.cli_num_id,
  c.cli_car_nom,
  c.cli_car_adresse1,
  c.cli_car_adresse2,
  c.cli_car_adresse3,
  c.cli_car_adresse4,
  c.cli_car_adresse5,
  cp.cpos_car_codepostal,
  cp.cpos_car_ville,
  c.cli_tel_telephone,
  c.cli_tel_portable,
  c.cli_tel_fax
from tbl_client c
     left join tbl_assure a on (a.ass_num_idclient_pk = c.cli_num_id)
     left join tbl_assure ass on (ass.ass_num_idclient_pk = a.ass_num_assure_fk)
     left join tbl_codepostal cp on (cp.cpos_num_id = c.cli_num_cpos_fk)
where  c.cli_bol_estcompte = -1 or cli_num_id in ( select cli_num_compte_fk from tbl_client where cli_num_compte_fk is not null  )


