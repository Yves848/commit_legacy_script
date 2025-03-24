set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_supprimer_donnees_modules(
  ATypeSuppression smallint)
as
begin
  if (ATypeSuppression = 101) then
    delete from t_historique_client;
end;

/* ********************************************************************************************** */
create or alter procedure ps_infosoft_creer_medecin(
  AID varchar(4),
  ANumeroFiness integer,
  ANom varchar(27),
  APrenom varchar(27),
  ASpecialite varchar(2),
  ARue varchar(27),
  ACodePostal varchar(5),
  ANomVille varchar(21),
  ATelephone varchar(15),
  AFax varchar(15))
as
declare variable intSpecialite integer;
begin
  execute procedure ps_renvoyer_id_specialite(:ASpecialite) returning_values :intSpecialite;

  insert into t_praticien(t_praticien_id,
                          nom,
                          prenom,
                          t_ref_specialite_id,
                          no_finess,
                          rue_1,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax)
  values(:AID,
         trim(:ANom),
         trim(:APrenom),
         :intSpecialite,
         lpad(:ANumeroFiness, 9, '0'),
         trim(:ARue),
         :ACodePostal,
         trim(:ANomVille),
         trim(:ATelephone),
         trim(:AFax));
end;

/* ********************************************************************************************** */
create or alter procedure ps_infosoft_creer_organisme(
  AID varchar(4),
  ANom varchar(28),
  ARue1 varchar(32),
  ARue2 varchar(32),
  ACodePostal varchar(5),
  ANomVille varchar(26),
  ATelephone varchar(16),
  AFax varchar(16),
  AIdentifiantNationalAMO varchar(9),
  AIdentifiantNationalAMC varchar(10),
  ATypeContrat varchar(2))
as
declare strIdAMO varchar(9);
declare strIdAMC varchar(10);
declare variable intRegime integer;
begin
  strIdAMO = trim(AIdentifiantNationalAMO);
  strIdAMC = trim(AIdentifiantNationalAMC);
  if (strIdAMO <> '') then
  begin
    execute procedure ps_renvoyer_id_regime(substring(:strIdAMO from 1 for 2)) returning_values :intRegime;

    insert into t_organisme(t_organisme_id,
                            type_organisme,
                            nom,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_standard,
                            fax,
                            t_ref_regime_id,
                            caisse_gestionnaire,
                            centre_gestionnaire)
    values(:AID,
           '1',
           trim(:ANom),
           trim(:ARue1),
           trim(:ARue2),
           trim(:ACodePostal),
           trim(:ANomVille),
           trim(:ATelephone),
           trim(:AFax),
           :intRegime,
           substring(:strIdAMO from 3 for 3),
           substring(:strIdAMO from 6 for 4));
  end
  
  if (strIdAMC <> '') then
  begin
    insert into t_organisme(t_organisme_id,
                            type_organisme,
                            nom,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_standard,
                            fax,
                            identifiant_national,
                            type_contrat)
    values(:AID||'-AMC',
           '2',
           trim(:ANom),
           trim(:ARue1),
           trim(:ARue2),
           trim(:ACodePostal),
           trim(:ANomVille),
           trim(:ATelephone),
           trim(:AFax),
           substring(trim(:AIdentifiantNationalAMC) from 1 for 8),
           iif(trim(:ATypeContrat) <> '', :ATypeContrat, 0));
  end
end;

create or alter procedure ps_infosoft_creer_couv_amo(
  AIDCouvertureAMO varchar(4),
  ALibelle varchar(40))
as
begin
  insert into t_couverture_amo(t_couverture_amo_id, libelle)
  values(:AIDCouvertureAMO, :ALibelle);
end;

create or alter procedure ps_infosoft_creer_couv_amc(
  AIDCouvertureAMC varchar(4),
  ALibelle varchar(40))
as
begin
  insert into t_couverture_amc(t_couverture_amc_id, libelle, montant_franchise, plafond_prise_en_charge, formule)
  values(:AIDCouvertureAMC, :ALibelle, 0, 0, '021');
end;

create or alter procedure ps_infosoft_creer_taux_pc(
  AIDCouvertureAMO varchar(4),
  AIDCouvertureAMC varchar(4),
  APrestation varchar(5),
  ATaux integer)
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(substring(:APrestation from 1 for 3)) returning_values :intPrestation;
  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amo_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux)
  values(next value for seq_taux_prise_en_charge,
         :AIDCouvertureAMO,
         :AIDCouvertureAMC,
         :intPrestation,
         :ATaux);
end;

/* ********************************************************************************************** */
create or alter procedure ps_infosoft_creer_couv_amo_cli(
  AIDClient integer,
  AIDOrganismeAMO varchar(4),
  AIDCouvertureAMO varchar(4),
  ACodeSituationAMO integer,
  AALD integer,
  ADebutDroitsAMO date,
  AFinDroitsAMO date)
