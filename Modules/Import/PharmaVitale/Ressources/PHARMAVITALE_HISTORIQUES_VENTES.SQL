select
  h.code_uv,
  year(h.DateFacture),
  month(h.DateFacture),
  iif( s.compparboite > 1 and p.liste in ('S','1'), sum(h.qte)/s.compparboite , sum(h.qte)) STOCK_STUP
from dbo.statprod h
inner join dbo.produit p on (p.code_uv = h.code_uv)
inner join dbo.stock s on (s.code_uv = h.code_uv)
where h.DateFacture > dateadd(year , -3 , getdate() ) and type_ligne in ('SC', 'SN')
group by h.code_uv,
     year(h.DateFacture),
     month(h.DateFacture),
     p.liste,
     s.compparboite,
     h.type_ligne
having sum(h.qte) > 0
