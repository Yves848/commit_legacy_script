set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_hopital(
  t_hopital_id varchar(50),
  nom varchar(50),
  commentaire varchar(200),
  no_finess varchar(9),
  rue_1 varchar(40),
  rue_2 varchar(40),
  code_postal char(5),
  nom_ville varchar(30),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  fax varchar(20))
as
begin
  insert into t_hopital(
    t_hopital_id,
    nom,
    commentaire,
    no_finess,
    rue_1,
    rue_2,
    code_postal,
    nom_ville,
    tel_personnel,
    tel_standard,
    tel_mobile,
    fax)
  values (
    :t_hopital_id,
    :nom,
    :commentaire,
    :no_finess,
    :rue_1,
    :rue_2,
    :code_postal,
    :nom_ville,
    :tel_personnel,
    :tel_standard,
    :tel_mobile,
    :fax);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_praticien(
  t_praticien_id varchar(50),
  type_praticien char(1),
  nom varchar(50),
  prenom varchar(50),
  code_specialite varchar(2),
  rue_1 varchar(40),
  rue_2 varchar(40),
  code_postal char(5),
  nom_ville varchar(30),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  fax varchar(20),
  t_hopital_id varchar(50),
  commentaire varchar(200),
  no_finess dm_finess,
  num_rpps dm_rpps)
as
declare variable intSpecialite integer;
begin
  execute procedure ps_renvoyer_id_specialite(:code_specialite) returning_values :intSpecialite;

  insert into t_praticien (t_praticien_id,
                            type_praticien,
                            nom,
                            prenom,
                            t_ref_specialite_id,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_personnel,
                            tel_standard,
                            tel_mobile,
                            fax,
                            t_hopital_id,
                            commentaire,
                            no_finess,
                            num_rpps)
  values (:t_praticien_id,
          :type_praticien,
          :nom,
          :prenom,
          :intSpecialite,
          :rue_1,
          :rue_2,
          :code_postal,
          :nom_ville,
          :tel_personnel,
          :tel_standard,
          :tel_mobile,
          :fax,
          :t_hopital_id,
          :commentaire,
          :no_finess,
          :num_rpps);


end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_dest(
  t_destinataire_id varchar(50),
  num_ident varchar(20),
  serv_smtp varchar(50),
  serv_pop3 varchar(50),
  utilisateur_pop3 varchar(100),
  mot_passe_pop3 varchar(50),
  adresse_bal varchar(50) ,
  no_appel varchar(50),
  tempo smallint,
  email_oct varchar(50) ,
  nom varchar(50),
  rue1 varchar(40),
  rue2 varchar(40),
  codepostal varchar(5),
  nomville varchar(30),
  telstandard varchar(20),
  telpersonnel varchar(20),
  telmobile varchar(20),
  fax varchar(20),
  application_oct varchar(20),
  num_dest_oct varchar(20),
  commentaire varchar(100),
  flux varchar(30),
  zone_message varchar(37),
  oct char(1),
  authentification char(1),
  typ varchar(2),
  gestion_num_lots char(1),
  xsl varchar(50),
  refuse_htp char(1))
as
begin
  insert into t_destinataire(t_destinataire_id,
                             num_ident,
                             serv_smtp,
                             serv_pop3,
                             utilisateur_pop3,
                             mot_passe_pop3,
                             adresse_bal,
                             no_appel,
                             tempo,
                             email_oct,
                             nom,
                             rue_1,
                             rue_2,
                             code_postal,
                             nom_ville,
                             tel_personnel,
                             tel_standard,
                             tel_mobile,
                             fax,
                             application_oct,
                             num_dest_oct,
                             commentaire,
                             flux,
                             zone_message,
                             oct,
                             authentification,
                             typ,
                             refuse_htp,
                             gestion_num_lots,
                             xsl)
  values (:t_destinataire_id,
          :num_ident,
          :serv_smtp,
          :serv_pop3,
          :utilisateur_pop3,
          :mot_passe_pop3,
          :adresse_bal,
          :no_appel,
          :tempo,
          :email_oct,
          :nom,
          :rue1,
          :rue2,
          :codepostal,
          :nomville,
          :telpersonnel,
          :telstandard,
          :telmobile,
          :fax,
          :application_oct,
          :num_dest_oct,
          :commentaire,
          :flux,
          :zone_message,
          :oct,
          :authentification,
          :typ,
          :refuse_htp,
          :gestion_num_lots,
          :xsl);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_organisme(
  t_organisme_id varchar(50),
  type_organisme char(1),
  nom_reduit varchar(20),
  commentaire varchar(200),
  commentaire_bloquant varchar(200),
  rue_1 varchar(40),
  rue_2 varchar(40),
  code_postal char(5),
  nom_ville varchar(30),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  fax varchar(20),
  org_reference char(1),
  mt_seuil_tiers_payant float,
  accord_tiers_payant char(1),
  doc_facturation smallint,
  type_releve varchar(10),
  edition_releve char(1),
  frequence_releve smallint,
  mt_seuil_ed_releve float,
  code_regime varchar(2),
  caisse_gestionnaire varchar(3),
  centre_gestionnaire varchar(4),
  fin_droits_org_amc char(1),
  org_circonscription char(1),
  org_conventionne char(1),
  nom varchar(50),
  identifiant_national varchar(9),
  prise_en_charge_ame char(1),
  application_mt_mini_pc char(1),
  type_contrat smallint,
  saisie_no_adherent char(1),
  t_destinataire_id varchar(50))
