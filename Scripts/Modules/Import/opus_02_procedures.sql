set sql dialect 3;

create exception exp_opus_produit_exist 'Le produit n''existe pas !';

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 101) then
    delete from t_opus_tva;
end;




create or alter procedure ps_supprimer_donnees_pha(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 0) then
  begin
    delete from t_ponderation;
    delete from t_rotation;

    delete from t_parametre;
  end
  else
    if (ATypeSuppression = 1) then
    begin
      delete from t_praticien;
      delete from t_hopital;
    end
    else
      if (ATypeSuppression = 2) then
      begin
        delete from t_couverture_amo where t_organisme_amo_id is null;
        delete from t_couverture_amc where t_organisme_amc_id is null;
        delete from t_organisme;
        delete from t_destinataire;
      end
      else
        if (ATypeSuppression = 3) then
        begin
          delete from t_client;
          delete from t_compte;
          delete from t_profil_remise;
          delete from t_param_remise_fixe;
          delete from t_profil_edition;
          delete from t_commentaire where type_entite = 0;
        end
        else
          if (ATypeSuppression = 4) then
          begin    
            delete from t_article_remise;        
            delete from t_commande;
            delete from t_promotion_entete;
            delete from t_classification_fournisseur where t_classification_parent_id is not null;
            delete from t_classification_fournisseur;
            delete from t_catalogue;
            delete from t_produit;
            delete from t_fournisseur_direct;
            delete from t_repartiteur;
            delete from t_classification_interne;
            delete from t_codification;
            delete from t_zone_geographique;
          end
          else
            if (ATypeSuppression = 5) then
            begin
              delete from t_operateur;
              delete from t_facture_attente;
              delete from t_credit;
              delete from t_vignette_avancee;
              delete from t_produit_du;
              delete from t_commande where etat <> '3';
            end
            else
              if (ATypeSuppression = 6) then
              begin

              end
              else
                if (ATypeSuppression = 8) then
                begin
                  delete from t_historique_client;
                  delete from t_commande where etat = '3';
                  delete from t_document;
                end
                else
                  if (exists(select *
                             from rdb$procedures
                             where rdb$procedure_name = 'PS_SUPPRIMER_DONNEES_MODULES')) then
                    execute statement 'execute procedure PS_SUPPRIMER_DONNEES_MODULES(' || '''' || ATypeSuppression || '''' || ')';
end;

/* ********************************************************************************************** */
create or alter procedure ps_opus_creer_medecin(
  AID integer,
  ANoFiness varchar(20),
  ANom  varchar(40),
  AAdresse1 varchar(50),
  ACodePostal varchar(10),
  ANomVille varchar(40),
  ATelephone varchar(20),
  AFax varchar(20),
  AEmail varchar(50),
  AObservation varchar(200),
  AMobile varchar(20),
  ASpecialite varchar(2),
  ARPPS varchar(11)
)
as
declare variable strNom varchar(50);
declare variable strPrenom varchar(50);
declare variable intSpecialite integer;
declare variable strNJF varchar(50);
begin

    execute procedure ps_separer_nom_prenom(:ANom, ' ') returning_values :strNom, strPrenom, :strNJF;
    execute procedure ps_renvoyer_id_specialite(substring(:ASpecialite from 1 for 2)) returning_values :intSpecialite;

    if (trim(:ARPPS) = '') then ARPPS = null;

    insert into t_praticien(t_praticien_id,
                            type_praticien,
                            nom,
                            prenom,
                            commentaire,
                            email,
                            no_finess,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_standard,
                            fax,
                            tel_mobile,
                            t_ref_specialite_id,
                            num_rpps)
    values(:AID,
           '1',
           trim(:strNom),
           trim(:strPrenom),
           :AObservation,
           :AEmail,
           :ANoFiness,
           substring(:AAdresse1 from 1 for 40),
           substring(:AAdresse1 from 40 for 10),
           substring(:ACodePostal from 1 for 5),
           substring(:ANomVille from 1 for 30),
           replace(:ATelephone,'-',''),
           replace(:AFax,'-',''),
           replace(:AMobile,'-',''),
           :intSpecialite,
           trim(:ARPPS));
 
end;

create or alter procedure ps_opus_creer_destinataire(
ADestinataireID varchar(50),
ANom varchar(20),
AAdresse1 varchar(30) ,
ACodePostal varchar(5),
ANomVille varchar(30) )
as
begin
  insert into t_destinataire( t_destinataire_id ,
                              nom,
                              rue_1,
                              code_postal,
                              nom_ville )
  values(:ADestinataireID,
         :ANom,
         :AAdresse1,
         :ACodePostal,
         :ANomVille
        );

end;

create or alter procedure ps_opus_creer_organisme_amo(
AOrganismeID varchar(50),
ANumero varchar(9),
ANom varchar(60),
ARegime varchar(2),
ACaisseGestionnaire varchar(3),
ACentreGestionnaire varchar(4),
ADestinataireID varchar(50),
AAdresse1 varchar(50),
AAdresse2 varchar(50),
ACodePostal varchar(5),
ANomVille varchar(30),
ATelephone varchar(20),
AFax varchar(20),
AEmail varchar(50),
ACommentaire varchar(200)
 )
