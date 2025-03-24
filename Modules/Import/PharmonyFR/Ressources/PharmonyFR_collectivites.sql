select id,
	   first_name,
	   last_name,
	   name,
	   street,
	   city,
	   postcode,
	   phone_number,
	   fax,
	   email,
	   mobile_phone_number,
	   comment,
	   cast(debt as float)
from collectivities
union
select ass.id,
	   ass.first_name,
	   ass.last_name,
	   '',
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
where trim(ssn) = ''
