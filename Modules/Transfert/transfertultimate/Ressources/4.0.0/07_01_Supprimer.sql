 /******************************************************************************/
create or replace package migration.pk_supprimer is

  /****************************************************************************/
  -- mode de création des données
  mode_merge boolean;
 
  -- profil d'édition par défaut
  profiled_defaut number(10);

  -- date système
  date_systeme date;

  -- depot
  depot_pha bel.t_depot.t_depot_id%type;
  depot_res bel.t_depot.t_depot_id%type;


  -- prestation phn
        /* prestation_phn bel.t_prestation.t_prestation_id%type;
  prestation_mx1 bel.t_prestation.t_prestation_id%type; */

  -- tva à 0
  tva_0 bel.t_tva.t_tva_id%type;

  -- device euro et mode de reglement
  devise_euro bel.t_devise.t_devise_id%type;
  modereglement_credit bel.t_modereglement.t_modereglement_id%type;

  -- spécialite 01 (généraliste)
  specialite_gen bel.t_specialite.t_specialite_id%type;

  -- operateur (.), poste de travail (poste0-serveur) et tiroir caisse par défaut
  operateur_point bel.t_operateur.t_operateur_id%type;
  postetravail_poste0 bel.t_postedetravail.t_id_postedetravail%type;
  tiroircaisse_poste0 bel.t_peripherique.t_id_peripherique%type;
 
/* ********************************************************************************************** */
function supprimer_donnees(atypesuppression in integer)
return integer;
 
/* ********************************************************************************************** */
function renvoyer_debut_sequence(asequence in varchar2)
return integer;      

/* ********************************************************************************************** */
 procedure initialiser_sequence(asequence in varchar2,
                                adebut in integer default null);

/* ********************************************************************************************** */
PROCEDURE supprimer_donnees_table(ATable IN varchar2,
                                  ASequence IN varchar2 DEFAULT NULL);
  
/* ********************************************************************************************** */
function initialiser_donnees return integer;
                             
end pk_supprimer;
/ 