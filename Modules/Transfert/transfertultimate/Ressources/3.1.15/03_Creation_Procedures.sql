/* ********************************************************************************************** */
create or replace procedure migration.compiler_objets(AProprietaire in varchar2)
as
  strSQL varchar2(1000);
begin
  for cr_obj in (select owner, object_name, object_type
                 from sys.all_objects
                 where owner = AProprietaire
                   and status = 'INVALID') loop
    if cr_obj.object_type = 'PACKAGE BODY' then
      strSQL := 'alter package ' || cr_obj.owner || '.' || cr_obj.object_name || ' compile body';
    else
      strSQL := 'alter ' || cr_obj.object_type || ' ' || cr_obj.owner || '.' || cr_obj.object_name || ' compile';
    end if;
    
    /*dbms_output.put_line(lStrSQL);*/
    begin
      execute immediate strSQL;
    exception
      when others then
        null;        
    end;
  end loop;
end;
/	

create or replace procedure migration.ps_recompiler_objets as
  lStrSQL varchar2(1000);
begin
  for cr_obj in (select owner, object_name, object_type
                 from sys.all_objects
                 where owner in ('MIGRATION', 'BEL')
                   and status = 'INVALID') loop
    if cr_obj.object_type = 'PACKAGE BODY' then
      lStrSQL := 'alter package ' || cr_obj.owner || '.' || cr_obj.object_name || ' compile body';
    else
      lStrSQL := 'alter ' || cr_obj.object_type || ' ' || cr_obj.owner || '.' || cr_obj.object_name || ' compile';
    end if;
    
    /*dbms_output.put_line(lStrSQL);*/
    begin
      execute immediate lStrSQL;
    exception
      when others then
        null;        
    end;
  end loop;  
end;
/
              
create or replace procedure migration.ps_executer_script(
    arepertoire in varchar2,
    ascript in varchar2) as

  f utl_file.file_type;
  buf varchar2(1024);
  t_buf varchar2(1024);
  l_buf integer;
  req varchar2(1024);

  c integer;
  nb integer;

  msg_erreur varchar2(500);

  procedure executer_sql(cmd in varchar2) as
  begin
    begin          
      dbms_sql.parse(c, cmd, dbms_sql.native);
      nb := dbms_sql.execute(c);
    exception
      when others then
        msg_erreur := sqlerrm;
        insert into migration.t_erreur(t_erreur_id, categorie, donnees, texte)
        values(seq_erreur.nextval, 'EXECUTION SCRIPT', arepertoire || '.' || ascript, msg_erreur);
    end;
  end;

begin  
  c := dbms_sql.open_cursor;  
  f := utl_file.fopen(arepertoire, ascript, 'R');
  loop  
    begin
      utl_file.get_line(f, buf);
      t_buf := regexp_replace(buf, '[[:cntrl:]]', '');

      --dbms_output.put_line('Ligne en cours : ' || t_buf || '#');

      if (substr(t_buf, 1, 2) != '--') then
        l_buf := lengthc(t_buf);

        --dbms_output.put_line('Ligne en cours pas un commentaire. Taille de la ligne : ' || l_buf || '. Dernier caractère : ' || substr(t_buf, l_buf, 1));

        if (substr(t_buf, l_buf, 1) = ';') then
          req := req || ' ' || substr(t_buf, 1, l_buf - 1);          
          executer_sql(req);

          --dbms_output.put_line('Execution de : ' || req);
          req := '';
        else
          req := req || ' ' || substr(t_buf, 1, l_buf);
        end if;        
      end if;
    exception
      when no_data_found then
      exit;
  end;
  end loop;
  dbms_sql.close_cursor(c);
end;
/