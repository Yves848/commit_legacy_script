SELECT
       r.RistCardNr
      ,max(r.RcAccountID)
      ,max(r.CustID)
      ,max(r.DateIssued)
  FROM Actor.RistCards r
  inner join Actor.RistCardsAccounts acc on r.RcAccountID=acc.RcAccountID and acc.RcAccStatusType=0
  where RcStatusType=0
  group by RistCardNr
  
  
