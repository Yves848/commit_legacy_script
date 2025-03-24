inherited dmModuleTransfertPHAyzy: TdmModuleTransfertPHAyzy
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  object dbLGPI: TOraSession
    Options.Direct = True
    Options.EnableBCD = True
    AutoCommit = False
    OnError = dbLGPIError
    Left = 264
    Top = 112
  end
  object psLGPI: TOraStoredProc
    StoredProcName = 'migration.PK_COMMUN.INITIALISER_TRANSFERT'
    Session = dbLGPI
    AutoCommit = False
    Options.TemporaryLobUpdate = True
    Left = 408
    Top = 112
  end
  object qryTableCorres: TUIBQuery
    SQL.Strings = (
      'execute procedure ps_transfert_creer_corres('
      '  :ACODEBASEPHA,'
      '  :ACODEBASELGPI);')
    Left = 96
    Top = 144
  end
  object scrLGPI: TOraScript
    OnError = scrLGPIError
    Session = dbLGPI
    Left = 216
    Top = 72
  end
  object qryErreurs: TOraQuery
    Session = dbLGPI
    SQL.Strings = (
      'select owner,'
      '  name,'
      '  line || '#39'/'#39' || position line_position,'
      '  text'
      'from sys.all_errors'
      'where owner = '#39'MIGRATION'#39)
    Left = 256
    Top = 184
    object qryErreursOWNER: TStringField
      FieldName = 'OWNER'
      Required = True
      Size = 30
    end
    object qryErreursNAME: TStringField
      DisplayLabel = 'Objet'
      FieldName = 'NAME'
      Required = True
      Size = 30
    end
    object qryErreursLINE_POSITION: TStringField
      DisplayLabel = 'Ligne/position'
      FieldName = 'LINE_POSITION'
      Size = 81
    end
    object qryErreursTEXT: TStringField
      DisplayLabel = 'Texte'
      FieldName = 'TEXT'
      Required = True
      Size = 4000
    end
  end
  object oraqry: TOraQuery
    Session = dbLGPI
    AutoCommit = False
    Left = 88
    Top = 344
  end
  object script: TOraScript
    Session = dbLGPI
    Left = 160
    Top = 344
  end
end
