SELECT 
  extract(year from vi_datum),
  extract(month from vi_datum), 
  vi_cnknummer,
  sum(vi_aantal_afgelev)
from 
  ftbverkoopitems 
where 
  vi_datum >=  dateadd (month, -24, current_date )
group by 
  extract(year from vi_datum),
  extract(month from vi_datum), 
  vi_cnknummer
having
  sum(vi_aantal_afgelev) > 0