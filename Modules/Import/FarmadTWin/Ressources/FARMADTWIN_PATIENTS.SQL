select 
  k.k_klantnummer,
  k.k_familienaam,
  k.k_voornaam,
  k.k_email_adres,
  k.k_familie_id,
  k.k_704,
  k.k_taal_cbl,
  k.k_insz,
  k.k_tekst,
  k.k_afschrift,
  k.k_laatste_bezoek,
  adr.a_straat, 
  pc.pc_nummer,
  pc.pc_gemeente,
  ks_1.ks_geboortedatum,
  ks_1.ks_geslacht,
  ks_1.ks_sis_gelezen,
  ks_1.ks_nr_sis,
  ks_1.ks_certificaat,
  ks_1.ks_cg1,
  ks_1.ks_cg2,
  ks_1.ks_versie_verz,
  ks_1.ks_stamnummer,
  ks_1.ks_categorie,
  k.K_MUT2_STAMNUMMER,
  k.K_MUT2_SOORT,
  ks_1.ks_sisgeldigheid,
  ks_1.ks_mut,
  iif(k.k_factgroep>0,k.k_factgroep,null),
  maxvalue(coalesce(k.k_kortingspercent,0),coalesce(fg.fg_korting1,0)),
  k.k_taalcode,
  (select first 1 tn.t_telefoonnummer
   from ftbtelnummers tn
   where tn.t_object_type = 'K' and tn.t_objectnummer = k.k_klantnummer)  
from 
  ftbklanten k
  left join ftbadressen adr on adr.a_uid = k.k_default_adres_id
  left join ftbpostcodes pc on pc.pc_id = adr.a_pc_id
  left join ftbklantsis ks_1 on ks_1.ks_klantnummer = k.k_klantnummer
  left join ftbfactgroepen fg on fg.fg_id = k.k_factgroep
where 
  k.k_familienaam is not null and 
  fg.fg_naamfr <> k.k_familienaam and -- exclure des collectivites deja reprises 
  trim(k.k_familienaam) <> '' and 
  (k.k_is_dummy = 'N' or k.k_is_dummy is null) and 
  ks_1.ks_id = (select max(ks_2.ks_id) 
              from ftbklantsis ks_2  
              where ks_2.ks_klantnummer = k.k_klantnummer) and 
  k.k_klantnummer in (select distinct vo_klantnummer 
                      from ftbvoorschriften) 
order by 
  k.k_klantnummer