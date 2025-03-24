inherited dmModuleImportPHA: TdmModuleImportPHA
  object setFichiersManquants: TFBDataSet
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = [ukModify]
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select atypefichier,'
      '       afichier,'
      '       adateheure,'
      '       arequis,'
      '       apresence,'
      '       avalidationabsence,'
      '       acommentaire'
      'from ps_verifier_fichiers(:AREPERTOIRE)')
    SQLEdit.Strings = (
      'execute procedure ps_valider_absence_fichier('
      '  :ATYPEFICHIER, :AFICHIER, :AVALIDATIONABSENCE)')
    Left = 280
    Top = 16
    object setFichiersManquantsAFICHIER: TFBAnsiField
      DisplayLabel = 'Nom du fichier'
      FieldName = 'AFICHIER'
      ReadOnly = True
      Size = 255
    end
    object setFichiersManquantsADATEHEURE: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Date/Heure'
      FieldName = 'ADATEHEURE'
      ReadOnly = True
      DisplayFormat = 'DD/MM/YYYY hh:nn'
    end
    object setFichiersManquantsAREQUIS: TStringField
      DisplayLabel = 'Requis ?'
      FieldName = 'AREQUIS'
      ReadOnly = True
      Size = 1
    end
    object setFichiersManquantsAPRESENCE: TStringField
      DisplayLabel = 'Pr'#233'sent ?'
      FieldName = 'APRESENCE'
      ReadOnly = True
      Size = 1
    end
    object setFichiersManquantsAVALIDATIONABSENCE: TStringField
      DisplayLabel = 'Validation absence'
      FieldName = 'AVALIDATIONABSENCE'
      Size = 1
    end
    object setFichiersManquantsACOMMENTAIRE: TFBAnsiField
      DisplayLabel = 'Description'
      FieldName = 'ACOMMENTAIRE'
      Size = 200
    end
    object setFichiersManquantsATYPEFICHIER: TFBAnsiField
      FieldName = 'ATYPEFICHIER'
      Size = 2
    end
  end
  object setConversionsOrganismesAMO: TFBDataSet
    BeforeOpen = setConversionsOrganismesAMOBeforeOpen
    BeforeClose = setConversionsOrganismesAMOBeforeClose
    AfterPost = setConversionsOrgCouvAMOAfterPost
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = [ukModify]
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified]
    SQLSelect.Strings = (
      'select t_organisme_amo_id,'
      '       nom,'
      '       nom_reduit,'
      '       t_ref_organisme_amo_id,'
      '       sans_centre_gestionnaire,'
      '       identifiant_national,'
      '       rue_1,'
      '       rue_2,'
      '       code_postal_ville,'
      '       code_postal,'
      '       nom_ville,'
      '       commentaire,'
      '       repris,'
      '       nombre_clients'
      'from v_cnv_organisme_amo'
      'order by repris desc,'
      '         t_ref_organisme_amo_id')
    SQLRefresh.Strings = (
      'select t_organisme_amo_id,'
      '       nom,'
      '       nom_reduit,'
      '       t_ref_organisme_amo_id,'
      '       sans_centre_gestionnaire,'
      '       identifiant_national,'
      '       rue_1,'
      '       rue_2,'
      '       code_postal_ville,'
      '       code_postal,'
      '       nom_ville,'
      '       commentaire,'
      '       repris'
      'from v_organisme_amo'
      'where t_organisme_amo_id = :T_ORGANISME_AMO_ID')
    SQLEdit.Strings = (
      'execute procedure ps_maj_organisme_amo('
      '  :T_ORGANISME_AMO_ID,'
      '  :REPRIS,'
      '  :IDENTIFIANT_NATIONAL)')
    Left = 128
    Top = 200
    object setConversionsOrganismesAMONOM: TFBAnsiField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      ReadOnly = True
      Size = 50
    end
    object setConversionsOrganismesAMONOM_REDUIT: TFBAnsiField
      FieldName = 'NOM_REDUIT'
      ReadOnly = True
    end
    object setConversionsOrganismesAMOT_REF_ORGANISME_AMO_ID: TIntegerField
      FieldName = 'T_REF_ORGANISME_AMO_ID'
      ReadOnly = True
    end
    object setConversionsOrganismesAMOSANS_CENTRE_GESTIONNAIRE: TFBAnsiField
      FieldName = 'SANS_CENTRE_GESTIONNAIRE'
      ReadOnly = True
      Size = 1
    end
    object setConversionsOrganismesAMOIDENTIFIANT_NATIONAL: TFBAnsiField
      DisplayLabel = 'Id. national'
      FieldName = 'IDENTIFIANT_NATIONAL'
      Size = 9
    end
    object setConversionsOrganismesAMORUE_1: TFBAnsiField
      FieldName = 'RUE_1'
      ReadOnly = True
      Size = 40
    end
    object setConversionsOrganismesAMORUE_2: TFBAnsiField
      FieldName = 'RUE_2'
      ReadOnly = True
      Size = 40
    end
    object setConversionsOrganismesAMOCODE_POSTAL_VILLE: TFBAnsiField
      DisplayLabel = 'CP / Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      ReadOnly = True
      Size = 36
    end
    object setConversionsOrganismesAMOCODE_POSTAL: TFBAnsiField
      FieldName = 'CODE_POSTAL'
      ReadOnly = True
      Size = 5
    end
    object setConversionsOrganismesAMONOM_VILLE: TFBAnsiField
      FieldName = 'NOM_VILLE'
      ReadOnly = True
      Size = 30
    end
    object setConversionsOrganismesAMOCOMMENTAIRE: TFBAnsiField
      FieldName = 'COMMENTAIRE'
      ReadOnly = True
      Size = 200
    end
    object setConversionsOrganismesAMOREPRIS: TStringField
      FieldName = 'REPRIS'
      Size = 1
    end
    object setConversionsOrganismesAMONOMBRE_CLIENTS: TIntegerField
      DisplayLabel = 'Nb. clients'
      FieldName = 'NOMBRE_CLIENTS'
      ReadOnly = True
    end
    object setConversionsOrganismesAMOT_ORGANISME_AMO_ID: TFBAnsiField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'T_ORGANISME_AMO_ID'
      ReadOnly = True
      Size = 50
    end
  end
  object setConversionsCouverturesAMO: TFBDataSet
    BeforeOpen = setConversionsCouverturesAMOBeforeOpen
    BeforeClose = setConversionsCouverturesAMOBeforeClose
    AfterPost = setConversionsOrgCouvAMOAfterPost
    AfterScroll = setConversionsCouverturesAMOAfterScroll
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = [ukModify]
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified]
    SQLSelect.Strings = (
      'select t_organisme_amo_id,'
      '       nom_organisme,'
      '       identifiant_national,'
      '       t_couverture_amo_id,'
      '       t_ref_couverture_amo_id,'
      '       libelle,'
      '       code_couverture,'
      '       nature_assurance,'
      '       ald,'
      '       justificatif_exo,'
      '       repris,'
      '       nombre_clients'
      'from v_cnv_couverture_amo'
      'order by repris desc,'
      '         t_ref_couverture_amo_id,'
      '         ald')
    SQLRefresh.Strings = (
      'select t_organisme_amo_id,'
      '       nom_organisme,'
      '       t_couverture_amo_id,'
      '       libelle,'
      '       code_couverture,'
      '       nature_assurance,'
      '       ald,'
      '       justificatif_exo,'
      '       repris'
      'from v_couverture_amo'
      'where t_couverture_amo_id = :T_COUVERTURE_AMO_ID')
    SQLEdit.Strings = (
      'execute procedure PS_MAJ_COUVERTURE_AMO('
      '  :T_COUVERTURE_AMO_ID,'
      '  :REPRIS,'
      '  :ALD,'
      '  :CODE_COUVERTURE)')
    Left = 168
    Top = 448
    object setConversionsCouverturesAMOT_ORGANISME_AMO_ID: TFBAnsiField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'T_ORGANISME_AMO_ID'
      ReadOnly = True
      Size = 50
    end
    object setConversionsCouverturesAMONOM_ORGANISME: TFBAnsiField
      DisplayLabel = 'Nom d'#39'organisme'
      FieldName = 'NOM_ORGANISME'
      ReadOnly = True
      Size = 50
    end
    object setConversionsCouverturesAMOT_COUVERTURE_AMO_ID: TFBAnsiField
      DisplayLabel = 'N'#176' de couverture'
      FieldName = 'T_COUVERTURE_AMO_ID'
      ReadOnly = True
      Size = 50
    end
    object setConversionsCouverturesAMOLIBELLE: TFBAnsiField
      DisplayLabel = 'Libell'#233
      FieldName = 'LIBELLE'
      ReadOnly = True
      Size = 50
    end
    object setConversionsCouverturesAMOCODE_COUVERTURE: TFBAnsiField
      DisplayLabel = 'Code SV'
      FieldName = 'CODE_COUVERTURE'
      Size = 50
    end
    object setConversionsCouverturesAMONATURE_ASSURANCE: TSmallintField
      DisplayLabel = 'Nat.'
      FieldName = 'NATURE_ASSURANCE'
      ReadOnly = True
    end
    object setConversionsCouverturesAMONOMBRE_CLIENTS: TIntegerField
      DisplayLabel = 'Nb. clients'
      FieldName = 'NOMBRE_CLIENTS'
      ReadOnly = True
    end
    object setConversionsCouverturesAMOREPRIS: TStringField
      FieldName = 'REPRIS'
      Size = 1
    end
    object setConversionsCouverturesAMOT_REF_COUVERTURE_AMO_ID: TIntegerField
      FieldName = 'T_REF_COUVERTURE_AMO_ID'
      ReadOnly = True
    end
    object setConversionsCouverturesAMOALD: TStringField
      FieldName = 'ALD'
      Size = 1
    end
    object setConversionsCouverturesAMOIDENTIFIANT_NATIONAL: TFBAnsiField
      FieldName = 'IDENTIFIANT_NATIONAL'
      Size = 9
    end
    object setConversionsCouverturesAMOJUSTIFICATIF_EXO: TStringField
      DisplayLabel = 'Exo.'
      FieldName = 'JUSTIFICATIF_EXO'
      ReadOnly = True
      Size = 1
    end
  end
  object setOrganismesAMORef: TUIBDataSet
    Transaction = trModuleImport
    OnClose = etmStayIn
    SQL.Strings = (
      'select t_ref_organisme_amo_id,'
      '       nom,'
      '       regime,'
      '       caisse_gestionnaire,'
      '       centre_gestionnaire,'
      '       code_postal,'
      '       nom_ville'
      'from v_ref_organisme_amo'
      'where nom like :ANOM || '#39'%'#39
      
        '   or (regime || caisse_gestionnaire || coalesce(centre_gestionn' +
        'aire, '#39#39')) like :AIDENTIFIANTNATIONAL || '#39'%'#39)
    Left = 168
    Top = 344
    object setOrganismesAMORefT_REF_ORGANISME_AMO_ID: TIntegerField
      FieldName = 'T_REF_ORGANISME_AMO_ID'
    end
    object setOrganismesAMORefNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 50
    end
    object setOrganismesAMORefREGIME: TWideStringField
      DisplayLabel = 'Reg.'
      FieldName = 'REGIME'
      Size = 2
    end
    object setOrganismesAMORefCAISSE_GESTIONNAIRE: TWideStringField
      DisplayLabel = 'Cais.'
      FieldName = 'CAISSE_GESTIONNAIRE'
      Size = 3
    end
    object setOrganismesAMORefCENTRE_GESTIONNAIRE: TWideStringField
      DisplayLabel = 'Ctr.'
      FieldName = 'CENTRE_GESTIONNAIRE'
      Size = 4
    end
    object setOrganismesAMORefCODE_POSTAL: TWideStringField
      DisplayLabel = 'CP'
      FieldName = 'CODE_POSTAL'
      Size = 5
    end
    object setOrganismesAMORefNOM_VILLE: TWideStringField
      DisplayLabel = 'Ville'
      FieldName = 'NOM_VILLE'
      Size = 30
    end
  end
  object setCouverturesAMORef: TUIBDataSet
    Transaction = trModuleImport
    OnClose = etmStayIn
    SQL.Strings = (
      'select *'
      'from ps_renvoyer_couvertures_ref(:AREGIME, :ACODECOUVERTURE)')
    Left = 40
    Top = 496
  end
  object setConversionsComptes: TFBDataSet
    BeforeOpen = setConversionsComptesBeforeOpen
    AfterPost = setConversionsOrgCouvAMOAfterPost
    MaxMEMOStringSize = 0
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.00'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified]
    SQLSelect.Strings = (
      'select'
      '  t_compte_id,'
      '  nom,'
      '  code_postal_ville,'
      '  collectif,'
      '  t_client_id,'
      '  nom_prenom_client,'
      '  nombre_adherents,'
      '  repris,'
      '  credit'
      'from v_cnv_compte'
      'order by nom')
    SQLRefresh.Strings = (
      'select'
      '  t_compte_id,'
      '  nom,'
      '  code_postal_ville,'
      '  collectif,'
      '  t_client_id,'
      '  nom_prenom_client,'
      '  nombre_adherents,'
      '  repris,'
      '  credit'
      'from v_cnv_compte'
      'where t_compte_id = :T_COMPTE_ID')
    SQLEdit.Strings = (
      'execute procedure PS_MAJ_COMPTE('
      '  :T_COMPTE_ID,'
      '  :REPRIS,'
      '  :COLLECTIF,'
      '  :T_CLIENT_ID)')
    Left = 416
    Top = 16
    object setConversionsComptesREPRIS: TStringField
      FieldName = 'REPRIS'
      Size = 1
    end
    object setConversionsComptesNOM: TFBAnsiField
      DisplayLabel = 'Nom du compte'
      FieldName = 'NOM'
      Size = 50
    end
    object setConversionsComptesCODE_POSTAL_VILLE: TFBAnsiField
      DisplayLabel = 'CP/ViIlle'
      FieldName = 'CODE_POSTAL_VILLE'
      Size = 36
    end
    object setConversionsComptesCOLLECTIF: TStringField
      FieldName = 'COLLECTIF'
      Size = 1
    end
    object setConversionsComptesNOM_PRENOM_CLIENT: TFBAnsiField
      DisplayLabel = 'Nom/pr'#233'nom du client attach'#233
      FieldName = 'NOM_PRENOM_CLIENT'
      Size = 101
    end
    object setConversionsComptesNOMBRE_ADHERENTS: TIntegerField
      DisplayLabel = 'Nb. adh.'
      FieldName = 'NOMBRE_ADHERENTS'
    end
    object setConversionsComptesT_COMPTE_ID: TFBAnsiField
      FieldName = 'T_COMPTE_ID'
      Visible = False
      Size = 59
    end
    object setConversionsComptesT_CLIENT_ID: TFBAnsiField
      FieldName = 'T_CLIENT_ID'
      Visible = False
      Size = 50
    end
    object setConversionsComptesCREDIT: TBCDField
      DisplayLabel = 'Cr'#233'dits'
      FieldName = 'CREDIT'
      Size = 2
    end
  end
  object trModuleImport: TUIBTransaction
    Left = 24
    Top = 120
  end
  object setListeClients: TUIBDataSet
    Transaction = trModuleImport
    OnClose = etmStayIn
    SQL.Strings = (
      'select distinct'
      '  t_client_id,'
      '  numero_insee,'
      '  nom,'
      '  prenom,'
      '  date_derniere_visite,'
      '  organisme_amo,'
      '  derniere_date_fin_droit_amo,'
      '  organisme_amc'
      'from v_liste_clients'
      'order by numero_insee')
    Left = 416
    Top = 152
    object setListeClientsT_CLIENT_ID: TWideStringField
      DisplayLabel = 'N'#176' dossier'
      FieldName = 'T_CLIENT_ID'
      Size = 59
    end
    object setListeClientsNUMERO_INSEE: TWideStringField
      DisplayLabel = 'N'#176' INSEE'
      FieldName = 'NUMERO_INSEE'
      EditMask = '0 00 00 000 000 00 - 00;0;_'
      Size = 15
    end
    object setListeClientsNOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 40
    end
    object setListeClientsPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM'
      Size = 40
    end
    object setListeClientsDERNIERE_DATE_FIN_DROIT_AMO: TDateField
      DisplayLabel = 'Dern. date fin droit AMO'
      FieldName = 'DERNIERE_DATE_FIN_DROIT_AMO'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object setListeClientsDATE_DERNIERE_VISITE: TDateField
      DisplayLabel = 'Date dern. visite'
      FieldName = 'DATE_DERNIERE_VISITE'
      DisplayFormat = 'DD/MM/YYYY'
    end
    object setListeClientsORGANISME_AMO: TWideStringField
      FieldName = 'ORGANISME_AMO'
      Size = 50
    end
    object setListeClientsORGANISME_AMC: TWideStringField
      FieldName = 'ORGANISME_AMC'
      Size = 50
    end
  end
  object setConversionsFournisseurs: TFBDataSet
    BeforeOpen = setConversionsFournisseursBeforeOpen
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = [ukModify]
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified]
    SQLSelect.Strings = (
      'select * '
      'from selectfournisseur'
      'order by acount desc')
    SQLRefresh.Strings = (
      'select * '
      'from selectfournisseur'
      'where afournisseur = :OLD_AFOURNISSEUR ')
    SQLEdit.Strings = (
      
        'execute procedure MAJFOURNISSEUR (:AFOURNISSEUR,:ATR_FOURNISSEUR' +
        ')')
    Left = 416
    Top = 216
    object setConversionsFournisseursAFOURNISSEUR: TFBAnsiField
      FieldName = 'AFOURNISSEUR'
      Origin = '"SELECTFOURNISSEUR"."AFOURNISSEUR"'
      ReadOnly = True
      Size = 50
    end
    object setConversionsFournisseursANUMAPB: TFBAnsiField
      DisplayWidth = 30
      FieldName = 'ANUMAPB'
      Origin = '"SELECTFOURNISSEUR"."ANUMAPB"'
      ReadOnly = True
      Size = 30
    end
    object setConversionsFournisseursANOM: TFBAnsiField
      FieldName = 'ANOM'
      Origin = '"SELECTFOURNISSEURR"."ANOM"'
      ReadOnly = True
      Size = 110
    end
    object setConversionsFournisseursARUE: TFBAnsiField
      FieldName = 'ARUE'
      Origin = '"SELECTFOURNISSEUR"."ARUE"'
      ReadOnly = True
      Size = 110
    end
    object setConversionsFournisseursACP: TFBAnsiField
      FieldName = 'ACP'
      Origin = '"SELECTFOURNISSEUR"."ACP"'
      ReadOnly = True
      Size = 30
    end
    object setConversionsFournisseursALOCALITE: TFBAnsiField
      FieldName = 'ALOCALITE'
      Origin = '"SELECTFOURNISSEUR"."ALOCALITE"'
      ReadOnly = True
      Size = 50
    end
    object setConversionsFournisseursATR_FOURNISSEUR: TFBAnsiField
      FieldName = 'ATR_FOURNISSEUR'
      Origin = '"SELECTFOURNISSEUR"."ATR_FOURNISSEUR"'
      Size = 35
    end
    object setConversionsFournisseursACOUNT: TIntegerField
      DisplayWidth = 30
      FieldName = 'ACOUNT'
      Origin = '"SELECTFOURNISSEUR"."ACOUNT"'
      ReadOnly = True
    end
  end
  object setConversionsRepartiteurs: TFBDataSet
    BeforeOpen = setConversionsCouverturesAMOBeforeOpen
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = [ukModify]
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified]
    SQLSelect.Strings = (
      'select * from selectrepartiteur'
      'order by ACOUNT desc')
    SQLRefresh.Strings = (
      'select * '
      'from selectrepartiteur'
      'where arepartiteur = :OLD_AREPARTITEUR')
    SQLEdit.Strings = (
      
        'execute procedure MAJREPARTITEUR (:AREPARTITEUR,:ATR_REPARTITEUR' +
        ')')
    Left = 544
    Top = 232
    object setConversionsRepartiteursAREPARTITEUR: TFBAnsiField
      FieldName = 'AREPARTITEUR'
      Origin = '"SELECTREPARTITEUR"."AREPARTITEUR"'
      ReadOnly = True
      Size = 50
    end
    object setConversionsRepartiteursANOM: TFBAnsiField
      FieldName = 'ANOM'
      Origin = '"SELECTREPARTITEUR"."ANOM"'
      ReadOnly = True
      Size = 110
    end
    object setConversionsRepartiteursARUE: TFBAnsiField
      FieldName = 'ARUE'
      Origin = '"SELECTREPARTITEUR"."ARUE"'
      ReadOnly = True
      Size = 110
    end
    object setConversionsRepartiteursACP: TFBAnsiField
      FieldName = 'ACP'
      Origin = '"SELECTREPARTITEUR"."ACP"'
      ReadOnly = True
      Size = 30
    end
    object setConversionsRepartiteursALOCALITE: TFBAnsiField
      FieldName = 'ALOCALITE'
      Origin = '"SELECTREPARTITEUR"."ALOCALITE"'
      ReadOnly = True
      Size = 50
    end
    object setConversionsRepartiteursATR_REPARTITEUR: TFBAnsiField
      FieldName = 'ATR_REPARTITEUR'
      Origin = '"SELECTREPARTITEUR"."ATR_REPARTITEUR"'
      Size = 35
    end
    object setConversionsRepartiteursACOUNT: TIntegerField
      FieldName = 'ACOUNT'
      Origin = '"SELECTREPARTITEUR"."ACOUNT"'
      ReadOnly = True
    end
  end
  object setFournisseursRef: TUIBDataSet
    Transaction = trModuleImport
    SQL.Strings = (
      'select * from RECHERCHEFOURNISSEUR')
    Left = 472
    Top = 336
    object IBStringField1: TWideStringField
      FieldName = 'CODE'
      Origin = '"RECHERCHEREPARTITEUR"."CODE"'
      ReadOnly = True
      Size = 10
    end
    object IBStringField2: TWideStringField
      FieldName = 'NOM'
      Origin = '"RECHERCHEREPARTITEUR"."NOM"'
      ReadOnly = True
      Size = 50
    end
    object IBStringField3: TWideStringField
      FieldName = 'RUE'
      Origin = '"RECHERCHEREPARTITEUR"."RUE"'
      ReadOnly = True
      Size = 40
    end
    object IBStringField5: TWideStringField
      FieldName = 'CODEPOSTAL'
      Origin = '"RECHERCHEREPARTITEUR"."CODEPOSTAL"'
      ReadOnly = True
      Size = 6
    end
    object IBStringField4: TWideStringField
      FieldName = 'LOCALITE'
      Origin = '"RECHERCHEREPARTITEUR"."LOCALITE"'
      ReadOnly = True
      Size = 40
    end
  end
  object setRepartiteursRef: TUIBDataSet
    Transaction = trModuleImport
    SQL.Strings = (
      'select * from RECHERCHEREPARTITEUR')
    Left = 328
    Top = 352
    object setRepartiteursRefCODE: TWideStringField
      FieldName = 'CODE'
      Origin = '"RECHERCHEREPARTITEUR"."CODE"'
      ReadOnly = True
      Size = 10
    end
    object setRepartiteursRefNOM: TWideStringField
      FieldName = 'NOM'
      Origin = '"RECHERCHEREPARTITEUR"."NOM"'
      ReadOnly = True
      Size = 50
    end
    object setRepartiteursRefRUE: TWideStringField
      FieldName = 'RUE'
      Origin = '"RECHERCHEREPARTITEUR"."RUE"'
      ReadOnly = True
      Size = 40
    end
    object setRepartiteursRefCODEPOSTAL: TWideStringField
      FieldName = 'CODEPOSTAL'
      Origin = '"RECHERCHEREPARTITEUR"."CODEPOSTAL"'
      ReadOnly = True
      Size = 6
    end
    object setRepartiteursRefLOCALITE: TWideStringField
      FieldName = 'LOCALITE'
      Origin = '"RECHERCHEREPARTITEUR"."LOCALITE"'
      ReadOnly = True
      Size = 40
    end
  end
  object setPrestations: TUIBDataSet
    Transaction = trModuleImport
    OnClose = etmStayIn
    SQL.Strings = (
      'select *'
      'from v_prestations_amo'
      'where t_couverture_amo_id = :T_COUVERTURE_AMO_ID')
    Left = 40
    Top = 448
  end
  object setConversionsReferenceAnalytiques: TFBDataSet
    BeforeOpen = setConversionsReferenceAnalytiquesBeforeOpen
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = [ukModify]
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost]
    RefreshTransactionKind = tkDefault
    Transaction = trModuleImport
    UpdateRecordTypes = [cusUnmodified, cusModified]
    SQLSelect.Strings = (
      'select * '
      'from selectreferenceanalytique')
    SQLRefresh.Strings = (
      'select * '
      'from selectreferenceanalytique'
      'where areferenceanalytique = :OLD_AREFERENCEANALYTIQUE')
    SQLEdit.Strings = (
      
        'execute procedure MAJreferenceanalytique (:Areferenceanalytique,' +
        ':ATR_referenceanalytique)')
    Left = 544
    Top = 160
    object setConversionsReferenceAnalytiquesAREFERENCEANALYTIQUE: TFBAnsiField
      FieldName = 'AREFERENCEANALYTIQUE'
      Origin = '"SELECTREFERENCEANALYTIQUE"."AREFERENCEANALYTIQUE"'
      ReadOnly = True
      Size = 50
    end
    object setConversionsReferenceAnalytiquesATR_REFERENCEANALYTIQUE: TFBAnsiField
      FieldName = 'ATR_REFERENCEANALYTIQUE'
      Origin = '"SELECTREFERENCEANALYTIQUE"."ATR_REFERENCEANALYTIQUE"'
      Size = 10
    end
  end
  object setReferenceAnalytiquesRef: TUIBDataSet
    Transaction = trModuleImport
    SQL.Strings = (
      'select * from RechercheREFERENCEANALYTIQUE')
    Left = 584
    Top = 312
    object REFERENCEANALYTIQUE: TWideStringField
      FieldName = 'REFERENCEANALYTIQUE'
      Origin = '"RechercheREFERENCEANALYTIQUE"."CODE"'
      ReadOnly = True
      Size = 10
    end
    object NOM: TWideStringField
      FieldName = 'NOM'
      Origin = '"RechercheREFERENCEANALYTIQUE"."NOM"'
      ReadOnly = True
      Size = 50
    end
  end
end
