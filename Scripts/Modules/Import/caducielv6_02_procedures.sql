set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_hopital(
  AHopitalID integer,
  ANom varchar(50),
  ANoFiness varchar(9),
  ACodepostal varchar(5),
  AVille varchar(30),
  ARue1 varchar(40),
  ATelephone varchar(50),
  AGsm varchar(50),
  AFax varchar(50),
  AEmail varchar(50)
  )
as
declare variable strHopitalID varchar(50);
begin
  strHopitalID = cast(AHopitalID as varchar(50));
  
  insert into t_hopital(t_hopital_id,
                        nom,
                        no_finess,
                        rue_1,
                        code_postal,
                        nom_ville,
                        tel_standard,
                        tel_mobile,
                        fax,  
                        commentaire)
  values(:strHopitalID,
         :ANom,
         :ANoFiness,
         :ARue1,
         :ACodepostal,
         :aville,
         :atelephone,
         :agsm,
         :afax,
         :aemail);

end;


/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_medecin(
  AID integer,
  ACodeSpecialite varchar(3),
  ACodePostal char(5),
  AVille varchar(200),
  AFiness char(9),
  ANom varchar(50),
  ACHU varchar(50),
  AAdresse1 varchar(50),
  AAdresse2 varchar(50),
  AAdresse3 varchar(50),
  ATelephone char(12),
  AFax char(12),
  APortable char(12),
  AEMail varchar(100),
  AMemo varchar(1000),
  ATypePrescripteur smallint,
  ANumRpps varchar(11),
  AFiness_site varchar(9)
  )
as
declare variable strHopital varchar(50);
declare variable intSpecialite integer;
declare variable strNom varchar(50);
declare variable strPrenom varchar(50);
declare variable strNJF varchar(50);
declare variable hopitalID varchar(9);
declare variable strComm varchar(50);
begin
  execute procedure ps_renvoyer_id_specialite(:ACodeSpecialite) returning_values :intSpecialite;
  execute procedure ps_separer_nom_prenom(:ANom, ' ') returning_values :strNom, :strPrenom, :strNJF;


  --xx0xxxxxx = finess de structure 
  -- c'est soit une structure soit un praticien hospitalier
  if ( substring(AFiness from 3 for 1) = '0' ) then 
  begin
         -- vrai finess hôpital trouvé dans la base de reference
        if (exists( select t_ref_hopital_id from t_ref_hopital where numero_finess = :afiness )) then
          strComm = null;
        else 
          strComm = 'ATTENTION NUMERO FINESS A VERIFIER / CORRIGER ';  

    if (:ACHU <> '')  then
    begin 
        -- creation de l hopital  par pseudo ID  
        if (not (exists (select *
                        from t_hopital
                        where t_hopital_id = upper(:ACHU))) ) then
          insert into t_hopital(t_hopital_id,
                                nom,
                                no_finess,
                                rue_1,
                                rue_2,
                                code_postal,
                                nom_ville,
                                tel_standard,
                                fax,
                                commentaire)
          values(upper(:ACHU),
                 upper(:ACHU),
                 :AFiness,
                 substring(:AAdresse1 from 1 for 40),
                 substring(:AAdresse2 from 1 for 40),
                 :ACodePostal,
                 substring(:AVille from 1 for 30),
                 :ATelephone,
                 :AFax,
                 :strComm);

        -- creation du praticien  
        insert into t_praticien(t_praticien_id,
                                type_praticien,
                                nom,
                                prenom,
                                rue_1,
                                rue_2,
                                code_postal,
                                nom_ville,
                                tel_standard,
                                tel_mobile,
                                fax,
                                t_hopital_id,
                                t_ref_specialite_id,
                                no_finess,
                                num_rpps)
        values(:AID,
               '2', -- hospitalier
               :strNom,
               :strPrenom,
               substring(:AAdresse1 from 1 for 40),
               substring(:AAdresse2 from 1 for 40),
               :ACodePostal,
               substring(:AVille from 1 for 30),
               :ATelephone,
               :APortable,
               :AFax,
               upper(:ACHU), -- relie a l hopital par ID
               :intSpecialite,
               :aFiness,
               :ANumRpps);
    end
    else -- pas de liaison hopital   
    if ( (:ACHU is null  ) or ( :ACHU = '')) then   
    begin


        -- creation de l hopital par finess   
        if (not (exists (select *
                        from t_hopital
                        where t_hopital_id = :AFiness)) ) then
        begin
          insert into t_hopital(t_hopital_id,
                                nom,
                                no_finess,
                                rue_1,
                                rue_2,
                                code_postal,
                                nom_ville,
                                tel_standard,
                                fax,
                                commentaire)
          values(:AFiness,
                 'Structure '||:AFiness,
                 :AFiness,
                 substring(:AAdresse1 from 1 for 40),
                 substring(:AAdresse2 from 1 for 40),
                 :ACodePostal,
                 substring(:AVille from 1 for 30),
                 :ATelephone,
                 :AFax,
                 :strComm);
        end
        else 
        -- creation du praticien  
        insert into t_praticien(t_praticien_id,
                                type_praticien,
                                nom,
                                prenom,
                                rue_1,
                                rue_2,
                                code_postal,
                                nom_ville,
                                tel_standard,
                                tel_mobile,
                                fax,
                                t_hopital_id,
                                t_ref_specialite_id,
                                no_finess,
                                num_rpps)
        values(:AID,
               '2', -- hospitalier
               :strNom,
               :strPrenom,
               substring(:AAdresse1 from 1 for 40),
               substring(:AAdresse2 from 1 for 40),
               :ACodePostal,
               substring(:AVille from 1 for 30),
               :ATelephone,
               :APortable,
               :AFax,
               :AFiness, -- relie a l hopital par finess
               :intSpecialite,
               :AFiness,
               :ANumRpps);
    end
  end
  else
  -- finess de cabinet privé
  begin 
        -- creation du praticien  
        insert into t_praticien(t_praticien_id,
                                type_praticien,
                                nom,
                                prenom,
                                rue_1,
                                rue_2,
                                code_postal,
                                nom_ville,
                                tel_standard,
                                tel_mobile,
                                fax,
                                t_ref_specialite_id,
                                no_finess,
                                num_rpps)
        values(:AID,
               '1', -- privé
               :strNom,
               :strPrenom,
               substring(:AAdresse1 from 1 for 40),
               substring(:AAdresse2 from 1 for 40),
               :ACodePostal,
               substring(:AVille from 1 for 30),
               :ATelephone,
               :APortable,
               :AFax,
               :intSpecialite,
               :AFiness,
               :ANumRpps);  
  end 
