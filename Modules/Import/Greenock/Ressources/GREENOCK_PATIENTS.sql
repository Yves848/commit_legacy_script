Select 
   pat.patientID
  ,AA.ActorShortName
  ,AA.LangCode
  ,A.Address
  ,isnull((select min(PhoneNr) from Actor.ActorPhones where PhoneTypeID=1 and ActorID = pat.patientID),'') as teldom
  ,isnull((select min(PhoneNr) from Actor.ActorPhones where PhoneTypeID=2 and ActorID = pat.patientID),'') as telbur
  ,isnull((select min(PhoneNr) from Actor.ActorPhones where PhoneTypeID=3 and ActorID = pat.patientID),'') as telpor
  ,isnull((select min(PhoneNr) from Actor.ActorPhones where PhoneTypeID=4 and ActorID = pat.patientID),'') as fax
  ,isnull((select max(Email) from Actor.ActorEmails where ActorID = pat.patientID),'') as email
  ,A.PostalCode
  ,A.PlaceLabel
  ,A.CountryCode
  ,AA.VatNr
  ,0
  ,AC.CustRistGrpCode
  ,AC.IsIvc
  ,pat.FirstName
  ,pat.DateBirth
  ,pat.InstID
  ,pat.NissinszNr
  ,pat.F704PrintType
  ,pat.CblPrintType
  ,pat.BvacPrintType
  ,pat.RoomNr
  ,AA.GenderCode
  ,(select OA1.FedNr from Actor.Oavi OA1 where OA.OaviID=OA1.OaviID)
  ,OA.RegistrationNr
  ,OA.DateActiveStart
  ,OA.DateValidityEnd
  ,case isnumeric(OA.CgctCt1Cpy) when 1 then OA.CgctCt1Cpy else null end
  ,case isnumeric(OA.CgctCt2Cpy) when 1 then OA.CgctCt2Cpy else null end
  ,(select OC1.FedNr from Actor.Oavi OC1 where OC.OaviID=OC1.OaviID)
  ,OC.RegistrationNr
  ,OC.OaviCode
  ,OC.DateActiveStart
  ,OC.DateActiveEnd
  ,(select AT1.FedNr from Actor.Oavi AT1 where AT.OaviID=AT1.OaviID)
  ,AT.RegistrationNr
  ,AT.DateActiveStart
  ,AT.DateActiveEnd
  ,OA.OaviVersion
  ,case isnumeric(OA.SisCardNr) when 1 then OA.SisCardNr else null end
  ,sis.DateTimeSisRead
  ,sis.SisCertificate
  ,OA.HasSisAttestation
  ,substring(AA.memo,1,500)
  ,pat.DateDeath
  ,pat.PatientIDHeadfam
  ,cast(pat.IsRefPharmacist as int)	
 from Actor.Patients pat
 inner join Actor.Actors AA on pat.patientID=AA.ActorID
 left join Actor.gv_ActorsAndAdress A on pat.patientID=A.ActorID and (A.LangCode='*' or A.LangCode=null)
 inner join Actor.Customers AC on pat.patientID=AC.CustID
 left join Actor.InsrCovers OA on  OA.InsrCoverID in (
           select max(CC1.InsrCoverID) from Actor.InsrCovers CC1 where pat.patientID=CC1.PatientID 
           and (CC1.OaviCode='CP' OR CC1.OaviCode='GR' OR CC1.OaviCode='IG' OR CC1.OaviCode='IN' OR CC1.OaviCode='OS' OR CC1.OaviCode='SN')
           group by CC1.PatientID)   
 left join Actor.InsrCovers OC on OC.InsrCoverID in (
           select max(CC2.InsrCoverID) from Actor.InsrCovers CC2 where pat.patientID=CC2.PatientID 
           and (CC2.OaviCode='CP' OR CC2.OaviCode='PF' OR CC2.OaviCode='SM') 
           group by CC2.PatientID)    
 left join Actor.InsrCovers AT on AT.InsrCoverID in (
           select max(CC3.InsrCoverID) from Actor.InsrCovers CC3 where pat.patientID=CC3.PatientID 
           and CC3.OaviCode='AT' 
           group by CC3.PatientID)  
 left join Actor.HistSisInfo sis on sis.InsrCoverID=oa.InsrCoverID and sis.DateQuarterStart in 
           (select max(sis2.DateQuarterStart) from Actor.HistSisInfo sis2 where sis2.InsrCoverID = sis.InsrCoverID)
 where AA.ActStatusType<>'S' and AA.ActorShortName<>''
 order by pat.patientID
 