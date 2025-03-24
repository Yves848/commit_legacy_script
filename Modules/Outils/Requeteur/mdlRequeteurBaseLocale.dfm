inherited dmRequeteurBaseLocale: TdmRequeteurBaseLocale
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 465
  Width = 469
  inherited mnuMenuPrincipale: TJvMainMenu
    Left = 96
  end
  object setResultat: TUIBDataSet
    Transaction = trResultat
    OnClose = etmStayIn
    Left = 24
    Top = 72
  end
  object trResultat: TUIBTransaction
    AutoStop = False
    Left = 24
    Top = 128
  end
  object scr: TUIBScript
    Transaction = trScr
    AutoDDL = False
    Left = 24
    Top = 16
  end
  object trScr: TUIBTransaction
    Left = 112
    Top = 128
  end
end
