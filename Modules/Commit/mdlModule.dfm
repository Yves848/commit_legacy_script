object frModule: TfrModule
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Align = alClient
  TabOrder = 0
  OnMouseMove = FrameMouseMove
  OnResize = FrameResize
  object wzDonnees: TJvWizard
    Left = 0
    Top = 25
    Width = 270
    Height = 279
    ActivePage = wipBienvenue
    ButtonBarHeight = 42
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Pr'#233'c'#233'dent'
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Suivant >'
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.Width = 75
    ButtonCancel.Caption = '&Annuler'
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Aide'
    ButtonHelp.Width = 75
    ShowRouteMap = True
    OnCancelButtonClick = wzDonneesCancelButtonClick
    OnActivePageChanged = wzDonneesActivePageChanged
    OnActivePageChanging = wzDonneesActivePageChanging
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    DesignSize = (
      270
      279)
    object wipBienvenue: TJvWizardInteriorPage
      Tag = 1
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clWhite
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Alignment = taCenter
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      EnabledButtons = [bkStart, bkLast, bkNext, bkFinish, bkHelp]
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      OnHelpButtonClick = wzDonneesHelpButtonClick
      object spl1: TJvNetscapeSplitter
        Left = 0
        Top = 98
        Width = 93
        Height = 11
        Cursor = crVSplit
        Align = alBottom
        MinSize = 1
        Maximized = True
        Minimized = False
        ButtonCursor = crDefault
        ButtonHighlightColor = 15195862
        AutoHighlightColor = True
        ExplicitLeft = -3
        ExplicitTop = 479
        ExplicitWidth = 636
        RestorePos = 128
      end
      object PIPanel1: TPIPanel
        Left = 0
        Top = 109
        Width = 93
        Height = 128
        Align = alBottom
        Alignment = taLeftJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        Degrade.Actif = False
        Degrade.CouleurDepart = clBlack
        Degrade.Direction = dirHautVersBas
        Degrade.CouleurFin = clBlack
        Degrade.Orientation = gdVertical
        CoinsRonds = False
        PropagationEtat = False
        object vstMAJModule: TVirtualStringTree
          Left = 1
          Top = 27
          Width = 91
          Height = 100
          Align = alClient
          BorderStyle = bsNone
          DefaultNodeHeight = 28
          DrawSelectionMode = smBlendedRectangle
          Header.AutoSizeIndex = 2
          Header.DefaultHeight = 22
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = [fsBold]
          Header.Height = 22
          Header.MainColumn = 2
          Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
          Header.Style = hsFlatButtons
          TabOrder = 0
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toFullRowSelect]
          OnFreeNode = vstMAJModuleFreeNode
          OnGetText = vstMAJModuleGetText
          Columns = <
            item
              Alignment = taCenter
              Options = [coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
              Position = 0
              Width = 100
              WideText = 'N'#176' de version'
            end
            item
              Alignment = taCenter
              Options = [coEnabled, coParentBidiMode, coParentColor, coVisible, coFixed, coAllowFocus]
              Position = 1
              Width = 125
              WideText = 'Date de diffusion'
            end
            item
              CaptionAlignment = taCenter
              Options = [coEnabled, coParentBidiMode, coParentColor, coVisible, coFixed, coAllowFocus, coUseCaptionAlignment]
              Position = 2
              Width = 10
              WideText = 'Contenu'
            end>
        end
        object StaticText1: TStaticText
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 85
          Height = 20
          Align = alTop
          Caption = 'Liste des mises '#224' jour'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    object wipPraticiens: TJvWizardInteriorPage
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'Praticiens'
      OnNextButtonClick = PagePrecSuiv
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdPraticiens: TPIStringGrid
        Tag = 1
        Left = 0
        Top = 50
        Width = 93
        Height = 187
        Align = alClient
        Color = clWhite
        ColCount = 10
        DefaultColWidth = 15
        DefaultRowHeight = 17
        DefaultDrawing = False
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentDoubleBuffered = False
        TabOrder = 0
        OnDblClick = GrilleDblClick
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
            Nom = 'INDICATEUR'
            Options = [ocExport, ocImpression]
            LectureSeule = True
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Donn'#233'es'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 237
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'PRESENCE_FICHIER'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fichier pr'#233'sent ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 85
          end
          item
            Alignement = taCenter
            Couleur = clLime
            Controle = ccPerso
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
            Nom = 'SUCCES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Succ'#232's'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clYellow
            Controle = ccPerso
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
            Nom = 'AVERTISSEMENTS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Avertissements'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = 33023
            Controle = ccPerso
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
            Nom = 'REJETS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Rejets'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clRed
            Controle = ccPerso
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
            Nom = 'ERREURS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Erreurs'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'DEBUT'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'D'#233'but'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'FIN'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fin'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 50
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'TRAITEMENT_TERMINE'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fait ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 64
          end>
        ControleHauteurLigne = False
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
        Options2.CouleurSelection = 12547635
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -13
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = [fsBold]
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        HauteurEntetes = 17
        Entetes = <>
        MenuEditionActif = True
        ExplicitWidth = 677
        ExplicitHeight = 542
        ColWidths = (
          15
          237
          85
          60
          60
          60
          100
          100
          50
          64)
      end
    end
    object wipOrganismes: TJvWizardInteriorPage
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'Organismes'
      OnNextButtonClick = PagePrecSuiv
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdOrganismes: TPIStringGrid
        Tag = 2
        Left = 0
        Top = 50
        Width = 93
        Height = 187
        Align = alClient
        Color = clWhite
        ColCount = 10
        DefaultColWidth = 15
        DefaultRowHeight = 17
        DefaultDrawing = False
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentDoubleBuffered = False
        TabOrder = 0
        OnDblClick = GrilleDblClick
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
            Nom = 'INDICATEUR'
            Options = [ocExport, ocImpression]
            LectureSeule = True
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Donn'#233'es'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 237
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'PRESENCE_FICHIER'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fichier pr'#233'sent ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 85
          end
          item
            Alignement = taCenter
            Couleur = clLime
            Controle = ccPerso
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
            Nom = 'SUCCES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Succ'#232's'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clYellow
            Controle = ccPerso
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
            Nom = 'AVERTISSEMENTS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Avertissements'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = 33023
            Controle = ccPerso
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
            Nom = 'REJETS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Rejets'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clRed
            Controle = ccPerso
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
            Nom = 'ERREURS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Erreurs'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
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
            Nom = 'DEBUT'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'D'#233'but'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'FIN'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fin'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'TRAITEMENT_TERMINE'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fait ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 50
          end>
        ControleHauteurLigne = False
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
        Options2.CouleurSelection = 12547635
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -13
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = [fsBold]
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        HauteurEntetes = 17
        Entetes = <>
        MenuEditionActif = True
        ExplicitWidth = 677
        ExplicitHeight = 542
        ColWidths = (
          15
          237
          85
          60
          60
          60
          60
          100
          100
          50)
      end
    end
    object wipClients: TJvWizardInteriorPage
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'Clients'
      OnNextButtonClick = PagePrecSuiv
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdClients: TPIStringGrid
        Tag = 3
        Left = 0
        Top = 50
        Width = 93
        Height = 187
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        ColCount = 10
        DefaultColWidth = 15
        DefaultRowHeight = 17
        DefaultDrawing = False
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentDoubleBuffered = False
        TabOrder = 0
        OnDblClick = GrilleDblClick
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
            Nom = 'INDICATEUR'
            Options = [ocExport, ocImpression]
            LectureSeule = True
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Donn'#233'es'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 237
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'PRESENCE_FICHIER'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fichier pr'#233'sent ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 85
          end
          item
            Alignement = taCenter
            Couleur = clLime
            Controle = ccPerso
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
            Nom = 'SUCCES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Succ'#232's'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clYellow
            Controle = ccPerso
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
            Nom = 'AVERTISSEMENTS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Avertissements'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = 33023
            Controle = ccPerso
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
            Nom = 'REJETS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Rejets'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clRed
            Controle = ccPerso
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
            Nom = 'ERREURS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Erreurs'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
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
            Nom = 'DEBUT'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'D'#233'but'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'FIN'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fin'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'TRAITEMENT_TERMINE'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fait ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 50
          end>
        ControleHauteurLigne = False
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
        Options2.CouleurSelection = 12547635
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -13
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = [fsBold]
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        HauteurEntetes = 17
        Entetes = <>
        MenuEditionActif = True
        ExplicitWidth = 677
        ExplicitHeight = 542
        ColWidths = (
          15
          237
          85
          60
          60
          60
          60
          100
          100
          50)
      end
    end
    object wipProduits: TJvWizardInteriorPage
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'Produits'
      OnNextButtonClick = PagePrecSuiv
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdProduits: TPIStringGrid
        Tag = 4
        Left = 0
        Top = 50
        Width = 93
        Height = 187
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        ColCount = 10
        DefaultColWidth = 15
        DefaultRowHeight = 17
        DefaultDrawing = False
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentDoubleBuffered = False
        TabOrder = 0
        OnDblClick = GrilleDblClick
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
            Nom = 'INDICATEUR'
            Options = [ocExport, ocImpression]
            LectureSeule = True
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Donn'#233'es'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 237
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'PRESENCE_FICHIER'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fichier pr'#233'sent ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 85
          end
          item
            Alignement = taCenter
            Couleur = clLime
            Controle = ccPerso
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
            Nom = 'SUCCES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Succ'#232's'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clYellow
            Controle = ccPerso
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
            Nom = 'AVERTISSEMENTS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Avertissements'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = 33023
            Controle = ccPerso
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
            Nom = 'REJETS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Rejets'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clRed
            Controle = ccPerso
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
            Nom = 'ERREURS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Erreurs'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
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
            Nom = 'DEBUT'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'D'#233'but'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'FIN'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fin'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'TRAITEMENT_TERMINE'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fait ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 50
          end>
        ControleHauteurLigne = False
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
        Options2.CouleurSelection = 12547635
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -13
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = [fsBold]
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        HauteurEntetes = 17
        Entetes = <>
        MenuEditionActif = True
        ExplicitWidth = 677
        ExplicitHeight = 542
        ColWidths = (
          15
          237
          85
          60
          60
          60
          60
          100
          100
          50)
      end
    end
    object wipEnCours: TJvWizardInteriorPage
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Caption = 'Encours'
      Enabled = False
      OnNextButtonClick = PagePrecSuiv
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdEnCours: TPIStringGrid
        Tag = 5
        Left = 0
        Top = 50
        Width = 93
        Height = 187
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        ColCount = 10
        DefaultColWidth = 15
        DefaultRowHeight = 17
        DefaultDrawing = False
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentDoubleBuffered = False
        TabOrder = 0
        OnDblClick = GrilleDblClick
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
            Nom = 'INDICATEUR'
            Options = [ocExport, ocImpression]
            LectureSeule = True
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Donn'#233'es'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 237
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'PRESENCE_FICHIER'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fichier pr'#233'sent ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 85
          end
          item
            Alignement = taCenter
            Couleur = clLime
            Controle = ccPerso
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
            Nom = 'SUCCES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Succ'#232's'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clYellow
            Controle = ccPerso
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
            Nom = 'AVERTISSEMENTS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Avertissements'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = 33023
            Controle = ccPerso
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
            Nom = 'REJETS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Rejets'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clRed
            Controle = ccPerso
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
            Nom = 'ERREURS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Erreurs'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
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
            Nom = 'DEBUT'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'D'#233'but'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'FIN'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fin'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'TRAITEMENT_TERMINE'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fait ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 50
          end>
        ControleHauteurLigne = False
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
        Options2.CouleurSelection = 12547635
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -13
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = [fsBold]
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        HauteurEntetes = 17
        Entetes = <>
        MenuEditionActif = True
        ExplicitWidth = 677
        ExplicitHeight = 542
        ColWidths = (
          15
          237
          85
          60
          60
          60
          60
          100
          100
          50)
      end
    end
    object wipAutresDonnees: TJvWizardInteriorPage
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'Autres donn'#233'es'
      Enabled = False
      OnNextButtonClick = PagePrecSuiv
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdAutresDonnees: TPIStringGrid
        Tag = 8
        Left = 0
        Top = 50
        Width = 93
        Height = 187
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        ColCount = 10
        DefaultColWidth = 15
        DefaultRowHeight = 17
        DefaultDrawing = False
        DoubleBuffered = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentDoubleBuffered = False
        TabOrder = 0
        OnDblClick = GrilleDblClick
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
            Nom = 'INDICATEUR'
            Options = [ocExport, ocImpression]
            LectureSeule = True
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Donn'#233'es'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 237
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'PRESENCE_FICHIER'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fichier pr'#233'sent ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 85
          end
          item
            Alignement = taCenter
            Couleur = clLime
            Controle = ccPerso
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
            Nom = 'SUCCES'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Succ'#232's'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clYellow
            Controle = ccPerso
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
            Nom = 'AVERTISSEMENTS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Avertissements'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = 33023
            Controle = ccPerso
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
            Nom = 'REJETS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Rejets'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
            Couleur = clRed
            Controle = ccPerso
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
            Nom = 'ERREURS'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Erreurs'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 60
          end
          item
            Alignement = taCenter
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
            Nom = 'DEBUT'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'D'#233'but'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taCenter
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
            Nom = 'FIN'
            Options = [ocExport, ocImpression]
            LectureSeule = False
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fin'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'Tahoma'
            Titre.Police.Style = []
            Visible = True
            Largeur = 100
          end
          item
            Alignement = taLeftJustify
            Couleur = clWindow
            Controle = ccCheckBox
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
            Nom = 'TRAITEMENT_TERMINE'
            Options = [ocExport, ocImpression]
            LectureSeule = True
            Titre.Alignement = taCenter
            Titre.Libelle = 'Fait ?'
            Titre.Couleur = clBtnFace
            Titre.Police.Charset = DEFAULT_CHARSET
            Titre.Police.Color = clWindowText
            Titre.Police.Height = -11
            Titre.Police.Name = 'MS Sans Serif'
            Titre.Police.Style = []
            Visible = True
            Largeur = 50
          end>
        ControleHauteurLigne = False
        Options2.LargeurIndicateur = 11
        Options2.LignesParLigneDonnees = 1
        Options2.LignesParTitre = 1
        Options2.CouleurSelection = 12547635
        Options2.PoliceSelection.Charset = DEFAULT_CHARSET
        Options2.PoliceSelection.Color = clHighlightText
        Options2.PoliceSelection.Height = -13
        Options2.PoliceSelection.Name = 'MS Sans Serif'
        Options2.PoliceSelection.Style = [fsBold]
        Options2.OptionsImpression.UniqLigneSelectionne = False
        Options2.OptionsImpression.FondCellule = False
        Options2.OptionsImpression.FondTitre = False
        Options2.PointSuspensionDonnees = False
        Options2.PointSuspensionTitre = False
        Options2.CoinsRonds = False
        HauteurEntetes = 17
        Entetes = <>
        MenuEditionActif = True
        ExplicitWidth = 677
        ExplicitHeight = 542
        ColWidths = (
          15
          237
          85
          60
          60
          60
          60
          100
          100
          50)
      end
    end
    object wipRecapitulatif: TJvWizardInteriorPage
      Tag = 1
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'R'#233'caputil'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Visible = False
      Header.Subtitle.Text = 'Subtitle'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Alignment = taCenter
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = []
      Header.ShowDivider = False
      EnabledButtons = [bkStart, bkLast, bkBack, bkFinish, bkHelp]
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'R'#233'capitulatif'
      OnEnterPage = wipRecapitulatifEnterPage
      OnHelpButtonClick = wzDonneesHelpButtonClick
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object sbxRecapitulatif: TScrollBox
        Left = 0
        Top = 50
        Width = 677
        Height = 542
        Align = alClient
        TabOrder = 0
        OnResize = sbxRecapitulatifResize
        object prpRecapitulatif: TPRPage
          Left = 0
          Top = 0
          Width = 697
          Height = 842
          MarginTop = 32
          MarginLeft = 32
          MarginRight = 32
          MarginBottom = 32
          object prlpRecapitulatif: TPRLayoutPanel
            Left = 33
            Top = 33
            Width = 631
            Height = 776
            Align = alClient
            object prlNonImportees: TPRLabel
              Tag = 1
              Left = 520
              Top = 8
              Width = 96
              Height = 17
              FontColor = clRed
              FontName = fnArial
              FontSize = 12.000000000000000000
              FontBold = True
              Caption = 'Non-import'#233'es'
              Alignment = taCenter
            end
            object prlImportees: TPRLabel
              Tag = 1
              Left = 380
              Top = 8
              Width = 61
              Height = 17
              FontColor = clLime
              FontName = fnArial
              FontSize = 12.000000000000000000
              FontBold = True
              Caption = 'Import'#233'es'
              Alignment = taCenter
            end
            object prlRejetees: TPRLabel
              Tag = 1
              Left = 452
              Top = 8
              Width = 68
              Height = 17
              FontColor = 33023
              FontName = fnArial
              FontSize = 12.000000000000000000
              FontBold = True
              Caption = 'Rejet'#233'es'
              Alignment = taCenter
            end
          end
        end
      end
    end
    object rmnDonnees: TJvWizardRouteMapNodes
      Left = 0
      Top = 0
      Width = 177
      Height = 237
      Cursor = crHandPoint
      Color = 12547635
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      UsePageTitle = False
    end
  end
  object xpcOutils: TJvXPContainer
    Left = 270
    Top = 25
    Width = 181
    Height = 279
    Color = clWhite
    ParentColor = False
    Align = alRight
    object sbxTraitements: TScrollBox
      AlignWithMargins = True
      Left = 9
      Top = 194
      Width = 163
      Height = 77
      Margins.Left = 9
      Margins.Top = 0
      Margins.Right = 9
      Margins.Bottom = 8
      VertScrollBar.Style = ssFlat
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      object xpbTraitements: TJvXPBar
        Left = 0
        Top = 0
        Width = 163
        Height = 2
        Caption = 'Traitement(s)'
        Colors.GradientFrom = 15116940
        Colors.GradientTo = 14452580
        Colors.SeparatorColor = 14215660
        Items = <>
        HeaderHeight = 0
        OwnerDraw = False
        ShowRollButton = False
        ShowItemFrame = False
        RoundedItemFrame = 0
        TopSpace = 0
        Align = alTop
        OnMouseDown = xpbTraitementsMouseDown
      end
    end
    object xpbEntetesTraitements: TJvXPBar
      AlignWithMargins = True
      Left = 9
      Top = 159
      Width = 163
      Height = 35
      Margins.Left = 9
      Margins.Top = 8
      Margins.Right = 9
      Margins.Bottom = 0
      Caption = 'Traitement(s)'
      Colors.GradientFrom = 15116940
      Colors.GradientTo = 14452580
      Colors.SeparatorColor = 14215660
      Items = <>
      OwnerDraw = False
      ShowRollButton = False
      ShowItemFrame = False
      RoundedItemFrame = 0
      Align = alTop
      Anchors = []
    end
    object xpbAccesBD: TJvXPBar
      AlignWithMargins = True
      Left = 9
      Top = 8
      Width = 163
      Height = 135
      Margins.Left = 9
      Margins.Top = 8
      Margins.Right = 9
      Margins.Bottom = 8
      Colors.GradientFrom = 15116940
      Colors.GradientTo = 14452580
      Colors.SeparatorColor = 14215660
      Items = <
        item
          Action = actAccesBDConnexion
        end
        item
          Action = actAccesBDDeconnexion
        end
        item
          Caption = ' '
          Enabled = False
        end
        item
          Action = actAccesBDParametres
        end>
      OwnerDraw = False
      ImageList = limOutils
      ItemHeight = 23
      ShowRollButton = False
      ShowItemFrame = True
      RoundedItemFrame = 0
      Align = alTop
      object bvlSeparateur_2: TBevel
        Left = 0
        Top = 136
        Width = 153
        Height = 9
        Shape = bsBottomLine
      end
      object bvlSeparateur_1: TBevel
        Left = 0
        Top = 88
        Width = 153
        Height = 9
        Shape = bsBottomLine
      end
    end
  end
  object pnlTitre: TPIPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 25
    Align = alTop
    Alignment = taRightJustify
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    Degrade.Actif = True
    Degrade.CouleurDepart = 12937777
    Degrade.Direction = dirGaucheVersDroite
    Degrade.CouleurFin = clBlack
    Degrade.Orientation = gdHorizontal
    CoinsRonds = False
    PropagationEtat = False
  end
  object mnuMenuPrincipale: TJvMainMenu
    Style = msXP
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 680
    Top = 256
  end
  object pmnuMenuContextuel: TPopupMenu
    Left = 808
    Top = 256
  end
  object prRecapitulatif: TPReport
    FileName = 'default.pdf'
    CreationDate = 39281.653711597220000000
    UseOutlines = False
    ViewerPreference = []
    Left = 704
    Top = 384
  end
  object limOutils: TImageList
    Left = 664
    Top = 320
    Bitmap = {
      494C010103000500100010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A9EC6008486840084A6AD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A9EC6008486840084A6AD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8E940073CFE7005A717B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8E940073CFE7005A717B000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004A9EC6008486840084A6
      AD0000000000000000000000000000000000738E94005AB6E70042799C000000
      000000000000000000000000000000000000000000004A9EC6008486840084A6
      AD0000000000000000000000000000000000738E94005AB6E70042799C000000
      0000000000000000000000000000000000000000000000000000C6BEBD00B5B6
      B500E7E7E700F7F7F700FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006BAEBD0073C7D6004A61
      6B000000000000000000000000000000000063696B0029799C0029719C007B61
      63009C696B00000000000000000000000000000000006BAEBD0073C7D6004A61
      6B000000000000000000000000000000000063696B0029799C0029719C007B61
      63009C696B00000000000000000000000000000000000000000094693900C661
      3100AD4910006B2000007B716B00D6D7D600EFEFEF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000528694005ABEF7004269
      8C0073616300000000009C717300AD717300AD696B0052868C0073CFE7008C71
      7B00D68684008C616300000000000000000000000000528694005ABEF7000030
      DE0073616300000000009C717300AD717300AD696B0052868C0073CFE7008C71
      7B00D68684000030DE000000000000000000000000000000000094592100D6A6
      8400FFEFCE00FFF7CE00FFD7AD00DE864A009C3808006B514A00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002186B5002971
      94006B494A009C696B00D6868400DE8E8C00C6797B006B717B0084DFEF009486
      8C00DE8E8C00AD7173008C8E8C000000000000000000000000002186B5000030
      DE000030DE009C696B00D6868400DE8E8C00C6797B006B717B0084DFEF009486
      8C000030DE00AD7173008C8E8C00000000000000000000000000AD612100E7BE
      A500FFE7CE00FFE7C600FFDFB500FFDFB500FFDF7B0073280000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD717300528EA50073D7
      FF0063595A00A5696B00D6868400D6868400D68684007B616300C6CFCE00B58E
      8C00D6868400BD797B0094797B000000000000000000AD717300528EA50073D7
      FF000030DE000030DE00D6868400D6868400D68684007B6163000030DE000030
      DE00D6868400BD797B0094797B00000000000000000000000000BD692900EFCF
      B500FFF7D600109ECE00BDD7C600FFC76300FFEFCE006B200000F7F7F700FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BD797B008C86840084DF
      EF0073969C009C696B00C6797B00C6797B009C696B00A5696B00CE8E8C00CE96
      9400CE969400C68E8C00948684000000000000000000BD797B008C86840084DF
      EF0073969C000030DE000030DE00C6797B009C696B000030DE000030DE00CE96
      9400CE969400C68E8C0094868400000000000000000000000000C6712900FFE7
      D600109ECE00FFF7D600109ECE00ADA69C00DEA66B00F7B66B00CEA68C00E7E7
      E700FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD7173009C696B00949E
      9C00A5A6A5009C696B009C696B00CE8E8C00DEA6A500E7AEAD00DEA6A500DEA6
      A500DEA6A500C68E8C009C8684000000000000000000AD7173009C696B00949E
      9C00A5A6A5009C696B000030DE000030E7000030DE000030E700DEA6A500DEA6
      A500DEA6A500C68E8C009C868400000000000000000000000000CE712100FFF7
      EF00FFFFEF00FFF7E70029AECE00FFF7CE00FFDFBD00BD691800FFEFCE00F7C7
      8C008C8E9400DEDFE700FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5696B00A5696B00AD71
      7300CE9E9C00DEB6B500EFBEBD00EFB6B500DEA6A500E7A6A500EFAEAD00EFAE
      AD00DEAEAD00B58684008C8E8C000000000000000000A5696B00A5696B00AD71
      7300CE9E9C00DEB6B500EFBEBD000030E7000030E7000030DE000030DE00EFAE
      AD00DEAEAD00B58684008C8E8C00000000000000000000000000DE712100FFFF
      FF00FFFFF700FFF7EF00EFEFE7009CCFD600FFF7E7006B412100FFFFFF00F7EF
      DE002149C6009C9ED600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AD797B00EFD7D600FFEF
      EF00FFE7E700EFCFCE00E7C7C600EFC7C600F7C7C600EFBEBD00E7AEAD00EFAE
      AD00CE9E9C009C868400000000000000000000000000AD797B00EFD7D600FFEF
      EF00FFE7E700EFCFCE000030DE000030EF00F7C7C600F7C7C6000030F7000030
      DE00CE9E9C009C86840000000000000000000000000000000000DE711800FFFF
      FF00FFFFFF00FFFFF700FFFFEF000096CE00FFFFEF0073492100FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5868400DECFCE00FFF7
      F700FFF7F700FFE7E700EFCFCE00EFD7D600F7CFCE00F7C7C600F7C7C600DEAE
      AD009C86840000000000000000000000000000000000B5868400DECFCE00FFF7
      F700FFF7F7000030F7000030EF00EFD7D600F7CFCE00F7C7C600F7C7C6000030
      F7009C8684000000000000000000000000000000000000000000DE792900BD61
      2900D69E7B00EFDFDE00FFFFFF00FFFFFF00FFFFFF0073513100FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B58E8C00CEAE
      AD00EFDFDE00FFEFEF00FFEFEF00FFE7E700EFC7C600EFB6B5009C8684009C86
      8400000000000000000000000000000000000000000000000000B58E8C00CEAE
      AD000030FF000030EF00FFEFEF00FFE7E700EFC7C600EFB6B5009C8684009C86
      84000030F7000000000000000000000000000000000000000000FFCF7B00E779
      1000D6610000CE510000BD410000B5380000BD51100084695A00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD9E
      9C00C6AEAD00CEB6B500C6AEAD00BDA6A500BDA6A5009C8684008C8684007371
      7300000000000000000000000000000000000000000000000000000000000030
      F7000030F700CEB6B500C6AEAD00BDA6A500BDA6A5009C8684008C8684007371
      7300000000000030F70000000000000000000000000000000000FFFFFF00F7F7
      F700D6D7D600ADB6AD00ADA68400CEAE6B00EFA64A008C716300FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000030
      F70000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF1FFF1FFFFF0000FF1FFF1FC7FF0000
      8F1F8F1FC07F00008F078F07C01F000084038403C01F0000C001C001C01F0000
      80018001C00F000080018001C003000080018001C001000080018001C0010000
      80038003C01F000080078007C01F0000C00FC007C01F0000E00FE00BC01F0000
      FF0FEF0FFFFF0000FF0FFF0FFFFF000000000000000000000000000000000000
      000000000000}
  end
  object lacOutils: TActionList
    Images = limOutils
    Left = 624
    Top = 152
    object actAccesBDConnexion: TAction
      Caption = 'Connexion'
      ImageIndex = 0
      OnExecute = actAccesBDConnexionExecute
    end
    object actAccesBDDeconnexion: TAction
      Caption = 'D'#233'connexion'
      Enabled = False
      ImageIndex = 1
      OnExecute = actAccesBDDeconnexionExecute
    end
    object actAccesBDParametres: TAction
      Caption = 'Param'#232'tres'
      ImageIndex = 2
      OnExecute = actAccesBDParametresExecute
    end
  end
end
