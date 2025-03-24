inherited frVignettesAvancees: TfrVignettesAvancees
  inherited Splitter: TSplitter
    Top = 242
    Width = 651
    Cursor = crHSplit
    Align = alNone
    Visible = False
    ExplicitTop = 242
    ExplicitWidth = 651
  end
  inherited ScrollBox: TScrollBox [1]
    Top = 432
    Width = 651
    Height = 221
    Align = alNone
    Visible = False
    ExplicitTop = 432
    ExplicitWidth = 651
    ExplicitHeight = 221
  end
  inherited pnlCritere: TPanel [2]
    inherited lblCritere: TLabel
      Width = 67
      Caption = 'NOM+Pr'#233'nom'
      ExplicitWidth = 67
    end
    inherited btnChercher: TPISpeedButton
      Left = 515
      OnClick = btnChercherClick
      ExplicitLeft = 515
    end
    inherited edtCritere: TEdit
      Left = 96
      Width = 417
      ExplicitLeft = 96
      ExplicitWidth = 417
    end
  end
  inherited grdResultat: TPIDBGrid [3]
    Height = 271
    Align = alClient
    Columns = <
      item
        Expanded = False
        FieldName = 'CODE_CIP'
        Title.Alignment = taCenter
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'DESIGNATION'
        Title.Alignment = taCenter
        Width = 140
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'NOM'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'PRENOM'
        Title.Alignment = taCenter
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'QUANTITE_AVANCEE'
        Title.Alignment = taCenter
        Width = 30
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'PRIX_VENTE'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end
      item
        Expanded = False
        FieldName = 'DATE_AVANCE'
        Title.Alignment = taCenter
        Width = 75
        Visible = True
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Options = [ocExport, ocImpression]
      end>
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetVignettesAvancees
  end
end
