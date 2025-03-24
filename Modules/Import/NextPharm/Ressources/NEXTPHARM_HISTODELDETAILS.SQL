SELECT 
	d.IDVente
	,d.NumTicket
	,d.IDPatient
	,d.IDClient
	,d.NumOrdo	
	,d.TypeVente
	,d.Cnk
	,d.Libellé
	,d.Qt
	,d.Tmtot
FROM ventes d
WHERE d.DateHeureLigne >=add_months(sysdate,-24) and d.LigneSuspendue =0 and d.TypeProduit<>8