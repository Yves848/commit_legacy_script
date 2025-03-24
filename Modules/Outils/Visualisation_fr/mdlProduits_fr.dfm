inherited frProduits: TfrProduits
  Ctl3D = False
  ParentCtl3D = False
  ExplicitWidth = 1019
  ExplicitHeight = 590
  inherited Splitter: TSplitter
    Top = 125
    ExplicitTop = 125
    ExplicitWidth = 753
  end
  inherited pnlCritere: TPanel
    ExplicitWidth = 1019
    inherited lblCritere: TLabel
      Width = 111
      Caption = 'Code CIP / D'#233'signation'
      ExplicitWidth = 111
    end
    inherited btnChercher: TPISpeedButton
      Left = 588
      Top = 5
      OnClick = btnChercherClick
      ExplicitLeft = 588
      ExplicitTop = 5
    end
    inherited edtCritere: TEdit
      Left = 133
      Width = 447
      Height = 19
      ExplicitLeft = 133
      ExplicitWidth = 447
      ExplicitHeight = 19
    end
    object DBNavigator1: TDBNavigator
      Left = 676
      Top = 4
      Width = 42
      Height = 23
      DataSource = dsResultat
      VisibleButtons = [nbPrior, nbNext]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
    end
  end
  inherited grdResultat: TPIDBGrid
    Height = 92
    Columns = <
      item
        Expanded = False
        FieldName = 'T_PRODUIT_ID'
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
        FieldName = 'CODE_CIP'
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
        FieldName = 'PRIX_VENTE'
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
      end
      item
        Expanded = False
        FieldName = 'QUANTITE_TOTAL'
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
        FieldName = 'QUANTITE_PHA'
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
        FieldName = 'ZONE_GEOGRAPHIQUE_PHA'
        Title.Alignment = taCenter
        Width = 145
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
  inherited ScrollBox: TScrollBox
    Top = 128
    Height = 176
    ExplicitTop = 128
    ExplicitWidth = 1019
    ExplicitHeight = 176
    object lblDesignation: TLabel
      Left = 8
      Top = 8
      Width = 56
      Height = 13
      Caption = 'D'#233'signation'
    end
    object lblCodeCIPHomeo: TLabel
      Left = 8
      Top = 32
      Width = 45
      Height = 13
      Caption = 'Code CIP'
    end
    object lblTypeHomeo: TLabel
      Left = 8
      Top = 64
      Width = 33
      Height = 13
      Caption = 'Hom'#233'o'
    end
    object lblEtat: TLabel
      Left = 8
      Top = 88
      Width = 20
      Height = 13
      Caption = 'Etat'
    end
    object lblDateDernVte: TLabel
      Left = 440
      Top = 8
      Width = 98
      Height = 13
      Caption = 'Date Derniere Vente'
    end
    object txtDesignation: TDBEdit
      Left = 80
      Top = 4
      Width = 337
      Height = 19
      Color = 15987699
      DataField = 'DESIGNATION'
      DataSource = dsResultat
      TabOrder = 0
    end
    object txtCodeCIP: TDBEdit
      Left = 80
      Top = 28
      Width = 115
      Height = 19
      Color = 15987699
      DataField = 'CODE_CIP'
      DataSource = dsResultat
      TabOrder = 2
    end
    object txtTypeHomeo: TDBEdit
      Left = 80
      Top = 60
      Width = 177
      Height = 19
      Color = 15987699
      DataField = 'TYPE_HOMEO'
      DataSource = dsResultat
      TabOrder = 1
    end
    object txtEtat: TDBEdit
      Left = 80
      Top = 84
      Width = 177
      Height = 19
      Color = 15987699
      DataField = 'ETAT'
      DataSource = dsResultat
      TabOrder = 4
    end
    object dbGrdCodeEAN13: TPIDBGrid
      Left = 296
      Top = 29
      Width = 145
      Height = 93
      BorderStyle = bsNone
      DataSource = dsCodesEAN13
      DefaultDrawing = False
      Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
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
      Options2.CouleurSelection = clHighlight
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
      Options2.CoinsRonds = True
      Details = False
      HauteurEntetes = 17
      Entetes = <>
      MultiSelection.Active = False
      MultiSelection.Mode = mmsSelection
      Columns = <
        item
          Expanded = False
          FieldName = 'CODE_EAN13'
          Title.Alignment = taCenter
          Width = 122
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
    object txtDateDernVte: TDBEdit
      Left = 552
      Top = 4
      Width = 97
      Height = 19
      DataField = 'DATE_DERNIERE_VENTE'
      DataSource = dsResultat
      TabOrder = 6
    end
    object pCtrlDetailProduits: TPageControl
      Left = 0
      Top = 122
      Width = 649
      Height = 308
      ActivePage = tShCommentaires
      Align = alBottom
      OwnerDraw = True
      TabOrder = 3
      OnDrawTab = pCtrlDetailProduitsDrawTab
      ExplicitTop = 121
      object tShGestion: TTabSheet
        Caption = 'Gestion'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblTVA: TLabel
          Left = 8
          Top = 5
          Width = 19
          Height = 13
          Caption = 'TVA'
        end
        object lblListe: TLabel
          Left = 209
          Top = 5
          Width = 22
          Height = 13
          Caption = 'Liste'
        end
        object lblPrestation: TLabel
          Left = 493
          Top = 9
          Width = 49
          Height = 13
          Caption = 'Prestation'
        end
        object txtTauxTVA: TDBEdit
          Left = 33
          Top = 3
          Width = 65
          Height = 19
          DataField = 'TAUX_TVA'
          DataSource = dsResultat
          TabOrder = 0
        end
        object txtPrestation: TDBEdit
          Left = 548
          Top = 7
          Width = 49
          Height = 19
          DataField = 'PRESTATION'
          DataSource = dsResultat
          TabOrder = 3
        end
        object txtListe: TDBEdit
          Left = 237
          Top = 3
          Width = 108
          Height = 19
          DataField = 'LISTE'
          DataSource = dsResultat
          TabOrder = 1
        end
        object chkSoumisMDL: TDBCheckBox
          Left = 106
          Top = 4
          Width = 97
          Height = 17
          Caption = 'Soumis MDL'
          DataField = 'SOUMIS_MDL'
          DataSource = dsResultat
          TabOrder = 2
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object chkKit: TDBCheckBox
          Left = 368
          Top = 9
          Width = 33
          Height = 17
          Caption = 'Kit'
          DataField = 'PRODUIT_KIT'
          DataSource = dsResultat
          TabOrder = 4
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object dbGrdCodeLPP: TPIDBGrid
          Left = 368
          Top = 32
          Width = 306
          Height = 73
          BorderStyle = bsNone
          DataSource = dsProduitsLPP
          DefaultDrawing = False
          FixedColor = 14922394
          ReadOnly = True
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
          Options2.CouleurSelection = 9368563
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
              FieldName = 'CODE_LPP'
              Title.Alignment = taCenter
              Width = 58
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
              FieldName = 'QUANTITE'
              Title.Alignment = taCenter
              Title.Caption = 'Nb. unit'#233's'
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
              FieldName = 'TARIF_UNITAIRE'
              Title.Alignment = taCenter
              Width = 74
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
              FieldName = 'PRESTATION'
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
              FieldName = 'SERVICE_TIPS'
              Title.Alignment = taCenter
              Width = 69
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
        object pnlInfoprix: TPanel
          Left = 0
          Top = 28
          Width = 362
          Height = 86
          BevelEdges = []
          BevelOuter = bvNone
          BorderWidth = 1
          BorderStyle = bsSingle
          ParentColor = True
          TabOrder = 6
          object Label2: TLabel
            Left = -1
            Top = 0
            Width = 362
            Height = 14
            AutoSize = False
            Caption = '  Informations Prix'
            Color = clGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object lblBaseRbt: TLabel
            Left = 148
            Top = 20
            Width = 53
            Height = 13
            Caption = 'Tarif remb.'
          end
          object lblPAMP: TLabel
            Left = 148
            Top = 63
            Width = 46
            Height = 13
            Caption = 'PAMP net'
          end
          object lblPrixAchat: TLabel
            Left = 5
            Top = 63
            Width = 48
            Height = 13
            Caption = 'PA Moyen'
          end
          object lblPrixVente: TLabel
            Left = 5
            Top = 20
            Width = 34
            Height = 13
            Caption = 'PV TTC'
          end
          object chkPxAchTarif: TDBCheckBox
            Left = 5
            Top = 39
            Width = 97
            Height = 17
            Caption = 'PA tarif unique'
            DataField = 'TARIF_ACHAT_UNIQUE'
            DataSource = dsResultat
            TabOrder = 0
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object txtBaseRbt: TDBEdit
            Left = 202
            Top = 18
            Width = 97
            Height = 19
            DataField = 'BASE_REMBOURSEMENT'
            DataSource = dsResultat
            TabOrder = 1
          end
          object txtPAHT: TDBEdit
            Left = 61
            Top = 59
            Width = 73
            Height = 19
            DataField = 'PRIX_ACHAT_CATALOGUE'
            DataSource = dsResultat
            TabOrder = 2
          end
          object txtPAMP: TDBEdit
            Left = 202
            Top = 59
            Width = 73
            Height = 19
            DataField = 'PAMP'
            DataSource = dsResultat
            TabOrder = 3
          end
          object txtPVTTC: TDBEdit
            Left = 61
            Top = 16
            Width = 73
            Height = 19
            DataField = 'PRIX_VENTE'
            DataSource = dsResultat
            TabOrder = 4
          end
        end
        object pnlInfoFou: TPanel
          Left = 0
          Top = 120
          Width = 362
          Height = 97
          BevelEdges = []
          BevelOuter = bvNone
          BorderWidth = 1
          BorderStyle = bsSingle
          ParentColor = True
          TabOrder = 7
          object dbGrdTarifs: TPIDBGrid
            Left = 1
            Top = 1
            Width = 358
            Height = 93
            Align = alClient
            BorderStyle = bsNone
            DataSource = dsTarifs
            DefaultDrawing = False
            FixedColor = 14922394
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            ReadOnly = True
            TabOrder = 0
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
            Options2.CouleurSelection = 9368563
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
                Width = 137
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
                FieldName = 'PRIX_ACHAT_CATALOGUE'
                Title.Alignment = taCenter
                Title.Caption = 'PA Cat'
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
                FieldName = 'REMISE_SIMPLE'
                Title.Alignment = taCenter
                Title.Caption = 'Rem'
                Width = 48
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
                Width = 72
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
        end
      end
      object tShStock: TTabSheet
        Caption = 'Stock'
        ImageIndex = 3
        object lblProfilGS: TLabel
          Left = 8
          Top = 8
          Width = 24
          Height = 13
          Caption = 'Profil'
        end
        object lblNbMoisCalcul: TLabel
          Left = 0
          Top = 232
          Width = 210
          Height = 13
          Caption = 'Nbre de mois pris en compte pour les calculs'
        end
        object lblCalcul: TLabel
          Left = 400
          Top = 8
          Width = 28
          Height = 13
          Caption = 'Calcul'
        end
        object txtProfilGSLibelle: TDBText
          Left = 48
          Top = 24
          Width = 225
          Height = 17
          DataField = 'EXPLICATION_PROFIL_GS'
          DataSource = dsResultat
        end
        inline frStock: TfrStock
          Left = 0
          Top = 64
          Width = 569
          Height = 159
          AutoSize = True
          TabOrder = 0
          ExplicitTop = 64
          ExplicitHeight = 159
          inherited lblConditionnement: TLabel
            Top = 96
            ExplicitTop = 96
          end
          inherited lblColisage: TLabel
            Top = 120
            ExplicitTop = 120
          end
          inherited lblUV: TLabel
            Top = 144
            ExplicitTop = 144
          end
          inherited txtConditionnement: TDBEdit
            Top = 92
            Height = 19
            DataSource = dsResultat
            ExplicitTop = 92
            ExplicitHeight = 19
          end
          inherited txtColisage: TDBEdit
            Top = 116
            Height = 19
            DataField = 'LOT_ACHAT'
            DataSource = dsResultat
            ExplicitTop = 116
            ExplicitHeight = 19
          end
          inherited txtMoyVte: TDBEdit
            Top = 140
            Height = 19
            DataField = 'UNITE_MOYENNE_VENTE'
            DataSource = dsResultat
            ExplicitTop = 140
            ExplicitHeight = 19
          end
          inherited dbGrdStock: TPIDBGrid
            BorderStyle = bsSingle
            FixedColor = 14790035
            Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ReadOnly = True
            Options2.CouleurSelection = 9368563
            Options2.PoliceSelection.Color = clWindowText
            Columns = <
              item
                Expanded = False
                FieldName = 'QUANTITE'
                Title.Alignment = taCenter
                Width = 42
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
                FieldName = 'ZONE_GEOGRAPHIQUE'
                Title.Alignment = taCenter
                Width = 124
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
                FieldName = 'DEPOT'
                Title.Alignment = taCenter
                Width = 80
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
                FieldName = 'STOCK_MINI'
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
                FieldName = 'STOCK_MAXI'
                Title.Alignment = taCenter
                Width = 53
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
          inherited txtStockMini: TDBEdit
            Height = 19
            DataField = 'STOCK_MINI'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited txtStockMaxi: TDBEdit
            Height = 19
            DataField = 'STOCK_MAXI'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited txtPrdDus: TDBEdit
            Height = 19
            DataField = 'NOMBRE_PRODUIT_DU'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtStockTotal: TDBEdit
            Height = 19
            DataField = 'QUANTITE_TOTAL'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtDatePeremption: TDBEdit
            Height = 19
            DataField = 'DATE_PEREMPTION'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited dsProduitsGeo: TDataSource
            DataSet = dmVisualisationPHA_fr.dSetProduitStock
          end
        end
        object edtProfilGS: TDBEdit
          Left = 48
          Top = 4
          Width = 217
          Height = 19
          DataField = 'PROFIL_GS'
          DataSource = dsResultat
          TabOrder = 1
        end
        object edtCalculGS: TDBEdit
          Left = 456
          Top = 4
          Width = 185
          Height = 19
          DataField = 'CALCUL_GS'
          DataSource = dsResultat
          TabOrder = 2
        end
        object pnlFournisseurs: TPanel
          Left = 0
          Top = 172
          Width = 305
          Height = 19
          AutoSize = True
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 3
          object lblRepartiteurAttitre: TLabel
            Left = 0
            Top = 4
            Width = 94
            Height = 13
            Caption = 'R'#233'partiteur exclusif'
          end
          object edtRepartiteurAttitre: TDBEdit
            Left = 96
            Top = 0
            Width = 209
            Height = 19
            DataField = 'REPARTITEUR_ATTITRE'
            DataSource = dsResultat
            TabOrder = 0
          end
        end
        object edtNbMoisCalcul: TDBEdit
          Left = 224
          Top = 228
          Width = 81
          Height = 19
          DataField = 'NOMBRE_MOIS_CALCUL'
          DataSource = dsResultat
          TabOrder = 4
        end
      end
      object tShDivers: TTabSheet
        Caption = 'Divers'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblContenance: TLabel
          Left = 488
          Top = 125
          Width = 58
          Height = 13
          Caption = 'Contenance'
        end
        object lblDelaiLait: TLabel
          Left = 288
          Top = 58
          Width = 87
          Height = 13
          Caption = 'LAIT      - Nb jours'
        end
        object lblDelaiViande: TLabel
          Left = 288
          Top = 85
          Width = 87
          Height = 13
          Caption = 'VIANDE - Nb jours'
        end
        object lblCodificationsLibre: TLabel
          Left = 8
          Top = 8
          Width = 108
          Height = 13
          Caption = 'Codifications libres'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblCodif1: TDBText
          Left = 16
          Top = 32
          Width = 41
          Height = 13
          AutoSize = True
          DataField = 'ALIBELLECDF1'
          DataSource = dsLibellesCodifications
        end
        object lblCodif2: TDBText
          Left = 16
          Top = 56
          Width = 41
          Height = 13
          AutoSize = True
          DataField = 'ALIBELLECDF2'
          DataSource = dsLibellesCodifications
        end
        object lblCodif4: TDBText
          Left = 16
          Top = 104
          Width = 41
          Height = 13
          AutoSize = True
          DataField = 'ALIBELLECDF4'
          DataSource = dsLibellesCodifications
        end
        object lblCodif3: TDBText
          Left = 16
          Top = 80
          Width = 41
          Height = 13
          AutoSize = True
          DataField = 'ALIBELLECDF3'
          DataSource = dsLibellesCodifications
        end
        object lblCodif5: TDBText
          Left = 16
          Top = 128
          Width = 41
          Height = 13
          AutoSize = True
          DataField = 'ALIBELLECDF5'
          DataSource = dsLibellesCodifications
        end
        object lblCodif7: TLabel
          Left = 16
          Top = 152
          Width = 65
          Height = 13
          Caption = 'Codification 7'
        end
        object lblMarque: TLabel
          Left = 16
          Top = 174
          Width = 36
          Height = 13
          Caption = 'Marque'
        end
        object Label1: TLabel
          Left = 268
          Top = 8
          Width = 27
          Height = 13
          Caption = 'Veto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 488
          Top = 8
          Width = 127
          Height = 13
          Caption = 'Infos compl'#233'mentaires'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txtContenance: TDBEdit
          Left = 552
          Top = 122
          Width = 41
          Height = 19
          DataField = 'CONTENANCE'
          DataSource = dsResultat
          TabOrder = 0
        end
        object txtDelaiLait: TDBEdit
          Left = 388
          Top = 56
          Width = 49
          Height = 19
          Color = 14737632
          DataField = 'DELAI_LAIT'
          DataSource = dsResultat
          TabOrder = 3
        end
        object txtDelaiViande: TDBEdit
          Left = 388
          Top = 81
          Width = 49
          Height = 19
          Color = 14737632
          DataField = 'DELAI_VIANDE'
          DataSource = dsResultat
          TabOrder = 4
        end
        object txtUniteMesure: TDBEdit
          Left = 599
          Top = 122
          Width = 81
          Height = 19
          DataField = 'UNITE_MESURE'
          DataSource = dsResultat
          TabOrder = 1
        end
        object chkVeterinaire: TDBCheckBox
          Left = 268
          Top = 27
          Width = 113
          Height = 17
          Caption = 'Produit V'#233't'#233'rinaire'
          DataField = 'VETERINAIRE'
          DataSource = dsResultat
          TabOrder = 2
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object chkGereInteressement: TDBCheckBox
          Left = 488
          Top = 30
          Width = 137
          Height = 17
          Caption = 'Int'#233'ressement op'#233'rateur'
          DataField = 'GERE_INTERESSEMENT'
          DataSource = dsResultat
          TabOrder = 5
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object chkTracabilite: TDBCheckBox
          Left = 488
          Top = 51
          Width = 97
          Height = 17
          Caption = 'Tra'#231'abilit'#233
          DataField = 'TRACABILITE'
          DataSource = dsResultat
          TabOrder = 6
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object chkGereSuiviClient: TDBCheckBox
          Left = 488
          Top = 73
          Width = 97
          Height = 17
          Caption = 'Suivi client'
          DataField = 'GERE_SUIVI_CLIENT'
          DataSource = dsResultat
          TabOrder = 7
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object chkGerePFC: TDBCheckBox
          Left = 488
          Top = 99
          Width = 169
          Height = 17
          Caption = 'Echantillonnage Pierre Fabre'
          DataField = 'GERE_PFC'
          DataSource = dsResultat
          TabOrder = 8
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object edtCodif1: TDBEdit
          Left = 96
          Top = 28
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'CODIFICATION_1'
          DataSource = dsResultat
          TabOrder = 9
        end
        object edtCodif2: TDBEdit
          Left = 96
          Top = 52
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'CODIFICATION_2'
          DataSource = dsResultat
          TabOrder = 10
        end
        object edtCodif3: TDBEdit
          Left = 96
          Top = 76
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'CODIFICATION_3'
          DataSource = dsResultat
          TabOrder = 11
        end
        object edtCodif4: TDBEdit
          Left = 96
          Top = 100
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'CODIFICATION_4'
          DataSource = dsResultat
          TabOrder = 12
        end
        object edtCodif5: TDBEdit
          Left = 96
          Top = 124
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'CODIFICATION_5'
          DataSource = dsResultat
          TabOrder = 13
        end
        object edtCodif7: TDBEdit
          Left = 96
          Top = 148
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'CODIFICATION_7'
          DataSource = dsResultat
          TabOrder = 14
        end
        object edtMarque: TDBEdit
          Left = 96
          Top = 172
          Width = 161
          Height = 19
          Color = 15987699
          DataField = 'MARQUE'
          DataSource = dsResultat
          TabOrder = 15
        end
      end
      object tShCommentaires: TTabSheet
        Caption = 'Commentaires'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblCommVente: TLabel
          Left = 8
          Top = 8
          Width = 94
          Height = 13
          Caption = 'Commentaire vente'
        end
        object lblCommCommande: TLabel
          Left = 8
          Top = 84
          Width = 117
          Height = 13
          Caption = 'Commentaire commande'
        end
        object lblCommGestion: TLabel
          Left = 8
          Top = 160
          Width = 101
          Height = 13
          Caption = 'Commentaire gestion'
        end
        object mmCommVente: TDBMemo
          Left = 144
          Top = 4
          Width = 169
          Height = 73
          Color = 15987699
          DataField = 'COMMENTAIRE_VENTE'
          DataSource = dsResultat
          TabOrder = 0
        end
        object mmCommCommande: TDBMemo
          Left = 144
          Top = 80
          Width = 169
          Height = 73
          Color = 15987699
          DataField = 'COMMENTAIRE_COMMANDE'
          DataSource = dsResultat
          TabOrder = 1
        end
        object mmCommGestion: TDBMemo
          Left = 144
          Top = 156
          Width = 169
          Height = 73
          Color = 15987699
          DataField = 'COMMENTAIRE_GESTION'
          DataSource = dsResultat
          TabOrder = 2
        end
      end
    end
    object txtCodeCIP7: TDBEdit
      Left = 201
      Top = 28
      Width = 56
      Height = 19
      Color = 15987699
      DataField = 'CODE_CIP7'
      DataSource = dsResultat
      TabOrder = 7
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetProduits
    Left = 464
  end
  inherited pmnMenuFrame: TJvPopupMenu
    object mnuProfilProduit: TMenuItem
      Caption = '&Profil produit'
      ShortCut = 112
      OnClick = mnuProfilProduitClick
    end
    object mnuHistoAchat: TMenuItem
      Caption = '&Historique achat'
      ShortCut = 113
      OnClick = mnuHistoAchatClick
    end
    object mnuHistoClient: TMenuItem
      Caption = 'Derni'#232'res &ventes par client'
      ShortCut = 114
    end
    object mnuPromotions: TMenuItem
      Caption = '&Promotions'
      ShortCut = 115
      OnClick = mnuPromotionsClick
    end
  end
  object dsTarifs: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetCatalogues
    Left = 472
    Top = 176
  end
  object dsCodesEAN13: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetCodesEAN13
    Left = 392
    Top = 176
  end
  object dsProduitsLPP: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetProduitsLPP
    Left = 296
    Top = 176
  end
  object dsLibellesCodifications: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetLibellesCodifications
    Left = 560
    Top = 48
  end
end
