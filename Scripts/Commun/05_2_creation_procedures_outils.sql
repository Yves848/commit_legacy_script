set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_conv_chaine_en_date_format(
  AChaine varchar(10),
  AFormat varchar(8))
returns(
  ADate date)
as
begin
  begin
    ADate = cast(AChaine as date);   
  when any do
    ADate = null;
  end

  if (ADate is null) then
   ADate = Case 
             when (AChaine='') then null
             when ((octet_length(AChaine) <> 8) or 
			       (AChaine not similar to '[[:DIGIT:]]*') or
			       (((AFormat ='YYYYMMDD') or (AFormat='AAAAMMJJ')) and 
				    (substring(AChaine from 5 for 2)='00' or substring(AChaine from 7 for 2)='00')) or
                   (((AFormat ='DDMMYYYY') or (AFormat='JJMMAAAA')) and 
				    (substring(AChaine from 3 for 2)='00' or substring(AChaine from 7 for 2)='00'))) then null              
             when ((AFormat ='YYYYMMDD') or (AFormat='AAAAMMJJ')) then cast(substring(AChaine from 1 for 4) || '-' || substring(AChaine from 5 for 2) || '-' || substring(AChaine from 7 for 2) as date)              
             when ((AFormat ='DDMMYYYY') or (AFormat='JJMMAAAA')) then cast(substring(AChaine from 5 for 4) || '-' || substring(AChaine from 3 for 2) || '-' || substring(AChaine from 1 for 2) as date)              
             else null
           end;
end;                

/* ********************************************************************************************** */
create or alter procedure ps_convertir_chaine_en_float( AChaine varchar(5000))
returns( AFloat float)
as
begin
	AFloat = cast(trim(AChaine) as float);
	When any do
		AFloat = 0;
end;

/* ********************************************************************************************** */
create or alter procedure ps_filtrer_numerique(
  AChaine varchar(255))
returns(
  AChaineFiltree varchar(255))
as
declare variable i integer;
declare variable intTailleChaine integer;
declare variable c char(1);
begin
  AChaineFiltree = ''; i = 1; intTailleChaine = char_length(AChaine);
  while (i <= intTailleChaine) do
  begin
    c = substring(AChaine from i for 1);
    if (c in ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')) then
      AChaineFiltree = AChaineFiltree || c;
    i = i + 1;
  end
  AChaineFiltree = TRIM(AChaineFiltree); 
end;

/* ********************************************************************************************** */
create or alter procedure ps_separer_nom_prenom(
    ANomPrenom varchar(100),
	  ASeparateurNP varchar(5))
returns(
    ANom varchar(100),
    APrenom varchar(100),
    ANomJeuneFille varchar(100))
as
declare variable intPos integer;
declare variable l integer;
declare variable prenom varchar(50);
begin
  ANomPrenom = trim(ANomPrenom);
  for select prenom 
      from t_ref_prenom_compose
      into :prenom do
        ANomPrenom = replace(ANomPrenom, upper(' '||:prenom||' '),upper(' '||:prenom||'-')  );

  -- Gestion du nom de jeune fille incoroporee
  intpos = position(' NEE ' in upper(ANomPrenom));
  if (intpos > 0) then
  begin
    ANom = substring(ANomPrenom from 1 for intPos - 1);    
    execute procedure ps_separer_nom_prenom(substring(ANomPrenom from intPos + 5 for 100), ASeparateurNP) returning_values :ANomJeuneFille, :APrenom, :prenom;
  end
  else
  begin
    ANomJeuneFille  = null;  
    -- ne pas tenir compte des 3 premiers caracteres, chercher le separateur a partir du 4 eme 
    -- pour eviter les noms "LE NOM" "DU NOM" "LA NOM" ... soit séparés si pas de prénom
    intPos = position(ASeparateurNP, ANomPrenom, 4);
    if (intPos > 0) then
    begin
	    l = char_length(ASeparateurNP);
      ANom = substring(ANomPrenom from 1 for intPos - l);
      APrenom = trim(substring(ANomPrenom from intPos + l for 20));
      if (APrenom = '') then
        APrenom = '_';

      -- Gestion d'une particule
      if (ASeparateurNP = ' ') then
  	  begin
  		  intPos = position(' ' in APrenom);
    		  if (intPos > 0) then
    		  begin
      			ANom = ANom || ' ' || substring(APrenom from 1 for intPos - 1);
      			APrenom = substring(APrenom from intPos + 1 for 20);
    		  end
  	  end
    end
    else
    begin
      ANom = trim(ANomPrenom);
      APrenom = '_';
    end
  end
end;

create or alter procedure ps_separer_valeurs(
  AValeurs varchar(5000),
  ASeparateur varchar(20))
returns(
  AValeur varchar(5000))
as
declare variable p integer;
declare variable s varchar(5000);
begin
  s = AValeurs;
  p = position(ASeparateur in s);
  while (p > 0) do
  begin
    AValeur = substring(s from 1 for p - 1);
    suspend;

    s = substring(s from p + char_length(ASeparateur) for char_length(s));
    p = position(ASeparateur in s);
  end

  AValeur = s;
  suspend;
end;