inherited dmOutilsPHA_be: TdmOutilsPHA_be
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  inherited mnuMenuPrincipale: TJvMainMenu
    object mnuReprise: TMenuItem
      Caption = '&Reprise'
      object mnuSeparateur3: TMenuItem
        Caption = '-'
      end
      object mnuRepriseInitialisation: TMenuItem
        Caption = 'Initialisation'
        OnClick = mnuRepriseInitialisationClick
      end
    end
    object mnuOutils: TMenuItem
      Caption = 'Outils &PHA'
      object mnuOutilsOrganismes: TMenuItem
        Caption = 'Organismes'
        object mnuOutilsOrganismesDestinataires: TMenuItem
          Caption = 'Destinataires ...'
          OnClick = mnuOutilsOrganismesDestinatairesClick
        end
        object mnuOutilsOrganismesSantePHARMA: TMenuItem
          Caption = 'Sant'#233' PHARMA ...'
          OnClick = mnuOutilsOrganismesSantePHARMAClick
        end
      end
      object mnuOutilsProduits: TMenuItem
        Caption = 'Produits'
        object mnuProduitsInventaire: TMenuItem
          Caption = '&Inventaire par TVA ...'
          OnClick = mnuProduitsInventaireClick
        end
        object mnuOutilsProduitsAuditHomeo: TMenuItem
          Caption = 'Audit hom'#233'o ...'
          OnClick = mnuOutilsProduitsAuditHomeoClick
        end
        object mnuOutilsProduitsReDefaut: TMenuItem
          Caption = 'R'#233'partiteur par d'#233'faut ...'
          OnClick = mnuOutilsProduitsReDefautClick
        end
      end
      object mnuSeparateur_1: TMenuItem
        Caption = '-'
      end
      object mnuOutilsIncoherences: TMenuItem
        Caption = 'Incoh'#233'rences ...'
        OnClick = mnuOutilsIncoherencesClick
      end
      object mnuOutilsPurges: TMenuItem
        Caption = 'Purges ...'
        OnClick = mnuOutilsPurgesClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuSeparateur_2: TMenuItem
        Caption = '-'
      end
    end
  end
end
