inherited frPharmalandv7Configuration: TfrPharmalandv7Configuration
  Width = 443
  Height = 270
  Align = alClient
  AutoSize = True
  object gBoxMotsDePasses: TGroupBox
    Left = 0
    Top = 0
    Width = 443
    Height = 81
    Align = alTop
    Caption = 'Mots de passe'
    TabOrder = 0
    DesignSize = (
      443
      81)
    object lblPARAM: TLabel
      Left = 16
      Top = 24
      Width = 57
      Height = 13
      Caption = 'PARAM.FIC'
    end
    object lblLisezMoi: TLabel
      Left = 46
      Top = 57
      Width = 228
      Height = 13
      Cursor = crHandPoint
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      Caption = 'T'#233'l'#233'chargez HyperFile Password Recovery Tool'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnClick = lblLisezMoiClick
    end
    object edtPARAM: TEdit
      Left = 88
      Top = 20
      Width = 217
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
end
