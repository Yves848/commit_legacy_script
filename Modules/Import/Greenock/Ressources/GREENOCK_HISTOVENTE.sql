SELECT	
      substring(convert(varchar(7),Sales.Sales.DateSale,120),1,7)
     ,Sales.SaleItems.ArtIDSold
	 ,sum(Sales.SaleItems.SaleQty)
     ,count(*)
FROM Sales.Sales INNER JOIN
     Actor.Actors AS Actor_Pharmacy ON Actor_Pharmacy.ActorID = 0 INNER JOIN
     Sales.SaleSections ON Sales.Sales.SlsID = Sales.SaleSections.SlsID INNER JOIN
     Sales.SaleItems ON Sales.SaleSections.SlsID = Sales.SaleItems.SlsID AND Sales.SaleSections.SsecNr = Sales.SaleItems.SsecNr LEFT OUTER JOIN
     Sales.SitmInsrReimbs ON Sales.SaleItems.SlsID = Sales.SitmInsrReimbs.SlsID AND Sales.SaleItems.SsecNr = Sales.SitmInsrReimbs.SsecNr AND Sales.SaleItems.SitmNr = Sales.SitmInsrReimbs.SitmNr LEFT OUTER JOIN
     Sales.Magistrals ON Sales.SaleItems.MagistralID = Sales.Magistrals.MagistralID LEFT OUTER JOIN
     Sales.MagItems ON Sales.Magistrals.MagistralID = Sales.MagItems.MagistralID LEFT OUTER JOIN
     Sales.MitmInsrReimbs ON Sales.MitmInsrReimbs.MagistralID = Sales.MagItems.MagistralID AND Sales.MitmInsrReimbs.MitmNr = Sales.MagItems.MitmNr
WHERE		(Sales.SitmInsrReimbs.SeqNr = 1 OR Sales.SitmInsrReimbs.SeqNr IS NULL) AND
			(Sales.MitmInsrReimbs.SeqNr = 1 OR Sales.MitmInsrReimbs.SeqNr IS NULL) AND
			(Sales.MagItems.MitmNr = (SELECT TOP 1 MitmNr FROM Sales.MagItems WHERE MagistralID = Sales.Magistrals.MagistralID) OR Sales.MagItems.MitmNr IS NULL)
   and Sales.Sales.DateSale > getdate()-(365*2) and Sales.SaleItems.SaleQty>0 and Sales.SaleItems.ArtIDSold is not null
group by Sales.SaleItems.ArtIDSold,substring(convert(varchar(7),Sales.Sales.DateSale,120),1,7)

/*
OU   (si la vue existe)

select 
  substring(convert(varchar(7),DateSale,120),1,7)
 ,ArtIDSold
 ,SUM(SaleQty)
 ,count(*)
from Sales.gv_SaleItems
where DateSale > getdate()-(365*2) and SaleQty>0 and ArtIDSold is not null
group by ArtIDSold,substring(convert(varchar(7),DateSale,120),1,7)

*/
