create or replace package body migration.pk_encours as
     
   
  /* ********************************************************************************************** */
  procedure maj_produit_du_stup
  as
  begin 

    
  for c_prod_stup in ( select t_produit_id, codecip, nb_mode_administration
             from erp.t_produit 
             where ( assimile_stupefiant = '1' or liste = 3 ) 
             and deconditionnable = '1'
             and nb_mode_administration is not null and nb_mode_administration >0
             and profilgs <> 1
             and ( conditionnement is null or conditionnement <= 1) ) loop
      
        update erp.t_produitdu pd
        set qtedue = qtedue * c_prod_stup.nb_mode_administration , datemajproduitdu = sysdate
        where pd.t_produit_id = c_prod_stup.t_produit_id;
    
  end loop;
  
  end;     
  /* ********************************************************************************************** */
  function creer_acte(ADateActe in date,
                      AEtat in varchar2 default '110',
                      AIDOperateur in integer default null)
                     return integer 
  as
    intIDActe integer;  
  begin
    insert into erp.t_acte(t_acte_id,
                           t_operateur_id,
                           t_postedetravail_id,
                           dateacte,
                           termine,
                           valide,
                           signe,
                           t_tiroircaisse_id,
                           typeacte)
     values(erp.seq_id_acte.nextval,
            nvl(AIDOperateur, pk_commun.IDOperateurPoint),
            pk_commun.IDPoste0,
            ADateActe,
            substr(AEtat, 1, 1),
            substr(AEtat, 2, 1),
            substr(AEtat, 3, 1),
            pk_commun.IDTiroirCaissePoste0,
            '1')
    returning t_acte_id into intIDActe; 

    return intIDActe;    
  end;
  
  /* ********************************************************************************************** */
  function creer_facture(ADateFacture in date,
                         AIDClient in integer,
                         AMontant in number,
                         AAttente in boolean default false)
                        return rec_facture
  as
    recFacture rec_facture;
    recClient erp.t_assureayantdroit%rowtype;
    recAdresse erp.t_adresse%rowtype;
    recCodePostal erp.t_cpville%rowtype;
    strQualite varchar2(2);
  begin
    -- Recherche des informations assuré
    begin
      select ass.*
      into recClient
      from erp.t_assureayantdroit ben
           inner join erp.t_assureayantdroit ass on (ass.numeroinsee = ben.numeroinsee)
           inner join erp.t_qualite q on (q.t_qualite_id = ass.t_qualite_id)
      where ben.t_aad_id = AIDClient
        and q.code = '0';
    exception
      when too_many_rows or no_data_found then
        select *
        into recClient
        from erp.t_assureayantdroit
        where t_aad_id = AIDClient;
    end;

    if recClient.t_adresse_id is not null then
      select adr.*
      into recAdresse
      from erp.t_adresse adr
      where adr.t_adresse_id = recClient.t_adresse_id;

      if recAdresse.t_cpville_id is not null then
        select cp.*
        into recCodePostal
        from erp.t_cpville cp
        where cp.t_cpville_id = recAdresse.t_cpville_id;
      end if;
    end if;

    strQualite := pk_commun.Qualites(recClient.t_qualite_id);
    recFacture.t_acte_id := creer_acte(ADateFacture);
    if AAttente then
      insert into erp.t_dossierattente(t_facture_id,
                                       date_maj,
                                       id_acte,
                                       t_operateur_id,
                                       numero_facture,
                                       etat_facture,
                                       date_execution,
                                       code_operateur,
                                       the_type_facturation,
                                       total_facture,
                                       montant_assure,
                                       remise,
                                       type_remise,
                                       frais_port,
                                       t_client_id,
                                       nom_assure,
                                       prenom_assure,
                                       nom_malade,
                                       prenom_malade,
                                       code_postal,
                                       rue1,
                                       rue2,
                                       ville,
                                       numero_insee,
                                       date_naissance,
                                       rang_gemellaire,
                                       code_qualite,
                                       exoneration_tva,
                                       mise_en_lot_amo,
                                       mise_en_lot_amc,
                                       total_remise,
                                       type_certification_amo,
                                       type_certification_amc,
                                       sens_comptable_amo,
                                       sens_comptable_amc,
                                       rejetamo,
                                       rejetamc,
                                       edition_prix_surbl,
                                       retro_majhistovente)
      values(erp.seq_id_facture.nextval,
             sysdate,
             recFacture.t_acte_id,
             pk_commun.IDOperateurPoint,
             0, -- Vente directe donc => 0
             'V', -- Etat de la facture validé
             ADateFacture,
             '.',
             3, -- Vente directe
             AMontant,
             AMontant,
             0,
             'P',
             0,
             AIDClient,
             recClient.nom,
             recClient.prenom,
             recClient.nom,
             recClient.prenom,
             recCodePostal.codepostal,
             recAdresse.rue1,
             recAdresse.rue2,
             recCodePostal.nomville,
             recClient.numeroinsee,
             recClient.datenaissance,
             recClient.ranggemellaire,
             strQualite,
             '0',
             '0',
             '0',
             0,
             0,
             0,
             0,
             0,
             '0',
             '0',
             '0',
             '0')
      returning t_facture_id into recFacture.t_facture_id;
    else    
      insert into erp.t_facture(t_facture_id,
                                date_maj,
                                id_acte,
                                t_operateur_id,
                                numero_facture,
                                etat_facture,
                                date_execution,
                                code_operateur,
                                the_type_facturation,
                                total_facture,
                                montant_assure,
                                remise,
                                type_remise,
                                frais_port,
                                t_client_id,
                                nom_assure,
                                prenom_assure,
                                nom_malade,
                                prenom_malade,
                                code_postal,
                                rue1,
                                rue2,
                                ville,
                                numero_insee,
                                date_naissance,
                                rang_gemellaire,
                                code_qualite,
                                exoneration_tva,
                                mise_en_lot_amo,
                                mise_en_lot_amc,
                                total_remise,
                                type_certification_amo,
                                type_certification_amc,
                                sens_comptable_amo,
                                sens_comptable_amc,
                                rejetamo,
                                rejetamc,
                                edition_prix_surbl,
                                retro_majhistovente)
      values(erp.seq_id_facture.nextval,
             sysdate,
             recFacture.t_acte_id,
             pk_commun.IDOperateurPoint,
             0, -- Vente directe donc => 0
             'V', -- Etat de la facture validé
             ADateFacture,
             '.',
             3, -- Vente directe
             AMontant,
             AMontant,
             0,
             'P',
             0,
             AIDClient,
             recClient.nom,
             recClient.prenom,
             recClient.nom,
             recClient.prenom,
             recCodePostal.codepostal,
             recAdresse.rue1,
             recAdresse.rue2,
             recCodePostal.nomville,
             recClient.numeroinsee,
             recClient.datenaissance,
             recClient.ranggemellaire,
             strQualite,
             '0',
             '0',
             '0',
             0,
             0,
             0,
             0,
             0,
             '0',
             '0',
             '0',
             '0')
      returning t_facture_id into recFacture.t_facture_id;
    end if;
    
    return recFacture;
  end; 
  
  function creer_histo_entete(AIDClient in integer,
                         ANumeroFacture in number,
                         ADatePrescription in date,
                         ACodeOperateur in varchar2,
                         AIDStructure in integer,
                         ATypePraticien in char,
                         ANomPraticien in varchar2,
                         APrenomPraticien in varchar2,
                         ANoFiness in varchar2,
                         ACodeSpecialite in varchar2,                         
                         ATypeFacturation in number,
                         ADateActe in date,
                         AMontant in number)
                        return integer
  as
    intIDHistoriqueClient integer;
    recFacture rec_facture;
    recClient erp.t_assureayantdroit%rowtype;
    recAdresse erp.t_adresse%rowtype;
    recCodePostal erp.t_cpville%rowtype;
    recPraticien erp.t_praticien%rowtype;
    strQualite varchar2(2);    
  begin
    savepoint sp_facture;

    begin
      select ass.*
      into recClient
      from erp.t_assureayantdroit ben
           inner join erp.t_assureayantdroit ass on (ass.numeroinsee = ben.numeroinsee)
           inner join erp.t_qualite q on (q.t_qualite_id = ass.t_qualite_id)
      where ben.t_aad_id = AIDClient
        and q.code = '0';
    exception
      when too_many_rows or no_data_found then
        select *
        into recClient
        from erp.t_assureayantdroit
        where t_aad_id = AIDClient;
    end;

    if recClient.t_adresse_id is not null then
      select adr.*
      into recAdresse
      from erp.t_adresse adr
      where adr.t_adresse_id = recClient.t_adresse_id;

      select cp.*
      into recCodePostal
      from erp.t_cpville cp
      where cp.t_cpville_id = recAdresse.t_cpville_id;
    end if;

    insert into erp.t_facture(t_facture_id,
                              date_maj,
                              id_acte,
                              t_operateur_id,
                              numero_facture,
                              etat_facture,
                              date_execution,
                              code_operateur,
                              the_type_facturation,
                              total_facture,
                              montant_assure,
                              remise,
                              type_remise,
                              frais_port,
                              t_client_id,
                              nom_assure,
                              prenom_assure,
                              nom_malade,
                              prenom_malade,
                              code_postal,
                              rue1,
                              rue2,
                              ville,
                              numero_insee,
                              date_naissance,
                              rang_gemellaire,
                              code_qualite,
                              exoneration_tva,
                              mise_en_lot_amo,
                              mise_en_lot_amc,
                              total_remise,
                              type_certification_amo,
                              type_certification_amc,
                              sens_comptable_amo,
                              sens_comptable_amc,
                              rejetamo,
                              rejetamc,
                              edition_prix_surbl,
                              retro_majhistovente,
                              t_praticien_structure_id,
                              nom_praticien,
                              prenom_praticien,
                              no_finess_prescripteur,
                              code_specialite_medecin)
    values(erp.seq_id_facture.nextval,
           sysdate,
           recFacture.t_acte_id,
           pk_commun.IDOperateurPoint,
           ANumeroFacture,
           'V', -- Etat de la facture validé
           ADateActe,
           '.',
           3, -- Vente directe
           AMontant,
           AMontant,
           0,
           'P',
           0,
           AIDClient,
           recClient.nom,
           recClient.prenom,
           recClient.nom,
           recClient.prenom,
           recCodePostal.codepostal,
           recAdresse.rue1,
           recAdresse.rue2,
           recCodePostal.nomville,
           recClient.numeroinsee,
           recClient.datenaissance,
           recClient.ranggemellaire,
           strQualite,
           '0',
           '0',
           '0',
           0,
           0,
           0,
           0,
           0,
           '0',
           '0',
           '0',
           '0',
           AIDStructure,
           ANomPraticien,
           APrenomPraticien,
           ANoFiness,
           ACodeSpecialite)
    returning t_facture_id into intIDHistoriqueClient; 

        -- Création de l'encaissement
    insert into erp.t_encaissement(t_acte_id,
                                   n_ordre,
                                   montant,
                                   t_devise_id,
                                   t_modereglement_id,
                                   dateecriture,
                                   commentaire,
                                   t_postedetravail_id,
                                   emetteurcheque,
                                   banque,
                                   datemaj,
                                   montantdevise,
                                   edite,
                                   dateremiseenbanque,
                                   nocompte,
                                   codeoperateur,
                                   t_acte_encaisse_id,
                                   t_aad_id,
                                   num_releve,
                                   type_ecriture,
                                   lettre,
                                   valide_releve,
                                   date_releve,
                                   soumisareleve,
                                   t_aad_debiteur_id,
                                   num_releve_encaisse,
                                   t_facture_id,
                                   t_facture_encaisse_id)
    values(recFacture.t_acte_id,
           1,
           AMontant,
           pk_commun.IDDeviseEuro,
           6,
           ADateActe,
           'Reprise historique délivrances',
           pk_commun.IDPoste0,
           null,
           null,
           sysdate,
           AMontant,
           '0',
           null,
           null,
           '.',
           null,
           AIDClient,
           null,
           'D',
           '0',
           '0',
           null,
           '0',
           AIDClient,
           null,
           intIDHistoriqueClient,
           null);
           
    return intIDHistoriqueClient;
  exception
    when others then
      rollback to sp_lignes_ventes;
      raise;
  end;
  
  /* ********************************************************************************************** */
  procedure creer_histo_ligne(AIDHistoriqueClientEntete in integer,
                              AIDProduit in integer,
                              ACodeCIP in varchar2,
                              ADesignation in varchar2,
                              AQuantiteFacturee in number,
                              --APrixAchat in number,
                              APrixVente in number) 
  as
    intIDClient integer;
    flMontant numeric(10, 2);
    flTauxTVA numeric(5, 2);
    intIDActe integer;
    dtDateExecution date;
    recProduit erp.t_produit%rowtype;
    recPrestation erp.t_prestation%rowtype;
  begin
    savepoint sp_lignes_ventes;
    
    select id_acte, t_client_id, date_execution, total_facture
    into intIDActe, intIDClient, dtDateExecution, flMontant
    from erp.t_facture
    where t_facture_id = AIDHistoriqueClientEntete;
    
    select *
    into recProduit
    from erp.t_produit
    where t_produit_id = AIDProduit;
    
    select tauxtva
    into flTauxTVA
    from erp.t_tva
    where t_tva_id = recProduit.t_tva_id;
    
    select *
    into recPrestation
    from erp.t_prestation
    where t_prestation_id = recProduit.t_prestation_id;
    
    -- Création de la ligne de vente
     insert into erp.t_lignevente(t_lignevente_id,
                                 qtefacturee,
                                 liste,
                                 complementprestation,
                                 qualificatifdepense,
                                 noordonnancier,
                                 designation,
                                 motifsubstitution,
                                 qtedelivree,
                                 qtemanquante,
                                 datemajlignevente,
                                 t_facture_id,
                                 t_produit_id,
                                 t_prestation_id,
                                 t_tva_id,
                                 t_couvertureamo_id,
                                 typefacturation,
                                 remise,
                                 coefficient,
                                 prixvente,
                                 baseremboursement,
                                 t_produitprescrit_id,
                                 tauxamo,
                                 dateenvoiep,
                                 codeaccordep,
                                 rembamo,
                                 rembamc,
                                 rembamotransmis,
                                 rembamctransmis,
                                 tauxamc,
                                 codecip_prescrit,
                                 designation_prescrit,
                                 paht_prescrit,
                                 baseremboursement_prescrit,
                                 pvttc_prescrit,
                                 codetaux_prescrit,
                                 codecip,
                                 paht_brut,
                                 codetaux,
                                 tauxtva,
                                 codeprestation,
                                 suivi_interessement,
                                 t_zonegeo_id,
                                 t_classificationint_id,
                                 t_fournisseurdirect_id,
                                 veterinaire,
                                 delailait,
                                 delaiviande,
                                 pvttc_fichier,
                                 paht_remise,
                                 pamp,
                                 code_exo,
                                 numero_bonlivraison,
                                 grp1720,
                                 avec_coeff,
                                 servicetips,
                                 datedeblocouachat,
                                 datefinloc,
                                 datelivraison,
                                 codelabotaux,
                                 codelabotaux_prescrit,
                                 pvht,
                                 pvhtremise,
                                 montant_net,
                                 montant_net_ht,
                                 montant_net_ttc,
                                 pvttc_boite)
   values(erp.seq_id_lignevente.nextval,
           1,
           recProduit.liste,
           0,
           0,
           0,
           ADesignation,
           0,
           AQuantiteFacturee,
           0,
           sysdate,
           AIDHistoriqueClientEntete,
           AIDProduit,
           recProduit.t_prestation_id,
           recProduit.t_tva_id,
           null,
           '1',
           0,
           1,
           APrixVente,
           recProduit.baseremboursement,
           null,
           0,
           null,
           '9', -- Acte non-soumis à accord,
           0,
           0,
           0,
           0,
           0,
           recProduit.codecip,
           recProduit.designation,
           recProduit.prixachatcatalogue,
           decode(recProduit.baseremboursement, 0, recProduit.prixvente, recProduit.baseremboursement),
           APrixVente,
           recPrestation.codetaux,
           ACodeCIP,
           recProduit.prixachatcatalogue,
           recPrestation.codetaux,
           flTauxTVA,
           recPrestation.code,
           '0',
           null,
           null,
           null,
           '0',
           0,
           0,
           0,
           0,
           0,
           null,
           null,
           recPrestation.groupe1720,
           recPrestation.aveccoefficient,
           null,
           null,
           null,
           null,
           '0',
           '0',
           0,
           0,
           APrixVente * AQuantiteFacturee,
           -1,
           APrixVente * AQuantiteFacturee,
           APrixVente);
  exception
    when others then
      rollback to sp_lignes_ventes;
      raise;
  end;
                              
  /* ********************************************************************************************** */
  procedure creer_vignette_avancee(AIDClient in integer,
                                   ADateAvance in date,
                                   ACodeCIP in varchar2,
                                   ADesignation in varchar2,
                                   APrixVente in number,
                                   APrixAchat in number,
                                   APrestation in varchar2,
                                   AIDProduit in integer,
                                   AQuantiteAvancee in number,
                                   ABaseremboursement in number,
                                   AIDOperateur in integer)
  as
    intIDActe integer;
  begin
    savepoint sp_vignettes_avancees;

    intIDActe := creer_acte(ADateAvance, '100', AIDOperateur);
    insert into erp.t_vignetteavancee(t_vignetteavancee_id,
                                      t_assureayantdroit_id,
                                      dateavance,
                                      codecip,
                                      designation,
                                      prixvente,
                                      paht_brut,
                                      codeprestation,
                                      t_produit_id,
                                      t_operateur_id,
                                      qteavancee,
                                      baseremboursement,
                                      t_acte_id)
    values(erp.seq_id_vignetteavancee.nextval,
           AIDClient,
           ADateAvance,
           ACodeCIP,
           ADesignation,
           APrixVente,
           APrixAchat,
           APrestation,
           AIDProduit,
           nvl(AIDOperateur, pk_commun.IDOperateurPoint),
           AQuantiteAvancee,
           ABaseRemboursement,
           intIDActe);
  exception
    when others then
      rollback to sp_vignettes_avancees;
      raise;
  end;

  /* ********************************************************************************************** */
  function creer_credit(ADateCredit date,
                        AIDClient number,
                        AIDCompte number,
                        AMontant number)
                        return integer
  as
    intIDClient integer;
    recFacture rec_facture;
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_credits;

    intIDClient := nvl(AIDClient, AIDCompte);
    recFacture := creer_facture(ADateCredit, intIDClient, AMontant);

    -- Création de la ligne de vente
    insert into erp.t_lignevente(t_lignevente_id,
                                 qtefacturee,
                                 liste,
                                 complementprestation,
                                 qualificatifdepense,
                                 noordonnancier,
                                 designation,
                                 motifsubstitution,
                                 qtedelivree,
                                 qtemanquante,
                                 datemajlignevente,
                                 t_facture_id,
                                 t_produit_id,
                                 t_prestation_id,
                                 t_tva_id,
                                 t_couvertureamo_id,
                                 typefacturation,
                                 remise,
                                 coefficient,
                                 prixvente,
                                 baseremboursement,
                                 t_produitprescrit_id,
                                 tauxamo,
                                 dateenvoiep,
                                 codeaccordep,
                                 rembamo,
                                 rembamc,
                                 rembamotransmis,
                                 rembamctransmis,
                                 tauxamc,
                                 codecip_prescrit,
                                 designation_prescrit,
                                 paht_prescrit,
                                 baseremboursement_prescrit,
                                 pvttc_prescrit,
                                 codetaux_prescrit,
                                 codecip,
                                 paht_brut,
                                 codetaux,
                                 tauxtva,
                                 codeprestation,
                                 suivi_interessement,
                                 t_zonegeo_id,
                                 t_classificationint_id,
                                 t_fournisseurdirect_id,
                                 veterinaire,
                                 delailait,
                                 delaiviande,
                                 pvttc_fichier,
                                 paht_remise,
                                 pamp,
                                 code_exo,
                                 numero_bonlivraison,
                                 grp1720,
                                 avec_coeff,
                                 servicetips,
                                 datedeblocouachat,
                                 datefinloc,
                                 datelivraison,
                                 codelabotaux,
                                 codelabotaux_prescrit,
                                 pvht,
                                 pvhtremise,
                                 montant_net,
                                 montant_net_ht,
                                 montant_net_ttc,
                 pvttc_boite)
    values(erp.seq_id_lignevente.nextval,
           1,
           0,
           0,
           0,
           0,
           'Produit reprise crédit',
           0,
           1,
           0,
           sysdate,
           recFacture.t_facture_id,
           null,
           --pk_commun.IDPrestationw,
           pk_commun.IDPrestationPHN,
           pk_commun.IDTVA0,
           null,
           null,
           0,
           1,
           AMontant,
           0,
           null,
           0,
           null,
           '9', -- Acte non-soumis à accord,
           0,
           0,
           0,
           0,
           0,
           null,
           null,
           0,
           0,
           0,
           null,
           null,
           0,
           '0',
           0,
           'PHN',
           '0',
           null,
           null,
           null,
           '0',
           0,
           0,
           0,
           0,
           0,
           null,
           null,
           '0',
           '0',
           null,
           null,
           null,
           null,
           '0',
           '0',
           AMontant,
           AMontant,
           0,
           -1,
           0,
       AMontant);

    -- Création de l'encaissement
    insert into erp.t_encaissement(t_acte_id,
                                   n_ordre,
                                   montant,
                                   t_devise_id,
                                   t_modereglement_id,
                                   dateecriture,
                                   commentaire,
                                   t_postedetravail_id,
                                   emetteurcheque,
                                   banque,
                                   datemaj,
                                   montantdevise,
                                   edite,
                                   dateremiseenbanque,
                                   nocompte,
                                   codeoperateur,
                                   t_acte_encaisse_id,
                                   t_aad_id,
                                   num_releve,
                                   type_ecriture,
                                   lettre,
                                   valide_releve,
                                   date_releve,
                                   soumisareleve,
                                   t_aad_debiteur_id,
                                   num_releve_encaisse,
                                   t_facture_id,
                                   t_facture_encaisse_id)
    values(recFacture.t_acte_id,
           1,
           AMontant,
           pk_commun.IDDeviseEuro,
           pk_commun.IDModeReglementCredit,
           ADateCredit,
           'Reprise crédit',
           pk_commun.IDPoste0,
           null,
           null,
           sysdate,
           AMontant,
           '0',
           null,
           null,
           '.',
           null,
           intIDClient,
           null,
           'D',
           '0',
           '0',
           null,
           '0',
           intIDClient,
           null,
           recFacture.t_facture_id,
           null);

    return recFacture.t_acte_id;
  exception
    when others then
      rollback to sp_credits;
      raise;
  end;
  
  /* ********************************************************************************************** */
  function creer_produit_du(AIDClient in integer,
                            ADateDu in date)
                           return integer 
  as
    recFacture rec_facture;
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_produits_dus;

    recFacture := creer_facture(ADateDu, AIDClient, 0);
    return recFacture.t_facture_id;
  exception
    when others then
      rollback to sp_produits_dus;
      raise;
  end;
  
  /* ********************************************************************************************** */
  procedure creer_produit_du_ligne(AIDFacture in integer,
                                   AIDProduit in number,
                                   AQuantite in number)
  as
    intIDClient integer;
    dtDateFacture date;
    intIDActe integer;
    recProduit erp.t_produit%rowtype;
    recPrestation erp.t_prestation%rowtype;
    ftTauxTVA number(5,2);
    intIDLigneVente integer;
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_produits_dus;

    select id_acte,
           t_client_id,
           date_execution
    into intIDActe,
         intIDClient,
         dtDateFacture
    from erp.t_facture
    where t_facture_id = AIDFacture;
    
    -- Recherche des informations produit
    select prod.*
    into recProduit
    from erp.t_produit prod
    where prod.t_produit_id = AIDProduit;

    -- Recherche des informations prestation
    select prest.*
    into recPrestation
    from erp.t_prestation prest
    where prest.t_prestation_id = recProduit.t_prestation_id;
    
    -- Recherche informations TVA
    select tauxtva
    into ftTauxTVA
    from erp.t_tva
    where t_tva_id = recProduit.t_tva_id; 
    
    insert into erp.t_lignevente(t_lignevente_id,
                                 qtefacturee,
                                 liste,
                                 complementprestation,
                                 qualificatifdepense,
                                 noordonnancier,
                                 designation,
                                 motifsubstitution,
                                 qtedelivree,
                                 qtemanquante,
                                 datemajlignevente,
                                 t_facture_id,
                                 t_produit_id,
                                 t_prestation_id,
                                 t_tva_id,
                                 t_couvertureamo_id,
                                 typefacturation,
                                 remise,
                                 coefficient,
                                 prixvente,
                                 baseremboursement,
                                 t_produitprescrit_id,
                                 tauxamo,
                                 dateenvoiep,
                                 codeaccordep,
                                 rembamo,
                                 rembamc,
                                 rembamotransmis,
                                 rembamctransmis,
                                 tauxamc,
                                 codecip_prescrit,
                                 designation_prescrit,
                                 paht_prescrit,
                                 baseremboursement_prescrit,
                                 pvttc_prescrit,
                                 codetaux_prescrit,
                                 codecip,
                                 paht_brut,
                                 codetaux,
                                 tauxtva,
                                 codeprestation,
                                 suivi_interessement,
                                 t_zonegeo_id,
                                 t_classificationint_id,
                                 t_fournisseurdirect_id,
                                 veterinaire,
                                 delailait,
                                 delaiviande,
                                 pvttc_fichier,
                                 paht_remise,
                                 pamp,
                                 code_exo,
                                 numero_bonlivraison,
                                 grp1720,
                                 avec_coeff,
                                 servicetips,
                                 datedeblocouachat,
                                 datefinloc,
                                 datelivraison,
                                 codelabotaux,
                                 codelabotaux_prescrit,
                                 pvht,
                                 pvhtremise,
                                 montant_net,
                                 montant_net_ht,
                                 montant_net_ttc,
                 pvttc_boite)
    values(erp.seq_id_lignevente.nextval,
           AQuantite,
           recProduit.liste,
           0,
           0,
           0,
           recProduit.designation,
           0,
           0,
           AQuantite,
           sysdate,
           AIDFacture,
           AIDProduit,
           recProduit.t_prestation_id,
           recProduit.t_tva_id,
           null,
           null,
           0,
           1,
           recProduit.prixvente,
           recProduit.baseremboursement,
           AIDProduit,
           0,
           null,
           '9', -- Acte non-soumis à accord,
           0,
           0,
           0,
           0,
           0,
           recProduit.codecip,
           recProduit.designation,
           recProduit.prixachatcatalogue,
           decode(recProduit.baseremboursement, 0, recProduit.prixvente, recProduit.baseremboursement),
           recProduit.prixvente,
           recPrestation.codetaux,
           recProduit.codecip,
           recProduit.prixachatcatalogue,
           recPrestation.codetaux,
           ftTauxTVA,
           recPrestation.code,
           '0',
           null,
           null,
           null,
           '0',
           0,
           0,
           0,
           0,
           0,
           null,
           null,
           recPrestation.groupe1720,
           recPrestation.aveccoefficient,
           null,
           null,
           null,
           null,
           '0',
           '0',
           0,
           0,
           recProduit.prixvente * AQuantite,
           -1,
           recProduit.prixvente * AQuantite,
           recProduit.prixvente)
    returning t_lignevente_id into intIDLigneVente;

    -- Création du produit du
    insert into erp.t_produitdu(t_produitdu_id,
                                qtedue,
                                suivi_commande,
                                t_produit_id,
                                t_acte_id,
                                t_aad_id,
                                datemajproduitdu,
                                en_attente,
                                t_postedetravail_id,
                                t_lignevente_id,
                                t_facture_id,
                                t_commande_id)
    values(erp.seq_id_produitdu.nextval,
           AQuantite,
           '0',
           AIDProduit,
           intIDActe,
           intIDClient,
           dtDateFacture,
           '0',
           pk_commun.IDPoste0,
           intIDLigneVente,
           AIDFacture,
           null);    
  end;  
  
  /* ********************************************************************************************** */
  function creer_facture_attente(ADateFacture in date,
                                 AIDClient in integer)
                                return integer 
  as
    recFacture rec_facture;
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_facture_attente;

    recFacture := creer_facture(ADateFacture, AIDClient, 0, true);
    
    return recFacture.t_facture_id;  
  exception
    when others then
      rollback to sp_facture_attente;
      raise;
  end;  
  
  /* ********************************************************************************************** */
  procedure creer_facture_attente_ligne(AIDFactureAttente in integer,
                                        AIDProduit in integer,
                                        AQuantiteFacturee in number,
                                        APrestation varchar2,
                                        APrixVente in number,
                                        APrixAChat in number)                                      
  as
    recProduit erp.t_produit%rowtype;
    recPrestation erp.t_prestation%rowtype;
    ftTauxTVA number(5,2);
  begin
    -- Sauvegarde données déjà crée
    savepoint sp_facture_attente_ligne;

    -- Recherche des informations produit
    begin
      select prod.*
      into recProduit
      from erp.t_produit prod
      where prod.t_produit_id = AIDProduit;
    exception
      when too_many_rows or no_data_found then
      recProduit := null;  
    end;


    -- Recherche des informations prestation
    select prest.*
    into recPrestation
    from erp.t_prestation prest
    where prest.code = APrestation;

    -- Recherche informations TVA
    begin
      select tauxtva
      into ftTauxTVA
      from erp.t_tva
      where t_tva_id = recProduit.t_tva_id;
    exception
      when too_many_rows or no_data_found then
      ftTauxTVA := 0;  
    end;

    -- Création de la ligne de vente
    insert into erp.t_lignevente(t_lignevente_id,
                                 qtefacturee,
                                 liste,
                                 complementprestation,
                                 qualificatifdepense,
                                 noordonnancier,
                                 designation,
                                 motifsubstitution,
                                 qtedelivree,
                                 qtemanquante,
                                 datemajlignevente,
                                 t_facture_id,
                                 t_produit_id,
                                 t_prestation_id,
                                 t_tva_id,
                                 t_couvertureamo_id,
                                 typefacturation,
                                 remise,
                                 coefficient,
                                 prixvente,
                                 baseremboursement,
                                 t_produitprescrit_id,
                                 tauxamo,
                                 dateenvoiep,
                                 codeaccordep,
                                 rembamo,
                                 rembamc,
                                 rembamotransmis,
                                 rembamctransmis,
                                 tauxamc,
                                 codecip_prescrit,
                                 designation_prescrit,
                                 paht_prescrit,
                                 baseremboursement_prescrit,
                                 pvttc_prescrit,
                                 codetaux_prescrit,
                                 codecip,
                                 paht_brut,
                                 codetaux,
                                 tauxtva,
                                 codeprestation,
                                 suivi_interessement,
                                 t_zonegeo_id,
                                 t_classificationint_id,
                                 t_fournisseurdirect_id,
                                 veterinaire,
                                 delailait,
                                 delaiviande,
                                 pvttc_fichier,
                                 paht_remise,
                                 pamp,
                                 code_exo,
                                 numero_bonlivraison,
                                 grp1720,
                                 avec_coeff,
                                 servicetips,
                                 datedeblocouachat,
                                 datefinloc,
                                 datelivraison,
                                 codelabotaux,
                                 codelabotaux_prescrit,
                                 pvht,
                                 pvhtremise,
                                 montant_net,
                                 montant_net_ht,
                                 montant_net_ttc,
                 pvttc_boite)
    values(erp.seq_id_lignevente.nextval,
           AQuantiteFacturee,
           coalesce(recProduit.liste,0),
           0,
           0,
           0,
           coalesce(recProduit.designation,'Honoraires' ),
           0,
           AQuantiteFacturee,
           0,
           sysdate,
           AIDFactureAttente,
           AIDProduit,
           recPrestation.t_prestation_id,
           coalesce(recProduit.t_tva_id, 4),
           null,
           null,
           0,
           1,
           APrixVente,
           coalesce(recProduit.baseremboursement,0),
           AIDProduit,
           0,
           null,
           '9', -- Acte non-soumis à accord,
           0,
           0,
           0,
           0,
           0,
           recProduit.codecip,
           recProduit.designation,
           APrixAchat,
           decode(recProduit.baseremboursement, 0, APrixVente, recProduit.baseremboursement),
           APrixVente,
           recPrestation.codetaux,
           recProduit.codecip,
           APrixAchat,
           coalesce(recPrestation.codetaux,'5'),
           ftTauxTVA,
           APrestation,
           '0',
           null,
           null,
           null,
           '0',
           0,
           0,
           APrixVente,
           APrixAchat,
           coalesce(recProduit.pamp,0),
           null,
           null,
           coalesce(recPrestation.groupe1720,'0'),
           coalesce(recPrestation.aveccoefficient,'0'),
           null,
           null,
           null,
           null,
           '0',
           '0', -- CODETAUXLABO_PRESCRIT,
           (APrixVente / (1 + (ftTauxTVA/100))),
           (APrixVente / (1 + (ftTauxTVA/100))),
           coalesce(recProduit.prixvente, APrixVente) * AQuantiteFacturee,
           -1,
           coalesce(recProduit.prixvente, APrixVente) * AQuantiteFacturee,
           coalesce(recProduit.prixvente, APrixVente));
  exception
    when others then
      rollback to sp_facture_attente_ligne;
      raise;
  end;  
end; 
/