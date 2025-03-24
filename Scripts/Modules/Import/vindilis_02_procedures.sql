set sql dialect 3;

create or alter procedure ps_vindilis_creer_praticien(
  serial integer,
  nom varchar(50),
  prenom varchar(50),
  adresse1 varchar(50),
  adresse2 varchar(50),
  codepostal varchar(5),
  ville varchar(50),
  telephone varchar(16),
  mobile varchar(16),
  fax varchar(16),
  mail varchar(50),
  commentaire varchar(200), 
  finess varchar(9),
  specialite integer,
  ratp char(1),
  rpps varchar(11))
as
declare variable intSpecialite integer;
declare variable strCommentaireFiness varchar(50);
begin
  execute procedure ps_renvoyer_id_specialite(:specialite) returning_values :intSpecialite;
  
  --  finess d'hopital => creation d'un hopital 
  if (( substring(:finess from 3 for 1) = '0' ) ) then
  begin
    -- si finess pas dans la base c'est peut etre une erreur   
    if (not(exists(select * from T_REF_HOPITAL where NUMERO_FINESS = trim(:finess) ))) then
      strCommentaireFiness = 'Vérifier / Corriger Numéro FINESS';
    
    -- creation si n existe pas 
    if (not(exists(select * from T_HOPITAL where NO_FINESS = trim(:finess) ))) then
      insert into t_hopital (t_hopital_id,
                             nom,
                             rue_1,
                             rue_2,
                             code_postal,
                             nom_ville,
                             no_finess,
                             tel_standard,
                             commentaire)
      values ('hop-'||:serial,
              substring(:nom||' '||coalesce(:prenom,'') from 1 for 50),
              substring(:adresse1 from 1 for 40),
              substring(:adresse2 from 1 for 40),
              :codepostal,
              substring(:ville from 1 for 30),
              :finess,
              :telephone,
              coalesce(:strCommentaireFiness,:commentaire));  

      -- creation d 'un praticien hospitalier
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
                              num_rpps,
                              agree_ratp,
                              t_hopital_id)
      values(:serial,
             '2',
             :nom,
             :prenom,
             substring(:adresse1 from 1 for 40),
             substring(:adresse2 from 1 for 40),
             :codepostal,
             substring(:ville from 1 for 30),
             :telephone,
             :mobile,
             :fax,
             :intSpecialite,
             :finess,
             :rpps,
             iif(:ratp='O','1','0'),
             (select t_hopital_id from T_HOPITAL where NO_FINESS = trim(:finess) ));


  end
  else
  begin
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
                              num_rpps,
                              agree_ratp)
      values(:serial,
             '1',
             :nom,
             :prenom,
             substring(:adresse1 from 1 for 40),
             substring(:adresse2 from 1 for 40),
             :codepostal,
             substring(:ville from 1 for 30),
             :telephone,
             :mobile,
             :fax,
             :intSpecialite,
             :finess,
             :rpps,
             iif(:ratp='O','1','0'));
  end

end;



create or alter procedure ps_vindilis_creer_destinataire(
 id integer,
 libelle varchar(50),
 num_destinataire varchar(20),
 serveursmtp varchar(50),
 serveurpop varchar(50),
 email_oct varchar(50),
 adresse_messagerie varchar(50),
 nom_utilisateur_pop3 varchar(50),
 mot_de_passe_pop3 varchar(50),
 port integer
 )
as 
begin

  insert into t_destinataire(t_destinataire_id,
                             num_ident,
                             serv_smtp,
                             serv_pop3,
                             utilisateur_pop3,
                             mot_passe_pop3,
                             adresse_bal,
                             email_oct,
                             nom,
                             num_dest_oct
                            )
  values (:id,
          :num_destinataire,
          :serveursmtp,
          :serveurpop,
          :nom_utilisateur_pop3,
          :mot_de_passe_pop3,
          :adresse_messagerie,
          :email_oct,
          :libelle,
          :num_destinataire
          );

end;



