create or replace package migration.pk_supprimer as

  /* ********************************************************************************************** */
  function renvoyer_debut_sequence(ASequence in varchar2)
                                  return integer;
  
  /* ********************************************************************************************** */
  procedure initialiser_sequence(ASequence in varchar2,
                                 ADebut in integer default null);
                                
  /* ********************************************************************************************** */
  function initialiser_donnees return integer;
  
  /* ********************************************************************************************** */
  function supprimer_donnees(ATypeSuppression in integer)
                             return integer;

end; 
/
