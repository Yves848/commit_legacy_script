select atc.*
from 
  (select paa.pph_id, '0' cmu, hor.pmo_id, cdr.gco_id, coalesce(ags.atc_numeroadherentunique, ags.atc_identifiantassure) atc_numeroadherentunique, atc.atc_datedebut, atc.atc_datefin
   from leonew.dbo.pph_asso_atc paa
     inner join dbo.AttestationComplementaire atc on atc.Atc_Id = paa.Atc_Id
     inner join dbo.AttestationGestionSeparee ags on ags.Atc_Id = paa.Atc_Id
     inner join dbo.HistoOrganisme hor on hor.hor_id = ags.hor_id
     inner join dbo.ContratDeRemboursement cdr on cdr.cdr_id = ags.cdr_id  
   union
   select paa.pph_id, '0', hor.pmo_id, cdr.gco_id, null, atc.atc_datedebut, atc.atc_datefin
   from leonew.dbo.pph_asso_atc paa
     inner join dbo.AttestationComplementaire atc on atc.Atc_Id = paa.Atc_Id
     inner join dbo.AttestationGestionUnique agu on agu.Atc_Id = paa.Atc_Id
     inner join dbo.HistoOrganisme hor on hor.hor_id = agu.hor_id
     inner join dbo.ContratDeRemboursement cdr on cdr.cdr_id = agu.cdr_id
   union
   select paa.pph_id, '1', null, null, null, atc.atc_datedebut, atc.atc_datefin
   from leonew.dbo.pph_asso_atc paa
     inner join dbo.AttestationComplementaire atc on atc.Atc_Id = paa.Atc_Id
     inner join leonew.dbo.AttestationCMU acmu on acmu.Atc_Id = paa.Atc_Id) atc
  inner join dbo.Personne prs on prs.prs_id = atc.pph_id
where
  (atc.atc_datefin >= concat(year(getdate()) - 3, '-01-01') or atc.atc_datefin is null) and
  prs.Prs_DateDernierePrestation is not null
order by atc_datefin