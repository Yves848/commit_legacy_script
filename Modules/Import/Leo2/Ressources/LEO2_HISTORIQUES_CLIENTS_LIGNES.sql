SELECT 
pst.Pst_Id
,pel.Bes_IdTarifie
,pel.Pel_CodeBienEtService
,pel.Pel_Libelle
,pel.Pel_Quantite
,pel.Pel_PrixAchatPMP
,pel.Pel_PrixPublic
,pel.Pel_PrixVentHT
FROM dbo.Prestation AS pst 
INNER JOIN dbo.PrestationElementaire AS Pel ON Pst.Pst_Id = Pel.Pst_Id       
LEFT OUTER JOIN dbo.Avance AS Avn ON Pel.Pel_Id = Avn.Pel_Id
where 	Pst.Pph_IdPatient IS NOT NULL 
		AND Pst.Etp_Id = 3 
		AND Pst.Pst_IsAnnule = 0		 
		AND (Avn.Avn_QteAvanceRestante IS NULL OR Avn.Avn_QteAvanceRestante > 0)
		AND pel.Pel_Quantite is not null
and pst.Pst_DateDelivrance >= concat(year(getdate()) - 2, '-01-01')