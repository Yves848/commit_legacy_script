select 
  vi.vi_id,
  vi.vi_cnknummer,
  fm.fm_omschrijving,
  gv.gv_tekst$$ ,
  fmd.fmd_cnkdetail,
  coalesce(des.to_omschr,  des2.pt_omschrijving$$),
  fmd.fmd_hoeveel,    -- qte 
  unit.ee_tekst$$,
  fm.fm_tekst -- formule
from 
  ftbverkoopitems vi
  left join ftbpomschrijving pt on pt.pt_cnknummer = vi.vi_cnknummer 
  left join ftbvoorschriften vo on vo.vo_nummer = vi.vi_vsnummer 
  left join ftbformules fm  on fm.fm_cnknummer  = vi.vi_cnknummer
  left join ftbformdetails fmd on ( fmd.fmd_cnknummer = vi.vi_cnknummer   )
  left join ftbgalvormen gv on gv_id = cast(fmd.fmd_cnkdetail as integer) 
  left join FTBTMBOMSCHRIJVING des on des.to_cnk = fmd.fmd_cnkdetail  and des.to_synkey = coalesce(fmd.fmd_synkey , 'NA0')
  left join FTBPOMSCHRIJVING des2 on des2.pt_cnknummer = fmd.fmd_cnkdetail  and des2.PT_VOLGNUMMER =0
  left join FTBEENHEDEN unit on unit.ee_id = fmd.fmd_eenheid 
where 
  vi.vi_aantal_afgelev > 0 and 
  vo.vo_vsdatum >= dateadd(month , -24, current_date)
and vi.vi_cnknummer like 'M%'