select
  it.SsecNr
 ,it.SitmNr
 ,s.SlsID
 ,A.CnkNr
 ,(select ArtName from Article.ArtNames AN1 where AN1.ArtID=A.ArtID and AN1.LangCode='*' and AN1.NameNr=0)
 ,it.PayableQty
 ,it.PubPricePerUnit
 ,it.ArtIDSold
from Sales.SaleItems it
INNER JOIN Sales.SaleSections sec ON sec.SlsID = it.SlsID and sec.SsecNr=it.SsecNr and sec.PatientID is not null 
INNER JOIN Sales.Sales s ON s.SlsID = it.SlsID
LEFT JOIN Article.Articles A ON A.ArtID = it.ArtIDSold
where DateSale > getdate()-(365*2) and SitmType in ('ART','ACT')
order by s.SlsID
