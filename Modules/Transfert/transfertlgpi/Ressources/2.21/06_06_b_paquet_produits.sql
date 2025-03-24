create or replace package body migration.pk_produits as

  type rec_tva is record(
    id integer,
    soumismdl char(1));

  type tab_tvas is table
    of rec_tva index by varchar2(15);

  type tab_tab_identifiants is table
    of pk_commun.tab_identifiants index by binary_integer;
  
  Depots pk_commun.tab_identifiants;
  TVAs tab_tvas;
  ZonesGeographiques pk_commun.tab_identifiants;
  Codifications tab_tab_identifiants;

/* ********************************************************************************************** */
 procedure maj_dictionnaire
  as
  begin
    -- On vide la table ( si c'est pas la première fois que le script passe )
    execute immediate 'truncate table erp.t_dictionnaire_designation';

    -- On peuple ensuite avec les données issues de VM_RECHERCHE_BDM
    insert into erp.t_dictionnaire_designation(id, 
                                           designation, 
                                           t_produit_id, 
                                           ID_PACKAGE_BDM, 
                                           type_designation)
      (
          select erp.seq_dictionnaire_designation.nextval, 
                 v.designation, 
                 v.t_produit_id, 
                 v.id_package_bdm, 
                 'DESIGNATION_LONGUE' 
          from erp.vm_recherche_bdm v
      );
      
    insert into erp.t_dictionnaire_designation(id, 
                                           designation, 
                                           t_produit_id, 
                                           ID_PACKAGE_BDM, 
                                           type_designation)
      (
          select erp.seq_dictionnaire_designation.nextval, 
                 v.designation_courte, 
                 v.t_produit_id, 
                 v.id_package_bdm, 
                 'DESIGNATION_COURTE' 
          from erp.vm_recherche_bdm v
      );
      
    insert into erp.t_dictionnaire_designation(id, 
                                           designation, 
                                           t_produit_id, 
                                           id_package_bdm, 
                                           type_designation)
    ( select erp.seq_dictionnaire_designation.nextval, 
             f.libelle || ' ' || v.designation_courte, 
             v.t_produit_id, 
             v.id_package_bdm, 
             'FABRICANT_ET_COURTE' 
      from erp.vm_recherche_bdm v, erp.t_bdm_fabricant f 
      where v.id_fabricant_bdm=f.id_bdm );

    -- puis on complète avec les données de t_produit ( pour les t_produit_id, et pour les produits qui ne seraient que dans t_produit )

    merge into erp.t_dictionnaire_designation d using ( select id_package_bdm, 
                                                               t_produit_id, 
                                                               designation
                                                        from erp.t_produit where d_del is null ) p
    on (p.id_package_bdm=d.id_package_bdm and p.designation=d.designation)
    when not matched then insert (d.id, 
                                  d.designation, 
                                  d.t_produit_id, 
                                  d.id_package_bdm, 
                                  d.type_designation)
        values (erp.seq_dictionnaire_designation.nextval, 
                p.designation, 
                p.t_produit_id, 
                nvl(p.id_package_bdm,-1), 
                'DESIGNATION_COURTE');

    -- 2e merge pour aller ajouter des t_produit_id à des produits bdm ( si déjà importés )
    merge into erp.t_dictionnaire_designation d using ( select id_package_bdm, 
                                                           min(t_produit_id) as t_produit_id
                                                    from erp.t_produit where d_del is null group by id_package_bdm ) p                                        
    on (p.id_package_bdm=d.id_package_bdm)
    when matched then update set d.t_produit_id=p.t_produit_id where d.t_produit_id<=0;

    -- insert du libellé "fabricant et courte" pour les produit n'ayant pas d'id bdm
    insert into erp.t_dictionnaire_designation(id, 
                                               designation, 
                                               t_produit_id, 
                                               id_package_bdm, 
                                               type_designation)
      (
          select erp.seq_dictionnaire_designation.nextval, 
                 fab.libelle|| ' ' || designation, 
                 tp.t_produit_id, 
                 nvl(tp.id_package_bdm,-1),
                 'FABRICANT_ET_COURTE'
          from erp.t_produit tp, erp.t_bdm_fabricant fab 
          where tp.d_del is null
          and tp.t_bdm_fabricant_id=fab.t_bdm_fabricant_id
          and tp.id_package_bdm is null
      );

  end;

  procedure maj_produit_stup(ACodeCIP in varchar2)
  as
  begin
    savepoint sp_produit_stup;
    
    update erp.t_produit
    set deconditionnable ='1'
    where codecip = ACodeCIP;

  exception
    when others then
      rollback to sp_produit_stup;
  end;

  /* ********************************************************************************************** */
  procedure maj_stock_stup
  as
  begin 

    
  for c_prod_stup in ( select t_produit_id, codecip, nb_mode_administration
             from erp.t_produit 
             where ( assimile_stupefiant = '1' or liste = 3 ) 
             and deconditionnable = '1'
             and nb_mode_administration is not null and nb_mode_administration >0
             and profilgs <> 1
             and ( conditionnement is null or conditionnement <= 1) ) loop
      
        update erp.t_produitgeographique pg 
    set quantite =  quantite * c_prod_stup.nb_mode_administration, 
    stockmini = stockmini * c_prod_stup.nb_mode_administration, 
    stockmaxi = stockmaxi * c_prod_stup.nb_mode_administration
        where pg.t_produit_id = c_prod_stup.t_produit_id;
    
  end loop;
  
  end;  
 
 /* ********************************************************************************************** */
  procedure maj_commande_stup
  as
  begin 

    
  for c_prod_stup in ( select t_produit_id, codecip, nb_mode_administration
             from erp.t_produit 
             where ( assimile_stupefiant = '1' or liste = 3 ) 
             and deconditionnable = '1'
             and nb_mode_administration is not null and nb_mode_administration >0
             and profilgs <> 1
             and ( conditionnement is null or conditionnement <= 1) ) loop
      
        update erp.t_lignecommande lc
        set lc.qtevendue = lc.qtevendue * c_prod_stup.nb_mode_administration , datemajligcde = sysdate
        where lc.t_produit_id = c_prod_stup.t_produit_id 
    and lc.t_commande_id is null;
    
  end loop;
  
  end;   
  /* ********************************************************************************************** */
  procedure maj_clickadoc_lppr
  as
  begin 
    --clickadm.pharmagest.maj_lppr_init;    
    --clickadm.pharmagest.maj_lppr_ref;
    --clickadm.pharmagest.maj_tarif_remb_lppr;    
    
    update erp.t_produit
    set soumismdl = 1, 
        tarifachatunique = 1
    where t_produit_id in (select p.t_produit_id 
                            from erp.t_produit p, 
                                erp.t_tva t, 
                                erp.t_prestation pr
                            where p.t_tva_id = t.t_tva_id
                              and p.t_prestation_id = pr.t_prestation_id
                              and t.soumismdl = 1
                              and pr.codetaux>0
                              and p.codecip not in (select codecip 
                                                   from erp.t_substituable s, 
                                                        erp.t_substituable_famille sf
                                                    where s.propriete = 2
                                                      and (sf.tfr is null or sf.tfr=0)
                                                      and s.t_substituable_famille_id = sf.t_substituable_famille_id));     
  end;

  /* ********************************************************************************************** */
  function creer_depot(ALibelle in varchar2,
                       AAutomate in char,
                       ATypeDepot in varchar2,
                       AFusion in char)
                      return integer
  as intIDDepot integer;
  begin
    savepoint sp_depots;
    
  --si fusion modification du libelle  
  -- Recherche du depot si fusion   
    if AFusion = '1' then
      begin
        select t_depot_id
        into intIDDepot
        from erp.t_depot
        where upper(convert(libelle, 'US7ASCII')) = upper(convert(substr('FUSION:'||ALibelle,1,50), 'US7ASCII'));
      exception
        when no_data_found or too_many_rows then
          intIDDepot := null;
      end;
    else
      intIDDepot := null;
    end if;
  
    -- création du depot 
  if intIDDepot is null then
    insert into erp.t_depot(t_depot_id,                           
                libelle,                              
                datemajdepot,                         
                pourcentage,                          
                automate,                             
                automate_suspendu,
                type_depot)

        values(erp.seq_id_depot.nextval,
               decode(AFusion, '0', ALibelle, substr('FUSION:'||ALibelle,1,50)),
               sysdate,
               0, 
               null , -- par defaut depot pas automate -> a parametrer en manuel
               '0',
           ATypeDepot
              )          
               returning t_depot_id into intIDDepot;
  end if;

    return intIDDepot;
  exception
    when others then
      rollback to sp_depots;
      raise;
  end;


  /* ********************************************************************************************** */
  function creer_zone_geographique(ALibelle in varchar2)
                                  return integer
  as
    intIDZoneGeographique integer;
    
    procedure inserer_zone_geographique as
    begin
      insert into erp.t_zonegeographique(t_zonegeo_id,
                                         libelle,
                                         datemajzonegeo)
      values(erp.seq_id_zonegeographique.nextval,
             ALibelle,
             sysdate)
      returning t_zonegeo_id into intIDZoneGeographique;
      
      ZonesGeographiques(ALibelle) := intIDZoneGeographique;
    end;
    
  begin
    if ALibelle is not null then
      if ZonesGeographiques.count = 0 then
        inserer_zone_geographique;
      else
        begin
          intIDZoneGeographique := ZonesGeographiques(ALibelle);
        exception
          when no_data_found then
            inserer_zone_geographique;
        end;
      end if;
    else
      intIDZoneGeographique := null;
    end if;
  
    return intIDZoneGeographique;
  exception
    when others then
      return null;
  end;
  
  /* ********************************************************************************************** */
  function creer_codification(ARang in integer,
                              ALibelle in varchar2)
                             return integer
  as
    intIDCodif integer;
    
    procedure inserer_codification as
      strSQL varchar(2000);
    begin
      execute immediate 'select erp.seq_id_codif' || Arang || '.nextval from dual' into intIDCodif;
      execute immediate 'insert into erp.t_codif' || ARang || '(t_codif' || ARang || '_id , libelle, datemajcodif' || ARang || ') values(:1, :2, :3)' using intIDCodif, ALibelle, sysdate;


      Codifications(ARang)(ALibelle) := intIDCodif;
    end;
    
  begin
    if (ARang between 1 and 6) and (ALibelle is not null) then
      if Codifications.count = 0 then
        inserer_codification;
      else
        begin
          intIDCodif := Codifications(ARang)(ALibelle);
        exception
          when no_data_found then
            inserer_codification;
        end;
      end if;
    else
      intIDCodif := null;
    end if;
  
    return intIDCodif;
  exception
    when others then
      return null;
  end;

  /* ********************************************************************************************** */
  function creer_fournisseur(AIDFournisseurLGPI in integer,
                                    ATypeFournisseur in char,
                                    ARaisonSociale in varchar2,
                                    AN171Identifiant in varchar2, -- plus utilisé
                                    AN171NumeroAppel in varchar2,-- plus utilisé
                                    ACommentaire in varchar2,
                                    AN171Vitesse in char,-- plus utilisé
                                    AModeTransmission in char,
                                    ARue1 in varchar2,
                                    ARue2 in varchar2,
                                    ACodePostal in varchar,
                                    ANomVille in varchar2,
                                    ATelPersonnel in varchar2,
                                    ATelStandard in varchar2,
                                    ATelMobile in varchar2,
                                    AFax in varchar2,                             
                                    ARepresentePar in varchar2,
                                    ATelephoneRepresentant in varchar2,
                                    AMobileRepresentant in varchar2,
                                    ANumeroFax in varchar2,
                                    AFDPartenaire in char,
                                    AFDCodePartenaire in number,                             
                                    ARepDefaut in char,
                                    ARepObjectifCAMensuel in number,
                                    ARepPharmaMLRefID in number,
                                    ARepPharmaMLURL1 in varchar2,
                                    ARepPharmaMLURL2 in varchar2,
                                    ARepPharmaMLIDOfficine in varchar2,
                                    ARepPharmaMLIDMagasin in varchar2,
                                    ARepPharmaMLCle in varchar2,
                                    AFDCodeSel in varchar2,
                                    AEmail in varchar2,
                                    AEmailRepresentant in varchar2,
                                    AFusion in char)
                                   return integer
  as
    intIDAdresse integer;
    intIDAdresseRepresentant integer;
    intIDAdresseLGPI integer;
    intIDFournisseur integer;
    intIDFournisseurContact integer;
    intIDFournisseurContactLGPI integer;
    intIDPharmaRef integer;
  begin
    savepoint sp_fournisseurs;

    if ARepPharmaMLRefID >0 then 
      begin
        select code 
        into intIDPharmaRef
        from erp.T_REPARTITEUR_PHARMAML_REF
        where code = ARepPharmaMLRefID;
      exception
        when no_data_found or too_many_rows then
          intIDPharmaRef := null;
      end;
    else 
      intIDPharmaRef := null;
    end if;

    -- Recherche du produit si fusion   
    if AFusion = '1' then
      begin
        select t_fournisseur_id
        into intIDFournisseur
        from erp.t_fournisseur
        where type_fournisseur = ATypeFournisseur
        and upper(trim(raisonsociale)) = upper(trim(ARaisonSociale));
      exception
        when no_data_found or too_many_rows then
          intIDFournisseur := null;
      end;
    else
      intIDFournisseur := null;
    end if;
    
    if intIDFournisseur is null then
      intIDAdresse := pk_commun.creer_adresse(ARue1, ARue2, ACodePostal, ANomVille, ATelPersonnel, ATelStandard, ATelMobile, AFax, AEmail);
      
      if ARepresentePar is not null then
         intIDAdresseRepresentant := pk_commun.creer_adresse(null, null, null, null, null,  ATelephoneRepresentant, AMobileRepresentant, ANumeroFax, AEmailRepresentant);
         insert into erp.t_fournisseur_contact(t_fournisseur_contact_id,
                                                                    nom,
                                                                    t_adresse_id,
                                                                    date_creation,
                                                                    date_maj)
          values(erp.seq_id_fournisseur_contact.nextval,
                      ARepresentePar,
                      intIDAdresseRepresentant,
                      sysdate,
                      sysdate)
          returning t_fournisseur_contact_id into intIDFournisseurContact;
      end if;
      
      if AIDFournisseurLGPI is null then
        insert into erp.t_fournisseur(t_fournisseur_id,
                                            type_fournisseur,
                                            raisonsociale,
                                            commentaire,
                                            --n171_identifiant, 
                                            --n171_noappel,
                                            --n171_vitesse,
                                            date_creation,
                                            date_maj,
                                            modetransmission,
                                            t_adresse_id,
                                            nofax,
--                                            foud_partenaire,
--                                            foud_codepartenaire,
                                            rep_defaut,
                                            rep_objectifcamensuel,
                                            pharmaml_ref_id,
                                            pharmaml_url1,
                                            pharmaml_url2,
                                            pharmaml_id_officine,
                                            pharmaml_id_magasin,
                                            pharmaml_cle,                                  
                                            cdespe_syst,
                                            t_contact_id,
                        foud_codesel)
        values(erp.seq_id_fournisseur.nextval,
               ATypeFournisseur,
               ARaisonSociale,
               ACommentaire,
               --AN171Identifiant,
               --AN171NumeroAppel,
               --AN171Vitesse,
               sysdate,
               sysdate,
               AModeTransmission,
               intIDAdresse,
               ANumeroFax,
--               AFDPartenaire,
--               AFDCodePartenaire,
               ARepDefaut,
               ARepObjectifCAMensuel,
               intIDPharmaRef,
               ARepPharmaMLURL1,
               ARepPharmaMLURL2,
               ARepPharmaMLIDOfficine,
               ARepPharmaMLIDMagasin,
               ARepPharmaMLCle,             
               '0',
               intIDFournisseurContact,
         AFDCodeSel)
        returning t_fournisseur_id into intIDFournisseur;
      else
        intIDFournisseur := AIDFournisseurLGPI;
                              
        select t_contact_id, t_adresse_id
        into intIDFournisseurContactLGPI, intIDAdresseLGPI
        from erp.t_fournisseur
        where t_fournisseur_id = AIDFournisseurLGPI;

        update erp.t_fournisseur
        set raisonsociale = ARaisonSociale,
            commentaire = ACommentaire,
            --n171_identifiant = AN171Identifiant, -- plus utilisé
            --n171_noappel = AN171NumeroAppel,
            --n171_vitesse = AN171Vitesse,
            date_maj = sysdate,
            modetransmission = AModeTransmission,
            t_adresse_id = intIDAdresse,
            nofax = ANumeroFax,
--            foud_partenaire = AFDPartenaire,
--            foud_codepartenaire = AFDCodePartenaire,
            rep_defaut = ARepDefaut,
            rep_objectifcamensuel = ARepObjectifCAMensuel,
            pharmaml_ref_id = intIDPharmaRef,
            pharmaml_url1 = ARepPharmaMLURL1,
            pharmaml_url2 = ARepPharmaMLURL2,
            pharmaml_id_officine = ARepPharmaMLIDOfficine,
            pharmaml_id_magasin = ARepPharmaMLIDMagasin,
            pharmaml_cle = ARepPharmaMLCle,
            t_contact_id = intIDFournisseurContact
        where t_fournisseur_id = AIDFournisseurLGPI;          

        delete from erp.t_adresse where t_adresse_id = intIDAdresseLGPI;
        delete from erp.t_fournisseur_contact where t_fournisseur_contact_id = intIDFournisseurContactLGPI;
      end if;
    end if;
    
    return intIDFournisseur;
  exception
    when others then
      rollback to sp_fournisseurs;
      raise;
  end;

  /* ********************************************************************************************** */
   function creer_produit(AIDProduitLGPI in integer,
                         ACodeCIP in varchar2,
                         ACodesEAN in varchar2,
                         ADesignation in varchar2,
                         APrixAchatCatalogue in number,
                         APrixVente in number,
                         ABaseremboursement in number,
                         AEtat in char,
                         ADelaiViande in number,
                         ADelaiLait in number,
                         AGereInteressement in char,
                         ACommentaireVente in varchar2,
                         AEditionEtiquette in char,
                         ACommentaireCommande in varchar2,
                         ACommentaireGestion in varchar2,
                         APrestation in varchar2,
                         AGereSuiviClient in char,
                         ATauxTVA in number,
                         AListe in char,
                         ATracabilite in char,
                         ALotAchat in number,
                         ALotVente in number,
                         AStockMini in number,
                         AStockMaxi in number,
                         APAMP in number,
                         ATarifAchatUnique in char,
                         AProfilGS in char,
                         ACalculGS in char,
                         ANombreMoisCalcul in number,
                         AGerePFC in char,
                         ASoumisMDL in char,
                         AIDClassificationInterne in integer,
                         AConditionnement in number,
                         AMoyenneVente in number,
                         AUniteMoyenneVente in number,
                         ADateDerniereVente in date,
                         ADatePremiereVente in date,
                         AContenance in number,
                         AUniteMesure in char,
                         APrixAchatRemise in number,
                         AVeterinaire in char,
                         AServiceTips in varchar2,
                         ATypeHomeo in char,
                         AMarque in varchar2,
                         AIDRepartiteurExclusif in integer,
                         AQuantite in number,
                         AZoneGeographique in varchar2,
                         AStockMiniPharmacie in number,
                         AStockMaxiPharmacie in number,
                         ACodification1 in varchar2,
                         ACodification2 in varchar2,
                         ACodification3 in varchar2,
                         ACodification4 in varchar2,
                         ACodification5 in varchar2,
                         ADatePeremption in date,
                         APrixAchatMetropole in number,
                         APrixVenteMetropole in number,
                         ACodecip7 in varchar2,
                         AIDArticleRemise in number,
                         AFusion in char)
                        return integer
  as
    intIDTVA integer;
    lFtRemise erp.t_produitfournisseur.remise%type;
    intIDFusionProduit integer;
    lIntIDPrestation integer;
    lIntIDTVA integer;
    lStrMarque varchar2(50);
    ftCoeffMarge number(6, 3);
    ftTauxMarge number(5, 2);
    lCodecip13 varchar2(13);
    lDateDerniereVente date;
  begin
    savepoint sp_produits;

    if ( trim(ACodeCip) is null) or (trim(ACodeCip) = '0000000') then
      begin
        lCodeCIP13 := ACodeCIP7;
      end;
    end if;


    -- Recherche du produit si fusion   
    if AFusion = '1' then
      begin
        select t_produit_id,
               datedernvte  
        into intIDFusionProduit,
             lDateDerniereVente
        from erp.t_produit
        where (trim(codecip7) = trim(ACodeCIP7)
        or trim(codecip) = trim(ACodeCIP))
        and id_del is null;
      exception
        when no_data_found then
          begin
            begin
              begin
                execute immediate 'select distinct prd.t_produit_id, datedernvte
                                   from erp.t_code_ean13 ean 
                                   inner join erp.t_produit prd on prd.t_produit_id = ean.t_produit_id 
                                   where prd.d_del is null and ean.code_ean13 in '|| ACodesEan into intIDFusionProduit, lDateDerniereVente;  
              end;
            exception
              when no_data_found  then 
              begin
                intIDFusionProduit := null; 
              end;  
              when too_many_rows then 
              begin
                raise_application_error(-20202, 'Impossible de fusionner un produit qui est en doublon');  
              end;
              when others then 
              begin
                intIDFusionProduit := null; 
              end;  
            end;  
          end;
        when too_many_rows then
          raise_application_error(-20202, 'Impossible de fusionner un produit qui est en doublon');  
      end;
    else
      intIDFusionProduit := null;
    end if;
    
    -- Recherche de la prestation
    begin
      lIntIDPrestation := pk_commun.Prestations(APrestation).id;
    exception
      when no_data_found then
        lIntIDPrestation := pk_commun.IDPrestationPHN;
    end;
    
    -- Recherche de la TVA
    begin
      if ATauxTVA is not null then
        lIntIDTVA := TVAs(to_char(ATauxTVA, '999.999')).id;
      else
        lIntIDTVA := null;
      end if; 
    exception
      when no_data_found then
        lIntIDTVA := null;
    end;
    
    -- création du produit 
    if intIDFusionProduit is null then
      if AIDProduitLGPI is null then        
        insert into erp.t_produit(t_produit_id,
                                  codecip,
                                  designation,
                                  prixachatcatalogue,
                                  prixvente,
                                  baseremboursement,
                                  etat,
                                  delaiviande,
                                  delailait,
                                  gereinteressement,
                                  commentairevente,
                                  t_etiquette_model_id,
                                  commentairecommande,
                                  commentairegestion,
                                  t_prestation_id,
                                  geresuiviclient,
                                  t_tva_id,
                                  datedernmajproduit,
                                  liste,
                                  tracabilite,
                                  lotachat,
                                  lotvente,
                                  stockmini,
                                  stockmaxi,
                                  pamp,
                                  tarifachatunique,
                                  profilgs,
                                  calculgs,
                                  nbmoiscalcul,
                                  gerepfc,
                                  soumismdl,
                                  t_classificationint_id,
                                  t_forme_id,
                                  conditionnement,
                                  moyvte,
                                  umoyvte,
                                  datedernvte,
                                  datepremvte,
                                  contenance,
                                  unitemesure,
                                  prixachatremise,
                                  veterinaire,
                                  saisie_delai_veto,                              
                                  servicetips,
                                  typehomeo,
                                  video,
                                  t_codif1_id,
                                  t_codif2_id,
                                  t_codif3_id,
                                  t_codif4_id,
                                  t_codif5_id,
                                  t_codif6_id,
                                  dateperemption,
                                  datecreation,
                                  t_repartiteur_exclusif_id,
                                  prixvente_metro,
                                  prixachat_metro,
                                  baseremboursement_metro,
                                  codecip7)
        values(erp.seq_id_produit.nextval,
               nvl(trim(ACodecip),lcodecip13) ,
               ADesignation,
               APrixAchatCatalogue,
               APrixVente,
               ABaseRemboursement,
               AEtat,
               ADelaiViande,
               ADelaiLait,
               AGereInteressement,
               ACommentaireVente,
               null,--lIntEtiquetteModel,
               ACommentaireCommande,
               ACommentaireGestion,
               lIntIDPrestation,
               AGereSuiviClient,
               lIntIDTVA,
               sysdate,
               AListe,
               ATracabilite,
               ALotAchat,
               ALotVente,
               AStockMini,
               AStockMaxi,
               APAMP,
               ATarifAchatUnique,
               AProfilGS,
               ACalculGS,
               ANombreMoisCalcul,
               AGerePFC,
               ASoumisMDL,
               null,--lIntClassifInt,
               null,
               AConditionnement,
               AMoyenneVente,
               AUniteMoyenneVente,
               ADateDerniereVente,
               nvl(ADatePremiereVente,nvl(ADateDerniereVente-40,sysdate-40)), 
               AContenance,
               AUniteMesure,
               APrixAchatRemise,
               AVeterinaire,
               decode(AVeterinaire, '1', '1', '0'),
               AServiceTIPS,
               ATypeHomeo,
               '0',
               decode(AFusion, '0', creer_codification(1, ACodification1), null),
               decode(AFusion, '0', creer_codification(2, ACodification2), null),
               decode(AFusion, '0', creer_codification(3, ACodification3), null),
               decode(AFusion, '0', creer_codification(4, ACodification4), null),
               decode(AFusion, '0', creer_codification(5, ACodification5), null),
               decode(AFusion, '0', creer_codification(6, AMarque), null),
               ADateperemption,
               sysdate - interval '5' year,
               AIDRepartiteurExclusif,
               APrixVenteMetropole,
               APrixAchatMetropole,
               ABaseremboursement,
               ACodeCip7)          
               returning t_produit_id into intIDFusionProduit;
               
        if AFusion = '1' then        
          insert into migration.t_tmp_produit_fusionne values (intIDFusionProduit, 'C');
        end if;
      else
        intIDFusionProduit := AIDProduitLGPI;
        -- MISE A JOUR 
        update erp.t_produit
        set codecip = ACodeCIP,
            designation = ADesignation,
            prixachatcatalogue = APrixAchatCatalogue,
            prixvente = APrixVente,
            baseremboursement = ABaseRemboursement,
            etat = AEtat,
            delaiviande = ADelaiViande,
            delailait = ADelaiLait,
            gereinteressement = AGereInteressement,
            commentairevente = ACommentaireVente,
            --t_etiquette_model_id,
            commentairecommande = ACommentaireCommande,
            commentairegestion = ACommentaireGestion,
            t_prestation_id = lIntIDPrestation,
            geresuiviclient = AGereSuiviClient,
            t_tva_id = lIntIDTVA,
            datedernmajproduit = sysdate,
            liste = AListe,
            tracabilite = ATracabilite,
            lotachat = ALotAchat,
            lotvente = ALotVente,
            stockmini = AStockMini,
            stockmaxi = AStockMaxi,
            pamp = APAMP,
            tarifachatunique = ATarifAchatUnique,
            profilgs = AProfilGS,
            calculgs = ACalculGS,
            nbmoiscalcul = ANombreMoisCalcul,
            gerepfc = AGerePFc,
            soumismdl = ASoumisMDL,
            --t_classificationint_id,
            conditionnement = AConditionnement,
            moyvte = AMoyenneVente,
            umoyvte = AUniteMoyenneVente,
            datedernvte = ADateDerniereVente,
            contenance = AContenance,
            unitemesure = AUniteMesure,
            prixachatremise = APrixAchatRemise,
            veterinaire = AVeterinaire,
            saisie_delai_veto = decode(AVeterinaire, '1', '1', '0'),                              
            servicetips = AServiceTIPS,
            typehomeo = ATypeHomeo,
            t_codif1_id = creer_codification(1, ACodification1),
            t_codif2_id = creer_codification(2, ACodification2),
            t_codif3_id = creer_codification(3, ACodification3),
            t_codif4_id = creer_codification(4, ACodification4),
            t_codif5_id = creer_codification(5, ACodification5),
            t_codif6_id = creer_codification(6, AMarque),
            datecreation = nvl(ADateDerniereVente, sysdate),
            t_repartiteur_exclusif_id = AIDRepartiteurExclusif,
            prixvente_metro = APrixVenteMetropole,
            prixachat_metro = APrixAchatMetropole,
            codecip7 = ACodecip7
        where t_produit_id = AIDProduitLGPI;
        
        if ( substr(ACodecip,1,5) = '20000') then 
          insert into erp.t_code_ean13(t_code_ean13_id,
                                       t_produit_id,
                                       code_ean13)
          values(erp.seq_id_code_ean13.nextval,
                 AIDProduitLGPI,
                 ACodeCIP);
        end if;

      end if;
    elsif (AFusion = '1') then           
      -- SI FUSION maj des dates + maj des prix si options + on garde la ddv la plus recente ( la plus grande )
      update erp.t_produit
      set datedernmajproduit = sysdate,
          --profilgs = decode(AProfilGS,1,profilgs,AProfilGS),
          datedernvte = greatest(nvl(ADateDerniereVente, '01/01/1970'), nvl(lDateDerniereVente, '01/01/1970')),
          prixachatcatalogue = decode(pk_commun.Options.produits_ecraser_prix, '1', APrixAchatCatalogue, prixachatcatalogue),
          prixvente = decode(pk_commun.Options.produits_ecraser_prix, '1', APrixVente, prixvente),
          pamp = decode(pk_commun.Options.produits_ecraser_prix, '1', APAMP, pamp),
          prixachatremise = decode(pk_commun.Options.produits_ecraser_prix, '1', APrixAchatRemise, prixachatremise),
          prixvente_metro = decode(pk_commun.Options.produits_ecraser_prix, '1', APrixVenteMetropole, prixvente_metro),
          prixachat_metro = decode(pk_commun.Options.produits_ecraser_prix, '1', APrixAchatMetropole, prixachat_metro)
          --marge_taux = ftTauxMarge,
          --marge_coeff = ftCoeffMarge,
          --id_del = null,                    on ne réactive pas un produit effacé
          --d_del = null
      where t_produit_id = intIDFusionProduit;
      insert into migration.t_tmp_produit_fusionne values (intIDFusionProduit, 'F');
    end if;

    return intIDFusionProduit;
  exception
    when others then
      rollback to sp_produits;
      raise;
  end;


  /* ********************************************************************************************** */
    procedure creer_information_stock(AIDProduit in integer,
                                    AQuantite in number,
                                    AStockMini in number,
                                    AStockMaxi in number,
                                    AZoneGeographique in varchar2,
                                    AIDDepot in integer,
                                    AFusion in char default '0')
  as    
    intNbDepots integer; intDepotPharmacie integer;
    intIDZoneGeographique integer;
    boolCreationStock boolean; boolCreationDepotPharmacie boolean;
    chPrioriteFusion char(1);
    libelleDepot erp.t_depot.libelle%type;
    typeDepot erp.t_depot.type_depot%type;
  begin  
    savepoint sp_informations_stocks;  

    if ((AFusion = '1') and (pk_commun.Options.produits_fusionner_stock = '1') and (AQuantite > 0)) or (AFusion = '0') then
      select libelle, type_depot 
      into libelleDepot, typeDepot 
      from erp.t_depot 
      where t_depot_id = AIDDepot ; 

      -- la priorite est un priorite de réappro au sein d'un meme type de depot
      -- traditionnellement le depot AUTOMATE est prioritaire sur le depot PHARMACIE 
      
      -- PHARMACIE et AUTOMATE / ROBOT sont de type SUVE
      -- RESERVE de type SUAL_R 

      -- si fusion
      if AFusion = '1' then      
  
        -- verification existence du depot et recupe de sa prio 
        -- pour MAJ si besoin 
        -- !! un produit peut exister deux fois dans le meme depot (cas rare)
        
        begin 
          select count(*), min(priorite) 
          into intNbDepots, chPrioriteFusion
          from erp.t_produitgeographique
          where t_produit_id = AIDProduit and t_depot_id = AIDDepot
          group by t_depot_id, t_produit_id;
        exception
        when no_data_found then
          intNbDepots := 0;
        end;

        -- si c'est un depot reserve il faut qd mm creer un depot pharmacie vide
        if typeDepot <> 'SUVE' then
          select count(*)
          into intDepotPharmacie
          from erp.t_produitgeographique
          where t_produit_id = AIDProduit
          and priorite = 1;

          if intDepotPharmacie = 0 then
            boolCreationDepotPharmacie := true;
          else
            boolCreationDepotPharmacie := false;  
          end if;
        end if;
        -- si le depot existe 
        if intNbDepots >= 1 then
          boolCreationStock := false;
        else
          -- sinon ( si pas de depot )
          boolCreationStock := true;
        end if;
      -- fin si 1 depot
      else
        --sinon pas fusion     
        boolCreationStock := true;
      end if;
      -- fin si fusion

      if AFusion = '0' then
        intIDZoneGeographique := creer_zone_geographique(AZoneGeographique);    
      else
        intIDZoneGeographique := null;
      end if; 

      -- creation d un enregistrement         
      if boolCreationStock then
        insert into erp.t_produitgeographique(t_prodgeo_id,
                                              t_produit_id,
                                              stockmini,
                                              stockmaxi,
                                              priorite,
                                              datemajprodgeo,
                                              t_depot_id,
                                              t_zonegeo_id,
                                              quantite,
                                              date_der_inv,
                                              depotvente)
        values(erp.seq_id_produitgeographique.nextval,
               AIDProduit,
               AStockMini,
               AStockMaxi,
               decode(typeDepot,'SUVE','1','2'), -- on defini la priorite selon le type 
               sysdate,
               AIDDepot,
               intIDZoneGeographique,
               AQuantite,
               null,
               decode(typeDepot,'SUVE','1','0')); -- on defini la depotvente selon le type 
      else
        -- sinon MAJ     
        update erp.t_produitgeographique
        set quantite = (quantite + AQuantite),
            datemajprodgeo = sysdate
        where t_produit_id = AIDProduit
          and t_depot_id = AIDDepot
          and priorite = chPrioriteFusion;
      end if;
      --fin si    

      if boolCreationDepotPharmacie then
        insert into erp.t_produitgeographique(t_prodgeo_id,
                                              t_produit_id,
                                              stockmini,
                                              stockmaxi,
                                              priorite,
                                              datemajprodgeo,
                                              t_depot_id,
                                              quantite,
                                              date_der_inv,
                                              depotvente)
        values(erp.seq_id_produitgeographique.nextval,
               AIDProduit,
               0,
               0,
               '1',
               sysdate,
               Depots('PHARMACIE'),
               0,
               null,
               '1');    
      end if;  
    end if;     

  exception
    when others then
      rollback to sp_informations_stocks;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_code_ean13(AIDProduit in integer,
                             ACodeEAN13 in varchar2,
                             AReferent in integer,
                             AFusion in char)
  as
    intNbProduits integer;
  begin
    savepoint sp_code_ean13;

    if AFusion = '1' then
      select count(*)
      into intNbProduits
      from migration.t_tmp_produit_fusionne
      where t_produit_id = AIDProduit
        and etat in ( 'C');
    else
      intNbProduits := 1;
    end if;
    
    if intNbProduits > 0 then
      insert into erp.t_code_ean13(t_code_ean13_id,
                                   t_produit_id,
                                   code_ean13,
                                   referent)
      values(erp.seq_id_code_ean13.nextval,
             AIDProduit,
             ACodeEAN13,
             AReferent);
    end if;
  exception
    when others then
      rollback to sp_code_ean13;
  end;

  /* ********************************************************************************************** */
  procedure creer_code_lpp(AIDProduit in integer,
                           ATypeCode in char,
                           ACodeLPP in varchar2,
                           AQuantite in number,
                           ATarifUnitaire in number,
                           APrestation in varchar2,
                           AService in char,
                           AFusion in char)
  as
    intNbProduits integer;
    intIDPrestation integer;
  begin
    savepoint sp_code_lpp;
    
    if AFusion = '1' then
      select count(*)
      into intNbProduits
      from migration.t_tmp_produit_fusionne
      where t_produit_id = AIDProduit
        and etat in ('C');
    else
      intNbProduits := 1;
    end if;
    
    if intNbProduits > 0 then
      if ATypeCode = 1 then
        -- Recherche de la prestation
        begin
          intIDPrestation := pk_commun.Prestations(APrestation).id;
        exception
          when no_data_found then
            intIDPrestation := pk_commun.IDPrestationPHN;
        end;
      else
        intIDPrestation := null;
      end if;
      
      insert into erp.t_produit_lpp(t_produit_lpp_id,
                                    t_produit_id,
                                    typecode,
                                    code_lpp,
                                    qte,
                                    tarif_unitaire,
                                    t_prestation_id,
                                    service,
                                    date_maj)
      values(erp.seq_t_produit_lpp.nextval,
             AIDProduit,
             ATypeCode,
             ACodeLPP,
             AQuantite,
             ATarifUnitaire,
             intIDPrestation,
             AService,
             sysdate);
    end if;
  exception
    when others then
      rollback to sp_code_lpp;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_historique_vente(AIDProduit in integer,
                                   APeriode in varchar,
                                   AQuantiteVendues in number,
                                   AQuantiteActes in number,
                                   AFusion in char default '0')
  as
    h integer;
    
    procedure inserer_historique_vente as
    begin
      insert into erp.t_historiquevente(t_historiquevente_id,
                                      annee,
                                      mois,
                                      qtevendue,
                                      nbventes,
                                      datemajhistvte,
                                      t_produit_id,
                                      moisannee)
       values(erp.seq_id_historiquevente.nextval,
           substr(APeriode, 3, 4),
           substr(APeriode, 1, 2),
           AQuantiteVendues,
           AQuantiteActes,
           sysdate,
           AIDProduit,
           to_date('01' || APeriode, 'DDMMYYYY'));
    end;    
  begin
    savepoint sp_historique_ventes;

      if AFusion = '1' then 
         begin
        select t_historiquevente_id
        into h
        from erp.t_historiquevente
        where t_produit_id  = AIDProduit 
          and moisannee = to_date('01' || APeriode, 'DDMMYYYY') ;

        update erp.t_historiquevente 
        set qtevendue = qtevendue + AQuantiteVendues,
            nbventes = nbventes + AQuantiteActes
        where t_historiquevente_id = h;
      exception
        when no_data_found then
          inserer_historique_vente;
      end;
      else
      inserer_historique_vente;
     end if;
  exception
    when others then
      rollback to sp_historique_ventes;
      raise;
  end;

  /* ********************************************************************************************** */
  function creer_catalogue(AIDCatalogueLGPI in integer,
                           ADesignation in varchar2,
                           ADateDebut in date,
                           ADateFin in date,
                           AIDFournisseur in integer,
                           ADateCreation in date,
                           ADateFinValidite in date)
                          return integer
  as
    lIntCatalogue integer;
  begin
    savepoint sp_catalogues;
    
    insert into erp.t_catalogue_entete(t_catalogue_id,
                                       designation,
                                       date_debut,
                                       date_fin,
                                       t_fournisseur_id,
                                       date_creation,
                                       date_maj,
                                       date_fin_validite)
    values(erp.seq_id_catalogue_entete.nextval,
           ADesignation,
           ADateDebut,
           ADateFin,
           AIDFournisseur,
           ADateCreation,
           sysdate,
           ADateFinValidite)
    returning t_catalogue_id into lIntCatalogue;
    
    return lIntCatalogue;
  exception
    when others then
      rollback to sp_catalogues;
      raise;
  end;
  
  /* ********************************************************************************************** */
  function creer_classif_fournisseur(AIDClassifFournisseurLGPI in integer,
                                     ADesignation in varchar2,
                                     ADateDebutMarche in date,
                                     ADureeMarche in number,
                                     AIDClassificationParent in integer,
                                     AIDCatalogue in integer)
                                    return integer
  as
    lIntClassifFournisseur integer;
  begin
    savepoint sp_classif_fournisseurs;
    
    insert into erp.t_classif_fournisseur(t_classif_fournisseur_id,
                                          libelle,
                                          rfa_valeur_objectif,
                                          date_deb_marche,
                                          duree_marche,
                                          t_classif_parent_id,
                                          date_maj,
                                          t_catalogue_id)
    values(erp.seq_id_classif_fournisseur.nextval,
           ADesignation,
           0,
           ADateDebutMarche,
           ADureeMarche,
           AIDClassificationParent,
           sysdate,
           AIDCatalogue)
    returning t_classif_fournisseur_id into lIntClassifFournisseur;
    
    return lIntClassifFournisseur;
  exception
    when others then
      rollback to sp_classif_fournisseurs;
      raise;
  end;
  
  /* ********************************************************************************************** */
  function creer_classif_interne(AIDClassifInterneLGPI in integer,
                                 ALibelle in varchar2,
                                 AIDClassificationParent in integer,
                                 AIDClassificationParentLGPI in integer,
                                 ATauxMArque in number)
                                return integer
  as
    lIntClassifInterne integer;
  begin
    savepoint sp_classif_internes;
    
    insert into erp.t_classificationinterne(t_classificationinterne_id,
                                     libelle,
                                     id_classif_parent,
                                     datemajclassinterne,
                                     tauxmarque,
                                     tauxmarge)
    values(erp.seq_id_classificationinterne.nextval,
           ALibelle,
           AIDClassificationParentLGPI,
           sysdate,
           nvl(ATauxMarque,0),
           0)
    returning t_classificationinterne_id into lIntClassifInterne;
    
    return lIntClassifInterne;
  exception
    when others then
      rollback to sp_classif_internes;
      raise;
  end;


  /* ********************************************************************************************** */
  procedure creer_ligne_catalogue(AIDCatalogue in integer,
                                  ANoLigne in number,
                                  AIDProduit in integer,
                                  AQuantite in number,
                                  AIDClassificationFournisseur in integer,
                                  APrixAchatCatalogue in number,
                                  APrixAchatRemise in number,
                                  ARemiseSimple in number,
                                  ADateMAJTarif in date,
                                  ADateCreation in date,
                                  AColisage in number)
  as
  lintGereOfficentral integer;
  lintIDFournisseur integer;
  lDesignation  erp.t_produit.designation%type;
  lCodecip13 erp.t_produit.codecip%type;
  lCodecip7 erp.t_produit.codecip7%type;
  lCodeEAN13 erp.t_code_ean13.code_ean13%type;
  lTva erp.t_tva.tauxtva%type;
  lPrestation erp.t_prestation.code%type;
  

 nb integer;
  begin
    savepoint sp_ligne_catalogue;
    
    insert into erp.t_catalogue_ligne(t_lignecatalogue_id,
                                      no_ligne,
                                      prixachatcatalogue,
                                      prix_achat_remise,
                                      remisesimple,
                                      date_maj_tarif,
                                      t_gamme_id,
                                      t_catalogue_id,
                                      date_creation,
                                      date_maj,
                                      colisage)
    values(erp.seq_id_catalogue_ligne.nextval,
           ANoLigne,
           APrixAchatCatalogue,
           APrixAchatRemise,
           ARemiseSimple,
           sysdate,
           AIDClassificationFournisseur,
           AIDCatalogue,
           ADateMAJTarif,
           sysdate,
           AColisage);
  
  select t_fournisseur_id, decode(foud_codesel,null,0,1)  
  into lintIDFournisseur, lintGereOfficentral
  from erp.t_fournisseur
  where t_fournisseur_id = ( select t_fournisseur_id from erp.t_catalogue_entete where t_catalogue_id = AIDCatalogue);

   select count(*)
   into nb
   from erp.t_lignecatalogue_suite
   where t_fournisseur_id = lIntIDFournisseur
   and t_produit_id = AIDProduit;
 
    if (nb = 0) then
     insert into  erp.t_lignecatalogue_suite(t_lignecataloguesuite_id,
                 t_fournisseur_id,
                 t_produit_id,
                 gere_officentral,
                 prix_revient,
                 date_creation,
                 date_maj,
                 marge_taux_revient,
                 marge_coeff_revient                       
                 )
     values(erp.seq_id_lignecatalogue_suite.nextval,
         lintIDFournisseur,
         AIDProduit,
         lintGereOfficentral,
         0,
         ADateCreation,
         sysdate,
         0,
         0);
    end if;
       
    select prd.designation, prd.codecip, prd.codecip7, ean.code_ean13, tva.tauxtva, pre.code
    into lDesignation, lCodeCIP13, lCodecip7, lCodeEAN13, lTva, lPrestation
    from erp.t_produit prd
    left join ( select t_produit_id , min(code_ean13) code_ean13 from erp.t_code_ean13  group by t_produit_id ) ean on (  ean.t_produit_id = prd.t_produit_id   )     
    left join  erp.t_tva tva on tva.t_tva_id = prd.t_tva_id 
    left join  erp.t_prestation pre on pre.t_prestation_id = prd.t_prestation_id
    where prd.t_produit_id = AIDProduit  ;  

    insert into erp.t_catalogue_produit(t_produitcatalogue_id,
                                        designation,
                                        prixachatht,
                                        tva,
                                        prestation,
                                        cipacl,
                                        ean13,
                                        date_creation,
                                        date_maj,
                                        prixachat_grossiste,
                                        prixachat_fabricant
      )
    values(erp.seq_id_catalogue_produit.nextval,
           lDesignation, 
           APrixAchatRemise,
           lTva,
           lPrestation,
           nvl(lCodecip13,lCodecip7),
           lCodeEAN13,
           ADateMAJTarif,
           sysdate,
           0,
           0
    );     
    insert into erp.t_catalogue_reference(t_referencecatalogue_id,
                                          t_lignecatalogue_id,
                                          t_produitcatalogue_id,
                                          t_produit_id,
                                          quantite,
                                          date_creation,
                                          date_maj)
    values(erp.seq_id_catalogue_reference.nextval,
           erp.seq_id_catalogue_ligne.currval,
           erp.seq_id_catalogue_produit.currval,
           AIDProduit,
           AQuantite,
           ADateCreation,
           sysdate);
 


  exception
    when others then
      rollback to sp_ligne_catalogue;
      raise;
  end;


  /* ********************************************************************************************** */
  function creer_promotion(AIDPromotionLGPI in integer,
                           ALibelle in varchar2,
                           ADateDebut in date,
                           ADateFin in date,
                           ACommentaire in varchar2,
                           ANombreLotsAffectes in number,
                           AStockAlerte in number,
                           ANombreLotsVendus in number,
                           ADateCreation in date)
                          return integer
  as
    intIDPromotion integer;
  begin
    savepoint sp_promotions;

    if AIDPromotionLGPI is null then
      insert into erp.t_promotion(t_promotion_id,
                                  libelle,
                                  datedebut,
                                  datefin,
                                  commentaire,
                                  nblotsaffectes,
                                  stockalerte,
                                  nblotsvendus,
                                  datecreation,
                                  datemajpromotion)
      values(erp.seq_id_promotion.nextval,
             ALibelle,
             ADateDebut,
             ADateFin,
             ACommentaire,
             ANombreLotsAffectes,
             AStockAlerte,
             ANombreLotsVendus,
             ADateCreation,
             sysdate)
      returning t_promotion_id into intIDPromotion;
    else
      intIDPromotion := AIDPromotionLGPI;
      
      update erp.t_promotion
      set libelle = ALibelle,
          datedebut = ADateDebut,
          datefin = ADateFin,
          commentaire = ACommentaire,
          nblotsaffectes = ANombreLotsAffectes,
          stockalerte = AStockAlerte,
          nblotsvendus = ANombreLotsVendus,
          datecreation = ADateCreation,
          datemajpromotion = sysdate
      where t_promotion_id = AIDPromotionLGPI;
      
      delete from erp.t_produitpromotion where t_promotion_id = AIDPromotionLGPI;
    end if;
    
    return intIDPromotion; 
  exception
    when others then
      rollback to sp_promotions;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_produit_promotion(AIDProduit in integer,
                                   AIDPromotion in integer,
                                   ADeclencheur in char,
                                   AQuantite in number,
                                   APrixVente in number,
                                   ARemise in number,
                                   APrixVenteRemise in number)
  as
  begin
    savepoint sp_produits_promotions;

    insert into erp.t_produitpromotion(t_produitpromotion_id,
                                       declencheur,
                                       qte,
                                       prixvente,
                                       remise,
                                       prixvremise,
                                       datemajprodpromo,
                                       t_promotion_id,
                                       t_produit_id)
    values(erp.seq_id_produitpromotion.nextval,
           ADeclencheur,
           AQuantite,
           APrixVente,
           ARemise,
           APrixVenteRemise,
           sysdate,
           AIDPromotion,
           AIDProduit);
  exception
    when others then
      rollback to sp_produits_promotions;
      raise;
  end;

  /* ********************************************************************************************** */
  function creer_commande(AIDCommandeLGPI in integer,
                          ANumero in integer,
                          AModeTransmission in char,
                          ADateCreation in date,
                          AMontantHt in number,
                          ACommentaire in varchar2,
                          AIDFournisseur in integer,
                          AIDRepartiteur in integer,
                          AEtat in varchar2,
                          ADateReception in date,
                          ADateReceptionPrevue in date)
                         return integer as
    intIDCommande integer;
  begin
    savepoint sp_commandes;

    if AIDCommandeLGPI is null then
      insert into erp.t_commande(t_commande_id,
                                 datecreation,
                                 modetransmission,
                                 datetransmission,
                                 datereceptionprevue,
                                 datereception,
                                 commentaire,
                                 montantht,
                                 escompte,
                                 etat,
                                 datemajcommande,
                                 t_fournisseur_id,
                                 remise,
                                 numero)
      values(erp.seq_id_commande.nextval,
             ADateCreation,
             AModeTransmission,
             ADateCreation,
             coalesce(ADateReceptionPrevue, ADateReception),
             ADateReception,
             ACommentaire,
             AMontantHt,
             0,
             AEtat,
             sysdate,
             nvl(AIDFournisseur, AIDRepartiteur),
             0,
             nvl(ANumero,erp.seq_no_commande.nextval)
             )
      returning t_commande_id into intIDCommande;
    else
      intIDCommande := AIDCommandeLGPI;
      
      update erp.t_commande
      set numero = nvl(ANumero,erp.seq_no_commande.nextval),
          datecreation = ADateCreation,
          modetransmission = AModeTransmission,
          datetransmission = ADateCreation,
          datereceptionprevue = ADateReception,
          datereception = ADateReception,
          montantht = AMontantHt,
          etat = AEtat,
          datemajcommande = sysdate,
          t_fournisseur_id = nvl(AIDFournisseur, AIDRepartiteur)
      where t_commande_id = AIDCommandeLGPI;
      
      delete from erp.t_lignecommande where t_commande_id = AIDCommandeLGPI;
    end if;
    
    return intIDCommande;
  exception
    when others then
      rollback to sp_commandes;
      raise;
  end;
  
  /* ********************************************************************************************** */
  procedure creer_ligne_commande(AIDCommande in integer,
                                 ADateCreation in date,
                                 AIDFournisseur in number,
                                 AIDRepartiteur in number,
                                 AIDProduit in number,
                                 AQuantiteCommandee in number,
                                 AQuantiteRecue in number,
                                 AQuantiteTotaleRecue in number,
                                 APrixAchatTarif in number,
                                 APrixAchatRemise in number,
                                 APrixVente in number,
                                 AChoixReliquat in number,
                                 AUnitesGratuites in number,
                                 AEtat varchar2,
                                 AReceptionFinanciere in char,
                                 AColisage in number,
                                 ADateReceptionPrevue in date)
  as                                 
    intTVA integer;
    d date;
    f number(5,2);
    lFtTauxTVA number(5,2);
  lmargecoeff number(6,3);
  lmargetaux number(5,2);
  lmargecoeffremise number(6,3);
  lmargetauxremise number(5,2);
  lmargecoeffrevient number(6,3);
  lmargetauxrevient number(5,2);
  lprixachatremiseug number(10,3);
  lprixrevient number(10,3);
  n integer;
  ldatereception date;
    
    function calculer_remise(APrixAchatCatalogue in number, APrixAchatRemise in number) return number
    as
      lFtRemise number(5,2);
    begin
      begin
        if (APrixAchatRemise > 0) and (APrixAchatCatalogue > 0) and (APrixAchatRemise < APrixAchatCatalogue) then
          lFtRemise := 100-((APrixAchatRemise/APrixAchatCatalogue)*100);

          if lFtRemise > 100 then
            lFtRemise := 100;
          elsif lFtRemise < 0 then
            lFtRemise := 0;
          end if;
        else
          lFtRemise := 0;
        end if;
      exception
        when value_error then
          lFtRemise := 0;
      end;
      
      return lFtRemise;
    end;

    function calculer_marge_taux(APrixVente in number, APrixAchat in number, AIDTva in integer) return number
    as
      lFtMargeTaux number(5,2);
    lPrixVenteHT erp.T_PRODUIT.PRIXVENTE%TYPE;
    lTva number(5,2);
    begin
      begin
        lFtMargeTaux := 0;
    
      begin
      select tauxTva
      into lTva
      from erp.t_tva
      where t_tva_id = AIDTva;
    exception
    when no_data_found then
      lTVA := null;
    end; 
      
      lPrixVenteHT := round(APrixVente / (1 + (lTva / 100)), 3);
    
        if (lprixVenteHT != 0) then
            lFtMargeTaux := ((lPrixVenteHT - APrixAchat) / lPrixVenteHT) * 100;
        end if;

        if (lFtMargeTaux < 0 or lFtMargeTaux > 100) then
            lFtMargeTaux := 0;
        end if;
      exception
        when value_error then
          lFtMargeTaux := 0;
      end;
      
      return lFtMargeTaux;
    end;
 
    function calculer_marge_coeff(APrixVente in number, APrixAchat in number) return number
    as
      lFtMargeCoeff number(6,3);
    begin
      begin
        lFtMargeCoeff := 0;
    
    
        if (APrixAchat != 0) then
           lFtMargeCoeff := APrixVente / APrixAchat;
    else 
      return lFtMargeCoeff ;
        end if;

        if (lFtMargeCoeff  > 999.999) then
            lFtMargeCoeff := 0;
        end if;
      exception
        when value_error then
          lFtMargeCoeff := 0;
      end;
      
      return lFtMargeCoeff;
    end;
 
  begin
    savepoint sp_lignes_commandes;

    -- Création information prix
    f := calculer_remise(APrixAchatTarif, APrixAchatRemise);
    
    if (AIDRepartiteur is not null) then
      select max(datereceptionprevue)
      into d
      from erp.t_lignecommande
      where t_produit_id = AIDProduit
        and t_fournisseur_id = AIDRepartiteur;
      
      if (d > ADateCreation) then
        select count(*)
        into n
        from erp.t_produit_repart_typeprix
        where t_produit_id = AIDProduit
          and t_fournisseur_id = AIDRepartiteur;
          
        if (n > 0) then
          update erp.t_produit_repart_typeprix
          set prixachatcatalogue = APrixAchatTarif,
              prixachatremise = APrixAchatRemise,
              remise = f
          where t_produit_id = AIDProduit
            and t_fournisseur_id = AIDRepartiteur;
        else
          insert into erp.t_produit_repart_typeprix(t_produit_id,
                                                    t_fournisseur_id,
                                                    type_prix,
                                                    marge_taux,
                                                    marge_coeff,
                                                    prixachatcatalogue,
                                                    prixachatremise,
                                                    remise,
                                                    datecreation,
                                                    datemodification)
          values(AIDProduit,
                 AIDRepartiteur,
                 '1',
                 0,
                 0,
                 APrixAchatTarif,
                 APrixAchatRemise,
                 f,
                 sysdate,
                 sysdate);
        end if;
      end if;
    end if;

    begin
      select p.t_tva_id, t.tauxtva
      into intTVA, lFtTauxTVA
      from erp.t_produit p 
      left join erp.t_tva t on p.t_tva_id = t.t_tva_id
      where p.t_produit_id = AIDProduit;
    exception
      when no_data_found then
      begin
        intTVA := null;
        lftTauxTVA := null;
      end;  
    end;
    
  if ( AQuantiteCommandee <> 0 ) then
    lprixachatremiseug := round(APrixAchatRemise*AQuantiteCommandee/(AQuantiteCommandee+AUnitesGratuites),3) ;
  else
    lprixachatremiseug := APrixAchatRemise ;
  end if ;  
  
  lprixrevient := lprixachatremiseug ;  
  
  lmargetaux :=  calculer_marge_taux( APrixvente, APrixAchatTarif, intTva );  
  lmargecoeff := calculer_marge_coeff( APrixVente, APrixAchatTarif );
  lmargetauxremise :=  calculer_marge_taux( APrixvente, APrixAchatRemise, intTva ); 
  lmargecoeffremise := calculer_marge_coeff( APrixVente, APrixAchatRemise );
  lmargetauxrevient :=  calculer_marge_taux( APrixVente, lprixrevient, intTva );  
  lmargecoeffrevient := calculer_marge_coeff( APrixVente, lprixrevient );
  
  if ( Aetat in ( 22, 3 ) ) then  
    select datereception 
    into ldatereception
    from erp.t_commande 
    where t_commande_id = AIDCommande;
  end if;

  -- pour une commande ou tous les produits sont arrivés ( etat = 22, 3 ) archivée ou reception financiere
  -- une ligne de commande par produit 
  -- avec qtecdee = qterecue = qtetotalerecue
  -- avec une date de reception dans DATERECEPTIONQUANTITATIVE
  -- RECEPTIONNEE_QUANT_PAR_OP avec un id 

  -- pour une commande partiellement receptionnée ( etat 2,21 ) 
  -- 2 lignes de commandes par produit
  -- 1ere ligne avec qtecdee = qterecue = qtetotalerecue = qte effectivement recue
  -- 2 eme avec qtecdee = qte encore attendue,  qterecue = 0  qtetotalerecue =0
  -- la somme des QTECDEE = QTE ORIGINALE Commandée
  -- RECEPTIONNEE_QUANT_PAR_OP null


-- partie receptionnée
    insert into erp.t_lignecommande(t_lignecommande_id,
                                    qtecdee,
                                    qteug,
                                    qtestockreception,
                                    qterecue,
                                    qtetotalerecue,
                                    receptionnee_quant_par_op,
                                    prixachattarif,
                                    prixachatremise,
                                    qtemanquantvente,
                                    choixreliquat,
                                    receptionfinanciere,
                                    datereceptionfinanciere,
                                    datereceptionquantitative,
                                    retourmanquanttrans,
                                    datemajligcde,
                                    t_produit_id,
                                    t_ligcde_manquant_id,
                                    t_fournisseur_id,
                                    t_commande_id,
                                    t_planification_id,
                                    qteetiquette,
                                    prixvente,
                                    prixvente_metro,
                                    remise,
                                    remise_catalogue,
                                    datereceptionprevue,
                                    t_postedetravail_id,
                                    majpv,
                                    t_tva_id,
                                    tauxtva,
                                    colisage,
                                    prixachatcatalogueremise,
                                    prixachatcatalogue,
                                    prixachatremiseug,
                                    prixrevient,
                                    marge_taux,
                                    marge_coeff,
                                    marge_taux_remise,
                                    marge_coeff_remise,
                                    marge_taux_revient,
                                    marge_coeff_revient
                  )
      values(erp.seq_id_lignecommande.nextval,
             AQuantiteRecue, -- attention correspond a la quantite qui RESTE a recevoir 2.13 !
             AUnitesGratuites,
             0,
             AQuantiteRecue, 
             AQuantiteTotaleRecue,
             pk_commun.IDOperateurPoint, --receptionnee_quant_par_op theoriquement ID operateur pk_commun.IDOperateurPoint ?
             APrixAchatTarif,
             APrixAchatRemise,
             0,
             AChoixReliquat,
             decode(AEtat,3,1,AReceptionFinanciere), -- si commande archivée on a forcement une date de recept finanicere
             decode(AEtat,3,ldatereception,null),
             ldatereception,
             0,
             sysdate,
             AIDProduit,
             null,
             nvl(AIDFournisseur, AIDRepartiteur),
             AIDCommande,
             null,
             0,
             APrixVente,
             APrixVente,
             f,
             f,
             coalesce(ADateReceptionPrevue, ADateCreation),
             pk_commun.IDPoste0,
             '1',
             intTVA,
             lFtTauxTVA,
             AColisage,
             APrixAchatRemise,
             APrixAchatTarif,
             lprixrevient,
             lprixrevient,
             lmargetaux,
             lmargecoeff,
             lmargetauxremise,
             lmargecoeffremise,
             lmargetauxrevient,
             lmargecoeffrevient
       );

 -- partie NON receptionnée
 -- inutile de creer un ligne si ZERO attendu
  if (( Aetat in ( 2, 21 ) ) and (AQuantiteCommandee - AQuantiteRecue > 0)) then  
    insert into erp.t_lignecommande(t_lignecommande_id,
                                    qtecdee,
                                    qteug,
                                    qtestockreception,
                                    qterecue,
                                    qtetotalerecue,
                                    prixachattarif,
                                    prixachatremise,
                                    qtemanquantvente,
                                    choixreliquat,
                                    receptionfinanciere,
                                    datereceptionfinanciere,
                                    datereceptionquantitative,
                                    retourmanquanttrans,
                                    datemajligcde,
                                    t_produit_id,
                                    t_ligcde_manquant_id,
                                    t_fournisseur_id,
                                    t_commande_id,
                                    t_planification_id,
                                    qteetiquette,
                                    prixvente,
                                    prixvente_metro,
                                    remise,
                                    remise_catalogue,
                                    datereceptionprevue,
                                    t_postedetravail_id,
                                    majpv,
                                    t_tva_id,
                                    tauxtva,
                                    colisage,
                                    prixachatcatalogueremise,
                                    prixachatcatalogue,
                                    prixachatremiseug,
                                    prixrevient,
                                    marge_taux,
                                    marge_coeff,
                                    marge_taux_remise,
                                    marge_coeff_remise,
                                    marge_taux_revient,
                                    marge_coeff_revient
                  )
      values(erp.seq_id_lignecommande.nextval,
             AQuantiteCommandee - AQuantiteRecue, -- attention correspond a la quantite qui RESTE a recevoir 2.13 !
             AUnitesGratuites,
             0,
             0, -- qterecue
             0, -- qtetotalerecue
             APrixAchatTarif,
             APrixAchatRemise,
             0,
             AChoixReliquat,
             AReceptionFinanciere, 
             null,
             null, -- datereceptionquantitative
             0,
             sysdate,
             AIDProduit,
             null,
             nvl(AIDFournisseur, AIDRepartiteur),
             AIDCommande,
             null,
             0,
             APrixVente,
             APrixVente,
             f,
             f,
             coalesce(ADateReceptionPrevue, ADateCreation),
             pk_commun.IDPoste0,
             '1',
             intTVA,
             lFtTauxTVA,
             AColisage,
             APrixAchatRemise,
             APrixAchatTarif,
             lprixrevient,
             lprixrevient,
             lmargetaux,
             lmargecoeff,
             lmargetauxremise,
             lmargecoeffremise,
             lmargetauxrevient,
             lmargecoeffrevient
       );

  end if;




  exception
    when others then
      rollback to sp_lignes_commandes;
      raise;
  end;
 
  procedure creer_histo_stock(AIDFournisseur in integer,
                              AMois in number,
                              AAnnee in number,
                              AValeurStock in number)
  as
  begin
    savepoint sp_g9_historique_stock;
  
    insert into erp.t_g9_historique_stock(t_g9_historique_stock_id,
                                          t_fournisseur_id,
                                          mois,
                                          annee,
                                          valeur_stock)
    values(erp.seq_g9_historique_stock.nextval,
           AIDFournisseur,
           AMois,
           AAnnee,
           AValeurStock);
  exception
    when others then
      rollback to sp_g9_historique_stock;
      raise;
  end;
  
  procedure maj_commandes
  as
    lNumero integer;
  begin
    -- update erp.t_lignecommande   REDONDANT avec decode(AEtat,3,1,AReceptionFinanciere)
    -- set receptionfinanciere = 1
    -- where t_commande_id in (select t_commande_id
    --                         from erp.t_commande
    --                         where etat = 3);
    

    -- new initialisation de la sequence 
  -- recupe du plus gros numero de commande
    begin
      select max(numero)
      into lNumero
      from erp.t_commande  ;
    exception
      when no_data_found then
        lNumero := 0; 
    end;  

  pk_supprimer.initialiser_sequence('erp.seq_no_commande', lNumero);

    -- commandes en attentes de reception
    insert into erp.t_lignecommande_livraison(id_seq,
                                              date_maj,
                                              t_lignecommande_id,
                                              qtecdee,
                                              qteug,
                                              datereceptionprevue,
                                              choixreliquat,
                                              qterecue,
                                              qtetotalerecue)
    select erp.seq_lignecommande_livraison.nextval,
              sysdate,
              l.t_lignecommande_id,
              l.qtecdee,
              l.qteug,
              l.datereceptionprevue,
              l.choixreliquat,
              l.qterecue,
              l.qtetotalerecue
        from erp.t_lignecommande l
            inner join erp.t_commande c on (c.t_commande_id = l.t_commande_id)
            left join erp.t_lignecommande_livraison lcl on ( l.t_lignecommande_id = lcl.t_lignecommande_id )
            where lcl.t_lignecommande_id is null ; 
           
    -- gestion des reliquat flag a mettre a 1 dans toutes les commandes archivés dont les qte recues sont incompletes
    update erp.t_lignecommande_livraison
    set choixreliquat = 1
    where t_lignecommande_id in (select t_lignecommande_id
                                  from erp.t_lignecommande
                                  where qtecdee > 0
                                  and qtecdee > qtetotalerecue
                                  and choixreliquat = 0
                                  and t_commande_id in (select t_commande_id
                                                        from erp.t_commande
                                                        where etat = 3));

    

    update erp.t_lignecommande
    set choixreliquat = 1
    where qtecdee > 0
    and qtecdee > qtetotalerecue
    and choixreliquat = 0
    and t_commande_id in (select t_commande_id
                          from erp.t_commande
                          where etat = 3);

    --execute immediate 'analyze table erp.t_commande estimate statistics sample 33 percent';
    --execute immediate 'analyze table erp.t_lignecommande estimate statistics sample 33 percent';


    DBMS_STATS.GATHER_SCHEMA_STATS(
     ownname => 'ERP',
     Estimate_Percent => 30,
     Cascade => true,
     Method_Opt => 'FOR ALL COLUMNS SIZE 1',
     no_invalidate => false
     );

  end;
    
begin
  -- Depots
  for cr_dep in (select t_depot_id, upper(libelle) libelle from erp.t_depot) loop
    Depots(cr_dep.libelle) := cr_dep.t_depot_id;
  end loop;

  -- TVAs
  for cr_tva in (select t_tva_id, to_char(tauxtva, '999.999') tauxtva, soumismdl from erp.t_tva) loop
    TVAs(cr_tva.tauxtva).id := cr_tva.t_tva_id;
    TVAs(cr_tva.tauxtva).soumismdl := cr_tva.soumismdl;
  end loop;

  -- Zones gographiques
  for cr_zg in (select t_zonegeo_id, libelle from erp.t_zonegeographique) loop
    ZonesGeographiques(cr_zg.libelle) := cr_zg.t_zonegeo_id;
  end loop;

  -- Codifs. libres
  for cr_cdf in (select 1 rang, t_codif1_id t_codif_id, libelle from erp.t_codif1
                 union
                 select 2, t_codif2_id, libelle from erp.t_codif2
                 union
                 select 3, t_codif3_id, libelle from erp.t_codif3
                 union
                 select 4, t_codif4_id, libelle from erp.t_codif4
                 union
                 select 5, t_codif5_id, libelle from erp.t_codif5
                 union
                 select 6, t_codif6_id, libelle from erp.t_codif6) loop
    Codifications(cr_cdf.rang)(cr_cdf.libelle) := cr_cdf.t_codif_id;
  end loop;
end; 
/