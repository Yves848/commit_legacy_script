declare
  lIntCount number(10);
begin
  select count(*)
  into lIntCount
  from sys.all_users
  where lower(username) = 'migration';
  
  if lIntCount > 0 then
    execute immediate 'drop user migration cascade';
  end if;
end;
/
create user migration identified by migration;
grant connect, unlimited tablespace to migration;
grant drop any table, alter any table, select any table, insert any table, update any table, delete any table,
  drop any sequence, create any sequence, select any sequence, drop any materialized view, analyze any,
  execute any procedure, alter database, create any directory,
  debug connect session, debug any procedure, alter any procedure
to migration;
