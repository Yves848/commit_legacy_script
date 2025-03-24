object frmVisualisationScriptSQL: TfrmVisualisationScriptSQL
  Left = 261
  Top = 123
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frmVisualisationScriptSQL'
  ClientHeight = 573
  ClientWidth = 792
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mmSQL: TSynMemo
    Left = 185
    Top = 33
    Width = 607
    Height = 540
    Align = alClient
    ActiveLineColor = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ShowLineNumbers = True
    Highlighter = shSQL
    ReadOnly = True
    ExplicitLeft = 191
    ExplicitTop = 32
  end
  object pnlRecherche: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 33
    Align = alTop
    TabOrder = 1
    object lblChercher: TLabel
      Left = 8
      Top = 8
      Width = 43
      Height = 13
      Caption = 'Chercher'
    end
    object btnChercher: TPISpeedButton
      Left = 338
      Top = 4
      Width = 73
      Height = 22
      Caption = 'Chercher'
      Flat = True
      OnClick = btnChercherClick
      Fleche = False
    end
    object btnAllerLigne: TPISpeedButton
      Left = 588
      Top = 3
      Width = 37
      Height = 22
      Caption = 'Aller'
      Flat = True
      OnClick = btnAllerLigneClick
      Fleche = False
    end
    object lblNumeroLigne: TLabel
      Left = 436
      Top = 8
      Width = 52
      Height = 13
      Caption = 'N'#176' de ligne'
    end
    object Bevel1: TBevel
      Left = 416
      Top = 7
      Width = 9
      Height = 18
      Shape = bsRightLine
    end
    object edtChercher: TEdit
      Left = 64
      Top = 4
      Width = 273
      Height = 21
      TabOrder = 0
      OnChange = edtChercherChange
      OnKeyDown = edtChercherKeyDown
    end
  end
  object edtNumeroLigne: TJvSpinEdit
    Left = 506
    Top = 4
    Width = 81
    Height = 21
    TabOrder = 2
    OnKeyDown = edtNumeroLigneKeyDown
  end
  object tvScriptsSQL: TTreeView
    Left = 0
    Top = 33
    Width = 185
    Height = 540
    Align = alLeft
    Indent = 19
    TabOrder = 3
    Visible = False
    OnClick = tvScriptsSQLClick
  end
  object shSQL: TSynSQLSyn
    CommentAttri.Foreground = clGreen
    StringAttri.Foreground = clRed
    SQLDialect = sqlInterbase6
    Left = 360
    Top = 80
  end
end
