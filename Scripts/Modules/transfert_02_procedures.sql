set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_transfert_init_trait(
  ATraitementID integer,
  AMiseAJour char(1))
as
declare variable lStrSQL varchar(2000);
declare variable lStrTableCorrespondance varchar(31);
declare variable lIntFichierID integer;
declare variable strCle varchar(31);
begin
  select table_correspondance,
         t_fct_fichier_id
  from t_transfert_traitement
  where t_transfert_traitement_id = :ATraitementID
  into :lStrTableCorrespondance,
       :lIntFichierID;

  if (row_count = 1) then
  begin
    -- Creation procédure de correspondance
    if (lStrTableCorrespondance is not null) then
    begin
      select rdb$field_name
      from rdb$relation_fields
      where rdb$relation_name = upper(:lStrTableCorrespondance)
        and rdb$field_id = 0
      into :strCle;

      lStrSQL = 'create or alter procedure ps_transfert_creer_corres(ACodeBasePHA varchar(50), ACodeBaseTrf integer)
                 as
                 begin';
      if (AMiseAJour = '1') then
        lStrSQL = lStrSQL || '
                   if (not(exists(select *
                                  from ' || lStrTableCorrespondance || '
                                  where ' || strCle || ' = :ACodeBasePHA))) then';

      lStrSQL = lStrSQL || '
                     insert into ' || lStrTableCorrespondance || ' values(:ACodeBasePHA, :ACodeBaseTrf);
                 end;';
      execute statement lStrSQL;

      if (AMiseAJour = '0') then
        execute statement 'delete from ' || lStrTableCorrespondance;
    end
    else
      if (exists (select *
                  from rdb$procedures
                  where upper(rdb$procedure_name) = 'PS_TRANSFERT_CREER_CORRES')) then
        execute statement 'drop procedure ps_transfert_creer_corres';

    -- Vidage des tables d'erreurs & correspondaces
    delete from t_fct_erreur
    where type_erreur = 2
      and t_fct_fichier_id = :lIntFichierID;
  end
  else
    exception exp_transfert_tr_non_ex 'Traitement inexistant (' || ATraitementID || ') !';
end;

