inherited frmMySQLConnexionServeur: TfrmMySQLConnexionServeur
  Caption = 'Connection Periphar'
  ClientHeight = 322
  ClientWidth = 569
  ExplicitWidth = 575
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Width = 433
    Height = 306
    ExplicitWidth = 433
    ExplicitHeight = 156
  end
  inherited bvlSeparateur_2: TBevel
    Top = 181
    Width = 412
    Anchors = [akLeft, akTop, akRight]
    ExplicitTop = 181
    ExplicitWidth = 412
  end
  inherited img: TImage
    Height = 306
    ExplicitHeight = 156
  end
  object Bevel1: TBevel [3]
    Left = 143
    Top = 116
    Width = 412
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  object lblOptions: TLabel [4]
    Left = 257
    Top = 26
    Width = 37
    Height = 13
    Caption = 'Options'
  end
  object lblDumpSQL: TLabel [5]
    Left = 245
    Top = 97
    Width = 49
    Height = 13
    Caption = 'Dump SQL'
  end
  object Bevel2: TBevel [6]
    Left = 143
    Top = 78
    Width = 412
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  inherited edtServeur: TLabeledEdit
    Left = 311
    Top = 131
    EditLabel.ExplicitLeft = 151
    EditLabel.ExplicitTop = 135
    EditLabel.ExplicitWidth = 140
    TabOrder = 2
    ExplicitLeft = 311
    ExplicitTop = 131
  end
  inherited edtBD: TLabeledEdit
    Left = 311
    Top = 158
    EditLabel.ExplicitLeft = 159
    EditLabel.ExplicitTop = 162
    EditLabel.ExplicitWidth = 132
    TabOrder = 3
    ExplicitLeft = 311
    ExplicitTop = 158
  end
  inherited btnAnnuler: TButton
    Left = 387
    Top = 281
    TabOrder = 8
    ExplicitLeft = 387
    ExplicitTop = 318
  end
  inherited btnOK: TButton
    Left = 269
    Top = 281
    TabOrder = 7
    ExplicitLeft = 269
    ExplicitTop = 318
  end
  inherited edtUtilisateur: TLabeledEdit
    Left = 311
    Top = 196
    EditLabel.ExplicitLeft = 243
    EditLabel.ExplicitTop = 200
    EditLabel.ExplicitWidth = 48
    TabOrder = 4
    ExplicitLeft = 311
    ExplicitTop = 196
  end
  inherited edtMotDePasse: TLabeledEdit
    Left = 311
    Top = 228
    EditLabel.ExplicitLeft = 227
    EditLabel.ExplicitTop = 232
    EditLabel.ExplicitWidth = 64
    TabOrder = 5
    ExplicitLeft = 311
    ExplicitTop = 228
  end
  inherited chkConnexionLocale: TCheckBox
    Left = 143
    Top = 258
    TabOrder = 6
    WordWrap = True
    OnClick = chkConnexionLocaleClick
    ExplicitLeft = 143
    ExplicitTop = 277
  end
  object mmOptions: TMemo
    Left = 311
    Top = 23
    Width = 237
    Height = 54
    TabOrder = 0
  end
  object edtDumpSQL: TJvFilenameEdit
    Left = 311
    Top = 93
    Width = 237
    Height = 21
    AddQuotes = False
    Filter = 'All files (*.*)|*.*|Srcipts SQL (*.sql)|*.sql'
    TabOrder = 1
  end
end
