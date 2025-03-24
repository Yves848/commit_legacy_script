inherited frOrganismes: TfrOrganismes
  Width = 996
  Height = 612
  Color = clWhite
  Ctl3D = False
  ParentColor = False
  ParentCtl3D = False
  inherited Splitter: TSplitter
    Width = 996
    ExplicitWidth = 671
  end
  inherited pnlCritere: TPanel
    Width = 996
    inherited lblCritere: TLabel
      Width = 75
      Caption = 'Nom/Identifiant'
      ExplicitWidth = 75
    end
    inherited btnChercher: TPISpeedButton
      Left = 571
      OnClick = sBtnSearchClick
      ExplicitLeft = 571
    end
    inherited edtCritere: TEdit
      Left = 96
      Width = 369
      Height = 19
      ExplicitLeft = 96
      ExplicitWidth = 369
      ExplicitHeight = 19
    end
    object edtIdentifiant: TEdit
      Left = 472
      Top = 6
      Width = 97
      Height = 19
      Color = 14737632
      TabOrder = 1
      OnKeyDown = edtCritereKeyDown
    end
  end
  inherited grdResultat: TPIDBGrid
    Width = 996
    ParentColor = True
    Columns = <
      item
        Expanded = False
        FieldName = 'T_ORGANISME_ID'
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
        FieldName = 'NOM_REDUIT'
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
        FieldName = 'LIBELLE_TYPE_ORGANISME'
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
      end
      item
        Expanded = False
        FieldName = 'NOM_DESTINATAIRE'
        Title.Alignment = taCenter
        Width = 120
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
    Width = 996
    Height = 456
    Color = clWhite
    object lblTypeOrganisme: TLabel
      Left = 8
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object lblNom: TLabel
      Left = 160
      Top = 8
      Width = 21
      Height = 13
      Caption = 'Nom'
    end
    object lblNomReduit: TLabel
      Left = 160
      Top = 32
      Width = 52
      Height = 13
      Caption = 'Nom r'#233'duit'
    end
    object lblIdNatAMC: TLabel
      Left = 160
      Top = 56
      Width = 63
      Height = 13
      Caption = 'N'#176' identifiant'
    end
    object lblDestinataire: TLabel
      Left = 160
      Top = 80
      Width = 108
      Height = 13
      Caption = 'Destinataire t'#233'l'#233'trans.'
    end
    object chkOrgReference: TDBCheckBox
      Left = 8
      Top = 78
      Width = 137
      Height = 17
      Caption = 'R'#233'f'#233'renc'#233' Sesam-Vitale'
      DataField = 'ORG_REFERENCE'
      DataSource = dsResultat
      TabOrder = 8
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object pCtrlDetailOrganisme: TPageControl
      Left = 0
      Top = 226
      Width = 996
      Height = 230
      ActivePage = tShGeneralites
      Align = alBottom
      HotTrack = True
      OwnerDraw = True
      TabHeight = 20
      TabOrder = 9
      TabStop = False
      OnChange = pCtrlDetailOrganismeChange
      OnDrawTab = pCtrlDetailOrganismeDrawTab
      ExplicitTop = 111
      ExplicitWidth = 629
      object tShGeneralites: TTabSheet
        Caption = 'G'#233'n'#233'ralit'#233's'
        ExplicitWidth = 621
        inline frAdresseOrganisme: TfrAdresse
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
            Top = 47
            Height = 19
            DataField = 'CODE_POSTAL'
            DataSource = dsResultat
            ExplicitTop = 47
            ExplicitHeight = 19
          end
          inherited edtVille: TDBEdit
            Top = 47
            Height = 19
            DataField = 'NOM_VILLE'
            DataSource = dsResultat
            ExplicitTop = 47
            ExplicitHeight = 19
          end
          inherited edtTelephone1: TDBEdit
            Height = 19
            DataField = 'TEL_STANDARD'
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
            Top = 71
            Height = 19
            DataField = 'TEL_PERSONNEL'
            DataSource = dsResultat
            ExplicitTop = 71
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
            ExplicitHeight = 19
          end
        end
      end
      object tShRemboursements: TTabSheet
        Caption = 'Remboursements'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 609
        ExplicitHeight = 0
        object lblRemboursements: TLabel
          Left = 8
          Top = 8
          Width = 126
          Height = 13
          Caption = 'Remboursements associ'#233's'
        end
        object grdCouvertures: TPIDBGrid
          Left = 8
          Top = 24
          Width = 617
          Height = 169
          BorderStyle = bsNone
          DataSource = dsCouvertures
          DefaultDrawing = False
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
          Options2.CoinsRonds = False
          Details = False
          HauteurEntetes = 17
          Entetes = <>
          MultiSelection.Active = False
          MultiSelection.Mode = mmsSelection
        end
      end
      object tShGestion: TTabSheet
        Caption = 'R'#232'gles de gestion'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblDocFacturation: TLabel
          Left = 344
          Top = 10
          Width = 93
          Height = 13
          Caption = 'Doc. de facturation'
        end
        object lblSeuilEdReleve: TLabel
          Left = 344
          Top = 34
          Width = 99
          Height = 13
          Caption = 'Seuil d'#39'appel de fond'
        end
        object lblTypeReleve: TLabel
          Left = 344
          Top = 96
          Width = 136
          Height = 13
          Caption = 'Bordereau hors transmission'
        end
        object lblFrequenceEdition: TLabel
          Left = 344
          Top = 120
          Width = 94
          Height = 13
          Caption = 'Fr'#233'quence d'#39#233'dition'
        end
        object pnlGestionAMO: TPanel
          Left = 8
          Top = 8
          Width = 273
          Height = 193
          AutoSize = True
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          Visible = False
          object chkOrgConventionne: TDBCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 17
            Caption = 'Conventionn'#233
            DataField = 'ORGCONVENTIONNE'
            TabOrder = 0
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object chkOrgCirconscription: TDBCheckBox
            Left = 0
            Top = 24
            Width = 177
            Height = 17
            Caption = 'Organisme de la circonscription'
            DataField = 'ORGCIRCONSCRIPTION'
            TabOrder = 1
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object chkGestionTOPR: TDBCheckBox
            Left = 0
            Top = 48
            Width = 97
            Height = 17
            Caption = 'Gestion TOP R'
            DataField = 'TOPR'
            TabOrder = 2
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object gBxAccords: TGroupBox
            Left = 0
            Top = 72
            Width = 273
            Height = 97
            Caption = 'Accords'
            TabOrder = 3
            object lblMtMiniPriseEnChargeAMO: TLabel
              Left = 16
              Top = 48
              Width = 104
              Height = 13
              Caption = 'Mt mini pris en charge'
            end
            object lblApplicationMiniPCAMO: TLabel
              Left = 16
              Top = 72
              Width = 66
              Height = 13
              Caption = 'S'#39'applique sur'
            end
            object chkAccordsTierPayantAMO: TDBCheckBox
              Left = 16
              Top = 24
              Width = 113
              Height = 17
              Caption = 'Accord Tier Payant'
              DataField = 'ACCORDTIERSPAYANT'
              TabOrder = 0
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object edtMtMiniPriseenchargeAMO: TDBEdit
              Left = 136
              Top = 44
              Width = 57
              Height = 19
              DataField = 'MTSEUILTIERSPAYANT'
              TabOrder = 1
            end
            object edtApplicationMiniPCAMO: TDBEdit
              Left = 136
              Top = 68
              Width = 113
              Height = 19
              DataField = 'APPLICATIONMINIPC_LIBELLE'
              TabOrder = 2
            end
          end
          object chkFinDroitsOrgAMC: TDBCheckBox
            Left = 0
            Top = 176
            Width = 169
            Height = 17
            Caption = 'Ne pas contr'#244'ler fin droits AMC'
            DataField = 'FIN_DROITS_ORG_AMC'
            DataSource = dsResultat
            TabOrder = 4
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
        end
        object pnlGestionAMC: TPanel
          Left = 8
          Top = 6
          Width = 273
          Height = 171
          AutoSize = True
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          Visible = False
          object lblTypeContrat: TLabel
            Left = 168
            Top = 4
            Width = 62
            Height = 13
            Caption = 'Type contrat'
          end
          object chkOrgSantePharma: TDBCheckBox
            Left = 0
            Top = 2
            Width = 153
            Height = 17
            Caption = 'Organisme Sant'#233'-Pharma'
            DataField = 'ORG_SANTE_PHARMA'
            DataSource = dsResultat
            TabOrder = 0
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object chkSaisieNoAdherent: TDBCheckBox
            Left = 0
            Top = 26
            Width = 177
            Height = 17
            Caption = 'Saisie obligatoire n'#176' adh'#233'rent'
            DataField = 'SAISIE_NO_ADHERENT'
            DataSource = dsResultat
            TabOrder = 2
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object chkPriseEnChargeAME: TDBCheckBox
            Left = 0
            Top = 50
            Width = 145
            Height = 17
            Caption = 'Prise en charge AME'
            DataField = 'PRISE_EN_CHARGE_AME'
            DataSource = dsResultat
            TabOrder = 3
            ValueChecked = '1'
            ValueUnchecked = '0'
          end
          object gBxGestionAMC: TGroupBox
            Left = 0
            Top = 74
            Width = 273
            Height = 97
            Caption = 'Accords'
            ParentBackground = False
            TabOrder = 4
            object lblMtMiniPriseEnChargeAMC: TLabel
              Left = 16
              Top = 47
              Width = 104
              Height = 13
              Caption = 'Mt mini pris en charge'
            end
            object lblApplicationMiniPCAMC: TLabel
              Left = 16
              Top = 72
              Width = 66
              Height = 13
              Caption = 'S'#39'applique sur'
            end
            object Label2: TLabel
              Left = 0
              Top = 2
              Width = 273
              Height = 16
              AutoSize = False
              Caption = '   Accords'
              Color = clGreen
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
            end
            object chkAccordsTierPayantAMC: TDBCheckBox
              Left = 16
              Top = 24
              Width = 113
              Height = 17
              Caption = 'Accord Tier Payant'
              DataField = 'ACCORD_TIERS_PAYANT'
              DataSource = dsResultat
              TabOrder = 0
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object edtMtMiniPriseenchargeAMC: TDBEdit
              Left = 136
              Top = 44
              Width = 57
              Height = 19
              Color = 15987699
              DataField = 'MT_SEUIL_TIERS_PAYANT'
              DataSource = dsResultat
              TabOrder = 1
            end
            object edtApplicationMiniPCAMC: TDBEdit
              Left = 136
              Top = 68
              Width = 113
              Height = 19
              Color = 14737632
              DataField = 'APPLICATION_MT_MINI_PC'
              DataSource = dsResultat
              TabOrder = 2
            end
          end
          object edtTypeContrat: TDBEdit
            Left = 240
            Top = 0
            Width = 33
            Height = 19
            DataField = 'TYPE_CONTRAT'
            DataSource = dsResultat
            TabOrder = 1
          end
        end
        object chkEditionReleve: TDBCheckBox
          Left = 344
          Top = 64
          Width = 145
          Height = 17
          Caption = 'Bordereau de tranmission'
          DataField = 'EDITION_RELEVE'
          DataSource = dsResultat
          TabOrder = 4
          ValueChecked = '1'
          ValueUnchecked = '0'
        end
        object edtDocFacturation: TDBEdit
          Left = 496
          Top = 6
          Width = 129
          Height = 19
          Color = 15987699
          DataField = 'DOC_FACTURATION'
          DataSource = dsResultat
          TabOrder = 2
        end
        object txtSeuilEdReleve: TDBEdit
          Left = 496
          Top = 30
          Width = 49
          Height = 19
          Color = 15987699
          DataField = 'MT_SEUIL_ED_RELEVE'
          DataSource = dsResultat
          TabOrder = 3
        end
        object edtTypeReleve: TDBEdit
          Left = 496
          Top = 92
          Width = 129
          Height = 19
          Color = 15987699
          DataField = 'TYPE_RELEVE'
          DataSource = dsResultat
          TabOrder = 5
        end
        object edtFrequenceEdition: TDBEdit
          Left = 496
          Top = 116
          Width = 41
          Height = 19
          Color = 14737632
          DataField = 'FREQUENCE_RELEVE'
          DataSource = dsResultat
          TabOrder = 6
        end
      end
      object tShCommentaires: TTabSheet
        Caption = 'Commentaires'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblCommentaire: TLabel
          Left = 8
          Top = 8
          Width = 63
          Height = 13
          Caption = 'Commentaire'
        end
        object lblCommGlobal: TLabel
          Left = 344
          Top = 8
          Width = 108
          Height = 13
          Caption = 'Commentaire bloquant'
        end
        object mmCommentaire: TDBMemo
          Left = 8
          Top = 24
          Width = 277
          Height = 169
          Color = 15987699
          DataField = 'COMMENTAIRE'
          DataSource = dsResultat
          TabOrder = 0
        end
        object mmCommGlobal: TDBMemo
          Left = 348
          Top = 24
          Width = 277
          Height = 169
          Color = 15987699
          DataField = 'COMMENTAIRE_BLOQUANT'
          DataSource = dsResultat
          TabOrder = 1
        end
      end
      object tShAMOAssAMC: TTabSheet
        Caption = 'Organismes AMO associ'#233's'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblAMOAssAMC: TLabel
          Left = 8
          Top = 8
          Width = 125
          Height = 13
          Caption = 'Organismes AMO associ'#233's'
        end
        object dbGrdAMOAssAMC: TPIDBGrid
          Left = 8
          Top = 24
          Width = 617
          Height = 169
          BorderStyle = bsNone
          DataSource = dsAMOAssAMC
          DefaultDrawing = False
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
          Options2.CoinsRonds = False
          Details = False
          HauteurEntetes = 17
          Entetes = <>
          MultiSelection.Active = False
          MultiSelection.Mode = mmsSelection
          Columns = <
            item
              Expanded = False
              FieldName = 'NOM_ORGANISME_AMO'
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
              FieldName = 'TOP_MUTUALISTE'
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
              FieldName = 'TYPE_CONTRAT'
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
              FieldName = 'REGIME'
              Title.Alignment = taCenter
              Width = 35
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
              FieldName = 'CAISSE_GESTIONNAIRE'
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
              FieldName = 'CENTRE_GESTIONNAIRE'
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
              FieldName = 'NOM_DESTINATAIRE'
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
              FieldName = 'TYPE_DEBITEUR'
              Title.Alignment = taCenter
              Width = 81
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
    object edtNom: TDBEdit
      Left = 280
      Top = 4
      Width = 349
      Height = 19
      Color = 14737632
      DataField = 'NOM'
      DataSource = dsResultat
      TabOrder = 1
    end
    object edtNomReduit: TDBEdit
      Left = 280
      Top = 28
      Width = 169
      Height = 19
      Color = 15987699
      DataField = 'NOM_REDUIT'
      DataSource = dsResultat
      TabOrder = 2
    end
    object edtDestinataire: TDBEdit
      Left = 280
      Top = 76
      Width = 349
      Height = 19
      Color = 15987699
      DataField = 'NOM_DESTINATAIRE'
      DataSource = dsResultat
      TabOrder = 7
    end
    object edtIdNat: TDBEdit
      Left = 280
      Top = 52
      Width = 89
      Height = 19
      DataField = 'IDENTIFIANT_NATIONAL'
      DataSource = dsResultat
      TabOrder = 6
      Visible = False
    end
    object edtTypeOrganisme: TDBEdit
      Left = 48
      Top = 4
      Width = 41
      Height = 19
      DataField = 'LIBELLE_TYPE_ORGANISME'
      DataSource = dsResultat
      TabOrder = 0
    end
    object pnlSeparator_1: TPanel
      Left = 0
      Top = 210
      Width = 996
      Height = 16
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 10
      ExplicitTop = 95
      ExplicitWidth = 629
    end
    object edtRegime: TDBEdit
      Left = 280
      Top = 52
      Width = 25
      Height = 19
      Color = 14737632
      DataField = 'REGIME'
      DataSource = dsResultat
      TabOrder = 3
      Visible = False
    end
    object EdtCaisGest: TDBEdit
      Left = 304
      Top = 52
      Width = 25
      Height = 19
      Color = 14737632
      DataField = 'CAISSE_GESTIONNAIRE'
      DataSource = dsResultat
      TabOrder = 4
      Visible = False
    end
    object edtCtrGest: TDBEdit
      Left = 328
      Top = 52
      Width = 41
      Height = 19
      Color = 14737632
      DataField = 'CENTRE_GESTIONNAIRE'
      DataSource = dsResultat
      TabOrder = 5
      Visible = False
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetOrganismes
    OnDataChange = dsResultDataChange
  end
  object dsCouvertures: TDataSource
    AutoEdit = False
    OnStateChange = dsCouverturesStateChange
    Left = 680
    Top = 224
  end
  object dsAMOAssAMC: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetAssociationsOrganismesAMOAMC
    Left = 688
    Top = 296
  end
end
