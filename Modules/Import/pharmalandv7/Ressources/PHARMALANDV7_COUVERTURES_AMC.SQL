select distinct
  cli.mutuelle,
  cli.risque_mut,
  ctr.cemutdiv[5]
from client cli
inner join centre ctr on (ctr.cecode = cli.mutuelle) 