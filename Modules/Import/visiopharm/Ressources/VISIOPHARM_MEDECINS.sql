select
m.nmedecin,
m.nom, 
m.code, 
m.rue, 
m.codepostal,
m.ville,
m.telephone,
m.fax, 
m.commentaire,
s.codespecialite,
m.email, 
m.rpps
from medecin m
left join specmed s on m.nspecialite= s.nspecialite
