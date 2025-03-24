object frmConsole: TfrmConsole
  Left = 721
  Top = 338
  BorderStyle = bsSizeToolWin
  Caption = 'Console COMMIT'
  ClientHeight = 179
  ClientWidth = 259
  Color = clWindow
  Ctl3D = False
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object mmConsole: TMemo
    Left = 0
    Top = 0
    Width = 259
    Height = 179
    Align = alClient
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = []
    Lines.Strings = (
      'Commit 4.6')
    ParentColor = True
    ParentFont = False
    PopupMenu = pmnuConsole
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object pmnuConsole: TJvPopupMenu
    Style = msXP
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 96
    Top = 8
    object mnuSauvegarder: TMenuItem
      Caption = '&Sauvegarder'
      ShortCut = 16467
      OnClick = mnuSauvegarderClick
    end
    object mnuImprimer: TMenuItem
      Caption = '&Imprimer'
      ShortCut = 16464
    end
    object mnuSeparateur_1: TMenuItem
      Caption = '-'
    end
    object mnuVider: TMenuItem
      Caption = '&Vider'
      ShortCut = 46
      OnClick = mnuViderClick
    end
  end
  object sd: TSaveDialog
    Left = 144
    Top = 8
  end
end
