WITH
	InfoLignes as 
	(SELECT
		lp.Pro_Id as IdPromis,
		lp.Bes_Id as idProduit,
		lp.Lps_QtePromiseRestante as QtePromiseRestante,
		lp.Lps_QteADelivre as QteADelivre,
		lp.Bes_Id as NbProduit
	FROM
		LignePromis as lp With(nolock,nowait)
	)
	
	SELECT
		COALESCE(pmo.Pmo_Id, pph.Pph_Id) as IdClient,	
		cast(pro.Pro_DateCreation as datetime) as DateCreation,
		il.idProduit,
		il.QtePromiseRestante as QtePromiseRestante
	FROM
		TicketPromis as pro With(nolock,nowait)
		INNER JOIN InfoLignes as il With(nolock,nowait) on il.IdPromis = pro.Pro_Id
		LEFT JOIN PersonnePhysique as pph With(nolock,nowait) on pph.Pph_Id = pro.Prs_Id
		LEFT JOIN PersonneMorale as pmo With(nolock,nowait) on pmo.Pmo_Id = pro.Prs_Id

		where QtePromiseRestante > 0