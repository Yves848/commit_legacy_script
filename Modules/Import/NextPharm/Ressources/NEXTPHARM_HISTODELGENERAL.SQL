SELECT 
  d.NumTicket
 ,d.IDPatient
 ,d.IDClient
 ,d.NumOrdo	
 ,max(d.DateHeureLigne)
 ,max(m.Nomprénom)
 ,d.TypeVente
FROM ventes d
left join Médecins m on m.IDMédecin= d.IDMédecin
WHERE d.DateHeureLigne >=add_months(sysdate,-24) and d.LigneSuspendue =0 and d.TypeProduit<>8
group by d.NumTicket
 ,d.IDPatient
 ,d.IDClient
 ,d.NumOrdo	
 ,d.TypeVente