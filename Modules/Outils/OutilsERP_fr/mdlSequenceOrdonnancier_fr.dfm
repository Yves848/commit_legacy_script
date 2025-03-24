object frmSequenceOrdonnancier: TfrmSequenceOrdonnancier
  Left = 646
  Top = 246
  BorderStyle = bsDialog
  Caption = 'S'#233'quences ordonanciers & factures'
  ClientHeight = 200
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
    Caption = 'Sequences ordonanciers'
    TabOrder = 0
    object lblSeqOrdoLigne: TLabel
      Left = 16
      Top = 29
      Width = 26
      Height = 13
      Caption = 'Ligne'
    end
    object lblSeqOrdoStup: TLabel
      Left = 16
      Top = 61
      Width = 48
      Height = 13
      Caption = 'Stup'#233'fiant'
    end
    object edtSeqOrdoLigne: TSpinEdit
      Left = 104
      Top = 24
      Width = 89
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object edtSeqOrdoStup: TSpinEdit
      Left = 104
      Top = 56
      Width = 89
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object gBoxSeqFact: TGroupBox
    Left = 8
    Top = 104
    Width = 209
    Height = 57
    Caption = 'Sequence factures'
    TabOrder = 1
    object lblSeqFact: TLabel
      Left = 16
      Top = 29
      Width = 36
      Height = 13
      Caption = 'Facture'
    end
    object edtSeqFact: TSpinEdit
      Left = 104
      Top = 24
      Width = 89
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object btnOK: TButton
    Left = 23
    Top = 168
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 127
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 3
  end
end
