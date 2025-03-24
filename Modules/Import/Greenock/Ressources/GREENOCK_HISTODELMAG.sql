select
it.SsecNr
,it.SitmNr
,s.SlsID
,'Préparation Magistrale N°'+mag.MagistralNr
,it.DeliveredQty
,mag.GalformCode
,mag.DtQty
,art.CnkNr
,nam.ArtName
,mit.QtyQualifier
,mit.qtd 
,mit.QtdUnitCode
,mit.memo
from Sales.Magistrals mag
inner join Sales.MagItems mit on mag.MagistralID = mit.MagistralID
inner join Sales.SaleItems it on it.MagistralID = mag.MagistralID
INNER JOIN Sales.SaleSections sec ON sec.SlsID = it.SlsID and sec.SsecNr=it.SsecNr and sec.PatientID is not null 
INNER JOIN Sales.Sales s ON s.SlsID = it.SlsID
left outer join Article.Articles art on (mit.ArtIDSold = art.ArtID )				
left outer join Article.ArtNames nam on (mit.ArtIDSold = nam.ArtID and nam.LangCode = '*' and nam.NameNr = 0)				
where DateSale > getdate()-(365*2) and SitmType= 'MAG'
order by s.SlsID, sec.SsecNr, it.SitmNr, mit.MitmNr







