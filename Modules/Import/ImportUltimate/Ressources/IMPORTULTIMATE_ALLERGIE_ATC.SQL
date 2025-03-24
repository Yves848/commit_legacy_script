select 
  a.t_allergiedelphiatcassaad_id,
  a.t_aad_id,
  atc.code
from
  bel.t_allergiedelphiatcassaad a
  inner join bel.t_delphi_classifatc atc on atc.t_delphi_classifatc_id = a.t_delphi_classifatc_id 
  inner join bel.t_assureayantdroit aad on aad.t_aad_id = a.t_aad_id
  left join bel.t_collectivite c on c.t_aad_id = aad.t_aad_id 
where aad.id_del is null  and 
  (c.no_collectivite = (select min(c1.no_collectivite) 
                        from bel.t_collectivite c1 
                        where c1.t_aad_id = aad.t_aad_id) 
   or c.no_collectivite is null)  