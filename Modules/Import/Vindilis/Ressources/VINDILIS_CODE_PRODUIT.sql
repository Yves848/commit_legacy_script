select prd.serial,
       amm.amm,
       amm.principal
from  article prd
inner join amm on amm.serialarticle = prd.serial