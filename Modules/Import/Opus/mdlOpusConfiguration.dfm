inherited frOpusConfiguration: TfrOpusConfiguration
  Width = 451
  Height = 304
  Align = alClient
  ExplicitWidth = 451
  ExplicitHeight = 304
  object Label4: TLabel
    Left = 32
    Top = 86
    Width = 58
    Height = 13
    Caption = 'D'#233'clenche '#224
  end
  object grbCartefi: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Align = alClient
    Caption = 'Carte fid'#233'lit'#233
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 59
      Width = 52
      Height = 13
      Caption = 'Remise de '
    end
    object Label3: TLabel
      Left = 32
      Top = 86
      Width = 58
      Height = 13
      Caption = 'D'#233'clenche '#224
    end
    object cbxCarteFi: TCheckBox
      Left = 16
      Top = 24
      Width = 409
      Height = 17
      Caption = 
        'Creer une carte avantage avec ces parametres (ne fonctionne plus' +
        ')'
      Enabled = False
      TabOrder = 0
    end
    object cbxTypeObjectif: TComboBox
      Left = 167
      Top = 83
      Width = 82
      Height = 21
      TabOrder = 1
      Text = 'euros'
      Items.Strings = (
        'euros'
        'boites'
        'passages'
        'point')
    end
    object cbxTypeAvantage: TComboBox
      Left = 167
      Top = 56
      Width = 82
      Height = 21
      TabOrder = 2
      Text = '% sur CA'
      Items.Strings = (
        '% sur CA'
        'cheque cadeau'
        'cadeau'
        'produit offert')
    end
    object spnValeurAvantage: TSpinEdit
      Left = 98
      Top = 56
      Width = 63
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 3
      Value = 5
    end
    object spnValeurObjectif: TSpinEdit
      Left = 98
      Top = 83
      Width = 63
      Height = 22
      MaxValue = 500
      MinValue = 0
      TabOrder = 4
      Value = 10
    end
  end
end
