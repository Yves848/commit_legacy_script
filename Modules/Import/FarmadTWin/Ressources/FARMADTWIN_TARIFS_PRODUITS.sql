select 
  p.p_levnum,
  p.p_cnknummer,
  p.p_prijs,
  l.l_type_leverancier,
  p.p_kritieklevnum,
  l2.l_type_leverancier
from 
  ftbproducten p
  left join ftbleveranciers l on l.l_levnummer = p.p_levnum 
  left join ftbleveranciers l2 on l2.l_levnummer = p.p_kritieklevnum 
where 
  p.p_cnknummer is not null and (p.p_levnum <> 0 or (p.p_kritieklevnum <>0 and p.p_kritieklevnum is not null))
