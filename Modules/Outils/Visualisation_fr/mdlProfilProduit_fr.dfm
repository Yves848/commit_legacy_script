inherited frProfilProduit: TfrProfilProduit
  inherited Splitter: TSplitter
    Top = 137
    Visible = False
    ExplicitTop = 137
    ExplicitWidth = 989
  end
  inherited pnlCritere: TPanel
    Visible = False
    ExplicitWidth = 669
    inherited lblCritere: TLabel
      Width = 45
      Caption = 'Code CIP'
      ExplicitWidth = 45
    end
    inherited btnChercher: TPISpeedButton
      Left = 499
      ExplicitLeft = 499
    end
    inherited edtCritere: TEdit
      Left = 80
      Width = 417
      ExplicitLeft = 80
      ExplicitWidth = 417
    end
  end
  inherited grdResultat: TPIDBGrid
    Height = 104
    Constraints.MinHeight = 0
    Visible = False
  end
  inherited ScrollBox: TScrollBox
    Top = 140
    Height = 164
    ParentColor = True
    ExplicitTop = 140
    ExplicitHeight = 164
    object lblDesignation: TLabel
      Left = 8
      Top = 8
      Width = 56
      Height = 13
      Caption = 'D'#233'signation'
    end
    object lblCodeCIP: TLabel
      Left = 512
      Top = 8
      Width = 45
      Height = 13
      Caption = 'Code CIP'
    end
    object lblDernVente: TLabel
      Left = 8
      Top = 280
      Width = 112
      Height = 13
      Caption = 'Date de derni'#232're vente'
    end
    object lblCalculGS: TLabel
      Left = 345
      Top = 280
      Width = 28
      Height = 13
      Caption = 'Calcul'
    end
    object lblCmdEnCours: TLabel
      Left = 8
      Top = 485
      Width = 102
      Height = 13
      Caption = 'Commandes en cours'
    end
    object Bevel1: TBevel
      Left = 8
      Top = 192
      Width = 641
      Height = 71
    end
    object lblHistoVente: TLabel
      Left = 14
      Top = 206
      Width = 9
      Height = 13
      Caption = 'V'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblHistoAchat: TLabel
      Left = 14
      Top = 228
      Width = 9
      Height = 13
      Caption = 'A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBCtrlGrid1: TDBCtrlGrid
      Left = 41
      Top = 201
      Width = 600
      Height = 38
      ColCount = 24
      DataSource = dsHistoriqueVentes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Orientation = goHorizontal
      PanelHeight = 22
      PanelWidth = 25
      ParentFont = False
      TabOrder = 6
      RowCount = 1
      object DBEdit1: TDBEdit
        Left = 1
        Top = 1
        Width = 23
        Height = 19
        DataField = 'AQUANTITEVENDUES'
        DataSource = dsHistoriqueVentes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object DBCtrlGrid2: TDBCtrlGrid
      Left = 41
      Top = 223
      Width = 600
      Height = 38
      ColCount = 24
      DataSource = dsHistoriqueAchats
      Orientation = goHorizontal
      PanelHeight = 22
      PanelWidth = 25
      TabOrder = 7
      RowCount = 1
      object DBEdit2: TDBEdit
        Left = 1
        Top = 1
        Width = 23
        Height = 19
        DataField = 'AQUANTITERECUES'
        DataSource = dsHistoriqueAchats
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object Panel1: TPanel
      Left = 40
      Top = 245
      Width = 601
      Height = 16
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 8
    end
    object edtDesignation: TDBEdit
      Left = 80
      Top = 4
      Width = 409
      Height = 21
      DataField = 'DESIGNATION'
      DataSource = dsProduits
      ParentColor = True
      TabOrder = 0
    end
    object edtCodeCIP: TDBEdit
      Left = 568
      Top = 4
      Width = 81
      Height = 21
      DataField = 'CODE_CIP'
      DataSource = dsProduits
      ParentColor = True
      TabOrder = 1
    end
    object edtDernVente: TDBEdit
      Left = 136
      Top = 276
      Width = 73
      Height = 21
      DataField = 'DATE_DERNIERE_VENTE'
      DataSource = dsProduits
      TabOrder = 3
    end
    object edtCalculGS: TDBEdit
      Left = 392
      Top = 276
      Width = 249
      Height = 21
      DataField = 'CALCUL_GS'
      DataSource = dsProduits
      TabOrder = 4
    end
    object dbGrdCmdEnCours: TPIDBGrid
      Left = 8
      Top = 500
      Width = 305
      Height = 61
      BorderStyle = bsNone
      DataSource = dsCommandesEnCours
      DefaultDrawing = False
      DrawingStyle = gdsGradient
      GradientEndColor = 14790035
      GradientStartColor = 15584957
      ParentColor = True
      TabOrder = 5
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
          FieldName = 'RAISON_SOCIALE'
          Title.Alignment = taCenter
          Width = 156
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
          Width = 40
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
    object sBxHistVteAch: TScrollBox
      Left = 8
      Top = 32
      Width = 641
      Height = 153
      TabOrder = 2
      object dbChHistoVente: TDBChart
        Left = 0
        Top = 0
        Width = 637
        Height = 149
        AutoRefresh = False
        AllowPanning = pmHorizontal
        BackWall.Brush.Color = clWhite
        BackWall.Color = clWindow
        LeftWall.Brush.Color = clWhite
        MarginLeft = 0
        MarginRight = 0
        Title.Text.Strings = (
          'TDBChart')
        Title.Visible = False
        BottomAxis.Grid.Visible = False
        BottomAxis.MinorTickLength = 0
        BottomAxis.TickLength = 0
        BottomAxis.Ticks.Visible = False
        BottomAxis.TicksInner.Visible = False
        DepthAxis.MinorGrid.Style = psDash
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMinimum = False
        LeftAxis.LabelsOnAxis = False
        LeftAxis.MinorGrid.Visible = True
        LeftAxis.MinorTickCount = 0
        LeftAxis.MinorTicks.Visible = False
        LeftAxis.Ticks.Visible = False
        LeftAxis.TicksInner.Visible = False
        Legend.Visible = False
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        RightAxis.Axis.Width = 1
        RightAxis.Axis.Visible = False
        RightAxis.Grid.Visible = False
        RightAxis.MinorTicks.Visible = False
        RightAxis.Ticks.Visible = False
        RightAxis.TicksInner.Visible = False
        RightAxis.Visible = False
        TopAxis.Visible = False
        View3D = False
        Zoom.Allow = False
        Align = alClient
        BevelOuter = bvNone
        BevelWidth = 0
        BorderWidth = 7
        ParentColor = True
        TabOrder = 0
        PrintMargins = (
          15
          38
          15
          38)
        object Series1: TBarSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          DataSource = dmVisualisationPHA_fr.dSetHistoriqueVentes
          SeriesColor = clLime
          ShowInLegend = False
          Title = 'Qte vente'
          XLabelsSource = 'APERIODE'
          AutoMarkPosition = False
          Dark3D = False
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8487297
          SideMargins = False
          UseYOrigin = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'AQUANTITEVENDUES'
        end
        object Series2: TBarSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          DataSource = dmVisualisationPHA_fr.dSetHistoriqueAchats
          ShowInLegend = False
          Title = 'Qte achat'
          XLabelsSource = 'APERIODE'
          AutoMarkPosition = False
          Dark3D = False
          Gradient.Direction = gdTopBottom
          Shadow.Color = 8553090
          SideMargins = False
          UseYOrigin = False
          XValues.Name = 'X '
          XValues.Order = loAscending
          YValues.Name = 'Histo. '
          YValues.Order = loNone
          YValues.ValueSource = 'AQUANTITERECUES'
        end
      end
    end
    inline frStock: TfrStock
      Left = 8
      Top = 313
      Width = 569
      Height = 169
      AutoSize = True
      TabOrder = 9
      ExplicitLeft = 8
      ExplicitTop = 313
      inherited dbGrdStock: TPIDBGrid
        DrawingStyle = gdsGradient
        GradientEndColor = 14790035
        GradientStartColor = 15584957
        ParentColor = True
        Options2.CouleurSelection = 9434356
        Options2.PoliceSelection.Color = clWindowText
      end
      inherited txtPrdDus: TDBEdit
        DataField = 'NOMBRE_PRODUIT_DU'
        DataSource = dsProduits
      end
      inherited edtStockTotal: TDBEdit
        DataField = 'QUANTITE_TOTAL'
        DataSource = dsProduits
      end
      inherited dsProduitsGeo: TDataSource
        DataSet = dmVisualisationPHA_fr.dSetProduitStock
      end
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetProduits
  end
  object dsCommandesEnCours: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetCommandesEnCours
    Left = 224
    Top = 496
  end
  object dsHistoriqueVentes: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetHistoriqueVentes
    Left = 232
    Top = 96
  end
  object dsHistoriqueAchats: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetHistoriqueAchats
    Left = 296
    Top = 96
  end
  object dsProduits: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetProduits
    Left = 544
    Top = 200
  end
end
