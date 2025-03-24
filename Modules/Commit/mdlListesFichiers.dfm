object frmListeFichiers: TfrmListeFichiers
  Left = 39
  Top = 396
  BorderStyle = bsSizeToolWin
  Caption = 'T'#233'l'#233'chargements en cours'
  ClientHeight = 191
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object vstListesFichiers: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 624
    Height = 191
    Align = alClient
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 17
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    Header.Style = hsXPStyle
    TabOrder = 0
    TreeOptions.PaintOptions = [toHideSelection, toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages, toAlwaysHideSelection]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnGetText = vstListesFichiersGetText
    OnPaintText = vstListesFichiersPaintText
    OnKeyDown = vstListesFichiersKeyDown
    ExplicitLeft = -8
    ExplicitTop = 8
    Columns = <
      item
        Position = 0
        Width = 200
        WideText = 'Source'
      end
      item
        Position = 1
        Width = 200
        WideText = 'Destinatation'
      end
      item
        Position = 2
        Style = vsOwnerDraw
        Width = 150
        WideText = 'Progression'
      end>
  end
end
