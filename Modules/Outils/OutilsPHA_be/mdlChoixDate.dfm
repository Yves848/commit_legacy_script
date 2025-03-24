object frmChoixDate: TfrmChoixDate
  Left = 150
  Top = 134
  BorderStyle = bsDialog
  Caption = 'Entrez une date ...'
  ClientHeight = 90
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblChoixDate: TLabel
    Left = 8
    Top = 16
    Width = 3
    Height = 13
  end
  object edtChoixDate: TPIDateTimePicker
    Left = 96
    Top = 12
    Width = 186
    Height = 21
    Date = 39482.000000000000000000
    Time = 0.640200046298559700
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 63
    Top = 56
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnAnnuler: TButton
    Left = 159
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 2
  end
end
