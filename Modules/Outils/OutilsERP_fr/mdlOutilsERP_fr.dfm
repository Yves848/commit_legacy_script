inherited dmOutilsERP_fr: TdmOutilsERP_fr
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 293
  Width = 283
  inherited mnuMenuPrincipale: TJvMainMenu
    object OutilsERP1: TMenuItem
      Caption = 'Outils &ERP'
      object Sequenceordonanciersfactures1: TMenuItem
        Caption = '&Sequence ordonanciers && factures'
        OnClick = mnuERPToolsSeqOrdoClick
      end
      object Positionnementdesndelots1: TMenuItem
        Caption = '&Positionnement des n'#176' de lots'
        OnClick = mnuPosNoLotClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Statistiques1: TMenuItem
        Caption = '&Statistiques'
        ImageIndex = 0
        OnClick = mnuERPToolsStatClick
      end
    end
  end
end
