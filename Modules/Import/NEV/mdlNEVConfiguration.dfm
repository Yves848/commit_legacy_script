inherited frNEVConfiguration: TfrNEVConfiguration
  Width = 571
  Height = 200
  ExplicitWidth = 571
  ExplicitHeight = 200
  object gbxMasquesIdNat: TGroupBox
    Left = 0
    Top = 72
    Width = 571
    Height = 128
    Align = alClient
    Caption = 'Masques identifiants nationaux'
    TabOrder = 0
    Visible = False
    DesignSize = (
      571
      128)
    object SpeedButton1: TSpeedButton
      Left = 336
      Top = 8
      Width = 45
      Height = 22
      Caption = 'Aide'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 254
      Top = 8
      Width = 76
      Height = 22
      Caption = 'Automatique'
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 201
      Top = 8
      Width = 47
      Height = 22
      Caption = 'RAZ'
      OnClick = SpeedButton3Click
    end
    object grdDestinataires: TPIStringGrid
      Left = 0
      Top = 36
      Width = 393
      Height = 103
      Anchors = [akLeft, akTop, akRight, akBottom]
      DefaultRowHeight = 17
      DefaultDrawing = False
      DoubleBuffered = True
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
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
          Nom = 'Column4'
          Options = [ocExport, ocImpression]
          LectureSeule = False
          Titre.Alignement = taCenter
          Titre.Libelle = 'ID'
          Titre.Couleur = clBtnFace
          Titre.Police.Charset = DEFAULT_CHARSET
          Titre.Police.Color = clWindowText
          Titre.Police.Height = -11
          Titre.Police.Name = 'MS Sans Serif'
          Titre.Police.Style = []
          Visible = False
          Largeur = 64
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
          Titre.Libelle = 'Destinataire'
          Titre.Couleur = clBtnFace
          Titre.Police.Charset = DEFAULT_CHARSET
          Titre.Police.Color = clWindowText
          Titre.Police.Height = -11
          Titre.Police.Name = 'MS Sans Serif'
          Titre.Police.Style = []
          Visible = True
          Largeur = 203
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
          Titre.Libelle = 'D'#233'but'
          Titre.Couleur = clBtnFace
          Titre.Police.Charset = DEFAULT_CHARSET
          Titre.Police.Color = clWindowText
          Titre.Police.Height = -11
          Titre.Police.Name = 'MS Sans Serif'
          Titre.Police.Style = []
          Visible = True
          Largeur = 50
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
          Titre.Libelle = 'Fin'
          Titre.Couleur = clBtnFace
          Titre.Police.Charset = DEFAULT_CHARSET
          Titre.Police.Color = clWindowText
          Titre.Police.Height = -11
          Titre.Police.Name = 'MS Sans Serif'
          Titre.Police.Style = []
          Visible = True
          Largeur = 40
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
      Options2.CoinsRonds = True
      HauteurEntetes = 17
      Entetes = <>
      MenuEditionActif = True
      ColWidths = (
        15
        64
        203
        50
        40)
    end
  end
  object gbxCarteFi: TGroupBox
    Left = 0
    Top = 0
    Width = 571
    Height = 72
    Align = alTop
    Caption = 'Programme fid'#233'lit'#233
    TabOrder = 1
    ExplicitTop = 345
    object Label5: TLabel
      Left = 16
      Top = 44
      Width = 47
      Height = 13
      Caption = 'Avantage'
    end
    object Label6: TLabel
      Left = 16
      Top = 25
      Width = 32
      Height = 13
      Caption = 'Ojectif'
    end
    object cbxAvantage: TComboBox
      Left = 149
      Top = 44
      Width = 82
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = '% '
      Items.Strings = (
        '% '
        #8364
        'points'
        '')
    end
    object cbxCarteFi: TCheckBox
      Left = 254
      Top = 22
      Width = 148
      Height = 11
      Caption = 'Creer une carte fid'#233'lite'
      TabOrder = 1
    end
    object cbxDeclencheur: TComboBox
      Left = 149
      Top = 22
      Width = 82
      Height = 21
      ItemIndex = 0
      TabOrder = 2
      Text = #8364
      Items.Strings = (
        #8364
        'boites'
        'passages'
        'points')
    end
    object spnAvantage: TJvSpinEdit
      Left = 80
      Top = 44
      Width = 63
      Height = 21
      MaxValue = 1000.000000000000000000
      Value = 5.000000000000000000
      TabOrder = 3
    end
    object spnDeclenchement: TJvSpinEdit
      Left = 80
      Top = 22
      Width = 63
      Height = 21
      MaxValue = 1000.000000000000000000
      Value = 10.000000000000000000
      TabOrder = 4
    end
  end
end