as
declare variable strCouvertureAMO varchar(50);
declare variable chALD char(1);
declare variable intCouvertureAMORef integer;
begin

  if ((trim(AIDOrganismeAMO) <> '') and (ACodeSituationAMO <> 0)) then
  begin
    chALD = iif(:AALD = 1, '1', '0');
    strCouvertureAMO = AIDOrganismeAMO || '_' || chALD || '_' || ACodeSituationAMO;
    if (not exists(select *
                   from t_couverture_amo
                   where t_couverture_amo_id = :strCouvertureAMO)) then
    begin
      execute procedure ps_renvoyer_id_couv_amo_ref(:chALD || lpad(:ACodeSituationAMO, 4, '0')) returning_values :intCouvertureAMORef;

      insert into t_couverture_amo(t_couverture_amo_id,
                                   t_organisme_amo_id,
                                   libelle,
                                   ald,
                                   t_ref_couverture_amo_id)
      values(:strCouvertureAMO,
             :AIDOrganismeAMO,
             :ACodeSituationAMO,
             :chALD,
             :intCouvertureAMORef);

      if (intCouvertureAMORef is null) then
        insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                           t_couverture_amo_id,
                                           t_ref_prestation_id,
                                           taux)
        select next value for seq_taux_prise_en_charge,
               :strCouvertureAMO,
               t_ref_prestation_id,
               taux
        from t_taux_prise_en_charge
        where t_couverture_amo_id = :AIDCouvertureAMO;
    end

    insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                        t_client_id,
                                        t_couverture_amo_id,
                                        debut_droit_amo,
                                        fin_droit_amo)
    values(next value for seq_couverture_amo_client,
           :AIDClient,
           :strCouvertureAMO,
           :ADebutDroitsAMO,
           :AFinDroitsAMO);
  end
end;

create or alter procedure ps_infosoft_creer_couv_amc_cli(
  AIDClient integer,
  AIDOrganismeAMC varchar(4),
  AIDCouvertureAMC varchar(4),
  ADebutDroitsAMC date,
  AFinDroitsAMC date)
as
declare variable strCouvertureAMC varchar(50);
begin

end;

create or alter procedure ps_infosoft_creer_client(
  AID integer,
  ANumeroInsee varchar(15),
  ADateNaissance varchar(8),
  ARangGemellaire char(1),
  AQualite integer,
  ANom varchar(27),
  ANomJeuneFille varchar(27),
  APrenom varchar(27),
  ARue varchar(26),
  ACodePostal varchar(5),
  ANomVille varchar(21),
  ATelephone varchar(16),
  AFax varchar(16),
  APortable varchar(16),
  AIDOrganismeAMO varchar(4),
  AIDCouvertureAMO varchar(4),
  ACodeSituationAMO_0 integer,
  AALD_0 integer,
  ADebutDroitsAMO_0 date,
  AFinDroitsAMO_0 date,
  ACodeSituationAMO_1 integer,
  AALD_1 integer,
  ADebutDroitsAMO_1 date,
  AFinDroitsAMO_1 date,
  ACodeSituationAMO_2 integer,
  AALD_2 integer,
  ADebutDroitsAMO_2 date,
  AFinDroitsAMO_2 date,
  ACodeSituationAMO_3 integer,
  AALD_3 integer,
  ADebutDroitsAMO_3 date,
  AFinDroitsAMO_3 date,
  ACodeSituationAMO_4 integer,
  AALD_4 integer,
  ADebutDroitsAMO_4 date,
  AFinDroitsAMO_4 date,
  AIDOrganismeAMC varchar(8),
  AIDCouvertureAMC varchar(4),
  ACodeSituationAMC_0 integer,
  ADebutDroitsAMC_0 date,
  AFinDroitsAMC_0 date,
  ANumeroAdherentMutuelle varchar(16),
  ANumeroSPSante varchar(10))
