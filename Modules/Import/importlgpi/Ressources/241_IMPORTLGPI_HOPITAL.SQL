select 
  cast(hop.t_hopital_id as varchar2(50)),
  hop.nom,
  hop.commentaires,
  fin.nofiness,
  adr.rue1,
  adr.rue2,
  cp.codepostal,
  cp.nomville,
  adr.telstandard,
  adr.telpersonnel,
  adr.telmobile,
  adr.fax
from 
  erp.t_hopital hop,
  erp.t_finess fin,
	 erp.t_adresse adr,
	 erp.t_cpville cp
where hop.t_finess_id = fin.t_finess_id
  and hop.t_adresse_id = adr.t_adresse_id(+)
  and adr.t_cpville_id = cp.t_cpville_id(+)	 	   	  