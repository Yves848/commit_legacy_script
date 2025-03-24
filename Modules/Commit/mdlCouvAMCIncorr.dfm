inherited frmCouvAMCIncorr: TfrmCouvAMCIncorr
  Left = 162
  Top = 225
  Caption = 'Couvertures AMC incorrectes'
  ClientHeight = 277
  ClientWidth = 771
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited tbToolbar: TToolBar
    Width = 59
    Height = 86
    Align = alNone
    Visible = False
    inherited tBtnSeparator_0: TToolButton
      Wrap = True
    end
    inherited tBtnAide: TToolButton
      Left = 0
      Top = 30
    end
    inherited tBtnSeparator_1: TToolButton
      Left = 0
      Top = 30
      Wrap = True
    end
    inherited tBtnClose: TToolButton
      Left = 0
      Top = 60
    end
  end
  object dbGrdCouvAMCIncorr: TPIDBGrid [1]
    Left = 0
    Top = 0
    Width = 771
    Height = 225
    Align = alTop
    BorderStyle = bsNone
    DataSource = dsCouvAMCIncorr
    DefaultDrawing = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
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
    Titles = <>
    PIMultiSelect.Active = False
    PIMultiSelect.Mode = msmSelection
  end
  object btnOk: TButton [2]
    Left = 288
    Top = 240
    Width = 75
    Height = 25
    Caption = '&Valider'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton [3]
    Left = 408
    Top = 240
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Annuler'
    ModalResult = 2
    TabOrder = 3
  end
  object dSetCouvAMCIncorr: TPIIBDataSet
    Transaction = dmCommitPHA.trPHA
    AfterOpen = dSetCouvAMCIncorrAfterOpen
    DeleteSQL.Strings = (
      'execute procedure NODELETE')
    InsertSQL.Strings = (
      'execute procedure NOINSERT')
    SelectSQL.Strings = (
      'select org.organisme, '
      'org.nom, '
      'c_couvamc.couvertureamc,'
      'couvamc.libelle,'
      'c_couvamc.modecalcul,'
      'count(*) nb_cli'
      'from t_conv_couvertureamc c_couvamc'
      
        'inner join t_couvertureamc couvamc on (couvamc.couvertureamc = c' +
        '_couvamc.couvertureamc)'
      
        'inner join t_organisme org on (org.organisme = couvamc.organisme' +
        'amc)'
      
        'inner join t_client cli on (cli.couvertureamc = couvamc.couvertu' +
        'reamc)'
      'where couvamc.couvertureamc in (select couvertureamc'
      'from t_tauxpriseencharge'
      'where prestation = '#39'PH4'#39
      'and taux > 65)'
      'and couvamc.modecalcul <> '#39'0'#39
      'group by org.organisme, '
      'org.nom, '
      'c_couvamc.couvertureamc,'
      'couvamc.libelle,'
      'c_couvamc.modecalcul')
    ModifySQL.Strings = (
      'execute procedure MAJCouvertureAMC('
      '  :COUVERTUREAMC,'
      '  :MODECALCUL)')
    Left = 40
    Top = 200
  end
  object dsCouvAMCIncorr: TDataSource
    DataSet = dSetCouvAMCIncorr
    Left = 40
    Top = 144
  end
end
