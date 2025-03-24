SELECT     
  ar.RistCardNr
  ,ar.RcAccountID
  ,convert(decimal(10,2) ,sum(r.AmntRist))
  --,cast(SUBSTRING(cast(r.VatRate as varchar(5)),1,charindex('.',cast(r.VatRate as varchar(5)))-1) as int)
  ,max(r.DatetimeFirst)
FROM Sales.RistCardsRists r 
INNER JOIN Actor.RistCards ar ON r.RistCardNr = ar.RistCardNr 
INNER JOIN Actor.RistCardsAccounts acc ON acc.RcAccountID = ar.RcAccountID 
INNER JOIN Actor.Actors aa ON ar.CustID = aa.ActorID
WHERE     
(r.RistTransactType IN ('A', 'E')) 
AND (r.DatetimeFirst >= ISNULL( (SELECT MAX(RCR.DatetimeFirst) AS Expr1 FROM Sales.RistCardsRists AS RCR INNER JOIN Actor.RistCards AS RC ON RCR.RistCardNr = RC.RistCardNr
     WHERE (RC.RcAccountID = acc.RcAccountID) AND (RCR.RistTransactType = 'B')), '2005-01-01')) 
AND (r.DatetimeFirst >= (SELECT DATEADD(MONTH, - CAST(ISNULL(ParamValue, ParamDefaultValue) AS int), GETDATE()) AS Expr1 FROM Config.Params WHERE (ParamName = 'RistCardNbrMonthValidity')))
GROUP BY ar.RistCardNr, ar.RcAccountID--, cast(SUBSTRING(cast(r.VatRate as varchar(5)),1,charindex('.',cast(r.VatRate as varchar(5)))-1) as int)


