set sql dialect 3;
/* **************************************************************************************************************** */


/* **************************************************************************************************************** */
/* ************************************************** Praticiens ************************************************** */
/* **************************************************************************************************************** */
create or alter procedure ps_pharmonyfr_creer_hopital(
  ANoFiness dm_code,
  ANom varchar(50),
  ARue1 varchar(80),
  AVille varchar(50),
  ACodepostal varchar(10),
  ATelephone varchar(50),
  AFax varchar(50),
  AEmail varchar(50)
 )
as
begin
      insert into t_hopital (t_hopital_id,
                             nom,
                             rue_1,
                             rue_2,
                             code_postal,
                             nom_ville,
                             no_finess,
                             tel_standard,
                             fax,
                             commentaire)
      values (:ANoFiness,
              :ANom,
              substring(:arue1 from 1 for 40),
              substring(:arue1 from 40 for 40),
              :ACodePostal,
              :AVille,
              :ANoFiness,
              :ATelephone,
              :AFax,
              :AEmail); 
end;


create or alter procedure ps_pharmonyfr_creer_praticien(
  APraticienID dm_code,
  APrenom varchar(50),
  ANom varchar(50),
  ARue1 varchar(80),
  AVille varchar(50),
  ACodepostal varchar(10),
  ATelephone varchar(50),
  AFax varchar(50),
  AEmail varchar(50),
  AMobile varchar(50),
  ACommentaire varchar(200),
  ASpecialite varchar(10),
  AExercice_mode varchar(10),--?
  ARPPS varchar(11),
  ANoFiness dm_code        
 )
as
declare variable IDHopital varchar(50);
declare variable intSpecialite integer;
begin
  execute procedure ps_renvoyer_id_specialite(:ASpecialite) returning_values :intSpecialite;


    -- si RPPS + finess d'hopital => praticien hospitalier     
  if ((substring(:ANoFiness from 3 for 1) = '0') and (trim(:ARPPS) > '')) then
  begin
    select t_hopital_id from T_HOPITAL where NO_FINESS = trim(:ANoFiness)
    into :IDHopital;

   update or insert into t_praticien(t_praticien_id,
                                    type_praticien,
                                    nom,
                                    prenom,
                                    rue_1,
                                    rue_2,
                                    code_postal,
                                    nom_ville,
                                    tel_standard,
                                    t_ref_specialite_id,
                                    no_finess,
                                    num_rpps,
                                    commentaire,
                                    t_hopital_id)
  values(:APraticienID,
         '2',
         :ANom,
         :APrenom,
         substring(:arue1 from 1 for 40),
         substring(:arue1 from 40 for 40),
         :acodepostal,
         :aville,
         :atelephone,
         :intSpecialite,
         :ANoFiness,
         trim(:ARPPS),
         '',
         :IDHopital);
  end

 -- si pas finess d'hopital => praticien privé     
  if (substring(:ANoFiness from 3 for 1) <> '0') then
   update or insert into t_praticien(t_praticien_id,
                                    type_praticien,
                                    nom,
                                    prenom,
                                    rue_1,
                                    rue_2,
                                    code_postal,
                                    nom_ville,
                                    tel_standard,
                                    t_ref_specialite_id,
                                    no_finess,
                                    num_rpps,
                                    commentaire)
  values(:APraticienID,
         '1',
         :ANom,
         :APrenom,
         substring(:arue1 from 1 for 40),
         substring(:arue1 from 40 for 40),
         :acodepostal,
         :aville,
         :atelephone,
         :intSpecialite,
         :ANoFiness,
         trim(:ARPPS),
         '');
end;



/* **************************************************************************************************************** */
/* ************************************************** Organismes ************************************************** */
/* **************************************************************************************************************** */

