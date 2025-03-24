inherited frRistournes: TfrRistournes
  Width = 745
  Height = 587
  ExplicitHeight = 335
  inherited Splitter: TSplitter
    Top = 345
    Width = 705
    Height = 0
    Cursor = crHSplit
    Align = alNone
    ExplicitTop = 345
    ExplicitWidth = 705
    ExplicitHeight = 0
  end
  inherited ScrollBox: TScrollBox [1]
    Top = 345
    Width = 705
    Height = 185
    Align = alNone
    ExplicitTop = 345
    ExplicitWidth = 705
    ExplicitHeight = 185
  end
  inherited pnlCritere: TPanel [2]
    Width = 745
    inherited lblCritere: TLabel
      Left = 96
      Top = 33
      Width = 64
      Caption = 'Nom du client'
      ExplicitLeft = 96
      ExplicitTop = 33
      ExplicitWidth = 64
    end
    object Label3: TLabel [1]
      Left = 8
      Top = 9
      Width = 108
      Height = 13
      Caption = 'Nom+Pr'#233'nom du client'
    end
    inherited btnChercher: TPISpeedButton
      OnClick = btnChercherClick
    end
    inherited edtCritere: TEdit
      Left = 148
      Width = 289
      ExplicitLeft = 148
      ExplicitWidth = 289
    end
  end
  inherited grdResultat: TPIDBGrid [3]
    Width = 745
    Height = 316
    Align = alClient
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'T_COMPTE_ID'
        Title.Alignment = taCenter
        Width = 87
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
        Title.Caption = 'Nom'
        Width = 176
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
        Width = 167
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
        FieldName = 'NB_CARTES'
        Title.Caption = 'Nb Cartes'
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
        FieldName = 'SOLDEDISP'
        Title.Alignment = taCenter
        Title.Caption = 'Solde Disp.'
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
        FieldName = 'RISTDISP'
        Title.Caption = 'Rist. Disp.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
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
  object pnlRecapitulatif: TPanel [4]
    Left = 0
    Top = 349
    Width = 745
    Height = 238
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 97
    ExplicitWidth = 451
    object lblNom: TLabel
      Left = 8
      Top = 14
      Width = 21
      Height = 13
      Caption = 'Nom'
    end
    object Label2: TLabel
      Left = 8
      Top = 132
      Width = 110
      Height = 13
      Caption = 'Somme cr'#233'dit ristourne'
    end
    object Label4: TLabel
      Left = 185
      Top = 132
      Width = 107
      Height = 13
      Caption = 'Somme d'#233'bit ristourne'
    end
    object Label5: TLabel
      Left = 360
      Top = 132
      Width = 80
      Height = 13
      Caption = 'Somme ristourne'
    end
    object Label6: TLabel
      Left = 8
      Top = 188
      Width = 92
      Height = 13
      Caption = 'Somme cr'#233'dit client'
    end
    object Label7: TLabel
      Left = 184
      Top = 188
      Width = 89
      Height = 13
      Caption = 'Somme d'#233'bit client'
    end
    object Label8: TLabel
      Left = 360
      Top = 188
      Width = 96
      Height = 13
      Caption = 'Ristourne disponible'
    end
    object Label1: TLabel
      Left = 148
      Top = 151
      Width = 4
      Height = 13
      Caption = '-'
    end
    object Label9: TLabel
      Left = 148
      Top = 207
      Width = 4
      Height = 13
      Caption = '-'
    end
    object Label10: TLabel
      Left = 322
      Top = 151
      Width = 8
      Height = 13
      Caption = '='
    end
    object Label11: TLabel
      Left = 322
      Top = 207
      Width = 8
      Height = 13
      Caption = '='
    end
    object edtNom: TDBEdit
      Left = 55
      Top = 12
      Width = 122
      Height = 21
      Color = 15987699
      DataField = 'NOM'
      DataSource = dsResultat
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 8
      Top = 151
      Width = 108
      Height = 21
      Color = 15987699
      DataField = 'SOLDE0'
      DataSource = dsResultat
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 183
      Top = 151
      Width = 108
      Height = 21
      Color = 15987699
      DataField = 'SOLDE1'
      DataSource = dsResultat
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 360
      Top = 151
      Width = 108
      Height = 21
      Color = 15987699
      DataField = 'SOLDEDISP'
      DataSource = dsResultat
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 8
      Top = 207
      Width = 108
      Height = 21
      Color = 15987699
      DataField = 'SOLDE2'
      DataSource = dsResultat
      TabOrder = 4
    end
    object DBEdit6: TDBEdit
      Left = 184
      Top = 207
      Width = 108
      Height = 21
      Color = 15987699
      DataField = 'SOLDE3'
      DataSource = dsResultat
      TabOrder = 5
    end
    object DBEdit7: TDBEdit
      Left = 360
      Top = 207
      Width = 108
      Height = 21
      Color = 15987699
      DataField = 'RISTDISP'
      DataSource = dsResultat
      TabOrder = 6
    end
    object DBEdit1: TDBEdit
      Left = 183
      Top = 12
      Width = 109
      Height = 21
      Color = 15987699
      DataField = 'PRENOM'
      DataSource = dsResultat
      TabOrder = 7
    end
    object grdCartes: TPIDBGrid
      Left = 8
      Top = 41
      Width = 393
      Height = 85
      Align = alCustom
      BorderStyle = bsNone
      Constraints.MinHeight = 20
      DataSource = dsCartes
      DefaultDrawing = False
      DrawingStyle = gdsGradient
      FixedColor = 14922394
      GradientEndColor = 14790035
      GradientStartColor = 15584957
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = pmnMenuFrame
      TabOrder = 8
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
          FieldName = 'NUM_CARTE'
          Title.Alignment = taCenter
          Title.Caption = 'No Carte'
          Width = 86
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
          Title.Caption = 'Nom'
          Width = 111
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
          Width = 96
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
          FieldName = 'dateEmis'
          Title.Caption = 'Date d '#233'mission'
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
        end>
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_be.dSetRistournes
    Left = 344
    Top = 96
  end
  inherited pmnMenuFrame: TJvPopupMenu
    Left = 256
    Top = 96
  end
  object dsCartes: TDataSource
    AutoEdit = False
    DataSet = dmVisualisationPHA_be.dSetCartesRistournes
    Left = 416
    Top = 96
  end
end
