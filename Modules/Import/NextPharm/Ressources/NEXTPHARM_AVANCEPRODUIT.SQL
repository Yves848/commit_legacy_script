SELECT 
 ag.IDAgenda
 ,ag.IDPatient
 ,v.Cnk
 ,ag.Quantité
 ,v.tmTot
 ,v.Libellé
 ,trim(cast(ag.DateDette as varchar(10))) 
 ,v.Cbu
 ,v.gtin
 ,v.SerialNumber
 ,v.TypeProduit
FROM Agenda ag, Ventes v
WHERE ag.IDVente=v.IDVente and ag.TypeDette = 1 and  ag.DateDette >=add_months(sysdate,-36)


