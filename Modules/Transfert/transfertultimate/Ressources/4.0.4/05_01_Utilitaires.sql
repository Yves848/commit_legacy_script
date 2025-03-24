CREATE OR REPLACE package migration.pk_utilitaires is

  -- Acces sequence
		ACCES_SEQ_LECTURE constant number := 0;
		ACCES_SEQ_ECRITURE constant number := 1;
		
  -- Constantes de filtre
  FILTRE_TOUT constant number := 0;  -- filtre sur les caractères #32 à #127
  FILTRE_ALPHA constant number := 1; -- filtre sur les caractères 0-9, a-z, A-Z
  FILTRE_NUM constant number := 2;   -- filtre sur les caractères 0-9

  STATUT_FK_ACTIVE constant number := 0;    -- ForeignKey activé
  STATUT_FK_DESACTIVE constant number := 1; -- ForeignKey desactivé

  STATUT_TR_ACTIVE constant number := 0;    -- Trigger activé
  STATUT_TR_DESACTIVE constant number := 1; -- Trigger desactivé


  -- Fonction et Procédures
  
  FUNCTION CleanVarchar(chainToClean IN VARCHAR2) 
  RETURN VARCHAR2;
  
  FUNCTION nbWordsInString(string IN VARCHAR2) 
	RETURN INTEGER;
	
	FUNCTION Split(chainToExplode IN VARCHAR2,separator IN VARCHAR2) 
	RETURN sys.dbms_debug_vc2coll;
	
	FUNCTION SearchPosOfStringInTable(string IN VARCHAR2,tableRef IN sys.dbms_debug_vc2coll) 
	RETURN sys.dbms_debug_vc2coll;
	
	FUNCTION posFoundNbWordsInTable(nbWordsToFound IN INTEGER,wordsToSearch IN sys.dbms_debug_vc2coll,tabVilles IN sys.dbms_debug_vc2coll) 
	RETURN INTEGER;
  
  function ifthen(ACondition in boolean,
                  ATrueValue in varchar2,
                  AFalseValue in varchar2)
                 return varchar2;
                 
  procedure log(ATypeDonnee in varchar2,
                AMsgStr in varchar2,
                AMsgIDOra in number,
      		        AMsgStrOra in varchar2,
      		        AImportance in char);

  procedure ActiveContraintes(ANomProp in varchar2,
      		                      AStatut in number);

  procedure ActiveTriggers(ANomProp in varchar2,
		                         AStatut in number);

  procedure RAZTable(ANomTable in varchar2 default '',
                     ANomSequence in varchar2 default '',
                     ADebutSequence in number default 1,
                     ALogCategorie in varchar2 default null);

  function FiltreChaine(AChaine in varchar2,
		                      AFiltre in number default FILTRE_TOUT,
			                     ACaractereSub in varchar2 default '')
                       return varchar2;

  function CompterNombreLignes(ANomTable in varchar2)
                              return number;

  function AccesSequence(ATypeAcces in number,
		                    Aowner in varchar2,
		                    ANomSequence in varchar2,
							ADebutSequence in number default 1)
                        return number;
                       
end pk_utilitaires;
/
