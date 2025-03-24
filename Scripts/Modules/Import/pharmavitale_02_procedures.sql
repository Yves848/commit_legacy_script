set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_medecin(
  index_medecin integer,
  nom varchar(50),
  prenom varchar(30),
  finess varchar(10), 
  rpps varchar(11),
  index_specialite integer,
  adresse varchar(100),
  adresse2 varchar(100),
  codepostal varchar(5),
  ville varchar(50),
  telephone varchar(14),
  fax varchar(14),
  commentaire varchar(5000))
as
declare variable intSpecialite integer;

begin
  execute procedure ps_renvoyer_id_specialite(:index_specialite) returning_values :intSpecialite;
  execute procedure ps_filtrer_numerique(:finess) returning_values :finess;
  
  insert into t_praticien(t_praticien_id,
                          type_praticien,
                          nom,
                          prenom,
                          rue_1,
                          rue_2,
                          code_postal,
                          nom_ville,
                          tel_standard,
                          fax,
                          t_ref_specialite_id,
                          no_finess,
                          num_rpps)
  values(:index_medecin,
         '1',
         :nom,
         :prenom,
         substring(:adresse from 1 for 40),
         substring(:adresse2 from 1 for 40),
         substring(:codepostal from 1 for 5),
         substring(:ville from 1 for 30),
         substring(:telephone from 1 for 20),
         substring(:fax from 1 for 20),
         :intSpecialite,
         substring(:finess from 1 for 9),
         substring(:rpps from 1 for 11));
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_dest(
nom varchar(255),
adresse_mail varchar(255),
adresse_mail_ccent varchar(255),
serveur_pop varchar(255),
serveur_smtp varchar(255),
login_pop varchar(255),
mdp_pop varchar(255),
login_smtp varchar(255),
mdp_smtp varchar(255),
app varchar(255),
delai varchar(255))
as
begin
   insert into t_destinataire(t_destinataire_id,
                              nom,
                              application_oct,
                              tempo,
                              adresse_bal,
                              utilisateur_pop3,
                              mot_passe_pop3,
                              serv_pop3,
                              serv_smtp,
                              nom_util,
                              mot_passe)
   values('1',
          :nom,
          :app,
          iif(trim(:delai) = '', 0, :delai),
          :adresse_mail,
          :login_pop,
          :mdp_pop,
          :serveur_pop,
          :serveur_smtp,
          :login_smtp,
          :mdp_smtp);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_organisme(
  index_centre integer,
  regime varchar(2),
  caissegestion varchar(4),
  centregestion varchar(4),
  nom varchar(30),
  code_centre varchar(20),
  adresse varchar(100),
  adresse2 varchar(100),
  ville varchar(50),
  codepostal varchar(5),
  telephone varchar(14),
  fax varchar(14))
as
declare variable intRegime integer;
begin
   execute procedure ps_renvoyer_id_regime(:regime) returning_values :intRegime;

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
                           centre_gestionnaire)
   values(1,
          'AMO_' || :index_centre,
          iif(:nom = '', :code_centre, :nom),
          :code_centre,
          substring(:adresse from 1 for 40),
          substring(:adresse2 from 1 for 40),
          :codepostal,
          substring(:ville from 1 for 30),
          :telephone,
          :fax,
          :intRegime,
          substring(:caissegestion from 1 for 3),
          :centregestion);
end;

/* ********************************************************************************************** */
create or alter procedure ps_separer_valeurs(
  AValeurs varchar(5000),
  ASeparateur varchar(20))
returns(
  AValeur varchar(5000))
as
declare variable p integer;
declare variable s varchar(5000);
begin
  s = AValeurs;
  p = position(ASeparateur in s);
  while (p > 0) do
  begin
    AValeur = substring(s from 1 for p - 1);
    suspend;

    s = substring(s from p + char_length(ASeparateur) for char_length(s));
    p = position(ASeparateur in s);
  end

  AValeur = s;
  suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_gr_mut(
  index_mutuelle integer,
  index_grillemutuelle integer,
  intitule varchar(50),
  detail_remb varchar(5000))
