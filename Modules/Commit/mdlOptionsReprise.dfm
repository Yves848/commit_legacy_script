inherited frmOptionsReprise: TfrmOptionsReprise
  Left = 500
  Top = 260
  BorderStyle = bsDialog
  Caption = 'Options de reprise'
  ClientHeight = 300
  ClientWidth = 433
  Constraints.MinHeight = 0
  Constraints.MinWidth = 0
  OldCreateOrder = False
  Position = poScreenCenter
  ExplicitWidth = 439
  ExplicitHeight = 329
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 127
    Top = 268
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnAnnuler: TButton
    Left = 231
    Top = 268
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 1
  end
  object pCtlOptionsReprise: TPageControl
    Left = 0
    Top = 0
    Width = 433
    Height = 257
    ActivePage = tshImport
    Align = alTop
    TabOrder = 2
    OnResize = pCtlOptionsRepriseResize
    object tshImport: TTabSheet
      Tag = 1
      Caption = 'Import'
    end
    object tshTransfert: TTabSheet
      Tag = 2
      Caption = 'Transfert'
      ImageIndex = 1
    end
  end
end
