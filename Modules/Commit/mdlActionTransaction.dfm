object frmActTrans: TfrmActTrans
  Left = 513
  Top = 365
  Caption = 'Transaction active ...'
  ClientHeight = 92
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblMessage: TLabel
    Left = 35
    Top = 8
    Width = 256
    Height = 26
    Alignment = taCenter
    Caption = 
      'Une transaction en cours a '#233't'#233' d'#233'tect'#233'e. Vous devez effectuer un' +
      ' commit ou un rollback ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btnCommit: TButton
    Left = 30
    Top = 56
    Width = 75
    Height = 25
    Caption = '&Commit'
    ModalResult = 1
    TabOrder = 0
  end
  object btnRollback: TButton
    Left = 126
    Top = 56
    Width = 75
    Height = 25
    Caption = '&Rollback'
    Default = True
    ModalResult = 3
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 222
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 2
  end
end
