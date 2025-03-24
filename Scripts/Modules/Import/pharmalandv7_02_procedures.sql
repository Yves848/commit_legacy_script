set sql dialect 3;

create exception exp_pharmalandv7_produit_exist 'Le produit n''existe pas !';
create exception exp_pharmalandv7_qte_commandee 'La quantité commandée et la quantité reçue sont = 0 !';
/* ********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression smallint)  
as
begin
  if (ATypeSuppression = 101) then
    delete from t_pharmalandv7_tva;
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_medecin(
  ACleUnique integer,
  ANom  varchar(40),
  AAdresse1 varchar(40),
  AAdresse2 varchar(40),
  ACodePostal varchar(10),
  ANomVille varchar(40),
  ASpecialite varchar(10),
  ANoFiness varchar(20),
  ARpps varchar(20),
  ATelephone varchar(20),
  AFax varchar(20),
  AObservation varchar(5000),
  ACleHopital varchar(200),
  AHopital integer)
as
declare variable strNom varchar(50);
declare variable strPrenom varchar(50);
declare variable strNjf varchar(40);
declare variable intSpecialite integer;
begin
  if (AHopital = 1) then
    insert into t_hopital(t_hopital_id,
                          nom,
                          commentaire,
                          no_finess,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax)
    values(:ACleUnique,
           :ANom,
           substring(:AObservation from 1 for 200),
           substring(:ANoFiness from 1 for 9),
           :AAdresse1,
           :AAdresse2,
           substring(:ACodePostal from 1 for 5),
           substring(:ANomVille from 1 for 30),
           :ATelephone,
           :AFax);
  else
  begin
    execute procedure ps_separer_nom_prenom(:ANom, ' ') returning_values :strNom, strPrenom, :strNjf;
    execute procedure ps_renvoyer_id_specialite(substring(:ASpecialite from 1 for 2)) returning_values :intSpecialite;

    insert into t_praticien(t_praticien_id,
                            type_praticien,
                            nom,
                            prenom,
                            commentaire,
                            no_finess,
                            num_rpps,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_standard,
                            fax,
                            t_ref_specialite_id,
                            t_hopital_id)
    values(:ACleUnique,
           iif(:ACleHopital <> '' and :AHopital >0, '2', '1'), 
           substring(:strNom from 1 for 50),
           substring(:strPrenom from 1 for 50),
           substring(:AObservation from 1 for 200),
           :ANoFiness,
           :ARpps,
           :AAdresse1,
           :AAdresse2,
           substring(:ACodePostal from 1 for 5),
           substring(:ANomVille from 1 for 30),
           :ATelephone,
           :AFax,
           :intSpecialite,
           iif(:ACleHopital = '' or :AHopital =-1, null, cast(:AHopital as integer)));
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_taux_pc(
  ACouvertureAMC varchar(50),
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
         :ACouvertureAMC,
         :intPrestation,
         :ATaux);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_maj_taux_amc(
  ACouvertureAMC varchar(20),
  APrestation varchar(10),
  ATaux varchar(10))
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:APrestation) returning_values :intPrestation;

  update t_taux_prise_en_charge
  set taux =  :ATaux
  where t_couverture_amc_id like '%-' || substring(:ACouvertureAMC from 3 for 18)
    and t_ref_prestation_id = :intPrestation;
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_couv_amc(
  AOrganismeAMC varchar(20),
  ACouvertureAMC varchar(20),
  ACouvertureAMCDefaut varchar(20))
as
declare variable strOrganismeAMC varchar(50);
declare variable strCouvertureAMC varchar(50);
begin  
  strOrganismeAMC = 'AMC-' || AOrganismeAMC;
  strCouvertureAMC = strOrganismeAMC || '-' || iif(:ACouvertureAMC = '',iif(:ACouvertureAMCDefaut = '',:ACouvertureAMCDefaut ,'100' ), :ACouvertureAMC);

  if (not exists(select *
                 from t_couverture_amc
				 where t_couverture_amc_id = :strCouvertureAMC)) then
  begin
	  insert into t_couverture_amc(t_couverture_amc_id,
								   t_organisme_amc_id,
								   libelle,
								   montant_franchise,
								   plafond_prise_en_charge,
								   formule)
	  values(:strCouvertureAMC,
			 :strOrganismeAMC,
			 :strCouvertureAMC,
			 0,
			 0,
			 '02A');
		-- creation d'un couv avec taux par defaut = 100 partout , sera mis a jour plus tard	 
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'PH4', 100);
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'PH7', 100);
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'PH1', 100);
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'PH2', 100);
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'AAD', 100);
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'PMR', 100);
    execute procedure ps_pharmalandv7_creer_taux_pc(:strCouvertureAMC, 'PHN', 0);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_maj_couv_amc(
  ACouvertureAMC varchar(20),
  ALibelle varchar(50),
  ATaux varchar(50))
as
declare variable c varchar(50);
begin
  for select t_couverture_amc_id
      from t_couverture_amc
      where t_couverture_amc_id like '%-' || :ACouvertureAMC 
      into :c do
  begin
    update t_couverture_amc
    set libelle = :ALibelle
    where t_couverture_amc_id = :c;
	
  -- mise a jour de tous les taucx sauf PH1 avec le taux par
	execute procedure ps_pharmalandv7_maj_taux_amc(:ACouvertureAMC, 'PH4', ATaux );  
	execute procedure ps_pharmalandv7_maj_taux_amc(:ACouvertureAMC, 'PH7', ATaux );   
  execute procedure ps_pharmalandv7_maj_taux_amc(:ACouvertureAMC, 'PH2', ATaux );  
  execute procedure ps_pharmalandv7_maj_taux_amc(:ACouvertureAMC, 'AAD', ATaux );   
  execute procedure ps_pharmalandv7_maj_taux_amc(:ACouvertureAMC, 'PMR', ATaux ); 

  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_organisme(
  ACodeUnique varchar(20),
  ARegime varchar(10),
  ACaisseGestionnaire varchar(10),
  ACentreGestionnaire varchar(10),
  ACodePrefectoral char(20),
  AType numeric(2),
  ANom varchar(40),
  AAdresse1 varchar(40),
  AAdresse2 varchar(40),
  ACodePostal varchar(10),
  ANomVille varchar(40),
  ATelephone varchar(20),
  AFax varchar(20),
  AObservation varchar(1000),
  ACouvertureAMC varchar(20))
as
declare variable intRegime integer;
declare variable strOrganismeAMC varchar(24);
begin
  -- AMO
  if (AType in (1, 3)) then
    execute procedure ps_renvoyer_id_regime(substring(:ARegime from 1 for 2)) returning_values :intRegime;

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
                            commentaire)
    values('AMO-' || :ACodeUnique,
           '1',
           iif(:ANom = '', :ACodeUnique, :ANom),
           :ACodeUnique,
           :intRegime,
           substring(:ACaisseGestionnaire from 1 for 3),
           substring(:ACentreGestionnaire from 1 for 4),
           :AAdresse1,
           :AAdresse2,
           substring(:ACodePostal from 1 for 5),
           substring(:ANomVille from 1 for 30),
           :ATelephone,
           :AFax,
           substring(:AObservation from 1 for 200));

  -- AMC
  if (AType in (2, 3)) then
  begin
    strOrganismeAMC = 'AMC-' || :ACodeUnique;
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
                            commentaire)
    values(:strOrganismeAMC,
           '2',
           iif(:ANom = '', :ACodePrefectoral, :ANom),
           :ACodeUnique,
           substring(trim(:ACodePrefectoral) from 1 for 9),
           :AAdresse1,
           :AAdresse2,
           substring(:ACodePostal from 1 for 5),
           substring(:ANomVille from 1 for 30),
           :ATelephone,
           :AFax,
           substring(:AObservation from 1 for 200));
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_couv_amo(
  ACaissePrimaire varchar(20),
  AALD varchar(3),
  ACodeCouverture varchar(6))
as
declare variable chALD char(1);
declare variable strOrganismeAMO varchar(24);
declare variable strCouvertureAMO char(5);
declare variable intCouvertureAMORef integer;
begin
  strOrganismeAMO = 'AMO-' || ACaissePrimaire;
  chALD = iif(substring(AALD from 1 for 1) = '1', '1', '0');
  strCouvertureAMO = chALD || substring(ACodeCouverture from 1 for 4);
  if (not (exists (select *
                   from t_couverture_amo
                   where t_couverture_amo_id = :strOrganismeAMO || '-' || :strCouvertureAMO))) then
  begin
    execute procedure ps_renvoyer_id_couv_amo_ref(:strCouvertureAMO) returning_values :intCouvertureAMORef;

    insert into t_couverture_amo(t_couverture_amo_id,
                                 t_organisme_amo_id,
                                 libelle,
                                 ald,
                                 t_ref_couverture_amo_id)
    values(:strOrganismeAMO || '-' || :strCouvertureAMO,
           :strOrganismeAMO,
           :strCouvertureAMO,
           :chALD,
           :intCouvertureAMORef);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_couv_cli(
  ACleUnique varchar(20),
  AOrganismeAMO varchar(24),
  AALD varchar(3),
  ACodeSituation varchar(6),
  ADebutPC date,
  AFinPC date)
as
declare variable strCouvertureAMO varchar(50);
--declare variable dtDebutDroit date;
--declare variable dtFinDroit date;
begin
  if (ACodeSituation <> '') then
  begin
    strCouvertureAMO = AOrganismeAMO || '-' || iif(substring(AALD from 1 for 1) = '1', '1', '0') || substring(ACodeSituation from 1 for 4);
--    execute procedure ps_conv_chaine_en_date_format(:ADebutPC,'YYYYMMDD') returning_values :dtDebutDroit;
--    execute procedure ps_conv_chaine_en_date_format(:AFinPC,'YYYYMMDD') returning_values :dtFinDroit ;

    update or insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                                  t_client_id,
                                                  t_couverture_amo_id,
                                                  debut_droit_amo,
                                                  fin_droit_amo)
    values(next value for seq_couverture_amo_client,
           :ACleUnique,
           :strCouvertureAMO,
           :ADebutPC,
           :AFinPC)
    matching (t_client_id, t_couverture_amo_id);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_couv_cli2(
  ACleUnique varchar(20),
  AOrganismeAMO varchar(24),
  AALD varchar(3),
  ACodeSituation varchar(6),
  AFinDroit date)
as
declare variable strCouvertureAMO varchar(50);
--declare variable dtFinDroit date;
begin
  if (ACodeSituation <> '') then
  begin
    strCouvertureAMO = AOrganismeAMO || '-' || iif(substring(AALD from 1 for 1) = '1', '1', '0') || substring(ACodeSituation from 1 for 4);

    update or insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                                  t_client_id,
                                                  t_couverture_amo_id,
                                                  fin_droit_amo)
    values(next value for seq_couverture_amo_client,
           :ACleUnique,
           :strCouvertureAMO,
           :AFinDroit)
    matching (t_client_id, t_couverture_amo_id);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_client(
  ACleUnique varchar(20),
  ATypeClient smallint,
  ANumeroInsee varchar(15),
  ACleNumeroInsee varchar(4),
  ANom varchar(30),
  APrenom varchar(30),
  ADateNaissance varchar(8),
  ARangGemellaire varchar(3),
  AQualite varchar(4),
  AAdresse1 varchar(40),
  AAdresse2 varchar(40),
  ACodePostal varchar(10),
  ANomVille varchar(40),
  ATelephone varchar(20),
  AFax varchar(20),
  APortable varchar(20),
  ACaissePrimaire varchar(20),
  AALD1 varchar(3),
  ACodeSituation1 varchar(6),
  ADebutPC1 date,
  AFinPC1 date,
  AALD2 varchar(3),
  ACodeSituation2 varchar(6),
  ADebutPC2 date,
  AFinPC2 date,
  AALD3 varchar(3),
  ACodeSituation3 varchar(6),
  ADebutPC3 date,
  AFinPC3 date,
  AALD4 varchar(3),
  ACodeSituation4 varchar(6),
  ADebutPC4 date,
  AFinPC4 date,
  AALD5 varchar(3),
  ACodeSituation5 varchar(6),
  ADebutPC5 date,
  AFinPC5 date,
  AMutuelle varchar(20),
  ARisqueMutuelle varchar(20),
  ARisqueMutuelleDefaut varchar(20),
  AContratSantePharma varchar(20),
  ANumeroMutuelle varchar(20),
  AValiditeMutuelle date,
  ACommentaire varchar(1000),
  ADernierPassage date,
  AALDMan varchar(3),
  ACodeSituationMan varchar(6),
  AFinPCMan date,
  AEmail varchar(50))
as
declare variable strCentreGestionnaire varchar(4);
declare variable strOrganismeAMO varchar(50);
declare variable strOrganismeAMC varchar(50);
declare variable strCouvertureAMC varchar(50);
begin
  strOrganismeAMO =  iif(ACaissePrimaire <> '', 'AMO-' || ACaissePrimaire, null);
  if (strOrganismeAMO is not null) then
  begin
    select o.centre_gestionnaire
    from t_organisme o
         inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
    where o.t_organisme_id = :strOrganismeAMO
      and r.sans_centre_gestionnaire = '1'
    into :strCentreGestionnaire;

    if (row_count = 0) then
      strCentreGestionnaire = null;
  end
  else
    strCentreGestionnaire = null;

  strOrganismeAMC = 'AMC-' || AMutuelle;

  strCouvertureAMC = strOrganismeAMC || '-' || iif( ARisqueMutuelle='',ARisqueMutuelleDefaut ,ARisqueMutuelle);   

  /*if ((AMutuelle <> '') and (ARisqueMutuelle <> '') and
      (not (exists (select *
                    from t_couverture_amc
                    where t_couverture_amc_id = :strCouvertureAMC)))) then
    execute procedure ps_pharmalandv7_creer_couv_amc(:strOrganismeAMC, :ARisqueMutuelle);*/

  insert into t_client(t_client_id,
                       numero_insee,
                       nom,
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
                       contrat_sante_pharma,
                       commentaire_individuel,
                       date_derniere_visite, 
                       email)
  values(:ACleUnique,
         substring(:ANumeroInsee from 1 for 13) || substring(:ACleNumeroInsee from 1 for 2),
         :ANom,
         :APrenom,
         :AAdresse1,
         :AAdresse2,
         substring(:ACodePostal from 1 for 5),
         substring(:ANomVille from 1 for 30),
         :ATelephone,
         :APortable,
         :AFax,
         substring(:ADateNaissance from 7 for 2) || substring(:ADateNaissance from 5 for 2)  || substring(:ADateNaissance from 1 for 4),
         iif(trim(:ARangGemellaire) = '' , 1, cast(:ARangGemellaire as smallint)),
         iif(trim(:AQualite) = '' , 1, cast(:AQualite as integer)),
         :strOrganismeAMO,
         :strCentreGestionnaire,
         :strOrganismeAMC,
         :strCouvertureAMC,
         :AValiditeMutuelle,
         substring(:AContratSantePharma from 1 for 18),
         substring(:ANumeroMutuelle from 1 for 16),
         substring(:ACommentaire from 1 for 200),
         :ADernierPassage,
         :Aemail);

  -- commentaire 
  if (trim(:ACommentaire ) > '') then
        insert into t_commentaire (t_commentaire_id,
                                   t_entite_id,
                                   type_entite,
                                   commentaire )
        values ( next value for seq_commentaire,
                 :ACleUnique,
                 '0', -- client 
                cast(:ACommentaire as blob)   );

  -- Couvertures AMO
  if (strOrganismeAMO is not null) then
  begin
    execute procedure ps_pharmalandv7_creer_couv_cli2(:ACleUnique, :strOrganismeAMO, :AALDMAn, :ACodeSituationMan, AFinPCMAn);

    execute procedure ps_pharmalandv7_creer_couv_cli(:ACleUnique, :strOrganismeAMO, :AALD1, :ACodeSituation1, :ADebutPC1, AFinPC1);
    execute procedure ps_pharmalandv7_creer_couv_cli(:ACleUnique, :strOrganismeAMO, :AALD2, :ACodeSituation2, :ADebutPC2, AFinPC2);
    execute procedure ps_pharmalandv7_creer_couv_cli(:ACleUnique, :strOrganismeAMO, :AALD3, :ACodeSituation3, :ADebutPC3, AFinPC3);
    execute procedure ps_pharmalandv7_creer_couv_cli(:ACleUnique, :strOrganismeAMO, :AALD4, :ACodeSituation4, :ADebutPC4, AFinPC4);
    execute procedure ps_pharmalandv7_creer_couv_cli(:ACleUnique, :strOrganismeAMO, :AALD5, :ACodeSituation5, :ADebutPC5, AFinPC5);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_four(
  ACode varchar(20),
  ALibelle varchar(127),
  AType char)
