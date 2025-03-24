select 
cddate,
cddatelivr,
cdetat,
cdchrono,
cdlabo, 
cdachcat,
cdachrem,
cdnblignes,
cdboites
from af31
where cddate > current_date - (365*2)
and cdetat in ('C', 'A' , 'N', 'T')