select 
couvamo.serialbeneficiaire,
couvamo.serialcouverture,
couvamo.ald,
couvamo.datedebut,
couvamo.datefin,
ass.serialamo
from couverturebeneficiaire couvamo
left join beneficiaire ben on ben.serial = couvamo.serialbeneficiaire
left join assure ass on ben.serialassure = ass.serial