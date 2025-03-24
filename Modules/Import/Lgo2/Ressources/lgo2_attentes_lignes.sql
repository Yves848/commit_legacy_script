select ent.ci id_facture,
	   prd.ci id_produit,		
	   lig.qv , 
	   lig.ht,	
	   lig.ttc,	
 	   (select cast(trim(both '{}' from (string_to_array(data, '|'))[1]) as varchar(3)) from "LGO2".commondata where index = lig.acte and uid = 7) code_prestation
from "LGO2".invoicelines lig
inner join "LGO2".invoices ent on lig.ci = ent.ci
inner join "LGO2".products prd on lig.product = prd.ci 
where lig.state = 1