inherited frmIIPharmaConnexionServeur: TfrmIIPharmaConnexionServeur
  Left = 0
  Top = 0
  Caption = 'frmIIPharmaConnexionServeur'
  ClientHeight = 191
  ClientWidth = 516
  ExplicitWidth = 522
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvlSeparator_1: TBevel
    Width = 380
    Height = 172
    ExplicitWidth = 380
    ExplicitHeight = 172
  end
  inherited img: TImage
    Height = 172
    ExplicitHeight = 172
  end
  object lblCheminBDTarif: TLabel [3]
    Left = 148
    Top = 81
    Width = 179
    Height = 13
    Caption = 'Chemin de la base de donn'#233'es "Tarif"'
  end
  inherited edtServeur: TLabeledEdit
    Left = 346
    EditLabel.ExplicitLeft = 186
    EditLabel.ExplicitTop = 28
    EditLabel.ExplicitWidth = 140
    ExplicitLeft = 346
  end
  inherited edtBD: TLabeledEdit
    Left = 346
    TabStop = False
    EditLabel.Width = 183
    EditLabel.Caption = 'Chemin de base de donn'#233'es "Officine"'
    EditLabel.ExplicitLeft = 143
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 183
    ExplicitLeft = 346
  end
  inherited btnAnnuler: TButton
    Left = 347
    Top = 147
    TabOrder = 8
    ExplicitLeft = 347
  end
  inherited btnOK: TButton
    Left = 241
    Top = 147
    TabOrder = 7
    ExplicitLeft = 241
  end
  inherited edtUtilisateur: TLabeledEdit
    TabStop = False
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 64
    TabOrder = 4
  end
  inherited edtMotDePasse: TLabeledEdit
    TabStop = False
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -16
    EditLabel.ExplicitWidth = 75
    TabOrder = 5
  end
  inherited chkConnexionLocale: TCheckBox
    Top = 119
    TabOrder = 6
  end
  inherited edtCheminBD: TJvFilenameEdit
    Left = 346
    ExplicitLeft = 346
  end
  object edtCheminBDTarif: TJvFilenameEdit
    Left = 346
    Top = 78
    Width = 145
    Height = 21
    AddQuotes = False
    Filter = 
      'Bases Interbase/Firebird (*.gdb, *.fdb)|*.fdb;*.gdb|All files (*' +
      '.*)|*.*'
    TabOrder = 3
  end
end
