select
  personne_id,
  nomtitulaire,
  prenomtitulaire,
  ct1,
  ct2,
  assurabiliteversion,
  sexe,
  sisnumero,
  certificat,
  datelecture,
  assureur,
  matricule,
  datevalidite
from
  assure  a
where
  assureur <> '933'    and PERSONNE_ID>100
order by 
  a.personne_id    , a.datelecture