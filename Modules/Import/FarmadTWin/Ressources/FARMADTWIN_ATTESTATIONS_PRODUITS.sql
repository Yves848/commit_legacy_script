select distinct 
  a.at_attestid, 
  k.k_klantnummer, 
  kpa.kpa_cnknummer, 
  a.at_categorie, 
  vi.vi_aflevering,
  a.at_attestnummer,
  a.at_vervaldatum 
from 
  ftbklanten k
  inner join ftbattesten a on a.at_klantnummer  = k.k_klantnummer
  inner join ftbkpattesten kpa on kpa.kpa_attestid = a.at_attestid
  inner join ftbverkoopitems vi on vi.vi_attestid = a.at_attestid
where 
  a.at_vervaldatum >= current_date  
order by 
  k_klantnummer