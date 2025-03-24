select
ass.nclient,
ass.nom,
ass.prenom,
ass.nss,
ass.ranggem,
ass.qualite,
ass.adresse1,
ass.adresse2,
ass.codepostal,
ass.ville,
ass.telephone,
ass.pointeur_caiss_primaire,
ass.datedenaissance,
ass.date_val_mut,
ass.nadherent,
ass.pointeur_caiss_compl,
ass.commentaire,
ass.datevaliditeald,
ass.ald,
ass.typerembt,
ass.datevaliditerembt,
ass.codesituationbenef,
ass.identmutuelle,
ass.telephone2,
amo.codecentre


from
client ass
left join caisse amo on amo.ncaisse = ass.pointeur_caiss_primaire