as
declare variable i integer;
declare variable s1 varchar(5000);
declare variable s2 varchar(5000);
declare variable strCouverture varchar(50);
declare variable intPrestation integer;
declare variable intTaux numeric(10,2);
begin
  strCouverture = 'AMC_' || :index_mutuelle || '_' || :index_grillemutuelle;
  insert into t_couverture_amc(t_couverture_amc_id,
                               t_organisme_amc_id,
                               libelle,
                               montant_franchise,
                               plafond_prise_en_charge,
                               formule,
                               couverture_cmu)
  values(:strCouverture,
         'AMC_' ||:index_mutuelle,
         :intitule,
         0,
         0,
         '021',
         '0');

  i = 0;
  for select AValeur from ps_separer_valeurs(:detail_remb, ';') into :s1 do
  begin
    if (mod(i, 2) = 0) then
      intTaux = s1;
    else
      for select AValeur from ps_separer_valeurs(:s1, ',') into :s2 do
      begin
        execute procedure ps_renvoyer_id_prestation(:s2) returning_values :intPrestation;
        insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                           t_couverture_amc_id,
                                           t_ref_prestation_id,
                                           taux)
        values(next value for seq_taux_prise_en_charge,
               :strCouverture,
               :intPrestation,
               :intTaux);

        when any do
        begin

        end
      end
    i = i + 1;
  end
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_mutuelle(
  index_mutuelle integer,
  code_mutuelle varchar(20),
  nom varchar(50),
  adresse varchar(100),
  adresse2 varchar(100),
  codepostal varchar(5),
  ville varchar(100),
  telephone varchar(14),
  fax varchar(14),
  commentaire varchar(255),
  codevitale varchar(20),
  codeteletrans varchar(10),
  index_grillemutuelle integer,
  typecontrat smallint,
  cmu char(1),
  ame char(1))
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
                           type_contrat,
                           prise_en_charge_ame)
   values(2,
          'AMC_' || :index_mutuelle,
          iif((:nom is null) or (:nom = ''), :index_mutuelle, :nom),
          :code_mutuelle,
          substring(:adresse from 1 for 40),
          substring(:adresse2 from 1 for 40),
          substring(:codepostal from 1 for 5),
          substring(:ville from 1 for 30),
          substring(:telephone from 1 for 20),
          substring(:fax from 1 for 20),
          iif(:codevitale <> '', substring(:codevitale from 1 for 9), substring(:codeteletrans from 3 for 9)),
          coalesce(:typecontrat, 0),
          :ame);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_assure(
  nom varchar(50),
  prenom varchar(30),
  noss varchar(13),
  cless varchar(2),
  datenaissance varchar(10),
  adresse varchar(100),
  adresse2 varchar(100),
  codepostal varchar(5),
  ville varchar(50),
  datevalid_mutuelle date,
  noadherent varchar(20),
  nocetip varchar(20),
  date_situation varchar(50),
  codeALD varchar(1),
  telephone varchar(14),
  rang varchar(1),
  regime varchar(2),
  index_qualite smallint,
  index_centre integer,
  index_mutuelle integer,
  fax varchar(14),
  commentaire varchar(5000),
  noteauto varchar(5000),
  DerniereVisite date,
  datedeb_mutuelle date,
  portable varchar(14),
  sexe varchar(1),
  code_situation varchar(255),
  index_assure integer,
  centregestion varchar(4),
  index_grillemutuelle integer)
