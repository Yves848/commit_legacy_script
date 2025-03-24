select 
n.no_nfac,
l.ar_cip,
trim(l.ar_nom),
l.lf_quant,
l.lf_punit
from lignefac l
inner join notefac n on n.no_nfac = l.no_nfac
where n.no_dtfac>=add_months(sysdate,-24)
and n.be_code > 0 
and l.ar_cip not in ( 'HC', 'HD1', 'HD2', 'HD4', 'HD7',
					 'HDA',	'HDE', 'HDR', 'HG4', 'HG7' )   	
and l.lf_quant>0 