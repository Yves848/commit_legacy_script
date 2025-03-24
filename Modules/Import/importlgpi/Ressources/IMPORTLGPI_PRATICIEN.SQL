select 
  cast(prat.t_praticien_id as varchar2(50)),
  decode(str.secteur, 'HOPITAL', '2','1'),
  prat.nom,
  prat.prenom,
  spe.code,
  adr.rue1,
  adr.rue2,
  cpv.codepostal,
  cpv.nomville,
  adr.telpersonnel,
  adr.telstandard,
  adr.telmobile,
  adr.fax,
  decode(str.secteur, 'HOPITAL',cast(ps.t_structure_id as varchar2(50)),null),
  prat.commentaires,
  nvl(prat.no_facturation,str.nofiness ) , --( ex finess )  
  prat.num_rpps 
from t_praticien prat
left join t_specialite spe on spe.t_specialite_id = prat.t_specialite_id 
left join t_praticien_structure ps on ps.t_praticien_id = prat.t_praticien_id
left join t_structure str on str.t_structure_id = ps.t_structure_id
left join t_adresse adr on adr.t_adresse_id = str.t_adresse_id
left join t_cpville cpv on cpv.t_cpville_id = adr.t_cpville_id 

