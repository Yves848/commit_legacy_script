inherited frmWinPharmaConnexionServeur: TfrmWinPharmaConnexionServeur
  ClientHeight = 270
  ClientWidth = 573
  ExplicitWidth = 579
  ExplicitHeight = 299
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Left = 111
    Width = 454
    Height = 254
    ExplicitLeft = 111
    ExplicitWidth = 454
    ExplicitHeight = 254
  end
  inherited bvlSeparateur_2: TBevel
    Left = 128
    Top = 43
    ExplicitLeft = 128
    ExplicitTop = 43
  end
  inherited img: TImage
    Width = 97
    Height = 254
    ExplicitWidth = 97
    ExplicitHeight = 254
  end
  inherited edtServeur: TLabeledEdit
    Left = 327
    Top = 152
    Width = 146
    EditLabel.Width = 176
    EditLabel.Caption = 'Selectionner le repertoire WPHARMA'
    EditLabel.ExplicitLeft = 131
    EditLabel.ExplicitTop = 156
    EditLabel.ExplicitWidth = 176
    ExplicitLeft = 327
    ExplicitTop = 152
    ExplicitWidth = 146
  end
  inherited edtBD: TLabeledEdit
    Left = 327
    Top = 16
    EditLabel.ExplicitLeft = 175
    EditLabel.ExplicitTop = 20
    EditLabel.ExplicitWidth = 132
    ExplicitLeft = 327
    ExplicitTop = 16
  end
  inherited btnAnnuler: TButton
    Left = 390
    Top = 229
    ExplicitLeft = 390
    ExplicitTop = 229
  end
  inherited btnOK: TButton
    Left = 272
    Top = 229
    ExplicitLeft = 272
    ExplicitTop = 229
  end
  inherited edtUtilisateur: TLabeledEdit
    Left = 327
    Top = 58
    EditLabel.ExplicitLeft = 259
    EditLabel.ExplicitTop = 62
    EditLabel.ExplicitWidth = 48
    Visible = False
    ExplicitLeft = 327
    ExplicitTop = 58
  end
  inherited edtMotDePasse: TLabeledEdit
    Left = 327
    Top = 101
    EditLabel.ExplicitLeft = 243
    EditLabel.ExplicitTop = 105
    EditLabel.ExplicitWidth = 64
    Visible = False
    ExplicitLeft = 327
    ExplicitTop = 101
  end
  inherited chkConnexionLocale: TCheckBox
    Left = 327
    Top = 194
    Visible = False
    ExplicitLeft = 327
    ExplicitTop = 194
  end
  object edtCheminBLOB: TJvDirectoryEdit
    Left = 327
    Top = 152
    Width = 193
    Height = 21
    DialogKind = dkWin32
    InitialDir = 'edtCheminBLOB.Text'
    Anchors = [akTop, akRight]
    TabOrder = 7
  end
end
