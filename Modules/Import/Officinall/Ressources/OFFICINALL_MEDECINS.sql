select art_primkey ,
       rtrim(arz_rizivnr) ,
       art_naam ,
       art_adres+' '+art_nr ,
       art_titel ,
       art_telefoon ,
       woon.wpl_postkode ,
       woon.wpl_woonplaats ,
       art_isbuitenlands ,
       art_isveearts
from dbo.arts med
left join dbo.vwoonplaats woon on wpl_primkey = art_wpl_primkey
left join dbo.artsriziv on art_primkey = arz_art_primkey
where art_naam != '' -- and len(rtrim(art_rizivnr))=11
and arz_primkey =
    ( select max(arz_primkey)
     from dbo.artsriziv
     where art_primkey = arz_art_primkey )