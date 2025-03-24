SELECT 
 pdt.CNK
,pdt.libf
,pdt.libn
,pdt.catAPBprod
,pdt.prixpublic
,pdt.codelabo
,pdt.codeconcession
,trim(cast(pdt.datedervente as varchar(10)))
,pdt.usage
,pdt.pctva
,pdt.remarques
,loc.idlocalisations
,stk.stkrayon
,stk.raystkmin
,stk.raystkopt
,locc.idlocalisations
,stk.stkcave
,stk.CaveStkMin
,stk.CaveQtMinACom
,stk.rayStkMax
,stk.QtMinPourComCave
,stk.stkrobot
,stk.ProdDansRobot
,pdt.prixachat
,pdt.bloquePP
,pdt.bloqueLib
FROM TarSpe pdt, Stock stk
left join localisations loc on loc.localisation=stk.raylocalisation1
left join localisations locc on locc.localisation=stk.cavelocalisation
WHERE pdt.cnk = stk.cnk AND 
(stk.stkrayon <> 0 OR stk.stkcave <> 0 OR (stk.stkrayon = 0 AND stk.stkcave = 0 AND pdt.datedervente >=add_months(sysdate,-36)))
