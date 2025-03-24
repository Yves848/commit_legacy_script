inherited dmImportLGPIPHA: TdmImportLGPIPHA
  OldCreateOrder = False
  Height = 579
  Width = 896
  inherited setReferenceAnalytiquesRef: TUIBDataSet
    Left = 680
    Top = 304
  end
  object dbLGPI: TOraSession
    Left = 568
    Top = 296
  end
  object qryLGPI: TOraQuery
    Session = dbLGPI
    Left = 568
    Top = 352
  end
end
