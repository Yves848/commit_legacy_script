select 
no_nfac,
trim(cast(no_dtfac as varchar(10))),
be_code
from notefac
where no_dtfac >= add_months(sysdate,-36)   
and be_code > 0 
and no_atten ='O'
and NO_ETATF = ' '