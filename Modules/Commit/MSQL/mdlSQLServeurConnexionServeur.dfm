inherited frmSQLServeurConnexionServeur: TfrmSQLServeurConnexionServeur
  Left = 407
  Top = 280
  Caption = 'Connexion SQL Server'
  ClientHeight = 270
  ExplicitWidth = 472
  ExplicitHeight = 302
  DesignSize = (
    466
    270)
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Height = 251
    ExplicitHeight = 241
  end
  inherited img: TImage
    Height = 251
    Proportional = True
    ExplicitHeight = 241
  end
  inherited edtServeur: TLabeledEdit
    EditLabel.Width = 76
    EditLabel.Caption = 'Nom du serveur'
    EditLabel.ExplicitLeft = 200
    EditLabel.ExplicitTop = 28
    EditLabel.ExplicitWidth = 76
  end
  inherited edtBD: TLabeledEdit
    Top = 56
    ExplicitTop = 56
  end
  inherited btnAnnuler: TButton
    Top = 226
    TabOrder = 7
    ExplicitTop = 226
  end
  inherited btnOK: TButton
    Top = 226
    TabOrder = 6
    ExplicitTop = 226
  end
  inherited chkConnexionLocale: TCheckBox
    Caption = 'SQL Serveur 2000'
    Visible = False
  end
  object chkAuthWindows: TCheckBox
    Left = 136
    Top = 192
    Width = 233
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Authentification Windows'
    TabOrder = 5
    OnClick = chkAuthWindowsClick
  end
end
