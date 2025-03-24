set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 101) then
  begin
    delete from t_depot;
    insert into t_depot values('1', 'Stock principal', '0', 'SUVE');
    insert into t_depot values('2', 'Automate', '1', 'SUVE');
    insert into t_depot values('3', 'Arrière boutique', '0', 'SUAL_R');
    insert into t_depot values('4', 'Sous-sol', '0', 'SUAL_D');
    insert into t_depot values('5', 'Etage', '0', 'SUAL_D');
    insert into t_depot values('1', 'Autre', '0', 'SUAL_D');
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_medecin(
  AID float,
  ANumeroFiness varchar(9),
  ASpecialite varchar(2),
  AHospitalier varchar(1),
  ASalarie varchar(1),
  ASNCF varchar(1),
  AMines varchar(1),
  ARPPS varchar(11), 
  ANomprenom varchar(27) )
as
declare variable intSpecialite integer;
declare variable nom varchar(50);
declare variable prenom varchar(50);
declare variable njf varchar(50);
begin
  
  if (trim(Anomprenom) = '') then ANomPrenom = null;
  execute procedure ps_renvoyer_id_specialite(:ASpecialite) returning_values :intSpecialite;
  execute procedure ps_separer_nom_prenom(:ANomprenom,' ') returning_values :nom,:prenom, :njf;

  
  insert into t_praticien(t_praticien_id,
                          nom,
                          prenom,
                          t_ref_specialite_id,
                          num_rpps,
                          no_finess)
  values(:AID,
         coalesce(trim(:nom),:ANumeroFiness),
         coalesce(trim(:prenom),'_'),
         :intSpecialite,
         :ARPPS,
         :ANumeroFiness);
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_org_amo(
  AID float,
  AIDNatAMO varchar(9))
as
declare variable intRegime integer;
begin
  execute procedure ps_renvoyer_id_regime(substring(:AIDNatAMO from 1 for 2)) returning_values :intRegime;

  insert into t_organisme(t_organisme_id,
                          type_organisme,
                          nom,
                          t_ref_regime_id,
                          caisse_gestionnaire,
                          centre_gestionnaire)
  values(:AID,
         '1',
         :AIDNatAMO,
         :intRegime,
         substring(:AIDNatAMO from 3 for 3),
         substring(:AIDNatAMO from 6 for 4));
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_org_amc(
  AID float,
  Anom varchar(16),
  ACode1 varchar(8),
  ACodePrefectoral varchar(8))
as
begin
  insert into t_organisme(t_organisme_id,
                          type_organisme,
                          nom,
                          identifiant_national)
  values(:AID,
         '2',
         :Anom,
         coalesce(:ACodePrefectoral,:acode1));
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_taux(
  AIDAMC varchar(50),
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
         :AIDAMC,
         :intPrestation,
         :ATaux);
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_contrat_amc(
  AID float,
  AIDAMC float,
  ALibelle varchar(20),
  APH1 float,
  APH4 float, 
  APH7 float,
  APH2 float,
  APHN float)
as
begin
  insert into t_couverture_amc(t_couverture_amc_id,
                               t_organisme_amc_id,
                               libelle,
                               montant_franchise,
                               plafond_prise_en_charge,
                               formule)
  values(:AID,
         :AIDAMC,
         trim(:ALibelle),
         0,
         0,
         '021');

  execute procedure ps_actipharm_creer_taux(:AID, 'PHN', APHN);
  execute procedure ps_actipharm_creer_taux(:AID, 'PH1', APH1);
  execute procedure ps_actipharm_creer_taux(:AID, 'PH2', APH2);
  execute procedure ps_actipharm_creer_taux(:AID, 'PH4', APH4);
  execute procedure ps_actipharm_creer_taux(:AID, 'PH7', APH7);
  execute procedure ps_actipharm_creer_taux(:AID, 'PMR', APH7);
  execute procedure ps_actipharm_creer_taux(:AID, 'AAD', APH7);
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_client(
  AID float,
  ANom varchar(30),
  APrenom varchar(30),
  ARue1 varchar(30),
  ARue2 varchar(30),
  ARue3 varchar(30),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  ATelephone varchar(20),
  AFax varchar(20),
  APortable varchar(20),
  ADateCreation date)
