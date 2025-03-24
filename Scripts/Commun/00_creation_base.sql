set sql dialect 3;

/* **************************************************************************** */
create table t_fct_script(
  t_fct_script_id integer,
  nom_script varchar(255),
  date_heure integer,
  constraint pk_fct_script primary key(t_fct_script_id));
  
create unique index unq_fct_script on t_fct_script(nom_script);

create sequence seq_fct_script;

create trigger trg_fct_script_nouveau for t_fct_script
active before insert
position 0
as
begin
  if (new.t_fct_script_id is null) then
    new.t_fct_script_id = next value for seq_fct_script;
end;

create procedure ps_inserer_info_script(
  ANomScript varchar(255),
  ADateHeure integer)
as
begin
  insert into t_fct_script(nom_script,
                           date_heure)
  values(:ANomScript,
         :ADateHeure);
end;

create procedure ps_renvoyer_date_maj_script(
  ANomScript varchar(255))
returns(
  ADateHeure integer)
as
begin
  select date_heure
  from t_fct_script
  where nom_script = :ANomScript
  into :ADateHeure;
  
  if (row_count = 0) then
    ADateHeure = null;
    
  suspend;
end;