as
declare variable strOrganismeAMC varchar(50);
declare variable strNomAMC varchar(50);
declare variable strCouvertureAMC varchar(50);
declare variable strSPSante varchar(10);
declare variable strCentreGest varchar(4);
begin
   -- Centre gestionnaire
   select o.centre_gestionnaire
   from t_organisme o
   inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
   where t_organisme_id = :AIDOrganismeAMO
     and r.sans_centre_gestionnaire = '1'
   into :strCentreGest;
   
   if (row_count = 0) then
     strCentreGest = null;
   
   -- SP Sante
   strSPSante = trim(ANumeroSPSante);
   if (char_length(strSPSante) = 8) then
   begin
     select nom
     from t_ref_organisme
     where type_organisme = '2'
       and identifiant_national = :strSPSante
     into strNomAMC;

     if (row_count = 0) then
       strNomAMC = strSPSante;

     strOrganismeAMC = 'SPSANTE_' || strSPSante;
     if (not exists(select *
                    from t_organisme
                    where t_organisme_id = :strOrganismeAMC)) then
       insert into t_organisme(t_organisme_id,
                               type_organisme,
                               nom,
                               identifiant_national)
       values(:strOrganismeAMC,
              '2',
              :strNomAMC,
              :strSPSante);
   end
   else
     strOrganismeAMC = AIDOrganismeAMC||'-AMC';


  -- Création couverture AMC
  if ((trim(strOrganismeAMC) <> '') and (trim(AIDCouvertureAMC) <> '')) then
  begin
    strCouvertureAMC = strOrganismeAMC || '_' || AIDCouvertureAMC;
    if ((not exists(select *
                   from t_couverture_amc
                   where t_couverture_amc_id = :strCouvertureAMC))
   and  ( exists(select *
                   from t_organisme
                   where t_organisme_id = :strOrganismeAMC)))
                    then
    begin
      insert into t_couverture_amc(t_couverture_amc_id, t_organisme_amc_id, libelle, montant_franchise, plafond_prise_en_charge, formule)
      select :strCouvertureAMC,
             :strOrganismeAMC,
             libelle,
             0,
             0,
             '02A'
      from t_couverture_amc
      where t_couverture_amc_id = :AIDCouvertureAMC;

      insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                         t_couverture_amc_id,
                                         t_ref_prestation_id,
                                         taux)
      select next value for seq_taux_prise_en_charge,
             :strCouvertureAMC,
             t_ref_prestation_id,
             taux
      from t_taux_prise_en_charge
      where t_couverture_amc_id = :AIDCouvertureAMC;
    end
  end
  else
    strCouvertureAMC = null;

  -- Création client
  insert into t_client(t_client_id,
                       numero_insee,
                       nom,
                       nom_jeune_fille,
                       prenom,
                       rue_1,
                       code_postal,
                       nom_ville,
                       tel_personnel,
                       tel_mobile,
                       fax,
                       date_naissance,
                       qualite,
                       rang_gemellaire,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       t_organisme_amc_id,
                       t_couverture_amc_id,
                       numero_adherent_mutuelle,
                       debut_droit_amc,
                       fin_droit_amc)
  values(:AID,
         trim(:ANumeroInsee),
         trim(:ANom),
         trim(:ANomJeuneFille),
         trim(:APrenom),
         trim(:ARue),
         :ACodePostal,
         trim(:ANomVille),
         trim(:ATelephone),
         trim(:APortable),
         trim(:AFax),
         substring(:ADateNaissance from 7 for 2) || substring(:ADateNaissance from 5 for 2) || substring(:ADateNaissance from 1 for 4),
         :AQualite,
         :ARangGemellaire,
         :AIDOrganismeAMO,
         :strCentreGest,
         :strOrganismeAMC,
         :strCouvertureAMC,
         trim(:ANumeroAdherentMutuelle),
         :ADebutDroitsAMC_0,
         :AFinDroitsAMC_0 );

   execute procedure ps_infosoft_creer_couv_amo_cli(:AID, :AIDOrganismeAMO, :AIDCouvertureAMO, :ACodeSituationAMO_0, :AALD_0, :ADebutDroitsAMO_0, :AFinDroitsAMO_0);
   execute procedure ps_infosoft_creer_couv_amo_cli(:AID, :AIDOrganismeAMO, :AIDCouvertureAMO, :ACodeSituationAMO_1, :AALD_1, :ADebutDroitsAMO_1, :AFinDroitsAMO_1);
   execute procedure ps_infosoft_creer_couv_amo_cli(:AID, :AIDOrganismeAMO, :AIDCouvertureAMO, :ACodeSituationAMO_2, :AALD_2, :ADebutDroitsAMO_2, :AFinDroitsAMO_2);
   execute procedure ps_infosoft_creer_couv_amo_cli(:AID, :AIDOrganismeAMO, :AIDCouvertureAMO, :ACodeSituationAMO_3, :AALD_3, :ADebutDroitsAMO_3, :AFinDroitsAMO_3);
   execute procedure ps_infosoft_creer_couv_amo_cli(:AID, :AIDOrganismeAMO, :AIDCouvertureAMO, :ACodeSituationAMO_4, :AALD_4, :ADebutDroitsAMO_4, :AFinDroitsAMO_4);
 end;


create or alter procedure ps_infosoft_creer_fournisseur (
  t_fournisseur_id varchar(50),
  flag_grossiste integer,
  raison_sociale varchar(50),
  rue_1 varchar(70),
  code_postal varchar(5),
  nom_ville varchar(70),
  tel_personnel varchar(20),
  fax varchar(20),
  numero_appel varchar(20),
  identifiant_171 varchar(8),
  contact varchar(50),
  pharmaml_ref_id varchar(4),
  pharmaml_url_1 varchar(150),
  pharmaml_url_2 varchar(150),
  pharmaml_id_officine varchar(20),
  pharmaml_id_magasin varchar(20),
  pharmaml_cle varchar(4),
  email varchar(50)


  )
