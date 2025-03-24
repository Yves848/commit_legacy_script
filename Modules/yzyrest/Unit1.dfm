object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 631
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    793
    631)
  TextHeight = 15
  object Memo1: TMemo
    Left = 8
    Top = 39
    Width = 777
    Height = 584
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object btGo: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 1
    OnClick = btGoClick
  end
  object Button1: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
  end
end
