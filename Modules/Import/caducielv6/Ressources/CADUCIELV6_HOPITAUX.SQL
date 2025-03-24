select ID,
       NOM,
       FINESS_SITE,
       cpos_car_codepostal as CP,
       cpos_car_ville as VILLE,
       ADRESSE,
       TELEPHONE,
       PORTABLE,
       FAX,
       EMAIL
from TBL_ETABLISSEMENT ETS
left join TBL_CODEPOSTAL CP on CP.cpos_num_id = ETS.TBL_CODEPOSTAL_ID