set sql dialect 3;

/* ********************************************************************************************** */
declare external function f_maj_lettre_1 --uniquement dans  be\06_creation_triggers_pha.sql 
  cstring(255)
returns
  cstring(255) free_it
entry_point 'initcap' module_name 'ibstr.dll';
 
/* ********************************************************************************************** */
declare external function f_est_une_date --inutilisé
  cstring(255)
returns
  integer by value
entry_point 'isdate' module_name 'ibstr.dll';

/* ********************************************************************************************** */
declare external function f_est_un_nombre --inutilisé
  cstring(255)
returns
  integer by value
entry_point 'isnumber' module_name 'ibstr.dll';

/* ********************************************************************************************** */
declare external function f_distance_chaine -- utilisé dans FR\05_03_creation_procedures_conversions.sql
  cstring(255),
  cstring(255)
returns
  integer by value
entry_point 'ldistance' module_name 'ibstr.dll';

/* ********************************************************************************************** */
declare external function f_rtf_vers_text -- utilisé dans farmadtwin et nextpharm
  cstring(5000)
returns 
  cstring(5000) free_it
entry_point 'rtftotext' module_name 'ibstr.dll';

commit;