select distinct 
  o.t_organismeamo_id || '_' || couvamo.t_couvertureamo_id,
  cast(o.t_organismeamo_id as varchar2(50)),
  decode(substr(couvamo.codecouverture, 1, 1), '1', '1', '0'),
  substr(couvamo.libelle, 1, 50),
  couvamo.codecouverture,
  null,
  couvamo.justificatifexo
from 
  erp.t_couvertureaadamo couvcli
  inner join erp.t_organismeaadamo o on (o.t_organismeaadamo_id = couvcli.t_organismeaadamo_id)
  inner join erp.t_assureayantdroit cli on (cli.t_aad_id = o.t_aad_id)
  inner join erp.t_couvertureamo couvamo on (couvamo.t_couvertureamo_id = couvcli.t_couvertureamo_id)
