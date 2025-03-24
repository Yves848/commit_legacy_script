object frmUpdateFromFTP: TfrmUpdateFromFTP
  Left = 444
  Top = 338
  BorderStyle = bsDialog
  Caption = 'Mise '#224' jour'
  ClientHeight = 202
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gBxInfoConnect: TGroupBox
    Left = 0
    Top = 0
    Width = 297
    Height = 153
    Align = alTop
    Caption = 'Information de connexion'
    TabOrder = 0
    object lblServer: TLabel
      Left = 16
      Top = 28
      Width = 37
      Height = 13
      Caption = 'Serveur'
    end
    object bvlSeparator_1: TBevel
      Left = 8
      Top = 48
      Width = 281
      Height = 9
      Shape = bsBottomLine
    end
    object lblUtilisateur: TLabel
      Left = 32
      Top = 96
      Width = 46
      Height = 13
      Caption = 'Utilisateur'
    end
    object lblMotdepasse: TLabel
      Left = 32
      Top = 128
      Width = 64
      Height = 13
      Caption = 'Mot de passe'
    end
    object edtServer: TEdit
      Left = 72
      Top = 24
      Width = 209
      Height = 21
      TabOrder = 0
      Text = 'repf.groupe.pharmagest.com'
    end
    object chkPassword: TCheckBox
      Left = 16
      Top = 64
      Width = 137
      Height = 17
      Caption = 'Utilisateur/Mot de passe'
      TabOrder = 1
      OnClick = chkPasswordClick
    end
    object edtUtilisateur: TEdit
      Left = 120
      Top = 92
      Width = 161
      Height = 21
      Color = clInactiveCaption
      Enabled = False
      TabOrder = 2
    end
    object edtMotdePasse: TEdit
      Left = 120
      Top = 124
      Width = 161
      Height = 21
      Color = clInactiveCaption
      Enabled = False
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object btnOK: TButton
    Left = 55
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnAnnuler: TButton
    Left = 167
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 2
  end
end
