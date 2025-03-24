select ArtID,
       right(ArtCodeNr ,13)
from Article.ArtCodes
where ArtCodeNr is not null and ArtCodeNr<>'' 
order by ArtID
