inherited frConvertFournisseur: TfrConvertFournisseur
  object PIDBGrid1: TPIDBGrid
    Left = 0
    Top = 0
    Width = 700
    Height = 240
    Align = alClient
    BorderStyle = bsNone
    DataSource = Dsfournisseur
    DefaultDrawing = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = PIDBGrid1DrawColumnCell
    OnDblClick = PIDBGrid1DblClick
    ActiveMenuColumns = False
    ControlOnRowHeight = False
    PIOptions.IndicatorWidth = 11
    PIOptions.Options = []
    PIOptions.LinesPerRow = 1
    PIOptions.LinesPerTitle = 1
    PIOptions.SelectedColor = clHighlight
    PIOptions.SelectedFont.Charset = DEFAULT_CHARSET
    PIOptions.SelectedFont.Color = clHighlightText
    PIOptions.SelectedFont.Height = -11
    PIOptions.SelectedFont.Name = 'MS Sans Serif'
    PIOptions.SelectedFont.Style = []
    PIOptions.PrintingOptions.Alignment = taLeftJustify
    PIOptions.PrintingOptions.OffsetTitle = 0
    PIOptions.PrintingOptions.Preview = False
    PIOptions.PrintingOptions.Title.Alignment = caLeft
    PIOptions.PrintingOptions.Title.Angle = 0
    PIOptions.PrintingOptions.Title.Color = clWhite
    PIOptions.PrintingOptions.Title.Font.Charset = DEFAULT_CHARSET
    PIOptions.PrintingOptions.Title.Font.Color = clWindowText
    PIOptions.PrintingOptions.Title.Font.Height = -11
    PIOptions.PrintingOptions.Title.Font.Name = 'MS Sans Serif'
    PIOptions.PrintingOptions.Title.Font.Style = []
    PIOptions.PrintingOptions.Title.OffsetX = 0
    PIOptions.PrintingOptions.Title.OffsetY = 0
    PIOptions.PrintingOptions.Title.WordWrap = False
    PIOptions.PrintingOptions.OnlyRowSelected = False
    PIOptions.PrintingOptions.BackgroundCell = False
    PIOptions.PrintingOptions.BackgroundTitle = False
    ShowDetails = False
    TitlesHeight = 17
    Titles = <
      item
        Alignment = taCenter
        Caption = 'Fournisseur'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Width = 171
      end
      item
        Alignment = taCenter
        Caption = 'R'#233'f'#233'rence'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Width = 100
      end
      item
        Alignment = taCenter
        Caption = 'Adresse'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Width = 336
      end>
    PIMultiSelect.Active = False
    PIMultiSelect.Mode = msmSelection
    Columns = <
      item
        Expanded = False
        FieldName = 'AFOURNISSEUR'
        Title.Caption = 'Code'
        Width = 40
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end
      item
        Expanded = False
        FieldName = 'ANOM'
        Title.Caption = 'Fournisseur'
        Width = 130
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end
      item
        Expanded = False
        FieldName = 'ATR_FOURNISSEUR'
        Width = 100
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end
      item
        Expanded = False
        FieldName = 'ARUE'
        Title.Caption = 'Rue'
        Width = 150
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end
      item
        Expanded = False
        FieldName = 'ACP'
        Title.Caption = 'CP'
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end
      item
        Expanded = False
        FieldName = 'ALOCALITE'
        Title.Caption = 'Ville'
        Width = 150
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end
      item
        Expanded = False
        FieldName = 'ACOUNT'
        Title.Caption = 'Nb Tarif'
        Width = 50
        Visible = True
        Control = ccNone
        ControlOptions.Boolean.ValueChecked = '1'
        ControlOptions.Boolean.ValueUnChecked = '0'
        ControlOptions.ComboBox.ValueAsIndex = False
        ControlOptions.ProgressBar.Color = clActiveCaption
        ControlOptions.ProgressBar.Max = 100
        ControlOptions.ProgressBar.Min = 0
        Options = [coExporting, coPrinting]
      end>
  end
  object Dsfournisseur: TDataSource
    DataSet = dmCommitPHA.dSetFournisseur
    Left = 168
    Top = 104
  end
end