as
declare variable c char(1);
declare variable strOrganismeAMO varchar(50);
declare variable strCouvertureAMO varchar(50);
declare variable strOrganismeAMC varchar(50);
declare variable i integer;
declare variable s varchar(5000);
declare variable d date;
declare variable intCouvertureAMORef integer;
declare variable dtDebutDroitAMO date;
declare variable dtFinDroitAMO date;
declare variable strNSS varchar(15);
begin
  if (noss = '') then
    strNSS = null;
  else
    strNSS = :noss || lpad(:cless, 2, '0');
    
  strOrganismeAMO = iif(index_centre = 0, null, 'AMO_' || :index_centre);

  select sans_centre_gestionnaire
  from t_ref_regime
  where code = :regime
  into :c;

  if (row_count = 0) then
    c = null;

  strOrganismeAMC = iif(index_mutuelle = 0, null, 'AMC_' || :index_mutuelle);

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
                       qualite,
                       rang_gemellaire,
                       date_naissance,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       t_organisme_amc_id,
                       t_couverture_amc_id,
                       numero_adherent_mutuelle,
                       debut_droit_amc,
                       fin_droit_amc,
                       genre,
                       date_derniere_visite)
  values(:index_assure,
         :strNSS,
         substring(:nom from 1 for 30),
         :prenom,
         substring(:adresse from 1 for 40),
         substring(:adresse2 from 1 for 40),
         :codepostal,
         substring(:ville from 1 for 30),
         :telephone,
         :portable,
         :fax,
         :index_qualite,
         iif(:rang = '', null, :rang),
         replace(:datenaissance, '/', ''),
         :strOrganismeAMO,
         iif(:c = 1, :centregestion, null),
         :strOrganismeAMC,
         :strOrganismeAMC || '_' || :index_grillemutuelle,
         substring(:noadherent from 1 for 16),
         :datedeb_mutuelle,
         :datevalid_mutuelle,
         case
           when :sexe = 'M' then 'H'
           else 'F'
         end,
         :DerniereVisite);

    if ( commentaire >'' ) then
      insert into t_commentaire (t_commentaire_id,
                                   t_entite_id,
                                   type_entite,
                                   commentaire,
                                   est_global )
      values ( next value for seq_commentaire,
                 :index_assure,
                 '0', -- client 
                  cast(:commentaire as blob),
                  0 );

    if ( noteauto >'' ) then
      insert into t_commentaire (t_commentaire_id,
                                   t_entite_id,
                                   type_entite,
                                   commentaire,
                                   est_global,
                                   est_bloquant )
      values ( next value for seq_commentaire,
                 :index_assure,
                 '0', -- client 
                  cast(:noteauto as blob),
                  0,
                  1 );

  if ((code_situation <> '') and (strOrganismeAMO is not null)) then
  begin
    i = 0;
    for select upper(trim(AValeur)) from ps_separer_valeurs(:code_situation, ',') into :s do
    begin
      if (mod(i, 2) = 0) then
      begin
        strCouvertureAMO = strOrganismeAMO || '_' || s;
        if (not(exists(select *
                       from t_couverture_amo
                       where t_couverture_amo_id = :strCouvertureAMO))) then
        begin
          if (char_length(s) <> 5) then
            s = '0' || s;

          execute procedure ps_renvoyer_id_couv_amo_ref(:s) returning_values :intCouvertureAMORef;
          insert into t_couverture_amo(t_couverture_amo_id,
                                       t_organisme_amo_id,
                                       ald,
                                       libelle,
                                       t_ref_couverture_amo_id)
          values(:strCouvertureAMO,
                 :strOrganismeAMO,
                 iif(:s = 'ALD', '1', '0'),
                 :s,
                 :intCouvertureAMORef);
        end
      end
      else
      begin
        if (upper(s) = 'DROITS OUVERTS') then
        begin
          dtDebutDroitAMO = cast(extract(year from current_date) || '/01/01' as date);
          dtFinDroitAMO = null;
        end
        else
        begin
          dtDebutDroitAMO = null;
          dtFinDroitAMO = cast(substring(s from 7 for 4) || '/' ||
                               substring(s from 4 for 2) || '/' ||
                               substring(s from 1 for 2) as date);
        when sqlcode -413 do
          dtFinDroitAMO = cast('20' || substring(s from 5 for 2) || '/' ||
                               substring(s from 3 for 2) || '/' ||
                               substring(s from 1 for 2) as date);
        end

        select fin_droit_amo
        from t_couverture_amo_client
        where t_client_id = :index_assure
          and t_couverture_amo_id = :strCouvertureAMO
        into :d;

        if (row_count = 0) then
          insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                              t_client_id,
                                              t_couverture_amo_id,
                                              debut_droit_amo,
                                              fin_droit_amo)
          values(next value for seq_couverture_amo_client,
                 :index_assure,
                 :strCouvertureAMO,
                 :dtDebutDroitAMO,
                 :dtFinDroitAMO);
        else
          if (((d is not null) and (d < :dtFinDroitAMO)) or (dtFinDroitAMO is null)) then
            update t_couverture_amo_client
            set fin_droit_amo = :dtFinDroitAMO
            where t_client_id = :index_assure
              and t_couverture_amo_id = :strCouvertureAMO;
      end
      i = i + 1;
    end
  end
