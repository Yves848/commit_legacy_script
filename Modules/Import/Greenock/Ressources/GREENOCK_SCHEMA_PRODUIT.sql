with tmp_schema as
  (select row_number() over(
       partition by Therap.MedSchemeItems.MedSchemeItemID, Therap.HistMedSchemeItems.DeliveredArtID, Therap.MedSchemeItems.PatientID
	   order by Therap.MedSchemeItems.MedSchemeItemID, Therap.Posos.DateBeginTreat desc) rn,
     Therap.MedSchemeItems.MedSchemeItemID, Therap.HistMedSchemeItems.DeliveredArtID, Therap.MedSchemeItems.PatientID, 
     Therap.Posos.DateBeginTreat,Therap.Posos.DateEndTreat, Therap.Posos.FreePosoText
   FROM Therap.MedSchemeItems   
     INNER JOIN Therap.HistMedSchemeItems ON Therap.MedSchemeItems.MedSchemeItemID = Therap.HistMedSchemeItems.MedSchemeItemID 
     INNER JOIN Therap.Posos ON Therap.HistMedSchemeItems.PosoID = Therap.Posos.PosoID 
   where Therap.Posos.DateBeginTreat is not null and Therap.Posos.DateEndTreat is null)
select 
  tmp_schema.MedSchemeItemID 
 ,tmp_schema.DeliveredArtID
 ,tmp_schema.PatientID
 ,tmp_schema.DateBeginTreat
 ,tmp_schema.DateEndTreat
 ,isnull(substring(tmp_schema.FreePosoText, 1, 200), '')
 ,ArtNames_TSP.ArtName
from tmp_schema
  CROSS JOIN Actor.Pharmacies 
  INNER JOIN Actor.Actors AS Actor_Pharmacies ON Actor_Pharmacies.ActorID = Actor.Pharmacies.PharmID
  INNER JOIN Article.Articles AS Articles_TSP ON Articles_TSP.ArtID = tmp_schema.DeliveredArtID
  INNER JOIN Article.ArtNames AS ArtNames_TSP ON ArtNames_TSP.ArtID = Articles_TSP.ArtID AND 
                                                 ArtNames_TSP.NameNr = 0 AND 
												 ArtNames_TSP.LangCode = Actor_Pharmacies.LangCode 
where rn = 1