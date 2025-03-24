inherited dmPharmaVitalePHA: TdmPharmaVitalePHA
  OldCreateOrder = False
  Left = 5
  Top = 23
  Height = 429
  Width = 638
  object dbPharmaVitale: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=falcor;I' +
      'nitial Catalog=PharmaVitale;Data Source=PharmaVitale00'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 408
  end
  object qryPharmaVitale: TADOQuery
    Connection = dbPharmaVitale
    Parameters = <>
    Left = 112
    Top = 408
  end
  object dataset: TADOQuery
    Connection = dbPharmaVitale
    Parameters = <>
    Left = 112
    Top = 472
  end
end
