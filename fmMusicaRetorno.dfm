object fMusicaRetorno: TfMusicaRetorno
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Apresenta'#231#227'o de M'#250'sica - Modo Retorno'
  ClientHeight = 421
  ClientWidth = 627
  Color = clBlack
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
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 627
    Height = 421
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel'
    Color = 2697513
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object lblLetra_prox: TbsSkinStdLabel
      Left = 0
      Top = 301
      Width = 627
      Height = 40
      EllipsType = bsetNone
      UseSkinFont = False
      UseSkinColor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWhite
      DefaultFont.Height = 10
      DefaultFont.Name = 'Tahoma'
      DefaultFont.Style = []
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = 40
      Font.Name = 'Arial Narrow'
      Font.Style = [fsBold]
      Align = alBottom
      Alignment = taCenter
      Caption = '< CARREGANDO >'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 248
    end
    object pnlProgress: TGridPanel
      Left = 0
      Top = 382
      Width = 627
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlProgress'
      Color = clBlack
      ColumnCollection = <
        item
          SizeStyle = ssAbsolute
          Value = 50.000000000000000000
        end
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAbsolute
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = gSlide
          Row = 0
        end
        item
          Column = 1
          Control = gSlideTotal
          Row = 1
        end
        item
          Column = 2
          Control = lblTempo
          Row = 0
          RowSpan = 2
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 50.001144400448600000
        end
        item
          Value = 49.998855599551390000
        end>
      ShowCaption = False
      TabOrder = 0
      object gSlide: TbsSkinGauge
        Left = 50
        Top = 0
        Width = 477
        Height = 19
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
        UseSkinSize = True
        ShowProgressText = False
        ShowPercent = False
        MinValue = 0
        MaxValue = 1
        Value = 1
        Vertical = False
        ProgressAnimationPause = 3000
        Align = alClient
      end
      object gSlideTotal: TbsSkinGauge
        Left = 50
        Top = 19
        Width = 477
        Height = 20
        HintImageIndex = 0
        TabOrder = 2
        SkinDataName = 'gauge'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        UseSkinSize = True
        ShowProgressText = False
        ShowPercent = False
        MinValue = 0
        MaxValue = 1
        Value = 1
        Vertical = False
        ProgressAnimationPause = 3000
        Align = alClient
      end
      object lblTempo: TbsSkinLabel
        AlignWithMargins = True
        Left = 537
        Top = 0
        Width = 90
        Height = 39
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        HintImageIndex = 0
        TabOrder = 1
        SkinDataName = 'label'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 13
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = True
        Transparent = True
        ShadowEffect = False
        ShadowColor = clBlack
        ShadowOffset = 0
        ShadowSize = 3
        ReflectionEffect = False
        ReflectionOffset = -5
        EllipsType = bsetNoneEllips
        UseSkinSize = True
        UseSkinFontColor = False
        BorderStyle = bvNone
        Align = alClient
        AutoSize = False
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 341
      Width = 627
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      Color = clBlack
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      object lblSlides: TbsSkinLabel
        Left = 0
        Top = 0
        Width = 627
        Height = 41
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        HintImageIndex = 0
        TabOrder = 0
        SkinDataName = 'label'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 30
        DefaultFont.Name = 'DIN Condensed'
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        Transparent = True
        ShadowEffect = False
        ShadowColor = clBlack
        ShadowOffset = 0
        ShadowSize = 3
        ReflectionEffect = False
        ReflectionOffset = -5
        EllipsType = bsetNoneEllips
        UseSkinSize = False
        UseSkinFontColor = False
        BorderStyle = bvFrame
        Alignment = taCenter
        Align = alClient
        Caption = '1 / 5'
        AutoSize = False
      end
    end
    object pnlLetra: TPanel
      Left = 0
      Top = 0
      Width = 627
      Height = 301
      Align = alClient
      BevelOuter = bvNone
      Caption = #39#39
      Color = clBlack
      Ctl3D = False
      DoubleBuffered = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ShowCaption = False
      TabOrder = 2
      object lblLetra: TbsSkinStdLabel
        Left = 50
        Top = 0
        Width = 8
        Height = 80
        EllipsType = bsetNone
        UseSkinFont = False
        UseSkinColor = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 10
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        SkinData = DM.bsSkinData1
        SkinDataName = 'label'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 40
        Font.Name = 'Arial Narrow'
        Font.Style = [fsBold]
        Alignment = taCenter
        Caption = '    '
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
      object lblLetra_aux: TbsSkinStdLabel
        Left = 60
        Top = 71
        Width = 8
        Height = 80
        EllipsType = bsetNone
        UseSkinFont = False
        UseSkinColor = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWhite
        DefaultFont.Height = 10
        DefaultFont.Name = 'Tahoma'
        DefaultFont.Style = []
        SkinData = DM.bsSkinData1
        SkinDataName = 'label'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 40
        Font.Name = 'Arial Narrow'
        Font.Style = [fsBold]
        Alignment = taCenter
        Caption = '    '
        Color = clWhite
        ParentColor = False
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
    end
  end
end
