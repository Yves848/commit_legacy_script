select 
  l.l_type_leverancier,
  lt.lt_levnummer,
  lt.lt_srt_telnummer || ':' || trim(lt.lt_telefoonnummer)
from   
  ftblevtelnummers lt 
  left join ftbleveranciers l on (l.l_levnummer = lt.lt_levnummer)
where 
  l.l_leverancier is not null and 
  l.l_type_leverancier in (2, 6)
order by 
  l.l_levnummer