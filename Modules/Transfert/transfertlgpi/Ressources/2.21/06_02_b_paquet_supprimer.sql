create or replace package body migration.pk_supprimer as

  type tab_integer is table of integer index by binary_integer;
  
  C_SUPPRESSION_PRATICIENS constant integer := 1;
  C_SUPPRESSION_ORGANISMES constant integer := 2;
  C_SUPPRESSION_CLIENTS constant integer := 3;
  C_SUPPRESSION_PRODUITS constant integer := 4;
  C_SUPPRESSION_ENCOURS constant integer := 5;   
  C_SUPPRESSION_AVANTAGES constant integer := 6;
  C_SUPPRESSION_AUTRES_DONNEES constant integer := 8;
  
  table_inexistante exception; pragma exception_init(table_inexistante, -00942);
  sequence_inexistante exception; pragma exception_init(sequence_inexistante, -02289);

  strErreur varchar2(500);  

  /* ********************************************************************************************** */
  function renvoyer_debut_sequence(ASequence in varchar2)
                                  return integer
  as
    i integer;
    strProp varchar(255);
    strSequence varchar(255);
  begin
    i := instr(ASequence, '.');
    if i > 1 then
      strProp := substr(ASequence, 1, i - 1);
      strSequence := substr(ASequence, i + 1); 
    else
      select user
      into strProp
      from dual;
      
      strSequence := ASequence;    
    end if;
    
    execute immediate 'select last_number from sys.all_sequences where sequence_owner= :1 and sequence_name = :2' 
    into i
    using strProp, strSequence;
    
    return i;
  end;
  
  /* ********************************************************************************************** */
  procedure initialiser_sequence(ASequence in varchar2,
                                 ADebut in integer default null)
  as
  begin
    execute immediate 'drop sequence ' || ASequence;
    execute immediate 'create sequence ' || ASequence || ' start with ' || nvl(ADebut, 1) || ' nocache';
  exception
    when sequence_inexistante then
      strErreur := sqlerrm;      

      insert into migration.t_erreur(t_erreur_id, categorie, donnees, texte)
      values(seq_erreur.nextval, 'SUPPRESSION SEQUENCE', ASequence, strErreur);
  end;

  /* ********************************************************************************************** */
  procedure supprimer_donnees_table(ATable in varchar2,
                                    ASequence in varchar2 default null)
  as
    i integer;
    o varchar(255);
    t varchar(255);
    
    procedure separer_owner_table
    as
      p integer;
    begin
      p := instr('.', ATable);
      if p > 0 then
        o := upper(substr(ATable, 1, p - 1));
        t := upper(substr(ATable, p + 1, length(ATable)));
      else
        o := '';
        t := upper(ATable);
      end if;
    end;
    
  begin
    if ATable is not null then
      begin
        execute immediate 'select count(*) from ' || ATable into i;
        if i > 0 then
          separer_owner_table;
          
          select count(*)
          into i
          from sys.all_tab_columns          
          where owner = o
            and table_name = t
            and data_type = 'BLOB';           
          
          if i > 0 then
            execute immediate 'truncate table ' || ATable || ' drop all storage';
          else
            execute immediate 'truncate table ' || ATable;
          end if;
        end if;
      exception
        when table_inexistante then
          strErreur := sqlerrm; 
          
          insert into migration.t_erreur(t_erreur_id, categorie, donnees, texte)
          values(seq_erreur.nextval, 'SUPPRESSION TABLE', ATable, strErreur);
      end;
      
      if ASequence is not null then
        initialiser_sequence(ASequence);
      end if;
    end if;
  end;

  /* ********************************************************************************************** */
  function affecter_etat_contraintes(AShema in varchar2,
                                     AEtatContraintes in boolean) 
                                    return integer
  as
    intNbContraintesDes integer;
    strEtatContraintes varchar2(10);
  begin
    if AEtatContraintes then
      strEtatContraintes := 'enable';
    else
      strEtatContraintes := 'disable';
    end if;

    for cr_cntrs in (select table_name, constraint_name, status
                     from sys.all_constraints
                     where owner = upper(AShema)
                       and constraint_type = 'R') loop
      begin
        if (AEtatContraintes and (cr_cntrs.status = 'DISABLED')) or (not AEtatContraintes and (cr_cntrs.status = 'ENABLED')) then
          execute immediate 'alter table ' || AShema || '.' || cr_cntrs.table_name || ' modify constraint ' || cr_cntrs.constraint_name || ' ' || strEtatContraintes;
        end if;
      exception
        when others then
          strErreur := sqlerrm;
          
          insert into migration.t_erreur(t_erreur_id, categorie, donnees, texte)
          values(seq_erreur.nextval, '(DES)ACTIVATION CONSTRAINTES', AShema || '.' || cr_cntrs.table_name || '.' || cr_cntrs.constraint_name, strErreur);
      end;
    end loop;
    
    select count(*)
    into intNbContraintesDes
    from sys.all_constraints
    where owner = upper(AShema)
      and constraint_type = 'R'
      and status = 'DISABLED';
    
    return intNbContraintesDes;
  end;

  /* ********************************************************************************************** */
  procedure supprimer_actes(AActes in tab_integer)
  as
    i integer; 
  begin
    if AActes.first is not null then
      for i in AActes.first..AActes.last loop
        delete from erp.t_acte where t_acte_id = AActes(i);        
        delete from erp.t_dossierattente where id_acte = AActes(i);
        delete from erp.t_encaissement where t_acte_id = AActes(i);
        
        for cr_f in (select t_facture_id
                     from erp.t_facture
                     where id_acte = AActes(i)) loop                   
          delete from erp.t_facture where t_facture_id = cr_f.t_facture_id;
        
          for cr_lv in (select t_lignevente_id 
                        from erp.t_lignevente 
                        where t_facture_id = cr_f.t_facture_id) loop
            delete from erp.t_lignevente where t_lignevente_id = cr_lv.t_lignevente_id;
            delete from erp.t_lignevente_fidelite where t_lignevente_id = cr_lv.t_lignevente_id;
          end loop;
        end loop;
      end loop;
    end if; 
  end;

  /* ********************************************************************************************** */
  procedure supprimer_adresses(AAdresses in tab_integer)
  as
    i integer;
  begin
    --if AAdresses.first is not null then
      forall i in AAdresses.first..AAdresses.last
        delete from erp.t_adresse
        where t_adresse_id = AAdresses(i);        
    --end if;        
  end;
  
  /* ********************************************************************************************** */
  function initialiser_donnees return integer
  as
    intNbContraintesDes integer;
    lIntCount integer;
    tabIDAdresses tab_integer;    
    tabIDFournisseurContact tab_integer;
    i binary_integer;
    a integer;
  begin
    execute immediate 'alter database datafile ''/home/oracle/oradata/PHAL1/undotbs01.dbf'' autoextend on next 10M';
    
    intNbContraintesDes := affecter_etat_contraintes('ERP', false);

    -- Supressions des vues matérialisées/logs
    for cr in (select mview_name
                   from sys.all_mviews
                   where owner = 'ERP') loop
      execute immediate 'drop materialized view erp.' || cr.mview_name;
    end loop;
    
    --execute immediate 'drop table erp.mv_acte_utilisable';
    for cr_log in (select master
                   from sys.all_mview_logs
                   where log_owner = 'ERP') loop
      execute immediate 'drop materialized view log on erp.' || cr_log.master;
    end loop;
  
  update erp.t_produit
    set t_operateur_id = null,
        opdernvte = null,
        t_classificationint_id = null,
        t_codif1_id = null,
        t_codif2_id = null,
        t_codif3_id = null,
        t_codif4_id = null,
        t_codif5_id = null,
        t_codif6_id = null
    where reference = '1' or (t_prestation_id in ( select t_prestation_id from erp.t_prestation where code in  ( 'TRD' , 'VGP' , 'TLM' ))) ;
  
    -- Suppressions des données des tables
    supprimer_donnees_table('erp.t_g9_historique_stock', 'erp.seq_g9_historique_stock');
    --supprimer_donnees_table('erp.t_aad_allergen');    
    supprimer_donnees_table('erp.t_aad_allergy');   
    supprimer_donnees_table('erp.t_aad_insi', 'erp.seq_t_aad_insi'); 
    supprimer_donnees_table('erp.t_aad_pfi', 'erp.seq_aad_pfi'); 
    supprimer_donnees_table('erp.t_ataad', 'erp.seq_id_ataad');
    supprimer_donnees_table('erp.t_acte', 'erp.seq_id_acte');
    supprimer_donnees_table('erp.t_acte_pfi_stat', 'erp.seq_acte_pfi_stat');
    supprimer_donnees_table('erp.t_acte_viadys', 'erp.seq_t_acte_viadys');
    supprimer_donnees_table('erp.t_adresse_livr_aad','erp.seq_adresse_livr_aad');
    supprimer_donnees_table('erp.t_alerte');
    supprimer_donnees_table('erp.t_affectation', 'erp.seq_id_affectation');
    supprimer_donnees_table('erp.t_anomalie');
    supprimer_donnees_table('erp.t_assoc_cde_externes');
    supprimer_donnees_table('erp.t_assureayantdroit', 'erp.seq_assureayantdroit');
    supprimer_donnees_table('erp.t_assureayantdroit_dmc');
    supprimer_donnees_table('erp.t_assureayantdroit_dmc_produit');
    supprimer_donnees_table('erp.t_ataad', 'erp.seq_id_ataad');
    supprimer_donnees_table('erp.t_automatisationcdes');
    supprimer_donnees_table('erp.t_balance_stupefiants', 'erp.seq_balance_stup');
    supprimer_donnees_table('erp.t_bordereau_nbex_per_org', 'erp.seq_bordereau_nbex');
    supprimer_donnees_table('erp.t_bordereauaediter', 'erp.seq_id_bordereauaediter');
    supprimer_donnees_table('erp.t_bordereauorganisme', 'erp.seq_id_bordereauorganisme');
    supprimer_donnees_table('erp.t_caissecentrale', 'erp.seq_id_caissecentrale');
    supprimer_donnees_table('erp.t_catalogue_entete', 'erp.seq_id_catalogue_entete');
    supprimer_donnees_table('erp.t_catalogue_ligne', 'erp.seq_id_catalogue_ligne');
    supprimer_donnees_table('erp.t_lignecatalogue_suite', 'erp.seq_id_lignecatalogue_suite');
    supprimer_donnees_table('erp.t_catalogue_produit', 'erp.seq_id_catalogue_produit');
    supprimer_donnees_table('erp.t_catalogue_reference', 'erp.seq_id_catalogue_reference');
    supprimer_donnees_table('erp.t_catalogue_offi_avanta_exclus', 'erp.seq_id_catalogue_avantage_excl');    
    supprimer_donnees_table('erp.t_catalogue_offi_avanta_grille', 'erp.seq_id_catalogue_avantage_gril');    
    supprimer_donnees_table('erp.t_catalogue_offi_avantage', 'erp.seq_id_catalogue_avantage');    
    supprimer_donnees_table('erp.t_catalogue_offi_controle', 'erp.seq_id_catalogue_controle');    
    supprimer_donnees_table('erp.t_catalogue_offidirect_entete');    
    supprimer_donnees_table('erp.t_catalogue_offidirect_ligne');    
    supprimer_donnees_table('erp.t_catalogue_offidirect_prodlpp');
    supprimer_donnees_table('erp.t_catalogue_offidirect_produit');    
    supprimer_donnees_table('erp.t_catalogue_offidirect_referen');    
    supprimer_donnees_table('erp.t_cartefi', 'erp.seq_id_cartefi');
    supprimer_donnees_table('erp.t_cartefi_avantage', 'erp.seq_id_cartefi_avantage');
    supprimer_donnees_table('erp.t_cartefi_avantage_detail', 'erp.seq_id_cartefi_avantage');
    supprimer_donnees_table('erp.t_cartefi_client', 'erp.seq_id_cartefi_client');
    supprimer_donnees_table('erp.t_cartefi_produit');    
    supprimer_donnees_table('erp.t_cartefi_produit_import');
    supprimer_donnees_table('erp.t_codif1', 'erp.seq_id_codif1');
    supprimer_donnees_table('erp.t_codif2', 'erp.seq_id_codif2');
    supprimer_donnees_table('erp.t_codif3', 'erp.seq_id_codif3');
    supprimer_donnees_table('erp.t_codif4', 'erp.seq_id_codif4');
    supprimer_donnees_table('erp.t_codif5', 'erp.seq_id_codif5');
    supprimer_donnees_table('erp.t_codif6', 'erp.seq_id_codif6');
    supprimer_donnees_table('erp.t_cotation_groupe1610', 'erp.seq_id_cotation_groupe1610'); 
    supprimer_donnees_table('erp.t_cotation_groupe1610_lv');
    supprimer_donnees_table('erp.t_classificationinterne', 'erp.seq_id_classificationinterne');
    supprimer_donnees_table('erp.t_classif_fournisseur', 'erp.seq_id_classif_fournisseur');
    supprimer_donnees_table('erp.t_classif_fournisseur_offidi');
    supprimer_donnees_table('erp.t_clientgroupementachat');
    supprimer_donnees_table('erp.t_collectivite');
    supprimer_donnees_table('erp.t_commande', 'erp.seq_id_commande');    
    supprimer_donnees_table('erp.t_commande_remise');
    supprimer_donnees_table('erp.t_commandeapercu', 'erp.seq_commandeapercu');
    supprimer_donnees_table('erp.t_commande_remise_ug');
    supprimer_donnees_table('erp.t_commentaire', 'erp.seq_commentaire');
    supprimer_donnees_table('erp.t_commentaire_association');
    supprimer_donnees_table('erp.t_complement_facture_rsp', 'erp.seq_complement_rsp');
    supprimer_donnees_table('erp.t_constantes_aad','erp.seq_id_constantes_aad');
    supprimer_donnees_table('erp.t_content_doc');
    supprimer_donnees_table('erp.t_cotation_groupe1610_lv', 'erp.seq_id_cotation_groupe1610');  
    supprimer_donnees_table('erp.t_couvertureaadamo', 'erp.seq_couvertureaadamo');
    supprimer_donnees_table('erp.t_couvertureaadamc', 'erp.seq_couvertureaadamc');    
    supprimer_donnees_table('erp.t_depot', 'erp.seq_id_depot');
    supprimer_donnees_table('erp.t_destruction_stup', 'erp.seq_destruction_stups');       
    supprimer_donnees_table('erp.t_detailprestation', 'erp.seq_id_detailprestation');
    supprimer_donnees_table('erp.t_doc_asso');
    supprimer_donnees_table('erp.t_document', 'erp.seq_id_document');
    supprimer_donnees_table('erp.t_dossierattente');
    supprimer_donnees_table('erp.t_dp_priseencompte_alerte','erp.seq_dp_priseencompte_alerte');
    supprimer_donnees_table('erp.t_ebiz_potentiel_assoc', 'erp.seq_potentiel_assoc_ebiz');
    supprimer_donnees_table('erp.t_ebiz_stat_assoc', 'erp.seq_stat_assoc_ebiz');
    supprimer_donnees_table('erp.t_ebiz_stat_bandeau', 'erp.seq_stat_bandeau_ebiz');
    supprimer_donnees_table('erp.t_ebiz_stat_bandeau', 'erp.seq_stat_bandeau_ebiz_trans');
    supprimer_donnees_table('erp.t_editionretours');
    supprimer_donnees_table('erp.t_encaissement', 'erp.seq_id_encaissement');
    supprimer_donnees_table('erp.t_envoi_alerte_sms', 'erp.seq_id_envoi_alerte_sms');
    supprimer_donnees_table('erp.t_ep_arl', 'erp.seq_t_ep_arl_id');
    supprimer_donnees_table('erp.t_ep_prescription', 'erp.seq_t_ep_prescription');    
    supprimer_donnees_table('erp.t_es_fondcaisse', 'erp.seq_es_fondcaisse');
    supprimer_donnees_table('erp.t_etatpathoassaad', 'erp.seq_id_etatpathoassaad');
    supprimer_donnees_table('erp.t_facture', 'erp.seq_id_facture');
    supprimer_donnees_table('erp.t_fse');
    supprimer_donnees_table('erp.t_fixation', 'erp.seq_id_fixation');
    supprimer_donnees_table('erp.t_fixation_produit');
    supprimer_donnees_table('erp.t_fmd_histo', 'erp.seq_id_fmd_histo');

    supprimer_donnees_table('erp.t_fondcaisseoperateur', 'erp.seq_id_fondcaisseoperateur');
    supprimer_donnees_table('erp.t_fourchetteremise');    
    supprimer_donnees_table('erp.t_fournisseur', 'erp.seq_id_fournisseur'); 
    supprimer_donnees_table('erp.t_fournisseur_catalogue_offidi', 'erp.seq_id_fournisseur_catalogue');
    supprimer_donnees_table('erp.t_fournisseur_cdes_auto', 'erp.seq_id_fournisseur_cdes_auto');
    supprimer_donnees_table('erp.t_fournisseur_cdes_speciales', 'erp.seq_id_fou_cdes_speciales');
    supprimer_donnees_table('erp.t_fournisseur_codereponse', 'erp.seq_id_fournisseur_codereponse');
    supprimer_donnees_table('erp.t_fournisseur_operateurs', 'erp.seq_id_fou_operateurs');
    supprimer_donnees_table('erp.t_fournisseur_maj_catalogue', 'erp.seq_id_fourn_maj_catalogue');
    --supprimer_donnees_table('erp.t_fournisseurdfournisseurd', 'erp.seq_id_fdfd'); 
    supprimer_donnees_table('erp.t_habilitation_profil');    
    supprimer_donnees_table('erp.t_hermes_destinataire', 'erp.seq_hermes_destinataire');
    supprimer_donnees_table('erp.t_hermes_message', 'erp.seq_hermes_message');
    supprimer_donnees_table('erp.t_histo_client_entete', 'erp.seq_pk_histo_client_entete');
    supprimer_donnees_table('erp.t_histo_client_ligne', 'erp.seq_pk_histo_client_ligne');
    supprimer_donnees_table('erp.t_histo_tournee_aad', 'erp.seq_histo_tournee_aad');
    supprimer_donnees_table('erp.t_histopraticienaad', 'erp.seq_id_histopraticienaad');
    supprimer_donnees_table('erp.t_historiqueachatcumule', 'erp.seq_id_historiqueachatcumule');
    supprimer_donnees_table('erp.t_historiquevente', 'erp.seq_id_historiquevente');
    supprimer_donnees_table('erp.t_infos_pro','erp.seq_t_infos_pro');
    supprimer_donnees_table('erp.t_inventaire');
    supprimer_donnees_table('erp.t_liendepot','erp.seq_id_liendepot');  
    supprimer_donnees_table('erp.t_lignealerte');
    supprimer_donnees_table('erp.t_lignecatalogue_suite', 'erp.seq_id_lignecatalogue_suite');
    supprimer_donnees_table('erp.t_lignecommande', 'erp.seq_id_lignecommande');
    supprimer_donnees_table('erp.t_lignecommande_livraison', 'erp.seq_lignecommande_livraison');
    supprimer_donnees_table('erp.t_lignecommande_manquant', 'erp.seq_id_lignecommande_manquant');
    supprimer_donnees_table('erp.t_lignecommanderecu', 'erp.seq_id_lignecommanderecu');    
    supprimer_donnees_table('erp.t_lignefacturation', 'erp.seq_id_lignefacturation');
    supprimer_donnees_table('erp.t_ligneretrocession', 'erp.seq_id_ligneretrocession');
    supprimer_donnees_table('erp.t_lignevente', 'erp.seq_id_lignevente');
    supprimer_donnees_table('erp.t_lignevente_dci');
    supprimer_donnees_table('erp.t_lignevente_edite_remise');
    supprimer_donnees_table('erp.t_lignevente_pfi_bri');
    supprimer_donnees_table('erp.t_lignevente_lpp', 'erp.seq_t_lignevente_lpp');    
    supprimer_donnees_table('erp.t_lignevente_tracabilite', 'erp.seq_lignevente_tracabilite'); 
    supprimer_donnees_table('erp.t_lignereappro', 'erp.seq_id_lignereappro');
    supprimer_donnees_table('erp.t_lignevente_en_boite', 'erp.seq_lignevente_en_boite');    
    supprimer_donnees_table('erp.t_lignevente_fidelite', 'erp.seq_id_lignevente_fidelite');    
    supprimer_donnees_table('erp.t_lignevente_pfi', 'erp.seq_lignevente_pfi');   
    supprimer_donnees_table('erp.t_lignevente_pfi_phr', 'erp.seq_lignevente_pfi_phr'); 
    supprimer_donnees_table('erp.t_lignevente_fidelite_grpt');    
    supprimer_donnees_table('erp.t_location_facture', 'erp.seq_id_location_facture');    
    supprimer_donnees_table('erp.t_location_suspension', 'erp.seq_id_location_suspension');        
    supprimer_donnees_table('erp.t_mandataire');
    supprimer_donnees_table('erp.t_message171', 'erp.seq_id_message171');
    --supprimer_donnees_table('erp.t_message_cnop', 'erp.seq_id_t_message_cnop');
    supprimer_donnees_table('erp.t_mvt_fondcaisse', 'erp.seq_mvt_fondcaisse');
    supprimer_donnees_table('erp.t_mvt_fondcaisse_tempo', 'erp.seq_mvt_fondcaisse_tempo');
    supprimer_donnees_table('erp.t_test_antigenique','erp.seq_test_antigenique');
    supprimer_donnees_table('erp.t_nf_ticket');
    supprimer_donnees_table('erp.t_nf_archive', 'erp.seq_nf_archive');
    supprimer_donnees_table('erp.t_nf_duplicata', 'erp.seq_nf_duplicata');
    supprimer_donnees_table('erp.t_nf_facture');
    supprimer_donnees_table('erp.t_nf_gt_ticket');
    supprimer_donnees_table('erp.t_nf_gt_periode', 'erp.seq_id_nf_gt_periode');
    supprimer_donnees_table('erp.t_offidose_depot', 'erp.seq_offidose_depot');    
    supprimer_donnees_table('erp.t_test_antigenique');
    supprimer_donnees_table('erp.t_ticket_cb_client');
    supprimer_donnees_table('erp.t_ticket_cb_commercant');
    supprimer_donnees_table('erp.t_operateur');     
    supprimer_donnees_table('erp.t_operateur_badge');
    supprimer_donnees_table('erp.t_opinion_decision');
    supprimer_donnees_table('erp.t_opinion_nature');
    supprimer_donnees_table('erp.t_opinion_pharma', 'erp.seq_id_opinion_pharma');
    supprimer_donnees_table('erp.t_opinion_produit', 'erp.seq_id_opinion_produit');
    supprimer_donnees_table('erp.t_opinion_reference');
    supprimer_donnees_table('erp.t_ordonnancier_ligne');
    supprimer_donnees_table('erp.t_ordonnancier_entete', 'erp.seq_id_ordonnancier_entete');
    supprimer_donnees_table('erp.t_organismeaadamo','erp.seq_id_organismeaadamo');
    supprimer_donnees_table('erp.t_organismeamoassamc');
    supprimer_donnees_table('erp.t_paiement', 'erp.seq_id_paiement');
    supprimer_donnees_table('erp.t_panier_relance', 'erp.seq_id_panier_relance');
    supprimer_donnees_table('erp.t_parametre_alertescdes', 'erp.seq_parametre_alertescdes');
    supprimer_donnees_table('erp.t_paramremisefixe');
    supprimer_donnees_table('erp.t_planification', 'erp.seq_id_planification');
    supprimer_donnees_table('erp.t_planning_livraison', 'erp.seq_id_planning_livraison');
    supprimer_donnees_table('erp.t_planning_visite', 'erp.seq_id_planning_visite');
    supprimer_donnees_table('erp.t_posologie_ordo', 'erp.seq_id_posologie_ordo');
    supprimer_donnees_table('erp.t_posologie_ligne', 'erp.seq_id_posologie_ligne');
    supprimer_donnees_table('erp.t_posologie_tracabilite', 'erp.seq_id_posologie_tracabilite');
    supprimer_donnees_table('erp.t_posologie_date_prise', 'erp.seq_id_posologie_date_prise');
    supprimer_donnees_table('erp.t_posologie_commentaire', 'erp.seq_id_posologie_commentaire');
    supprimer_donnees_table('erp.t_poso_commentaire_ass');
    supprimer_donnees_table('erp.t_posologie_pathologie');
    supprimer_donnees_table('erp.t_praticien', 'erp.seq_id_praticien');
    supprimer_donnees_table('erp.t_praticien_structure', 'erp.seq_id_praticien_structure');    
    supprimer_donnees_table('erp.t_prescrestreinte_specialite');  
    supprimer_donnees_table('erp.t_prest_remise');          
    supprimer_donnees_table('erp.t_produit_disponibilite', 'erp.seq_id_produit_disponibilite');
    supprimer_donnees_table('erp.t_produit_fournisseur_prefer', 'erp.seq_id_produit_fournisseur_pre');
    supprimer_donnees_table('erp.t_produitdu', 'erp.seq_id_produitdu');
    supprimer_donnees_table('erp.t_produitdu_remis', 'erp.seq_produitdu_remis');
    supprimer_donnees_table('erp.t_produitfournisseur', 'erp.seq_id_produitfournisseur');    
    supprimer_donnees_table('erp.t_produitgeographique', 'erp.seq_id_zonegeographique');
    supprimer_donnees_table('erp.t_produit_groupement', 'erp.seq_id_produit_groupement');
    supprimer_donnees_table('erp.t_produit_maj_pv_a_reception');
    supprimer_donnees_table('erp.t_produit_noserie', 'erp.seq_id_produit_noserie');
    supprimer_donnees_table('erp.t_produitpromotion', 'erp.seq_id_produitpromotion');
    supprimer_donnees_table('erp.t_produit_repart_typeprix');
    supprimer_donnees_table('erp.t_profil_operateur', 'erp.seq_profil_operateur');
    supprimer_donnees_table('erp.t_profil_article_remise');
    supprimer_donnees_table('erp.t_profiledition', 'erp.seq_profiledition');
    supprimer_donnees_table('erp.t_profilremise', 'erp.seq_profilremise');
    supprimer_donnees_table('erp.t_prolongation', 'erp.seq_id_prolongation');        
    supprimer_donnees_table('erp.t_promotion', 'erp.seq_id_promotion');
    supprimer_donnees_table('erp.t_promotion_entete', 'erp.seq_promotion_entete');
    supprimer_donnees_table('erp.t_promotion_suspension', 'erp.seq_promotion_suspension');
    supprimer_donnees_table('erp.t_promotion_produit', 'erp.seq_promotion_produit');
    supprimer_donnees_table('erp.t_promotion_avantage', 'erp.seq_promotion_avantage');
    supprimer_donnees_table('erp.t_promotion_critere_alerte', 'erp.seq_promotion_critere_alerte');
    supprimer_donnees_table('erp.t_qtearanger');
    supprimer_donnees_table('erp.t_reappro', 'erp.seq_id_reappro');
    supprimer_donnees_table('erp.t_receptrav_entete', 'erp.seq_id_receptrav_entete');
    supprimer_donnees_table('erp.t_receptrav_ligne', 'erp.seq_id_receptrav_ligne');
    supprimer_donnees_table('erp.t_reglage_controle_securite', 'erp.seq_id_reglage_controle_secu');
    supprimer_donnees_table('erp.t_reglement', 'erp.seq_id_reglement');
    supprimer_donnees_table('erp.t_reglementorganisme', 'erp.seq_id_reglementorganisme');
    supprimer_donnees_table('erp.t_regle_depot', 'erp.seq_regle_depot');
    supprimer_donnees_table('erp.t_regle_destockage', 'erp.seq_regle_destockage');
    supprimer_donnees_table('erp.t_regle_operateur', 'erp.seq_regle_operateur');
    supprimer_donnees_table('erp.t_regle_poste', 'erp.seq_regle_poste');
    supprimer_donnees_table('erp.t_rejet', 'erp.seq_id_rejet');
    supprimer_donnees_table('erp.t_rejetnoedetail', 'erp.seq_id_rejetnoedetail');
    supprimer_donnees_table('erp.t_remise_tva', 'erp.seq_id_remise_tva');
    supprimer_donnees_table('erp.t_remise_fixe_regle_sup', 'erp.seq_remise_fixe_regle_sup');
    supprimer_donnees_table('erp.t_renumerotation', 'erp.seq_id_renumerotation');
    supprimer_donnees_table('erp.t_retour171', 'erp.seq_id_retour171');
    supprimer_donnees_table('erp.t_save_recept_entete', 'erp.seq_id_save_recept_entete');
    supprimer_donnees_table('erp.t_save_recept_ligne', 'erp.seq_id_save_recept_ligne');
    supprimer_donnees_table('erp.t_scor_arl', 'erp.seq_scor_arl');
    supprimer_donnees_table('erp.t_scor_arp', 'erp.seq_scor_arp');
    supprimer_donnees_table('erp.t_scor_dossierjustif', 'erp.seq_scor_dossierjustif');
    supprimer_donnees_table('erp.t_scor_dossiersreconstitues');
    supprimer_donnees_table('erp.t_scor_lotjustif', 'erp.seq_scor_lotjustif');
    initialiser_sequence('erp.seq_scor_no_lotjustif');
    supprimer_donnees_table('erp.t_scor_fichierlotjustif', 'erp.seq_scor_fichierlotjustif');
    supprimer_donnees_table('erp.t_scor_mails', 'erp.seq_scor_mails');
    supprimer_donnees_table('erp.t_scor_msgservice', 'erp.seq_scor_msgservice');
    supprimer_donnees_table('erp.t_scor_piecejustif', 'erp.seq_scor_piecejustif');
    supprimer_donnees_table('erp.t_ssp_consentement_service');
    supprimer_donnees_table('erp.t_ssp_crit_cip', 'erp.seq_id_ssp_crit_cip');
    supprimer_donnees_table('erp.t_ssp_crit_cip_asso', 'erp.seq_id_ssp_crit_cip_asso');
    supprimer_donnees_table('erp.t_ssp_crit_op_jour', 'erp.seq_id_ssp_crit_op_jour');
    supprimer_donnees_table('erp.t_ssp_crit_operateur', 'erp.seq_id_ssp_crit_operateur');
    supprimer_donnees_table('erp.t_ssp_delivrance', 'erp.seq_id_ssp_delivrance');
    supprimer_donnees_table('erp.t_ssp_dossier_aad', 'erp.seq_id_ssp_dossier_aad');
    supprimer_donnees_table('erp.t_ssp_dossier_aad_envoi');
    supprimer_donnees_table('erp.t_ssp_dossier_aad_prg', 'erp.seq_id_ssp_dossier_aad_prg');    
    supprimer_donnees_table('erp.t_ssp_ordonnance', 'erp.seq_id_ssp_ordonnance');
    supprimer_donnees_table('erp.t_ssp_produit_delivrance', 'erp.seq_id_ssp_produit_delivrance');
    supprimer_donnees_table('erp.t_ssp_prod_delivrance_prg');    
    supprimer_donnees_table('erp.t_sst_aad', 'erp.seq_id_sst_aad');
    supprimer_donnees_table('erp.t_sst_aad_produit', 'erp.seq_id_sst_aad_produit');
    supprimer_donnees_table('erp.t_sst_aad_service', 'erp.seq_id_sst_aad_service');
    supprimer_donnees_table('erp.t_statscaventesfour_temp');   
    supprimer_donnees_table('erp.t_structure', 'erp.seq_id_structure');    
    supprimer_donnees_table('erp.t_stupefiant_a_detruire', 'erp.seq_stupefiant_a_detruire');    
    supprimer_donnees_table('erp.t_sv_arl', 'erp.seq_id_sv_arl');
    supprimer_donnees_table('erp.t_sv_bordereauapercu', 'erp.seq_sv_bordereau');
    supprimer_donnees_table('erp.t_sv_fichier', 'erp.seq_id_sv_fichier');
    supprimer_donnees_table('erp.t_sv_lotfse');
    supprimer_donnees_table('erp.t_sv_mail', 'erp.seq_id_sv_mail');
    supprimer_donnees_table('erp.t_sv_numlot', 'erp.seq_id_lot');
    supprimer_donnees_table('erp.t_sv_messageservice', 'erp.seq_id_sv_messageservice');
    supprimer_donnees_table('erp.t_sv_opposition');
    supprimer_donnees_table('erp.t_sv_pbfse', 'erp.seq_id_sv_arl');
    supprimer_donnees_table('erp.t_sv_sts', 'erp.seq_id_sv_sts');
  supprimer_donnees_table('erp.t_test_antigenique');
    supprimer_donnees_table('erp.t_trace_mvmt_stock', 'erp.seq_id_trace_mvmt_stock');
    supprimer_donnees_table('erp.t_traceacte', 'erp.seq_id_traceacte');
    supprimer_donnees_table('erp.t_traceacte_ligne', 'erp.seq_id_traceacte_ligne');
    supprimer_donnees_table('erp.t_tracestock');
    supprimer_donnees_table('erp.t_traceqtecommande', 'erp.seq_id_traceqtecommande');
    supprimer_donnees_table('erp.t_tracestockprix', 'erp.seq_id_tracestockprix');
    supprimer_donnees_table('erp.t_tx_histo_taux_renouv', 'erp.seq_id_tx_histo_taux');
    supprimer_donnees_table('erp.t_ventilation_tva_facture', 'erp.seq_id_ventilation');
    supprimer_donnees_table('erp.t_verrou', 'erp.seq_id_verrou');
    supprimer_donnees_table('erp.t_vignetteavancee', 'erp.seq_id_vignetteavancee');
    supprimer_donnees_table('erp.t_visio_anomalie', 'erp.seq_visio_anomalie');
    supprimer_donnees_table('erp.t_zonegeographique', 'erp.seq_id_zonegeographique');
        
    -- Traitement spéciaux
    delete from erp.t_activite;

    update erp.t_assoc
    set stats_transmises = '0',
        compteur1 = 0,
        compteur2 = 0,
        compteur3 = 0,
        compteur4 = 0,
        compteur5 = 0,
        qte_assoc = 0,
        date_trans = null; 
        
    delete from erp.t_destinataire
    returning adresseid bulk collect into tabIDAdresses;
    supprimer_adresses(tabIDAdresses);
    initialiser_sequence('erp.seq_destinataire');

    delete from erp.t_destinatairestat
    returning t_adresse_id bulk collect into tabIDAdresses;
    supprimer_adresses(tabIDAdresses);

    delete from erp.t_edition where typeedition not in (32, 33, 35);     

    update erp.t_fournisseur 
    set t_aad_id = null,
        foud_t_fournisseu_copie_cde_id = null,
        commentaire = null;
    
    delete from erp.t_fournisseur /*where foud_partenaire = '0'*/
    returning t_adresse_id, t_contact_id bulk collect into tabIDAdresses, tabIDFournisseurContact;
    
    supprimer_adresses(tabIDAdresses);
    
    if tabIDFournisseurContact.first is not null then
      for i in tabIDFournisseurContact.first..tabIDFournisseurContact.last loop
        delete from erp.t_fournisseur_contact where t_fournisseur_contact_id = tabIDFournisseurContact(i) returning t_adresse_id into a;
        delete from erp.t_adresse where t_adresse_id = a;
      end loop;
    end if;

    update erp.t_honoraires_garde_plgtrf
    set id_produit_ferie = null,
        id_produit_hors_ferie = null;
    
    delete from erp.t_couvertureamc where couvreference = '0';        
    delete from erp.t_organismeamc where orgreference = '0'; 
    update erp.t_organismeamc set t_destinataire_id = null;
    delete from erp.t_organismeamo where orgreference = '0';
    update erp.t_organismeamo set t_destinataire_id = null;

    delete from erp.t_organismepayeur         
    where t_organismepayeur_id not in (select t_organismepayeur_id
                                       from erp.t_organismeamo                                       
                                       union
                                       select t_organismepayeur_id
                                       from erp.t_organismeamc)
    returning t_adresse_id bulk collect into tabIDAdresses;
    supprimer_adresses(tabIDAdresses);    
  
  select count(*)
    into lIntCount
    from sys.all_tables
    where owner = 'ERP'
      and table_name in ('T_PDA_PRISE', 'T_PDA_DECONDITIONNEMENT', 'T_PDA_FICHE_TRAVAIL', 'T_PDA_JOUR_PRISE', 'T_PDA_FT_ASS_FACT');

    if lIntCount = 5 then
      supprimer_donnees_table('erp.t_pda_prise', 'erp.seq_pda_prise');
      supprimer_donnees_table('erp.t_pda_jour_prise', 'erp.seq_pda_jour_prise');
      supprimer_donnees_table('erp.t_pda_ft_ass_fact');
      supprimer_donnees_table('erp.t_pda_deconditionnement', 'erp.seq_pda_deconditionnement');
      supprimer_donnees_table('erp.t_pda_fiche_travail', 'erp.seq_pda_fiche_travail');
      initialiser_sequence('erp.seq_pda_dct_numero_ordre');
    end if;
           

    delete from erp.t_produit 
    where reference = '0' 
      and t_prestation_id not in ( select t_prestation_id from erp.t_prestation where code in  ( 'TRD' , 'VGP' , 'TLM' ));



    -- Création des données élémentaires
    insert into erp.t_profiledition(t_profiledition_id,
                                    libelle,
                                    saut_page_client,
                                    sous_total_client,
                                    detail_produits,
                                    type_de_tri,
                                    datemaj)
    values(erp.seq_profiledition.nextval,
           'Edition complète avec saut de page',
           '1',
           '1',
           '1',
           2,
           sysdate);                                                                            
    
    insert into erp.t_profil_operateur(t_profil_operateur_id,
                                       designation_profil,
                                       datemaj)
    values(erp.seq_profil_operateur.nextval,
           'Profil par défaut',
           sysdate);
  
   
           
    insert into erp.t_operateur(t_operateur_id,
                                codeoperateur,
                                nom,
                                prenom,
                                motdepasse,
                                activationoperateur,
                                datemaj,
                                rgbintlevel1,
                                rgbintlevel2,
                                rgbintlevel3,
                                rgbintlevel4,
                                rgbci,
                                propqteacder,
                                t_profil_operateur_id,
                                rgb_redondance_pa)
    values(erp.seq_id_operateur.nextval,
           '.',
           'Pharmagest-CIP',
           'point',
           'villers',
           1,
           sysdate,
           0,
           0,
           0,
           0,
           0,
           0,
           erp.seq_profil_operateur.currval,
           -103);

    insert into erp.t_operateur(t_operateur_id,
                                codeoperateur,
                                nom,
                                prenom,
                                motdepasse,
                                activationoperateur,
                                datemaj,
                                rgbintlevel1,
                                rgbintlevel2,
                                rgbintlevel3,
                                rgbintlevel4,
                                rgbci,
                                propqteacder,
                                t_profil_operateur_id,
                                rgb_redondance_pa)
    values(erp.seq_id_operateur.nextval,
           '-',
           'Non identifié',
           ' ',
           '-',
           0,
           sysdate,
           -2303270,
           -13108,
           -26368,
           -65536,
           -65536,
           0,
           erp.seq_profil_operateur.currval,
           -103);

    insert into erp.t_operateur(t_operateur_id,
                            codeoperateur,
                            nom,
                            prenom,
                            motdepasse,
                            activationoperateur,
                            datemaj,
                            rgbintlevel1,
                            rgbintlevel2,
                            rgbintlevel3,
                            rgbintlevel4,
                            rgbci,
                            propqteacder,
                            is_scanpalrf,
                            type_focus_vente,
                            t_profil_operateur_id,
                            rgb_redondance_pa)
    values (erp.seq_id_operateur.nextval,
            'Borne',
            'Borne automatique',
            ' ',
            '_',
            0,
            sysdate,
            -2303270,
            -13108,
            -26368,
            -65536,
            -65536,
            '0',
            '0',
            0,
            1,
            -103); 

    insert into erp.t_operateur(t_operateur_id,
                            codeoperateur,
                            nom,
                            prenom,
                            motdepasse,
                            activationoperateur,
                            datemaj,
                            rgbintlevel1,
                            rgbintlevel2,
                            rgbintlevel3,
                            rgbintlevel4,
                            rgbci,
                            propqteacder,
                            is_scanpalrf,
                            type_focus_vente,
                            t_profil_operateur_id,
                            rgb_redondance_pa)
    values (erp.seq_id_operateur.nextval,
            'Web',
            'Vente Internet',
            ' ',
            '_',
            0,
            sysdate,
            -2303270,
            -13108,
            -26368,
            -65536,
            -65536,
            '0',
            '0',
            0,
            1,
            -103);

    insert into erp.t_habilitation_profil(t_habilitation_profil_id,
                                          id_profil_operateur,
                                          id_module,
                                          restriction,
                                          datemaj)
    select erp.seq_habilitation_profil.nextval,
           erp.seq_profil_operateur.currval,
           t_module_id,
           2,
           sysdate
    from erp.t_module;

    insert into erp.t_profil_operateur(t_profil_operateur_id,
                                       designation_profil,
                                       datemaj)
    values(erp.seq_profil_operateur.nextval,
           'Profil opérateur par défaut',
           sysdate);  
    
  insert into erp.t_habilitation_profil(t_habilitation_profil_id,
                                          id_profil_operateur,
                                          id_module,
                                          restriction,
                                          datemaj)
    select erp.seq_habilitation_profil.nextval,
           erp.seq_profil_operateur.currval,
           t_module_id,
           2,
           sysdate
    from erp.t_module; 

  for cr in (select t_organismeamc_id 
             from erp.t_organismeamc o 
         where o.orgreference = '1'
                 and not exists(select null from erp.t_24 t where t.t_organismeamc_id = o.t_organismeamc_id)) loop
    insert into erp.t_couvertureamc(t_couvertureamc_id,
                  libelle,
                  montantfranchise,
                  plafondpriseencharge,
                  datemajcouvamc,
                  couvreference,
                  couvcmu)
    select erp.seq_couvertureamc.nextval,
         libelle,
         montantfranchise,
         plafondpriseencharge,
         sysdate,
         '0',
         couvcmu
    from erp.t_couvertureamc
    where couvreference = '1' and couvcmu = '1';
    
    -- A partir d'ici, on considère qu'il n'existe q'une seule couverture AMC de référence ET CMU
    insert into erp.t_24
    values(cr.t_organismeamc_id,
           erp.seq_couvertureamc.currval);
         
    for cr_p in (select p.t_pec_amc_id, p.date_application, p.datemajpecamc, p.t_couverture_amc_id, p.t_prestation_id, p.t_formule_id
                from erp.t_pec_amc p
                      inner join erp.t_couvertureamc c on c.t_couvertureamc_id = p.t_couverture_amc_id
                 where c.couvreference = '1' and c.couvcmu = '1') loop
      insert into erp.t_pec_amc(t_pec_amc_id,
                    date_application,
                    datemajpecamc,
                    t_couverture_amc_id,
                    t_prestation_id,
                    t_formule_id)
      values (erp.seq_id_pec_amc.nextval,
            cr_p.date_application,
            sysdate,
            erp.seq_couvertureamc.currval,
            cr_p.t_prestation_id,
            cr_p.t_formule_id);
    
     insert into erp.t_pec_amc_formule_parametre(t_pec_amc_formule_parametre_id,
                          no_parametre_formule,
                            valeur,
                            t_pec_amc_id,
                            datemajpecamcformuleparametre)
      select erp.seq_id_pec_amc_formule_paramet.nextval,
             no_parametre_formule,
          valeur,
          erp.seq_id_pec_amc.currval,
          sysdate
     from erp.t_pec_amc_formule_parametre pp
     where t_pec_amc_id = cr_p.t_pec_amc_id;
    end loop;
  end loop;
  
 update erp.t_parametres set valeur = to_char(sysdate, 'DD/MM/YYYY') where cle = 'repriseFichiers.dateReprise';
  if sql%rowcount = 0 then
    insert into erp.t_parametres values('repriseFichiers.dateReprise', to_char(sysdate, 'DD/MM/YYYY'));
  end if;
 
 update erp.t_parametres set valeur = 0 where cle = 'ged.migrationVersMuse.active';  
  if sql%rowcount = 0 then
    insert into erp.t_parametres values('ged.migrationVersMuse.active', 0);
  end if;


    -- Vérification contraintes désactivées
    intNbContraintesDes := affecter_etat_contraintes('ERP', true);
    return intNbContraintesDes;
  end;
  
  /* ********************************************************************************************** */
  function supprimer_donnees(ATypeSuppression in integer)
                            return integer
  as
    i integer;      
    intNbContraintesDes integer;
    tabIDAdresses tab_integer;
    tabIDActes tab_integer;
  begin
    intNbContraintesDes := affecter_etat_contraintes('ERP', false);

    if ATypeSuppression = C_SUPPRESSION_PRATICIENS then
      supprimer_donnees_table('erp.t_structure', 'erp.seq_id_structure');
      supprimer_donnees_table('erp.t_praticien', 'erp.seq_id_praticien');
      supprimer_donnees_table('erp.t_praticien_structure', 'erp.seq_id_praticien_structure');

    elsif ATypeSuppression = C_SUPPRESSION_ORGANISMES then
      supprimer_donnees_table('erp.t_sv_numlot', 'erp.seq_id_lot');
      delete from erp.t_destinataire
      returning adresseid bulk collect into tabIDAdresses;
      supprimer_adresses(tabIDAdresses);
      initialiser_sequence('erp.seq_destinataire');
     
      supprimer_donnees_table('erp.t_bordereau_nbex_per_org', 'erp.seq_bordereau_nbex');
      delete from erp.t_organismepayeur         
      where t_organismepayeur_id not in (select t_organismepayeur_id
                                         from erp.t_organismeamo                                       
                                         union
                                         select t_organismepayeur_id
                                         from erp.t_organismeamc);                        
      delete from erp.t_organismeamo where orgreference = '0';
      update erp.t_organismeamo set t_destinataire_id = null;    
      delete from erp.t_organismeamc where orgreference = '0';
      delete from erp.t_couvertureamc where couvreference = '0';
      update erp.t_organismeamc set t_destinataire_id = null;      
      update erp.t_assureayantdroit set t_organismeamc_id = null;
      
      supprimer_donnees_table('erp.t_organismeaadamo', 'erp.seq_id_organismeaadamo'); 
      supprimer_donnees_table('erp.t_couvertureaadamo', 'erp.seq_id_couvertureaadamo');
      supprimer_donnees_table('erp.t_couvertureaadamc', 'erp.seq_id_couvertureaadamc');
    elsif ATypeSuppression = C_SUPPRESSION_CLIENTS then
      supprimer_donnees_table('erp.t_assureayantdroit', 'erp.seq_assureayantdroit');
      supprimer_donnees_table('erp.t_organismeaadamo', 'erp.seq_organismeaadamo'); 
      supprimer_donnees_table('erp.t_couvertureaadamo', 'erp.seq_couvertureaadamo');
      supprimer_donnees_table('erp.t_couvertureaadamc', 'erp.seq_id_couvertureaadamc');
      supprimer_donnees_table('erp.t_commentaire', 'erp.seq_commentaire');
      supprimer_donnees_table('erp.t_commentaire_association');
      delete from erp.t_activite where type = 'A';
    elsif ATypeSuppression = C_SUPPRESSION_PRODUITS then
      supprimer_donnees_table('erp.t_zonegeographique','erp.seq_id_zonegeographique');
      
      delete from erp.t_fournisseur /* where foud_partenaire = '0'*/
      returning t_adresse_id bulk collect into tabIDAdresses;
      supprimer_adresses(tabIDAdresses);

      delete from erp.t_produit 
        where reference = '0'
         and t_prestation_id not in ( select t_prestation_id from erp.t_prestation where code in  ( 'TRD' , 'VGP' , 'TLM' ));

      delete from erp.t_activite where type = 'P';
      supprimer_donnees_table('erp.t_lignecatalogue_suite', 'erp.seq_id_lignecatalogue_suite');   
      supprimer_donnees_table('erp.t_catalogue_ligne', 'erp.seq_id_catalogue_ligne');
      supprimer_donnees_table('erp.t_catalogue_reference', 'erp.seq_id_catalogue_reference');   
      supprimer_donnees_table('erp.t_catalogue_entete', 'erp.seq_id_catalogue_entete');
      supprimer_donnees_table('erp.t_produitgeographique', 'erp.seq_id_produitgeographique');
      supprimer_donnees_table('erp.t_depot', 'erp.seq_id_depot');      
      supprimer_donnees_table('erp.t_codif1', 'erp.seq_id_codif1');
      supprimer_donnees_table('erp.t_codif2', 'erp.seq_id_codif2');
      supprimer_donnees_table('erp.t_codif3', 'erp.seq_id_codif3');
      supprimer_donnees_table('erp.t_codif4', 'erp.seq_id_codif4');
      supprimer_donnees_table('erp.t_codif5', 'erp.seq_id_codif5');
      supprimer_donnees_table('erp.t_codif6', 'erp.seq_id_codif6');
   elsif ATypeSuppression = C_SUPPRESSION_ENCOURS then          
      delete from erp.t_acte 
      where t_acte_id in (select t_acte_id 
                          from erp.t_facture 
                          where t_acte_id not in (select id_acte from erp.t_facture where t_facture_id in(select t_facture_id 
                                                     from erp.t_lignevente where t_lignevente_id in ( select t_lignevente_id  from erp.t_lignevente_fidelite )) ))
      returning t_acte_id bulk collect into tabIDActes;
      supprimer_actes(tabIDActes);
      
      supprimer_donnees_table('erp.t_produitdu', 'erp.seq_id_produitdu');
      supprimer_donnees_table('erp.t_vignetteavancee', 'erp.seq_id_vignetteavancee');
      delete from erp.t_operateur where codeoperateur not in  ('.', '-', 'Borne', 'Web');
    elsif ATypeSuppression = C_SUPPRESSION_AUTRES_DONNEES then
      delete from erp.t_commande;
      delete from erp.t_lignecommande_livraison; 
      supprimer_donnees_table('erp.t_content_doc');
      supprimer_donnees_table('erp.t_doc_asso');
      supprimer_donnees_table('erp.t_document', 'erp.seq_id_document');   
      supprimer_donnees_table('erp.t_histo_client_ligne', 'erp.seq_pk_histo_client_ligne');    
      supprimer_donnees_table('erp.t_histo_client_entete', 'erp.seq_pk_histo_client_entete');
      supprimer_donnees_table('erp.t_promotion_entete', 'erp.seq_promotion_entete');     
      supprimer_donnees_table('erp.t_promotion_produit', 'erp.seq_promotion_produit');
      supprimer_donnees_table('erp.t_promotion_avantage', 'erp.seq_promotion_avantage');     
    elsif ATypeSuppression = C_SUPPRESSION_AVANTAGES then
         delete from erp.t_acte where t_acte_id in (select id_acte from erp.t_facture where t_facture_id in(select t_facture_id 
                                                     from erp.t_lignevente where t_lignevente_id in ( select t_lignevente_id  from erp.t_lignevente_fidelite )) )
      returning t_acte_id bulk collect into tabIDActes;
      supprimer_actes(tabIDActes);
      
      supprimer_donnees_table('erp.t_cartefi', 'erp.seq_id_cartefi');
      supprimer_donnees_table('erp.t_cartefi_avantage', 'erp.seq_id_cartefi_avantage');
      supprimer_donnees_table('erp.t_cartefi_avantage_detail', 'erp.seq_id_cartefi_avantage');
      supprimer_donnees_table('erp.t_cartefi_client', 'erp.seq_id_cartefi_client');
      supprimer_donnees_table('erp.t_cartefi_produit');    
      supprimer_donnees_table('erp.t_cartefi_produit_import');      
    end if;
    
    intNbContraintesDes := affecter_etat_contraintes('ERP', true);
    return intNbContraintesDes;
  end;
end; 
/