as
declare variable intRegime integer;
begin
  execute procedure ps_renvoyer_id_regime(:code_regime) returning_values :intRegime;

  insert into t_organisme (
    t_organisme_id,
    type_organisme,
    nom_reduit,
    commentaire,
    commentaire_bloquant,
    rue_1,
    rue_2,
    code_postal,
    nom_ville,
    tel_personnel,
    tel_standard,
    tel_mobile,
    fax,
    org_reference,
    mt_seuil_tiers_payant,
    accord_tiers_payant,
    doc_facturation,
    type_releve,
    edition_releve,
    frequence_releve,
    mt_seuil_ed_releve,
    t_ref_regime_id,
    caisse_gestionnaire,
    centre_gestionnaire,
    fin_droits_org_amc,
    org_circonscription,
    org_conventionne,
    nom,
    identifiant_national,
    prise_en_charge_ame,
    application_mt_mini_pc,
    type_contrat,
    saisie_no_adherent,
    t_destinataire_id)
  values (
    :t_organisme_id,
    :type_organisme,
    :nom_reduit,
    :commentaire,
    :commentaire_bloquant,
    :rue_1,
    :rue_2,
    :code_postal,
    :nom_ville,
    :tel_personnel,
    :tel_standard,
    :tel_mobile,
    :fax,
    :org_reference,
    :mt_seuil_tiers_payant,
    :accord_tiers_payant,
    :doc_facturation,
    :type_releve,
    :edition_releve,
    :frequence_releve,
    :mt_seuil_ed_releve,
    :intRegime,
    :caisse_gestionnaire,
    :centre_gestionnaire,
    :fin_droits_org_amc,
    :org_circonscription,
    :org_conventionne,
    :nom,
    :identifiant_national,
    :prise_en_charge_ame,
    :application_mt_mini_pc,
    :type_contrat,
    :saisie_no_adherent,
    :t_destinataire_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_ass_org_amc(
  t_organisme_amo_id varchar(50),
  t_organisme_amc_id varchar(50),
  type_debiteur char(1),
  type_contrat smallint)
as
begin
  insert into t_organisme_amo_ass_amc (
    t_organisme_amo_ass_amc_id,
    t_organisme_amo_id,
    t_organisme_amc_id,
    type_debiteur,
    type_contrat)
  values (
    next value for seq_organisme_amo_ass_amc,
    :t_organisme_amo_id,
    :t_organisme_amc_id,
    :type_debiteur,
    :type_contrat);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_couv_amo(
  t_couverture_amo_id varchar(50),
  t_organisme_amo_id varchar(50),
  ald char(1),
  libelle varchar(50),
  code_couverture char(5),
  nature_assurance smallint,
  justificatif_exo char(1))
as
declare variable intCouvertureRef integer;
begin
  execute procedure ps_renvoyer_id_couv_amo_ref(:code_couverture) returning_values :intCouvertureRef;

  insert into t_couverture_amo (
    t_couverture_amo_id,
    t_organisme_amo_id,
    ald,
    libelle,
    nature_assurance,
    justificatif_exo,
    t_ref_couverture_amo_id)
  values (
    :t_couverture_amo_id,
    :t_organisme_amo_id,
    :ald,
    :libelle,
    :nature_assurance,
    :justificatif_exo,
    :intCouvertureRef);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_couv_amc(
  t_couverture_amc_id varchar(50),
  t_organisme_amc_id varchar(50),
  libelle varchar(60),
  montant_franchise float,
  plafond_prise_en_charge float,
  couverture_cmu char(1),
  formule varchar(3))
as
begin
  insert into t_couverture_amc (
    t_couverture_amc_id,
    t_organisme_amc_id,
    libelle,
    montant_franchise,
    plafond_prise_en_charge,
    couverture_cmu,
  formule)
  values (
    :t_couverture_amc_id,
    :t_organisme_amc_id,
    :libelle,
    :montant_franchise,
    :plafond_prise_en_charge,
    :couverture_cmu,
  :formule);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_taux_pc(
  t_couverture_amc_id varchar(50),
  prestation varchar(3),
  taux float)
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:prestation) returning_values :intPrestation;

  insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                     t_couverture_amc_id,
                                     t_ref_prestation_id,
                                     taux)
  values(next value for seq_taux_prise_en_charge,
         :t_couverture_amc_id,
         :intPrestation,
         :taux);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_client(
  t_client_id varchar(50),
  numero_insee varchar(15),
  nom varchar(30),
  prenom varchar(30),
  nom_jeune_fille varchar(30),
  commentaire_global varchar(200),
  commentaire_global_bloquant char(1),
  commentaire_individuel varchar(200),
  commentaire_individuel_bloquant char(1),
  date_naissance varchar(8),
  qualite varchar(2),
  rang_gemellaire smallint,
  nat_piece_justif_droit char(1),
  date_validite_piece_justif date,
  t_organisme_amo_id varchar(50),
  centre_gestionnaire varchar(4),
  t_organisme_amc_id varchar(50),
  numero_adherent_mutuelle varchar(16),
  t_couverture_amc_id varchar(50),
  debut_droit_amc date,
  attestation_ame_complementaire char(1),
  fin_droit_amc date,
  date_derniere_visite date,
  t_assure_rattache_id varchar(50),
  rue_1 varchar(40),
  rue_2 varchar(40),
  code_postal char(5),
  nom_ville varchar(30),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  fax varchar(20),
  email varchar(50), 
  activite varchar(50),
  date_creation date,
  genre char(1),
  collectivite char(1),
  payeur char(1),
  delai_paiement numeric(3),
  fin_de_mois char(1),
  mode_gestion_amc char(1))
