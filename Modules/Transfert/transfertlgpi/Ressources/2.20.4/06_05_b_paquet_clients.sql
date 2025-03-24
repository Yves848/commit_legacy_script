create or replace package body migration.pk_clients as

  Qualites pk_commun.tab_identifiants;
  
  /* ********************************************************************************************** */
  procedure creer_couverture_amo_client(AIDClient integer,
                                        AIDOrganismeAMO integer,
                                        ACodeCouvertureAMO in char,
                                        ADebutDroitAMO in date,
                                        AFinDroitAMO in date,
                                        ACentreGestionnaire in varchar2,
                                        AFusion in char)
  as
    intIDCouvertureAMO integer;
    intIDcouvertureaadAMO integer;
    intNbClients integer;
  begin
    savepoint ps_couvertures_amo_clients;
    
    if AFusion = '1' then
      select count(*)
      into intNbClients
      from migration.t_tmp_client_fusionne
      where t_client_id = AIDClient
        and etat in ('F', 'C');

       if intNbClients = 0 then
        raise_application_error(-20106, 'Fusion de couverture AMO impossible, client non trouvé dans la table de fusion');  
      end if;
    else
      intNbClients := 1;
    end if;
    
    if intNbClients > 0 then
      select t_couvertureamo_id
      into intIDCouvertureAMO
      from erp.t_couvertureamo
      where codecouverture = ACodeCouvertureAMO;
    
      begin
        select t_organismeaadamo_id 
        into intIDcouvertureaadAMO
        from erp.t_organismeaadamo
        where t_aad_id = AIDClient and t_organismeamo_id = AIDOrganismeAMO ;
      exception
            when no_data_found then
              intIDcouvertureaadAMO := null;
      end;  

      if ( intIDcouvertureaadAMO is null ) then 
        insert into erp.t_organismeaadamo(t_organismeaadamo_id,
                      t_organismeamo_id,
                      t_aad_id,
                      centregestionnaire,
                      type_organismeamo,
                      datemajorganismeamoaad)
        values (erp.seq_id_organismeaadamo.nextval,
            AIDOrganismeAMO,
            AIDClient,
            ACentreGestionnaire,
            1, -- verifier
            sysdate
          ) returning  t_organismeaadamo_id into intIDcouvertureaadAMO;
      end if;
    
      insert into erp.t_couvertureaadamo(t_couvertureaadamo_id,
                                     datedebutdroit,
                                     datefindroit,
                                     originedonnees,
                                     codeald,
                                     datemajcouvaadamo,
                                     t_couvertureamo_id,
                                     t_organismeaadamo_id)
      values(erp.seq_couvertureaadamo.nextval,
             ADebutDroitAMO,
             AFinDroitAMO,
             '0',
             ' ',
             sysdate,
             intIDCouvertureAMO,
             intIDcouvertureaadAMO
       );  
    end if;
  exception
    when others then
      rollback to ps_couvertures_amo_clients;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_couverture_amc_client(AIDClient in integer,
                                        AIDCouvertureAMC in integer) 
                                        --ADebutDroitAMC in date,-- disparu 2.0
                                        --AFinDroitAMC in date)-- disparu 2.0
  as
  begin
    if AIDCouvertureAMC is not null then      
      insert into erp.t_couvertureaadamc(t_couvertureaadamc_id,
                                         datemajcouvaadamc,
                                         t_couvertureamc_id,
                                         t_aad_id)
      values(erp.seq_couvertureaadamc.nextval,
             sysdate,
             AIDCouvertureAMC,
             AIDClient);
    end if;
  end;
  
  /* ********************************************************************************************** */
  function creer_client(AIDClientLGPI in integer,
                        ANumeroInsee in varchar2,
                        ANom in varchar2,
                        APrenom in varchar2,
                        ANomJeuneFille in varchar2,
                        ACommentaireGlobal in varchar2,
                        ACommentaireGlobalBloquant in char,
                        ACommentaireIndividuel in varchar2,
                        ACommentaireIndividuelBloquant in char,
                        ADateNaissance in varchar2,
                        AQualite in varchar2,
                        ARangGemellaire in number,
                        ADateValiditePieceJustif in date,
                        AIDOrganismeAMO in integer,
                        AInformationsAMC in varchar2,
                        AIDOrganismeAMC in integer,
                        ANumeroAdherentMutuelle in varchar2,
                        AIDCouvertureAMC in integer,
                        ADebutDroitAMC in date,
                        AAttestationAMEComplementaire in char,
                        AFinDroitAMC in date,
                        ADateDerniereVisite in date,
                        AActivite in varchar2,
                        ARue1 in varchar2,
                        ARue2 in varchar2,
                        ACodePostal in varchar2,
                        ANomVille in varchar2,
                        ATelPersonnel in varchar2,
                        ATelStandard in varchar2,
                        ATelMobile in varchar2,
                        AFax in varchar2,
                        AEmail in varchar2,
                        ANumeroIdentifiantAMC in varchar2,
                        AModeGestionAMC in char,
                        AGenre in char,
                        AIDProfilRemise in integer,
                        ARefExterne in varchar2,
                        AFusion in char)
                       return integer
  as                       
    intIDClient integer;
    intIDActivite integer;
    intIDQualite integer;
    intIDAdresse integer;
    intIDPraticien integer;
    lDtDateDerniereVisite date;
    lDtDateFinDroitAMC date;
    intIDAdresseLGPI integer;
    lNumeroIdentifiantAMC varchar(15);      
    lNumeroAdherentMutuelle varchar(8);
 
  begin
    savepoint ps_clients;
    
    -- recherche de l id pour la fusion
    if AFusion = '1' then 
        begin
          select t_aad_id, datedernierevisite , datefindroitsamc
          into intIDClient, lDtDateDerniereVisite,lDtDateFinDroitAMC
          from erp.t_assureayantdroit
          where numeroinsee = ANumeroInsee
            and datenaissance = ADateNaissance
            and ranggemellaire = ARangGemellaire
            and d_del is null
            and (numeroinsee is not null or numeroinsee <>'');
        exception
          when no_data_found  then
            intIDClient := null;
            lDtDateDerniereVisite := null;
          when too_many_rows then 
            raise_application_error(-20201, 'Impossible de fusionner un client qui est en doublon');  
        end;
    else
        intIDClient := null;
    end if; 
    
    --  pas trouvé en mode fusion , ou mode normal , ou mode mise a jour => Création 
    if intIDClient is null then 
          begin
            intIDQualite := Qualites(AQualite);
          exception
            when no_data_found then
              intIDQualite := null;
          end;
          
          intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, AEmail);
          intIDActivite := pk_commun.creer_activite(AActivite, 'A'); 

          if ( length(ANumeroadherentMutuelle) <= 8 )  then  
              lNumeroAdherentMutuelle := ANumeroadherentMutuelle  ;
              lNumeroIdentifiantAMC := null;    
          elsif ( length(ANumeroadherentMutuelle) <= 15 ) then 
              lNumeroAdherentMutuelle := null ;
              lNumeroIdentifiantAMC := ANumeroadherentMutuelle ; 
          end if ;                                         
          

          -- pas d'id LGPI donc pas MAJ : creation d'un nouveau record
          if AIDClientLGPI is null then  
                  insert into erp.t_assureayantdroit(t_aad_id,
                                                     numeroinsee,
                                                     typecartevitale,
                                                     noseriecv,
                                                     nom,
                                                     prenom,
                                                     nomjeunefille,
                                                     datenaissance,
                                                     ranggemellaire,
                                                     nadherentmut,
                                                     datevaliditepiecejustif,
                                                     datedernierevisite,
                                                     datemajaad,
                                                     datecreation,
                                                     t_organismeamc_id,
                                                     t_qualite_id,
                                                     t_adresse_id,
                                                     typeimmatriculation,
                                                     paiediffinterdit,
                                                     chequeinterdit,
                                                     t_assurerattache_id,
                                                     t_activite_id,
                                                     datedebdroitsamc,
                                                     numero_identifiant_amc,
                                                     attestation_ame_complementaire,
                                                     datefindroitsamc,
                                                     modegestionamc,
                                                     type_convention1,
                                                     piecejustifdroitsamc,
                                                     codeserviceamo,
                                                     genre,
                                                     ref_externe)
                  values(erp.seq_assureayantdroit.nextval,
                         ANumeroInsee,    
                         null,
                         null,
                         ANom,
                         APrenom,
                         ANomJeuneFille,
                         ADateNaissance,
                         ARangGemellaire,
                         lNumeroadherentMutuelle,
                         ADateValiditePieceJustif,
                         ADateDerniereVisite,
                         sysdate,
                         sysdate - interval '5' year,
                         AIDOrganismeAMC,
                         intIDQualite,
                         intIDAdresse,
                         null,
                         '0',
                         '0',
                         null,
                         intIDActivite,
                         ADebutDroitAMC ,
                         lNumeroIdentifiantAMC ,
                         decode(lNumeroIdentifiantAMC , '75500017', 'N' , AAttestationAMEComplementaire) ,
                         decode(AFinDroitAMC , null , sysdate-1 , AFinDroitAMC ),
                         AModeGestionAMC,
                         decode(lNumeroIdentifiantAMC , '75500017', 'RO' , null), -- AME
                         decode(lNumeroIdentifiantAMC , '75500017', 1 , null),  -- AME
                         decode(AIDOrganismeAMC , null , null, '00'),
                         AGenre,
                         ARefExterne   )
                  returning t_aad_id into intIDClient;
              
                  insert into migration.t_tmp_client_fusionne values(intIDClient, 'C');   
          else -- l'id existe , MAJ ( le mode mise a jour est implicite )
                  -- le mode mise à jour ecrase toutes les données
                  intIDClient := AIDClientLGPI;
                  
                  select t_adresse_id
                  into intIDAdresseLGPI
                  from erp.t_assureayantdroit
                  where t_aad_id = intIDClient;
                  
                  update erp.t_assureayantdroit
                  set numeroinsee = ANumeroInsee,
                      commindividuel = ACommentaireIndividuel,
                      commindividuelbloquant = ACommentaireIndividuelBloquant,
                      commglobal = ACommentaireGlobal,
                      commglobalbloquant = ACommentaireGlobalBloquant,
                      nom = ANom,
                      nomjeunefille = ANomJeuneFille,
                      datenaissance = ADateNaissance,
                      ranggemellaire = ARangGemellaire,
                      nadherentmut = ANumeroadherentMutuelle,
                      datevaliditepiecejustif = ADateValiditePieceJustif,
                      datedernierevisite = ADateDerniereVisite,
                      datemajaad = sysdate,
                      t_organismeamc_id = AIDOrganismeAMC,
                      t_qualite_id = intIDQualite,
                      t_adresse_id = intIDAdresse,
                      t_activite_id = intIDActivite,
                      codeserviceamo = decode(AIDOrganismeAMC , null , null, '00'),
                      genre = AGenre
                  where t_aad_id = intIDClient;

                  delete from erp.t_adresse where t_adresse_id = intIDAdresseLGPI;   
                  delete from erp.t_commentaire_association where id_entite = intIDClient;                  
                  delete from erp.t_commentaire where type_entite = 0 and id_commentaire in ( select ca.id_commentaire from erp.t_commentaire_association ca where ca.id_entite = intIDClient );
                  delete from erp.t_couvertureaadamc where t_aad_id = intIDClient;
         end if;    
         --  a partir de la l'id LGPI existe, soit il vient de la fusion , soit c'est l id LGPI d'une mise à jour 
     elsif (AFusion = '1') and ((lDtDateFinDroitAMC < AFinDroitAMC) or (lDtDateFinDroitAMC is null)) then --if 2  on a trouvé l'id donc on peut fusionner             update erp.t_assureayantdroit  -- en mode fusion on met a jour ses infos AMC si les dates de prise en charge sont plus recentes
          update erp.t_assureayantdroit  -- en mode fusion on met a jour ses infos AMC si les dates de prise en charge sont plus recentes
          set datemajaad = sysdate,
              t_organismeamc_id = AIDOrganismeAMC,  
              nadherentmut = ANumeroadherentMutuelle,
              numero_identifiant_amc = lNumeroIdentifiantAMC,
              datedebdroitsamc = ADebutDroitAMC,
              datefindroitsamc = decode(AFinDroitAMC,null,sysdate-1,AFinDroitAMC),   
              id_del = null,
              d_del = null
          where t_aad_id = intIDClient;
          
          delete from erp.t_couvertureaadamc where t_aad_id = intIDClient;
          insert into migration.t_tmp_client_fusionne values(intIDClient, 'F');
    elsif(AFusion = '1') then                                            -- if 2
          insert into migration.t_tmp_client_fusionne values(intIDClient, 'R');
    end if;                                                              -- if 2 
    
    if (AFusion = '0') or ((AFusion = '1') and ((lDtDateFinDroitAMC is null) or (lDtDateFinDroitAMC < AFinDroitAMC))) then --if 5
        creer_couverture_amc_client(intIDClient, AIDCouvertureAMC);
    end if; 
    
    -- en mode fusion on mets a jour l adresse selon la date de derniere visite
    if  ((AFusion = '1') and ((lDtDateDerniereVisite is null) or (lDtDateDerniereVisite < ADateDerniereVisite))) then -- if 6
        intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, AEmail);
         
        update erp.t_assureayantdroit
        set datemajaad = sysdate,
              t_adresse_id = intIDAdresse,
              datedernierevisite = ADateDerniereVisite
        where t_aad_id = intIDClient;
    end if; 

    return intIDClient;
  exception
    when others then
      rollback to ps_clients;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure rattacher_assure(AIDClient integer,
                             AIDAssure integer)
  as
  begin
    savepoint ps_rattachements_assures;
    
    update erp.t_assureayantdroit
    set t_assurerattache_id = AIDAssure
    where t_aad_id = AIDClient;
  exception
    when others then
      rollback to ps_rattachements_assures;
      raise;
  end;  
  
  /* ********************************************************************************************** */
  procedure creer_mandataire(AIDClient integer,
                             AIDMandataire integer,
                             ATypeLien integer)
  as
  begin
    savepoint ps_creer_mandataire;
    
    insert into erp.t_mandataire (t_aad_id,
                                  t_mandataire_id,
                                  type_lien)
    values ( AIDClient,
             AIDMandataire,
             ATypeLien );

  exception
    when others then
      rollback to ps_creer_mandataire;
      raise;
  end;  

begin
  for cr_q in (select t_qualite_id, code from erp.t_qualite) loop
    Qualites(cr_q.code) := cr_q.t_qualite_id;
  end loop;  
end; 
/