set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_verifier_fichiers(
  ARepertoire varchar(255))
returns(
  AFichier varchar(255),
  ADateHeure timestamp,
  ATypeFichier char(2),
  ARequis char(1),
  AValidationAbsence char(1),
  APresence char(1),
  ACommentaire varchar(200))
as
begin
  for select type_fichier,
             nom,
             f_renvoyer_date_fichier(:ARepertoire || nom),
             requis,
             validation_absence,
             commentaire
      from t_fct_fichier
      where type_fichier in ('10', '11')
      into :ATypeFichier,
           :AFichier,
           :ADateHeure,
           :ARequis,
           :AValidationAbsence,
           :ACommentaire do
  begin
    APresence = f_fichier_existant(ARepertoire || AFichier);
    if (APresence = '1') then
    begin
      if (AValidationAbsence = '1') then
      begin
        update t_fct_fichier
        set validation_absence = '0'
        where type_fichier = '1'
          and nom = :AFichier;

        AValidationAbsence = '0';
      end
    end
    else
      ADateHeure = null;

    suspend;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_valider_absence_fichier(
  ATypeFichier char(2),
  AFichier varchar(255),
  AValidationAbsence char(1))
as
begin
  update t_fct_fichier
  set validation_absence = :AValidationAbsence
  where type_fichier = :ATypeFichier
    and nom = :AFichier;
end;

/* ********************************************************************************************** */
create or alter procedure ps_erreur(
  ATypeErreur char(1),
  AFichier varchar(255),
  AMessageErreurSQL varchar(1000),
  ACodeErreurSQL integer,
  AImportance char(1),
  ADonnees blob sub_type text,
  AInstruction blob sub_type text)
as
declare variable lIntFichierID integer;
begin
  select t_fct_fichier_id
  from t_fct_fichier
  where lower(nom) = lower(:AFichier)
    and type_fichier like (:ATypeErreur || '2')
  into lIntFichierID;

  if (row_count = 0) then
  begin
    select t_fct_fichier_id
    from t_fct_fichier
    where lower(nom) = lower(:AFichier)
      and type_fichier like (:ATypeErreur || '1')
    into lIntFichierID;
    
    if (row_count = 0) then
      lIntFichierID = null;
  end

  insert into t_fct_erreur(t_fct_erreur_id,
                           type_erreur,
                           t_fct_fichier_id,
                           message_erreur_sql,
                           code_erreur_sql,
                           importance,
                           donnees,
                           instruction)
  values(gen_id(seq_fct_erreur, 1),
         :ATypeErreur,
         :lIntFichierID,
         :AMessageErreurSQL,
         :ACodeErreurSQL,
         :AImportance,
         :ADonnees,
         :AInstruction);
end;

/* ********************************************************************************************** */
create or alter procedure ps_exporter_erreurs(
  ATable varchar(255),
  ARepertoire varchar(255))
