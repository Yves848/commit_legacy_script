inherited dmMIMySQLPHA: TdmMIMySQLPHA
  OldCreateOrder = False
  Height = 501
  Width = 959
  object dbMySQL: TZConnection
    ControlsCodePage = cGET_ACP
    Properties.Strings = (
      'controls_cp=GET_ACP'
      'AutoEncodeStrings=ON')
    Port = 0
    Protocol = 'mysql-4.1'
    Left = 664
    Top = 416
  end
  object qryMySQL: TZReadOnlyQuery
    Connection = dbMySQL
    Params = <>
    Left = 744
    Top = 408
  end
  object dataset: TZReadOnlyQuery
    Connection = dbMySQL
    Params = <>
    Options = [doOemTranslate, doCalcDefaults]
    Left = 832
    Top = 408
  end
  object script: TZSQLProcessor
    Params = <>
    Connection = dbMySQL
    Delimiter = ';'
    Left = 832
    Top = 344
  end
end