/* **************************************************************************************************************** */
create or alter procedure ps_PharmonyFR_creer_org_amc(
  AIDOrganisme dm_code,
  ANom varchar(50),
  ANomCourt varchar(50),
  AIdentifiantNational varchar(16),
  ARue1 varchar(80),
  AVille varchar(50),
  ACodepostal varchar(10),
  ATelephone varchar(50),
  AFax varchar(50),
  AEmail varchar(50),
  AMobile varchar(50)
 )
as
declare variable ADestinataireID dm_code;
begin

    ADestinataireID = null;
    update or insert into t_organisme(type_organisme,
                                      t_organisme_id,
                                      nom,
                                      nom_reduit,
                                      t_destinataire_id,
                                      type_releve,
                                      identifiant_national,
                                      application_mt_mini_pc,
                                      org_sante_pharma,
                                      rue_1,
                                      rue_2,
                                      code_postal,
                                      nom_ville,
                                      tel_personnel)
    values('2',
          :AIDOrganisme,
          trim(:ANom),
          substring(:ANomCourt from 1 for 20),
          :ADestinataireID,
          '0',
          right(:AIdentifiantNational, 8),
          '0',
          '0',
          substring(:arue1 from 1 for 40),
          substring(:arue1 from 40 for 40),
          :acodepostal,
          :aville,
          :atelephone);

end;

create or alter procedure ps_PharmonyFR_creer_org_amo(
  ARegime char(2),
  ACaisse char(3),
  ACentreGestionnaire char(4)
 )
as
declare variable intIDRegime integer;
declare variable strOrganismeID varchar(50);
declare variable strIdentifiantNational varchar(9);
declare variable chSansCentreGestionnaire char(1);
begin

  strOrganismeID = :ARegime || '_' || :ACaisse|| '_' ||ACentreGestionnaire ;

    select t_ref_regime_id,
           sans_centre_gestionnaire
    from t_ref_regime
    where code = :ARegime
    into :intIDRegime,
         :chSansCentreGestionnaire;

    if (row_count = 0) then
      intIDRegime = null;

    update or insert into t_organisme(type_organisme,
                                      t_organisme_id,
                                      nom,
                                      nom_reduit,
                                      type_releve,
                                      t_destinataire_id,
                                      t_ref_regime_id,
                                      caisse_gestionnaire,
                                      centre_gestionnaire,
                                      application_mt_mini_pc
                                      )
    values('1',
          :strOrganismeID,
          :strOrganismeID,
          :strOrganismeID,
          '0',
          null,
          :intIDRegime,
          :ACaisse,
          :ACentreGestionnaire,
          '0'
         );

end;

create or alter procedure ps_PharmonyFR_destinataire
as
begin

  if (not exists(select t_destinataire_id from t_destinataire)) then
    insert into t_destinataire (t_destinataire_id,nom) values (1,'DESTINATAIRE T');
  update t_organisme set t_destinataire_id = '1' where identifiant_national <> '';
  update t_organisme set t_destinataire_id = '1' where caisse_gestionnaire <> '';
end;


create or alter procedure ps_PharmonyFR_creer_couv_amo(
  AAld char(1),
  ACodeSituation char(4),
  ARegime char(2),
  ACaisse char(3),
  ACentreGestionnaire char(4)
 )
as
declare variable intIDRegime integer;
declare variable intCouvertureRef integer;
declare variable strOrganismeID varchar(50);
declare variable strCouvertureID varchar(50);
begin

  strOrganismeID = :ARegime || '_' || :ACaisse|| '_' ||ACentreGestionnaire ;
  strCouvertureID = :AAld || '_' || :ACodeSituation|| '_' ||:strOrganismeID ;

  execute procedure ps_renvoyer_id_couv_amo_ref(:AAld||:ACodeSituation) returning_values :intCouvertureRef;

  insert into t_couverture_amo(t_couverture_amo_id,
                               t_organisme_amo_id,
                               libelle,
                               ald,
                               t_ref_couverture_amo_id)         
  values(:strCouvertureID,
         :strOrganismeID,
         :strCouvertureID,
         :Aald,
         :intCouvertureRef);

