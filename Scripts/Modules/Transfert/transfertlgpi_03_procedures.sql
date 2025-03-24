set sql dialect 3;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_hopital
returns(
  AIDHopital varchar(50),
  AIDHopitalLGPI integer,
  ANom varchar(50),
  ACommentaire varchar(200),
  ANoFiness varchar(9),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal char(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20))
as
begin
  for select hop.t_cnv_hopital_id,
             hopl.t_transfertlgpi_hopital_id,
             hop.nom,
             hop.commentaire,
             hop.numero_finess,
             hop.rue_1,
             hop.rue_2,
             coalesce(cp.code_postal, hop.code_postal),
             coalesce(cp.nom_ville, hop.nom_ville),
             hop.tel_personnel,
             hop.tel_standard,
             hop.tel_mobile,
             hop.fax
      from t_cnv_hopital hop
      left join t_transfertlgpi_hopital hopl on (hopl.t_hopital_id = hop.t_cnv_hopital_id)
      left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = hop.t_ref_cp_ville_id)
      where hop.numero_finess not in ( select no_finess from t_hopital where repris = '0' ) 
      or hop.t_hopital_id in ( select t_hopital_id from t_praticien ) into 
           :AIDHopital,
           :AIDHopitalLGPI,
           :ANom,
           :ACommentaire,
           :ANoFiness,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax do
        suspend;

end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_praticien
returns(
  AIDPraticien varchar(50),
  AIDPraticienLGPI integer,
  ATypePraticien char(1),
  ANom varchar(50),
  APrenom varchar(50),
  ASpecialite varchar(3),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20),
  AEmail varchar(50),
  ACommentaire varchar(200),
  ANoFiness varchar(9),
  AIDHopital integer,
  ANumRpps varchar(11),
  AVeterinaire char(1)
  )
as
begin
  for select 
             iif( cnv.numero_finess is null ,'1','2' ),
             pratl.t_transfertlgpi_praticien_id,
             prat.t_praticien_id,
             prat.nom,
             prat.prenom,
             sp.code,
             prat.rue_1,
             prat.rue_2,
             coalesce(cp.code_postal, prat.code_postal),
             coalesce(cp.nom_ville, prat.nom_ville),
             prat.tel_personnel,
             prat.tel_standard,
             prat.tel_mobile,
             prat.fax,
             prat.email,
             prat.commentaire,
             prat.no_finess,
             hop.t_transfertlgpi_hopital_id,
             prat.num_rpps,
             '0'
      from t_praticien prat
           left join t_cnv_hopital cnv on  prat.no_finess = cnv.numero_finess  
           left join t_transfertlgpi_hopital hop on (hop.t_hopital_id = cnv.t_cnv_hopital_id)
           inner join t_ref_specialite sp on (sp.t_ref_specialite_id = prat.t_ref_specialite_id)
           left join t_transfertlgpi_praticien pratl on (pratl.t_praticien_id = prat.t_praticien_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = prat.t_ref_cp_ville_id)
      where prat.repris = '1'
  into :ATypePraticien,
           :AIDPraticienLGPI,
           :AIDPraticien,
           :ANom,
           :APrenom,
           :ASpecialite,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax,
           :AEmail,
           :ACommentaire,
           :ANoFiness,
           :AIDHopital,
           :ANumRPPS,
           :AVeterinaire do
    suspend;

end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_destinataire
returns(
  AIDDestinataire varchar(50),
  AIDDestinataireLGPI integer,
  ANumIdent varchar(20),
  AServSMTP varchar(50),
  AServPOP3 varchar(50),
  AServDNS varchar(50),
  AUtilisateurPOP3 varchar(100),
  AMotPassePOP3 varchar(50),
  AAdresseBAL varchar(50),
  ANoAppel varchar(50),
  ATempo numeric(4),
  AEmailOCT varchar(50),
  ANom varchar(50),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20),
  AApplicationOCT varchar(2),
  ANumDestOCT varchar(20),
  ANorme char(1),
  ANormeRetour char(1),
  ACommentaire varchar(100),
  AFlux varchar(30),
  AZoneMessage varchar(37),
  AOCT char(1),
  AAuthentification char(1),
  ATYP varchar(2),
  ARefuseHTP char(1),
  AGestionNumLots char(1),
  AXSL varchar(50))
as
begin
  for select distinct d.t_destinataire_id,
             dl.t_transfertlgpi_destinataire_id,
             d.num_ident,
             d.serv_smtp,
             d.serv_pop3,
             d.serv_dns,
             d.utilisateur_pop3,
             d.mot_passe_pop3,
             d.adresse_bal,
             d.no_appel,
             d.tempo,
             d.email_oct,
             d.nom,
             d.rue_1,
             d.rue_2,
             coalesce(cp.code_postal, d.code_postal),
             coalesce(cp.nom_ville, d.nom_ville),
             d.tel_personnel,
             d.tel_standard,
             d.tel_mobile,
             d.fax,
             d.application_oct,
             d.num_dest_oct,
             d.norme,
             d.norme_retour,
             d.commentaire,
             d.flux,
             d.zone_message,
             d.oct,
             d.authentification,
             d.typ,
             d.refuse_htp,
             d.gestion_num_lots,
             d.xsl
        from t_organisme o
             inner join t_destinataire d on (d.t_destinataire_id = o.t_destinataire_id)
             left join t_transfertlgpi_destinataire dl on (dl.t_destinataire_id = dl.t_destinataire_id)
             left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = d.t_ref_cp_ville_id)
        into :AIDDestinataire,
             :AIDDestinataireLGPI,
             :ANumIdent,
             :AServSMTP,
             :AServPOP3,
             :AServDNS,
             :AUtilisateurPOP3,
             :AMotPassePOP3,
             :AAdresseBAL,
             :ANoAppel,
             :ATempo,
             :AEmailOCT,
             :ANom,
             :ARue1,
             :ARue2,
             :ACodePostal,
             :ANomVille,
             :ATelPersonnel,
             :ATelStandard,
             :ATelMobile,
             :AFax,
             :AApplicationOCT,
             :ANumDestOCT,
             :ANorme,
             :ANormeRetour,
             :ACommentaire,
             :AFlux,
             :AZoneMessage,
             :AOCT,
             :AAuthentification,
             :ATYP,
             :ARefuseHTP,
             :AGestionNumLots,
             :AXSL do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_organisme
returns(
  AIDOrganisme varchar(50),
  AIDOrganismeAMCLGPI integer,
  ATypeOrganisme char(1),
  ANomReduit varchar(20),
  ACommentaire varchar(200),
  ACommentaireBloquant varchar(200),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20),
  AOrgReference char(1),
  AMtSeuilTiersPayant numeric(10,2),
  AAccordTiersPayant char(1),
  AIDDestinataire varchar(9),
  ADocFacturation numeric(3),
  ATypeReleve varchar(10),
  AEditionReleve char(1),
  AFrequenceReleve numeric(3),
  AMtSeuilEdReleve numeric(7,2),
  ARegime varchar(9),
  ACaisseGestionnaire varchar(3),
  ACentreGestionnaire varchar(4),
  AFinDroitsOrgAMC char(1),
  AOrgCirconscription char(1),
  AOrgConventionne char(1),
  ANom varchar(50),
  AIdentifiantNational varchar(9),
  APriseEnChargeAME char(1),
  AApplicationMtMiniPC char(1),
  ATypeContrat numeric(2),
  ASaisieNoAdherent char(1))
as
begin
  for select null,
             org.t_organisme_id,
             org.type_organisme,
             org.nom_reduit,
             org.commentaire,
             org.commentaire_bloquant,
             org.rue_1,
             org.rue_2,
             coalesce(cp.code_postal, org.code_postal),
             coalesce(cp.nom_ville, org.nom_ville),
             org.tel_personnel,
             org.tel_standard,
             org.tel_mobile,
             org.fax,
             org.org_reference,
             org.mt_seuil_tiers_payant,
             org.accord_tiers_payant,
             dest.t_transfertlgpi_destinataire_id,
             org.doc_facturation,
             org.type_releve,
             org.edition_releve,
             org.frequence_releve,
             org.mt_seuil_ed_releve,
             coalesce(r_reg.code, reg.code),
             coalesce(r_org.caisse_gestionnaire, org.caisse_gestionnaire),
             coalesce(r_org.centre_gestionnaire, org.centre_gestionnaire),
             org.fin_droits_org_amc,
             org.org_circonscription,
             org.org_conventionne,
             org.nom,
             org.identifiant_national,
             org.prise_en_charge_ame,
             org.application_mt_mini_pc,
             org.type_contrat,
             org.saisie_no_adherent
      from t_organisme org
           left join t_ref_regime reg on (reg.t_ref_regime_id = org.t_ref_regime_id)
           left join t_transfertlgpi_destinataire dest on (dest.t_destinataire_id = org.t_destinataire_id)
           left join t_ref_organisme r_org on (r_org.t_ref_organisme_id = org.t_ref_organisme_id)
           left join t_ref_regime r_reg on (r_reg.t_ref_regime_id = r_org.t_ref_regime_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = org.t_ref_cp_ville_id)
      where repris = '1'
        and exists(select *
                   from t_client c
                   where c.t_organisme_amo_id = org.t_organisme_id)
      union
      select orgl.t_transfertlgpi_organisme_id,
             org.t_organisme_id,
             org.type_organisme,
             org.nom_reduit,
             org.commentaire,
             org.commentaire_bloquant,
             org.rue_1,
             org.rue_2,
             coalesce(cp.code_postal, org.code_postal),
             coalesce(cp.nom_ville, org.nom_ville),
             org.tel_personnel,
             org.tel_standard,
             org.tel_mobile,
             org.fax,
             org.org_reference,
             org.mt_seuil_tiers_payant,
             org.accord_tiers_payant,
             dest.t_transfertlgpi_destinataire_id,
             org.doc_facturation,
             org.type_releve,
             org.edition_releve,
             org.frequence_releve,
             org.mt_seuil_ed_releve,
             null,
             null,
             null,
             org.fin_droits_org_amc,
             org.org_circonscription,
             org.org_conventionne,
             org.nom,
             org.identifiant_national,
             org.prise_en_charge_ame,
             org.application_mt_mini_pc,
             org.type_contrat,
             org.saisie_no_adherent
      from t_organisme org
           left join t_transfertlgpi_destinataire dest on (dest.t_destinataire_id = org.t_destinataire_id)
           left join t_transfertlgpi_organisme orgl on (orgl.t_organisme_id = org.t_organisme_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = org.t_ref_cp_ville_id)
      where org.type_organisme = '2'
        and repris = '1'
      into :AIDOrganismeAMCLGPI,
           :AIDOrganisme,
           :ATypeOrganisme,
           :ANomReduit,
           :ACommentaire,
           :ACommentaireBloquant,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax,
           :AOrgReference,
           :AMtSeuilTiersPayant,
           :AAccordTiersPayant,
           :AIDDestinataire,
           :ADocFacturation,
           :ATypeReleve,
           :AEditionReleve,
           :AFrequenceReleve,
           :AMtSeuilEdReleve,
           :ARegime,
           :ACaisseGestionnaire,
           :ACentreGestionnaire,
           :AFinDroitsOrgAMC,
           :AOrgCirconscription,
           :AOrgConventionne,
           :ANom,
           :AIdentifiantNational,
           :APriseEnChargeAME,
           :AApplicationMtMiniPC,
           :ATypeContrat,
           :ASaisieNoAdherent do
        suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_couverture_amc
