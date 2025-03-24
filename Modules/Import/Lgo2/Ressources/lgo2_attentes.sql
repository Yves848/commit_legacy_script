select fac.ci id_facture,
	   fac.customer id_client,
	   fac.invoiceday
from "LGO2".invoices fac
inner join "LGO2".invoicelines lig on lig.ci = fac.ci
where lig.state = 1
group by fac.ci, fac.customer, fac.invoiceday -- avec l'inner join, on récupére nb_lignes enregistrements pour chaque facture, entraînant des erreurs