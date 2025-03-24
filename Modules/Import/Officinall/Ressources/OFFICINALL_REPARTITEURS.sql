select lev_primkey,
       lev_naam,
       lev_straatnr,
       lev_gemeente,
       lev_postcode,
       lev_telefoon,
       lev_fax,
       lev_email /*lev_lev_Primkey,
        lev_BestelProfiel,
       lev_GUIPositie,
       lev_UserID,
       lev_BTWNr,
       lev_Afkorting,
       lev_Land,
       lev_ContactPersoon,
       lev_Titel,
       lev_URL,
       lev_wpl_Primkey   ---- toujours à 0 donc on ne gère pas le lien avec le fichier des villes      ,
*/
from dbo.leverancier
where lev_primkey>0
  and lev_primkey<1000 --en desssous c'est repartiteur