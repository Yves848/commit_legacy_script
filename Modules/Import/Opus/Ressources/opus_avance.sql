select 
be_code,    
trim(cast(no_dtsai as varchar(10))),
ar_cip,               
trim(ar_nom),               
lf_punit,               
lf_pacha,               
ac_code,               
op_code,                
lf_quant,                
lf_ptips
from lignefac
where lf_avanc = 'O'