end;


/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_dest(
  AID integer,
  ANom varchar(50),
  AAdresse1 varchar(50),
  AAdresse2 varchar(50),
  AAdresse3 varchar(50),
  ACodePostal char(5),
  AVille varchar(200),
  ATelephone char(12),
  AFax char(12),
  ALoginBAL varchar(50),
  AMDPBAL varchar(50),
  AEMailBAL varchar(100),
  ANomBAL varchar(50),
  AServeurSMTP varchar(100),
  AServeurPOP3 varchar(100))
as
begin
  insert into t_destinataire(t_destinataire_id,
                             nom,
                             rue_1,
                             rue_2,
                             code_postal,
                             nom_ville,
                             tel_standard,
                             fax,
                             serv_smtp,
                             serv_pop3,
                             utilisateur_pop3,
                             mot_passe_pop3,
                             adresse_bal)
  values(:AID,
         :ANom,
         substring(:AAdresse1 from 1 for 40),
         substring(:AAdresse2 from 1 for 40),
         :ACodePostal,
         substring(:AVille from 1 for 30),
         :ATelephone,
         :AFax,
         substring(:AServeurSMTP from 1 for 50),
         substring(:AServeurPOP3 from 1 for 50),
         :ALoginBAL,
         :AMDPBAL,
         :AEMailBAL);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_org_amo(
  AID integer,
  ANom varchar(30),
  AAbreviation varchar(15),
  AAdresse1 varchar(50),
  AAdresse2 varchar(50),
  AAdresse3 varchar(50),
  ACodePostal char(5),
  AVille varchar(200),
  ATelephone char(12),
  AFax char(12),
  ACodeGrandRegime smallint,
  ACodePrimaire integer,
  ACodeCentre integer,
  ADestinataire integer)
as
declare variable intRegime integer;
begin
  execute procedure ps_renvoyer_id_regime(:ACodeGrandRegime) returning_values :intRegime;

  insert into t_organisme(type_organisme,
                          t_organisme_id,
                          nom,
                          nom_reduit,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          t_ref_regime_id,
                          caisse_gestionnaire,
                          centre_gestionnaire,
                          t_destinataire_id)
  values(1,
         'AMO_' || :AID,
         :ANom,
         :AAbreviation,
         substring(:AAdresse1 from 1 for 40),
         substring(:AAdresse2 from 1 for 40),
         :ACodePostal,
         substring(:AVille from 1 for 30),
         :ATelephone,
         :AFax,
         :intRegime,
         lpad(:ACodePrimaire,3,'0'),
         lpad(:ACodeCentre,4,'0'),
         :ADestinataire);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_org_amc(
  AID integer,
  ANom varchar(30),
  AAbreviation varchar(15),
  AAdresse1 varchar(50),
  AAdresse2 varchar(50),
  AAdresse3 varchar(50),
  ACodePostal char(5),
  AVille varchar(200),
  ATelephone char(12),
  AFax char(12),
  ACodePrefectoral varchar(9),
  ATypeContrat smallint,
  AEstLieeAvecPrim smallint,
  AAMECode char(2),
  ADestinataire integer)
as
begin
  insert into t_organisme(type_organisme,
                          t_organisme_id,
                          nom,
                          nom_reduit,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          identifiant_national,
                          t_destinataire_id,
                          type_contrat)
  values(2,
         'AMC_' || :AID,
         coalesce(:ANom, :AAbreviation),
         :AAbreviation,
         substring(:AAdresse1 from 1 for 40),
         substring(:AAdresse2 from 1 for 40),
         :ACodePostal,
         substring(:AVille from 1 for 30),
         :ATelephone,
         :AFax,
         :ACodePrefectoral,
         :ADestinataire,
         coalesce(:ATypeContrat, 0));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_taux(
  ACouverture integer,
  ANature smallint,
  ACodeActe varchar(3),
  ATauxRemboursement smallint,
  AFormule dm_formule)
as
declare variable intPrestation integer;
declare variable amo varchar(50);
declare variable amc varchar(50);
declare intTaux integer;
begin
  execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;

  if (ANature = 0) then
  begin
    amo = ACouverture;
    amc = null;
    intTaux = ATauxRemboursement;
  end
  else
  begin
    amo = null;
    amc = ACouverture;
    intTaux = ATauxRemboursement / 100;
  end

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amo_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux,
                                     formule)
  values(gen_id(seq_taux_prise_en_charge, 1),
         :amo,
         :amc,
         :intPrestation,
         iif(:ACodeActe = 'PH1', 100,:intTaux ),
         :Aformule);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_couverture(
    AId integer,
    ANom varchar(200),
    ANature smallint,
    ACodeexo varchar(2),
    AAlsaceMoselle  smallint)
