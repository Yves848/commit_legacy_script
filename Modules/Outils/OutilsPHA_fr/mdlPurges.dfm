inherited frmPurges: TfrmPurges
  Left = 308
  Top = 231
  Caption = 'Purges de donn'#233'es'
  ClientHeight = 477
  ClientWidth = 705
  Constraints.MaxHeight = 550
  Constraints.MaxWidth = 713
  Position = poDesigned
  OnDestroy = FormDestroy
  ExplicitWidth = 711
  ExplicitHeight = 506
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel [0]
    Left = 344
    Top = 248
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object pCtlPurgeDonnees: TPageControl [1]
    Left = 0
    Top = 0
    Width = 705
    Height = 477
    ActivePage = tshEncours
    Align = alClient
    Images = iLstPageControl
    TabHeight = 32
    TabOrder = 0
    OnChange = pCtlPurgeDonneesChange
    OnChanging = pCtlPurgeDonneesChanging
    object tShPurgePraticiens: TTabSheet
      Caption = 'Praticiens'
      object Label4: TLabel
        Left = 121
        Top = 61
        Width = 41
        Height = 13
        Caption = 'purg'#233's : '
      end
      object Label5: TLabel
        Left = 249
        Top = 61
        Width = 64
        Height = 13
        Caption = 'Non purg'#233's : '
      end
      object rgPurgePraticiens: TRadioGroup
        Left = 8
        Top = 8
        Width = 681
        Height = 51
        Caption = 'Types de purge'
        Columns = 2
        Items.Strings = (
          'Praticiens sans RPPS'
          'Date de derni'#232're visite (--/--/----)')
        TabOrder = 0
        OnClick = rgChoixPurgeClick
      end
      object grdPurgePraticiens: TPIDBGrid
        Left = 8
        Top = 80
        Width = 681
        Height = 308
        DataSource = dsPraticiens
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        MenuColonneActif = False
        StyleBordure = sbDouble
        Options2.LargeurIndicateur = 16
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
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
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = True
        MultiSelection.Mode = mmsDeselection
        Columns = <
          item
            Expanded = False
            FieldName = 'APRATICIENID'
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
            FieldName = 'ANOM'
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
            FieldName = 'APRENOM'
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
            FieldName = 'ANOFINESS'
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
            FieldName = 'ANUMRPPS'
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
            FieldName = 'ADATEDERNIEREVISITE'
            Title.Alignment = taCenter
            Width = 79
            Visible = True
            Controle = ccDateTimePicker
            OptionsControle.CheckBox.ValeurCoche = '1'
            OptionsControle.CheckBox.ValeurDecoche = '0'
            OptionsControle.ComboBox.ValeurParIndex = False
            OptionsControle.ProgressBar.Couleur = clActiveCaption
            OptionsControle.ProgressBar.Max = 100
            OptionsControle.ProgressBar.Min = 0
            Options = [ocExport, ocImpression]
        end>
      end
      object txtTotalRestantPraticiens: TStaticText
        Left = 312
        Top = 61
        Width = 67
        Height = 17
        Alignment = taRightJustify
        Caption = 'non purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object txtTotalPurgePraticiens: TStaticText
        Left = 161
        Top = 61
        Width = 42
        Height = 17
        Alignment = taRightJustify
        Caption = 'purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object btnPurgePraticiens: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 4
        Visible = False
      end
    end
    object tShPurgeOrganismes: TTabSheet
      Caption = 'Organismes'
      ImageIndex = 1
      object Label6: TLabel
        Left = 249
        Top = 61
        Width = 64
        Height = 13
        Caption = 'Non purg'#233's : '
      end
      object Label7: TLabel
        Left = 121
        Top = 61
        Width = 41
        Height = 13
        Caption = 'purg'#233's : '
      end
      object rgPurgeOrganismes: TRadioGroup
        Left = 8
        Top = 8
        Width = 681
        Height = 51
        Caption = 'Types de purge'
        Columns = 2
        Items.Strings = (
          'Organismes AMC sans clients')
        TabOrder = 0
        OnClick = rgChoixPurgeClick
      end
      object grdPurgeOrganismes: TPIDBGrid
        Left = 8
        Top = 80
        Width = 681
        Height = 308
        DataSource = dsOrganismes
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        MenuColonneActif = False
        StyleBordure = sbDouble
        Options2.LargeurIndicateur = 16
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
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
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = True
        MultiSelection.Mode = mmsDeselection
        Columns = <
          item
            Expanded = False
            FieldName = 'AORGANISMEAMCID'
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
            FieldName = 'ANOM'
            Title.Alignment = taCenter
            Width = 175
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
            FieldName = 'ANOMREDUIT'
            Title.Alignment = taCenter
            Width = 125
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
            FieldName = 'AIDENTIFIANTNATIONAL'
            Title.Alignment = taCenter
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
            FieldName = 'ACODEPOSTALVILLE'
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
          end>
      end
      object btnPurgeOrganismes: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 2
        Visible = False
      end
      object txtTotalPurgeOrganismes: TStaticText
        Left = 161
        Top = 61
        Width = 42
        Height = 17
        Alignment = taRightJustify
        Caption = 'purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object txtTotalRestantOrganismes: TStaticText
        Left = 312
        Top = 61
        Width = 67
        Height = 17
        Alignment = taRightJustify
        Caption = 'non purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
    end
    object tShPurgeClients: TTabSheet
      Caption = 'Clients'
      ImageIndex = 2
      object Label8: TLabel
        Left = 249
        Top = 92
        Width = 64
        Height = 13
        Caption = 'Non purg'#233's : '
      end
      object Label9: TLabel
        Left = 121
        Top = 92
        Width = 41
        Height = 13
        Caption = 'purg'#233's : '
      end
      object rgPurgeClients: TRadioGroup
        Left = 8
        Top = 8
        Width = 681
        Height = 85
        Caption = 'Types de purge'
        Columns = 2
        Items.Strings = (
          'Date de derni'#232're visite (--/--/----)'
          'B'#233'n'#233'ficiaires orphelins'
          'Clients sans num'#233'ro de SS'
          'Clients sans organismes AMO/AMC')
        TabOrder = 0
        OnClick = rgChoixPurgeClick
      end
      object grdPurgeClients: TPIDBGrid
        Left = 8
        Top = 112
        Width = 681
        Height = 276
        DataSource = dsClients
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        MenuColonneActif = False
        StyleBordure = sbDouble
        Options2.LargeurIndicateur = 16
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
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
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = True
        MultiSelection.Mode = mmsDeselection
        Columns = <
          item
            Expanded = False
            FieldName = 'ACLIENTID'
            Title.Alignment = taCenter
            Width = 90
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
            FieldName = 'ANOM'
            Title.Alignment = taCenter
            Width = 200
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
            FieldName = 'APRENOM'
            Title.Alignment = taCenter
            Width = 150
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
            FieldName = 'ANUMEROINSEE'
            Title.Alignment = taCenter
            Width = 120
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
            FieldName = 'ADATEDERNIEREVISITE'
            Title.Alignment = taCenter
            Width = 79
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
      object btnPurgeClients: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 2
        Visible = False
      end
      object txtTotalPurgeClients: TStaticText
        Left = 161
        Top = 92
        Width = 42
        Height = 17
        Alignment = taRightJustify
        Caption = 'purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object txtTotalRestantClients: TStaticText
        Left = 312
        Top = 92
        Width = 67
        Height = 17
        Alignment = taRightJustify
        Caption = 'non purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
    end
    object tShPurgeProduits: TTabSheet
      Caption = 'Produits'
      ImageIndex = 3
      object Label12: TLabel
        Left = 249
        Top = 92
        Width = 64
        Height = 13
        Caption = 'Non purg'#233's : '
      end
      object Label13: TLabel
        Left = 121
        Top = 92
        Width = 41
        Height = 13
        Caption = 'purg'#233's : '
      end
      object rgPurgeProduits: TRadioGroup
        Left = 8
        Top = 8
        Width = 681
        Height = 85
        Caption = 'Types de purge'
        Items.Strings = (
          'Date de derni'#232're vente (--/--/----)'
          'Fournisseur (-)')
        TabOrder = 0
        OnClick = rgChoixPurgeClick
      end
      object grdPurgeProduits: TPIDBGrid
        Left = 8
        Top = 112
        Width = 681
        Height = 276
        DataSource = dsProduits
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        MenuColonneActif = False
        StyleBordure = sbDouble
        Options2.LargeurIndicateur = 16
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
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
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = True
        MultiSelection.Mode = mmsDeselection
        Columns = <
          item
            Expanded = False
            FieldName = 'ACODECIP'
            Title.Alignment = taCenter
            Width = 60
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
            FieldName = 'ADESIGNATION'
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
            FieldName = 'APRIXACHATCATALOGUE'
            Title.Alignment = taCenter
            Width = 70
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
            FieldName = 'APRIXVENTE'
            Title.Alignment = taCenter
            Width = 70
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
            FieldName = 'APAMP'
            Title.Alignment = taCenter
            Width = 70
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
            FieldName = 'APRESTATION'
            Title.Alignment = taCenter
            Width = 30
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
            FieldName = 'ADATEDERNIEREVENTE'
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
            FieldName = 'ASTOCKTOTAL'
            Title.Alignment = taCenter
            Width = 70
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
      object btnPurgeProduits: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 2
        Visible = False
      end
      object txtTotalRestantProduits: TStaticText
        Left = 312
        Top = 92
        Width = 67
        Height = 17
        Alignment = taRightJustify
        Caption = 'non purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object txtTotalPurgeProduits: TStaticText
        Left = 161
        Top = 92
        Width = 42
        Height = 17
        Alignment = taRightJustify
        Caption = 'purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
    end
    object tShPurgeHistoDeliv: TTabSheet
      Caption = 'Historiques'
      ImageIndex = 4
      object Label10: TLabel
        Left = 249
        Top = 61
        Width = 64
        Height = 13
        Caption = 'Non purg'#233's : '
      end
      object Label11: TLabel
        Left = 121
        Top = 61
        Width = 41
        Height = 13
        Caption = 'purg'#233's : '
      end
      object grdPurgeHistoriques: TPIDBGrid
        Left = 8
        Top = 80
        Width = 681
        Height = 297
        DataSource = dsHistoriques
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        MenuColonneActif = False
        StyleBordure = sbDouble
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
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
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = False
        MultiSelection.Mode = mmsDeselection
        Columns = <
          item
            Expanded = False
            FieldName = 'ANUMEROFACTURE'
            Width = 78
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
            FieldName = 'ADATEACTE'
            Width = 106
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
            FieldName = 'ADATEPRESCRIPTION'
            Width = 121
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
            FieldName = 'ANOMCLIENT'
            Width = 103
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
            FieldName = 'APRENOMCLIENT'
            Width = 113
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
            FieldName = 'APURGECLIENT'
            Width = 132
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
      object btnPurgeHistoriques: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 1
        Visible = False
      end
      object txtTotalPurgeHistoriques: TStaticText
        Left = 161
        Top = 61
        Width = 42
        Height = 17
        Alignment = taRightJustify
        Caption = 'purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object txtTotalRestantHistoriques: TStaticText
        Left = 312
        Top = 61
        Width = 67
        Height = 17
        Alignment = taRightJustify
        Caption = 'non purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object rgPurgeHistoriques: TRadioGroup
        Left = 8
        Top = 8
        Width = 681
        Height = 51
        Caption = 'Types de purge'
        Items.Strings = (
          'Date de l'#39'acte (--/--/----)')
        TabOrder = 4
        OnClick = rgChoixPurgeClick
      end
    end
    object tshEncours: TTabSheet
      Caption = 'Encours'
      ImageIndex = 5
      object Bevel1: TBevel
        Left = 21
        Top = 17
        Width = 659
        Height = 45
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 277
        Top = 31
        Width = 66
        Height = 13
        Caption = 'Date de l'#39'acte'
      end
      object lblTypeEncours: TLabel
        Left = 35
        Top = 31
        Width = 73
        Height = 13
        Caption = 'Type d'#39'encours'
      end
      object dtEncoursDateActe: TDateTimePicker
        Left = 349
        Top = 25
        Width = 95
        Height = 24
        Date = 41018.736677407410000000
        Time = 41018.736677407410000000
        TabOrder = 0
        OnChange = dtDateActeChange
      end
      object cbxTypeEncours: TComboBox
        Left = 114
        Top = 28
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 1
        Text = 'Tous'
        OnChange = cbxTypeEncoursChange
        Items.Strings = (
          'Tous'
          'Cr'#233'dits'
          'Vignettes avanc'#233'es'
          'Factures en attentes'
          'Produits dus')
      end
      object gpEncours: TGridPanel
        Left = 21
        Top = 68
        Width = 659
        Height = 300
        ColumnCollection = <
          item
            Value = 4.002703283875526000
          end
          item
            Value = 95.997296716124470000
          end>
        ControlCollection = <
          item
            Column = 1
            Control = dgPurgeCredits
            Row = 0
          end
          item
            Column = -1
            Row = -1
          end
          item
            Column = -1
            Row = -1
          end
          item
            Column = -1
            Row = -1
          end
          item
            Column = -1
            Row = -1
          end
          item
            Column = -1
            Row = 2
          end
          item
            Column = -1
            Row = 3
          end
          item
            Column = 0
            Control = JvLabel1
            Row = 0
          end
          item
            Column = 1
            Control = PIDBGrid2
            Row = 1
          end
          item
            Column = 0
            Control = JvLabel3
            Row = 2
          end
          item
            Column = 1
            Control = PIDBGrid3
            Row = 2
          end
          item
            Column = 0
            Control = JvLabel2
            Row = 1
          end
          item
            Column = 0
            Control = JvLabel4
            Row = 3
          end
          item
            Column = 1
            Control = PIDBGrid4
            Row = 3
          end>
        RowCollection = <
          item
            SizeStyle = ssAbsolute
            Value = 80.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 80.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 80.000000000000000000
          end
          item
            SizeStyle = ssAbsolute
            Value = 80.000000000000000000
          end>
        TabOrder = 2
        Visible = False
        DesignSize = (
          659
          300)
        object dgPurgeCredits: TPIDBGrid
          Left = 27
          Top = 1
          Width = 631
          Height = 80
          Align = alClient
          DataSource = dsCredits
          DefaultDrawing = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          MenuColonneActif = False
          StyleBordure = sbDouble
          Options2.LargeurIndicateur = 11
          Options2.LignesParLigneDonnees = 1
          Options2.LignesParTitre = 1
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
          Impression = dmOutilsPHAPHA_fr.impDonnees
          MultiSelection.Active = False
          MultiSelection.Mode = mmsDeselection
          Columns = <
            item
              Expanded = False
              FieldName = 'NOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'PRENOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'MONTANT_CREDIT'
              Title.Alignment = taCenter
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
              FieldName = 'DATE_CREDIT'
              Title.Alignment = taCenter
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
        object JvLabel1: TJvLabel
          Left = 6
          Top = 23
          Width = 16
          Height = 35
          Caption = 'Cr'#233'dits'
          Anchors = []
          Transparent = True
          Angle = 90
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ExplicitLeft = 157
          ExplicitTop = 72
        end
        object PIDBGrid2: TPIDBGrid
          Left = 27
          Top = 81
          Width = 631
          Height = 80
          Align = alClient
          DataSource = dsVignettes
          DefaultDrawing = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          MenuColonneActif = False
          StyleBordure = sbDouble
          Options2.LargeurIndicateur = 11
          Options2.LignesParLigneDonnees = 1
          Options2.LignesParTitre = 1
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
          Impression = dmOutilsPHAPHA_fr.impDonnees
          MultiSelection.Active = False
          MultiSelection.Mode = mmsDeselection
          Columns = <
            item
              Expanded = False
              FieldName = 'NOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'PRENOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'CODE_CIP_AVANCE'
              Title.Alignment = taCenter
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
              FieldName = 'QUANTITE_AVANCEE'
              Title.Alignment = taCenter
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
              FieldName = 'DATE_AVANCE'
              Title.Alignment = taCenter
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
        object JvLabel3: TJvLabel
          Left = 6
          Top = 179
          Width = 16
          Height = 44
          Caption = 'Factures'
          Anchors = []
          Transparent = True
          Angle = 90
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ExplicitTop = 195
        end
        object PIDBGrid3: TPIDBGrid
          Left = 27
          Top = 161
          Width = 631
          Height = 80
          Align = alClient
          DataSource = dsFactures
          DefaultDrawing = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          MenuColonneActif = False
          StyleBordure = sbDouble
          Options2.LargeurIndicateur = 11
          Options2.LignesParLigneDonnees = 1
          Options2.LignesParTitre = 1
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
          Impression = dmOutilsPHAPHA_fr.impDonnees
          MultiSelection.Active = False
          MultiSelection.Mode = mmsDeselection
          Columns = <
            item
              Expanded = False
              FieldName = 'NOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'PRENOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'DATE_FACTURE'
              Title.Alignment = taCenter
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
        object JvLabel2: TJvLabel
          Left = 6
          Top = 98
          Width = 16
          Height = 45
          Caption = 'Vignettes'
          Anchors = []
          Transparent = True
          Angle = 90
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ExplicitTop = 109
        end
        object JvLabel4: TJvLabel
          Left = 6
          Top = 250
          Width = 16
          Height = 61
          Caption = 'Produits dus'
          Anchors = []
          Transparent = True
          Angle = 90
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ExplicitTop = 273
        end
        object PIDBGrid4: TPIDBGrid
          Left = 27
          Top = 241
          Width = 631
          Height = 80
          Align = alClient
          DataSource = dsProduitsDus
          DefaultDrawing = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          MenuColonneActif = False
          StyleBordure = sbDouble
          Options2.LargeurIndicateur = 11
          Options2.LignesParLigneDonnees = 1
          Options2.LignesParTitre = 1
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
          Impression = dmOutilsPHAPHA_fr.impDonnees
          MultiSelection.Active = False
          MultiSelection.Mode = mmsDeselection
          Columns = <
            item
              Expanded = False
              FieldName = 'NOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'PRENOM_CLIENT'
              Title.Alignment = taCenter
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
              FieldName = 'CODE_CIP_DU'
              Title.Alignment = taCenter
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
              FieldName = 'QUANTITE_DU'
              Title.Alignment = taCenter
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
              FieldName = 'DATE_DU'
              Title.Alignment = taCenter
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
      object btnPurgeEncours: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 3
        Visible = False
      end
    end
    object tshCommandes: TTabSheet
      Tag = 4
      Caption = 'Commandes'
      ImageIndex = 6
      object Label2: TLabel
        Left = 121
        Top = 61
        Width = 41
        Height = 13
        Caption = 'purg'#233's : '
      end
      object Label14: TLabel
        Left = 249
        Top = 61
        Width = 64
        Height = 13
        Caption = 'Non purg'#233's : '
      end
      object rgPurgeCommandes: TRadioGroup
        Tag = 4
        Left = 8
        Top = 8
        Width = 681
        Height = 51
        Caption = 'Types de purge'
        Items.Strings = (
          'Date de l'#39'acte (--/--/----)')
        TabOrder = 0
        OnClick = rgChoixPurgeClick
      end
      object txtTotalPurgeCommandes: TStaticText
        Left = 161
        Top = 61
        Width = 42
        Height = 17
        Alignment = taRightJustify
        Caption = 'purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object txtTotalRestantCommandes: TStaticText
        Left = 312
        Top = 61
        Width = 67
        Height = 17
        Alignment = taRightJustify
        Caption = 'non purg'#233's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object grdPurgeCommandes: TPIDBGrid
        Left = 8
        Top = 80
        Width = 681
        Height = 297
        DataSource = dsCommandes
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Visible = False
        MenuColonneActif = False
        StyleBordure = sbDouble
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
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
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = False
        MultiSelection.Mode = mmsDeselection
        Columns = <
          item
            Expanded = False
            FieldName = 'ACOMMANDEID'
            Title.Caption = 'ID Commande'
            Width = 189
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
            FieldName = 'ADATECOMMANDE'
            Title.Caption = 'Date Commande'
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
            FieldName = 'ADATERECEPTION'
            Title.Caption = 'Date R'#233'ception'
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
            FieldName = 'ANOMFOURNISSEUR'
            Title.Caption = 'Fournisseur'
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
            FieldName = 'AMONTANT'
            Title.Caption = 'Montant HT'
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
      object btnPurgeCommandes: TButton
        Left = 0
        Top = 394
        Width = 697
        Height = 41
        Action = actPurger
        Align = alBottom
        ImageIndex = 8
        Images = iLstPageControl
        Style = bsCommandLink
        TabOrder = 4
        Visible = False
      end
    end
  end
  inherited ilActions: TImageList
    Left = 656
    Top = 56
    Bitmap = {
      494C010103000500680010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000ADADAD00E7D6CE00F7EFE700EFEFEF00EFEFEF00EFE7E700BDADA5007B73
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00000000000000000000000000848484008484
      84008C8C8C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD00949494008484840094949400ADADAD00000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD00F7EFEF00EFEFEF00E7DEDE00E7E7E700E7E7E700EFEFEF00EFEFEF00EFE7
      E700636363000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C00D6CECE009494940039393900525252009C949400C6C6
      C600D6D6D6008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD00ADADAD00C6C6C600D6D6D600FFE7B500D6D6D600C6C6C600A5A5A500A5A5
      A500000000000000000000000000000000000000000000000000F7EFE700EFEF
      EF00D6B5A500C6734A00BD633100C6947B00C6734200BD633100CE8C6B00E7D6
      CE00F7EFEF00C6BDB500000000000000000000000000000000009C9C9C009C9C
      9C00F7F7F700FFFFFF00D6D6D6009C9C9C004242420021182100211821003131
      310063636300848484008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ADADAD00D6D6
      D600EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00DEDEDE00FFE7B500C6C6
      C600A5A5A50000000000000000000000000000000000ADADAD00F7F7F700EFEF
      EF00BD633900C6633100BD734A00D6CECE00E7C6B500C6633100BD633100C673
      4A00EFEFEF00F7EFEF007373730000000000948C8C009C9C9C00EFEFEF00FFFF
      FF00EFE7E700C6C6C6009C9C9C008C8C8C009494940084848400636363003939
      3900182121002118210073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00DEDEDE000000
      0000EFEFEF00EFEFEF00EFEFEF0000000000EFEFEF00EFEFEF00EFEFEF00FFE7
      B500C6C6C600A5A5A500000000000000000000000000F7E7E700E7D6CE00C66B
      3900C6633100CE633100CE633100CE846300CE6B3900CE633100C6633100C663
      3100CE8C6B00EFEFEF00B5A59C009C9C9C009C9C9C00E7E7E700E7E7E700BDBD
      BD00A5A5A500B5ADAD00C6BDBD00A5A5A50094949400948C8C00949494009C94
      94008C8C8C006B6B6B0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      000000000000000000000000000000000000000000000000000000000000EFEF
      EF00FFE7B500A5A5A5000000000000000000D6CECE00F7F7F700D6947300C663
      3100CE6B3100CE633100CE6B3900CE846300CE734A00CE633100CE633100C663
      3100BD633100E7CEC600EFDED6006B6B6B0094949400ADADAD00A5A5A500ADAD
      AD00C6C6C600D6D6D600EFEFEF00EFEFEF00DEDEDE00C6C6C600ADADAD009C9C
      9C00948C8C00949494008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600DEDEDE00000000000000
      000000000000000000000000000000000000000000000000000000000000EFEF
      EF00EFEFEF00C6C6C600ADADAD0000000000EFDED600FFFFFF00C66B3900CE6B
      3900CE633100CE633100C66B3900CEC6C600EFC6AD00CE6B3900CE633100CE6B
      3100C6633100CE7B5A00F7F7EF00A5949400948C8C00ADADAD00C6C6C600CECE
      CE00C6C6C600DEDEDE00CECECE00A5ADA500BDBDBD00CECECE00D6D6D600D6D6
      D600C6C6C600B5B5B50094949400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ADADAD0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFEF
      EF00EFEFEF00DEDEDE00A5A5A50000000000EFDED600FFFFFF00CE6B3900CE6B
      3900CE633100CE633100CE633100BD947B00FFF7F700DEA58C00CE633100CE6B
      3100C66B3900C6734A00F7F7F700AD9C9400000000009C9C9C00CECECE00CECE
      CE00DEDEDE00C6C6C600B5B5B500A5D6A500BDC6BD00C6A5A500ADA5A500A5A5
      A500B5B5B500C6BDBD00A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF00EFEFEF009494940000000000EFDED600FFFFFF00D6734200D673
      4200CE6B3100CE633100CE633100CE633100D6B5A500F7F7F700D6845200CE6B
      3900CE6B3900D67B5200FFF7F700ADA59C0000000000000000009C9C9C00BDBD
      BD00ADADAD00ADADAD00E7E7E700F7EFEF00EFEFEF00EFE7DE00D6D6D600CECE
      CE00B5B5B5009494940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFEFEF00A5A5A50000000000EFDED600FFFFFF00E7845200DE7B
      4A00CE6B3900CE734200CE6B3900CE633100C6734200EFE7E700E7B59C00CE6B
      3900D6734200DE9C7B00FFF7EF00A59C9C000000000000000000000000009C9C
      9C00D6D6D600CECECE009C9C9C00BDBDBD00D6D6D600D6D6D600D6D6D600C6C6
      C600ADADAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600DEDEDE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D6D6D600BDBDBD0000000000F7EFE700EFDED600FFE7D600FF9C
      6300DE7B4A00D6C6BD00F7EFE700DE946B00DEAD9400F7F7F700DEA58C00DE7B
      4A00E7946B00FFF7F700DECEC600C6BDB5000000000000000000000000000000
      0000FFE7E700FFDECE00E7C6BD00E7C6BD00E7CEC600DED6CE00CECECE009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600000000000000000000000000F7E7DE00FFFFFF00FFCE
      AD00FF9C6300DE9C7B00FFFFFF00FFF7F700FFFFFF00FFFFFF00EF8C6300EF8C
      5A00FFE7D600FFFFFF00C6BDB500000000000000000000000000000000000000
      0000CE9C9C00FFDECE00FFCEBD00FFC6AD00FFBDA500FFAD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600EFEFEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDEDE00C6C6C60000000000000000000000000000000000EFDED600FFFF
      FF00FFEFD600FFE7B500F7C69C00F7C69C00F7BD9C00FFBD8C00FFBD9400FFE7
      D600FFFFFF00F7E7DE0000000000000000000000000000000000000000000000
      0000CE9C9C00FFDECE00FFCEBD00FFC6AD00FFBDA500F7AD9400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600EFEF
      EF0000000000000000000000000000000000000000000000000000000000DEDE
      DE00BDBDBD000000000000000000000000000000000000000000F7E7DE00EFDE
      D600FFFFFF00FFFFF700FFF7D600FFEFBD00FFE7B500FFE7BD00FFFFF700FFFF
      FF00F7EFE700ADADAD0000000000000000000000000000000000000000000000
      0000CE9C9C00FFDECE00FFCEBD00FFC6AD00FFBDA500F7AD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600DEDEDE00000000000000000000000000DEDEDE00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000EFDED600F7EFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7EFE700EFDE
      D60000000000000000000000000000000000000000000000000000000000CE9C
      9C00FFE7D600FFDECE00FFCEBD00FFC6AD00FFBDA500F7AD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600BDBDBD00ADADAD00BDBDBD00C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7EFE700EFDED600EFDED600EFDED600EFDED600EFDED600EFDED600F7EF
      E70000000000000000000000000000000000000000000000000000000000CE9C
      9C00CE9C9C00CE9C9C00CE9C9C00F7AD9C00F7AD9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFF00FFDC70000F83FE007F0030000
      E00FC003C0010000C0078001000100009103800000010000B383000000010000
      39210000000100007C610000800100007C710000C003000079390000E0070000
      33990000F00F0000B7DB8001F03F00009FF3C003F03F0000CFE7C003F03F0000
      E38FF00FE03F0000F83FF00FE07F000000000000000000000000000000000000
      000000000000}
  end
  inherited alActionsSupp: TActionList
    Left = 656
    Top = 8
    object actPurger: TAction
      Caption = 'Purger'
      Enabled = False
      OnExecute = actPurgerExecute
    end
    object actReset: TAction
      Caption = 'Reset'
      OnExecute = actResetExecute
    end
  end
  inherited alActionsStd: TActionList
    Tag = 1
    Left = 608
    Top = 56
    inherited actImprimer: TAction
      OnExecute = actImprimerExecute
    end
  end
  object iLstPageControl: TImageList
    AllocBy = 0
    DrawingStyle = dsFocus
    Height = 32
    Width = 32
    Left = 612
    Top = 8
    Bitmap = {
      494C010109004400040120002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F3F320F3F3F320000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F3F3F320D5D5D570B1B1B1CFA2A2A2FF9D9D9DFF9C9C9CDFBDBD
      BD8FE8E8E8300000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F4F4F420D7D7
      D770B5B5B5CFA9A8A8FFB6B5B4FFC8C5C4FFCECBCAFFBCB8B4FFB0ADA9FF9E9C
      9AFF8E8D8DFF939393DFB9B9B98FE7E7E7300000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F4F4F420DADADA70B9B9B9CFADADACFFB9B8
      B7FFC9C6C5FFD1CECDFFD1CECDFFD1CECDFFCECBCAFFBCB8B4FFB4AFAAFFB4AF
      AAFFB4AFAAFFAFABA7FF9A9896FF8A8A89FF919191DFE6E6E629FDFDFD020000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F4F4F420BDBDBDCFB1B1B1FFBCBABAFFCAC7C6FFD1CECDFFD1CE
      CDFFD1CECDFFD1CECDFFD1CECDFFD1CECDFFCECBCAFFBCB8B4FFB4AFAAFFB4AF
      AAFFB4AFAAFFB4AFAAFFB4AFAAFFB4AFAAFFAEAAA7FFE3E3E242FBFBFB04FEFE
      FE01000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EFEEEE40CAC8C7FFD1CECDFFD1CECDFFD1CECDFFD1CECDFFD1CE
      CDFFD1CECDFFD1CECDFFD1CECDFFD1CECDFFCECBCAFFBCB8B4FFB4AFAAFFB4AF
      AAFFB4AFAAFFB4AFAAFFB7B2ACF8BDB8B3E5C6C2BCCFF1F0EF31000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F5F4F348DEDCDAD3D8D5D4E7D2CFCDFBD1CECDFFD1CECDFFD1CE
      CDFFD1CECDFFD1CECDFFD1CECDFFD1CECDFFCECBCAFFBCB8B4FFB4AFAAFFB7B2
      ACF8BDB8B3E5C6C2BCCFC9C6C0C4C9C6C0C4C9C6C0C4E6E4E261000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F1F0EF60E4E2E1BFE4E2E1BFE4E2E1BFDEDCDAD3D8D5D4E7D2CF
      CDFBD1CECDFFD1CECDFFD1CECDFFD1CECDFFD1CECDF6C5C2BDE4C6C2BCCFC9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4DFDDDA7A000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EDEBEA83E4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4DC
      D2C3DAB986EBD6B683F7DBCFBCE5E6E3E3C5E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4D7D4D093000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EBE9E88FE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFDCA4
      46EBD98800FFD98800FFDDA039EDEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4CBC8C3C3000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E6E4E2B3E4E2E1BFE0CDB6CBD59646EBCF7400FFE0C08CD7D988
      00FFD98800FFD78400FFD37D00FFE1BE90D3E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4FBFBFB0C0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4E2E1BFE4E2E1BFD68D2AF3CF7400FFCF7400FFE4DCD2C3DCA4
      46EBDB9D38EFD07500FFCF7400FFE0BD90D3E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4F1F0EF310000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F7F730E4E2E1BFE1CBA8CFD88700FFD27F0DFBD9A662E3E4E2E1BFE4E2
      E1BFE1CFB6CBD69646EBD59039EEE9E2D9BCE8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4E7E6E3560000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F6F6F53CE4E2E1BFDDA954E7D98800FFD98D0DFBDEAF62E3E4E2E1BFE4E2
      E1BFE1CBA8CFDFB671DEE9E7E6BAEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4E2E1DE6E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F0EF60E4E2E1BFDDA954E7D98800FFD98800FFE1C59AD3E4DCD2C3DEAF
      62E3D98800FFD98D0DFBE8E1D8BEEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4D7D4D0930000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0EFEE6BE4E2E1BFDEAF62E3DC9E38EFDC9E38EFDDC09AD3DEC09AD3DA99
      2AF3D98800FFDB931CF7E6D0ADCBEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4CFCCC7B70000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EBE9E88FE4E2E1BFE4E2E1BFE4E2E1BFDAB27EDBCF7400FFD3882AF3D988
      00FFD98800FFE3CCAACEE9E7E6BAEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4FDFD
      FD0C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E8E6E4A7E4E2E1BFE4E2E1BFE4E2E1BFD3882AF3CF7400FFD17800FFD98D
      0DFBDEAF62E3E6E4E2BEE9E7E6BAEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4F1F0
      EF31000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE0CDB6CBD79D54E7DFC29AD3E4E2
      E1BFE4E2E1BFE6E4E2BEE9E7E6BAEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4EAE8
      E655000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FB18E4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2
      E1BFE4E2E1BFE6E4E2BEE9E7E6BAEBE9E7B8E8E6E4B9D3CFCBC1C9C6C0C4C9C6
      C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4E2E1
      DE6E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F8F7
      F730E4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2
      E1BFE4E2E1BFE6E4E2BEE9E7E6BAEBE9E7B8EFEDEDCFE9E7E5E0DAD8D3D8C9C5
      C0C6C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4D7D4
      D093000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F3F2
      F154E4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2
      E1BFE4E2E1BFEDECEBD2F4F3F3D5F5F5F5C2EFEFEF96ECECEC7EEFEFEF96F3F2
      F2C5E8E6E5DBDAD8D3D8C9C5C0C6C9C6C0C4C9C6C0C4C9C6C0C4C9C6C0C4CFCC
      C7B7000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F1F0
      EF60E4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFE4E2E1BFECEBEAD3EFEE
      EDD9EAEAEAC8E1E1E19EE7E7E781ECECEC7EECECEC7EECECEC7EECECEC7EECEC
      EC7EECECEC7EEFEFEF96F3F2F2C5E8E6E5DBDAD8D3D8C9C5C0C6C9C6C0C4C9C6
      C0C4FDFDFD0C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EBE9
      E88FE4E2E1BFE4E2E1BFE4E2E1BFECEBEAD3EFEEEDD9EAEAEAC8DBDBDBA1D3D3
      D38BD3D3D38BDADADA88E7E7E781ECECEC7EECECEC7EECECEC7EECECEC7EECEC
      EC7EECECEC7EECECEC7EECECEC7EECECEC7EEFEFEF96F3F2F2C5E8E6E5DBDAD8
      D3D8F1F0EF310000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EBE9
      E88FECEBEAD3EFEEEDD9EAEAEAC8DBDBDBA1D3D3D38BD3D3D38BD3D3D38BD3D3
      D38BD3D3D38BDADADA88E7E7E781ECECEC7EECECEC7EECECEC7EECECEC7EECEC
      EC7EECECEC7EECECEC7EECECEC7EECECEC7EECECEC7EEDEDED86F2F1F1AEFBFB
      FBBFFFFEFE200000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F9F9
      F8DBE7E6E5C5D3D3D38BD3D3D38BD3D3D38BD3D3D38BD3D3D38BD3D3D38BD3D3
      D38BD3D3D38BDADADA88E7E7E781ECECEC7EECECEC7EECECEC7EECECEC7EECEC
      EC7EECECEC7EECECEC7EECECEC86EFEFEFAEF5F4F3A7FCFBFB70FEFEFE200000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCFCFC30F6F5F488E8E7E6B4DCDCDBAFD3D3D38BD3D3D38BD3D3D38BD3D3
      D38BD3D3D38BDADADA88E7E7E781ECECEC7EECECEC7EECECEC7EECECEC7EECEC
      EC86EDEDECAEF2F1F0A7FAF9F870FDFDFD200000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FBFBFB30F3F2F188E5E4E2B4DBDAD9AFD3D3
      D38BD3D3D38BDADADA88E7E7E781ECECEC7EECECEC86EBEBE9AEEFEEEDA7F7F7
      F570FCFCFC200000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFAF930F1F0
      ED88E2E1DFB4DEDDDCADE6E5E3B8EDECEAA7F5F4F270FCFBFB20000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FBFBFA2000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EFEC
      E928EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7
      E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7
      E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7E332EBE7
      E332EBE7E332EBE7E332EBE7E332FBF9F90A0000000000000000FCFCFC03FBFB
      FB04000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CCC1
      B5CCE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9
      CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9
      CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9CDFFE1D9
      CDFFE1D9CDFFE1D9CDFFD4CABDFFEBE7E33200000000F2F2F20D9B876BAA8F7B
      5DC0BAAB9484CECAC342ECECEC13FCFCFC030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F3F3F320F3F3F320000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D3C9
      BFCCF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EB
      E1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EB
      E1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EBE1FFF2EB
      E1FFF2EBE1FFF2EBE1FFE1D9CDFFEBE7E332FBFBFB04C8C3BC468A6838FE7D6A
      46FFB99059FFB58B52FEAA8756EAAF9674B5C0B2A075D6D3D033F2F2F20DFDFD
      FD02000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00FDFDFD02FBFBFB04FDFDFD0200000000FFFF
      FF00FFFFFF0000000000FDFDFD02FBFBFB04FDFDFD02FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F3F3F320D5D5D570B1B1B1CFA2A2A2FF9D9D9DFF9C9C9CDFBDBD
      BD8FE8E8E8300000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D4CB
      C3CCF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3
      EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3
      EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3EDFFF7F3
      EDFFF7F3EDFFF7F3EDFFE5DFD6FFEBE7E332FDFDFD02DCD6CC388D6D3CFD826F
      4FFFC39D68FFC19A65FFBE9660FFBB935CFFB99058FFB48B52FEAB8A5DE0B19C
      7DA9C2B7A868DBD9D827F5F5F50AFEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FDFDFD02FCFCFC0300000000FFFFFF0000000000FBFBFB04EFEF
      EF10EFEFEF10FBFBFB0400000000FFFFFF0000000000FCFCFC03FDFDFD020000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F4F4F420D7D7
      D770B5B5B5CFA9A8A8FFB6B5B4FFC8C5C4FFCFCCCBFFBCB8B4FFB2AFABFF9E9C
      9AFF8E8D8DFF939393DFB9B9B98FE7E7E7300000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E4DFD4308E6D3EFC8977
      5AFFC7A16DFFCAA471FFCAB496FFB4A691FFB69D7BFFC7A473FFBF9862FFBB93
      5CFFB89057FFB28A52FCAC8D62D5B5A2869AC9C0B457E3E3E31CF9F9F9060000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00FCFCFC03FEFEFE0100000000D9D9D9268585857A454545BA222222DD1313
      13EC141414EB222222DD454545BA8585857AD9D9D92600000000FEFEFE01FCFC
      FC030000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000F4F4F420DADADA70B9B9B9CFADADACFFB9B8
      B7FFC9C6C5FFD3D0CEFFDBD8D6FFD9D7D3FFD4D2CEFFC2BEB9FFBBB7B0FFB6B1
      ACFFB5B0AAFFAFABA7FF9A9896FF8A8A89FF919191DFE6E6E629FDFDFD020000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E5DFD62E8F6F40FC9180
      67FFC5A06DFFCCA774FFC7B59DFF989898FF666666FFA0A09FFFADA79EFFB19C
      80FFC69F6BFFC29B65FFBE975FFFBB9259FFB58B52FFAD854EF7AA8D65C9B9A7
      8E8BCFC8BF48EAEAEA15FBFBFB04000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FBFB
      FB0400000000DEDEDE21575757A8040404FB000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF040404FB575757A8DEDEDE210000
      0000FEFEFE01FFFFFF0000000000000000000000000000000000000000000000
      000000000000F4F4F420BDBDBDCFB1B1B1FFBCBABAFFCAC7C6FFD1CECDFFD2CF
      CEFFDAD7D5FFE3E0DEFFE4E2DFFFDDDBD7FFD7D4D1FFC2BEB9FFBFBBB4FFBBB6
      AFFFB8B4ADFFB8B3ADFFB7B2ADFFBAB5B0FFAEAAA7FFE3E3E242FBFBFB04FEFE
      FE0100000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C917142FC9789
      73FFC4A06EFFD0AA78FFDECCB5FFC1C1C1FFA4A4A4FFA8A8A8FF989898FF8F86
      7AFFCDA874FFCAA571FFC6A16DFFC49E68FFC29A64FFBE965FFFBA9157FFB58A
      4FFFB1864AFFA8824CEFAD916BBCBDAE987DD3CFCA3AF0F0F00FFDFDFD020000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FBFBFB040000
      0000A4A4A45B0B0B0BF4000000FF040404FB030303FC000000FF000000FF0000
      00FF000000FF000000FF000000FF030303FC040404FB000000FF0C0C0CF39A9A
      9A6500000000FDFDFD02FFFFFF00000000000000000000000000000000000000
      000000000000EFEEEE40CAC8C7FFD4D1D0FFDEDCDBFFE4E2E1FFE0DDDAFFE7E4
      E0FFE8E5E3FFE5E2DFFFDAD8D4FFDBD9D4FFD9D7D4FFCAC6C1FFC1BDB7FFBEBA
      B4FFB8B4ADFFC0BCB6FFC6C2BCFFBDB8B2FBC6C2BCCFF1F0EF31000000000000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C947446FC9C90
      7DFFC09E6EFFD3B07FFFE1C9A8FFDED7CDFFC8C7C6FFC8C8C8FFC0C0C0FFCEC5
      B9FFD0AB79FFCFA976FFCDA773FFCBA671FFCAA46EFFC8A16BFFC49D67FFC198
      61FFBE945BFFBA9056FFB68B4FFFB5894CFFB18447FEAA8552E5B09874AFC3B6
      A36EDBD9D72AF6F6F60900000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FCFCFC03000000008B8B
      8B74000000FF030303FC060606F9000000FF0B0B0BF44D4D4DB289898976A6A6
      A659A6A6A659898989764C4C4CB30A0A0AF5000000FF070707F8000000FF6B6B
      6B9400000000FDFDFD02FFFFFF00000000000000000000000000000000000000
      000000000000F5F4F348E4E0DEEBE7E5E3FFE7E6E5FFE7E5E4FFE6E3E1FFE7E4
      E0FFE7E4E1FFDAD7D4FFDAD7D5FFDFDDDAFFD4D2CEFFC3BFBAFFC2BDB7FFC2BE
      B8FFC0BBB5FFC6C1BBFFC8C3BDFFBBB7AFFFC3BEB9DAE6E4E261000000000000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C957648FC9E95
      86FFBF9E70FFD5B385FFD5B384FFD5B383FFD6B587FFDFC4A0FFE8D5BBFFE9D8
      C0FFD2AD7CFFD0AB79FFD0AA77FFCFA976FFCEA873FFCDA671FFCBA46EFFC9A1
      6BFFC59D65FFC39A62FFC1985FFFBE945AFFBC9156FFBA8F53FFB68B4EFFB286
      48FFAF8345FCBA9C70BBFBFBFB04000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FCFCFC0300000000A2A2A25D0000
      00FF050505FA040404FB000000FF6464649BE3E3E31C00000000FEFEFE01FFFF
      FF00FFFFFF00FEFEFE0100000000E3E3E31C6464649B000000FF7575758A0000
      0000FEFEFE01FFFFFF0000000000000000000000000000000000000000000000
      000000000000F1F0EF60E3E0DFCFE4E1DEFFE7E4E1FFE8E6E4FFE9E6E5FFE7E4
      E0FFDFDCD8FFD7D5D1FFD9D6D4FFE3E1DFFFDAD7D5FFC3BFBAFFC3BEB8FFC4BF
      B9FFC5C1BAFFC6C2BBFFC7C2BCFFBBB7AFFFB8B3ADFFDBD8D489000000000000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C97794CFC9D99
      8DFFBB9B70FFD8B98DFFD9BA8DFFD8B88BFFD7B78AFFD6B688FFD7B587FFD6B4
      85FFD3B180FFD3AF7EFFD1AC7BFFD0AB79FFD1AB77FFCFA974FFCDA771FFCAA3
      6DFFC8A069FFC79E65FFC69D63FFC39A60FFC3995FFFC2975DFFBF955AFFBC91
      57FFBA8F53FFB78B4EFFF5F0EA1C0000000000000000FFFFFF0000000000FFFF
      FF00FEFEFE01FEFEFE01FEFEFE01FCFCFC0300000000DBDBDB240F0F0FF00000
      00FF010101FE050505FAA8A8A85700000000FDFDFD02FBFBFB04F9F9F906FAFA
      FA05FBFBFB04FBFBFB04FCFCFC0300000000FFFFFF00CACACA35F7F7F708FFFF
      FF00FEFEFE0100000000FFFFFF00000000000000000000000000000000000000
      000000000000EDEBEA83E3E0DFCFE1DEDCFFE6E3E0FFE9E6E3FFE2E0DDFFE1DA
      CFFFDBBB87FFD9B984FFD8CCB8FFE4E2DFFFDDDBD9FFCDC9C6FFC6C2BDFFC5C2
      BDFFC5C0BAFFC6C1B9FFC6C2BBFFBBB7AFFFB8B4AEFFCBC7C2B8000000000000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFF
      FFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFFFFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFF
      FFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C9A7D53FC9A9B
      95FFB6986EFFDBBE95FFDBBD94FFDBBD93FFDABC91FFDABB90FFD9BA8EFFD8B8
      8BFFD7B688FFD6B485FFD4B181FFD4B07FFFD4AE7DFFD1AC78FFCEA873FFCCA5
      6FFFC9A16AFFC79F67FFC89E66FFC69D63FFC59C61FFC4995FFFC49A5FFFC399
      5EFFC2985DFFC0955BFFF4EDE32A000000000000000000000000000000000000
      00000000000000000000FFFFFF00FCFCFC03000000005C5C5CA3000000FF0505
      05FA000000FFABABAB5400000000FCFCFC03FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000FDFDFD02FCFCFC0300000000FDFDFD02FEFE
      FE0100000000FFFFFF0000000000000000000000000000000000000000000000
      000000000000EBE9E88FE4E1E0C3E1DFDCFFE2E0DDFFE5E2DFFFE3E0DDFFDCA3
      45FFD98800FFD98800FFDC9F38FFE6E3E0FFDFDCD9FFCCC9C5FFC6C2BEFFC6C2
      BEFFC5C2BDFFC6C2BCFFC4C0B9FFBEBAB4FFC3BFB9E9CBC7C2C7000000000000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C9F8259FB919B
      96FFB2946BFFDDC29BFFDDC29BFFDDC29AFFDCC099FFDCBF97FFDBBE95FFDABD
      92FFD9BB8FFFD8B98CFFD7B688FFD5B385FFD5B282FFD4AF7EFFD1AC79FFCEA8
      73FFCCA56FFFC9A16AFFC9A067FFC69C63FFC69C62FFC69C61FFC69C61FFC59A
      60FFC3985DFFC3985DFFF0E7D93A0000000000000000FFFFFF0000000000FEFE
      FE01EFEFEF10EDEDED12ECECEC13F5F5F50ACCCCCC33080808F7020202FD0000
      00FF5A5A5AA500000000E8E8E817EDEDED12EEEEEE11EEEEEE11EDEDED12EFEF
      EF10FEFEFE0100000000FFFFFF0000000000FFFFFF00FCFCFC03FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000E5E3E1BBE3E0DFCBDFCCB4FFD59645FFCF7400FFDEBE8AFFD988
      00FFD98800FFD78400FFD37D00FFDEBA8BFFE1DEDBFFCDC9C4FFC6C2BCFFC6C2
      BCFFC7C3BDFFC6C2BCFFC1BCB6FFC3BFBAEDC9C6C0C4C9C6C0C4FBFBFB0C0000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72CA0845CFB91A4
      9FFFAD9068FFDFC6A2FFDFC5A1FFDFC4A0FFDEC39EFFDDC29DFFDDC19BFFDCC0
      99FFDCC097FFDBBD94FFD8BA8FFFD7B88BFFD7B588FFD6B484FFD2AE7EFFCFAB
      78FFCEA874FFCBA46FFFCAA26BFFC89F66FFC79E64FFC89E63FFC79C62FFC69B
      60FFC59A5FFFC59A5FFFECDFCE4C0000000000000000FEFEFE0100000000EFEF
      EF10252525DA111111EE161616E9161616E90D0D0DF2000000FF000000FF0101
      01FE151515EA151515EA141414EB151515EA151515EA161616E9111111EE2525
      25DAEFEFEF1000000000FEFEFE01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E4E2E1BFE3E1E0FFD68E2AFFCF7400FFCF7400FFE3DBD0FFDDA4
      46FFDA9C37FFD07500FFCF7400FFD8B486FFE0DCD9FFC8C4BEFFC2BCB6FFC4BF
      B8FFC4BFB9FFBFBBB5FFBEBAB3FFC1BDB7E5C2BDB7DEC7C4BECBF1F0EF310000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72C99805CFB9DBB
      BCFFA78B64FFE1C9A7FFE1C9A7FFE0C8A6FFE1C8A5FFDFC6A3FFDFC5A1FFDEC3
      9FFFDEC49EFFDDC29BFFDCBF97FFDABC92FFD9BA8FFFD6B689FFD4B284FFD3B0
      80FFD0AC7BFFCFA976FFCBA671FFCBA36DFFCAA169FFC9A067FFC99F65FFC79D
      63FFC69B60FFC69B60FFE9D8C2600000000000000000FEFEFE0100000000EEEE
      EE11111111EE000000FF010101FE000000FF010101FE010101FE000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF010101FE000000FF1111
      11EEEEEEEE1100000000FEFEFE01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8F7F730E4E2E1BFE1CBA8FFD88700FFD27F0EFFDCA964FFE5E2DFFFE2E0
      DEFFDECCB4FFD69747FFD48F38FFDDD5CAFFD7D5D1FFC2BFB9FFBEBAB3FFC1BD
      B7FFC1BDB7FFC1BCB6FFBCB8B0FFBAB5AFFFB9B5AFFFBCB8B1FBE5E3E15D0000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCFFFFFFFFFFFFFFFFF4EBE5FFE2C9B7FFD1AD8EFFD1AB8CFFDABCA4FFEBDB
      CFFFF0EBE4FFF1EDE7FFF9F8F5FFFFFFFFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFF
      FFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFFFFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E6E0D72CA08866FBA1C4
      CAFFA18A66FFE3CCABFFE4CCACFFE2CBAAFFE2CAAAFFE2CBAAFFE2CAA8FFE2C8
      A6FFE0C7A3FFDFC5A0FFDDC29DFFDDC29AFFDCBE96FFD8BA90FFD1B48BFFD2B2
      85FFD2B082FFD1AE7DFFCFAB79FFCEA874FFCCA56FFFCAA26BFFCAA169FFC9A0
      67FFC69D63FFC79D63FFE6D2B8730000000000000000FEFEFE0100000000F4F4
      F40B6262629D545454AB585858A7545454AB0A0A0AF5000000FF000000FF3232
      32CD5C5C5CA3555555AA575757A8575757A8575757A8575757A8545454AB6262
      629DF4F4F40B00000000FEFEFE01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F6F6F53CE4E2E1BFDBA852FBD98800FFDA8E0EFFDDAE61FFDFDCDAFFDAD7
      D3FFD7C19CFFD7AE69FFE0DEDDFFE1DFDCFFD8D5D1FFC7C4BEFFC1BDB7FFC3BE
      B8FFC4C0BAFFC2BDB7FFC0BBB5FFC0BCB6FFC1BEB8FBC8C4BFCBE2E1DE6E0000
      000000000000000000000000000000000000000000000000000000000000D7CF
      C8CCF2E7DFFFD9AE8EFFDFA67AFFEEB589FFF0B78BFFF0B78BFFEFB68AFFE7AD
      81FFD8A47DFFE3CCBAFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E8E2DA299E8665FBA1C8
      D1FF998B6AFFE4CDAEFFE4CEAFFFE4CEAEFFE3CDADFFE4CDADFFE3CCACFFE3CB
      AAFFE2CAA8FFE1C8A6FFDFC6A2FFDEC49FFFDDC29CFFDABE96FFB2A99AFF8091
      A5FF9D9A95FFB5A287FFCCAC7EFFCEAB79FFCDA775FFCBA672FFCBA46FFFCAA2
      6CFFC8A068FFC9A168FFE2CDAF86000000000000000000000000000000000000
      000000000000FEFEFE0100000000F0F0F00F141414EB000000FF000000FFA5A5
      A55A00000000FBFBFB0400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F1F0EF60E4E2E1BFDDA953EFD98800FFD98800FFDEC397FFE0D9CEFFDBAC
      5FFFD98800FFD98D0EFFE4DDD2FFE7E4E2FFDDDAD8FFC7C3BEFFC5C1BBFFC6C2
      BDFFC6C2BDFFC8C3BDFFC5C1BBFFC4BFB9FFC4BFB9E9C9C6C0C4D7D4D0930000
      000000000000000000000000000000000000000000000000000000000000C9AF
      99CCDDA57BFFF0B78BFFF0BA91FFF5D0B4FFF8DECAFFF8E0CEFFF6D7BFFFF2C2
      9EFFF0B78BFFE8AF83FFD7AE8FFFFCF9F8FFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E8E2DA299D8667FB9EC9
      D0FF928C6FFFE5D0B2FFE5D0B1FFE5D0B1FFE5D0B1FFE5CFB0FFE4CEAFFFE4CD
      ADFFE2CBAAFFE1CAA8FFE0C8A6FFDFC6A3FFDEC4A0FFDBC19CFFB1AB9FFF698B
      B6FF6A8AB4FF698AB4FFBEA98BFFCFAE7FFFCEAB7BFFCCA877FFCCA774FFCCA6
      72FFCCA570FFCBA46EFFDEC6A59C000000000000000000000000000000000000
      000000000000FEFEFE0100000000F0F0F00F141414EB000000FF000000FFA5A5
      A55A00000000FBFBFB0400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0EFEE6BE4E2E1BFDEAF63F7DC9F39FFDDA039FFDCBE98FFDDBF98FFDB98
      29FFD98800FFD9921AFFE2CCA8FFE1DEDCFFDDDAD8FFC7C3BEFFC4C1BBFFC6C2
      BEFFC6C2BDFFC7C2BDFFC8C4BEFFC8C4BEFFBCB8B0FBC6C2BDCFCFCCC7B70000
      0000000000000000000000000000000000000000000000000000E8D6C94EE1A8
      7CFCF0B78BFFF6D4BAFFFEFAF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
      FEFFFAE7D8FFF1BC93FFEDB488FFD8AF91FFDDD3C4FFDED4C5FFF1EDE7FFFFFF
      FFFFDED4C5FFDED4C5FFF1EDE7FFFFFFFFFFDED4C5FFDED4C5FFF1EDE7FFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E8E2DA29A99379FB99C7
      CCFF898B71FFE7D2B5FFE6D1B4FFE6D1B4FFE6D1B4FFE6D1B3FFE6D0B2FFE4CE
      B0FFE3CDADFFE2CAAAFFE0C9A8FFDFC8A5FFDEC5A2FFDCC29EFFB5AEA2FF6A8D
      B8FF6A8CB7FF6A8CB7FFBEAC91FFD2B387FFD1B083FFCEAD7EFFCDAA7AFFCEAB
      79FFCDA977FFCBA673FFD9BF9BB10000000000000000FEFEFE0100000000F4F4
      F40B6262629D545454AB585858A7545454AB0A0A0AF5000000FF000000FF3232
      32CD5C5C5CA3555555AA575757A8575757A8575757A8575757A8545454AB6262
      629DF4F4F40B00000000FEFEFE01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EBE9E88FE5E3E3DFE7E5E4FFE6E5E3FFDEB581FFCF7400FFD38829FFD988
      00FFD98800FFD8C39EFFDDDBD8FFE2E0DEFFDFDDDBFFCBC7C2FFBEBAB3FFC6C2
      BDFFC6C2BCFFC7C2BCFFC7C2BDFFC7C2BDFFBBB7AFFFB8B5AFF8C8C4BFC8FDFD
      FD0C0000000000000000000000000000000000000000F8F4F013D8A37AECF0B7
      8BFFF7DCC6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFCF3ECFFF1BC93FFE8AF83FFD9BEA8FFF1EDE7FFF9F8F5FFFFFF
      FFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFFFFFFF1EDE7FFF1EDE7FFF9F8F5FFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E8E2DA29AD9984FBA9D5
      E2FF828C75FFE7D2B6FFE7D2B6FFE7D3B7FFE8D3B7FFE7D2B5FFE6D1B4FFE6D0
      B1FFE4CEAFFFE3CCADFFE1CAAAFFE0C9A8FFE0C7A5FFDDC5A2FFB7B0A5FF6C8F
      BAFF6C8EBAFF6B8EB9FFBDAC94FFD3B58CFFD3B489FFD1B285FFCFAF81FFCFAD
      7FFFCEAB7CFFCDAA7AFFD6BA94C70000000000000000FEFEFE0100000000EEEE
      EE11111111EE000000FF010101FE000000FF010101FE010101FE000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF010101FE000000FF1111
      11EEEEEEEE1100000000FEFEFE01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E8E6E4A7E5E3E2D3E7E6E5FFE7E5E3FFD4892AFFCF7400FFD17800FFDA8E
      0EFFDFB163FFD9D7D3FFD6D3D0FFE2E0DEFFE4E3E1FFCECBC8FFBEBAB4FFBFBB
      B5FFC6C2BCFFC6C1BAFFC6C1BAFFC6C2BBFFBBB7AFFFB7B3ACFFBEB9B3E5F1F0
      EF310000000000000000000000000000000000000000DEC0A982EEB589FFF4CA
      AAFFFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFECEB
      EAFFFFFFFFFFFFFFFFFFFAE7D8FFF0B78BFFD8A47DFFFDFCFCFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E8E2DA29B2A092FBB1DE
      EDFF849E8EFFDCC6A9FFE7D3B8FFE8D4B8FFE8D4B8FFE7D3B7FFE7D3B5FFE5D1
      B3FFE5CFB1FFE4CEAFFFE2CCACFFE1CAA9FFDFC7A6FFDEC6A3FFB9B2A7FF6D91
      BDFF6D91BCFF6D90BCFFBDAD97FFD5B890FFD4B68CFFD1B388FFD0B085FFD0B1
      84FFCEAE81FFCEAD7FFFD3B68EDF0000000000000000FEFEFE0100000000EFEF
      EF10252525DA111111EE161616E9161616E90D0D0DF2000000FF000000FF0101
      01FE151515EA151515EA141414EB151515EA151515EA161616E9111111EE2525
      25DAEFEFEF1000000000FEFEFE01000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E5E2E1C3E5E3E2DBE7E5E3FFE6E3E0FFDFCCB5FFD79E55FFDFC39AFFE6E3
      DFFFE7E4E1FFD9D7D3FFD7D4D2FFD7D4D2FFDEDCDAFFCFCCC8FFC2BEB8FFC4BF
      BAFFC6C1BBFFC5C1BCFFC5C1BBFFC4BFB8FFBDB9B3FFC0BDB7F0C6C2BDCFEAE8
      E6550000000000000000000000000000000000000000D8A680DDF0B78BFFFBED
      E3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD6D3D0FFCCC9
      C6FFFFFFFFFFFFFFFFFFFEFEFEFFF2C29EFFE7AD81FFEBDBCFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFEBE7E4FFEBE7E33200000000E8E2DA29B9AAA1FAB1E0
      EEFF8AB5ACFFCCB697FFE8D4B9FFE7D4B8FFE8D4B8FFE6D3B7FFE7D3B7FFE6D1
      B4FFE5D0B2FFE4CEB0FFE2CDAEFFE0CAAAFFDFC8A7FFDDC6A4FFBAB4A9FF6F94
      C0FF6F93BFFF6E93BFFFBEB09CFFD7BB94FFD4B78FFFD1B58BFFD0B389FFD0B2
      87FFD1B186FFCFB084FFD0B186F50000000000000000FFFFFF0000000000FEFE
      FE01EFEFEF10EDEDED12ECECEC13F5F5F50ACCCCCC33080808F7020202FD0000
      00FF5A5A5AA500000000E8E8E817EDEDED12EEEEEE11EEEEEE11EDEDED12EFEF
      EF10FEFEFE0100000000FFFFFF0000000000FFFFFF00FDFDFD02FFFFFF000000
      0000FFFFFF00000000000000000000000000000000000000000000000000FBFB
      FB18E3E0DFCFE6E4E3FFE7E5E3FFE6E4E2FFE6E4E3FFE6E5E4FFE6E5E3FFE6E4
      E3FFE5E2DFFFDEDCDAFFE4E1DFFFE5E3E0FFD6D4D0FFCBC7C2FFC5C1BBFFC6C2
      BDFFC6C2BCFFC7C3BDFFC6C2BCFFC1BDB7FFC3BFB9EDC9C6C0C4C9C6C0C4E2E1
      DE6E00000000000000000000000000000000F7F2EE16DDA377FFF0BB92FFFEFE
      FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBEAE9FFB7B1ADFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF6D7BFFFEFB68AFFBC9FA3FFB3B3E8FFB3B3
      E8FFB3B3E8FFB3B3E8FFB3B3E8FFB3B3E8FFB3B3E8FFB3B3E8FFB3B3E8FFB3B3
      E8FFB3B3E8FFB3B3E8FFA7A5D8FFE4E2EA3300000000E8E2DA29BDAFACFAB1E1
      EFFF93D5D6FFB7A07FFFE8D5BBFFE8D5BAFFE8D4B9FFE6D3B8FFE7D3B7FFE6D1
      B5FFE5D0B3FFE4CFB1FFE2CDAFFFE2CBADFFE0C9AAFFDEC7A6FFBDB7ABFF7096
      C2FF7096C2FF7095C1FFBDB19EFFD7BC96FFD5B992FFD4B890FFD2B58DFFD1B4
      8BFFD2B48BFFD1B389FFD0B287FFFBF9F6110000000000000000000000000000
      00000000000000000000FFFFFF00FCFCFC03000000005C5C5CA3000000FF0505
      05FA000000FFABABAB5400000000FCFCFC03FFFFFF0000000000000000000000
      0000FFFFFF00FFFFFF0000000000FDFDFD02FCFCFC0300000000FDFDFD02FEFE
      FE0100000000FFFFFF000000000000000000000000000000000000000000F8F7
      F730E4E2E1BFE4E2E2E7E8E6E6FFE7E4E2FFE7E4E2FFE7E4E2FFE8E6E3FFE6E3
      E1FFE0DEDCFFE3E0DEFFE7E4E1FFE4E2DFFFE2E1DEFFE0DEDBFFD5D2CEFFC6C1
      BAFFC7C3BCFFC7C2BCFFC5C0BBFFC2BEB8FFC4C1BBE5C9C6C0C4C9C6C0C4D7D4
      D09300000000000000000000000000000000F0E6DE2EE3A97DFFF2C39FFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D1CFFF7E756EFFFEFDFDFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8E0CEFFF0B78BFFAF8D9FFF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF7F7FEDFFD7D7F13500000000E8E2DA29B9A68BFAB5E6
      ECFF9EEFF6FF8AA697FFB29F81FFCFBB9EFFE5D3BAFFE8D6BCFFE7D4B8FFE6D2
      B6FFE5D2B5FFE4CFB2FFE3CEB0FFE3CEAFFFE1CBACFFDFC8A8FFBFB8ADFF7298
      C5FF7198C4FF7197C4FFBDB2A0FFD6BC97FFD5BB95FFD6BA95FFD5B992FFD3B7
      8FFFD2B58DFFD2B58CFFD2B58CFFF6F1EA2C00000000FFFFFF0000000000FFFF
      FF00FEFEFE01FEFEFE01FEFEFE01FCFCFC0300000000DBDBDB240F0F0FF00000
      00FF010101FE050505FAA7A7A75800000000FDFDFD02FBFBFB04F9F9F906FAFA
      FA05FBFBFB04FBFBFB04FCFCFC030000000000000000CACACA35F7F7F7080000
      0000FEFEFE0100000000FFFFFF0000000000000000000000000000000000F3F2
      F154E4E2E1BFE5E3E2EFE6E4E4FFE7E5E4FFE7E5E3FFE7E4E1FFE5E2E0FFE4E2
      DFFFE4E1DFFFEDEBE9FFF3F2F0FFEBEAE6FFC8C7C2FFB4B2AEFFCECDC9FFF7F6
      F4FFEAE8E6FFD9D7D3FFC4C0BAFFC1BDB7FFC1BDB7FFC8C4BECFC9C6C0C4CFCC
      C7B700000000000000000000000000000000F2E9E228E1A87CFFF2C19CFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0EFEEFFA39C97FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8DECAFFF0B78BFFAD8CA2FF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF7F7FEDFFD7D7F13500000000E9E3DB28BBA383FBE1DF
      D8FFDBEDEEFFC2E6E9FFA3D4D8FF88B6B2FF859F91FF989D87FFB1A185FFCAB4
      96FFE1CEB3FFE6D3B8FFE3CEB2FFE2CDB0FFE1CBADFFE0CAAAFFBFB9AEFF739A
      C7FF739AC7FF729AC6FFBFB4A4FFD5BB98FFD5BB96FFD6BC97FFD6BB96FFD4B9
      93FFD2B790FFD4B790FFD2B68FFFF2E9DE480000000000000000000000000000
      00000000000000000000FFFFFF0000000000FCFCFC0300000000A2A2A25D0000
      00FF050505FA040404FB000000FF6464649BE3E3E31C00000000FEFEFE01FFFF
      FF00FFFFFF00FEFEFE0100000000E3E3E31C6565659A000000FF7373738C0000
      0000FEFEFE01FFFFFF000000000000000000000000000000000000000000F1F0
      EF60E4E2E1BFE5E3E3DFE7E5E5FFE6E5E4FFE6E3E1FFE6E3E0FFECEAE8FFF3F2
      F1FFF5F6F7FFF0F1F1FFEAEAEAFFD5D4D0FFD2D2D0FFD8D7D4FFE3E1DAFFEEEC
      E8FFEBEAE7FFE8E7E6FFE8E8E6FFE4E2DFFFD5D2CEFFC6C1BCE2C9C6C0C4C9C6
      C0C4FDFDFD0C000000000000000000000000FCFAF808DAA176F9F0B88CFFFEFA
      F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0BCB8FFF1F0EFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D0B4FFEEB589FFA088B2FF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF7F7FEDFFD7D7F13500000000FAF9F807B39975D5C1B5
      8CFFB9EFCAFFC6EFD4FFD4EEDCFFCAD2C8FFB8A9A6FFB4C1BFFF9DC6C9FF8CBF
      BEFF87A89CFF949E89FFABA185FFC4AD8CFFD8C3A6FFE3CFB3FFC1BCB1FF749C
      C9FF749CC9FF749CC8FFBFB5A6FFD7BE9BFFD5BC98FFD6BC98FFD7BD98FFD7BC
      97FFD5BA95FFD4B993FFD4B993FFECE1D1680000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FCFCFC03000000008B8B
      8B74000000FF030303FC060606F9000000FF0A0A0AF54C4C4CB389898976A6A6
      A659A6A6A659898989764C4C4CB30A0A0AF5000000FF070707F8000000FF6B6B
      6B9400000000FDFDFD02FFFFFF0000000000000000000000000000000000EBE9
      E88FE4E2E1BFE4E2E1BFE7E5E4EBEFEEEDFFF5F3F2FFEFEEECFFF0EEEAFFEDEB
      E7FFF0EDE8FFF5F2EFFFDEDDDAFFD9D8D5FFDEDCD9FFDAD8D4FFD2D2D0FFD3D2
      D0FFD5D4D2FFD4D3CEFFC3C2B8FFB7B6AEFFC5C4BFFFE7E6E4F5E8E6E5DBDAD8
      D3D8F1F0EF3100000000000000000000000000000000DAAF8EBDF0B78BFFF8E1
      CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F6F5FFBBB6B2FFFFFF
      FFFFFFFFFFFFFFFFFFFFFEFAF7FFF0BA91FFDFA57AFF948BDEFF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8FF7FF8F8F
      F7FF8F8FF7FF8F8FF7FF7F7FEDFFD7D7F1350000000000000000E0D8CD38BE9F
      74FCC5A87DFFC3B48AFFC0C198FFBCCDA4FFB0CDA8FFB8BDA6FFCBB7B1FFC9B6
      B6FFBABBBEFFB0CACBFFA0CFD1FF8FC8C9FF89B1A8FF919F8BFF93A2AEFF7CA3
      CDFF7CA3CDFF7AA1CCFFC0B8ACFFD8C09EFFD6BE9CFFD5BC99FFD8BE9BFFD6BD
      99FFD5BC98FFD6BC97FFD5BA96FFE7DBC6870000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FBFBFB040000
      0000A4A4A45B0B0B0BF4000000FF040404FB030303FC000000FF000000FF0000
      00FF000000FF000000FF000000FF030303FC040404FB000000FF0C0C0CF39999
      996600000000FDFDFD02FFFFFF0000000000000000000000000000000000EBE9
      E88FECEBEAD3F2F0EEE7F2F0EDF4F1EFE9FFF1EEE9FFDDDCD8FFE2DFDAFFE7E3
      DDFFE9E6E1FFF1F0EEFFE5E3DEFFEBEAE7FFF5F4F3FFDAD9D6FFD7D6D3FFD3D2
      CEFFDBD9D6FFD8D7D1FFC5C4BBF7CECDC8CFE4E3E0BFE9E8E5C7F2F1F1AEFBFB
      FBBFFFFEFE2000000000000000000000000000000000E7D4C553E7AE82FFF1BD
      95FFFDF8F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB2ADA9FFFFFF
      FFFFFFFFFFFFFFFFFFFFF6D4BAFFF0B78BFFB38987FF7F7FEDFF7F7FEDFF7F7F
      EDFF7F7FEDFF7F7FEDFF7F7FEDFF7F7FEDFF7F7FEDFF7F7FEDFF7F7FEDFF7F7F
      EDFF7F7FEDFF7F7FEDFF7373E5FFD7D7F1350000000000000000FEFEFE01B296
      6DE5D2B083FFD0AF82FFD0AF81FFD1AF82FFD1B083FFCEAE81FFC6A980FFC2A9
      8DFFC1AE9EFFC3B6ACFFC5BCB1FFC0BFB1FFB0C0BCFF7CA8C9FF739CC9FF749D
      CAFF759ECBFF7FACC4FFA0A188FFBAA481FFCDB28EFFDAC3A4FFD8C1A1FFD7BE
      9CFFD5BC99FFD5BC99FFD7BD9AFFE2D1B9A90000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF00FBFB
      FB0400000000DEDEDE21575757A8040404FB000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF040404FB575757A8DEDEDE210000
      0000FEFEFE01FFFFFF000000000000000000000000000000000000000000F9F9
      F8DBE7E6E5C5D5D4D492DBD9D6B7E4E1DCDBE5E2DDFFE2E0DBFFE5E4E0FFE3E0
      DBFFE9E8E6FFEFEEEDFFEDEAE5FFF3F0ECFFF4F2EFFFE1DFDAFFCCCCC3FFBCBB
      B2FFCDCCC7FFDEDCD6FFEBEBEA96EFEFEFAEF5F4F3A7FCFBFB70FEFEFE200000
      0000000000000000000000000000000000000000000000000000D7AC8BBCEFB6
      8AFFF3C5A2FFFDF8F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAD8D6FFF5F4
      F4FFFEFEFEFFF7DCC6FFF0B78BFFDDA57AF7DAD0D74CD7D7F135D7D7F135D7D7
      F135D7D7F135D7D7F135D7D7F135D7D7F135D7D7F135D7D7F135D7D7F135D7D7
      F135D7D7F135D7D7F135D7D7F135F6F6FB0B000000000000000000000000BDAA
      8D9ED7B88FFFD4B387FFD3B285FFD4B285FFD4B285FFD5B386FFD6B487FFD6B4
      87FFD5B386FFD8B990FAC7AE8CD6B7A68DFE7998B9FF7198C4FF7199C5FF749A
      C4FFA0AFC4FFB9D5E6FFA7D6E3FF93D2DAFF8BC3C1FF8EA998FFA0A389FFB6A5
      82FFCAAD86FED8C1A1FCDAC3A3FFE0CEB5C10000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00FCFCFC03FEFEFE0100000000D9D9D9268585857A454545BA222222DD1313
      13EC131313EC222222DD454545BA8585857AD9D9D92600000000FEFEFE01FCFC
      FC030000000000000000FFFFFF00000000000000000000000000000000000000
      0000FCFCFC30F6F5F488E8E7E6B4DCDCDBAFD5D5D592E9E9EAE9EBEDEFFFD5D6
      D0FFD0CEC7FFCCCAC3FFC9C7C1FFE3E4E4FFEEF0F1FFEDECEBFFD7D7D0FFD3D1
      CCFFDBD9D6FFE8E6E4CFFAF9F870FDFDFD200000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7F2EE17D6A4
      7EDAEFB68AFFF1BD95FFF8E1CFFFFEFAF8FFFFFFFFFFFFFFFFFFFEFEFEFFFBED
      E3FFF4CAAAFFF0B78BFFE1A87CFCE6D1C15B0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F2EF
      EB16C2B19A88BDA587C6BB9F79F6D1B48EF8DABC92FFD8B88CFFD8B789FFD7B6
      89FFD7B68AFFE6D4BD9A00000000EDEDEB1CCCCFD254ADB6C08D909FAEC6B1A2
      8CF6D1B48CFDCAB190FFCAB7A6FFCAC0C2FFC7CDE0FFBDD7EAFFAAD7E5FF97D5
      DBFFB7B6ABBFE2D2BF50DBC8AD7EF4EEE63E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0000000000FDFDFD02FCFCFC0300000000FFFFFF0000000000FBFBFB04EFEF
      EF10EFEFEF10FBFBFB0400000000FFFFFF0000000000FCFCFC03FDFDFD020000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FBFBFB30F3F2F188E7E6E5BBEDEEEEF8E9EA
      EBFFDCDAD6FFDEDCD8FFE2E0DCE7E6E5E3B6ECEAE6FFEEEBE5FFF3F1ECFFF8F7
      F4FFF0EEECFFF4F3F17000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F2
      EE17D7AC8BBCE7AE82FFF0B78BFFF0B88CFFF2C19CFFF2C39FFFF0BB92FFF0B7
      8BFFEEB589FFD8A37AECE8D6C94E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F6F4F20ED8D0C448C7B8A480C1AC90BDBFA47FF0D2B6
      90F5DDC19CF6F9F6F21B0000000000000000000000000000000000000000FAF9
      F708E5DCCF3BD9C9B374D4BD9FAFCEB089E8CEB089FCD2BEA9FFD3C6C5FFD4C7
      B9FFE0D5C5B50000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00FDFDFD02FBFBFB04FDFDFD0200000000FFFF
      FF00FFFFFF0000000000FDFDFD02FBFBFB04FDFDFD02FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBFAF930F2F2
      F2CFE5E4E0FFE2E0DCE8E6E5E3C0EDECEAA7F6F4F270FBFAF830000000000000
      0000FEFEFE10FEFEFE1000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7D4C553DAAF8EBDDAA176F9E1A87CFFE3A97DFFDDA377FFD8A6
      80DDDEC0A982F8F4F01300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F7F70ADFD7
      CC3FEAE5DC2D0000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EFE8E026DFCFBB60DAC4A89AD9BF
      9DC7EFE3D3700000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFA
      FA30F7F7F560FBFBFA2000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FCFAF808F2E9E228F0E6DE2EF7F2EE160000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F6F5F40FEEE4D84AEFDA
      C47EEFD2B4A6EFCCA8C2F1CAA3D2EDC69EDAEBC59ED5EBC9A6C3E7CBADAAE3D0
      BB81DFD7CE4CE8E8E817FAFAFA05000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FBFBFB05EFE3D653EECFAEB4E9C194F6FFD1A0FFFFD1
      9FFFFFD09EFFCDA982FF5D4C3BFF856B50FFF2C291FFFCC997FFFFCC99FFFFCC
      99FFFECB98FFEFC397EED9C0A6A7D1CDC844EEEEEE11FEFEFE01000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005548
      D900BBB6EA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD02EFE4D557F0CFA7D9EDC698FFF5C695FFF2C596FFF4CD9EFFFFD4
      A3FFFED5A5FF686562FF7E7E7EFF232322FFB5926EFFF7C594FFFFCC99FFFFCC
      99FFFFCC99FFFFCC99FFFFCE9DFFF8C899F8CBB8A595D1D1D12EF2F2F20D0000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003C2BD700DCDC
      F4008983E000A09CE300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FDFDFD02FDFDFD02FDFDFD02FDFDFD02FDFDFD02FDFD
      FD02FDFDFD02FDFDFD02FDFDFD02FDFDFD02FDFDFD02FDFDFD02FDFDFD02FDFD
      FD02FDFDFD020000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F5F2
      F017D8C3A9B4685C4FFF635543FFE7BF92FFF8CB9AFFFED3A2FFE6C296FFFDDC
      AFFFFFE0B5FFA6A29BFFA4A4A4FF434343FFC7A37DFFEEC192FFFFCC99FFFFCC
      99FFFFCC99FFFFCC99FFFFCF9FFFFFCE9EFFECC49BDEC1C1C13ECECECE31E7E7
      E718FCFCFC03000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AEA9E8007B73DD00FDFEFB00FFFF
      FE00FEFEFE00F9F9FD00280EDB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFEFEF109494946B7272728D7272728D7272728D7272728D7272728D7272
      728D8C9DAD8D9AAEC08D7B81868D7272728D7272728D7272728D7272728D7272
      728D7272728D8A8A8A75E5E5E51A000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007E7E7E9E4D4944D49588
      78E7817668FFF1D0A4FFE6C59AFFFCD2A1FFEFC594FFF4CA97FFFBD6A7FFE6C7
      9CFFFFDCADFFF2D4ABFF918779FF685B4AFFFAD1A1FFE2BA8EFFFFCF9DFFFFCC
      99FFFFCC99FFFFCC99FFFFCF9FFFFFCE9DFFF1C79CE5CFCFCF30D8D8D827E1E1
      E11EEEEEEE11FDFDFD020000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009992E2009290E000FEFEFE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FCFDFD003624D600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009292926D010101FE010101FF010101FF010101FF010101FF030303FF0505
      05FF629FD6FF85C6FFFF3E5C76FF010101FF010101FF010101FF010101FF0101
      01FF010101FF010101FF7272728D00000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000EED4B4BBB09D
      83FFF6D6A9FFA89982FFE3C297FFFFD9A9FFDBAC77FFE0AB70FFFFDFB0FFF1D4
      AAFFEED2A6FFFFDFB0FFD3B790FF3F362AFFFAD4A5FFD9B58CFFFDD1A1FFFFCF
      9CFFFFCC99FFFFCC99FFFFCFA0FFFFCE9DFFF2CAA0DBDEDEDE21E7E7E718F0F0
      F00FF8F8F807000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005042D900FBFDFB00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CCCAEC00DDDAF500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C2C2C23D000000FF010101FF010101FF050505FF0D0D0DFF161616FF1316
      18FF75BAF4FF87C9FFFF689AC3FF000000FF010101FF010101FF010101FF0101
      01FF010101FF010101FFB8B8B84700000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE0100000000FEFEFE01CAB9A3BDDAC0
      9AFFF8DAADFFDAC39EFFCAB291FFFEDDAFFFD3995CFFD99855FFF5D5A7FFFFE3
      B7FFEBD3AFFFF3D7ACFFFEE0B2FF242019FFECCB9FFFE1BF95FFF1CCA2FFFFD1
      A0FFFFCE9BFFFFCC99FFFFD0A1FFFFCE9DFFF3CEA8C9ECECEC13F5F5F50AFDFD
      FD0200000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005043D800FEFEFD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C9C9EF00DEDAF400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FEFEFE01FAFA
      FA05F9F9F906F9F9F906F9F9F906F9F9F906F9F9F906F9F9F906F9F9F906F9F9
      F906F8F8F807282828D7070707FF101010FF191919FF232323FF2C2C2CFF2333
      3FFF85C7FDFF89CBFFFF88C9FCFF0C1013FF090909FF090909FF090909FF0909
      09FF090909FF353535CFFEFEFE0100000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FFFFFF01FFFFFF01FFFFFE01FFFFFE01FFFFFE01FFFFFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000D5C8B69FD7C0
      9CFFF1D6ADFFE8CCA2FF7C715FFFE9CCA3FFD29251FFD29454FFDFB07BFFFFE5
      BDFFFFE5BDFFEBD5B4FFF2D7ADFF4F4638FFC1A884FFF4D2A4FFDFC09BFFFFD5
      A5FFFFD09EFFFFCD9AFFFFD1A4FFFFCD9CFFF5D6B7A7FAFAFA05000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005043D800FEFEFD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CAC9EF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F3F3F30CB6B1B071A79C
      9BA9A89D9BA9ACA2A1A9B0A7A6A9B4ACABA9B8B1B0A9BBB5B5A9BCB5B5A9BCB5
      B5A9BCB5B5A9918B8BCF1D1D1DFF262626FF303030FF393939FF424242FF3957
      6DFF8ACCFFFF8BCDFFFF8BCEFFFF344958FF292929FF292929FF292929FF2929
      29FF2A2A2AF4C5C5C53E0000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFFFE01FFFFFE01FFFFFE01FFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FEFFFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FFFFFF01F1F2F123DBDCDA84CFD0CDB4D5D6D4A4E2E4E159FDFDFB06FFFF
      FF01FEFFFE01FEFEFE01FEFEFE01FEFEFE010000000000000000EEE0CC7E9285
      70FFEDD4ADFFEACFA5FF625846FF977F62FFD49556FFC78D53FFC18D57FFF1D5
      AEFFFFE7C1FFFFE6BFFFEED9B9FF776A56FF8C7C62FFFFDDAFFFD8BA93FFFDDB
      B2FFFFD2A1FFFFCF9CFFFFD3A7FFFFCC9AFFF7E3CD7300000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005043D800FDFEFD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CAC9EF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000DDD7D655BAA29EFEB398
      94FFBDA4A0FFC6AFACFFCFBAB7FFD8C5C3FFE1D0CFFFE9DAD9FFEDDFDFFFEDDE
      DEFFEDDEDEFFECDDDDFFD4C5C4FF908584FF5C5756FF434242FF505050FF5584
      A6FF8CCFFFFF8DCFFFFF8ED0FFFF527994FF444444FF3F3F3FF76B6B6BB2A7A7
      A761EEEEEE11000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FFFF
      FE01FFFFFF01FFFFFD02F5FBF322F1F6EE5DF1F4EF88F1F4EE9DF5F7F3A2F4F7
      F19CF4F8F189F4F9F163F5FAF12CFDFFFD04FFFFFF01FFFFFF01FFFFFE01FFFF
      FF01E5E6E457CBCCCAF1D6D7D5FEDCDDDBFEDCDDDBFED6D7D6FED6D8D4BCF9FB
      F711FFFFFF01FEFFFE01FEFEFE01FEFEFE010000000000000000F5EBDE513430
      29FFDAC4A2FFF6DAB0FF9E8E75FF6A5136FFB07D4AFFC18B54FFB9844FFFEEB6
      78FFFEE9C6FFFFE7C2FFFFE5BEFFB6A58AFF554B3CFFFDDEB0FFF3D2A5FFE8CB
      A8FFFFD5A5FFFFD3A3FFFFD3A8FFFCCA98FEF9F3EC2800000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005040DC00FDFBFC00FDFEFD00FFFFFF00FFFF
      FF00FFFFFF00FDFFFE00FEFEFC00C5C6EC00DDD9F300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D0CEEC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000E7E1E048BAA19DFFB195
      90FFBAA09CFFC3ABA8FFCBB6B3FFD3BFBDFFDCCAC9FFE4D5D4FFEBDDDCFFEEE2
      E2FFEFE3E3FFECDFDFFFE5D5D5FFA6A6AFFF214F73FF0E456DFF0F4267FF64A4
      D1FF89CCFBFF84C8F7FFA2D9FEFF6AA4CBFE3C5464CBBABBBD45FBFBFB040000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01FFFF
      FF01F4F9F139E6ECE2BAE6E7E4F9E8E8E7FEEBECEAFEEFF0EEFEF6F7F5FEF7F8
      F6FEF5F6F4FEF4F5F3FEF3F3F2FCEDF2E9CEF5F9F249FFFFFF01FFFFFF01E1E2
      E063D0D1CFF9DFE0DEFEE7E8E6FEE9EAE8FEE8E9E7FEE2E3E1FEDADBD9FEDADF
      D6B2FEFFFE03FEFFFE01FEFEFE01FEFEFE010000000000000000FCF9F7108377
      65F8776B59FFEED6AFFF665D4EFF917250FFEAA053FFB68C63FFE09B54FFF5A8
      59FFF7D7AEFFFFE9C6FFFFE7C1FFE5CEA8FF322C23FFEBCEA3FFFFDEAFFFE8C7
      9DFFFBD7AEFFFFD8AEFFFFD2A4FFF7D4AFBD0000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A6A2E5007F75DB00311ED900FBFCFB00FEFEFE00FFFF
      FF00FFFFFF00FEFEFC00DFDEF700351ED9002F17D900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF002D0FDB007366DF00B6B0EA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F1EDED23BCA39FFFAD92
      8CFFB69C97FFBEA6A2FFC7B0ADFFCEB9B6FFD6C3C1FFDECDCCFFE4D5D4FFE7DA
      D9FFE9DDDCFFE9DEDDFFC3C5CCFF69859DFF0E4770FF0B4772FF0B4974FF498C
      BDFF76B6EDFF7EBBF1FF619FCFFF3B759FFF0C4B78FF165B86F098AAB567FEFE
      FE0100000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01F5F9
      F348EAECE9F8E4E5E3FEE5E6E4FEE8E9E7FEEBECEAFEF0F1EFFEF6F7F5FEF7F8
      F6FEF5F6F4FEF4F5F3FEF2F3F1FEF0F1EFFEEEEFEDFBF4F8F147DEE0DD70D2D3
      D1FBE3E4E2FEECEDEBFEF1F2F0FEF2F3F1FEF1F2F0FEEBECEAFEE2E3E1FED6D7
      D5FDEBF1E845FFFFFF01FEFEFE01FEFEFE01000000000000000000000000EEDF
      CA947D7465FF393531FF5B554BFFDDBE98FFF5AF62FFA5B9D2FF9FB6D2FFDCAC
      77FFF4BB79FFFCE7C5FFFFE7C3FFFFE5BCFF231F19FFE8D1ABFFFDDFB3FFFEDB
      ACFFF0CEA6FFFEDCB6FFFBCD9CFCF8EFE5390000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008C86DC009B99E300FDFDFE00EBEDF700250BDD00F7F8FD00FDFF
      FB00FFFCFE00D4D3F3004739D500FCFDFC00FAFDF8003D2DD900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002506DB00F1F3FB00FFFEFB009088DC009C99E200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FBFBFB04BDA6A2F6A98D
      88FFB29692FFBAA09CFFC1A9A6FFC8B1AEFFD0BBB9FFD7C5C3FFDDCDCBFFE1D2
      D1FFE3D6D4FFE4D8D6FF4D728FFF1A5078FF0B4974FF0B4B77FF1E5F8CFF88BF
      F1FF8BC8FFFF83C4FFFF87C5FCFF76B0DFFF115380FF0C4A76FF176390EEE9EA
      EB1600000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01F1F6
      EE73EAEBE9FEE4E5E3FEE5E6E4FEE8E9E7FEECEDEBFEEFF0EEFEF2F3F1FEF3F4
      F2FEECEDEBFEE7E8E6FEEFF0EEFEF0F1EFFEEFF0EEFEDCDFDBDAD3D4D2FDE5E6
      E4FEEEEFEDFEF4F5F3FEF7F8F6FEF8F9F7FEF6F7F5FEEFF0EEFEE6E7E5FEDADB
      D9FEE0E6DC84FFFFFF01FEFEFE01FEFEFE01000000000000000000000000FCFB
      FA08F1DEC4B1DAC4A3FF5D574DFFE2CAA9FFD4A874FF5D8FCFFF6CA0E3FF80AC
      E4FFC6AE92FFF4CC97FFFFE8C4FFFFE5BEFF2D2921FFE4CAA5FFEBCFAAFFFEE0
      B7FFFEE0BAFFF6CFA3F6F8E8D75E000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00331CDD00F7FDFA00FFFFFF00FFFFFF00FFFFFF00FFFCFD00A29DE000837D
      E0002A16DC00E6E7F800FDFDFF00FFFFFF00FFFFFF00FEFEFE00E4E3F6003827
      D900756CD900B0AAE800FEFEFE00FEFEFE00FFFFFF00FEFEFD00F9FAFB002914
      D300FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000C5B1AED3A68B
      85FFAC918BFFB49995FFBBA19EFFC1A9A6FFC9B3B0FFD0BDBAFFD6C4C2FFDACA
      C8FFDDCECDFFAAABB4FF677C93FF395E7EFF0B4A76FF0A4F7BFF80B6E1FF8FCA
      FFFF85C6FFFF86C7FFFF86C7FFFF88C9FFFF4A92C0FF095C8DFF095E90FFC7D7
      E03800000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01F1F6
      ED74EBECEAFEEBECEAFEF0F1EFFEF3F4F2FEF4F5F3FEF5F6F4FEF5F6F4FEF0F1
      EFFEE0E1DFFEE0E1DFFEF0F1EFFEF0F1EFFEEFF0EEFEE4E5E3FEE6E7E5FEEFF0
      EEFEF5F6F4FEF8F9F7FEFAFBF9FEFAFBF9FEF7F8F6FEF0F1EFFEE6E7E5FEDADB
      D9FEDEE5DA8BFFFFFF01FEFEFE01FEFEFE010000000000000000000000000000
      0000FFFEFE01F3E6D66C47423AFAE2D0B4FF878A96FF4676BCFF5184CCFF6297
      DFFF6FA0E1FFC0A990FFF6D4A6FFFFE5BDFF2F2A22FFE8CBA0FFEDD0A8FFFDE4
      C0FFF7DFC1B2FAF5EE2400000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF002603
      DA00FDFCFD00FFFFFD00FFFFFF00FFFFFF00FFFFFF00FEFEFF00FCFDFD008C84
      E400EDECFD00FEFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFFFE00E9E5
      F900A39CE600FCFDFD00FFFFFF00FFFFFF00FFFFFF00FFFEFF00FFFFFF00FBFB
      FE002B0DDA00FFFFFF00FFFFFF00FFFFFF000000000000000000D5C7C595A88D
      88FFA78B85FFAE928DFFB49A95FFBAA19DFFC2AAA7FFC9B4B1FFCFBCB9FFD4C2
      C0FFD7C7C5FFDACBC9FFDCCECCFFB3B4BBFF19537DFF0B5381FF9BCFFAFF86C8
      FFFF87C9FFFF8FCDFFFF9ED4FFFF99D2FFFF61A8D8FF086396FF08699EFFCBDB
      E43400000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01F0F5
      EC74F0F1EFFEF4F5F3FEF8F9F7FEF9FAF8FEFAFBF9FEFAFBF9FEF9FAF8FEE1E2
      E0FEDEE0DEFEF6F7F5FEF8F9F7FEF4F5F3FEEFF0EEFEECEDEBFEEFF0EEFEF5F6
      F4FEF8F9F7FEFAFBF9FEFBFCFAFEF9FAF8FEF5F6F4FEEDEEECFEE3E4E2FED9D9
      D8FEE8EEE55AFFFFFF01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000000000009291907A587095FD497ECFFF4F83D1FF5384D0FF4F82
      CFFF588CD8FF6393D6FFD1A679FFF9DAADFF2B261FFFF0D0A4FFEED2AED7F8F0
      E542000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF002603
      D900FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFE009993
      E500F5F4FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3EE
      FB00AEA8E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FD002C0CD900FFFFFF00FFFFFF00FFFFFF000000000000000000F6F4F31ABBA4
      A0E5A28680FFA78C85FFAD928DFFB39893FFBAA19DFFC2ABA8FFC8B3B1FFCDBA
      B8FFD1C0BEFFD5C5C2FFD7C9C6FFDACCCAFF407698FF1D6A9BFFA2D6FFFF89CB
      FFFF8FCEFFFF9FD5FFFFAFDCFFFFBFE3FFFF95C9ECFF08679BFF0770A7FFE8ED
      F11700000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01F1F5
      EF75F3F4F2FEF9FAF8FEFCFDFBFEFDFFFCFEFDFFFCFEFDFDFCFEE9EBE9FEDEE0
      DEFEF7F8F6FEFDFFFCFEFCFDFBFEF9FAF8FEF3F4F2FEF0F1EFFEF5F6F4FEF9FA
      F8FEFBFCFAFEFBFCFAFEF9FAF8FEF6F7F5FEF0F1EFFEE7E8E6FEDEDFDDFED9DD
      D7D7FBFDF90AFFFFFE01FEFEFE01FEFEFE010000000000000000000000000000
      00000000000000000000E5E9F3224B7FCDFD4D83D3FF4D83D3FF4C83D3FF5689
      D4FF5788D2FF4F83D2FF6C89B8FFE8A865FF29241CFFF2DDC1A1FCFAF80F0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF002603
      D900FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFE009993
      E400F5F4FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2ED
      FC00AEA9E900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FD002C0CD900FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FAF9
      F90EE1D7D562C6B3AFABB29A94E7AC918BFFB39994FFBEA7A3FFE1D6D4FFCAB7
      B3FFDED2D0FFDCCFCDFFD7C9C6FFDED2D0FF628AA5FF3587B7FF9FD5FFFF8DCD
      FDFF9ED5FFFFAEDDFFFFBEE3FFFFCDEAFFFFB5D9F1FF076AA0FF1D7AAAE7FEFE
      FE0100000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01F4F9
      F040F1F2F0FBF7F8F6FEFAFBF9FEFBFCFAFEFCFDFBFEEFF1EFFEE0E2E0FEF3F4
      F3FEFCFDFBFEFBFCFAFEFBFCFAFEF7F8F6FEF2F3F0FED6D7EFFEF9FAF8FEFAFB
      F9FEFBFCFAFEF9FAF8FEF6F7F5FEF1F2F0FEE9EAE8FEE1E2E0FEDFE1DDE1F4F7
      F328FFFFFF01FEFFFE01FEFEFE01FEFEFE010000000000000000000000000000
      0000000000000000000096B4E299558AD7FF568BD7FF568CD8FF568BD7FF5489
      D6FF568AD6FF5B8CD5FF4A7FCFFF7C6C63FF5F5E5DA300000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF002603
      D900FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFE009793
      E400F5F4FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F2ED
      FC00AEA9E900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
      FF002C0DD800FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000F2EEED2CDACECD7BD2D6DAF2DBE6EEFFCED4
      D9FFDDE7EEFFE0EAF0FFDDD7D5B1E4DCDA6188A9BD871472A7FF4897CBFF4091
      C5FF77B7E1FFBCE4FFFFCCEAFFFFDBF0FFFFA0CBE3FF076EA4FF549ABFAE0000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FFFFFF01FFFF
      FF01F3F7F060F1F3EFEEF5F6F4FEF7F8F6FEF3F4F2FEE1E3E1FEEFF1EFFEFAFA
      F9FEF9FAF8FEF8F9F7FEF6F7F5FEEFF0F1FE7A7AE8FE1514E5FED3D3F7FEFBFC
      FAFEF9FAF8FEF6F7F5FEF1F2F0FEE9EAE8FEE2E3E1FEDFE2DDDAF7F9F522FFFF
      FF01FFFFFF01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000EAEFF81C5C8FD8FB5E92DCFF5F94DCFF6094DCFF5F93DCFF5D92
      DBFF5A8FDAFF5B8FD9FF5587D2FF263C5FF7C0C0C03F00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF002802
      DC00FEFFFD00FFFEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFB009795
      E900F6F5FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0ED
      FC00AEA9E300FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFD
      FE002D0CDB00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000F9F9F90691C6EAD472B5EAFF72B2
      E7FF75B7E9FF89CCF7FFE4EBF02D00000000B9CFDC47086294FF086396FF0866
      9BFF1875A8FFBCE2FAFFD9F0FFFFE7F5FEFF4597C3FF0772A9FFA1C8DC5F0000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FFFF
      FF01FFFFFF01FBFDFB14F3F7F070EBF0E8BED0D3CDEEE7E9E7FCF5F5F4FEF3F3
      F1FEE5E6EFFEBEBEECFE7C7CEAFE2121E8FE0201EAFE0201EBFE1E1EEDFED2D2
      F6FEF5F6F4FEF0F1EFFEE9EAE8FEE2E3E1FEDFE3DCD1F6F9F41CFFFFFF01FFFF
      FF01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000B5CBEB6F6498DFFF679BE0FF689CE1FF699CE1FF689CE1FF669A
      E0FF6397DEFF5F93DCFF5E91DAFFACBBD5670000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF003F2E
      D600DBD9F400FEFEFE00FFFFFD00FFFFFF00FFFFFF00FEFFFE00FAFDFC003721
      D900968FDE00FCFDFD00FEFFFC00FFFFFF00FFFFFF00FEFEFE00FEFDFD008980
      DF004331DB00FCFCFD00FEFEFF00FFFFFF00FFFFFF00FFFFFD00FEFFFD00D2D0
      EF005041D400FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000FCFCFC03A7B7C16681BCEEF98FC9FFFF85C5
      FFFF8BC8FFFF88C3F3FFA2B6C379FDFDFD02E9EFF316086598FD08679BFF0869
      9EFF076BA1FF51A0CAFFE1F3FEFF6FB4D9FF0674ACFF117BB1F2F1F5F80E0000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FCFCFB07F7FBF610797DCE981010
      CCFE0606DDFE0201E6FE0201ECFE0201F0FE0201F1FE0201F1FE0201F0FE1313
      EDFE9E9FECFEE8E9E7FEE2E3E1FEE2E4E0C7F9FBF815FFFFFF01FFFFFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      00000000000097B8E6A76DA0E3FF70A3E5FF71A4E6FF72A5E6FF71A4E5FF6FA2
      E4FF6B9FE2FF679BE0FF6196DDFF4169A6FB989FB06700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00584ED300CBC7EF00FEFEFE00FFFFFF00FFFFFF00F9FAF800290DD800FFFF
      FF00AFACE8007D71E000FDFCFD00FFFFFF00FFFFFF00FEFEFE006E65E1002500
      E3002600E3003319E000FAF9FE00FFFFFE00FFFFFF00FDFDFD00BEBCE900665B
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000E1E7EB279AC9F3F494CDFFFF85C6FFFF84C6
      FFFF85C6FFFF86C7FFFF99CCF8F5EBECEF18000000004D92B7B6076BA0FF076D
      A3FF076FA5FF0772A9FF1E88BFFF0675AEFF0677B0FF78B5D488000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFFFE01FEFEFE01F9F9FD061F1FC3E20202
      D8FE0202E5FE0202EEFE0202F4FE0202F6FE0202F6FE0202F4FE0202F0FE0202
      EBFE0302E4FE4242DFFEABAFDDBEFAFBF910FFFFFF01FFFFFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      00000000000089B1E6C875A8E8FF78ABE9FF7BADEAFF7BADEBFF7AACEAFF77AA
      E9FF73A6E7FF6EA1E4FF689CE1FF6699DFFF284473FDBBC0CB44000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF002809DC00F7F9FE008D85DF009F9AE700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003E2DDC00DDDCF300D7D5F2002402E3002601E1002601
      E1002601E1002601E1002503DE009E96E200F4F8F8002606D900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000D3E1EE529DD2FFFF86C7FFFF89C9FFFF8FCC
      FFFF92CEFFFF8BCBFFFF8FCDFFFFD6E2EB4A00000000D9E7EF261476A9F00770
      A7FF0772AAFF0674ADFF0677B0FF0679B2FF3B96C4C7F3F7FB0C000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01F0F0FA0F0B0DC6F6090A
      DFFE090AEAFE090AF2FE090AF7FE0809F8FE0304F7FE0204F3FE0204EEFE0204
      E6FE1D1EE1FE676DE0B2F3F5F80DFEFEFF01FFFFFF01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      00000000000086B0E6D77DAFECFF82B3EDFF85B5EEFF86B5EFFF84B4EEFF80B1
      EDFF7BADEBFF75A8E8FF6FA2E4FF689BE1FF577DB3FF374866CA000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF002706DB00B8B5E900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005248DB002601E0002601E1002601E1002601
      E1002601E1002601E1002601E1002601E1002C08DE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000FEFEFE01A5BBCE939DD3FFFF92CEFFFF9AD2FFFFA1D5
      FFFFA7D8FFFFACDBFFFF9AD3FFFF9EB7CA92F8F8F80700000000DAE9F1255DA3
      C8A52184B7E21581B6EE3593C1CD8CC2DD74F8FAFB0700000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01F8F8FC071F25C6E71D21
      DFFE1D21E9FE1D22F0FE1D22F4FE1D22F4FE151BF2FE0208ECFE0208E5FE1F24
      E0FE7179DEA6F6F7FA09FEFEFF01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      00000000000092B8E9D78FBBF0FF91BDF1FF90BDF2FF90BEF2FF8EBCF1FF89B8
      F0FF83B3EEFF7CAEEBFF3A5D92FF70A0E0FF5073A6FF051A3FFEEDEDF0120000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D0CDEE002601E1002601E1002601E1002601
      E1002601E1002601E1002601E1002601E1007068DD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000E4E4E61B4B7A9DEFA8D9FFFFA4D7FFFFAADAFFFFB1DD
      FFFFB7E0FFFFBCE2FFFFBAE1FFFF3674A0F995A8B36B00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFF016E77D495323B
      DDFE3841E7FE3841ECFE3841F0FE3841F0FE3842EDFE0813E3FE222BDFFE7A82
      E19AF9F9FD06FEFEFF01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      0000000000009FC1EDCC9DC5F3FFA3C9F5FFA6CCF6FFA1C9F6FF98C4F5FF92BF
      F3FF8AB9F0FF81B2EDFF2D4E7FFF0C2651FF041B42FF061B3FFFCFD2DA300000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D1CEEF002601E0002601E1002601E1002601
      E1002601E1002601E1002601E1002601E1007069DE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000099AFBD68195D89FFB0DCFDFFB3DFFFFFB9E1FFFFBFE4
      FFFFC0E2FCFF81AAC8FF45779BFF1B5984FF236187E8F8F8F807000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01EAEDF515414F
      D3D5525EE3FE5461E7FE5561EAFE5561EAFE5561E8FE2F3CDEFD848EE28DFBFB
      FD04FEFEFF01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000A9C8EEB8A1C8F5FFA8CEF7FFAED2F9FFB0D4FAFFA9CFF9FF9AC5
      F5FF90BDF2FF86B6EFFF33568AFF001A46FF001841FF071D42FFC9CDD6360000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D1CEEF002601E0002601E1002601E1002601
      E1002601E1002601E1002601E1002601E1007069DE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000618DA9A2095B8BFF91C4E4FFC1E5FFFFC6E7FEFFA8CD
      E7FF32658AFF0C4973FF14547FFF2B6B92FF296E96F6FAFAFA05000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFF01E3E7
      F31E5969D9BE5765DFFD7280E7FE7683E7FE6270E0F19BA6E274FCFCFE03FEFE
      FF01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000B7D0F198A3CAF6FFACD1F9FFB4D7FBFFB7D9FDFFB0D4FAFFA4CC
      F7FF93C0F3FF88B8EFFF214377FF001C4DFF001A48FF0A2149FFD7D9E0280000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D1CEEE002601E0002601E1002601E1002601
      E1002601E1002601E1002601E1002601E1007069DE00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000528CADB1086498FF60A4CAFFCBE9FDFF8FB8D4FF1A54
      7DFF0B4D79FF0E5482FF216893FF397DA5FF4588ADD700000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FF01FCFDFF03D0D8EF33AAB6E45FB5BFE752EBEEF616FEFEFF01FEFEFF01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000C7D9F26BA2C9F5FFABD0F9FFB2D6FBFFB5D7FCFFAED3FAFFA5CC
      F7FF95C1F3FF6790C7FF0D2C62FF032257FF001D4EFF0D2651FDF5F5F70A0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D1CFEC002601E2002601E1002601E1002601
      E1002601E1002601E1002601E1002601E100716ADC00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000082B2CC7F076EA4FF2B87B9FF598CAFFF0F4F7AFF0B52
      7FFF0B5786FF176694FF307BA6FF478FB5FF7CB0CB8E00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFF01FEFEFF01FEFEFF01FEFEFF01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      0000E9E9ED164B5F82B91B3A6CFF1C3C71FF24467CFF32558CFF44689EFF4B70
      A7FF365B94FF25447BFF27457AFF213E71FF09275BFF3B4F75D2000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00422FDA002601E2002601E1002601
      E1002601E1002601E1002701E1002804DC00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000F2F6F90D3D8AB3C60A5D8EFF0B507DFF0A5684FF0A5C
      8BFF0F6596FF2679A7FF3E8DB7FF3E91BCF3E2EDF41D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      0000E2E5EA1F4A5D80E339527DFF3D5885FF3D5A8BFF3A598EFF365790FF3658
      92FF365790FF2E5089FF294981FF244378FF1F3C6EFF8A96AD7E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005A50DC002601E5002601
      E1002601E1002600E4002A0ADD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000B0C5D3510A5482FF0A5B8AFF096091FF0A67
      99FF1C77A8FF348BB8FF3C94C0F4B8D8E84A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      000000000000E3E5E91E51668BCD365384FF3B5A8EFF416197FF42649EFF3F62
      9FFF395D9AFF325591FF2B4C86FF25457CFF3E5681D8F1F1F40E000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002702
      DF002802DF00D2D0F200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000009BBDD1661E719FE7086A9FFF0E74
      A9FF2C89B9EA75B4D498DEEDF421000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFEFE01FEFE
      FE01FEFEFE01FEFEFE01FEFEFE01FEFEFE010000000000000000000000000000
      00000000000000000000FAFAFB05A1ACC16D506997DD43639BFF4568A4FF4368
      A8FF3C62A2FF345897FF2A4B86FD697DA0A8E9EAEF1600000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E5EFF51AE6F0
      F619000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6DAE32FB0BCD1629BAC
      C97C99A9C67AAFBACE5BE3E5EB1C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF000000000000000000000000
      FFFF3FFF000000000000000000000000FFF807FF000000000000000000000000
      FFC000FF000000000000000000000000FE00001F000000000000000000000000
      F800000F000000000000000000000000F800003F000000000000000000000000
      F800003F000000000000000000000000F800003F000000000000000000000000
      F800003F000000000000000000000000F800003F000000000000000000000000
      F800001F000000000000000000000000F800001F000000000000000000000000
      F000001F000000000000000000000000F000001F000000000000000000000000
      F000001F000000000000000000000000F000001F000000000000000000000000
      F000000F000000000000000000000000F000000F000000000000000000000000
      F000000F000000000000000000000000E000000F000000000000000000000000
      E000000F000000000000000000000000E000000F000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000E000001F000000000000000000000000
      F00000FF000000000000000000000000FE0007FF000000000000000000000000
      FFC03FFF000000000000000000000000FFFBFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000E0000000CFFFFFFFFFFFFFFFFFFFFFFF
      E000000080FFFFFFFFFE817FFFFF3FFFE0000000000FFFFFFFF4242FFFF807FF
      E00000000000FFFFFFC94293FFC000FFE000000080001FFFFFA2004DFE00001F
      E0000000800001FFFF480013F800000FE00000008000001FFE100009F800003F
      E000000080000003FEA00009F800003FE000000080000001FD404213F800003F
      E000000080000001A0810105F800003FE000000080000001FC82724BF800003F
      E000000080000001A0040517F800001FE000000080000001A00005FFF800001F
      E000000080000001A00005FFF000001FE000000080000001A00005FFF000001F
      E000000080000001FA0BFFFFF000001FE000000080000001FA0BFFFFF000001F
      C000000080000001A00005FFF000000F8000000080000001A00005FFF000000F
      8000000080000001A00005FFF000000F8000000080000001A0040517E000000F
      0000000080000000FC82724BE000000F0000000080000000A0810195E000000F
      0000000080000000FD404213E00000070000000080000000FEA00009E0000007
      80000000C0000000FE100009E000000780000000C0000000FF480013E000001F
      C0000000E0000000FFA2004DF00000FFC000FFFFE0020000FFC94293FE0003FF
      E001FFFFFC03E007FFF4242FFFC033FFF803FFFFFFC7FF07FFFE817FFFE3FFFF
      FE1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8001FF00000000FFFFFFFFFFFFFFFF
      FC00003F00000000FFFFFFFFFFFFFFFFF000001F00000000FFFC0007FFFFFFFF
      E000000700000000FFF00001FFFFFFFF8000000300000000FFF0000100000000
      C000000700000000FFF00001000000008000000F00000000C000000100000000
      C000003F000000008000000300000000C000007F000000008000000700000000
      C000007F000000008000001F00000000C00000FF000000008000000F00000000
      E00000FF000000008000000F00000000E00001FF00000000C000000F00000000
      F00003FF00000000C000000F00000000FC000FFF00000000C000000F00000000
      FC001FFF00000000E000000F00000000FC007FFF00000000FE00001F00000000
      F8007FFF00000000FF01001F00000000F800FFFF00000000FE00001F00000000
      F8007FFF00000000FE00803F00000000F8003FFF00000000FE00803F00000000
      F8003FFF00000000FC00407F00000000F8001FFF00000000FC007FFF00000000
      F8001FFF00000000FC003FFF00000000F8001FFF00000000FC003FFF00000000
      F8001FFF00000000FC007FFF00000000F8001FFF00000000FC007FFF00000000
      F0003FFF00000000FC007FFF00000000F0003FFF00000000FE00FFFF00000000
      F8003FFF00000000FF01FFFF00000000FC007FFF00000000FFCFFFFFFFFFFFFF
      FF81FFFF00000000FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object dsClients: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setClients
    Left = 252
    Top = 163
  end
  object dsProduits: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setProduits
    Left = 340
    Top = 163
  end
  object dsOrganismes: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setOrganismesAMC
    Left = 164
    Top = 163
  end
  object dsHistoriques: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setHistoriques
    Left = 436
    Top = 163
  end
  object dsCredits: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setCredits
    Left = 528
    Top = 160
  end
  object dsVignettes: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setVignettes
    Left = 528
    Top = 216
  end
  object dsFactures: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setFactures
    Left = 528
    Top = 272
  end
  object dsProduitsDus: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setProduitsDus
    Left = 528
    Top = 328
  end
  object dsPraticiens: TDataSource
    DataSet = dmOutilsPHAPHA_fr.SetPraticiens
    Left = 68
    Top = 163
  end
  object dsCommandes: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setCommandes
    Left = 612
    Top = 163
  end
end
