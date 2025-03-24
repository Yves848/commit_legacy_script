inherited frHistoAchat: TfrHistoAchat
  inherited Splitter: TSplitter
    Visible = False
    ExplicitWidth = 733
  end
  inherited pnlCritere: TPanel
    Visible = False
    ExplicitWidth = 726
  end
  inherited grdResultat: TPIDBGrid
    Visible = False
  end
  inherited ScrollBox: TScrollBox
    ExplicitWidth = 726
    ExplicitHeight = 280
    object lblDesignation: TLabel
      Left = 8
      Top = 8
      Width = 56
      Height = 13
      Caption = 'D'#233'signation'
    end
    object lblCodeCIP: TLabel
      Left = 8
      Top = 32
      Width = 45
      Height = 13
      Caption = 'Code CIP'
    end
    object lblHistoAchat: TLabel
      Left = 8
      Top = 64
      Width = 238
      Height = 13
      Caption = 'Historique des achats (qt'#233' totale re'#231'ue / nb cdes)'
    end
    object lblAchats: TLabel
      Left = 8
      Top = 171
      Width = 33
      Height = 13
      Caption = 'Achats'
    end
    object lblPAMP: TLabel
      Left = 8
      Top = 328
      Width = 27
      Height = 13
      Caption = 'PAMP'
    end
    object lblCmdEnCours: TLabel
      Left = 8
      Top = 352
      Width = 102
      Height = 13
      Caption = 'Commandes en cours'
    end
    object lblAnnee112: TLabel
      Left = 8
      Top = 112
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAnnee1324: TLabel
      Left = 8
      Top = 136
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDesignation: TDBEdit
      Left = 80
      Top = 4
      Width = 505
      Height = 21
      DataField = 'DESIGNATION'
      DataSource = dsProduits
      TabOrder = 0
    end
    object edtCodeCIP: TDBEdit
      Left = 80
      Top = 28
      Width = 57
      Height = 21
      DataField = 'CODE_CIP'
      DataSource = dsProduits
      TabOrder = 1
    end
    object dbGrdCmdEnCours: TPIDBGrid
      Left = 8
      Top = 192
      Width = 577
      Height = 120
      BorderStyle = bsNone
      DataSource = dsListeAchats
      DefaultDrawing = False
      DrawingStyle = gdsGradient
      GradientEndColor = 14790035
      GradientStartColor = 15584957
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentColor = True
      TabOrder = 4
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
      Options2.CouleurSelection = clHighlight
      Options2.PoliceSelection.Charset = DEFAULT_CHARSET
      Options2.PoliceSelection.Color = clWindowText
      Options2.PoliceSelection.Height = -11
      Options2.PoliceSelection.Name = 'MS Sans Serif'
      Options2.PoliceSelection.Style = []
      Options2.OptionsImpression.UniqLigneSelectionne = False
      Options2.OptionsImpression.FondCellule = False
      Options2.OptionsImpression.FondTitre = False
      Options2.PointSuspensionDonnees = True
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
          FieldName = 'RAISON_SOCIALE'
          Title.Alignment = taCenter
          Width = 93
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
          FieldName = 'PRIX_ACHAT_TARIF'
          Title.Alignment = taCenter
          Width = 55
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
          FieldName = 'PRIX_ACHAT_REMISE'
          Title.Alignment = taCenter
          Width = 55
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
          FieldName = 'QUANTITE_COMMANDEE'
          Title.Alignment = taCenter
          Width = 45
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
          FieldName = 'QUANTITE_RECUE'
          Title.Alignment = taCenter
          Width = 45
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
          FieldName = 'QUANTITE_A_RECEVOIR'
          Title.Alignment = taCenter
          Width = 45
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
          FieldName = 'T_COMMANDE_ID'
          Title.Alignment = taCenter
          Width = 60
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
          FieldName = 'DATE_CREATION'
          Title.Alignment = taCenter
          Width = 70
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
          FieldName = 'ETAT'
          Title.Alignment = taCenter
          Width = 70
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
    object edtPAMP: TDBEdit
      Left = 128
      Top = 324
      Width = 73
      Height = 21
      DataField = 'PAMP'
      DataSource = dsProduits
      TabOrder = 2
    end
    object edtCmdEnCours: TDBEdit
      Left = 128
      Top = 348
      Width = 73
      Height = 21
      DataField = 'COMMANDES_EN_COURS'
      DataSource = dsProduits
      TabOrder = 3
    end
    object dbGrdHistoAchat112: TDBCtrlGrid
      Left = 93
      Top = 84
      Width = 492
      Height = 65
      AllowDelete = False
      AllowInsert = False
      ColCount = 12
      DataSource = dsHistoAchat1
      Orientation = goHorizontal
      PanelHeight = 49
      PanelWidth = 41
      TabOrder = 5
      RowCount = 1
      object pnlMois: TPanel
        Left = 0
        Top = 0
        Width = 41
        Height = 25
        Align = alTop
        ParentColor = True
        TabOrder = 0
        object txtMois: TDBText
          Left = 1
          Top = 4
          Width = 39
          Height = 16
          Alignment = taCenter
          DataField = 'AABRMOIS'
          DataSource = dsHistoAchat1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object pnlAchat112: TPanel
        Left = 0
        Top = 25
        Width = 41
        Height = 24
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWindow
        TabOrder = 1
        object txtAchat112: TDBText
          Left = 2
          Top = 2
          Width = 33
          Height = 16
          Alignment = taCenter
          Color = clBtnFace
          DataField = 'AQUANTITERECUES'
          DataSource = dsHistoAchat1
          ParentColor = False
          Transparent = True
        end
      end
    end
    object dbGrdHistoAchat1324: TDBCtrlGrid
      Left = 93
      Top = 132
      Width = 492
      Height = 41
      ColCount = 12
      DataSource = dsHistoAchat2
      Orientation = goHorizontal
      PanelHeight = 25
      PanelWidth = 41
      TabOrder = 6
      RowCount = 1
      object pnlAchat1324: TPanel
        Left = 0
        Top = 0
        Width = 41
        Height = 24
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvNone
        BorderStyle = bsSingle
        Color = clWindow
        TabOrder = 0
        object txtAchat1324: TDBText
          Left = 2
          Top = 2
          Width = 33
          Height = 16
          Alignment = taCenter
          Color = clBtnFace
          DataField = 'AQUANTITERECUES'
          DataSource = dsHistoAchat2
          ParentColor = False
          Transparent = True
        end
      end
    end
    object Panel1: TPanel
      Left = 9
      Top = 157
      Width = 492
      Height = 16
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetHistoriqueAchats
  end
  object dsHistoAchat1: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetHistoAchats1
    Left = 336
    Top = 208
  end
  object dsHistoAchat2: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetHistoAchats2
    Left = 512
    Top = 200
  end
  object dsListeAchats: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetListeAchats
    Left = 536
    Top = 296
  end
  object dsCodeEAN13: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetProduits
    Left = 672
    Top = 56
  end
  object dsProduits: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetProduits
    Left = 600
    Top = 96
  end
end