returns(
  AIDCouvertureAMC varchar(50),
  AIDCouvertureAMCLGPI integer,
  AIDOrganismeAMC integer,
  ALibelle varchar(60),
  AMontantFranchise numeric(10,2),
  APlafondPriseEnCharge numeric(10,2),
  ACouvertureCMU char(1))
as
begin
  for select camcl.t_transfertlgpi_couv_amc_id,
       cmc.t_cnv_couverture_amc_id,
       org.t_transfertlgpi_organisme_id,
       camc.libelle,
       camc.montant_franchise,
       camc.plafond_prise_en_charge,
       camc.couverture_cmu   
    from t_cnv_couverture_amc cmc
     inner join t_couverture_amc camc on (camc.t_couverture_amc_id = cmc.t_couverture_amc_id)
     inner join t_transfertlgpi_organisme org on (org.t_organisme_id = camc.t_organisme_amc_id)
     left join t_transfertlgpi_couverture_amc camcl on (camcl.t_couverture_amc_id = cmc.t_cnv_couverture_amc_id)
      into :AIDCouvertureAMCLGPI,
           :AIDCouvertureAMC,
           :AIDOrganismeAMC,
           :ALibelle,
           :AMontantFranchise,
           :APlafondPriseEnCharge,
           :ACouvertureCMU do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_taux_pc
returns(
  AIDCouvertureAMC integer,
  APrestation varchar(3),
  ATaux numeric(10,2),
  AFormule varchar(3))
as
begin
  for select camc.t_transfertlgpi_couv_amc_id,
             pr.code,
             tpc.taux,
              coalesce(tpc.formule, couv.formule) 
      from t_cnv_taux_prise_en_charge tpc
            inner join t_cnv_couverture_amc couv on ( couv.t_cnv_couverture_amc_id = tpc.t_couverture_amc_id )  
           inner join t_ref_prestation pr on (pr.t_ref_prestation_id = tpc.t_ref_prestation_id)
           inner join t_transfertlgpi_couverture_amc camc on (camc.t_couverture_amc_id = tpc.t_couverture_amc_id)      
      into :AIDCouvertureAMC,
           :APrestation,
           :ATaux,
     :AFormule       do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_creer_ccc
as
declare variable AIDOrganismeamo integer;
declare variable numero_insee varchar(15);
declare variable code_postal varchar(5);
declare variable nom_ville varchar(30);
declare variable code_caisse dm_varchar3;
declare variable NIR_homme dm_varchar15;
declare variable NIR_femme dm_varchar15;
declare variable t_organisme_amo_ccc_id dm_code;
declare variable t_couverture_amo_ccc_id dm_code;
begin

  -- clients fictifs contraception
  -- recherche de la caisse par defaut 
  select caisse_gestionnaire,
         t_organisme_id,
         code_postal,
         nom_ville
  from t_organisme
  where t_organisme_id = (select first 1 t_organisme_amo_id
                          from t_client
                          where t_organisme_amo_id is not null
                          and T_CNV_COUVERTURE_AMC_ID is not null
                          group by t_organisme_amo_id
                          order by count(*) desc)
  into :code_caisse,
       :t_organisme_amo_ccc_id,
       :code_postal,
       :nom_ville;

  if (:code_caisse is not null) then
  begin 
      --recuperation de la couverture de base
      select first 1 t_couverture_amo_id 
      from t_couverture_amo
      where t_organisme_amo_id = :t_organisme_amo_ccc_id
      and (( justificatif_exo = 0 and nature_assurance = 10 )
      or ( T_REF_COUVERTURE_AMO_ID = 432 )) 
      into :t_couverture_amo_ccc_id;

      if (:t_couverture_amo_ccc_id is not null) then
      begin  
          NIR_homme = '1555555'||:code_caisse||'042';
          NIR_femme = '2555555'||:code_caisse||'042';

          select t_transfertlgpi_organisme_id
          from t_transfertlgpi_organisme 
          where t_organisme_id = :t_organisme_amo_ccc_id
          into :AIDorganismeamo;

          if (not(exists(select null 
                         from t_client 
                         where (numero_insee =:NIR_homme||f_cle_ss(:NIR_homme)
                         and t_organisme_amo_id is not null )
                         or t_client_id = :NIR_homme))) then
          
          begin
            numero_insee= :NIR_homme||f_cle_ss(:NIR_homme);
            insert into t_client(t_client_id,
                                 numero_insee,
                                 nom,
                                 prenom, 
                                 qualite,
                                 rang_gemellaire,
                                 mode_gestion_amc,
                                 t_organisme_amo_id,
                                 code_postal,
                                 nom_ville,
                                 rue_1,
                                 commentaire_global_bloquant,
                                 commentaire_individuel_bloquant
                                 )
            values(:NIR_homme,
                   :numero_insee,
                   'Contraceptif',
                   'Homme',
                   '0',
                   1,
                   2,
                   :t_organisme_amo_ccc_id,
                   :code_postal,
                   :nom_ville,
                   'Création automatique',
                   '0',
                   '0'
              );
            
            insert into t_couverture_amo_client values(next value for seq_couverture_amo_client,
                                                       :NIR_homme,
                                                       :t_couverture_amo_ccc_id,
                                                       cast(extract(year from current_date) || '-01-01' as date),
                                                       null);
          end 

          if (not(exists(select null 
                         from t_client 
                         where (numero_insee =:NIR_femme||f_cle_ss(:NIR_femme)
                         and t_organisme_amo_id is not null)
                         or t_client_id = :NIR_femme))) then
          begin
            numero_insee= :NIR_femme||f_cle_ss(:NIR_femme);
            insert into t_client(t_client_id,
                                 numero_insee,
                                 nom,
                                 prenom, 
                                 qualite,
                                 rang_gemellaire,
                                 mode_gestion_amc,
                                 t_organisme_amo_id,
                                 code_postal,
                                 nom_ville,
                                 rue_1,
                                 commentaire_global_bloquant,
                                 commentaire_individuel_bloquant
                                 )
            values(:NIR_femme,
                   :numero_insee,
                   'Contraceptif',
                   'Femme',
                   '0',
                   1,
                   2,
                   :t_organisme_amo_ccc_id,
                   :code_postal,
                   :nom_ville,
                   'Création automatique',
                   '0',
                   '0'
              );

             insert into t_couverture_amo_client values(next value for seq_couverture_amo_client,
                                                       :NIR_femme,
                                                       :t_couverture_amo_ccc_id,
                                                       cast(extract(year from current_date) || '-01-01' as date),
                                                       null
              );
          end
        end
      end
end;



/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_client
returns(
  AIDClient varchar(50),
  AIDClientLGPI integer,
  ANumeroInsee varchar(15),
  ANom varchar(50),
  APrenom varchar(50),
  ANomJeuneFille varchar(50),
  ACommentaireGlobal varchar(2000),
  ACommentaireGlobalBloquant char(1),
  ACommentaireIndividuel varchar(2000),
  ACommentaireIndividuelBloquant char(1),
  ADateNaissance varchar(8),
  AQualite varchar(2),
  ARangGemellaire numeric(1),
  ACentreGestionnaire varchar(4),
  ANumeroAdherentMutuelle varchar(16),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20),
  AEmail varchar(50),
  ADateValiditePieceJustif date,
  AIDOrganismeAMO integer,
  AInformationsAMC varchar(150),
  AIDOrganismeAMC integer,
  AIDCouvertureAMC integer,
  ADebutDroitAMC date,
  AAttestationAMEComplementaire char(1),
  AFinDroitAMC date,
  ADateDerniereVisite date,
  AActivite varchar(50),
  ANumeroIdentifiantAMC varchar(20),
  AModeGestionAMC char(1),
  AGenre char(1),
  AIDProfilremise varchar(50),
  ARefExterne varchar(20)
  )
as
begin


  execute procedure ps_transfertlgpi_creer_ccc; 

  for select clil.t_transfertlgpi_client_id,
             cli.t_client_id,
             cli.numero_insee,
             cli.nom,
             cli.prenom,
             cli.nom_jeune_fille,
             cli.commentaire_global,
             cli.commentaire_global_bloquant,
             cli.commentaire_individuel,
             cli.commentaire_individuel_bloquant,
             cli.date_naissance,
             cli.qualite,
             cli.rang_gemellaire,
             cli.centre_gestionnaire,
             cli.numero_adherent_mutuelle,
             cli.rue_1,
             cli.rue_2,
             coalesce(cp.code_postal, cli.code_postal),
             coalesce(cp.nom_ville, cli.nom_ville),
             cli.tel_personnel,
             cli.tel_standard,
             cli.tel_mobile,
             cli.fax,
             cli.email,
             cli.date_validite_piece_justif,
             orgamo.t_transfertlgpi_organisme_id,
             orgamc.nom || iif(couvamc.libelle is null, '', '/' || couvamc.libelle),
             lorgamc.t_transfertlgpi_organisme_id,
             lcouvamc.t_transfertlgpi_couv_amc_id,
             cli.debut_droit_amc,
             cli.attestation_ame_complementaire,
             cli.fin_droit_amc,
             cli.date_derniere_visite,
             cli.activite,
             orgamc.identifiant_national,
             cli.mode_gestion_amc,
             cli.genre,
             cli.ref_externe,
             pr.t_transfertlgpi_profil_rem_id
      from t_client cli
           left join t_transfertlgpi_organisme orgamo on (orgamo.t_organisme_id = cli.t_organisme_amo_id)
           left join t_transfertlgpi_organisme lorgamc on (lorgamc.t_organisme_id = cli.t_organisme_amc_id)
           left join t_organisme orgamc on (orgamc.t_organisme_id = cli.t_organisme_amc_id)
           left join t_cnv_couverture_amc cnv_couvamc on (cnv_couvamc.t_cnv_couverture_amc_id = cli.t_cnv_couverture_amc_id)
           left join t_couverture_amc couvamc on (couvamc.t_couverture_amc_id = cnv_couvamc.t_couverture_amc_id)
           left join t_transfertlgpi_couverture_amc lcouvamc on (lcouvamc.t_couverture_amc_id = cli.t_cnv_couverture_amc_id)
           left join t_transfertlgpi_client clil on (clil.t_client_id = cli.t_client_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = cli.t_ref_cp_ville_id)
           left join t_transfertlgpi_profil_remise pr on ( pr.t_profil_remise_id = cli.t_profil_remise_id )
      where cli.repris = '1'
      into :AIDClientLGPI,
           :AIDClient,
           :ANumeroInsee,
           :ANom,
           :APrenom,
           :ANomJeuneFille,
           :ACommentaireGlobal,
           :ACommentaireGlobalBloquant,
           :ACommentaireIndividuel,
           :ACommentaireIndividuelBloquant,
           :ADateNaissance,
           :AQualite,
           :ARangGemellaire,
           :ACentreGestionnaire,
           :ANumeroAdherentMutuelle,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax,
           :AEmail,
           :ADateValiditePieceJustif,
           :AIDOrganismeAMO,
           :AInformationsAMC,
           :AIDOrganismeAMC,
           :AIDCouvertureAMC,
           :ADebutDroitAMC,
           :AAttestationAMEComplementaire,
           :AFinDroitAMC,
           :ADateDerniereVisite,
           :AActivite,
           :ANumeroidentifiantamc,
           :AModeGestionAMC,
           :AGenre,
           :ARefExterne,
           :AIDProfilremise
       do
    suspend;