as
declare variable mode_transmission char(1);
declare variable commentaire varchar(50);
begin

  if ( position(email,'@') = -1 )  then
  begin
    commentaire = email;
    email = '';
  end

  if ( identifiant_171 <> '' ) then
    mode_transmission = '1';
  else
    mode_transmission = '5';

  if ( flag_grossiste = 1 ) then
  insert into t_repartiteur(t_repartiteur_id,
                            raison_sociale,
                            rue_1,
                            code_postal,
                            nom_ville,
                            commentaire,
                            numero_appel,
                            tel_personnel,
                            fax,
                            vitesse_171,
                            identifiant_171,
                            mode_transmission,
                      pharmaml_ref_id,
                            pharmaml_url_1,
                            pharmaml_url_2,
                            pharmaml_id_officine,
                            pharmaml_id_magasin,
                            pharmaml_cle,
                            email
                            )
  values(:t_fournisseur_id,
         :raison_sociale,
         :rue_1,
         :code_postal,
         :nom_ville,
         :contact,
         :numero_appel,
         :tel_personnel,
         :fax,
         1,
         :identifiant_171,
         :mode_transmission,
     :pharmaml_ref_id,
         :pharmaml_url_1,
         :pharmaml_url_2,
         :pharmaml_id_officine,
         :pharmaml_id_magasin,
         :pharmaml_cle,
         :email

  );
  else
  insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                   raison_sociale,
                                   rue_1,
                                   code_postal,
                                   nom_ville,
                                   numero_appel,
                                   represente_par,
                                   tel_personnel,
                                   fax,
                                   vitesse_171,
                                   mode_transmission,
                                   nombre_tentatives,
                                   monogamme,
                                   identifiant_171)
  values (:t_fournisseur_id,
          :raison_sociale,
          :rue_1,
          :code_postal,
          :nom_ville,
          :numero_appel,
          :contact,
          :tel_personnel,
          :fax,
          1,
          :mode_transmission,
          1,
          '0',
          :identifiant_171);


end;


create or alter procedure ps_infosoft_historique_vente(
  AProduitId varchar(50),
  periode date,
  qte_sortie integer
  )
returns(
  periode_suivante date)
as
declare variable strPeriode varchar(6);
begin
  periode_suivante = dateadd(month, -1, periode);

  if (qte_sortie > 0) then
  begin
    strPeriode = substring(cast(periode as varchar(25)) from 6 for 2) ||
                 substring(cast(periode as varchar(25)) from 1 for 4);

    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_vendues,
                                   quantite_actes)
    values(next value for seq_historique_vente,
           :AProduitID,
           :strPeriode,
           :qte_sortie,
           :qte_sortie);
  end
end;

create or alter procedure ps_infosoft_historique_achat(
AProduitID integer,
AchatFournisseur varchar(50),
AchatPrix float,
AchatDate date,
AchatQuantite integer,
PrixVente float)
as
declare variable type_commande char(1);
declare variable t_repartiteur_id varchar(50);
declare variable t_fournisseur_direct_id varchar(50);
begin
 

 if ((trim(AchatFournisseur) <> '') and (AchatQuantite > 0)) then
  begin
    t_fournisseur_direct_id = null ;
    t_repartiteur_id = null ;

    if (exists( select * from t_repartiteur where t_repartiteur_id = :AchatFournisseur )) then
    begin
      t_repartiteur_id = :AchatFournisseur ;
      t_fournisseur_direct_id = null ;
      type_commande = '2' ;
      --etat = '2' ;
    end
    else  
  if (exists( select * from t_fournisseur_direct where t_fournisseur_direct_id = :AchatFournisseur )) then   
    begin
      t_fournisseur_direct_id = :AchatFournisseur ;
      t_repartiteur_id = null ;
      type_commande = '1' ;
    end

    if  (( t_repartiteur_id is not null  ) or ( t_fournisseur_direct_id is not null  )) then
    begin
      if (not exists ( select * from t_commande where t_commande_id = :AchatFournisseur||:AchatDate ))  then
        insert into t_commande(t_commande_id,
                   type_commande,
                   date_creation,
                   date_reception,
                   mode_transmission,
                   montant_ht,
                   t_repartiteur_id,
                   t_fournisseur_direct_id,
                   etat)
        values(:AchatFournisseur||:AchatDate,
           :type_commande,
           :AchatDate,
           :AchatDate,
           '5',
           :AchatQuantite*:AchatPrix,
           :t_repartiteur_id,
           :t_fournisseur_direct_id,
           '3');


         insert into t_commande_ligne(t_commande_ligne_id,
                       t_commande_id,
                       t_produit_id,
                       quantite_commandee,
                       quantite_recue,
                       prix_achat_tarif,
                       prix_achat_remise,
                       quantite_totale_recue,
                       prix_vente)
        values(next value for seq_commande_ligne,
           :AchatFournisseur||:AchatDate,
           :AProduitID,
           :AchatQuantite,
           :AchatQuantite,
           :AchatPrix,
           :AchatPrix,
           :AchatQuantite,
           :prixvente);


      
    end
  end
  when any do 
  begin
  end

