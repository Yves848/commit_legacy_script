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