SELECT 
	d.IDPatient,
    d.DateHeureLigne,
	d.Cnk
FROM ventes d
WHERE d.DateHeureLigne >='01/01/2007' and d.LigneSuspendue =0 and d.TypeProduit<>8
AND d.cnk in  ('5520689','5520705','5520721','5520739','5520788','5521059')
order by d.DateHeureLigne 