as
begin
  if ( Atype = 1) then
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale)
    values(:ACode,
           substring(:ALibelle from 1 for 50));
  else
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                     raison_sociale)
    values(:ACode,
           substring(:ALibelle from 1 for 50));
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_zone_geo(
  ALibelle varchar(127))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
                                  libelle)
  values(:ALibelle,
         :ALibelle);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_produit(
  ACleUnique integer,
  ACode varchar(20),
  ALibelle varchar(50),
  AEAN varchar(20),
  ATableau varchar(1),
  AEtat numeric(2),
  ATVA numeric(2),
  ACodeActe varchar(5),
  ACodeVignette integer, -- 1 PHN, 2 PH4, 3 PH7, 4 UPH, 5 PH1, 6 PMH, 8 PH2, 7 PA MAD DVO PAN AAD AAR ....
  APrixAchat float,
  APrixPublic float,
  APrixPHN float,
  APAMP float,
  ABaseRemboursement float,
  ALieuStockage varchar(20),
  AQuantite numeric(4),
  AQuantiteReserve numeric(4),
  AQuantiteMinimum numeric(4),
  AQuantiteMaximum numeric(4),
  ACodeFabricant varchar(20),
  ADateDerniereVente date,
  ACommentaire varchar(1000),
  AInfoCommande varchar(1000),
  Automate varchar(10))
