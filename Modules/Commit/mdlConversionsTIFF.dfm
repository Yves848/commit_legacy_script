object frmConversionTIFF: TfrmConversionTIFF
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Conversions documents scann'#233's vers TIFF'
  ClientHeight = 396
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 298
    Height = 349
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
  object grdConversionsDocuments: TPIStringGrid
    Left = 2
    Top = -4
    Width = 513
    Height = 353
    ColCount = 2
    DefaultRowHeight = 16
    DoubleBuffered = True
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentDoubleBuffered = False
    TabOrder = 0
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
        Fixe = False
        Police.Charset = DEFAULT_CHARSET
        Police.Color = clWindowText
        Police.Height = -11
        Police.Name = 'Tahoma'
        Police.Style = []
        Indicateur = False
        Nom = 'Column0'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Nom du fichier'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'Tahoma'
        Titre.Police.Style = []
        Visible = True
        Largeur = 439
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
        Police.Name = 'Tahoma'
        Police.Style = []
        Indicateur = False
        Nom = 'Column1'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'R'#233'sultat des la conversion'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'Tahoma'
        Titre.Police.Style = []
        Visible = True
        Largeur = 17
      end>
    ControleHauteurLigne = False
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
    HauteurEntetes = 17
    Entetes = <>
    SurDessinerCellule = grdConversionsDocumentsSurDessinerCellule
    MenuEditionActif = True
    ColWidths = (
      439
      17)
  end
  object btnAnnuler: TButton
    Left = 408
    Top = 363
    Width = 75
    Height = 25
    Caption = 'Annuler'
    TabOrder = 1
    OnClick = btnAnnulerClick
  end
end
