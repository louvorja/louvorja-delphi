object fVideoOn: TfVideoOn
  Left = 0
  Top = 0
  Caption = '.'
  ClientHeight = 263
  ClientWidth = 452
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
  object wbVideo: TWebBrowser
    Left = 0
    Top = 0
    Width = 452
    Height = 174
    Align = alClient
    TabOrder = 1
    OnDocumentComplete = wbVideoDocumentComplete
    ExplicitLeft = 64
    ExplicitTop = 56
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000B72E0000FC1100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object mmHTML: TMemo
    Left = 0
    Top = 174
    Width = 452
    Height = 89
    Align = alBottom
    Lines.Strings = (
      '<!DOCTYPE html>'
      '<html style='#39'border:0'#39'>'
      '<head>'
      
        '<!-- // this is needed to force our embedded browser to run in E' +
        'DGE mode -->'
      '<meta http-equiv="X-UA-Compatible" content="IE=edge">'
      ''
      '    <style>'
      '        *{margin:0;padding:0;}'
      
        '        html,body{height:100%;margin:0;padding:0;overflow:hidden' +
        ';background:#000;}'
      '    </style>'
      '</head>'
      '  <body style='#39'border:0'#39'>'
      
        '    <!-- 1. The <iframe> (and video player) will replace this <d' +
        'iv> tag. -->'
      '    <div id="player"></div>'
      ''
      '    <script>'
      
        '      // 2. This code loads the IFrame Player API code asynchron' +
        'ously.'
      '      var tag = document.createElement('#39'script'#39');'
      ''
      '      tag.src = "https://www.youtube.com/iframe_api";'
      
        '      var firstScriptTag = document.getElementsByTagName('#39'script' +
        #39')[0];'
      
        '      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag' +
        ');'
      ''
      
        '      // 3. This function creates an <iframe> (and YouTube playe' +
        'r)'
      '      //    after the API code downloads.'
      '      var player;'
      '      function onYouTubeIframeAPIReady() {'
      '        player = new YT.Player('#39'player'#39', {'
      
        '          //height: window.innerHeight || document.documentEleme' +
        'nt.clientHeight || document.body.clientHeight,'
      #9#9'  height: '#39'100%'#39','
      '          width: '#39'100%'#39','
      '          videoId: location.search.slice(1),'
      #9#9'  position: '#39'relative'#39','
      
        '          playerVars: { '#39'autoplay'#39': 1, '#39'controls'#39': 2 }, // this ' +
        'is essential for autoplay'
      '          events: {'
      '            '#39'onReady'#39': onPlayerReady,'
      '            '#39'onStateChange'#39': onPlayerStateChange'
      '          }'
      '        });'
      '      }'
      ''
      
        '      // 4. The API will call this function when the video playe' +
        'r is ready.'
      '      function onPlayerReady(event) {'
      '        event.target.playVideo();'
      '      }'
      ''
      
        '      // 5. The API calls this function when the player'#39's state ' +
        'changes.'
      
        '      //    The function indicates that when playing a video (st' +
        'ate=1),'
      
        '      //    the player should play for six seconds and then stop' +
        '.'
      '      var done = false;'
      '      function onPlayerStateChange(event) {'
      '        //if (event.data == YT.PlayerState.PLAYING && !done) {'
      '        //  setTimeout(stopVideo, 6000);'
      '        //  done = true;'
      '        //}'
      '      }'
      '      function stopVideo() {'
      '        player.stopVideo();'
      '      }'
      '    </script>'
      '  </body>'
      '</html>')
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
    WordWrap = False
  end
  object pnlLoading: TPanel
    Left = 0
    Top = 0
    Width = 452
    Height = 174
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlLoading'
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object lblLoading: TbsSkinLabel
      Left = 0
      Top = 0
      Width = 452
      Height = 174
      HintImageIndex = 0
      TabOrder = 0
      SkinData = DM.bsSkinData1
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWhite
      DefaultFont.Height = 21
      DefaultFont.Name = 'Arial Rounded MT Bold'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      Transparent = True
      ShadowEffect = True
      ShadowColor = clWhite
      ShadowOffset = 0
      ShadowSize = 3
      ReflectionEffect = False
      ReflectionOffset = -5
      EllipsType = bsetNoneEllips
      UseSkinSize = False
      UseSkinFontColor = False
      BorderStyle = bvNone
      Alignment = taCenter
      Align = alClient
      Caption = 'Carregando...'
      AutoSize = True
    end
  end
end
