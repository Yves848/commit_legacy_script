CREATE OR REPLACE package migration.pk_annexes is

  /* Type et Subtype */
  type tErreur is record(err_code number(10),
                      err_msg varchar2(255));

  /* Variables et constantes */
  CONTACT_ORGANISME constant number := 0;
  CONTACT_DESTINATAIRE constant number := 1;

  erreur tErreur;

  /* Procédures et fonctions */

  FUNCTION EnregistreDepot(ALibelle in bel.t_depot.libelle%TYPE)
                          return bel.t_depot.t_depot_id%TYPE;

  FUNCTION EnregistreContact(ATypeContact in number,
                             AOrganisme in bel.t_contact.t_organisme_id%TYPE,
                             ADestintaire in bel.t_contact.t_destinataire_id%TYPE,
                             ANom in bel.t_contact.nom%TYPE,
                             APrenom in bel.t_contact.prenom%TYPE,
                             AService in bel.t_contact.service%TYPE,
                             ANoTelephone in bel.t_contact.notelephone%TYPE,
                             AEMail in bel.t_contact.email%TYPE)
                            return boolean;

  FUNCTION EnregistreActivite(ALibelle in bel.t_activite.libelle%TYPE,
                              AType in bel.t_activite.type%TYPE)
                             return bel.t_activite.t_activite_id%TYPE;

  FUNCTION isNumeric(x IN VARCHAR2) RETURN NUMBER;
  PROCEDURE MAJPARAMSRIST;
  PROCEDURE CHOIXTYPECARTERIST(idTypeCarte IN VARCHAR2);
  FUNCTION Num_Max_Crist RETURN NUMBER;

end pk_annexes;
/