as
declare variable intRegime integer;
begin
  execute procedure ps_renvoyer_id_regime(:ARegime ) returning_values :intRegime;

  if (not exists(select *
                from t_destinataire
                where t_destinataire_id = :ADestinataireID)) then
    ADestinataireID = null;

 insert into t_organisme(t_organisme_id,
                          type_organisme,
                          nom,
                          nom_reduit,
                          t_ref_regime_id,
                          caisse_gestionnaire,
                          centre_gestionnaire,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          commentaire,
                          t_destinataire_id
                           )
  values('AMO-'||:AOrganismeID,
         '1',
                 substring(coalesce(nullif(trim(:ANom), ''), :AOrganismeID) from 1 for 50),
         :ANumero,
         :intRegime,
         :ACaisseGestionnaire,
         iif(:ACentreGestionnaire similar to '[[:DIGIT:]]*', :ACentreGestionnaire, null),
         substring(:AAdresse1 from 1 for 40),
         substring(:AAdresse2 from 1 for 40),
         :ACodePostal,
         :ANomVille,
         replace(:ATelephone,'-',''),
         replace(:AFax,'-',''),
         substring(:AEmail||' '||:ACommentaire from 1 for 200),
         :ADestinataireID
        );
end;

create or alter procedure ps_opus_creer_organisme_amc(
AOrganismeID varchar(50),
ANumero varchar(10),
ANom varchar(80),
ADestinataireID varchar(50),
AAdresse1 varchar(50),
AAdresse2 varchar(50),
ACodePostal varchar(5),
ANomVille varchar(30),
ATelephone varchar(20),
AFax varchar(20),
AEmail varchar(50),
AWeb varchar(50),
ACommentaire varchar(200)
 )
as
declare variable strIdNat varchar(8);
begin
  
  strIdNat = substring(:ANumero from 3 for 8);
  if (not exists(select null
                from t_destinataire
                where t_destinataire_id = :ADestinataireID)) then
    ADestinataireID = null;

if (not exists(select null
                from t_organisme
                where identifiant_national = :strIdNat)) then
  insert into t_organisme(t_organisme_id,
                          type_organisme,
                          nom,
                          nom_reduit,
                          identifiant_national,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          commentaire,
                          t_destinataire_id
                           )
  values('AMC-'||:AOrganismeID,
         '2',
         substring(coalesce(nullif(trim(:ANom), ''), :AOrganismeID) from 1 for 50),
         :AOrganismeID,
         :strIdNat,
         substring(:AAdresse1 from 1 for 40),
         substring(:AAdresse2 from 1 for 40),
         :ACodePostal,
         :ANomVille,
         replace(:ATelephone,'-',''),
         replace(:AFax,'-',''),
         substring(:AEmail||' '||:AWeb||' '||:ACommentaire from 1 for 200),
         :ADestinataireID
        );
end;



create or alter procedure ps_opus_creer_taux_amo(
  ACouverture varchar(50),
  APrestation varchar(3),
  ATaux integer)
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amo_id,
                                     t_ref_prestation_id,
                                     taux)
  values(next value for seq_taux_prise_en_charge,
         :ACouverture,
         :intPrestation,
         :ATaux);
end;

create or alter procedure ps_opus_creer_taux_amc(
  ACouverture varchar(50),
  APrestation varchar(3),
  ATaux integer)
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux)
  values(next value for seq_taux_prise_en_charge,
         :ACouverture,
         :intPrestation,
         :ATaux);

  if ( APrestation = 'PH2' or APrestation = 'PH4' or APrestation = 'PH7'  ) then
  update t_couverture_amc 
  set libelle = libelle||' '||:APrestation||'='||cast(:ATaux as varchar(3) )||','
  where t_couverture_amc_id = :ACouverture;
end;

create or alter procedure ps_opus_creer_couverture_amo(
ACodeCouverture char(1),
ALibelle varchar(30),
ANatureAssurance char(2),
AJustificatifExo char(1),
ATauxPHN integer,
ATauxPH1 integer,
ATauxPH2 integer,
ATauxPH4 integer,
ATauxPH7 integer,
ATauxAAD integer,
ATauxPMR integer
 )
as
declare variable t_organisme_amo_id varchar(50);
begin

  if (:ACodeCouverture = 'N') then
  begin
        if (not(exists(select t_couverture_amo_id from t_couverture_amo where t_couverture_amo_id = 'N' ))) then
        insert into t_couverture_amo (t_couverture_amo_id,
                                ald,
                                libelle,
                                nature_assurance,
                                justificatif_exo
                                )
        values (:ACodeCouverture,
          iif(:AJustificatifExo='4','1','0'),
          :ALibelle,
          :ANatureAssurance,
          :AJustificatifExo
          );
  end
  else
  for select t_organisme_id
      from t_organisme
      where type_organisme='1'
      into :t_organisme_amo_id
  do
  begin
        insert into t_couverture_amo (t_couverture_amo_id,
                                t_organisme_amo_id,
                                ald,
                                libelle,
                                nature_assurance,
                                justificatif_exo
                                )
        values (:ACodeCouverture||'-'||:t_organisme_amo_id,
          :t_organisme_amo_id,
          iif(:AJustificatifExo='4','1','0'),
          :ALibelle,
          :ANatureAssurance,
          :AJustificatifExo
          );

        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'PHN',:ATauxPHN);
        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'PH1',:ATauxPH1);
        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'PH2',:ATauxPH2);
        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'PH4',:ATauxPH4);
        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'PH7',:ATauxPH7);
        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'AAD',:ATauxAAD);
        execute procedure ps_opus_creer_taux_amo( :ACodeCouverture||'-'||:t_organisme_amo_id,'PMR',:ATauxPMR);


  end

end;

create or alter procedure ps_opus_creer_couv_org_amo(
AOrganismeId varchar(50),
APrestation varchar(3),
ATaux integer
 )