as
declare variable f integer;
declare variable l integer;
declare variable nb integer;
declare variable i integer;
declare variable intC integer;
declare variable pd integer;
declare variable pf integer;
declare variable chC char(1);
declare variable s1 varchar(5100);
declare variable s2 varchar(5100);
declare variable intNomFichier integer;
declare variable strMessErr varchar(1000);
declare variable intNbOcc integer;
begin
  f = f_creer_fichier_texte(ARepertoire || ATable || '.erreurs.xml');
  
  if (f > 0) then
  begin
    -- Entete  
    f_ecrire_fichier_texte(f, '<?xml-stylesheet type="text/xsl" href="' || ATable || '.erreurs.xml' ||  '" encoding="UTF-8"?>');
    f_ecrire_fichier_texte(f, '<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">');
    f_ecrire_fichier_texte(f, '  <xsl:variable name="doc">');
    f_ecrire_fichier_texte(f, '    <log>');
    f_ecrire_fichier_texte(f, '      <titre>' || 'Compte-rendu des erreurs du fichier ' || ATable || '</titre>');
    f_ecrire_fichier_texte(f, '      <erreurs>');
    
    -- Contenu
    for select f.t_fct_fichier_id,
               e.message_erreur_sql,
               count(*)
        from t_fct_erreur e 
             inner join t_fct_fichier f on (f.t_fct_fichier_id = e.t_fct_fichier_id)
        where f.nom = :ATable
        group by f.t_fct_fichier_id,
                 e.message_erreur_sql
        into :intNomFichier,
             :strMessErr,
             :intNbOcc do
    
    begin
      f_ecrire_fichier_texte(f, '    <erreur>');      
      f_ecrire_fichier_texte(f, '      <libelle>' || strMessErr || '</libelle>');
      f_ecrire_fichier_texte(f, '      <occurence> (' || intNbOcc || ' fois)</occurence>');      
      
      
      nb = 1;
      for select donnees
          from t_fct_erreur
          where t_fct_fichier_id = :intNomFichier
            and message_erreur_sql = :strMessErr
          into s1 do
      begin
        s2 = ''; i = 1; l = char_length(s1);
        while (i <= l) do
        begin
          chC = substring(s1 from i for 1);
          begin
            intC = ascii_val(chC);
            if ((((intC < 32) or (intC > 126)) and (intC <> 13) and (intC <> 10))) then
              chC = ' ';     
              
            when any do
              chC = ' ';          
          end
          s2 = s2 || chC;
          i = i + 1;
        end
        
        if (nb = 1) then
        begin
          s1 = s2;
          f_ecrire_fichier_texte(f, '        <entetes>');
          
          pd = position('<donnee nom="' in s1);
          while (pd > 0) do
          begin
            pd = pd + 13;
            pf = position('"', s1, pd);
            
            f_ecrire_fichier_texte(f, '          <entete>' || substring(s1 from pd for pf - pd) || '</entete>');
            
            s1 = substring(s1 from pf + 1 for 5100);
            pd = position('<donnee nom="' in s1);
          end
          nb = 0;
          f_ecrire_fichier_texte(f, '        </entetes>');          
        end
        
        f_ecrire_fichier_texte(f, '        <donnees>' || s2 || '</donnees>');
      end
      f_ecrire_fichier_texte(f, '    </erreur>');           
    end
    
    --Fin
    f_ecrire_fichier_texte(f, '      </erreurs>');
    f_ecrire_fichier_texte(f, '    </log>');
    f_ecrire_fichier_texte(f, '  </xsl:variable>');
    f_ecrire_fichier_texte(f, '  <xsl:template match="log">');
    f_ecrire_fichier_texte(f, '    <html>');
    f_ecrire_fichier_texte(f, '      <head>');
    f_ecrire_fichier_texte(f, '        <title><xsl:value-of select="titre"/></title>');
    f_ecrire_fichier_texte(f, '        <link href="export_erreurs.css" rel="stylesheet" type="text/css"/>');
    f_ecrire_fichier_texte(f, '      </head>');
    f_ecrire_fichier_texte(f, '      <body>');
    f_ecrire_fichier_texte(f, '        <br/>');
    f_ecrire_fichier_texte(f, '        <table align="center" border="1" width="33%" height="50" margin-right="33%" margin-left="33%">');
    f_ecrire_fichier_texte(f, '          <tr><td align="center"><b><font size="5"><xsl:value-of select="titre"/></font></b></td></tr>');
    f_ecrire_fichier_texte(f, '        </table>');
    f_ecrire_fichier_texte(f, '        <br/><br/>');
    f_ecrire_fichier_texte(f, '        <ul>');
    f_ecrire_fichier_texte(f, '          <xsl:for-each select="erreurs/erreur">');
    f_ecrire_fichier_texte(f, '            <li><xsl:value-of select="libelle"/><xsl:value-of select="occurence"/></li> ');
    f_ecrire_fichier_texte(f, '            <br/>');
    f_ecrire_fichier_texte(f, '            <br/>');
    f_ecrire_fichier_texte(f, '            <table border="1">');
    f_ecrire_fichier_texte(f, '              <tr>');
    f_ecrire_fichier_texte(f, '                <xsl:for-each select="entetes/entete">');
    f_ecrire_fichier_texte(f, '                  <th><xsl:value-of select="."/></th>');
    f_ecrire_fichier_texte(f, '                </xsl:for-each>');
    f_ecrire_fichier_texte(f, '              </tr>');
    f_ecrire_fichier_texte(f, '              <xsl:for-each select="donnees">');
    f_ecrire_fichier_texte(f, '                <tr>');
    f_ecrire_fichier_texte(f, '                  <xsl:for-each select="donnee">');
    f_ecrire_fichier_texte(f, '                    <td>');
    f_ecrire_fichier_texte(f, '                      <xsl:choose>');
    f_ecrire_fichier_texte(f, '                        <xsl:when test="normalize-space(@valeur)">');
    f_ecrire_fichier_texte(f, '                          <xsl:value-of select="@valeur"/>');
    f_ecrire_fichier_texte(f, '                        </xsl:when>');
    f_ecrire_fichier_texte(f, '                        <xsl:otherwise>');
    f_ecrire_fichier_texte(f, '                          <xsl:text disable-output-escaping="yes">&#160;</xsl:text>');
    f_ecrire_fichier_texte(f, '                        </xsl:otherwise>');
    f_ecrire_fichier_texte(f, '                      </xsl:choose>');
    f_ecrire_fichier_texte(f, '                    </td>');
    f_ecrire_fichier_texte(f, '                  </xsl:for-each>');
    f_ecrire_fichier_texte(f, '                </tr>');
    f_ecrire_fichier_texte(f, '              </xsl:for-each>');
    f_ecrire_fichier_texte(f, '            </table>');
    f_ecrire_fichier_texte(f, '            <br/>');
    f_ecrire_fichier_texte(f, '            <br/>');
    f_ecrire_fichier_texte(f, '          </xsl:for-each>');
    f_ecrire_fichier_texte(f, '        </ul>');    
    f_ecrire_fichier_texte(f, '      </body>');
    f_ecrire_fichier_texte(f, '    </html>');
    f_ecrire_fichier_texte(f, '  </xsl:template>');
    f_ecrire_fichier_texte(f, '</xsl:stylesheet>');
    f_fermer_fichier(f);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_erreur(
  AIDFichier integer)  
returns(
  AMessage varchar(500),
  AMessageSQL varchar(1000),
  AOccurence integer)  
as
declare variable chTypeMessage char(1);
begin
  for select message_erreur_sql, type_erreur, count(*)
      from t_fct_erreur
      where t_fct_fichier_id = :AIDFichier      
      group by type_erreur, message_erreur_sql 
      into :AMessageSQL, :chTypeMessage, :AOccurence do
  begin
    select message
    from t_fct_message_erreur
    where position(lower(nom_contrainte), lower(:AMessageSQL)) > 0
      and type_message = :chTypeMessage 
	  and t_fct_message_erreur_id= (select min(t_fct_message_erreur_id) from t_fct_message_erreur where position(lower(nom_contrainte), lower(:AMessageSQL)) > 0 and type_message = :chTypeMessage)
    into :AMessage;
    
    if ((row_count = 0) or (AMessage is null) or (AMessage = '')) then
      AMessage = AMessageSQL;
      
    suspend;  
  end 
end;