as
begin
  insert into t_client(t_client_id,
                       nom,
                       prenom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_standard,
                       tel_mobile,
                       fax,
                       date_creation,
                       qualite)
  values(:AID,
         trim(:ANom),
         trim(:APrenom),
         trim(:ARue1),
         substring(trim(:ARue2) || ' ' || trim(:ARue3) from 1 for 40),
         :ACodePostal,
         trim(:ANomVille),
         trim(:ATelephone),
         trim(:APortable),
         trim(:AFax),
         :ADateCreation,
         '0');
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_maj_assure(
  AID float,
  ANumeroInsee varchar(15),
  AIDNatAMO varchar(9),
  AIDAmo float,
  AIDCentreAMO float)
as
declare variable strClient varchar(50);
declare variable c varchar(4);
begin
  select o.centre_gestionnaire
  from t_organisme o
       inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
  where t_organisme_id = :AIDAMO
    and r.sans_centre_gestionnaire = '1'
  into :c;

  insert into t_client(t_client_id,
                       numero_insee,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       nom,
                       prenom,
                       qualite)
  values(:AID,
         :ANumeroInsee,
         :AIDAmo,
         :c,
         :AID,
         '_',
         '0');
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_maj_ayant_droit(
  AID float,
  AIDAssure float,
  ANumeroInsee varchar(15),
  AQualite varchar(2),
  ARangGemellaire char(1),
  ANom varchar(27),
  ANomJeuneFille varchar(27),
  APrenom varchar(27),
  ADateNaissance varchar(8),
  ASexe char(1),
  AIDAMCFichier float,
  AIDAMCCarte float,
  AIDCouvAMCFichier float,
  AIDCouvAMCCarte float,
  ANumeroAdherentMutuelle varchar(16),
  ADebutDroitAMCFichier date,
  ADebutDroitAMCCarte date,
  AFinDroitAMCFichier date,
  AFinDroitAMCCarte date,
  AAdresse1 varchar(32),
  AAdresse2 varchar(32),
  AAdresse3 varchar(32),
  ADerniereVisite date
  )
as
declare variable strClient varchar(50);
declare variable strAssure varchar(50);
declare variable q integer;
declare variable o varchar(50);
declare variable c varchar(4);
declare variable cp varchar(5);
declare variable ville varchar(25);
begin
  strClient = cast(AID as varchar(50));
  strAssure = cast(AIDAssure as varchar(50));
  q = cast(AQualite as integer);

  select t_organisme_amo_id, centre_gestionnaire
  from t_client
  where t_client_id = :strAssure
  into :o, :c;

  update or insert into t_client(t_client_id,
                            numero_insee,
                            qualite,
                            rang_gemellaire,
                            nom,
                            nom_jeune_fille,
                            prenom,
                            date_naissance,
                            genre,
                            t_organisme_amo_id,
                            centre_gestionnaire,
                            t_organisme_amc_id,
                            t_couverture_amc_id,
                            numero_adherent_mutuelle,
                            debut_droit_amc,
                            fin_droit_amc,
              rue_1,
              rue_2,
              code_postal,
              nom_ville,
              date_derniere_visite
              )
  values(:strClient,
         :ANumeroInsee,
         :q,
         :ARangGemellaire,
         :ANom,
         :ANomJeuneFille,
         :APrenom,
         substring(:ADateNaissance from 7 for 2) || substring(:ADateNaissance from 5 for 2) || substring(:ADateNaissance from 1 for 4),
         case
           when :ASexe = 'M' then 'H'
           when :ASexe = 'F' then 'F'
           else null
         end,
         :o,
         :c,
         iif(:AIDAMCCarte <> 0, :AIDAMCCarte, :AIDAMCFichier),
         iif(:AIDCouvAMCCarte <> 0, :AIDCouvAMCCarte, :AIDCouvAMCFichier),
         :ANumeroAdherentMutuelle,
         iif(:ADebutDroitAMCCarte is not null, :ADebutDroitAMCCarte, :ADebutDroitAMCFichier),
         iif(:AFinDroitAMCCarte is not null, :AFinDroitAMCCarte, :AFinDroitAMCFichier),
     :AAdresse1,
     :AAdresse2,
     substring(:AAdresse3 from 1 for 5 ),
     substring(:AAdresse3 from 6 for 25 ),
     :ADerniereVisite   )
   matching(t_client_id);
 end;

 
 create or alter procedure ps_actipharm_maj_couv_amc(
  AID float,
  AIDAssure float,
  AIDAMCFichier float,
  AIDCouvAMCFichier float,
  ANumeroAdherentMutuelle varchar(16),
  ADebutDroitAMCFichier date,
  AFinDroitAMCFichier date
  )