end;


/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_couv_amo_cli
returns (
    aidclient integer,
    aidorganismeamo integer,
    acodecouvertureamo varchar(5),
    adebutdroitamo date,
    afindroitamo date,
    acentregestionnaire varchar(4))
as
declare variable strclient varchar(50);
declare variable intnbcouverturenonald integer;
begin
  for select distinct c.t_client_id
      from t_transfertlgpi_client c
           inner join t_couverture_amo_client camo on (camo.t_client_id = c.t_client_id)
      into :strClient do
      
    -- recherche des couv *** en cours de validité uniquement
    begin
        -- avec fusion ALD / non ALD
        for select 
                   c.t_transfertlgpi_client_id, 
                   max(couv.ald)||max(substring(coalesce(rca.code_couverture,'10100') from 2 for 4)),
                   min(cac.debut_droit_amo),
                   max(cac.fin_droit_amo),
                   cli.centre_gestionnaire,
                   corg.t_transfertlgpi_organisme_id    
            from t_couverture_amo_client cac
                 inner join t_transfertlgpi_client c on (c.t_client_id = cac.t_client_id)
                 inner join t_couverture_amo couv on (couv.t_couverture_amo_id = cac.t_couverture_amo_id)
                 inner join t_client cli on (cli.t_client_id = cac.t_client_id)
                 inner join t_transfertlgpi_organisme corg on (corg.t_organisme_id = cli.t_organisme_amo_id)        
                 left join t_ref_couverture_amo rca on (rca.t_ref_couverture_amo_id = couv.t_ref_couverture_amo_id) 
            where cac.t_client_id = :strClient
            and ( cac.debut_droit_amo <= current_date
            and ( cac.fin_droit_amo >= current_date or cac.fin_droit_amo is null )   )
            and ( rca.code_couverture is not null or couv.ald = 1  )
            and ( rca.code_couverture not like '9%' or rca.code_couverture is null  )
            group by  
                   c.t_transfertlgpi_client_id, 
                   cli.centre_gestionnaire,
                   corg.t_transfertlgpi_organisme_id   
            into :AIDClient,
                 :ACodeCouvertureAMO,
                 :ADebutDroitAmo,
                 :AFinDroitAmo,
                 :ACentreGestionnaire,
     :Aidorganismeamo do 
  suspend;
  -- couvertures passée ou futures , traitees en individuel sauf les couv en 9****
        for select 
                   c.t_transfertlgpi_client_id, 
                   iif(couv.ald = 1 and rca.code_couverture is null, '10100' , couv.ald || substring(rca.code_couverture from 2 for 4) ),
                   cac.debut_droit_amo,
                   cac.fin_droit_amo,
                   cli.centre_gestionnaire,
                   corg.t_transfertlgpi_organisme_id    
            from t_couverture_amo_client cac
                 inner join t_transfertlgpi_client c on (c.t_client_id = cac.t_client_id)
                 inner join t_couverture_amo couv on (couv.t_couverture_amo_id = cac.t_couverture_amo_id)
                 inner join t_client cli on (cli.t_client_id = cac.t_client_id)
                 inner join t_transfertlgpi_organisme corg on (corg.t_organisme_id = cli.t_organisme_amo_id)        
                 left join t_ref_couverture_amo rca on (rca.t_ref_couverture_amo_id = couv.t_ref_couverture_amo_id) 
            where cac.t_client_id = :strClient
            and not( cac.debut_droit_amo <= current_date
            and ( cac.fin_droit_amo >= current_date or cac.fin_droit_amo is null ) )
            and ( rca.code_couverture not like '9%' ) 

            into :AIDClient,
                 :ACodeCouvertureAMO,
                 :ADebutDroitAmo,
                 :AFinDroitAmo,
                 :ACentreGestionnaire,
     :Aidorganismeamo do 
  suspend;    
   -- couv en 9****
           for select 
                   c.t_transfertlgpi_client_id, 
                   rca.code_couverture,
                   cac.debut_droit_amo,
                   cac.fin_droit_amo,
                   cli.centre_gestionnaire,
                   corg.t_transfertlgpi_organisme_id    
            from t_couverture_amo_client cac
                 inner join t_transfertlgpi_client c on (c.t_client_id = cac.t_client_id)
                 inner join t_couverture_amo couv on (couv.t_couverture_amo_id = cac.t_couverture_amo_id)
                 inner join t_client cli on (cli.t_client_id = cac.t_client_id)
                 inner join t_transfertlgpi_organisme corg on (corg.t_organisme_id = cli.t_organisme_amo_id)        
                 left join t_ref_couverture_amo rca on (rca.t_ref_couverture_amo_id = couv.t_ref_couverture_amo_id) 
            where cac.t_client_id = :strClient
            and ( rca.code_couverture like'9%' ) 

            into :AIDClient,
                 :ACodeCouvertureAMO,
                 :ADebutDroitAmo,
                 :AFinDroitAmo,
                 :ACentreGestionnaire,
     :Aidorganismeamo do 
  suspend;    
    end                               
end;



/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_mandataire
returns(
  AIDClient integer,
  AIDMandataire integer,
  ATypeLien integer)
as
begin
  for select clilgpi.t_transfertlgpi_client_id,
             mdtlgpi.t_transfertlgpi_client_id,
             mdt.type_lien
      from t_mandataire mdt
           inner join t_transfertlgpi_client clilgpi on (clilgpi.t_client_id = mdt.t_client_id)
           inner join t_transfertlgpi_client mdtlgpi on (mdtlgpi.t_client_id = mdt.t_mandataire_id)
      into :AIDClient,
           :AIDMandataire,
           :ATypeLien do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_fourn_direct
returns (
    aidfournisseur varchar(50),
    aidfournisseurlgpi integer,
    araisonsociale varchar(50),
    ATypeFournisseur char(1),
    AN171Identifiant varchar(8),
    AN171NumeroAppel varchar(20),
    acommentaire varchar(200),
    AN171Vitesse char(1),
    amodetransmission char(1),
    arue1 varchar(40),
    arue2 varchar(40),
    acodepostal varchar(5),
    ANomville varchar(30),
    APays varchar(30),
    atelpersonnel varchar(20),
    atelstandard varchar(20),
    atelmobile varchar(20),
    afax varchar(20),
    arepresentepar varchar(50),
    ATelephoneRepresentant varchar(20),
    AMobileRepresentant varchar(20),
    anumerofax varchar(20),
    AFDPartenaire char(1),
    AFDCodePartenaire numeric(4,0),
    ARepDefaut char(1),
    ARepObjectifCAMensuel numeric(10,2),
    ARepPharmaMLRefID numeric(3),
    ARepPharmaMLURL1 varchar(150),
    ARepPharmaMLURL2 varchar(150),
    ARepPharmaMLIDOfficine varchar(20),
    ARepPharmaMLIDMagasin varchar(20),
    ARepPharmaMLCle varchar(4),
    AFDCodeSel varchar(20),
    AEmail varchar(50),
    AEmailRepresentant varchar(50)
    )
as
begin
  ATypeFournisseur = 'D';
  ARepDefaut = '0';

  for select distinct fou.t_fournisseur_direct_id,
                      foul.t_transfertlgpi_fourn_direct_id,
                      fou.raison_sociale,
                      fou.identifiant_171,
                      fou.numero_appel,
                      fou.commentaire,
                      fou.vitesse_171,
                      fou.mode_transmission,
                      fou.rue_1,
                      fou.rue_2,
                      coalesce(cp.code_postal, fou.code_postal),
                      coalesce(cp.nom_ville, fou.nom_ville),
                      fou.tel_personnel,
                      fou.tel_standard,
                      fou.tel_mobile,
                      fou.fax,
                      fou.fournisseur_partenaire,
                      fou.represente_par,
                      fou.telephone_representant,
                      fou.numero_fax,
                      fou.code_partenaire,
                      fou.code_sel,
                      fou.email,
                      fou.email_representant,
                      fou.mobile_representant,
                      fou.pharmaml_ref_id,
                      fou.pharmaml_url_1,
                      fou.pharmaml_url_2,
                      fou.pharmaml_id_officine,
                      fou.pharmaml_id_magasin,
                      fou.pharmaml_cle
      from t_fournisseur_direct fou
           left join t_transfertlgpi_fourn_direct foul on (foul.t_fournisseur_direct_id = fou.t_fournisseur_direct_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = fou.t_ref_cp_ville_id)
      into :AIDFournisseur,
           :AIDFournisseurLGPI,
           :ARaisonSociale,
           :AN171Identifiant,
           :AN171NumeroAppel,
           :ACommentaire,
           :AN171Vitesse,
           :AModeTransmission,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax,
           :AFDPartenaire,
           :ARepresentePar,
           :ATelephoneRepresentant,
           :ANumeroFax,
           :AFDCodePartenaire,
           :AFDCodeSel,
           :AEmail,
           :AEmailRepresentant,
           :AMobileRepresentant,
           :ARepPharmaMLRefID,
           :ARepPharmaMLURL1,
           :ARepPharmaMLURL2,
           :ARepPharmaMLIDOfficine,
           :ARepPharmaMLIDMagasin,
           :ARepPharmaMLCle

    do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_repartiteur
