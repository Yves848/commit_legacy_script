inherited frTransfertYZYConfiguration: TfrTransfertYZYConfiguration
  Width = 451
  Height = 329
  Align = alClient
  AutoSize = True
  ExplicitWidth = 451
  ExplicitHeight = 304
  object grdFusion: TGroupBox
    Left = 0
    Top = 81
    Width = 451
    Height = 248
    Align = alClient
    Caption = 'Param'#232'tres de fusion'
    TabOrder = 0
    ExplicitTop = 87
    DesignSize = (
      451
      248)
    object bvlPraticiens: TBevel
      Left = 8
      Top = 32
      Width = 435
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
      ExplicitWidth = 369
    end
    object lblPraticiens: TLabel
      Left = 16
      Top = 24
      Width = 46
      Height = 13
      Caption = 'Praticiens'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblProduits: TLabel
      Left = 16
      Top = 101
      Width = 38
      Height = 13
      Caption = 'Produits'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 13
      Top = 105
      Width = 435
      Height = 12
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
    end
    object lblCritere: TLabel
      Left = 16
      Top = 188
      Width = 357
      Height = 13
      Caption = 
        'Programme relationnel appliqu'#233' par d'#233'faut sur les cartes qui n'#39'e' +
        'n ont pas :'
    end
    object Bevel3: TBevel
      Left = 13
      Top = 169
      Width = 435
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
    end
    object chkPraticiensNonReconnus: TCheckBox
      Left = 24
      Top = 71
      Width = 209
      Height = 17
      Caption = 'Cr'#233'ation des praticiens non-reconnus'
      TabOrder = 0
    end
    object chkFusionStock: TCheckBox
      Left = 24
      Top = 123
      Width = 97
      Height = 17
      Caption = 'Fusion du stock'
      TabOrder = 1
    end
    object chkHopitauxNonReconnus: TCheckBox
      Left = 24
      Top = 48
      Width = 209
      Height = 17
      Caption = 'Cr'#233'ation des hopitaux non-reconnus'
      TabOrder = 2
    end
    object chkPrix: TCheckBox
      Left = 24
      Top = 146
      Width = 270
      Height = 17
      Caption = 'Ecrasement des prix d'#39'achats/vente si reconnu'
      TabOrder = 3
    end
    object ComboBox_prog_rel: TComboBox
      Left = 104
      Top = 207
      Width = 200
      Height = 21
      TabOrder = 4
      Text = 'ComboBox_prog_rel'
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 81
    Align = alTop
    Caption = 'Param'#232'tres sv 140'
    TabOrder = 1
    DesignSize = (
      451
      81)
    object Bevel2: TBevel
      Left = 8
      Top = 32
      Width = 1058
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
      ExplicitWidth = 369
    end
    object lblProduit140: TLabel
      Left = 16
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Produits'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object chkStup: TCheckBox
      Left = 24
      Top = 47
      Width = 209
      Height = 17
      Caption = 'D'#233'conditionnement des stup'#233'fiants'
      TabOrder = 0
    end
  end
  object Transaction_prog_rel: TUIBTransaction
    Left = 416
    Top = 152
  end
  object qLibellesProgRel: TUIBQuery
    SQL.Strings = (
      'select t_ref_prog_rel_id, libelle       '
      'from t_ref_prog_relationnel'
      'order by t_ref_prog_rel_id')
    Left = 344
    Top = 136
  end
end
