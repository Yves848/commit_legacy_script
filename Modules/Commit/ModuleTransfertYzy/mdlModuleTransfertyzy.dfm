inherited frModuleTransfertyzy: TfrModuleTransfertyzy
  AutoSize = True
  inherited wzDonnees: TJvWizard
    inherited wipBienvenue: TJvWizardInteriorPage
      Header.Title.Font.Charset = ANSI_CHARSET
      Header.Subtitle.Visible = True
      Header.Subtitle.Text = ''
      Header.Subtitle.Font.Charset = ANSI_CHARSET
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      Header.Subtitle.Text = ''
      Caption = 'Transfert des donn'#233'es'
      inherited spl1: TJvNetscapeSplitter
        Top = 226
        ExplicitTop = 368
        ExplicitWidth = 405
        RestorePos = 1
      end
      inherited PIPanel1: TPIPanel
        Top = 98
        ExplicitTop = 98
      end
    end
    inherited wipPraticiens: TJvWizardInteriorPage
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      ExplicitHeight = 375
      inherited grdPraticiens: TPIStringGrid
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
            Largeur = 64
          end>
        SurAppliquerProprietesCellule = GrilleSurAppliquerProprietesCellule
        ExplicitWidth = 242
        ExplicitHeight = 187
      end
    end
    inherited wipOrganismes: TJvWizardInteriorPage
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      Enabled = False
      ExplicitHeight = 375
      inherited grdOrganismes: TPIStringGrid
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
        SurAppliquerProprietesCellule = GrilleSurAppliquerProprietesCellule
        ExplicitWidth = 242
        ExplicitHeight = 187
      end
    end
    inherited wipClients: TJvWizardInteriorPage
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      ExplicitHeight = 375
      inherited grdClients: TPIStringGrid
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
        SurAppliquerProprietesCellule = GrilleSurAppliquerProprietesCellule
        ExplicitWidth = 242
        ExplicitHeight = 187
      end
    end
    inherited wipProduits: TJvWizardInteriorPage
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      ExplicitHeight = 375
      inherited grdProduits: TPIStringGrid
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
        SurAppliquerProprietesCellule = GrilleSurAppliquerProprietesCellule
        ExplicitWidth = 242
        ExplicitHeight = 187
      end
    end
    inherited wipEnCours: TJvWizardInteriorPage
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      Enabled = True
      ExplicitHeight = 375
      inherited grdEnCours: TPIStringGrid
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
        SurAppliquerProprietesCellule = GrilleSurAppliquerProprietesCellule
        ExplicitWidth = 242
        ExplicitHeight = 187
      end
    end
    inherited wipAutresDonnees: TJvWizardInteriorPage
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      Enabled = True
      ExplicitHeight = 375
      inherited grdAutresDonnees: TPIStringGrid
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
        SurAppliquerProprietesCellule = GrilleSurAppliquerProprietesCellule
        ExplicitWidth = 242
        ExplicitHeight = 187
      end
    end
    inherited wipRecapitulatif: TJvWizardInteriorPage
      Header.Title.Font.Charset = ANSI_CHARSET
      Header.Subtitle.Color = clWindow
      Header.Subtitle.Visible = True
      Header.Subtitle.Text = ''
      Header.Subtitle.Alignment = taLeftJustify
      Header.Subtitle.Font.Charset = ANSI_CHARSET
      Header.Subtitle.Font.Color = clPurple
      Header.Subtitle.Font.Style = [fsBold]
      Header.Subtitle.Text = ''
      ExplicitHeight = 375
      inherited sbxRecapitulatif: TScrollBox
        Width = 242
        Height = 325
        ExplicitWidth = 242
        ExplicitHeight = 325
        inherited prpRecapitulatif: TPRPage
          inherited prlpRecapitulatif: TPRLayoutPanel
            inherited prlNonImportees: TPRLabel
              Left = 472
              Caption = 'Non-transf'#233'r'#233'es'
              ExplicitLeft = 472
            end
            inherited prlImportees: TPRLabel
              Width = 69
              FontColor = clPurple
              Caption = 'Transf'#233'r'#233'es'
              ExplicitWidth = 69
            end
          end
        end
      end
    end
    inherited rmnDonnees: TJvWizardRouteMapNodes
      NodeColors.Selected = clPurple
    end
  end
  inherited xpcOutils: TJvXPContainer
    Color = clWindow
    inherited sbxTraitements: TScrollBox
      Top = 386
      Height = 211
      ExplicitTop = 386
      ExplicitHeight = 211
    end
    inherited xpbEntetesTraitements: TJvXPBar
      Top = 351
      ExplicitTop = 351
    end
    inherited xpbAccesBD: TJvXPBar
      Top = 154
      Height = 181
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
        end
        item
          Caption = ' '
        end
        item
          Action = actAccesLGPIInitialisation
        end>
      ExplicitTop = 154
      ExplicitHeight = 181
      inherited bvlSeparateur_2: TBevel
        Left = 4
        ExplicitLeft = 4
      end
      inherited bvlSeparateur_1: TBevel
        Left = 5
        ExplicitLeft = 5
      end
    end
    object xpbKitMigration: TJvXPBar
      AlignWithMargins = True
      Left = 9
      Top = 8
      Width = 163
      Height = 135
      Margins.Left = 9
      Margins.Top = 8
      Margins.Right = 9
      Caption = 'Kit migration'
      Colors.GradientFrom = 15116940
      Colors.GradientTo = 14452580
      Colors.SeparatorColor = 14215660
      Items = <
        item
          Action = actKitMigrationInstallation
        end
        item
          Action = actKitMigrationVisualisation
        end
        item
          Caption = ' '
          Enabled = False
        end
        item
          Action = actKitMigrationAfficherErreurs
        end>
      OwnerDraw = False
      ImageList = limOutils
      ItemHeight = 23
      ShowRollButton = False
      ShowItemFrame = True
      RoundedItemFrame = 0
      Align = alTop
      object bvlSeparateur_3: TBevel
        Left = 0
        Top = 88
        Width = 153
        Height = 9
        Shape = bsBottomLine
      end
    end
  end
  inherited mnuMenuPrincipale: TJvMainMenu
    Left = 376
    Top = 136
  end
  inherited pmnuMenuContextuel: TPopupMenu
    OwnerDraw = True
    Left = 232
    Top = 192
  end
  inherited prRecapitulatif: TPReport
    Left = 320
    Top = 368
  end
  inherited limOutils: TImageList
    Bitmap = {
      494C010106001000300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000636163006361630063616300636163000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7F7
      D600FFEFC600FFE7BD00FFE7B500FFEFC600FFFFD600B5B69C006B696B000000
      0000000000000000000000000000000000000000000000000000C6BEBD00B5B6
      B500E7E7E700F7F7F700FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7CF8C00FFEF
      CE00FFEFBD00FFDFAD00FFDFAD00FFF7CE00FFE7B500FFEFC600FFF7CE00D6C7
      A50000000000000000000000000000000000000000000000000094693900C661
      3100AD4910006B2000007B716B00D6D7D600EFEFEF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFB66B00FFF7
      D600FFE7B500FFDFAD00FFD7A500009E000042B64200009E0000CEEFC600FFFF
      D600DEDFC600000000000000000000000000000000000000000094592100D6A6
      8400FFEFCE00FFF7CE00FFD7AD00DE864A009C3808006B514A00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F7B67300F7B6
      7300FFEFC600FFEFC600FFD7A500009E0000009E0000009E0000009E0000DEF7
      D600FFFFDE006B696B0000000000000000000000000000000000AD612100E7BE
      A500FFE7CE00FFE7C600FFDFB500FFDFB500FFDF7B0073280000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFC78400F7BE8400F7BE
      8400F7BE8400F7BE8400FFCF9400009E0000009E0000ADDFA500FFFFEF00109E
      1000FFCF9C006B696B0000000000000000000000000000000000BD692900EFCF
      B500FFF7D600109ECE00BDD7C600FFC76300FFEFCE006B200000F7F7F700FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFCF9C00FFCF9400FFCF
      9400FFCF9400FFCF9400FFF7DE00FFF7CE00FFFFEF00BDE7BD00FFFFFF00FFFF
      EF00FFDFB5007371730000000000000000000000000000000000C6712900FFE7
      D600109ECE00FFF7D600109ECE00ADA69C00DEA66B00F7B66B00CEA68C00E7E7
      E700FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFD7A500FFD7A500FFD7
      A500FFD7A500FFD7A500FFE7B5008CD78400FFFFD60031AE3100009E000042B6
      4200FFDFAD00BDBEA50000000000000000000000000000000000CE712100FFF7
      EF00FFFFEF00FFF7E70029AECE00FFF7CE00FFDFBD00BD691800FFEFCE00F7C7
      8C008C8E9400DEDFE700FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFE7B500FFE7B500FFE7
      B500FFE7B500FFE7B500FFE7B50031AE310021A6210042B64200009E000042B6
      4200FFE7B500FFEFC60000000000000000000000000000000000DE712100FFFF
      FF00FFFFF700FFF7EF00EFEFE7009CCFD600FFF7E7006B412100FFFFFF00F7EF
      DE002149C6009C9ED600FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7CE00FFF7CE00FFF7
      CE00FFF7CE00FFF7CE00FFF7CE00FFF7CE0021A62100009E0000009E000042B6
      4200FFF7D600FFF7CE0000000000000000000000000000000000DE711800FFFF
      FF00FFFFFF00FFFFF700FFFFEF000096CE00FFFFEF0073492100FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFDFAD00FFFFDE00FFFFDE00FFFF
      DE00FFFFDE00FFFFDE00FFFFDE00FFFFDE00FFFFDE00FFFFE700FFFFE700CEEF
      C600FFFFFF00FFFFDE006B696B00000000000000000000000000DE792900BD61
      2900D69E7B00EFDFDE00FFFFFF00FFFFFF00FFFFFF0073513100FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFDFAD00FFFFDE00FFFFDE00FFFF
      DE00FFFFDE00FFFFDE00FFF7D600FFD7A500F7C78C00F7CF8C00FFEFBD00FFFF
      DE00FFFFDE00FFFFDE006B696B00000000000000000000000000FFCF7B00E779
      1000D6610000CE510000BD410000B5380000BD51100084695A00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFDFC600FFE7B500FFDF
      C600FFDFC600F7C78C00EFB66B00EFB66B00F7BE7300F7BE7B00F7BE7B00FFC7
      8400FFCF8C00FFFFDE006B696B00000000000000000000000000FFFFFF00F7F7
      F700D6D7D600ADB6AD00ADA68400CEAE6B00EFA64A008C716300FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7D7B500F7BE7B00FFC78400FFC7
      8C00FFC78C00FFCF94006B696B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFDFB500FFC7
      8C00FFCF9400FFCF9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A9EC6008486840084A6AD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A9EC6008486840084A6AD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848684005A59
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8E940073CFE7005A717B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8E940073CFE7005A717B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006B696B00EFEFEF00DEDF
      DE00949694004A494A00292829004A494A0073515200C6969400CEA6A5007351
      520021202100000000000000000000000000000000004A9EC6008486840084A6
      AD0000000000000000000000000000000000738E94005AB6E70042799C000000
      000000000000000000000000000000000000000000004A9EC6008486840084A6
      AD0000000000000000000000000000000000738E94005AB6E70042799C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C7C600EFE7E700FFF7
      EF00FFFFF700FFEFE700FFD79C00D68E8400FFB6B500FFC7C600FFD7D600FFEF
      EF00EFE7E700312829000000000000000000000000006BAEBD0073C7D6004A61
      6B000000000000000000000000000000000063696B0029799C0029719C007B61
      63009C696B00000000000000000000000000000000006BAEBD0073C7D6004A61
      6B000000000000000000000000000000000063696B0029799C0029719C007B61
      63009C696B0000000000000000000000000000000000000000006B696B006B61
      6B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D7D600B5B6B500EFE7DE00CEDF
      B500009E0000009E0000B5797300FF9E9C00FFA6A500FFB6B500FFC7C600FFEF
      EF00FFFFFF00E7DFDE00212021000000000000000000528694005ABEF7000030
      DE0073616300000000009C717300AD717300AD696B0052868C0073CFE7008C71
      7B00D68684000030DE00000000000000000000000000528694005ABEF7004269
      8C0073616300000000009C717300AD717300AD696B0052868C0073CFE7008C71
      7B00D68684008C616300000000000000000000000000000000003196F7004A69
      A5006B616B000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D7D600E7E7E700EFDFD600D6DF
      AD0029C74200009E0000FFC7C600FFB6B500FF9E9C00FFC7DE00FFCFF700FFFF
      FF00FFFFFF00FFFFFF00735152000000000000000000000000002186B5000030
      DE000030DE009C696B00D6868400DE8E8C00C6797B006B717B0084DFEF009486
      8C000030DE00AD7173008C8E8C000000000000000000000000002186B5002971
      94006B494A009C696B00D6868400DE8E8C00C6797B006B717B0084DFEF009486
      8C00DE8E8C00AD7173008C8E8C0000000000000000000000000063BEF70042AE
      FF004A69A5006B616B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6D7D600E7E7E700EFDFD600D6DF
      AD004AEF7300009E0000FFD7D600FFC7C600FFBEBD00EFA6B500B5797300FFFF
      FF00F7EFEF00F7EFEF00C6AEAD00B59E9C0000000000AD717300528EA50073D7
      FF000030DE000030DE00D6868400D6868400D68684007B6163000030DE000030
      DE00D6868400BD797B0094797B000000000000000000AD717300528EA50073D7
      FF0063595A00A5696B00D6868400D6868400D68684007B616300C6CFCE00B58E
      8C00D6868400BD797B0094797B000000000000000000000000000000000063BE
      F7003196F7004A69A5006B616B00000000006B616B006B616B00000000000000
      000000000000000000000000000000000000D6D7D600EFEFEF00F7E7CE00DEE7
      AD005AF794003196F700FFCFCE00FFCFCE00FFD7D600D6AEAD00F7D7AD00FFD7
      DE00FFBEB500F7CFCE00D6B6AD00B59E9C0000000000BD797B008C86840084DF
      EF0073969C000030DE000030DE00C6797B009C696B000030DE000030DE00CE96
      9400CE969400C68E8C00948684000000000000000000BD797B008C86840084DF
      EF0073969C009C696B00C6797B00C6797B009C696B00A5696B00CE8E8C00CE96
      9400CE969400C68E8C0094868400000000000000000000000000000000000000
      000063BEF70042AEFF0084868400AD867B00EFD7AD00F7EFC600C6A6A5006B61
      6B0000000000000000000000000000000000D6D7D600EFEFF700F7E7CE00D6C7
      BD003196F7003196F700FFCFC600FFF7F700FFFFFF00FFE7FF00FFC7DE00FFE7
      E700FF9E9C00FFB6B500CE9694000000000000000000AD7173009C696B00949E
      9C00A5A6A5009C696B000030DE000030E7000030DE000030E700DEA6A500DEA6
      A500DEA6A500C68E8C009C8684000000000000000000AD7173009C696B00949E
      9C00A5A6A5009C696B009C696B00CE8E8C00DEA6A500E7AEAD00DEA6A500DEA6
      A500DEA6A500C68E8C009C868400000000000000000000000000000000000000
      00000000000000000000DEAE9400FFFFC600FFFFD600FFFFE700FFFFFF00EFE7
      C6006B616B00000000000000000000000000D6D7DE00F7860000F7E7CE00FFCF
      9C00FFCF9400F7CF9C00B5797B00FFFFFF00FFFFFF00FFEFEF00FFC7C600FFB6
      B500FF9E9C00FFA6A500735152000000000000000000A5696B00A5696B00AD71
      7300CE9E9C00DEB6B500EFBEBD000030E7000030E7000030DE000030DE00EFAE
      AD00DEAEAD00B58684008C8E8C000000000000000000A5696B00A5696B00AD71
      7300CE9E9C00DEB6B500EFBEBD00EFB6B500DEA6A500E7A6A500EFAEAD00EFAE
      AD00DEAEAD00B58684008C8E8C00000000000000000000000000000000000000
      000000000000D6B6A500FFFFC600FFEFB500FFFFD600FFFFEF00FFFFFF00FFFF
      DE0063494A00000000000000000000000000D6DFDE00DE710000F7E7CE00FFC7
      7B00FFC77B00FFC77B00FFC77B00CEB6B500FFFFFF00FFE7E700FFD7D600FFC7
      C600FFB6B500D68E8400000000000000000000000000AD797B00EFD7D600FFEF
      EF00FFE7E700EFCFCE000030DE000030EF00F7C7C600F7C7C6000030F7000030
      DE00CE9E9C009C868400000000000000000000000000AD797B00EFD7D600FFEF
      EF00FFE7E700EFCFCE00E7C7C600EFC7C600F7C7C600EFBEBD00E7AEAD00EFAE
      AD00CE9E9C009C86840000000000000000000000000000000000000000000000
      0000000000008C8E8C00FFF7C600FFE7B500FFFFCE00FFFFE700FFFFE700FFFF
      D600B58E8400000000000000000000000000D6DFDE00BDBEBD00FFDFB500FFAE
      2900FFAE3900FFAE3900FFB64A00FFBE5A00B5868400F7E7E700FFE7E700FFCF
      CE00B586840000000000000000000000000000000000B5868400DECFCE00FFF7
      F700FFF7F7000030F7000030EF00EFD7D600F7CFCE00F7C7C600F7C7C6000030
      F7009C86840000000000000000000000000000000000B5868400DECFCE00FFF7
      F700FFF7F700FFE7E700EFCFCE00EFD7D600F7CFCE00F7C7C600F7C7C600DEAE
      AD009C8684000000000000000000000000000000000000000000000000000000
      000000000000C6A6A500FFFFCE00FFDFAD00FFF7BD00FFFFCE00FFFFCE00FFFF
      CE006B595A00000000000000000000000000DEDFDE00E7E7E700FFDFB500FFFF
      FF00F7F7FF00EFF7FF00E7E7E700E7DFD600EFC78C00EFAE4A00EF9E29003128
      29004A494A000000000000000000000000000000000000000000B58E8C00CEAE
      AD000030FF000030EF00FFEFEF00FFE7E700EFC7C600EFB6B5009C8684009C86
      84000030F7000000000000000000000000000000000000000000B58E8C00CEAE
      AD00EFDFDE00FFEFEF00FFEFEF00FFE7E700EFC7C600EFB6B5009C8684009C86
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F7E7BD00FFFFFF00FFE7B500FFDFAD00FFEFB500FFD7
      A5006B616B00000000000000000000000000DEDFDE00E7E7E700A5717300A571
      7300B5797B00CEA6A500DEC7C600E7DFDE00E7E7E700DEDFDE00D6D7DE00C6C7
      C600000000000000000000000000000000000000000000000000000000000030
      F7000030F700CEB6B500C6AEAD00BDA6A500BDA6A5009C8684008C8684007371
      7300000000000030F7000000000000000000000000000000000000000000AD9E
      9C00C6AEAD00CEB6B500C6AEAD00BDA6A500BDA6A5009C8684008C8684007371
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7B69400FFF7C600FFEFBD00E7B694006B61
      6B0000000000000000000000000000000000BDBEBD00EFEFF700FFBE6300FFCF
      9400E7B69400DEAE9400CE9E9400CE969400EFDFDE00FFF7F700FFEFEF002120
      2100000000000000000000000000000000000000000000000000000000000030
      F70000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7EFEF00FFCF8C00FFCF9400FFCF
      9C00FFCFA500FFCFAD00FFCFB500FFCFC600BDA6A500FFEFEF00FFFFFF009496
      9400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A6A500FFFFFF008C8E8C007371
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CECFCE00CECFCE00D6C7BD00D6BE
      B500E7C7AD00EFC7B500F7C7BD00FFCFCE0094969400F7EFEF00DEDFDE00CECF
      CE0000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000F0FFC7FF00000000
      E01FC07F00000000C00FC01F00000000C007C01F00000000C003C01F00000000
      8003C00F000000008003C003000000008003C001000000008003C00100000000
      8003C01F000000000001C01F000000000001C01F000000008001C01F00000000
      FF01FFFF00000000FFC3FFFF00000000FF1FFF1FFFFFCFFFFF1FFF1FFFFF8007
      8F1F8F1FFFFF80038F078F07CFFF000184038403C7FF0001C001C001C3FF0000
      80018001E13F000080018001F00F000180018001FC07000180018001F8070003
      80038003F807000780078007F8070007C007C00FFC07000FE00BE00FFE0F000F
      EF0FFF0FFFFF000FFF0FFF0FFFFF000F00000000000000000000000000000000
      000000000000}
  end
  inherited lacOutils: TActionList
    Left = 536
    Top = 240
    object actKitMigrationVisualisation: TAction
      Category = 'Kit migration'
      Caption = 'Visualisation ...'
      ImageIndex = 2
    end
    object actKitMigrationInstallation: TAction
      Category = 'Kit migration'
      Caption = 'Installation ...'
      ImageIndex = 3
      OnExecute = actKitMigrationInstallationExecute
    end
    object actAccesLGPIInitialisation: TAction
      Category = 'Acc'#232's LGPI'
      Caption = 'Initialisation'
      Enabled = False
      OnExecute = actAccesLGPIInitialisationExecute
    end
    object actKitMigrationAfficherErreurs: TAction
      Category = 'Kit migration'
      Caption = 'Derni'#232're(s) erreur(s)'
    end
  end
end