as
declare variable intPrestation integer;
declare variable flTauxTVA float;
declare variable intTVA integer;
declare variable intMarque integer;
-- declare variable cip7 varchar(7);
declare variable cip13 varchar(13);
declare variable ean13 varchar(13);
declare variable ean13_2 varchar(13);
begin
  flTauxTVA = case
                when ATVA = 2 then 20
                when ATVA = 3 then 10
                when ATVA = 4 then 5.5
                when ATVA = 6 then 2.1
        else 0
          end;
  
  -- cip 13 doit etre valide         
  if ((:ACode similar to '340[[:DIGIT:]]{10}' ) or (:ACode similar to '[[:DIGIT:]]{7}'))  then 
    cip13 = :ACode;
  else
    if (:ACode similar to '[[:DIGIT:]]{13}') then 
      ean13_2 = :ACode;


  -- si le premier code n est pas un cip 13 mais le 2eme 
  if (
    ( (:AEAN similar to '340[[:DIGIT:]]{10}' or (:AEAN similar to '[[:DIGIT:]]{7}' )) 
      and 
      (:ACode not similar to '340[[:DIGIT:]]{10}')))  then 
    cip13 = :AEAN; 
  else  -- autres cas ean / gtin / cip7 ...
    if (
        ((:AEAN not similar to '340[[:DIGIT:]]{10}') and (:AEAN similar to '[[:DIGIT:]]{13}' ))) then   
      ean13 = :AEAN;

  -- si présence d'un code ean valide non interne, alors cip13 inutile
   if (cip13 similar to '[[:DIGIT:]]{7}' and (ean13 is not null or ean13_2 is not null)) then 
      if (ean13 not like '20000%' or ean13_2 not like '20000%') then
        cip13 = null; 

  execute procedure ps_renvoyer_id_tva(:flTauxTVA) returning_values :intTVA;  
  execute procedure ps_renvoyer_id_marque(:ACodeFabricant) returning_values :intMarque;
  if (:ACodeActe > '') then 
    execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;
  else
    execute procedure ps_renvoyer_id_prestation('PHN') returning_values :intPrestation;

  insert into t_produit(t_produit_id,
                        code_cip,
                        designation,
                        liste,
                        t_ref_tva_id,
                        t_ref_prestation_id,
                        prix_achat_catalogue,
                        prix_vente,
                        base_remboursement,
                        pamp,
                        stock_mini,
                        stock_maxi,
                        t_codif_6_id,
                        date_derniere_vente,
                        commentaire_gestion,
                        commentaire_commande,
                        mode_stockage,
                        code_cip7)
  values(:ACleUnique,
         :cip13,
         :ALibelle,
         case
           when :ATableau = '1' then '1'
           when :ATableau = '2' then '2'
           when :ATableau = 'S' then '3'
           else '0'
         end,
         :intTVA,
         :intPrestation,
         :APrixAchat,
     -- Modif faites suite à install ou il fallait prendre le prixpromo plutot que le prix de vente pour les phn est ce valable pour toutes les install ?
         iif(:ACodeVignette=1 and :APrixPHN <> 0, :APrixPHN,:APrixPublic),
         :ABaseRemboursement,
         :APAMP,
         :AQuantiteMinimum,
         :AQuantiteMaximum,
         :intMarque,
         :ADateDerniereVente,
         substring(:ACommentaire from 1 for 200),
         :AInfoCommande,
         :Automate,
         iif(char_length(:ACode) = 7,: ACode ,null)
     );

  if (:ean13 is not null) then
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id, 
                             code_ean13)
    values(next value for seq_code_ean13,
           :ACleUnique,
           :ean13);
           
 if ((:ean13_2 is not null) and ((:ean13 <> :ean13_2) or (:ean13 is null )) ) then
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id, 
                             code_ean13)
    values(next value for seq_code_ean13,
           :ACleUnique,
           :ean13_2);           
           

  if ((AQuantite is not null) and (AQuantite > 0)) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                       t_produit_id,
                                       quantite,
                                       t_depot_id,
                                       t_zone_geographique_id)
    values(next value for seq_produit_geographique,
           :ACleUnique,
           :AQuantite,
           iif(:Automate <> '', (select t_depot_id from t_depot where libelle = 'AUTOMATE'), (select t_depot_id from t_depot where libelle = 'PHARMACIE')),
           iif(:ALieuStockage <> '', null, :ALieuStockage));

  if (AQuantiteReserve > 0) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                       t_produit_id,
                                       quantite,
                                       t_depot_id)
    values(next value for seq_produit_geographique,
           :ACleUnique,
           :AQuantiteReserve,
           (select t_depot_id from t_depot where libelle = 'RESERVE'));
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_histo_vte(
  AProduitID varchar(50),
  APeriode varchar(20),
  AQuantite integer)
