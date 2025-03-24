SELECT A.ArtID
	,s.QtyInStock
	,SW.WhLocQty
	,SW.MinThd
	,SW.MaxThd
	,SW.WhId
	,SW.WhLocId
	,(select count(WW.ArtID) from Article.StockWhLocs WW where WW.ArtID = A.ArtID and (WW.WhLocQty>0 or WW.MinThd>0 or WW.MaxThd>0))
FROM Article.Articles A
left join Article.Stocks S on S.ArtID=A.ArtID and S.QtyInStock>0 
left join Article.StockWhLocs SW on A.ArtID=SW.ArtID  and (SW.WhLocQty>0 or SW.MinThd>0 or SW.MaxThd>0) 
where S.ArtID is not null or SW.ArtID is not null
order by A.ArtID
