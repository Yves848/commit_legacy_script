select 
  'A'+cast(A.ArtID as varchar)
 ,A.ArtID
 ,A.SupplierIDPref
 --,cast(isnull((select 1 from Actor.Suppliers sup where sup.SupplierType='G' and A.SupplierIDPref=sup.SupplierID),0) as int)
 ,isnull((select 1 from Actor.Suppliers sup where sup.SupplierType='G' and A.SupplierIDPref=sup.SupplierID),0)
 ,1
from 
 Article.Articles A
where 
 A.SupplierIDPref is not null

union

select 
  'B'+cast(A.ArtID as varchar)
 ,A.ArtID
 ,A.SupplierIDNextOrder 
 --,cast(isnull((select 1 from Actor.Suppliers sup where sup.SupplierType='G' and A.SupplierIDPref=sup.SupplierID),0) as int)
 ,isnull((select 1 from Actor.Suppliers sup where sup.SupplierType='G' and A.SupplierIDPref=sup.SupplierID),0)
 ,0
from 
 Article.Articles  A
where
 A.SupplierIDNextOrder is not null