;with 
couv as ( select hor.pmo_id, cdr.gco_id
   from leonew.dbo.pph_asso_atc paa
     inner join dbo.AttestationComplementaire atc on atc.Atc_Id = paa.Atc_Id
     inner join dbo.AttestationGestionSeparee ags on ags.Atc_Id = paa.Atc_Id
     inner join dbo.HistoOrganisme hor on hor.hor_id = ags.hor_id
     inner join dbo.ContratDeRemboursement cdr on cdr.cdr_id = ags.cdr_id  
union
   select hor.pmo_id, cdr.gco_id
   from leonew.dbo.pph_asso_atc paa
     inner join dbo.AttestationComplementaire atc on atc.Atc_Id = paa.Atc_Id
     inner join dbo.AttestationGestionUnique agu on agu.Atc_Id = paa.Atc_Id
     inner join dbo.HistoOrganisme hor on hor.hor_id = agu.hor_id
     inner join dbo.ContratDeRemboursement cdr on cdr.cdr_id = agu.cdr_id   )

select 
 couv.pmo_id, 
 couv.gco_id,
 gco.Gco_Libelle, 
 fdr.fdr_taux,
 tfc.Tfc_LibelleCourt
from couv

  inner join leonew.dbo.garantiecomplementaire gco on gco.gco_id = couv.gco_id  
  inner join leonew.dbo.FormuleDeRemboursement fdr on fdr.fdr_id = gco.Fdr_Id
  inner join leonew.dbo.TypeFormuleDeCalcul tfc on tfc.Tfc_Id = fdr.Tfc_Id