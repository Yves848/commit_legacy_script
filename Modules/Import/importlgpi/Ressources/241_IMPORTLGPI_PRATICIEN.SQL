select 
  cast(pp.t_praticienprive_id as varchar2(50)),
  '1',
  pp.nom,
  pp.prenom,
  specpp.code,
  adrpp.rue1,
  adrpp.rue2,
  cppp.codepostal,
  cppp.nomville,
  adrpp.telpersonnel,
  adrpp.telstandard,
  adrpp.telmobile,
  adrpp.fax,
  cast(null as varchar2(50)),
  pp.commentaires,
  finpp.nofiness,
  pp.num_rpps
from 
  erp.t_praticienprive pp,
  erp.t_specialite specpp,
	 erp.t_adresse adrpp,
	 erp.t_cpville cppp,
	 erp.t_finess finpp
where pp.t_specialite_id = specpp.t_specialite_id
  and pp.t_adresse_id = adrpp.t_adresse_id(+)
  and adrpp.t_cpville_id = cppp.t_cpville_id(+)
  and pp.t_finess_id = finpp.t_finess_id
union 	 	 	   
select 
  cast(ph.t_praticienhospitalier_id as varchar2(50)),
  '2',
  ph.nom,
  ph.prenom,
  specph.code,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  null,
  cast(hopph.t_hopital_id as varchar2(50)),
  null,
  null,
  ph.num_rpps
from 
  erp.t_praticienhospitalier ph,
  erp.t_specialite specph,
	 erp.t_hopital hopph
where ph.t_specialite_id = specph.t_specialite_id
  and ph.t_hopital_id = hopph.t_hopital_id