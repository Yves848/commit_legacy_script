SELECT  
  p.PendingID
 ,p.PendType
 ,p.PatientID
 ,(select ArtName from Article.ArtNames AN1 where AN1.ArtID=p.ArtID and AN1.LangCode='*' and AN1.NameNr=0)
 ,p.DatePending 
 ,convert(decimal(10,2) ,p.CurPendingQtd)
 ,sp.PrespNr
 FROM Sales.Pendings p
left join Sales.SsecPresps sp on sp.SlsID = p.SlsID and sp.SsecNr=p.SsecNr 
where p.PendType<>'E' and p.PendType<>'3' and p.DatePendResol is null
