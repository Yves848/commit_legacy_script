inherited frmInventaire: TfrmInventaire
  Left = 497
  Top = 363
  Caption = 'Inventaire'
  ClientHeight = 221
  ClientWidth = 451
  Constraints.MaxHeight = 255
  Constraints.MaxWidth = 459
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grdInventaire: TPIDBGrid [0]
    Left = 0
    Top = 41
    Width = 451
    Height = 155
    Align = alClient
    DataSource = dsInventaire
    DefaultDrawing = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    MenuColonneActif = False
    StyleBordure = sbAucune
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
    MultiSelection.Mode = mmsSelection
    Columns = <
      item
        Expanded = False
        FieldName = 'TAUX_TVA'
        Title.Alignment = taCenter
        Width = 54
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
        FieldName = 'TOTAL_PRIX_ACHAT_CATALOGUE'
        Title.Alignment = taCenter
        Width = 74
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
        FieldName = 'TOTAL_PRIX_VENTE'
        Title.Alignment = taCenter
        Width = 74
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
        FieldName = 'TOTAL_PAMP'
        Title.Alignment = taCenter
        Width = 74
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
        FieldName = 'NB_PRODUITS'
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
        FieldName = 'NB_UNITES'
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
  object pnlTotaux: TPanel [1]
    Left = 0
    Top = 196
    Width = 451
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object lblTotaux: TLabel
      Left = 16
      Top = 7
      Width = 33
      Height = 13
      Caption = 'Totaux'
    end
    object txtTotalPAHT: TStaticText
      Left = 68
      Top = 4
      Width = 73
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object txtTotalPVTCC: TStaticText
      Left = 143
      Top = 4
      Width = 72
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object txtTotalPAMP: TStaticText
      Left = 218
      Top = 4
      Width = 72
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object txtTotalNbProduits: TStaticText
      Left = 293
      Top = 4
      Width = 68
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object txtTotalNbUnites: TStaticText
      Left = 364
      Top = 4
      Width = 68
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
  end
  object rgPriorite: TRadioGroup [2]
    Left = 0
    Top = 0
    Width = 451
    Height = 41
    Align = alTop
    Caption = 'Dep'#244'ts'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Tous'
      'Pharmacie'
      'R'#233'serve')
    TabOrder = 2
    OnClick = rgPrioriteClick
  end
  inherited ilActions: TImageList
    Left = 464
  end
  inherited alActionsSupp: TActionList
    Left = 176
    Top = 112
  end
  inherited alActionsStd: TActionList
    Tag = 1
    Left = 32
    inherited actImprimer: TAction
      OnExecute = actImprimerExecute
    end
  end
  object dsInventaire: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setInventaire
    Left = 488
    Top = 176
  end
end
