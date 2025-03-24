select distinct
  cast(ass.t_organismeamo_id as varchar2(50)),
  cast(ass.t_organismeamc_id as varchar2(50)),
  ass.typedebiteur,
  ass.typecontrat
from erp.t_organismeamoassamc ass,
     erp.t_organismeaadamo a
where ass.t_organismeamo_id = a.t_organismeamo_id
