object frmForcageDestinataire: TfrmForcageDestinataire
  Left = 225
  Top = 241
  BorderStyle = bsDialog
  Caption = 'For'#231'age destinataire ...'
  ClientHeight = 154
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblTypeOrganisme: TLabel
    Left = 16
    Top = 12
    Width = 83
    Height = 13
    Caption = 'Type d'#39'organisme'
  end
  object lblDestinataire: TLabel
    Left = 16
    Top = 45
    Width = 56
    Height = 13
    Caption = 'Destinataire'
  end
  object bvlSeparateur_1: TBevel
    Left = 8
    Top = 64
    Width = 385
    Height = 9
    Shape = bsBottomLine
  end
  object lblDepartement: TLabel
    Left = 16
    Top = 83
    Width = 61
    Height = 13
    Caption = 'D'#233'partement'
  end
  object btnOk: TButton
    Left = 116
    Top = 119
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnAnnuler: TButton
    Left = 212
    Top = 119
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 1
  end
  object cbxChoixTypeOrganismes: TComboBox
    Left = 112
    Top = 8
    Width = 273
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    Items.Strings = (
      'Tous les organismes (AMO + AMC)'
      'Uniquement les organismes AMO'
      'Uniquement les organismes AMC')
  end
  inline frChoixDestinataire: TfrChoixID
    Left = 96
    Top = 32
    Width = 295
    Height = 39
    TabOrder = 3
    ExplicitLeft = 96
    ExplicitTop = 32
    ExplicitHeight = 39
    inherited cbxChoix: TDBLookupComboBox
      Width = 273
      NullValueKey = 16430
      ExplicitWidth = 273
    end
    inherited dsChoix: TDataSource
      DataSet = dmOutilsPHAPHA_fr.setDestinataires
      Left = 232
      Top = 0
    end
  end
  inline frChoixDepartement: TfrChoixID
    Left = 96
    Top = 73
    Width = 295
    Height = 33
    TabOrder = 4
    ExplicitLeft = 96
    ExplicitTop = 73
    ExplicitHeight = 33
    inherited cbxChoix: TDBLookupComboBox
      Width = 273
      NullValueKey = 16430
      ExplicitWidth = 273
    end
    inherited dsChoix: TDataSource
      DataSet = dmOutilsPHAPHA_fr.setDepartements
      Left = 232
      Top = 3
    end
  end
end
