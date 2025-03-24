select 
 vr.IdVentesReportées 
 ,vr.Cnk
 ,vr.IDPatient
 ,v.idmédecin
 ,vr.NumOrdoOrigine
 ,trim(cast(vr.DatePrescription as varchar(10)))
 ,v.QtAdmise
from VentesReportées vr
inner join Ventes v on v.idvente = vr.IDVenteOrigine
where vr.IDVenteRégul =0 and vr.DateValiditéBon >= sysdate and (vr.Type=2 OR vr.Type=1)