as
declare variable lLibelle varchar(50);
declare variable lNatureAssurance char(2);
declare variable lJustificatifExo char(1);
begin

  /* recup des infos de la couv de base */
  select libelle,
         nature_assurance,
         justificatif_exo
  from t_couverture_amo
  where t_couverture_amo_id ='N'
  into :lLibelle,
       :lNatureAssurance,
       :lJustificatifExo;

  /* creation de la vraie couv */
  if (not(exists(select t_couverture_amo_id from t_couverture_amo where t_couverture_amo_id = 'N-AMO-'||:AOrganismeId ))) then
    insert into t_couverture_amo (t_couverture_amo_id,
                                  t_organisme_amo_id,
                                  ald,
                                  libelle,
                                  nature_assurance,
                                  justificatif_exo
                                )
    values ('N-AMO-'||:AOrganismeId ,
          'AMO-'||:AOrganismeId,
          iif(:lJustificatifExo='4','1','0'),
          :lLibelle,
          :lNatureAssurance,
          :lJustificatifExo
          );

 /* creation des taux de la couverture de base N */
 if ( APrestation = 'PHN' or APrestation = 'PH1' or APrestation = 'PH2' or APrestation = 'PH4' or APrestation = 'PH7' or APrestation = 'AAD' or APrestation = 'PMR' ) then
  execute procedure ps_opus_creer_taux_amo( 'N-AMO-'||:AOrganismeId,:APrestation,:ATaux);


end;



create or alter procedure ps_opus_creer_couverture_amc(
AOrganismeId varchar(50),
AIdentifiant varchar(8),
APrestation varchar(3),
ATaux integer
 )
as
declare variable t_organisme_amc_id varchar(50);
begin
  
  select t_organisme_id 
  from t_organisme
  where identifiant_national = :AIdentifiant
  into :t_organisme_amc_id;
  
  if (not(exists(select t_couverture_amc_id from t_couverture_amc where t_couverture_amc_id = 'AMC-'||:AOrganismeId ))) then
    insert into t_couverture_amc(t_couverture_amc_id,
                                 t_organisme_amc_id,
                                 libelle,
                                 montant_franchise,
                                 plafond_prise_en_charge,
                                 formule)
    values('AMC-'||:AOrganismeId,
           :t_organisme_amc_id,
           'Couv AMC ',
           0,
           0,
           '02A');

  if ( APrestation = 'PMR' or APrestation = 'PH1' or APrestation = 'PH2' or APrestation = 'PH4' or APrestation = 'PH7' or  APrestation = 'AAD' ) then
    execute procedure ps_opus_creer_taux_amc( 'AMC-'||:AOrganismeId,:APrestation,:ATaux);


end;

create or alter procedure ps_opus_creer_compte(
  ACodeRegroupement varchar(3),
  ANom varchar(50),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(20),
  ATelephone varchar(14),
  AFax varchar(14))
as
begin
  insert into t_compte(t_compte_id,
    nom,
    rue_1,
    rue_2,
    code_postal,
    nom_ville,
    tel_standard,
    fax)
  values(:ACodeRegroupement,
    substring(trim(:ANom) from 1 for 30),
    trim(:ARue1),
    trim(:ARue2),
    :ACodePostal,
    trim(:ANomVille),
    replace(:ATelephone,'-',''),
    replace(:AFax,'-',''));
end;