as
declare variable id varchar(50);
declare variable ald char(1);
begin
  id = cast(AID as varchar(50));
  if (ANature = 0) then
  begin
    if (:acodeexo = '4') then
        ald = '1';
    else
        ald = '0';

    insert into t_couverture_amo(t_couverture_amo_id,
                                 libelle,
                                 justificatif_exo,
                                 nature_assurance,
                                 ald)
    values(:AID,
           substring(:ANom from 1 for 50),
           :ACodeExo,
           iif( :AAlsaceMoselle = 0 , 10, 13 ),
           :ald);
  end
  else
  begin
    insert into t_couverture_amc(t_couverture_amc_id,
                                 libelle,
                                 montant_franchise,
                                 plafond_prise_en_charge)
    values(:AID,
           substring(:ANom from 1 for 60),
           0,
           0);
  end
end;


/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_couv_amo(
  AOrganismeAMO varchar(50),
  AInCouvertureAMO varchar(3),
  AALD varchar(3))
returns(
  AOutCouvertureAMO varchar(50))
as
declare variable strCouvertureAMO varchar(50);
declare variable chALD char(1);
begin
   chALD = iif(AALD <> '', '1', '0');
   AOutCouvertureAMO = :AOrganismeAMO || '_' || :AInCouvertureAMO || '_' || chALD;

   if ((AInCouvertureAMO <> '') and (AOutCouvertureAMO is not null)) then
   begin
     if (not(exists(select *
                    from t_couverture_amo
                    where t_couverture_amo_id = :AOutCouvertureAMO))) then
     begin
       insert into t_couverture_amo(t_couverture_amo_id,
                                    t_organisme_amo_id,
                                    ald,
                                    libelle,
                                    nature_assurance,
                                    justificatif_exo)
       select :AOutCouvertureAMO,
              :AOrganismeAMO,
              :chALD,
              libelle,
              nature_assurance,
              justificatif_exo
       from t_couverture_amo
       where t_couverture_amo_id = :AInCouvertureAMO
         and t_organisme_amo_id is null;

       insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                          t_couverture_amo_id,
                                          t_couverture_amc_id,
                                          t_ref_prestation_id,
                                          taux)
       select next value for seq_taux_prise_en_charge,
              :AOutCouvertureAMO,
              null,
              t_ref_prestation_id,
              taux
       from t_taux_prise_en_charge
       where t_couverture_amo_id = :AInCouvertureAMO;
     end
   end
   else
     AOutCouvertureAMO = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_couv_amc(
  AOrganismeAMC varchar(50),
  AInCouvertureAMC varchar(3))
returns(
  AOutCouvertureAMC varchar(50))
as
begin
   AOutCouvertureAMC = :AOrganismeAMC || '_' || :AInCouvertureAMC;
   if ((AInCouvertureAMC <> '') and (AOutCouvertureAMC is not null)) then
   begin
     if (not (exists(select *
                     from t_couverture_amc
                     where t_couverture_amc_id = :AOutCouvertureAMC))) then
     begin
       insert into t_couverture_amc(t_couverture_amc_id,
                                    t_organisme_amc_id,
                                    libelle,
                                    montant_franchise,
                                    plafond_prise_en_charge)
       select :AOutCouvertureAMC,
              :AOrganismeAMC,
              libelle,
              montant_franchise,
              plafond_prise_en_charge
       from t_couverture_amc
       where t_couverture_amc_id = :AInCouvertureAMC
         and t_organisme_amc_id is null;

       insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                          t_couverture_amo_id,
                                          t_couverture_amc_id,
                                          t_ref_prestation_id,
                                          taux,
                                          formule)
       select next value for seq_taux_prise_en_charge,
              null,
              :AOutCouvertureAMC,
              t_ref_prestation_id,
              taux,
              formule
       from t_taux_prise_en_charge
       where t_couverture_amc_id = :AInCouvertureAMC;
     end
   end
   else
     AOutCouvertureAMC = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_compte (
    AId integer,
    ANom varchar(200),
    AAdresse1 varchar(50),
    AAdresse2 varchar(50),
    AAdresse3 varchar(50),
    AAdresse4 varchar(50),
    AAdresse5 varchar(50),
    ACodepostal char(5),
    AVille varchar(200),
    ATelephone char(12),
    APortable char(12),
    AFax char(12)
)
as
begin
  insert into t_compte(t_compte_id,
                       nom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_standard,
                       tel_mobile,
                       fax,
                       collectif)
  values(:AId,
         substring(:ANom from 1 for 30),
         substring(:AAdresse1 from 1 for 40),
         substring(:AAdresse2 from 1 for 40),
         :ACodePostal,
         substring(:AVille from 1 for 30),
         :ATelephone,
         :APortable,
         :AFax,
         '1');
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_client (
    AId integer,
    ANom varchar(200),
    AInsee varchar(15),
    AQualite smallint,
    ARang smallint,
    ANaissance char(8),
    APrimaire integer,
    ARegimeprimaire integer,
    ARegimeald integer,
    ADebutdroitprimaire date,
    AFindroitprimaire date,
    ADebutdroitALD date,
    AFindroitALD date,
    AAdhspsante varchar(16),
    ANumerospsante varchar(18),
    AMutuellecarte integer,
    ARegimemutuellecarte integer,
    ADebutdroitmutuellecarte date,
    AFindroitmutuellecarte date,
    AMutuelledexia integer,
    ARegimemutuelledexia integer,
    ADebutdroitmutuelledexia date,
    AFindroitmutuelledexia date,
    AMutuellefichier integer,
    ARegimemutuellefichier integer,
    ADebutdroitmutuellefichier date,
    AFindroitmutuellefichier date,
    ASexe varchar(2),
    ANomjeunefille varchar(50),
    AAdresse1 varchar(50),
    AAdresse2 varchar(50),
    AAdresse3 varchar(50),
    AAdresse4 varchar(50),
    AAdresse5 varchar(50),
    ACodepostal char(5),
    AVille varchar(200),
    ATelephone char(12),
    APortable char(12),
    AFax char(12),
    ADatecreation date,
    ARemarque varchar(200),
    AMemo varchar(1000),
    ACompte smallint,
    AIDCompte integer,
    ADateDerniereVisite date)
