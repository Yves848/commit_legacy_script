set sql dialect 3;

/* ********************************************************************************************** */
recreate view v_fichier(
  t_fct_fichier_id,
  nom,
  type_fichier,
  libelle,
  grille,
  ligne)
as
select t_fct_fichier_id,
       nom,
       type_fichier,
       libelle,
       grille,
       ligne
from t_fct_fichier
order by nom;

recreate view v_traitement_1 as select * from v_fichier where type_fichier like '1%';
recreate view v_traitement_2 as select * from v_fichier where type_fichier like '2%';

/* ********************************************************************************************** */
recreate view v_erreur(t_fct_fichier_id,
                       message_erreur_sql,
                       nb_occurrences)
as
select t_fct_fichier_id,
       message_erreur_sql,
       count(*)
from t_fct_erreur
group by t_fct_fichier_id,
         message_erreur_sql;
         
/* ********************************************************************************************** */
recreate view v_astuce(
  message,
  type_astuce)
as
select message,
	   case 
	     when type_astuce = 1 then 'Astuce pour l''import'
	     when type_astuce = 2 then 'Astuce générale'
	     when type_astuce = 3 then 'Astuce pour le transfert'
	   end
from t_fct_astuce;
	   
/* ********************************************************************************************** */
recreate view v_donnees(
  t_fct_fichier_id,
  message_erreur_sql,
  donnees,
  instruction)
as
select
  t_fct_fichier_id,
  message_erreur_sql,
  donnees,
  instruction
from t_fct_erreur;