end;


/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_categ(
  code_categorie varchar(6),
  libelle_categorie varchar(127))
as
begin
  insert into t_codification(t_codification_id,
                             code,
                             libelle,
                             rang)
  values(next value for seq_codification,
         :code_categorie,
         substring(:libelle_categorie from 1 for 50),
         1);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_code_geo(
  code_geo smallint,
  libelle_geo varchar(30))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
                                  libelle)
  values(:code_geo,
         :code_geo || ' - ' || :libelle_geo);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_fourn(
  code_fournisseur integer,
  nom_fournisseur varchar(40),
  adresse1 varchar(100),
  adresse2 varchar(100),
  codePostal varchar(10),
  ville varchar(50),
  telephone varchar(20),
  fax varchar(20),
  siteweb varchar(5000),
  direct char(1),
  commentaire varchar(5000),
  idfourn_fpml varchar(30),
  codfourn_fpml varchar(30),
  adrurl_fpml varchar(200),
  adrurlsec_fpml varchar(200),
  nocli_fpml varchar(30),
  clefcli_fpml varchar(30),
  adrenv_fpml varchar(50))
as
begin
  if (direct = '1') then
    insert into t_fournisseur_direct(t_fournisseur_direct_id,
                                     raison_sociale,
                                     rue_1,
                                     rue_2,
                                     code_postal,
                                     nom_ville,
                                     tel_standard,
                                     fax)
    values(:code_fournisseur,
           substring(:nom_fournisseur from 1 for 50),
           substring(:adresse1 from 1 for 40),
           substring(:adresse2 from 1 for 40),
           substring(:codePostal from 1 for 5),
           substring(:ville from 1 for 30),
           :telephone,
           :fax);
  else
    insert into t_repartiteur(t_repartiteur_id,
                              raison_sociale,
                              rue_1,
                              rue_2,
                              code_postal,
                              nom_ville,
                              tel_standard,
                              fax,
                              pharmaml_ref_id,
                              pharmaml_url_1,
                              pharmaml_url_2,
                              pharmaml_id_officine,
                              pharmaml_id_magasin,
                              pharmaml_cle)
    values(:code_fournisseur,
           substring(:nom_fournisseur from 1 for 50),
           substring(:adresse1 from 1 for 40),
           substring(:adresse2 from 1 for 40),
           substring(:codePostal from 1 for 5),
           substring(:ville from 1 for 30),
           :telephone,
           :fax,
           substring(:codfourn_fpml from 1 for 3),
           substring(:adrurl_fpml from 1 for 150),
           substring(:adrurlsec_fpml from 1 for 150),
           substring(:nocli_fpml from 1 for 20),
           substring(:adrenv_fpml from 1 for 20),
           substring(:clefcli_fpml from 1 for 4));
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_stock(
  AProduitID varchar(10),
  AZoneGeographiqueID smallint,
  AQuantite smallint,
  APriorite char(1))
returns(
  AProduitGeographiqueID integer)
as
begin
  if (AQuantite >= 0) then
    insert into t_produit_geographique(t_produit_geographique_id,
                                      t_produit_id,
                                      quantite,
                                      t_zone_geographique_id,
                                      t_depot_id)
    values(next value for seq_produit_geographique,
           :AProduitID,
           :AQuantite,
           :AZoneGeographiqueID,
           iif(:APriorite = '1', '1', '2'))
    returning t_produit_geographique_id into :AProduitGeographiqueID;
end;

