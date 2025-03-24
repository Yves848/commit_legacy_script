SELECT 
 ag.IDAgenda
 ,ag.TypeDette
 ,ag.IDPatient
 ,v.cnk
 ,trim(cast(ag.DateDette as varchar(10))) 
 ,ag.Quantite
FROM Agenda ag
inner join ventes v on ag.idvente=v.idvente
WHERE ag.TypeDette = 2 and  ag.DateDette >=add_months(sysdate,-36)
