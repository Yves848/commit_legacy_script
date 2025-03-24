select 
  s.SlsID
 ,sec.SsecNr
 ,sec.PatientID
 ,isnull(p.PrespNr,0)
 ,s.SellerID
 ,s.DateSale
 ,p.DatePresp
 ,AA.ActorName
 ,isnull(Pres.FirstName,'')
from Sales.Sales s
INNER JOIN Sales.SaleSections sec ON s.SlsID = sec.SlsID and sec.PatientID is not null --and sec.SsecNr=1
left join Sales.SsecPresps p on sec.SlsID = p.SlsID AND sec.SsecNr = p.SsecNr
left join Actor.Actors AA on P.PrescriberID=AA.ActorID
left join Actor.Prescribers pres on P.PrescriberID=pres.PrescriberID
where DateSale > getdate()-(365*2) 
order by s.SlsID