create or alter procedure ps_pharmavitale_creer_produit(
  code_uv varchar(10),
  nom_prod varchar(45),
  cip varchar(7),
  cip13 varchar(13),
  liste varchar(1),
  libelle_tva varchar(5),
  base float,
  prix_ttc float,
  code_acte varchar(3),
  ean varchar(13),
  prix_ht float,
  code_categorie varchar(6),
  commentaire varchar(255),
  code_geo smallint,
  code_lpp varchar(127),
  commentaire2 varchar(255),
  delai_lait integer,
  delai_viande integer,
  delai_oeuf integer,
  code_georeserve smallint,
  code_fournisseur integer,
  nb_stock integer,
  mini_stock smallint,
  maxi_stock smallint,
  dernprixd_stock integer,
  dernprixg_stock integer,
  datedernvente_stock varchar(10),
  stock_robot smallint,
  grosexclu_stock integer,
  stock_minirobot integer,
  minirayon_stock integer,
  maxirayon_stock integer,
  flreserve_stock char(1),
  nbstock_rayon smallint,
  geststock char(1),
  gestreser char(1),
  gestrobot char(1))
as
declare variable intTVA integer;
declare variable intPrestation integer;
declare variable intCategorie integer;
declare variable intProduitGEO integer;
declare variable strDateDerniereVente date;
begin
  execute procedure ps_renvoyer_id_prestation(:code_acte) returning_values :intPrestation;
  execute procedure ps_renvoyer_id_tva(replace(:libelle_tva, ',', '.')) returning_values :intTVA;
  execute procedure ps_renvoyer_id_codification('1', :code_categorie) returning_values intCategorie;

  if (position('/' in datedernvente_stock) > 1) then
    strDateDerniereVente = substring(datedernvente_stock from 7 for 4) || '/' || substring(datedernvente_stock from 4 for 2) || '/' || substring(datedernvente_stock from 1 for 2);
  else
    strDateDerniereVente = substring(datedernvente_stock from 1 for 4) || '/' || substring(datedernvente_stock from 5 for 2) || '/' || substring(datedernvente_stock from 7 for 2);

  -- Produit
  insert into t_produit(t_produit_id,
                        designation,
                        code_cip,
                        liste,
                        t_ref_tva_id,
                        base_remboursement,
                        prix_vente,
                        t_ref_prestation_id,
                        prix_achat_catalogue,
                        t_codif_1_id,
                        commentaire_gestion,
                        delai_lait,
                        delai_viande,
                        --t_codif_6_id,
                        date_derniere_vente,
                        t_repartiteur_id)
   values(:code_uv,
          :nom_prod,
          :cip13,
          case
            when :liste = '1' then '1'
            when :liste = '2' then '2'
            when :liste = 'S' then '3'
            else '0'
          end,
          :intTVA,
          :base,
          :prix_ttc,
          :intPrestation,
          :prix_ht,
          :intCategorie,
          substring(:commentaire || ' ' || :commentaire2 from 1 for 200),
          :delai_lait,
          :delai_viande,
          --:code_fournisseur,
          :strDateDerniereVente,
          :grosexclu_stock);

  -- EAN13
  if ((ean is not null) and (ean similar to '[[:DIGIT:]]{13}')) then
    insert into t_code_ean13(t_code_ean13_id,
                             t_produit_id,
                             code_ean13)
    values(next value for seq_code_ean13,
           :code_uv,
           :ean);

  -- Gestion de stock
  if (geststock = '1') then
  begin
    if (code_geo = '1') then -- correspond à l'automate
      execute procedure ps_pharmavitale_creer_stock(:code_uv, :code_geo, stock_robot, '3') returning_values :intProduitGEO;
    else
      if (code_geo =  '3' and stock_robot > 0) then -- zone mixte robot et pharmacie, ventilation des produits
      begin
        execute procedure ps_pharmavitale_creer_stock(:code_uv, :code_geo, stock_robot, '3') returning_values :intProduitGEO;
        execute procedure ps_pharmavitale_creer_stock(:code_uv, :code_geo, nb_stock-stock_robot, '1') returning_values :intProduitGEO;
      end
      else
      begin
        execute procedure ps_pharmavitale_creer_stock(:code_uv, :code_geo, iif((gestreser = '1') and (flreserve_stock = '1'), nbstock_rayon, nb_stock), '1') returning_values :intProduitGEO;

        if ((gestreser = '1') and (flreserve_stock = '1')) then
        begin
          update t_produit_geographique
          set stock_mini = :minirayon_stock,
              stock_maxi = :maxirayon_stock
          where t_produit_geographique_id = :intProduitGEO;

          execute procedure ps_pharmavitale_creer_stock(:code_uv, null, :nb_stock - :nbstock_rayon, '0') returning_values :intProduitGEO;
        end
        else
          update t_produit
          set stock_mini = :mini_stock,
              stock_maxi = :mini_stock
          where t_produit_id = :code_uv;
      end
    end
