inherited frGoed: TfrGoed
  inherited wzDonnees: TJvWizard
    inherited wipBienvenue: TJvWizardInteriorPage
      inherited spl1: TJvNetscapeSplitter
        ExplicitTop = 432
        ExplicitWidth = 350
        RestorePos = 205
      end
    end
    inherited wipPraticiens: TJvWizardInteriorPage
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited wipOrganismes: TJvWizardInteriorPage
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited wipClients: TJvWizardInteriorPage
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited wipProduits: TJvWizardInteriorPage
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited wipEnCours: TJvWizardInteriorPage
      Enabled = True
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited wipAutresDonnees: TJvWizardInteriorPage
      Enabled = True
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    inherited wipRecapitulatif: TJvWizardInteriorPage
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object wipProgrammesFidelites: TJvWizardInteriorPage [9]
      Header.Height = 50
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Title'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = ANSI_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'MS Sans Serif'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = ANSI_CHARSET
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'MS Sans Serif'
      Header.Subtitle.Font.Style = [fsBold]
      Header.Subtitle.Text = ''
      Header.ShowDivider = False
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'Programmes Fid'#233'lit'#233's'
      OnLastButtonClick = PagePrecSuiv
      OnNextButtonClick = PagePrecSuiv
      ExplicitLeft = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grdProgrammesFidelites: TPIStringGrid
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
            Fixe = False
            Police.Charset = DEFAULT_CHARSET
            Police.Color = clWindowText
            Police.Height = -11
            Police.Name = 'MS Sans Serif'
            Police.Style = []
            Indicateur = False
            Nom = 'INDICATEUR'
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
            Nom = 'DONNEES'
            Options = [ocExport, ocImpression]
            LectureSeule = False
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
            LectureSeule = False
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
            LectureSeule = False
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
            LectureSeule = False
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
            LectureSeule = False
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
            LectureSeule = False
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
            LectureSeule = False
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
  end
  inherited limOutils: TImageList
    Bitmap = {
      494C010103000500600010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    HostName = '127.0.0.1'
    Port = 5432
    User = 'postgres'
    Password = 'postgres'
    Protocol = 'postgresql'
    LibraryLocation = 'libpq.dll'
    Left = 48
    Top = 32
  end
  object ZSQLProc: TZSQLProcessor
    Params = <>
    Connection = ZConnection1
    Delimiter = ';'
    Left = 48
    Top = 80
  end
end
