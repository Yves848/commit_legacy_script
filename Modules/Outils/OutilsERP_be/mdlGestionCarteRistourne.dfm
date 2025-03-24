object frmGestionCarteRistourne: TfrmGestionCarteRistourne
  Left = 610
  Top = 296
  Caption = 'Choix du type de cartes ristourne'
  ClientHeight = 479
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 48
    Top = 8
    Width = 233
    Height = 39
    Caption = 
      'ATTENTION : '#224' n'#39'utiliser que si il n'#39'y a qu'#39'un seul type de cart' +
      'es ristrounes !!!'
    WordWrap = True
  end
  object btnCarteVirt: TRadioButton
    Left = 48
    Top = 40
    Width = 233
    Height = 17
    Caption = 'Cartes virtuellles'
    TabOrder = 0
  end
  object btnDynaphar: TRadioButton
    Left = 48
    Top = 88
    Width = 233
    Height = 17
    Caption = 'Cartes Dynaphar'
    TabOrder = 1
  end
  object btnPharmapass: TRadioButton
    Left = 48
    Top = 112
    Width = 233
    Height = 17
    Caption = 'Cartes PharmaPass'
    TabOrder = 2
  end
  object btnMonPharmacien: TRadioButton
    Left = 48
    Top = 136
    Width = 233
    Height = 17
    Caption = 'Cartes Mon Pharmacien'
    TabOrder = 3
  end
  object btnPreimprim: TRadioButton
    Left = 48
    Top = 160
    Width = 233
    Height = 17
    Caption = 'Cartes pr'#233'imprim'#233'es'
    TabOrder = 4
  end
  object btnCarteImprPlastif: TRadioButton
    Left = 48
    Top = 184
    Width = 233
    Height = 17
    Caption = 'Cartes Imprim'#233'e en officine et plastifi'#233'e'
    TabOrder = 5
  end
  object btnCarteImprOffEtiq: TRadioButton
    Left = 48
    Top = 208
    Width = 233
    Height = 17
    Caption = 'Cartes Imprim'#233'e en officine sur '#233'tiquette'
    TabOrder = 6
  end
  object btnValider: TButton
    Left = 80
    Top = 416
    Width = 137
    Height = 17
    Caption = 'Valider'
    TabOrder = 7
    OnClick = btnValiderClick
  end
  object btnPasCarte: TRadioButton
    Left = 48
    Top = 232
    Width = 233
    Height = 17
    Caption = 'Pas de gestion des ristournes sur cartes'
    TabOrder = 8
  end
  object btnVPharma: TRadioButton
    Left = 48
    Top = 64
    Width = 233
    Height = 17
    Caption = 'Cartes VPharma'
    TabOrder = 9
  end
  object gBoxSeqCrist: TGroupBox
    Left = 48
    Top = 296
    Width = 209
    Height = 89
    Caption = 'Porchain num'#233'ro de carte ristourne'
    TabOrder = 10
    object Label1: TLabel
      Left = 16
      Top = 37
      Width = 37
      Height = 13
      Caption = 'Num'#233'ro'
    end
    object edtSeqCrist: TSpinEdit
      Left = 96
      Top = 32
      Width = 97
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
end