returns (
  AIDRepartiteur varchar(50),
  AIDFournisseurLGPI integer,
  ATypeFournisseur char(1),
  ARaisonSociale varchar(50),
  AN171Identifiant varchar(9),
  AN171NumeroAppel varchar(20),
  ACommentaire varchar(200),
  AN171Vitesse char(1),
  AModeTransmission char(1),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20),
  ARepresentePar varchar(50),
  ATelephoneRepresentant varchar(16),
  AMobileRepresentant varchar(16),
  ANumeroFax varchar(20),
  AFDPartenaire char(1),
  AFDCodePartenaire numeric(4),
  ARepDefaut char(1),
  ARepObjectifCAmensuel varchar(50),
  ARepPharmaMLRefID numeric(3),
  ARepPharmaMLURL1 varchar(150),
  ARepPharmaMLURL2 varchar(150),
  ARepPharmaMLIDOfficine varchar(20),
  ARepPharmaMLIDMagasin varchar(20),
  ARepPharmaMLCle varchar(4),
  AFDCodeSel varchar(20),
  AEmail varchar(50),
  AEmailRepresentant varchar(50))
as
begin
  ATypeFournisseur = 'R';
  AFDPartenaire = '0';

  for select rep.t_repartiteur_id,
             repl.t_transfertlgpi_repartiteur_id,
             rep.raison_sociale,
             rep.identifiant_171,
             rep.numero_appel,
             rep.commentaire,
             rep.vitesse_171,
             rep.mode_transmission,
             rep.rue_1,
             rep.rue_2,
             coalesce(cp.code_postal, rep.code_postal),
             coalesce(cp.nom_ville, rep.nom_ville),
             rep.tel_personnel,
             rep.tel_standard,
             rep.tel_mobile,
             rep.fax,
             rep.defaut,
             rep.numero_fax,
             rep.objectif_ca_mensuel,
             rep.pharmaml_ref_id,
             rep.pharmaml_url_1,
             rep.pharmaml_url_2,
             rep.pharmaml_id_officine,
             rep.pharmaml_id_magasin,
             rep.pharmaml_cle
      from t_repartiteur rep
           left join t_transfertlgpi_repartiteur repl on (repl.t_repartiteur_id = rep.t_repartiteur_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = rep.t_ref_cp_ville_id)
      into :AIDRepartiteur,
           :AIDFournisseurLGPI,
           :ARaisonSociale,
           :AN171Identifiant,
           :AN171NumeroAppel,
           :ACommentaire,
           :AN171Vitesse,
           :AModeTransmission,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax,
           :ARepDefaut,
           :ANumeroFax,
           :ARepObjectifCAmensuel,
           :ARepPharmaMLRefID,
           :ARepPharmaMLURL1,
           :ARepPharmaMLURL2,
           :ARepPharmaMLIDOfficine,
           :ARepPharmaMLIDMagasin,
           :ARepPharmaMLCle do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_codification
returns(
  AIDCodification integer,
  ACode varchar(50),
  ALibelle varchar(50),
  ARang char(1),
  ATauxMarque numeric(4,3))
as
begin
  for select t_codification_id,
             code,
             libelle,
             rang,
             taux_marque
      from t_codification
      into :AIDCodification,
           :ACode,
           :ALibelle,
           :ARang,
           :ATauxMarque do
   suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_zone_geo
returns(
  AIDZoneGeographique varchar(50),
  ALibelle varchar(50))
as
begin
  for select t_zone_geographique_id,
             libelle
      from t_zone_geographique
      into :AIDZoneGeographique,
           :ALibelle do
   suspend;
end;

/* ********************************************************************************************** */

create or alter procedure ps_transfertlgpi_article_remise
  returns(
    AIDArticleRemise varchar(50),
    AIDArticleRemiseLGPI integer,
    ACode varchar(10),
    ALibelle varchar(50))
as
begin
  for select t_article_remise_id,
             code,
             libelle
      from t_article_remise
      into :AIDArticleRemise,
           :ACode,
           :ALibelle do
    suspend;           
end; 


/* ********************************************************************************************** */

create or alter procedure ps_eans (
    t_produit_id dm_code
) returns (
eans blob sub_type text )
as

