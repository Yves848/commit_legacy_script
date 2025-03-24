	/******************************************************************************/
CREATE OR REPLACE package body migration.pk_supprimer AS

-- type et subtype
  TYPE temp_id IS TABLE OF NUMBER(10);
  TYPE tab_integer IS TABLE OF INTEGER INDEX BY binary_integer;
 
  -- Variables globales
  i binary_integer;
  gStrtypedonnee varchar2(30);
  C_SUPPRESSION_PRATICIENS constant INTEGER := 1;
  C_SUPPRESSION_ORGANISMES constant INTEGER := 2;
  C_SUPPRESSION_CLIENTS constant INTEGER := 3;
  C_SUPPRESSION_PRODUITS constant INTEGER := 4;
  C_SUPPRESSION_ENCOURS constant INTEGER := 5;  
  C_SUPPRESSION_AVANTAGES constant INTEGER := 6;
  C_SUPPRESSION_AUTRES_DONNEES constant INTEGER := 8;
 
  table_inexistante exception; pragma exception_init(table_inexistante, -00942);
  sequence_inexistante exception; pragma exception_init(sequence_inexistante, -02289);

  strErreur varchar2(500);  
 
    /* ********************************************************************************************** */
  FUNCTION renvoyer_debut_sequence(ASequence IN varchar2)
                                  RETURN INTEGER
  AS
    i INTEGER;
    strProp VARCHAR(255);
    strSequence VARCHAR(255);
  BEGIN
    i := instr(ASequence, '.');
    IF i > 1 THEN
      strProp := substr(ASequence, 1, i - 1);
      strSequence := substr(ASequence, i + 1);
    ELSE
      SELECT USER
      INTO strProp
      FROM dual;
     
      strSequence := ASequence;    
    END IF;
   
    EXECUTE immediate 'select last_number from sys.all_sequences where sequence_owner= :1 and sequence_name = :2'
    INTO i
    USING strProp, strSequence;
   
    RETURN i;
  END;

 /* ********************************************************************************************** */
  PROCEDURE initialiser_sequence(ASequence IN varchar2,
                                 ADebut IN INTEGER DEFAULT NULL)
  AS
  BEGIN
    EXECUTE immediate 'drop sequence ' || ASequence;
    EXECUTE immediate 'create sequence ' || ASequence || ' start with ' || nvl(ADebut, 1) || ' nocache';
  exception
    WHEN sequence_inexistante THEN
      strErreur := sqlerrm;      

      INSERT INTO migration.t_erreur(t_erreur_id, categorie, donnees, texte)
      VALUES(seq_erreur.NEXTVAL, 'SUPPRESSION SEQUENCE', ASequence, strErreur);
  END;

 /* ********************************************************************************************** */
  PROCEDURE supprimer_adresses(AAdresses IN tab_integer)
  AS
    i INTEGER;
  BEGIN
      forall i IN AAdresses.FIRST..AAdresses.LAST
        DELETE FROM bel.t_adresse
        WHERE t_adresse_id = AAdresses(i);        
  END;
 
 
