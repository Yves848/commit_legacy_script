select id,
	   first_name,
	   last_name,
	   substr(street,1,80),
	   city,
	   postcode,
	   phone_number,
	   fax,
	   email,
	   mobile_phone_number,
	   comment,
	   speciality,
	   exercise_mode,
	   rpps,
	   invoicing_code 
from prescribers
