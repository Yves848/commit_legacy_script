inherited frmBDEConnexionServeur: TfrmBDEConnexionServeur
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 341
  ClientWidth = 643
  ExplicitWidth = 649
  ExplicitHeight = 373
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Width = 441
    Height = 209
    ExplicitWidth = 441
    ExplicitHeight = 209
  end
  inherited bvlSeparateur_2: TBevel
    Visible = False
  end
  inherited edtServeur: TLabeledEdit
    Visible = False
  end
  inherited edtBD: TLabeledEdit
    Left = 310
    Top = 62
    TabStop = False
    EditLabel.Width = 135
    EditLabel.Caption = 'Chemin de base de donn'#233'es'
    EditLabel.ExplicitLeft = 155
    EditLabel.ExplicitTop = 66
    EditLabel.ExplicitWidth = 135
    ExplicitLeft = 310
    ExplicitTop = 62
  end
  inherited btnAnnuler: TButton
    TabOrder = 5
  end
  inherited btnOK: TButton
    TabOrder = 4
  end
  inherited edtUtilisateur: TLabeledEdit
    Visible = False
  end
  inherited edtMotDePasse: TLabeledEdit
    Left = 280
    Top = 138
    Width = 144
    EditLabel.ExplicitLeft = 196
    EditLabel.ExplicitTop = 142
    EditLabel.ExplicitWidth = 64
    TabOrder = 6
    Visible = False
    ExplicitLeft = 280
    ExplicitTop = 138
    ExplicitWidth = 144
  end
  inherited chkConnexionLocale: TCheckBox
    TabOrder = 3
    Visible = False
  end
  object edtCheminBD: TJvDirectoryEdit
    Left = 310
    Top = 62
    Width = 249
    Height = 21
    DialogKind = dkWin32
    Anchors = [akTop, akRight]
    TabOrder = 7
  end
end
