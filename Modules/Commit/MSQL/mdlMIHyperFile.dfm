inherited frMIHyperFile: TfrMIHyperFile
  Width = 721
  Height = 551
  inherited wzDonnees: TJvWizard
    Width = 540
    Height = 526
    inherited wipBienvenue: TJvWizardInteriorPage
      inherited spl1: TJvNetscapeSplitter
        Top = 345
        Width = 363
        ExplicitTop = 98
        RestorePos = 205
      end
      inherited PIPanel1: TPIPanel
        Top = 356
        Width = 363
        ExplicitTop = 109
        inherited vstMAJModule: TVirtualStringTree
          Width = 361
          Columns = <
            item
              CaptionAlignment = taCenter
              Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coUseCaptionAlignment]
              Position = 0
              Width = 100
              WideText = 'N'#176' de version'
            end
            item
              CaptionAlignment = taCenter
              Options = [coEnabled, coParentBidiMode, coParentColor, coVisible, coFixed, coAllowFocus, coUseCaptionAlignment]
              Position = 1
              Width = 100
              WideText = 'Date de diffusion'
            end
            item
              Options = [coEnabled, coParentBidiMode, coParentColor, coVisible, coFixed, coAllowFocus]
              Position = 2
              Width = 161
              WideText = 'Contenu'
            end>
        end
        inherited StaticText1: TStaticText
          Width = 355
        end
      end
      inherited grdFichiersManquants: TPIDBGrid
        Width = 363
        Height = 295
      end
    end
    inherited wipPraticiens: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited grdPraticiens: TPIStringGrid
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipOrganismes: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited grdOrganismes: TPIStringGrid
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipClients: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited grdClients: TPIStringGrid
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipProduits: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited grdProduits: TPIStringGrid
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipEnCours: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited grdEnCours: TPIStringGrid
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipAutresDonnees: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited grdAutresDonnees: TPIStringGrid
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipRecapitulatif: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited sbxRecapitulatif: TScrollBox
        Width = 608
        Height = 631
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
    inherited wipConversions: TJvWizardInteriorPage
      ExplicitWidth = 228
      ExplicitHeight = 357
      inherited tctlConversions: TTabControl
        Width = 363
        Height = 434
        ExplicitWidth = 228
        ExplicitHeight = 307
      end
    end
    inherited rmnDonnees: TJvWizardRouteMapNodes
      Height = 484
    end
  end
  inherited xpcOutils: TJvXPContainer
    Left = 540
    Height = 526
    inherited sbxTraitements: TScrollBox
      Height = 324
    end
  end
  inherited pnlTitre: TPIPanel
    Width = 721
  end
end
