select 
  T1.serial,
  T4.serialbeneficiaire,
  T4.chronofacture,
  T4.dateprescription,
  T1.vendeurquivalide,
  T4.serialprescripteur,
  T5.nom,
  T5.prenom,
  T1.typevente,
  T1.datevente  
from 
  vente T1 
  left join ordonnance T4 on T4.serialvente = T1.serial
  left join prescripteur T5 on T5.serial = T4.serialprescripteur 
where
  T4.serialbeneficiaire <> 0 and T4.serialbeneficiaire is not null