returns (
    ainfoetatcouvertureamo char(1),
    ainfoetatcouvertureamc char(1))
as
declare variable strclient varchar(50);
declare variable strnom varchar(50);
declare variable strprenom varchar(50);
declare variable strNJF varchar(50);
declare variable strcentregestionnaire varchar(4);
declare variable strorganismeamo varchar(50);
declare variable strcouvertureamo varchar(50);
declare variable strorganismeamc varchar(50);
declare variable strcouvertureamc varchar(50);
declare variable dtdebutdroitamc date;
declare variable dtfindroitamc date;
begin
  AInfoEtatCouvertureAMO = '1';
  AInfoEtatCouvertureAMC = '1';

  /* Informations AMO */
  strOrganismeAMO = 'AMO_' || APrimaire;

  /* Centre payeur*/
  select centre_gestionnaire from t_organisme where t_organisme_id = :strOrganismeAMO into :strCentreGestionnaire;

  /*delete from t_tmp_couverture_amc_client;*/
  if (AMutuelleCarte is not null) then insert into t_caducielv6_couv_amc_client values(:AID, :AMutuelleCarte, :ARegimeMutuelleCarte, :ADebutDroitMutuelleCarte, :AFinDroitMutuelleCarte);
  if (AMutuelleDexia is not null) then insert into t_caducielv6_couv_amc_client values(:AID, :AMutuelleDexia, :ARegimeMutuelleDexia, :ADebutDroitMutuelleDexia, :AFinDroitMutuelleDexia);
  if (AMutuelleFichier is not null) then insert into t_caducielv6_couv_amc_client values(:AID, :AMutuelleFichier, :ARegimeMutuelleFichier, :ADebutDroitMutuelleFichier, :AFinDroitMutuelleFichier);

  /* Recherche des informations AMC */
  select first 1 'AMC_' || t_organisme_amc_id,
                 t_couverture_amc_id,
                 debut_droit_amc,
                 fin_droit_amc
  from t_caducielv6_couv_amc_client
  where t_client_id = :AID
  order by fin_droit_amc desc
  into :strOrganismeAMC,
       :strCouvertureAMC,
       :dtDebutDroitAMC,
       :dtFinDroitAMC;

  if (strOrganismeAMC is not null) then
  begin
    execute procedure ps_caducielv6_creer_couv_amc(:strOrganismeAMC, :strCouvertureAMC) returning_values :strCouvertureAMC;

    when any do
    begin
      AInfoEtatCouvertureAMC = '0';
      strCouvertureAMC = null;
      dtFinDroitAMC = null;
    end
  end
  else
  begin
    strCouvertureAMC = null;
    dtFinDroitAMC = null;
  end

  execute procedure ps_separer_nom_prenom(:ANom, ' ') returning_values :strNom, :strPrenom, :strNJF;

  /* Création du client */
  --if (( AQualite is not null ) or ( :AIDCompte is not null)) then
  begin
    insert into t_client(t_client_id,
                         numero_insee,
                         nom,
                         prenom,
                         nom_jeune_fille,
                         rue_1,
                         rue_2,
                         code_postal,
                         nom_ville,
                         tel_personnel,
                         tel_mobile,
                         fax,
                         qualite,
                         rang_gemellaire,
                         date_naissance,
                         t_organisme_amo_id,
                         centre_gestionnaire,
                         t_organisme_amc_id,
                         t_couverture_amc_id,
                         debut_droit_amc,
                         fin_droit_amc,
                         numero_adherent_mutuelle,
                         contrat_sante_pharma,
                         genre,
                         commentaire_individuel,
                         date_derniere_visite)
    values(:AID,
           substring(:AInsee from 1 for 15),
           substring(:strNom from 1 for 30),
           substring(:strPrenom from 1 for 30),
           substring(coalesce(:ANomJeuneFille, :strNJF) from 1 for 30),
           substring(:AAdresse1 from 1 for 40),
           substring(:AAdresse2 from 1 for 40),
           :ACodePostal,
           substring(:AVille from 1 for 30),
           :ATelephone,
           :APortable,
           :AFax,
           coalesce(:AQualite, '0'),
           :ARang,
           iif(char_length(trim(:ANaissance)) = 8, :ANaissance, null),
           :strOrganismeAMO,
           :strCentreGestionnaire,
           :strOrganismeAMC,
           :strCouvertureAMC,
           :dtDebutDroitAMC,
           :dtFinDroitAMC,
           :AAdhSPSante,
           :ANumeroSPSante,
           case
             when :ASexe = 'F' then 'F'
             else 'H'
           end,
           substring(trim(:ARemarque) || ' ' || trim(:AMemo) from 1 for 200),
           :ADateDerniereVisite);

    if ( AMemo >'' ) then
      insert into t_commentaire (t_commentaire_id,
                                   t_entite_id,
                                   type_entite,
                                   commentaire,
                                   est_global )
      values ( next value for seq_commentaire,
                 :AID,
                 '0', -- client 
                  cast(:AMemo as blob),
                  1 );

    if ( ARemarque >'' ) then
      insert into t_commentaire (t_commentaire_id,
                                   t_entite_id,
                                   type_entite,
                                   commentaire,
                                   est_global )
      values ( next value for seq_commentaire,
                 :AID,
                 '0', -- client 
                  cast(:ARemarque as blob),
                  1 );

    /* Création informations AMO */
    if (strOrganismeAMO is not null) then
      begin
        execute procedure ps_caducielv6_creer_couv_amo(:strOrganismeAMO, :ARegimePrimaire, '') returning_values :strCouvertureAMO;
        if (strCouvertureAMO is not null) then
          insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                              t_client_id,
                                              t_couverture_amo_id,
                                              debut_droit_amo,
                                              fin_droit_amo)
          values(next value for seq_couverture_amo_client,
                 :AID,
                 :strCouvertureAMO,
                 :ADebutDroitPrimaire,
                 :AFinDroitPrimaire);

        execute procedure ps_caducielv6_creer_couv_amo(:strOrganismeAMO, :aregimeald, '1') returning_values :strCouvertureAMO;
        
        if (strCouvertureAMO is not null) then
          insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                              t_client_id,
                                              t_couverture_amo_id,
                                              debut_droit_amo,
                                              fin_droit_amo)
          values(next value for seq_couverture_amo_client,
                 :AID,
                 :strCouvertureAMO,
                 :ADebutdroitALD,
                 :AFindroitALD);

        when any do
          AInfoEtatCouvertureAMO = '0';
      end
    end

  if (AIDCompte is not null) then
    insert into t_compte_client(t_compte_client_id,
                                t_compte_id,
                                t_client_id)
    values(next value for seq_compte_client,
           :AIDCompte,
           :AID);

 
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_lineaire(
  AID integer,
  ACode varchar(20),
  ANom varchar(200))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
                                 libelle)
  values(:AID,
         substring(:ANom from 1 for 50));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_codif(
  ARang numeric(1),
  ACode varchar(20),
  ANom varchar(200))