end;


/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_depots(hasAutomate varchar(50))
as
begin
  if (hasAutomate = '1') then 
  begin
    insert into t_depot values (next value for seq_depot , 'AUTOMATE', '1', 'SUVE');
  end
end;
/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_histo_vte(
  code_uv varchar(10),
  dateh_mvmt_annee smallint,
  dateh_mvmt_mois smallint,
  nbunit_mvmt integer)
as
begin
  insert into t_historique_vente(t_historique_vente_id,
                                 t_produit_id,
                                 periode,
                                 quantite_vendues,
                                 quantite_actes)
  values(next value for seq_historique_vente,
         :code_uv,
         lpad(:dateh_mvmt_mois, 2, '0') || lpad(:dateh_mvmt_annee, 4, '0'),
         :nbunit_mvmt,
         :nbunit_mvmt);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_histo_del(
  index_stat integer,
  index_assure integer,
  NoFacture integer,
  DateFacture date,
  code_ope varchar(10),
  index_medecin integer,
  cip varchar(13),
  code_uv varchar(50),
  nom_prod varchar(50),
  Qte smallint,
  prix_ttc float)
as
declare variable strHistoClientID varchar(50);
begin

  strHistoClientID = cast(index_stat as varchar(50));
  if (not(exists(select *
                 from t_historique_client
                 where t_historique_client_id = :strHistoClientID))) then
    insert into t_historique_client(t_historique_client_id,
                                    t_client_id,
                                    code_operateur,
                                    t_praticien_id,
                                    numero_facture,
                                    date_prescription,
                                    date_acte,
                                    type_facturation)
    values(:strHistoClientID,
           :index_assure,
           :code_ope,
           :index_medecin,
           :NoFacture,
           :DateFacture,
           :DateFacture,
           '2');

  if (:cip ='') then cip = null  ;
  insert into t_historique_client_ligne(t_historique_client_ligne_id,
                                        t_historique_client_id,
                                        t_produit_id,
                                        code_cip,
                                        designation,
                                        quantite_facturee,
                                        prix_vente)
  values(next value for seq_historique_client_ligne,
         :strHistoClientID,
         :code_uv,
         :cip,
         :nom_prod,
         :Qte,
         :prix_ttc / 100);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_operateur(
  num_ope integer,
  code_ope varchar(10),
  nom_ope varchar(50))
as
begin
  insert into t_operateur(t_operateur_id,
                          code_operateur,
                          nom,
                          mot_de_passe)
  values(:num_ope,
         :num_ope,
         :nom_ope,
         :code_ope);
end;


create or alter procedure ps_pharmavitale_creer_va(
  indexVA integer,
  index_assure integer,
  datefacture date, 
  cip_prod varchar(13),
  nom_prod varchar(45),
  prixttc float,
  prix_ht float,
  code_acte varchar(3),
  code_uv varchar(10),
  num_ope integer,
  quantitepromis integer,
  base float)