create or alter procedure ps_opus_creer_client(
ABeneficiaireID varchar(50),
AAssureID varchar(50),
ANomAssure varchar(27),
ANumeroInsee varchar(13),
ACleInsee char(3),
ANomBeneficiaire varchar(27),
APrenomBeneficiaire varchar(27),
ATelephone varchar(14),
APortable varchar(14),
ADateNaissance varchar(8),
ARang char(1),
ANumeroAdherent varchar(15) ,
AFindroitAmo1 varchar(10),
AFinDroitAmo2 varchar(10),
AFinDroitAmc varchar(10),
ACommentaireAss varchar(300),
ACommentaireBen varchar(300),
AAld char(1),
AOrganismeAmoId varchar(50),
AIdentifiantNational varchar(9),
AOrganismeAmcId varchar(50),
AIdentAMC varchar(10),
AQualite varchar(2),
ACouvertureAmo1 varchar(50),
ACouvertureAmo2 varchar(50),
ADateDernierPassage varchar(10),
ARue1 varchar(50),
ARue2 varchar(50),
ACodePostal varchar(5),
ANomVille varchar(20),
AFax varchar(14),
AEmail varchar(50),
ACodeRegroupement varchar(3))
as
declare variable t_organisme_amo_id varchar(50);
declare variable t_organisme_amc_id varchar(50);
declare variable t_couverture_amo1_id varchar(50);
declare variable t_couverture_amo2_id varchar(50);
declare variable t_couverture_amc_id varchar(50);
declare variable strCentreGestionnaire varchar(4);
declare variable dateFindroitAmo1 date;
declare variable dateFinDroitAmo2 date;
declare variable dateFinDroitAmc date;
declare variable dateDernierPassage date;
begin
  execute procedure ps_conv_chaine_en_date_format(:AFindroitAmo1,'AAAAMMJJ') returning_values :dateFindroitAmo1;
  execute procedure ps_conv_chaine_en_date_format(:AFindroitAmo2,'AAAAMMJJ') returning_values :dateFindroitAmo2;
  execute procedure ps_conv_chaine_en_date_format(:AFindroitAmc,'AAAAMMJJ') returning_values :dateFindroitAmc;
  execute procedure ps_conv_chaine_en_date_format(:ADateDernierPassage,'AAAAMMJJ') returning_values :dateDernierPassage;

  t_organisme_amo_id =  iif(AOrganismeAmoId <> '', 'AMO-' || AOrganismeAmoId, null);

  if (exists(select o.centre_gestionnaire
             from t_organisme o
                  inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
             where o.t_organisme_id = :t_organisme_amo_id
               and r.sans_centre_gestionnaire = '1')) then
    strCentreGestionnaire = substring(AIdentifiantNational from 6 for 4);
  else
    strCentreGestionnaire = null;

   t_organisme_amc_id = (select t_organisme_id from t_organisme where identifiant_national = substring(:AIdentAMC from 3 for 8)  and type_organisme='2');
   t_couverture_amc_id = iif(AOrganismeAmcId <> '', 'AMC-' || AOrganismeAmcId, null);


   insert into t_client(t_client_id,
                       numero_insee,
                       nom,
                       nom_jeune_fille,
                       prenom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_personnel,
                       tel_mobile,
                       fax,
                       date_naissance,
                       rang_gemellaire,
                       qualite,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       t_organisme_amc_id,
                       t_couverture_amc_id,
                       fin_droit_amc,
                       numero_adherent_mutuelle,
                      -- commentaire_global,
                      -- commentaire_individuel,
                       date_derniere_visite,
                           t_famille_id)
  values( :ABeneficiaireID,
          substring(iif(trim(:ANumeroInsee||:ACleInsee)<>'',:ANumeroInsee||:ACleInsee,null) from 1 for 15),
          trim(:ANomAssure),
          iif(trim(:ANomBeneficiaire) <> '' and  trim(:ANomBeneficiaire) <> trim(:ANomAssure) , :ANomBeneficiaire, ''),
          trim(:APrenomBeneficiaire),
          substring(:ARue1 from 1 for 40),
          substring(:ARue2 from 1 for 40),
          :ACodePostal,
          :ANomVille,
          replace(:ATelephone,'-',''),
          replace(:APortable,'-',''),
          replace(:AFax,'-',''),
          iif( :ADateNaissance similar to '[[:DIGIT:]]{8}',substring(:ADateNaissance from 7 for 2)||substring(:ADateNaissance from 5 for 2)||substring(:ADateNaissance from 1 for 4), null),
          iif(trim(:ARang) = '' , 1, cast(:ARang as smallint)),
          iif(:AQualite = '', 0, cast(:AQualite as integer)),
          :t_organisme_amo_id,
          :strCentreGestionnaire,
          :t_organisme_amc_id,
          :t_couverture_amc_id,
          :dateFinDroitAmc,
          :ANumeroAdherent,
       --   substring(trim(:AcommentaireAss) from 1 for 200),
      --    substring(trim(:AcommentaireBen) from 1 for 200),
          :dateDernierPassage,
      :AAssureID  );

      
  if (trim(AcommentaireAss) <> '' ) then
  insert into t_commentaire (t_commentaire_id,
                             t_entite_id,
                             type_entite,
                             commentaire,
                             est_global )
  values (next value for seq_commentaire,
          :ABeneficiaireID,
          '0', -- client 
          cast(:AcommentaireAss as blob),
          '1'  );
      
  if (trim(ACommentaireBen) <> '' ) then
     insert into t_commentaire (t_commentaire_id,
                                 t_entite_id,
                                 type_entite,
                                 commentaire,
                                 est_global )
      values (next value for seq_commentaire,
              :ABeneficiaireID,
              '0', -- client 
              :ACommentaireBen,
              '0'  );
      
  if  ( trim(:ACouvertureAmo1)<> '' ) then
  begin
    select t_couverture_amo_id
    from t_couverture_amo
    where t_couverture_amo_id = trim(:ACouvertureAmo1)||'-'||:t_organisme_amo_id
    into :t_couverture_amo1_id ;

      if ( row_count > 0 ) then
        insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                        t_client_id,
                                        t_couverture_amo_id,
                                        fin_droit_amo)
      values(next value for seq_couverture_amo_client,
           :ABeneficiaireID,
           :t_couverture_amo1_id,
           :dateFindroitAmo1);
   end

  if  ( (trim(:ACouvertureAmo2)<> '') and  (trim(:ACouvertureAmo2)<> trim(:ACouvertureAmo1)) ) then
  begin
    select t_couverture_amo_id
    from t_couverture_amo
    where t_couverture_amo_id = trim(:ACouvertureAmo2)||'-'||:t_organisme_amo_id
    into :t_couverture_amo2_id ;

    if ( row_count > 0 ) then
      insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                          t_client_id,
                                          t_couverture_amo_id,
                                          fin_droit_amo)
      values(next value for seq_couverture_amo_client,
             :ABeneficiaireID,
             :t_couverture_amo2_id,
             :dateFindroitAmo2);
   end
  
  if (trim(ACodeRegroupement) <> '') then
    insert into t_compte_client(t_compte_client_id,
      t_compte_id,
      t_client_id)
    values(next value for seq_compte_client,
      :ACodeRegroupement,
      :ABeneficiaireID);
end;

/************************************************************************************/
create or alter procedure ps_opus_creer_tva(
  ACode integer,
  AValeur float)
as
begin
  if ((ACode is not null) and (AValeur is not null)) then
    insert into t_opus_tva(code,
                          valeur)
    values(:ACode,
           :AValeur);
end;


create or alter procedure ps_opus_creer_famille(
  ACodifId varchar(5),
  ADesignation varchar(30))
as
begin

  if (ACodifId is not null) then
  insert into t_codification(t_codification_id,
                             code,
                             libelle,
                             rang,
                             taux_marque)
  values(next value for seq_codification ,
        :ACodifId ,
        substring(:ADesignation from 1 for 50),
        1,
        0);

end;

