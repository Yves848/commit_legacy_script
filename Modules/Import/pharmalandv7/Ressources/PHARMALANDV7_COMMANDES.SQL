select
IDCommandes,
CMNumero,
substring(CMDate,1,4)+ '-' +
    substring(CMDate,5,2)+ '-' +
    substring(CMDate,7,2) as cmdate,
CASE WHEN CMDatePrevision = '' THEN NULL ELSE substring(CMDatePrevision,1,4)+ '-' +
    substring(CMDatePrevision,5,2)+ '-' +
    substring(CMDatePrevision,7,2) END as cmdatep,
substring(CMDateTransmission,1,4)+ '-' +
	substring(CMDateTransmission,5,2)+ '-' +
	substring(CMDateTransmission,7,2) as cmdatet,
CMFrsId,
CMTypeFrs, 
CMEtat
from COMMANDES
where CMDate >=add_months(sysdate,-24) 
and CmEtat in ( 2, 3, 4, 5)
-- 1 Prete ( non transmise )
-- 2 Emise ( transmise )
-- 3 Reception Partielle 
-- 4 Recue
-- 5 Reception financiere