as
begin
  if (collectivite = '0') then
    update or insert into t_client (
      t_client_id,
      numero_insee,
      nom,
      prenom,
      nom_jeune_fille,
      commentaire_global,
      commentaire_global_bloquant,
      commentaire_individuel,
      commentaire_individuel_bloquant,
      date_naissance,
      qualite,
      rang_gemellaire,
      nat_piece_justif_droit,
      date_validite_piece_justif,
      t_organisme_amo_id,
      centre_gestionnaire,
      t_organisme_amc_id,
      numero_adherent_mutuelle,
      t_couverture_amc_id,
      debut_droit_amc,
      attestation_ame_complementaire,
      fin_droit_amc,
      date_derniere_visite,
      t_assure_rattache_id,
      rue_1,
      rue_2,
      code_postal,
      nom_ville,
      tel_personnel,
      tel_standard,
      tel_mobile,
      fax,
      email,
      activite,
      date_creation,
      genre,
      mode_gestion_amc)
    values (
      :t_client_id,
      :numero_insee,
      :nom,
      :prenom,
      :nom_jeune_fille,
      :commentaire_global,
      :commentaire_global_bloquant,
      :commentaire_individuel,
      :commentaire_individuel_bloquant,
      :date_naissance,
      :qualite,
      :rang_gemellaire,
      :nat_piece_justif_droit,
      :date_validite_piece_justif,
      :t_organisme_amo_id,
      :centre_gestionnaire,
      :t_organisme_amc_id,
      :numero_adherent_mutuelle,
      :t_couverture_amc_id,
      :debut_droit_amc,
      :attestation_ame_complementaire,
      :fin_droit_amc,
      :date_derniere_visite,
      :t_assure_rattache_id,
      :rue_1,
      :rue_2,
      :code_postal,
      :nom_ville,
      :tel_personnel,
      :tel_standard,
      :tel_mobile,
      :fax,
      :email,
      :activite,
      :date_creation,
      case
        when :genre in ('F', 'H') then :genre
        else null
      end,
    :mode_gestion_amc);
  else
    insert into t_compte(
      t_compte_id,
      nom,
      activite,
      rue_1,
      rue_2,
      code_postal,
      nom_ville,
      tel_personnel,
      tel_standard,
      tel_mobile,
      fax,
      delai_paiement,
      fin_de_mois,
      collectif,
      payeur)
    values(
      :t_client_id,
      :nom,
      :activite,
      :rue_1,
      :rue_1,
      :code_postal,
      :nom_ville,
      :tel_standard,
      :tel_personnel,
      :tel_mobile,
      :fax,
      :delai_paiement,
      :fin_de_mois,
      '1',
      :payeur);
end;
/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_cpt_cli(
  t_compte_id varchar(50),
  t_client_id varchar(50))
