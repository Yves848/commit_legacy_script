select 
lcddate,
lcdchrono,
lcdnocip,
lcdqtecomm,
lcdnbug,
lcdqterecue,
lcdpxachcat,
lcdpxachrem,
lcdpxpublic,
lcddaterec 
from af32 lig
left join af31 ent on ( ent.cddate = lig.lcddate and ent.cdchrono = lig.lcdchrono )
where lcddate > current_date - (365*2)  
and cdetat in ('C', 'A' , 'N', 'T')