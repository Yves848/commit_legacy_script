SELECT A.ArtID
	,A.CnkNr
	,(select ArtName from Article.ArtNames AN1 where AN1.ArtID=A.ArtID and AN1.LangCode='*' and AN1.NameNr=0)
	,(select ArtName from Article.ArtNames AN1 where AN1.ArtID=A.ArtID and AN1.LangCode='N' and AN1.NameNr=0)
	,isnull((select max(BuyPrice) from Article.HistBuyPrices where ArtID = A.ArtID and DateActiveStart=(
		select distinct max(DateActiveStart) from Article.HistBuyPrices  where ArtID = A.ArtID)),0)
	,ISNULL(PubPrice, isnull((select max(PubPrice) from Article.HistArtApbPrices where ArtID = A.ArtID and DateActiveStart=(
		select distinct max(DateActiveStart) from Article.HistArtApbPrices  where ArtID = A.ArtID)),0))
	,ApbCatCode
	,S.DateLastSale
	,(select min(DateExpiry) from Article.ExpDateLotNrs ED where ED.ArtID=A.ArtID)
	,s.QtyInStock
	,S.MinThd
	,S.MaxThd
	,substring(A.memo,1,200)
FROM Article.Articles A
left join Article.Stocks S on S.ArtID=A.ArtID
where S.QtyInStock>0 or S.DateLastSale is not null
order by A.ArtID
