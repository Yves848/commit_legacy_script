select 
  cli.serial idcli,
  ben.serial idben,
  cp.serial idpara, 
  cli.nom, 
  cli.prenom, 
  adr.adresse1, 
  adr.adresse2, 
  adr.codepostal, 
  adr.ville, 
  adr.telephone, 
  adr.mobile, 
  adr.fax,
  0,
  ass.numeross,
  ass.serialamo,
  ass.centregestionnaire,
  ass.datevaliditepiece,
  ass.alsacemoselle,
  ben.nom nom_ben,
  ben.nompatronymique nom_jf_ben,
  ben.prenom prenom_ben,
  ben.datenaissance,
  ben.rangnaissance,
  ben.qualite,
  ben.datedebutamo,
  ben.datefinamo,
  ben.numeroadherent,
  ben.datedebutamc,
  ben.datefinamc,
  ben.mutuelleencarte,
  ben.codetraitementamc,
  ben.typerc, -- mode gestion amc ?
  ben.identifiantamc,
  couvamc.serialamc, 
  couvamc.serialcouvertureamc,
  couvamc.datedebut,
  couvamc.datefin,
  couvamc.adherent,
  cli.dernierpassage

    
from client cli
  left join adresse adr on adr.serial = cli.serialadresse
  left join clientpara cp on cp.serialclient = cli.serial
  left join assure ass on ass.serialclient = cli.serial
  left join beneficiaire ben on ben.serialassure = ass.serial
  left join couvertureamcbeneficiaire couvamc on couvamc.serialbeneficiaire = ben.serial

