inherited frOfficinall: TfrOfficinall
  inherited wzDonnees: TJvWizard
    Width = 263
    ExplicitWidth = 263
    inherited wipBienvenue: TJvWizardInteriorPage
      ExplicitWidth = 86
      inherited grdFichiersManquants: TPIDBGrid
        Width = 86
      end
    end
    inherited wipPraticiens: TJvWizardInteriorPage
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited grdPraticiens: TPIStringGrid
        Width = 86
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipOrganismes: TJvWizardInteriorPage
      Enabled = False
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited grdOrganismes: TPIStringGrid
        Width = 86
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipClients: TJvWizardInteriorPage
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited grdClients: TPIStringGrid
        Width = 86
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipProduits: TJvWizardInteriorPage
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited grdProduits: TPIStringGrid
        Width = 86
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipEnCours: TJvWizardInteriorPage
      Enabled = True
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited grdEnCours: TPIStringGrid
        Width = 86
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipAutresDonnees: TJvWizardInteriorPage
      Caption = 'Historiques'
      Enabled = True
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited grdAutresDonnees: TPIStringGrid
        Width = 86
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipRecapitulatif: TJvWizardInteriorPage
      ExplicitWidth = 531
      ExplicitHeight = 491
      inherited sbxRecapitulatif: TScrollBox
        Width = 531
        Height = 441
        ExplicitWidth = 531
        ExplicitHeight = 441
      end
    end
    inherited wipConversions: TJvWizardInteriorPage
      ExplicitWidth = 86
      inherited tctlConversions: TTabControl
        Width = 86
        ExplicitWidth = 86
      end
    end
  end
  inherited xpcOutils: TJvXPContainer
    Left = 263
    Width = 188
    Color = clWindow
    ExplicitLeft = 263
    ExplicitWidth = 188
    inherited sbxTraitements: TScrollBox
      Width = 170
      ExplicitWidth = 170
      inherited xpbTraitements: TJvXPBar
        Width = 170
        ExplicitWidth = 170
      end
    end
    inherited xpbEntetesTraitements: TJvXPBar
      Width = 170
      ExplicitWidth = 170
    end
    inherited xpbAccesBD: TJvXPBar
      Width = 170
      ExplicitWidth = 170
    end
  end
  inherited lacOutils: TActionList
    object actAccesOfficinallConnexion: TAction
      Caption = 'Connexion ...'
      ImageIndex = 1
    end
    object actAccesOfficinallDeconnexion: TAction
      Caption = 'D'#233'connexion'
      Enabled = False
      ImageIndex = 0
    end
    object actAccesOfficinallParametres: TAction
      Caption = 'Param'#232'tres ...'
      ImageIndex = 2
    end
  end
end