as
begin
  insert into t_codification(t_codification_id,
                             rang,
                             code,
                             libelle)
  values(next value for seq_codification,
         :ARang,
         :ACode,
         substring(:ANom from 1 for 50));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_fournisseur(
  AID varchar(50),
  ANom varchar(200),
  ACodePostal char(5),
  ANomVille varchar(200),
  AAdresse1 varchar(50),
  AAdresse2 varchar(50),
  AAdresse3 varchar(50),
  ATypeFournisseur char(1),
  ATypeProtocole smallint,
  ATelephone char(12),
  AFax char(12),
  APortable char(12),
  AAdresseInternet varchar(100),
  pharmaml_ref_id varchar(3),
  pharmaml_url_1 varchar(150),
  pharmaml_url_2 varchar(150),
  pharmaml_id_officine varchar(20),
  pharmaml_id_magasin varchar(20),
  pharmaml_cle varchar(4),
  AMemo varchar(1000))
as
begin
  if (ATypeFournisseur in ('G')) then
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale,
                              tel_standard,
                              fax,
                              email,
                              commentaire,
                              pharmaml_ref_id,
                              pharmaml_url_1, 
                              pharmaml_url_2,
                              pharmaml_id_officine,
                              pharmaml_id_magasin,
                              pharmaml_cle)
    values(:AID,
           substring(:ANom from 1 for 50),
           :ATelephone,
           :AFax,
           :AAdresseInternet,
           :AMemo,
           iif(:pharmaml_ref_id='',0,:pharmaml_ref_id), 
           :pharmaml_url_1,
           :pharmaml_url_2,
           :pharmaml_id_officine,
           :pharmaml_id_magasin,
           :pharmaml_cle);
  else
    if (ATypeFournisseur in ('D', 'M')) then
      insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                       raison_sociale,
                                       tel_standard,
                                       fax,
                                       email,
                                       commentaire)
      values(:AID,
             substring(:ANom from 1 for 50),
             :ATelephone,
             :AFax,
             :AAdresseInternet,
             substring(:AMemo from 1 for 200));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_histo_vente (
  AProduit integer,
  AMois smallint,
  AAnnee smallint,
  AQteVendue integer)
as
begin
  if (AQteVendue > 0) then
    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_vendues,
                                   quantite_actes)
    values(next value for seq_historique_vente,
           :AProduit,
           lpad(:AMois, 2, '0') || lpad(:AAnnee, 4, '0'),
           :AQteVendue,
           :AQteVendue);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_produit (
  AID integer,
  ANom varchar(50),
  ACodeActe varchar(3),
  APrixVente float,
  APrixRemboursement float,
  APrixAchatMoyen float,
  AStockTotal integer,
  AStockMini integer,
  AStockMaxi integer,
  ACodeTableau varchar(2),
  ATauxTVA float,
  AFamille integer,
  ALineaire integer,
  ACategorie integer,
  ADisponible varchar(10),
  ACodeLaboTaux smallint,
  ADelaiViande smallint,
  ADelaiLait smallint,
  ADateDerniereVente date,
  ACodeService varchar(2),
  ARemarque varchar(200),
  AMemo varchar(1000),
  ADateCreation date,
  APeremption date,
  AFabricant varchar(50),
  ARepartiteurExclusif integer,
  AminiPhie integer,
  Amaxiphie integer,
  AQuantitePhie integer,
  Aminireserve integer,
  Amaxireserve integer,
  AquantiteReserve integer,
  AAutomate integer,
  AStockAuto integer,
  ASeuil integer
  )
as
declare variable intTVA integer;
declare variable intPrestation integer;
declare variable intCategorie integer;
declare variable intFamille integer;
declare variable intMarque integer;
declare variable t_depot_phie_id dm_code;
declare variable t_depot_reserve_id dm_code;
declare variable t_depot_automate_id dm_code;