as
begin
  insert into t_compte_client(
    t_compte_client_id,
    t_compte_id,
    t_client_id)
  values(
    next value for seq_compte_client,
    :t_compte_id,
    :t_client_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_mandataire(
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
create or alter procedure ps_importlgpi_creer_couv_client(
  t_client_id varchar(50),
  t_couverture_amo_id varchar(50),
  debut_droit_amo date,
  fin_droit_amo date)
as
begin
  update or insert into t_couverture_amo_client (
    t_couverture_amo_client_id,
    t_client_id,
    t_couverture_amo_id,
    debut_droit_amo,
    fin_droit_amo)
  values (
    next value for seq_couverture_amo_client,
    :t_client_id,
    :t_couverture_amo_id,
    :debut_droit_amo,
    :fin_droit_amo)
  matching(t_client_id, t_couverture_amo_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_commentaire(
  t_commentaire_id varchar(50),
  t_client_id varchar(50),
  contenu varchar(5000),
  est_bloquant char(1),
  est_global char(1)  )
as  
begin
  insert into t_commentaire(t_commentaire_id,
                            t_entite_id,
                            type_entite,
                            commentaire,
                            est_bloquant,
                            est_global)
        values(next value for seq_commentaire,
               :t_client_id,
               '0', -- client 
               :contenu,
               :est_bloquant,
               :est_global) ;
  
end;


/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_fourn_dir(
  t_fournisseur_direct_id varchar(50),
  raison_sociale varchar(50),
  --identifiant_171 varchar(8),
  --numero_appel varchar(20),
  commentaire varchar(200),
  --vitesse_171 char(1),
  mode_transmission char(1),
  rue_1 dm_rue,
  rue_2 dm_rue,
  code_postal char(5),
  nom_ville varchar(30),
  tel_personnel  dm_telephone,
  tel_standard  dm_telephone,
  tel_mobile  dm_telephone,
  numero_fax varchar(20),
  fournisseur_partenaire char(1),
  code_partenaire smallint,
  fax_representant dm_telephone,
  code_sel varchar(20),
  nom varchar(50),
  prenom varchar(50),
  rue_1_representant dm_rue,
  rue_2_representant dm_rue,
  telephone_representant dm_telephone,
  standard_representant dm_telephone,
  mobile_representant dm_telephone,
  fax_representant2 dm_telephone,
  email_representant varchar(50),
  code_postal_representant dm_code_postal,
  nom_ville_representant dm_nom_ville
  )
as
begin
  insert into t_fournisseur_direct (
              t_fournisseur_direct_id,
              raison_sociale,
              --identifiant_171,
              --numero_appel,
              commentaire,
              --vitesse_171,
              mode_transmission,
              rue_1,
              rue_2,
              code_postal,
              nom_ville,
              tel_personnel,
              tel_standard,
              tel_mobile,
              fax,
              fournisseur_partenaire,
              numero_fax,
              code_partenaire,
              code_sel,
              represente_par,
              telephone_representant,
              mobile_representant,
              email_representant)
  values (:t_fournisseur_direct_id,
          :raison_sociale,
          --:identifiant_171,
          --:numero_appel,
          :commentaire,
          --:vitesse_171,
          :mode_transmission,
          :rue_1,
          :rue_2,
          :code_postal,
          :nom_ville,
          :tel_personnel,
          :tel_standard,
          :tel_mobile,
          :numero_fax,
          :fournisseur_partenaire,
          coalesce(:fax_representant,:fax_representant2),
          :code_partenaire,
          :code_sel,
          substring(trim(:nom)||' '||trim(:prenom) from 1 for 50),
          :telephone_representant,
          :mobile_representant,
          :email_representant);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_repartiteur(
  t_repartiteur_id varchar(50),
  raison_sociale varchar(50),
  --identifiant_171 varchar(8),
  --numero_appel varchar(20),
  commentaire varchar(200),
  --vitesse_171 char(1),
  mode_transmission char(1),
  rue_1 varchar(40),
  rue_2 varchar(40),
  code_postal char(5),
  nom_ville varchar(30),
  tel_personnel varchar(20),
  tel_standard varchar(20),
  tel_mobile varchar(20),
  fax varchar(20),
  defaut char(1),
  objectif_ca_mensuel integer,
  monogamme char(1),
  t_reaffectation_manquants_id varchar(50),
  numero_fax varchar(20),
  pharmaml_ref_id smallint,
  pharmaml_url_1 varchar(150),
  pharmaml_url_2 varchar(150),
  pharmaml_id_officine varchar(20),
  pharmaml_id_magasin varchar(20),
  pharmaml_cle varchar(4))
as
begin
  insert into t_repartiteur (
    t_repartiteur_id,
    raison_sociale,
    --identifiant_171,
    --numero_appel,
    commentaire,
    --vitesse_171,
    mode_transmission,
    rue_1,
    rue_2,
    code_postal,
    nom_ville,
    tel_personnel,
    tel_standard,
    tel_mobile,
    fax,
    defaut,
    objectif_ca_mensuel,
    monogamme,
    t_reaffectation_manquants_id,
    numero_fax,
    pharmaml_ref_id,
    pharmaml_url_1,
    pharmaml_url_2,
    pharmaml_id_officine,
    pharmaml_id_magasin,
    pharmaml_cle)
  values (
    :t_repartiteur_id,
    :raison_sociale,
    --:identifiant_171,
    --:numero_appel,
    :commentaire,
    --:vitesse_171,
    :mode_transmission,
    :rue_1,
    :rue_2,
    :code_postal,
    :nom_ville,
    :tel_personnel,
    :tel_standard,
    :tel_mobile,
    :fax,
    :defaut,
    :objectif_ca_mensuel,
    :monogamme,
    :t_reaffectation_manquants_id,
    :numero_fax,
    :pharmaml_ref_id,
    :pharmaml_url_1,
    :pharmaml_url_2,
    :pharmaml_id_officine,
    :pharmaml_id_magasin,
    :pharmaml_cle);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_maj_repartiteur(
  t_repartiteur_id varchar(50),
  t_repartiteur_reaffmqts_id varchar(50))
as
begin
  update t_repartiteur
  set t_reaffectation_manquants_id = :t_repartiteur_reaffmqts_id
  where t_repartiteur_id = :t_repartiteur_id;
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_codif(
  code varchar(50),
  libelle varchar(50),
  rang char(1),
  taux_marque float)
as
begin
  insert into t_codification (
    t_codification_id,
    code,
    libelle,
    rang,
    taux_marque)
  values (
    next value for seq_codification,
    :code,
    :libelle,
    :rang,
    :taux_marque);
end;


/* ********************************************************************************************** */

create or alter procedure ps_importlgpi_creer_depot(
t_depot_id varchar(50),
libelle varchar(50),
gestion_stock_automate char,
type_depot varchar(6))
as
begin
  insert into t_depot(
    t_depot_id,
    libelle,
    automate,
    type_depot)
  values(
    :t_depot_id,
    :libelle,
    :gestion_stock_automate,
    :type_depot);
end;


/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_zone_geo(
  t_zone_geographique_id varchar(50),
  libelle varchar(50),
  gestion_automate varchar(50))
as
begin
  insert into t_zone_geographique (
    t_zone_geographique_id,
    libelle,
    gestion_automate)
  values (
    :t_zone_geographique_id,
    :libelle,
    :gestion_automate);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_produit(
  t_produit_id varchar(50),
  code_cip char(13),
  code_cip7 char(7),
  designation varchar(50),
  prix_achat_catalogue float,
  prix_vente float,
  base_remboursement float,
  etat char(1),
  delai_viande smallint,
  delai_lait smallint,
  gere_interessement char(1),
  commentaire_vente varchar(200),
  commentaire_commande varchar(200),
  commentaire_gestion varchar(200),
  prestation varchar(3),
  gere_suivi_client char(1),
  TVA float,
  liste char(1),
  tracabilite char(1),
  lot_achat integer,
  lot_vente integer,
  stock_mini integer,
  stock_maxi integer,
  pamp float,
  tarif_achat_unique char(1),
  profil_gs char(1),
  calcul_gs char(1),
  nombre_mois_calcul smallint,
  gere_pfc char(1),
  soumis_mdl char(1),
  conditionnement smallint,
  moyenne_vente float,
  unite_moyenne_vente integer,
  date_derniere_vente date,
  contenance integer,
  unite_mesure char(1),
  prix_achat_remise float,
  veterinaire char(1),
  service_tips char(1),
  type_homeo char(1),
  t_repartiteur_id varchar(50),
  t_codif_1_id integer,
  t_codif_2_id integer,
  t_codif_3_id integer,
  t_codif_4_id integer,
  t_codif_5_id integer,
  t_codif_6_id integer,
  date_peremption date,
  t_produit_bdm_id varchar(50),
  t_package_bdm_id varchar(50))
as
declare variable intPrestation integer;
declare variable intTVA integer;
declare variable intCodif1 integer;
declare variable intCodif2 integer;
declare variable intCodif3 integer;
declare variable intCodif4 integer;
declare variable intCodif5 integer;
declare variable intCodif6 integer;
declare variable c integer;
begin
  execute procedure ps_renvoyer_id_prestation(:prestation) returning_values :intPrestation;
  execute procedure ps_renvoyer_id_tva(:tva) returning_values :intTVA;
  execute procedure ps_renvoyer_id_codification('1', :t_codif_1_id) returning_values :intCodif1;
  execute procedure ps_renvoyer_id_codification('2', :t_codif_2_id) returning_values :intCodif2;
  execute procedure ps_renvoyer_id_codification('3', :t_codif_3_id) returning_values :intCodif3;
  execute procedure ps_renvoyer_id_codification('4', :t_codif_4_id) returning_values :intCodif4;
  execute procedure ps_renvoyer_id_codification('5', :t_codif_5_id) returning_values :intCodif5;
  execute procedure ps_renvoyer_id_codification('6', :t_codif_6_id) returning_values :intCodif6;

  insert into t_produit(t_produit_id,
                        code_cip,
                        code_cip7,
                        designation,
                        prix_achat_catalogue,
                        prix_vente,
                        base_remboursement,
                        etat,
                        delai_viande,
                        delai_lait,
                        gere_interessement,
                        commentaire_vente,
                        commentaire_commande,
                        commentaire_gestion,
                        t_ref_prestation_id,
                        gere_suivi_client,
                        t_ref_tva_id,
                        liste,
                        tracabilite,
                        lot_achat,
                        lot_vente,
                        stock_mini,
                        stock_maxi,
                        pamp,
                        tarif_achat_unique,
                        profil_gs,
                        calcul_gs,
                        nombre_mois_calcul,
                        gere_pfc,
                        soumis_mdl,
                        conditionnement,
                        moyenne_vente,
                        unite_moyenne_vente,
                        date_derniere_vente,
                        contenance,
                        unite_mesure,
                        prix_achat_remise,
                        veterinaire,
                        service_tips,
                        type_homeo,
                        t_repartiteur_id,
                        t_codif_1_id,
                        t_codif_2_id,
                        t_codif_3_id,
                        t_codif_4_id,
                        t_codif_5_id,
                        t_codif_6_id,
                        date_peremption,
                        t_produit_bdm_id,
                        t_package_bdm_id
                        )
  values (:t_produit_id,
          :code_cip,
          :code_cip7,
          :designation,
          :prix_achat_catalogue,
          :prix_vente,
          :base_remboursement,
          :etat,
          :delai_viande,
          :delai_lait,
          :gere_interessement,
          :commentaire_vente,
          :commentaire_commande,
          :commentaire_gestion,
          :intPrestation,
          :gere_suivi_client,
          :intTVA,
          :liste,
          :tracabilite,
          :lot_achat,
          :lot_vente,
          :stock_mini,
          :stock_maxi,
          :pamp,
          :tarif_achat_unique,
          :profil_gs,
          :calcul_gs,
          :nombre_mois_calcul,
          :gere_pfc,
          :soumis_mdl,
          :conditionnement,
          :moyenne_vente,
          :unite_moyenne_vente,
          :date_derniere_vente,
          :contenance,
          :unite_mesure,
          :prix_achat_remise,
          :veterinaire,
          :service_tips,
          :type_homeo,
          :t_repartiteur_id,
          :intCodif1,
          :intCodif2,
          :intCodif3,
          :intCodif4,
          :intCodif5,
          :intCodif6,
          :date_peremption,
          :t_produit_bdm_id,
          :t_package_bdm_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_info_stock(
  t_produit_id varchar(50),
  t_zone_geographique_id varchar(50),
  quantite integer,
  priorite char(1),
  stock_mini integer,
  stock_maxi integer,
  t_depot_id integer)
as
begin

  insert into t_produit_geographique (t_produit_geographique_id,
                                      t_produit_id,
                                      t_zone_geographique_id,
                                      quantite,
                                      t_depot_id,
                                      stock_mini,
                                      stock_maxi)
  values (next value for seq_produit_geographique,
          :t_produit_id,
          :t_zone_geographique_id,
          :quantite,
          :t_depot_id,
          :stock_mini,
          :stock_maxi);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_code_ean13(
  t_produit_id varchar(50),
  code_ean13 varchar(13),
  referent dm_boolean)
as
begin
  insert into t_code_ean13 (t_code_ean13_id,
                            t_produit_id,
                            code_ean13,
                            referent)
  values (next value for seq_code_ean13,
          :t_produit_id,
          :code_ean13,
          :referent);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_code_lpp(
  t_produit_id varchar(50),
  type_code char(1),
  code_lpp varchar(13),
  quantite integer,
  tarif_unitaire float,
  prestation varchar(3),
  service_tips char(1))
as
declare variable intPrestation integer;
begin
  execute procedure ps_renvoyer_id_prestation(:prestation) returning_values :intPrestation;

  insert into t_produit_lpp (
    t_produit_lpp_id,
    t_produit_id,
    type_code,
    code_lpp,
    quantite,
    tarif_unitaire,
    t_ref_prestation_id,
    service_tips)
  values (
    next value for seq_produit_lpp,
    :t_produit_id,
    :type_code,
    :code_lpp,
    :quantite,
    :tarif_unitaire,
    :intPrestation,
    :service_tips);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_histo_vente(
  t_produit_id varchar(50),
  periode varchar(6),
  quantite_actes integer,
  quantite_vendues integer)
as
begin
  insert into t_historique_vente (
    t_historique_vente_id,
    t_produit_id,
    periode,
    quantite_actes,
    quantite_vendues)
  values (
    next value for seq_historique_vente,
    :t_produit_id,
    :periode,
    :quantite_actes,
    :quantite_vendues);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_tarif(
  t_tarif_id integer,
  t_produit_id varchar(50),
  t_fournisseur_direct_id varchar(50),
  prix_achat float,
  remise float,
  prix_achat_remise float)
as
declare variable strRS varchar(50);
declare variable intDernierNoLigne numeric(5);
begin
  if (not(exists(select *
                 from t_catalogue
                 where t_fournisseur_id = :t_fournisseur_direct_id))) then
  begin
    select raison_sociale
    from t_fournisseur_direct
    where t_fournisseur_direct_id = :t_fournisseur_direct_id
    into :strRS;

    insert into t_catalogue (
      t_catalogue_id,
      designation,
      date_debut,
      date_fin,
      t_fournisseur_id,
      date_creation,
      date_fin_validite)
    values (
      :t_fournisseur_direct_id,
      'Catalogue ' || :strRS,
      current_date,
      null,
      :t_fournisseur_direct_id,
      current_date,
      null);
  end

  select coalesce(max(no_ligne) + 1, 1)
  from t_catalogue_ligne
  where t_catalogue_id = :t_fournisseur_direct_id
  into :intDernierNoLigne;

  insert into t_catalogue_ligne(t_catalogue_ligne_id,
                                t_catalogue_id,
                                t_classification_fournisseur_id,
                                no_ligne,
                                t_produit_id,
                                prix_achat_catalogue,
                                prix_achat_remise,
                                remise_simple,
                                date_maj_tarif,
                                date_creation)
  values(next value for seq_catalogue_ligne,
         :t_fournisseur_direct_id,
         null,
         :intDernierNoLigne,
         :t_produit_id,
         :prix_achat,
         :prix_achat_remise,
         :remise,
         current_date,
         current_date);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_catalogue(
  t_catalogue_id integer,
  designation varchar(50),
  date_debut date,
  date_fin date,
  t_fournisseur_id varchar(50),
  date_creation date,
  date_fin_validite date)
as
begin
  insert into t_catalogue (
    t_catalogue_id,
    designation,
    date_debut,
    date_fin,
    t_fournisseur_id,
    date_creation,
    date_fin_validite)
  values (
    :t_catalogue_id,
    :designation,
    :date_debut,
    :date_fin,
    :t_fournisseur_id,
    :date_creation,
    :date_fin_validite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_cl_four(
  t_classif_fournisseur_id integer,
  designation varchar(50),
  date_deb_marche date,
  duree_marche smallint,
  t_classif_parent_id varchar(50),
  t_catalogue_id integer)
as
begin
  insert into t_classification_fournisseur(t_classification_fournisseur_id,
                                           designation,
                                           date_debut_marche,
                                           duree_marche,
                                           t_classification_parent_id,
                                           t_catalogue_id)
  values(:t_classif_fournisseur_id,
         :designation,
         :date_deb_marche,
         :duree_marche,
         :t_classif_parent_id,
         :t_catalogue_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_cl_int(
  t_classif_interne_id integer,
  libelle varchar(50),
  taux_marque float,
  t_classif_parent_id varchar(50))
as
begin
  insert into t_classification_interne( t_classification_interne_id,
                                        libelle,
                                        taux_marque,
                                        t_class_interne_parent_id)
  values(:t_classif_interne_id,
         :libelle,
         :taux_marque,
         :t_classif_parent_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_lig_catal(
  t_catalogue_id integer,
  t_gamme_id varchar(50),
  no_ligne smallint,
  t_produit_id integer,
  prixachatcatalogue float,
  prixachatremise float,
  remisesimple float,
  date_maj_tarif date,
  date_creation date,
  colisage integer)
as
begin
  insert into t_catalogue_ligne(t_catalogue_ligne_id,
                                t_catalogue_id,
                                t_classification_fournisseur_id,
                                no_ligne,
                                t_produit_id,
                                prix_achat_catalogue,
                                prix_achat_remise,
                                remise_simple,
                                date_maj_tarif,
                                date_creation,
                                colisage)
  values(next value for seq_catalogue_ligne,
         :t_catalogue_id,
         :t_gamme_id,
         :no_ligne,
         :t_produit_id,
         :prixachatcatalogue,
         :prixachatremise,
         :remisesimple,
         :date_maj_tarif,
         :date_creation,
         :colisage);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_commande(
  t_commande_id varchar(50),
  date_creation date,
  mode_transmission char(1),
  montant_ht float,
  t_fournisseur_direct_id varchar(50),
  t_repartiteur_id varchar(50),
  etat varchar(2),
  date_reception date)
as
declare chTypeCommande char(1);
begin
  chTypeCommande = iif(t_fournisseur_direct_id is not null, '1', '2');

  insert into t_commande (
    t_commande_id,
    type_commande,
    date_creation,
    mode_transmission,
    montant_ht,
    t_fournisseur_direct_id,
    t_repartiteur_id,
    etat,
    date_reception)
  values (
    :t_commande_id,
    :chTypeCommande,
    :date_creation,
    :mode_transmission,
    :montant_ht,
    :t_fournisseur_direct_id,
    :t_repartiteur_id,
    :etat,
    :date_reception);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_cmd_lig(
  t_commande_id varchar(50),
  t_produit_id varchar(50),
  quantite_commandee integer,
  quantite_recue integer,
  quantite_totale_recue integer,
  prix_achat_tarif float,
  prix_achat_remise float,
  prix_vente float,
  reception_financiere char(1),
  choix_reliquat char(1),
  unites_gratuites integer)
as
begin
  insert into t_commande_ligne (
    t_commande_ligne_id,
    t_commande_id,
    t_produit_id,
    quantite_commandee,
    quantite_recue,
    quantite_totale_recue,
    prix_achat_tarif,
    prix_achat_remise,
    prix_vente,
    reception_financiere,
    choix_reliquat,
    unites_gratuites)
  values (
    next value for seq_commande_ligne,
    :t_commande_id,
    :t_produit_id,
    :quantite_commandee,
    :quantite_recue,
    :quantite_totale_recue,
    :prix_achat_tarif,
    :prix_achat_remise,
    :prix_vente,
    :reception_financiere,
    :choix_reliquat,
    :unites_gratuites);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_operateur(
  t_operateur_id varchar(50),
  code_operateur varchar(10),
  nom varchar(50),
  prenom varchar(50),
  mot_de_passe varchar(50),
  activation_operateur char(1),
  gravite_int char(1))
as
begin
  insert into t_operateur (
    t_operateur_id,
    code_operateur,
    nom,
    prenom,
    mot_de_passe,
    activation_operateur,
    gravite_int,
    recherche_int)
  values (
    :t_operateur_id,
    :code_operateur,
    :nom,
    :prenom,
    :mot_de_passe,
    :activation_operateur,
    :gravite_int,
    '1');
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_histo_cli(
  t_historique_client_id varchar(50),
  t_client_id varchar(50),
  numero_facture numeric(10),
  date_prescription date,
  code_operateur varchar(10),
  t_praticien_id varchar(50),
  nom_praticien varchar(50),
  prenom_praticien varchar(50),
  type_facturation varchar(2),
  date_acte date)
as
begin
  insert into t_historique_client (
    t_historique_client_id,
    t_client_id,
    numero_facture,
    date_prescription,
    code_operateur,
    t_praticien_id,
    nom_praticien,
    prenom_praticien,
    type_facturation,
    date_acte)
  values (
    :t_historique_client_id,
    :t_client_id,
    :numero_facture,
    :date_prescription,
    :code_operateur,
    :t_praticien_id,
    :nom_praticien,
    :prenom_praticien,
    :type_facturation,
    :date_acte);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_his_cli_lig(
  t_historique_client_ligne_id varchar(50),
  t_historique_client_id varchar(50),
  code_cip char(13),
  designation varchar(50),
  quantite_facturee integer,
  prix_vente float)
as
begin
  insert into t_historique_client_ligne (
    t_historique_client_ligne_id,
    t_historique_client_id,
    code_cip,
    designation,
    quantite_facturee,
    prix_vente)
  values (
    next value for seq_historique_client_ligne,
    :t_historique_client_id,
    :code_cip,
    :designation,
    :quantite_facturee,
    :prix_vente);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_credit(
  t_client_id varchar(50),
  date_credit date,
  montant float)
as
declare variable intClient integer;
declare variable intCompte integer;
begin
  if (exists(select *
             from t_client
             where t_client_id = :t_client_id)) then
  begin
    if (exists(select *
               from t_credit
               where t_client_id = :t_client_id)) then
      update t_credit
      set montant = montant + :montant
      where t_client_id = :t_client_id;
    else
      insert into t_credit(t_credit_id,
                           t_client_id,
                           montant,
                           date_credit)
      values(:t_client_id,
             :t_client_id,
             :montant,
             :date_credit);
  end
  else
  begin
    if (exists(select *
               from t_credit
               where t_compte_id = :t_client_id)) then
      update t_credit
      set montant = montant + :montant
      where t_compte_id = :t_client_id;
    else
      insert into t_credit(t_credit_id,
                           t_compte_id,
                           montant,
                           date_credit)
      values(:t_client_id,
             :t_client_id,
             :montant,
             :date_credit);
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_fac_att(
  t_facture_attente_id varchar(50),
  date_acte date,
  t_client_id varchar(50))
as
begin
  insert into t_facture_attente (
    t_facture_attente_id,
    date_acte,
    t_client_id)
  values (
    :t_facture_attente_id,
    :date_acte,
    :t_client_id);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_fac_att_lig(
  t_facture_attente_id varchar(50),
  t_produit_id varchar(50),
  quantite_facturee integer,
  t_ref_prestation_id integer,
  prix_vente float,
  prix_achat float)
as
begin
  insert into t_facture_attente_ligne (
    t_facture_attente_ligne_id,
    t_facture_attente_id,
    t_produit_id,
    quantite_facturee,
    t_ref_prestation_id,
    prix_vente,
    prix_achat)
  values (
    next value for seq_facture_attente_ligne,
    :t_facture_attente_id,
    :t_produit_id,
    :quantite_facturee,
    :t_ref_prestation_id,
    :prix_vente,
    :prix_achat);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_vign_av(
  t_client_id varchar(50),
  date_avance date,
  code_cip char(13),
  designation varchar(50),
  prix_vente float,
  prix_achat float,
  code_prestation varchar(3),
  t_produit_id varchar(50),
  t_operateur_id varchar(10),
  quantite_avancee integer,
  base_remboursement float)
as
begin
  insert into t_vignette_avancee (
    t_vignette_avancee_id,
    t_client_id,
    date_avance,
    code_cip,
    designation,
    prix_vente,
    prix_achat,
    code_prestation,
    t_produit_id,
    t_operateur_id,
    quantite_avancee,
    base_remboursement)
  values (
    next value for seq_vignette_avancee,
    :t_client_id,
    :date_avance,
    :code_cip,
    :designation,
    :prix_vente,
    :prix_achat,
    :code_prestation,
    :t_produit_id,
    :t_operateur_id,
    :quantite_avancee,
    :base_remboursement);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_produit_du(
  t_client_id varchar(50),
  date_du date,
  t_produit_id varchar(50),
  quantite integer)
as
begin
  insert into t_produit_du (
    t_produit_du_id,
    t_client_id,
    date_du,
    t_produit_id,
    quantite)
  values (
    next value for seq_produit_du,
    :t_client_id,
    :date_du,
    :t_produit_id,
    :quantite);
end;

/* ********************************************************************************************** */
create or alter procedure ps_importlgpi_creer_doc(
  id_doc integer, 
  num_page integer,
  id_entity integer,
  content_type integer,
  muse_path varchar(255),
  document varchar(255),
  commentaire varchar(200))
as
begin
  insert into t_document(t_document_id,
                         type_entite,
                         t_entite_id,
                         content_type,
                         libelle,
                         document, 
                         commentaire)
  values(next value for seq_document,
         2, --doc client
         :id_entity,
         :content_type,
         :id_doc,
         :document, 
         :commentaire);
end;