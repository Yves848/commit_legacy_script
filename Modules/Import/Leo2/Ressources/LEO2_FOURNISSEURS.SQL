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
  fou.Pmo_Id,
  fou.Fou_CodeFournisseur,
  pmo.Pmo_RaisonSociale,  
  adr.Cop_LigneAdresse,
  adr.Cop_CodePostal,
  adr.Cop_Ville,
  tel_f.Tel_Numero Fixe,
  tel_m.Tel_Numero Mobile,
  tel_fx.Tel_Numero Fax,
  pml.Ptc_LoginOfficine,
  pml.Ptc_LoginRepartiteur,
  pml.Ptc_UrlPrimaire,
  pml.Ptc_UrlSecondaire,
  pml.Ptc_ClefSecrete,
  soc.Soc_Code
from 
  dbo.Fournisseur fou
  left join dbo.PersonneMorale pmo on pmo.Pmo_Id = fou.Pmo_Id  
  left join dbo.Personne prs on prs.Prs_Id = pmo.Pmo_Id
  left join adr on adr.Prs_Id = prs.Prs_Id  
  left join tel_f on tel_f.Prs_Id = prs.Prs_Id
  left join tel_m on tel_m.Prs_Id = prs.Prs_Id
  left join tel_fx on tel_fx.Prs_Id = prs.Prs_Id
  left join dbo.ProtoTransCommande ptc on ptc.Pmo_Id = fou.Pmo_Id
  left join dbo.ProtoTransCommandePharmaML pml on pml.Ptc_Id = ptc.Ptc_Id
  left join dbo.SocieteCsrp soc on soc.Soc_Id = pml.Soc_Id
  left join dbo.LibellePharmaML lph on lph.Lph_Id = soc.Lph_IdCle
where (ptc.Ptc_IsDefaut = 1 or ptc.Ptc_IsDefaut is null) 
  and (ptc.Ptc_IsActif = 1 or ptc.Ptc_IsActif is null)
order by fou.Pmo_Id