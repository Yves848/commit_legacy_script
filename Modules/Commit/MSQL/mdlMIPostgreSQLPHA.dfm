inherited dmMIPostgreSQLPHA: TdmMIPostgreSQLPHA
  OldCreateOrder = False
  Height = 501
  Width = 959
  object dbPostgreSQL: TZConnection
    ControlsCodePage = cGET_ACP
    Properties.Strings = (
      'controls_cp=GET_ACP'
      'AutoEncodeStrings=ON')
    HostName = '10.200.221.99'
    Port = 5432
    Database = 'vindilis'
    User = 'postgres'
    Password = 'postgres'
    Protocol = 'postgresql'
    Left = 648
    Top = 416
  end
  object qryPostgreSQL: TZReadOnlyQuery
    Connection = dbPostgreSQL
    Params = <>
    Left = 744
    Top = 408
  end
  object dataset: TZReadOnlyQuery
    Connection = dbPostgreSQL
    Params = <>
    Options = [doOemTranslate, doCalcDefaults]
    Left = 832
    Top = 408
  end
  object script: TZSQLProcessor
    Params = <>
    Connection = dbPostgreSQL
    Delimiter = ';'
    Left = 832
    Top = 344
  end
end
