inherited frPromotions: TfrPromotions
  inherited Splitter: TSplitter
    ExplicitWidth = 810
  end
  inherited pnlCritere: TPanel
    inherited btnChercher: TPISpeedButton
      OnClick = btnChercherClick
    end
  end
  inherited grdResultat: TPIDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'LIBELLE'
        Title.Alignment = taCenter
        Width = 275
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'TYPE_PROMOTION'
        Title.Alignment = taCenter
        Width = 185
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'DATE_DEBUT'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'DATE_FIN'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end>
  end
  inherited ScrollBox: TScrollBox
    object lblLibelle: TLabel
      Left = 8
      Top = 12
      Width = 80
      Height = 13
      Caption = 'Libell'#233' promotion'
    end
    object lblDebutValidite: TLabel
      Left = 8
      Top = 40
      Width = 40
      Height = 13
      Caption = 'D'#233'but le'
    end
    object lblFinValidite: TLabel
      Left = 194
      Top = 40
      Width = 25
      Height = 13
      Caption = 'Fin le'
    end
    object edtLibelle: TDBEdit
      Left = 96
      Top = 8
      Width = 289
      Height = 21
      DataField = 'LIBELLE'
      DataSource = dsResultat
      TabOrder = 0
    end
    object edtDebutValidite: TDBEdit
      Left = 94
      Top = 36
      Width = 87
      Height = 21
      DataField = 'DATE_DEBUT'
      DataSource = dsResultat
      TabOrder = 1
    end
    object edtFinValidite: TDBEdit
      Left = 234
      Top = 36
      Width = 87
      Height = 21
      DataField = 'DATE_FIN'
      DataSource = dsResultat
      TabOrder = 2
    end
    object pnlDates: TPIPanel
      Left = 416
      Top = 8
      Width = 201
      Height = 65
      TabOrder = 3
      Degrade.Actif = False
      Degrade.CouleurDepart = clBlack
      Degrade.Direction = dirHautVersBas
      Degrade.CouleurFin = clBlack
      Degrade.Orientation = gdVertical
      CoinsRonds = True
      PropagationEtat = False
      object lblMAJ: TLabel
        Left = 11
        Top = 36
        Width = 59
        Height = 13
        Caption = 'Derni'#232're MA'
      end
      object Label2: TLabel
        Left = 8
        Top = 12
        Width = 80
        Height = 13
        Caption = 'Date de cr'#233'ation'
      end
      object edtMAJ: TDBEdit
        Left = 104
        Top = 32
        Width = 89
        Height = 21
        DataField = 'DATE_DERNIERE_MAJ'
        DataSource = dsResultat
        TabOrder = 0
      end
      object edtDateCreation: TDBEdit
        Left = 104
        Top = 8
        Width = 89
        Height = 21
        DataField = 'DATE_CREATION'
        DataSource = dsResultat
        TabOrder = 1
      end
    end
    object gbxProduitsPromotion: TGroupBox
      Left = 8
      Top = 80
      Width = 609
      Height = 177
      Caption = 'Produits affect'#233's '#224' la promotion'
      TabOrder = 4
      object Label1: TLabel
        Left = 16
        Top = 28
        Width = 75
        Height = 13
        Caption = 'Type promotion'
      end
      object edtTypePromo: TDBEdit
        Left = 112
        Top = 24
        Width = 265
        Height = 21
        DataField = 'TYPE_PROMOTION'
        DataSource = dsResultat
        TabOrder = 0
      end
      object grdPanierPromo: TPIDBGrid
        Left = 16
        Top = 56
        Width = 577
        Height = 113
        BorderStyle = bsNone
        DataSource = dsPanierPromotion
        DefaultDrawing = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        MenuColonneActif = False
        StyleBordure = sbimple
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 2
        Options2.CouleurSelection = clHighlight
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -11
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = []
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        Details = False
        HauteurEntetes = 17
        Entetes = <>
        MultiSelection.Active = False
        MultiSelection.Mode = mmsSelection
        Columns = <
          item
            Expanded = False
            FieldName = 'DESIGNATION'
            Title.Alignment = taCenter
            Width = 390
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end
          item
            Expanded = False
            FieldName = 'PRIX_VENTE'
            Title.Alignment = taCenter
            Width = 50
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end
          item
            Expanded = False
            FieldName = 'QUANTITE'
            Title.Alignment = taCenter
            Title.Caption = 'Stock Promo'
            Width = 50
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end
          item
            Expanded = False
            FieldName = 'STOCK_ALERTE'
            Title.Alignment = taCenter
            Width = 50
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end>
      end
    end
    object grdAvantagePromotion: TGroupBox
      Left = 8
      Top = 264
      Width = 609
      Height = 161
      Caption = 'Avantage promotionnel'
      TabOrder = 5
      object grdAvantagePromo: TPIDBGrid
        Left = 16
        Top = 24
        Width = 577
        Height = 129
        BorderStyle = bsNone
        DataSource = dsAvantage
        DefaultDrawing = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        MenuColonneActif = False
        StyleBordure = sbimple
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 2
        Options2.CouleurSelection = clHighlight
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -11
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = []
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        Details = False
        HauteurEntetes = 17
        Entetes = <>
        MultiSelection.Active = False
        MultiSelection.Mode = mmsSelection
        Columns = <
          item
            Expanded = False
            FieldName = 'A_PARTIR_DE'
            Title.Alignment = taCenter
            Title.Caption = 'Qt'#233' '#224' vendre ('#224' partir de)'
            Width = 75
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end
          item
            Expanded = False
            FieldName = 'TYPE_AVANTAGE_PROMO'
            Title.Alignment = taCenter
            Title.Caption = 'Avantage Promotionnel'
            Width = 390
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end
          item
            Expanded = False
            FieldName = 'VAL_AVANTAGE'
            Title.Alignment = taCenter
            Title.Caption = 'Valeur de l'#39'avantage'
            Width = 75
            Visible = True
            Controle = ccAucun
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
          end>
      end
    end
  end
  object dsPanierPromotion: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetPanierPromotion
    Left = 24
    Top = 344
  end
  object dsAvantage: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetAvantagePromo
    Left = 16
    Top = 448
  end
end