as
declare variable strProduit dm_code;
begin

         select t_produit_id
         from t_produit
         where t_produit_id = :AProduitID
         into :strProduit;

          if (row_count = 0) then
              exception exp_pharmalandv7_produit_exist;
          else
              insert into t_historique_vente(t_historique_vente_id,
                                             t_produit_id,
                                             periode,
                                             quantite_actes,
                                             quantite_vendues)
              values(next value for seq_historique_vente,
                     :strProduit,
                     substring(:APeriode from 5 for 2) || substring(:APeriode from 1 for 4),
                     :AQuantite,
                     :AQuantite);

end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_histo_cli(
  AEntete integer,
  ANumeroFacture varchar(15),
  ADateFacture date,
  ADatePrescription date,
  AClient varchar(20),
  ANumeroLigne integer,
  ACodeCIP varchar(20),
  APrestation varchar(5),
  ADesignation varchar(50),
  APrixVente float,
  AQuantite float,
  APraticienID varchar(10))
as
begin
  if (not (exists(select *
             from t_historique_client
             where t_historique_client_id = cast(:AEntete as varchar(50))))) then
    insert into t_historique_client(t_historique_client_id,
                                    t_client_id,
                                    numero_facture,
                                    date_prescription,
                                    type_facturation,
                                    date_acte,
                                    t_praticien_id)
    values(:AEntete,
           :AClient,
           :ANumeroFacture,
           :ADatePrescription,
           '2',
           :ADateFacture,
           :APraticienID);

  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                        t_historique_client_id,
                                        code_cip,
                                        designation,
                                        quantite_facturee,
                                        prix_vente)
  values(next value for seq_historique_client_ligne,
         :AEntete,
         :ACodeCIP,
         :ADesignation,
         :AQuantite,
         :APrixVente);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_credit(
  ANumeroFacture varchar(15),
  AIDClient varchar(20), 
  ADateCredit date,
  AMontantCredit float)