create or alter procedure ps_opus_creer_zonegeo(
  AZoneGeoId varchar(5),
  ADesignation varchar(30))
as
begin
  if (AZoneGeoId is not null) then
    insert into t_zone_geographique(t_zone_geographique_id,
                                    libelle)
    values(:AZoneGeoId,
           trim(:AZoneGeoId)||' '||trim(:ADesignation));

end;

create or alter procedure ps_opus_creer_repartiteur(
ARepartiteurId varchar(3),
ANom varchar(30),
ARue varchar(25),
ACodePostal varchar(5),
ANomVille varchar(25),
ATelephone varchar(14),
AFax varchar(14),
AParamTrans varchar(24),
ARepresentant varchar(30),
ATelephoneAchat varchar(16)
)
as
begin

  insert into t_repartiteur ( t_repartiteur_id,
                              raison_sociale,
                              commentaire,
                              commentaire_171,
                              rue_1,
                              code_postal,
                              nom_ville,
                              tel_standard,
                              fax

                            )
  values( :ARepartiteurId,
          :ANom,
          :ARepresentant||' '||:ATelephoneAchat,
          :AParamTrans,
          :ARue,
          :ACodePostal,
          :ANomVille,
          replace(:ATelephone,'-',''),
          replace(:AFax,'-','')
        );

end;

create or alter procedure ps_opus_creer_fournisseur(
AFournisseurId varchar(50),
ANom varchar(30),
ARue varchar(25),
ACodePostal varchar(5),
ANomVille varchar(25),
ATelephone varchar(14),
AFax varchar(14),
ARepresentant varchar(30),
ACommentaire varchar(300),
AEmail varchar(50),
APortable varchar(14),
ARepondeur varchar(14)

)
as
begin

  insert into t_fournisseur_direct ( t_fournisseur_direct_id,
                                     raison_sociale,
                                     commentaire,
                                     rue_1,
                                     code_postal,
                                     nom_ville,
                                     tel_standard,
                                     fax,
                                     tel_mobile,
                                     represente_par,
                                     email
                            )
  values( :AFournisseurId,
          :ANom,
          substring(:ACommentaire from 1 for 200),
          :ARue,
          :ACodePostal,
          :ANomVille,
          replace(:ATelephone,'-',''),
          replace(:AFax,'-',''),
          replace(:APortable,'-',''),
          trim(:ARepresentant),
          :AEmail
        );

end;


create or alter procedure ps_opus_creer_produit(
ACodeCip varchar(7),
ACodeCip13 varchar(13),
ADesignation varchar(45),
APrixVente float,
APrixTips float,
ABorneMini integer,
ABorneMaxi integer,
AQuantiteStock integer,
AStockMini integer,
AStockMaxi integer,
AQuantiteReserve integer,
APrixAchatCatalogue float,   
APrixAchatRemise float,
APrixAchatRepartiteur float,
APrestation varchar(3),
ARepartiteurID varchar(3),
ATauxTva float,
AFournisseurID varchar(5),
ACodif varchar(5),
ATableau varchar(1),
AZoneGeoId varchar(5),
AZoneGeoReserveId varchar(5),
ACodeTipsLPP varchar(13),
ACodeEan13 varchar(13),
ACommentaireVente varchar(100),
ACommentaire varchar(100),
APrixAchatFabricant float ,
ADatePeremption varchar(10),
AFlagHomeo varchar(1),
ADateDerniereVente varchar(10),
APrixHT float)
as
declare variable intTVA integer;
declare variable intPrestation integer;
declare variable intCodif integer;
declare variable intMarque integer;
declare variable datePeremption date;
declare variable dateDerniereVente date;