create or alter procedure ps_vindilis_creer_organisme(
  type_organisme integer,
  serial integer,
  code varchar(20),
  libelle varchar(50),
  grandregime varchar(2),
  caisse varchar(3),
  centre varchar(4),
  numeromutuelle varchar(10),
  adresse1 varchar(50),
  adresse2 varchar(50),
  codepostal varchar(5),
  ville varchar(50),
  telephone varchar(16),
  mobile varchar(16),
  fax varchar(16),
  mail varchar(50),
  commentaire varchar(200)
  )
as

declare variable intIDRegime integer;
declare variable strOrganismeID varchar(50);
declare variable strIdentifiantNational varchar(9);
declare variable chSansCentreGestionnaire char(1);
begin

  if (type_organisme = '1') then
  begin
    select t_ref_regime_id,
           sans_centre_gestionnaire
    from t_ref_regime
    where code = lpad(:grandregime,2,'0')
    into :intIDRegime,
         :chSansCentreGestionnaire;

    if (row_count = 0) then
      intIDRegime = null;

    insert into t_organisme(type_organisme,
                            t_organisme_id,
                            nom,
                            nom_reduit,
                            type_releve,
                            t_destinataire_id,
                            t_ref_regime_id,
                            caisse_gestionnaire,
                            centre_gestionnaire,
                            application_mt_mini_pc,
                            rue_1,
                            rue_2,
                            code_postal,
                            nom_ville,
                            tel_personnel,
                            commentaire)
    values('1',
          'amo-'||:serial,
          trim(:libelle),
          :code,
          '0',
          null, -- destinataire voir plus tard
          :intIDRegime,
          lpad(:caisse,3,'0'),
          :centre, 
          '0',
          :adresse1,
          :adresse2,
          :codepostal,
          :ville,
          :telephone,
          :commentaire
          );
  end
  else
  begin
    if ((char_length(numeromutuelle)) = 10) then
      strIdentifiantNational = substring(numeromutuelle from 2 for 9);
    else
      strIdentifiantNational = numeromutuelle;  

    insert into t_organisme(type_organisme,
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
                            tel_personnel,
                            commentaire)
    values('2',
          'amc-'||:serial,
          trim(:libelle),
          :code,
          null,
          '0',
          :strIdentifiantNational,
          '0',
          0,
          :adresse1,
          :adresse2,
          :codepostal,
          :ville,
          :telephone,
          :commentaire
          );
  end  
end;


