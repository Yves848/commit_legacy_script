select 
no_nfac,
no_nsubr,
trim(cast(no_dtfac as varchar(10))),
trim(cast(no_dtpre as varchar(10))),
trim(op_code),
be_code,
trim(no_typef),
trim(mo_code),
trim(mo_nom)
from notefac 
--where be_code > 0 
where no_dtfac>=add_months(sysdate,-24) and be_code > 0 
