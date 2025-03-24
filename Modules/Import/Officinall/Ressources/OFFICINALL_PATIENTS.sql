select 
       0,
       pat_primkey,
       pat_naam,
       pat_voornaam,
       pvz_geslacht, --sexe
       pat_taal,   --langue
       pat_gebdatum,
       pat_adres+' '+pat_nr as rue,
       pat_telefoon,
       pat_gsm,
       woon.wpl_postkode,
       woon.wpl_woonplaats,
       pat_drukf704, -- edition f704,
       pat_drukverzekeringsattest,
       pvz_insz,
       pvz_rizivnr,
       case rtrim(pvz_federatie) when '' then null else    pvz_federatie end,
       case isnumeric(pvz_kg1) when 1 then pvz_kg1 else null end,
       case isnumeric(pvz_kg2) when 1 then pvz_kg2 else null end,
       pvz_begingeldigheidverz,
       pvz_eindgeldigheidverz,
       pvz_rizivnr2,
       case rtrim(pvz_federatie2) when '' then null else    pvz_federatie2 end,
       pvz_aktiefnr2,
       pvz_datumcertificaat,
       pvz_begingeldigheidkaart,
       pvz_eindgeldigheidkaart,
       case isnumeric(pvz_logischnummer) when 1 then cast(   pvz_logischnummer as bigint) else 0 end,
       case isnumeric(pvz_versieverzekerbaarheid) when 1 then    pvz_versieverzekerbaarheid else 0 end,
       pvz_certificaat,
       pat_klt_primkey,
       pat_korting,
       nfo.nfo_omschrijving,
       pat_kamer,
       pat_verdiep,
       case (pat_visible) when 'True' then 1 else 0 end
from dbo.patient pat 
left outer join dbo.patientverzekerbaarheid pvz on pvz.pvz_primkey= pat.pat_pvz_primkey
left join dbo.vwoonplaats woon on wpl_primkey=pat_wpl_primkey
left join dbo.info nfo on nfo.nfo_ref_primkey=pat.pat_primkey 
                          and nfo.nfo_tablename = 'Patient'
where pat_naam<>''
 