as
begin
  insert into t_vignette_avancee(t_vignette_avancee_id,
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
  values(:indexVA,
         :index_assure,
         :datefacture,
         :cip_prod,
         :nom_prod,
         :prixttc,
         :prix_ht,
         :code_acte,
         :code_uv,
         :num_ope,
         :quantitepromis,
         :base);
end;

/* ********************************************************************************************** */

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_credit(
  index_payeur integer, 
  date_facture date, 
  EnCredit float)
as
begin
  insert into t_credit(t_credit_id,
                       t_client_id,
                       montant,
                       date_credit)
  values(:index_payeur,
         :index_payeur,
         :EnCredit,
         :date_facture);
end;

/* ********************************************************************************************** */
create or alter procedure ps_pharmavitale_creer_scan(
  id_Client integer,
  id_Facture integer,
  nom_fichier varchar(20),
  document varchar(255),
  type_scan integer)
as
begin
  insert into t_document(t_document_id,
                         type_entite,
                         t_entite_id,
                         libelle,
                         document,
                         commentaire)
  values(next value for seq_document,
         2, --doc client
         :id_Client,
         :nom_fichier,
         :document,
         iif(:type_scan=5,'Attestation Mutuelle','Ordonnance '||:id_facture));
end;


/* ********************************************************************************************** */

create or alter procedure ps_pharmavitale_credit_liste (
    date_credit date,
    numero_facture integer,
    montant float,
    nom varchar(50),
    prenom varchar(30) 
    )
as
declare variable t_client_id varchar(50);
declare variable nb integer;
begin


  select first 1 t_client_id
  from t_historique_client
  where numero_facture = :numero_facture
  into :t_client_id;  

  if ( t_client_id is null)  then
  begin
      select count(*) ,min(t_client_id)
      from t_client 
      where nom = trim(:nom) and upper(prenom) = upper(trim(:prenom))
      group by nom, upper(prenom)
      into :nb ,:t_client_id;  
  end

  if ( t_client_id is not null)  then
    if (not(exists(select t_client_id from t_credit where t_client_id = :t_client_id) ) ) then
      insert into t_credit(t_credit_id,
                           date_credit,
                           t_client_id,
                           montant)
            values(next value for seq_credit,
                   :date_credit,
                   :t_client_id,
                   :montant);

        else
         update t_credit set montant =montant+:montant
         where t_client_id = :t_client_id;
    

end;


create or alter procedure ps_pharmavitale_creer_commande(
  id_com dm_code,
  code_fournisseur dm_code,
  nom_com varchar(100),
  type_com char(1),
  dtsaisie_com date,
  dtenvoi_com date,
  dtliv_com date,
  montantHT_com float,
  comment_com varchar(200)

)
as
declare variable chTypeCommande char(1);
declare variable strFournisseur varchar(50);
declare variable strRepartiteur varchar(50);
declare variable e varchar(2);
begin
  if (type_com = 'D') then
  begin
    chTypeCommande = '1';
    strFournisseur = code_fournisseur;
    strRepartiteur = null;
  end
  else
  begin
    chTypeCommande = '2';
    strRepartiteur = code_fournisseur;
    strFournisseur = null;
  end

  insert into t_commande(t_commande_id,
                         type_commande,
                         t_fournisseur_direct_id,
                         t_repartiteur_id,
                         date_creation,
                         date_reception,
                         etat,
                         mode_transmission,
                         montant_ht,
                         commentaire)
  values(:id_com,
         :chTypeCommande,
         :strFournisseur,
         :strRepartiteur,
         :dtsaisie_com,
         :dtliv_com,
         3,
         '5',
         :montantHT_com/100,
         :comment_com);
end;

create or alter procedure ps_pharmavitale_creer_com_lig(
   id_com dm_code,
   num_ligcom integer,
   code_uv dm_code,
   etat_ligcom char(1),
   qtecom_ligcom integer,
   qterec_ligcom integer,
   prixcat_ligcom float,
   txremg_ligcom float,
   prixremht_ligcom float,
   qteug_ligcom integer, 
   pxpub_ligcom float
)
as


begin
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
  values(next value for seq_commande_ligne,
         :id_com,
         :code_uv,
         :qtecom_ligcom,
         :qterec_ligcom,
         :qterec_ligcom + :qteug_ligcom,
         :prixcat_ligcom/100,
         :prixremht_ligcom/10000,
         :pxpub_ligcom/100,
         :qteug_ligcom);
  
end;