end;

create or alter procedure ps_infosoft_creer_produit(
  AProduitID integer,
  ACodeCIP varchar(13),
  ADesignation varchar(50),
  ACodeEAN varchar(13),
  ACodetva varchar(1),
  AListe varchar(1),
  ACodeLabo varchar(1),
  APrestation varchar(3),
  ABaseRemboursement float,
  APrixAchat float,
  APrixAchatRemise float,
  APamp float,
  APrixVente float,
  ADateDerniereVente date,
  AZoneGeographique varchar(7),
  ACodeTIPSLPP varchar(13),
  AStock integer,
  AStockMini integer,
  AStockMaxi integer,
  AVente1 integer,
  AVente2 integer,
  AVente3 integer,
  AVente4 integer,
  AVente5 integer,
  AVente6 integer,
  AVente7 integer,
  AVente8 integer,
  AVente9 integer,
  AVente10 integer,
  AVente11 integer,
  AVente12 integer,
  AVente13 integer,
  AVente14 integer,
  AVente15 integer,
  AVente16 integer,
  AVente17 integer,
  AVente18 integer,
  AVente19 integer,
  AVente20 integer,
  AVente21 integer,
  AVente22 integer,
  AVente23 integer,
  AVente24 integer,
  ARepartiteurID varchar(50),
  AAchatFournisseur1 varchar(50),
  AAchatPrix1 float,
  AAchatDate1 date,
  AAchatQuantite1 integer,
  AAchatFournisseur2 varchar(50),
  AAchatPrix2 float,
  AAchatDate2 date,
  AAchatQuantite2 integer,
  AAchatFournisseur3 varchar(50),
  AAchatPrix3 float,
  AAchatDate3 date,
  AAchatQuantite3 integer,
  AAchatFournisseur4 varchar(50),
  AAchatPrix4 float,
  AAchatDate4 date,
  AAchatQuantite4 integer,
  AAchatFournisseur5 varchar(50),
  AAchatPrix5 float,
  AAchatDate5 date,
  AAchatQuantite5 integer,
  AAchatFournisseur6 varchar(50),
  AAchatPrix6 float,
  AAchatDate6 date,
  AAchatQuantite6 integer,
  AAchatFournisseur7 varchar(50),
  AAchatPrix7 float,
  AAchatDate7 date,
  AAchatQuantite7 integer,
  AAchatFournisseur8 varchar(50),
  AAchatPrix8 float,
  AAchatDate8 date,
  AAchatQuantite8 integer,
  AAchatFournisseur9 varchar(50),
  AAchatPrix9 float,
  AAchatDate9 date,
  AAchatQuantite9 integer,
  AAchatFournisseur10 varchar(50),
  AAchatPrix10 float,
  AAchatDate10 date,
  AAchatQuantite10 integer,
  AAchatFournisseur11 varchar(50),
  AAchatPrix11 float,
  AAchatDate11 date,
  AAchatQuantite11 integer,
  AAchatFournisseur12 varchar(50),
  AAchatPrix12 float,
  AAchatDate12 date,
  AAchatQuantite12 integer,
  AAchatFournisseur13 varchar(50),
  AAchatPrix13 float,
  AAchatDate13 date,
  AAchatQuantite13 integer,
  AAchatFournisseur14 varchar(50),
  AAchatPrix14 float,
  AAchatDate14 date,
  AAchatQuantite14 integer,
  AAchatFournisseur15 varchar(50),
  AAchatPrix15 float,
  AAchatDate15 date,
  AAchatQuantite15 integer,
  AAchatFournisseur16 varchar(50),
  AAchatPrix16 float,
  AAchatDate16 date,
  AAchatQuantite16 integer,
  AAchatFournisseur17 varchar(50),
  AAchatPrix17 float,
  AAchatDate17 date,
  AAchatQuantite17 integer,
  AAchatFournisseur18 varchar(50),
  AAchatPrix18 float,
  AAchatDate18 date,
  AAchatQuantite18 integer

)
as
declare variable lFtTauxTVA numeric(5,2);
declare variable lIntTVAID integer;
declare variable lIntPrestationID integer;
declare variable periode date;
declare variable TypeCode char(1);
declare variable lpp varchar(13);
declare variable lCodeCip13 varchar(13);
declare variable lCodeEan13 varchar(13);
declare variable lCodeEan13_2 varchar(13); -- eventuel deuxieme code ean
begin

  -- TVA
  if (ACodetva = 1) then
    lFtTauxTVA = 2.1;
  else
    if (ACodetva = 2) then
      lFtTauxTVA = 5.5;
      else
       if (ACodetva = 3) then
         lFtTauxTVA = 20;
       else
        if (ACodetva = 4) then
          lFtTauxTVA = 10;
        else
          lFtTauxTVA = '0.0';

  if (AListe = '') then
    AListe = '0';
  else
    if (AListe in('1', 'A')) then
      AListe = '1';
    else
      if (AListe in ('2', 'C')) then
        AListe = '2';
      else
        if (AListe in ('S', 'B')) then
          AListe = '3';
        else
          AListe = '0';

  if (ACodeLabo = '6') then
    ACodeLabo = '1';
  else
    if (ACodeLabo ='7') then
     ACodeLabo = '2';
   else
    ACodeLabo = '0';


  execute procedure ps_renvoyer_id_tva(lFtTauxTVA) returning_values :lIntTVAID;
  execute procedure ps_renvoyer_id_prestation(APrestation) returning_values :lIntPrestationID;



  -- cas 1 codecip = cip13 code ean = ? 
  if ( :ACodeCIP similar to '340[01][[:DIGIT:]]{9}' ) then
  begin 
    lCodeCip13 = :ACodeCIP;
    lCodeEan13 = :ACodeEAN;
  end  
  else -- cas 2 codecip = cip 7 et code ean = cip 13 , pas besoin du cip 7
    if (( :ACodeCIP similar to '[[:DIGIT:]]{7}' ) and ( :ACodeEAN similar to '340[01][[:DIGIT:]]{9}' )) then 
    begin 
      lCodeCip13 = :ACodeEAN;
      lCodeEan13 = null;
    end 
    else -- cas 2bis  codecip = cip 7 et code ean = ? ( mais pas cip 13 )
      if ( :ACodeCIP similar to '[[:DIGIT:]]{7}' ) then 
      begin 
        lCodeCip13 = :ACodeCIP;
        lCodeEan13 = :ACodeEAN;
      end 
      else -- cas 3 codecip7 est un EAN
        if (:ACodeCIP similar to '[[:DIGIT:]]{13}' ) then 
        begin
          lCodeCip13 = null;
          lCodeEan13 = :ACodeCIP;
          lCodeEan13_2 = :ACodeEAN;
        end 

  insert into t_produit(t_produit_id,
                        code_cip,
                        designation,
                        liste,
                        t_ref_prestation_id,
                        date_derniere_vente,
                        type_homeo,
                        prix_achat_catalogue,
                        prix_achat_remise,
                        pamp,
                        prix_vente,
                        base_remboursement,
                        t_ref_tva_id,
                        t_repartiteur_id,
                        profil_gs)                                   
  values(:AProduitID,
         :lCodeCip13,
         trim(:ADesignation),
         :AListe,
         :lIntPrestationID,
         :ADateDerniereVente,
         :ACodeLabo,
         :APrixAchat,
         :APrixAchatRemise,
         :APamp,
         :APrixVente,
         :ABaseRemboursement,
         :lIntTVAID,
          (select t_repartiteur_id from t_repartiteur where t_repartiteur_id = :ARepartiteurID),
          iif(:Astockmini<0,2,0));   
  -- Code EAN13
  
  if ( :lCodeEan13  similar to '[[:DIGIT:]]{13}')  then
      insert into t_code_ean13 (t_code_ean13_id,
                                t_produit_id,
                                code_ean13)
      values (next value for seq_code_ean13,
              :AProduitID,
              trim(:lCodeEan13));
  
  if (( :lCodeEan13_2  similar to '[[:DIGIT:]]{13}') and (:lCodeEan13_2 <> :lCodeEan13) ) then
      insert into t_code_ean13 (t_code_ean13_id,
                                t_produit_id,
                                code_ean13)
      values (next value for seq_code_ean13,
              :AProduitID,
              trim(:lCodeEan13_2));


  if (trim(:AZoneGeographique) > '' ) then
    update or insert into t_zone_geographique(t_zone_geographique_id,
                                              libelle)
    values(:AZoneGeographique,
           :AZoneGeographique);

  insert into t_produit_geographique (t_produit_geographique_id,
                                      t_produit_id,
                                      quantite,
                                      t_depot_id,
                                      stock_mini,
                                      stock_maxi,
                                      t_zone_geographique_id)
  values (next value for seq_produit_geographique,
          :AProduitID,
          iif(:AStock<0,0,:AStock),
          1,
          iif(:Astockmini<0,0,:Astockmini),
          iif(:Astockmaxi<0,0,:Astockmaxi),
          :AZoneGeographique );


  lpp = trim(ACodeTIPSLPP);
  if (lpp > '' ) then
  begin
    if ( lpp similar to '[[:DIGIT:]]{7}' ) then
       TypeCode = '0';
    else
       TypeCode = '2';

    insert into t_produit_lpp (t_produit_lpp_id,
                 t_produit_id,
                 type_code,
                 code_lpp,
                 quantite,
                 t_ref_prestation_id,
                 tarif_unitaire)
    values(next value for seq_produit_lpp,
       :AProduitId,
       :TypeCode,
       :lpp,
       1,
       :lIntPrestationID,
       :ABaseRemboursement);
  end

  periode = ADateDerniereVente;
  /* qte 0 = mois en cours */

  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente1) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente2) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente3) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente4) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente5) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente6) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente7) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente8) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente9) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente10) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente11) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente12) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente13) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente14) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente15) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente16) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente17) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente18) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente19) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente20) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente21) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente22) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente23) returning_values :periode;
  execute procedure ps_infosoft_historique_vente(:AProduitID, :periode, :AVente24) returning_values :periode;

  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur1,:AAchatPrix1,:AAchatDate1,:AAchatQuantite1,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur2,:AAchatPrix2,:AAchatDate2,:AAchatQuantite2,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur3,:AAchatPrix3,:AAchatDate3,:AAchatQuantite3,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur4,:AAchatPrix4,:AAchatDate4,:AAchatQuantite4,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur5,:AAchatPrix5,:AAchatDate5,:AAchatQuantite5,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur6,:AAchatPrix6,:AAchatDate6,:AAchatQuantite6,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur7,:AAchatPrix7,:AAchatDate7,:AAchatQuantite7,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur8,:AAchatPrix8,:AAchatDate8,:AAchatQuantite8,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur9,:AAchatPrix9,:AAchatDate9,:AAchatQuantite9,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur10,:AAchatPrix10,:AAchatDate10,:AAchatQuantite10,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur11,:AAchatPrix11,:AAchatDate11,:AAchatQuantite11,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur12,:AAchatPrix12,:AAchatDate12,:AAchatQuantite12,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur13,:AAchatPrix13,:AAchatDate13,:AAchatQuantite13,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur14,:AAchatPrix14,:AAchatDate14,:AAchatQuantite14,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur15,:AAchatPrix15,:AAchatDate15,:AAchatQuantite15,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur16,:AAchatPrix16,:AAchatDate16,:AAchatQuantite16,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur17,:AAchatPrix17,:AAchatDate17,:AAchatQuantite17,:APrixVente);
  execute procedure ps_infosoft_historique_achat(:AProduitID, :AAchatFournisseur18,:AAchatPrix18,:AAchatDate18,:AAchatQuantite18,:APrixVente);
