select gco_id, cpt_id, fdr_taux, tfc_libellecourt
from leonew.dbo.ExceptionComplementaire exc
  inner join leonew.dbo.FormuleDeRemboursement fdr on fdr.fdr_id = exc.Fdr_Id
  inner join leonew.dbo.TypeFormuleDeCalcul tfc on tfc.tfc_id = fdr.Tfc_Id 