select mem_primkey, -- litige
       mem_pat_primkey,
       1,
       '',
       mem_omschrijving,
       mem_prd_primkey,
       case when len(mem_opmerking)= 16 then 
            mem_opmerking
       else 
            null 
       end CBU       ,
       vrk_nummervoorschrift,
       mem_vvgefactureerd,
       isnull(vdp_tebetalen,0) + isnull(vdm_tebetalen,0),
       mem_aantal,
       0,
       mem_datechanged,
       1
from memopatient
  left join verkoopdetailproduct on vdp_primkey    = mem_vdp_primkey
  left join verkoopdetailmagis   on vdm_primkey    = mem_vdm_primkey
  left join verkoop on vrk_primkey = mem_vrk_primkey
  where mem_type=5