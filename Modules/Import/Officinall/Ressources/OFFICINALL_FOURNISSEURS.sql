select lev_primkey,
       lev_naam,
       lev_straatnr,
       lev_gemeente,
       lev_postcode,
       lev_telefoon,
       lev_fax,
       lev_email
       /*lev_lev_primkey,
       lev_datechanged,
         lev_bestelprofiel,
       lev_guipositie,
       lev_userid,
       lev_btwnr,
       lev_afkorting,
       lev_land,
       lev_contactpersoon,
       lev_titel,
       lev_url,
       lev_wpl_primkey   ---- toujours à 0 donc on ne gère pas le lien avec le fichier des villes      ,
*/
from dbo.leverancier
where lev_primkey>999 --en desssous c'est repartiteur