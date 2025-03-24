Select 
   c.CustRistGrpCode
   ,c.DefaultRistType
   ,cl.CustRistGroupLabel
   ,isnull(r1.RistPercent, r2.RistPercent)
FROM Config.CustRistGroups c
inner join Config.CustRistGroupLabels cl on c.CustRistGrpCode=cl.CustRistGrpCode 
left join config.RistCustRules r1 on r1.ristRuleID = ( select rg1.RistRuleID from Config.RistCustRistGroups rg1 where rg1.CustRistGrpCode=c.CustRistGrpCode and rg1.MarginTypeID = (select m1.MarginTypeID from Config.MarginTypes m1 where m1.MarginMin='0.00'))
left join config.RistCustRules r2 on r2.ristRuleID = ( select rg2.RistRuleID from Config.RistPatRistGroups rg2 where rg2.CustRistGrpCode=c.CustRistGrpCode and rg2.MarginTypeID = (select m2.MarginTypeID from Config.MarginTypes m2 where m2.MarginMin='0.00'))
where c.deleted is null and cl.LangCode='*'   and c.CustRistGrpCode not in ('DEFA', 'DEFP')  
   