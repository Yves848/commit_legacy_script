select 
    ci,
    cast(substring(finess from 1 for 9) as varchar(9)) finess,
    cast(substring(rpps from 1 for 11) as varchar(11)) rpps,
    speciality,
    struct ,        
    cast(structid as  varchar(10)),
    cast(substring(nom from 1 for 50) as varchar(50)) nom,
    cast(substring(prenom from 1 for 50)as varchar(50)) prenom,
    substring(rue from 1 for 40),
    substring(cp from 1 for 5),
    substring(ville from 1 for 30), 
    substring(tel from 1 for 20), 
    substring(fax from 1 for 20), 
    substring(gsm from 1 for 20), 
    substring(mail from 1 for 50)
from "LGO2"."doctors"
where not( structid > '0' and struct = 0 )