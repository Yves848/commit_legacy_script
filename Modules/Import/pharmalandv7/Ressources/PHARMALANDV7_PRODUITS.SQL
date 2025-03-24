select 
  arcleunik,
  artcode,
  artlibelle,
  artean,
  arttableau,
  artetat,
  arttva,
  aractcod,
  artvigcod,
  arpach,
  arppbl,
  arpromoprix_1,
  arppmp,
  arppba,
  artucd,
  arqtsto,
  ardepotstock,
  arqtmin,
  arqtmax,
  arcodefabricant,
  trim(cast(ardatedernierevente as varchar(10))),
  arcommentaire,
  arinfocommande,
  arautomate
from articles art
where (ardatedernierevente >=add_months(sysdate,-24) 
or arqtsto > 0 
or artcode in (select lacode from ligart where LAQte <> LAQteAnnulee -- on ne prend pas en compte les lignes annulées
and LAQte > LAQteRecue and LADate >=add_months(sysdate,-24))
)