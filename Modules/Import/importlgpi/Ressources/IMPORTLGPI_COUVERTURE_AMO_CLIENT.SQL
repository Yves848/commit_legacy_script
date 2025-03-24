select cast(cli.t_aad_id as varchar2(50)),
       o.t_organismeamo_id || '_' || couvcli.t_couvertureamo_id,
	   couvcli.datedebutdroit,
	   couvcli.datefindroit
from erp.t_couvertureaadamo couvcli
     inner join erp.t_organismeaadamo o on o.t_organismeaadamo_id = couvcli.t_organismeaadamo_id
     inner join erp.t_assureayantdroit cli on cli.t_aad_id = o.t_aad_id
where cli.id_del is null     
order by couvcli.datefindroit  