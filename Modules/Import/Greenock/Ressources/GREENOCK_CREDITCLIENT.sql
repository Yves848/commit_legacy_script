SELECT  
  p.PendingID
 ,convert(decimal(10,2) ,p.CurPendingQtd)
 ,p.DatePending 
 ,p.PatientID
FROM Sales.Pendings p
where p.PendType='1' and p.DatePendResol is null