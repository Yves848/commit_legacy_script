inherited frmNoLot: TfrmNoLot
  Left = 403
  Top = 280
  Caption = 'Positionnement des num'#233'ros de lots'
  ClientHeight = 166
  ClientWidth = 397
  Constraints.MaxHeight = 200
  Constraints.MaxWidth = 405
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object dbGrdNoLot: TPIDBGrid [0]
    Left = 0
    Top = 0
    Width = 397
    Height = 166
    Align = alClient
    BorderStyle = bsNone
    DataSource = dsNoLot
    DefaultDrawing = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
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
    Options2.PointSuspensionDonnees = False
    Options2.PointSuspensionTitre = False
    Options2.CoinsRonds = False
    Details = False
    HauteurEntetes = 17
    Entetes = <>
    MultiSelection.Active = False
    MultiSelection.Mode = mmsSelection
    Columns = <
      item
        Expanded = False
        FieldName = 'NOM'
        Title.Alignment = taCenter
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
        FieldName = 'NUMERO_LOT'
        Title.Alignment = taCenter
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
  object dsNoLot: TDataSource
    DataSet = dmOutilsERPERP_fr.qryNoLot
    Left = 248
    Top = 80
  end
end
