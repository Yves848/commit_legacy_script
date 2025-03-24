SELECT 
    Therap.HistMedSchemeItems.MedSchemeItemID,
    Therap.Posos.PosoPeriodicityCode,
    Therap.PosoItems.DayOfWeek,
    Therap.PosoItems.PosoDayPeriodNr
    --Therap.HistMedSchemeItems.DateActiveStart
FROM Therap.HistMedSchemeItems 
INNER JOIN Therap.Posos ON Therap.HistMedSchemeItems.PosoID = Therap.Posos.PosoID 
LEFT OUTER JOIN Therap.PosoItems ON Therap.Posos.PosoID = Therap.PosoItems.PosoID
LEFT JOIN (
    SELECT 
        H.MedSchemeItemID,
        MAX(H.DateActiveStart) AS MaxDateActiveStart
    FROM Therap.HistMedSchemeItems H
    left join Therap.PosoItems ON H.PosoID = Therap.PosoItems.PosoID
    where Therap.PosoItems.PosoDayPeriodNr is not null
    GROUP BY H.MedSchemeItemID
) maxdate ON maxdate.MedSchemeItemID = Therap.HistMedSchemeItems.MedSchemeItemID 
WHERE   Therap.HistMedSchemeItems.DateActiveStart = maxdate.MaxDateActiveStart ;