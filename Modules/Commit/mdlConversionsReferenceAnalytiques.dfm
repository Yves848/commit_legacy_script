inherited frConversionsReferenceAnalytiques: TfrConversionsReferenceAnalytiques
  inherited grdConversions: TPIDBGrid
    OnDrawColumnCell = grdConversionsDrawColumnCell
    OnDblClick = nil
    Columns = <
      item
        Expanded = False
        FieldName = 'AREFERENCEANALYTIQUE'
        Title.Caption = 'R'#233'f'#233'rence Analytique'
        Width = 300
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
        FieldName = 'ATR_REFERENCEANALYTIQUE'
        Title.Caption = 'LIEN R'#233'f'#233'rence Analytique Ultimate'
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
      end>
  end
  inherited dsConversions: TDataSource
    DataSet = dmModuleImportPHA.setConversionsReferenceAnalytiques
  end
end
