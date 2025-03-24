select 
av.no_assure,
av.cip,
av.designation,
av.qte,
av.date_vignet,
av.prix,
av.codeuv, 
coalesce(op.codevendeur,'.' ),
coalesce(prd.codeacteb2,'PHN'),
prd.baseremboursement
from vignavc av
left join prodeco prd on prd.codeuv = av.codeuv
left join vendeur op on op.codevendeur = av.codevendeur