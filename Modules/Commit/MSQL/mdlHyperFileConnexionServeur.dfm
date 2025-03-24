inherited frmHyperFileConnexionServeur: TfrmHyperFileConnexionServeur
  Caption = 'Connexion HyperFile (ODBC)'
  ClientHeight = 268
  ClientWidth = 574
  DragKind = dkDock
  ExplicitWidth = 580
  ExplicitHeight = 300
  DesignSize = (
    574
    268)
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Width = 437
    Height = 252
    ExplicitWidth = 327
    ExplicitHeight = 252
  end
  inherited bvlSeparateur_2: TBevel
    Top = 102
    Width = 417
    Height = 12
    Visible = False
    ExplicitTop = 102
    ExplicitWidth = 417
    ExplicitHeight = 12
  end
  inherited img: TImage
    Height = 252
    ExplicitHeight = 252
  end
  object lblAnalyse: TLabel [3]
    Left = 240
    Top = 27
    Width = 38
    Height = 13
    Caption = 'Analyse'
    Enabled = False
    Visible = False
  end
  inherited edtServeur: TLabeledEdit
    Top = 51
    Width = 249
    EditLabel.Width = 38
    EditLabel.Caption = 'Serveur'
    EditLabel.ExplicitLeft = 238
    EditLabel.ExplicitTop = 55
    EditLabel.ExplicitWidth = 38
    Enabled = False
    Visible = False
    ExplicitTop = 51
    ExplicitWidth = 249
  end
  inherited edtBD: TLabeledEdit
    Top = 78
    Width = 144
    EditLabel.Width = 135
    EditLabel.Caption = 'Chemin de base de donn'#233'es'
    EditLabel.ExplicitLeft = 141
    EditLabel.ExplicitTop = 82
    EditLabel.ExplicitWidth = 135
    TabOrder = 6
    ExplicitTop = 78
    ExplicitWidth = 144
  end
  inherited btnAnnuler: TButton
    Left = 397
    Top = 223
    TabOrder = 5
    ExplicitLeft = 397
    ExplicitTop = 223
  end
  inherited btnOK: TButton
    Left = 296
    Top = 223
    TabOrder = 4
    ExplicitLeft = 296
    ExplicitTop = 223
  end
  inherited edtUtilisateur: TLabeledEdit
    Top = 120
    Width = 249
    EditLabel.ExplicitLeft = 230
    EditLabel.ExplicitTop = 124
    EditLabel.ExplicitWidth = 46
    Enabled = False
    TabOrder = 1
    Visible = False
    ExplicitTop = 120
    ExplicitWidth = 249
  end
  inherited edtMotDePasse: TLabeledEdit
    Top = 152
    Width = 249
    EditLabel.ExplicitLeft = 212
    EditLabel.ExplicitTop = 156
    EditLabel.ExplicitWidth = 64
    Enabled = False
    TabOrder = 2
    Visible = False
    ExplicitTop = 152
    ExplicitWidth = 249
  end
  inherited chkConnexionLocale: TCheckBox
    Left = 144
    Top = 200
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = chkConnexionLocaleClick
    ExplicitLeft = 144
    ExplicitTop = 200
  end
  object edtAnalyse: TJvFilenameEdit
    Left = 296
    Top = 24
    Width = 249
    Height = 21
    AddQuotes = False
    Filter = 'Analyse Windev (*.wdd)|*.wdd|All files (*.*)|*.*'
    Enabled = False
    Anchors = [akTop, akRight]
    TabOrder = 7
    Visible = False
  end
  object edtCheminBD: TJvDirectoryEdit
    Left = 296
    Top = 78
    Width = 249
    Height = 21
    DialogKind = dkWin32
    Anchors = [akTop, akRight]
    TabOrder = 8
  end
end
