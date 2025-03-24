object fDriveChoice: TfDriveChoice
  Left = 0
  Top = 0
  Caption = 'Espace disque insuffisant'
  ClientHeight = 161
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 327
    Height = 18
    Caption = 'Pas assez de place sur %s pour la d'#233'compression'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 346
    Height = 18
    Caption = 'Choisissez un autre disque ou abandonnez l'#39'op'#233'ration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 108
    Top = 81
    Width = 46
    Height = 18
    Caption = 'Utiliser '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object cbDrives: TComboBox
    Left = 160
    Top = 80
    Width = 97
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 288
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Abandon'
    ModalResult = 3
    TabOrder = 2
  end
end
