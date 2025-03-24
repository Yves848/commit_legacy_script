SELECT        
 IdPayeur
 ,SUM(ResteDu) AS ResteDu
 ,cast(max(date_credit) as datetime)
 FROM (SELECT 	crd.Crd_Id AS IdCredit
				,crd.Prs_IdPayeur AS IdPayeur
				,crd.Crd_Montant - ISNULL(SUM(vrg.Vrg_Montant), 0) AS ResteDu
				,cast(max(crd.crd_date) as datetime) as date_credit
		FROM dbo.Credit AS crd 
		LEFT OUTER JOIN dbo.VentilationReglement AS vrg ON vrg.Crd_Id = crd.Crd_Id 
		LEFT OUTER JOIN (SELECT lrg.Lrg_Id AS IdLigneReglement 
						FROM dbo.VentilationReglement AS vrg 
						INNER JOIN dbo.LigneReglement AS lrg ON vrg.Lrg_Id = lrg.Lrg_Id AND lrg.Mre_Id = 4 
						INNER JOIN dbo.PartFacture AS pfa ON vrg.Pfa_Id = pfa.Pfa_Id 
						INNER JOIN dbo.Rlv_Asso_Fac AS raf ON raf.Fac_Id = pfa.Fac_Id
                        GROUP BY lrg.Lrg_Id
                        HAVING (COUNT(vrg.Vrg_Id) = 1)) AS rlv 
		ON rlv.IdLigneReglement = crd.Lrg_Id
        GROUP BY crd.Crd_Id, crd.Prs_IdPayeur, crd.Crd_Montant, rlv.IdLigneReglement, crd.crd_date
        HAVING (crd.Crd_Montant - ISNULL(SUM(vrg.Vrg_Montant), 0) > 0)) AS crd
GROUP BY IdPayeur

UNION 

SELECT 
	ISNULL(avo.IdPayeur, 1) as IdPayeur,
	SUM(avo.ResteDu) as ResteDu,
	cast(max(date_avoir) as datetime)
FROM
	(SELECT
		avo.Avo_Id as IdAvoir,
		avo.Prs_IdPayeur as IdPayeur,
		avo.Avo_Montant + ISNULL(SUM(VR.Vrg_Montant), 0) as ResteDu,
		avo.Avo_Date as date_avoir
	FROM
		Avoir as avo
		LEFT JOIN (SELECT
					vre.Avo_Id,
					(CASE WHEN LRE.Mre_Id = 7 THEN vre.Vrg_Montant ELSE -vre.Vrg_Montant END) as Vrg_Montant
				FROM
					 VentilationReglement as vre with(nolock, nowait)
					 INNER JOIN LigneReglement as LRE with(nolock, nowait) on vre.Lrg_Id = lre.Lrg_Id
				WHERE
					vre.Avo_Id IS NOT NULL) as VR ON avo.Avo_Id = VR.Avo_Id
		LEFT JOIN (
			SELECT
				lrg.Lrg_Id as IdLigneReglement
			FROM
				VentilationReglement as vrg
				INNER JOIN LigneReglement as lrg on vrg.Lrg_Id = lrg.Lrg_Id AND lrg.Mre_Id = 6
				INNER JOIN PartFacture as pfa on vrg.Pfa_Id = pfa.Pfa_Id
				INNER JOIN Rlv_Asso_Fac as raf on raf.Fac_Id = pfa.Fac_Id
			GROUP BY
				lrg.Lrg_Id
			HAVING
				COUNT(vrg.Vrg_Id) = 1) as rlv on rlv.IdLigneReglement = avo.Lrg_Id
	GROUP BY
		avo.Avo_Id,
		avo.Prs_IdPayeur,
		avo.Avo_Montant,
		rlv.IdLigneReglement,
		avo.Avo_Date
	HAVING 
		avo.Avo_Montant + ISNULL(SUM(VR.Vrg_Montant), 0) != 0) as avo
GROUP BY
	avo.IdPayeur