as
begin

		if (exists(select * from t_credit where t_client_id = :AIDClient)) then
			update t_credit
			set montant = montant + :AMontantCredit
			where t_client_id = :AIDClient;
		else
			insert into t_credit(t_credit_id,
                         t_client_id,
                         date_credit,
                         montant)
			values(next value for seq_credit,
				   :AIDClient,
				   :ADateCredit,
				   :AMontantCredit);
end;


/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_attente(
  ANumeroFacture varchar(15),  
  AIDClient varchar(20), 
  ADateAttente date)
as
begin
  insert into t_facture_attente(t_facture_attente_id,
                                date_acte,
                                t_client_id)
  values(:ANumeroFacture,
         :ADateAttente,
         :AIDClient);
 end; 

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_att_lig(
  ANumeroFacture varchar(15),
  ACodeCip varchar(20),
  ACodeActe varchar(3),
  AQuantite integer,
  APrixVente float,
  APrixAchat float )
as  
declare variable strProduit dm_code;  
declare variable intPrestation integer;
begin

  if (exists( select * from t_facture_attente where t_facture_attente_id = :ANumeroFacture )) then
  begin	
	  execute procedure ps_renvoyer_id_prestation(:ACodeActe) returning_values :intPrestation;
  
	  select t_produit_id
	  from t_produit
	  where code_cip = :ACodeCip or code_cip7 = :ACodeCip 
	  into :strProduit;

	  if (row_count = 0) then
		  exception exp_pharmalandv7_produit_exist;
	  else
		  insert into t_facture_attente_ligne(t_facture_attente_ligne_id,
											  t_facture_attente_id,
											  t_produit_id,
											  quantite_facturee,
											  t_ref_prestation_id,
											  prix_vente,
											  prix_achat)
		  values(next value for seq_facture_attente_ligne,
				 :ANumeroFacture,
				 :strProduit ,
				 :AQuantite,
				 :intPrestation,
				 :APrixVente,
				 :APrixAchat);
			 
	end
