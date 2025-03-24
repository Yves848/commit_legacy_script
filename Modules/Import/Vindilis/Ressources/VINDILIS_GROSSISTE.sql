select
  serial,
  libellegrossiste,
  url as url_principal, 
  idf as id_officine, 
  codesecret as cle_secrete, 
  nullif(coderepartiteur, '') as code_pharmaml,
  idrepartiteur as identifiant_magasin
from 
  grossiste