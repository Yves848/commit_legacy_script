inherited dmRequeteur: TdmRequeteur
  OldCreateOrder = False
  Height = 150
  Width = 215
  inherited mnuMenuPrincipale: TJvMainMenu
    object mnuOutils: TMenuItem
      Caption = '&Reprise'
      object mnuOutilsRequeteur: TMenuItem
        Caption = '&Requ'#234'teur SQL'
        ShortCut = 16465
        OnClick = mnuOutilsRequeteurClick
      end
    end
  end
end
