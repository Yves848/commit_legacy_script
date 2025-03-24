 Select
   sup.SupplierID
  ,AA.ActorName
  ,A.Address
  ,A.PlaceLabel
  ,A.PostalCode
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=1 and ActorID = sup.SupplierID),'') as teldom
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=2 and ActorID = sup.SupplierID),'') as telbur
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=3 and ActorID = sup.SupplierID),'') as telpor
  ,isnull((select PhoneNr from Actor.ActorPhones where PhoneTypeID=4 and ActorID = sup.SupplierID),'') as fax
  ,isnull((select max(Email) from Actor.ActorEmails where ActorID = sup.SupplierID),'') as email
  ,sup.Rs232Stopbits
  ,sup.LabApbCode
 from Actor.Suppliers sup
 inner join Actor.Actors AA on sup.SupplierID=AA.ActorID
 left join Actor.gv_ActorsAndAdress A on sup.SupplierID=A.ActorID and (A.LangCode='*' or A.LangCode=null)
 where AA.ActStatusType<>'S' and AA.ActorShortName<>'' and sup.SupplierType='L'
 order by sup.SupplierID
 
