object frmDetailTraitementEnCours: TfrmDetailTraitementEnCours
  Left = 510
  Top = 332
  BorderStyle = bsToolWindow
  ClientHeight = 79
  ClientWidth = 185
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblSucces: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 13
    Caption = 'Succ'#232's'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblRejets: TLabel
    Left = 8
    Top = 32
    Width = 37
    Height = 13
    Caption = 'Rejets'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblErreurs: TLabel
    Left = 8
    Top = 56
    Width = 41
    Height = 13
    Caption = 'Erreurs'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtSucces: TStaticText
    Left = 104
    Top = 6
    Width = 69
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    BevelKind = bkFlat
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
  end
  object txtRejets: TStaticText
    Left = 104
    Top = 30
    Width = 69
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    BevelKind = bkFlat
    Color = 33023
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
  end
  object txtErreurs: TStaticText
    Left = 104
    Top = 54
    Width = 69
    Height = 17
    Alignment = taRightJustify
    AutoSize = False
    BevelKind = bkFlat
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
  object tmTraitement: TTimer
    Interval = 2000
    OnTimer = tmTraitementTimer
    Left = 72
    Top = 32
  end
end
