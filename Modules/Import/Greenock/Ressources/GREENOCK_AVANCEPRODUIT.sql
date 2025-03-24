SELECT  
  p.PendingID
 ,p.PatientID
 ,(select ArtName from Article.ArtNames AN1 where AN1.ArtID=p.ArtID and AN1.LangCode='*' and AN1.NameNr=0)
 ,p.ArtID
 ,convert(decimal(10,2) ,s.AmntPaid/p.CurPendingQtd)
 ,p.CurPendingQtd
 ,convert(decimal(10,2) ,p.OriginalPendingQtd-CurPendingQtd)
 ,p.DatePending
 ,ub.UbcNr
FROM Sales.Pendings p
 left join Sales.SaleItems s on s.SlsID=p.SlsID and s.SsecNr=p.SsecNr and s.SitmNr=p.SitmNr
 left join Sales.SitmUbcs ub on ub.SlsID=p.SlsID and ub.SsecNr=p.SsecNr and ub.SitmNr=p.SitmNr --and ub.SitmUbcNr=1
where p.PendType='3' and p.DatePendResol is null and p.ArtID is not null and p.CurPendingQtd>0 and s.AmntPaid > 0