end;


create or alter procedure ps_PharmonyFR_creer_taux_pc(
  t_couverture_amc_id varchar(50),
  prestation varchar(3),
  taux float,
  formule varchar(3))
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:prestation) returning_values :intPrestation;

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux,
                                     formule)
  values(next value for seq_taux_prise_en_charge,
         :t_couverture_amc_id,
         :intPrestation,
         :taux,
         :formule);
end;

create or alter procedure ps_PharmonyFR_creer_couv_amc(
  AOrganismeID varchar(10),
  AFormule varchar(3),
  APH2 numeric(10,2),
  APH4 float,
  APH7 float,
  APHN float,
  ALPP float
  )
as
declare variable t_couverture_amc_id dm_code;
begin

  t_couverture_amc_id = :AFormule||cast(:APH2 as integer)||'-'
                                  ||cast(:APH4 as integer)||'-'
                                  ||cast(:APH7 as integer)||'-'
                                  ||cast(:APHN as integer)||'-'
                                  ||cast(:ALPP as integer); 
  

  insert into t_couverture_amc (t_couverture_amc_id,
                                t_organisme_amc_id,
                                libelle,
                                montant_franchise,
                                plafond_prise_en_charge,
                                couverture_cmu,
                                formule)
  values (:t_couverture_amc_id,
          :AOrganismeID,
          :t_couverture_amc_id,
          0,
          0,
          0,
          null--:Aformule ne ^pas remplir code formalue ala fois dans t_couverture et dans t_taux
          );

  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'PH2',
                                                :APH2,
                                                :Aformule);
  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'PH4',
                                                :APH4,
                                                :Aformule);
  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'PH7',
                                                :APH7,
                                                :Aformule);
  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'PHN',
                                                :APHN,
                                                :Aformule);
  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'AAD',
                                                :ALPP,
                                                :Aformule);
  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'PMR',
                                                :APH7,
                                                :Aformule);
  execute procedure ps_PharmonyFR_creer_taux_pc(:t_couverture_amc_id,
                                                'PH1',
                                                100,
                                                :Aformule);
end;





create or alter procedure ps_PharmonyFR_creer_compte(
  ACompteID dm_code,
  APrenom varchar(50),
  ANom varchar(50),
  ARaisonSociale varchar(50),
  AVille varchar(50),
  ARue1 varchar(80),
  ACodepostal varchar(10),
  ATelephone varchar(50),
  AFax varchar(50),
  AEmail varchar(50),
  AMobile varchar(50),
  ACommentaire varchar(200),
  AMontantCredit float
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
                       tel_personnel,
                       tel_mobile,
                       fax)
  values(:ACompteID,
         substring(iif(:ARaisonSociale='',trim(:ANom)||' '||trim(:APrenom),:ARaisonSociale) from 1 for 30),
         substring(:ARue1 from 1 for 40),
         substring(:ARue1 from 41 for 40),
         substring(:ACodepostal from 1 for 5),
         substring(:AVille from 1 for 30),
         substring(:ATelephone from 1 for 20),
         substring(:ATelephone from 1 for 20),
         substring(:AMobile from 1 for 20),
         substring(:AFax from 1 for 20));
end;


/* **************************************************************************************************************** */

/* **************************************************************************************************************** */

/* **************************************************************************************************************** */
/* ************************************************** Clients ***************************************************** */
/* **************************************************************************************************************** */

create or alter procedure ps_PharmonyFR_creer_client(
  AClientID dm_code,
  APrenom varchar(30),
  ANom varchar(30),
  ADateNaissance varchar(10),
  ARangGemellaire char(1),
  ANumeroInsee varchar(13),
  ACle varchar(2),
  AQualite varchar(2),
  AGenre char(1), 
  AEtat char(1), 
  ARue1 varchar(80),
  AVille varchar(50),
  ACodepostal varchar(10),
  ATelephone varchar(15), 
  AFax varchar(15),
  AEmail varchar(60),  
  AMobile varchar(15),
  ACommentaire varchar(2000),
  ACredit float
 )