end;


create or alter procedure ps_infosoft_creer_com_prod(
  ACodeCip varchar(13),
  ACommentaire varchar(200))
as
declare variable t_produit_id dm_code;
begin

  select t_produit_id from t_produit 
  where code_cip = :ACodeCip
  into :t_produit_id;

  if (:t_produit_id is null ) then
    select t_produit_id from t_code_ean13 
    where code_ean13 = :ACodeCip
    into :t_produit_id;  

  if (:t_produit_id is not null ) then 
    update t_produit 
    set commentaire_vente = substring( coalesce(commentaire_vente,'')||:ACommentaire from 1 for 200)
    where code_cip = :t_produit_id;

end;

create or alter procedure ps_infosoft_creer_histo_entete(
  ANumeroFacture integer,
  ANumeroOrdo integer,
  AIDClient integer,
  ADatePrescription date,
  ADateFacture date,
  AIdPraticien varchar(4),
  ANomPrenomPraticien varchar(20))
as
declare variable strNom varchar(20);
declare variable strPrenom varchar(20);
declare variable strNJF varchar(20);
begin
  execute procedure ps_separer_nom_prenom(:ANomPrenomPraticien, ' ') returning_values :strNom, :strPrenom, :strNJF;
  insert into t_historique_client(t_historique_client_id,
                                  t_client_id,
                                  date_prescription,
                                  t_praticien_id,
                                  nom_praticien,
                                  prenom_praticien,
                                  date_acte,
                                  numero_facture,
                                  type_facturation)
  values(:ANumeroFacture,
         :AIDClient,
         :ADatePrescription,
         iif(trim(:AIDPraticien) <> '', :AIDPraticien, null),
         :strNom,
         :strPrenom,
         :ADateFacture,
         :ANumeroFacture,
         '2');
