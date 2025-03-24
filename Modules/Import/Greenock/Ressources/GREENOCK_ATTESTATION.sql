SELECT 
  a.AttestID
 ,l.ArtID
 ,PatientID
 ,AttestationNr
 ,DateActiveEnd
 ,ArtReimbCatCode
 ,ReimbExcptCode
 ,AttestationQty
 ,Memo
FROM Actor.Attestations a
left join Actor.AttestArtLinks l on l.AttestId=a.AttestId
where DateActiveEnd>(getdate()-365*2)
order by a.AttestId