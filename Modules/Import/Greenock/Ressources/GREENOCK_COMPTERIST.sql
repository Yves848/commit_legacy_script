  SELECT 
       RcAccountID
      ,CustID
      ,ReleaseType
      ,isnull(ReleaseLimit, (select ParamValue from config.Params where ParamName='RistCardDefaultReleaseLimitQty') )
  FROM Actor.RistCardsAccounts
  where RcAccStatusType=0