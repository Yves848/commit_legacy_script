object frStock: TfrStock
  Left = 0
  Top = 0
  Width = 569
  Height = 169
  AutoSize = True
  TabOrder = 0
  object lblStockMini: TLabel
    Left = 399
    Top = 28
    Width = 18
    Height = 13
    Caption = 'mini'
  end
  object lblDus: TLabel
    Left = 112
    Top = 88
    Width = 18
    Height = 13
    Caption = 'Dus'
  end
  object Stock: TLabel
    Left = 400
    Top = 8
    Width = 34
    Height = 13
    Caption = 'Stock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblConditionnement: TLabel
    Left = 400
    Top = 104
    Width = 81
    Height = 13
    Caption = 'Conditionnement'
  end
  object lblColisage: TLabel
    Left = 400
    Top = 128
    Width = 40
    Height = 13
    Caption = 'Colisage'
  end
  object lblUV: TLabel
    Left = 400
    Top = 152
    Width = 13
    Height = 13
    Caption = 'UV'
  end
  object lblStockMaxi: TLabel
    Left = 398
    Top = 52
    Width = 22
    Height = 13
    Caption = 'maxi'
  end
  object lblDatePeremption: TLabel
    Left = 200
    Top = 88
    Width = 95
    Height = 13
    Caption = 'Date de p'#233'remption'
  end
  object txtConditionnement: TDBEdit
    Left = 496
    Top = 100
    Width = 73
    Height = 21
    DataField = 'CONDITIONNEMENT'
    TabOrder = 4
  end
  object txtColisage: TDBEdit
    Left = 496
    Top = 124
    Width = 73
    Height = 21
    DataField = 'LOTACHAT'
    TabOrder = 5
  end
  object txtMoyVte: TDBEdit
    Left = 496
    Top = 148
    Width = 73
    Height = 21
    DataField = 'UMOYVTE'
    TabOrder = 6
  end
  object dbGrdStock: TPIDBGrid
    Left = 0
    Top = 0
    Width = 377
    Height = 81
    BorderStyle = bsNone
    DataSource = dsProduitsGeo
    DefaultDrawing = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
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
    MultiSelection.Active = False
    MultiSelection.Mode = mmsSelection
    Columns = <
      item
        Expanded = False
        FieldName = 'QUANTITE'
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
        FieldName = 'ZONE_GEOGRAPHIQUE'
        Title.Alignment = taCenter
        Width = 100
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
        FieldName = 'DEPOT'
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
        FieldName = 'STOCK_MINI'
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
        FieldName = 'STOCK_MAXI'
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
  object txtStockMini: TDBEdit
    Left = 456
    Top = 24
    Width = 41
    Height = 21
    DataField = 'STOCKMINI'
    TabOrder = 2
  end
  object txtStockMaxi: TDBEdit
    Left = 456
    Top = 48
    Width = 41
    Height = 21
    DataField = 'STOCKMAXI'
    TabOrder = 3
  end
  object txtPrdDus: TDBEdit
    Left = 144
    Top = 84
    Width = 33
    Height = 21
    DataField = 'PRODUITDU'
    TabOrder = 1
  end
  object edtStockTotal: TDBEdit
    Left = 16
    Top = 84
    Width = 41
    Height = 21
    TabOrder = 7
  end
  object edtDatePeremption: TDBEdit
    Left = 304
    Top = 84
    Width = 73
    Height = 21
    TabOrder = 8
  end
  object dsProduitsGeo: TDataSource
    AutoEdit = False
    Left = 272
    Top = 24
  end
end