as
declare variable strClient varchar(50);
declare variable c varchar(4);
declare variable cp varchar(5);
declare variable ville varchar(25);
begin
  strClient = cast(AID as varchar(50));

  update t_client 
  set t_client_id = :strClient,
      t_organisme_amc_id=:AIDAMCFichier,
      t_couverture_amc_id=:AIDCouvAMCFichier,
      numero_adherent_mutuelle=:ANumeroAdherentMutuelle,
      debut_droit_amc=:ADebutDroitAMCFichier,
      fin_droit_amc=:AFinDroitAMCFichier
  where t_client_id = :strClient
        --and (fin_droit_amc < :AFinDroitAMCFichier or fin_droit_amc is null)
        ;
end;
 
/* ********************************************************************************************** */
 create or alter procedure ps_actipharm_creer_couv_amo(
   AID float,
   ACodeCouverture char(5),
   ADebutDroitAMO date,
   AFinDroitAMO date)
 as
 declare variable strClient varchar(50);
 declare variable o varchar(50);
 declare variable c varchar(50);
 declare variable c_ref integer;
begin
   strClient = cast(AID as varchar(50));

   select t_organisme_amo_id
   from t_client
   where t_client_id = :strClient
   into :o;

   if (row_count <> 0) then
   begin
     c = o || '_' || ACodeCouverture;

     if (not exists(select *
                    from t_couverture_amo
                    where t_couverture_amo_id = :c)) then
     begin
       execute procedure ps_renvoyer_id_couv_amo_ref(:ACodeCouverture) returning_values :c_ref;

       insert into t_couverture_amo(t_couverture_amo_id,
                                    t_organisme_amo_id,
                                    libelle,
                                    ald,
                                    t_ref_couverture_amo_id)
       values(:c,
              :o,
              :ACodeCouverture,
              '0',
              :c_ref);
     end

     insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                         t_client_id,
                                         t_couverture_amo_id,
                                         debut_droit_amo,
                                         fin_droit_amo)
     values(next value for seq_couverture_amo_client,
            :strClient,
            :c,
            :ADebutDroitAMO,
            :AFinDroitAMO);
   end
 end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_fournisseur(
  AID float,
  ANumeroClient varchar(20),
  ARepartiteur integer,
  AURL1 varchar(64),
  AURL2 varchar(64),
  AIDOfficine varchar(16),
  ACle varchar(4),
  ALogin varchar(20),
  AMotDePasse varchar(20))
as
begin
  if (ARepartiteur = 1) then
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale,
                              pharmaml_url_1,
                              pharmaml_url_2,
                              pharmaml_id_officine,
                              pharmaml_cle)
    values(:AID,
           :AID,
           trim(:AURL1),
           trim(:AURL2),
           trim(:AIDOfficine),
           :ACle);
  else
  begin
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                     raison_sociale)
    values(:AID,
           :AID);

    insert into t_catalogue(t_catalogue_id,
                            designation,
                            t_fournisseur_id)
    values(:AID,
           :AID,
           :AID);
  end
end;

create or alter procedure ps_actipharm_creer_fabricant(
  AID float)
