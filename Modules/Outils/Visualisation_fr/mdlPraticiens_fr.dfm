inherited frPraticiens: TfrPraticiens
  Width = 869
  Ctl3D = False
  ParentColor = False
  ParentCtl3D = False
  inherited Splitter: TSplitter
    Width = 869
    ExplicitWidth = 932
  end
  object txtTypePraticien: TDBText [1]
    Left = 0
    Top = 156
    Width = 869
    Height = 29
    Align = alTop
    Alignment = taCenter
    DataField = 'LIBELLE_TYPE_PRATICIEN'
    DataSource = dsResultat
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 443
  end
  inherited pnlCritere: TPanel
    Width = 869
    inherited lblCritere: TLabel
      Width = 67
      Caption = 'NOM+Pr'#233'nom'
      ExplicitWidth = 67
    end
    inherited btnChercher: TPISpeedButton
      Left = 571
      OnClick = btnChercherClick
      ExplicitLeft = 571
    end
    inherited edtCritere: TEdit
      Left = 96
      Width = 469
      Height = 19
      ExplicitLeft = 96
      ExplicitWidth = 469
      ExplicitHeight = 19
    end
  end
  inherited grdResultat: TPIDBGrid
    Width = 869
    ParentColor = True
    Columns = <
      item
        Expanded = False
        FieldName = 'T_PRATICIEN_ID'
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
        FieldName = 'NO_FINESS'
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
        FieldName = 'LIBELLE_TYPE_PRATICIEN'
        Title.Alignment = taCenter
        Width = 104
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
        FieldName = 'TEL_PERSONNEL'
        Title.Alignment = taCenter
        Width = 119
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
        FieldName = 'RPPS'
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
    Top = 185
    Width = 635
    Height = 119
    ExplicitTop = 185
    ExplicitWidth = 217
    ExplicitHeight = 119
    object pnlPPrive: TPanel
      Left = 8
      Top = 4
      Width = 265
      Height = 133
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object lblNomPP: TLabel
        Left = 0
        Top = 4
        Width = 21
        Height = 13
        Caption = 'Nom'
      end
      object lblPrenomPP: TLabel
        Left = 0
        Top = 28
        Width = 36
        Height = 13
        Caption = 'Pr'#233'nom'
      end
      object lblFinessPP: TLabel
        Left = 0
        Top = 52
        Width = 35
        Height = 13
        Caption = 'FINESS'
      end
      object lblSpecialitePP: TLabel
        Left = 0
        Top = 79
        Width = 45
        Height = 13
        Caption = 'Sp'#233'cialit'#233
      end
      object LblRpps: TLabel
        Left = 0
        Top = 97
        Width = 24
        Height = 13
        Caption = 'Rpps'
      end
      object chkAgreeRATPPP: TDBCheckBox
        Left = 0
        Top = 116
        Width = 97
        Height = 17
        Caption = 'Agr'#233#233' RATP'
        DataField = 'AGREE_RATP'
        DataSource = dsResultat
        TabOrder = 4
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object edtNomPP: TDBEdit
        Left = 80
        Top = 0
        Width = 185
        Height = 19
        DataField = 'NOM'
        DataSource = dsResultat
        TabOrder = 0
      end
      object edtPrenomPP: TDBEdit
        Left = 80
        Top = 24
        Width = 185
        Height = 19
        DataField = 'PRENOM'
        DataSource = dsResultat
        TabOrder = 1
      end
      object edtFinessPP: TDBEdit
        Left = 80
        Top = 48
        Width = 65
        Height = 19
        DataField = 'NO_FINESS'
        DataSource = dsResultat
        TabOrder = 2
      end
      object edtSpecialitePP: TDBEdit
        Left = 80
        Top = 72
        Width = 185
        Height = 19
        DataField = 'SPECIALITE'
        DataSource = dsResultat
        TabOrder = 3
      end
      object edtRpps: TDBEdit
        Left = 80
        Top = 97
        Width = 185
        Height = 19
        DataField = 'RPPS'
        DataSource = dsResultat
        TabOrder = 5
      end
    end
    object pnlPHosp: TPanel
      Left = 8
      Top = 4
      Width = 265
      Height = 43
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      Visible = False
      object lblNomPH: TLabel
        Left = 0
        Top = 4
        Width = 21
        Height = 13
        Caption = 'Nom'
      end
      object lblFinessHP: TLabel
        Left = 0
        Top = 28
        Width = 35
        Height = 13
        Caption = 'FINESS'
      end
      object edtNomHP: TDBEdit
        Left = 80
        Top = 0
        Width = 185
        Height = 19
        DataField = 'NOM_HOPITAL'
        DataSource = dsResultat
        TabOrder = 0
      end
      object edtFinessHP: TDBEdit
        Left = 80
        Top = 24
        Width = 185
        Height = 19
        DataField = 'NO_FINESS'
        DataSource = dsResultat
        TabOrder = 1
      end
    end
    object pCtrlDetailPraticien: TPageControl
      Left = 0
      Top = 148
      Width = 619
      Height = 177
      ActivePage = tShAdresse
      Align = alBottom
      OwnerDraw = True
      TabOrder = 3
      OnDrawTab = pCtrlDetailPraticienDrawTab
      ExplicitWidth = 273
      object tShAdresse: TTabSheet
        Caption = 'Adresse'
        ExplicitWidth = 265
        inline frAdressePraticien: TfrAdresse
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
      object tShCommentaires: TTabSheet
        Caption = 'Commentaires'
        ImageIndex = 1
        object mmCommentaires: TDBMemo
          Left = 8
          Top = 4
          Width = 385
          Height = 117
          DataField = 'COMMENTAIRE'
          DataSource = dsResultat
          TabOrder = 0
        end
      end
    end
    object pnlSeparator: TPanel
      Left = 0
      Top = 137
      Width = 619
      Height = 11
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      ExplicitWidth = 273
    end
  end
  object dbGrdPraticiensHosp: TPIDBGrid [5]
    Left = 635
    Top = 185
    Width = 234
    Height = 119
    Align = alRight
    BorderStyle = bsNone
    DataSource = dsPraticiensHosp
    DefaultDrawing = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
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
        FieldName = 'NOM'
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
        FieldName = 'PRENOM'
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
        FieldName = 'SPECIALITE'
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
      end>
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetPraticiens
    OnDataChange = dsResultDataChange
    Top = 88
  end
  object dsPraticiensHosp: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_fr.dSetPraticienHospitalier
    Left = 536
    Top = 88
  end
end