end;
	
  /* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_commande (
  t_commande_id varchar(50),
  Numero_commande varchar(50),
  date_creation varchar(12),
  date_prevision varchar(12),
  date_transmission varchar(12),
  t_fournisseur_id varchar(50),
  type_fournisseur integer,
  flag_commande integer)
as
declare variable t_repartiteur_id varchar(50);
declare variable t_fournisseur_direct_id varchar(50);
declare variable type_commande char(1);
declare variable etat varchar(2);
declare variable date_reception date;
begin
  /* repartiteur */
  if ( type_fournisseur = 1 ) then
  begin
    t_repartiteur_id = t_fournisseur_id ;
    t_fournisseur_direct_id = null ;
    type_commande = '2' ;
  end
  else    /*  fournisseur */
  begin
    t_fournisseur_direct_id = t_fournisseur_id ;
    t_repartiteur_id = null ;
    type_commande = '1' ;

  end

  if (flag_commande  = 2) then -- 2 transmise
    etat = '2'; 
  else if (flag_commande  = 3) then -- 3 reception partielle 
          etat = '21';
       else -- autres receptions complete ou financiere
          etat = '3';

  if (date_prevision is null) then date_reception = date_creation; else date_reception = date_prevision;
  insert into t_commande(t_commande_id,
                         type_commande,
                         date_creation,
                         date_reception,
                         mode_transmission,
                         t_repartiteur_id,
                         t_fournisseur_direct_id,
                         montant_ht,
                         etat)
  values(:t_commande_id,
         :type_commande,
         :date_creation,
         :date_reception,
         '5',
         :t_repartiteur_id,
         :t_fournisseur_direct_id,
         0,
         :etat);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmalandv7_creer_comm_lig (
  ACommandeLigneID varchar(50),
  ACommandeID varchar(50),
  AProduitID varchar(50),
  AQuantiteCommandee integer,
  AQuantiteRecue integer,
  AQuantiteAnnulee integer,
  APrixAchat float,
  ARemise float,
  APrixAchatRemise float,
  APrixVente float
)
as
declare variable strProduit varchar(50);
declare variable intUnitesGratuites integer;
declare variable choix_reliquat integer;
begin


    if (AQuantiteCommandee = 0 and AQuantiteRecue = 0) then 
      exception exp_pharmalandv7_qte_commandee; 
    -- calcul de la qte attendue 
    if (AQuantiteCommandee - AQuantiteRecue - AQuantiteAnnulee = 0 )  then
      choix_reliquat = 1; -- on attends plus rien 
    else 
      choix_reliquat = 0;  

    if (AQuantiteRecue > AQuantiteCommandee) then
      intUnitesGratuites = AQuantiteRecue - AQuantiteCommandee;
    else
      intUnitesGratuites = 0;
	  
    insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente,
                               quantite_totale_recue,
                               unites_gratuites, 
                               choix_reliquat)
    values(next value for seq_commande_ligne,
         :ACommandeID,
         :AProduitID,
         :AQuantiteCommandee,
         :AQuantiteRecue,
         :APrixAchat,
         :APrixAchatRemise,
         :APrixVente,
         :AQuantiteRecue,
         :intUnitesGratuites,
         :choix_reliquat);

