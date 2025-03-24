select atp.*
from 
  (select ap.pph_id, 1 tap_id, hor.pmo_id, hor.hor_centre, '0' ald, atp_codesituation, am.atp_datedebut, am.atp_datefin
   from dbo.AttestationPrimaire ap
     inner join dbo.AttestationMaladie am on am.atp_id = ap.atp_id
     inner join dbo.HistoOrganisme hor on hor.hor_id = am.hor_id
   union
   select ap.pph_id, 2, null, null, '1', null, aald.atp_datedebut, aald.atp_datefin
   from dbo.AttestationPrimaire ap
     inner join dbo.AttestationAld aald on aald.atp_id = ap.atp_id
   union
   select ap.pph_id, 5, null, null, '0', null, amat.atp_datedebutgrossesse, amat.atp_dateaccouchementreel
   from dbo.AttestationPrimaire ap
     inner join dbo.AttestationMaternite amat on amat.atp_id = ap.atp_id
   union
   select acv.pph_id, 0 tap_id, hor.pmo_id, hor.hor_centre, pdc.pdc_codeald, pdc.pdc_codesituation, pdc.pdc_datedebut, pdc.pdc_datefin
   from dbo.AttestationCarteVitale acv
     inner join dbo.PeriodeDeCouverture pdc on pdc.acv_id = acv.acv_id
     inner join dbo.HistoOrganisme hor on hor.hor_id = acv.hor_id) as atp
  inner join dbo.Personne prs on prs.prs_id = atp.pph_id
where
  (atp.atp_datefin >= concat(year(getdate()) - 3, '-01-01') or atp.atp_datefin is null) and
  prs.Prs_DateDernierePrestation is not null  
order by 1, 2;