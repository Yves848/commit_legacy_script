select 
  vi.vi_id,
  vi.vi_cnknummer,
  coalesce(pt.pt_omschrijvingfr, fm.fm_omschrijving, gv.gv_tekst$$),
  vi.vi_aantal_afgelev,
--  vi.vi_publieksprijs, Prix public
  vi.vi_remgeld -- prix payé
from 
  ftbverkoopitems vi
  left join ftbpomschrijving pt on pt.pt_cnknummer = vi.vi_cnknummer 
  left join ftbvoorschriften vo on vo.vo_nummer = vi.vi_vsnummer 
  left join ftbformules fm  on fm.fm_cnknummer  = vi.vi_cnknummer
  left join ftbformdetails fmd on ( fmd.fmd_cnknummer = vi.vi_cnknummer  and fmd.fmd_seq = 0  )
  left join ftbgalvormen gv on gv_id = cast(fmd.fmd_cnkdetail as integer)
where 
  vi.vi_aantal_afgelev > 0 and 
  vo.vo_vsdatum >= dateadd(month , -24, current_date)
