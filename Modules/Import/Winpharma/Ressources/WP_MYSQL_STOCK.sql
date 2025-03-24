-- depot vente en premier contient le stock TOTAL 
-- depot id = 0 ( par defaut ? )
select 
prd.cip,
0,
prd.code_geo,
cast(prd.en_stock as signed) STOCK_TOTAL,
prd.minmaxrayon & 65535,
prd.minmaxrayon >> 16
from produit prd
where (datediff( current_date, prd.Dernier_Vente) < 1095 or prd.en_stock > 0)
union
-- autres depots -> a soustraire au stock total
select 
pg.CIP ID,
pg.CodeZone DEPOT,
pg.codegeo,
case when pg.CodeZone = 1  then cast(prd.QteEnReserve as signed)  
     when pg.CodeZone = 2  then cast(prd.QteEnReserve2 as signed)
     when pg.CodeZone = 3  then cast(prd.QteEnReserve3 as signed)
     when pg.CodeZone = 4  then cast(prd.QteEnReserve4 as signed)
     when pg.CodeZone = 5  then cast(prd.QteEnReserve5 as signed) 
     when pg.CodeZone = 6  then cast(prd.QteEnReserve6 as signed)
     when pg.CodeZone = 7  then cast(prd.QteEnReserve7 as signed)
end  quantite,
pg.SeuilMin MINI,
pg.Capacite MAXI
from produit prd  
left join PRODGEO pg on prd.cip= pg.cip
