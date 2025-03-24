SELECT  
  p.PendingID
 ,p.ArtID
 ,p.PatientID
 ,s.PrescriberID
 ,s.PrespNr
 ,s.DatePresp
 ,s.DateDeliv
 ,p.CurPendingQtd
 ,p.DatePending
FROM Sales.Pendings p
 left join Sales.SsecPresps s on s.SlsID=p.SlsID and s.SsecNr=p.SsecNr
 left join Actor.Actors AA on s.PrescriberID=AA.ActorID
 left join Actor.Prescribers pr on AA.ActorID=Pr.PrescriberID
where p.PendType='E' and p.ArtID is not null and p.CurPendingQtd<>0
and s.PrespNr is not null and p.DatePending  > (getdate()-365)


/*SELECT  
  p.PendingID
 ,p.ArtID
 ,p.PatientID
 ,s.PrescriberID
 ,s.PrespNr
 ,s.DatePresp
 ,s.DateDeliv
 ,p.CurPendingQtd
 ,p.DatePending
FROM Sales.Pendings p
 left join Sales.SsecPresps s on s.SlsID=p.SlsID and s.SsecNr=p.SsecNr
where p.PendType='E' and p.ArtID is not null and p.CurPendingQtd<>0
and s.PrespNr is not null and p.DatePending  > (getdate()-365)*/
