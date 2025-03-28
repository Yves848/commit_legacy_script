select 1,
       klt_primkey as prim_key,
       klt_naam as nom,
       '' as prenom,
       '' as sexe,
       klt_taal as langue,
       '' as datenaissance,
       klt_adres+' '+klt_nr as rue,
       '' as tel,
       '' as gsm,
       woon.wpl_postkode as cp,
       woon.wpl_woonplaats as ville,
       '0' as print704,
       '',
       '',
       '' as matoa,
       '' as oa,
       null,
       null as ct2,
       '' as datedebut,
       '' as datefin,
       '',
       '',
       0 as catoc,
       null as dern_lecture,
       '' as datecertif,
       '' as datefin2,
       0 as numcartesis,
       0,
       '' as certificat,
       0,
       klt_korting,
       nfo.nfo_omschrijving,
       null,
       null,
       1
        /*
            klt_titel,
            klt_contactpersoon,
            klt_btwnr,
            klt_handelsreg,
            klt_rprnummer,
            klt_inschrijvingsnr,
            klt_type,
            klt_plafond,
            klt_plafondprocent,
            klt_aantallevbons,
            klt_betaling,
            klt_korting,
            klt_factuurvervaltermijn,
            klt_factuurvrijelijn,
            klt_creditnotavrijelijn,
            klt_printbon,
            klt_printlabel,
            klt_groep,
            klt_drukvvbon,
            klt_plafondwie,
            klt_rek_primkey,
            klt_drukocmwlabel,
            klt_plafondpatient,
            klt_plafondpatienttbt,
            klt_printrvtlabel*/
from dbo.klant
left join dbo.vwoonplaats woon on wpl_primkey=klt_wpl_primkey
left join dbo.info nfo on nfo.nfo_ref_primkey=klt_primkey and nfo.nfo_tablename = 'Klant'
where klt_naam<>''