Select 
   inst.InstID
  ,A.ActorShortName
  ,AA.LangCode
  ,A.Address
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=1 and ActorID = inst.InstID),'') as teldom
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=2 and ActorID = inst.InstID),'') as telbur
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=3 and ActorID = inst.InstID),'') as telpor
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=4 and ActorID = inst.InstID),'') as fax
  ,isnull((select max(Email) from Actor.ActorEmails where ActorID = inst.InstID),'') as email
  ,A.PostalCode
  ,A.PlaceLabel
  ,A.CountryCode
  ,AA.VatNr
  ,1
  ,AC.CustRistGrpCode
  ,AC.IsIvc as profilfact
  ,''
  ,null
  ,0
  ,''
  ,0
  ,0
  ,0
  ,''  
  ,''
  ,0
  ,''
  ,null
  ,null
  ,0
  ,0
  ,0
  ,''
  ,null
  ,null
  ,null
  ,0
  ,''
  ,null
  ,null
  ,0
  ,0
  ,null
  ,null
  ,0 
  ,substring(AA.memo,1,500)
  ,null
  ,null
  ,null
 from Actor.institutions inst
 inner join Actor.Actors AA on inst.InstID=AA.ActorID
 left join Actor.gv_ActorsAndAdress A on inst.InstID=A.ActorID and A.LangCode='*'
 inner join Actor.Customers AC on inst.InstID=AC.CustID
 where AA.ActStatusType<>'S' and A.ActorShortName is not null
 order by inst.InstID
