select mem_primkey,
       mem_prd_primkey,
       mem_pat_primkey,
       art_primkey,
       vrk_nummervoorschrift,
       vrk_datumaflevering,
       mem_datechanged,
       mem_aantal,
       mem_datum
from memopatient
  left join verkoop on vrk_primkey = mem_vrk_primkey
  left join arts on vrk_art_primkey = art_primkey  
where mem_type=6