as
declare variable strClientID varchar(50);
declare variable lStrDateNaissance varchar(8);
declare variable lStrQualite varchar(2);
declare variable strCommentaireG varchar(200);
begin

  insert into t_client(t_client_id,
                       numero_insee,
                       nom,
                       prenom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_personnel,
                       tel_standard,
                       tel_mobile,
                       fax,
                       email,
                       date_naissance,
                       qualite,
                       rang_gemellaire,
                       --date_derniere_visite,
                       genre --,
                             --date_creation
                       )
  values(:AClientID,
    trim(:ANumeroInsee)||trim(:ACle),
    trim(:ANom),
    trim(:APrenom),
    substring(:ARue1 from 1 for 40),
    substring(:ARue1 from 40 for 40),
    :acodepostal,
    :aville,
    trim(:atelephone),
    trim(:ATelephone),
    trim(:AMobile),
    :AFax,
    substring(:aemail from 1 for 50),
    substring(:ADateNaissance from 7 for 2) ||
                             substring(:ADateNaissance from 5 for 2) ||
                             substring(:ADateNaissance from 1 for 4),
    iif(trim(:AQualite)='','0',:AQualite),
    :ARangGemellaire,
    --:ADateDerniereVisite,
    iif(:AGenre = '2', 'F', 'H') --,
    --:ADateCreation
    );

  if (trim(:ACommentaire) > '') then
  insert into t_commentaire (t_commentaire_id,
                             t_entite_id,
                             type_entite,
                             commentaire,
                             est_global)
  values (next value for seq_commentaire,
          :AClientID,
          '0', -- client 
          cast(:ACommentaire as blob),
          '1' );

end;



create or alter procedure ps_PharmonyFR_creer_couv_cli(
  AClientID dm_code,
  AAld char(1),
  ACodeSituation char(4),
  ARegime char(2),
  ACaisse char(3),
  ACentreGestionnaire char(4),
  ADebutDroitAMO varchar(10),
  AFinDroitAMO varchar(10),
  AOrganismeAMCID varchar(10),
  ANumeroAdherent varchar(15),
  AFormule varchar(3),
  APH2 varchar(10),
  APH4 varchar(10),
  APH7 varchar(10),
  APHN varchar(10),
  ALPP varchar(10),
  ADebutDroitAMC varchar(10),
  AFinDroitAMC varchar(10),
  AModeGestionAMC char(1)
 )
as
declare variable intIDRegime integer;
declare variable intCouvertureRef integer;
declare variable strOrganismeID varchar(50);
declare variable strCouvertureID varchar(50);
declare variable date_debut_droit_amo date;
declare variable date_fin_droit_amo date;
declare variable t_couverture_amc_id varchar(50);
begin
    t_couverture_amc_id = :AFormule||cast(:APH2 as integer)||'-'
                                  ||cast(:APH4 as integer)||'-'
                                  ||cast(:APH7 as integer)||'-'
                                  ||cast(:APHN as integer)||'-'
                                  ||cast(:ALPP as integer); 
  
 
  strOrganismeID = :ARegime || '_' || :ACaisse|| '_' ||ACentreGestionnaire ;
  strCouvertureID = :AAld || '_' || :ACodeSituation ||'_'||:strOrganismeID;

  insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                      t_client_id,
                                      t_couverture_amo_id,
                                      debut_droit_amo,
                                      fin_droit_amo

    )         
  values(next value for seq_couverture_amo_client,
         :AClientID,
         :strCouvertureID,
         iif(trim(:ADebutDroitAMO)>'',trim(:ADebutDroitAMO),null),
         iif(trim(:AFinDroitAMO)>'',trim(:AFinDroitAMO),null)         
    );

  update t_client set t_organisme_amo_id = :strOrganismeID,
                      centre_gestionnaire = :ACentreGestionnaire,
                      mode_gestion_amc = iif(:AModeGestionAMC = '1', '1', '2')
  where t_client_id = :AClientID;

  if (exists(select null from t_couverture_amc where t_couverture_amc_id = :t_couverture_amc_id)) then
  update t_client set t_organisme_amc_id = :AOrganismeAMCID,
                      t_couverture_amc_id = :t_couverture_amc_id,
                      numero_adherent_mutuelle = :ANumeroAdherent,
                      debut_droit_amc = replace(:ADebutDroitAMC, '/','.'),
                      fin_droit_amc = replace(:AFinDroitAMC, '/','.')
  where t_client_id = :AClientID;  

