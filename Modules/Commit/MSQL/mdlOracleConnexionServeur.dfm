inherited frmOracleConnexionServeur: TfrmOracleConnexionServeur
  Caption = 'Connexion'
  ClientHeight = 211
  ClientWidth = 490
  ExplicitWidth = 496
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Width = 354
    Height = 195
    ExplicitWidth = 330
    ExplicitHeight = 217
  end
  inherited bvlSeparateur_2: TBevel
    Left = 152
    Anchors = [akTop]
    ExplicitLeft = 152
  end
  inherited img: TImage
    Height = 195
    ExplicitHeight = 90
  end
  inherited edtServeur: TLabeledEdit
    Left = 320
    EditLabel.ExplicitLeft = 160
    EditLabel.ExplicitTop = 28
    EditLabel.ExplicitWidth = 140
  end
  inherited edtBD: TLabeledEdit
    Left = 673
    EditLabel.ExplicitLeft = 521
    EditLabel.ExplicitTop = 55
    EditLabel.ExplicitWidth = 132
    ExplicitLeft = 649
  end
  inherited btnAnnuler: TButton
    Left = 328
    Top = 170
    ExplicitTop = 65
  end
  inherited btnOK: TButton
    Left = 227
    Top = 170
    ExplicitTop = 65
  end
  inherited edtUtilisateur: TLabeledEdit
    Left = 320
    Top = 93
    Anchors = [akTop, akRight]
    EditLabel.ExplicitLeft = 252
    EditLabel.ExplicitTop = 97
    EditLabel.ExplicitWidth = 48
    ExplicitLeft = 320
    ExplicitTop = 93
  end
  inherited edtMotDePasse: TLabeledEdit
    Left = 320
    Top = 120
    Anchors = [akTop, akRight]
    EditLabel.ExplicitLeft = 236
    EditLabel.ExplicitTop = 124
    EditLabel.ExplicitWidth = 64
    ExplicitLeft = 320
    ExplicitTop = 120
  end
  inherited chkConnexionLocale: TCheckBox
    Left = 482
    Top = 143
    Visible = False
    ExplicitLeft = 482
    ExplicitTop = 38
  end
end