begin
  execute procedure ps_renvoyer_id_tva(:ATauxTVA) returning_values :intTVA;
  execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;
  execute procedure ps_renvoyer_id_codification('1', ACategorie) returning_values :intCategorie;
  execute procedure ps_renvoyer_id_codification('2', AFamille) returning_values :intFamille;
  execute procedure ps_renvoyer_id_marque(AFabricant) returning_values :intMarque;

  select t_depot_id from t_depot where libelle ='PHARMACIE' into :t_depot_phie_id ;
  select t_depot_id from t_depot where libelle ='RESERVE' into :t_depot_reserve_id ;
  select t_depot_id from t_depot where libelle ='AUTOMATE' into :t_depot_automate_id ;

  -- Produit
  insert into t_produit(t_produit_id,
                        designation,
                        etat,
                        liste,
                        t_ref_prestation_id,
                        date_derniere_vente,
                        type_homeo,
                        t_codif_1_id,
                        t_codif_2_id,
                        prix_achat_catalogue,
                        prix_vente,
                        base_remboursement,
                        t_ref_tva_id,
                        delai_viande,
                        delai_lait,
                        commentaire_commande,
                        commentaire_vente,
                        date_peremption,
                        service_tips,
                        t_codif_6_id,
                        stock_mini,
                        stock_maxi, 
                        t_repartiteur_id,
                        calcul_gs)
  values(:AID,
         :ANom,
         case
           when :ADisponible = 1 then '1'
           when :ADisponible = 3 then '7'
           else '1'
         end,
         case
           when :ACodeTableau in ('1', '3') then '1'
           when :ACodeTableau in ('2', '4') then '2'
           when :ACodeTableau in ('5', '6') then '3'
           else '0'
         end,
         :intPrestation,
         :ADateDerniereVente,
         case
           when :ACodeLaboTaux = '6' then '1'
           when :ACodeLaboTaux = '7' then '2'
           else '0'
         end,
         :intCategorie,
         :intCategorie,
         coalesce(:APrixAchatMoyen, 0),
         :APrixVente,
         :APrixRemboursement,
         :intTVA,
         :ADelaiViande,
         :ADelaiLait,
         :ARemarque,
         substring(:AMemo from 1 for 200),
         :APeremption,
         case
           when :ACodeService = '-' then null
           else :ACodeService
         end,
         :intMarque,
         iif( :AStockAuto = 0, :AStockMini, :ASeuil ), -- si stock auto => mini = sock_mini sinon seuil
         iif( :AStockAuto = 0, :AStockMaxi, null ), -- si stock auto => maxi = stico_maxi sinon rien
         :ARepartiteurExclusif,
         iif( :AStockAuto = 0, 4, 0 ));  -- si stock auto => fixé sinon par defaut 

  -- Stocks
  if ( AquantitePhie is not null ) then 
  insert into t_produit_geographique(t_produit_geographique_id,
                                     t_produit_id,
                                     t_zone_geographique_id,
                                     quantite,
                                     t_depot_id,
                                     stock_mini,
                                     stock_maxi)
  values(next value for seq_produit_geographique,
         :AID,
         :ALineaire,
         :AquantitePhie,
         iif(:AAutomate = -1,:t_depot_automate_id, :t_depot_phie_id),
         :AminiPhie,
         :AMaxiPhie);
         
  if ( AquantiteReserve is not null ) then
  insert into t_produit_geographique(t_produit_geographique_id,
                                     t_produit_id,
                                     t_zone_geographique_id,
                                     quantite,
                                     t_depot_id,
                                     stock_mini,
                                     stock_maxi)
  values(next value for seq_produit_geographique,
         :AID,
         :ALineaire,
         :AquantiteReserve,
         :t_depot_reserve_id,
         :Aminireserve,
         :AMaxiReserve);         
         
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_code_prod(
  codeprod_num_produit_fk varchar(50), --integer mis en varchar direct pour éviter le cast ensuite
  typcodprod_num_code smallint,
  -- filtrage des cip7, ean13, cip13 dans l'ordre cip7 en dernier 
  -- le cip 7 ne doit etre repris que si il est unique et pas d'autres codes'
  codeprod_cde_code varchar(13))
as
begin

    if (:codeprod_cde_code SIMILAR TO '[[:DIGIT:]]{7}') then
      update t_produit
      set code_cip =:codeprod_cde_code
      where t_produit_id = :codeprod_num_produit_fk and code_cip is null
        and (select t_code_ean13_id from t_code_ean13 where t_produit_id = :codeprod_num_produit_fk) is null;
    else  
      if (:codeprod_cde_code SIMILAR TO '340[01][[:DIGIT:]]{9}') then
        update t_produit
        set code_cip =:codeprod_cde_code
        where t_produit_id = :codeprod_num_produit_fk;
      else 
        insert into t_code_ean13 ( t_code_ean13_id , t_produit_id, code_ean13, referent)
        values (next value for seq_code_ean13, :codeprod_num_produit_fk, substring(:codeprod_cde_code from 1 for 13), '0');
end;


/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_code_ean13(
  AProduit integer,
  ACodeEAN13 varchar(30))
as
begin
  insert into t_code_ean13(t_code_ean13_id,
                           t_produit_id,
                           code_ean13)
  values(next value for seq_code_ean13,
         :AProduit,
         :ACodeEAN13);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_code_lppr(
  AProduit integer,
  ACodeLPPR varchar(7),
  ACodeActe varchar(3),
  AService varchar(2),
  APrixVente float,
  AQuantite smallint)
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;

  insert into t_produit_lpp(t_produit_lpp_id,
                            t_produit_id,
                            type_code,
                            code_lpp,
                            tarif_unitaire,
                            quantite,
                            service_tips,
                            t_ref_prestation_id)
  values (next value for seq_produit_lpp,
          :AProduit,
          0,
          :ACodeLPPR,
          :APrixVente,
          :AQuantite,
          :AService,
          :intPrestation);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_hist_entete(
  AID integer,
  AClient integer,
  AMedecin integer,
  ANumeroFacture integer,
  APrescription date,
  ADateActe date,
  ADateHorodatage date,
  AMontantDu float)
as
begin
  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  numero_facture,
                                  date_prescription,
                                  code_operateur,
                                  t_praticien_id,
                                  type_facturation,
                                  date_acte)
  values(:AID,
         :AClient,
         :ANumeroFacture,
         :APrescription,
         '.',
         :AMedecin,
         '2',
         coalesce(:ADateActe, :ADateHorodatage));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_hist_ligne (
  AID integer,
  ANom varchar(50),
  AProduit varchar(50),
  ACodeActe varchar(3),
  ADelivrance integer,
  AQuantite smallint,
  APrixUnitaire float,
  APrixAchat float,
  ACodeProduit varchar(20))
