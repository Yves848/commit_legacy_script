select
  personne_id
  assureur,
  matricule,
  datevalidite
from
  assure
where
  assureur = '933'
order by 
  personne_id