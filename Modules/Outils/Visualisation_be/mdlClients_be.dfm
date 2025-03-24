inherited frClients: TfrClients
  inherited Splitter: TSplitter
    Top = 345
    Width = 705
    Height = 0
    Cursor = crHSplit
    Align = alNone
    ExplicitTop = 345
    ExplicitWidth = 705
    ExplicitHeight = 0
  end
  inherited ScrollBox: TScrollBox [1]
    Top = 345
    Width = 705
    Height = 185
    Align = alNone
    ExplicitTop = 345
    ExplicitWidth = 705
    ExplicitHeight = 185
  end
  inherited pnlCritere: TPanel [2]
    ExplicitWidth = 609
    inherited lblCritere: TLabel
      Left = 96
      Top = 33
      Width = 64
      Caption = 'Nom du client'
      ExplicitLeft = 96
      ExplicitTop = 33
      ExplicitWidth = 64
    end
    object Label3: TLabel [1]
      Left = 8
      Top = 9
      Width = 108
      Height = 13
      Caption = 'Nom+Pr'#233'nom du client'
    end
    inherited btnChercher: TPISpeedButton
      OnClick = btnChercherClick
    end
    inherited edtCritere: TEdit
      Left = 148
      Width = 289
      ExplicitLeft = 148
      ExplicitWidth = 289
    end
  end
  inherited grdResultat: TPIDBGrid [3]
    Height = 271
    Align = alClient
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'T_COMPTE_ID'
        Title.Alignment = taCenter
        Width = 87
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
        Title.Alignment = taCenter
        Title.Caption = 'Nom'
        Width = 176
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
        Title.Alignment = taCenter
        Title.Caption = 'Pr'#233'nom'
        Width = 167
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
        FieldName = 'NB_CARTES'
        Title.Caption = 'Nb Cartes'
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
        FieldName = 'SOLDEDISP'
        Title.Alignment = taCenter
        Title.Caption = 'Solde Disp.'
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
        FieldName = 'RISTDISP'
        Title.Caption = 'Rist. Disp.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
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
  inherited dsResultat: TDataSource
    Left = 344
    Top = 96
  end
  inherited pmnMenuFrame: TJvPopupMenu
    Left = 256
    Top = 96
  end
end