end;




/* **************************************************************************************************************** */
/* ************************************************** Produits **************************************************** */
/* **************************************************************************************************************** */
create or alter procedure ps_creer_fournisseur(
  AFournisseurID dm_code,
  ATypeFournisseur char(1),
  ARaisonSociale varchar(25),
  AIdentifiantClient varchar(20),
  AIdentifiantFournisseur varchar(20),
  ACodeFournisseur varchar(20),
  aProtocolCode varchar(3),
  AUtilisateur varchar(50),
  AMotDePasse varchar(50),
  ACleCryptage varchar(4),
  AURLPrincipale varchar(100)
 )
as
begin

/* ---------------- REPARTITEUR ---------------*/
  if (ATypeFournisseur='1') then
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale,
                              identifiant_171,
                              pharmaml_url_1,
                              pharmaml_cle,
                              pharmaml_id_officine,
                              pharmaml_id_magasin,
                              pharmaml_ref_id
                            )
    values(:AFournisseurID,
          trim(:ARaisonSociale),
          substring(:AIdentifiantClient from 1 for 8),
          :AURLPrincipale, -- in 100 out 150 OK
          :ACleCryptage, -- out dm_varchar4
          :AIdentifiantClient, -- pharmaml_id_officine in varchar(20) out dm_varchar20 OK
          :AIdentifiantFournisseur, --in varchar(20) out dm_varchar20 OK
          cast(:aProtocolCode as dm_numeric3)
         );
  else 
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                     raison_sociale
      )
    values (:AFournisseurID,
            trim(:ARaisonSociale)
  );    

end;
/* **************************************************************************************************************** */

/* **************************************************************************************************************** */
create or alter procedure ps_creer_zone_geo(
  geo_id dm_code,
    geo_name varchar(50),
    dep_name dm_libelle,
    dep_id dm_code,
    dep_robot dm_boolean
)
as
begin
  update or insert into t_zone_geographique(
    t_zone_geographique_id,
    libelle)
  values(:geo_id,
         substring(trim(:geo_name) from 1 for 50));

  update or insert into t_depot(
    t_depot_id,
    libelle,
    automate,
    type_depot)
    values (:dep_id,
            substring(trim(:dep_name) from 1 for 50),
            cast(:dep_robot as dm_boolean),
            'SUVE');
  
end;

/* **************************************************************************************************************** */
create or alter procedure ps_creer_produit(
  AProduitID dm_code,
  ACIP13 char(13),
  ADesignation varchar(34),
  APrixAchat float,
  ATVA float,
  APrixVente float,
  AStockMini integer,
  AStockMaxi integer,
  APAMP float,
  ADatePeremption date,
  AEan13 char(13),
  APrestation char(3),
  ACommentaireVente varchar(1000)
 )
