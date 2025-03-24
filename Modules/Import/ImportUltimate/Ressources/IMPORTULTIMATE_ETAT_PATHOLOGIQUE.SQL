select
  a.t_etatpathoassaad_id,
  a.t_aad_id,
  d.code
from 
  bel.t_etatpathoassaad a
  inner join bel.t_delphi_etat_patho d on d.t_delphi_etat_patho_id = a.t_delphi_etat_patho_id
  inner join bel.t_assureayantdroit aad on aad.t_aad_id = a.t_aad_id
  left join bel.t_collectivite c on c.t_aad_id = aad.t_aad_id 
where 
  aad.id_del is null  and 
  (c.no_collectivite =(select min(c1.no_collectivite) 
                       from bel.t_collectivite c1 
                       where c1.t_aad_id = aad.t_aad_id) 
   or c.no_collectivite is null)