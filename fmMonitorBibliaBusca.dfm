object fMonitorBibliaBusca: TfMonitorBibliaBusca
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Busca B'#237'blica'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBibliaBusca: TPanel
    Left = 0
    Top = 0
    Width = 600
    Height = 400
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = -182
    ExplicitTop = -25
    ExplicitWidth = 782
    ExplicitHeight = 425
    object imgBibliaBusca: TImage
      Left = 2
      Top = 176
      Width = 421
      Height = 59
      Center = True
      Stretch = True
      Transparent = True
    end
    object lmdBibliaBuscaTxt: TLabel
      Left = 51
      Top = 24
      Width = 62
      Height = 30
      Alignment = taCenter
      AutoSize = False
      Caption = 'Texto'
      Layout = tlCenter
      WordWrap = True
    end
    object lmdBibliaBuscaInfo: TLabel
      Left = 16
      Top = 100
      Width = 121
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Passagem'
      Layout = tlCenter
      WordWrap = True
    end
  end
end
