inherited dmOutilsBaseLocalePHA: TdmOutilsBaseLocalePHA
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 449
  Width = 676
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
    object setOrganismesAMCAORGANISMEAMCID: TStringField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'AORGANISMEAMCID'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.AORGANISMEAMCID'
      Size = 50
    end
    object setOrganismesAMCANOM: TStringField
      DisplayLabel = 'Nom'
      FieldName = 'ANOM'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.ANOM'
      Size = 50
    end
    object setOrganismesAMCANOMREDUIT: TStringField
      DisplayLabel = 'Nom r'#233'duit'
      FieldName = 'ANOMREDUIT'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.ANOMREDUIT'
    end
    object setOrganismesAMCAIDENTIFIANTNATIONAL: TStringField
      DisplayLabel = 'Id. national'
      FieldName = 'AIDENTIFIANTNATIONAL'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.AIDENTIFIANTNATIONAL'
      Size = 9
    end
    object setOrganismesAMCARUE1: TStringField
      FieldName = 'ARUE1'
      Size = 40
    end
    object setOrganismesAMCARUE2: TStringField
      FieldName = 'ARUE2'
      Size = 40
    end
    object setOrganismesAMCACODEPOSTALVILLE: TStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'ACODEPOSTALVILLE'
      Origin = 'PS_UTL_PHA_ORGANISME_AMC.CODEPOSTALVILLE'
      Size = 36
    end
    object setOrganismesAMCACOMMENTAIRE: TStringField
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
    object setClientsANOM: TStringField
      DisplayLabel = 'Nom'
      FieldName = 'ANOM'
      Origin = 'PS_UTL_PHA_CLIENT.ANOM'
      Size = 50
    end
    object setClientsAPRENOM: TStringField
      DisplayLabel = 'Pr'#233'nom'
      FieldName = 'APRENOM'
      Origin = 'PS_UTL_PHA_CLIENT.APRENOM'
      Size = 50
    end
    object setClientsANUMEROINSEE: TStringField
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
    object setClientsACLIENTID: TStringField
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
    object setProduitsACODECIP: TStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'ACODECIP'
      Origin = 'PS_UTL_PHA_PRODUITS.ACODECIP'
      Size = 7
    end
    object setProduitsADESIGNATION: TStringField
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
    object setProduitsAPRESTATION: TStringField
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
    object setProduitsAFOURNISSEUR: TStringField
      DisplayLabel = 'Marque'
      FieldName = 'AFOURNISSEUR'
      Size = 50
    end
    object setProduitsAREPARTITEUR: TStringField
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
    object setProduitsATYPEHOMEO: TStringField
      FieldName = 'ATYPEHOMEO'
      Size = 1
    end
    object setProduitsAPRODUITID: TStringField
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
    object setFournisseursDirectID: TStringField
      FieldName = 'ID'
      Size = 50
    end
    object setFournisseursDirectLIBELLE: TStringField
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
    AutoStart = False
    AutoStop = False
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
    object setRepartiteurT_REPARTITEUR_ID: TStringField
      FieldName = 'T_REPARTITEUR_ID'
      Size = 50
    end
    object setRepartiteurRAISON_SOCIALE: TStringField
      DisplayLabel = 'Raison sociale'
      FieldName = 'RAISON_SOCIALE'
      Size = 50
    end
    object setRepartiteurDEFAUT: TStringField
      FieldName = 'DEFAUT'
      Required = True
      Size = 1
    end
    object setRepartiteurIDENTIFIANT_171: TStringField
      DisplayLabel = 'Identifiant 171'
      FieldName = 'IDENTIFIANT_171'
      Size = 8
    end
    object setRepartiteurCODE_POSTAL_VILLE: TStringField
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
    object setAuditHomeoCIPCIP_1: TStringField
      DisplayLabel = '1er chiffre du code CIP'
      FieldName = 'CIP_1'
      Origin = 'V_UTL_PHA_AH_CIP.CIP_1'
      Size = 7
    end
    object setAuditHomeoCIPTYPE_HOMEO: TStringField
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
    object setAuditHomeoFDRAISON_SOCIALE: TStringField
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
    object setAuditHomeoFDTYPE_HOMEO: TStringField
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
    object setOrganismesT_ORGANISME_ID: TStringField
      DisplayLabel = 'N'#176' d'#39'organisme'
      FieldName = 'T_ORGANISME_ID'
      Size = 50
    end
    object setOrganismesTYPE_ORGANISME: TStringField
      DisplayLabel = 'Type'
      FieldName = 'TYPE_ORGANISME'
      Size = 3
    end
    object setOrganismesNOM: TStringField
      DisplayLabel = 'Nom'
      FieldName = 'NOM'
      Size = 50
    end
    object setOrganismesIDENTIFIANT_NATIONAL: TStringField
      DisplayLabel = 'Id. national'
      FieldName = 'IDENTIFIANT_NATIONAL'
      Size = 9
    end
    object setOrganismesCODE_POSTAL_VILLE: TStringField
      DisplayLabel = 'CP/Ville'
      FieldName = 'CODE_POSTAL_VILLE'
      Size = 36
    end
    object setOrganismesDESTINATAIRE: TStringField
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
    object setOrganismesT_DESTINATAIRE_ID: TStringField
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
    object setDestinatairesID: TStringField
      FieldName = 'ID'
      Size = 50
    end
    object setDestinatairesLIBELLE: TStringField
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
    object StringField1: TStringField
      DisplayWidth = 2
      FieldName = 'ID'
      Size = 2
    end
    object StringField2: TStringField
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
      '  ACodeCIP,'
      '  ADesignation,'
      '  AQuantiteFacturee'
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
    object setHistoriquesANOMCLIENT: TStringField
      DisplayLabel = 'Nom client'
      FieldName = 'ANOMCLIENT'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ANOMCLIENT'
      Size = 30
    end
    object setHistoriquesAPRENOMCLIENT: TStringField
      DisplayLabel = 'Pr'#233'nom client'
      FieldName = 'APRENOMCLIENT'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.APRENOMCLIENT'
      Size = 30
    end
    object setHistoriquesACODECIP: TStringField
      DisplayLabel = 'Code CIP'
      FieldName = 'ACODECIP'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ACODECIP'
      Size = 7
    end
    object setHistoriquesADESIGNATION: TStringField
      DisplayLabel = 'D'#233'signation'
      FieldName = 'ADESIGNATION'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.ADESIGNATION'
      Size = 50
    end
    object setHistoriquesAQUANTITEFACTUREE: TIntegerField
      DisplayLabel = 'Qt'#233' '
      FieldName = 'AQUANTITEFACTUREE'
      Origin = 'PS_UTL_PHA_HISTO_CLIENT.AQUANTITEFACTUREE'
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
end
