inherited dmMIFirebirdPHA: TdmMIFirebirdPHA
  OldCreateOrder = False
  inherited setOrganismesAMORef: TUIBDataSet
    Left = 152
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    Port = 3050
    Left = 392
    Top = 464
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 160
    Top = 432
  end
end
