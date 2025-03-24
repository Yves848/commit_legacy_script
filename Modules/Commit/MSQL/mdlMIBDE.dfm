inherited frMIBDE: TfrMIBDE
  inherited wzDonnees: TJvWizard
    inherited wipBienvenue: TJvWizardInteriorPage
      inherited spl1: TJvNetscapeSplitter
        Top = 226
        Width = 93
        ExplicitTop = 226
        RestorePos = 205
      end
      inherited PIPanel1: TPIPanel
        Top = 98
        Width = 93
        inherited vstMAJModule: TVirtualStringTree
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
              WideText = 'Contenu'
            end>
        end
      end
    end
    inherited wipPraticiens: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
    end
    inherited wipOrganismes: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
    end
    inherited wipClients: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
    end
    inherited wipProduits: TJvWizardInteriorPage
      ExplicitHeight = 237
    end
    inherited wipEnCours: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
    end
    inherited wipAutresDonnees: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
    end
    inherited wipRecapitulatif: TJvWizardInteriorPage
      ExplicitWidth = 93
      ExplicitHeight = 237
      inherited sbxRecapitulatif: TScrollBox
        Width = 93
        Height = 187
        ExplicitWidth = 93
        ExplicitHeight = 187
      end
    end
  end
  inherited xpcOutils: TJvXPContainer
    inherited sbxTraitements: TScrollBox
      Height = 77
    end
    inherited xpbAccesBD: TJvXPBar
      Items = <
        item
          Action = actAccesBDConnexion
          Enabled = False
        end
        item
          Action = actAccesBDDeconnexion
        end
        item
          Caption = ' '
          Enabled = False
        end
        item
          Action = actAccesBDParametres
        end>
    end
  end
end
