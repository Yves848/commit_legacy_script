select 
  cast(p.t_praticienprive_id as varchar2(50)),
  p.nom,
  p.prenom,
  p.commentaires,
  p.identification,
  s.code,
  a.email,
  a.fax,
  c.nomville,
  c.codepostal,
  pa.code_iso,   
  a.telstandard,
  a.telpersonnel,
  a.telmobile,
  a.rue1,
  a.rue2,
  a.siteweb,
  p.categorie,
  s.is_dentiste
from bel.t_praticienprive p
inner join bel.t_specialite s on s.t_specialite_id = p.t_specialite_id
left join bel.t_adresse a on a.t_adresse_id = p.t_adresse_id
left join bel.t_cpville c on c.t_cpville_id = a.t_cpville_id
left join bel.t_pays pa on pa.t_pays_id = c.t_pays_id