as
declare variable lFtTauxTVA numeric(5,2);
declare variable lIntTVAID integer;
declare variable lIntPrestationID integer;
declare variable lIntFamilleBCB integer;
declare variable lIntFamilleInterne integer;
declare variable lIntDistributeur integer;
declare variable intMarque integer;
declare variable lCodeCIP13 varchar(13);
declare variable lCodeEAN13 varchar(13);
declare variable lCodeCIP7 char(7);
begin

  execute procedure ps_renvoyer_id_tva(lFtTauxTVA) returning_values :lIntTVAID;

 --  Prestation
  execute procedure ps_renvoyer_id_prestation(APrestation) returning_values :lIntPrestationID;

  -- Marque
  --execute procedure ps_renvoyer_id_marque(:ALaboratoire) returning_values :intMarque;

  -- Distributeur
  --execute procedure ps_renvoyer_id_codification('4', :ADistributeur) returning_values :lIntDistributeur;

  -- Familles
  --execute procedure ps_renvoyer_id_codification('1', trim(:AFamilleBCB)) returning_values :lIntFamilleBCB;
  --if (AFamilleInterne = AFamilleBCB) then
  --  lIntFamilleInterne = null;
  --else
  --  execute procedure ps_renvoyer_id_codification('2', trim(:AFamilleInterne)) returning_values :lIntFamilleInterne;


    -- ne reprendre cip7 que si c'est le seul code  

    
  -- Produit
  insert into t_produit(t_produit_id,
                        code_cip,
                        designation,
                        liste,
                        t_ref_prestation_id,
                        date_derniere_vente,
                        type_homeo,
                        prix_achat_catalogue,
                        prix_vente,
                        t_ref_tva_id,
                        t_repartiteur_id,
                        --prix_achat_remise,
                        pamp,
                        date_peremption,
                        --commentaire_commande,
                        commentaire_vente,
                        stock_mini,
                        stock_maxi,
                        profil_gs,
                        calcul_gs)
  values(:AProduitID,
         :ACIP13, 
         :ADesignation,
         '0',
         :lIntPrestationID,
         null,
         '0',
         :APrixAchat,
         :APrixVente,
         :lIntTVAID,
         null,
         --:APrixAchatRemise,
         :APAMP,
         :ADatePeremption,
         --substring(:ACommentaireAchat from 1 for 200),
         substring(:ACommentaireVente from 1 for 200),
         :AStockMini,
         :AStockMaxi,
         '0',
         '0');

if (:AEAN13 similar to '[[:DIGIT:]]{13}') then
        insert into t_code_ean13 (t_code_ean13_id,
                                  t_produit_id,
                                  code_ean13)
        values (next value for seq_code_ean13,
                :AProduitID,
                trim(:AEAN13));

end;

/* **************************************************************************************************************** */
create or alter procedure ps_creer_stock(
  AProduitID integer,
  AQuantite numeric(5),
  APriorite char(1),
  AStockMini numeric(3),
  AStockMaxi numeric(3),
  AZoneGeographique varchar(50),
  ADepotId dm_code)
as
declare variable t_depot_id dm_code;
begin
  

  insert into t_produit_geographique (t_produit_geographique_id,
                                      t_produit_id,
                                      quantite,
                                      t_depot_id,
                                      stock_mini,
                                      stock_maxi,
                                      t_zone_geographique_id)
  values (next value for seq_produit_geographique,
          :AProduitID,
          :AQuantite,
          :AdepotId,
          :AStockMini,
          :AStockMaxi,
          iif(:AZoneGeographique = '', null, trim(:AZoneGeographique)));

end;


/* ********************************************************************************************** */
create or alter procedure ps_nev_creer_produit_code(
  AProduitID dm_code,
  ACode varchar(13),
  p_type integer)
