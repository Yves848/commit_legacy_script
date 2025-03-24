inherited dmMIOLEDBPHA: TdmMIOLEDBPHA
  object dbOLEDB: TADOConnection
    LoginPrompt = False
    Left = 192
    Top = 472
  end
  object qryOLEDB: TADOQuery
    Connection = dbOLEDB
    Parameters = <>
    Left = 296
    Top = 472
  end
  object adoDataset: TADOQuery
    Connection = dbOLEDB
    Parameters = <>
    Left = 600
    Top = 448
  end
end
