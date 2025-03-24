object frmSequenceOrdonnancier: TfrmSequenceOrdonnancier
  Left = 646
  Top = 246
  BorderStyle = bsDialog
  Caption = 'S'#233'quences ordonanciers & factures'
  ClientHeight = 143
  ClientWidth = 226
  Color = clBtnFace
  Constraints.MaxHeight = 234
  Constraints.MaxWidth = 234
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
  object gBoxSeqOrdo: TGroupBox
    Left = 8
    Top = 8
    Width = 209
    Height = 89
    Caption = 'Ordonnance'
    TabOrder = 0
    object Label1: TLabel
      Left = 49
      Top = 21
      Width = 123
      Height = 13
      Caption = 'Le prochain num'#233'ro est  : '
    end
    object Label2: TLabel
      Left = 15
      Top = 68
      Width = 183
      Height = 13
      Caption = 'Mettre le nouveau num'#233'ro d'#39'ordo + OK'
    end
    object edtSeqOrdoLigne: TSpinEdit
      Left = 57
      Top = 40
      Width = 97
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object btnOK: TButton
    Left = 23
    Top = 104
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 127
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 2
  end
end
