SELECT
  tar_id,
  langue, 
  libelle 
FROM 
  tar15 
WHERE 
  synonyme = '1' and
  langue in ('F', 'N') and libelle is not null
   and trim(libelle) <> ''