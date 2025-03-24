SELECT 
 ag.IDAgenda
 ,ag.IDPatient
 ,ag.SommeDue
 ,trim(cast(ag.DateDette as varchar(10))) 
FROM Agenda ag
WHERE ag.TypeDette = 4 and  ag.DateDette >=add_months(sysdate,-36)