as
declare code_cip_produit varchar(13);
begin
  
  -- recuperation du code cip du produit pour comparaison
  select code_cip
  from t_produit
  where  t_produit_id = :AProduitID
  into code_cip_produit;

  -- si deja un cip13 de creer_produit mettre a jour avec celui donc le code type = 1
  -- CIP 13
  if (((:ACode similar to '340[01][[:DIGIT:]]{9}') and (p_type = 1)) -- code cip13 prioritaire
  or ((:ACode similar to '340[01][[:DIGIT:]]{9}') and ( coalesce(:code_cip_produit,'') not similar to '340[01][[:DIGIT:]]{9}'))) then -- cip 13 pas deja present ( ecrase un cip 7 ou un cip13 null)  
    update t_produit 
    set code_cip = trim(:ACode) 
    where t_produit_id = :AProduitID; 
  else
    begin
  
      -- code EAN / GTIN / ACL / codes internes ... mais pas de CIP 13 !!
      if ((trim(:ACode) similar to '[[:DIGIT:]]{13}')  and (trim(:ACode) not similar to '340[01][[:DIGIT:]]{9}') and not(exists(select code_ean13 from t_code_ean13 WHERE code_ean13 = trim(:ACode)))) then
      begin
        insert into t_code_ean13 (t_code_ean13_id,
                    t_produit_id,
                    code_ean13)
        values (next value for seq_code_ean13,
            :AProduitID,
            trim(:ACode));
      end
      -- si le seul code est un cip 7 le reprendre 
      if ((trim(:ACode) similar to '[[:DIGIT:]]{7}') and (code_cip_produit is null)) then 
      begin
        update t_produit 
        set code_cip = :ACode 
        where t_produit_id = :AProduitID ;
      end
      
      -- si on a un code autre que code interne , cip 7 inutile le faire sauter 
      if ((trim(:ACode) not similar to '20000[[:DIGIT:]]{8}') and (trim(:ACode) not similar to '[[:DIGIT:]]{7}') and (coalesce(trim(:code_cip_produit),'') similar to '[[:DIGIT:]]{7}')) then 
      begin
        update t_produit 
        set code_cip = null 
        where t_produit_id = :AProduitID ;
      end  


     end   
end;
/* ********************************************************************************************** */
create or alter procedure ps_PharmonyFR_creer_histo_vente(
  ADate varchar(7),
  AProduitID dm_code,
  AQuantite integer
)
as
declare variable mois varchar(2);
declare variable annee varchar(4);
begin

    mois = substring( ADate from 6 for 2);
    annee = substring( ADate from 1 for 4);

    insert into t_historique_vente(t_historique_vente_id,
                                   t_produit_id,
                                   periode,
                                   quantite_vendues,
                                   quantite_actes)
    values(next value for seq_historique_vente,
           :AProduitID,
           :mois || :annee,
           :AQuantite,
           :AQuantite);

end;


create or alter procedure ps_PharmonyFR_creer_credit(
  AClientID varchar(50),
  AMontantCredit float)
as
declare variable boolCpt char(1);
begin

  if ( exists(select null from t_compte where t_compte_id = :AClientID) ) then
    boolCpt = '1';
  else 
    boolCpt = '0';

  insert into t_credit(t_credit_id,
             t_client_id,
             t_compte_id,
             date_credit,
             montant)
  values(:AClientID,
       iif(:boolCpt = '0', :AClientID, null),
       iif(:boolCpt = '1', :AClientID, null),
       current_date,
       :AMontantCredit);
end;


create procedure ps_creer_hist_entete(
AClient integer,
ADateOrdonnance date,  
ADateFacture date,   
ANFacture integer,
ANoPrescripteur varchar(9))
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
  values(:ANFacture,
         :AClient,
         :ANFacture,
         :ADateOrdonnance,
         '.',
         :ANoPrescripteur,
         '2',
         :ADateFacture);
end;

create or alter procedure ps_creer_hist_ligne (
  ANFacture integer,
  AProduit varchar(127),
  ACip varchar(13),
  AQuantite smallint,  
  APrix float
  )
as
begin
  if (AQuantite > 0) then
    insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                          t_historique_client_id,
                                          code_cip,
                                          designation,
                                          quantite_facturee,
                                          prix_vente)
    values(next value for seq_historique_client_ligne,
           :ANFacture,
           :ACip,
           substring(:AProduit from 1 for 50),
           :AQuantite,
           :APrix);
end;