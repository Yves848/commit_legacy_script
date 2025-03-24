object frmGenerationSQL: TfrmGenerationSQL
  Left = 504
  Top = 302
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Saisies'
  ClientHeight = 384
  ClientWidth = 530
  Color = clBtnFace
  Constraints.MaxHeight = 418
  Constraints.MaxWidth = 539
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbxTableMAJ: TGroupBox
    Left = 0
    Top = 0
    Width = 530
    Height = 129
    Align = alTop
    Caption = 'Table '#224' mettre '#224' jour'
    TabOrder = 0
    object lblTable: TLabel
      Left = 16
      Top = 72
      Width = 27
      Height = 13
      Caption = 'Table'
    end
    object lblCle: TLabel
      Left = 16
      Top = 100
      Width = 15
      Height = 14
      Caption = 'Cl'#233
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaption
      Font.Height = -11
      Font.Name = 'lblCle'
      Font.Style = []
      ParentFont = False
    end
    object lblValeurCle: TLabel
      Left = 272
      Top = 100
      Width = 73
      Height = 13
      Caption = 'Valeur de la cl'#233
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaption
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cbxTable: TComboBox
      Left = 56
      Top = 68
      Width = 457
      Height = 21
      TabOrder = 0
      OnChange = cbxTableChange
    end
    object cbxCle: TComboBox
      Left = 56
      Top = 96
      Width = 201
      Height = 21
      Enabled = False
      TabOrder = 1
      OnChange = cbxCleChange
    end
    object cbxValeurCle: TComboBox
      Left = 360
      Top = 96
      Width = 153
      Height = 21
      Enabled = False
      TabOrder = 2
      OnChange = cbxCleChange
    end
    object rdgAction: TJvRadioGroup
      Left = 16
      Top = 16
      Width = 497
      Height = 33
      Columns = 3
      ItemIndex = 1
      Items.Strings = (
        'Insertion (insert ...)'
        'Mise '#224' jour (update ...)'
        'Suppression (delete ...)')
      TabOrder = 3
      OnClick = rdgActionClick
      CaptionVisible = False
      EdgeInner = esNone
      EdgeOuter = esNone
    end
  end
  object grdChampsMAJ: TPIStringGrid
    Left = 0
    Top = 129
    Width = 530
    Height = 208
    Align = alTop
    ColCount = 3
    DefaultRowHeight = 17
    DefaultDrawing = False
    DoubleBuffered = True
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentDoubleBuffered = False
    TabOrder = 1
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
        Nom = 'CHAMPS'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Champs'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 247
      end
      item
        Alignement = taLeftJustify
        Couleur = clWindow
        Controle = ccComboBox
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
        Nom = 'VALEUR'
        Options = [ocExport, ocImpression]
        LectureSeule = False
        Titre.Alignement = taCenter
        Titre.Libelle = 'Valeurs'
        Titre.Couleur = clBtnFace
        Titre.Police.Charset = DEFAULT_CHARSET
        Titre.Police.Color = clWindowText
        Titre.Police.Height = -11
        Titre.Police.Name = 'MS Sans Serif'
        Titre.Police.Style = []
        Visible = True
        Largeur = 247
      end>
    ControleHauteurLigne = False
    Options2.LargeurIndicateur = 11
    Options2.LignesParLigneDonnees = 1
    Options2.LignesParTitre = 1
    Options2.CouleurSelection = clHighlight
    Options2.PoliceSelection.Charset = DEFAULT_CHARSET
    Options2.PoliceSelection.Color = clHighlightText
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
    ColWidths = (
      15
      247
      247)
  end
  object btnValider: TButton
    Left = 176
    Top = 352
    Width = 75
    Height = 25
    Caption = '&Valider'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnAnnuler: TButton
    Left = 280
    Top = 352
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 3
  end
end
