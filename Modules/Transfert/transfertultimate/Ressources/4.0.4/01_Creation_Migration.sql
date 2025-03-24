/***************************************/
/*    SCRIPT DE CREATION DU SCHEMA     */
/*          MIGRATION                  */
/***************************************/

/* Création de l'utilisateur MIGRATION */
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

grant 
  connect, unlimited tablespace, dba to migration;
  
grant all privileges to migration;

grant 
  drop any table, alter any table, select any table, insert any table, update any table, delete any table,
  drop any sequence, create any sequence, select any sequence, alter any trigger, execute any procedure
to migration;

create or replace directory SU_SCRIPT_OFFIBASE as '/home/pharmagest/erp/executable/sql/offibase';
create or replace directory SU_SCRIPT_MULTIPHARMA as '/home/pharmagest/erp/executable/sql/multipharma';
