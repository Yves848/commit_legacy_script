inherited dmOutilsPHAPHA_fr: TdmOutilsPHAPHA_fr
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 639
  Width = 880
  object setOrganismesAMC: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  AORGANISMEAMCID,'
      '  ANOM,'
      '  ANOMREDUIT,'
      '  AIDENTIFIANTNATIONAL,'
      '  ARUE1,'
      '  ARUE2,'
      '  ACODEPOSTALVILLE,'
      '  ACOMMENTAIRE'
      'from PS_UTL_PHA_ORGANISMES_AMC(:ATYPE, :APARAMETRE)'
      'order by ANom')
    Left = 40
    Top = 208
    object setOrganismesAMCAORGANISMEAMCID: TWideStringField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'AORGANISMEAMCID'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.AORGANISMEAMCID'
      Size = 50
    end
    object setOrganismesAMCANOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'ANOM'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.ANOM'
      Size = 50
    end
    object setOrganismesAMCANOMREDUIT: TWideStringField
      DisplayLabel = 'Nom r'#233'duit'
      FieldName = 'ANOMREDUIT'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.ANOMREDUIT'
    end
    object setOrganismesAMCAIDENTIFIANTNATIONAL: TWideStringField
      DisplayLabel = 'Id. national'
      FieldName = 'AIDENTIFIANTNATIONAL'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.AIDENTIFIANTNATIONAL'
      Size = 9
    end
    object setOrganismesAMCARUE1: TWideStringField
      FieldName = 'ARUE1'
      Size = 40
    end
    object setOrganismesAMCARUE2: TWideStringField
      FieldName = 'ARUE2'
      Size = 40
    end
    object setOrganismesAMCACODEPOSTALVILLE: TWideStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'ACODEPOSTALVILLE'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.CODEPOSTALVILLE'
      Size = 36
    end
    object setOrganismesAMCACOMMENTAIRE: TWideStringField
      DisplayLabel = 'Commentaire'
      FieldName = 'ACOMMENTAIRE'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.ACOMMENTAIRE'
      Size = 200
    end
  end
  object sp: TUIBQuery
    Transaction = trSP
    Left = 40
    Top = 88
  end
  object setClients: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  aclientid,'
      '  anom,'
      '  aprenom,'
      '  anumeroinsee,'
      '  adatedernierevisite'
      'from ps_utl_pha_clients(:ATYPE, :APARAMETRE)'
      'order by APrenom, ANom')
    Left = 136
    Top = 208
    object setClientsANOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'ANOM'
      Origin = 'PS_UTL_PHA_CLIENT.ANOM'
      Size = 50
    end
    object setClientsAPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'APRENOM'
      Origin = 'PS_UTL_PHA_CLIENT.APRENOM'
      Size = 50
    end
    object setClientsANUMEROINSEE: TWideStringField
      DisplayLabel = 'N'#176' INSEE'
      FieldName = 'ANUMEROINSEE'
      Origin = 'PS_UTL_PHA_CLIENT.ANUMEROINSEE'
      Size = 15
    end
    object setClientsADATEDERNIEREVISITE: TDateField
      DisplayLabel = 'Derni'#232're visite'
      FieldName = 'ADATEDERNIEREVISITE'
      Origin = 'PS_UTL_PHA_CLIENT.ADATEDERNIEREVISITE'
    end
    object setClientsACLIENTID: TWideStringField
      DisplayLabel = 'N'#176' dossier'
      FieldName = 'ACLIENTID'
      Size = 50
    end
  end
  object setProduits: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  AProduitID,'
      '  ACodeCIP,'
      '  ADesignation,'
      '  APrixAchatCatalogue,'
      '  APrixVente,'
      '  APAMP,'
      '  APrixAchatRemise,'
      '  AFournisseur,'
      '  ARepartiteur,'
      '  APrestation,'
      '  ADateDerniereVente,'
      '  AStockTotal,'
      '  ATypeHomeo'
      'from ps_utl_pha_produits(:ATYPE, :APARAMETRE)'
      'order by ACodeCIP')
    Left = 224
    Top = 208
    object setProduitsACODECIP: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'ACODECIP'
      Origin = 'PS_UTL_PHA_PRODUITS.ACODECIP'
      Size = 7
    end
    object setProduitsADESIGNATION: TWideStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'ADESIGNATION'
      Origin = 'PS_UTL_PHA_PRODUITS.ADESIGNATION'
      Size = 50
    end
    object setProduitsAPRIXACHATCATALOGUE: TUIBBCDField
      DisplayLabel = 'PA Tarif'
      FieldName = 'APRIXACHATCATALOGUE'
      Origin = 'PS_UTL_PHA_PRODUITS.APRIXACHATCATALOGUE'
      Precision = 18
      Size = 3
    end
    object setProduitsAPRIXVENTE: TUIBBCDField
      DisplayLabel = 'PV TTC'
      FieldName = 'APRIXVENTE'
      Origin = 'PS_UTL_PHA_PRODUITS.APRIXVENTE'
      Precision = 18
      Size = 2
    end
    object setProduitsAPAMP: TUIBBCDField
      DisplayLabel = 'PAMP'
      FieldName = 'APAMP'
      Origin = 'PS_UTL_PHA_PRODUITS.APAMP'
      Precision = 18
      Size = 3
    end
    object setProduitsAPRESTATION: TWideStringField
      DisplayLabel = 'Prest.'
      FieldName = 'APRESTATION'
      Origin = 'PS_UTL_PHA_PRODUITS.APRESTATION'
      Size = 3
    end
    object setProduitsADATEDERNIEREVENTE: TDateField
      DisplayLabel = 'Derni'#232're vente'
      FieldName = 'ADATEDERNIEREVENTE'
      Origin = 'PS_UTL_PHA_PRODUITS.ADATEDERNIEREVENTE'
    end
    object setProduitsASTOCKTOTAL: TIntegerField
      DisplayLabel = 'Stock total'
      FieldName = 'ASTOCKTOTAL'
      Origin = 'PS_UTL_PHA_PRODUITS.ASTOCKTOTAL'
    end
    object setProduitsAFOURNISSEUR: TWideStringField
      DisplayLabel = 'Marque'
      FieldName = 'AFOURNISSEUR'
      Size = 50
    end
    object setProduitsAREPARTITEUR: TWideStringField
      DisplayLabel = 'R'#233'partiteur attitr'#233
      FieldName = 'AREPARTITEUR'
      Size = 50
    end
    object setProduitsAPRIXACHATREMISE: TUIBBCDField
      DisplayLabel = 'PA Remis'#233
      FieldName = 'APRIXACHATREMISE'
      Precision = 18
      Size = 3
    end
    object setProduitsATYPEHOMEO: TWideStringField
      FieldName = 'ATYPEHOMEO'
      Size = 1
    end
    object setProduitsAPRODUITID: TWideStringField
      FieldName = 'APRODUITID'
      Size = 50
    end
  end
  object setFournisseursDirect: TFBDataSet
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = []
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost, poFetchAll]
    RefreshTransactionKind = tkDefault
    Transaction = trAnnexe
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select id,'
      'libelle,'
      'nombre_produits'
      'from v_utl_pha_fournisseur_direct'
      'order by libelle')
    Left = 488
    Top = 16
    object setFournisseursDirectID: TIntegerField
      FieldName = 'ID'
    end
    object setFournisseursDirectLIBELLE: TFBAnsiField
      DisplayLabel = 'Raison sociale'
      FieldName = 'LIBELLE'
      Size = 50
    end
    object setFournisseursDirectNOMBRE_PRODUITS: TIntegerField
      DisplayLabel = 'Nb. Produits'
      FieldName = 'NOMBRE_PRODUITS'
    end
  end
  object trAnnexe: TUIBTransaction
    Left = 488
    Top = 80
  end
  object trDataset: TUIBTransaction
    OnEndTransaction = trDatasetEndTransaction
    Left = 40
    Top = 152
  end
  object trSP: TUIBTransaction
    AutoStart = False
    AutoStop = False
    Left = 136
    Top = 88
  end
  object setRepartiteur: TFBDataSet
    AfterOpen = setRepartiteurAfterOpen
    BeforeClose = setRepartiteurBeforeClose
    AfterPost = setRepartiteurAfterPost
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
    Transaction = trDataset
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select'
      '  t_repartiteur_id,'
      '  raison_sociale,'
      '  identifiant_171,'
      '  code_postal_ville,'
      '  defaut'
      'from v_utl_pha_repartiteur')
    SQLRefresh.Strings = (
      'select'
      '  t_repartiteur_id,'
      '  raison_sociale,'
      '  identifiant_171,'
      '  code_postal_ville,'
      '  defaut'
      'from v_utl_pha_repartiteur'
      'where t_repartiteur_id = :T_REPARTITEUR_ID'
      '   or t_repartiteur_id = :T_ANCIEN_REPARTITEUR_DEFAUT_ID')
    SQLEdit.Strings = (
      'execute procedure ps_utl_pha_maj_rep_defaut('
      '  :T_REPARTITEUR_ID)')
    Left = 312
    Top = 208
    object setRepartiteurT_REPARTITEUR_ID: TFBAnsiField
      FieldName = 'T_REPARTITEUR_ID'
      Size = 50
    end
    object setRepartiteurRAISON_SOCIALE: TFBAnsiField
      DisplayLabel = 'Raison sociale'
      FieldName = 'RAISON_SOCIALE'
      Size = 50
    end
    object setRepartiteurDEFAUT: TStringField
      FieldName = 'DEFAUT'
      Required = True
      Size = 1
    end
    object setRepartiteurIDENTIFIANT_171: TFBAnsiField
      DisplayLabel = 'Identifiant 171'
      FieldName = 'IDENTIFIANT_171'
      Size = 8
    end
    object setRepartiteurCODE_POSTAL_VILLE: TFBAnsiField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Size = 36
    end
  end
  object setAuditHomeoCIP: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  cip_1,'
      '  type_homeo,'
      '  total'
      'from v_utl_pha_ah_cip'
      'order by cip_1'
      '')
    Left = 224
    Top = 272
    object setAuditHomeoCIPCIP_1: TWideStringField
      DisplayLabel = '1er chiffre du code CIP'
      FieldName = 'CIP_1'
      Origin = 'V_UTL_PHA_AH_CIP.CIP_1'
      Size = 7
    end
    object setAuditHomeoCIPTYPE_HOMEO: TWideStringField
      FieldName = 'TYPE_HOMEO'
      Origin = 'V_UTL_PHA_AH_CIP.TYPE_HOMEO'
      Visible = False
      Size = 1
    end
    object setAuditHomeoCIPTOTAL: TIntegerField
      DisplayLabel = 'Total'
      FieldName = 'TOTAL'
      Origin = 'V_UTL_PHA_AH_CIP.TOTAL'
    end
  end
  object setAuditHomeoFD: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  raison_sociale,'
      '  type_homeo,'
      '  total'
      'from v_utl_pha_ah_fournisseur_direct'
      'order by raison_sociale')
    Left = 224
    Top = 320
    object setAuditHomeoFDRAISON_SOCIALE: TWideStringField
      DisplayLabel = 'Raison sociale'
      FieldName = 'RAISON_SOCIALE'
      Origin = 'V_UTL_PHA_AH_FOURNISSEUR_DIRECT.RAISON_SOCIALE'
      Size = 50
    end
    object setAuditHomeoFDTOTAL: TIntegerField
      DisplayLabel = 'Total'
      FieldName = 'TOTAL'
      Origin = 'V_UTL_PHA_AH_FOURNISSEUR_DIRECT.TOTAL'
    end
    object setAuditHomeoFDTYPE_HOMEO: TWideStringField
      FieldName = 'TYPE_HOMEO'
      Visible = False
      Size = 1
    end
  end
  object setOrganismes: TFBDataSet
    AfterOpen = setOrganismesAfterOpen
    AfterPost = setOrganismesAfterPost
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
    Transaction = trDataset
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select'
      '  t_organisme_id,'
      '  type_organisme,'
      '  nom,'
      '  identifiant_national,'
      '  code_postal_ville,'
      '  org_sante_pharma,'
      '  t_destinataire_id'
      'from v_utl_pha_organisme'
      'order by nom')
    SQLRefresh.Strings = (
      'select'
      '  t_organisme_id,'
      '  type_organisme,  '
      '  nom,'
      '  identifiant_national,'
      '  code_postal_ville,'
      '  org_sante_pharma,'
      '  t_destinataire_id'
      'from v_utl_pha_organisme'
      'where t_organisme_id = :T_ORGANISME_ID')
    SQLEdit.Strings = (
      'execute procedure ps_utl_pha_maj_organisme('
      '  :T_ORGANISME_ID,'
      '  null,'
      '  null,'
      '  :T_DESTINATAIRE_ID,'
      '  :ORG_SANTE_PHARMA)')
    Left = 440
    Top = 208
    object setOrganismesT_ORGANISME_ID: TFBAnsiField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'T_ORGANISME_ID'
      Size = 50
    end
    object setOrganismesTYPE_ORGANISME: TFBAnsiField
      DisplayLabel = 'Type'
      FieldName = 'TYPE_ORGANISME'
      Size = 3
    end
    object setOrganismesNOM: TFBAnsiField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 50
    end
    object setOrganismesIDENTIFIANT_NATIONAL: TFBAnsiField
      DisplayLabel = 'Id. national'
      FieldName = 'IDENTIFIANT_NATIONAL'
      Size = 9
    end
    object setOrganismesCODE_POSTAL_VILLE: TFBAnsiField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Size = 36
    end
    object setOrganismesDESTINATAIRE: TFBAnsiField
      DisplayLabel = 'Destinataire'
      FieldKind = fkLookup
      FieldName = 'DESTINATAIRE'
      LookupDataSet = setDestinataires
      LookupKeyFields = 'ID'
      LookupResultField = 'LIBELLE'
      KeyFields = 'T_DESTINATAIRE_ID'
      Size = 50
      Lookup = True
    end
    object setOrganismesT_DESTINATAIRE_ID: TFBAnsiField
      FieldName = 'T_DESTINATAIRE_ID'
      Size = 50
    end
    object setOrganismesORG_SANTE_PHARMA: TStringField
      DisplayLabel = 'Org. Sant'#233' PHARMA'
      FieldName = 'ORG_SANTE_PHARMA'
      Size = 1
    end
  end
  object setDestinataires: TFBDataSet
    MaxMEMOStringSize = 0
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost, poFetchAll]
    RefreshTransactionKind = tkDefault
    Transaction = trAnnexe
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select'
      '  id,'
      '  libelle'
      'from v_utl_pha_destinataire'
      'order by libelle'
      '  ')
    Left = 608
    Top = 16
    object setDestinatairesID: TFBAnsiField
      FieldName = 'ID'
      Size = 50
    end
    object setDestinatairesLIBELLE: TFBAnsiField
      FieldName = 'LIBELLE'
      Size = 50
    end
  end
  object setDepartements: TFBDataSet
    MaxMEMOStringSize = 0
    AllowedUpdateKinds = []
    AutoUpdateOptions.WhenGetGenID = wgNever
    AutoUpdateOptions.IncrementBy = 1
    DefaultFormats.DisplayFormatNumeric = '#,##0.0'
    DefaultFormats.DisplayFormatInteger = '#,##0'
    DefaultFormats.EditFormatNumeric = '#0.0'
    DefaultFormats.EditFormatInteger = '#0'
    DetailConditions = []
    Macros = <>
    Option = [poTrimCharFields, poRefreshAfterPost, poFetchAll]
    RefreshTransactionKind = tkDefault
    Transaction = trAnnexe
    UpdateRecordTypes = [cusUnmodified, cusModified, cusInserted]
    SQLSelect.Strings = (
      'select distinct'
      '  substring(code_postal_ville from 1 for 2) id,'
      '  substring(code_postal_ville from 1 for 2) libelle'
      'from v_utl_pha_organisme'
      'where substring(code_postal_ville from 1 for 2) is not null'
      '  and substring(code_postal_ville from 1 for 2) <> '#39#39
      'order by substring(code_postal_ville from 1 for 2)')
    Left = 384
    Top = 16
    object StringField1: TFBAnsiField
      DisplayWidth = 2
      FieldName = 'ID'
      Size = 2
    end
    object StringField2: TFBAnsiField
      DisplayWidth = 2
      FieldName = 'LIBELLE'
      Size = 2
    end
  end
  object setHistoriques: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  ANumeroFacture,'
      '  ADateActe,'
      '  ADatePrescription,'
      '  ANomClient,'
      '  APrenomClient,'
      '  APurgeClient'
      'from ps_utl_pha_histo_client(:AType, :AParametre)')
    Left = 40
    Top = 288
    object setHistoriquesANUMEROFACTURE: TLargeintField
      DisplayLabel = 'Facture'
      FieldName = 'ANUMEROFACTURE'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ANUMEROFACTURE'
    end
    object setHistoriquesADATEACTE: TDateField
      DisplayLabel = 'Date d'#233'liv.'
      FieldName = 'ADATEACTE'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ADATEACTE'
    end
    object setHistoriquesADATEPRESCRIPTION: TDateField
      DisplayLabel = 'Prescription'
      FieldName = 'ADATEPRESCRIPTION'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ADATEPRESCRIPTION'
    end
    object setHistoriquesANOMCLIENT: TWideStringField
      DisplayLabel = 'Nom client'
      FieldName = 'ANOMCLIENT'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ANOMCLIENT'
      Size = 30
    end
    object setHistoriquesAPRENOMCLIENT: TWideStringField
      DisplayLabel = 'Pr'#233'nom client'
      FieldName = 'APRENOMCLIENT'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.APRENOMCLIENT'
      Size = 30
    end
    object setHistoriquesAPURGECLIENT: TWideStringField
      DisplayLabel = 'Purg'#233' Client'
      FieldName = 'APURGECLIENT'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.APURGECLIENT'
      Size = 30
    end
  end
  object setInventaire: TUIBDataSet
    Transaction = trDataset
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '  taux_tva,'
      '  sum(nb_produits) nb_produits,'
      '  sum(nb_unites) nb_unites,'
      '  sum(total_prix_achat_catalogue) total_prix_achat_catalogue,'
      '  sum(total_prix_vente) total_prix_vente,'
      '  sum(total_pamp) total_pamp'
      'from'
      '  v_utl_pha_inventaire'
      'group by'
      '  taux_tva')
    Left = 416
    Top = 360
    object setInventaireTAUX_TVA: TUIBBCDField
      DisplayLabel = 'TVA'
      FieldName = 'TAUX_TVA'
      Size = 2
    end
    object setInventaireTOTAL_PRIX_ACHAT_CATALOGUE: TUIBBCDField
      DisplayLabel = 'Tot. PA HT'
      FieldName = 'TOTAL_PRIX_ACHAT_CATALOGUE'
      Precision = 18
      Size = 3
    end
    object setInventaireTOTAL_PRIX_VENTE: TUIBBCDField
      DisplayLabel = 'Tot. PV TTC'
      FieldName = 'TOTAL_PRIX_VENTE'
      Precision = 18
      Size = 2
    end
    object setInventaireTOTAL_PAMP: TUIBBCDField
      DisplayLabel = 'Tot. PAMP'
      FieldName = 'TOTAL_PAMP'
      Precision = 18
      Size = 3
    end
    object setInventaireNB_PRODUITS: TLargeintField
      DisplayLabel = 'Nb. produits'
      FieldName = 'NB_PRODUITS'
    end
    object setInventaireNB_UNITES: TLargeintField
      DisplayLabel = 'Nb. unit'#233's'
      FieldName = 'NB_UNITES'
    end
  end
  object impDonnees: TPIImpression
    EntetePage.Alignement = taLeftJustify
    EntetePage.Cartouche.Alignement = acHaut
    EntetePage.Cartouche.Couleur = clWhite
    EntetePage.Cartouche.Coins.Coins = [beLeft, beTop, beRight, beBottom]
    EntetePage.Cartouche.Coins.Largeur = 1
    EntetePage.Cartouche.Frequence = fiToutes
    EntetePage.Cartouche.Visible = False
    EntetePage.Offset = 0
    EntetePage.Libelle.Alignement = alGauche
    EntetePage.Libelle.Angle = 0
    EntetePage.Libelle.Couleur = clWhite
    EntetePage.Libelle.Police.Charset = DEFAULT_CHARSET
    EntetePage.Libelle.Police.Color = clWindowText
    EntetePage.Libelle.Police.Height = -11
    EntetePage.Libelle.Police.Name = 'MS Sans Serif'
    EntetePage.Libelle.Police.Style = []
    EntetePage.Libelle.OffsetX = 0
    EntetePage.Libelle.OffsetY = 0
    EntetePage.Libelle.RetourLigne = False
    Previsualisation = True
    ImprimanteDefaut = True
    Marges.Bas = 4
    Marges.Haut = 4
    Marges.Gauche = 4
    Marges.Droite = 4
    PiedPage.Alignement = acBas
    PiedPage.Couleur = clWhite
    PiedPage.Coins.Coins = [beLeft, beTop, beRight, beBottom]
    PiedPage.Coins.Largeur = 1
    PiedPage.Frequence = fiToutes
    PiedPage.Visible = False
    EspacementEntreObjet = 10
    Orientation = poPortrait
    Left = 232
    Top = 48
  end
  object setCredits: TClientDataSet
    Aggregates = <>
    Filtered = True
    Params = <>
    Left = 752
    Top = 472
    object setCreditsT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Size = 50
    end
    object setCreditsNOM_CLIENT: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM_CLIENT'
      Size = 30
    end
    object setCreditsPRENOM_CLIENT: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM_CLIENT'
    end
    object setCreditsT_CREDIT_ID: TIntegerField
      FieldName = 'T_CREDIT_ID'
    end
    object setCreditsMONTANT_CREDIT: TBCDField
      DisplayLabel = 'Montant'
      FieldName = 'MONTANT_CREDIT'
      Precision = 18
      Size = 2
    end
    object setCreditsDATE_CREDIT: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_CREDIT'
    end
  end
  object setEncours: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      '  t_client_id, nom_client, prenom_client,'
      '  t_credit_id,  montant_credit, date_credit,'
      
        '  t_vignette_avancee_id, code_cip_avance, quantite_avancee, date' +
        '_avance,'
      '  t_facture_attente_id, date_facture,'
      '  t_produit_du_id, code_cip_du, quantite_du, date_du'
      'from'
      '  v_utl_pha_client_encours'
      'where date_credit < :ADATE_ENCOURS'
      '  or date_avance < :ADATE_ENCOURS'
      '  or date_facture < :ADATE_ENCOURS'
      '  or date_du < :ADATE_ENCOURS')
    AfterOpen = setEncoursAfterOpen
    Left = 648
    Top = 520
    object setEncoursT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Origin = 'V_CLIENT_ENCOURS.T_CLIENT_ID'
      Size = 50
    end
    object setEncoursNOM_CLIENT: TWideStringField
      FieldName = 'NOM_CLIENT'
      Origin = 'V_CLIENT_ENCOURS.NOM_CLIENT'
      Size = 30
    end
    object setEncoursPRENOM_CLIENT: TWideStringField
      FieldName = 'PRENOM_CLIENT'
      Origin = 'V_CLIENT_ENCOURS.PRENOM_CLIENT'
    end
    object setEncoursT_CREDIT_ID: TIntegerField
      FieldName = 'T_CREDIT_ID'
      Origin = 'V_CLIENT_ENCOURS.T_CREDIT_ID'
    end
    object setEncoursMONTANT_CREDIT: TUIBBCDField
      FieldName = 'MONTANT_CREDIT'
      Origin = 'V_CLIENT_ENCOURS.MONTANT_CREDIT'
      Precision = 18
      Size = 2
    end
    object setEncoursDATE_CREDIT: TDateField
      FieldName = 'DATE_CREDIT'
      Origin = 'V_CLIENT_ENCOURS.DATE_CREDIT'
    end
    object setEncoursT_VIGNETTE_AVANCEE_ID: TIntegerField
      FieldName = 'T_VIGNETTE_AVANCEE_ID'
      Origin = 'V_CLIENT_ENCOURS.T_VIGNETTE_AVANCEE_ID'
    end
    object setEncoursCODE_CIP_AVANCE: TWideStringField
      FieldName = 'CODE_CIP_AVANCE'
      Origin = 'V_CLIENT_ENCOURS.CODE_CIP_AVANCE'
      Size = 13
    end
    object setEncoursQUANTITE_AVANCEE: TIntegerField
      FieldName = 'QUANTITE_AVANCEE'
      Origin = 'V_CLIENT_ENCOURS.QUANTITE_AVANCEE'
    end
    object setEncoursDATE_AVANCE: TDateField
      FieldName = 'DATE_AVANCE'
      Origin = 'V_CLIENT_ENCOURS.DATE_AVANCE'
    end
    object setEncoursT_FACTURE_ATTENTE_ID: TWideStringField
      FieldName = 'T_FACTURE_ATTENTE_ID'
      Origin = 'V_CLIENT_ENCOURS.T_FACTURE_ATTENTE_ID'
      Size = 50
    end
    object setEncoursDATE_FACTURE: TDateField
      FieldName = 'DATE_FACTURE'
      Origin = 'V_CLIENT_ENCOURS.DATE_FACTURE'
    end
    object setEncoursT_PRODUIT_DU_ID: TWideStringField
      FieldName = 'T_PRODUIT_DU_ID'
      Origin = 'V_CLIENT_ENCOURS.T_PRODUIT_DU_ID'
      Size = 50
    end
    object setEncoursCODE_CIP_DU: TWideStringField
      FieldName = 'CODE_CIP_DU'
      Origin = 'V_CLIENT_ENCOURS.CODE_CIP_DU'
      Size = 13
    end
    object setEncoursQUANTITE_DU: TIntegerField
      FieldName = 'QUANTITE_DU'
      Origin = 'V_CLIENT_ENCOURS.QUANTITE_DU'
    end
    object setEncoursDATE_DU: TDateField
      FieldName = 'DATE_DU'
      Origin = 'V_CLIENT_ENCOURS.DATE_DU'
    end
  end
  object setVignettes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 424
    object setVignettesT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Size = 50
    end
    object setVignettesNOM_CLIENT: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM_CLIENT'
      Size = 30
    end
    object setVignettesPRENOM_CLIENT: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM_CLIENT'
    end
    object setVignettesT_VIGNETTE_AVANCEE_ID: TIntegerField
      FieldName = 'T_VIGNETTE_AVANCEE_ID'
    end
    object setVignettesCODE_CIP_AVANCE: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'CODE_CIP_AVANCE'
      Size = 13
    end
    object setVignettesQUANTITE_AVANCEE: TIntegerField
      DisplayLabel = 'Quantit'#233
      FieldName = 'QUANTITE_AVANCEE'
    end
    object setVignettesDATE_AVANCE: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_AVANCE'
    end
  end
  object setFactures: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 384
    object setFacturesT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Size = 50
    end
    object setFacturesNOM_CLIENT: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM_CLIENT'
      Size = 30
    end
    object setFacturesPRENOM_CLIENT: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM_CLIENT'
    end
    object setFacturesT_FACTURE_ATTENTE_ID: TWideStringField
      FieldName = 'T_FACTURE_ATTENTE_ID'
    end
    object setFacturesDATE_FACTURE: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_FACTURE'
    end
  end
  object setProduitsDus: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 744
    Top = 344
    object setProduitsDusT_CLIENT_ID: TWideStringField
      FieldName = 'T_CLIENT_ID'
      Size = 50
    end
    object setProduitsDusNOM_CLIENT: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM_CLIENT'
      Size = 30
    end
    object setProduitsDusPRENOM_CLIENT: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'PRENOM_CLIENT'
    end
    object setProduitsDusT_PRODUIT_DU_ID: TWideStringField
      FieldName = 'T_PRODUIT_DU_ID'
    end
    object setProduitsDusCODE_CIP_DU: TWideStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'CODE_CIP_DU'
      Size = 13
    end
    object setProduitsDusQUANTITE_DU: TIntegerField
      DisplayLabel = 'Quantit'#233
      FieldName = 'QUANTITE_DU'
    end
    object setProduitsDusDATE_DU: TDateField
      DisplayLabel = 'Date'
      FieldName = 'DATE_DU'
    end
  end
  object setPraticiens: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      ' APraticienID,'
      ' ANom,'
      ' APrenom,'
      ' ANoFiness,'
      ' ANumRPPS,'
      ' ADateDernierePrescription'
      ' from ps_utl_pha_praticiens(:ATYPE, :APARAMETRE)'
      ' order by APrenom, ANom')
    Left = 42
    Top = 210
    object setPraticiensANOM: TWideStringField
      DisplayLabel = 'Nom'
      FieldName = 'ANOM'
      Origin = 'PS_UTL_PHA_PRATICIEN.ANOM'
      Size = 50
    end
    object setPraticiensAPRENOM: TWideStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'APRENOM'
      Origin = 'PS_UTL_PHA_PRATICIEN.APRENOM'
      Size = 50
    end
    object setPraticiensANUMEROFINESS: TWideStringField
      DisplayLabel = 'N'#176' Finess'
      FieldName = 'ANoFiness'
      Origin = 'PS_UTL_PHA_PRATICIEN.ANOFINESS'
      Size = 15
    end
    object setPraticiensANumRPPS: TWideStringField
      DisplayLabel = 'N'#176' RPPS'
      FieldName = 'ANumRPPS'
      Origin = 'PS_UTL_PHA_PRATICIEN.ANumRPPS'
      Size = 15
    end
    object setPraticiensADATEDERNIEREPRESCRIPTION: TDateField
      DisplayLabel = 'Derni'#232're prescription'
      FieldName = 'ADATEDERNIEREPRESCRIPTION'
      Origin = 'PS_UTL_PHA_PRATICIEN.ADATEDERNIEREPRESCRIPTION'
    end
    object setPraticiensAPRATICIENID: TWideStringField
      DisplayLabel = 'ID'
      FieldName = 'APRATICIENID'
      Size = 50
    end
  end
  object setCommandes: TUIBDataSet
    Transaction = trDataset
    OnClose = etmCommitRetaining
    SQL.Strings = (
      'select'
      'ACommandeID,'
      'ADateCommande,'
      'ADateReception,'
      'ANomFournisseur,'
      'AMontant '
      'from ps_utl_pha_commandes(:AType, :AParametre)')
    Left = 40
    Top = 360
    object setCommandesACOMMANDEID: TWideStringField
      FieldName = 'ACOMMANDEID'
      Origin = 'PS_UTL_PHA_COMMANDES.ACOMMANDEID'
      Size = 50
    end
    object setCommandesADATECOMMANDE: TDateField
      FieldName = 'ADATECOMMANDE'
      Origin = 'PS_UTL_PHA_COMMANDES.ADATECOMMANDE'
    end
    object setCommandesADATERECEPTION: TDateField
      FieldName = 'ADATERECEPTION'
      Origin = 'PS_UTL_PHA_COMMANDES.ADATERECEPTION'
    end
    object setCommandesANOMFOURNISSEUR: TWideStringField
      FieldName = 'ANOMFOURNISSEUR'
      Origin = 'PS_UTL_PHA_COMMANDES.ANOMFOURNISSEUR'
      Size = 30
    end
    object setCommandesAMONTANT: TUIBBCDField
      FieldName = 'AMONTANT'
      Origin = 'PS_UTL_PHA_COMMANDES.AMONTANT'
      Precision = 18
      Size = 2
    end
  end
end
