select plv_primkey, 
       --,plv_datechanged
       --,plv_userid
       plv_prd_primkey,
       plv_lev_primkey,
       --,plv_productcodeleverancier --cnk
       plv_aankoopprijsverpakking,
       plv_prd_primkey
       --,plv_aantalinverpakking -- nb colis
       --lv_verkoopprijs
       --,plv_richtprijs --prix indicatif
       --,plv_leverbaar
       --,plv_laatsteantwoord -- derniere réponse

from productleverancier pl
where pl.plv_prd_primkey<>''
  and pl.plv_datechanged>'2008-01-01'
  and pl.plv_prd_primkey in (select distinct pst_prd_primkey
                             from dbo.productstock)