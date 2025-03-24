select 
'1',
amo.serial,
amo.code,
amo.libelle,
amo.grandregime,
amo.caissegestionnaire,
amo.centregestionnaire,
null,
adr.adresse1,
adr.adresse2,
adr.codepostal,
adr.ville,
adr.telephone,
adr.mobile,
adr.fax,
adr.mail,   
cast(regexp_replace(adr.commentaire , '\\[[:alnum:]]*|{.*;}|\n|}' , '' , 'g') as varchar(200) )
from amo amo 
left join adresse adr on adr.serial = amo.serialadresse