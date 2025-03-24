select 
distinct l.ci,
 l.product,
 l.qv,
 l.ttc
 
from "LGO2".invoicelines l
left join "LGO2".invoices i on i.ci = l.ci
inner join "LGO2".products p on p.ci = l.product
where i.customer <> 0 and i.state <>255 and l.qv>=0 
and i.invoiceday > current_date - interval '2 years'