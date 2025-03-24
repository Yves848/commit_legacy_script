select 
  kr.kr_verkoopitem,
  kr.kr_cnknummer,
  kr.kr_klantnummer,
  vo.vo_artsnummer,
  kr.kr_voorschriftnr,
  kr.kr_aantal,
  kr.kr_datum,
  vo.vo_datum,
  vo.vo_vsdatum
from 
  ftbkredieten kr 
  inner join ftbklanten k on k.k_klantnummer = kr.kr_klantnummer
  left join ftbvoorschriften vo on vo.vo_nummer = kr.kr_voorschriftid  
where 
  (kr.kr_is_uitgesteld = 'Y' or kr.kr_is_memo = 'Y') and 
  vo.vo_vsdatum >= dateadd(month , -24, current_date)
  