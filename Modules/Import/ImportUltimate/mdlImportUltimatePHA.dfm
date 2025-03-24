inherited dmImportUltimatePHA: TdmImportUltimatePHA
  OldCreateOrder = False
  Height = 579
  Width = 896
  inherited setReferenceAnalytiquesRef: TUIBDataSet
    Left = 680
    Top = 304
  end
  object dbUltimate: TOraSession
    Options.Direct = True
    Left = 568
    Top = 296
  end
  object qryUltimate: TOraQuery
    Session = dbUltimate
    Left = 568
    Top = 352
  end
end
