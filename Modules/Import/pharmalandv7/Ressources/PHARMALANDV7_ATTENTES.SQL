select 
ffnum,
ffclient,
ffdtord
from ffattente
where ffnum > 0 and ffclient>0 
and ffdjou >=add_months(sysdate,-24) 