/* ********************************************************************************************** */
  FUNCTION affecter_etat_contraintes(AShema IN varchar2,
                                     AEtatContraintes IN BOOLEAN)
                                    RETURN INTEGER
  AS
    intNbContraintesDes INTEGER;
    strEtatContraintes varchar2(10);
  BEGIN
    IF AEtatContraintes THEN
      strEtatContraintes := 'enable';
    ELSE
      strEtatContraintes := 'disable';
    END IF;

    FOR cr_cntrs IN (SELECT TABLE_NAME, constraint_name, STATUS
                     FROM sys.all_constraints
                     WHERE owner = UPPER(AShema)
                       AND constraint_type = 'R') loop
      BEGIN
        IF (AEtatContraintes AND (cr_cntrs.STATUS = 'DISABLED')) OR (NOT AEtatContraintes AND (cr_cntrs.STATUS = 'ENABLED')) THEN
          EXECUTE immediate 'alter table ' || AShema || '.' || cr_cntrs.TABLE_NAME || ' modify constraint ' || cr_cntrs.constraint_name || ' ' || strEtatContraintes;
        END IF;
      exception
        WHEN others THEN
          strErreur := sqlerrm;
         
          INSERT INTO migration.t_erreur(t_erreur_id, categorie, donnees, texte)
          VALUES(seq_erreur.NEXTVAL, '(DES)ACTIVATION CONSTRAINTES', AShema || '.' || cr_cntrs.TABLE_NAME || '.' || cr_cntrs.constraint_name, strErreur);
      END;
    END loop;
   
    SELECT COUNT(*)
    INTO intNbContraintesDes
    FROM sys.all_constraints
    WHERE owner = UPPER(AShema)
      AND constraint_type = 'R'
      AND STATUS = 'DISABLED';
   
    RETURN intNbContraintesDes;
  END;
 
  /* ********************************************************************************************** */
  PROCEDURE supprimer_donnees_table(ATable IN varchar2,
                                    ASequence IN varchar2 DEFAULT NULL)
  AS
    i INTEGER;
  BEGIN
    IF ATable IS NOT NULL THEN
      BEGIN
        EXECUTE immediate 'select count(*) from ' || ATable INTO i;
        IF i > 0 THEN
          EXECUTE immediate 'truncate table ' ||ATable;
        END IF;
      exception
        WHEN table_inexistante THEN
          strErreur := sqlerrm;
         
          INSERT INTO migration.t_erreur(t_erreur_id, categorie, donnees, texte)
          VALUES(seq_erreur.NEXTVAL, 'SUPPRESSION TABLE', ATable, strErreur);
      END;
     
      IF ASequence IS NOT NULL THEN
        initialiser_sequence(ASequence);
      END IF;
    END IF;
  END;
 
  /*********************************************************************************************/
  function initialiser_donnees return integer 
  as
    intNbContraintesDes integer;
  begin
    execute immediate 'alter database datafile ''/home/oracle/oradata/PHAL1/undotbs01.dbf'' autoextend on next 10M';
   
    intNbContraintesDes := affecter_etat_contraintes('BEL', false);

    delete from bel.t_adresse where t_adresse_id in (select t_adresse_id from bel.t_assureayantdroit);
    delete from bel.t_adresse where t_adresse_id in (select t_adresse_id from bel.t_banque);
    delete from bel.t_adresse where t_adresse_id in (select adresseid from bel.t_destinataire);
    delete from bel.t_adresse where t_adresse_id in (select t_adresse_id from bel.t_destinatairestat);
    delete from bel.t_adresse where t_adresse_id in (select t_adresse_id from bel.t_praticienprive);

    supprimer_donnees_table('bel.assoctmp');
    supprimer_donnees_table('bel.eti_libel');
    supprimer_donnees_table('bel.inv_import_format');
    supprimer_donnees_table('bel.inv_produit_inx');
    supprimer_donnees_table('bel.inv_produit_rap');
    supprimer_donnees_table('bel.inv_produit_ref');
    supprimer_donnees_table('bel.lvst');
    supprimer_donnees_table('bel.plan_table');
    supprimer_donnees_table('bel.t_aad_contact');
    supprimer_donnees_table('bel.t_accessoire_produit', 'bel.seq_id_accessoire_produit');
    supprimer_donnees_table('bel.t_acte', 'bel.seq_id_acte');
    supprimer_donnees_table('bel.t_acte_bon_reduction', 'bel.seq_t_acte_bon_reduction');
    supprimer_donnees_table('bel.t_activite', 'bel.seq_id_activite');
    supprimer_donnees_table('bel.t_affectation', 'bel.seq_id_affectation');
    supprimer_donnees_table('bel.t_alerte', 'bel.seq_id_t_alerte');
    supprimer_donnees_table('bel.t_allergiedelphiatcassaad', 'bel.seq_id_allergiedelphiatcassaad');
    supprimer_donnees_table('bel.t_allergieexcipientassaad', 'bel.seq_id_allergieexcipientassaad');
    supprimer_donnees_table('bel.t_annonce', 'bel.seq_id_annonce');
    supprimer_donnees_table('bel.t_anomalie', 'bel.seq_id_anomalie');
    --supprimer_donnees_table('bel.t_arrondi');
    supprimer_donnees_table('bel.t_assoc');
    supprimer_donnees_table('bel.t_assoc_detail');
    supprimer_donnees_table('bel.t_assocrepart');
    supprimer_donnees_table('bel.t_assocrepart_stat');
    supprimer_donnees_table('bel.t_assurabilite', 'bel.seq_id_assurabilite');
    supprimer_donnees_table('bel.t_assureayantdroit', 'bel.seq_assureayantdroit');
    supprimer_donnees_table('bel.t_attente', 'bel.seq_id_attente');
    supprimer_donnees_table('bel.t_attestationremb', 'bel.seq_attestationremb');
    supprimer_donnees_table('bel.t_automatisationcdes', 'bel.seq_id_automatisationcdes');
    supprimer_donnees_table('bel.t_bac_doc');
    supprimer_donnees_table('bel.t_bac_imp');
    supprimer_donnees_table('bel.t_banque', 'bel.seq_id_banque');
    supprimer_donnees_table('bel.t_binomeannonce', 'bel.seq_id_binomeannonce');
    supprimer_donnees_table('bel.t_blacklist_shortliner');
    supprimer_donnees_table('bel.t_blob');
    supprimer_donnees_table('bel.t_boite_tuh', 'bel.seq_id_boite_tuh');
    supprimer_donnees_table('bel.t_bon_cadeau_ligne_vente', 'bel.seq_id_bon_cadeau_ligne_vente'); 
    supprimer_donnees_table('bel.t_bordereauaediter', 'bel.seq_id_bordereauaediter');
    supprimer_donnees_table('bel.t_bordereau_especes');
    supprimer_donnees_table('bel.t_bordereau_nbex_per_org', 'bel.seq_bordereau_nbex'); 
    supprimer_donnees_table('bel.t_bordereauorganisme', 'bel.seq_id_bordereauorganisme');
    supprimer_donnees_table('bel.t_caissecentrale', 'bel.seq_id_caissecentrale');
    supprimer_donnees_table('bel.t_campagne_suivi', 'bel.seq_id_campagne_suivi');
    supprimer_donnees_table('bel.t_catalogue_tarif');
    supprimer_donnees_table('bel.t_cbu_attente', 'bel.seq_id_cbu_attente');
    supprimer_donnees_table('bel.t_chim_attestation', 'bel.seq_id_chim_attestation');
    supprimer_donnees_table('bel.t_chim_denomination', 'bel.seq_id_chim_denomination');
  	supprimer_donnees_table('bel.t_chim_fiche_analyse', 'bel.seq_id_chim_fiche_analyse');
    supprimer_donnees_table('bel.t_chim_liste', 'bel.seq_id_chim_liste');
    supprimer_donnees_table('bel.t_chim_manipulation', 'bel.seq_id_chim_manipulation');
    supprimer_donnees_table('bel.t_chim_produit', 'bel.seq_id_chim_produit');
    supprimer_donnees_table('bel.t_chim_tarif', 'bel.seq_id_chim_tarif');
    supprimer_donnees_table('bel.t_cip_report_histodeliv');
    supprimer_donnees_table('bel.t_classificationgroupe', 'bel.seq_id_classificationgroupe');
    supprimer_donnees_table('bel.t_client_facturation_temp');
    supprimer_donnees_table('bel.t_clientgroupementachat');
    supprimer_donnees_table('bel.t_code_ean13', 'bel.seq_id_code_ean13');
    supprimer_donnees_table('bel.t_code_rfid');
    supprimer_donnees_table('bel.t_codif1', 'bel.seq_id_codif1');
    supprimer_donnees_table('bel.t_codif2', 'bel.seq_id_codif2');
    supprimer_donnees_table('bel.t_codif3', 'bel.seq_id_codif3');
    supprimer_donnees_table('bel.t_codif4', 'bel.seq_id_codif4');
    supprimer_donnees_table('bel.t_codif5', 'bel.seq_id_codif5');
    supprimer_donnees_table('bel.t_collectivite');
    supprimer_donnees_table('bel.t_collectivite_sauv');
    supprimer_donnees_table('bel.t_commande', 'bel.seq_id_commande');
    supprimer_donnees_table('bel.t_commandeapercu', 'bel.seq_commandeapercu');
    supprimer_donnees_table('bel.t_commande_depot', 'bel.seq_id_commande_depot');
    supprimer_donnees_table('bel.t_compte_ftp', 'bel.seq_id_compte_ftp');
    supprimer_donnees_table('bel.t_contact', 'bel.seq_contact');
    supprimer_donnees_table('bel.t_content_doc');
    supprimer_donnees_table('bel.t_credit_non_central');
    supprimer_donnees_table('bel.t_creer_facturation_tmp');
    supprimer_donnees_table('bel.t_crist_cartes', 'bel.seq_id_crist_cartes');
    supprimer_donnees_table('bel.t_crist_cartes_syn');
    supprimer_donnees_table('bel.t_crist_cheque', 'bel.seq_id_crist_cheque');
    supprimer_donnees_table('bel.t_crist_comptes', 'bel.seq_id_crist_comptes');
    supprimer_donnees_table('bel.t_crist_prefixe', 'bel.seq_id_crist_prefixe');
    supprimer_donnees_table('bel.t_crist_recu', 'bel.seq_id_crist_recu');
    supprimer_donnees_table('bel.t_crist_transaction', 'bel.seq_id_crist_transaction');
    supprimer_donnees_table('bel.t_date_peremption_boite', 'bel.seq_id_date_peremption_boite');
    supprimer_donnees_table('bel.t_delivrancediff', 'bel.seq_delivrancediff');
    supprimer_donnees_table('bel.t_depot_allee', 'bel.seq_id_depot_allee');
    supprimer_donnees_table('bel.t_depot_position', 'bel.seq_id_depot_position');
    supprimer_donnees_table('bel.t_depot_rayon', 'bel.seq_id_depot_rayon');
    supprimer_donnees_table('bel.t_depot_tablette', 'bel.seq_id_depot_tablette');
    supprimer_donnees_table('bel.t_destinataire', 'bel.seq_destinataire'); 
    --supprimer_donnees_table('bel.t_destinatairestat');      --------------------- Table parametre ne pas suppr pour test
    supprimer_donnees_table('bel.t_doc_asso');
    supprimer_donnees_table('bel.t_document', 'bel.seq_id_document');
    supprimer_donnees_table('bel.t_dossierattente');
    supprimer_donnees_table('bel.t_dossier_location', 'bel.seq_id_dossier_location');
    supprimer_donnees_table('bel.t_ebiz_potentiel_assoc');
    supprimer_donnees_table('bel.t_ebiz_stat_assoc');
    supprimer_donnees_table('bel.t_editionacc', 'bel.seq_id_editionacc');
    supprimer_donnees_table('bel.t_edition_envoiot', 'bel.seq_id_edition_envoiot');
    supprimer_donnees_table('bel.t_email', 'bel.seq_email');
    supprimer_donnees_table('bel.t_encaissement', 'bel.seq_id_encaissement');
    supprimer_donnees_table('bel.t_entree_nolot', 'bel.seq_id_entree_nolot');
    supprimer_donnees_table('bel.t_entree_nolot_pm', 'bel.seq_id_entree_nolot_pm');
    supprimer_donnees_table('bel.t_envoi_alerte_sms', 'bel.seq_id_envoi_alerte_sms');
    supprimer_donnees_table('bel.t_erreur', 'bel.seq_erreur');
    supprimer_donnees_table('bel.t_es_fondcaisse', 'bel.seq_es_fondcaisse');
    supprimer_donnees_table('bel.t_etatpathoassaad', 'bel.seq_id_etatpathoassaad');
    supprimer_donnees_table('bel.t_etiquette_tmp_impr');
    supprimer_donnees_table('bel.t_facturation', 'bel.seq_id_facturation');
    supprimer_donnees_table('bel.t_facture', 'bel.seq_id_facture');
    supprimer_donnees_table('bel.t_facture_oxygene', 'bel.seq_id_facture_oxygene');
    supprimer_donnees_table('bel.t_familleaad');
    supprimer_donnees_table('bel.t_fichier');
    supprimer_donnees_table('bel.t_fichierstats', 'bel.seq_id_fichierstats');
    supprimer_donnees_table('bel.t_fmd_historique', 'bel.seq_id_fmd_historique');
    supprimer_donnees_table('bel.t_fmd_facturation', 'bel.seq_id_fmd_facturation');
    supprimer_donnees_table('bel.t_fondcaisseoperateur', 'bel.seq_id_fondcaisseoperateur');
    supprimer_donnees_table('bel.t_fondcaissetiroirc', 'bel.seq_id_fondcaissetiroirc');
    supprimer_donnees_table('bel.t_formularium');
    supprimer_donnees_table('bel.t_formularium_entete', 'bel.seq_id_formularium_entete');
    supprimer_donnees_table('bel.t_formularium_ligne', 'bel.seq_id_formularium_ligne');
    supprimer_donnees_table('bel.t_fournisseurdfournisseurd');
    supprimer_donnees_table('bel.t_fournisseurfabricant', 'bel.seq_id_fournisseurfabricant');
    supprimer_donnees_table('bel.t_frais_facture', 'bel.seq_id_frais_facture');
    supprimer_donnees_table('bel.t_gamme', 'bel.seq_id_gamme');
    supprimer_donnees_table('bel.t_gamme_regle', 'bel.seq_id_gam_regle');
    supprimer_donnees_table('bel.t_genere_historique', 'bel.seq_id_genere_affichage');
    supprimer_donnees_table('bel.t_genere_modele', 'bel.seq_id_genere_modele');
    supprimer_donnees_table('bel.t_generique_sauv');
    supprimer_donnees_table('bel.t_generique_tmp_suiviachat');
    supprimer_donnees_table('bel.t_hermes_destinataire', 'bel.seq_hermes_destinataire');
    supprimer_donnees_table('bel.t_heures_prises');
    supprimer_donnees_table('bel.t_hermes_message', 'bel.seq_hermes_message');
    supprimer_donnees_table('bel.t_histo_client_entete', 'bel.seq_pk_histo_client_entete');
    supprimer_donnees_table('bel.t_histo_client_ligne', 'bel.seq_pk_histo_client_ligne');
    supprimer_donnees_table('bel.t_historiqueachatcumule', 'bel.seq_id_historiqueachatcumule');
    supprimer_donnees_table('bel.t_historiquevente', 'bel.seq_id_historiquevente');
    supprimer_donnees_table('bel.t_homelink_commande', 'bel.seq_id_homelink_commande');
    supprimer_donnees_table('bel.t_homelink_facture', 'bel.seq_id_homelink_facture');
    supprimer_donnees_table('bel.t_homelink_fichier', 'bel.seq_id_homelink_fichier');
    supprimer_donnees_table('bel.t_homelink_home', 'bel.seq_id_homelink_home');
    supprimer_donnees_table('bel.t_homelink_lignemag', 'bel.seq_id_homelink_lignemag');
    supprimer_donnees_table('bel.t_homelink_ligneprod', 'bel.seq_id_homelink_ligneprod');
    supprimer_donnees_table('bel.t_homelink_patient', 'bel.seq_id_homelink_patient');
    supprimer_donnees_table('bel.t_homelink_prescripteur', 'bel.seq_id_homelink_prescripteur');
    supprimer_donnees_table('bel.t_honorairesupp', 'bel.seq_id_honorairesupp');
    supprimer_donnees_table('bel.t_id_conversion');
    supprimer_donnees_table('bel.t_impression_temp');
    supprimer_donnees_table('bel.t_infoscanner', 'bel.seq_id_infoscanner');
    supprimer_donnees_table('bel.t_instancesaediter', 'bel.seq_id_instancesaediter');
    supprimer_donnees_table('bel.t_intfactoffi_entete', 'bel.seq_id_intfactoffi_entete');
    supprimer_donnees_table('bel.t_intfactoffi_ligne', 'bel.seq_id_intfactoffi_ligne');
    supprimer_donnees_table('bel.t_inventaire');
    supprimer_donnees_table('bel.t_inventairecip');
    supprimer_donnees_table('bel.t_jourgardeferie', 'bel.seq_id_jourgardeferie');
    supprimer_donnees_table('bel.t_licences', 'bel.seq_id_licences');
    supprimer_donnees_table('bel.t_lignealerte', 'bel.seq_id_t_lignealerte');
    supprimer_donnees_table('bel.t_lignecommande', 'bel.seq_id_lignecommande');
    supprimer_donnees_table('bel.t_lignecommandeapercu');
    supprimer_donnees_table('bel.t_lignecommande_depot', 'bel.seq_id_lignecommande_depot');
    supprimer_donnees_table('bel.t_lignecommande_manquant', 'bel.seq_id_lignecommande_manquant');
    supprimer_donnees_table('bel.t_lignecommanderecu', 'bel.seq_id_lignecommanderecu');
    supprimer_donnees_table('bel.t_lignefacturation', 'bel.seq_id_lignefacturation');
    supprimer_donnees_table('bel.t_ligne_interact_masquee', 'bel.seq_id_ligne_interact_masquee');
    supprimer_donnees_table('bel.t_ligne_package_produit');
    supprimer_donnees_table('bel.t_ligne_pv_degressif', 'bel.seq_id_ligne_pv_degressif');
    supprimer_donnees_table('bel.t_lignereappro', 'bel.seq_id_lignereappro');
    supprimer_donnees_table('bel.t_lignerecurrence_moisans', 'bel.seq_id_lignerecurrence_moisans');
    supprimer_donnees_table('bel.t_ligne_reclamation', 'bel.seq_id_lignereclamation');
    supprimer_donnees_table('bel.t_ligneretrocession', 'bel.seq_id_ligneretrocession');
    supprimer_donnees_table('bel.t_ligne_tarif_perso', 'bel.seq_id_ligne_tarif_perso');
    supprimer_donnees_table('bel.t_lignevente', 'bel.seq_id_lignevente');
    supprimer_donnees_table('bel.t_lignevente_cbu', 'bel.seq_id_lignevente_cbu');
    supprimer_donnees_table('bel.t_lignevente_date_peremption');
    supprimer_donnees_table('bel.t_lignevente_delphicare');
    supprimer_donnees_table('bel.t_lignevente_nolot', 'bel.seq_id_lignevente_nolot');
    supprimer_donnees_table('bel.t_lignevente_nolot_pm', 'bel.seq_id_lignevente_nolot_pm');
    supprimer_donnees_table('bel.t_lignevente_sauv');
    supprimer_donnees_table('bel.t_liste_interv_client_cpas', 'bel.seq_id_liste_intervclient_cpas');
    supprimer_donnees_table('bel.t_liste_prescripteur_cpas', 'bel.seq_id_liste_prescripteur_cpas');
    supprimer_donnees_table('bel.t_liste_prod_cpas', 'bel.seq_id_liste_prod_cpas');
    supprimer_donnees_table('bel.t_magi_incorporee', 'bel.seq_id_magi_incorporee');
    supprimer_donnees_table('bel.t_magi_ligne_formule', 'bel.seq_id_magi_ligne_formule');
    supprimer_donnees_table('bel.t_magi_ligne_incorporee', 'bel.seq_id_magi_ligne_incorporee');
    supprimer_donnees_table('bel.t_magi_ligne_magistrale', 'bel.seq_id_magi_ligne_magistrale');
    supprimer_donnees_table('bel.t_magi_magistrale', 'bel.seq_id_magi_magistrale');
    supprimer_donnees_table('bel.t_magi_uniformite', 'bel.seq_id_magi_uniformite');
    supprimer_donnees_table('bel.t_magi_uniformite_calcul', 'bel.seq_id_magi_uniformite_calcul');
    supprimer_donnees_table('bel.t_mailcommande', 'bel.seq_id_mailcommande');
    supprimer_donnees_table('bel.t_materiel_a_la_vente');
    supprimer_donnees_table('bel.t_medication_heure_prise', 'bel.seq_id_medication_heure_prise');
    supprimer_donnees_table('bel.t_memorisation_ventil_stock', 'bel.seq_id_memo_ventil_stock');
    supprimer_donnees_table('bel.t_message171', 'bel.seq_id_message171');
    supprimer_donnees_table('bel.t_mtdetail', 'bel.seq_id_mtdetail');
    supprimer_donnees_table('bel.t_mvt_fondcaisse', 'bel.seq_mvt_fondcaisse');
    supprimer_donnees_table('bel.t_mvt_fondcaisse_tempo', 'bel.seq_mvt_fondcaisse_tempo');
    supprimer_donnees_table('bel.t_nolot_peremption', 'bel.seq_id_nolot_peremption');
    supprimer_donnees_table('bel.t_numeroanalyse_nonaff', 'bel.seq_id_numanalyse_nonaff');
    supprimer_donnees_table('bel.t_numerodossierloc_nonaff', 'bel.seq_id_numerodossierloc_nonaff');
    supprimer_donnees_table('bel.t_numeroordo_nonaff', 'bel.seq_id_numeroordo_nonaff');
    supprimer_donnees_table('bel.t_offidel');
    supprimer_donnees_table('bel.t_ordonnancier_entete', 'bel.seq_id_ordonnancier_entete');
    supprimer_donnees_table('bel.t_ordonnancier_ligne', 'bel.seq_id_ordonnancier_ligne');
    supprimer_donnees_table('bel.t_paiement', 'bel.seq_id_paiement');
    supprimer_donnees_table('bel.t_panier_etiquettes');
    supprimer_donnees_table('bel.t_panier_facing');
    supprimer_donnees_table('bel.t_panier_relance', 'bel.seq_id_panier_relance');
    supprimer_donnees_table('bel.t_panier_suiviachat');
    --supprimer_donnees_table('bel.t_parametre_poste', 'bel.seq_id_parametre_poste');          --------------------- Table parametre ne pas suppr pour test
    supprimer_donnees_table('bel.t_param_peremp_mag');
    supprimer_donnees_table('bel.t_partenaire');
    supprimer_donnees_table('bel.t_periode_tarification', 'bel.seq_id_periode_tarification');
    --supprimer_donnees_table('bel.t_peripherique', 'bel.seq_id_peripherique');         --------------------- Table parametre ne pas suppr pour test
    supprimer_donnees_table('bel.t_pharmagora');
    supprimer_donnees_table('bel.t_planification', 'bel.seq_id_planification');
    supprimer_donnees_table('bel.t_poso_perso', 'bel.seq_id_poso_perso');
    supprimer_donnees_table('bel.t_poso_produit', 'bel.seq_id_poso_produit');
    supprimer_donnees_table('bel.t_poste_doc');
    supprimer_donnees_table('bel.t_praticienprive', 'bel.seq_id_praticien');
    supprimer_donnees_table('bel.t_produit_copie');
    supprimer_donnees_table('bel.t_produit_disponibilite', 'bel.seq_id_produit_disponibilite');
    supprimer_donnees_table('bel.t_produitdu', 'bel.seq_id_produitdu');
    supprimer_donnees_table('bel.t_produitgeographique', 'bel.seq_id_produitgeographique');
    supprimer_donnees_table('bel.t_produit_noserie', 'bel.seq_id_produit_noserie');
    supprimer_donnees_table('bel.t_produitpromotion');
    supprimer_donnees_table('bel.t_produit_pv_modifie');
    supprimer_donnees_table('bel.t_produit_rembourse_mp', 'bel.seq_id_produit_rembourse_mp');
    supprimer_donnees_table('bel.t_produitsvendus');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_catinv');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_catprod');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_codif1');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_codif2');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_codif3');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_codif4');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_codif5');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_labo');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_legis');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_offibase');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_reg');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_temp');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_tva');
    supprimer_donnees_table('bel.t_profilcondrepsuppl_usage');
    supprimer_donnees_table('bel.t_profil_maj_suppl', 'bel.seq_id_profil_maj_suppl');
    supprimer_donnees_table('bel.t_profil_maj_suppl_catprod');
    supprimer_donnees_table('bel.t_profil_maj_suppl_classif');
    supprimer_donnees_table('bel.t_profil_maj_suppl_forfscl');
    supprimer_donnees_table('bel.t_profil_maj_suppl_labo');
    supprimer_donnees_table('bel.t_profil_maj_suppl_tva');
    supprimer_donnees_table('bel.t_profil_maj_suppl_usage');
    supprimer_donnees_table('bel.t_profilremise', 'bel.seq_id_profilremise');
    supprimer_donnees_table('bel.t_profilremisesuppl', 'bel.seq_id_profilremisesuppl');
    supprimer_donnees_table('bel.t_profilremisesuppl_catinv');
    supprimer_donnees_table('bel.t_profilremisesuppl_catprod');
    supprimer_donnees_table('bel.t_profilremisesuppl_classif');
    supprimer_donnees_table('bel.t_profilremisesuppl_cnk');
    supprimer_donnees_table('bel.t_profilremisesuppl_forfscl');
    supprimer_donnees_table('bel.t_profilremisesuppl_labo');
    supprimer_donnees_table('bel.t_profilremisesuppl_legis');
    supprimer_donnees_table('bel.t_profilremisesuppl_reg');
    supprimer_donnees_table('bel.t_profilremisesuppl_temp');
    supprimer_donnees_table('bel.t_profilremisesuppl_tva');
    supprimer_donnees_table('bel.t_profilremisesuppl_usage');
    supprimer_donnees_table('bel.t_profil_tarif_perso', 'bel.seq_id_profil_tarif_perso');
    supprimer_donnees_table('bel.t_pro_forma', 'bel.seq_id_pro_forma');
    supprimer_donnees_table('bel.t_promotion_avantage', 'bel.seq_promotion_avantage');
    supprimer_donnees_table('bel.t_promotion_critere_alerte', 'bel.seq_promotion_critere_alerte');
    supprimer_donnees_table('bel.t_promotion_entete', 'bel.seq_promotion_entete');
    supprimer_donnees_table('bel.t_promotion_produit', 'bel.seq_promotion_produit');
    supprimer_donnees_table('bel.t_promotion_suspension', 'bel.seq_promotion_suspension');
    supprimer_donnees_table('bel.t_purge', 'bel.seq_id_purge');
    supprimer_donnees_table('bel.t_purge_rapport');
    supprimer_donnees_table('bel.t_qtearanger');
    supprimer_donnees_table('bel.t_reappro', 'bel.seq_id_reappro');
    supprimer_donnees_table('bel.t_reclamation', 'bel.seq_id_reclamation');
  	initialiser_sequence('bel.seq_no_reclamation');
	  supprimer_donnees_table('bel.t_receptrav_codeproduit');
    supprimer_donnees_table('bel.t_receptrav_entete', 'bel.seq_id_receptrav_entete');
    supprimer_donnees_table('bel.t_receptrav_ligne', 'bel.seq_id_receptrav_ligne');
    supprimer_donnees_table('bel.t_recipe_fichier', 'bel.seq_id_recipe_fichier');
    supprimer_donnees_table('bel.t_recurrence', 'bel.seq_id_recurrence');
    supprimer_donnees_table('bel.t_reglecpas', 'bel.seq_id_reglecpas');
    supprimer_donnees_table('bel.t_regle_gamme_exclus', 'bel.seq_id_regle_gamme_exclus');
    supprimer_donnees_table('bel.t_reglement', 'bel.seq_id_reglement');
    supprimer_donnees_table('bel.t_reglementorganisme', 'bel.seq_id_reglementorganisme');
    supprimer_donnees_table('bel.t_regle_remisepara', 'bel.seq_id_regle_remisepara');
    supprimer_donnees_table('bel.t_regle_shortliner', 'bel.seq_id_regle_shortliner');
    supprimer_donnees_table('bel.t_renumerotation', 'bel.seq_id_renumerotation');
    supprimer_donnees_table('bel.t_repartiteur_cdes_speciales');
    supprimer_donnees_table('bel.t_repartiteur_codereponse', 'bel.seq_id_repartiteur_codereponse');
    supprimer_donnees_table('bel.t_repartiteur_pharmaml_ref');
    supprimer_donnees_table('bel.t_scenario', 'bel.seq_id_scenario');
    supprimer_donnees_table('bel.t_scenario_contexte');
    supprimer_donnees_table('bel.t_sch_medication_prise', 'bel.seq_id_sch_medication_prise');
    supprimer_donnees_table('bel.t_sch_medication_produit', 'bel.seq_id_sch_medication_produit');
    supprimer_donnees_table('bel.t_sch_prise_date', 'bel.seq_id_sch_prise_date');
    supprimer_donnees_table('bel.t_service', 'bel.seq_id_service');
    supprimer_donnees_table('bel.t_serviceparam', 'bel.seq_id_serviceparam');
    supprimer_donnees_table('bel.t_stat_acnielsen', 'bel.seq_id_stat_acnielsen');
    supprimer_donnees_table('bel.t_stock_qualipharma', 'bel.seq_id_stock_qualipharma');
    supprimer_donnees_table('bel.t_substituable');
    supprimer_donnees_table('bel.t_substituable_famille', 'bel.seq_id_substituable_famille');
    supprimer_donnees_table('bel.t_sv_messageservice');
    supprimer_donnees_table('bel.t_sv_messagesmtp');
    supprimer_donnees_table('bel.t_synchro_pharmacie', 'bel.seq_id_synchro_pharmacie');
    supprimer_donnees_table('bel.t_tache_consultation');
    supprimer_donnees_table('bel.t_tache_operateur', 'bel.seq_id_tache_operateur');
    supprimer_donnees_table('bel.t_traceacte', 'bel.seq_id_traceacte');
    supprimer_donnees_table('bel.t_traceacte_ligne', 'bel.seq_id_traceacte_ligne');
    supprimer_donnees_table('bel.t_trace_cderep_auto', 'bel.seq_id_trace_cderep_auto');
    supprimer_donnees_table('bel.t_traceqtecommande', 'bel.seq_id_traceqtecommande');
    supprimer_donnees_table('bel.t_tracestock');
    supprimer_donnees_table('bel.t_tracestockprix', 'bel.seq_id_tracestockprix');
  	supprimer_donnees_table('bel.T_TRACESTOCK_TUH', 'bel.SEQ_ID_TRACESTOCK_TUH');
    supprimer_donnees_table('bel.t_tri_canevas_facture', 'bel.seq_id_tri_canevas_facture');
    supprimer_donnees_table('bel.t_tri_commande');
    supprimer_donnees_table('bel.t_tuh', 'bel.seq_id_tuh');
    supprimer_donnees_table('bel.t_tuh_anomalie_fichier', 'bel.SEQ_ID_TUH_ANOMALIE_FICHIER'); 
    supprimer_donnees_table('bel.t_tuh_fichier', 'bel.seq_id_tuh_fichier');
    supprimer_donnees_table('bel.t_tuh_tarification', 'bel.seq_id_tuh_tarification');
    supprimer_donnees_table('bel.t_type_besoin_pharmacie');
    supprimer_donnees_table('bel.t_typeserviceparam');
    supprimer_donnees_table('bel.t_ventilation_tva_facture', 'bel.seq_id_ventilationtva');
    supprimer_donnees_table('bel.t_verrou', 'bel.seq_id_verrou');
    supprimer_donnees_table('bel.T_WEBRESERVATION', 'bel.SEQ_ID_WEBRESERVATION'); 
  	supprimer_donnees_table('bel.T_WEBRESERVATION_DETAIL', 'bel.SEQ_ID_WEBRESERVATION_DETAIL'); 
	  supprimer_donnees_table('bel.T_WEBRESERVATION_HISTO', 'bel.SEQ_ID_WEBRESERVATION_HISTO'); 
	  supprimer_donnees_table('bel.T_WEBRESERVATION_MESSAGE', 'bel.SEQ_ID_WEBRESERVATION_MESSAGE'); 
    supprimer_donnees_table('bel.t_zonegeographique', 'bel.seq_id_zonegeographique'); 

	--Suppression des tables TW
    supprimer_donnees_table('migration.tw_client'); 
	supprimer_donnees_table('migration.tw_famille'); 

	delete from bel.t_remboursement where t_produit_id in (select null from bel.t_produit where (t_produit_id not between 1 and 77) or (hono_urgence = '0'));      
	delete from bel.t_tarif_produit where t_produit_id in (select null from bel.t_produit where (t_produit_id not between 1 and 77) or (hono_urgence = '0'));      

	delete from bel.t_produit where t_produit_id not in ( 
		select t_produit_id from bel.t_produit
		where codecip like '55%'
		or codecip in ('2733772', '2733780', '2852762', '2852754', '0000802', '0000810', '0000828', '0000836', '0000844', '0000085', '4004693', '4004941')
		or hono_urgence = '1' 
		or type_produit_particulier in (1, 4, 5, 6)
		or ligne_caution in ('1', '2'));
	
	update bel.t_produit set t_codif1_id = null, t_codif2_id = null, t_codif3_id = null, t_codif4_id = null, t_codif5_id = null, T_LABORATOIRE_ID =null, T_CONCESSIONNAIRE_ID= null;
  
  -- On supprime les fourn et rep en laissant ceux de base dans le serveur
  delete from bel.t_fournisseurdirect where t_fournisseurdirect_id > 1971; 
  update bel.t_fournisseurdirect set t_aad_id = null;
  delete from bel.t_repartiteur where t_repartiteur_id > 74; 
  update bel.t_repartiteur set t_aad_id = null, t_repartiteur_reaffmqts_id = null;

	update bel.t_organismeamc set t_reglecpas_id = null;
	update bel.t_organismeamo set t_reglecpas_id = null;
	
    -- Réattribution des droits Offibase/Multipharma
    ps_executer_script('SU_SCRIPT_OFFIBASE', 'grantTableBelToOffibase.sql');
    --ps_executer_script('SU_SCRIPT_MULTIPHARMA', 'grantTableBelToMP.sql');

	intNbContraintesDes := affecter_etat_contraintes('BEL', true);
    return  intNbContraintesDes;
  end;
  
  /*********************************************************************************************/
  FUNCTION supprimer_donnees(ATypeSuppression IN INTEGER)
                            RETURN INTEGER
  AS
    i INTEGER;      
    intNbContraintesDes INTEGER;
        max_id_adr INTEGER;
    tabIDAdresses tab_integer;
    tabIDActes tab_integer;
  BEGIN
    intNbContraintesDes := affecter_etat_contraintes('BEL', FALSE);

    IF ATypeSuppression = C_SUPPRESSION_PRATICIENS THEN
      DELETE FROM bel.t_praticienprive
          returning t_adresse_id bulk collect INTO tabIDAdresses;
      supprimer_adresses(tabIDAdresses);
      initialiser_sequence('bel.seq_id_praticien');
          SELECT MAX(t_adresse_id) INTO max_id_adr FROM bel.t_adresse;
          initialiser_sequence('bel.seq_adresse',max_id_adr);
          EXECUTE immediate('GRANT select on bel.SEQ_ADRESSE to BDDB');  --droits de la sequence adresse sur BDDB

          /*elsif ATypeSuppression = C_SUPPRESSION_ORGANISMES then
      delete from bel.t_destinataire
      returning adresseid bulk collect into tabIDAdresses;
      supprimer_adresses(tabIDAdresses);
      initialiser_sequence('bel.seq_destinataire');
     
      supprimer_donnees_table('bel.t_bordereau_nbex_per_org', 'bel.seq_bordereau_nbex');
      delete from bel.t_organismepayeur        
      where t_organismepayeur_id not in (select t_organismepayeur_id
                                         from bel.t_organismeamo                                      
                                         union
                                         select t_organismepayeur_id
                                         from bel.t_organismeamc);                        
      delete from bel.t_organismeamo where orgreference = '0';
      update bel.t_organismeamo set t_destinataire_id = null;    
      delete from bel.t_organismeamc where orgreference = '0';
      update bel.t_organismeamc set t_destinataire_id = null;
     
      update bel.t_assureayantdroit
      set t_organismeamo_id = null,
          t_organismeamc_id = null;
     
      supprimer_donnees_table('bel.t_couvertureaadamo', 'bel.seq_id_couvertureaadamo');
      supprimer_donnees_table('bel.t_couvertureaadamc', 'bel.seq_id_couvertureaadamc');*/
        elsif ATypeSuppression = C_SUPPRESSION_CLIENTS THEN
      supprimer_donnees_table('bel.t_assurabilite', 'bel.seq_id_assurabilite');
      supprimer_donnees_table('bel.t_familleaad', 'bel.seq_no_famille'); ---------------
      supprimer_donnees_table('bel.t_collectivite'); ----------------
      supprimer_donnees_table('bel.t_produitdu', 'bel.seq_id_produitdu');
      supprimer_donnees_table('bel.t_attestationremb', 'bel.seq_attestationremb'); -------------
      supprimer_donnees_table('bel.t_assureayantdroit', 'bel.seq_assureayantdroit');
     
      DELETE FROM bel.t_activite WHERE TYPE = 'A';
     
      intNbContraintesDes := supprimer_donnees(C_SUPPRESSION_ENCOURS);
      intNbContraintesDes := supprimer_donnees(C_SUPPRESSION_AUTRES_DONNEES);
      intNbContraintesDes := supprimer_donnees(C_SUPPRESSION_AVANTAGES);
     
    elsif ATypeSuppression = C_SUPPRESSION_PRODUITS THEN
      supprimer_donnees_table('bel.t_zonegeographique','bel.seq_id_zonegeographique');
     
      --delete from bel.t_fournisseur where foud_partenaire = '0'
      --returning t_adresse_id bulk collect into tabIDAdresses;
      --supprimer_adresses(tabIDAdresses);
     
      --Mis en commentaires en attendant que le champs reference soit créer
      --delete from bel.t_produit where reference = '0';
     
     
      --
      --supprimer_donnees_table('bel.t_produit', 'bel.seq_id_produit');      
     
      DELETE FROM bel.t_activite WHERE TYPE = 'P';
      supprimer_donnees_table('bel.t_produitfournisseur', 'bel.seq_id_produitfournisseur');      
      supprimer_donnees_table('bel.t_produitgeographique', 'bel.seq_id_produitgeographique');
      supprimer_donnees_table('bel.t_promotion', 'bel.seq_id_promotion');
      supprimer_donnees_table('bel.t_produitpromotion', 'bel.seq_id_produitpromotion');
     
      --intNbContraintesDes := supprimer_donnees(C_SUPPRESSION_ENCOURS);
      --intNbContraintesDes := supprimer_donnees(C_SUPPRESSION_AVANTAGES);
     
    elsif ATypeSuppression = C_SUPPRESSION_ENCOURS THEN          
                           --delete from bel.t_acte
      --where t_acte_id in (select t_acte_id
      --                    from bel.t_facture
      --                    where t_acte_id not in (select id_acte from bel.t_facture where t_facture_id in(select t_facture_id
      --                                                                                                                         from bel.t_lignevente where t_lignevente_id in ( select t_lignevente_id        from bel.t_lignevente_fidelite )) ))
      --returning t_acte_id bulk collect into tabIDActes;
      --supprimer_actes(tabIDActes);
     
      supprimer_donnees_table('bel.t_produitdu', 'bel.seq_id_produitdu');
     
    elsif ATypeSuppression = C_SUPPRESSION_AUTRES_DONNEES THEN
        supprimer_donnees_table('bel.t_histo_client_ligne', 'bel.seq_pk_histo_client_ligne');    
        supprimer_donnees_table('bel.t_histo_client_entete', 'bel.seq_pk_histo_client_entete');
        supprimer_donnees_table('bel.t_historiquevente', 'bel.seq_id_historiquevente');
    

    elsif ATypeSuppression = C_SUPPRESSION_AVANTAGES THEN
                           -- Mis en commentaire , pas le t-ligne_fidelite en belgique, par contre regarder dans le slignes de vente directement les  ristournes mise sur la carte
      --delete from bel.t_acte where t_acte_id in (select id_acte from bel.t_facture where t_facture_id in(select t_facture_id
      --                                                                                                                         from bel.t_lignevente where t_lignevente_id in ( select t_lignevente_id        from bel.t_lignevente_fidelite )) )
--      returning t_acte_id bulk collect into tabIDActes;
--      supprimer_actes(tabIDActes);
     
      supprimer_donnees_table('bel.t_crist_cartes', 'bel.seq_id_crist_cartes');
      supprimer_donnees_table('bel.t_crist_cartes_syn');
      supprimer_donnees_table('bel.t_crist_cheque', 'bel.seq_id_crist_cheque');
      supprimer_donnees_table('bel.t_crist_comptes', 'bel.seq_id_crist_comptes');
      supprimer_donnees_table('bel.t_crist_recu', 'bel.seq_id_crist_recu');    
      supprimer_donnees_table('bel.t_crist_transaction', 'bel.seq_id_crist_transaction ');
     
    END IF;

    intNbContraintesDes := affecter_etat_contraintes('BEL', TRUE);
    RETURN intNbContraintesDes;
  END;  
   
   
   
END pk_supprimer;
/