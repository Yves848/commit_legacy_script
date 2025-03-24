select distinct invoicing_code,
				substr(structure_name,1,50),
				substr(structure_street,1,80),
				structure_city,
				structure_postcode,
				structure_phone_number,
				structure_fax,
				substr(structure_email,1,50)
from prescribers				
