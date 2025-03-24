select
ben.nclient,
ass.nss,
ben.datenaissanceaydrt,
ben.ranggem,
ben.qualite,
ben.no_aydrt,
ben.nom_aydrt,
ben.prenom_aydrt,
ben.adresse,
ben.codepostal,
ben.ville,
ben.telephone,
ben.commentaire,
ben.pointeur_caiss_compl,
ben.noadherent,
ben.datevaliditemutuelle,
ben.datevaliditeald,
ben.typerembt,
ben.datedernierpassage,
ben.datedroitsss,
ben.ald,
ben.codesituationbenef,
ben.identmutuelle,
ben.telephone2,
ass.pointeur_caiss_primaire,
amo.codecentre

from
clientay ben
left join client ass on ass.nclient = ben.nclient
left join caisse amo on amo.ncaisse = ass.pointeur_caiss_primaire