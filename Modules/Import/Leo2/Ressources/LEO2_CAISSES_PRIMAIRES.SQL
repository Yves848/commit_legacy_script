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
   cge.Pmo_Id, 
  pmo.Pmo_RaisonSociale+' '+cge.Cge_Code, 
  reg.Rgi_Id, 
  cpr.Cpr_Code, 
  cge.Cge_Code, 
  cast(cpr.Cpr_IsCirconscription as integer),
  adr.Cop_LigneAdresse, 
  adr.Cop_CodePostal, 
  adr.Cop_Ville,
  tel_f.Tel_Numero Fixe, 
  tel_m.Tel_Numero Mobile, 
  tel_fx.Tel_Numero Fax,
  cpr.Ctr_Id
from dbo.CaissePrimaire  cpr
  inner join dbo.PersonneMorale pmo on pmo.pmo_id = cpr.Pmo_Id
  inner join dbo.CentreGestionnaire cge on  pmo.Pmo_Id = cge.Pmo_IdCaissePrimaire
  inner join dbo.Personne prs on prs.Prs_Id = pmo.Pmo_Id
  inner join dbo.Regime reg on  reg.Rgi_Id = cpr.Rgi_Id
  left join adr on adr.Prs_Id = prs.Prs_Id  
  left join tel_f on tel_f.Prs_Id = prs.Prs_Id
  left join tel_m on tel_m.Prs_Id = prs.Prs_Id
  left join tel_fx on tel_fx.Prs_Id = prs.Prs_Id
