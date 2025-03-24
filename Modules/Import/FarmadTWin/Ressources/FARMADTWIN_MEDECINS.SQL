select 
  art.a_artsnummer,
  art.a_naam,
  art.a_voornaam, 
  art.a_rizivnr,
  art.a_kwalificatie,
  art.a_email_adres, 
  art.a_tekst,
  adr.a_straat,
  pc.pc_nummer,
  pc.pc_gemeente,  
  (select first 1
     tn.t_telefoonnummer
   from
     ftbtelnummers tn 
   where 
     tn.t_object_type = 'A' and 
     tn.t_objectnummer = art.a_artsnummer) 
from 
  ftbartsen art 
  left join ftbadressen adr on adr.a_uid = art.a_default_adres_id 
  left join ftbpostcodes pc on pc.pc_id = adr.a_pc_id  
where 
  a_naam is not null --and 
  --a_rizivnr is not null and art.a_kwalificatie is not null 
order by 
 a_artsnummer