end;

create or alter procedure ps_infosoft_creer_histo_ligne(
  ADateFacture date,
  ANumeroFacture integer,
  ACodeCIP varchar(13),
  ADesignation varchar(45),
  APrixVente float,
  AQuantite integer)
as
begin
  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                        t_historique_client_id,
                                        code_cip,
                                        designation,
                                        prix_vente,
                                        quantite_facturee)
  values(next value for seq_historique_client_ligne,
         :ANumeroFacture,
         :ACodeCIP,
         trim(:ADesignation),
         :APrixVente,
         :AQuantite);
end;

create or alter procedure ps_infosoft_creer_credit(
  AIDClient integer,
  ADateCredit date,
  AMontant float)
as
begin
  if (not exists(select *
                 from t_credit
                 where t_client_id = :AIDCLient)) then
    insert into t_credit(t_credit_id,
                         t_client_id,
                         date_credit,
                         montant)
    values(:AIDClient,
           :AIDClient,
           :ADateCredit,
           :AMontant);
  else
    update t_credit
    set montant = montant + :AMontant
    where t_client_id = :AIDClient;
end;

create or alter procedure ps_infosoft_creer_avances(
  AIDClient integer,
  ADate_avance date,
  ACode_Cip varchar(13),
  ADesignation varchar(50),
  AQuantite integer,
  APrix_vente float,
  APrix_achat float,
  ABase_remboursement float,
  APrestation varchar(3),
  AOperateur varchar(2)

  )
