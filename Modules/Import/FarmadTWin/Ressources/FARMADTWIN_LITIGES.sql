Select 
  kr.kr_klantnummer, 
  kr.kr_cnknummer,
  om.pt_omschrijvingfr,
  kr.kr_aantal,
  v.vi_aantal_aftelev,
  kr.kr_betaald, 
  kr.kr_datum,
  v.vi_unieke_bc,
  kr.kr_voorschriftnr
from ftbkredieten  kr
  inner join ftbpomschrijving om on om.pt_cnknummer = kr.kr_cnknummer 
  inner join ftbverkoopitems v on v.vi_id = kr.kr_verkoopitem and v.vi_cnknummer=kr.kr_cnknummer
where kr.kr_is_ovs='Y' or kr.kr_is_opleg='Y'

/*select 
  vo.vo_klantnummer, 
  vi.vi_cnknummer,
  pt_1.pt_omschrijvingfr,
  vi.vi_aantal_afgelev,
  vi.vi_tebetalen, 
  vo.vo_datum,
  vi.vi_unieke_bc
from 
  ftbvoorschriften vo
  --inner join ftbartsen a on a.a_artsnummer = vo.vo_artsnummer 
  inner join ftbklanten k on k.k_klantnummer = vo.vo_klantnummer 
  --inner join ftbklantsis ksis on ksis.ks_id = vo.vo_siskaart 
  --inner join ftbvsstatus vs on vs.vs_statusid = vo.vo_status 
  inner join ftbverkoopitems vi on vi.vi_vsnummer = vo.vo_nummer 
  inner join ftbpomschrijving pt_1 on pt_1.pt_cnknummer = vi.vi_cnknummer 
where 
  vo.vo_status = 1 -- and vi.vi_unieke_bc not like ' %' 
  and vo.vo_datum >= dateadd(-3 year to current_date) and
  vo.vo_klantnummer not in (select 
                              kr_klantnummer 
                            from 
                              ftbkredieten  kr
                              left join ftbpomschrijving pt_2 on kr.kr_cnknummer = pt_2.pt_cnknummer 
                              left join ftbklanten k on k.k_klantnummer = kr.kr_klantnummer 
                            where 
                              (kr.kr_is_ovs='Y' or kr.kr_is_attest='Y') and 
                              kr.kr_klantnummer = vo.vo_klantnummer and 
                              substring(kr.kr_datum from 1 for 10) = substring(vo.vo_datum from 1 for 10) and 
                              pt_2.pt_omschrijvingfr = pt_1.pt_omschrijvingfr and 
                              kr.kr_cnknummer = vi.vi_cnknummer)*/