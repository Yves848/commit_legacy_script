select vte.vrk_primkey,
       vte.vrk_pat_primkey,
       vte.vrk_nummervoorschrift,
       vte.vrk_userid,
       vte.vrk_datumaflevering,
       vte.vrk_datumvoorschrift,
       med.art_naam
from verkoop vte
left join arts med on med.art_primkey = vte.vrk_art_primkey
where vte.vrk_datumaflevering > getdate()-365*2 --2 ans d'anciennete