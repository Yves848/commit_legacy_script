select
  a.arcleunik,
  c.koperiode,
  sum(c.koqtes)
from
  conso c inner join articles a on c.KOArticle = a.artcode 
where kotype = 'V' and ardatedernierevente >=add_months(sysdate,-24) 
group by
  arcleunik,
  c.koperiode
having 
  sum(c.koqtes) > 0