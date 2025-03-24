inherited frCodifications: TfrCodifications
  Color = clWindow
  Ctl3D = False
  ParentColor = False
  ParentCtl3D = False
  ExplicitWidth = 736
  ExplicitHeight = 417
  inherited Splitter: TSplitter
    Visible = False
    ExplicitWidth = 729
  end
  inherited pnlCritere: TPanel
    Visible = False
    ExplicitWidth = 736
    inherited edtCritere: TEdit
      Height = 19
      ExplicitHeight = 19
    end
  end
  inherited grdResultat: TPIDBGrid
    Visible = False
  end
  inherited ScrollBox: TScrollBox
    ParentColor = True
    ExplicitWidth = 736
    ExplicitHeight = 261
    object lblSelection: TLabel
      Left = 16
      Top = 8
      Width = 43
      Height = 13
      Caption = 'S'#233'lection'
    end
    object bvlSeparator: TBevel
      Left = 8
      Top = 24
      Width = 337
      Height = 9
      Shape = bsBottomLine
    end
    object lblLabel: TLabel
      Left = 16
      Top = 44
      Width = 29
      Height = 13
      Caption = 'Libell'#233
    end
    object cbxSelection: TComboBox
      Left = 80
      Top = 4
      Width = 257
      Height = 21
      Style = csDropDownList
      ParentColor = True
      TabOrder = 0
      OnChange = cbxSelectionChange
      Items.Strings = (
        'Zones g'#233'ographiques'
        'Codification 1'
        'Codification 2'
        'Codification 3'
        'Codification 4'
        'Codification 5'
        'Codification 6'
        'Codification 7')
    end
    object dbGrdCodifs: TPIDBGrid
      Left = 16
      Top = 72
      Width = 321
      Height = 345
      BorderStyle = bsNone
      DataSource = dsResultat
      DefaultDrawing = False
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      MenuColonneActif = False
      StyleBordure = sbAucune
      Options2.LargeurIndicateur = 11
      Options2.LignesParLigneDonnees = 1
      Options2.LignesParTitre = 1
      Options2.CouleurSelection = 9434356
      Options2.PoliceSelection.Charset = DEFAULT_CHARSET
      Options2.PoliceSelection.Color = clWindowText
      Options2.PoliceSelection.Height = -11
      Options2.PoliceSelection.Name = 'MS Sans Serif'
      Options2.PoliceSelection.Style = []
      Options2.OptionsImpression.UniqLigneSelectionne = False
      Options2.OptionsImpression.FondCellule = False
      Options2.OptionsImpression.FondTitre = False
      Options2.PointSuspensionDonnees = False
      Options2.PointSuspensionTitre = False
      Options2.CoinsRonds = False
      Details = False
      HauteurEntetes = 17
      Entetes = <>
      MultiSelection.Active = False
      MultiSelection.Mode = mmsSelection
      Columns = <
        item
          Expanded = False
          FieldName = 'LIBELLE'
          Title.Alignment = taCenter
          Width = 205
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
          FieldName = 'TAUX_MARQUE'
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
        end>
    end
    object edtLabel: TEdit
      Left = 80
      Top = 40
      Width = 257
      Height = 19
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetCodifications
  end
end
