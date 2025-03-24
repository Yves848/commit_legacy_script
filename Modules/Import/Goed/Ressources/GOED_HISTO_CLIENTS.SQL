select patnr,
       min(to_date(datum, 'DD/MM/YY')),
       min(to_date(vsdatum, 'DD/MM/YY')),
       kasvolgnr
from 
import.histpatient
where patnr <> '0'
group by patnr,
         kasvolgnr