declare variable code_ean dm_code_cip;
begin
    eans = '(';
    for select CODE_EAN13 
        from T_CODE_EAN13 
        where code_ean13 not like '20000%' and t_produit_id = :t_produit_id
        into :code_ean do
          eans = :eans ||' '''||:code_ean ||''',' ;
          
    eans = eans || ')';      
    eans = replace(:eans, ',)',  ')' );     
    suspend; 
           
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_produit
returns (
  AIDProduit varchar(50),
  AIDProduitLGPI integer,
  ACodeCIP dm_code_cip,
  ACodesEAN varchar(1000),
  ADesignation varchar(50),
  APrixAchatCatalogue numeric(10,3),
  APrixVente numeric(10,2),
  AEtat char(1),
  AGereInteressement char(1),
  ACommentaireVente varchar(200),
  AEditionEtiquette char(1),
  ACommentaireCommande varchar(200),
  ACommentaireGestion varchar(200),
  AGereSuiviClient char(1),
  AListe char(1),
  ATracabilite char(1),
  ATarifAchatUnique char(1),
  AGerePFC char(1),
  ASoumisMdl char(1),
  AIDClassificationInterne integer,
  AVeterinaire char(1),
  ATypeHomeo char(1),
  AStockMini numeric(5),
  AStockMaxi numeric(5),
  ADateDerniereVente date,
  ADatePremiereVente date,
  ABaseRemboursement numeric(10,2),
  ADelaiLait numeric(3),
  ADelaiViande numeric(3),
  APrestation varchar(3),
  AlotAchat numeric(5),
  ALotVente numeric(5),
  ANombreMoisCalcul numeric(2),
  AConditionnement numeric(3),
  AMoyenneVente numeric(6,1),
  AUniteMoyenneVente numeric(5),
  AContenance numeric(5),
  APrixAchatRemise numeric(10,3),
  AServiceTips char(1),
  ATauxTVA numeric(5,2),
  APAMP numeric(10,3),
  AUniteMesure char(1),
  AProfilGS char(1),
  ACalculGS char(1),
  AMarque varchar(50),
  AIDRepartiteurExclusif integer,
  AQuantite numeric(5),
  AZoneGeographique varchar(50),
  AStockMiniPharmacie numeric(5),
  AStockMaxiPharmacie numeric(5),
  ACodification1 varchar(50),
  ACodification2 varchar(50),
  ACodification3 varchar(50),
  ACodification4 varchar(50),
  ACodification5 varchar(50),
  ADatePeremption date,
  APrixAchatMetropole numeric(10,3),
  APrixVenteMetropole numeric(10,2),
  ACodeCip7 dm_code_cip7,
  AIDArticleRemise integer)
as
declare variable no_check integer;
declare variable eans varchar(1000);
begin

  delete from t_cip13_generes;
  select count(*) from t_produit where code_cip like '2000%' into :no_check;
  if (row_count = 0) then no_check = 0;


  begin
    execute procedure ps_inserer_ref_produits;
    when any do
    insert into t_fct_console values(next value for seq_fct_console,
                                     current_time,
                                     'Produits de réference non créés',
                                     1 
    );
  end

  for select prd.t_produit_id,
             prdl.t_transfertlgpi_produit_id,
             prd.code_cip,
             prd.designation,
             prd.prix_achat_catalogue,
             prd.prix_vente,
             prd.etat,
             prd.gere_interessement,
             prd.commentaire_vente,
             prd.edition_etiquette,
             prd.commentaire_commande,
             prd.commentaire_gestion,
             prd.gere_suivi_client,
             prd.liste,
             prd.tracabilite,
             prd.tarif_achat_unique,
             prd.gere_pfc,
             prd.soumis_mdl,
             prd.veterinaire,
             prd.type_homeo,
             prd.stock_mini,
             prd.stock_maxi,
             prd.date_derniere_vente,
             null,
             prd.base_remboursement,
             prd.delai_lait,
             prd.delai_viande,
             pr.code,
             prd.lot_achat,
             prd.lot_vente,
             prd.nombre_mois_calcul,
             prd.conditionnement,
             prd.moyenne_vente,
             prd.unite_moyenne_vente,
             prd.contenance,
             prd.prix_achat_remise,
             prd.service_tips,
             tva.taux,
             prd.pamp,
             prd.unite_mesure,
             prd.profil_gs,
             prd.calcul_gs,
             cdf6.libelle,
             lgpirep.t_transfertlgpi_repartiteur_id,
             pg.quantite,
             pg.stock_mini,
             pg.stock_maxi,
             zg.libelle,
             cdf1.libelle,
             cdf2.libelle,
             cdf3.libelle,
             cdf4.libelle,
             cdf5.libelle,
             prd.date_peremption,
             prd.prix_achat_metropole,
             prd.prix_vente_metropole,
             null, -- plus utilisé
             arl.t_transfertlgpi_art_rem_id
      from t_produit prd
           inner join t_ref_prestation pr on (pr.t_ref_prestation_id = prd.t_ref_prestation_id)
           left join t_ref_tva tva on (tva.t_ref_tva_id = prd.t_ref_tva_id)
           left join t_transfertlgpi_repartiteur lgpirep on (lgpirep.t_repartiteur_id = prd.t_repartiteur_id)
           left join t_repartiteur rep on (rep.t_repartiteur_id = prd.t_repartiteur_id)
           left join (select t_produit_id, t_zone_geographique_id, quantite, stock_mini, stock_maxi
                      from t_produit_geographique
                      where t_depot_id = '2') pg on (pg.t_produit_id = prd.t_produit_id)
           left join t_zone_geographique zg on (zg.t_zone_geographique_id = pg.t_zone_geographique_id)
           left join t_codification cdf1 on (cdf1.t_codification_id = prd.t_codif_1_id)
           left join t_codification cdf2 on (cdf2.t_codification_id = prd.t_codif_2_id)
           left join t_codification cdf3 on (cdf3.t_codification_id = prd.t_codif_3_id)
           left join t_codification cdf4 on (cdf4.t_codification_id = prd.t_codif_4_id)
           left join t_codification cdf5 on (cdf5.t_codification_id = prd.t_codif_5_id)
           left join t_codification cdf6 on (cdf6.t_codification_id = prd.t_codif_6_id)
           left join t_transfertlgpi_produit prdl on (prdl.t_produit_id = prd.t_produit_id)
           left join t_transfertlgpi_art_rem arl on (arl.t_article_remise_id = prd.t_article_remise_id)

      where prd.repris = '1'

      into :AIDProduit,
           :AIDProduitLGPI,
           :ACodeCIP,
           :ADesignation,
           :APrixAchatCatalogue,
           :APrixVente,
           :AEtat,
           :AGereInteressement,
           :ACommentaireVente,
           :AEditionEtiquette,
           :ACommentaireCommande,
           :ACommentaireGestion,
           :AGereSuiviClient,
           :AListe,
           :ATracabilite,
           :ATarifAchatUnique,
           :AGerePFC,
           :ASoumisMdl,
           :AVeterinaire,
           :ATypeHomeo,
           :AStockMini,
           :AStockMaxi,
           :ADateDerniereVente,
           :ADatePremiereVente,
           :ABaseRemboursement,
           :ADelaiLait,
           :ADelaiViande,
           :APrestation,
           :AlotAchat,
           :ALotVente,
           :ANombreMoisCalcul,
           :AConditionnement,
           :AMoyenneVente,
           :AUniteMoyenneVente,
           :AContenance,
           :APrixAchatRemise,
           :AServiceTips,
           :ATauxTVA,
           :APAMP,
           :AUniteMesure,
           :AProfilGS,
           :ACalculGS,
           :AMarque,
           :AIDRepartiteurExclusif,
           :AQuantite,
           :AStockMiniPharmacie,
           :AStockMaxiPharmacie,
           :AZoneGeographique,
           :ACodification1,
           :ACodification2,
           :ACodification3,
           :ACodification4,
           :ACodification5,
           :ADatePeremption,
           :APrixAchatMetropole,
           :APrixVenteMetropole,
           :ACodeCip7,
           :AIDArticleRemise
       do
       begin
          execute procedure ps_eans(:AIdProduit) returning_values :AcodesEAN; 
          eans = :eans;
       
          if (  (Acodecip is null ) and  ( ( :Acodecip7 not similar to '[[:DIGIT:]]*') or (:Acodecip7 like '%X%')  ) ) then 
          begin
            execute procedure ps_generer_cip13(:no_check) returning_values :ACodeCip;
            insert into t_cip13_generes values (:ACodeCip7 ,:ACodeCip );
            ACodeCip7 = null;  
          end
          suspend;         
       end
end;
 


/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_stup
returns (ACodeCIP dm_code_cip)
as
begin
  for select prd.code_cip
      from t_produit prd
      where prd.repris = '1'
        and code_cip in ( select code_cip from t_ref_produit_stup)
      into :ACodecip do
      suspend;         
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_info_stock
returns(
  AIDProduit integer,
  AQuantite numeric(5),
  AIDDepot integer,
  AStockMini numeric(5),
  AStockMaxi numeric(5),
  AZoneGeographique varchar(50))
as
begin
  for select p.t_transfertlgpi_produit_id,
             zg.libelle,
             d.t_transfertlgpi_depot_id,
             pg.quantite,
             pg.stock_mini,
             pg.stock_maxi
      from t_produit_geographique pg
           inner join t_transfertlgpi_produit p on (p.t_produit_id = pg.t_produit_id)
           left join t_zone_geographique zg on (zg.t_zone_geographique_id = pg.t_zone_geographique_id)
           inner join t_transfertlgpi_depot d on (d.t_depot_id = pg.t_depot_id)
      into :AIDProduit,
           :AZoneGeographique,
           :AIDDepot,
           :AQuantite,
           :AStockmini,
           :AStockMaxi do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_code_ean13
returns(
  AIDProduit integer,
  ACodeEAN13 varchar(13),
  AReferent dm_boolean)
as
begin
  for select p.t_transfertlgpi_produit_id,
             c.code_ean13,
             c.referent
      from t_code_ean13 c
           inner join t_transfertlgpi_produit p on (p.t_produit_id = c.t_produit_id)
      into :AIDProduit,
           :ACodeEAN13,
           :AReferent do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_depot
returns(
  AIDDepot dm_code,
  ALibelle dm_libelle,
  AAutomate dm_boolean,
  AtypeDepot dm_type_depot
  )
as
begin
  for select d.t_depot_id,
             d.libelle,
             d.automate,
             d.type_depot
      from t_depot d
      into :AIDDepot,
           :ALibelle,
           :AAutomate,
           :ATypeDepot do
    suspend;
end;
/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_code_lpp
returns (
  AIDProduit integer,
  ATypeCode char(1),
  ACodeLPP varchar(13),
  AQuantite numeric(5),
  ATarifUnitaire numeric(10,2),
  APrestation varchar(3),
  AService char(1))
as
begin
  for select p.t_transfertlgpi_produit_id,
             l.type_code,
             l.code_lpp,
             l.quantite,
             l.tarif_unitaire,
             pr.code,
             l.service_tips
      from t_produit_lpp l
           inner join t_transfertlgpi_produit p on (p.t_produit_id = l.t_produit_id)
           left join t_ref_prestation pr on (pr.t_ref_prestation_id = l.t_ref_prestation_id)
      into :AIDProduit,
           :ATypeCode,
           :ACodeLPP,
           :AQuantite,
           :ATarifUnitaire,
           :APrestation,
           :AService do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_histo_vente
returns (
  AIDProduit integer,
  APeriode varchar(6),
  AQuantiteVendues numeric(5),
  AQuantiteActes numeric(5))
as
begin
  for select p.t_transfertlgpi_produit_id,             
             h.periode,
             h.quantite_actes,
             h.quantite_vendues
      from t_historique_vente h
           inner join t_transfertlgpi_produit p on (p.t_produit_id = h.t_produit_id)
      where h.repris = '1'
      into :AIDProduit,
           :APeriode,
           :AQuantiteActes,
           :AQuantiteVendues do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_commande
returns (
  AIDCommande varchar(50),
  AIDCommandeLGPI integer,
  ANumero integer,
  AModeTransmission char(1),
  ADateCreation date,
  AMontantHT numeric(10,2),
  ACommentaire varchar(200),
  AIDFournisseur integer,
  AIDRepartiteur integer,
  AEtat varchar(2),
  ADatereception date,
  ADatereceptionprevue date)
as
declare variable Numero integer;
begin
  for select distinct c.t_commande_id,
             cl.t_transfertlgpi_commande_id,
             c.numero,
             c.mode_transmission,
             c.date_creation,
             c.montant_ht,
             c.commentaire,
             f.t_transfertlgpi_fourn_direct_id,
             r.t_transfertlgpi_repartiteur_id,
             c.etat,
             c.date_reception,
             c.date_reception_prevue
      from t_commande_ligne l
           inner join t_commande c on (c.t_commande_id = l.t_commande_id)
           inner join t_produit p on (p.t_produit_id = l.t_produit_id)
           left join t_transfertlgpi_fourn_direct f on (f.t_fournisseur_direct_id = c.t_fournisseur_direct_id)
           left join t_transfertlgpi_repartiteur r on (r.t_repartiteur_id = c.t_repartiteur_id)
           left join t_transfertlgpi_commande cl on (cl.t_commande_id = c.t_commande_id)
      where (f.t_transfertlgpi_fourn_direct_id is not null or r.t_transfertlgpi_repartiteur_id is not null)
        and c.date_creation > current_date - 365*4
        -- limitation à 4 ans 
        and c.repris = '1'
      into :AIDCommande,
           :AIDCommandeLGPI,
           :ANumero,
           :AModeTransmission,
           :ADateCreation,
           :AMontantHt,
           :ACommentaire,
           :AIDFournisseur,
           :AIDRepartiteur,
           :AEtat,
           :ADatereception,
           :ADatereceptionprevue do
           begin

            if (ANumero is null) then
            begin
              Numero = cast(AIDCommande as integer);
              when any do Numero = null;
            end
            ANumero = coalesce(Anumero, Numero);
            suspend;
           end
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_commande_ligne
returns (
  AIDCommande varchar(50),
  ADateCreation date,
  AIDFournisseur integer,
  AIDRepartiteur integer,
  AIDProduit integer,
  AQuantiteCommandee numeric(5),
  AQuantiteRecue numeric(5),
  AQuantiteTotaleRecue numeric(5),
  APrixAchatTarif numeric(10,3),
  APrixAchatRemise numeric(10,3),
  APrixVente numeric(10,2),
  AChoixReliquat char(1),
  AUnitesGratuites numeric(5),
  AEtat varchar(2),
  AReceptionFinanciere char(1),
  AColisage numeric(5),
  ADateReceptionPrevue date)
as
begin
  for select c_lg.t_transfertlgpi_commande_id,
             c.date_creation,
             f.t_transfertlgpi_fourn_direct_id,
             r.t_transfertlgpi_repartiteur_id,
             p.t_transfertlgpi_produit_id,
             l.quantite_commandee,
             l.quantite_recue,
             l.quantite_totale_recue,
             l.prix_achat_tarif,
             l.prix_achat_remise,
             l.prix_vente,
             l.choix_reliquat,
             l.unites_gratuites,
             c.etat,
             l.reception_financiere,
             l.colisage,
             c.date_reception_prevue
      from t_commande_ligne l
           inner join t_transfertlgpi_produit p on (p.t_produit_id = l.t_produit_id)
           inner join t_transfertlgpi_commande c_lg on c_lg.t_commande_id = l.t_commande_id
           inner join t_commande c on (c.t_commande_id = l.t_commande_id)
           left join t_transfertlgpi_fourn_direct f on (f.t_fournisseur_direct_id = c.t_fournisseur_direct_id)
           left join t_transfertlgpi_repartiteur r on (r.t_repartiteur_id = c.t_repartiteur_id)
      into :AIDCommande,
           :ADateCreation,
           :AIDFournisseur,
           :AIDRepartiteur,
           :AIDProduit,
           :AQuantiteCommandee,
           :AQuantiteRecue,
           :AQuantiteTotaleRecue,
           :APrixAchatTarif,
           :APrixAchatRemise,
           :APrixVente,
           :AChoixReliquat,
           :AUnitesGratuites,
           :AEtat,
           :AReceptionFinanciere,
           :AColisage,
           :ADateReceptionPrevue do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_operateur
returns (
  AIDOperateur varchar(50),
  AIDOperateurLGPI integer,
  ACodeOperateur varchar(10),
  ANom varchar(50),
  APrenom varchar(50),
  AMotDePasse varchar(50),
  AActivationOperateur char(1),
  AGraviteInteraction char(1),
  ARechercheInt char(1))
as
begin
  for select op.t_operateur_id,
             opl.t_transfertlgpi_operateur_id,
             op.code_operateur,
             op.nom,
             op.prenom,
             op.mot_de_passe,
             op.activation_operateur,
             op.gravite_int,
             op.recherche_int
      from t_operateur op
           left join t_transfertlgpi_operateur opl on (opl.t_operateur_id = op.t_operateur_id)
      into :AIDOperateur,
           :AIDOperateurLGPI,
           :ACodeOperateur,
           :ANom,
           :APrenom,
           :AMotDePasse,
           :AActivationOperateur,
           :AGraviteInteraction,
           :ARechercheInt do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_histo_client
returns (
  AIDHistoriqueClientEntete varchar(50),
  AIDLGPIHistoriqueClientEntete integer,
  AIDClient integer,
  ANumeroFacture numeric(10),
  ADatePrescription date,
  ACodeOperateur varchar(10),
  ANomPraticien varchar(50),
  APrenomPraticien varchar(50),
  ATypeFacturation char(2),
  ADateActe date)
as
begin
  for select h.t_historique_client_id,
			 hist.t_transfertlgpi_histo_client_id,
             c.t_transfertlgpi_client_id,
             h.numero_facture,
             h.date_prescription,
             h.code_operateur,
             coalesce(h.nom_praticien, p.nom),
             coalesce(h.prenom_praticien, p.prenom),
             h.type_facturation,
             h.date_acte
      from t_historique_client h
           left join t_transfertlgpi_client c on (c.t_client_id = h.t_client_id)
           --left join t_transfertlgpi_praticien lp on (lp.t_praticien_id = h.t_praticien_id)
		   left join t_transfertlgpi_histo_client hist on (hist.T_HISTORIQUE_CLIENT_ID = h.T_HISTORIQUE_CLIENT_ID)
           left join t_praticien p on (p.t_praticien_id = h.t_praticien_id)
      where h.repris = '1'
      into :AIDHistoriqueClientEntete,
		   :AIDLGPIHistoriqueClientEntete,
           :AIDClient,
           :ANumeroFacture,
           :ADatePrescription,
           :ACodeOperateur,
           :ANomPraticien,
           :APrenomPraticien,
           :ATypeFacturation,
           :ADateActe do
    suspend;
end; 

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_histo_cli_lig
returns (
  AIDHistoriqueClientEntete integer,
  ACodeCIP dm_code_cip,
  AIDProduit integer,
  ADesignation varchar(50),
  AQuantitefacturee numeric(5),
  /*APrixAchat numeric(10,3),*/
  APrixAchat numeric(10,2),
  APrixVente numeric(10,2),
  AMontantNetHT numeric(10,2),
  AMontantNetTTC numeric(10,2),
  APrixAchatHTRemise numeric(10,2))
as
begin
  for select he.t_transfertlgpi_histo_client_id,             
             substring(hl.code_cip from 1 for 13),
             plgpi.t_transfertlgpi_produit_id,
             hl.designation,
             hl.quantite_facturee,
             hl.prix_achat,
             hl.prix_vente,
             hl.montant_net_ht,
             hl.montant_net_ttc,
             hl.prix_achat_ht_remise
      from t_transfertlgpi_histo_client he
           inner join t_historique_client_ligne hl on (hl.t_historique_client_id = he.t_historique_client_id)
       left join t_transfertlgpi_produit plgpi on (plgpi.t_produit_id = hl.t_produit_id)

	   
	   
	   --------------->>>>>>>>>>>>>>>>>>>>	   where hl.code_cip not in (select codecip from t_produit where t_ref_prestation_id in (select t_ref_prestation_id from t_ref_prestation where code like 'H%'))
      
	  
	  into :AIDHistoriqueClientEntete,
           :ACodeCIP,
           :AIDProduit,
           :ADesignation,
           :AQuantitefacturee,
           :APrixAchat,
           :APrixVente,
           :AMontantNetHT,
           :AMontantNetTTC,
           :APrixAchatHTRemise do
    suspend;
end;



/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_catalogue
returns(
  AIDCatalogue dm_code,
  AIDCatalogueLGPI dm_cle,
  ADesignation dm_code,
  ADateDebut dm_date,
  ADateFin dm_date,
  AIDFournisseur dm_cle,
  ADateCreation dm_date,
  ADateFinValidite dm_date)
as
begin
  for select c.t_catalogue_id,
             clgpi.t_transfertlgpi_catalogue_id,
             c.designation,
             c.date_debut,
             c.date_fin,
             flgpi.t_transfertlgpi_fourn_direct_id,
             c.date_creation,
             c.date_fin_validite
      from t_catalogue c
           inner join t_transfertlgpi_fourn_direct flgpi on (flgpi.t_fournisseur_direct_id = c.t_fournisseur_id)
           left join t_transfertlgpi_catalogue clgpi on (clgpi.t_catalogue_id = c.t_catalogue_id)
      into :AIDCatalogue,
           :AIDCatalogueLGPI,
           :Adesignation,
           :ADateDebut,
           :ADateFin,
           :AIDFournisseur,
           :ADateCreation,
           :ADateFinValidite do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_classif_four
returns(
  AIDClassifFournisseur dm_code,
  AIDClassifFournisseurLGPI dm_cle,
  ADesignation dm_varchar100,
  ADateDebutMarche dm_date,
  ADureeMarche dm_numeric3,
  AIDClassificationParent dm_cle,
  AIDCatalogue dm_cle)
as
begin
  for select cl.t_classification_fournisseur_id,
             cllgpi.t_transfertlgpi_classif_four_id,
             cl.designation,
             cl.date_debut_marche,
             cl.duree_marche,
             null,
             clgpi.t_transfertlgpi_catalogue_id
      from t_classification_fournisseur cl
           left join t_transfertlgpi_classif_four cllgpi on (cllgpi.t_classification_fournisseur_id = cl.t_classification_fournisseur_id)
           inner join t_transfertlgpi_catalogue clgpi on (clgpi.t_catalogue_id = cl.t_catalogue_id)
      where t_classification_parent_id is null
      into :AIDClassifFournisseur,
           :AIDClassifFournisseurLGPI,
           :ADesignation,
           :ADateDebutMarche,
           :ADureeMarche,
           :AIDClassificationParent,
           :AIDCatalogue do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_classif_int
returns(
  AIDClassifInterne dm_code,
  AIDClassifInterneLGPI dm_cle,
  ALibelle dm_libelle,  
  AIDClassificationParent dm_code,
  AIDClassificationParentLGPI dm_cle,
  ATauxMarque dm_taux_marque)
as
begin
  for select cl.t_classification_interne_id,
             cllgpi.t_transfertlgpi_classifint_id,
             cl.libelle,
             cl.t_class_interne_parent_id,
             clparentlgpi.t_transfertlgpi_classifint_id,
             cl.taux_marque
      from T_CLASSIFICATION_INTERNE cl
      left join t_transfertlgpi_classifint cllgpi on (cllgpi.t_classification_interne_id = cl.t_classification_interne_id)
      left join t_transfertlgpi_classifint clparentlgpi on (clparentlgpi.t_classification_interne_id = cl.t_class_interne_parent_id )
     
      into :AIDClassifInterne,
           :AIDClassifInterneLGPI,
           :ALibelle,
           :AIDClassificationParent,
           :AIDClassificationParentLGPI,
           :ATauxMarque do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_catalogue_lig
returns(
  AIDCatalogue dm_cle,
  ANoLigne dm_numeric5,
  AIDProduit dm_cle,
  AQuantite dm_quantite,
  AIDClassificationFournisseur dm_cle,
  APrixAchatCatalogue dm_prix_achat,
  APrixAchatRemise dm_prix_achat,
  ARemiseSimple dm_remise,
  ADateMAJTarif dm_date,
  ADateCreation dm_date,
  AColisage dm_numeric5)
as
begin
  for select clgpi.t_transfertlgpi_catalogue_id,
             cl.no_ligne,
             plgpi.t_transfertlgpi_produit_id,
             cl.quantite,
             cllgpi.t_transfertlgpi_classif_four_id,
             cl.prix_achat_catalogue,
             cl.prix_achat_remise,
             cl.remise_simple,
             cl.date_maj_tarif,
             cl.date_creation,
             cl.colisage
      from t_catalogue_ligne cl
           inner join t_transfertlgpi_catalogue clgpi on (clgpi.t_catalogue_id = cl.t_catalogue_id)
           inner join t_transfertlgpi_produit plgpi on (plgpi.t_produit_id = cl.t_produit_id)
           left join t_transfertlgpi_classif_four cllgpi on (cllgpi.t_classification_fournisseur_id = cl.t_classification_fournisseur_id)
      into :AIDCatalogue,
           :ANoLigne,
           :AIDProduit,
           :AQuantite,
           :AIDClassificationFournisseur,
           :APrixAchatCatalogue,
           :APrixAchatRemise,
           :ARemiseSimple,
           :ADateMAJTarif,
           :ADateCreation,
           :AColisage do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_promotion
returns(
  AIDPromotion varchar(50),
  AIDPromotionLGPI integer,
  ALibelle varchar(50),
  ADateDebut date,
  ADateFin date,
  ATypePromotion char,
  ADateCreation date,
  ADatemaj date,  
  ACommentaire varchar(200),
  Aautorisepanachagedeclencheur char,
  ANombreLotsAffectes numeric(5),  
  Alotqteaffectee numeric(5),
  Alotqtevendus numeric(5),
  Alotstockalerte numeric(5)
  )
as
begin
  for select p.t_promotion_id,
             pl.t_transfertlgpi_promotion_id,
             p.libelle,
             p.date_debut,
             p.date_fin,
             p.type_promotion,
             p.date_creation,
             p.date_maj,
             p.commentaire,
             p.autorise_panachage_declencheur,
             p.nombre_lots_affectes,
             p.lot_qte_affectee,
             p.lot_qte_vendue,
             p.lot_stock_alerte              
      from t_promotion_entete p
           left join t_transfertlgpi_promotion pl on (pl.t_promotion_id = p.t_promotion_id)
      into :AIDPromotion,
           :AIDPromotionLGPI,
           :Alibelle,
           :ADateDebut,
           :ADateFin,
           :ATypePromotion,
           :ADateCreation,
           :ADatemaj,  
           :ACommentaire,
           :Aautorisepanachagedeclencheur,
           :ANombreLotsAffectes,  
           :Alotqteaffectee,
           :Alotqtevendus,
           :Alotstockalerte   do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_promo_avantage
returns(
  AIDPromotionAvantage varchar(50),
  AIDPromotion numeric(10),
  AAPartirDe numeric(3),
  ATypeAvantagePromo numeric(2),
  AValAvantage numeric(9,2),
  ANbOffert numeric(2,0),
  AAvecArrondi char
  )
as
begin
  for select a.t_promotion_avantage_id,
             pl.t_transfertlgpi_promotion_id,
             a.a_partir_de,   
             a.type_avantage_promo,
             a.val_avantage,           
             a.nb_offert,
             a.avec_arrondi  
      from t_promotion_avantage a
           inner join t_transfertlgpi_promotion pl on (pl.t_promotion_id = a.t_promotion_id)
      into :AIDPromotionAvantage,
           :AIDPromotion,       
           :AAPartirDe,
           :ATypeAvantagePromo,
           :AValAvantage,
           :ANbOffert,
           :AAvecArrondi
   do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_promo_produit
returns(
  AIDProduit numeric(10),
  AIDPromotion numeric(10),
  ADateEntree date,
  ADateRetrait date,
  AQteAffectee numeric(5),
  AQteVendue numeric(5),
  AStockAlerte numeric(5),
  ADeclencheur char,
  APanier char,
  ALotPrixVenteHorsPromo numeric(10,2),
  ALotQtePromo numeric(10,2),               
  ALotRemise numeric(10,2))
as
begin
  for select p.t_transfertlgpi_produit_id,
             pr.t_transfertlgpi_promotion_id,
             pp.date_entree,
             pp.qte_affectee,
             pp.qte_vendue,
             pp.declencheur,
             pp.panier,
             pp.lot_prixvente_hors_promo,
             pp.lot_qte_promo,
             pp.lot_remise
      from t_promotion_produit pp
           inner join t_transfertlgpi_produit p on (p.t_produit_id = pp.t_produit_id)
           inner join t_transfertlgpi_promotion pr on (pr.t_promotion_id = pp.t_promotion_id)
      into :AIDProduit,
           :AIDPromotion,
           :ADateEntree,
           :AQteAffectee,
           :AQteVendue,
           :ADeclencheur,
           :APanier,
           :ALotPrixVenteHorsPromo,
           :ALotQtePromo,
           :ALotRemise do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_vign_avancee
returns (
  AIDClient integer,
  ADateAvance date,
  ACodeCIP dm_code_cip,
  ADesignation varchar(50),
  APrixVente numeric(10,2),
  APrixAchat numeric(10,3),
  APrestation varchar(3),
  AIDProduit integer,
  AQuantiteAvancee numeric(5),
  ABaseRemboursement numeric(10,2),
  AIDOperateur integer)
as
begin
  for select c.t_transfertlgpi_client_id,
             v.date_avance ,
       iif (char_length(trim(v.code_cip)) = 7, trim(v.code_cip), null),
             v.designation,
             v.prix_vente,
             v.prix_achat,
             v.code_prestation,
             p.t_transfertlgpi_produit_id,
             v.quantite_avancee,
             v.base_remboursement,
             o.t_transfertlgpi_operateur_id
      from t_vignette_avancee v
           inner join t_transfertlgpi_client c on (c.t_client_id = v.t_client_id)
           inner join t_transfertlgpi_produit p on (p.t_produit_id = v.t_produit_id)
           left join  t_transfertlgpi_operateur o on (o.t_operateur_id = v.t_operateur_id)
      where v.repris = '1'
      into :AIDClient,
           :ADateAvance,
           :ACodeCIP,
           :ADesignation,
           :APrixVente,
           :APrixAchat,
           :APrestation,
           :AIDProduit,
           :AQuantiteAvancee,
           :ABaseRemboursement,
           :AIDOperateur do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_credit
returns(
  AIDCredit dm_code,
  AIDCreditLGPI integer,
  ADateCredit date,
  AIDClient integer,
  AIDCompte integer,
  AMontant numeric(10,2))
as
begin
  for select credit.t_credit_id,
             c.t_transfertlgpi_acte_id,
             credit.date_credit,
             cli.t_transfertlgpi_client_id,
             cpt.t_transfertlgpi_compte_id,
             credit.montant
      from t_credit credit
           left join t_transfertlgpi_credit c on (c.t_credit_id = credit.t_credit_id)
           left join t_transfertlgpi_client cli on (cli.t_client_id = credit.t_client_id)
           left join t_transfertlgpi_compte cpt on (cpt.t_compte_id = credit.t_compte_id)
      where credit.montant <> 0
        and (cli.t_transfertlgpi_client_id is not null or cpt.t_transfertlgpi_compte_id is not null)
        and credit.repris = '1'
      into  :AIDCredit,
            :AIDCreditLGPI,
           :ADateCredit,
           :AIDClient,
           :AIDCompte,
           :AMontant do
    suspend;
end;
/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_compte
returns(
  AIDCompte varchar(50),
  AIDCompteLGPI integer,
  ANom varchar(30),
  AActivite varchar(50),
  ARue1 varchar(40),
  ARue2 varchar(40),
  ACodePostal varchar(5),
  ANomVille varchar(30),
  APays varchar(30),
  ATelPersonnel varchar(20),
  ATelStandard varchar(20),
  ATelMobile varchar(20),
  AFax varchar(20),
  ADelaiPaiement numeric(3),
  AFinDeMois char(1),
  ACollectivite char(1),
  AIDProfilRemise integer,
  AIDProfilEdition integer,
  APayeur char(1),
  AIDClient integer)
as
declare variable client integer;
declare variable collectif char(1);
begin
  for select cpt.t_compte_id,
             cptl.t_transfertlgpi_compte_id,
             cpt.nom,
             cpt.activite,
             cpt.rue_1,
             cpt.rue_2,
             coalesce(cp.code_postal, cpt.code_postal),
             coalesce(cp.nom_ville, cpt.nom_ville),
             cpt.tel_personnel,
             cpt.tel_standard,
             cpt.tel_mobile,
             cpt.fax,
             cpt.delai_paiement,
             cpt.fin_de_mois,
             cpt.payeur,
             rm.t_transfertlgpi_profil_rem_id,
             ed.t_transfertlgpi_profil_ed_id,
             iif(cli.t_transfertlgpi_client_id is not null, '0', cpt.collectif),
             cli.t_transfertlgpi_client_id
      from t_compte cpt
           left join t_transfertlgpi_client cli on (cli.t_client_id = cpt.t_client_id)
           left join t_transfertlgpi_profil_remise rm on (rm.t_profil_remise_id = cpt.t_profil_remise_id)
           left join t_transfertlgpi_profil_edition ed on (ed.t_profil_edition_id = cpt.t_profil_edition_id)
           left join t_transfertlgpi_compte cptl on (cptl.t_compte_id = cpt.t_compte_id)
           left join t_ref_cp_ville cp on (cp.t_ref_cp_ville_id = cpt.t_ref_cp_ville_id)
      where cpt.repris = '1'
      into :AIDCompte,
           :AIDCompteLGPI,
           :ANom,
           :AActivite,
           :ARue1,
           :ARue2,
           :ACodePostal,
           :ANomVille,
           :ATelPersonnel,
           :ATelStandard,
           :ATelMobile,
           :AFax,
           :ADelaiPaiement,
           :AFinDeMois,
           :APayeur,
           :AIDProfilRemise,
           :AIDProfilEdition,
           :ACollectivite,
           :AIDClient do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_client_compte
returns (
  AIDCompte integer,
  AIDClient integer)
as
begin
  for select cpt_lg.t_transfertlgpi_compte_id,
             cli.t_transfertlgpi_client_id
      from t_compte_client cptcli
           inner join t_transfertlgpi_compte cpt_lg on (cpt_lg.t_compte_id = cptcli.t_compte_id)
           inner join t_compte cpt on ( cpt.t_compte_id = cptcli.t_compte_id)
           inner join t_transfertlgpi_client cli on (cli.t_client_id = cptcli.t_client_id)
      where cpt.collectif = '1'
      into :AIDCompte,
           :AIDClient do
    suspend;
end;
/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_param_rem_fixe
returns (
    aidparamremisefixe dm_code,
    aidparamremisefixelgpi integer,
    ataux dm_remise)
as
begin
    for select prf.t_param_remise_fixe_id,
               lg.t_transfertlgpi_prm_rem_fixe_id,
               prf.taux
            from t_param_remise_fixe prf
            left join t_transfertlgpi_param_rem_fixe lg on lg.t_param_remise_fixe_id = prf.t_param_remise_fixe_id
            into AIDParamRemiseFixe,
                 AIDParamRemiseFixelgpi,
                 ATaux do
            suspend;
end;


/* ********************************************************************************************** */

create or alter procedure ps_transfertlgpi_profil_remise
returns (
    aidprofilremise varchar(50),
    aidprofilremiselgpi integer,
    alibelle varchar(50),
    aarrondi numeric(5,2),
    atypearrondi char(1),
    aidparamremisefixe integer,
    atyperemise char(1),
    asurventedirecte char(1),
    asurfactureciale char(1),
    asurfactureretro char(1),
    asurordonnance char(1))
as
begin
    for select  pr.t_profil_remise_id,
                plg.t_transfertlgpi_profil_rem_id,
                        pr.libelle,
                        pr.arrondi,
                        pr.type_arrondi,
                        prf.t_transfertlgpi_prm_rem_fixe_id,
                        pr.type_remise,
                        pr.sur_vente_directe,
                        pr.sur_facture_ciale,
                        pr.sur_facture_retro,
                        pr.sur_ordonnance
            from t_profil_remise pr
            left join t_transfertlgpi_param_rem_fixe prf on pr.t_param_remise_fixe_id = prf.t_param_remise_fixe_id
            left join t_transfertlgpi_profil_remise plg on pr.t_profil_remise_id = plg.t_profil_remise_id
            into
                  :AIDProfilRemise ,
                  :AIDProfilRemiseLgpi ,
                  :ALibelle ,
                  :AArrondi ,
                  :ATypeArrondi ,
                  :AIDParamRemiseFixe,
                  :ATypeRemise ,
                  :ASurVenteDirecte ,
                  :ASurFactureCiale ,
                  :ASurFactureRetro ,
                  :ASurOrdonnance
            do
            suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_lgpi_client_compte
returns (
  AIDCompte integer,
  AIDClient integer)
as
begin
  for select cpt_lg.t_transfertlgpi_compte_id,
             cli.t_transfertlgpi_client_id
      from t_compte_client cptcli
           inner join t_transfertlgpi_compte cpt_lg on (cpt_lg.t_compte_id = cptcli.t_compte_id)
           inner join t_compte cpt on ( cpt.t_compte_id = cptcli.t_compte_id)
           inner join t_transfertlgpi_client cli on (cli.t_client_id = cptcli.t_client_id)
      where cpt.collectif = '1'
      into :AIDCompte,
           :AIDClient do
    suspend;
end;
/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_fact_attente
returns(
  AIDFactureAttente varchar(50),
  ADateFacture date,
  AIDClient integer)
as
begin
  for select f.t_facture_attente_id,
             f.date_acte ,
             c.t_transfertlgpi_client_id
      from t_facture_attente f
           inner join t_transfertlgpi_client c on (c.t_client_id = f.t_client_id)
      where f.repris = '1'
      into :AIDFactureAttente,
           :ADateFacture,
           :AIDClient do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_fact_att_ligne
returns(
  AIDFactureAttente integer,
  AIDProduit integer,
  AQuantiteFacturee numeric(5),
  APrestation varchar(3),
  APrixVente numeric(10,2),
  APrixAchat numeric(10,3))
as
begin
  for select f.t_transfertlgpi_fact_attente_id,
             p.t_transfertlgpi_produit_id,
             l.quantite_facturee,
             pr.code,
             l.prix_vente,
             l.prix_achat
      from t_facture_attente_ligne l
           inner join t_transfertlgpi_fact_attente f on (f.t_facture_attente_id = l.t_facture_attente_id)
           inner join t_transfertlgpi_produit p on (p.t_produit_id = l.t_produit_id)
           inner join t_ref_prestation pr on (pr.t_ref_prestation_id = l.t_ref_prestation_id)
      into :AIDFactureAttente,
           :AIDProduit,
           :AQuantiteFacturee,
           :APrestation,
           :APrixVente,
           :APrixAchat do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_produit_du
returns(
  AIDProduitDu varchar(50),
  AIDClient integer,
  ADateDu date)
as
begin
  for select p.t_produit_du_id,
             c.t_transfertlgpi_client_id,
             p.date_du
      from t_produit_du p
           inner join t_transfertlgpi_client c on (c.t_client_id = p.t_client_id)
      where p.repris = '1'
      into :AIDProduitDu,
           :AIDClient,
           :ADateDu do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_produit_du_lig
returns(
  AIDFacture integer,
  AIDProduit integer,
  AQuantite numeric(5))
as
begin
  for select pr_lg.t_transfertlgpi_produit_du_id,
             p.t_transfertlgpi_produit_id,
             pr.quantite
      from t_produit_du pr
           inner join t_transfertlgpi_produit_du pr_lg on (pr_lg.t_produit_du_id = pr.t_produit_du_id)
           inner join t_transfertlgpi_produit p on (p.t_produit_id = pr.t_produit_id)
      into :AIDFacture,
           :AIDProduit,
           :AQuantite do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_parametre
returns(
  ACle varchar(50),
  AValeur varchar(150))
as
begin
  for select cle,
             valeur
      from t_parametre
      into :ACle,
           :AValeur do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_prog_avantage
returns (
    AIDprogrammeavantage varchar(50),
    Atypecarte numeric(2,0),
    Acodeexterne varchar(30),
    Alibelle varchar(30),
    Anbmoisvalidite numeric(3,0),
    Adatefinvalidite date,
    Adesactivee char(1),
    Atypeobjectif numeric(2,0),
    Avaleurobjectif numeric(9,0),
    Avaleurpoint numeric(9,2),
    Anbpointtranche numeric(9,0),
    Avaleurtranche numeric(9,0),
    Avaleurarrondi numeric(9,2),
    Atypeavantage numeric(2,0),
    Amodecalculavantage numeric(2,0),
    Avaleuravantage numeric(9,2),
    Avaleurecart numeric(9,2),
    Adiffassure char(1),
    Avaleurcarte numeric(9,2))
as
begin

  for select t_programme_avantage_id,
             type_carte,
             code_externe,
             libelle,
             nombre_mois_validite,
             date_fin_validite,
             desactivee,
             type_objectif,
             valeur_objectif,
             valeur_point,
             nombre_point_tranche,
             valeur_tranche,
             valeur_arrondi,
             type_avantage,
             mode_calcul_avantage,
             valeur_avantage,
             valeur_ecart,
             diff_assure,
             valeur_carte
      from t_programme_avantage
      into :AIDprogrammeavantage,
           :ATypeCarte,
           :ACodeExterne,
           :ALibelle,
           :ANbMoisValidite,
           :ADateFinValidite,
           :ADesactivee,
           :ATypeObjectif,
           :AValeurObjectif,
           :AValeurPoint,
           :ANbpointTranche,
           :AValeurTranche,
           :AValeurArrondi,
           :ATypeAvantage,
           :AModeCalculAvantage,
           :AValeurAvantage,
           :AValeurEcart,
           :ADiffAssure,
           :AValeurCarte do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_prog_av_cli
returns (
    AIDprogavantageclient integer,
    AIDprogrammeavantage varchar(50),
    AIDclient varchar(50),
    Anumerocarte varchar(13),
    Astatut numeric(2,0),
    Adatecreation date,
    Adatecreationinitiale date,
    Adatefinvalidite date,
    Aoperateur varchar(10),
    Aencoursinitial numeric(9,2),
    Aencoursca numeric(9,2))
as
begin

  for select t_programme_avantage_client_id,
             pa.t_transfertlgpi_prog_avantag_id,
             cli.t_transfertlgpi_client_id,
             numero_carte,
             statut,
             date_creation,
             date_creation_initiale,
             date_fin_validite,
             encours_initial,
             encours_CA,
             t_operateur_id
      from t_programme_avantage_client pac
           inner join t_transfertlgpi_prog_avantage pa on (pa.t_programme_avantage_id = pac.t_programme_avantage_id)
           inner join t_transfertlgpi_client cli on (cli.t_client_id = pac.t_client_id)
      into :AIDprogavantageclient,
           :AIDprogrammeavantage,
           :AIDClient,
           :ANumeroCarte,
           :AStatut,
           :ADateCreation,
           :ADateCreationInitiale,
           :ADateFinValidite,
           :AEncoursInitial,
           :AEncoursCA,
           :AOperateur do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_prog_av_prod
returns (
    AIDprogrammeavantage varchar(50),
    AIDProduit integer,
    AGain char(1),
    AOffert char(1),
    ANbPointSupp numeric(5))
AS
begin

  for select pa.t_transfertlgpi_prog_avantag_id,
             pdt.t_transfertlgpi_produit_id,
             pap.gain,
             pap.offert,
             pap.nombre_point_supp
      from t_programme_avantage_produit pap
           inner join t_transfertlgpi_prog_avantage pa on (pa.t_programme_avantage_id = pap.t_programme_avantage_id)
           inner join t_transfertlgpi_produit pdt on (pdt.t_produit_id = pap.t_produit_id)
      into :AIDprogrammeavantage,
           :AIDProduit,
           :AGain,
           :AOffert,
           :ANbPointSupp do
    suspend;
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_ass_rattache
returns(
  AIDClient integer,
  AIDAssure integer)
as
begin
  for select lc.t_transfertlgpi_client_id, lass.t_transfertlgpi_client_id
      from t_client c
           inner join t_transfertlgpi_client lc on (lc.t_client_id = c.t_client_id)
           inner join t_transfertlgpi_client lass on (lass.t_client_id = c.t_assure_rattache_id)
      into :AIDClient, :AIDAssure do
    suspend;
end; 

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_document
returns(
  ATypeEntite char(2),
  AIDEntite integer,
  AContentType integer,
  ALibelle varchar(50), 
  ADateDocument date,
  ACommentaire varchar(1024),
  ADocument blob sub_type 1)
as
declare variable strIDEntite varchar(50);
begin
  for select d.type_entite,
             c.t_transfertlgpi_client_id,
             d.content_type,
             d.libelle,
             d.t_date,
             'Reprise :'||d.commentaire,
             cast(d.document as blob)
      from t_document d
      inner join t_transfertlgpi_client c on c.t_client_id = d.t_entite_id
      where f_fichier_existant(d.document) = 1
      and d.type_entite = 2
    union
      select d.type_entite,
             coalesce(f.t_transfertlgpi_fourn_direct_id, r.t_transfertlgpi_repartiteur_id),
             d.content_type,
             d.libelle,
             d.t_date,
             'Reprise :'||d.commentaire,
             cast(d.document as blob)
      from t_document d
      left join t_transfertlgpi_fourn_direct f on f.t_fournisseur_direct_id = d.t_entite_id
      left join t_transfertlgpi_repartiteur r on r.t_repartiteur_id = d.t_entite_id
      where f_fichier_existant(d.document) = 1
      and d.type_entite = 16
      and coalesce(f.t_transfertlgpi_fourn_direct_id, r.t_transfertlgpi_repartiteur_id) is not null
    union
      select d.type_entite,
             c.t_transfertlgpi_commande_id,
             d.content_type,
             d.libelle,
             d.t_date,
             'Reprise :'||d.commentaire,
             cast(d.document as blob)
      from t_document d
      inner join t_transfertlgpi_commande c on c.t_commande_id = d.t_entite_id    
      where f_fichier_existant(d.document) = 1
      and d.type_entite = 3         
      into :ATypeEntite,
           :AIDEntite,
           :AContentType,
           :ALibelle,
           :ADateDocument,
           :ACommentaire,
           :ADocument do
    suspend;        
end;

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_histo_stock
returns(
  AIDFournisseur integer,
  AMois smallint,
  AAnnee smallint,
  AValeurStock numeric(10,3))
as
begin
  for select fl.t_transfertlgpi_fourn_direct_id,
             h.mois,
             h.annee,
             h.valeur_stock
      from t_g9_historique_stock h
           inner join t_transfertlgpi_fourn_direct fl on (fl.t_fournisseur_direct_id = h.t_fournisseur_direct_id)
      into :AIDFournisseur,
           :AMois,
           :AAnnee,
           :AValeurStock do
    suspend;           
end;  
  

/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_commentaire
returns(
  AIDCommentaire dm_code,
  AIDCommentaireLGPI integer,  
  AIDEntite integer,
  ATypeEntite smallint,
  AEstGlobal dm_boolean,
  AEstBloquant dm_boolean,
  ACommentaire blob sub_type 1)
as
begin
  for select c.t_commentaire_id,
             lc.t_transfertlgpi_commentaire_id,
             lcli.t_transfertlgpi_client_id,
             c.type_entite,
             c.est_global,
             c.est_bloquant,
             c.commentaire
      from t_commentaire c 
           left join t_transfertlgpi_commentaire lc on (c.t_commentaire_id = lc.t_commentaire_id)
           inner join t_transfertlgpi_client lcli on (c.t_entite_id = lcli.t_client_id and c.type_entite = '0' )
           
      into :AIDCommentaire,
           :AIDCommentaireLGPI,
           :AIDEntite,
           :ATypeEntite,
           :AEstGlobal,
           :AEstBloquant,
           :ACommentaire do
    suspend;           
end;  
  
/* ********************************************************************************************** */
create or alter procedure ps_transfertlgpi_carte_prog_rel
returns (
    AIDcarteprogrel integer,
    AIDclient varchar(50),
    Anumerocarte varchar(13),
    AIDpfi_lgpi integer)
as
begin
  for select t_carte_prog_relationnel_id,
             cli.t_transfertlgpi_client_id,
             numero_carte, 
             t_pfi_lgpi_id
      from t_carte_programme_relationnel prog
      inner join t_transfertlgpi_client cli on (cli.t_client_id = prog.t_aad_id)
      into :AIDcarteprogrel,
           :AIDClient,
           :ANumeroCarte,
           :AIDpfi_lgpi do
    suspend;
end;
