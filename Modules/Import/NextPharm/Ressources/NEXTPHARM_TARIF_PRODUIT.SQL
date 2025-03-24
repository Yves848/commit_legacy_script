SELECT 
 t.cnk,
 f.code,
2
FROM TarPrixFour t, fournisseurs f
where t.NumFour = f.idfournisseurs
group by t.cnk,f.code,f.type
		
UNION

select 
	s.cnk,
	s.RayFourPref,
	f.type
from stock s, fournisseurs f
where s.RayFourPref = f.code and s.RayFourPref<>''

