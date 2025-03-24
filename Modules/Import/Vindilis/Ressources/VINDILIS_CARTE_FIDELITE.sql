select cm.serialclientpara idpara,
       ben.serial idben, 
       cast(substring(cm.numerocarte,1,12) as varchar(12)) 
from clientmap cm
left join clientpara cp on  cp.serial = cm.serialclientpara
left join client cli on cli.serial = cp.serialclient
left join assure ass on ass.serialclient = cp.serialclient
left join beneficiaire ben on ben.serialassure = ass.serial
where actif ='O'   and (qualite = 0 or qualite is null)
order by numerocarte