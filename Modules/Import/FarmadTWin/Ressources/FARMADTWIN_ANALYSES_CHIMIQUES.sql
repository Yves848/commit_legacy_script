select AN_ID,
       AN.AN_TMBLINK,
       AN.AN_PRODLINK,
       AN.AN_VERGUNNINGSNR,
       AN.AN_ANALYSEREF,
       AN.AN_DATUM, -- Date achat
       p.P_LABO, -- fabricant
       AN.AN_LEVNUMMER, -- fournisseur
       AN.AN_PARTIJNR, -- num lot
       AN.AN_AANKOOPPRIJS,
       '', -- bon de livraison
       cast(AN.AN_VERVALDATUM as varchar(20)), -- date péremption
       AN.AN_AANTAL_EENHEDEN, -- quantité initiale  
       P.P_VERKOOPSVORM
       from FTBANALYSEREG AN
left join FTBPRODUCTEN p on p.p_CNKNUMMER = AN.AN_PRODLINK 
where AN.AN_VERVALDATUM > (select timestamp 'NOW' from rdb$database) and AN.AN_POTISOP = 'N'