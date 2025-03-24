select 
  s.serialarticle,
  extract(year from datevente),
  extract(month from datevente),
  sum(quantite),
  count(distinct vte.serial)
from 
  vente vte 
  inner join lignevente lv on lv.serialvente=vte.serial  
  inner join stock s on s.serialarticle = lv.serialarticle
where  
  lv.serialarticle <> 0
  and lv.typearticle='1'
  and vte.datevente is not null  
group by
  1, 2, 3
order by 
  1 desc, 2 desc