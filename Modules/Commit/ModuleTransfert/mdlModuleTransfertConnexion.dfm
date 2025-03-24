inherited frmModuleTrasfertConnexion: TfrmModuleTrasfertConnexion
  PixelsPerInch = 96
  TextHeight = 13
  inherited edtServeur: TLabeledEdit
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 54
  end
  inherited edtBD: TLabeledEdit
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 29
    TabOrder = 7
  end
  inherited edtUtilisateur: TLabeledEdit
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 64
  end
  inherited edtMotDePasse: TLabeledEdit
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 75
  end
  object edtCIPPharmacie: TLabeledEdit
    Left = 320
    Top = 51
    Width = 145
    Height = 21
    Anchors = [akTop, akRight]
    EditLabel.Width = 120
    EditLabel.Height = 13
    EditLabel.Caption = 'Code CIP/APB pharmacie'
    LabelPosition = lpLeft
    LabelSpacing = 20
    MaxLength = 7
    TabOrder = 1
  end
end
