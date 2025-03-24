select 
  lcf.serial,
  lcf.serialcommandefou,
  stk.serialarticle,
  lcf.qtecommandee,
  lcf.qtelivree,
  lcf.qteuglivree,
  lcf.prixachatbase,
  lcf.prixachatnet,
  lcf.prixventettc,
  lcf.qteug 
from lignecommandefou lcf
inner join stock stk on stk.serial = lcf.serialstock
union
select 
  lcg.serial,
  lcg.serialcommandegro,
  lcg.serialstock,
  lcg.qtecommandee,
  lcg.qtelivree,
  0,
  lcg.prixachatbase,
  lcg.prixachatnet,
  lcg.prixvente,
  0
from lignecommandegro lcg 
inner join stock stk on stk.serial = lcg.serialstock
