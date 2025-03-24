object frmListeClients: TfrmListeClients
  Left = 426
  Top = 235
  BorderStyle = bsToolWindow
  ClientHeight = 322
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grdListeClients: TPIDBGrid
    Left = 0
    Top = 33
    Width = 496
    Height = 175
    Align = alClient
    Color = clInfoBk
    DataSource = dsListeClients
    DefaultDrawing = False
    DrawingStyle = gdsClassic
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = grdListeClientsDblClick
    MenuColonneActif = False
    StyleBordure = sbAucune
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
    Options2.PointSuspensionDonnees = True
    Options2.PointSuspensionTitre = False
    Options2.CoinsRonds = False
    Details = False
    HauteurEntetes = 17
    Entetes = <>
    SurAppliquerProprietesCellule = grdListeClientsSurAppliquerProprietesCellule
    MultiSelection.Active = False
    MultiSelection.Mode = mmsSelection
    Columns = <
      item
        Expanded = False
        FieldName = 'T_CLIENT_ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Alignment = taCenter
        Width = 75
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Alignment = taCenter
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
        FieldName = 'NOM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Alignment = taCenter
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
        FieldName = 'PRENOM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Title.Alignment = taCenter
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
        FieldName = 'DATE_DERNIERE_VISITE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
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
  object pnlRecherche: TPIPanel
    Left = 0
    Top = 0
    Width = 496
    Height = 33
    Align = alTop
    ParentBackground = False
    TabOrder = 0
    Visible = False
    Degrade.Actif = False
    Degrade.CouleurDepart = clWhite
    Degrade.Direction = dirHautVersBas
    Degrade.CouleurFin = 14079702
    Degrade.Orientation = gdVertical
    CoinsRonds = False
    PropagationEtat = False
    object lblCritere: TLabel
      Left = 8
      Top = 10
      Width = 67
      Height = 13
      Caption = 'NOM+Pr'#233'nom'
      Transparent = True
    end
    object btnChercher: TPISpeedButton
      Left = 464
      Top = 5
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76060000424D7606000000000000360000002800000014000000140000000100
        2000000000004006000000000000000000000000000000000000FFFFFF0FFFFF
        FF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFEFEFDFFFCFEFDFFFCFEFAFEFCFCFDFFFCFDFCFFFFFFFEFFFFFFFFFFFFFF
        FFF8FFFFFF96FFFFFF0FFFFFFF96D0E1D0FF287A28FF0D660DFF116B11FF126B
        12FF146B14FF126A15FF156E14FF187117FF1A731AFF147815FF137913FF0E75
        10FF087208FF047002FF006A01FF1F731FFFCFDFCFFFFFFFFF96FFFFFFF82888
        28FF137E13FF1B821BFF218721FF258825FF268926FF248924FF238B23FF238B
        23FF228B21FF179318FF149213FF0E950EFF0A9509FF049204FF028B01FF007A
        00FF1F721FFFFFFFFFFFFFFFFFFF0E840EFF1C8C1CFF289228FF2F962FFF3398
        33FF349934FF319931FF319A30FF319831FF299A29FF219D21FF1A9F19FF13A1
        13FF0DA60DFF08A407FF029D02FF008900FF006700FFFFFFFFFFFFFFFFFF148A
        14FF259325FF319831FF399D39FF3D9F3DFF3DA03DFF3BA03BFF39A139FFA4D4
        A4FFFFFFFFFF28A327FF20A51FFF18A918FF11AA11FF0BAB0BFF05A505FF0292
        02FF016B01FFFFFFFFFFFFFFFFFF188C18FF2E972EFF3A9D3AFF42A142FF46A3
        46FF45A445FF43A443FF3FA541FFFFFFFFFFFFFFFFFFFFFFFFFF24AB24FF1CAD
        1CFF15B015FF0EAF0EFF0AA909FF059505FF026E02FFFFFFFFFFFFFFFFFF1E8F
        1EFF369B36FF42A042FF49A449FF4CA64CFF4AA64AFF47A648FF44A745FF40A8
        42FFFFFFFFFFFFFFFFFFFFFFFFFF1EB11FFF18B218FF12B012FF0DA90DFF0B96
        0BFF067006FFFFFFFFFFFFFFFFFF259325FF3D9E3DFF48A348FF4EA64EFF50A8
        50FF4EA84EFF4BA74BFF47A847FF46A847FF3DAA3FFFFFFFFFFFFFFFFFFFFFFF
        FFFF1AB01AFF16AF16FF13A713FF109710FF0A710AFFFFFFFFFFFFFFFFFF2B95
        2BFF44A144FF4EA74EFF52A852FF53A953FF51A951FF4DA84DFF48A748FF46A8
        46FF40AA3DFF33AC33FFFFFFFFFFFFFFFFFFFFFFFFFF18AC18FF17A618FF1697
        14FF0F750FFFFFFFFFFFFFFFFFFF2B952BFF44A144FF4EA74EFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF18A618FF169815FF0F7411FFFFFFFFFFFFFFFFFF2B95
        2BFF44A144FF4EA74EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF18A518FF1698
        16FF0F7311FFFFFFFFFFFFFFFFFF329832FF4BA54BFF54A954FF56AA56FF55AA
        55FF52A852FF4EA74DFF49A649FF45A645FF3FA73FFF37A737FFFFFFFFFFFFFF
        FFFFFFFFFFFF1DA51CFF1CA11CFF1B961CFF157312FFFFFFFFFFFFFFFFFF379B
        37FF51A851FF57AB57FF59AB59FF57AA57FF53A852FF4FA750FF4CA64CFF48A6
        48FF42A642FFFFFFFFFFFFFFFFFFFFFFFFFF28A126FF24A024FF229F22FF2194
        21FF177116FFFFFFFFFFFFFFFFFF4DA64DFF6EB76EFF70B970FF6AB56AFF62AF
        62FF5BAB5AFF54A855FF50A750FF4CA74CFFFFFFFFFFFFFFFFFFFFFFFFFF35A1
        34FF2E9E2DFF2C9B2BFF2D972CFF2C8E2CFF1D711DFFFFFFFFFFFFFFFFFF52A8
        52FF79BD79FF7CBE7CFF71B971FF67B367FF60AE60FF5CAB5BFF57A857FFFFFF
        FFFFFFFFFFFFFFFFFFFF43A443FF3DA13DFF379E37FF329A32FF309730FF2C8D
        2CFF1D711DFFFFFFFFFFFFFFFFFF58AC58FF89C489FF8DC68DFF7FBF7FFF71B8
        71FF6AB46AFF64B164FF5EAE5EFFB5DAB5FFFFFFFFFF50A951FF4AA64BFF45A3
        45FF40A040FF3A9D3AFF349934FF2A8C2AFF186E18FFFFFFFFFFFFFFFFFF65B2
        65FF97CB97FF9ACD9AFF89C489FF7ABD7AFF72B972FF6DB66DFF68B368FF65B2
        66FF5DAF5FFF56AB57FF4FA851FF4CA74DFF4AA44AFF43A143FF379A37FF288B
        28FF156B15FFFFFFFFFFFFFFFFFF76BB76FF90C890FF94CA94FF85C285FF75BB
        75FF6EB76EFF68B468FF66B266FF66B166FF64B264FF55AC58FF52A954FF4FA6
        4EFF49A549FF3FA03FFF329832FF238923FF307E30FFFFFFFFEFFFFFFF8FDCED
        DCFF73B973FF60B060FF55AA55FF4DA64DFF48A348FF42A042FF44A144FF44A2
        44FF45A145FF3C9D3BFF349A34FF339A33FF309831FF289429FF1F8D1FFF348F
        34FFD2E3D2FFFFFFFF8FFFFFFF0FFFFFFF8FFFFFFFEFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF96FFFFFF0F}
      OnClick = btnChercherClick
      Fleche = False
    end
    object edtCritere: TEdit
      Left = 88
      Top = 6
      Width = 377
      Height = 21
      TabOrder = 0
      OnKeyDown = edtCritereKeyDown
    end
  end
  object pnlDetailsClient: TPIPanel
    Left = 0
    Top = 208
    Width = 496
    Height = 114
    Align = alBottom
    ParentBackground = False
    TabOrder = 2
    Degrade.Actif = False
    Degrade.CouleurDepart = clWhite
    Degrade.Direction = dirHautVersBas
    Degrade.CouleurFin = 14079702
    Degrade.Orientation = gdVertical
    CoinsRonds = False
    PropagationEtat = False
    ExplicitTop = 214
    object lblOrganismeAMO: TLabel
      Left = 16
      Top = 12
      Width = 77
      Height = 13
      Caption = 'Organisme AMO'
      Transparent = True
    end
    object lblOrganismeAMC: TLabel
      Left = 16
      Top = 80
      Width = 76
      Height = 13
      Caption = 'Organisme AMC'
      Transparent = True
    end
    object lblDerniereDateFinDroitAMO: TLabel
      Left = 16
      Top = 37
      Width = 128
      Height = 13
      Caption = 'Derniere date fin droit AMO'
      Transparent = True
    end
    object bvlSeparateur_1: TBevel
      Left = 8
      Top = 56
      Width = 481
      Height = 9
      Shape = bsBottomLine
    end
    object edtOrganismeAMO: TDBEdit
      Left = 152
      Top = 8
      Width = 329
      Height = 21
      DataField = 'ORGANISME_AMO'
      DataSource = dsListeClients
      TabOrder = 0
    end
    object edtOrganismeAMC: TDBEdit
      Left = 152
      Top = 76
      Width = 329
      Height = 21
      DataField = 'ORGANISME_AMC'
      DataSource = dsListeClients
      TabOrder = 1
    end
    object edtDerniereDateFinDroitAMO: TDBEdit
      Left = 152
      Top = 34
      Width = 75
      Height = 21
      DataField = 'DERNIERE_DATE_FIN_DROIT_AMO'
      DataSource = dsListeClients
      TabOrder = 2
    end
  end
  object dsListeClients: TDataSource
    DataSet = dmModuleImportPHA.setListeClients
    Left = 192
    Top = 40
  end
end
