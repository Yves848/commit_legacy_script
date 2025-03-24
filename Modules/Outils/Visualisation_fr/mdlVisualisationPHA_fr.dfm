inherited dmVisualisationPHA_fr: TdmVisualisationPHA_fr
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 633
  Width = 881
  inherited mnuMenuPrincipale: TJvMainMenu
    Left = 32
    Top = 24
  end
  object trPHA: TUIBTransaction
    AutoStart = False
    AutoStop = False
    Left = 712
    Top = 24
  end
  object dSetClients: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_client_id,'
      '       nom,'
      '       prenom,'
      '       nom_jeune_fille,'
      '       numero_insee,'
      '       date_naissance,'
      '       commentaire_global,'
      '       commentaire_global_bloquant,'
      '       commentaire_individuel,'
      '       commentaire_individuel_bloquant,'
      '       qualite,'
      '       type_qualite,'
      '       libelle_qualite,'
      '       rang_gemellaire,'
      '       nat_piece_justif_droit,'
      '       date_validite_piece_justif,'
      '       t_organisme_amo_id,'
      '       nom_organisme_amo,'
      '       nom_reduit_organisme_amo,'
      '       sans_centre_gestionnaire,'
      '       identifiant_national_org_amo,'
      '       centre_gestionnaire,'
      '       t_organisme_amc_id,'
      '       nom_organisme_amc,'
      '       nom_reduit_organisme_amc,'
      '       identifiant_national_org_amc,'
      '       numero_adherent_mutuelle,'
      '       contrat_sante_pharma,'
      '       mutuelle_lue_sur_carte,'
      '       date_derniere_visite,'
      '       assure_rattache,'
      '       nom_assure,'
      '       prenom_assure,'
      '       rue_1,'
      '       rue_2,'
      '       code_postal,'
      '       nom_ville,'
      '       code_postal_ville,'
      '       tel_personnel,'
      '       tel_standard,'
      '       tel_mobile,'
      '       fax,'
      '       email,'
      '       activite,'
      '       delai_paiement,'
      '       fin_de_mois,'
      '       payeur,'
      '       profil_remise,'
      '       profil_edition,'
      '       releve_de_facture,'
      '      collectif,'
      'document'
      'from v_vslt_client(:ANOM,:APRENOM)'
      '')
    BeforeClose = dSetClientsBeforeClose
    AfterScroll = dSetClientsAfterScroll
    Left = 24
    Top = 112
    object dSetClientsT_CLIENT_ID: TWideStringField
      DisplayLabel = 'N'#176' de dossier'
      FieldName = 'T_CLIENT_ID'
      Origin = 'V_VSLT_CLIENT.T_CLIENT_ID'
      Size = 50
    end
    object dSetClientsNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Origin = 'V_VSLT_CLIENT.NOM'
      Size = 30
    end
    object dSetClientsPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Origin = 'V_VSLT_CLIENT.PRENOM'
    end
    object dSetClientsNOM_JEUNE_FILLE: TWideStringField
      FieldName = 'NOM_JEUNE_FILLE'
      Origin = 'V_VSLT_CLIENT.NOM_JEUNE_FILLE'
      Size = 30
    end
    object dSetClientsNUMERO_INSEE: TWideStringField
      DisplayLabel = 'N'#176' INSEE'
      FieldName = 'NUMERO_INSEE'
      Origin = 'V_VSLT_CLIENT.NUMERO_INSEE'
      EditMask = '0 00 00 000 000 00 - 00;0;_'
      Size = 15
    end
    object dSetClientsDATE_NAISSANCE: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Date naiss.'
      FieldName = 'DATE_NAISSANCE'
      Origin = 'V_VSLT_CLIENT.DATE_NAISSANCE'
      EditMask = '!99/99/0000;0;_'
      Size = 8
    end
    object dSetClientsCOMMENTAIRE_GLOBAL: TWideStringField
      FieldName = 'COMMENTAIRE_GLOBAL'
      Origin = 'V_VSLT_CLIENT.COMMENTAIRE_GLOBAL'
      Size = 200
    end
    object dSetClientsCOMMENTAIRE_GLOBAL_BLOQUANT: TWideStringField
      FieldName = 'COMMENTAIRE_GLOBAL_BLOQUANT'
      Origin = 'V_VSLT_CLIENT.COMMENTAIRE_GLOBAL_BLOQUANT'
      Required = True
      Size = 1
    end
    object dSetClientsCOMMENTAIRE_INDIVIDUEL: TWideStringField
      FieldName = 'COMMENTAIRE_INDIVIDUEL'
      Origin = 'V_VSLT_CLIENT.COMMENTAIRE_INDIVIDUEL'
      Size = 200
    end
    object dSetClientsCOMMENTAIRE_INDIVIDUEL_BLOQUANT: TWideStringField
      FieldName = 'COMMENTAIRE_INDIVIDUEL_BLOQUANT'
      Origin = 'V_VSLT_CLIENT.COMMENTAIRE_INDIVIDUEL_BLOQUANT'
      Required = True
      Size = 1
    end
    object dSetClientsQUALITE: TWideStringField
      FieldName = 'QUALITE'
      Origin = 'V_VSLT_CLIENT.QUALITE'
      Size = 2
    end
    object dSetClientsTYPE_QUALITE: TWideStringField
      DisplayLabel = 'Qualit'#233
      FieldName = 'TYPE_QUALITE'
      Origin = 'V_VSLT_CLIENT.TYPE_QUALITE'
      Size = 11
    end
    object dSetClientsLIBELLE_QUALITE: TWideStringField
      FieldName = 'LIBELLE_QUALITE'
      Origin = 'V_VSLT_CLIENT.LIBELLE_QUALITE'
      Size = 44
    end
    object dSetClientsRANG_GEMELLAIRE: TSmallintField
      FieldName = 'RANG_GEMELLAIRE'
      Origin = 'V_VSLT_CLIENT.RANG_GEMELLAIRE'
    end
    object dSetClientsNAT_PIECE_JUSTIF_DROIT: TWideStringField
      FieldName = 'NAT_PIECE_JUSTIF_DROIT'
      Origin = 'V_VSLT_CLIENT.NAT_PIECE_JUSTIF_DROIT'
      Required = True
      Size = 60
    end
    object dSetClientsDATE_VALIDITE_PIECE_JUSTIF: TDateField
      FieldName = 'DATE_VALIDITE_PIECE_JUSTIF'
      Origin = 'V_VSLT_CLIENT.DATE_VALIDITE_PIECE_JUSTIF'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetClientsT_ORGANISME_AMO_ID: TWideStringField
      FieldName = 'T_ORGANISME_AMO_ID'
      Origin = 'V_VSLT_CLIENT.T_ORGANISME_AMO_ID'
      Size = 50
    end
    object dSetClientsNOM_ORGANISME_AMO: TWideStringField
      FieldName = 'NOM_ORGANISME_AMO'
      Origin = 'V_VSLT_CLIENT.NOM_ORGANISME_AMO'
      Size = 50
    end
    object dSetClientsNOM_REDUIT_ORGANISME_AMO: TWideStringField
      FieldName = 'NOM_REDUIT_ORGANISME_AMO'
      Origin = 'V_VSLT_CLIENT.NOM_REDUIT_ORGANISME_AMO'
    end
    object dSetClientsSANS_CENTRE_GESTIONNAIRE: TWideStringField
      FieldName = 'SANS_CENTRE_GESTIONNAIRE'
      Origin = 'V_VSLT_CLIENT.SANS_CENTRE_GESTIONNAIRE'
      Required = True
      Size = 1
    end
    object dSetClientsIDENTIFIANT_NATIONAL_ORG_AMO: TWideStringField
      FieldName = 'IDENTIFIANT_NATIONAL_ORG_AMO'
      Origin = 'V_VSLT_CLIENT.IDENTIFIANT_NATIONAL_ORG_AMO'
      Size = 6
    end
    object dSetClientsCENTRE_GESTIONNAIRE: TWideStringField
      FieldName = 'CENTRE_GESTIONNAIRE'
      Origin = 'V_VSLT_CLIENT.CENTRE_GESTIONNAIRE'
      Size = 4
    end
    object dSetClientsT_ORGANISME_AMC_ID: TWideStringField
      FieldName = 'T_ORGANISME_AMC_ID'
      Origin = 'V_VSLT_CLIENT.T_ORGANISME_AMC_ID'
      Size = 50
    end
    object dSetClientsNOM_ORGANISME_AMC: TWideStringField
      FieldName = 'NOM_ORGANISME_AMC'
      Origin = 'V_VSLT_CLIENT.NOM_ORGANISME_AMC'
      Size = 50
    end
    object dSetClientsNOM_REDUIT_ORGANISME_AMC: TWideStringField
      FieldName = 'NOM_REDUIT_ORGANISME_AMC'
      Origin = 'V_VSLT_CLIENT.NOM_REDUIT_ORGANISME_AMC'
    end
    object dSetClientsIDENTIFIANT_NATIONAL_ORG_AMC: TWideStringField
      FieldName = 'IDENTIFIANT_NATIONAL_ORG_AMC'
      Origin = 'V_VSLT_CLIENT.IDENTIFIANT_NATIONAL_ORG_AMC'
      Size = 9
    end
    object dSetClientsNUMERO_ADHERENT_MUTUELLE: TWideStringField
      FieldName = 'NUMERO_ADHERENT_MUTUELLE'
      Origin = 'V_VSLT_CLIENT.NUMERO_ADHERENT_MUTUELLE'
      Size = 16
    end
    object dSetClientsCONTRAT_SANTE_PHARMA: TWideStringField
      FieldName = 'CONTRAT_SANTE_PHARMA'
      Origin = 'V_VSLT_CLIENT.CONTRAT_SANTE_PHARMA'
      Size = 18
    end
    object dSetClientsMUTUELLE_LUE_SUR_CARTE: TWideStringField
      FieldName = 'MUTUELLE_LUE_SUR_CARTE'
      Origin = 'V_VSLT_CLIENT.MUTUELLE_LUE_SUR_CARTE'
      Required = True
      Size = 1
    end
    object dSetClientsDATE_DERNIERE_VISITE: TDateField
      FieldName = 'DATE_DERNIERE_VISITE'
      Origin = 'V_VSLT_CLIENT.DATE_DERNIERE_VISITE'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetClientsASSURE_RATTACHE: TWideStringField
      FieldName = 'ASSURE_RATTACHE'
      Origin = 'V_VSLT_CLIENT.ASSURE_RATTACHE'
      Size = 51
    end
    object dSetClientsNOM_ASSURE: TWideStringField
      FieldName = 'NOM_ASSURE'
      Origin = 'V_VSLT_CLIENT.NOM_ASSURE'
      Size = 30
    end
    object dSetClientsPRENOM_ASSURE: TWideStringField
      FieldName = 'PRENOM_ASSURE'
      Origin = 'V_VSLT_CLIENT.PRENOM_ASSURE'
    end
    object dSetClientsRUE_1: TWideStringField
      FieldName = 'RUE_1'
      Origin = 'V_VSLT_CLIENT.RUE_1'
      Size = 40
    end
    object dSetClientsRUE_2: TWideStringField
      FieldName = 'RUE_2'
      Origin = 'V_VSLT_CLIENT.RUE_2'
      Size = 40
    end
    object dSetClientsCODE_POSTAL: TWideStringField
      FieldName = 'CODE_POSTAL'
      Origin = 'V_VSLT_CLIENT.CODE_POSTAL'
      Size = 5
    end
    object dSetClientsNOM_VILLE: TWideStringField
      FieldName = 'NOM_VILLE'
      Origin = 'V_VSLT_CLIENT.NOM_VILLE'
      Size = 30
    end
    object dSetClientsCODE_POSTAL_VILLE: TWideStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Origin = 'V_VSLT_CLIENT.CODE_POSTAL_VILLE'
      Size = 36
    end
    object dSetClientsTEL_PERSONNEL: TWideStringField
      FieldName = 'TEL_PERSONNEL'
      Origin = 'V_VSLT_CLIENT.TEL_PERSONNEL'
    end
    object dSetClientsTEL_STANDARD: TWideStringField
      FieldName = 'TEL_STANDARD'
      Origin = 'V_VSLT_CLIENT.TEL_STANDARD'
    end
    object dSetClientsTEL_MOBILE: TWideStringField
      FieldName = 'TEL_MOBILE'
      Origin = 'V_VSLT_CLIENT.TEL_MOBILE'
    end
    object dSetClientsFAX: TWideStringField
      FieldName = 'FAX'
      Origin = 'V_VSLT_CLIENT.FAX'
    end
    object dSetClientsEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = 'V_VSLT_CLIENT.EMAIL'
    end
    object dSetClientsACTIVITE: TWideStringField
      FieldName = 'ACTIVITE'
      Origin = 'V_VSLT_CLIENT.ACTIVITE'
      Size = 50
    end
    object dSetClientsDELAI_PAIEMENT: TSmallintField
      FieldName = 'DELAI_PAIEMENT'
      Origin = 'V_VSLT_CLIENT.DELAI_PAIEMENT'
    end
    object dSetClientsFIN_DE_MOIS2: TWideStringField
      FieldName = 'FIN_DE_MOIS'
      Origin = 'V_VSLT_CLIENT.FIN_DE_MOIS'
      Size = 1
    end
    object dSetClientsPAYEUR: TWideStringField
      FieldName = 'PAYEUR'
      Origin = 'V_VSLT_CLIENT.PAYEUR'
      Size = 12
    end
    object dSetClientsPROFIL_REMISE: TWideStringField
      FieldName = 'PROFIL_REMISE'
      Origin = 'V_VSLT_CLIENT.PROFIL_REMISE'
      Size = 50
    end
    object dSetClientsPROFIL_EDITION: TWideStringField
      FieldName = 'PROFIL_EDITION'
      Origin = 'V_VSLT_CLIENT.PROFIL_EDITION'
      Size = 50
    end
    object dSetClientsRELEVE_DE_FACTURE: TIntegerField
      FieldName = 'RELEVE_DE_FACTURE'
      Origin = 'V_VSLT_CLIENT.RELEVE_DE_FACTURE'
    end
    object dSetClientsCOLLECTIF: TWideStringField
      FieldName = 'COLLECTIF'
      Origin = 'V_VSLT_CLIENT.COLLECTIF'
      Size = 1
    end
    object dSetClientsDOCUMENT: TWideStringField
      FieldName = 'DOCUMENT'
      Origin = 'V_VSLT_CLIENT.DOCUMENT'
      Size = 200
    end
  end
  object dSetFamilleClient: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select nom,'
      '       prenom,'
      '       libelle_qualite,'
      '       date_naissance,'
      '       rang_gemellaire,'
      '       nom_organisme_amc'
      'from v_vslt_famille_client'
      'where t_client_id <> :AIDCLIENT'
      '  and numero_insee = :ANUMEROINSEE')
    Left = 256
    Top = 360
    object dSetFamilleClientNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Origin = 'V_VSLT_FAMILLE_CLIENT.NOM'
      Size = 50
    end
    object dSetFamilleClientPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Origin = 'V_VSLT_FAMILLE_CLIENT.PRENOM'
      Size = 50
    end
    object dSetFamilleClientLIBELLE_QUALITE: TWideStringField
      DisplayLabel = 'Qualit'#233
      FieldName = 'LIBELLE_QUALITE'
      Origin = 'V_VSLT_FAMILLE_CLIENT.LIBELLE_QUALITE'
      Size = 44
    end
    object dSetFamilleClientDATE_NAISSANCE: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Date de naissance'
      FieldName = 'DATE_NAISSANCE'
      Origin = 'V_VSLT_FAMILLE_CLIENT.DATE_NAISSANCE'
      EditMask = '!99/99/0000;0;_'
      Size = 8
    end
    object dSetFamilleClientRANG_GEMELLAIRE: TSmallintField
      DisplayLabel = 'Rang'
      FieldName = 'RANG_GEMELLAIRE'
      Origin = 'V_VSLT_FAMILLE_CLIENT.RANG_GEMELLAIRE'
    end
    object dSetFamilleClientNOM_ORGANISME_AMC: TWideStringField
      DisplayLabel = 'Organisme AMC'
      FieldName = 'NOM_ORGANISME_AMC'
      Origin = 'V_VSLT_FAMILLE_CLIENT.NOM_ORGANISME_AMC'
      Size = 50
    end
  end
  object dSetCouverturesAMOClient: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select *'
      'from v_vslt_couverture_amo_client'
      'where "N'#176' de dossier" = :AIDCLIENT')
    Left = 16
    Top = 448
    object dSetCouverturesAMOClientCodeSV: TWideStringField
      FieldName = 'Code SV'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.Code SV'
      Size = 10
    end
    object dSetCouverturesAMOClientPH2: TUIBBCDField
      FieldName = 'PH2'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.PH2'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOClientPH4: TUIBBCDField
      FieldName = 'PH4'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.PH4'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOClientPH7: TUIBBCDField
      FieldName = 'PH7'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.PH7'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOClientPH1: TUIBBCDField
      FieldName = 'PH1'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.PH1'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOClientFindroit: TDateField
      FieldName = 'Fin droit'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.Fin droit'
    end
    object dSetCouverturesAMOClientNÂdedossier: TWideStringField
      DisplayLabel = 'N'#176' de dossier'
      FieldName = 'N'#194#176' de dossier'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.N'#194#176' de dossier'
      Size = 50
    end
    object dSetCouverturesAMOClientLibellÃ: TWideStringField
      DisplayLabel = 'Libell'#233
      FieldName = 'Libell'#195#169
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.Libell'#195#169
    end
    object dSetCouverturesAMOClientDÃbutdroit: TDateField
      DisplayLabel = 'D'#233'but droit'
      FieldName = 'D'#195#169'but droit'
      Origin = 'V_VSLT_COUVERTURE_AMO_CLIENT.D'#195#169'but droit'
    end
  end
  object dSetCouverturesAMCClient: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select *'
      'from v_vslt_couverture_amc_client'
      'where "N'#176' de dossier" = :AIDCLIENT')
    Left = 56
    Top = 416
    object dSetCouverturesAMCClientPH2: TUIBBCDField
      FieldName = 'PH2'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.PH2'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMCClientPH4: TUIBBCDField
      FieldName = 'PH4'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.PH4'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMCClientPH7: TUIBBCDField
      FieldName = 'PH7'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.PH7'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMCClientPH1: TUIBBCDField
      FieldName = 'PH1'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.PH1'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMCClientAAD2: TUIBBCDField
      FieldName = 'AAD'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.AAD'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMCClientAAD: TUIBBCDField
      FieldName = 'PMR'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.AAD'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMCClientFindroit: TDateField
      FieldName = 'Fin droit'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.Fin droit'
    end
    object dSetCouverturesAMCClientNÂdedossier: TWideStringField
      DisplayLabel = 'N'#176' de dossier'
      FieldName = 'N'#194#176' de dossier'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.N'#194#176' de dossier'
      Size = 50
    end
    object dSetCouverturesAMCClientLibellÃ2: TWideStringField
      DisplayLabel = 'Libell'#233
      FieldName = 'Libell'#195#169
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.Libell'#195#169
      Size = 30
    end
    object dSetCouverturesAMCClientDÃbutdroit: TDateField
      DisplayLabel = 'D'#233'but droit'
      FieldName = 'D'#195#169'but droit'
      Origin = 'V_VSLT_COUVERTURE_AMC_CLIENT.D'#195#169'but droit'
    end
  end
  object dSetOrganismes: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_organisme_id,'
      '       type_organisme,'
      '       libelle_type_organisme,'
      '       nom,'
      '       nom_reduit,'
      '       regime,'
      '       caisse_gestionnaire,'
      '       centre_gestionnaire,'
      '       identifiant_national,'
      '       nom_destinataire,'
      '       rue_1,'
      '       rue_2,'
      '       code_postal_ville,'
      '       code_postal,'
      '       nom_ville,'
      '       tel_personnel,'
      '       tel_standard,'
      '       tel_mobile,'
      '       fax,'
      '       org_conventionne,'
      '       org_circonscription,'
      '       org_reference,'
      '       top_r,'
      '       accord_tiers_payant,'
      '       mt_seuil_tiers_payant,'
      '       application_mt_mini_pc,'
      '       doc_facturation,'
      '       mt_seuil_ed_releve,'
      '       edition_releve,'
      '       type_releve,'
      '       frequence_releve,'
      '       commentaire,'
      '       commentaire_bloquant,'
      '       prise_en_charge_ame,'
      '       type_contrat,'
      '       fin_droits_org_amc,'
      '       org_sante_pharma,'
      '       saisie_no_adherent'
      'from v_vslt_organisme'
      'where upper(nom) like upper(:ANOM) || '#39'%'#39
      '  and identifiant_national like :AIDENTIFIANTNATIONAL || '#39'%'#39)
    BeforeClose = dSetOrganismesBeforeClose
    AfterScroll = dSetOrganismesAfterScroll
    Left = 160
    Top = 416
    object dSetOrganismesT_ORGANISME_ID: TWideStringField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'T_ORGANISME_ID'
      Origin = 'V_VSLT_ORGANISME.T_ORGANISME_ID'
      Size = 50
    end
    object dSetOrganismesTYPE_ORGANISME: TWideStringField
      FieldName = 'TYPE_ORGANISME'
      Origin = 'V_VSLT_ORGANISME.TYPE_ORGANISME'
      Required = True
      Size = 1
    end
    object dSetOrganismesLIBELLE_TYPE_ORGANISME: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Type d'#39'organisme'
      FieldName = 'LIBELLE_TYPE_ORGANISME'
      Origin = 'V_VSLT_ORGANISME.LIBELLE_TYPE_ORGANISME'
      Size = 3
    end
    object dSetOrganismesNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Origin = 'V_VSLT_ORGANISME.NOM'
      Size = 50
    end
    object dSetOrganismesNOM_REDUIT: TWideStringField
      DisplayLabel = 'Nom r'#233'duit'
      FieldName = 'NOM_REDUIT'
      Origin = 'V_VSLT_ORGANISME.NOM_REDUIT'
    end
    object dSetOrganismesREGIME: TWideStringField
      FieldName = 'REGIME'
      Origin = 'V_VSLT_ORGANISME.REGIME'
      Size = 2
    end
    object dSetOrganismesCAISSE_GESTIONNAIRE: TWideStringField
      FieldName = 'CAISSE_GESTIONNAIRE'
      Origin = 'V_VSLT_ORGANISME.CAISSE_GESTIONNAIRE'
      Size = 3
    end
    object dSetOrganismesCENTRE_GESTIONNAIRE: TWideStringField
      FieldName = 'CENTRE_GESTIONNAIRE'
      Origin = 'V_VSLT_ORGANISME.CENTRE_GESTIONNAIRE'
      Size = 4
    end
    object dSetOrganismesIDENTIFIANT_NATIONAL: TWideStringField
      FieldName = 'IDENTIFIANT_NATIONAL'
      Origin = 'V_VSLT_ORGANISME.IDENTIFIANT_NATIONAL'
      Size = 9
    end
    object dSetOrganismesNOM_DESTINATAIRE: TWideStringField
      DisplayLabel = 'Destinataire'
      FieldName = 'NOM_DESTINATAIRE'
      Origin = 'V_VSLT_ORGANISME.NOM_DESTINATAIRE'
      Size = 50
    end
    object dSetOrganismesRUE_1: TWideStringField
      FieldName = 'RUE_1'
      Origin = 'V_VSLT_ORGANISME.RUE_1'
      Size = 40
    end
    object dSetOrganismesRUE_2: TWideStringField
      FieldName = 'RUE_2'
      Origin = 'V_VSLT_ORGANISME.RUE_2'
      Size = 40
    end
    object dSetOrganismesCODE_POSTAL_VILLE: TWideStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Origin = 'V_VSLT_ORGANISME.CODE_POSTAL_VILLE'
      Size = 36
    end
    object dSetOrganismesCODE_POSTAL: TWideStringField
      FieldName = 'CODE_POSTAL'
      Origin = 'V_VSLT_ORGANISME.CODE_POSTAL'
      Size = 5
    end
    object dSetOrganismesNOM_VILLE: TWideStringField
      FieldName = 'NOM_VILLE'
      Origin = 'V_VSLT_ORGANISME.NOM_VILLE'
      Size = 30
    end
    object dSetOrganismesTEL_PERSONNEL: TWideStringField
      FieldName = 'TEL_PERSONNEL'
      Origin = 'V_VSLT_ORGANISME.TEL_PERSONNEL'
    end
    object dSetOrganismesTEL_STANDARD: TWideStringField
      FieldName = 'TEL_STANDARD'
      Origin = 'V_VSLT_ORGANISME.TEL_STANDARD'
    end
    object dSetOrganismesTEL_MOBILE: TWideStringField
      FieldName = 'TEL_MOBILE'
      Origin = 'V_VSLT_ORGANISME.TEL_MOBILE'
    end
    object dSetOrganismesFAX: TWideStringField
      FieldName = 'FAX'
      Origin = 'V_VSLT_ORGANISME.FAX'
    end
    object dSetOrganismesORG_CONVENTIONNE: TWideStringField
      FieldName = 'ORG_CONVENTIONNE'
      Origin = 'V_VSLT_ORGANISME.ORG_CONVENTIONNE'
      Size = 1
    end
    object dSetOrganismesORG_CIRCONSCRIPTION: TWideStringField
      FieldName = 'ORG_CIRCONSCRIPTION'
      Origin = 'V_VSLT_ORGANISME.ORG_CIRCONSCRIPTION'
      Required = True
      Size = 1
    end
    object dSetOrganismesORG_REFERENCE: TWideStringField
      FieldName = 'ORG_REFERENCE'
      Origin = 'V_VSLT_ORGANISME.ORG_REFERENCE'
      Required = True
      Size = 1
    end
    object dSetOrganismesTOP_R: TWideStringField
      FieldName = 'TOP_R'
      Origin = 'V_VSLT_ORGANISME.TOP_R'
      Required = True
      Size = 1
    end
    object dSetOrganismesACCORD_TIERS_PAYANT: TWideStringField
      FieldName = 'ACCORD_TIERS_PAYANT'
      Origin = 'V_VSLT_ORGANISME.ACCORD_TIERS_PAYANT'
      Required = True
      Size = 1
    end
    object dSetOrganismesDOC_FACTURATION: TSmallintField
      FieldName = 'DOC_FACTURATION'
      Origin = 'V_VSLT_ORGANISME.DOC_FACTURATION'
    end
    object dSetOrganismesMT_SEUIL_ED_RELEVE: TUIBBCDField
      FieldName = 'MT_SEUIL_ED_RELEVE'
      Origin = 'V_VSLT_ORGANISME.MT_SEUIL_ED_RELEVE'
      Precision = 9
      Size = 2
    end
    object dSetOrganismesEDITION_RELEVE: TWideStringField
      FieldName = 'EDITION_RELEVE'
      Origin = 'V_VSLT_ORGANISME.EDITION_RELEVE'
      Required = True
      Size = 1
    end
    object dSetOrganismesTYPE_RELEVE: TWideStringField
      FieldName = 'TYPE_RELEVE'
      Origin = 'V_VSLT_ORGANISME.TYPE_RELEVE'
      Size = 10
    end
    object dSetOrganismesFREQUENCE_RELEVE: TSmallintField
      FieldName = 'FREQUENCE_RELEVE'
      Origin = 'V_VSLT_ORGANISME.FREQUENCE_RELEVE'
    end
    object dSetOrganismesCOMMENTAIRE: TWideStringField
      FieldName = 'COMMENTAIRE'
      Origin = 'V_VSLT_ORGANISME.COMMENTAIRE'
      Size = 200
    end
    object dSetOrganismesCOMMENTAIRE_BLOQUANT: TWideStringField
      FieldName = 'COMMENTAIRE_BLOQUANT'
      Origin = 'V_VSLT_ORGANISME.COMMENTAIRE_BLOQUANT'
      Size = 200
    end
    object dSetOrganismesPRISE_EN_CHARGE_AME: TWideStringField
      FieldName = 'PRISE_EN_CHARGE_AME'
      Origin = 'V_VSLT_ORGANISME.PRISE_EN_CHARGE_AME'
      Required = True
      Size = 1
    end
    object dSetOrganismesTYPE_CONTRAT: TSmallintField
      FieldName = 'TYPE_CONTRAT'
      Origin = 'V_VSLT_ORGANISME.TYPE_CONTRAT'
    end
    object dSetOrganismesFIN_DROITS_ORG_AMC: TWideStringField
      FieldName = 'FIN_DROITS_ORG_AMC'
      Origin = 'V_VSLT_ORGANISME.FIN_DROITS_ORG_AMC'
      Required = True
      Size = 1
    end
    object dSetOrganismesORG_SANTE_PHARMA: TWideStringField
      FieldName = 'ORG_SANTE_PHARMA'
      Origin = 'V_VSLT_ORGANISME.ORG_SANTE_PHARMA'
      Required = True
      Size = 1
    end
    object dSetOrganismesSAISIE_NO_ADHERENT: TWideStringField
      FieldName = 'SAISIE_NO_ADHERENT'
      Origin = 'V_VSLT_ORGANISME.SAISIE_NO_ADHERENT'
      Required = True
      Size = 1
    end
    object dSetOrganismesMT_SEUIL_TIERS_PAYANT: TUIBBCDField
      FieldName = 'MT_SEUIL_TIERS_PAYANT'
      Origin = 'V_VSLT_ORGANISME.MT_SEUIL_TIERS_PAYANT'
      Precision = 18
      Size = 2
    end
    object dSetOrganismesAPPLICATION_MT_MINI_PC: TWideStringField
      FieldName = 'APPLICATION_MT_MINI_PC'
      Origin = 'V_VSLT_ORGANISME.APPLICATION_MT_MINI_PC'
      Size = 16
    end
  end
  object dSetCouverturesAMO: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select *'
      'from v_vslt_couverture_amo'
      'where "N'#176' d'#39'organisme" = :AIDORGANISMEAMO')
    Left = 24
    Top = 344
    object dSetCouverturesAMOCodeSV: TWideStringField
      FieldName = 'Code SV'
      Origin = 'V_VSLT_COUVERTURE_AMO.Code SV'
      Size = 5
    end
    object dSetCouverturesAMONatass: TSmallintField
      FieldName = 'Nat. ass.'
      Origin = 'V_VSLT_COUVERTURE_AMO.Nat. ass.'
    end
    object dSetCouverturesAMOExo: TWideStringField
      FieldName = 'Exo.'
      Origin = 'V_VSLT_COUVERTURE_AMO.Exo.'
      Size = 1
    end
    object dSetCouverturesAMOPH2: TUIBBCDField
      FieldName = 'PH2'
      Origin = 'V_VSLT_COUVERTURE_AMO.PH2'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOPH4: TUIBBCDField
      FieldName = 'PH4'
      Origin = 'V_VSLT_COUVERTURE_AMO.PH4'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOPH7: TUIBBCDField
      FieldName = 'PH7'
      Origin = 'V_VSLT_COUVERTURE_AMO.PH7'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMOPH1: TUIBBCDField
      FieldName = 'PH1'
      Origin = 'V_VSLT_COUVERTURE_AMO.PH1'
      Precision = 18
      Size = 2
    end
    object dSetCouverturesAMONÂdorganisme: TWideStringField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'N'#194#176' d'#39'organisme'
      Origin = 'V_VSLT_COUVERTURE_AMO.N'#194#176' d'#39'organisme'
      Size = 50
    end
    object dSetCouverturesAMOLibÃllÃ: TWideStringField
      DisplayLabel = 'Libell'#233
      FieldName = 'Lib'#195#169'll'#195#169
      Origin = 'V_VSLT_COUVERTURE_AMO.Lib'#195#169'll'#195#169
      Size = 50
    end
  end
  object dSetCouverturesAMC: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select *'
      'from v_vslt_couverture_amc_conv'
      'where "N'#176' d'#39'organisme" = :AIDORGANISMEAMC')
    Left = 344
    Top = 392
  end
  object dSetAssociationsOrganismesAMOAMC: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_organisme_amc_id,'
      '       t_organisme_amo_id,'
      '       nom_organisme_amo,'
      '       top_mutualiste,'
      '       type_contrat,'
      '       regime,'
      '       caisse_gestionnaire,'
      '       centre_gestionnaire,'
      '       t_destinataire_id,'
      '       nom_destinataire,'
      '       type_debiteur'
      'from v_vslt_organisme_amo_ass_amc'
      'where t_organisme_amc_id = :AIDORGANISMEAMC;')
    Left = 488
    Top = 416
    object dSetAssociationsOrganismesAMOAMCT_ORGANISME_AMC_ID: TWideStringField
      FieldName = 'T_ORGANISME_AMC_ID'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.T_ORGANISME_AMC_ID'
      Size = 50
    end
    object dSetAssociationsOrganismesAMOAMCT_ORGANISME_AMO_ID: TWideStringField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'T_ORGANISME_AMO_ID'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.T_ORGANISME_AMO_ID'
      Size = 50
    end
    object dSetAssociationsOrganismesAMOAMCNOM_ORGANISME_AMO: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM_ORGANISME_AMO'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.NOM_ORGANISME_AMO'
      Size = 50
    end
    object dSetAssociationsOrganismesAMOAMCTOP_MUTUALISTE: TWideStringField
      DisplayLabel = 'Top M'
      FieldName = 'TOP_MUTUALISTE'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.TOP_MUTUALISTE'
      Required = True
      Size = 1
    end
    object dSetAssociationsOrganismesAMOAMCTYPE_CONTRAT: TSmallintField
      DisplayLabel = 'Contrat'
      FieldName = 'TYPE_CONTRAT'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.TYPE_CONTRAT'
    end
    object dSetAssociationsOrganismesAMOAMCREGIME: TWideStringField
      DisplayLabel = 'Reg.'
      FieldName = 'REGIME'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.REGIME'
      Size = 2
    end
    object dSetAssociationsOrganismesAMOAMCCAISSE_GESTIONNAIRE: TWideStringField
      DisplayLabel = 'Caisse gest.'
      FieldName = 'CAISSE_GESTIONNAIRE'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.CAISSE_GESTIONNAIRE'
      Size = 3
    end
    object dSetAssociationsOrganismesAMOAMCCENTRE_GESTIONNAIRE: TWideStringField
      DisplayLabel = 'Centre gest.'
      FieldName = 'CENTRE_GESTIONNAIRE'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.CENTRE_GESTIONNAIRE'
      Size = 4
    end
    object dSetAssociationsOrganismesAMOAMCT_DESTINATAIRE_ID: TWideStringField
      FieldName = 'T_DESTINATAIRE_ID'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.T_DESTINATAIRE_ID'
      Size = 50
    end
    object dSetAssociationsOrganismesAMOAMCNOM_DESTINATAIRE: TWideStringField
      DisplayLabel = 'Destinataire t'#233'l'#233'trans.'
      FieldName = 'NOM_DESTINATAIRE'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.NOM_DESTINATAIRE'
      Size = 50
    end
    object dSetAssociationsOrganismesAMOAMCTYPE_DEBITEUR: TWideStringField
      DisplayLabel = 'D'#233'biteur'
      FieldName = 'TYPE_DEBITEUR'
      Origin = 'V_VSLT_ORGANISME_AMO_ASS_AMC.TYPE_DEBITEUR'
      Size = 7
    end
  end
  object dSetPraticiens: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_praticien_id,'
      '       type_praticien,'
      '       libelle_type_praticien,'
      '       nom,'
      '       prenom,'
      '       no_finess,'
      '       specialite,'
      '       agree_ratp,'
      '       rue_1,'
      '       rue_2,'
      '       code_postal,'
      '       nom_ville,'
      '       code_postal_ville,'
      '       tel_standard,'
      '       tel_personnel,'
      '       tel_mobile,'
      '       fax,'
      '       commentaire,'
      '       t_hopital_id,'
      '       nom_hopital,'
      '       rpps,'
      '       email'
      'from v_vslt_praticien'
      'where upper(nom) like upper(:ANOM) || '#39'%'#39
      '  and upper(prenom) like upper(:APRENOM) || '#39'%'#39)
    BeforeClose = dSetPraticiensBeforeClose
    AfterScroll = dSetPraticiensAfterScroll
    Left = 160
    Top = 472
    object dSetPraticiensT_PRATICIEN_ID: TWideStringField
      DisplayLabel = 'N'#176' de praticien'
      FieldName = 'T_PRATICIEN_ID'
      Origin = 'V_VSLT_PRATICIEN.T_PRATICIEN_ID'
      Size = 50
    end
    object dSetPraticiensTYPE_PRATICIEN: TWideStringField
      FieldName = 'TYPE_PRATICIEN'
      Origin = 'V_VSLT_PRATICIEN.TYPE_PRATICIEN'
      Required = True
      Size = 1
    end
    object dSetPraticiensNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Origin = 'V_VSLT_PRATICIEN.NOM'
      Size = 50
    end
    object dSetPraticiensPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Origin = 'V_VSLT_PRATICIEN.PRENOM'
      Size = 50
    end
    object dSetPraticiensNO_FINESS: TWideStringField
      DisplayLabel = 'N'#176' finess'
      FieldName = 'NO_FINESS'
      Origin = 'V_VSLT_PRATICIEN.NO_FINESS'
      Size = 9
    end
    object dSetPraticiensAGREE_RATP: TWideStringField
      FieldName = 'AGREE_RATP'
      Origin = 'V_VSLT_PRATICIEN.AGREE_RATP'
      Required = True
      Size = 1
    end
    object dSetPraticiensRUE_1: TWideStringField
      FieldName = 'RUE_1'
      Origin = 'V_VSLT_PRATICIEN.RUE_1'
      Size = 40
    end
    object dSetPraticiensRUE_2: TWideStringField
      FieldName = 'RUE_2'
      Origin = 'V_VSLT_PRATICIEN.RUE_2'
      Size = 40
    end
    object dSetPraticiensCODE_POSTAL: TWideStringField
      FieldName = 'CODE_POSTAL'
      Origin = 'V_VSLT_PRATICIEN.CODE_POSTAL'
      Size = 5
    end
    object dSetPraticiensNOM_VILLE: TWideStringField
      FieldName = 'NOM_VILLE'
      Origin = 'V_VSLT_PRATICIEN.NOM_VILLE'
      Size = 30
    end
    object dSetPraticiensCODE_POSTAL_VILLE: TWideStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Origin = 'V_VSLT_PRATICIEN.CODE_POSTAL_VILLE'
      Size = 36
    end
    object dSetPraticiensTEL_STANDARD: TWideStringField
      FieldName = 'TEL_STANDARD'
      Origin = 'V_VSLT_PRATICIEN.TEL_STANDARD'
    end
    object dSetPraticiensTEL_PERSONNEL: TWideStringField
      DisplayLabel = 'T'#233'l'#233'phone'
      FieldName = 'TEL_PERSONNEL'
      Origin = 'V_VSLT_PRATICIEN.TEL_PERSONNEL'
    end
    object dSetPraticiensTEL_MOBILE: TWideStringField
      FieldName = 'TEL_MOBILE'
      Origin = 'V_VSLT_PRATICIEN.TEL_MOBILE'
    end
    object dSetPraticiensFAX: TWideStringField
      FieldName = 'FAX'
      Origin = 'V_VSLT_PRATICIEN.FAX'
    end
    object dSetPraticiensCOMMENTAIRE: TWideStringField
      FieldName = 'COMMENTAIRE'
      Origin = 'V_VSLT_PRATICIEN.COMMENTAIRE'
      Size = 200
    end
    object dSetPraticiensT_HOPITAL_ID: TWideStringField
      FieldName = 'T_HOPITAL_ID'
      Origin = 'V_VSLT_PRATICIEN.T_HOPITAL_ID'
      Size = 50
    end
    object dSetPraticiensNOM_HOPITAL: TWideStringField
      FieldName = 'NOM_HOPITAL'
      Origin = 'V_VSLT_PRATICIEN.NOM_HOPITAL'
      Size = 50
    end
    object dSetPraticiensSPECIALITE: TWideStringField
      FieldName = 'SPECIALITE'
      Origin = 'V_VSLT_PRATICIEN.SPECIALITE'
      Size = 50
    end
    object dSetPraticiensLIBELLE_TYPE_PRATICIEN: TWideStringField
      DisplayLabel = 'Type de praticien'
      FieldName = 'LIBELLE_TYPE_PRATICIEN'
      Origin = 'V_VSLT_PRATICIEN.LIBELLE_TYPE_PRATICIEN'
      Size = 11
    end
    object dSetPraticiensRPPS: TWideStringField
      FieldName = 'RPPS'
      Size = 11
    end
    object dSetPraticiensEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 11
    end
  end
  object dSetPraticienHospitalier: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select nom,'
      '       prenom,'
      '       specialite'
      'from v_vslt_praticien_hospitalier'
      'where t_hopital_id = :AIDHOPITAL')
    Left = 256
    Top = 472
    object dSetPraticienHospitalierNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Origin = 'V_VSLT_PRATICIEN_HOSPITALIER.NOM'
      Size = 50
    end
    object dSetPraticienHospitalierPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Origin = 'V_VSLT_PRATICIEN_HOSPITALIER.PRENOM'
      Size = 50
    end
    object dSetPraticienHospitalierSPECIALITE: TWideStringField
      DisplayLabel = 'Specialit'#233
      FieldName = 'SPECIALITE'
      Origin = 'V_VSLT_PRATICIEN_HOSPITALIER.SPECIALITE'
      Size = 50
    end
  end
  object dSetProduits: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select   t_produit_id,'
      '  code_cip,'
      '  code_cip7,'
      '  designation,'
      '  type_homeo,'
      '  date_derniere_vente,'
      '  taux_tva,'
      '  liste,'
      '  soumis_mdl,'
      '  tarif_achat_unique,'
      '  prix_vente,'
      '  base_remboursement,'
      '  prix_achat_catalogue,'
      '  pamp,'
      '  prestation,'
      '  etat,'
      '  contenance,'
      '  unite_mesure,'
      '  veterinaire,'
      '  delai_lait,'
      '  delai_viande,'
      '  gere_interessement,'
      '  tracabilite,'
      '  gere_suivi_client,'
      '  gere_pfc,'
      '  commentaire_vente,'
      '  commentaire_commande,'
      '  commentaire_gestion,'
      '  profil_gs,'
      '  explication_profil_gs,'
      '  marque,'
      '  repartiteur_attitre,'
      '  nombre_mois_calcul,'
      '  calcul_gs,'
      '  stock_mini,'
      '  stock_maxi,'
      '  conditionnement,'
      '  lot_achat,'
      '  lot_vente,'
      '  unite_moyenne_vente,'
      '  moyenne_vente,'
      '  nombre_produit_du,'
      '  quantite_pha,'
      '  quantite_total,'
      '  zone_geographique_pha,'
      '  produit_kit,'
      '  codification_1,'
      '  codification_2,'
      '  codification_3,'
      '  codification_4,'
      '  codification_5,'
      '  codification_7,'
      '  commandes_en_cours,'
      '  date_peremption'
      'from v_vslt_produit'
      'where code_cip like '#39'%'#39'|| :ACODECIP || '#39'%'#39
      
        '   or upper(designation) like  '#39'%'#39'||  upper(:ADESIGNATION) || '#39'%' +
        #39
      ' or  code_cip7 like '#39'%'#39'||:ACODECIP7 || '#39'%'#39
      ''
      '')
    BeforeClose = dSetProduitsBeforeClose
    AfterScroll = dSetProduitsAfterScroll
    Left = 232
    Top = 24
    object dSetProduitsT_PRODUIT_ID: TWideStringField
      DisplayLabel = 'N'#176' de produit'
      FieldName = 'T_PRODUIT_ID'
      Origin = 'V_VSLT_PRODUIT.T_PRODUIT_ID'
      Size = 50
    end
    object dSetProduitsCODE_CIP2: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'CODE_CIP'
      Origin = 'V_VSLT_PRODUIT.CODE_CIP'
      Size = 13
    end
    object dSetProduitsCODE_CIP: TWideStringField
      DisplayLabel = 'Code CIP7'
      FieldName = 'CODE_CIP7'
      Origin = 'V_VSLT_PRODUIT.CODE_CIP'
      Size = 7
    end
    object dSetProduitsDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Origin = 'V_VSLT_PRODUIT.DESIGNATION'
      Size = 50
    end
    object dSetProduitsDATE_DERNIERE_VENTE: TDateField
      FieldName = 'DATE_DERNIERE_VENTE'
      Origin = 'V_VSLT_PRODUIT.DATE_DERNIERE_VENTE'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetProduitsTAUX_TVA: TUIBBCDField
      FieldName = 'TAUX_TVA'
      Origin = 'V_VSLT_PRODUIT.TAUX_TVA'
      Precision = 9
      Size = 2
    end
    object dSetProduitsSOUMIS_MDL: TWideStringField
      FieldName = 'SOUMIS_MDL'
      Origin = 'V_VSLT_PRODUIT.SOUMIS_MDL'
      Size = 1
    end
    object dSetProduitsTARIF_ACHAT_UNIQUE: TWideStringField
      FieldName = 'TARIF_ACHAT_UNIQUE'
      Origin = 'V_VSLT_PRODUIT.TARIF_ACHAT_UNIQUE'
      Size = 1
    end
    object dSetProduitsPRIX_VENTE: TUIBBCDField
      DisplayLabel = 'PV TTC'
      FieldName = 'PRIX_VENTE'
      Origin = 'V_VSLT_PRODUIT.PRIX_VENTE'
      Precision = 18
      Size = 2
    end
    object dSetProduitsBASE_REMBOURSEMENT: TUIBBCDField
      FieldName = 'BASE_REMBOURSEMENT'
      Origin = 'V_VSLT_PRODUIT.BASE_REMBOURSEMENT'
      Precision = 18
      Size = 2
    end
    object dSetProduitsPRIX_ACHAT_CATALOGUE: TUIBBCDField
      FieldName = 'PRIX_ACHAT_CATALOGUE'
      Origin = 'V_VSLT_PRODUIT.PRIX_ACHAT_CATALOGUE'
      Precision = 18
      Size = 3
    end
    object dSetProduitsPAMP: TUIBBCDField
      FieldName = 'PAMP'
      Origin = 'V_VSLT_PRODUIT.PAMP'
      Precision = 18
      Size = 3
    end
    object dSetProduitsPRESTATION: TWideStringField
      FieldName = 'PRESTATION'
      Origin = 'V_VSLT_PRODUIT.PRESTATION'
      Size = 3
    end
    object dSetProduitsCONTENANCE: TIntegerField
      FieldName = 'CONTENANCE'
      Origin = 'V_VSLT_PRODUIT.CONTENANCE'
    end
    object dSetProduitsVETERINAIRE: TWideStringField
      FieldName = 'VETERINAIRE'
      Origin = 'V_VSLT_PRODUIT.VETERINAIRE'
      Required = True
      Size = 1
    end
    object dSetProduitsDELAI_LAIT: TSmallintField
      FieldName = 'DELAI_LAIT'
      Origin = 'V_VSLT_PRODUIT.DELAI_LAIT'
    end
    object dSetProduitsDELAI_VIANDE: TSmallintField
      FieldName = 'DELAI_VIANDE'
      Origin = 'V_VSLT_PRODUIT.DELAI_VIANDE'
    end
    object dSetProduitsGERE_INTERESSEMENT: TWideStringField
      FieldName = 'GERE_INTERESSEMENT'
      Origin = 'V_VSLT_PRODUIT.GERE_INTERESSEMENT'
      Required = True
      Size = 1
    end
    object dSetProduitsTRACABILITE: TWideStringField
      FieldName = 'TRACABILITE'
      Origin = 'V_VSLT_PRODUIT.TRACABILITE'
      Required = True
      Size = 1
    end
    object dSetProduitsGERE_SUIVI_CLIENT: TWideStringField
      FieldName = 'GERE_SUIVI_CLIENT'
      Origin = 'V_VSLT_PRODUIT.GERE_SUIVI_CLIENT'
      Required = True
      Size = 1
    end
    object dSetProduitsGERE_PFC: TWideStringField
      FieldName = 'GERE_PFC'
      Origin = 'V_VSLT_PRODUIT.GERE_PFC'
      Required = True
      Size = 1
    end
    object dSetProduitsCOMMENTAIRE_VENTE: TWideStringField
      FieldName = 'COMMENTAIRE_VENTE'
      Origin = 'V_VSLT_PRODUIT.COMMENTAIRE_VENTE'
      Size = 200
    end
    object dSetProduitsCOMMENTAIRE_COMMANDE: TWideStringField
      FieldName = 'COMMENTAIRE_COMMANDE'
      Origin = 'V_VSLT_PRODUIT.COMMENTAIRE_COMMANDE'
      Size = 200
    end
    object dSetProduitsCOMMENTAIRE_GESTION: TWideStringField
      FieldName = 'COMMENTAIRE_GESTION'
      Origin = 'V_VSLT_PRODUIT.COMMENTAIRE_GESTION'
      Size = 200
    end
    object dSetProduitsMARQUE: TWideStringField
      FieldName = 'MARQUE'
      Origin = 'V_VSLT_PRODUIT.MARQUE'
      Size = 50
    end
    object dSetProduitsREPARTITEUR_ATTITRE: TWideStringField
      FieldName = 'REPARTITEUR_ATTITRE'
      Origin = 'V_VSLT_PRODUIT.REPARTITEUR_ATTITRE'
      Size = 50
    end
    object dSetProduitsNOMBRE_MOIS_CALCUL: TSmallintField
      FieldName = 'NOMBRE_MOIS_CALCUL'
      Origin = 'V_VSLT_PRODUIT.NOMBRE_MOIS_CALCUL'
    end
    object dSetProduitsSTOCK_MINI: TIntegerField
      FieldName = 'STOCK_MINI'
      Origin = 'V_VSLT_PRODUIT.STOCK_MINI'
    end
    object dSetProduitsSTOCK_MAXI: TIntegerField
      FieldName = 'STOCK_MAXI'
      Origin = 'V_VSLT_PRODUIT.STOCK_MAXI'
    end
    object dSetProduitsCONDITIONNEMENT: TSmallintField
      FieldName = 'CONDITIONNEMENT'
      Origin = 'V_VSLT_PRODUIT.CONDITIONNEMENT'
    end
    object dSetProduitsLOT_ACHAT: TIntegerField
      FieldName = 'LOT_ACHAT'
      Origin = 'V_VSLT_PRODUIT.LOT_ACHAT'
    end
    object dSetProduitsLOT_VENTE: TIntegerField
      FieldName = 'LOT_VENTE'
      Origin = 'V_VSLT_PRODUIT.LOT_VENTE'
    end
    object dSetProduitsUNITE_MOYENNE_VENTE: TIntegerField
      FieldName = 'UNITE_MOYENNE_VENTE'
      Origin = 'V_VSLT_PRODUIT.UNITE_MOYENNE_VENTE'
    end
    object dSetProduitsMOYENNE_VENTE: TUIBBCDField
      FieldName = 'MOYENNE_VENTE'
      Origin = 'V_VSLT_PRODUIT.MOYENNE_VENTE'
      Precision = 9
      Size = 1
    end
    object dSetProduitsNOMBRE_PRODUIT_DU: TIntegerField
      FieldName = 'NOMBRE_PRODUIT_DU'
      Origin = 'V_VSLT_PRODUIT.NOMBRE_PRODUIT_DU'
    end
    object dSetProduitsQUANTITE_TOTAL: TLargeintField
      DisplayLabel = 'Stock total'
      FieldName = 'QUANTITE_TOTAL'
      Origin = 'V_VSLT_PRODUIT.QUANTITE_TOTAL'
    end
    object dSetProduitsZONE_GEOGRAPHIQUE_PHA: TWideStringField
      DisplayLabel = 'Zone g'#233'o. princ.'
      FieldName = 'ZONE_GEOGRAPHIQUE_PHA'
      Origin = 'V_VSLT_PRODUIT.ZONE_GEOGRAPHIQUE_PHA'
      Size = 50
    end
    object dSetProduitsQUANTITE_PHA: TIntegerField
      DisplayLabel = 'Stock princ.'
      FieldName = 'QUANTITE_PHA'
      Origin = 'V_VSLT_PRODUIT.QUANTITE_PHA'
    end
    object dSetProduitsLISTE: TWideStringField
      FieldName = 'LISTE'
      Origin = 'V_VSLT_PRODUIT.LISTE'
      Size = 11
    end
    object dSetProduitsETAT: TWideStringField
      FieldName = 'ETAT'
      Origin = 'V_VSLT_PRODUIT.ETAT'
      Size = 21
    end
    object dSetProduitsUNITE_MESURE: TWideStringField
      FieldName = 'UNITE_MESURE'
      Origin = 'V_VSLT_PRODUIT.UNITE_MESURE'
      Size = 11
    end
    object dSetProduitsPROFIL_GS: TWideStringField
      FieldName = 'PROFIL_GS'
      Origin = 'V_VSLT_PRODUIT.PROFIL_GS'
      Size = 29
    end
    object dSetProduitsCALCUL_GS: TWideStringField
      FieldName = 'CALCUL_GS'
      Origin = 'V_VSLT_PRODUIT.CALCUL_GS'
      Size = 26
    end
    object dSetProduitsPRODUIT_KIT: TWideStringField
      FieldName = 'PRODUIT_KIT'
      Origin = 'V_VSLT_PRODUIT.PRODUIT_KIT'
      Size = 1
    end
    object dSetProduitsTYPE_HOMEO: TWideStringField
      FieldName = 'TYPE_HOMEO'
      Origin = 'V_VSLT_PRODUIT.TYPE_HOMEO'
      Size = 17
    end
    object dSetProduitsCODIFICATION_1: TWideStringField
      FieldName = 'CODIFICATION_1'
      Origin = 'V_VSLT_PRODUIT.CODIFICATION_1'
      Size = 50
    end
    object dSetProduitsCODIFICATION_2: TWideStringField
      FieldName = 'CODIFICATION_2'
      Origin = 'V_VSLT_PRODUIT.CODIFICATION_2'
      Size = 50
    end
    object dSetProduitsCODIFICATION_3: TWideStringField
      FieldName = 'CODIFICATION_3'
      Origin = 'V_VSLT_PRODUIT.CODIFICATION_3'
      Size = 50
    end
    object dSetProduitsCODIFICATION_4: TWideStringField
      FieldName = 'CODIFICATION_4'
      Origin = 'V_VSLT_PRODUIT.CODIFICATION_4'
      Size = 50
    end
    object dSetProduitsCODIFICATION_5: TWideStringField
      FieldName = 'CODIFICATION_5'
      Origin = 'V_VSLT_PRODUIT.CODIFICATION_5'
      Size = 50
    end
    object dSetProduitsCODIFICATION_7: TWideStringField
      FieldName = 'CODIFICATION_7'
      Origin = 'V_VSLT_PRODUIT.CODIFICATION_7'
      Size = 50
    end
    object dSetProduitsEXPLICATION_PROFIL_GS: TWideStringField
      FieldName = 'EXPLICATION_PROFIL_GS'
      Origin = 'V_VSLT_PRODUIT.EXPLICATION_PROFIL_GS'
      Size = 29
    end
    object dSetProduitsCOMMANDES_EN_COURS: TIntegerField
      FieldName = 'COMMANDES_EN_COURS'
      Origin = 'V_VSLT_PRODUIT.COMMANDES_EN_COURS'
    end
    object dSetProduitsDATE_PEREMPTION: TDateField
      FieldName = 'DATE_PEREMPTION'
      DisplayFormat = 'DD/MM/YYYY'
    end
  end
  object dSetCodesEAN13: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_produit_id,'
      'code_ean13'
      'from v_vslt_code_ean13'
      'where t_produit_id = :APRODUITID')
    Left = 352
    Top = 24
    object dSetCodesEAN13T_PRODUIT_ID: TWideStringField
      FieldName = 'T_PRODUIT_ID'
      Origin = 'V_VSLT_CODE_EAN13.T_PRODUIT_ID'
      Size = 50
    end
    object dSetCodesEAN13CODE_EAN13: TWideStringField
      DisplayLabel = 'Code EAN13'
      FieldName = 'CODE_EAN13'
      Origin = 'V_VSLT_CODE_EAN13.CODE_EAN13'
      Size = 13
    end
  end
  object dSetCatalogues: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_fournisseur_id,'
      '       raison_sociale,'
      '       t_produit_id,'
      '       code_cip,'
      '       designation,'
      '       prix_achat_catalogue,'
      '       prix_achat_remise,'
      '       remise_simple'
      'from v_vslt_catalogue'
      'where t_fournisseur_id = :AFOURNISSEURID')
    Left = 232
    Top = 136
    object dSetCataloguesT_FOURNISSEUR_ID: TWideStringField
      FieldName = 'T_FOURNISSEUR_ID'
      Size = 50
    end
    object dSetCataloguesT_PRODUIT_ID: TWideStringField
      FieldName = 'T_PRODUIT_ID'
      Origin = 'V_VSLT_TARIF.T_PRODUIT_ID'
      Size = 50
    end
    object dSetCataloguesCODE_CIP: TWideStringField
      DisplayLabel = 'CIP'
      FieldName = 'CODE_CIP'
      Size = 13
    end
    object dSetCataloguesDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Size = 50
    end
    object dSetCataloguesRAISON_SOCIALE: TWideStringField
      DisplayLabel = 'Fournisseur'
      FieldName = 'RAISON_SOCIALE'
      Size = 50
    end
    object dSetCataloguesPRIX_ACHAT_CATALOGUE: TUIBBCDField
      DisplayLabel = 'PA Tarif'
      FieldName = 'PRIX_ACHAT_CATALOGUE'
      Origin = 'V_VSLT_TARIF.PRIX_ACHAT_CATALOGUE'
      Precision = 18
      Size = 3
    end
    object dSetCataloguesREMISE_SIMPLE: TUIBBCDField
      DisplayLabel = 'Remise'
      FieldName = 'REMISE_SIMPLE'
      Origin = 'V_VSLT_TARIF.REMISE_SIMPLE'
      Precision = 9
      Size = 2
    end
    object dSetCataloguesPRIX_ACHAT_REMISE: TUIBBCDField
      DisplayLabel = 'PA Remis'#233
      FieldName = 'PRIX_ACHAT_REMISE'
      Origin = 'V_VSLT_TARIF.PRIX_ACHAT_REMISE'
      Precision = 18
      Size = 3
    end
  end
  object dSetProduitsLPP: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_produit_id,'
      '       type_code,'
      '       code_lpp,'
      '       quantite,'
      '       tarif_unitaire,'
      '       prestation,'
      '       service_tips'
      'from v_vslt_produit_lpp'
      'where t_produit_id = :APRODUITID')
    Left = 512
    Top = 40
    object dSetProduitsLPPT_PRODUIT_ID: TWideStringField
      FieldName = 'T_PRODUIT_ID'
      Origin = 'V_VSLT_PRODUIT_LPP.T_PRODUIT_ID'
      Size = 50
    end
    object dSetProduitsLPPTYPE_CODE: TWideStringField
      FieldName = 'TYPE_CODE'
      Origin = 'V_VSLT_PRODUIT_LPP.TYPE_CODE'
      Size = 1
    end
    object dSetProduitsLPPCODE_LPP: TWideStringField
      DisplayLabel = 'Code LPP'
      FieldName = 'CODE_LPP'
      Origin = 'V_VSLT_PRODUIT_LPP.CODE_LPP'
      Size = 13
    end
    object dSetProduitsLPPQUANTITE: TIntegerField
      DisplayLabel = 'Nb unit'#233's'
      FieldName = 'QUANTITE'
      Origin = 'V_VSLT_PRODUIT_LPP.QUANTITE'
    end
    object dSetProduitsLPPTARIF_UNITAIRE: TUIBBCDField
      DisplayLabel = 'Tarif r'#233'f. unit.'
      FieldName = 'TARIF_UNITAIRE'
      Origin = 'V_VSLT_PRODUIT_LPP.TARIF_UNITAIRE'
      Precision = 18
      Size = 2
    end
    object dSetProduitsLPPPRESTATION: TWideStringField
      DisplayLabel = 'Prest.'
      FieldName = 'PRESTATION'
      Origin = 'V_VSLT_PRODUIT_LPP.PRESTATION'
      Size = 3
    end
    object dSetProduitsLPPSERVICE_TIPS: TWideStringField
      DisplayLabel = 'Service'
      FieldName = 'SERVICE_TIPS'
      Origin = 'V_VSLT_PRODUIT_LPP.SERVICE_TIPS'
      Size = 17
    end
  end
  object dSetLibellesCodifications: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select alibellecdf1,'
      '       alibellecdf2,'
      '       alibellecdf3,'
      '       alibellecdf4,'
      '       alibellecdf5'
      'from ps_vslt_renvoyer_libelles_cdfs')
    Left = 768
    Top = 136
  end
  object dSetFournisseurs: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  type_fournisseur,'
      '  type_fournisseur_libelle,'
      '  t_fournisseur_id,'
      '  raison_sociale,'
      '  identifiant_171,'
      '  numero_appel,'
      '  commentaire,'
      '  vitesse_171,'
      '  mode_transmission,'
      '  rue_1,'
      '  rue_2,'
      '  code_postal,'
      '  nom_ville,'
      '  code_postal_ville,'
      '  telephone,'
      '  tel_personnel,'
      '  tel_standard,'
      '  tel_mobile,'
      '  fax,'
      '  represente_par,'
      '  code_partenaire,'
      '  objectif_ca_mensuel,'
      '  defaut,'
      '  numero_fax,'
      '  id_pharmacie,'
      '  pharmaml_ref_id,'
      '  pharmaml_url_1,'
      '  pharmaml_url_2,'
      '  pharmaml_id_officine,'
      '  pharmaml_id_magasin,'
      '  pharmaml_cle'
      'from v_vslt_fournisseur'
      'where upper(raison_sociale) starting with upper(:ARAISONSOCIALE)')
    BeforeClose = dSetFournisseursBeforeClose
    AfterScroll = dSetFournisseursAfterScroll
    Left = 232
    Top = 80
    object dSetFournisseursTYPE_FOURNISSEUR: TWideStringField
      FieldName = 'TYPE_FOURNISSEUR'
      Origin = 'V_VSLT_FOURNISSEUR.TYPE_FOURNISSEUR'
      Size = 1
    end
    object dSetFournisseursTYPE_FOURNISSEUR_LIBELLE: TWideStringField
      DisplayLabel = 'Type de fournisseur'
      FieldName = 'TYPE_FOURNISSEUR_LIBELLE'
      Origin = 'V_VSLT_FOURNISSEUR.TYPE_FOURNISSEUR_LIBELLE'
      Size = 18
    end
    object dSetFournisseursT_FOURNISSEUR_ID: TWideStringField
      FieldName = 'T_FOURNISSEUR_ID'
      Origin = 'V_VSLT_FOURNISSEUR.T_FOURNISSEUR_ID'
      Size = 50
    end
    object dSetFournisseursRAISON_SOCIALE: TWideStringField
      DisplayLabel = 'Raison sociale'
      FieldName = 'RAISON_SOCIALE'
      Origin = 'V_VSLT_FOURNISSEUR.RAISON_SOCIALE'
      Size = 50
    end
    object dSetFournisseursIDENTIFIANT_171: TWideStringField
      FieldName = 'IDENTIFIANT_171'
      Origin = 'V_VSLT_FOURNISSEUR.IDENTIFIANT_171'
      Size = 8
    end
    object dSetFournisseursNUMERO_APPEL: TWideStringField
      FieldName = 'NUMERO_APPEL'
      Origin = 'V_VSLT_FOURNISSEUR.NUMERO_APPEL'
    end
    object dSetFournisseursCOMMENTAIRE: TWideStringField
      FieldName = 'COMMENTAIRE'
      Origin = 'V_VSLT_FOURNISSEUR.COMMENTAIRE'
      Size = 200
    end
    object dSetFournisseursVITESSE_171: TWideStringField
      FieldName = 'VITESSE_171'
      Origin = 'V_VSLT_FOURNISSEUR.VITESSE_171'
      Size = 1
    end
    object dSetFournisseursRUE_1: TWideStringField
      FieldName = 'RUE_1'
      Origin = 'V_VSLT_FOURNISSEUR.RUE_1'
      Size = 40
    end
    object dSetFournisseursRUE_2: TWideStringField
      FieldName = 'RUE_2'
      Origin = 'V_VSLT_FOURNISSEUR.RUE_2'
      Size = 40
    end
    object dSetFournisseursCODE_POSTAL: TWideStringField
      FieldName = 'CODE_POSTAL'
      Origin = 'V_VSLT_FOURNISSEUR.CODE_POSTAL'
      Size = 5
    end
    object dSetFournisseursNOM_VILLE: TWideStringField
      FieldName = 'NOM_VILLE'
      Origin = 'V_VSLT_FOURNISSEUR.NOM_VILLE'
      Size = 30
    end
    object dSetFournisseursCODE_POSTAL_VILLE: TWideStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Origin = 'V_VSLT_FOURNISSEUR.CODE_POSTAL_VILLE'
      Size = 36
    end
    object dSetFournisseursTEL_PERSONNEL: TWideStringField
      FieldName = 'TEL_PERSONNEL'
      Origin = 'V_VSLT_FOURNISSEUR.TEL_PERSONNEL'
    end
    object dSetFournisseursTEL_STANDARD: TWideStringField
      FieldName = 'TEL_STANDARD'
      Origin = 'V_VSLT_FOURNISSEUR.TEL_STANDARD'
    end
    object dSetFournisseursTEL_MOBILE: TWideStringField
      FieldName = 'TEL_MOBILE'
      Origin = 'V_VSLT_FOURNISSEUR.TEL_MOBILE'
    end
    object dSetFournisseursFAX: TWideStringField
      FieldName = 'FAX'
      Origin = 'V_VSLT_FOURNISSEUR.FAX'
    end
    object dSetFournisseursREPRESENTE_PAR: TWideStringField
      DisplayLabel = 'Repr'#233'sent'#233' par'
      FieldName = 'REPRESENTE_PAR'
      Origin = 'V_VSLT_FOURNISSEUR.REPRESENTE_PAR'
      Size = 50
    end
    object dSetFournisseursCODE_PARTENAIRE: TSmallintField
      FieldName = 'CODE_PARTENAIRE'
      Origin = 'V_VSLT_FOURNISSEUR.CODE_PARTENAIRE'
    end
    object dSetFournisseursOBJECTIF_CA_MENSUEL: TIntegerField
      FieldName = 'OBJECTIF_CA_MENSUEL'
      Origin = 'V_VSLT_FOURNISSEUR.OBJECTIF_CA_MENSUEL'
    end
    object dSetFournisseursDEFAUT: TWideStringField
      FieldName = 'DEFAUT'
      Origin = 'V_VSLT_FOURNISSEUR.DEFAUT'
      Size = 1
    end
    object dSetFournisseursNUMERO_FAX: TWideStringField
      FieldName = 'NUMERO_FAX'
      Origin = 'V_VSLT_FOURNISSEUR.NUMERO_FAX'
    end
    object dSetFournisseursID_PHARMACIE: TWideStringField
      FieldName = 'ID_PHARMACIE'
      Origin = 'V_VSLT_FOURNISSEUR.ID_PHARMACIE'
      Size = 10
    end
    object dSetFournisseursMODE_TRANSMISSION: TWideStringField
      DisplayLabel = 'Mode de trans.'
      FieldName = 'MODE_TRANSMISSION'
      Origin = 'V_VSLT_FOURNISSEUR.MODE_TRANSMISSION'
      Size = 13
    end
    object dSetFournisseursPHARMAML_REF_ID: TSmallintField
      FieldName = 'PHARMAML_REF_ID'
      Origin = 'V_VSLT_FOURNISSEUR.PHARMAML_REF_ID'
    end
    object dSetFournisseursPHARMAML_URL_1: TWideStringField
      FieldName = 'PHARMAML_URL_1'
      Origin = 'V_VSLT_FOURNISSEUR.PHARMAML_URL_1'
      Size = 150
    end
    object dSetFournisseursPHARMAML_URL_2: TWideStringField
      FieldName = 'PHARMAML_URL_2'
      Origin = 'V_VSLT_FOURNISSEUR.PHARMAML_URL_2'
      Size = 150
    end
    object dSetFournisseursPHARMAML_ID_OFFICINE: TWideStringField
      FieldName = 'PHARMAML_ID_OFFICINE'
      Origin = 'V_VSLT_FOURNISSEUR.PHARMAML_ID_OFFICINE'
    end
    object dSetFournisseursPHARMAML_ID_MAGASIN: TWideStringField
      FieldName = 'PHARMAML_ID_MAGASIN'
      Origin = 'V_VSLT_FOURNISSEUR.PHARMAML_ID_MAGASIN'
    end
    object dSetFournisseursPHARMAML_CLE: TWideStringField
      FieldName = 'PHARMAML_CLE'
      Origin = 'V_VSLT_FOURNISSEUR.PHARMAML_CLE'
      Size = 4
    end
    object dSetFournisseursTELEPHONE: TWideStringField
      FieldName = 'TELEPHONE'
      Origin = 'V_VSLT_FOURNISSEUR.TELEPHONE'
    end
  end
  object dSetProduitStock: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_produit_id,'
      '  quantite,'
      '  depot,'
      '  stock_mini,'
      '  stock_maxi,'
      '  zone_geographique'
      'from v_vslt_stock'
      'where t_produit_id = :APRODUITID')
    Left = 608
    Top = 36
    object dSetProduitStockT_PRODUIT_ID: TWideStringField
      FieldName = 'T_PRODUIT_ID'
      Origin = 'V_VSLT_STOCK.T_PRODUIT_ID'
      Size = 50
    end
    object dSetProduitStockQUANTITE: TIntegerField
      DisplayLabel = 'Stock'
      FieldName = 'QUANTITE'
      Origin = 'V_VSLT_STOCK.QUANTITE'
    end
    object dSetProduitStockSTOCK_MINI: TIntegerField
      DisplayLabel = 'Seuil mini'
      FieldName = 'STOCK_MINI'
      Origin = 'V_VSLT_STOCK.STOCK_MINI'
    end
    object dSetProduitStockSTOCK_MAXI: TIntegerField
      DisplayLabel = 'Seuil maxi'
      FieldName = 'STOCK_MAXI'
      Origin = 'V_VSLT_STOCK.STOCK_MAXI'
    end
    object dSetProduitStockZONE_GEOGRAPHIQUE: TWideStringField
      DisplayLabel = 'Zone g'#233'o.'
      FieldName = 'ZONE_GEOGRAPHIQUE'
      Origin = 'V_VSLT_STOCK.ZONE_GEOGRAPHIQUE'
      Size = 50
    end
    object dSetProduitStockDEPOT: TWideStringField
      DisplayLabel = 'D'#233'pot'
      FieldName = 'DEPOT'
      Origin = 'V_VSLT_STOCK.DEPOT'
      Size = 10
    end
  end
  object dSetCodifications: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_codification_id,'
      '  libelle,'
      '  taux_marque'
      'from v_vslt_codification'
      'where rang = :ARANG')
    Left = 352
    Top = 144
    object dSetCodificationsT_CODIFICATION_ID: TWideStringField
      DisplayLabel = 'Code'
      FieldName = 'T_CODIFICATION_ID'
      Size = 50
    end
    object dSetCodificationsLIBELLE: TWideStringField
      DisplayLabel = 'Libell'#233
      FieldName = 'LIBELLE'
      Origin = 'T_CODIFICATION.LIBELLE'
      Required = True
      Size = 50
    end
    object dSetCodificationsTAUX_MARQUE: TUIBBCDField
      DisplayLabel = 'Taux de marque'
      FieldName = 'TAUX_MARQUE'
      Origin = 'T_CODIFICATION.TAUX_MARQUE'
      Precision = 4
      Size = 3
    end
  end
  object dSetHistoriqueClient: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  numero_facture,'
      '  type_facturation,'
      '  date_acte,'
      '  praticien,'
      '  date_prescription,'
      '  t_client_id,'
      '  nom_client,'
      '  prenom_client,'
      '  nom_prenom_client,'
      '  code_operateur,'
      '  code_cip,'
      '  designation,'
      '  quantite_facturee,'
      '  prix_vente'
      'from v_vslt_historique_client'
      'where upper(nom_client) like upper(:ANOMCLIENT) || '#39'%'#39' and'
      '      upper(prenom_client) like upper(:APRENOMCLIENT) || '#39'%'#39' and'
      '      code_cip like :ACODECIP || '#39'%'#39
      '')
    Left = 264
    Top = 232
    object dSetHistoriqueClientNUMERO_FACTURE: TLargeintField
      DisplayLabel = 'Facture'
      FieldName = 'NUMERO_FACTURE'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.NUMERO_FACTURE'
    end
    object dSetHistoriqueClientTYPE_FACTURATION: TWideStringField
      DisplayLabel = 'Type'
      FieldName = 'TYPE_FACTURATION'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.TYPE_FACTURATION'
      Size = 2
    end
    object dSetHistoriqueClientDATE_ACTE: TDateField
      DisplayLabel = 'Date d'#233'liv.'
      FieldName = 'DATE_ACTE'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.DATE_ACTE'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetHistoriqueClientPRATICIEN: TWideStringField
      DisplayLabel = 'Praticien'
      FieldName = 'PRATICIEN'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.PRATICIEN'
      Size = 101
    end
    object dSetHistoriqueClientDATE_PRESCRIPTION: TDateField
      DisplayLabel = 'Prescription'
      FieldName = 'DATE_PRESCRIPTION'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.DATE_PRESCRIPTION'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetHistoriqueClientT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.T_CLIENT_ID'
      Size = 50
    end
    object dSetHistoriqueClientNOM_CLIENT: TWideStringField
      FieldName = 'NOM_CLIENT'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.NOM_CLIENT'
      Size = 30
    end
    object dSetHistoriqueClientPRENOM_CLIENT: TWideStringField
      FieldName = 'PRENOM_CLIENT'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.PRENOM_CLIENT'
      Size = 30
    end
    object dSetHistoriqueClientCODE_OPERATEUR: TWideStringField
      DisplayLabel = 'Op'#233'r.'
      FieldName = 'CODE_OPERATEUR'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.CODE_OPERATEUR'
      Size = 10
    end
    object dSetHistoriqueClientCODE_CIP: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'CODE_CIP'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.CODE_CIP'
      Size = 7
    end
    object dSetHistoriqueClientDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.DESIGNATION'
      Size = 50
    end
    object dSetHistoriqueClientQUANTITE_FACTUREE: TIntegerField
      DisplayLabel = 'Qt'#233
      FieldName = 'QUANTITE_FACTUREE'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.QUANTITE_FACTUREE'
    end
    object dSetHistoriqueClientPRIX_VENTE: TUIBBCDField
      DisplayLabel = 'PV TTC'
      FieldName = 'PRIX_VENTE'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.PRIX_VENTE'
      Precision = 18
      Size = 2
    end
    object dSetHistoriqueClientNOM_PRENOM_CLIENT: TWideStringField
      DisplayLabel = 'Client'
      FieldName = 'NOM_PRENOM_CLIENT'
      Origin = 'V_VSLT_HISTORIQUE_CLIENT.NOM_PRENOM_CLIENT'
      Size = 61
    end
  end
  object dSetCredits: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_client_id,'
      '       t_compte_id,'
      '       type_client,'
      '       type_client_libelle,'
      '       nom_client,'
      '       date_credit,'
      '       montant'
      'from v_vslt_credit'
      'where upper(nom_client) like upper(:ANOMCLIENT) || '#39'%'#39';')
    Left = 256
    Top = 288
    object dSetCreditsT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Origin = 'V_VSLT_CREDIT.T_CLIENT_ID'
      Size = 50
    end
    object dSetCreditsT_COMPTE_ID: TWideStringField
      FieldName = 'T_COMPTE_ID'
      Origin = 'V_VSLT_CREDIT.T_COMPTE_ID'
      Size = 50
    end
    object dSetCreditsTYPE_CLIENT: TWideStringField
      FieldName = 'TYPE_CLIENT'
      Origin = 'V_VSLT_CREDIT.TYPE_CLIENT'
      Size = 1
    end
    object dSetCreditsNOM_CLIENT: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM_CLIENT'
      Origin = 'V_VSLT_CREDIT.NOM_CLIENT'
      Size = 61
    end
    object dSetCreditsDATE_CREDIT: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_CREDIT'
      Origin = 'V_VSLT_CREDIT.DATE_CREDIT'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetCreditsTYPE_CLIENT_LIBELLE: TWideStringField
      DisplayLabel = 'Type de client'
      FieldName = 'TYPE_CLIENT_LIBELLE'
      Origin = 'V_VSLT_CREDIT.TYPE_CLIENT_LIBELLE'
      Size = 18
    end
    object dSetCreditsMONTANT: TUIBBCDField
      DisplayLabel = 'Montant'
      FieldName = 'MONTANT'
      Origin = 'V_VSLT_CREDIT.MONTANT'
      Precision = 18
      Size = 2
    end
  end
  object dSetVignettesAvancees: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_client_id,'
      '  nom,'
      '  prenom,'
      '  code_cip,'
      '  designation,'
      '  quantite_avancee,'
      '  prix_vente,'
      '  date_avance'
      'from v_vslt_vignette_avancee'
      'where upper(nom) like upper(:ANOM) || '#39'%'#39
      '  and upper(prenom) like upper(:APRENOM) || '#39'%'#39)
    Left = 368
    Top = 288
    object dSetVignettesAvanceesT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.T_CLIENT_ID'
      Size = 50
    end
    object dSetVignettesAvanceesNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.NOM'
      Size = 30
    end
    object dSetVignettesAvanceesPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.PRENOM'
      Size = 30
    end
    object dSetVignettesAvanceesCODE_CIP: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'CODE_CIP'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.CODE_CIP'
      Size = 7
    end
    object dSetVignettesAvanceesDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.DESIGNATION'
      Size = 50
    end
    object dSetVignettesAvanceesQUANTITE_AVANCEE: TIntegerField
      DisplayLabel = 'Qt'#233
      FieldName = 'QUANTITE_AVANCEE'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.QUANTITE_AVANCEE'
    end
    object dSetVignettesAvanceesPRIX_VENTE: TUIBBCDField
      DisplayLabel = 'PV TTC'
      FieldName = 'PRIX_VENTE'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.PRIX_VENTE'
      Precision = 18
      Size = 2
    end
    object dSetVignettesAvanceesDATE_AVANCE: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_AVANCE'
      Origin = 'V_VSLT_VIGNETTE_AVANCEE.DATE_AVANCE'
      DisplayFormat = 'DD/MM/YYYY'
    end
  end
  object dSetHistoriqueVentes: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select first 24'
      '  case'
      '    when AMois = 1 then '#39'jan.'#39
      '    when AMois = 2 then '#39'f'#233'v.'#39
      '    when AMois = 3 then '#39'mar.'#39
      '    when AMois = 4 then '#39'avr.'#39
      '    when AMois = 5 then '#39'mai'#39
      '    when AMois = 6 then '#39'juin'#39
      '    when AMois = 7 then '#39'juil.'#39
      '    when AMois = 8 then '#39'aou.'#39
      '    when AMois = 9 then '#39'sep.'#39
      '    when AMois = 10 then '#39'oct.'#39
      '    when AMois = 11 then '#39'nov.'#39
      '    when AMois = 11 then '#39'd'#233'c.'#39
      '  end || ascii_char(13) ||  ascii_char(10) || AAnnee APeriode,'
      '  AQuantiteVendues'
      'from ps_vslt_renvoyer_histo_ventes(:AProduitID)')
    Left = 576
    Top = 152
    object dSetHistoriqueVentesAPERIODE: TWideStringField
      FieldName = 'APERIODE'
      Origin = '.'
      Size = 17
    end
    object dSetHistoriqueVentesAQUANTITEVENDUES: TIntegerField
      FieldName = 'AQUANTITEVENDUES'
      Origin = 'PS_VSLT_RENVOYER_HISTO_VENTES.AQUANTITEVENDUES'
    end
  end
  object dSetHistoriqueAchats: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select first 24'
      '  case'
      '    when AMois = 1 then '#39'jan.'#39
      '    when AMois = 2 then '#39'f'#233'v.'#39
      '    when AMois = 3 then '#39'mar.'#39
      '    when AMois = 4 then '#39'avr.'#39
      '    when AMois = 5 then '#39'mai'#39
      '    when AMois = 6 then '#39'juin'#39
      '    when AMois = 7 then '#39'juil.'#39
      '    when AMois = 8 then '#39'aou.'#39
      '    when AMois = 9 then '#39'sep.'#39
      '    when AMois = 10 then '#39'oct.'#39
      '    when AMois = 11 then '#39'nov.'#39
      '    when AMois = 11 then '#39'd'#233'c.'#39
      '  end ||  ascii_char(13) ||  ascii_char(10) || AAnnee APeriode,'
      '  AQuantiteRecues'
      'from ps_vslt_renvoyer_histo_achats(:AProduitID)')
    Left = 576
    Top = 200
    object dSetHistoriqueAchatsAPERIODE: TWideStringField
      FieldName = 'APERIODE'
      Origin = '.'
      Size = 18
    end
    object dSetHistoriqueAchatsAQUANTITERECUES: TIntegerField
      FieldName = 'AQUANTITERECUES'
      Origin = 'PS_VSLT_RENVOYER_HISTO_ACHATS.AQUANTITERECUES'
    end
  end
  object dSetCommandesEnCours: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_commande_id,'
      '  raison_sociale,'
      '  quantite_commandee,'
      '  date_creation,'
      '  trim(mode_transmission) mode_transmission,'
      '  code_cip,'
      '  designation,'
      '  quantite_totale_recue,'
      '  prix_achat_tarif,'
      '  prix_achat_remise,'
      '  prix_vente,'
      '  montant_ht'
      'from v_vslt_commandes_en_cours'
      'where raison_sociale like :ARAISONSOCIALE || '#39'%'#39
      'order by t_commande_id')
    Left = 568
    Top = 248
    object dSetCommandesEnCoursRAISON_SOCIALE: TWideStringField
      DisplayLabel = 'Raison sociale'
      FieldName = 'RAISON_SOCIALE'
      Origin = 'V_VSLT_COMMANDES_EN_COURS.RAISON_SOCIALE'
      Size = 50
    end
    object dSetCommandesEnCoursQUANTITE_COMMANDEE: TIntegerField
      DisplayLabel = 'Qt'#233
      FieldName = 'QUANTITE_COMMANDEE'
      Origin = 'V_VSLT_COMMANDES_EN_COURS.QUANTITE_COMMANDEE'
    end
    object dSetCommandesEnCoursDATE_CREATION: TDateField
      DisplayLabel = 'Date cr'#233'ation'
      FieldName = 'DATE_CREATION'
      Origin = 'V_VSLT_COMMANDES_EN_COURS.DATE_CREATION'
    end
    object dSetCommandesEnCoursMODE_TRANSMISSION: TWideStringField
      FieldName = 'MODE_TRANSMISSION'
      Size = 13
    end
    object dSetCommandesEnCoursCODE_CIP: TWideStringField
      FieldName = 'CODE_CIP'
      Size = 7
    end
    object dSetCommandesEnCoursDESIGNATION: TWideStringField
      FieldName = 'DESIGNATION'
      Size = 50
    end
    object dSetCommandesEnCoursQUANTITE_TOTALE_RECUE: TIntegerField
      FieldName = 'QUANTITE_TOTALE_RECUE'
    end
    object dSetCommandesEnCoursPRIX_ACHAT_TARIF: TUIBBCDField
      FieldName = 'PRIX_ACHAT_TARIF'
      Precision = 18
      Size = 3
    end
    object dSetCommandesEnCoursPRIX_ACHAT_REMISE: TUIBBCDField
      FieldName = 'PRIX_ACHAT_REMISE'
      Precision = 18
      Size = 3
    end
    object dSetCommandesEnCoursPRIX_VENTE: TUIBBCDField
      FieldName = 'PRIX_VENTE'
      Precision = 18
      Size = 2
    end
    object dSetCommandesEnCoursMONTANT_HT: TUIBBCDField
      FieldName = 'MONTANT_HT'
      Size = 2
    end
  end
  object dSetListeAchats: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  raison_sociale,'
      '  prix_achat_tarif,'
      '  prix_achat_remise,'
      '  quantite_commandee,'
      '  quantite_recue,'
      '  quantite_a_recevoir,'
      '  t_commande_id,'
      '  date_creation,'
      '  etat'
      'from v_vslt_historiques_achats'
      'where t_produit_id = :APRODUITID')
    Left = 712
    Top = 200
    object dSetListeAchatsRAISON_SOCIALE: TWideStringField
      DisplayLabel = 'Raison sociale'
      FieldName = 'RAISON_SOCIALE'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.RAISON_SOCIALE'
      Size = 50
    end
    object dSetListeAchatsPRIX_ACHAT_TARIF: TUIBBCDField
      DisplayLabel = 'PA Tarif'
      FieldName = 'PRIX_ACHAT_TARIF'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.PRIX_ACHAT_TARIF'
      Precision = 18
      Size = 3
    end
    object dSetListeAchatsPRIX_ACHAT_REMISE: TUIBBCDField
      DisplayLabel = 'PA Remis'#233
      FieldName = 'PRIX_ACHAT_REMISE'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.PRIX_ACHAT_REMISE'
      Precision = 18
      Size = 3
    end
    object dSetListeAchatsQUANTITE_COMMANDEE: TIntegerField
      DisplayLabel = 'Qt'#233' com.'
      FieldName = 'QUANTITE_COMMANDEE'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.QUANTITE_COMMANDEE'
    end
    object dSetListeAchatsQUANTITE_RECUE: TIntegerField
      DisplayLabel = 'Qt'#233' re'#231'.'
      FieldName = 'QUANTITE_RECUE'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.QUANTITE_RECUE'
    end
    object dSetListeAchatsQUANTITE_A_RECEVOIR: TLargeintField
      DisplayLabel = 'A re'#231'.'
      FieldName = 'QUANTITE_A_RECEVOIR'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.QUANTITE_A_RECEVOIR'
    end
    object dSetListeAchatsT_COMMANDE_ID: TWideStringField
      DisplayLabel = 'Commande'
      FieldName = 'T_COMMANDE_ID'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.T_COMMANDE_ID'
      Size = 50
    end
    object dSetListeAchatsDATE_CREATION: TDateField
      DisplayLabel = 'Date cr'#233'ation'
      FieldName = 'DATE_CREATION'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.DATE_CREATION'
    end
    object dSetListeAchatsETAT: TWideStringField
      DisplayLabel = 'Etat'
      FieldName = 'ETAT'
      Origin = 'V_VSLT_HISTORIQUES_ACHATS.ETAT'
      Size = 2
    end
  end
  object dSetHistoAchats1: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select first 12'
      '  case'
      '    when AMois = 1 then '#39'jan.'#39
      '    when AMois = 2 then '#39'f'#233'v.'#39
      '    when AMois = 3 then '#39'mar.'#39
      '    when AMois = 4 then '#39'avr.'#39
      '    when AMois = 5 then '#39'mai'#39
      '    when AMois = 6 then '#39'juin'#39
      '    when AMois = 7 then '#39'juil.'#39
      '    when AMois = 8 then '#39'aou.'#39
      '    when AMois = 9 then '#39'sep.'#39
      '    when AMois = 10 then '#39'oct.'#39
      '    when AMois = 11 then '#39'nov.'#39
      '    when AMois = 12 then '#39'd'#233'c.'#39
      '  end AAbrMois,'
      '  AQuantiteRecues'
      'from ps_vslt_renvoyer_histo_achats(:APRODUITID)'
      'order by AAnnee desc, AMois desc')
    Left = 712
    Top = 248
    object dSetHistoAchats1AABRMOIS: TWideStringField
      FieldName = 'AABRMOIS'
      Origin = '.'
      Size = 5
    end
    object dSetHistoAchats1AQUANTITERECUES: TIntegerField
      FieldName = 'AQUANTITERECUES'
      Origin = 'PS_VSLT_RENVOYER_HISTO_ACHATS.AQUANTITERECUES'
    end
  end
  object dSetHistoAchats2: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select first 24 skip 12'
      '  case'
      '    when AMois = 1 then '#39'jan.'#39
      '    when AMois = 2 then '#39'f'#233'v.'#39
      '    when AMois = 3 then '#39'mar.'#39
      '    when AMois = 4 then '#39'avr.'#39
      '    when AMois = 5 then '#39'mai'#39
      '    when AMois = 6 then '#39'juin'#39
      '    when AMois = 7 then '#39'juil.'#39
      '    when AMois = 8 then '#39'aou.'#39
      '    when AMois = 9 then '#39'sep.'#39
      '    when AMois = 10 then '#39'oct.'#39
      '    when AMois = 11 then '#39'nov.'#39
      '    when AMois = 12 then '#39'd'#233'c.'#39
      '  end AAbrMois,'
      '  AQuantiteRecues'
      'from ps_vslt_renvoyer_histo_achats(:APRODUITID)'
      'order by AAnnee desc, AMois desc')
    Left = 712
    Top = 304
    object dSetHistoAchats2AABRMOIS: TWideStringField
      FieldName = 'AABRMOIS'
      Origin = '.'
      Size = 5
    end
    object dSetHistoAchats2AQUANTITERECUES: TIntegerField
      FieldName = 'AQUANTITERECUES'
      Origin = 'PS_VSLT_RENVOYER_HISTO_ACHATS.AQUANTITERECUES'
    end
  end
  object dSetPromotions: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_promotion_id,'
      '  libelle,'
      '  type_promotion,'
      '  commentaire,'
      '  date_debut,'
      '  date_fin,'
      '  date_creation,'
      '  date_derniere_maj'
      'from v_vslt_promotion'
      'where t_promotion_id = (select t_promotion_id'
      '                        from v_vslt_panier_promotion'
      '                        where t_produit_id = :APRODUITID)'
      '   or libelle like :ALIBELLE || '#39'%'#39)
    BeforeClose = dSetPromotionsBeforeClose
    AfterScroll = dSetPromotionsAfterScroll
    Left = 672
    Top = 376
    object dSetPromotionsT_PROMOTION_ID: TWideStringField
      FieldName = 'T_PROMOTION_ID'
      Origin = 'V_VSLT_PROMOTION.T_PROMOTION_ID'
      Size = 50
    end
    object dSetPromotionsLIBELLE: TWideStringField
      DisplayLabel = 'Lib'#233'll'#233' de la promotion'
      FieldName = 'LIBELLE'
      Origin = 'V_VSLT_PROMOTION.LIBELLE'
      Size = 30
    end
    object dSetPromotionsCOMMENTAIRE: TWideStringField
      FieldName = 'COMMENTAIRE'
      Origin = 'V_VSLT_PROMOTION.COMMENTAIRE'
      Size = 200
    end
    object dSetPromotionsDATE_DEBUT: TDateField
      Alignment = taCenter
      DisplayLabel = 'D'#233'but le'
      FieldName = 'DATE_DEBUT'
      Origin = 'V_VSLT_PROMOTION.DATE_DEBUT'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetPromotionsDATE_FIN: TDateField
      Alignment = taCenter
      DisplayLabel = 'Fin le'
      FieldName = 'DATE_FIN'
      Origin = 'V_VSLT_PROMOTION.DATE_FIN'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetPromotionsDATE_CREATION: TDateField
      Alignment = taCenter
      FieldName = 'DATE_CREATION'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetPromotionsDATE_DERNIERE_MAJ: TDateField
      Alignment = taCenter
      FieldName = 'DATE_DERNIERE_MAJ'
      Origin = 'V_VSLT_PROMOTION.DATE_DERNIERE_MAJ'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object dSetPromotionsTYPE_PROMOTION: TWideStringField
      DisplayLabel = 'Type de promotion'
      FieldName = 'TYPE_PROMOTION'
      Origin = 'V_VSLT_PROMOTION.TYPE_PROMOTION'
      Size = 32
    end
  end
  object dSetPanierPromotion: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_promotion_id,'
      '  designation,'
      '  declencheur,'
      '  quantite,'
      '  stock_alerte,'
      '  prix_vente'
      'from v_vslt_panier_promotion'
      'where t_promotion_id = :APROMOTIONID')
    Left = 768
    Top = 376
    object dSetPanierPromotionT_PROMOTION_ID: TWideStringField
      FieldName = 'T_PROMOTION_ID'
      Origin = 'V_VSLT_PANIER_PROMOTION.T_PROMOTION_ID'
      Size = 50
    end
    object dSetPanierPromotionDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Origin = 'V_VSLT_PANIER_PROMOTION.DESIGNATION'
      Size = 50
    end
    object dSetPanierPromotionDECLENCHEUR: TWideStringField
      FieldName = 'DECLENCHEUR'
      Origin = 'V_VSLT_PANIER_PROMOTION.DECLENCHEUR'
      Required = True
      Size = 1
    end
    object dSetPanierPromotionQUANTITE: TIntegerField
      DisplayLabel = 'Quantit'#233
      FieldName = 'QUANTITE'
      Origin = 'V_VSLT_PANIER_PROMOTION.QUANTITE'
    end
    object dSetPanierPromotionSTOCK_ALERTE: TIntegerField
      DisplayLabel = 'Stock alerte'
      FieldName = 'STOCK_ALERTE'
    end
    object dSetPanierPromotionPRIX_VENTE: TUIBBCDField
      DisplayLabel = 'PV TTC'
      FieldName = 'PRIX_VENTE'
      Origin = 'V_VSLT_PANIER_PROMOTION.PRIX_VENTE'
      Precision = 18
      Size = 2
    end
  end
  object dSetProduitsDus: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_client_id,'
      '  numero_insee,'
      '  nom,'
      '  prenom,'
      '  date_du,'
      '  quantite,'
      '  code_cip,'
      '  designation,'
      '  prix_vente'
      'from v_vslt_produit_du'
      'where nom like :ANOM || '#39'%'#39
      '  and prenom like :APRENOM || '#39'%'#39)
    Left = 488
    Top = 288
    object dSetProduitsDusT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Size = 50
    end
    object dSetProduitsDusNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 30
    end
    object dSetProduitsDusPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Size = 30
    end
    object dSetProduitsDusCODE_CIP: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'CODE_CIP'
      Size = 7
    end
    object dSetProduitsDusDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Size = 50
    end
    object dSetProduitsDusPRIX_VENTE: TUIBBCDField
      DisplayLabel = 'PV TTC'
      FieldName = 'PRIX_VENTE'
      Precision = 18
      Size = 2
    end
    object dSetProduitsDusDATE_DU: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_DU'
    end
    object dSetProduitsDusNUMERO_INSEE: TWideStringField
      DisplayLabel = 'N'#176' INSEE'
      FieldName = 'NUMERO_INSEE'
      EditMask = '0 00 00 000 000 00 - 00;0;_'
      Size = 15
    end
    object dSetProduitsDusQUANTITE: TIntegerField
      DisplayLabel = 'Qt'#233
      FieldName = 'QUANTITE'
    end
  end
  object dSetFacturesAttentes: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  T_FACTURE_ATTENTE_ID,'
      '  NOM_CLIENT,'
      '  PRENOM_CLIENT,'
      '  ASSURE,'
      '  RUE_1,'
      '  CODE_POSTAL_VILLE,'
      '  DATE_ACTE,'
      '  CODE_CIP,'
      '  DESIGNATION,'
      '  QUANTITE_FACTUREE,'
      '  PRESTATION,'
      '  PRIX_VENTE,'
      '  PRIX_ACHAT'
      'from'
      '  v_vslt_facture_attente'
      'where upper(nom_client) like upper(:ANOM) || '#39'%'#39
      '  and upper(prenom_client) like upper(:APRENOM) || '#39'%'#39
      'order by'
      '  t_facture_attente_id')
    Left = 160
    Top = 296
    object dSetFacturesAttentesNOM_CLIENT: TWideStringField
      FieldName = 'NOM_CLIENT'
      Size = 50
    end
    object dSetFacturesAttentesPRENOM_CLIENT: TWideStringField
      FieldName = 'PRENOM_CLIENT'
      Size = 50
    end
    object dSetFacturesAttentesASSURE: TWideStringField
      FieldName = 'ASSURE'
      Size = 101
    end
    object dSetFacturesAttentesRUE_1: TWideStringField
      FieldName = 'RUE_1'
      Size = 40
    end
    object dSetFacturesAttentesCODE_POSTAL_VILLE: TWideStringField
      DisplayWidth = 36
      FieldName = 'CODE_POSTAL_VILLE'
      Size = 36
    end
    object dSetFacturesAttentesDATE_ACTE: TDateField
      FieldName = 'DATE_ACTE'
    end
    object dSetFacturesAttentesCODE_CIP: TWideStringField
      FieldName = 'CODE_CIP'
      Size = 7
    end
    object dSetFacturesAttentesDESIGNATION: TWideStringField
      FieldName = 'DESIGNATION'
      Size = 50
    end
    object dSetFacturesAttentesQUANTITE_FACTUREE: TIntegerField
      FieldName = 'QUANTITE_FACTUREE'
    end
    object dSetFacturesAttentesPRESTATION: TWideStringField
      FieldName = 'PRESTATION'
      Size = 3
    end
    object dSetFacturesAttentesT_FACTURE_ATTENTE_ID: TWideStringField
      FieldName = 'T_FACTURE_ATTENTE_ID'
      Size = 50
    end
    object dSetFacturesAttentesPRIX_ACHAT: TUIBBCDField
      FieldName = 'PRIX_ACHAT'
      Precision = 18
      Size = 3
    end
    object dSetFacturesAttentesPRIX_VENTE: TUIBBCDField
      FieldName = 'PRIX_VENTE'
      Precision = 18
      Size = 2
    end
  end
  object dSetProduitsExclusifs: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select code_cip,'
      '       designation'
      'from t_produit'
      'where t_repartiteur_id = :AREPARTITEURID')
    Left = 352
    Top = 80
    object dSetProduitsExclusifsCODE_CIP: TWideStringField
      DisplayLabel = 'CIP'
      FieldName = 'CODE_CIP'
      Size = 7
    end
    object dSetProduitsExclusifsDESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'DESIGNATION'
      Size = 50
    end
  end
  object dSetAvantagePromo: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  t_promotion_id,'
      '  a_partir_de,'
      '  type_avantage_promo,'
      '  val_avantage'
      'from v_vslt_avantage_promotion'
      'where t_promotion_id = :APROMOTIONID')
    Left = 768
    Top = 424
    object dSetAvantagePromoT_PROMOTION_ID: TWideStringField
      FieldName = 'T_PROMOTION_ID'
      Origin = 'V_VSLT_AVANTAGE_PROMOTION.T_PROMOTION_ID'
      Size = 50
    end
    object dSetAvantagePromoA_PARTIR_DE: TIntegerField
      FieldName = 'A_PARTIR_DE'
      Origin = 'V_VSLT_AVANTAGE_PROMOTION.A_PARTIR_DE'
    end
    object dSetAvantagePromoTYPE_AVANTAGE_PROMO: TWideStringField
      FieldName = 'TYPE_AVANTAGE_PROMO'
      Origin = 'V_VSLT_AVANTAGE_PROMOTION.TYPE_AVANTAGE_PROMO'
      Size = 43
    end
    object dSetAvantagePromoVAL_AVANTAGE: TUIBBCDField
      FieldName = 'VAL_AVANTAGE'
      Origin = 'V_VSLT_AVANTAGE_PROMOTION.VAL_AVANTAGE'
      Precision = 18
      Size = 2
    end
  end
  object qryCreerVuesCouvertures: TUIBQuery
    SQL.Strings = (
      'execute procedure ps_vslt_creer_vue_couvertures')
    Transaction = trPHA
    Left = 456
    Top = 216
  end
  object dsetCollectivites: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select nom'
      'from v_vslt_collectivite'
      'where t_client_id = :AIDCLIENT'
      ''
      '')
    Left = 24
    Top = 200
  end
  object dsetAdherent: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select '
      'nom,'
      'prenom,'
      'date_naissance,'
      'qualite'
      'from v_vslt_adherent'
      'where t_compte_id = :AIDCLIENT'
      ''
      '')
    Left = 24
    Top = 256
  end
  object dSetCarteFiClient: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select '
      'libelle,'
      'encours_initial,'
      'encours_ca,'
      'date_fin_validite'
      'from v_vslt_prog_avantage_client'
      'where t_client_id = :AIDCLIENT'
      ''
      '')
    Left = 120
    Top = 96
    object dSetCarteFiClientLIBELLE: TWideStringField
      FieldName = 'LIBELLE'
    end
    object dSetCarteFiClientENCOURS_INITIAL: TBCDField
      FieldName = 'ENCOURS_INITIAL'
      Size = 2
    end
    object dSetCarteFiClientENCOURS_CA: TBCDField
      FieldName = 'ENCOURS_CA'
      Size = 2
    end
    object dSetCarteFiClientDATE_FIN_VALIDITE: TDateField
      FieldName = 'DATE_FIN_VALIDITE'
    end
  end
  object dSetDocumentClient: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_document_id, t_entite_id, document'
      'from v_vslt_document_client'
      'where t_entite_id = :AIDCLIENT')
    Left = 112
    Top = 176
    object dSetDocumentClientT_DOCUMENT_ID: TIntegerField
      FieldName = 'T_DOCUMENT_ID'
    end
    object dSetDocumentClientT_ENTITE_ID: TWideStringField
      FieldName = 'T_ENTITE_ID'
      Origin = 'V_VSLT_CLIENT.T_ENTITE_ID'
      Size = 50
    end
    object dSetDocumentClientDOCUMENT: TWideStringField
      FieldName = 'DOCUMENT'
      Size = 1024
    end
  end
end
