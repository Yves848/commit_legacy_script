select 
  cast(hop.t_structure_id as varchar2(50)),
  hop.nom,
  hop.commentaires,
  hop.nofiness,
  adr.rue1,
  adr.rue2,
  cpv.codepostal,
  cpv.nomville,
  adr.telstandard,
  adr.telpersonnel,
  adr.telmobile,
  adr.fax
from t_structure hop
left join t_adresse adr on adr.t_adresse_id = hop.t_adresse_id
left join t_cpville cpv on cpv.t_cpville_id = adr.t_cpville_id 
where hop.secteur = 'HOPITAL'