inherited frDestinataire: TfrDestinataire
  Width = 629
  inherited Splitter: TSplitter
    Width = 629
  end
  inherited pnlCriteria: TPanel
    Width = 629
    inherited sBtnSearch: TPISpeedButton
      OnClick = sBtnSearchClick
    end
  end
  inherited dbGrdResult: TPIDBGrid
    Width = 629
    Columns = <
      item
        Expanded = False
        FieldName = 'NOM'
        Title.Alignment = taCenter
        Width = 210
        Visible = True
        Controle = ccAucun
      end
      item
        Expanded = False
        FieldName = 'FLUX'
        Title.Alignment = taCenter
        Visible = True
        Controle = ccAucun
      end
      item
        ButtonStyle = cbsNone
        Expanded = False
        FieldName = 'OCT'
        Title.Alignment = taCenter
        Visible = True
        Control = ccCheckBox
      end
      item
        Expanded = False
        FieldName = 'NORME_LIBELLE'
        Title.Alignment = taCenter
        Width = 95
        Visible = True
        Controle = ccAucun
      end
      item
        Expanded = False
        FieldName = 'NORME_RETOUR_LIBELLE'
        Title.Alignment = taCenter
        Width = 95
        Visible = True
        Controle = ccAucun
      end
      item
        Expanded = False
        FieldName = 'AUTHENTIFICATION'
        Title.Alignment = taCenter
        Visible = True
        Controle = ccAucun
      end>
  end
  inherited ScrollBox: TScrollBox
    Width = 629
    object lblNom: TLabel
      Left = 8
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Nom'
    end
    object lblNormes: TLabel
      Left = 8
      Top = 36
      Width = 47
      Height = 13
      Caption = 'NORMES'
    end
    object lblDestinataire: TLabel
      Left = 8
      Top = 64
      Width = 79
      Height = 13
      Caption = 'DESTINATAIRE'
    end
    object lblZoneMessage: TLabel
      Left = 8
      Top = 92
      Width = 70
      Height = 13
      Caption = 'Zone message'
    end
    object lblNormeAller: TLabel
      Left = 104
      Top = 36
      Width = 20
      Height = 13
      Caption = 'Aller'
    end
    object lblNormeRetour: TLabel
      Left = 280
      Top = 36
      Width = 32
      Height = 13
      Caption = 'Retour'
    end
    object lblDestNO: TLabel
      Left = 104
      Top = 64
      Width = 12
      Height = 13
      Caption = 'N'#176
    end
    object lblDestType: TLabel
      Left = 280
      Top = 64
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object lblDestApplication: TLabel
      Left = 368
      Top = 64
      Width = 52
      Height = 13
      Caption = 'Application'
    end
    object lblProtocole: TLabel
      Left = 480
      Top = 36
      Width = 45
      Height = 13
      Caption = 'Protocole'
    end
    object lblXSL: TLabel
      Left = 480
      Top = 92
      Width = 20
      Height = 13
      Caption = 'XSL'
    end
    object pCtrlDetailDest: TPageControl
      Left = 0
      Top = 109
      Width = 785
      Height = 222
      ActivePage = tShGeneral
      Align = alBottom
      Images = iLstDetailDest
      TabOrder = 0
      object tShGeneral: TTabSheet
        Caption = 'G'#233'n'#233'ralit'#233's'
        inline frViewDataAdresse: TfrViewDataAdresse
          Left = 8
          Top = 0
          Width = 385
          Height = 117
          AutoSize = True
          TabOrder = 0
          inherited edtRue1: TDBEdit
            DataField = 'RUE1'
            DataSource = dsResult
          end
          inherited edtRue2: TDBEdit
            DataField = 'RUE2'
            DataSource = dsResult
          end
          inherited edtCP: TDBEdit
            DataField = 'CP'
            DataSource = dsResult
          end
          inherited edtVille: TDBEdit
            DataField = 'NOMVILLE'
            DataSource = dsResult
          end
          inherited edtTelephone1: TDBEdit
            DataField = 'TELPERSONNEL'
            DataSource = dsResult
          end
          inherited edtMobile: TDBEdit
            DataField = 'TELMOBILE'
            DataSource = dsResult
          end
          inherited edtTelephone2: TDBEdit
            DataField = 'TELSTANDARD'
            DataSource = dsResult
          end
          inherited edtFax: TDBEdit
            DataField = 'FAX'
            DataSource = dsResult
          end
        end
      end
      object tShMessSMTP: TTabSheet
        Caption = 'Messagerie SMTP'
        ImageIndex = 1
        object lblNetwork: TLabel
          Left = 8
          Top = 8
          Width = 102
          Height = 13
          Caption = 'Connexion r'#233'seau'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblUserName: TLabel
          Left = 8
          Top = 32
          Width = 88
          Height = 13
          Caption = 'Nom de l'#39'utilisateur'
        end
        object lblPassWord: TLabel
          Left = 8
          Top = 56
          Width = 64
          Height = 13
          Caption = 'Mot de passe'
        end
        object lblAdrDNS: TLabel
          Left = 8
          Top = 80
          Width = 102
          Height = 13
          Caption = 'Adresse serveur DNS'
        end
        object lblEMailOCT: TLabel
          Left = 8
          Top = 120
          Width = 50
          Height = 13
          Caption = 'Email OCT'
        end
        object lblFichierAller: TLabel
          Left = 8
          Top = 144
          Width = 90
          Height = 13
          Caption = 'Nom du fichier aller'
        end
        object lblFichierRetour: TLabel
          Left = 8
          Top = 168
          Width = 98
          Height = 13
          Caption = 'Nom du fichier retour'
        end
        object lblBoiteLettre: TLabel
          Left = 320
          Top = 8
          Width = 93
          Height = 13
          Caption = 'Boite aux lettres'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lnlPOP3: TLabel
          Left = 320
          Top = 32
          Width = 161
          Height = 13
          Caption = 'serveur de courrier entrant (POP3)'
        end
        object lblSMTP: TLabel
          Left = 320
          Top = 56
          Width = 164
          Height = 13
          Caption = 'Serveur de courrier sortant (SMTP)'
        end
        object lblUserNamePOP3: TLabel
          Left = 320
          Top = 80
          Width = 119
          Height = 13
          Caption = 'Nom de l'#39'utilisateur POP3'
        end
        object lblPassWordPOP3: TLabel
          Left = 320
          Top = 104
          Width = 95
          Height = 13
          Caption = 'Mot de passe POP3'
        end
        object lblEMail: TLabel
          Left = 320
          Top = 128
          Width = 109
          Height = 13
          Caption = 'Adresse de messagerie'
        end
        object lblTempo: TLabel
          Left = 320
          Top = 168
          Width = 103
          Height = 13
          Caption = 'Tempo (en secondes)'
        end
        object edtUserName: TDBEdit
          Left = 128
          Top = 28
          Width = 153
          Height = 21
          DataField = 'NOM_UTIL'
          DataSource = dsResult
          TabOrder = 0
        end
        object edtPassWord: TDBEdit
          Left = 128
          Top = 52
          Width = 153
          Height = 21
          DataField = 'MOT_PASSE'
          DataSource = dsResult
          TabOrder = 1
        end
        object edtAddrDNS: TDBEdit
          Left = 128
          Top = 76
          Width = 153
          Height = 21
          DataField = 'SERV_DNS'
          DataSource = dsResult
          TabOrder = 2
        end
        object edtEMailOCT: TDBEdit
          Left = 128
          Top = 116
          Width = 153
          Height = 21
          DataField = 'EMAIL_OCT'
          DataSource = dsResult
          TabOrder = 3
        end
        object edtFichierAller: TDBEdit
          Left = 128
          Top = 140
          Width = 153
          Height = 21
          DataField = 'NOM_FIC_ALLER'
          DataSource = dsResult
          TabOrder = 4
        end
        object edtfichierRetour: TDBEdit
          Left = 128
          Top = 168
          Width = 153
          Height = 21
          DataField = 'NOM_FIC_RETOUR'
          DataSource = dsResult
          TabOrder = 5
        end
        object edtPOP3: TDBEdit
          Left = 504
          Top = 28
          Width = 153
          Height = 21
          DataField = 'SERV_POP3'
          DataSource = dsResult
          TabOrder = 6
        end
        object edtSMTP: TDBEdit
          Left = 504
          Top = 52
          Width = 153
          Height = 21
          DataField = 'SERV_SMTP'
          DataSource = dsResult
          TabOrder = 7
        end
        object edtUserNamePOP3: TDBEdit
          Left = 504
          Top = 76
          Width = 153
          Height = 21
          DataField = 'UTILISATEUR_POP3'
          DataSource = dsResult
          TabOrder = 8
        end
        object edtPassWordPOP3: TDBEdit
          Left = 504
          Top = 100
          Width = 153
          Height = 21
          DataField = 'MOT_PASSE_POP3'
          DataSource = dsResult
          TabOrder = 9
        end
        object edtEMail: TDBEdit
          Left = 504
          Top = 124
          Width = 153
          Height = 21
          DataField = 'ADRESSE_BAL'
          DataSource = dsResult
          TabOrder = 10
        end
        object edtTempo: TDBEdit
          Left = 504
          Top = 164
          Width = 153
          Height = 21
          DataField = 'TEMPO'
          DataSource = dsResult
          TabOrder = 11
        end
      end
    end
    object edtNom: TDBEdit
      Left = 104
      Top = 4
      Width = 361
      Height = 21
      DataField = 'NOM'
      DataSource = dsResult
      TabOrder = 1
    end
    object edtNormeAller: TDBEdit
      Left = 144
      Top = 32
      Width = 121
      Height = 21
      DataField = 'NORME_LIBELLE'
      DataSource = dsResult
      TabOrder = 2
    end
    object edtNormeRetour: TDBEdit
      Left = 328
      Top = 32
      Width = 137
      Height = 21
      DataField = 'NORME_RETOUR_LIBELLE'
      DataSource = dsResult
      TabOrder = 3
    end
    object edtDestNO: TDBEdit
      Left = 144
      Top = 60
      Width = 121
      Height = 21
      DataField = 'NO_APPEL'
      DataSource = dsResult
      TabOrder = 4
    end
    object edtNormeType: TDBEdit
      Left = 328
      Top = 60
      Width = 25
      Height = 21
      DataField = 'TYP'
      DataSource = dsResult
      TabOrder = 5
    end
    object edtDestApplication: TDBEdit
      Left = 440
      Top = 60
      Width = 25
      Height = 21
      DataField = 'APPLICATION_OCT'
      DataSource = dsResult
      TabOrder = 6
    end
    object edtZoneMessage: TDBEdit
      Left = 104
      Top = 88
      Width = 361
      Height = 21
      DataField = 'ZONE_MESSAGE'
      DataSource = dsResult
      TabOrder = 7
    end
    object chkOCT: TDBCheckBox
      Left = 480
      Top = 8
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      Caption = 'OCT'
      DataField = 'OCT'
      DataSource = dsResult
      TabOrder = 8
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object chkRefusHTP: TDBCheckBox
      Left = 480
      Top = 64
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Refus HTP'
      DataField = 'REFUSE_HTP'
      DataSource = dsResult
      TabOrder = 9
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object chkGereLot: TDBCheckBox
      Left = 592
      Top = 64
      Width = 81
      Height = 17
      Alignment = taLeftJustify
      Caption = 'G'#233'r'#233' n'#176' lot'
      DataField = 'GESTION_NUM_LOTS'
      DataSource = dsResult
      TabOrder = 10
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object edtProtocole: TDBEdit
      Left = 544
      Top = 32
      Width = 129
      Height = 21
      DataField = 'FLUX'
      DataSource = dsResult
      TabOrder = 11
    end
    object chkAuthentification: TDBCheckBox
      Left = 688
      Top = 34
      Width = 97
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Authentication'
      DataField = 'AUTHENTIFICATION'
      DataSource = dsResult
      TabOrder = 12
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object edtXSL: TDBEdit
      Left = 544
      Top = 88
      Width = 129
      Height = 21
      DataField = 'XSL'
      DataSource = dsResult
      TabOrder = 13
    end
  end
  inherited dsResult: TDataSource
    DataSet = dmViewDataPHA.dSetViewDataDestinataires
  end
  object iLstDetailDest: TImageList
    Left = 552
    Top = 320
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000044444400444444004444440000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000444444004444440044444400000000000000000044444400444444000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000444444004444
      440044444400000000006699CC0066CCFF006699CC0000000000444444004444
      4400444444000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003184FF001852FF003952CE005A4A94003131BD00214AEF001852
      FF00000000000000000000000000000000004444440044444400444444000000
      00006699CC006699CC006699CC0066CCFF0066669900666699006699CC000000
      0000444444004444440044444400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002973
      FF005A73CE0094849C00CE9C8400D69C8400DEC6A500D6947300DE7B4A007B8C
      CE001852FF0000000000000000000000000000000000000000006699CC006699
      CC006699CC006699CC006699CC0066CCFF0066669900A4A0A000A4A0A0006666
      99006699CC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003184FF00104A
      E700D6B59400E7D6B500EFD6AD00F7E7BD00EFDEB500D6845A00EFA56B00F7E7
      C600BDCEF700396BFF001852FF0000000000000000006699CC006699CC006699
      CC006699CC006699CC006699CC0066CCFF0066669900A4A0A000A4A0A000A4A0
      A0006699CC006699CC006699CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002163FF005252
      7B00D6AD9400E7B58400F7CE9400F7EFC600E7BDA500DE946300EFCE9C00EFE7
      C600FFFFFF00EFF7FF006B94FF001852FF00000000006699CC006699CC006699
      CC006699CC006699CC006699CC0066CCFF006699CC0066669900A4A0A0000000
      DD006699CC006699CC006699CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000396BCE00FFBD
      6300EFD6B500EFCEA500FFF7E700F7EFDE00DEA58400DEA56B00EFD6B500F7E7
      CE00F7EFE700FFFFFF00FFFFFF001863DE00000000006699CC006699CC006699
      CC006699CC006699CC006699CC00FFFFFF006699CC006699CC006699CC006666
      99000000DD000000DD006699CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002973FF002184CE00BDD6
      AD00F7E7D600F7EFDE00FFFFF700EFDEC600CE7B4A00F7C69400F7E7D600F7F7
      E700FFFFFF00FFFFFF00ADFFBD00107B8400000000006699CC006699CC006699
      CC006699CC00CCFFFF0066CCFF00CCFFFF0066CCFF00CCFFFF006699CC006699
      CC006699CC006699CC006699CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000186BE70008DEF700E7F7
      EF00EFDEBD00F7EFDE00FFFFFF00E7BDA500DE9C6300EFD6AD00F7F7E700FFFF
      FF00FFFFFF00FFFFFF0042C68C00185ADE00000000006699CC006699CC00CCFF
      FF0066CCFF0066CCFF0066CCFF00CCFFFF0066CCFF0066CCFF0066CCFF00CCFF
      FF006699CC006699CC006699CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000189CB50039CE8400F7EF
      DE00F7E7CE00FFF7F700F7E7CE00DEA57B00E7BD8C00EFDEB500F7E7CE00FFF7
      EF00FFFFFF00CEEFFF00216BFF001852FF0000000000CCFFFF0066CCFF0066CC
      FF0066CCFF0066CCFF0066CCFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF006699CC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000216BFF0018CE52009CDEA500F7EF
      E700FFFFF700EFF7FF009CB5F700BD948C00F7DEB500F7E7D600FFF7EF00FFFF
      FF00FFFFFF0073BDFF00215AFF0000000000000000006699CC006699CC006699
      CC006699CC006699CC006699CC00CCFFFF0066CCFF0066CCFF0066CCFF0066CC
      FF0066CCFF0066CCFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002163FF00399CAD00BDD6FF009CB5
      FF006B94FF001852FF00000000001852FF007394EF00EFF7FF00FFFFFF00FFFF
      FF00E7F7FF00297BFF001852FF000000000000000000000000000000000066CC
      FF0066CCFF0066CCFF006699CC0066CCFF0066CCFF0066CCFF0066CCFF0066CC
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000185AFF001852FF001852FF000000
      0000000000000000000000000000000000001852FF004273FF00ADC6FF00FFFF
      FF008CCEFF002163FF0000000000000000000000000000000000000000000000
      00000000000066CCFF006699CC0066CCFF0066CCFF0066CCFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001852FF004A73
      FF00297BFF001852FF0000000000000000000000000000000000000000000000
      000000000000000000000000000066CCFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001852FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFC7F00000000FFFFF19F00000000
      FFFFC44700000000F80F101100000000E007C00700000000C001800100000000
      C000800100000000C00080010000000080008001000000008000800100000000
      800080010000000000018003000000000201E00F000000001F03F83F00000000
      FFC3FEFF00000000FFF7FFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
