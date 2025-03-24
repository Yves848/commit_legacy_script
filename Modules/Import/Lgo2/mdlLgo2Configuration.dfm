inherited frLgo2Configuration: TfrLgo2Configuration
  Width = 451
  Height = 304
  Align = alClient
  AutoSize = True
  ExplicitWidth = 451
  ExplicitHeight = 304
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 185
    Align = alTop
    Caption = 'Documents scann'#233'es'
    TabOrder = 0
    ExplicitTop = 24
    object Label1: TLabel
      Left = 26
      Top = 47
      Width = 259
      Height = 13
      Caption = 'Si repertoire "\Doc" existe dans le repertoire de projet'
    end
    object Label2: TLabel
      Left = 11
      Top = 161
      Width = 183
      Height = 13
      Caption = 'Ne modifier que sur demande du dev !'
    end
    object Label3: TLabel
      Left = 11
      Top = 115
      Width = 274
      Height = 13
      Caption = 'Regex d'#39'extraction de  l'#39'ID client dans les fichiers de scan'
    end
    object Label4: TLabel
      Left = 26
      Top = 64
      Width = 287
      Height = 13
      Caption = 'Si dans un autre dossier : traiter ce dossier en mode manuel'
    end
    object chkScanAUTO: TCheckBox
      Left = 11
      Top = 24
      Width = 270
      Height = 17
      Caption = 'Reprise des Documents scann'#233's en AUTOMATIQUE'
      TabOrder = 0
    end
    object edtRegex: TEdit
      Left = 11
      Top = 134
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '(\d+)'
    end
    object Button1: TButton
      Left = 138
      Top = 134
      Width = 75
      Height = 21
      Caption = 'R'#233'tablir'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
