object fMonitorSorteioNomes: TfMonitorSorteioNomes
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Sorteio de Nomes'
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
  object pnlSorteioNM: TPanel
    Left = 150
    Top = 0
    Width = 300
    Height = 400
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object imgSorteioNM: TImage
      Left = 0
      Top = 6
      Width = 482
      Height = 419
      Center = True
      Stretch = True
      Transparent = True
    end
    object lmdSorteioNM: TLabel
      Left = 0
      Top = 0
      Width = 300
      Height = 394
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = '----'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -27
      Font.Name = 'Arial Rounded MT Bold'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      Layout = tlCenter
      WordWrap = True
      ExplicitLeft = 91
      ExplicitTop = 129
      ExplicitWidth = 413
      ExplicitHeight = 46
    end
    object gSorteioNM: TbsSkinGauge
      Left = 0
      Top = 394
      Width = 300
      Height = 6
      HintImageIndex = 0
      TabOrder = 0
      SkinDataName = 'gauge'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      UseSkinSize = False
      ShowProgressText = False
      ShowPercent = False
      MinValue = 0
      MaxValue = 1
      Value = 1
      Vertical = False
      ProgressAnimationPause = 3000
      Align = alBottom
    end
  end
  object pnlSorteioNME: TbsSkinExPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 400
    HintImageIndex = 0
    TabOrder = 1
    SkinData = DM.bsSkinData1
    SkinDataName = 'expanel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    UseSkinSize = True
    CaptionImageIndex = -1
    NumGlyphs = 1
    Spacing = 2
    RealWidth = 0
    RealHeight = 0
    ShowRollButton = False
    ShowCloseButton = True
    DefaultCaptionHeight = 21
    RollState = False
    RollKind = rkRollVertical
    Moveable = False
    Sizeable = False
    Align = alLeft
    Caption = 'Nomes do Sorteio'
    OnClose = pnlSorteioNMEClose
    object lbSorteioNM: TbsSkinOfficeListBox
      Left = 1
      Top = 21
      Width = 148
      Height = 378
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'listbox'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      AlternateRow = False
      ShowCheckBoxes = True
      HeaderLeftAlignment = False
      HeaderSkinDataName = 'menuheader'
      ItemSkinDataName = 'listbox'
      Items = <>
      ShowItemTitles = True
      ItemHeight = 30
      HeaderHeight = 20
      ItemIndex = -1
      ShowLines = True
      MouseMoveChangeIndex = False
      Align = alClient
      OnItemCheckClick = lbSorteioNMItemCheckClick
    end
  end
  object pnlSorteioNMD: TbsSkinExPanel
    Left = 450
    Top = 0
    Width = 150
    Height = 400
    HintImageIndex = 0
    TabOrder = 2
    SkinData = DM.bsSkinData1
    SkinDataName = 'expanel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 13
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    UseSkinSize = True
    CaptionImageIndex = -1
    NumGlyphs = 1
    Spacing = 2
    RealWidth = 0
    RealHeight = 0
    ShowRollButton = False
    ShowCloseButton = True
    DefaultCaptionHeight = 21
    RollState = False
    RollKind = rkRollVertical
    Moveable = False
    Sizeable = False
    Align = alRight
    Caption = #218'ltimos Sorteados'
    OnClose = pnlSorteioNMDClose
    object lbSorteadoNM: TbsSkinOfficeListBox
      Left = 1
      Top = 21
      Width = 148
      Height = 378
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'listbox'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 13
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      AlternateRow = False
      ShowCheckBoxes = False
      HeaderLeftAlignment = False
      HeaderSkinDataName = 'menuheader'
      ItemSkinDataName = 'listbox'
      Items = <>
      ShowItemTitles = True
      ItemHeight = 30
      HeaderHeight = 20
      ItemIndex = -1
      ShowLines = True
      MouseMoveChangeIndex = False
      Align = alClient
    end
  end
end
