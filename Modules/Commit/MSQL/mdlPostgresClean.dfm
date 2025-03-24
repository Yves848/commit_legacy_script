object frmPostgresClean: TfrmPostgresClean
  Left = 0
  Top = 0
  Caption = 'Nettoyage PostgresSQL'
  ClientHeight = 256
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sg1: TJvStringGrid
    Left = 160
    Top = 8
    Width = 425
    Height = 209
    ColCount = 2
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 0
    OnSelectCell = sg1SelectCell
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = []
    ColWidths = (
      267
      120)
  end
  object Memo1: TMemo
    Left = 160
    Top = 114
    Width = 425
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    Visible = False
  end
  object Button1: TButton
    Left = 24
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Select DB'
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object btnDropDB: TButton
    Left = 32
    Top = 8
    Width = 97
    Height = 25
    Caption = 'Supprimer DB'
    TabOrder = 3
    OnClick = btnDropDBClick
  end
  object btnClose: TButton
    Left = 510
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Fermer'
    TabOrder = 4
    OnClick = btnCloseClick
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    HostName = '127.0.0.1'
    Port = 5432
    User = 'postgres'
    Password = 'postgres'
    Protocol = 'postgresql'
    LibraryLocation = 'libpq.dll'
    Left = 30
    Top = 132
  end
  object ZQuery1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 64
    Top = 176
  end
end
