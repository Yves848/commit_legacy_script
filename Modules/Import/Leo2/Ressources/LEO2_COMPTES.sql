select 
  pmo.pmo_Id
  ,pmo.Pmo_RaisonSociale
  ,cp.Cop_LigneAdresse
  ,cp.Cop_CodePostal
  ,cp.Cop_Ville
  ,(select tel.Tel_Numero from Prs_Asso_Tel pat 
          left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
          left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id
                    where pat.Prs_Id = prs.Prs_Id and Ttl_Interne = 'Fixe')
  ,(select tel.Tel_Numero from Prs_Asso_Tel pat 
          left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
          left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id
          where pat.Prs_Id = prs.Prs_Id and Ttl_Interne = 'Mobile')
   ,(select tel.Tel_Numero from Prs_Asso_Tel pat 
          left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
          left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id
          where pat.Prs_Id = prs.Prs_Id and Ttl_Interne = 'Fax')
  ,(select tel.Tel_Numero from Prs_Asso_Tel pat 
          left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
          left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id
          where pat.Prs_Id = prs.Prs_Id and Ttl_Interne = 'Fax')
from 
  dbo.PersonneMorale pmo
  inner join dbo.Personne prs on prs.Prs_Id = pmo.pmo_Id
  left join dbo.Prs_Asso_Cop pac on pac.Prs_Id = prs.Prs_Id
  left join dbo.CoordonneePostale cp on cp.Cop_Id = pac.Cop_Id   -- AND c.Tco_Id = 1
  left join dbo.TypeCoordonnee tco on tco.Tco_Id = cp.Tco_Id  
where 
  ( pmo.pmo_id in (select pmo_id from dbo.ClientPro) 
  or pmo.pmo_id in (select pmo_id from dbo.Officine)
  or pmo.pmo_id in (select pmo_id from dbo.OrganismeRattachement) )
