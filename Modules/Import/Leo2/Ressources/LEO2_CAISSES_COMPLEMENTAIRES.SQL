;with
  adr as (select pac.Prs_Id, cp.Cop_LigneAdresse, cp.Cop_CodePostal, cp.Cop_Ville
              from dbo.Prs_Asso_Cop pac
                inner join dbo.CoordonneePostale cp on cp.Cop_Id = pac.Cop_Id
                inner join dbo.TypeCoordonnee tco on tco.Tco_Id = cp.Tco_Id
             where tco.Tco_Interne = 'Défaut'),
  tel as (select pat.Prs_Id, ttl.Ttl_Interne, tel.Tel_Numero
		  from Prs_Asso_Tel pat
		    left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
		    left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id),
  tel_f as (select * from tel where Ttl_Interne = 'Fixe'),
  tel_m as (select * from tel where Ttl_Interne = 'Mobile'),
  tel_fx as (select * from tel where Ttl_Interne = 'Fax')
select 
  cpl.Pmo_Id, pmo.Pmo_RaisonSociale, cpl.Cco_CodePrefectoral, cpl.Cco_NumeroAMC, rco.Rco_CodePrefectoral,
  adr.Cop_LigneAdresse, adr.Cop_CodePostal, adr.Cop_Ville,
  tel_f.Tel_Numero Fixe, tel_m.Tel_Numero Mobile, tel_fx.Tel_Numero Fax,
  cpl.Ctr_Id
from dbo.CaisseComplementaire cpl 
  inner join dbo.PersonneMorale pmo on pmo.Pmo_Id = cpl.Pmo_Id
  inner join dbo.Personne prs on prs.Prs_Id = pmo.Pmo_Id
  left join dbo.ReseauComplementaire rco on rco.Rco_Id = cpl.Rco_Id
  left join adr on adr.Prs_Id = prs.Prs_Id  
  left join tel_f on tel_f.Prs_Id = prs.Prs_Id
  left join tel_m on tel_m.Prs_Id = prs.Prs_Id
  left join tel_fx on tel_fx.Prs_Id = prs.Prs_Id