create or alter procedure ps_vindilis_creer_taux_amo(
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

create or alter procedure ps_vindilis_creer_couv_amo(
  serial integer, 
  code varchar(10), 
  libelle varchar(50), 
  taux integer, 
  exo char(1),
  alsacemoselle char(1),
  tauxph1 integer,
  tauxph2 integer,
  tauxph4 integer, 
  tauxph7 integer,
  tauxaad integer,
  tauxpmr integer
)
as
declare variable ald char(1);
declare variable t_ref_couverture_amo_id integer;
begin

  if (:exo = '4') then
      ald = '1';
  else
      ald = '0';

  -- couvertures de base 0100     
  if ( taux = 1 ) then 
    select t_ref_couverture_amo_id
    from t_ref_couverture_amo
    where code_couverture = trim(:ald||'0100')
    into :t_ref_couverture_amo_id;
  else
    t_ref_couverture_amo_id = null ;
      
  insert into t_couverture_amo(t_couverture_amo_id,
                               ald,
                               libelle,
                               nature_assurance,
                               justificatif_exo,
                               t_ref_couverture_amo_id)
    values(:serial,
           :ald,
           :libelle,
           iif( :alsacemoselle = 1, 13, 10 ),
           :exo,
           :t_ref_couverture_amo_id);

  execute procedure ps_vindilis_creer_taux_amo( serial, 'PH1', tauxph1 );
  execute procedure ps_vindilis_creer_taux_amo( serial, 'PH2', tauxph2 );
  execute procedure ps_vindilis_creer_taux_amo( serial, 'PH4', tauxph4 );
  execute procedure ps_vindilis_creer_taux_amo( serial, 'PH7', tauxph7 );
  execute procedure ps_vindilis_creer_taux_amo( serial, 'AAD', tauxaad );
  execute procedure ps_vindilis_creer_taux_amo( serial, 'PMR', tauxpmr );

end;


create or alter procedure ps_vindilis_creer_couv_amo_cli(
  serialbeneficiaire integer, 
  serialcouverture integer,
  ald char(1),
  datedebut date,
  datefin date,
  serialamo integer
)
as
declare variable strCouvertureAMO varchar(50);
begin
  strCouvertureAMO = serialamo||'-'||serialcouverture;

  if (not(exists( select null from t_couverture_amo where t_couverture_amo_id = :strCouvertureAMO))) then
  begin
    insert into t_couverture_amo( t_couverture_amo_id,
                                  t_organisme_amo_id,
                                  ald,
                                  libelle,
                                  nature_assurance,
                                  justificatif_exo,
                                  t_ref_couverture_amo_id    )
      select :strCouvertureAMO,
             'amo-'||:serialamo,
             ald,
             libelle,
             nature_assurance,
             justificatif_exo,
             t_ref_couverture_amo_id    
      from t_couverture_amo 
      where t_couverture_amo_id = cast(:serialcouverture as varchar(50)) ;

    insert into t_taux_prise_en_charge(t_taux_prise_en_charge_id,
                                       t_couverture_amo_id,
                                       t_couverture_amc_id,
                                       t_ref_prestation_id,
                                       taux,
                                       formule)
       select next value for seq_taux_prise_en_charge,
              :strCouvertureAMO,
              null,
              t_ref_prestation_id,
              taux,
              formule
       from t_taux_prise_en_charge
       where t_couverture_amo_id = cast(:serialcouverture as varchar(50)); 

  end

  insert into t_couverture_amo_client(t_couverture_amo_client_id,
                                      t_client_id,
                                      t_couverture_amo_id,
                                      debut_droit_amo,
                                      fin_droit_amo)
  values(next value for seq_couverture_amo_client,
        :serialbeneficiaire,
        :strCouvertureAMO,
        coalesce(:datedebut ,current_date),
        :datefin);
end;

create or alter procedure ps_vindilis_creer_taux_amc(
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
end;

create or alter procedure ps_vindilis_creer_couv_amc(
  serial integer, 
  code varchar(10), 
  libelle varchar(50), 
  taux integer,
  tauxph1 integer,
  tauxph2 integer,
  tauxph4 integer, 
  tauxph7 integer,
  tauxaad integer,
  tauxpmr integer  
)
as
begin
    insert into t_couverture_amc(t_couverture_amc_id,
                                 libelle,
                                 montant_franchise,
                                 plafond_prise_en_charge,
                                 formule)
    values(:serial,
           :libelle,
           0,
           0,
           '02A');  

  execute procedure ps_vindilis_creer_taux_amc( serial, 'PH1', tauxph1 );
  execute procedure ps_vindilis_creer_taux_amc( serial, 'PH2', tauxph2 );
  execute procedure ps_vindilis_creer_taux_amc( serial, 'PH4', tauxph4 );
  execute procedure ps_vindilis_creer_taux_amc( serial, 'PH7', tauxph7 );
  execute procedure ps_vindilis_creer_taux_amc( serial, 'AAD', tauxaad );
  execute procedure ps_vindilis_creer_taux_amc( serial, 'PMR', tauxpmr );

end;


create or alter procedure ps_vindilis_creer_couv_org_amc(
  AOrganismeAMC varchar(50),
  AInCouvertureAMC varchar(50))
returns(
  AOutCouvertureAMC varchar(50))
as
begin
   AOutCouvertureAMC = 'amc-'||:AOrganismeAMC || '-' || :AInCouvertureAMC;
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
                                    plafond_prise_en_charge,
                                    formule)
       select :AOutCouvertureAMC,
              :AOrganismeAMC,
              libelle,
              montant_franchise,
              plafond_prise_en_charge, 
              formule
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


create or alter procedure ps_vindilis_creer_compte (
serial integer,
raisonsociale varchar(50),
adresse1 varchar(50),
adresse2 varchar(50),
codepostal varchar(5),
ville varchar(50),
telephone varchar(16),
mobile varchar(16),
fax varchar(16),
adresse1_livr varchar(50),
adresse2_livr varchar(50),
codepostal_livr varchar(5),
ville_livr varchar(50),
telephone_livr varchar(16),
mobile_livr varchar(16),
fax_livr varchar(16),
dernierpassage date,
remise float)
as
declare variable t_profil_remise_id varchar(50);
declare variable t_param_remise_fixe_id varchar(50);
begin
  if ( remise > 0 ) then
  begin
    t_profil_remise_id = cast(remise as varchar(10));
    t_param_remise_fixe_id = cast(remise as varchar(10));

    if (not(exists(select t_param_remise_fixe_id from t_param_remise_fixe where t_param_remise_fixe_id=:t_param_remise_fixe_id))) then
    begin
      insert into t_param_remise_fixe (t_param_remise_fixe_id,
                                       taux)
      values(:t_param_remise_fixe_id,
             :remise);

      insert into t_profil_remise(t_profil_remise_id,
                                  libelle,
                                  sur_vente_directe,
                                  sur_facture_ciale,
                                  sur_facture_retro,
                                  sur_ordonnance,
                                  t_param_remise_fixe_id,
                                  type_remise)
      values(:t_param_remise_fixe_id,
             'profil '||:remise||'%',
             '1',
             '1',
             '1',
             '0',
             :t_param_remise_fixe_id,
             '0');
    end
  end
  else
    t_profil_remise_id = null;

  insert into t_compte(t_compte_id,
                       nom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_standard,
                       fax,
                       tel_mobile,
                       payeur,
                       t_profil_remise_id)
  values('CPT'||:serial,
         substring(:raisonsociale from 1 for 30 ),
         substring(:adresse1 from 1 for 40 ),
         substring(:adresse2 from 1 for 40 ),
         :codepostal,
         substring(:ville from 1 for 30 ),
         :telephone,
         :fax,
         :mobile,
         'A',
         :t_profil_remise_id);
end;

create or alter procedure ps_vindilis_creer_client(
  idcli integer, --id client
  idben integer, --id beneficiaire
  idpara integer, --id para
  nom_client varchar(50), 
  prenom_client varchar(50), 
  adresse1 varchar(50), 
  adresse2 varchar(50), 
  codepostal varchar(5), 
  ville varchar(50), 
  telephone varchar(16), 
  mobile varchar(16), 
  fax varchar(16),
  codenumerique integer,
  numeross varchar(15),
  serialamo integer,
  centregestionnaire integer,
  datevaliditepiece date,
  alsacemoselle char,
  nom varchar(50), 
  nompatronymique varchar(50), 
  prenom varchar(50), 
  datenaissance integer,
  rangnaissance integer,
  qualite integer,
  datedebutamo date,
  datefinamo date,
  numeroadherent varchar(20),
  datedebutamc date,
  datefinamc date,
  mutuelleencarte varchar(10),
  codetraitementamc integer,
  typerc char,
  identifiantamc varchar(15),
  serialamc integer,  
  serialcouvertureamc integer,  
  datedebut date,
  datefin date,
  adherent varchar(20),
  dernierpassage date

  )
as
declare variable strCouvertureAMC varchar(50);
declare variable strDateNaissance varchar(10);
begin

  strDateNaissance = null;

 if (serialamc is not null) then
  begin
    execute procedure ps_vindilis_creer_couv_org_amc('amc-'||:serialamc, :serialcouvertureamc) returning_values :strCouvertureAMC;

    when any do
    begin
      strCouvertureAMC = null;
    end
  end
 else
  begin
    strCouvertureAMC = null;
  end

  if (datenaissance > 0) then
  begin
    strDateNaissance = cast(datenaissance as varchar(10));
    strDateNaissance = substring( strDateNaissance from 7 for 2) ||
                       substring( strDateNaissance from 5 for 2) ||
                       substring( strDateNaissance from 1 for 4);

  end
      

  insert into t_client(t_client_id,
                       nom,
                       nom_jeune_fille,
                       prenom,
                       rue_1,
                       rue_2,
                       code_postal,
                       nom_ville,
                       tel_standard,
                       tel_mobile,
                       fax,
                       ref_externe,
                       numero_insee,
                       date_naissance,
                       date_validite_piece_justif,
                       qualite,
                       rang_gemellaire,
                       t_organisme_amo_id,
                       centre_gestionnaire,
                       date_derniere_visite,
                       mode_gestion_amc,
                       numero_adherent_mutuelle,
                       t_organisme_amc_id,
                       t_couverture_amc_id, 
                       debut_droit_amc,
                       fin_droit_amc
    )
  values(coalesce(:idben,'P'||:idpara,'C'||:idcli ),
        substring(coalesce(:nom,:nom_client) from 1 for 30),
        substring(:nompatronymique from 1 for 30),
        substring(coalesce(:prenom,:prenom_client) from 1 for 30),
        substring(:adresse1 from 1 for 40),
        substring(:adresse2 from 1 for 40),
        :codepostal,
        substring(:ville from 1 for 30),
        :telephone,
        :mobile,
        :fax,
        lpad(:codenumerique, 6, '0'),
        :numeross,
        :strDateNaissance,
        :datevaliditepiece,
        :qualite,
        :rangnaissance,
        'amo-'||:serialamo,
        :centregestionnaire,
        :dernierpassage,
        :typerc,
        :adherent, -- ou numeroadherent ?
        'amc-'||:serialamc,
        :strCouvertureAMC,
        coalesce(:datedebutamc,:datedebut),
        coalesce(:datefinamc,:datefin)
    );


end;


create or alter procedure ps_vindilis_creer_produit(
  serial integer,
  libellearticle varchar(60), 
  tva float,  
  gestionstock char(1),  
  acte varchar(5), 
  liste char(1), 
  prixachatht float,  
  prixventettc float, 
  baseremboursement float,
  commentaire varchar(1000), 
  commentairecommande varchar(1000),
  datedernierevente date,
  dateperemption date,
  stockmini integer,
  stockmaxi integer,
  optimisation char(1),
  blocagecommande char(1),
  modedecalcul varchar(500))
as
declare variable intTVA integer;
declare variable intPrestation integer;
declare variable gds char(1) default '0';
begin
  execute procedure ps_renvoyer_id_tva(:tva) returning_values :intTVA;
  execute procedure ps_renvoyer_id_prestation(:acte) returning_values :intPrestation;
  if (:blocagecommande='O' or :modedecalcul = 'Faible rotation' or :modedecalcul = 'Pas optimisé ou réajustement sur maxi  et moins de 60 jours' or :modedecalcul = 'Dormant') then gds = '2';
  if (:modedecalcul = 'Abaque type A') then gds = '3';
  insert into t_produit(t_produit_id,
    designation,
    t_ref_tva_id,
    t_ref_prestation_id,
    liste,
    prix_achat_catalogue,
    prix_vente,
    base_remboursement,
    commentaire_gestion,
    commentaire_commande,
    date_derniere_vente,
    date_peremption,
    stock_mini,
    stock_maxi,
    calcul_gs,
    profil_gs)
  values(:serial,
    substring(:libellearticle from 1 for 50),
    :intTVA,
    :intPrestation,
    coalesce(iif(:liste='S', '3', :liste), '0'),
    coalesce(:prixachatht,0),
    :prixventettc,
    :baseremboursement,
    substring(:commentaire from 1 for 200),
    substring(:commentairecommande from 1 for 200),
    :datedernierevente,
    :dateperemption,
    :stockmini,
    :stockmaxi,
    iif(:optimisation='A',4,0), -- si A , -> fixé
    :gds
    );
end;


create or alter procedure ps_vindilis_creer_code_produit(
  serial integer,
  amm varchar(13),
  principal char(1))
as
declare variable t_produit_id varchar(50);
begin
  t_produit_id = cast(serial as varchar(50));

  if (principal = 'O') then
    if (char_length(amm) = 7) then
      update t_produit
      set code_cip = :amm
      where t_produit_id = :t_produit_id
      and code_cip is null;
  
  if (amm similar to '340[01][[:DIGIT:]]{9}') then 
      update t_produit
      set code_cip = :amm
      where t_produit_id = :t_produit_id;  
    else
      if (amm similar to '[[:DIGIT:]]{13}') then
        insert into t_code_ean13(t_code_ean13_id, t_produit_id, code_ean13)
        values(next value for seq_code_ean13, :t_produit_id, :amm);    
end;

create or alter procedure ps_vindilis_creer_histo_vente(
  serialarticle integer,
  annee integer,
  mois integer,
  quantite integer,
  nombres_ventes integer)
as
begin
  insert into t_historique_vente(t_historique_vente_id,
    t_produit_id,
    periode,
    quantite_actes,
    quantite_vendues)
  values(next value for seq_historique_vente,
    :serialarticle,
    lpad(:mois, 2, '0') || :annee,
    :nombres_ventes,
    :quantite);
end;

create or alter procedure ps_vindilis_creer_histo_client(
  serial integer,
  serialclient integer,
  numerovente integer,
  dateprescription date,
  code_operateur integer,
  serialprescripteur integer,
  nom varchar(50),
  prenom varchar(50),
  typevente char(1),
  datevente date)
as
begin
  insert into t_historique_client(t_historique_client_id,
    t_client_id,
    numero_facture,
    date_prescription,
    code_operateur,
    t_praticien_id,
    nom_praticien,
    prenom_praticien,
    type_facturation,
    date_acte)
  values(:serial,
    :serialclient,
    :numerovente,
    :dateprescription,
    :code_operateur,
    :serialprescripteur,
    :nom,
    :prenom,
    2,
    :datevente);
end;  

create or alter procedure ps_vindilis_creer_histo_ligne(
  serialvente integer,
  codeamm varchar(13),
  serialarticle integer,
  libellearticle varchar(60),
  prixachat float,
  prixbrut float,
  quantite integer)
as
begin
  insert into t_historique_client_ligne(t_historique_client_ligne_id,
    t_historique_client_id,
    code_cip,
    t_produit_id,
    designation,
    quantite_facturee,
    prix_vente,    
    prix_achat)
  values(next value for seq_historique_client_ligne,
    :serialvente,
    iif(:codeamm = '', null, :codeamm),
    :serialarticle,
    substring(:libellearticle from 1 for 50),
    :quantite,
    :prixbrut,
    :prixachat);
end;
    
create or alter procedure ps_vindilis_creer_info_stock(
  serial integer,
  codegeo integer,
  stockmaxi integer, --> maxi produit
  stockmini integer, --> mini produit
  qtestock integer,
  gestionreserve char(1),
  qtereserve1 integer,
  codegeoreserve1 integer,
  stockagemaxireserve1 integer,
  qtereserve2 integer,
  codegeoreserve2 integer,
  stockalerte integer,
  stockagemaxicodegeo integer, --> maxi stock 
  miniincomp integer           --> mini stock ?  
  )
as
begin


  insert into t_produit_geographique(t_produit_geographique_id,
    t_produit_id,
    t_zone_geographique_id,
    t_depot_id,
    quantite,
    stock_maxi,
    stock_mini)
  values(next value for seq_produit_geographique,
    :serial,
    :codegeo,
    (select t_depot_id from t_depot where libelle = 'PHARMACIE'),
    :qtestock,
    :stockagemaxicodegeo,
    :miniincomp); -- pas sûr
    
  if (gestionreserve = 'O') then
  begin
    insert into t_produit_geographique(t_produit_geographique_id,
      t_produit_id,
      t_zone_geographique_id,
      t_depot_id,
      quantite)
    values(next value for seq_produit_geographique,
      :serial,
      :codegeoreserve1,
      (select t_depot_id from t_depot where libelle = 'RESERVE'),
      :qtereserve1);
  end
end;

create or alter procedure ps_vindilis_creer_code_geo(
  code integer,
  libelle varchar(50))
as
begin
  insert into t_zone_geographique(t_zone_geographique_id,
    libelle)
  values(:code,
    :libelle);
end;

create or alter procedure ps_vindilis_creer_fournisseur(
  serial integer,
  libellefournisseur varchar(50),
  url_principal varchar(512),
  id_officine varchar(20),
  cle_secrete varchar(4),
  code_pharmaml varchar(20),
  identifiant_magasin varchar(20))
as
begin
  insert into t_fournisseur_direct(
  t_fournisseur_direct_id,
  raison_sociale,
  pharmaml_ref_id,
  pharmaml_url_1,
  pharmaml_id_officine,
  pharmaml_id_magasin,
  pharmaml_cle)
  values(
    'FOU_' || :serial,
    :libellefournisseur,
    :code_pharmaml,
    :url_principal,
    :id_officine,
    :identifiant_magasin,
    :cle_secrete
    );
end;

create or alter procedure ps_vindilis_creer_grossiste(
  serial integer,
  libellegrossiste varchar(50),
  url_principal varchar(512),
  id_officine varchar(20),
  cle_secrete varchar(4),
  code_pharmaml varchar(20),
  identifiant_magasin varchar(20))
as
begin
  insert into t_repartiteur(
    t_repartiteur_id,
    raison_sociale,
    pharmaml_ref_id,
    pharmaml_url_1,
    pharmaml_id_officine,
    pharmaml_id_magasin,
    pharmaml_cle)
  values(
    'REP_' || :serial,
    :libellegrossiste,
    :code_pharmaml,
    :url_principal,
    :id_officine,
    :identifiant_magasin,
    :cle_secrete
    );
end;

create or alter procedure ps_vindilis_creer_commande(
  serial integer,
  typecommande char(1),
  datecommande date,
  datelivraison1 date,
  mtcommandeht float,
  serialfougro integer)
as
declare variable f varchar(50);
declare variable r varchar(50);
declare variable t char(1);
begin
  if (typecommande = 'F') then
  begin
    f = 'FOU_' || serialfougro;
    r = null;
    t = '1';
  end
  else
  begin
    r = 'REP_' || serialfougro;
    f = null;
    t = '2';  
  end
  
  insert into t_commande(
    t_commande_id,
    t_fournisseur_direct_id,
    t_repartiteur_id,
    type_commande,
    montant_ht,
    etat,
    date_creation,
    date_reception)
  values(:serial,
         :f,
         :r,
         :t,
         :mtcommandeht,
         '3',
         :datecommande,
         :datelivraison1);
end;

create or alter procedure ps_vindilis_creer_cmd_ligne(
  serial integer,
  serialhistocmde integer,
  serialstock integer,
  qtecommande integer,
  qtelivree integer,
  qteug integer,
  qteuglivree integer,
  prixachatbase float,
  prixachatnet float,
  prixventettc float,
  colisage integer)
as
begin
  insert into t_commande_ligne(t_commande_ligne_id,
    t_commande_id,
    t_produit_id,
    quantite_commandee,
    quantite_recue,
    quantite_totale_recue,
    unites_gratuites,
    colisage,
    prix_achat_tarif,
    prix_achat_remise,
    prix_vente)
  values(:serial,
    :serialhistocmde,
    :serialstock,
    :qtecommande,
    :qtelivree,
    :qtelivree + :qteuglivree,
    :qteug,
    :colisage,
    :prixachatbase,
    :prixachatnet,
    :prixventettc);
end;

create or alter procedure ps_vindilis_creer_cmd_attente(
  serial integer,
  typecommande char(1),
  datecommande date,
  mtcommandeht float,
  commentaire varchar(2000),
  serialgrossiste integer,
  serialfournisseur integer,
  datelivraison date)
as
begin
  insert into t_commande(t_commande_id,
    type_commande,
  date_creation,
  date_reception_prevue,
  montant_ht, 
  etat,
  commentaire,
  t_fournisseur_direct_id,
  t_repartiteur_id)
  values(:serial,
    :typecommande,
  :datecommande,
  :datelivraison,
  :mtcommandeht,
  '2',
  :commentaire,
  'FOU_' || :serialfournisseur,
  'REP_' || :serialgrossiste);
end;

create or alter procedure ps_vindilis_creer_ligcmd_att(
  serial integer,
  serialcommandefou integer,
  serialstock integer,
  qtecommandee integer,
  qtelivree integer,
  qteuglivree integer,
  prixachatbase float,
  prixachatnet float,
  prixventettc float,
  qteug integer)
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
  values(:serial,
    :serialcommandefou,
  :serialstock,
  :qtecommandee,
  coalesce(:qtelivree, 0),
  coalesce(:qtelivree, 0) + coalesce(:qteuglivree, 0),
  :prixachatbase,
  :prixachatnet,
  :prixventettc,
  :qteug);
end;

create or alter procedure ps_vindilis_creer_operateur (
    id integer,
    code_operateur varchar(255),
    nom varchar(255),
    prenom varchar(255),
    motdepasse varchar(255))
as
begin
    insert into t_operateur(t_operateur_id,
                        code_operateur,
                        nom,
                        prenom,
                        mot_de_passe,
                        activation_operateur)
    values(:id,
       :code_operateur,
       :nom,
       :prenom,
       :motdepasse,
       '1');
end;

/* ********************************************************************************************** */

create or alter procedure ps_vindilis_creer_avance(
    serialbeneficiaire varchar(50),
    serialclient varchar(50),
    datevente date,
    codeamm varchar(50),
    codeacte varchar(50),
    libellearticle varchar(100),
    prixventettc float,
    prixachatht float,
    serialarticle varchar(20),
    vendeurquivalide varchar(10),
    quantite integer,
    baseremboursement varchar(50))
as
begin

    insert into t_vignette_avancee(t_vignette_avancee_id,
                                       t_client_id,
                                       date_avance,
                                       code_cip,
                                       code_prestation,
                                       designation,
                                       prix_vente,
                                       prix_achat,
                                       t_produit_id,
                                       t_operateur_id,
                                       quantite_avancee,
                                       base_remboursement)
        values(next value for seq_vignette_avancee,
               coalesce(:serialbeneficiaire,:serialclient),
               :datevente,
               :codeamm,
               :codeacte,
               :libellearticle,
               cast(:prixventettc as decimal(5,2)),
               cast(:prixachatht as decimal(5,2)),
               :serialarticle,
               :vendeurquivalide,
               :quantite,
               0);

end;


/******************************************************* crédit  *******************************************************/
create or alter procedure ps_vindilis_creer_credit(
  client_id varchar(50),
  date_credit date,
  montant float
  ) 
as
begin
  insert into t_credit(t_credit_id,
                       date_credit,
                       t_client_id,
                       montant)
  values(next value for seq_credit,
                        :date_credit,
                        :client_id,
                        :montant);
end;


create or alter procedure ps_vindilis_creer_credit_compte(
  client_id varchar(50),
  date_credit date,
  montant float
  ) 
as
begin
  insert into t_credit(t_credit_id,
                       date_credit,
                       t_compte_id,
                       montant)
  values(next value for seq_credit,
                        :date_credit,
                        'CPT'||:client_id,
                        :montant);
end;


create or alter procedure ps_vindilis_creer_produit_du(
numero_du integer,  
ben_ti integer,
date_order date,
produit_id integer,
quantite smallint)
as
begin
  insert into t_produit_du(t_produit_du_id,
                           t_client_id,
                           date_du,
                           t_produit_id,
                           quantite)
  values(next value for seq_produit_du,
         :ben_ti,
         :date_order,
         :produit_id,
         :quantite);
end;

create or alter procedure ps_vindilis_creer_cf(
  AIDClientPara integer,
  AIDClientBen integer,
  numcarte char(13)
)
as
  declare commentaire varchar(2000);
begin
  insert into t_carte_programme_relationnel(
    t_carte_prog_relationnel_id,
    t_aad_id,
    numero_carte
   )
  values(
    next value for seq_programme_relationnel,
    coalesce(:AIDClientBen,'P'||:AIDClientPara),
    :numcarte);

  select COALESCE(commentaire_global, '') from t_client where t_client_id = coalesce(:AIDClientBen,'P'||:AIDClientPara) into :commentaire;

  if (trim(:commentaire) <> '') then
    commentaire = commentaire || '<BR>ELSIE : ' || :numcarte;
  else
    commentaire = 'ELSIE : ' || :numcarte;

  update t_client set commentaire_global = :commentaire where t_client_id = coalesce(:AIDClientBen,'P'||:AIDClientPara);
end; 