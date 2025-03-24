select 
'2',
amc.serial,
amc.code,
amc.libelle,
null,
null,
null,
amc.numeromutuelle,
adr.adresse1,
adr.adresse2,
adr.codepostal,
adr.ville,
adr.telephone,
adr.mobile,
adr.fax,
adr.mail,   
cast(regexp_replace(adr.commentaire , '\\[[:alnum:]]*|{.*;}|\n|}' , '' , 'g') as varchar(200) ),
amc.codetypeamc 
from amc amc 
left join adresse adr on adr.serial = amc.serialadresse