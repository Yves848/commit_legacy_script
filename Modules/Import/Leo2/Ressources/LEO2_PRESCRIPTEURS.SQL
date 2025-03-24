-- prescripteurs
;with
  adr as (select pac.Prs_Id, cp.Cop_LigneAdresse, cp.Cop_CodePostal, cp.Cop_Ville
              from dbo.Prs_Asso_Cop pac
                inner join dbo.CoordonneePostale cp on cp.Cop_Id = pac.Cop_Id
                inner join dbo.TypeCoordonnee tco on tco.Tco_Id = cp.Tco_Id
             where tco.Tco_Interne = 'Défaut'),
  adr2 as (select sps.pph_id, cp.Cop_LigneAdresse, cp.Cop_CodePostal, cp.Cop_Ville
              from dbo.Sps_Asso_Cop sac
               inner join dbo.CoordonneePostale cp on cp.Cop_Id = sac.Cop_Id
               inner join dbo.TypeCoordonnee tco on tco.Tco_Id = cp.Tco_Id
               inner join dbo.situationPS sps on sps.sps_id = sac.sps_id
             where tco.Tco_Interne = 'Défaut'),
  tel as (select pat.Prs_Id, ttl.Ttl_Interne, tel.Tel_Numero
      from Prs_Asso_Tel pat
        left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
        left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id),
  tel_f as (select * from tel where Ttl_Interne = 'Fixe'),
  tel_m as (select * from tel where Ttl_Interne = 'Mobile'),
  tel_fx as (select * from tel where Ttl_Interne = 'Fax')
SELECT 
  pds.Pph_Id, 
  pph.Pph_Nom,
  pph.Pph_Prenom,
  coalesce(adr.Cop_LigneAdresse,adr2.Cop_LigneAdresse),
  coalesce(adr.Cop_CodePostal, adr2.Cop_CodePostal),
  coalesce(adr.Cop_Ville, adr2.Cop_Ville),
  tel_f.Tel_Numero Fixe,
  tel_m.Tel_Numero Mobile,
  tel_fx.Tel_Numero Fax,
  sps.Pmo_Id,
  iif(se.set_id != null, sps.Sps_IsAgreeSncf, se.Set_IsAgreeSncf),
  -- bidon sps.Sps_IsPrescrHospAuto,
  sps.mex_id,   -- 00 = liberal 01 = hospitalier
  coalesce(ets.Ets_NumeroFiness,pds.Pds_NumeroAdeli), 
  pds.Pds_NumeroRpps,
  coalesce(sps.Csp_Id ,'01') CodeSpecialite
FROM dbo.ProfessionnelDeSante pds
  inner join dbo.PersonnePhysique pph on pph.Pph_Id = pds.Pph_Id
  inner join dbo.SituationPs sps on sps.Pph_Id = pph.Pph_Id
  inner join dbo.Personne prs on prs.Prs_Id = pph.Pph_Id
  left join adr on adr.Prs_Id = prs.Prs_Id  
  left join adr2 on adr2.Pph_Id = prs.Prs_Id  
  left join tel_f on tel_f.Prs_Id = prs.Prs_Id
  left join tel_m on tel_m.Prs_Id = prs.Prs_Id
  left join tel_fx on tel_fx.Prs_Id = prs.Prs_Id
  left join dbo.ServiceEtablissement se on se.Set_Id = sps.Set_Id  
  left join dbo.EtablissementDeSante ets on ets.pmo_id = sps.pmo_id