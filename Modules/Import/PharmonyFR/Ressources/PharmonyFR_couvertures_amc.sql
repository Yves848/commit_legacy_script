select distinct supplementary_insurance_id,
				formula,
				cast(value_ph2 as float),
				cast(value_ph4 as float),
				cast(value_ph7 as float),
				cast(value_phn as float),
				cast(value_lpp as float)
from insurance_covers
where supplementary_insurance_id > '' 
 and  value_ph2  > '' and value_ph4  > '' and value_ph7  > ''

