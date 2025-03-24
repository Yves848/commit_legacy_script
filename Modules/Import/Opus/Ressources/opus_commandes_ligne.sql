-- lignes commandes en cours grossiste
SELECT 'REP_'+ligne.cp_code,
       ligne.ar_cip,
       ligne.cr_qtcom,
       ligne.cr_qtrec,
       ligne.cr_qtgra,
       ligne.ar_phare,
       ligne.cr_phafa,
       ligne.ar_pvent
FROM comrep ligne
LEFT JOIN comartic entete ON entete.cp_code =ligne.cp_code
WHERE entete.cp_dtcre >= add_months(sysdate,-36)
	AND entete.cp_etat IN ('T')

UNION

-- lignes commandes directe en cours 
SELECT 'FOU_'+ligne.cd_code,
       ligne.ar_cip,
       ligne.cb_qtcom,
       ligne.cb_qtrec,
       ligne.cb_qtgra,
       ligne.ar_phacg,
       ligne.cb_phafa,
       ligne.ar_pvent
FROM comlab ligne
LEFT JOIN comprod entete ON ligne.cd_code = entete.cd_code
WHERE entete.cd_dtcre >= add_months(sysdate,-36)
	AND entete.cd_etat IN ('T')	

UNION 

-- ligne commandes en cours groupement
SELECT 'GRP_'+ligne.ch_code,
       ligne.ar_cip,
       ligne.cm_qtcom,
       ligne.cm_qtrec,
       ligne.cm_qtgra,
       ligne.ar_phacg,
       ligne.cm_phafa,
       ligne.ar_pvent
FROM comgrp ligne
LEFT JOIN comech entete ON entete.ch_code =ligne.ch_code
WHERE entete.ch_dtcre >= add_months(sysdate,-36)
	AND entete.ch_etat IN ('T')	