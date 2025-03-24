inherited frmIncoherence: TfrmIncoherence
  Left = 335
  Top = 238
  Caption = 'D'#233'tection des incoh'#233'rences'
  ClientHeight = 456
  ClientWidth = 705
  Constraints.MaxHeight = 500
  Constraints.MaxWidth = 746
  OnDestroy = FormDestroy
  ExplicitWidth = 711
  ExplicitHeight = 481
  PixelsPerInch = 96
  TextHeight = 13
  object pCtlIncohDonnees: TPageControl [0]
    Left = 0
    Top = 0
    Width = 705
    Height = 456
    ActivePage = tShPurgeProduits
    Align = alClient
    Images = iLstPageControl
    TabOrder = 0
    OnChanging = pCtlIncohDonneesChanging
    object tShIncohClients: TTabSheet
      Caption = 'Clients'
      object rgIncohClients: TRadioGroup
        Left = 8
        Top = 8
        Width = 681
        Height = 51
        Caption = 'Types d'#39'incoh'#233'rence'
        Columns = 2
        Items.Strings = (
          'Cl'#233' de num'#233'ro SS invalide')
        TabOrder = 0
        OnClick = rgIncoherenceClick
      end
      object grdPurgeClients: TPIDBGrid
        Left = 8
        Top = 72
        Width = 681
        Height = 313
        DataSource = dsClients
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        MenuColonneActif = False
        StyleBordure = sbDouble
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
        Details = False
        HauteurEntetes = 17
        Entetes = <>
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = False
        MultiSelection.Mode = mmsSelection
        Columns = <
          item
            Expanded = False
            FieldName = 'ACLIENTID'
            Title.Alignment = taCenter
            Width = 90
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
            FieldName = 'ANOM'
            Title.Alignment = taCenter
            Width = 200
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
            FieldName = 'APRENOM'
            Title.Alignment = taCenter
            Width = 150
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
            FieldName = 'ANUMEROINSEE'
            Title.Alignment = taCenter
            Width = 120
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
            FieldName = 'ADATEDERNIEREVISITE'
            Title.Alignment = taCenter
            Title.Caption = 'Dern. visite'
            Width = 79
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
    object tShPurgeProduits: TTabSheet
      Caption = 'Produits'
      ImageIndex = 1
      object rgIncohProduits: TRadioGroup
        Left = 8
        Top = 8
        Width = 713
        Height = 85
        Caption = 'Types d'#39'incoh'#233'rence'
        Columns = 2
        Items.Strings = (
          'Cl'#233' de code CIP invalide'
          'Prix de vente inf'#233'rieur aux prix d'#39'achat (tarif, pamp, remise)'
          'Produits en GS sans historique de vente')
        TabOrder = 0
        OnClick = rgIncoherenceClick
      end
      object grdPurgeProduits: TPIDBGrid
        Left = 8
        Top = 104
        Width = 681
        Height = 281
        DataSource = dsProduits
        DefaultDrawing = False
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        MenuColonneActif = False
        StyleBordure = sbDouble
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
        Details = False
        HauteurEntetes = 17
        Entetes = <>
        Impression = dmOutilsPHAPHA_fr.impDonnees
        MultiSelection.Active = False
        MultiSelection.Mode = mmsSelection
        Columns = <
          item
            Expanded = False
            FieldName = 'ACODECIP'
            Title.Alignment = taCenter
            Width = 60
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
            FieldName = 'ADESIGNATION'
            Title.Alignment = taCenter
            Width = 185
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
            FieldName = 'APRIXACHATCATALOGUE'
            Title.Alignment = taCenter
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
            FieldName = 'APRIXVENTE'
            Title.Alignment = taCenter
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
            FieldName = 'APAMP'
            Title.Alignment = taCenter
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
            FieldName = 'APRESTATION'
            Title.Alignment = taCenter
            Width = 30
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
            FieldName = 'ADATEDERNIEREVENTE'
            Title.Alignment = taCenter
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
          end
          item
            Expanded = False
            FieldName = 'ASTOCKTOTAL'
            Title.Alignment = taCenter
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
    end
  end
  inherited ilActions: TImageList
    Left = 440
    Top = 56
  end
  inherited alActionsSupp: TActionList
    Left = 152
    Top = 192
  end
  inherited alActionsStd: TActionList
    Tag = 1
    Left = 56
    Top = 208
    inherited actImprimer: TAction
      OnExecute = actImprimerExecute
    end
  end
  object dsClients: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setClients
    Left = 140
    Top = 296
  end
  object dsProduits: TDataSource
    DataSet = dmOutilsPHAPHA_fr.setProduits
    Left = 60
    Top = 298
  end
  object iLstPageControl: TImageList
    Left = 508
    Top = 56
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A4A4A004A4A4A004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000006B00002963290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5735200B5735200C6421800C642
      2100CE4A2900C64A29009C4A29008C5242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004A4A4A00CE6300009C3100009C310000732100005A3118004A4A4A004A4A
      4A00000000000000000000000000000000000000000000000000000000000000
      0000000000004A6B4A005A6B5A00000000000000000000000000000000000000
      000008A51800007B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6421800C6421800E75A3900F763
      4A00FF6B5A00EF634A00E75A3900EF5A42008C4A290063735A00397339003173
      3100297B290029732900316B31005A735A000000000000000000000000000000
      0000DE730000D66B0000B56B4A00EFDECE00E7C6BD00C68C73009C3908008421
      00004A4A4A000000000000000000000000000000000000000000426B39000873
      080010A5210010AD2100008408006B6B6B000000000000000000000000000000
      0000009C08002963290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CE4A2100CE4A2100FF735A00FF7B
      6300DE6B4200EFB58400DE7B4A00F7735A00E75A39007B8C390084BD730063AD
      5A0063C6630052C6520031B5310018941800000000000000000000000000EF84
      0000E77B0000DE730000BD7B5200F7E7DE00E7CEC600DEBDA500DEB59C00D6AD
      9400C69C9C00000000000000000000000000000000001873100052EF8C0039CE
      630018630800106B080052EF84000894100000000000000000000000000018A5
      3900008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6846300FF7B6300FF8C
      6B00DE8C5A00FFD69C00DE8C5A00EF7B5A00E75A39007BA55200C6DEB500D6E7
      C60073D6730063CE630042B54200188C1800000000000000000000000000F78C
      0000EF840000E77B0000BD7B6300F7E7E700DEB59C00BDB5AD00DEB5A500CE94
      7B00CEA59C000000000000000000000000000000000000000000000000000000
      00000000000000000000219C390029C64A001863180000840800009C0800009C
      0000296329000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A56342008C31
      18002121730021217B00A5524A00C65A310073B55A0084DE8400FFF7E700FFF7
      E7007BAD630063BD6300398C390000000000000000000000000000000000FF94
      0000EF840000E77B000063423100F7EFEF00D6CECE00EFD6C600B5A5B500DEBD
      A500CEA59C000000000000000000000000000000000000000000000000000000
      000000000000000000000000000039D66B0008AD180008A5180008A51000008C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000181818000808
      080010319400103194001018730063525A004AA54A0063BD630094ADB5004A8C
      B5006394A500318439000000000000000000000000000000000000000000FF94
      0000F78C0000EF84000018080800FFF7F700F7E7DE00EFDECE00E7CEBD00DEBD
      AD00CEADA5000000000000000000000000000000000000000000000000000000
      0000845A7300845A73000000000029C65A0010AD2100089C18005A6B5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001010100008101800184A
      A500185ABD00185ABD001852BD0010318C0000000000000000003194F7003194
      F7003194F7002994EF000000000000000000000000000000000000000000FF9C
      0800FF940000F7B56300FFFFF700FFDEB500DEAD8C00FFD69C005A3121006B52
      4A004A4A4A000000000000000000000000000000000000000000000000000000
      000031D66300106B100000000000108C210018B5310010AD29004A6B4A005A6B
      5A00086B08000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001818180010213100185A
      BD00216BCE00216BCE002163CE00104AAD0000000000529CCE0039A5FF0039A5
      FF00399CFF00399CFF00426B7B0000000000000000000000000000000000FFA5
      1800FF940000F7A53100FFFFFF00FFF7EF00FFDEBD00BD846B00CEA58C00CEA5
      8C004A4A4A000000000000000000000000000000000000000000000000000000
      00004AE77B00109C2900000000003163310018B5310018B5310010A5210010AD
      210008A51800426B420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003131310029292900215A
      A5003194F7003194F700298CF700216BCE000000000042A5E7004AB5FF0052B5
      FF004AB5FF004AADFF00298CCE0000000000000000000000000000000000FFAD
      2900FF9C0000FF940000EFD6C600EFBD9400CEA58C00DEB5A500DEB59C00D6A5
      94004A4A4A000000000000000000000000000000000000000000000000000000
      000042DE730029C6520018AD390021BD4A0029C6420021C6390018B52900088C
      080018BD3900086B080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000313131004A4A4A001829
      4200216BCE00297BE7003194F700216BC600000000004AA5E70052BDFF005ABD
      FF0052BDFF0052B5FF003194DE0000000000000000000000000000000000FFB5
      3900FFA51000FF9C0000F7EFEF00F7E7DE00217BB500738CA500D6AD9400D6AD
      9C004A4A4A000000000000000000000000000000000000000000000000000000
      0000108418005AF78C0052EF7B0031BD4A0010841800396B42006B6B6B000000
      000018B531000884100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A5A006B6B
      6B00A5A5A50084848400313131004A4A4A0000000000529CC6003994C6004A9C
      CE003194CE00298CCE00106B9C0000000000000000000000000000000000FFBD
      5200FFAD3100FFA51000FFF7F700F7EFE700EFDED600E7CEC600E7C6B500DEB5
      A5004A4A4A000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000021AD420039D66B0018BD3900396B
      3900088C100010A5210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424242007373
      73008C8C8C0084848400393939000000000000000000000000005AA5D6006BB5
      DE00ADD6EF0073B5D6004284A50000000000000000000000000000000000FFC6
      6300FFB53900FFA52100FFC67B00FFC67300F7D6B500EFCEA500E7C6BD00DEBD
      AD004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004ADE7B005AF7940031CE63003163
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009CC6DE008CBD
      D60084B5D6008CB5CE000000000000000000000000000000000000000000B563
      3100B5633100CE947300DEBDAD00DEBDAD00C68C6B00B56B4A00B56B4A00AD52
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029AD4200107310000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFF8FFFFF30000
      00FFF00FF9F300000000F007C0F300000000E00780E700008000E007FC070000
      C001E007FE0F0000C003E007F21F000080C3E007F20700008081E007F2030000
      8081E007F00300008081E007F0130000C081E007FF030000C1C1E007FF0F0000
      FFC3E00FFF9F0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
