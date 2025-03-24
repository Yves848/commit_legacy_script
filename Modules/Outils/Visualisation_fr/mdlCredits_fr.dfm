inherited frCredit: TfrCredit
  inherited Splitter: TSplitter
    Top = 345
    Width = 705
    Cursor = crHSplit
    Align = alNone
    ExplicitTop = 345
    ExplicitWidth = 705
  end
  inherited ScrollBox: TScrollBox [1]
    Top = 345
    Width = 705
    Height = 185
    Align = alNone
    Visible = False
    ExplicitTop = 345
    ExplicitWidth = 705
    ExplicitHeight = 185
  end
  inherited pnlCritere: TPanel [2]
    ExplicitWidth = 546
    inherited lblCritere: TLabel
      Width = 62
      Caption = 'NOM Pr'#233'nom'
      ExplicitWidth = 62
    end
    inherited btnChercher: TPISpeedButton
      Left = 387
      OnClick = btnChercherClick
      ExplicitLeft = 387
    end
    inherited edtCritere: TEdit
      Left = 96
      Width = 289
      ExplicitLeft = 96
      ExplicitWidth = 289
    end
  end
  inherited grdResultat: TPIDBGrid [3]
    Height = 246
    Align = alClient
    Columns = <
      item
        Expanded = False
        FieldName = 'TYPE_CLIENT_LIBELLE'
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
        FieldName = 'NOM_CLIENT'
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
        FieldName = 'DATE_CREDIT'
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
        FieldName = 'MONTANT'
        Title.Alignment = taCenter
        Width = 50
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
  object pnlRecapitulatif: TPanel [4]
    Left = 0
    Top = 279
    Width = 451
    Height = 25
    Align = alBottom
    TabOrder = 3
    object lblTotal: TLabel
      Left = 448
      Top = 5
      Width = 30
      Height = 13
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtTotal: TPIEdit
      Left = 488
      Top = 1
      Width = 54
      Height = 21
      Alignement = taRightJustify
      Negatif = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  inherited dsResultat: TDataSource
    DataSet = dmVisualisationPHA_fr.dSetCredits
    Left = 344
    Top = 96
  end
  inherited pmnMenuFrame: TJvPopupMenu
    Left = 256
    Top = 96
  end
end
