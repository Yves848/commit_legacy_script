select 
 type, --0 rép, 1 et 2 fourn direct
 ci,
 cast(fnom as varchar(80)) nom,
 cast(rue as varchar(80)) rue,
 cast(cp as varchar(5)) codepostal,
 cast(ville as varchar(40)) ville,
 cast(ftel as varchar(20)) telfour,
 cast(ffax as varchar(20)) as faxfour,
 cast(rnom as varchar(40)) as representant, --nom representant
 cast(providercode as varchar(20)) ,
 cast(providerid as varchar(20)), 
 cast(key as varchar(20)),
 cast(url as varchar(80)),
 cast(psid as varchar(20))
from
 "LGO2".providers pv
left join
 "LGO2".ptc pl
 ON pv.ci=pl.provider