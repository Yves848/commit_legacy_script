select cli.ci id_client,
	   av.day,
	   prd.ci,
	   prd.cip13,
	   prd.nom,
	   av.quantity, 
	   prd.pfht,	
	   can.ttc,	
 	   (select cast(trim(both '{}' from (string_to_array(data, '|'))[1]) as varchar(3)) from "LGO2".commondata where index = prd.acte and uid = 7) code_prestation,
	   av.usercode,
	   prd.base
from "LGO2".waits av 
inner join "LGO2".customers cli on cli.ci = av.customer 
inner join "LGO2".products prd on prd.ci = av.product
inner join "LGO2".canal can on can.product = prd.ci