inherited frCommandesEnCours: TfrCommandesEnCours
  inherited Splitter: TSplitter
    Width = 798
    Cursor = crHSplit
    Align = alNone
    Visible = False
    ExplicitWidth = 798
  end
  inherited pnlCritere: TPanel
    ParentColor = True
    ExplicitWidth = 816
    inherited lblCritere: TLabel
      Width = 56
      Caption = 'Fournisseur'
      ExplicitWidth = 56
    end
    inherited btnChercher: TPISpeedButton
      Left = 507
      OnClick = sBtnSearchClick
      ExplicitLeft = 507
    end
    inherited edtCritere: TEdit
      Left = 88
      Width = 417
      ExplicitLeft = 88
      ExplicitWidth = 417
    end
  end
  inherited grdResultat: TPIDBGrid
    Width = 798
    Align = alNone
  end
  inherited ScrollBox: TScrollBox
    Top = 153
    Width = 798
    Height = 351
    Align = alNone
    Visible = False
    ExplicitTop = 153
    ExplicitWidth = 798
    ExplicitHeight = 351
  end
  object PIDBStringGrid1: TPIDBStringGrid [4]
    Left = 0
    Top = 33
    Width = 451
    Height = 271
    Align = alClient
    Color = clBtnFace
    ColCount = 8
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
        Nom = 'Column1'
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
        Nom = 'Column2'
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
        Nom = 'Column3'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Qt'#233' cmd.'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 70
        NomChamp = 'QUANTITE_COMMANDEE'
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
        Nom = 'Column4'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Qt'#233' tot. re'#231'ue'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 70
        NomChamp = 'QUANTITE_TOTALE_RECUE'
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
        Nom = 'Column5'
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
        Largeur = 65
        NomChamp = 'PRIX_ACHAT_TARIF'
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
        Nom = 'Column6'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'PA Remis'#233
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 65
        NomChamp = 'PRIX_ACHAT_REMISE'
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
        Nom = 'Column7'
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
        Largeur = 65
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
    Options2.PointSuspensionDonnees = False
    Options2.PointSuspensionTitre = False
    Options2.CoinsRonds = False
    HauteurEntetes = 17
    Entetes = <>
    MenuEditionActif = True
    Groupements = <
      item
        NomChamp = 'RAISON_SOCIALE'
        Titre = '%s :'
      end
      item
        NomChamp = 'DATE_CREATION'
        Titre = 'le %s'
      end
      item
        NomChamp = 'MODE_TRANSMISSION'
        Titre = '(%s)'
      end
      item
        NomChamp = 'MONTANT_HT'
        Titre = 'pour %s'
      end>
    ConfigurationGroupements.Alignement = taLeftJustify
    ConfigurationGroupements.Hauteur = 24
    ConfigurationGroupements.Police.Charset = DEFAULT_CHARSET
    ConfigurationGroupements.Police.Color = clWhite
    ConfigurationGroupements.Police.Height = -11
    ConfigurationGroupements.Police.Name = 'MS Sans Serif'
    ConfigurationGroupements.Police.Style = [fsBold]
    ConfigurationGroupements.Couleur = 12547635
    SourceDonnees = dsResultat
    ColWidths = (
      15
      70
      140
      70
      70
      65
      65
      65)
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetCommandesEnCours
  end
end
