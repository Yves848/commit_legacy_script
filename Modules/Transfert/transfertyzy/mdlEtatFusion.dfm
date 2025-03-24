inherited frmEtatFusion: TfrmEtatFusion
  Left = 0
  Top = 0
  Caption = 'Etat de la fusion'
  ClientHeight = 565
  ClientWidth = 1099
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 1107
  ExplicitHeight = 599
  DesignSize = (
    1099
    565)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 51
    Width = 1099
    Height = 454
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Clients'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1091
        Height = 33
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 11
          Width = 75
          Height = 13
          Caption = 'N'#176' INSEE - Nom'
        end
        object JvDBSearchEdit1: TJvDBSearchEdit
          Left = 205
          Top = 6
          Width = 346
          Height = 21
          DataSource = DataSource1
          DataField = 'NOM_PRENOM'
          TabOrder = 0
        end
        object JvDBSearchEdit5: TJvDBSearchEdit
          Left = 89
          Top = 6
          Width = 110
          Height = 21
          DataSource = DataSource1
          DataField = 'NUMERO_INSEE'
          TabOrder = 1
        end
      end
      object DBGrid1: TPIDBGrid
        Left = 0
        Top = 33
        Width = 1091
        Height = 393
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -11
        Options2.PoliceSelection.Name = 'Tahoma'
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
            FieldName = 'T_CLIENT_ID'
            Title.Alignment = taCenter
            Title.Caption = 'N'#176' de client'
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
            FieldName = 'NUMERO_INSEE'
            Title.Alignment = taCenter
            Title.Caption = 'N'#176' INSEE'
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
            FieldName = 'NOM_PRENOM'
            Title.Alignment = taCenter
            Title.Caption = 'Nom - pr'#233'nom'
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
            FieldName = 'DATE_NAISSANCE'
            Title.Alignment = taCenter
            Title.Caption = 'Date de naissance'
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
          end
          item
            Expanded = False
            FieldName = 'RANG_GEMELLAIRE'
            Title.Alignment = taCenter
            Title.Caption = 'Rang'
            Width = 52
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
            FieldName = 'AMO'
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
            FieldName = 'AMC'
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'DECODE(ETAT,'#39'F'#39','#39'FUSIONN'#201#39','#39'R'#39','#39'RECONNU'#39','#39'CR'#201'E'#39')'
            Title.Alignment = taCenter
            Title.Caption = 'Etat'
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
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Produits'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGrid2: TPIDBGrid
        Left = 0
        Top = 33
        Width = 1091
        Height = 393
        Align = alClient
        DataSource = DataSource2
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -11
        Options2.PoliceSelection.Name = 'Tahoma'
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
            FieldName = 'T_PRODUIT_ID'
            Title.Alignment = taCenter
            Title.Caption = 'N'#176' de produit'
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'CODE_CIP'
            Title.Alignment = taCenter
            Title.Caption = 'Code CIP'
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'CODE_CIP7'
            Title.Alignment = taCenter
            Title.Caption = 'Code CIP 7'
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
            FieldName = 'DESIGNATION'
            Title.Alignment = taCenter
            Title.Caption = 'D'#233'signation'
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
            FieldName = 'DECODE(ETAT,'#39'F'#39','#39'FUSIONN'#201#39','#39'R'#39','#39'RECONNU'#39','#39'CR'#201'E'#39')'
            Title.Alignment = taCenter
            Title.Caption = 'Etat'
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
          end>
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1091
        Height = 33
        Align = alTop
        TabOrder = 1
        object Label2: TLabel
          Left = 8
          Top = 11
          Width = 141
          Height = 13
          Caption = 'Code CIP/CIP 7 - D'#233'signation'
        end
        object JvDBSearchEdit2: TJvDBSearchEdit
          Left = 155
          Top = 6
          Width = 110
          Height = 21
          DataSource = DataSource2
          DataField = 'CODE_CIP'
          TabOrder = 0
        end
        object JvDBSearchEdit3: TJvDBSearchEdit
          Left = 387
          Top = 6
          Width = 310
          Height = 21
          DataSource = DataSource2
          DataField = 'DESIGNATION'
          TabOrder = 1
        end
        object JvDBSearchEdit4: TJvDBSearchEdit
          Left = 271
          Top = 6
          Width = 110
          Height = 21
          DataSource = DataSource2
          DataField = 'CODE_CIP7'
          TabOrder = 2
        end
      end
    end
  end
  object Button1: TButton
    Left = 512
    Top = 532
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Fermer'
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 523
  end
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 0
    Width = 1099
    Height = 51
    Align = alTop
    Caption = 'Filtre'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Tous'
      'Cr'#233'e'
      'Fusionn'#233
      'Reconnu')
    TabOrder = 2
    OnClick = RadioGroup1Click
  end
  object HeaderControl1: THeaderControl
    Left = 0
    Top = 505
    Width = 1099
    Height = 17
    Sections = <
      item
        AllowClick = False
        ImageIndex = -1
        Width = 572
      end
      item
        ImageIndex = -1
        Text = 'Fusionn'#233's'
        Width = 100
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 75
      end
      item
        ImageIndex = -1
        Text = 'Cr'#233#233's'
        Width = 100
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 75
      end
      item
        ImageIndex = -1
        Text = 'Reconnus'
        Width = 100
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 75
      end>
    ExplicitLeft = 56
    ExplicitTop = 504
    ExplicitWidth = 0
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = SmartQuery1
    Left = 40
    Top = 152
  end
  object SmartQuery1: TSmartQuery
    SQL.Strings = (
      'select '
      '  t_client_id,'
      '  numero_insee,'
      '  prenom || nom nom_prenom,'
      '  date_naissance,'
      '  rang_gemellaire,'
      '  amo,'
      '  amc,'
      '  etat,'
      '  decode(etat, '#39'F'#39', '#39'Fusionn'#233#39', '#39'R'#39', '#39'Reconnu'#39', '#39'Cr'#233'e'#39')'
      'from v_fus_client'
      'order by nom, prenom')
    Left = 48
    Top = 248
    object SmartQuery1T_CLIENT_ID: TIntegerField
      FieldName = 'T_CLIENT_ID'
      Required = True
    end
    object SmartQuery1NOM_PRENOM: TStringField
      FieldName = 'NOM_PRENOM'
      ReadOnly = True
      Size = 50
    end
    object SmartQuery1NUMERO_INSEE: TStringField
      FieldName = 'NUMERO_INSEE'
      Size = 15
    end
    object SmartQuery1DATE_NAISSANCE: TStringField
      FieldName = 'DATE_NAISSANCE'
      Size = 8
    end
    object SmartQuery1RANG_GEMELLAIRE: TIntegerField
      FieldName = 'RANG_GEMELLAIRE'
      Required = True
    end
    object SmartQuery1AMO: TStringField
      FieldName = 'AMO'
      Required = True
      Size = 50
    end
    object SmartQuery1AMC: TStringField
      FieldName = 'AMC'
      Required = True
      Size = 50
    end
    object SmartQuery1DECODEETATFFUSIONNÉRRECONNUCRÉE: TStringField
      FieldName = 'DECODE(ETAT,'#39'F'#39','#39'FUSIONN'#201#39','#39'R'#39','#39'RECONNU'#39','#39'CR'#201'E'#39')'
      ReadOnly = True
      Size = 8
    end
    object SmartQuery1ETAT: TStringField
      FieldName = 'ETAT'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object SmartQuery2: TSmartQuery
    SQL.Strings = (
      'select '
      '  t_produit_id,'
      '  code_cip,'
      '  code_cip7,'
      '  designation,'
      '  etat,'
      '  decode(etat, '#39'F'#39', '#39'Fusionn'#233#39', '#39'R'#39', '#39'Reconnu'#39', '#39'Cr'#233'e'#39')'
      'from v_fus_produit'
      'order by designation')
    Left = 152
    Top = 256
    object SmartQuery2T_PRODUIT_ID: TFloatField
      FieldName = 'T_PRODUIT_ID'
      Required = True
    end
    object SmartQuery2CODE_CIP: TStringField
      FieldName = 'CODE_CIP'
      Size = 13
    end
    object SmartQuery2CODE_CIP7: TStringField
      FieldName = 'CODE_CIP7'
      Size = 7
    end
    object SmartQuery2DESIGNATION: TStringField
      FieldName = 'DESIGNATION'
      Required = True
      Size = 50
    end
    object SmartQuery2DECODEETATFFUSIONNÉRRECONNUCRÉE: TStringField
      FieldName = 'DECODE(ETAT,'#39'F'#39','#39'FUSIONN'#201#39','#39'R'#39','#39'RECONNU'#39','#39'CR'#201'E'#39')'
      ReadOnly = True
      Size = 8
    end
    object SmartQuery2ETAT: TStringField
      FieldName = 'ETAT'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = SmartQuery2
    Left = 136
    Top = 152
  end
end
