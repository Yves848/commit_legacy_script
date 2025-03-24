inherited frFournisseurs: TfrFournisseurs
  ExplicitWidth = 790
  ExplicitHeight = 483
  inherited Splitter: TSplitter
    Top = 129
    ExplicitTop = 129
    ExplicitWidth = 821
  end
  inherited pnlCritere: TPanel
    ExplicitWidth = 790
    inherited btnChercher: TPISpeedButton
      OnClick = sBtnSearchClick
    end
  end
  inherited grdResultat: TPIDBGrid
    Height = 96
    ParentColor = True
    Columns = <
      item
        Expanded = False
        FieldName = 'RAISON_SOCIALE'
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
        FieldName = 'REPRESENTE_PAR'
        Title.Alignment = taCenter
        Width = 114
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
        FieldName = 'TYPE_FOURNISSEUR_LIBELLE'
        Title.Alignment = taCenter
        Width = 151
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
        FieldName = 'MODE_TRANSMISSION'
        Title.Alignment = taCenter
        Width = 139
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
      end>
  end
  inherited ScrollBox: TScrollBox
    Top = 132
    Height = 172
    BevelInner = bvNone
    BevelOuter = bvNone
    ExplicitTop = 132
    ExplicitWidth = 790
    ExplicitHeight = 172
    object lblModeTransmission: TLabel
      Left = 387
      Top = 6
      Width = 38
      Height = 13
      Caption = 'Norme :'
    end
    object lblLibelle: TDBText
      Left = 3
      Top = 6
      Width = 114
      Height = 17
      DataField = 'TYPE_FOURNISSEUR_LIBELLE'
      DataSource = dsResultat
    end
    object lblNorme: TDBText
      Left = 431
      Top = 6
      Width = 95
      Height = 17
      DataField = 'MODE_TRANSMISSION'
      DataSource = dsResultat
    end
    object edtTelephone: TDBText
      Left = 51
      Top = 29
      Width = 95
      Height = 17
      DataField = 'TELEPHONE'
      DataSource = dsResultat
    end
    object lblTel: TLabel
      Left = 20
      Top = 29
      Width = 25
      Height = 13
      Caption = 'T'#233'l. :'
    end
    object Label5: TLabel
      Left = 198
      Top = 29
      Width = 25
      Height = 13
      Caption = 'Fax :'
    end
    object edtfax2: TDBText
      Left = 229
      Top = 29
      Width = 95
      Height = 17
      DataField = 'FAX'
      DataSource = dsResultat
    end
    object pCtrlDetailFour: TPageControl
      Left = 0
      Top = 129
      Width = 753
      Height = 249
      ActivePage = tSHCatalogues
      Align = alBottom
      OwnerDraw = True
      TabOrder = 0
      OnDrawTab = pCtrlDetailFourDrawTab
      object tSHCatalogues: TTabSheet
        Caption = 'Catalogues'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitHeight = 0
        DesignSize = (
          745
          221)
        object grdCatalogues: TPIDBGrid
          Left = 3
          Top = 3
          Width = 561
          Height = 196
          Anchors = [akLeft, akTop, akBottom]
          DataSource = dsCatalogues
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
              FieldName = 'DESIGNATION'
              Title.Alignment = taCenter
              Width = 231
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
              Width = 83
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
              FieldName = 'PRIX_ACHAT_REMISE'
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
        object dbGrdProduits: TPIDBGrid
          Left = 3
          Top = 3
          Width = 561
          Height = 196
          Anchors = [akLeft, akTop, akBottom]
          DataSource = dsProduits
          DefaultDrawing = False
          DrawingStyle = gdsGradient
          FixedColor = 14922394
          GradientEndColor = 14790035
          GradientStartColor = 15584957
          Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentColor = True
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
              FieldName = 'CODE_CIP'
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
              FieldName = 'DESIGNATION'
              Title.Alignment = taCenter
              Width = 465
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
      object tShTransmission: TTabSheet
        Caption = 'Transmission'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblFax: TLabel
          Left = 225
          Top = 3
          Width = 18
          Height = 13
          Caption = 'Fax'
        end
        object lbltypetrans: TLabel
          Left = 3
          Top = 3
          Width = 103
          Height = 13
          Caption = 'Mode de transmission'
        end
        object gBoxProtocole171: TGroupBox
          Left = 367
          Top = 27
          Width = 266
          Height = 126
          Caption = 'Protocole 171'
          TabOrder = 0
          object lblNoAppel: TLabel
            Left = 16
            Top = 24
            Width = 74
            Height = 13
            Caption = 'Num'#233'ro d'#39'appel'
          end
          object lblIdentifiant171: TLabel
            Left = 16
            Top = 51
            Width = 50
            Height = 13
            Caption = 'Identifiant'
          end
          object lblVitesse: TLabel
            Left = 16
            Top = 80
            Width = 34
            Height = 13
            Caption = 'Vitesse'
          end
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 342
            Height = 17
            AutoSize = False
            Caption = '   Protocole 171'
            Color = 1476096
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlightText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object edtNoAppel: TDBEdit
            Left = 104
            Top = 20
            Width = 121
            Height = 21
            DataField = 'NUMERO_APPEL'
            DataSource = dsResultat
            TabOrder = 0
          end
          object edtIdentifiant171: TDBEdit
            Left = 104
            Top = 48
            Width = 121
            Height = 21
            DataField = 'IDENTIFIANT_171'
            DataSource = dsResultat
            TabOrder = 1
          end
          object edtVitesse: TDBEdit
            Left = 104
            Top = 76
            Width = 121
            Height = 21
            DataField = 'VITESSE_171'
            DataSource = dsResultat
            TabOrder = 2
          end
        end
        object GroupBox1: TGroupBox
          Left = 3
          Top = 27
          Width = 335
          Height = 174
          Caption = 'Protocole PharmaML'
          TabOrder = 1
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 342
            Height = 17
            AutoSize = False
            Caption = '   Protocole PharmaML'
            Color = 1476096
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlightText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label4: TLabel
            Left = 3
            Top = 23
            Width = 102
            Height = 13
            Caption = 'R'#233'f'#233'rence PharmaML'
          end
          object lblURL1: TLabel
            Left = 3
            Top = 47
            Width = 67
            Height = 13
            Caption = 'URL principale'
          end
          object lblURL2: TLabel
            Left = 3
            Top = 72
            Width = 74
            Height = 13
            Caption = 'URL de secours'
          end
          object lblnumclient: TLabel
            Left = 3
            Top = 98
            Width = 80
            Height = 13
            Caption = 'Num'#233'ro de client'
          end
          object lblidmag: TLabel
            Left = 3
            Top = 125
            Width = 92
            Height = 13
            Caption = 'Identifiant magasin'
          end
          object lblcle: TLabel
            Left = 142
            Top = 153
            Width = 54
            Height = 13
            Caption = 'Cl'#233' secr'#232'te'
          end
          object edtRefpharmaml: TDBEdit
            Left = 111
            Top = 20
            Width = 190
            Height = 21
            DataField = 'PHARMAML_REF_ID'
            DataSource = dsResultat
            TabOrder = 0
          end
          object edtPharmamlurl1: TDBEdit
            Left = 111
            Top = 42
            Width = 190
            Height = 21
            DataField = 'PHARMAML_URL_1'
            DataSource = dsResultat
            TabOrder = 1
          end
          object edtPharmamlurl2: TDBEdit
            Left = 111
            Top = 69
            Width = 190
            Height = 21
            DataField = 'PHARMAML_URL_2'
            DataSource = dsResultat
            TabOrder = 2
          end
          object dtpharmamlIdofficine: TDBEdit
            Left = 111
            Top = 96
            Width = 190
            Height = 21
            DataField = 'PHARMAML_ID_OFFICINE'
            DataSource = dsResultat
            TabOrder = 3
          end
          object edtPharmamlIdmagasin: TDBEdit
            Left = 111
            Top = 123
            Width = 190
            Height = 21
            DataField = 'PHARMAML_ID_MAGASIN'
            DataSource = dsResultat
            TabOrder = 4
          end
          object edtPharmamlcle: TDBEdit
            Left = 216
            Top = 150
            Width = 61
            Height = 21
            DataField = 'PHARMAML_CLE'
            DataSource = dsResultat
            TabOrder = 5
          end
        end
        object edtFax: TDBEdit
          Left = 249
          Top = 0
          Width = 121
          Height = 21
          DataField = 'NUMERO_FAX'
          DataSource = dsResultat
          TabOrder = 2
        end
        object edtModeTrans: TDBEdit
          Left = 112
          Top = 0
          Width = 107
          Height = 21
          DataField = 'MODE_TRANSMISSION'
          DataSource = dsResultat
          TabOrder = 3
        end
      end
      object tShParticularites: TTabSheet
        Caption = 'Particularit'#233's'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblCAMensuel: TLabel
          Left = 8
          Top = 42
          Width = 103
          Height = 13
          Caption = 'CA mensuel '#224' r'#233'aliser'
        end
        object chkRepDefaut: TDBCheckBox
          Left = 8
          Top = 6
          Width = 137
          Height = 17
          Caption = 'R'#233'partiteur par d'#233'faut'
          DataField = 'DEFAUT'
          DataSource = dsResultat
          TabOrder = 0
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object edtCAMensuel: TDBEdit
          Left = 120
          Top = 38
          Width = 89
          Height = 21
          DataField = 'OBJECTIF_CA_MENSUEL'
          DataSource = dsResultat
          TabOrder = 1
        end
      end
      object tShGeneral: TTabSheet
        Caption = 'G'#233'n'#233'ralit'#233's'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        inline frAdresse: TfrAdresse
          Left = 3
          Top = 3
          Width = 385
          Height = 144
          AutoSize = True
          ParentBackground = False
          TabOrder = 0
          ExplicitLeft = 3
          ExplicitTop = 3
          inherited edtRue1: TDBEdit
            DataField = 'RUE_1'
            DataSource = dsResultat
          end
          inherited edtRue2: TDBEdit
            DataField = 'RUE_2'
            DataSource = dsResultat
          end
          inherited edtCP: TDBEdit
            DataField = 'CODE_POSTAL'
            DataSource = dsResultat
          end
          inherited edtVille: TDBEdit
            DataField = 'NOM_VILLE'
            DataSource = dsResultat
          end
          inherited edtTelephone1: TDBEdit
            DataField = 'TEL_STANDARD'
            DataSource = dsResultat
          end
          inherited edtMobile: TDBEdit
            DataField = 'TEL_MOBILE'
            DataSource = dsResultat
          end
          inherited edtTelephone2: TDBEdit
            DataField = 'TEL_PERSONNEL'
            DataSource = dsResultat
          end
          inherited edtFax: TDBEdit
            DataField = 'FAX'
            DataSource = dsResultat
          end
        end
      end
    end
    object edtRaisonSociale: TDBEdit
      Left = 123
      Top = 4
      Width = 185
      Height = 21
      DataField = 'RAISON_SOCIALE'
      DataSource = dsResultat
      TabOrder = 1
    end
    object chkFouPartenaire: TDBCheckBox
      Left = 3
      Top = 54
      Width = 93
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Partenaire'
      DataField = 'DEFAUT'
      DataSource = dsResultat
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object mmCommentaire: TDBMemo
      Left = 505
      Top = 6
      Width = 248
      Height = 43
      Color = 15987699
      DataField = 'COMMENTAIRE'
      DataSource = dsResultat
      TabOrder = 3
    end
    object pnlContact: TPanel
      Left = 505
      Top = 55
      Width = 248
      Height = 74
      BevelOuter = bvNone
      BorderStyle = bsSingle
      ParentColor = True
      TabOrder = 4
      object lblcontact: TLabel
        Left = 0
        Top = 0
        Width = 257
        Height = 17
        AutoSize = False
        Caption = '   Contact'
        Color = 1476096
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object Label3: TLabel
        Left = 6
        Top = 23
        Width = 73
        Height = 13
        Caption = 'Nom et pr'#233'nom'
      end
      object edtRepresente: TDBEdit
        Left = 112
        Top = 23
        Width = 121
        Height = 21
        DataField = 'REPRESENTE_PAR'
        DataSource = dsResultat
        TabOrder = 0
      end
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetFournisseurs
    OnDataChange = dsResultDataChange
    Left = 520
    Top = 88
  end
  object dsProduits: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetProduitsExclusifs
    Left = 600
    Top = 384
  end
  object dsCatalogues: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetCatalogues
    Left = 600
    Top = 344
  end
end
