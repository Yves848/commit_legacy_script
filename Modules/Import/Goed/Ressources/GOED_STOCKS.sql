SELECT artnr produit_id, 
 	   natnr cnk,
 	   stock,
 	   lokalisatie zone_geo,
 	   minstock mini,
 	   tebestellen maxi  
FROM import.artikel
where stock is not null