as
begin
  insert into t_codification(t_codification_id,
                             rang,
                             code,
                             libelle)
  values(next value for seq_codification,
         '6',
         :AID,
         :AID);
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_zg(
  AID float,
  ATypeMagasin char(1),
  AArmoire varchar(3),
  ARayon varchar(2),
  ANumero varchar(3),
  ALibelle varchar(20))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
                                  libelle)
  values(:AID,
         trim(:ALibelle) || ' (' || :AArmoire || '/' || :ARayon || '/' || :ANumero || ')');
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_article(
  AID float,
  ACodeCIP7 varchar(13),
  ACodeCIP13 varchar(13), 
  ALibelle varchar(80),
  ACodeEAN13 varchar(13),
  ADateCreation date,
  AIDFabricant float,
  APrestation varchar(3),
  AIDEmplacement float,
  ABaseRemboursement float,
  ADateModification date,
  ADisponible varchar(20),
  AMethodeReappro char(1),
  AStockMini float,
  AStockMaxi float,
  ATVA float,
  AListe char(1),
  AGereStock char(1))
as
declare variable intPrestation integer;
declare variable intTVA integer;
declare variable intCodif6 integer;

begin
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;
  execute procedure ps_renvoyer_id_tva(:ATVA) returning_values :intTVA;
  execute procedure ps_renvoyer_id_codification('6', :AIDFabricant) returning_values :intCodif6;

  
  insert into t_produit(t_produit_id,
                        code_cip,
                        designation,
                        t_codif_6_id,
                        t_ref_prestation_id,
                        t_ref_tva_id,
                        etat,
                        profil_gs,
                        calcul_gs,
                        liste,
                        stock_mini,
                        stock_maxi,
                        base_remboursement,
                        prix_vente,
                        prix_achat_catalogue)
  values(:AID,
         :ACodeCIP13,
         substring(trim(:ALibelle) from 1 for 50 ),
         :intCodif6,
         :intPrestation,
         :intTVA,
         case
           when :ADisponible in ('0', '1') then '1'
           when :ADisponible in ('4', '8', '16', '32') then '3'
           when :ADisponible = '64' then '2'
           when :ADisponible = '128' then '4'
           else '1'
         end,
         '0',
         case
           when :AMethodeReappro = '1' then '4'
           when :AMethodeReappro = '2' then '1'
           else '0'
         end,
         iif(:AListe = ' ', '0', iif(:AListe in ('1','2','S') ,:AListe , '0')),
         :AStockMini,
         :AStockMaxi,
         :ABaseRemboursement,
         0,
         0
     );

  if (AIDEmplacement <> 0) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                      t_produit_id,
                                      quantite,
                                      t_depot_id,
                                      t_zone_geographique_id)
    values(next value for seq_produit_geographique,
           :AID,
           0,
           1,
           :AIDEmplacement);

 if ((ACodeEAN13 is not null) and (trim(ACodeEAN13) <> '')  and (substring(ACodeEAN13 from 1 for 4) <> '3400') and (substring(ACodeEAN13 from 1 for 4) <> '3401') ) then       
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :AID,
           :ACodeEAN13);
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_maj_article(
  AIDArticle float,
  ASansTier char(1),
  ATypeTarif char(1),
  ACatalogue char(1),
  APrix float,
  APrixNet float,
  ARemise float,
  ANetTTC float,
  AIDTier float,
  ATVA float,
  ADateModification date)
