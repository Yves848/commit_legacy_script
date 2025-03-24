;with XMLNAMESPACES(DEFAULT 'schemas.microsoft.com/winfx/2006/xaml/presentation'),
  tel as (select pat.Prs_Id, ttl.Ttl_Interne, tel.Tel_Numero
      from Prs_Asso_Tel pat
        left join dbo.Telephone tel on tel.Tel_Id = pat.Tel_Id
        left join dbo.TypeTelephone ttl on ttl.Ttl_Id = tel.Ttl_Id),
  tel_f as (select * from tel where Ttl_Interne = 'Fixe'),
  tel_m as (select * from tel where Ttl_Interne = 'Mobile'),
  tel_fx as (select * from tel where Ttl_Interne = 'Fax')
select 
  pph.Pph_Id,
  pph.Pph_Nom, 
  pph.Pph_NomDeNaissance, 
  pph.Pph_Prenom, 
  pph.Pph_DateDeNaissance,
  pph.Pph_NumeroSecu, 
  pph.Pph_RangGemellaire, 
  cp.Cop_LigneAdresse, 
  cp.Cop_CodePostal, 
  cp.Cop_Ville, 
  tel_f.Tel_Numero, 
  tel_m.Tel_Numero, 
  tel_fx.Tel_Numero,
  try_convert(xml, prs.Prs_Commentaire).value('.' , 'varchar(max)'),
  --cast( prs.Prs_Commentaire as xml ).value('.' , 'varchar(max)' ) as commentaire, 
  convert(datetime, prs.Prs_DateDernierePrestation,120), 
  pph.Qbe_Id
from 
  dbo.PersonnePhysique pph
  inner join dbo.Personne prs on prs.Prs_Id = pph.Pph_Id
  left join dbo.Prs_Asso_Cop pac on pac.Prs_Id = prs.Prs_Id
    left join dbo.CoordonneePostale cp on cp.Cop_Id = pac.Cop_Id
    left join dbo.TypeCoordonnee tco on tco.Tco_Id = cp.Tco_Id and tco.Tco_Interne = 'Défaut' 
    --cela génére des doublons si 2 TypeCoordonnee mais si on met un inner on perd carrément les lignes 
  left join tel_f on tel_f.Prs_Id = prs.Prs_Id
  left join tel_m on tel_m.Prs_Id = prs.Prs_Id
  left join tel_fx on tel_fx.Prs_Id = prs.Prs_Id
where 
 prs.Prs_DateDernierePrestation is not null

