select 
  s.index_stat,
  s.index_assure,
  s.NoFacture,
  s.DateFacture,
  o.code_ope,
  s.index_medecin,  
  iif(p.cip13 > '',p.cip13, p.cip),
  p.code_uv,
  s.nom_prod,
  s.Qte,
  s.total_ttc / s.Qte prix_ttc
from 
  dbo.statprod s
  inner join dbo.produit p on (p.code_uv = s.code_uv)
  inner join dbo.operateur o on (o.num_ope = s.num_ope)
where datediff(year, s.DateFacture, GETDATE()) < 4
  and s.index_assure <> 0 and  s.Qte > 0 
  and p.code_acte not like 'H%'
