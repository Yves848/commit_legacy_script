set sql dialect 3;

/******************************************************************************/
declare external function f_supprimer_fichier
  cstring(255)
returns
  integer by value
entry_point 'supprimerfichier' module_name 'ibfichier';

/******************************************************************************/
declare external function f_fichier_existant -- transfert lgpi
  cstring(255)
returns
  integer by value
entry_point 'fichierexistant' module_name 'ibfichier';

/******************************************************************************/
declare external function f_extraire_chemin
  cstring(255)
returns
  cstring(255) free_it
entry_point 'extrairechemin' module_name 'ibfichier';

declare external function f_extraire_fichier
  cstring(255)
returns
  cstring(255) free_it
entry_point 'extrairefichier' module_name 'ibfichier';

/******************************************************************************/
declare external function f_renvoyer_date_fichier
  cstring(255),
  timestamp
returns 
  parameter 2
entry_point 'renvoyerdatefichier' module_name 'ibfichier';

/******************************************************************************/
declare external function f_ouvrir_fichier_texte
  cstring(255)
returns 
  integer by value
entry_point 'ouvrirfichiertexte' module_name 'ibfichier';

/******************************************************************************/
declare external function f_creer_fichier_texte
  cstring(255)
returns 
  integer by value
entry_point 'creerfichiertexte' module_name 'ibfichier';

/******************************************************************************/
declare external function f_lire_fichier_texte
  integer
returns
  cstring(2048) free_it
entry_point 'lirefichiertexte' module_name 'ibfichier';

/******************************************************************************/
declare external function f_ecrire_fichier_texte
  integer,
  cstring(5000)
returns
  integer by value
entry_point 'ecrirefichiertexte' module_name 'ibfichier';

/******************************************************************************/
declare external function f_fermer_fichier
  integer
returns
  integer by value
entry_point 'fermerfichier' module_name 'ibfichier';

declare external function f_renommer_fichier
  cstring(255),
  cstring(255)
returns
  integer by value
entry_point 'renommerfichier' module_name 'ibfichier';

commit;