as
declare variable p varchar(50);
declare variable n integer;
declare variable d date;
declare variable t varchar(50);
declare variable intTVA integer;
begin
  p = cast(AIDArticle as varchar(50));
  t = cast(AIDTier as varchar(50));

  if (ACatalogue = 'O') then
  begin
    --if (ATypeTarif = 'V') then update t_produit set prix_vente = :ANetTTC where t_produit_id = :p;
    if (ATypeTarif = 'A') then update t_produit set prix_achat_catalogue = :APrixNet where t_produit_id = :p;
  end
  else
  begin
    if ( ( ATypeTarif in  ('V','B')) and ( :ANetTTC > 0 ) ) then
    begin
      --execute procedure ps_renvoyer_id_tva(:ATVA) returning_values :intTVA;
      update t_produit
      set prix_vente = :ANetTTC,
          date_derniere_vente = :ADateModification
      where t_produit_id = :p ;
    --and ((date_derniere_vente is null) or (date_derniere_vente < :ADateModification));
    end
    else
      if ((ATypeTarif = 'A') and (ASansTier = '2') and
          (exists(select *
                  from t_catalogue
                  where t_catalogue_id = :t))) then
      begin
        select date_maj_tarif
        from t_catalogue_ligne
        where t_catalogue_id = :t
          and t_produit_id = :p
        into :d;

        if (row_count = 0) then
        begin
          select coalesce(max(no_ligne), 0) + 1
          from t_catalogue_ligne
          where t_catalogue_id = :t
          into :n;


          insert into t_catalogue_ligne(t_catalogue_ligne_id,
                                        t_catalogue_id,
                                        no_ligne,
                                        t_produit_id,
                                        prix_achat_catalogue,
                                        prix_achat_remise,
                                        remise_simple,
                                        date_maj_tarif)
          values(next value for seq_catalogue_ligne,
                 :t,
                 :n,
                 :p,
                 :APrix,
                 :APrixNet,
                 :ARemise,
                 :ADateModification);
        end
        else
          if (d < :ADateModification) then
            update t_catalogue_ligne
            set prix_achat_catalogue = :APrix,
                prix_achat_remise = :APrixNet,
                remise_simple = :ARemise
            where t_catalogue_id = :t
              and t_produit_id = :p;
      end
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_maj_stock(
  AIDArticle float,
  AReste float)
as
declare variable p varchar(50);
begin
  p = cast(AIDArticle as varchar(50));

  update t_produit_geographique
  set quantite = quantite + :AReste
  where t_produit_id = :p;
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_creer_histo_vente(
  AIDArticle float,
  ANbBoitesVendues float,
  ADate date)
as
declare variable p varchar(50);
declare variable strPeriode varchar(10);
declare variable a varchar(4);
declare variable m varchar(2);
begin
  p = cast(AIDArticle as varchar(50));
  strPeriode = cast(ADate as varchar(10));
  strPeriode = substring(strPeriode from 6 for 2) || substring(strPeriode from 1 for 4);

  if (not exists(select *
                 from t_historique_vente
                 where t_produit_id = :p
                   and periode = :strPeriode)) then
    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   quantite_actes,
                                   quantite_vendues,
                                   periode)
    values(next value for seq_historique_vente,
           :p,
           :ANbBoitesVendues,
           :ANbBoitesVendues,
           :strPeriode);
  else
    update t_historique_vente
    set quantite_actes = quantite_actes + :ANbBoitesVendues,
        quantite_vendues = quantite_vendues + :ANbBoitesVendues
    where t_produit_id = :p
      and periode = :strPeriode;
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharm_maj_tier(
  AID float,
  ATypeTier integer,
  ANom varchar(30),
  APrenom varchar(27),
  ARue1 varchar(30),
  ARue2 varchar(30),
  ARue3 varchar(30),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  ATelephone varchar(20),
  AFax varchar(20),
  APortable varchar(20))
