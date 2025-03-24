select 
  vi.vi_id, 
  vi.vi_datum, 
  vo.vo_klantnummer,
  a.a_voornaam, 
  a.a_naam, 
  vo.vo_vsdatum, 
  vo.vo_vsnummer 
from ftbverkoopitems vi
  left join ftbvoorschriften vo on vo.vo_nummer = vi.vi_vsnummer
  left join ftbartsen a on a.a_artsnummer = vo.vo_artsnummer
  left join ftbklanten on k_klantnummer=vo_klantnummer
where 
  (k_is_dummy = 'N' or k_is_dummy is null)
  and vo_vsdatum >= dateadd(month , -24, current_date)