inherited frClients: TfrClients
  Width = 451
  AutoSize = False
  Color = clWhite
  Ctl3D = False
  ParentColor = False
  ParentCtl3D = False
  inherited Splitter: TSplitter
    Top = 144
    Width = 451
    ExplicitTop = 144
    ExplicitWidth = 943
  end
  inherited pnlCritere: TPanel
    Width = 451
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    inherited lblCritere: TLabel
      Width = 67
      Caption = 'NOM+Pr'#233'nom'
      ExplicitWidth = 67
    end
    inherited btnChercher: TPISpeedButton
      OnClick = btnChercherClick
    end
    inherited edtCritere: TEdit
      Left = 96
      Width = 505
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      ExplicitLeft = 96
      ExplicitWidth = 505
      ExplicitHeight = 19
    end
    object DBNavigator1: TDBNavigator
      Left = 688
      Top = 3
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
    Width = 451
    Height = 111
    ParentColor = True
    StyleBordure = sbimple
    Options2.CouleurSelection = 9368563
    Columns = <
      item
        Expanded = False
        FieldName = 'T_CLIENT_ID'
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
        FieldName = 'NOM'
        Title.Alignment = taCenter
        Width = 100
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
        Width = 100
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
        FieldName = 'DATE_NAISSANCE'
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
        FieldName = 'TYPE_QUALITE'
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
        FieldName = 'NUMERO_INSEE'
        Title.Alignment = taCenter
        Width = 101
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
        FieldName = 'CODE_POSTAL_VILLE'
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
    Top = 147
    Width = 451
    Height = 157
    Ctl3D = False
    ParentCtl3D = False
    ExplicitTop = 147
    ExplicitHeight = 157
    object lblNom: TLabel
      Left = 8
      Top = 8
      Width = 21
      Height = 13
      Caption = 'Nom'
    end
    object lblQualite: TLabel
      Left = 8
      Top = 56
      Width = 34
      Height = 13
      Caption = 'Qualit'#233
    end
    object lblPrenom: TLabel
      Left = 8
      Top = 32
      Width = 36
      Height = 13
      Caption = 'Pr'#233'nom'
    end
    object lblNomJeuneFille: TLabel
      Left = 248
      Top = 6
      Width = 70
      Height = 13
      Caption = 'Nom jeune fille'
    end
    object lblRangGemellaire: TLabel
      Left = 248
      Top = 80
      Width = 76
      Height = 13
      Caption = 'Rang g'#233'mellaire'
    end
    object lblNumeroInsee: TLabel
      Left = 248
      Top = 56
      Width = 67
      Height = 13
      Caption = 'Num'#233'ro Insee'
    end
    object lblDateNaissance: TLabel
      Left = 248
      Top = 32
      Width = 38
      Height = 13
      Caption = 'N'#233'(e) le'
    end
    object edtNom: TDBEdit
      Left = 96
      Top = 4
      Width = 137
      Height = 19
      Color = 15987699
      DataField = 'NOM'
      DataSource = dsResultat
      TabOrder = 0
    end
    object edtPrenom: TDBEdit
      Left = 96
      Top = 27
      Width = 137
      Height = 19
      Color = 15987699
      DataField = 'PRENOM'
      DataSource = dsResultat
      TabOrder = 1
    end
    object edtQualite: TDBEdit
      Left = 96
      Top = 52
      Width = 137
      Height = 19
      Color = 15987699
      DataField = 'LIBELLE_QUALITE'
      DataSource = dsResultat
      TabOrder = 2
    end
    object edtNomJeuneFille: TDBEdit
      Left = 336
      Top = 3
      Width = 130
      Height = 19
      Color = 15987699
      DataField = 'NOM_JEUNE_FILLE'
      DataSource = dsResultat
      TabOrder = 3
    end
    object edtRangGemellaire: TDBEdit
      Left = 336
      Top = 76
      Width = 33
      Height = 19
      Color = 15987699
      DataField = 'RANG_GEMELLAIRE'
      DataSource = dsResultat
      TabOrder = 6
    end
    object edtNumeroInsee: TDBEdit
      Left = 336
      Top = 52
      Width = 121
      Height = 19
      Color = 15987699
      DataField = 'NUMERO_INSEE'
      DataSource = dsResultat
      MaxLength = 23
      TabOrder = 5
    end
    object edtDateNaissance: TDBEdit
      Left = 336
      Top = 28
      Width = 71
      Height = 19
      Color = 15987699
      DataField = 'DATE_NAISSANCE'
      DataSource = dsResultat
      MaxLength = 10
      TabOrder = 4
    end
    object gBxAssure: TGroupBox
      Left = 494
      Top = 6
      Width = 217
      Height = 71
      Caption = 'Assur'#233
      TabOrder = 7
      Visible = False
      object lblNomAssure: TLabel
        Left = 16
        Top = 24
        Width = 21
        Height = 13
        Caption = 'Nom'
      end
      object lblPrenomAssure: TLabel
        Left = 16
        Top = 48
        Width = 36
        Height = 13
        Caption = 'Pr'#233'nom'
      end
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 225
        Height = 14
        AutoSize = False
        Caption = '   Assur'#233
        Color = clGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object edtNomAssure: TDBEdit
        Left = 64
        Top = 20
        Width = 137
        Height = 19
        Color = 14737632
        DataField = 'NOM_ASSURE'
        DataSource = dsResultat
        TabOrder = 0
      end
      object edtPrenomAssure: TDBEdit
        Left = 64
        Top = 44
        Width = 137
        Height = 19
        Color = 14737632
        DataField = 'PRENOM_ASSURE'
        DataSource = dsResultat
        TabOrder = 1
      end
    end
    object pCtrlDetailClients: TPageControl
      Tag = 1
      Left = 0
      Top = 112
      Width = 466
      Height = 308
      ActivePage = tShRemboursements
      Align = alBottom
      OwnerDraw = True
      TabOrder = 8
      OnChange = pCtrlDetailClientsChange
      OnDrawTab = pCtrlDetailClientsDrawTab
      object tShAdresse: TTabSheet
        Tag = 1
        Caption = 'Adresse'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        inline frAdresseClient: TfrAdresse
          Left = 8
          Top = 4
          Width = 385
          Height = 142
          AutoSize = True
          ParentBackground = False
          TabOrder = 0
          ExplicitLeft = 8
          ExplicitTop = 4
          ExplicitHeight = 142
          inherited edtRue1: TDBEdit
            Height = 19
            DataField = 'RUE_1'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtRue2: TDBEdit
            Height = 19
            DataField = 'RUE_2'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtCP: TDBEdit
            Height = 19
            DataField = 'CODE_POSTAL'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtVille: TDBEdit
            Height = 19
            DataField = 'NOM_VILLE'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtTelephone1: TDBEdit
            Height = 19
            DataField = 'TEL_PERSONNEL'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtMobile: TDBEdit
            Height = 19
            DataField = 'TEL_MOBILE'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtTelephone2: TDBEdit
            Height = 19
            DataField = 'TEL_STANDARD'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtFax: TDBEdit
            Height = 19
            DataField = 'FAX'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
          inherited edtEmail: TDBEdit
            Height = 19
            DataField = 'EMAIL'
            DataSource = dsResultat
            ExplicitHeight = 19
          end
        end
      end
      object tShRemboursements: TTabSheet
        Tag = 2
        Caption = 'Remboursements'
        ImageIndex = 1
        object lblNomIdNatAMO: TLabel
          Left = 8
          Top = 8
          Width = 107
          Height = 13
          Caption = 'AMO Nom / Identifiant'
        end
        object lblNomIdNatAMC: TLabel
          Left = 8
          Top = 132
          Width = 106
          Height = 13
          Caption = 'AMC Nom / Identifiant'
        end
        object lblPieceJustifDroit: TLabel
          Left = 128
          Top = 101
          Width = 83
          Height = 13
          Caption = 'Pi'#232'ce justificative'
        end
        object lbDateValiditePieceJ: TLabel
          Left = 496
          Top = 101
          Width = 88
          Height = 13
          Caption = 'Date validit'#233' pi'#232'ce'
        end
        object lblNAdhAMC: TLabel
          Left = 128
          Top = 204
          Width = 92
          Height = 13
          Caption = 'Num'#233'ro d'#39'adh'#233'rent'
        end
        object lblCtrSPHAMC: TLabel
          Left = 424
          Top = 204
          Width = 107
          Height = 13
          Caption = 'Contrat Sant'#233' Pharma'
        end
        object edtNomAMO: TDBEdit
          Left = 128
          Top = 4
          Width = 289
          Height = 19
          Color = 15987699
          DataField = 'NOM_ORGANISME_AMO'
          DataSource = dsResultat
          TabOrder = 0
        end
        object edtNomReduitAMO: TDBEdit
          Left = 424
          Top = 4
          Width = 169
          Height = 19
          Color = 14737632
          DataField = 'NOM_REDUIT_ORGANISME_AMO'
          DataSource = dsResultat
          TabOrder = 1
        end
        object edtIdNatAMO: TDBEdit
          Left = 600
          Top = 4
          Width = 41
          Height = 19
          Color = 15987699
          DataField = 'IDENTIFIANT_NATIONAL_ORG_AMO'
          DataSource = dsResultat
          TabOrder = 2
        end
        object edtCtrGestAMO: TDBEdit
          Left = 640
          Top = 4
          Width = 33
          Height = 19
          DataField = 'CENTRE_GESTIONNAIRE'
          DataSource = dsResultat
          TabOrder = 3
        end
        object grdCouverturesAMOClient: TPIDBGrid
          Left = 121
          Top = 27
          Width = 545
          Height = 71
          BorderStyle = bsNone
          DataSource = dsCouverturesAMOClient
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14790035
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
              FieldName = 'Libell'#195#169
              Title.Alignment = taCenter
              Width = 179
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
              FieldName = 'Code SV'
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
              FieldName = 'PH2'
              Title.Alignment = taCenter
              Width = 33
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
              FieldName = 'PH4'
              Title.Alignment = taCenter
              Width = 34
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
              FieldName = 'PH7'
              Title.Alignment = taCenter
              Width = 32
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
              FieldName = 'PH1'
              Title.Alignment = taCenter
              Width = 32
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
              FieldName = 'D'#195#169'but droit'
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
              FieldName = 'Fin droit'
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
        object edtNomAMC: TDBEdit
          Left = 128
          Top = 128
          Width = 259
          Height = 19
          Color = 15987699
          DataField = 'NOM_ORGANISME_AMC'
          DataSource = dsResultat
          TabOrder = 7
        end
        object edtNomReduitAMC: TDBEdit
          Left = 424
          Top = 128
          Width = 169
          Height = 19
          Color = 14737632
          DataField = 'NOM_REDUIT_ORGANISME_AMC'
          DataSource = dsResultat
          TabOrder = 8
        end
        object edtIdNatAMC: TDBEdit
          Left = 600
          Top = 128
          Width = 73
          Height = 19
          Color = 15987699
          DataField = 'IDENTIFIANT_NATIONAL_ORG_AMC'
          DataSource = dsResultat
          TabOrder = 9
        end
        object edtPieceJustifDroit: TDBEdit
          Left = 233
          Top = 97
          Width = 257
          Height = 19
          Color = 15987699
          DataField = 'NAT_PIECE_JUSTIF_DROIT'
          DataSource = dsResultat
          TabOrder = 5
        end
        object edtDateValiditePieceJ: TDBEdit
          Left = 600
          Top = 97
          Width = 73
          Height = 19
          DataField = 'DATE_VALIDITE_PIECE_JUSTIF'
          DataSource = dsResultat
          TabOrder = 6
        end
        object grdCouvertureAMCClient: TPIDBGrid
          Left = 128
          Top = 158
          Width = 545
          Height = 36
          Hint = 'AAD AAR ARO B COR DVO ...'
          BorderStyle = bsNone
          DataSource = dsCouverturesAMCClient
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14922394
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentColor = True
          TabOrder = 10
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grdCouvertureAMCClientDrawColumnCell
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
              FieldName = 'Libell'#195#169
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
              FieldName = 'PH2'
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
              FieldName = 'PH4'
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
              FieldName = 'PH7'
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
              FieldName = 'PH1'
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
              FieldName = 'AAD'
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
              FieldName = 'PMR'
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
              FieldName = 'D'#195#169'but droit'
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
              FieldName = 'Fin droit'
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
        object edtNAdhAMC: TDBEdit
          Left = 232
          Top = 200
          Width = 105
          Height = 19
          Color = 14737632
          DataField = 'NUMERO_ADHERENT_MUTUELLE'
          DataSource = dsResultat
          TabOrder = 11
        end
        object edtCtrSMHAMC: TDBEdit
          Left = 544
          Top = 200
          Width = 129
          Height = 19
          Color = 14737632
          DataField = 'CONTRAT_SANTE_PHARMA'
          DataSource = dsResultat
          TabOrder = 12
        end
      end
      object tShCommentaires: TTabSheet
        Tag = 3
        Caption = 'Commentaires'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        object lblCommPerso: TLabel
          Left = 8
          Top = 8
          Width = 113
          Height = 13
          Caption = 'Commentaire personnel'
        end
        object lblCommGlobal: TLabel
          Left = 352
          Top = 8
          Width = 94
          Height = 13
          Caption = 'Commentaire global'
        end
        object mmCommPerso: TDBMemo
          Left = 8
          Top = 24
          Width = 321
          Height = 120
          Color = 15987699
          DataField = 'COMMENTAIRE_INDIVIDUEL'
          DataSource = dsResultat
          TabOrder = 0
        end
        object mmCommGlobal: TDBMemo
          Left = 352
          Top = 24
          Width = 321
          Height = 120
          Color = 15987699
          DataField = 'COMMENTAIRE_GLOBAL'
          DataSource = dsResultat
          TabOrder = 2
        end
        object chkCommPersoBlq: TDBCheckBox
          Left = 8
          Top = 152
          Width = 177
          Height = 17
          Caption = 'Commentaire personnel bloquant'
          DataField = 'COMMENTAIRE_INDIVIDUEL_BLOQUANT'
          DataSource = dsResultat
          TabOrder = 1
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object chkCommGlobBlq: TDBCheckBox
          Left = 352
          Top = 152
          Width = 161
          Height = 17
          Caption = 'Commentaire global bloquant'
          DataField = 'COMMENTAIRE_GLOBAL_BLOQUANT'
          DataSource = dsResultat
          TabOrder = 3
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
      end
      object tShFamilles: TTabSheet
        Tag = 4
        Caption = 'Liste famille'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        object lblAutresBenef: TLabel
          Left = 8
          Top = 8
          Width = 95
          Height = 13
          Caption = 'Autres b'#233'n'#233'ficiaires'
        end
        object lblRattacheA: TLabel
          Left = 8
          Top = 152
          Width = 53
          Height = 13
          Caption = 'Rattach'#233' '#224
        end
        object dbGrdFamilles: TPIDBGrid
          Left = 8
          Top = 24
          Width = 665
          Height = 120
          BorderStyle = bsNone
          DataSource = dsFamilles
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14922394
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentColor = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = dbGrdFamillesDrawColumnCell
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
              FieldName = 'NOM'
              Title.Alignment = taCenter
              Width = 100
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
              Width = 100
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
              FieldName = 'LIBELLE_QUALITE'
              Title.Alignment = taCenter
              Width = 100
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
              FieldName = 'DATE_NAISSANCE'
              Title.Alignment = taCenter
              Width = 100
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
              FieldName = 'RANG_GEMELLAIRE'
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
              FieldName = 'NOM_ORGANISME_AMC'
              Title.Alignment = taCenter
              Width = 190
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
        object edtRattacheA: TDBEdit
          Left = 80
          Top = 148
          Width = 593
          Height = 19
          DataField = 'ASSURE_RATTACHE'
          DataSource = dsResultat
          TabOrder = 1
        end
      end
      object tShProfilcommercial: TTabSheet
        Tag = 5
        Caption = 'Profil commercial'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        object Label1: TLabel
          Left = 468
          Top = 40
          Width = 80
          Height = 13
          Caption = 'Derni'#232're visite le'
        end
        object lblActivite: TLabel
          Left = 504
          Top = 100
          Width = 36
          Height = 13
          Caption = 'Activit'#233
        end
        object lblPayeur: TLabel
          Left = 13
          Top = 36
          Width = 34
          Height = 13
          Caption = 'Payeur'
        end
        object lblProfilRemise: TLabel
          Left = 13
          Top = 64
          Width = 73
          Height = 13
          Caption = 'Profil de remise'
        end
        object Label3: TLabel
          Left = 13
          Top = 90
          Width = 67
          Height = 13
          Caption = 'Profil d'#39#233'dition'
        end
        object lbldelaipaiement: TLabel
          Left = 13
          Top = 117
          Width = 85
          Height = 13
          Caption = 'D'#233'lai de paiement'
        end
        object delai: TLabel
          Left = 151
          Top = 117
          Width = 24
          Height = 13
          Caption = 'jours'
        end
        object edtPayeur: TDBEdit
          Left = 104
          Top = 36
          Width = 69
          Height = 19
          Color = 14737632
          DataField = 'PAYEUR'
          DataSource = dsResultat
          TabOrder = 0
        end
        object edtProfilRemise: TDBEdit
          Left = 104
          Top = 63
          Width = 228
          Height = 19
          Color = 15987699
          DataField = 'PROFIL_REMISE'
          DataSource = dsResultat
          TabOrder = 1
        end
        object edtProfilEdition: TDBEdit
          Left = 104
          Top = 90
          Width = 228
          Height = 19
          Color = 14737632
          DataField = 'PROFIL_EDITION'
          DataSource = dsResultat
          TabOrder = 2
        end
        object edtDateDerniereVisite: TDBEdit
          Left = 554
          Top = 36
          Width = 121
          Height = 19
          Color = 14737632
          DataField = 'DATE_DERNIERE_VISITE'
          DataSource = dsResultat
          TabOrder = 3
        end
        object edtActivite: TDBEdit
          Left = 554
          Top = 96
          Width = 133
          Height = 19
          Color = 15987699
          DataField = 'ACTIVITE'
          DataSource = dsResultat
          TabOrder = 4
        end
        object edtDelaiPaiement: TDBEdit
          Left = 104
          Top = 117
          Width = 41
          Height = 19
          Color = 14737632
          DataField = 'DELAI_PAIEMENT'
          DataSource = dsResultat
          TabOrder = 5
        end
        object cbxRelevedefacture: TDBCheckBox
          Left = 13
          Top = 3
          Width = 120
          Height = 17
          Caption = 'relev'#233' de factures'
          DataField = 'RELEVE_DE_FACTURE'
          DataSource = dsResultat
          ReadOnly = True
          TabOrder = 6
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object cbxFinDeMois: TDBCheckBox
          Left = 258
          Top = 117
          Width = 97
          Height = 17
          Caption = 'fin de mois'
          DataField = 'FIN_DE_MOIS'
          DataSource = dsResultat
          ReadOnly = True
          TabOrder = 7
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object grdCollectivite: TPIDBGrid
          Left = 13
          Top = 212
          Width = 320
          Height = 65
          DataSource = dsCollectivite
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14922394
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 8
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grdCollectiviteDrawColumnCell
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
              FieldName = 'NOM'
              Title.Alignment = taCenter
              Title.Caption = 'Collectivit'#233's'
              Width = 313
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
        object grdAvantage: TPIDBGrid
          Left = 13
          Top = 142
          Width = 320
          Height = 65
          DataSource = dsCarteFiClient
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14922394
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 9
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grdAvantageDrawColumnCell
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
              FieldName = 'LIBELLE'
              Title.Alignment = taCenter
              Title.Caption = 'Programme Avantage'
              Width = 129
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
              FieldName = 'ENCOURS_INITIAL'
              Title.Alignment = taCenter
              Title.Caption = 'Encours 1'
              Width = 59
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
              FieldName = 'ENCOURS_CA'
              Title.Alignment = taCenter
              Title.Caption = 'Encours2'
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
              FieldName = 'DATE_FIN_VALIDITE'
              Title.Caption = 'Fin validit'#233
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
      object tshAdherent: TTabSheet
        Tag = 6
        Caption = 'Adh'#233'rents'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        object lblAdherent: TLabel
          Left = 12
          Top = 5
          Width = 50
          Height = 13
          Caption = 'Adh'#233'rents'
        end
        object grdAdherent: TPIDBGrid
          Left = 0
          Top = 24
          Width = 377
          Height = 185
          Ctl3D = False
          DataSource = dsAdherent
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14922394
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentColor = True
          ParentCtl3D = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDrawColumnCell = grdAdherentDrawColumnCell
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
              FieldName = 'NOM'
              Title.Alignment = taCenter
              Title.Caption = 'Nom'
              Width = 127
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
              Title.Caption = 'Pr'#233'nom'
              Width = 91
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
              FieldName = 'DATE_NAISSANCE'
              Title.Alignment = taCenter
              Title.Caption = 'D.naissance'
              Width = 66
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
              FieldName = 'QUALITE'
              Title.Alignment = taCenter
              Title.Caption = 'Qualit'#233
              Width = 71
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
      object tshDocument: TTabSheet
        Caption = 'Documents'
        ImageIndex = 6
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        object lstDocumentClient: TDBLookupListBox
          Left = 0
          Top = 213
          Width = 458
          Height = 67
          Align = alBottom
          KeyField = 'T_DOCUMENT_ID'
          ListField = 'DOCUMENT'
          ListSource = dsDocumentClient
          TabOrder = 0
          OnDblClick = lstDocumentClientDblClick
        end
        object Panel: TPanel
          Left = 0
          Top = 0
          Width = 458
          Height = 213
          Align = alClient
          TabOrder = 1
          OnResize = PanelResize
          object PaintBox: TPaintBox
            Left = 1
            Top = 1
            Width = 933
            Height = 211
            Align = alClient
            OnPaint = PaintBoxPaint
            ExplicitLeft = 104
            ExplicitTop = 16
            ExplicitWidth = 105
            ExplicitHeight = 105
          end
        end
      end
    end
    object pnlSeparator: TPanel
      Left = 0
      Top = 96
      Width = 466
      Height = 16
      Align = alBottom
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 9
    end
    object cbxCollectivite: TDBCheckBox
      Left = 16
      Top = 79
      Width = 120
      Height = 17
      Caption = 'Collectivit'#233
      DataField = 'COLLECTIF'
      DataSource = dsResultat
      ReadOnly = True
      TabOrder = 10
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetClients
    OnDataChange = dsResultDataChange
    Left = 464
  end
  inherited pmnMenuFrame: TJvPopupMenu
    Style = msXP
    object mnuVignettesAvancees: TMenuItem
      Caption = '&Vignettes avanc'#233'es'
      ShortCut = 112
      OnClick = mnuVignettesAvanceesClick
    end
    object mnuCredits: TMenuItem
      Caption = '&Cr'#233'dits'
      ShortCut = 113
      OnClick = mnuCreditsClick
    end
    object mnuProduitsDus: TMenuItem
      Caption = '&Produits dus'
      ShortCut = 114
      OnClick = mnuProduitsDusClick
    end
    object mnuHistoriquesDelivrances: TMenuItem
      Caption = '&Historique d'#233'livrances'
      ShortCut = 115
      OnClick = mnuHistoriquesDelivrancesClick
    end
  end
  object dsCouverturesAMOClient: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetCouverturesAMOClient
    OnStateChange = dsCouverturesAMOClientStateChange
    Left = 712
    Top = 312
  end
  object dsFamilles: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetFamilleClient
    Left = 712
    Top = 232
  end
  object dsCouverturesAMCClient: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetCouverturesAMCClient
    OnStateChange = dsCouverturesAMCClientStateChange
    Left = 712
    Top = 440
  end
  object dsCollectivite: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dsetCollectivites
    Left = 568
    Top = 72
  end
  object dsAdherent: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dsetAdherent
    Left = 632
    Top = 72
  end
  object dsCarteFiClient: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetCarteFiClient
    Left = 712
    Top = 72
  end
  object ImageList1: TImageList
    Left = 224
    Top = 88
  end
  object dsDocumentClient: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetDocumentClient
    Left = 496
    Top = 392
  end
end
