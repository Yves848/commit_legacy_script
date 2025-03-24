object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sauvegarde SQL Server'
  ClientHeight = 410
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    487
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 481
    Height = 174
    Align = alTop
    Caption = 'Connexion '#224' SQL Server'
    TabOrder = 0
    object Bevel1: TBevel
      Left = 16
      Top = 67
      Width = 505
      Height = 6
      Shape = bsBottomLine
    end
    object Label2: TLabel
      Left = 255
      Top = 24
      Width = 29
      Height = 13
      Caption = 'Driver'
    end
    object Label3: TLabel
      Left = 24
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Serveur'
    end
    object ComboBox2: TComboBox
      Left = 24
      Top = 40
      Width = 201
      Height = 21
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 24
      Top = 121
      Width = 201
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'Utilisateur'
      TabOrder = 3
    end
    object LabeledEdit3: TLabeledEdit
      Left = 255
      Top = 121
      Width = 202
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'Mot de passe'
      PasswordChar = '*'
      TabOrder = 4
    end
    object ComboBox1: TComboBox
      Left = 255
      Top = 40
      Width = 202
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'SQL Server Native Client 10.0'
      Items.Strings = (
        'SQL Server Native Client 10.0'
        'Microsoft OLEDB Provider for SQL Server')
    end
    object CheckBox2: TCheckBox
      Left = 24
      Top = 79
      Width = 250
      Height = 17
      Caption = 'Authentification Windows'
      TabOrder = 2
      OnClick = CheckBox2Click
    end
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 183
    Width = 481
    Height = 154
    Align = alTop
    Caption = 'Sauvegarde'
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 75
      Width = 51
      Height = 13
      Caption = 'R'#233'pertoire'
    end
    object Label4: TLabel
      Left = 24
      Top = 24
      Width = 82
      Height = 13
      Caption = 'Base de donn'#233'es'
    end
    object JvDirectoryEdit1: TJvDirectoryEdit
      Left = 24
      Top = 94
      Width = 433
      Height = 21
      DialogKind = dkWin32
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 126
      Width = 99
      Height = 17
      Caption = 'Compression'
      TabOrder = 2
    end
    object ComboBox3: TComboBox
      Left = 24
      Top = 43
      Width = 433
      Height = 21
      TabOrder = 0
      OnEnter = LabeledEdit4Enter
    end
  end
  object Button1: TButton
    Left = 153
    Top = 356
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 258
    Top = 356
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Valider'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = Button2Click
  end
  object JvStatusBar1: TJvStatusBar
    Left = 0
    Top = 391
    Width = 487
    Height = 19
    Panels = <
      item
        Width = 50
        Control = ProgressBar1
      end>
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 0
      Width = 487
      Height = 19
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 3
    end
  end
  object ADOConnection1: TADOConnection
    Left = 376
    Top = 264
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 376
    Top = 312
  end
end
