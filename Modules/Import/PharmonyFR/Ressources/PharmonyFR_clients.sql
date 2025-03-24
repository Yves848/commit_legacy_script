select ass.id,
	   ass.first_name,
	   ass.last_name,
	   ass.birthdate,
	   ass.birth_rank,
	   ass.ssn,
	   ass.ssn_check_digit,
	   couv.quality,
	   ass.gender,
	   ass.status,
	   ass.street,
	   ass.city,
	   ass.postcode,
	   ass.phone_number,
	   ass.fax,
	   ass.email,
	   ass.mobile_phone_number,
	   ass.comment,
	   cast(ass.debt as float)
from patients ass
left join insurance_covers couv on ass.id = couv.patient_id 	   
where trim(ssn) > ''