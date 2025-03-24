set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_specialite(
  ASpecialite varchar(2))
returns(
  AID integer)
as
begin
  select t_ref_specialite_id
  from t_ref_specialite
  where code = lpad(:ASpecialite, 2, '0')
  into :AID;

  if (row_count = 0) then
    select t_ref_specialite_id
    from t_ref_specialite 
    where code = '01'
    into :AID;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_regime(
  ARegime varchar(2))
returns(
  AID integer)
as
begin
  select t_ref_regime_id
  from t_ref_regime
  where code = lpad(:ARegime, 2, '0')
  into :AID;

  if (row_count = 0) then
    select t_ref_regime_id
    from t_ref_regime 
    where code = '01'
    into :AID;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_prestation(
  APrestation varchar(3))
returns(
  AID integer)
as
begin
  select t_ref_prestation_id
  from t_ref_prestation
  where code = :APrestation
  into :AID;

  if (row_count = 0) then
    select t_ref_prestation_id
    from t_ref_prestation
    where code = 'MX1'
    into :AID;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_tva(
  ATaux numeric(5, 2))
returns(
  AID integer)
as
begin
  select t_ref_tva_id
  from t_ref_tva
  where taux = :ATaux
  into :AID;
  
  if (row_count = 0) then
    select t_ref_tva_id
    from t_ref_tva
    where taux = 0
    into :AID;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_codification(
  ARang char(1),
  ACode varchar(50))
returns(
  AID integer)
as
begin
  select t_codification_id
  from t_codification
  where rang = :ARang
    and code = :ACode
  into :AID;
  
  if (row_count = 0) then
    AID = null;
end;

create or alter procedure ps_renvoyer_id_codification_2(
  ARang char(1),
  ALibelle varchar(50))
returns(
  AID integer)
as
begin  
  if ((ALibelle is not null) and (ALibelle <> '')) then
  begin
    select t_codification_id
    from t_codification
    where rang = :ARang
      and libelle = :ALibelle
    into :AID;
    
    if (row_count = 0) then
      insert into t_codification(t_codification_id, rang, libelle, code)
      values(next value for seq_codification, :ARang, :ALibelle, :ALibelle)
      returning t_codification_id into :AID;
  end
  else
    AID = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_marque(
  AMarque varchar(50))
returns(
  AID dm_cle)
as
declare variable strMarque dm_libelle;
begin
  if ((AMarque is not null) and (AMarque <> '')) then
  begin
    execute procedure ps_renvoyer_id_codification(6, :AMarque) returning_values :AID;
    if (AID is null) then
    begin
      select raison_sociale
      from t_fournisseur_direct
      where t_fournisseur_direct_id = :AMarque
      into :strMarque;
      
      insert into t_codification(t_codification_id,
                                 rang,
                                 code,
                                 libelle)
      values(next value for seq_codification,
             6,
             :AMarque,
             coalesce(:strMarque, :AMarque))
      returning t_codification_id into :AID;
    end
  end
  else
    AID = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_praticien(
  ANoFiness varchar(9))
returns(
  AID integer)
as
begin
  select first 1 t_praticien_id
  from t_praticien
  where no_finess = :ANoFiness
  into :AID;
  
  if (row_count = 0) then
    AID = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_organisme_amo(
  ARegime varchar(2),
  ACaisseGestionnaire varchar(3),
  ACentreGestionnaire varchar(4))
returns(
  AID integer)
as
begin
  select first 1 t_ref_organisme_id
  from t_ref_organisme o
       inner join t_ref_regime r on (r.t_ref_regime_id = o.t_ref_regime_id)
  where r.code = :ARegime
    and o.caisse_gestionnaire = :ACaisseGestionnaire
    and coalesce(centre_gestionnaire, '') = iif(r.sans_centre_gestionnaire = '1', '', :ACentreGestionnaire)
  into :AID;

  if (row_count = 0) then
    AID = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_depot(
  ADepot varchar(50))
returns(
  AID varchar(50))
as
begin
  select t_depot_id
  from t_depot
  where libelle = :ADepot
  into :AID;
  
  if (row_count = 0) then
    AID = null;
    
  suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_couv_amo_ref(
  ACodeSesamVitale char(5))
returns(
  ACouvertureAMORef integer)
as
begin
  select t_ref_couverture_amo_id
  from t_ref_couverture_amo
  where code_couverture = :ACodeSesamVitale
  into :ACouvertureAMORef;
  
  if (row_count = 0) then
    ACouvertureAMORef = null;
end;

/* ********************************************************************************************** */
create or alter procedure ps_eclater_sp_sante(
  AIDOrganismeAMC varchar(50))
as
declare variable c varchar(50);
declare variable adh varchar(16);
declare variable org varchar(50);
declare variable couv varchar(50);
declare variable couv_sp varchar(50);
declare variable n varchar(50);
declare variable d varchar(50);
begin
  for select c.t_client_id, substring(c.contrat_sante_pharma from 1 for 8), c.t_couverture_amc_id, o.t_destinataire_id
      from t_client c
           inner join t_organisme o on (o.t_organisme_id = c.t_organisme_amc_id)
      where t_organisme_amc_id = :AIDOrganismeAMC and c.contrat_sante_pharma <> ''
      into :c, :adh, :couv, :d do
  begin
    org = 'MSPSANTE_' || :adh;
    if (not exists(select *
                   from t_organisme
                   where t_organisme_id = :org)) then
    begin
      select nom
      from t_ref_organisme
      where identifiant_national = :adh
      into n;
      
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
             :n ,
             :adh,
             '0',
             :adh,
             :d,
             '0',
             '0',
             0,
             '0');
    end
    
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
    
    update t_client
    set t_organisme_amc_id = :org, t_couverture_amc_id = :couv_sp, contrat_sante_pharma = null
    where t_client_id = :c;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_renvoyer_id_produit(
  ACodeProduit varchar(50))
returns(
  AIDProduit dm_code)
as
begin
  select t_produit_id 
  from t_produit
  where code_cip = :ACodeProduit or code_cip7 = :ACodeProduit
  into :AIDProduit;
  
  if (row_count = 0) then
  begin
      select t_produit_id
      from t_code_ean13
      where code_ean13 = :ACodeProduit
      into :AIDProduit;

       if (row_count = 0) then
        AIDProduit = null;
  end  
end;