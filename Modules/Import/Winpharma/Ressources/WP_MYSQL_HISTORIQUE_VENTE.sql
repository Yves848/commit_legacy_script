select 
histo.cip,
if(v1<0,0,v1),
if(v2<0,0,v2),
if(v3<0,0,v3),
if(v4<0,0,v4),
if(v5<0,0,v5),
if(v6<0,0,v6),
if(v7<0,0,v7),
if(v8<0,0,v8),
if(v9<0,0,v9),
if(v10<0,0,v10),
if(v11<0,0,v11),
if(v12<0,0,v12),
if(v13<0,0,v13),
if(v14<0,0,v14),
if(v15<0,0,v15),
if(v16<0,0,v16),
if(v17<0,0,v17),
if(v18<0,0,v18),
if(v19<0,0,v19),
if(v20<0,0,v20),
if(v21<0,0,v21),
if(v22<0,0,v22),
if(v23<0,0,v23),
if(v24<0,0,v24),
if(v25<0,0,v25)

from stprod histo
inner join produit prd on prd.cip = histo.cip
where ( prd.en_stock > 0 or datediff( current_date, prd.Dernier_Vente) < 1095 )
