select  patient_id,
		lti_code,
		situation_code,
		system_code,
		management_fund,
		management_center,
		principal_start_at,              
		principal_end_at,
		supplementary_insurance_id,
		member_number		
		supplementary_insurance_id,
		formula,
		coalesce(nullif(value_ph2 ,''),'0'),      
		coalesce(nullif(value_ph4 ,''),'0'),
		coalesce(nullif(value_ph7 ,''),'0'),                
		coalesce(nullif(value_phn ,''),'0'),
		coalesce(nullif(value_lpp ,''),'0'),
		cast(supplementary_start_at as varchar(10)),
		cast(supplementary_end_at as varchar(10)),
		handling_mode
from insurance_covers				
where patient_id > ''