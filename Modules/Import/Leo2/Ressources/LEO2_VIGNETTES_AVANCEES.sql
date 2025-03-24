SELECT
 avn.Prs_Id AS IdPersonne,
 avn.Bes_Id as IdProduit,
 cast(pst.Pst_DateDelivrance as datetime) AS DateDelivrance,
 pel.Pel_CodeBienEtService as pel_codecip,
 bes.Bes_LibelleLibre AS libelleproduit,
 coalesce(pel.Pel_PrixAchatPMP,0) as Pel_PrixAchat,
 pel.Pel_PrixPublic as Pel_PrixPublic,
 coalesce(bes2.cpt_id, 'PHN') as CodePrestation,
 coalesce(bes2.Bes_BaseDeRemboursement,0) as base_remboursement,
 avn.Avn_QteAvanceRestante AS QteAvance
FROM dbo.Avance AS avn 
INNER JOIN dbo.BiensEtServices AS bes ON avn.Bes_Id = bes.Bes_Id 
inner join dbo.BienEtService bes2 on bes2.Bes_Id = bes.Bes_Id
LEFT OUTER JOIN dbo.BesDonneeAdministrative AS bda ON bes.Bes_Id = bda.Bes_Id 
LEFT OUTER JOIN dbo.BesDonneeLogistique AS bdl ON bes.Bes_Id = bdl.Bes_Id 
INNER JOIN dbo.PrestationElementaire AS pel ON avn.Pel_Id = pel.Pel_Id 
INNER JOIN dbo.Prestation AS pst ON pel.Pst_Id = pst.Pst_Id
WHERE (avn.Avn_QteAvanceRestante > 0)
and pst.Pst_IsAnnule = 0