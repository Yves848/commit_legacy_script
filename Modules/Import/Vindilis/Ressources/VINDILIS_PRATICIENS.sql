select 
med.serial,
med.nom,
med.prenom,
adr.adresse1,
adr.adresse2,
adr.codepostal,
adr.ville,
adr.telephone,
adr.mobile,
adr.fax,
adr.mail,   
cast(regexp_replace(adr.commentaire , '\\[[:alnum:]]*|{.*;}|\n|}' , '' , 'g') as varchar(200) ), 
med.numero finess,
med.specialite,
med.ratp,
med.numerorpps
from prescripteur med
left join adresse adr on adr.serial = med.serialadresse