end;

/* ********************************************************************************************** */

create or alter procedure ps_pharmalandv7_creer_operateur (
    id integer,
    nom varchar(255))
as
declare variable strNom varchar(20);
declare variable strPrenom varchar(20);
declare variable strNJF varchar(50);
begin
    execute procedure ps_separer_nom_prenom(:nom, ' ') returning_values :strNom, :strPrenom, :strNJF;
    insert into t_operateur(t_operateur_id,
                        nom,
                        prenom,
                        mot_de_passe,
                        activation_operateur)
    values(:id,
       :strNom,
       :strPrenom,
       '',
       '1');
end;


create or alter procedure ps_pharmalandv7_creer_document(
  ALibelle varchar(50),
  AFichier varchar(255))
as
declare variable numero_facture dm_code;
declare variable id_facture dm_code;
declare variable t_client_id dm_code;
declare variable pos_separateur1 integer;
declare variable pos_separateur2 integer;
begin

  -- plusieurs formats : PDF JPG
  -- les scans mutuelles semblent suivre le pattern
  -- CL_0001157800_NOM_PRENOM_1.JPG
  -- id sur 10 digits lpadés à 0

  -- les scans ordos
  -- K_326808_NOM PRENOM_1.JPG
  -- avec id facture 6 digits
  -- ou O_230062746_BONNAFFOUX BRUNONOM PRENOM_11

    pos_separateur1 = position('_',upper(ALibelle) );
    pos_separateur2 = position('_', substring(upper(ALibelle) from pos_separateur1+1));
        
    
  if (upper(ALibelle) similar to 'O%[PDF]+[JPG]') then
  begin
    numero_facture = substring(upper(ALibelle) from pos_separateur1+1 for pos_separateur2-1);   
    insert into t_document(t_document_id,
                           type_entite,
                           t_entite_id,
                           libelle,
                           document, 
                           commentaire)
    values(next value for seq_document,
           2, --doc client
           ( select t_client_id from t_historique_client where numero_facture = :numero_facture ),
           :ALibelle,
           :AFichier||:ALibelle,
           'Scan Ordonnance no '||:numero_facture);      
  end
  else 
    if (upper(ALibelle) similar to 'K%[PDF]+[JPG]') then
  begin
    id_facture = substring(upper(ALibelle) from pos_separateur1+1 for pos_separateur2-1);   
    insert into t_document(t_document_id,
                           type_entite,
                           t_entite_id,
                           libelle,
                           document, 
                           commentaire)
    values(next value for seq_document,
           2, --doc client
           ( select t_client_id from t_historique_client where t_historique_client_id = :id_facture ),
           :ALibelle,
           :AFichier||:ALibelle,
           'Scan Ordonnance id '||:id_facture);      
  end 
  else
  if (upper(ALibelle) similar to 'CL%[PDF]+[JPG]') then  
  begin 
    t_client_id = substring(upper(ALibelle) from pos_separateur1+1 for pos_separateur2-1);
    insert into t_document(t_document_id,
                           type_entite,
                           t_entite_id,
                           libelle,
                           document, 
                           commentaire)
    values(next value for seq_document,
           2, --doc client
           :t_client_id,
           :ALibelle, 
           :AFichier||:ALibelle,
           'Attestation mutuelle');
  end
end;    

create or alter procedure ps_pharmalandv7_creer_CF_cli (
    t_client_id varchar(20),
    numero_carte varchar(20))
as
begin
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte)
  values(
    next value for seq_programme_relationnel,
    :t_client_id,
    :numero_carte);
end;
