SELECT 
 MAX(e.IDVente)
 ,e.cnk
 ,substring(e.DateHeureLigne,5,2)
 ,substring(e.DateHeureLigne,1,4)
 ,sum(e.Qt)
 ,count(*)
FROM ventes  e
WHERE e.cnk<>0 AND e.DateHeureLigne >=add_months(sysdate,-24)
GROUP BY e.cnk
		,substring(e.DateHeureLigne,5,2)
		,substring(e.DateHeureLigne,1,4)
 