as
begin
        insert into t_vignette_avancee(t_vignette_avancee_id,
                                       t_client_id,
                                       date_avance,
                                       code_cip,
                                       designation,
                                       prix_vente,
                                       prix_achat,
                                       code_prestation ,
                                       t_operateur_id,
                                       quantite_avancee,
                                       base_remboursement,
                     t_produit_id)
        values(next value for seq_vignette_avancee,
               :AIDClient,
               :ADate_avance,
               :ACode_cip,
               :ADesignation,
               :Aprix_vente,
               :APrix_achat,
               :APrestation,
               (select t_operateur_id from t_operateur where code_operateur = :AOperateur),
               :AQuantite,
               :ABase_remboursement,
         (select t_produit_id from t_produit where code_cip = :Acode_cip or code_cip7 = :Acode_cip ));
end;

create or alter procedure ps_infosoft_creer_commande(
  id varchar(3),
  reception smallint,
  fournisseur varchar(4),
  date_creation date)
as
declare variable f varchar(50);
declare variable r varchar(50);
declare variable t varchar(2);
begin
  if (exists(select * from t_repartiteur where t_repartiteur_id = :fournisseur)) then
  begin
    r = fournisseur;
    f = null;
    t = '2';
  end
  else  if (exists( select * from t_fournisseur_direct where t_fournisseur_direct_id = :fournisseur )) then
  begin
    f = fournisseur;
    r = null;
    t = '1';
  end

  insert into t_commande(t_commande_id,
                         t_fournisseur_direct_id,
                         t_repartiteur_id,
                         type_commande,
                         etat,
                         montant_ht,
                         mode_transmission,
                         date_creation)
  values(:id,
         :f,
         :r,
         :t,
         case
           when :reception = '3' then '21'
           when :reception = '1' then '22'
           else '2'
         end,
         0,
         '5',
         :date_creation);
end;

create or alter procedure ps_infosoft_creer_ligne_cmd(
  id varchar(3),
  code_cip varchar(13),
  quantite_commandee integer,
  quantite_receptionnee integer,
  prix_1 float,
  prix_2 float,
  prix_3 float,
  prix_4 float)
as
declare variable p varchar(50);
declare variable e varchar(2);
begin
  update t_commande
  set montant_ht = montant_ht + :quantite_commandee * :prix_1
  where t_commande_id = :id
  returning etat into e;
  
  select t_produit_id
  from t_produit
  where code_cip = :code_cip
  into :p;
  
  insert into t_commande_ligne(t_commande_ligne_id,
                               t_commande_id,
                               t_produit_id,
                               quantite_commandee,
                               quantite_recue,
                               quantite_totale_recue,
                               prix_achat_tarif,
                               prix_achat_remise,
                               prix_vente)
  values(next value for seq_commande_ligne,
         :id,
         :p,
         :quantite_commandee,
         iif(:e = '21', 0, :quantite_receptionnee),
         iif(:e = '21', 0, :quantite_receptionnee),
         :prix_2,
         :prix_1,
         :prix_3);
end;

create or alter procedure ps_infosoft_creer_document(
  AIDClient integer,
  AIDDocument varchar(255))
as
begin
  insert into t_document(t_document_id,
                                type_entite,
                                t_entite_id,
                                libelle,
                                document)
  values(next value for seq_document,
         2,-- attesttations mut
         :AIDClient,
         'SCAN MUTUELLE',
         :AIDDocument);
end;

create or alter procedure ps_infosoft_creer_operateur(
  ACodeOperateur varchar(2),
  ANom varchar(14),
  APrenom varchar(14))
as
begin
  insert into t_operateur(t_operateur_id,
                          code_operateur,
                          nom,
                          prenom)
  values(:ACodeOperateur,
         :ACodeOperateur,
         :ANom,
         :APrenom);
end;

create or alter procedure ps_forcetrans
as
begin

  if (not exists(select t_destinataire_id from t_destinataire)) then
    insert into t_destinataire (t_destinataire_id,nom) values (1,'DESTINATAIRE T');
  update t_organisme set t_destinataire_id = '1' where identifiant_national <> '';
  update t_organisme set t_destinataire_id = '1' where caisse_gestionnaire <> '';
end;