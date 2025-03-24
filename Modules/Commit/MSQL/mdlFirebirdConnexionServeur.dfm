inherited frmFirebirdConnexionServeur: TfrmFirebirdConnexionServeur
  Caption = 'Connexion Interbase/Firebird'
  ClientHeight = 158
  ExplicitWidth = 472
  ExplicitHeight = 190
  DesignSize = (
    466
    158)
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Height = 139
    ExplicitHeight = 142
  end
  inherited bvlSeparateur_2: TBevel
    Top = 215
    Visible = False
    ExplicitTop = 215
  end
  inherited img: TImage
    Height = 139
    Stretch = True
    Transparent = True
    ExplicitHeight = 233
  end
  inherited edtBD: TLabeledEdit
    Width = 144
    EditLabel.Width = 135
    EditLabel.Caption = 'Chemin de base de donn'#233'es'
    EditLabel.ExplicitLeft = 141
    EditLabel.ExplicitTop = 55
    EditLabel.ExplicitWidth = 135
    TabOrder = 2
    ExplicitWidth = 144
  end
  inherited btnAnnuler: TButton
    Top = 114
    TabOrder = 7
    ExplicitTop = 114
  end
  inherited btnOK: TButton
    Top = 114
    TabOrder = 6
    ExplicitTop = 114
  end
  inherited edtUtilisateur: TLabeledEdit
    Left = 295
    Top = 230
    EditLabel.ExplicitLeft = 229
    EditLabel.ExplicitTop = 234
    EditLabel.ExplicitWidth = 46
    TabOrder = 3
    Visible = False
    ExplicitLeft = 295
    ExplicitTop = 230
  end
  inherited edtMotDePasse: TLabeledEdit
    Left = 295
    Top = 257
    EditLabel.ExplicitLeft = 211
    EditLabel.ExplicitTop = 261
    EditLabel.ExplicitWidth = 64
    TabOrder = 4
    Visible = False
    ExplicitLeft = 295
    ExplicitTop = 257
  end
  inherited chkConnexionLocale: TCheckBox
    Top = 86
    Caption = 'Utiliser le serveur int'#233'gr'#233' '#224' commit'
    TabOrder = 5
    OnClick = chkConnexionLocaleClick
    ExplicitTop = 86
  end
  object edtCheminBD: TJvFilenameEdit
    Left = 296
    Top = 51
    Width = 145
    Height = 21
    AddQuotes = False
    Filter = 
      'Bases Interbase/Firebird (*.gdb, *.fdb)|*.fdb;*.gdb|All files (*' +
      '.*)|*.*'
    TabOrder = 1
  end
end