begin
  execute procedure ps_conv_chaine_en_date_format(:ADatePeremption,'AAAAMMJJ') returning_values :datePeremption;
  execute procedure ps_conv_chaine_en_date_format(:ADateDerniereVente,'AAAAMMJJ') returning_values :dateDerniereVente;

  execute procedure ps_renvoyer_id_tva(:ATauxTVA) returning_values :intTVA;
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;
  execute procedure ps_renvoyer_id_codification('1', :ACodif) returning_values :intCodif;
  execute procedure ps_renvoyer_id_marque(:AFournisseurID) returning_values :intMarque;

   insert into t_produit (t_produit_id,
                          code_cip,
                          designation,
                          liste,
                          t_ref_tva_id,
                          t_ref_prestation_id,
                          prix_achat_catalogue,
                          prix_vente,
                          base_remboursement,
                          stock_mini,
                          stock_maxi,
                          t_repartiteur_id,
                          date_derniere_vente,
                          t_codif_1_id,
                          t_codif_6_id,
                          commentaire_gestion,
                          commentaire_commande,
                          veterinaire,
                          date_peremption)
  values (:ACodeCip,
          iif(:ACodeCip13 similar to '340[01][[:DIGIT:]]{9}',
              :ACodeCip13 , -- si cip 13 on reprend le cip 13
              iif(:ACodeEan13 similar to '340[01][[:DIGIT:]]{9}',
                  :ACodeEan13, -- si les code sean13 est en fait un cip 13 on reprend le reprend en tant que cip 13 
                  iif(:ACodeCip similar to '[[:DIGIT:]]{7}', 
                      :ACodeCip,-- sinon si pas de cip13 mais un cip 7 on reprends le cip7
                      null))), 
          :ADesignation,
          case
               when :ATableau = '1' then '1'
               when :ATableau = '2' then '2'
               when :ATableau = 'B' then '3'
               else '0'
              end,
          :intTVA,
          :intPrestation,
          case --prix achat
            when :APrixHT > 0 then :APrixHT 
            when :APrixAchatCatalogue > 0 then :APrixAchatCatalogue 
            when :APrixAchatFabricant > 0 then :APrixAchatFabricant 
            when :APrixAchatRepartiteur > 0 then :APrixAchatRepartiteur 
            when :APrixAchatRemise > 0 then :APrixAchatRemise 
          else 0
          end,
          :APrixVente,
          :APrixTips,
          iif(:AStockMini > 0 , :AStockMini, :ABorneMini),
          iif(:AStockMaxi > 0 , :AStockMaxi, :ABorneMaxi),
          :ARepartiteurID,
          :dateDerniereVente,
          :intCodif,
          :intMarque,
          :ACommentaire,
          :ACommentaireVente,
          iif(:ATableau ='V', 1, 0 ),
          :datePeremption);


  if (:ACodeEan13 <> '') then -- sorti de la condition pour de meilleures perf
  if (not(exists(select * from t_code_ean13 where t_produit_id = :ACodecip and code_ean13 =:ACodeEan13)) -- le code ean13 n existe pas deja 
     and(:ACodeEan13 not similar to '340[01][[:DIGIT:]]{9}' )) then -- n est pas un cip 13
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :ACodecip,
           :ACodeEan13);

  if (:ACodeCip13 <> '') then
  if (not(exists(select * from t_code_ean13 where t_produit_id = :ACodecip and code_ean13 =:ACodeCip13)) -- le code ean13 n existe pas deja 
     and(:ACodeCip13 not similar to '340[01][[:DIGIT:]]{9}' )) then -- n est pas un cip 13
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :ACodecip,
           :ACodeCip13);

  if ((AQuantiteStock is not null) and (AQuantiteStock > 0)) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                       t_produit_id,
                                       quantite,
                                       t_depot_id,
                                       stock_maxi,
                                       stock_mini,
                                       t_zone_geographique_id)
    values(next value for seq_produit_geographique,
           :ACodeCip,
           :AQuantiteStock,
           (select t_depot_id from t_depot where libelle ='PHARMACIE'),
           :AStockMaxi,
           :AStockMini,
           iif(:AZoneGeoID <> '', :AZoneGeoId, null));
           
  if ((:AStockMaxi > 0 ) or (:AStockMini > 0) or (AQuantiteReserve > 0)) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                       t_produit_id,
                                       quantite,
                                       t_depot_id,
                                       t_zone_geographique_id)
    values(next value for seq_produit_geographique,
           :ACodeCip,
           :AQuantiteReserve,
           (select t_depot_id from t_depot where libelle ='RESERVE'),
           :AZoneGeoReserveId);           
end;

create or alter procedure ps_opus_creer_lpp(
  ACodecip varchar(7),
  ACodeLpp varchar(13),
  APrestation varchar(3),
  ATarif float)
as
declare variable type_code char(1);
declare variable intPrestation integer;
begin

  if ( ACodeLpp similar to '[[:DIGIT:]]{7}' ) then
    type_code = '0';
  else
    type_code = '2';

  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;

  insert into t_produit_lpp (t_produit_lpp_id,
                             t_produit_id,
                             type_code,
                             code_lpp,
                             quantite,
                             t_ref_prestation_id,
                             tarif_unitaire)
  values(next value for seq_produit_lpp,
         :ACodecip,
         :type_code,
         :ACodeLpp,
         1,
         :intPrestation,
         :ATarif);

end;

create or alter procedure ps_opus_creer_ean(
  ACodecip varchar(7),
  ACodeEan varchar(13))
as
begin
  if ( (substring(:ACodeEan from 1 for 4) <> '3400') and (substring(:ACodeEan from 1 for 4) <> '3401') ) then
    insert into t_code_ean13 (t_code_ean13_id,
                             t_produit_id,
                             code_ean13) 
    values (next value for  seq_code_ean13,
            :ACodecip,
            trim(:ACodeEan));
  else
    update t_produit set code_cip= trim(:ACodeEan)  
    where t_produit_id = :ACodecip
    and code_cip is null;  
end;



create or alter procedure ps_opus_creer_histo_vente(
ACodecip varchar(7),
AMois varchar(2),
AAnnee varchar(4),
AQuantite integer)
as
declare variable strProduit dm_code;
begin

  select t_produit_id
  from t_produit
  where t_produit_id = :ACodecip
  into :strProduit;

  if (row_count = 0) then
    exception exp_opus_produit_exist;
  else
    if ((AQuantite is not null) and (AQuantite>0)) then
    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_actes,
                                   quantite_vendues)
    values(next value for seq_historique_vente,
           :strProduit,
           lpad(cast(:AMois as integer), 2, '0') || lpad(cast(:AAnnee as integer), 4, '0'),
           :AQuantite,
           :AQuantite);
end;

create or alter procedure ps_opus_creer_histo_entete (
AHistoriqueClientId varchar(50),
ANumeroFacture numeric(10,0),
ADateActe varchar(10),
ADatePrescription varchar(10),
ACodeOperateur varchar(2),
AClientID  varchar(50),
ATypeFActure char(1),
APraticienID varchar(9),
APraticienNom varchar(30)
)
as
declare variable dateActe date;
declare variable datePrescription date;

begin
  execute procedure ps_conv_chaine_en_date_format(:ADateActe,'AAAAMMJJ') returning_values :dateActe;
  execute procedure ps_conv_chaine_en_date_format(:ADatePrescription,'AAAAMMJJ') returning_values :datePrescription;

  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  numero_facture,
                                  date_prescription,
                                  code_operateur,
                                  t_praticien_id,
                                  nom_praticien,
                                  type_facturation ,
                                  date_acte )
   values(:AHistoriqueClientId,
          :AClientId,
          :ANumeroFacture,
          :datePrescription,
          :ACodeOperateur,
          iif(trim(:APraticienID)>'',:APraticienID,null),
          :APraticienNom,
          '1',
          :dateActe
          );
