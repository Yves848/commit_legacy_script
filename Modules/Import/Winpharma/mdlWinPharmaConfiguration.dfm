inherited frWinPharmaConfiguration: TfrWinPharmaConfiguration
  Width = 451
  Height = 304
  Align = alClient
  AutoSize = True
  ExplicitWidth = 451
  ExplicitHeight = 304
  object gBoxVersion: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 57
    Align = alTop
    Caption = 'Param'#232'tres de lecture des donn'#233'es'
    TabOrder = 3
    object lblFacteurDecoupage: TLabel
      Left = 24
      Top = 24
      Width = 108
      Height = 13
      Caption = 'Facteur de d'#233'coupage'
    end
    object edtFacteurDecoupage: TJvSpinEdit
      Left = 147
      Top = 21
      Width = 49
      Height = 21
      ButtonKind = bkStandard
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 209
    Width = 451
    Height = 87
    Align = alTop
    Caption = 'Autre'
    TabOrder = 1
    object cbxPrixDOM: TCheckBox
      Left = 11
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Prix DOM'
      TabOrder = 0
    end
    object cbxDepot: TCheckBox
      Left = 11
      Top = 62
      Width = 257
      Height = 17
      Caption = 'Multi d'#233'pot ( ne pas cocher si erreur PRODGEO )'
      TabOrder = 1
      Visible = False
    end
    object cbxGestionStock: TCheckBox
      Left = 11
      Top = 39
      Width = 158
      Height = 17
      Caption = 'Pas de gestion de stock'
      TabOrder = 2
      OnMouseUp = cbxGestionStockMouseUp
    end
  end
  object grdCodifPrd: TRadioGroup
    Left = 0
    Top = 57
    Width = 451
    Height = 79
    Align = alTop
    Caption = 'Codifications produits'
    Columns = 3
    Items.Strings = (
      'Interne'
      'Gamme fournisseurs'
      'G'#233'n'#233'rique'
      'Gestion marge'
      'Libre')
    TabOrder = 2
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 136
    Width = 451
    Height = 73
    Align = alTop
    Caption = 'Documents scann'#233'es'
    TabOrder = 0
    object Label2: TLabel
      Left = 307
      Top = 27
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Repris '#224' partir du : '
    end
    object edtDateImportScans: TJvDateTimePicker
      AlignWithMargins = True
      Left = 307
      Top = 47
      Width = 101
      Height = 20
      Date = 42667.638947141200000000
      Time = 42667.638947141200000000
      TabOrder = 0
      DropDownDate = 43613.000000000000000000
    end
    object chkScanAM: TCheckBox
      Left = 11
      Top = 24
      Width = 121
      Height = 17
      Caption = 'Attestations mutuelle'
      TabOrder = 1
    end
    object chkScanOrdonnances: TCheckBox
      Left = 180
      Top = 23
      Width = 121
      Height = 17
      Caption = 'Ordonnances'
      TabOrder = 2
    end
    object chkScanFournisseurs: TCheckBox
      Left = 11
      Top = 47
      Width = 137
      Height = 17
      Caption = 'Documents fournisseurs'
      TabOrder = 3
    end
    object chkScanBL: TCheckBox
      Left = 180
      Top = 46
      Width = 121
      Height = 17
      Caption = 'Factures BL'
      TabOrder = 4
    end
  end
end
