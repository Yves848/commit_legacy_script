select 
lig.no_nfac,
lig.ar_cip,
trim(lig.ar_nom),
lig.ac_code,
lig.lf_quant,
lig.lf_punit
from lignefac  lig
inner join notefac ent on ent.no_nfac =lig.no_nfac
where ent.no_atten ='O' and ent.no_dtfac >= add_months(sysdate,-36) and ent.be_code > 0 