as
begin
  if (AQuantite > 0) then
    insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                          t_historique_client_id,
                                          code_cip,
                                          t_produit_id, 
                                          designation,
                                          quantite_facturee,
                                          prix_vente)
    values(next value for seq_historique_client_ligne,
           :ADelivrance,
           iif(:ACodeProduit = '', null ,:ACodeProduit),
           :AProduit,
           :ANom,
           :AQuantite,
           :APrixUnitaire);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_operateur(
  AIDOperateur integer,
  ACode varchar(3),
  ANom varchar(50))
as
begin
  insert into t_operateur(t_operateur_id,
                          code_operateur,
                          nom)
  values(:AIDOperateur,
         trim(:ACode),
         :ANom);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_credit_cli(
  AIDCredit integer,
  ADateCredit date,
  AIDClient integer,
  AMontant float)
as
begin
  if (exists(select *
             from t_credit
             where t_client_id = :AIDClient)) then
    update t_credit
    set montant = montant + :AMontant
    where t_client_id = :AIDClient;
  else
    insert into t_credit(t_credit_id,
                         t_client_id,
                         date_credit,
                         montant)
    values(:AIDCredit,
           :AIDClient,
           :ADateCredit,
           :AMontant);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_credit_cpt(
  AIDCredit integer,
  ADateCredit date,
  AIDCompte integer,
  AMontant float)
as
begin
  if (exists(select *
             from t_compte
             where t_compte_id = :AIDCompte)) then
  begin
    if (exists(select *
               from t_credit
               where t_compte_id = :AIDCompte)) then
      update t_credit
      set montant = montant + :AMontant
      where t_compte_id = :AIDCompte;
    else
      insert into t_credit(t_credit_id,
                           t_compte_id,
                           date_credit,
                           montant)
      values(:AIDCredit,
             :AIDCompte,
             :ADateCredit,
             :AMontant);
  end
  else
    execute procedure ps_caducielv6_creer_credit_cli(:AIDCredit, :ADateCredit, :AIDCompte, :AMontant);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_avance(
  AIDVignette integer,
  AIDClient integer,
  ADateVignette date,
  AIDProduit integer,
  ADesignation varchar(50),
  APrixUnitaire float,
  APrixVente float,
  ABaseRemboursement float,
  AActe varchar(3),
  AQuantite smallint)
as
begin

  if ( upper(ADesignation) not like '%ANNUL%VIGNETTE%' ) then
  insert into t_vignette_avancee(t_vignette_avancee_id,
                                 t_client_id,
                                 date_avance,
                                 t_produit_id,
                                 code_cip,
                                 designation,
                                 prix_achat,
                                 prix_vente,
                                 base_remboursement,
                                 code_prestation,
                                 quantite_avancee)
  values(:AIDVignette,
         :AIDClient,
         :ADateVignette,
         :AIDProduit,
         ( select code_cip from t_produit where t_produit_id = :AIDProduit ),
         :ADesignation,
         :APrixUnitaire,
         :APrixVente,
         :ABaseRemboursement,
         :AActe,
         :AQuantite);
  else 
  delete from t_vignette_avancee
  where t_vignette_avancee_id = :AIDVignette ;

end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_du(
  AIDProduit integer,
  AIDClient integer,
  AQuantite smallint,
  ADateDu date)
as
begin
  insert into t_produit_du(t_produit_du_id,
                           t_produit_id,
                           t_client_id,
                           date_du,
                           quantite)
  values(next value for seq_produit_du,
         :AIDProduit,
         :AIDClient,
         :ADateDu,
         :AQuantite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_commande(
  AIDCommande integer,
  ACommandeDirecte smallint,
  ADateCreation date,
  AIDFournisseur integer,
  AEtatCommande integer,
  ADateReception date)
as
declare variable t char(1);
declare variable f varchar(50);
declare variable r varchar(50);
begin
  r = null;
  f = AIDFournisseur;
  if(exists(select *
            from t_fournisseur_direct
            where t_fournisseur_direct_id = :f)) then
    t = '1';
  else
  begin
    t = '2';
    r = f;
    f = null;
  end
  insert into t_commande(t_commande_id,
                         type_commande,
                         mode_transmission,
                         t_fournisseur_direct_id,
                         t_repartiteur_id,
                         etat,
                         montant_ht,
                         date_creation,
                         date_reception)
  values(:AIDCommande,
         :t,
         '5',
         :f,
         :r,
         case
           when :AEtatCommande = 3 then '2'
           when :AEtatCommande = 4 then '3'
           when :AEtatCommande = 6 then '22'
         end,
         0,
         :ADateCreation,
         coalesce(:ADateReception, :ADateCreation));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_com_ligne(
  AIDLigneCommande integer,
  AIDCommande integer,
  AIDProduit integer,
  AQuantiteCommandee smallint,
  AQuantiteLivree smallint,
  APrixAchat float,
  APrxAchatPML float,
  APrixAchatCatalogue float,
  APrixAchatCataloguePML float,
  APrixVente float,
  ARemise1 float,
  ARemise2 float,
  AQuantiteGratuite float)
as
declare variable c varchar(50);
begin
  c = cast(AIDCommande as varchar(50));

  update t_commande
  set montant_ht = montant_ht + :AQuantiteCommandee * :APrixAchat
  where t_commande_id = :c;

  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               quantite_totale_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente,
                               unites_gratuites)
  values(:AIDLigneCommande,
         :c,
         :AIDProduit,
         :AQuantiteCommandee,
         coalesce(:AQuantiteLivree, 0),
         coalesce(:AQuantiteLivree + :AQuantiteGratuite, 0),
         coalesce(:APrixAchatCatalogue, :APrixAchat),
         :APrixAchat,
         :APrixVente,
         coalesce(:AQuantiteGratuite, 0));
