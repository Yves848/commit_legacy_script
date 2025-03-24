object dmPHA: TdmPHA
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 637
  Width = 977
  object setErreurs: TUIBDataSet
    Transaction = trErreurs
    SQL.Strings = (
      'select AMessage, AMessageSQL, AOccurence'
      'from ps_renvoyer_erreur(:AFICHIERID)')
    BeforeClose = setErreursBeforeClose
    AfterScroll = setErreursAfterScroll
    Left = 96
    Top = 8
    object setErreursAOCCURENCE: TIntegerField
      FieldName = 'AOCCURENCE'
    end
    object setErreursAMESSAGE: TWideStringField
      DisplayLabel = 'Message'
      FieldName = 'AMESSAGE'
      Size = 500
    end
    object setErreursAMESSAGESQL: TWideStringField
      FieldName = 'AMESSAGESQL'
      Size = 1000
    end
  end
  object trErreurs: TUIBTransaction
    Left = 24
    Top = 8
  end
  object qry: TUIBQuery
    Transaction = trErreurs
    Left = 96
    Top = 72
  end
  object setDonnees: TUIBDataSet
    Transaction = trErreurs
    OnClose = etmStayIn
    SQL.Strings = (
      'select first 20'
      '  donnees, instruction'
      'from'
      '  v_donnees'
      'where'
      '  t_fct_fichier_id = :AFICHIERID'
      '  and message_erreur_sql = :AMESSAGE')
    Left = 160
    Top = 8
    object setDonneesDONNEES: TWideMemoField
      FieldName = 'DONNEES'
      BlobType = ftWideMemo
    end
    object setDonneesINSTRUCTION: TWideMemoField
      FieldName = 'INSTRUCTION'
      BlobType = ftWideMemo
    end
  end
end