end;

create or alter procedure ps_opus_creer_histo_ligne(
AHistoriqueClientId varchar(50),
AIDProduit dm_code,
ADesignation varchar(50),
AQuantite integer,
APrix float
)
as
declare variable strCodeCip dm_code_cip;
begin

  select code_cip from t_produit where t_produit_id = :AIDProduit into :strCodeCip;

  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                    t_historique_client_id,
                    t_produit_id,
                    code_cip,
                    designation,
                    quantite_facturee,
                    prix_vente)
  values(next value for seq_historique_client_ligne,
     :AHistoriqueClientId,
     (select t_produit_id from t_produit where t_produit_id = :AIDProduit),
     :strCodeCIP,
     :ADesignation,
     :AQuantite,
     :APrix);

end;


create or alter procedure ps_opus_creer_operateur(
AOperateurId varchar(2),
ANom varchar(30),
APrenom varchar(30)
)
as
begin

  insert into t_operateur(t_operateur_id ,
                          nom ,
                          prenom,
                          activation_operateur)
  values(:AOperateurID,
         :Anom,
         :APrenom,
         '1');

end;

create or alter procedure ps_opus_creer_avance(
AClientId varchar(50),
ADateAvance varchar(10),
ACodeCip varchar(7),
ADesignation varchar(50),
APrix float,
APrixAchat float,
APrestation varchar(3),
AOperateur varchar(2),
AQuantite integer,
ABaseRemboursement float
)
as
declare variable dateavance date;
begin
  execute procedure ps_conv_chaine_en_date_format(:ADateAvance,'AAAAMMJJ') returning_values :dateavance;

  insert into t_vignette_avancee(t_vignette_avancee_id,
                                  t_client_id,
                                  date_avance,
                                  code_cip,
                                  designation,
                                  prix_vente,
                                  prix_achat,
                                  code_prestation ,
                                  t_produit_id,
                                  t_operateur_id,
                                  quantite_avancee,
                                  base_remboursement)
  values(next value for seq_vignette_avancee,
          :AClientId,
          :dateavance,
          :ACodeCip,
          :ADesignation,
          :APrix,
          :APrixAchat,
          :APrestation,
          :ACodeCip,
          :AOperateur,
          :AQuantite,
          :ABaseRemboursement);

end;

create or alter procedure ps_opus_creer_attente (
AAttenteID varchar(50),
ADateAttente varchar(10),
AClientID varchar(50)
)
as
declare variable dateAttente date;
begin
  execute procedure ps_conv_chaine_en_date_format(:ADateAttente,'AAAAMMJJ') returning_values :dateAttente;

  insert into t_facture_attente(t_facture_attente_id,
                                date_acte,
                                t_client_id)
  values(:AAttenteId,
         :dateAttente,
         :AClientId);
end;

create or alter procedure ps_opus_creer_attente_ligne (
AAttenteID varchar(50),
ACodeCip varchar(7),
ADesignation varchar(50),
APrestation varchar(3),
AQuantite integer,
APrixVente float
)
as
declare variable intPrestation integer;
begin
      execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;


      insert into t_facture_attente_ligne(t_facture_attente_ligne_id,
                                          t_facture_attente_id,
                                          t_produit_id,
                                          quantite_facturee,
                                          t_ref_prestation_id,
                                          prix_vente,
                                          prix_achat)
      values(next value for seq_facture_attente_ligne,
             :AAttenteID,
             :ACodeCip,
             :AQuantite,
             :intPrestation,
             :APrixVente,
             0.00);
end;


/* ********************************************************************************************** */
create or alter procedure ps_opus_creer_credit (
AClientID varchar(50),
ADateCredit varchar(10),
AMontant float)
as
declare variable datecredit date;
begin
  execute procedure ps_conv_chaine_en_date_format(:ADateCredit,'AAAAMMJJ') returning_values :datecredit;

    insert into t_credit(t_credit_id,
                         date_credit,
                         t_client_id,
                         montant)
    values(next value for seq_credit,
           :datecredit,
           ( select t_client_id from t_client where t_famille_id = :AClientId and qualite = 0 ),
           :AMontant);
end;


create or alter procedure ps_opus_creer_commande (
  t_commande_id varchar(50),
  t_repartiteur_id varchar(50),
  t_fournisseur_direct_id varchar(50),
  date_creation varchar(10),
  date_commande varchar(10),
  date_reception varchar(10),
  quantite_commandee integer,
  quantite_recue integer,
  unites_gratuites integer,
  montant_brut float,
  montant_net float,
  remise float,
  etat char(1))
as
declare variable type_commande char(1);
declare variable etat_commande char(2);
declare variable datecreation date;
--declare variable datecommande date;
declare variable datereception date;

begin
  execute procedure ps_conv_chaine_en_date_format(:date_creation,'AAAAMMJJ') returning_values :datecreation;
  --execute procedure ps_conv_chaine_en_date_format(:date_commande,'AAAAMMJJ') returning_values :datecommande;
  execute procedure ps_conv_chaine_en_date_format(:date_reception,'AAAAMMJJ') returning_values :datereception;

  if (t_repartiteur_id = '') then
  begin
    type_commande = 1;
    t_repartiteur_id = null;
  end  
  else
  begin
    type_commande = 2;
    t_fournisseur_direct_id = null;
  end  

  if (etat = 'T') then  -- T  transmise = en attente de reception
  begin
    etat_commande = '2';
    date_reception = null;
  end
  else 
      etat_commande = '3';    -- V : recue et valorisée = , (recue completement) 



  insert into t_commande(t_commande_id,
                         type_commande,
                         t_repartiteur_id,
                         t_fournisseur_direct_id,
                         date_creation,
                         date_reception,
                         mode_transmission,
                         montant_ht,
                         etat)
  values(:t_commande_id,
         :type_commande,
         :t_repartiteur_id,
         :t_fournisseur_direct_id,
         :datecreation,
         :datereception,
         '5',
         :montant_net,
         :etat_commande);

