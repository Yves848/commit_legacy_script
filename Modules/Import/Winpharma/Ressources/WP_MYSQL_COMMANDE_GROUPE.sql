select
  grp.nocomgros - (grp.nocomgros>>28)* 268435456,
  grp.cip,
  max(grp.qtec),
  sum(grp.qteug),
  sum(sel.qte),
  max(grp.PrixPublic)

from comautr grp 
left join modsel sel on sel.nocomgros = grp.nocomgros and sel.cip = grp.cip

where comaction =0 and qte > 0      
group by  grp.nocomgros,   grp.cip
order by  grp.nocomgros