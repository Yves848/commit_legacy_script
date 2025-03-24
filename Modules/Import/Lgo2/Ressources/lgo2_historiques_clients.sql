select 
 distinct fac.ci,
 ---type, --1 fse, 2 vente direct ?
 --fse,
 fac.deliveryday,
 fac.prescriptionday,
 fac.customer,
 fac.doctor,
 cast(substring(nom from 1 for 50) as varchar(50)) nom_medecin,
 cast(substring(prenom from 1 for 50)as varchar(50)) prenom_medecin,
 fac.fse
from "LGO2".invoices fac
left join "LGO2".doctors med on med.ci = fac.doctor
where fac.state <>255 and fac.customer <> 0 
and fac.invoiceday > current_date - interval '2 years'