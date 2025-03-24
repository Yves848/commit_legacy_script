select
lf.codeuv,
lf.annee,
lf.mois,
sum(lf.qte)
from factlign lf
where ( current_date - lf.datevente  ) < 365*3
group by
lf.codeuv,
lf.annee,
lf.mois