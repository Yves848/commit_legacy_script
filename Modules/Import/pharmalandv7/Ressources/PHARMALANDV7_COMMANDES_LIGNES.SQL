select 
lig.LANumero, 
lig.LANumeroIdCommande,
art.arcleunik,
lig.LAQte,  
lig.LAQteRecue,
lig.LAQteAnnulee,
lig.LAPrixAchatHT,
lig.LaRemise,
lig.LAPrixRemise,
art.ARPPBL
from LIGART lig 
inner join ARTICLES art on lig.LACode = art.artcode
inner join COMMANDES cmd on cmd.idcommandes = lig.LANumeroIdCommande
where cmd.CMDate >=add_months(sysdate,-24) 
and CmEtat in ( 2, 3, 4, 5)
and LAQte <> LAQteAnnulee -- on ne prend pas en compte les lignes annulées