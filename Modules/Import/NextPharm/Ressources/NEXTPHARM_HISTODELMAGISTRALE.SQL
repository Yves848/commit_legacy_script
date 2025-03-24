SELECT 
	d.IDVente
	,d.NumTicket
	,d.IDPatient
	,d.IDClient
	,d.NumOrdo	
	,d.TypeVente
	,d.Libellé
	,d.Qt
	,m.FormeGal
	,m.QtPréparée
	,dm.Cnk
	,dm.Libellé
	,dm.Compl
	,dm.QtPrescrite
	,dm.UnitéQtPrescrite
	,dm.QtATarifié
	,dm.QtAPeser
FROM Ventes d
INNER JOIN EnteteMag m on m.IDEnteteMag=d.IDEnteteMag
inner join DetailMag dm on m.IDEnteteMag= dm.IDEnteteMag
WHERE d.DateHeureLigne >=add_months(sysdate,-24) and d.LigneSuspendue =0 and d.TypeProduit=3