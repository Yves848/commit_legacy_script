inherited frFacturesAttentes: TfrFacturesAttentes
  inherited Splitter: TSplitter
    Width = 718
    Cursor = crHSplit
    Align = alNone
    Visible = False
    ExplicitWidth = 718
  end
  inherited grdResultat: TPIDBGrid [1]
    Width = 718
    Align = alNone
    DataSource = nil
    Visible = False
  end
  inherited pnlCritere: TPanel [2]
    ExplicitWidth = 953
    inherited lblCritere: TLabel
      Width = 67
      Caption = 'NOM+Pr'#233'nom'
      ExplicitWidth = 67
    end
    inherited btnChercher: TPISpeedButton
      Left = 563
      OnClick = sBtnSearchClick
      ExplicitLeft = 563
    end
    inherited edtCritere: TEdit
      Left = 96
      Width = 465
      ExplicitLeft = 96
      ExplicitWidth = 465
    end
  end
  inherited ScrollBox: TScrollBox
    Top = 33
    Height = 271
    Visible = False
    ExplicitTop = 33
    ExplicitWidth = 953
    ExplicitHeight = 271
  end
  object PIDBStringGrid1: TPIDBStringGrid [4]
    Left = 0
    Top = 33
    Width = 451
    Height = 271
    Align = alClient
    ColCount = 7
    DefaultRowHeight = 17
    DefaultDrawing = False
    DoubleBuffered = True
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    GradientEndColor = 14790035
    GradientStartColor = 15584957
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentDoubleBuffered = False
    TabOrder = 3
    StyleBordure = sbAucune
    Colonnes = <
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = True
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = True
        Nom = 'Column0'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 15
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = False
        Nom = 'colCODE_CIP'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'CIP'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 70
        NomChamp = 'CODE_CIP'
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = False
        Nom = 'colDESIGNATION'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'D'#233'signation'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 140
        NomChamp = 'DESIGNATION'
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = False
        Nom = 'colPRESTATION'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Prest.'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 64
        NomChamp = 'PRESTATION'
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = False
        Nom = 'colQUANTITE_FACTUREE'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Qt'#233
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 30
        NomChamp = 'QUANTITE_FACTUREE'
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = False
        Nom = 'colPRIX_ACHAT'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'PA HT'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 75
        NomChamp = 'PRIX_ACHAT'
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccAucun
        OptionsControle.CheckBox.ValeurCoche = '1'
        OptionsControle.CheckBox.ValeurDecoche = '0'
        OptionsControle.ComboBox.ValeurParIndex = False
        OptionsControle.ProgressBar.Couleur = clActiveCaption
        OptionsControle.ProgressBar.Max = 100
        OptionsControle.ProgressBar.Min = 0
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'MS Sans Serif'
        Police.Style = []
        Indicateur = False
        Nom = 'colPRIX_VENTE'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'PV TTC'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 64
        NomChamp = 'PRIX_VENTE'
      end>
    ControleHauteurLigne = False
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
    HauteurEntetes = 17
    Entetes = <>
    MenuEditionActif = True
    Groupements = <
      item
        NomChamp = 'T_FACTURE_ATTENTE_ID'
        Titre = 'Facture n'#176' %s :'
      end
      item
        NomChamp = 'PRENOM_CLIENT'
      end
      item
        NomChamp = 'NOM_CLIENT'
      end
      item
        NomChamp = 'DATE_ACTE'
        Titre = 'le %s'
      end>
    ConfigurationGroupements.Alignement = taLeftJustify
    ConfigurationGroupements.Hauteur = 24
    ConfigurationGroupements.Police.Charset = DEFAULT_CHARSET
    ConfigurationGroupements.Police.Color = clWindow
    ConfigurationGroupements.Police.Height = -11
    ConfigurationGroupements.Police.Name = 'MS Sans Serif'
    ConfigurationGroupements.Police.Style = [fsBold]
    ConfigurationGroupements.Couleur = 12547635
    SourceDonnees = dsResultat
    ColWidths = (
      15
      70
      140
      64
      30
      75
      64)
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetFacturesAttentes
  end
end
