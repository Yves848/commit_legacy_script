object frmOptionsSCANS: TfrmOptionsSCANS
  Left = 0
  Top = 0
  Caption = 'Options d'#39'importations des documents scann'#233's'
  ClientHeight = 163
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 113
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 8
      Width = 51
      Height = 13
      Caption = 'R'#233'pertoire'
    end
    object Label2: TLabel
      Left = 15
      Top = 32
      Width = 225
      Height = 13
      Caption = 'Extention des Scans '#224' importer dans le projet :'
    end
    object chkConversion: TCheckBox
      Left = 15
      Top = 104
      Width = 347
      Height = 17
      Caption = 'Conversion des scans en  .TIF (si necessaire)'
      TabOrder = 0
      Visible = False
    end
    object chkRecursif: TCheckBox
      Left = 47
      Top = 63
      Width = 347
      Height = 17
      Caption = 'Recursif (cherche les scans dans tous les r'#233'pertoires du projet)'
      TabOrder = 1
    end
    object edtRepertoire: TJvDirectoryEdit
      Left = 80
      Top = 5
      Width = 282
      Height = 21
      DialogKind = dkWin32
      TabOrder = 2
      Text = 'edtRepertoire'
    end
    object cbxFiltre: TComboBox
      Left = 246
      Top = 29
      Width = 58
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'jpg|pdf'
        'jpg'
        'pdf'
        'tif'
        'zli'
        'scan')
    end
  end
  object btnAnnuler: TButton
    Left = 225
    Top = 130
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 120
    Top = 130
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
