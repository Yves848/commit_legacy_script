select
lfnum,
lfcip,
lfcodeacte,
lfqte,
lfvente,
lfpxachat
from lfattente
where lfdjou >=add_months(sysdate,-24) 
