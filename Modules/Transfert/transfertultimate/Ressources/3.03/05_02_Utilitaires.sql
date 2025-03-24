CREATE OR REPLACE package body migration.pk_utilitaires as

  -- Exception
		table_not_exist exception;
		sequence_not_exist exception;
		
		pragma exception_init(table_not_exist, -942);
		pragma exception_init(sequence_not_exist, -2289);
		
		-- Types et subtypes
  type t_liste_varchar2_30 is table of varchar2(30);



  FUNCTION CleanVarchar(chainToClean IN VARCHAR2) 
  RETURN VARCHAR2
	AS
		locTmp VARCHAR2(150);
		i INTEGER := 1;
	BEGIN
		locTmp := TRIM(chainToClean);
		locTmp := TRIM(UPPER(TRANSLATE(locTmp,'àäâéèëêïîôöùû_-123456789,()','aaaeeeeiioouu              ')));
		WHILE i < LENGTH(locTmp) LOOP
			IF SUBSTR(locTmp,i,1) = ' ' THEN
				IF (i+1) < LENGTH(locTmp) AND SUBSTR(locTmp,(i+1),1) = ' ' THEN
					locTmp := SUBSTR(locTmp,1,i-1) || SUBSTR(locTmp,i+1,LENGTH(locTmp)-(i+1)+1);
					i := i - 1;
				END IF;	
			END IF;
			i := i + 1;	
		END LOOP;
		Return locTmp;
	END;


	FUNCTION nbWordsInString(string IN VARCHAR2) 
	RETURN INTEGER
	AS
		stringTmp VARCHAR2(150);
		cmpt INTEGER := 1;
		i INTEGER := 1;
	BEGIN
		stringTmp := TRIM(string);
		WHILE i < LENGTH(stringTmp) LOOP
			IF SUBSTR(stringTmp,i,1) = ' ' THEN
				cmpt := cmpt + 1;	
			END IF;
			i := i + 1;	
		END LOOP;
		RETURN cmpt;
	END;


	FUNCTION Split(chainToExplode IN VARCHAR2,separator IN VARCHAR2) 
	RETURN sys.dbms_debug_vc2coll
	AS
		chain VARCHAR2(150);
		tabChains sys.dbms_debug_vc2coll := sys.dbms_debug_vc2coll();
		posSepar INTEGER := 0;
	BEGIN
		chain := TRIM(chainToExplode);
		
		WHILE LENGTH(chain) != 0 LOOP
			posSepar := INSTR(chain,separator);
			
			IF posSepar = 0 THEN
				tabChains.extend;
	  		tabChains(tabChains.COUNT) := chain;
				chain := '';
			ELSE
				tabChains.extend;
	  		tabChains(tabChains.COUNT) := SUBSTR(chain,1,posSepar-1);
				chain := TRIM(SUBSTR(chain,posSepar+1,LENGTH(chain)));
			END IF;	
		END LOOP;
	
		RETURN tabChains;
	END;


	FUNCTION SearchPosOfStringInTable(string IN VARCHAR2,tableRef IN sys.dbms_debug_vc2coll) 
	RETURN sys.dbms_debug_vc2coll
	AS
		chainPos INTEGER := 0;
		tabChains sys.dbms_debug_vc2coll := sys.dbms_debug_vc2coll();
		--tabChains(1): conserve le nbre d'occurences
		--tabChains(j > 1): conserve les positions des occurences trouvées ds le tableau
		
		curs INTEGER := 1;
		
	BEGIN
		tabChains.extend;
	  tabChains(tabChains.COUNT) := 0; --initialise le compteur d'occurences
	  
		WHILE curs < (tableRef.COUNT + 1) LOOP
			chainPos := INSTR(tableRef(curs),string);
			
			--si chainPos!=0 string trouvé à la position curs du tableau
			IF chainPos != 0 THEN 
				tabChains(1) := tabChains(1) + 1; 
				tabChains.extend;
	  		tabChains(tabChains.COUNT) := curs; 		
	  	END IF;
	  		
			curs := curs + 1;	
		END LOOP;
	
		RETURN tabChains;
	END;



	FUNCTION posFoundNbWordsInTable(nbWordsToFound IN INTEGER,wordsToSearch IN sys.dbms_debug_vc2coll,tabVilles IN sys.dbms_debug_vc2coll) 
	RETURN INTEGER
	AS
	  tabWordsForACity sys.dbms_debug_vc2coll := sys.dbms_debug_vc2coll();
	  cmptWordsFound INTEGER := 0;
	BEGIN
	  FOR i IN 1..tabVilles.COUNT LOOP
	      tabWordsForACity := Split(tabVilles(i),' ');
	      IF tabWordsForACity.COUNT > (nbWordsToFound-1) THEN
	         FOR j IN 1..wordsToSearch.COUNT LOOP
	            FOR k IN 1..tabWordsForACity.COUNT LOOP
	                IF wordsToSearch(j) = tabWordsForACity(k) THEN
	                  cmptWordsFound := cmptWordsFound+1;
	                  EXIT;                  
	                END IF;
	            END LOOP;
	            IF cmptWordsFound = nbWordsToFound THEN
	               RETURN i;
	            END IF;
	         END LOOP;
	      END IF;
	      
	      tabWordsForACity.DELETE;
	      cmptWordsFound := 0;
	  END LOOP;
		
		RETURN 0;
	END;





  function ifthen(ACondition in boolean,
                  ATrueValue in varchar2,
                  AFalseValue in varchar2)
                 return varchar2 as
  begin
    if ACondition then
      return ATrueValue;
    else
      return AFalseValue;
				end if;      
  end ifthen;                

  /******************************************/
  /*                LOG                     */
  /******************************************/
  /* Enregistre une erreur dans la table    */
  /* des logs (T_ERREUR)                    */
  /******************************************/
  procedure log(ATypeDonnee in varchar2,
                AMsgStr in varchar2,
                AMsgIDOra in number,
	               AMsgStrOra in varchar2,
		              AImportance in char) as

    pragma autonomous_transaction;

  begin
    insert into t_oraerreur(t_oraerreur_id,
                            typedonnee,
                   	        msgstr,
         			                msgidora,
         			                msgstrora,
         			                importance,
         			                dateheure)
    values(seq_id_oraerreur.nextval,
   	       ATypeDonnee,
   	       AMsgStr,
   	       AMsgIDOra,
   	       AMsgStrOra,
   	       AImportance,
   	       sysdate);

    commit;
  end log;

  /******************************************/
  /*                active_contraintes      */
  /******************************************/
  /* Active ou désactive toutes les clés    */
  /* étrangères d'un schéma		    */
  /******************************************/
  procedure ActiveContraintes(ANomProp in varchar2,
                              AStatut in number) as

    cursor c_ctr is
      select owner, table_name, constraint_name
      from sys.all_constraints
      where upper(owner) = upper(ANomProp)
        and constraint_type = 'R';      
            
    lStrStatutFK varchar2(10);
    OraMsgErreur varchar(255);
    OraIDErreur number(10);
  begin
    if ANomProp is not null then
      if AStatut = STATUT_FK_ACTIVE then
   	    lStrStatutFK := 'enable';
      else
  	     lStrStatutFK := 'disable';
      end if;
  
	     for cr_ctr in c_ctr loop
	       begin
	         execute immediate 'alter table ' || cr_ctr.owner || '.' || cr_ctr.table_name || ' modify constraint ' || cr_ctr.constraint_name || ' ' || lStrStatutFK;        
        exception
          when others then
            OraMsgErreur := sqlerrm;
            OraIDErreur := sqlcode;
          
            log('SYSTEME',  
                cr_ctr.constraint_name,
                OraIDErreur,
                OraMsgErreur,
                1);               
        end;
	     end loop;
    end if;
  end ActiveContraintes;

  /******************************************/
  /*                active_triggers         */
  /******************************************/
  /* Active ou désactive toutes les triggers*/
  /******************************************/
  procedure ActiveTriggers(ANomProp in varchar2,
                           AStatut in number) as

    cursor c_tbl is
      select owner, table_name
      from sys.all_tables
      where upper(owner) = upper(ANomProp);
          
    lStrStatutTR varchar2(30);
    OraMsgErreur varchar(255);
    OraIDErreur number(10);
  begin
    if ANomProp is not null then
      if AStatut = STATUT_TR_ACTIVE then
	       lStrStatutTR := 'enable all triggers';
      else
	       lStrStatutTR := 'disable all triggers';
      end if;
      
      for cr_tbl in c_tbl loop
        begin
          execute immediate 'alter table ' || cr_tbl.owner || '.' || cr_tbl.table_name|| ' ' || lStrStatutTR;
        exception
          when others then
            OraMsgErreur := sqlerrm;
            OraIDErreur := sqlcode;
          
            log('SYSTEME',  
                cr_tbl.table_name,
                OraIDErreur,
                OraMsgErreur,
                1);               
        end;
      end loop;
    end if;
  end ActiveTriggers;

  /******************************************/
  /*                RAZ_TABLES              */
  /******************************************/
  /* Permet de vider une table et de        */
  /* recréer sa sequence en l'initialisant  */
  /******************************************/
  procedure RAZTable(ANomTable in varchar2 default '',
                     ANomSequence in varchar2 default '',
                     ADebutSequence in number default 1,
                     ALogCategorie in varchar2 default null) as

    lIntCode number(10); lStrMsg varchar(255);
          
  begin    
    -- Effacement de la table
    begin
      if ANomTable is not null then
        if CompterNombreLignes(ANomTable) <> 0 then
          execute immediate 'truncate table ' || ANomTable;
        end if;
      end if;
    exception
      when table_not_exist then
        log('SUPPRESSION_' || ALogCategorie,
            ALogCategorie,
            -942,
            ANomTable || ' : table or view does not exist',
            0);
    end;

    -- Re-création de la sequence
    begin
      if (ANomSequence is not null) then
        execute immediate 'drop sequence ' ||	 ANomSequence;
        execute immediate 'create sequence ' || ANomSequence || ' start with ' || ADebutSequence || ' nocache';
      end if;
    exception
      when sequence_not_exist then
        log('SUPPRESSION_' || ALogCategorie,
            ALogCategorie,
            -2289,
            ANomSequence ||' : sequence does not exist',
            0);       
    end;
  end RAZTable;

  


  /******************************************/
  /*              FILTRECHAINE		        */
  /******************************************/
  /* Filtre une chaine de caractères suivant*/
  /* un filtre (alpha/numérique/tous carac. */
  /******************************************/
  function FiltreChaine(AChaine in varchar2,
                        AFiltre in number default FILTRE_TOUT,
			                     ACaractereSub in varchar2 default '')
                       return varchar2 as

    i number(5);
    lIntLen number(5) := length(AChaine);
    lIntCaractere number(3);
    lStrChaineFiltree varchar2(255) := '';
  
  begin
    if (lIntLen <> 0) or (lIntLen is not null) then
      -- FILTRE_TOUT
      if AFiltre = FILTRE_TOUT then
	       for i in 1..lIntLen loop
	         lIntCaractere := ascii(substr(AChaine, i, 1));
     	    if (lIntCaractere > 31) and (lIntCaractere < 128) then
	           -- OK
	           lStrChaineFiltree := lStrChaineFiltree || chr(lIntCaractere);
	         else
	           -- Mauvais => Remplacement du caractère
	           lStrChaineFiltree := lStrChaineFiltree || ACaractereSub;
	         end if;
	       end loop;
      end if;

      -- FILTRE_ALPHA
      if AFiltre = FILTRE_ALPHA then
	       for i in 1..lIntLen loop
	         lIntCaractere := ascii(substr(AChaine, i, 1));
     	    if ((lIntCaractere > 47) and (lIntCaractere < 58)) or
   	         ((lIntCaractere > 96) and (lIntCaractere < 123)) or
	            ((lIntCaractere > 64) and (lIntCaractere < 91)) then
	           -- OK
 	          lStrChaineFiltree := lStrChaineFiltree || chr(lIntCaractere);
	         else
	           -- Mauvais => Remplacement du caractère
	           lStrChaineFiltree := lStrChaineFiltree || ACaractereSub;
	         end if;
	       end loop;
      end if;

      -- FILTRE_NUM
      if AFiltre = FILTRE_NUM then
	       for i in 1..lIntLen loop
	         lIntCaractere := ascii(substr(AChaine, i, 1));
  	       if (lIntCaractere > 47) and (lIntCaractere < 58) then
	           -- OK
	           lStrChaineFiltree := lStrChaineFiltree || chr(lIntCaractere);
	         else
	           -- Mauvais => Remplacement du caractère
	           lStrChaineFiltree := lStrChaineFiltree || ACaractereSub;
	         end if;
        end loop;
      end if;
    end if;

    return lStrChaineFiltree;
  end FiltreChaine;

  function AccesSequence(ATypeAcces in number,
		                       AOwner in varchar2,
		                       ANomSequence in varchar2,
																									ADebutSequence in number default 1)
                        return number as
    
    lIntCount number(10);
    
  begin
    -- Lecture
				if ATypeAcces = ACCES_SEQ_LECTURE then
  				if ANomSequence is not null then
        execute immediate 'select last_number - increment_by from all_sequences where lower(sequence_owner) = lower(' || '''' || lower(Aowner) || ''')' || 
				  		                                                                         'and lower(sequence_name) = lower(' || '''' || ANomSequence || ''')' into lIntCount;
        return lIntCount;
      else    
       return 0;
      end if;
				end if;
				
				-- Ecriture
				if ATypeAcces = ACCES_SEQ_ECRITURE then
				  RAZTable(ANomSequence => Aowner || '.' || ANomSequence, ADebutSequence => ADebutSequence + 1);
						return 0;				
				end if;
  end AccesSequence;

  function CompterNombreLignes(ANomTable in varchar2)
                              return number as
    
    lIntCount number(10);
    
  begin
    if ANomTable is not null then
      execute immediate 'select count(*) from ' || ANomTable into lIntCount;
      return lIntCount;
    else    
     return 0;
    end if;
  end CompterNombreLignes;
  
end pk_utilitaires;
/
