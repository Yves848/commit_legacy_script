select 'PAT-'||patnr,
       kasvolgnr,
       artikelnr id,
       natnr cnk,
       naam,
       volgnr,
       case
       when publprijs like '%.%' then cast(publprijs as float)    -- Prix vente
       else 0.00
       end prix_public
from import.histpatient
where patnr <> '0'



