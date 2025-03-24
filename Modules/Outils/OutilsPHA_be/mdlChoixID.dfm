object frChoixID: TfrChoixID
  Left = 0
  Top = 0
  Width = 295
  Height = 80
  TabOrder = 0
  object cbxChoix: TDBLookupComboBox
    Left = 16
    Top = 8
    Width = 265
    Height = 21
    KeyField = 'ID'
    ListField = 'LIBELLE'
    ListSource = dsChoix
    TabOrder = 0
    OnKeyDown = cbxChoixKeyDown
  end
  object btnOk: TButton
    Left = 63
    Top = 40
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnAnnuler: TButton
    Left = 159
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Annuler'
    ModalResult = 2
    TabOrder = 2
  end
  object dsChoix: TDataSource
    Left = 16
    Top = 32
  end
end
