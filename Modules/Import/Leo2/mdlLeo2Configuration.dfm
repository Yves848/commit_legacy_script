inherited frLeo2Configuration: TfrLeo2Configuration
  Width = 437
  Height = 57
  AutoSize = True
  ExplicitWidth = 437
  ExplicitHeight = 57
  object gbxCatalogues: TGroupBox
    Left = 0
    Top = 0
    Width = 437
    Height = 57
    Align = alTop
    Caption = 'Catalogues'
    TabOrder = 0
    DesignSize = (
      437
      57)
    object lblProvenanceCat: TLabel
      Left = 16
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Issue de'
    end
    object cbxProvenanceCat: TComboBox
      Left = 72
      Top = 20
      Width = 353
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Items.Strings = (
        'Commandes/Lignes de commandes'
        'R'#233'f'#233'rences fournisseurs')
    end
  end
end
