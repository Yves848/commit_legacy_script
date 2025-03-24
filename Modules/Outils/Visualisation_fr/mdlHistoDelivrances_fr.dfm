inherited frHistoDelivrances: TfrHistoDelivrances
  inherited Splitter: TSplitter
    Top = 345
    Width = 709
    Cursor = crHSplit
    Align = alNone
    Visible = False
    ExplicitTop = 345
    ExplicitWidth = 709
  end
  inherited ScrollBox: TScrollBox [1]
    Top = 348
    Width = 709
    Align = alNone
    Visible = False
    ExplicitTop = 348
    ExplicitWidth = 709
  end
  inherited pnlCritere: TPanel [2]
    ExplicitWidth = 784
    inherited lblCritere: TLabel
      Width = 71
      Caption = 'Client / Produit'
      ExplicitWidth = 71
    end
    inherited btnChercher: TPISpeedButton
      OnClick = btnChercherClick
    end
    inherited edtCritere: TEdit
      Left = 104
      Width = 393
      ExplicitLeft = 104
      ExplicitWidth = 393
    end
    object edtProduit: TEdit
      Left = 504
      Top = 6
      Width = 97
      Height = 21
      Color = 14737632
      TabOrder = 1
      OnEnter = edtProduitEnter
      OnExit = edtProduitExit
      OnKeyDown = edtCritereKeyDown
    end
  end
  inherited grdResultat: TPIDBGrid [3]
    Height = 271
    Align = alClient
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO_FACTURE'
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
        FieldName = 'NOM_PRENOM_CLIENT'
        Title.Alignment = taCenter
        Width = 125
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
        FieldName = 'DATE_ACTE'
        Title.Alignment = taCenter
        Width = 65
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
        FieldName = 'PRATICIEN'
        Title.Alignment = taCenter
        Width = 125
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
        FieldName = 'DATE_PRESCRIPTION'
        Title.Alignment = taCenter
        Width = 65
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
        FieldName = 'CODE_OPERATEUR'
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
        FieldName = 'CODE_CIP'
        Title.Alignment = taCenter
        Width = 103
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
        Width = 130
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
        FieldName = 'QUANTITE_FACTUREE'
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
      end>
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetHistoriqueClient
  end
end
