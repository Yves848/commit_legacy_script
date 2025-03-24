inherited dmVisualisationPHA_be: TdmVisualisationPHA_be
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 633
  Width = 881
  inherited mnuMenuPrincipale: TJvMainMenu
    Left = 16
    Top = 24
  end
  object trPHA: TUIBTransaction
    AutoStart = False
    AutoStop = False
    Left = 88
    Top = 16
  end
  object dSetRistournes: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      '   t_compte_id,'#9
      '  t_client_id,'
      '  nom,'
      '  prenom,'
      '  nb_cartes,'
      '  soldedisp,'
      '  ristdisp,'
      '  solde0,'
      '  solde1,'
      '  solde2,'
      '  solde3'
      'from v_vslt_compte_ristourne'
      'where upper(nom) like upper(:ANOM) || '#39'%'#39' and'
      '      upper(prenom) like upper(:APRENOM) || '#39'%'#39)
    BeforeClose = dSetRistournesBeforeClose
    AfterScroll = dSetRistournesAfterScroll
    Left = 168
    Top = 24
    object dSetRistournesT_COMPTE_ID: TWideStringField
      DisplayLabel = 'N'#176' Compte'
      FieldName = 'T_COMPTE_ID'
      Origin = 'v_vslt_compte_risourne.t_compte_id'
      Size = 50
    end
    object dSetRistournesT_CLIENT_ID: TWideStringField
      DisplayLabel = 't_client_id'
      FieldName = 'T_CLIENT_ID'
      Origin = 'v_vslt_compte_risourne.t_client_id'
      Required = True
      Visible = False
      FixedChar = True
      Size = 50
    end
    object dSetRistournesNOM: TWideStringField
      FieldName = 'NOM'
      Origin = 'v_vslt_compte_risourne.nom'
      Size = 30
    end
    object dSetRistournesPRENOM: TWideStringField
      FieldName = 'PRENOM'
      Origin = 'v_vslt_compte_risourne.prenom'
    end
    object dSetRistournesNB_CARTES: TSmallintField
      FieldName = 'NB_CARTES'
      Origin = 'v_vslt_compte_risourne.nb_cartes'
    end
    object dSetRistournesSOLDEDISP: TUIBBCDField
      FieldName = 'SOLDEDISP'
      Origin = 'v_vslt_compte_risourne.soldedisp'
      Precision = 2
      Size = 2
    end
    object dSetRistournesRISTDISP: TUIBBCDField
      FieldName = 'RISTDISP'
      Origin = 'v_vslt_compte_risourne.ristdisp'
      Precision = 2
      Size = 2
    end
    object dSetRistournesSOLDE0: TUIBBCDField
      FieldName = 'SOLDE0'
      Origin = 'v_vslt_compte_risourne.solde0'
      Precision = 2
      Size = 2
    end
    object dSetRistournesSOLDE1: TUIBBCDField
      FieldName = 'SOLDE1'
      Origin = 'v_vslt_compte_risourne.solde1'
      Precision = 2
      Size = 2
    end
    object dSetRistournesSOLDE2: TUIBBCDField
      FieldName = 'SOLDE2'
      Origin = 'v_vslt_compte_risourne.solde2'
      Precision = 2
      Size = 2
    end
    object dSetRistournesSOLDE3: TUIBBCDField
      FieldName = 'SOLDE3'
      Origin = 'v_vslt_compte_risourne.solde3'
      Precision = 2
      Size = 2
    end
  end
  object dSetCartesRistournes: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      ' t_compte_id,'#9
      '  nom,'
      '  prenom,'
      '  num_carte,'
      '  dateEmis'
      'from v_vslt_carte_ristourne'
      'where t_compte_id = (:T_COMPTE_ID)')
    BeforeClose = dSetCartesRistournesBeforeClose
    Left = 272
    Top = 24
    object dSetCartesRistournesT_COMPTE_ID: TWideStringField
      DisplayLabel = 'N'#176' Compte'
      FieldName = 'T_COMPTE_ID'
      Origin = 'v_vslt_carte_risourne.t_compte_id'
      Size = 50
    end
    object dSetCartesRistournesNOM: TWideStringField
      FieldName = 'NOM'
      Origin = 'v_vslt_carte_risourne.nom'
      Size = 30
    end
    object dSetCartesRistournesPRENOM: TWideStringField
      FieldName = 'PRENOM'
      Origin = 'v_vslt_carte_risourne.prenom'
    end
    object dSetCartesRistournesNUM_CARTE: TWideStringField
      DisplayLabel = 'N'#176' Carte'
      FieldName = 'NUM_CARTE'
      Origin = 'v_vslt_carte_risourne.num_carte'
      Size = 13
    end
    object dSetCartesRistournesDATEEMIS: TDateField
      DisplayLabel = 'Date d'#39#233'mission'
      FieldName = 'dateEmis'
      Origin = 'v_vslt_carte_risourne.dateEmis'
    end
  end
  object dSetClients: TUIBDataSet
    Transaction = trPHA
    OnClose = etmStayIn
    SQL.Strings = (
      'select'
      'CLIENT,'
      #9#9#9'NOM,'
      #9#9#9'PRENOM1,'
      #9#9#9'SEXE,'
      #9#9#9'LANGUE,'
      #9#9#9'DATENAISSANCE,'
      #9#9#9'NISS,'
      #9#9#9'RUE1,'
      #9#9#9'RUE2,'
      #9#9#9'CP,'
      #9#9#9'LOCALITE,'
      #9#9#9'CODEPAYS,'
      #9#9#9'TEL1,'
      #9#9#9'TEL2,'
      #9#9#9'GSM,'
      #9#9#9'EMAIL,'
      #9#9#9'FAX,'
      #9#9#9'URL,'
      #9#9#9'OA,'
      #9#9#9'OACPAS,'
      #9#9#9'MATOA,'
      #9#9#9'DATEDEBOA,'
      #9#9#9'DATEFINOA,'
      #9#9#9'OC,'
      #9#9#9'OCCPAS,'
      #9#9#9'MATOC,'
      #9#9#9'CATOC,'
      #9#9#9'DATEDEBOC,'
      #9#9#9'DATEFINOC,'
      #9#9#9'OAT,'
      #9#9#9'MATAT,'
      #9#9#9'CATAT,'
      #9#9#9'DATEDEBAT,'
      #9#9#9'DATEFINAT,'
      #9#9#9'CT1,'
      #9#9#9'CT2,'
      #9#9#9'COLLECTIVITE,'
      #9#9#9'VERSIONASSURABILITE,'
      #9#9#9'CERTIFICAT,'
      #9#9#9'NUMEROCARTESIS,'
      #9#9'DERNIERE_LECTURE,'
      #9#9#9'DATEDEBUTVALIDITEPIECE,'
      #9#9#9'DATEFINVALIDITEPIECE,'
      #9#9#9'PAYEUR,'
      #9#9#9'NUM_TVA,'
      #9#9#9'CommentaireIndiv,'
      #9#9#9'CommentaireBloqu,'
      #9#9#9'NatPieceJustifDroit,'
      #9#9#9'NumGroupe,'
      #9#9#9'IDPROFILEREMISE,'
      #9#9#9'IDFamille,'
      #9#9#9'DATEDERNIEREVISITE,'
      #9#9#9'EDITIONBVAC,'
      #9#9#9'EDITIONCBL,'
      #9#9#9'EDITION704,'
      #9#9#9'TYPEPROFILFACTURATION,'
      #9#9#9'COPIESCANEVASFACTURE,'
      #9#9#9'NUMCHAMBRE,'
      #9#9#9'ETAGE,'
      #9#9#9'MAISON,'
      #9#9#9'LIT,'
      #9#9#9'code_court,'
      #9#9#9'NB_TICKET_NOTEENVOI,'
      #9#9#9'NB_ETIQ_NOTEENVOI,'
      #9#9#9'DELAIPAIEMENT'
      '      FROM t_client'
      'where upper(nom) like upper(:ANOM) || '#39'%'#39' and'
      '      upper(prenom) like upper(:APRENOM) || '#39'%'#39)
    BeforeClose = dSetRistournesBeforeClose
    AfterScroll = dSetRistournesAfterScroll
    Left = 168
    Top = 96
  end
end