as
declare variable strID varchar(50);
begin
  strID = cast(:AID as  varchar(50));
  if (ATypeTier in ('2')) then
    insert into t_compte(t_compte_id,
                         nom,
                         rue_1,
                         rue_2,
                         code_postal,
                         nom_ville,
                         tel_standard,
                         fax,
                         tel_mobile,
                         payeur)
    values('CPT'||:AID,
           substring(:ANom from 1 for 30 ),
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelephone,
           :AFax,
           :APortable,
           'A'         
           );
  else
  if (ATypeTier in ('3', '4')) then
    update t_client
    set rue_1 = trim(:ARue1),
        rue_2 = trim(:ARue2) || ' ' || trim(:ARue3),
        code_postal = :ACodePostal,
        nom_ville = trim(:ANomVille),
        tel_standard = trim(:ATelephone),
        tel_mobile = trim(:APortable),
        fax = trim(:AFax)
    where t_client_id = :strID;
  else
    if (ATypeTier = '7') then
      update t_praticien
      set nom = trim(:ANom),
          prenom = trim(:APrenom),
          rue_1 = trim(:ARue1),
          rue_2 = trim(:ARue2) || ' ' || trim(:ARue3),
          code_postal = :ACodePostal,
          nom_ville = trim(:ANomVille),
          tel_standard = trim(:ATelephone),
          tel_mobile = trim(:APortable),
          fax = trim(:AFax)
      where t_praticien_id = :strID;
    else
      if (ATypeTier in ('9', '10')) then
        update t_organisme
        set nom = trim(:ANom),
            rue_1 = trim(:ARue1),
            rue_2 = trim(:ARue2) || ' ' || trim(:ARue3),
            code_postal = :ACodePostal,
            nom_ville = trim(:ANomVille),
            tel_standard = trim(:ATelephone),
            tel_mobile = trim(:APortable),
            fax = trim(:AFax)
        where t_organisme_id = :strID;
      else
        if (ATypeTier = '5') then
        begin
          if (exists (select *
                      from t_fournisseur_direct
                      where t_fournisseur_direct_id = :strID)) then
            update t_fournisseur_direct
            set raison_sociale = trim(:ANom),
                rue_1 = trim(:ARue1),
                rue_2 = trim(:ARue2) || ' ' || trim(:ARue3),
                code_postal = :ACodePostal,
                nom_ville = trim(:ANomVille),
                tel_standard = trim(:ATelephone),
                tel_mobile = trim(:APortable),
                fax = trim(:AFax)
            where t_fournisseur_direct_id = :strID;
          else
            if (exists (select *
                from t_repartiteur
                where t_repartiteur_id = :strID)) then
              update t_repartiteur
              set raison_sociale = trim(:ANom),
                  rue_1 = trim(:ARue1),
                  rue_2 = trim(:ARue2) || ' ' || trim(:ARue3),
                  code_postal = :ACodePostal,
                  nom_ville = trim(:ANomVille),
                  tel_standard = trim(:ATelephone),
                  tel_mobile = trim(:APortable),
                  fax = trim(:AFax)
              where t_repartiteur_id = :strID;
        end
        else
          if (ATypeTier = '6') then
            update t_codification
            set libelle = trim(:ANom)
            where rang = '6'
              and code = :strID;
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharma_creer_histo_ent(
  AID float,
  APiece varchar(20),
  AIDClient float,
  AIDMedecin float,
  ADateExecution date,
  ADatePrescription date,
  AMontantTTC float)
as
declare variable nf integer;
begin
-- en regex on verifie en meme temps le contenu de la chaine et sa longueur 
  if (:APiece NOT SIMILAR TO   '_[[:DIGIT:]]{19}') then
    if (:APiece NOT SIMILAR TO '__[[:DIGIT:]]{19}') then
      nf = trim(substring(:APiece from 3 for 19));
    else
      nf = 0;
  else
    nf = 0;

  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  t_praticien_id,
                                  type_facturation,
                                  date_acte,
                                  date_prescription,
                                  numero_facture)
  values(:AID,
         :AIDClient,
         :AIDMedecin,
         '2',
         :ADateExecution,
         :ADatePrescription,
         :nf);
end;

/* ********************************************************************************************** */
create or alter procedure ps_actipharma_creer_histo_lig(
  AIDEntete float,
  AIDLigne float,
  ACodeCIPDelivree varchar(13),
  ALibelle varchar(50),
  AQuantitePrescrite float,
  APrixUnitaireTTC float)
as
begin
  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                        t_historique_client_id,
                                        code_cip,
                                        designation,
                                        prix_vente,
                                        quantite_facturee)
  values(next value for seq_historique_client_ligne,
         :AIDEntete,
         :ACodeCIPDelivree,
         :ALibelle,
         :APrixUnitaireTTC,
         :AQuantitePrescrite);
end;
