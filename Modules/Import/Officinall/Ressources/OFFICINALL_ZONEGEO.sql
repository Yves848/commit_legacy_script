SELECT lok_Primkey as ZoneGeo_Cle,
       lok_LokatieNaam as ZoneGeo_Nom
FROM Lokatie -- zone geo 
where lok_Primkey<>0

--     ,[lok_DateChanged]
--     ,[lok_UserID]
--     ,[lok_type]
--     ,[lok_TypeLabel]
