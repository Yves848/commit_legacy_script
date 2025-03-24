  select 
    AA.ActorID
   ,AA.ActorName
   ,isnull(P.FirstName,' ')
   ,case isnumeric(P.InamirizvNr) when 1 then P.InamirizvNr else null end
   ,case isnumeric(P.PresbSpecCode) when 1 then P.PresbSpecCode else null end
   ,isnull((select max(Email) from Actor.ActorEmails where ActorID = P.PrescriberID),'') as email
   ,isnull((select max(PhoneNr) from Actor.ActorPhones where PhoneTypeID=4 and ActorID = P.PrescriberID),'') as fax
   ,A.PlaceLabel
   ,A.PostalCode
   ,A.CountryCode
   ,isnull((select max(PhoneNr) from Actor.ActorPhones where PhoneTypeID=1 and ActorID = P.PrescriberID),'') as teldom
   ,isnull((select max(PhoneNr) from Actor.ActorPhones where PhoneTypeID=2 and ActorID = P.PrescriberID),'') as telbur
   ,isnull((select max(PhoneNr) from Actor.ActorPhones where PhoneTypeID=3 and ActorID = P.PrescriberID),'') as telpor
   ,A.Address
   ,P.PresbProfCode   
   ,substring(AA.memo,1,200)
 from Actor.Prescribers P
 inner join Actor.Actors AA on P.PrescriberID=AA.ActorID
 left join Actor.gv_ActorsAndAdress A on P.PrescriberID=A.ActorID and (A.LangCode='*' or A.LangCode=null)
 where AA.ActStatusType<>'S' and AA.ActorName<>'' 
 order by P.PrescriberID