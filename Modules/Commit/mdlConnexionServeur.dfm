object frmConnexionServeur: TfrmConnexionServeur
  Left = 555
  Top = 189
  BorderStyle = bsDialog
  ClientHeight = 233
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    466
    233)
  PixelsPerInch = 96
  TextHeight = 13
  object bvlSeparator_1: TBevel
    Left = 128
    Top = 8
    Width = 330
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitWidth = 329
    ExplicitHeight = 185
  end
  object bvlSeparateur_2: TBevel
    Left = 136
    Top = 78
    Width = 313
    Height = 9
    Shape = bsBottomLine
  end
  object img: TImage
    Left = 8
    Top = 8
    Width = 114
    Height = 217
    Anchors = [akLeft, akTop, akBottom]
    Center = True
  end
  object edtServeur: TLabeledEdit
    Left = 296
    Top = 24
    Width = 145
    Height = 21
    Anchors = [akTop, akRight]
    CharCase = ecUpperCase
    EditLabel.Width = 140
    EditLabel.Height = 13
    EditLabel.Caption = 'Serveur (Nom ou Adresse IP)'
    LabelPosition = lpLeft
    LabelSpacing = 20
    TabOrder = 0
  end
  object edtBD: TLabeledEdit
    Left = 296
    Top = 51
    Width = 146
    Height = 21
    Anchors = [akTop, akRight]
    EditLabel.Width = 132
    EditLabel.Height = 13
    EditLabel.Caption = 'Nom de la base de donn'#233'es'
    LabelPosition = lpLeft
    LabelSpacing = 20
    TabOrder = 1
  end
  object btnAnnuler: TButton
    Left = 310
    Top = 192
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 6
  end
  object btnOK: TButton
    Left = 214
    Top = 192
    Width = 75
    Height = 25
    Anchors = [akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object edtUtilisateur: TLabeledEdit
    Left = 296
    Top = 96
    Width = 145
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Utilisateur'
    LabelPosition = lpLeft
    LabelSpacing = 20
    TabOrder = 2
  end
  object edtMotDePasse: TLabeledEdit
    Left = 296
    Top = 128
    Width = 145
    Height = 21
    EditLabel.Width = 64
    EditLabel.Height = 13
    EditLabel.Caption = 'Mot de passe'
    LabelPosition = lpLeft
    LabelSpacing = 20
    PasswordChar = '*'
    TabOrder = 3
  end
  object chkConnexionLocale: TCheckBox
    Left = 136
    Top = 165
    Width = 209
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Connexion locale'
    TabOrder = 4
  end
end
