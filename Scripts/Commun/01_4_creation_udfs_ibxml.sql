set sql dialect 3;

/* ********************************************************************************************** */
declare external function f_ouvrir_xml --officinall
  integer,
  cstring(8191)
returns
  integer by value
entry_point 'OuvrirXML' module_name 'ibxml.dll';
 
/* ********************************************************************************************** */
declare external function f_renvoyer_nombre_enfants
  cstring(255)
returns 
  integer by value
entry_point 'RenvoyerNombreEnfants' module_name 'ibxml.dll';

/* ********************************************************************************************** */
declare external function f_renvoyer_valeur_xml --officinall
  cstring(255)
returns 
  cstring(255) free_it
entry_point 'RenvoyerValeurXML' module_name 'ibxml.dll';

/* ********************************************************************************************** */
declare external function f_fermer_xml
returns
  integer by value
entry_point 'FermerXML' module_name 'ibxml.dll';


commit;