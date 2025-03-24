create or replace package body migration.pk_praticiens as

  Specialites pk_commun.tab_identifiants;  

  function creer_structure(AIDstructureLGPI in integer,
                           ASecteur in varchar2, 
                           ANom in varchar2,
                           ACommentaire in varchar2,
                           ANoFiness in varchar2,
                           ARue1 in varchar2,
                           ARue2 in varchar2,
                           ACodePostal in varchar2,
                           ANomVille in varchar2,
                           ATelPersonnel in varchar2,
                           ATelStandard in varchar2,
                           ATelMobile in varchar2,
                           AFax in varchar2,
                           AFusion in char)
                          return integer
  as
    intIDAdresse integer; 
    intIDstructure integer;
    
      procedure creer_donnees_annexe
      as
      begin
        intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, null);
      end;
    
      procedure maj_structure
      as
        intIDAdresseLGPI integer;
      begin    
        select t_adresse_id
        into intIDAdresseLGPI
        from erp.t_structure
        where t_structure_id = intIDstructure;

        creer_donnees_annexe;
        update erp.t_structure
        set nom = decode(AFusion, '0', ANom, nom),
            commentaires = decode(AFusion, '0', ACommentaire, nvl(commentaires, ACommentaire)),
            nofiness = ANoFiness,
            datemodification = sysdate,
            t_adresse_id = decode(AFusion, '0', intIDAdresse, nvl(t_adresse_id, intIDAdresse))
        where t_structure_id = intIDstructure;
      
        delete from erp.t_adresse where t_adresse_id = intIDAdresseLGPI;
      end;
    
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_structures;

    -- recherhe d une structure par no finess 
    if AFusion = '1' then
      begin
        select t_structure_id
        into intIDstructure
        from erp.t_structure h
        where h.nofiness = ANoFiness;
      exception
        when no_data_found or too_many_rows then
          intIDstructure := null;
      end;
    else
      intIDstructure := null;
    end if;
    
    if intIDstructure is null then
          if ((AFusion = '0') and (AIDstructureLGPI is null)) 
              or ((AFusion = '1') and ((pk_commun.Options.hopitaux_creer_si_inexistant = '1') or (ASecteur = 'PRIVE')) ) then                              
                creer_donnees_annexe;
                insert into erp.t_structure(t_structure_id,
                                          nom,
                                          secteur,
                                          commentaires,
                                          nofiness,
                                          datemodification,
                                          t_adresse_id)
                values (erp.seq_id_structure.nextval,
                        ANom,
                        Asecteur ,
                        Acommentaire,
                        ANoFiness,
                        sysdate,
                        intIDAdresse)
                returning t_structure_id into intIDstructure;
          elsif AFusion = '0' then
                intIDstructure := AIDstructureLGPI;
                maj_structure;
          end if;
    elsif AFusion = '0' then
          maj_structure;
    end if;
      
    return intIDstructure;
  exception
    when others then
      rollback to sp_structures;
      raise;
  end;

  /* ********************************************************************************************** */
  function creer_hopital(AIDHopitalLGPI in integer,
                         ANom in varchar2,
                         ACommentaire in varchar2,
                         ANoFiness in varchar2,
                         ARue1 in varchar2,
                         ARue2 in varchar2,
                         ACodePostal in varchar2,
                         ANomVille in varchar2,
                         ATelPersonnel in varchar2,
                         ATelStandard in varchar2,
                         ATelMobile in varchar2,
                         AFax in varchar2,
                         AFusion in char)
                        return integer
  as
    intIDHopital integer;
    
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_hopitals;

    intIDHopital := creer_structure(AIDHopitalLGPI,'HOPITAL',ANom,ACommentaire,ANoFiness,ARue1,ARue2,ACodePostal,ANomVille,ATelPersonnel,ATelStandard,ATelMobile,AFax,AFusion);
      
    return intIDHopital;
  exception
    when others then
      rollback to sp_hopitals;
      raise;
  end;

  /* ********************************************************************************************** */
  function creer_praticien(AIDPraticienLGPI in integer,
                           ATypePraticien in varchar2,
                           ANom in varchar2,
                           APrenom in varchar2,
                           ASpecialite in varchar2,
                           ARue1 in varchar2,
                           ARue2 in varchar2,
                           ACodePostal in varchar2,
                           ANomVille in varchar2,
                           ATelPersonnel in varchar2,
                           ATelStandard in varchar2,
                           ATelMobile in varchar2,
                           AFax in varchar2,
                           AIDHopital in number,
                           ACommentaire in varchar2,
                           ANoFiness in varchar2,
                           ANumRPPS in varchar2,
                           AVeterinaire in char,  
                           AFusion in char)
                          return number as

            intIDAdresse integer;
            intIDSpecialite integer;
            intIDPraticien integer;
            intIDStructure integer;
  
            procedure creer_donnees_annexe
            as
            begin
              intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, null);
            end;

            procedure maj_praticien
            as
              intIDStructureLGPI integer;
            begin
                  select t_structure_id
                  into intIDStructureLGPI
                  from erp.t_praticien_structure
                  where t_praticien_id = intIDPraticien;
                                       
                  creer_donnees_annexe;
                  update erp.t_praticien
                  set nom = ANom,
                      commentaires = decode(AFusion, '0', ACommentaire, nvl(commentaires, ACommentaire)),
                      datemodification = sysdate,
                      no_facturation = ANoFiness,
                      t_specialite_id = decode(AFusion, '0', intIDSpecialite, t_specialite_id)
                  where t_praticien_id = intIDPraticien;
                  
                  -- if (AFusion = '0') then
                  --       delete from erp.t_praticien_structure where t_adresse_id = intIDAdresseLGPI;          
                  -- else
                  --       if (intIDAdresseLGPI is not null) then
                  --             delete from erp.t_adresse where t_adresse_id = intIDAdresse;          
                  --       end if;
                  -- end if;
            end;
            
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_praticiens;
    
    begin
      intIDSpecialite := Specialites(ASpecialite);
    exception
      when no_data_found then
        intIDSpecialite := null;
    end;

    if AFusion = '1' then
          begin
            select t_praticien_id
            into intIDPraticien
            from erp.t_praticien p
            where num_rpps = ANumRPPS;
          exception
            when no_data_found or too_many_rows then
              intIDPraticien := null;
          end;
    else
          intIDPraticien := null;
    end if;
    
    -- pas trouvé creation 
    if intIDPraticien is null then
        if ((AFusion = '0') and (AIDPraticienLGPI is null)) 
            or ((AFusion = '1') and (pk_commun.Options.praticiens_creer_si_inexistant = '1')) then
              creer_donnees_annexe;         
              insert into erp.t_praticien(t_praticien_id,
                                          nom,
                                          prenom,
                                          t_profession_id,
                                          t_specialite_id,
                                          categorie, 
                                          no_facturation,
                                          num_rpps,
                                          datemodification,
                                          modemodification,
                                          commentaires)
              values (erp.seq_id_praticien.nextval,
                      ANom,
                      APrenom,
                      (select t_profession_id from erp.t_profession where libelle = 'Médecin'),
                      intIDSpecialite,
                      decode( AVeterinaire, '1', 'VETERINAIRE', 'PRESCRIPTEUR'),
                      ANoFiness,
                      trim(ANumRPPS),
                      sysdate,
                      'MANUEL',
                      ACommentaire
                      )
              returning t_praticien_id into intIDPraticien;

              -- creer cabinet en mode fusion ( ou relier hopital ) pour ne pas creer un cabinet deja existant
              if ATypePraticien = '2' then
                intIDStructure := AIDHopital;
              else
                intIDStructure := creer_structure(null,'PRIVE',substr('CABINET '||ANom,1,50),ACommentaire,ANoFiness,ARue1,ARue2,ACodePostal,ANomVille,ATelPersonnel,ATelStandard,ATelMobile,AFax,1);
              end if;

             -- creer liaison praticien / structure 
             insert into erp.t_praticien_structure(t_praticien_structure_id,
                                                   t_praticien_id,
                                                   t_structure_id,
                                                    datemodification)
              values (erp.seq_id_praticien_structure.nextval,
                      intIDPraticien,
                      intIDStructure,
                      sysdate);

        elsif AFusion = '0' then
              -- mode mise a jour
              intIDPraticien := AIDPraticienLGPI;
              maj_praticien;
        end if;   
    elsif AFusion = '0' then
      --
      maj_praticien;
    end if;

    return intIDPraticien;
  exception
    when others then
      rollback to sp_praticiens;
      raise;
  end;

  /* ********************************************************************************************** */
 
begin
  for cr_spec in (select t_specialite_id, code from erp.t_specialite) loop
    Specialites(cr_spec.code) := cr_spec.t_specialite_id;
  end loop;
end; 
/