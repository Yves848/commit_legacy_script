inherited dmVisualisation_fr: TdmVisualisation_fr
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 391
  Width = 475
  inherited mnuMenuPrincipale: TJvMainMenu
    Style = msXP
    object mnuReprise: TMenuItem
      Caption = '&Reprise'
      object mnuSeparateur: TMenuItem
        Caption = '-'
      end
      object mnuOutilsVisuFichiersOrig: TMenuItem
        Caption = '&Fichiers d'#39'origine (Binaires) ...'
        ShortCut = 16450
        OnClick = mnuOutilsVisuFichiersOrigClick
      end
    end
    object mnuOutils: TMenuItem
      Caption = 'Outils &PHA'
      GroupIndex = 2
      object mnuOutilsVisualisation: TMenuItem
        Caption = '&Visualisation'
        ShortCut = 49238
        OnClick = mnuOutilsVisualisationClick
      end
    end
  end
end
