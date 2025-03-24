select 
  cpt.serial, 
  cpt.raisonsociale, 
  fact.adresse1, 
  fact.adresse2, 
  fact.codepostal, 
  fact.ville, 
  fact.telephone, 
  fact.mobile, 
  fact.fax,
  livr.adresse1, 
  livr.adresse2, 
  livr.codepostal, 
  livr.ville, 
  livr.telephone, 
  livr.mobile, 
  livr.fax,
  cli.dernierpassage,
  cpt.remise

    
from client cli
  inner join clientencompte cpt on cpt.serialclient = cli.serial
  left join adresse fact on fact.serial = cpt.serialadressefacturation
  left join adresse livr on livr.serial = cpt.serialadresselivraison