end;

/* ********************************************************************************************** */
create or alter procedure ps_caducielv6_creer_document(
  AIDClient integer,
  ANomFichier varchar(255),
  ACommentaire varchar(50))
as
begin
  insert into t_document(
    t_document_id,
    type_entite,
    t_entite_id,
    libelle,
    document)
  values(next value for seq_document,
    2,
    :AIDClient,
    :ACommentaire,
    :ANomFichier);
end;

create or alter procedure ps_eclater_sp_sante(
  AIDOrganismeAMC varchar(50))
as
declare variable c varchar(50);
declare variable adh varchar(16);
declare variable org varchar(50);
declare variable org_id varchar(50);
declare variable couv varchar(50);
declare variable couv_sp varchar(50);
declare variable nom varchar(50);
declare variable d varchar(50);
begin
  -- tous les clients reliés à cette caisse
  for select c.t_client_id, 
             substring(c.contrat_sante_pharma from 1 for 8), 
             c.t_couverture_amc_id, 
             o.t_destinataire_id
      from t_client c
           inner join t_organisme o on (o.t_organisme_id = c.t_organisme_amc_id)
      where t_organisme_amc_id = :AIDOrganismeAMC 
        and c.contrat_sante_pharma <> ''
      into :c, 
           :adh, 
           :couv, 
           :d 
  do
  begin
    -- recherche d un organisme deja existant 
    select first 1 t_organisme_id 
    from t_organisme
    where identifiant_national =  :adh
    into org_id;

    if (org_id is null ) then  
    begin 
      --insert into t_debug values ( current_time ||' création de ' || :org_id);
      org = 'MSPSANTE_' || :adh;
    end  
    else 
    begin 
      --insert into t_debug values ( current_time ||' existe deja ' || :org_id)
      org = org_id;
    end   



    -- creation si necessaire    
    if (not exists(select *
                   from t_organisme
                   where t_organisme_id = :org)) then
    begin
      select nom
      from t_ref_organisme
      where identifiant_national = :adh
      into nom;

      if ( :nom is not null ) then
      insert into t_organisme(type_organisme,
                              t_organisme_id,
                              nom,
                              nom_reduit,
                              type_releve,
                              identifiant_national,
                              t_destinataire_id,
                              org_sante_pharma,
                              prise_en_charge_ame,
                              type_contrat,
                              saisie_no_adherent)
      values('2',
             :org,
             :nom ,
             :adh,
             '0',
             :adh,
             :d,
             '0',
             '0',
             0,
             '0');
    end
    
    update t_organisme 
    set commentaire = 'Ne plus utiliser, traité par l''éclatement SP SANTE'
    where t_organisme_id = :AIDOrganismeAMC;

    couv_sp = org ||'_' || couv;
    if (couv is not null) then
    begin
      if (not exists(select *
                     from t_couverture_amc
                     where t_couverture_amc_id = :couv_sp)) then
      begin
        insert into t_couverture_amc(t_organisme_amc_id,
                                     t_couverture_amc_id,
                                     libelle,
                                     montant_franchise,
                                     plafond_prise_en_charge,
                                     formule,
                                     couverture_cmu)
        select :org,
               :couv_sp,
               libelle,
               montant_franchise,
               plafond_prise_en_charge,
               formule,
               couverture_cmu
        from t_couverture_amc
        where t_couverture_amc_id = :couv;
        
        insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                           t_couverture_amc_id,
                                           taux,
                                           t_ref_prestation_id,
                                           formule)
        select next value for seq_taux_prise_en_charge,
               :couv_sp,
               taux,
               t_ref_prestation_id,
               formule
        from t_taux_prise_en_charge
        where t_couverture_amc_id = :couv;
      end
    end
    
    --MAJ Client
    update t_client
    set t_organisme_amc_id = :org,
        t_couverture_amc_id = :couv_sp, 
        contrat_sante_pharma = 'SP'
    where t_client_id = :c;
  end
end;

create or alter procedure ps_caduciel_sp_sante
as
declare variable org_id varchar(50);
begin
/* ATTENTION PAS ENCORE VALIDÉE */
-- on essaye de trouver la liste des SP SANTE a eclater par leur nom 


  for select distinct T_ORGANISME_AMC_ID from t_client
      where t_organisme_amc_id in ( select t_organisme_id 
                                    from t_organisme
                                    where upper(nom) like 'SP%SANTE%' )
                                    and FIN_DROIT_AMC > current_date

  into :org_id do
    execute procedure ps_eclater_sp_sante( org_id ); 
end;


create or alter procedure ps_caduciel_creer_attente (
  AAttenteID varchar(50),
  ADateAttente date, 
  AClientID varchar(50)  
)
as
begin
  insert into t_facture_attente(t_facture_attente_id,
                                date_acte,
                                t_client_id)
  values(:AAttenteId,
         :ADateAttente,
         :AClientId);
end;

create or alter procedure ps_caduciel_creer_attente_ligne (
  AAttenteID varchar(50),
  ANumeroOrdre integer,
  AProduitID dm_code,
  AQuantite integer,
  APrixVente float,
  APrixAchat float,
  ACodeActe varchar(3)
)
as
declare variable intPrestation integer;
begin
    execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;

    insert into t_facture_attente_ligne(t_facture_attente_ligne_id,
                                        t_facture_attente_id,
                                        t_produit_id,
                                        quantite_facturee,
                                        t_ref_prestation_id,
                                        prix_vente,
                                        prix_achat)
    values(next value for seq_facture_attente_ligne,
           :AAttenteID,
           :AProduitID,
           :AQuantite,
           :intPrestation,
           :APrixVente,
           :APrixAchat);
end;