end;

create or alter procedure ps_opus_creer_commande_ligne (
  t_commande_id varchar(50),
  t_produit_id varchar(50),
  quantite_commandee integer,
  quantite_recue integer,
  unites_gratuites integer,
  prix_achat_tarif float,
  prix_achat_remise float,
  prix_vente float)
as
begin

  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente,
                               quantite_totale_recue,
                               unites_gratuites)
  values(next value for seq_commande_ligne,
         :t_commande_id,
         :t_produit_id,
         :quantite_commandee,
         :quantite_recue,
         :prix_achat_tarif,
         :prix_achat_remise,
         :prix_vente,
         :quantite_recue + :unites_gratuites,
         :unites_gratuites);

  if ( prix_achat_remise > 0 ) then
    update t_produit 
    set pamp = :prix_achat_remise 
    where t_produit_id = :t_produit_id;

end;

/* ********************************************************************************************** */
create or alter procedure ps_opus_creer_document(
  AIDClient varchar(50),
  ALibelle varchar(50),
  AFichier varchar(255))
as
begin
  insert into t_document(t_document_id,
    type_entite,
    t_entite_id,
    libelle,
    document)
    values(next value for seq_document,
    2, --doc client
    :AIDClient,
    :ALibelle,
    :AFichier);
end;

/* ********************************************************************************************** */

create or alter procedure ps_opus_creer_prog_avantage(
  type_objectif integer,
  valeur_objectif float,
  type_cf_avantage integer,
  valeur_avantage float
)
as
declare variable type_avantage integer;
declare variable mode_calcul_avantage integer;
begin
  
  if ( type_cf_avantage = 0 ) then -- % remise en %
  begin
    type_avantage = 1;
    mode_calcul_avantage = 1;
  end  
  else if ( type_cf_avantage = 1 ) then -- € remise en euros
  begin
    type_avantage = 1;
    mode_calcul_avantage = 3;
  end
  else if ( type_cf_avantage = 2 ) then -- points
  begin
    type_avantage = 1;
    mode_calcul_avantage = 4;
  end  
  
  insert into t_programme_avantage(t_programme_avantage_id,
                               type_carte,
                               libelle,
                               date_fin_validite,
                               desactivee,
                               type_objectif,
                               valeur_objectif,
                               type_avantage,
                               mode_calcul_avantage,
                               diff_assure,
                               valeur_avantage)
  values('PA',
         '1',
         'Programme Avantage',
         null,
         '0',
         :type_objectif+1,
         :valeur_objectif,
         :type_avantage,
         :mode_calcul_avantage,
         '0',
         :valeur_avantage);
     
end;


/* ********************************************************************************************** */

create or alter procedure ps_opus_creer_prog_av_client(
  t_client_id dm_code,
  nbr_cumule_remise integer,
  ca_ttc_cumul_remis float)
as
declare variable id integer;
begin
  select t_programme_avantage_client_id
  from t_programme_avantage_client
  where t_programme_avantage_id = 'PA'
    and t_client_id = :t_client_id
  into id;
  
  if (row_count = 0) then
    insert into t_programme_avantage_client(t_programme_avantage_client_id,
                                      t_programme_avantage_id,
                                      t_client_id,
                                      numero_carte,
                                      statut,
                                      date_creation,
                                      date_creation_initiale,
                                      date_fin_validite,
                                      encours_initial,
                                      encours_ca
                                      )
                values(next value for seq_programme_avantage_client,
                'PA',
                :t_client_id,
                null,
                '0',
                current_date,
                current_date,
                null,
                :nbr_cumule_remise,
                :ca_ttc_cumul_remis);
  else
    update t_programme_avantage_client
    set encours_initial = encours_initial + :nbr_cumule_remise,
        encours_ca = encours_ca + :ca_ttc_cumul_remis
    where t_programme_avantage_client_id = :id;

end;

/* ********************************************************************************************** */

create or alter procedure ps_opus_creer_prog_av_produit(
  t_produit_id dm_code)
as
begin
  insert into t_programme_avantage_produit ( t_programme_avantage_produit_id , t_programme_avantage_id , t_produit_id )
    values ( next value for seq_programme_avantage_produit , 'PA', :t_produit_id  );

end;


create or alter procedure ps_opus_creer_mandataire(
  t_client_id varchar(50),
  t_mandataire_id varchar(50),
  type_lien integer)
as
begin
  insert into t_mandataire(
    t_client_id,
    t_mandataire_id,
    type_lien)
  values(
    :t_client_id,
    :t_mandataire_id,
    :type_lien);
end;

/* ********************************************************************************************** */

create or alter procedure ps_opus_creer_carte_prog_rel(
    designation varchar(50),
    t_client_id varchar(50),
    numero_carte varchar(14)
    )
as
declare variable id_prg_relationnel integer;
begin

  if ( trim(upper(designation))  = 'ALPHEGA' ) then
    id_prg_relationnel = 14;

  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte,
    t_pfi_lgpi_id)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :numero_carte,
    :id_prg_relationnel );

end;