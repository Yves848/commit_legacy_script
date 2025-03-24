SELECT pst.Pst_Id,
	   prs.Prs_Id,
	   nfs.NumeroFs,
	   ordo.Ord_DatePrescription,
	   cast(pst.Pst_DateDelivrance as datetime) AS DateDelivrance,
	   uti.uti_identifiant,
	   CASE sps.Mex_Id WHEN '01' THEN CASE WHEN sps.Pph_Id IS NULL THEN pm.Pmo_RaisonSociale ELSE pp.Pph_Nom END ELSE pp.Pph_Nom END AS Nom,
	   pp.Pph_Prenom AS Prenom
FROM dbo.Prestation AS pst 
INNER JOIN dbo.Personne AS prs ON prs.Prs_Id = pst.Pph_IdPatient 
INNER JOIN dbo.HistoPersonne AS hps ON hps.Prs_Id = prs.Prs_Id AND hps.Hps_IsDefaut = 1 
LEFT OUTER JOIN dbo.PersonnePhysique AS pph ON pph.Pph_Id = prs.Prs_Id 
LEFT OUTER JOIN dbo.Ordonnance ordo on pst.Pst_Id=ordo.Pst_Id
LEFT OUTER JOIN dbo.Utilisateur uti on uti.Pph_id = pst.Pph_IdUtilisateur 
LEFT OUTER JOIN dbo.SituationPs AS sps  on sps.Sps_id=Ordo.Sps_Id   and  sps.Mex_Id <> '04'
LEFT OUTER JOIN dbo.ServiceEtablissement AS se ON se.Set_Id = sps.Set_Id 
LEFT OUTER JOIN dbo.EtablissementDeSante AS esalarie ON esalarie.Pmo_Id = se.Pmo_Id 
LEFT OUTER JOIN dbo.PersonneMorale AS pm ON pm.Pmo_Id = esalarie.Pmo_Id 
LEFT OUTER JOIN dbo.ProfessionnelDeSante AS p ON p.Pph_Id = sps.Pph_Id 
LEFT OUTER JOIN dbo.PersonnePhysique AS pp ON pp.Pph_Id = p.Pph_Id 
LEFT OUTER JOIN (SELECT pst.Pst_Id AS IdPrestation, 
	                    fso.Fso_Id AS IdFeuilleDeSoin, 
	                    fso.Fso_NumeroFs AS NumeroFs, 
	                    fac.IdFacture as Facture
                 FROM dbo.Prestation AS pst 
				 INNER JOIN (SELECT fap.Pst_Id AS IdPrestation, 
				             MAX(fac.Fac_Id) AS IdFacture
							FROM dbo.Fac_Asso_Pst AS fap 
							INNER JOIN dbo.Facture AS fac ON fap.Fac_Id = fac.Fac_Id
							WHERE (fac.Fac_IdAvoir IS NULL)
							GROUP BY fap.Pst_Id) 
							AS fac ON fac.IdPrestation = pst.Pst_Id 
				INNER JOIN dbo.FeuilleDeSoin AS fso ON fso.Fac_Id = fac.IdFacture) 
				AS Nfs ON Nfs.IdPrestation = Pst.Pst_Id

where 	Pst.Pph_IdPatient IS NOT NULL 
		AND Pst.Etp_Id = 3 
		AND Pst.Pst_IsAnnule = 0
and pst.Pst_DateDelivrance >= concat(year(getdate()) - 2, '-01-01')