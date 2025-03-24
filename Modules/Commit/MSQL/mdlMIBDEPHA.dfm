inherited dmMIBDEPHA: TdmMIBDEPHA
  OldCreateOrder = False
  object qryBDE: TQuery
    DatabaseName = 'BDE'
    Left = 296
    Top = 472
  end
  object dataset: TQuery
    DatabaseName = 'BDE'
    SessionName = 'Default'
    Left = 600
    Top = 448
  end
  object dbBDE: TDatabase
    DatabaseName = 'BDE'
    DriverName = 'STANDARD'
    LoginPrompt = False
    Params.Strings = (
      'PATH='
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    Left = 208
    Top = 560
  end
end
