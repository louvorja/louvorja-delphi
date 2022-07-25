{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       SmartEffects                                                }
{       Version 2.98                                                }
{                                                                   }
{       Copyright (c) 2007-2016 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit se_controls;

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Buttons,
  StdCtrls, se_bitmap, se_utils, se_effect, se_ani, ImgList, se_imagelist,
  se_pngimagelist, se_PngImage {$IFDEF VER200},PngImage {$ENDIF};

type

  TseControlButton = record
    R: TRect;
    MouseIn: Boolean;
    Down: Boolean;
    Visible: Boolean;
  end;
  
  TseXButton = class(TGraphicControl)
  private
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    //
    SourceImage, DestImage: TseBitmap;
    FAniIndex: Integer;
    FAnimation: TseAnimation;
    //
    FDoubleBuffered: Boolean;
    FAutoSize: Boolean;
    FMouseInControl: Boolean;
    FPressed: Boolean;
    FImagePressed: TPicture;
    FImageNormal: TPicture;
    FImageHot: TPicture;
    FTransparent: Boolean;
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetImageHot(const Value: TPicture);
    procedure SetImageNormal(const Value: TPicture);
    procedure SetImagePressed(const Value: TPicture);
    procedure SetTransparent(const Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    function CalcDestRect: TRect;
    procedure AdjustSize;
  protected
    function CurGraphic: TGraphic;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Anchors;
    property DoubleBuffered: Boolean read
      FDoubleBuffered write SetDoubleBuffered;
    property AutoSize: boolean read FAutoSize write SetAutoSize;
    property ImageNormal: TPicture read FImageNormal write SetImageNormal;
    property ImageHot: TPicture read FImageHot write SetImageHot;
    property ImagePressed: TPicture read FImagePressed write SetImagePressed;
    property Animation: TseAnimation read FAnimation write FAnimation;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property OnClick;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TseXLabel = class(TGraphicControl)
  private
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    //
    SourceImage, DestImage: TseBitmap;
    FAniIndex: Integer;
    FAnimation: TseAnimation;
    FStopRePaint: Boolean;
    //
    FVistaGlowEffect: Boolean;
    FDoubleBuffered: Boolean;
    FFocusControl: TWinControl;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FLayout: TTextLayout;
    FWordWrap: Boolean;
    FShowAccelChar: Boolean;
    FUseSkinColor: Boolean;
    FBlurColor: TColor;
    FBlurSize: Integer;
    FBlurOffset: Integer;
    procedure SetVistaGlowEffect(Value: Boolean);
    procedure SetBlurColor(Value: TColor);
    procedure SetBlurSize(Value: Integer);
    procedure SetBlurOffset(Value: Integer);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAlignment(Value: TAlignment);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetLayout(Value: TTextLayout);
    procedure SetWordWrap(Value: Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure DrawLabelToBitMap(ABitMap: TseBitmap; AText: String);
  protected
    procedure AdjustBounds; dynamic;
    procedure DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint); dynamic;
    function GetLabelText: string; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure Paint; override;
    procedure SetAutoSize(Value: Boolean); 
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeText(ANewText: String);
  published
    property VistaGlowEffect: Boolean
      read FVistaGlowEffect write SetVistaGlowEffect;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property DoubleBuffered: Boolean read
      FDoubleBuffered write SetDoubleBuffered;
    property BlurSize: Integer read FBlurSize write SetBlurSize;
    property BlurOffset: Integer read FBlurOffset write SetBlurOffset;
    property BlurColor: TColor read FBlurColor write SetBlurColor;
    property Animation: TseAnimation read FAnimation write FAnimation;
    property Caption;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TseReflectLabel = class(TGraphicControl)
  private
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    //
    SourceImage, DestImage: TseBitmap;
    FAniIndex: Integer;
    FAnimation: TseAnimation;
    FStopRePaint: Boolean;
    //
    FReflectionColor: TColor;
    FReflectionOffset: Integer;
    FDoubleBuffered: Boolean;
    FFocusControl: TWinControl;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FLayout: TTextLayout;
    FShowAccelChar: Boolean;
    FUseSkinColor: Boolean;
    procedure SetReflectionColor(Value: TColor);
    procedure SetReflectionOffset(Value: Integer);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAlignment(Value: TAlignment);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetLayout(Value: TTextLayout);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure DrawLabelToBitMap(ABitMap: TseBitmap; AText: String);
  protected
    procedure AdjustBounds; dynamic;
    procedure DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint); dynamic;
    function GetLabelText: string; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
     Operation: TOperation); override;
    procedure Paint; override;
    procedure SetAutoSize(Value: Boolean); 
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override; 
    procedure ChangeText(ANewText: String);
  published
    property ReflectionOffset: Integer
     read FReflectionOffset write SetReflectionOffset;
    property ReflectionColor: TColor
     read FReflectionColor write SetReflectionColor;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property DoubleBuffered: Boolean read
      FDoubleBuffered write SetDoubleBuffered;
    property Animation: TseAnimation read FAnimation write FAnimation;
    property Caption;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TseButtonLabel = class(TGraphicControl)
  protected
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;

    FChecked: Boolean;
    FCheckedMode: Boolean;
    FOnCheckChange: TNotifyEvent;
    //
    FShowCaptionUnderLine: Boolean;
    //
    SourceImage, DestImage: TseBitmap;
    FAniIndex: Integer;
    FAnimation: TseAnimation;
    //
    FGlowColor: TColor;
    FGlowEffect: Boolean;
    FGlowSize: Integer;
    FDoubleBuffered: Boolean;
    FWebStyle: Boolean;
    FMouseIn, FDown: Boolean;
    FActiveFontColor: TColor;
    FDownFontColor: TColor;
    FMargin: Integer;
    FSpacing: Integer;
    FLayout: TseButtonLayout;
    FImageList: TCustomImageList;
    FImageIndex: Integer;
    FActiveImageIndex: Integer;
    procedure SetImageIndex(Value: Integer);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetLayout(Value : TseButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetWebStyle(Value: Boolean);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure CreateButtonImage(C: TCanvas; AActive: Boolean; AChecked: Boolean);
    procedure SetChecked(Value: Boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    property CheckedMode: Boolean read FCheckedMode write FCheckedMode;
    property Checked: Boolean read FChecked write SetChecked;
    property Animation: TseAnimation read FAnimation write FAnimation;
    property GlowColor: TColor read FGlowColor write FGlowColor;
    property GlowEffect: Boolean read FGlowEffect write FGlowEffect;
    property GlowSize: Integer read FGlowSize write FGlowSize;
    property DoubleBuffered: Boolean
      read FDoubleBuffered write SetDoubleBuffered;
    property ImageList: TCustomImageList read FImageList write FImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property ActiveImageIndex: Integer read FActiveImageIndex write FActiveImageIndex;
    property ActiveFontColor: TColor read FActiveFontColor write FActiveFontColor;
    property WebStyle: Boolean read FWebStyle write SetWebStyle;
    property Margin: Integer read FMargin write SetMargin default -1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Layout: TseButtonLayout read FLayout write SetLayout default seblGlyphLeft;
    property ShowCaptionUnderLine: Boolean
      read FShowCaptionUnderLine write FShowCaptionUnderLine;
    property Font;
    property Align;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnCheckChanged: TNotifyEvent read FOnCheckChange write FOnCheckChange;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TseBGDrawType = (seBGTile, seBGStretch, seBGVertStretch, seBGHorzStretch);

  TsePanel = class(TCustomControl)
  private
    FDragX, FDragY: Integer;
    ParentForm: TCustomForm;
    FInDrag: Boolean;
    FOnPrepareAnimation: TNotifyEvent;
    FAnimation: TseAnimation;
    FBGChangeAnimation: TseAnimation;
    FBGImageList: TseImageList;
    FBGImageIndex: Integer;
    FBGDrawType: TseBGDrawType;
    FFormDrag: Boolean;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    procedure SetFormDrag(Value: Boolean);
    procedure SetBGImageIndex(Value: Integer);
    procedure SetBGDrawType(Value: TseBGDrawType);
  protected
    procedure PaintPanel(C: TCanvas);
    procedure PaintTile(C: TCanvas);
    procedure PaintStretch(C: TCanvas);
    procedure PaintHorzStretch(C: TCanvas);
    procedure PaintVertStretch(C: TCanvas);
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure ExecuteAnimation;
    procedure ColorChange(AColor: TColor);
  published
    property FormDrag: Boolean
      read FFormDrag write SetFormDrag;
    property Animation: TseAnimation
      read FAnimation write FAnimation;
    property BGChangeAnimation: TseAnimation
      read FBGChangeAnimation write FBGChangeAnimation;
    property BGDrawType: TseBGDrawType
      read FBGDrawType write SetBGDrawType;
    property BGImageList: TseImageList
      read FBGImageList write FBGImageList;
    property BGImageIndex: Integer
     read FBGImageIndex write SetBGImageIndex;
    property OnPrepareAnimation: TNotifyEvent
      read FOnPrepareAnimation write FOnPrepareAnimation;
    property Color;
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TsePngImagePanel = class(TCustomControl)
  private
    FDown: Boolean;
    FAutoSize: Boolean;
    FMouseIn: Boolean;
    FOnPrepareAnimation: TNotifyEvent;
    FAnimation: TseAnimation;
    FChangeImageAnimation: TseAnimation;
    FPngImageList: TsePngImageList;
    FPngImageStorage: TsePngImageStorage;
    FImageIndex: Integer;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    procedure SetImageIndex(Value: Integer);
    procedure AdjustBounds;
  protected
    procedure SetAutoSize(Value: Boolean);
    procedure PaintPanel(C: TCanvas);
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure StartTimer;
    procedure StopTimer;
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    function CheckControls: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure ExecuteAnimation;
  published
    property AutoSize: boolean read FAutoSize write SetAutoSize;
    
    property Animation: TseAnimation
      read FAnimation write FAnimation;

    property ChangeImageAnimation: TseAnimation
      read FChangeImageAnimation write FChangeImageAnimation;

    property PngImageList: TsePngImageList
      read FPngImageList write FPngImageList;

    property PngImageStorage: TsePngImageStorage
      read FPngImageStorage write FPngImageStorage;

    property ImageIndex: Integer
     read FImageIndex write SetImageIndex;

    property OnPrepareAnimation: TNotifyEvent
      read FOnPrepareAnimation write FOnPrepareAnimation;
    property Color;
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;


  TsePage = class(TCustomControl)
  private
    FBGImageIndex: Integer;
    FBGDrawType: TseBGDrawType;
    procedure SetBGDrawType(Value: TseBGDrawType);
    procedure SetBGImageIndex(Value: Integer);
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Paint; override;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure PaintBG(C: TCanvas);
    procedure PaintTile(C: TCanvas);
    procedure PaintStretch(C: TCanvas);
    procedure PaintHorzStretch(C: TCanvas);
    procedure PaintVertStretch(C: TCanvas);
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Color;
    property BGImageIndex: Integer read FBGImageIndex write SetBGImageIndex;
    property BGDrawType: TseBGDrawType read FBGDrawType write SetBGDrawType;
    property Caption;
    property Height stored False;
    property TabOrder stored False;
    property Visible stored False;
    property Width stored False;
  end;

  TseNoteBook = class(TCustomControl)
  private
    FForceControlUpdate: Boolean;
    FAccess: TStrings;
    FPageIndex: Integer;
    FOnPageChanged: TNotifyEvent;
    FBGImageList: TseImageList;
    FAnimation: TseAnimation;
    procedure SetPages(Value: TStrings);
    procedure SetActivePage(const Value: string);
    function GetActivePage: string;
    procedure SetPageIndex(Value: Integer);
  protected
    function GetChildOwner: TComponent; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ReadState(Reader: TReader); override;
    procedure ShowControl(AControl: TControl); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    FPageList: TList;
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetPage(Index: Integer): TsePage;
    procedure InvalidatePage(Index: Integer);
  published
    property Animation: TseAnimation read FAnimation write FAnimation;
    property ForceControlUpdate: Boolean
      read FForceControlUpdate write FForceControlUpdate;
    property BGImageList: TseImageList read FBGImageList write FBGImageList;
    property ActivePage: string read GetActivePage write SetActivePage stored False;
    property Align;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Font;
    property Enabled;
    property PageIndex: Integer read FPageIndex write SetPageIndex default 0;
    property Pages: TStrings read FAccess write SetPages stored False;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPageChanged: TNotifyEvent read FOnPageChanged write FOnPageChanged;
    property OnStartDrag;
  end;

  // TseToolBarEx ==========================================================

  TseToolBarExItem = class(TCollectionItem)
  private
    FHint: String;
    FImageIndex: TImageIndex;
    FActiveImageIndex: TImageIndex;
    FEnabled: Boolean;
    FOnClick: TNotifyEvent;
    FGlowColor: TColor;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetActiveImageIndex(const Value: TImageIndex); virtual;
    procedure SetEnabled(Value: Boolean); virtual;
  public
    ItemRect: TRect;
    IsVisible: Boolean;
    Active: Boolean;
    Down: Boolean;
    FReflectionBitmap: TseBitmap;
    FReflectionActiveBitmap: TseBitmap;
    FAniIndex: Integer;
    SourceImage, DestImage: TseBitmap;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure InitReflectionBitmaps(AInit: Boolean);
  published
    property GlowColor: TColor  read FGlowColor write FGlowColor;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Hint: String read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property ActiveImageIndex: TImageIndex read FActiveImageIndex
      write SetActiveImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TseToolBarEx = class;

  TseToolBarExItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TseToolBarExItem;
    procedure SetItem(Index: Integer; Value:  TseToolBarExItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    ToolBarEx: TseToolBarEx;
    constructor Create(AListBox: TseToolBarEx);
    property Items[Index: Integer]: TseToolBarExItem read GetItem write SetItem; default;
    function Add: TseToolBarExItem;
    function Insert(Index: Integer): TseToolBarExItem;
    procedure Delete(Index: Integer);
    procedure Clear;
  end;

  TseToolBarExItemOnMouseEvent = procedure(Item: TseToolBarExItem) of object;

  TseToolBarHintWindow = class(THintWindow)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure Paint; override;
  end;   

  TseToolBarEx = class(TsePanel)
  protected
    HW: TseToolBarHintWindow;
    FItemAnimation: TseAnimation;
    FBGBuffer: TseBitmap;
    //
    Buttons: array [0..1] of TseControlButton;
    //
    FArrowImages: TsePngImageList;
    FShowItemHints: Boolean;
    FHintFont: TFont;
    FHintColor: TColor;
    FShowReflection: Boolean;
    FScrollArrowColor: TColor;
    FScrollArrowActiveColor: TColor;
    FOnChange: TNotifyEvent;
    FItemIndex: Integer;
    FHoldSelectedItem: Boolean;
    FScrollIndex, FScrollMax: Integer;
    FCursorColor: TColor;
    FAutoSize: Boolean;
    FItemSpacing: Integer;
    FItems: TseToolBarExItems;
    FImages: TsePngImageList;
    FShowHandPointCursor: Boolean;
    FShowGlow: Boolean;
    FOnMouseEnterItem: TseToolBarExItemOnMouseEvent;
    FOnMouseLeaveItem: TseToolBarExItemOnMouseEvent;
    procedure ShowHint(Item: TseToolBarExItem);
    procedure HideHint;
    procedure SetHintFont(Value: TFont);
    procedure SetItemAnimation(Value: TseAnimation);
    procedure DrawButtons(Cnvs: TCanvas);
    procedure CheckScroll;
    function ItemAtPos(X, Y: Integer): Integer;
    procedure SetAutoSize(Value: Boolean);
    procedure SetItemSpacing(Value: Integer);
    procedure SetItems(Value: TseToolBarExItems);
    procedure SetImages(Value: TsePngImageList);
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    //
    procedure PrepareItemImage(Cnvs: TCanvas; Item: TseToolBarExItem; AActive: Boolean; ARect: TRect);
    procedure DrawItem(Cnvs: TCanvas; Index: Integer);
    procedure CalcItemRects;
    procedure Loaded; override;
    procedure TestActive(X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
     procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure AdjustBounds;
    procedure SetItemIndex(Value: Integer);
    procedure SetShowGlow(Value: Boolean);
    procedure SetShowReflection(Value: Boolean);
    procedure StartAnimation(Item: TseToolBarExItem);
    procedure StopAnimation(Item: TseToolBarExItem);
    procedure StopAllAnimations;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    function GetVisibleCount: Integer;
    procedure SetArrowImages(Value: TsePngImageList);
  public
    MouseInItem, OldMouseInItem: Integer;
    procedure DecScroll;
    procedure IncScroll;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdatedSelected;
    procedure Paint; override;
  published
    property ArrowImages: TsePngImageList read FArrowImages write SetArrowImages;
    property HintFont: TFont read FHintFont write SetHintFont;
    property HintColor: TColor read FHintColor write FHintColor;
    property ShowItemHints: Boolean
      read FShowItemHints write FShowItemHints;
    property ItemAnimation: TseAnimation
      read FItemAnimation write SetItemAnimation;
    property ShowReflecton: Boolean
      read FShowReflection write SetShowReflection;
    property ScrollArrowColor: TColor
      read FScrollArrowColor write FScrollArrowColor;
    property ScrollArrowActiveColor: TColor
      read FScrollArrowActiveColor write FScrollArrowActiveColor;
    property ShowGlow: Boolean read
      FShowGlow write SetShowGlow; 
    property HoldSelectedItem: Boolean
      read FHoldSelectedItem write FHoldSelectedItem;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property ShowHandPointCursor: Boolean
      read FShowHandPointCursor write FShowHandPointCursor; 
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing;
    property Images: TsePngImageList read FImages write SetImages;
    property Items:  TseToolBarExItems read FItems write SetItems;
    property OnMouseEnterItem: TseToolBarExItemOnMouseEvent
      read FOnMouseEnterItem write FOnMouseEnterItem;
    property OnMouseLeaveItem: TseToolBarExItemOnMouseEvent
      read FOnMouseLeaveItem write FOnMouseLeaveItem;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property PopupMenu;
    property Visible;
    property OnClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;


  TsePngImageView = class(TGraphicControl)
  private
    //
    SourceImage, DestImage: TseBitmap;
    FAniIndex: Integer;
    FAnimation: TseAnimation;
    //
    FDoubleBuffered: Boolean;
    FReflectionImage: Pointer;
    FReflectionEffect: Boolean;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    FAutoSize: Boolean;
    FPngImageList: TsePngImageList;
    FPngImageStorage: TsePngImageStorage;
    FImageIndex: Integer;
    FCenter: Boolean;
    procedure PrepareImage(AImageIndex: Integer; ABitmap: TseBitMap);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetCenter(Value: Boolean);
    procedure SetReflectionEffect(Value: Boolean);
    procedure CreateReflection;
    procedure CreateReflectionBitmap(AReflectionImage: TseBitMap; AImageIndex: Integer);
    procedure DestroyReflection;
  protected
    procedure AdjustBounds;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property Animation: TseAnimation read FAnimation write FAnimation;
    property DoubleBuffered: Boolean
      read FDoubleBuffered write SetDoubleBuffered;
    property ReflectionEffect: Boolean
      read FReflectionEffect write SetReflectionEffect;
    property PngImageList: TsePngImageList
      read FPngImageList write FPngImageList;
    property PngImageStorage: TsePngImageStorage
      read FPngImageStorage write FPngImageStorage;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Align;
    property Anchors;
    property Center: Boolean read FCenter write SetCenter default False;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TsePngXButton = class(TGraphicControl)
  private
    SourceImage, DestImage: TseBitmap;
    FAniIndex: Integer;
    FAnimation: TseAnimation;
    //
    FMargin: Integer;
    FSpacing: Integer;
    FLayout: TseButtonLayout;
    //
    FChangeActive: Boolean;
    FChangeDown: Boolean;
    FActiveFontColor: TColor;
    FMouseIn: Boolean;
    FDown: Boolean;
    FDoubleBuffered: Boolean;
    FOnMouseEnter, FOnMouseLeave: TNotifyEvent;
    FAutoSize: Boolean;
    FPngImageList: TsePngImageList;
    FPngImageStorage: TsePngImageStorage;
    FImageIndex: Integer;
    FImageNormalIndex: Integer;
    FImageHotIndex: Integer;
    FImageDownIndex: Integer;
    FGlyphList: TCustomImageList;
    FGlyphIndex: Integer;
    function IsTransparentPixel(X, Y: Integer): Boolean;
    procedure SetImageNormalIndex(Value: Integer);
    procedure PrepareImage(AImageIndex: Integer; ABitmap: TseBitMap; AActive: Boolean);
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetGlyphIndex(Value: Integer);
  protected
    procedure SetLayout(Value : TseButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetSpacing(Value: Integer);
    procedure DrawButtonGlyphAndText(C: TCanvas; AActive: Boolean);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure AdjustBounds;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property DoubleBuffered: Boolean
      read FDoubleBuffered write SetDoubleBuffered;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Margin: Integer read FMargin write SetMargin default -1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Layout: TseButtonLayout read FLayout write SetLayout default seblGlyphLeft;
    property GlyphList: TCustomImageList read FGlyphList write FGlyphList;
    property GlyphIndex: Integer read FGlyphIndex write SetGlyphIndex;
    property ImageNormalIndex: Integer
      read FImageNormalIndex write SetImageNormalIndex;
    property ImageHotIndex: Integer read
      FImageHotIndex write FImageHotIndex;
    property ImageDonwIndex: Integer read
      FImageDownIndex write FImageDownIndex;
    property Animation: TseAnimation read FAnimation write FAnimation;
    property PngImageList: TsePngImageList
      read FPngImageList write FPngImageList;
    property PngImageStorage: TsePngImageStorage
      read FPngImageStorage write FPngImageStorage;
    property ActiveFontColor: TColor
      read FActiveFontColor write FActiveFontColor;
    property Font;
    property Align;
    property Caption;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  end;

  TseLayeredSplashForm = class(TComponent)
  private
    FForm: TForm;
    OldWindowProc: TWndMethod;
    FOnShowAnimation: Boolean;
    FOnHideAnimation: Boolean;
    FFirstShow: Boolean;
    FPngImageStorage: TsePngImageStorage;
    FPngImageIndex: Integer;
    Buffer: TseBitmap;
    FFormVisible: Boolean;
    //
    procedure CreateLayeredSplash;
    procedure UpdateLayeredSplash(AAlphaBlendValue: Integer);
  protected
    procedure NewWndProc(var Message: TMessage);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
                          Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnShowAnimation: Boolean read FOnShowAnimation write FOnShowAnimation;
    property OnHideAnimation: Boolean read FOnHideAnimation write FOnHideAnimation;
    property PngImageStorage: TsePngImageStorage read FPngImageStorage write FPngImageStorage;
    property PngImageIndex: Integer read FPngImageIndex write FPngImageIndex;
  end;
  

procedure NotebookHandlesNeeded(Notebook: TseNotebook);


procedure DrawImageAndText(Cnvs: TCanvas; R: TRect; Margin, Spacing: Integer;
            Layout: TseButtonLayout;
            Caption: String; ImageIndex: Integer; IL: TCustomImageList; ADown: Boolean;
            AEnabled: Boolean; ADrawColorMarker: Boolean; AColorMarkerValue: TColor);

procedure DrawImageAndTextGlow(Cnvs: TCanvas; R: TRect; Margin, Spacing: Integer;
            Layout: TseButtonLayout;
            Caption: String; ImageIndex: Integer; IL: TCustomIMageList; ADown: Boolean;
            AEnabled: Boolean; ADrawColorMarker: Boolean; AColorMarkerValue: TColor;
            FGlowColor: TColor; FGlowSize: Integer);

procedure DrawReflectionText(const Canvas: TCanvas;
  ARect: TRect; const Text: string; const Flags: cardinal;
  const ReflectionOffset: integer = 1;
  const ReflectionColor: cardinal = $202020);


procedure DrawEffectText(const Canvas: TCanvas;
  ARect: TRect; const Text: string; const Flags: cardinal; // std text params - like DrawText
  const ShadowDistance: integer = 1;
  const ShadowColor: cardinal = $202020;
  const BlurRadius: integer = 1);

procedure DrawEffectText2(const Canvas: TCanvas;
  ARect: TRect; const Text: string; const Flags: cardinal; // std text params - like DrawText
  const ShadowDistance: integer = 1;
  const ShadowColor: cardinal = $202020;
  const BlurRadius: integer = 1);

procedure MakeCopyFromPng(B : TseBitMap; P: TsePngImage);
procedure MakeBlurBlank(B :TseBitMap; P: TsePngImage; BlurSize: Integer);
procedure MakeBlurBlank2(B :TseBitMap; SB: TBitmap; BlurSize: Integer);
procedure MakeBlurBlank3(B :TseBitMap; IL: TCustomImageList; Index: Integer; BlurSize: Integer);

implementation
   Uses se_winapi;

const
  WS_EX_LAYERED = $80000;

type
  THackControl = class(TControl);
  PIntArray = ^TIntArray;
  TIntArray = array [0..0] of integer;

function Max(A, B: Longint): Longint;
begin
  if A > B then Result := A
  else Result := B;
end;

function Min(A, B: Longint): Longint;
begin
  if A < B then Result := A
  else Result := B;
end;

// =============================================================================
procedure MakeCopyFromPng(B :TseBitMap; P: TsePngImage);
var
  X, Y: Integer;
  {$IFNDEF VER200}
  Line: se_PngImage.PByteArray;
  {$ELSE}
  Line: PByteArray;
  {$ENDIF}
  C: TseColor;
  DstP: PseColor;
begin
  B.SetSize(P.Width, P.Height);
  for Y := 0 to P.Height - 1 do
   begin
     Line := P.AlphaScanline[Y];
     for X := 0 to P.Width - 1 do
     begin
       DstP := B.PixelPtr[X, Y];
       DstP^ := seColor(P.Pixels[X, Y], $FF);
       TseColorRec(DstP^).A := Line^[X];
     end;
   end;
  B.CheckingAlphaBlend;
end;

procedure MakeBlurBlank3(B :TseBitMap; IL: TCustomImageList; Index: Integer; BlurSize: Integer);
var
  X, Y: Integer;
  B1: TseBitMap;
  DstP: PseColor;
  DstP1: PseColor;
  C, C1: TseColor;
  SB: TBitMap;
begin
  if IL is TsePngImageList
  then
    begin
      MakeBlurBlank(B, TsePngImageList(IL).PngImages.Items[Index].PngImage, BlurSize);
      Exit;
    end
  else
    begin
      SB := TBitMap.Create;
      IL.GetBitmap(Index, SB);
      if SB.Empty
      then
        begin
          SB.Free;
          Exit;
        end;
    end;
  B1 := TseBitMap.Create;
  B1.Assign(SB);
  C1 := B1.Pixels[0, 0];
  for X := 0 to B1.Width - 1 do
   begin
     for Y := 0 to B1.Height - 1 do
     begin
       C := B1.Pixels[X, Y];
       DstP := B1.PixelPtr[X, Y];
       if C <> C1
       then
         DstP^ := seColor($FF);
     end;
   end;
  B1.CheckingTransparent(B1.Pixels[0, 0]);
  B1.Draw(B.Canvas, BlurSize, BlurSize);
  B1.Draw(B.Canvas, BlurSize - 1, BlurSize - 1);
  B1.Draw(B.Canvas, BlurSize + 1, BlurSize + 1);
  SB.Free;
  B1.Free;
end;

procedure MakeBlurBlank2(B :TseBitMap; SB: TBitmap; BlurSize: Integer);
var
  X, Y: Integer;
  B1: TseBitMap;
  DstP: PseColor;
  DstP1: PseColor;
  C, C1: TseColor;
begin
  B1 := TseBitMap.Create;
  B1.Assign(SB);
  C1 := B1.Pixels[0, 0];
  for X := 0 to B1.Width - 1 do
   begin
     for Y := 0 to B1.Height - 1 do
     begin
       C := B1.Pixels[X, Y];
       DstP := B1.PixelPtr[X, Y];
       if C <> C1
       then
         DstP^ := seColor($FF);
     end;
   end;
  B1.CheckingTransparent(B1.Pixels[0, 0]);
  B1.Draw(B.Canvas, BlurSize, BlurSize);
  B1.Draw(B.Canvas, BlurSize - 1, BlurSize - 1);
  B1.Draw(B.Canvas, BlurSize + 1, BlurSize + 1);
  B1.Free;
end;


procedure MakeBlurBlank(B :TseBitMap; P: TsePngImage; BlurSize: Integer);
var
  X, Y: Integer;
  {$IFNDEF VER200}
  Line: se_PngImage.PByteArray;
  {$ELSE}
  Line: PByteArray;
  {$ENDIF}
  C: TseColor;
  DstP: PseColor;
begin
  for Y := 0 to P.Height - 1 do
   begin
     Line := P.AlphaScanline[Y];
     for X := 0 to P.Width - 1 do
     begin
       DstP := B.PixelPtr[X + BlurSize, Y + BlurSize];
       if Line^[X] <> 0
       then
          DstP^ := seColor($FF, $FF);
     end;
   end;
  B.CheckingAlphaBlend;
end;
// =============================================================================
procedure DrawReflectionText(const Canvas: TCanvas;
  ARect: TRect; const Text: string; const Flags: cardinal;
  const ReflectionOffset: integer = 1;
  const ReflectionColor: cardinal = $202020);
var
  B: TseBitmap;
  R, R1: TRect;
  i, j: integer;
  Line: PseColorArray;
  Transparency: single;
begin
  R := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
  B := TseBitmap.Create;
  B.SetSize(R.Right, R.Bottom);
  B.Canvas.Font.Assign(Canvas.Font);
  B.Canvas.Font.Color := $FF; // blue
  B.Canvas.Brush.Style := bsClear;
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R, Flags);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R, Flags or DT_CALCRECT);
  R1 := ARect;
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R1, Flags or DT_CALCRECT);
  if R.Bottom - R.Top > 0 then
    for j := 0 to B.Height - 1 do
    begin
      if (j < R.Top) or (j > R.Bottom) then
      begin
        FillChar(B.Scanline[j]^, B.Width * 4, 0);
        Continue;
      end;
      for i := 0 to B.Width - 1 do
      begin
        Transparency := 0.7 - (R.Bottom - (j - R.Top)) / (R.Bottom - R.Top);
        if Transparency < 0 then
          Transparency := 0;
        PseColorRec(B.PixelPtr[i, j]).Color := FromRGB(ReflectionColor) and
        not $FF000000 or
        ((Trunc(PseColorRec(B.PixelPtr[i, j]).R * Transparency) shl 24));
      end;
    end;
  GetMem(Line, B.Width * 4);
  for j := 0 to (B.Height div 2) - 1 do
  begin
    Move(B.Scanline[j]^, Line^, B.Width * 4);
    Move(B.Scanline[B.Height - 1 - j]^, B.Scanline[j]^, B.Width * 4);
    Move(Line^, B.Scanline[B.Height - 1 - j]^, B.Width * 4);
  end;
  FreeMem(Line, B.Width * 4);
  B.AlphaBlend := true;
  B.Draw(Canvas, ARect.Left, R1.Bottom - (B.Height - R.Bottom) + ReflectionOffset);
  B.Free;
  Canvas.Brush.Style := bsClear;
  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), ARect, Flags);
end;


procedure DrawEffectText(const Canvas: TCanvas;
  ARect: TRect; const Text: string; const Flags: cardinal; // std text params - like DrawText
  const ShadowDistance: integer = 1;
  const ShadowColor: cardinal = $202020;
  const BlurRadius: integer = 1);
var
  B: TseBitmap;
  R: TRect;
  i, j: integer;
begin
  R := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
  B := TseBitmap.Create;
  B.SetSize(R.Right + BlurRadius * 2, R.Bottom + BlurRadius * 2);
  B.Canvas.Font.Assign(Canvas.Font);
  B.Canvas.Font.Color := $FF; // blue
  B.Canvas.Brush.Style := bsClear;
  R := Rect(BlurRadius, BlurRadius, B.Width - BlurRadius, B.Height - BlurRadius);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R, Flags);
  Blur(B, BlurRadius);
  for i := 0 to B.Width - 1 do
    for j := 0 to B.Height - 1 do
    begin
      PseColorRec(B.PixelPtr[i, j]).Color := FromRGB(ShadowColor) and not $FF000000 or (PseColorRec(B.PixelPtr[i, j]).R shl 24);
    end;
  B.AlphaBlend := true;
  B.Draw(Canvas, ARect.Left + ShadowDistance - BlurRadius, ARect.Top + ShadowDistance - BlurRadius);
  B.Free;
  Canvas.Brush.Style := bsClear;
  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), ARect, Flags);
end;

procedure DrawEffectText2(const Canvas: TCanvas;
  ARect: TRect; const Text: string; const Flags: cardinal; // std text params - like DrawText
  const ShadowDistance: integer = 1;
  const ShadowColor: cardinal = $202020;
  const BlurRadius: integer = 1);
var
  B: TseBitmap;
  R, R1: TRect;
  i, j: integer;
begin
  R := Rect(0, 0, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
  B := TseBitmap.Create;
  B.SetSize(R.Right + BlurRadius * 2, R.Bottom + BlurRadius * 2);
  B.Canvas.Font.Assign(Canvas.Font);
  B.Canvas.Font.Color := $FF; // blue
  B.Canvas.Brush.Style := bsClear;
  R := Rect(BlurRadius, BlurRadius, B.Width - BlurRadius, B.Height - BlurRadius);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R, Flags);
  R1 := R;
  OffsetRect(R1, -1, 0);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R1, Flags);
  OffsetRect(R1, 2, 0);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R1, Flags);
  OffsetRect(R1, -1, -1);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R1, Flags);
  OffsetRect(R1, 0, 2);
  Windows.DrawText(B.Canvas.Handle, PChar(Text), Length(Text), R1, Flags);
  Blur(B, BlurRadius);
  for i := 0 to B.Width - 1 do
    for j := 0 to B.Height - 1 do
    begin
      PseColorRec(B.PixelPtr[i, j]).Color := FromRGB(ShadowColor) and
        not $FF000000 or (PseColorRec(B.PixelPtr[i, j]).R shl 24);
    end;
  B.AlphaBlend := true;
  B.Draw(Canvas, ARect.Left + ShadowDistance - BlurRadius, ARect.Top + ShadowDistance - BlurRadius);
  B.Free;
  Canvas.Brush.Style := bsClear;
  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), ARect, Flags);
end;

procedure CalcLCoord(Layout: TseButtonLayout; R: TRect; gw, gh, tw, th: Integer;
  Spacing, Margin: Integer; var tx, ty, gx, gy: Integer);
var
  H, W, H1, W1: Integer;
begin
 H := R.Top + RectHeight(R) div 2;
 W := R.Left + RectWidth(R) div 2;
 if gw = 0 then Spacing := 0;
 if Margin = -1
 then
   begin
     W1 := (tw + gw + Spacing) div 2;
     H1 := (th + gh + Spacing) div 2;
     case Layout of
       seblGlyphRight:
         begin
           tx := W - W1;
           ty := H - th div 2;
           gx := W + W1 - gw;
           gy := H - gh div 2;
         end;
      seblGlyphLeft:
         begin
           gx := W - W1;
           gy := H - gh div 2;
           tx := W + W1 - tw;
           ty := H - th div 2;
         end;
      seblGlyphTop:
         begin
           tx := W - tw div 2;
           ty := H + H1 - th;
           gx := W - gw div 2;
           gy := H - H1;
        end;
     seblGlyphBottom:
        begin
          gx := W - gw div 2;
          gy := H + H1 - gh;
          tx := W - tw div 2;
          ty := H - H1;
       end;
     end;
   end
 else
   begin
     case Layout of
       seblGlyphRight:
         begin
           gy := H - gh div 2;
           gx := R.Right - gw - Margin;
           tx := gx - Spacing - tw;
           ty := H - th div 2;
         end;
       seblGlyphLeft:
         begin
           gy := H - gh div 2;
           gx := R.Left + Margin;
           tx := gx + gw + Spacing;
           ty := H - th div 2;
         end;
       seblGlyphTop:
          begin
            gy := R.Top +  Margin;
            gx := W - gw div 2;
            ty := gy + gh + Spacing;
            tx := W - tw div 2;
          end;
      seblGlyphBottom:
          begin
            gy := R.Bottom - gh - Margin;
            gx := W - gw div 2;
            ty := gy - Spacing - th;
            tx := W - tw div 2;
         end;
       end;
    end;
end;


procedure DrawImageAndText(Cnvs: TCanvas; R: TRect; Margin, Spacing: Integer;
            Layout: TseButtonLayout;
            Caption: String; ImageIndex: Integer; IL: TCustomIMageList; ADown: Boolean;
            AEnabled: Boolean; ADrawColorMarker: Boolean; AColorMarkerValue: TColor);

var
  gw, gh: Integer;
  tw, th: Integer;
  TX, TY, GX, GY: Integer;
  TR: TRect;
begin
  if (ImageIndex < 0) or (IL = nil) or (ImageIndex >= IL.Count)
  then
    begin
      gw := 0;
      gh := 0;
    end
  else
    begin
      gw := IL.Width;
      gh := IL.Height;
    end;
  with Cnvs do
  begin
    if Caption = ''
    then
      begin
        tw := 0;
        th := 0;
      end
    else
      begin
        TR := Rect(0, 0, RectWidth(R), RectHeight(R));
        if (Layout = seblGlyphLeft) or (Layout = seblGlyphRight)
        then
          begin
            Dec(TR.Right, gw);
          end
        else
        if (Layout = seblGlyphTop) or (Layout = seblGlyphBottom)
        then
          begin
            Dec(TR.Bottom, gh);
          end;
        Windows.DrawText(Handle, PChar(Caption), Length(Caption), TR,
             DT_EXPANDTABS or DT_WORDBREAK or DT_CALCRECT);
        tw := RectWidth(TR);
        th := RectHeight(TR);
      end;
    Brush.Style := bsClear;
  end;
  CalcLCoord(Layout, R, gw, gh, tw, th, Spacing, Margin, TX, TY, GX, GY);
  if ADown
  then
    begin
      Inc(GX); Inc(GY);
      Inc(TX); Inc(TY);
    end;
  if Caption <> ''
  then
    begin
      TR := Rect(TX, TY, TX + tw, TY + th);
      Inc(TR.Right, 2);
      Windows.DrawText(Cnvs.Handle, PChar(Caption), Length(Caption), TR, DT_EXPANDTABS or DT_VCENTER or DT_CENTER or DT_WORDBREAK);
    end;
  if gw <> 0
  then
    begin
      IL.Draw(Cnvs, GX, GY, ImageIndex, AEnabled);
      if ADrawColorMarker
      then
        with Cnvs do
        begin
          Pen.Color := AColorMarkerValue;
          MoveTo(GX, GY + IL.Height - 2);
          LineTo(GX + IL.Width, GY + IL.Height - 2);
          MoveTo(GX, GY + IL.Height - 1);
          LineTo(GX + IL.Width, GY + IL.Height - 1);
          MoveTo(GX, GY + IL.Height);
          LineTo(GX + IL.Width, GY + IL.Height);
        end;
    end
  else
    if ADrawColorMarker
    then
      with Cnvs do
      begin
        if Caption <> ''
        then
          begin
            Pen.Color := AColorMarkerValue;
            MoveTo(TR.Left, TR.Bottom  - 1);
            LineTo(TR.Right, TR.Bottom  - 1);
            MoveTo(TR.Left, TR.Bottom );
            LineTo(TR.Right, TR.Bottom);
            MoveTo(TR.Left, TR.Bottom  + 1);
            LineTo(TR.Right, TR.Bottom  + 1);
          end
        else
          begin
            Brush.Color := AColorMarkerValue;
            Brush.Style := bsSolid;
            FillRect(Rect(R.Left + 4, R.Top + 4, R.Right - 2, R.Bottom - 4));
          end;
     end;
end;

procedure DrawImageAndTextGlow;

var
  gw, gh: Integer;
  tw, th: Integer;
  i, j, TX, TY, GX, GY: Integer;
  TR: TRect;
  B: TseBitmap;
begin
  if (ImageIndex < 0) or (IL = nil) or (ImageIndex >= IL.Count)
  then
    begin
      gw := 0;
      gh := 0;
    end
  else
    begin
      gw := IL.Width;
      gh := IL.Height;
    end;
  with Cnvs do
  begin
    if Caption = ''
    then
      begin
        tw := 0;
        th := 0;
      end
    else
      begin
        TR := Rect(0, 0, RectWidth(R), RectHeight(R));
        if (Layout = seblGlyphLeft) or (Layout = seblGlyphRight)
        then
          begin
            Dec(TR.Right, gw);
          end
        else
        if (Layout = seblGlyphTop) or (Layout = seblGlyphBottom)
        then
          begin
            Dec(TR.Bottom, gh);
          end;
        Windows.DrawText(Handle, PChar(Caption), Length(Caption), TR,
                 DT_EXPANDTABS or DT_WORDBREAK or DT_CALCRECT);
        tw := RectWidth(TR);
        th := RectHeight(TR);
      end;
    Brush.Style := bsClear;
  end;
  CalcLCoord(Layout, R, gw, gh, tw, th, Spacing, Margin, TX, TY, GX, GY);
  if ADown
  then
    begin
      Inc(GX); Inc(GY);
      Inc(TX); Inc(TY);
    end;

  if gw <> 0
  then
    begin
      B := TseBitMap.Create;
      B.SetSize(IL.Width + FGlowSize * 2, IL.Height + FGlowSize * 2);
      MakeBlurBlank3(B, IL, ImageIndex, FGlowSize);
      Blur(B, FGlowSize);
      for i := 0 to B.Width - 1 do
        for j := 0 to B.Height - 1 do
          begin
            PseColorRec(B.PixelPtr[i, j]).Color := FromRGB(FGlowColor) and
            not $FF000000 or (PseColorRec(B.PixelPtr[i, j]).R shl 24);
          end;
      B.AlphaBlend := true;
      B.Draw(Cnvs, GX - FGlowSize, GY - FGlowSize);
      B.Free;
    end;

  if Caption <> ''
  then
    begin
      TR := Rect(TX, TY, TX + tw, TY + th);
      Inc(TR.Right, 2);
      DrawEffectText2(Cnvs, TR, Caption, DT_EXPANDTABS or DT_VCENTER or DT_CENTER or DT_WORDBREAK,
          0, FGlowColor, FGlowSize);
    end;
  if gw <> 0
  then
    begin
      IL.Draw(Cnvs, GX, GY, ImageIndex, AEnabled);
      if ADrawColorMarker
      then
        with Cnvs do
        begin
          Pen.Color := AColorMarkerValue;
          MoveTo(GX, GY + IL.Height - 2);
          LineTo(GX + IL.Width, GY + IL.Height - 2);
          MoveTo(GX, GY + IL.Height - 1);
          LineTo(GX + IL.Width, GY + IL.Height - 1);
          MoveTo(GX, GY + IL.Height);
          LineTo(GX + IL.Width, GY + IL.Height);
        end;
    end
  else
    if ADrawColorMarker
    then
      with Cnvs do
      begin
        if Caption <> ''
        then
          begin
            Pen.Color := AColorMarkerValue;
            MoveTo(TR.Left, TR.Bottom  - 1);
            LineTo(TR.Right, TR.Bottom  - 1);
            MoveTo(TR.Left, TR.Bottom );
            LineTo(TR.Right, TR.Bottom);
            MoveTo(TR.Left, TR.Bottom  + 1);
            LineTo(TR.Right, TR.Bottom  + 1);
          end
        else
          begin
            Brush.Color := AColorMarkerValue;
            Brush.Style := bsSolid;
            FillRect(Rect(R.Left + 4, R.Top + 4, R.Right - 2, R.Bottom - 4));
          end;
     end;
end;
// =============================================================================

procedure Blur(const Bitmap: TseBitmap; const Radius: integer);
var
  pix: PseColorArray;
  w, h, wm, hm, wh, vdiv: integer;
  rsum,gsum,bsum,x,y,i,yp,yi,yw: integer;
  P: cardinal;
  divsum: integer;
  stackpointer, stackstart: integer;
  sir: PseColorRec;
  rbs, r1, routsum, goutsum, boutsum, rinsum, ginsum, binsum: integer;
  dv: PIntArray;
  vmin: PIntArray;
  r, g, b: PIntArray;
  stack: PseColorArray;
begin
  if (radius<1) then Exit;

  pix := Bitmap.Scanline[0];

  w := Bitmap.width;
  h := Bitmap.height;
  wm := w - 1;
  hm := h - 1;
  wh := w * h;
  vdiv := radius + radius + 1;

  GetMem(r, wh * SizeOf(Integer));
  GetMem(g, wh * SizeOf(Integer));
  GetMem(b, wh * SizeOf(Integer));
  GetMem(vmin, max(w, h) * SizeOf(Integer));
  divsum := (vdiv + 1) shr 1;
  divsum := divsum * divsum;
  GetMem(dv, 256 * divsum * SizeOf(Integer));
  for i := 0 to 256 * divsum - 1 do
    dv[i] := (i div divsum);

  yw := 0;
  yi := 0;

  GetMem(stack, vdiv * SizeOf(TseColor));

  r1 := radius + 1;

  for y := 0 to h - 1 do
  begin
    rinsum := 0;
    ginsum := 0;
    binsum := 0;
    routsum := 0;
    goutsum := 0;
    boutsum := 0;
    rsum := 0;
    gsum := 0;
    bsum :=0;
    for i := -radius to radius do
    begin
      p := pix[yi+min(wm,max(i,0))];
      sir := @stack[i + radius];
      sir.Color := p;
      rbs := r1-abs(i);
      rsum := rsum + (sir.r*rbs);
      gsum := gsum + (sir.g*rbs);
      bsum := bsum + (sir.b*rbs);
      if (i > 0) then
      begin
        rinsum := rinsum + sir.r;
        ginsum := ginsum + sir.g;
        binsum := binsum + sir.b;
      end else
      begin
        routsum := routsum + sir.r;
        goutsum := goutsum + sir.g;
        boutsum := boutsum + sir.b;
      end
    end;
    stackpointer := radius;

    for x := 0 to w - 1 do
    begin
      r[yi] := dv[rsum];
      g[yi] := dv[gsum];
      b[yi] := dv[bsum];

      rsum := rsum - routsum;
      gsum := gsum - goutsum;
      bsum := bsum - boutsum;

      stackstart := stackpointer-radius+vdiv;
      sir := @stack[stackstart mod vdiv];

      routsum := routsum - sir.r;
      goutsum := goutsum - sir.g;
      boutsum := boutsum - sir.b;

      if (y=0)then
      begin
        vmin[x] := min(x+radius+1,wm);
      end;                            
      p := pix[yw+vmin[x]];
      sir.color := p;

      rinsum := rinsum + sir.r;
      ginsum := ginsum + sir.g;
      binsum := binsum + sir.b;

      rsum := rsum + rinsum;
      gsum := gsum + ginsum;
      bsum := bsum + binsum;

      stackpointer :=(stackpointer+1) mod vdiv;
      sir := @stack[(stackpointer) mod vdiv];

      routsum := routsum + sir.r;
      goutsum := goutsum + sir.g;
      boutsum := boutsum + sir.b;

      rinsum := rinsum - sir.r;
      ginsum := ginsum - sir.g;
      binsum := binsum - sir.b;

      yi := yi + 1;
    end;
    yw := yw + w;
  end;

  for x := 0 to w - 1 do
  begin
    rinsum := 0;
    ginsum := 0;
    binsum := 0;
    routsum := 0;
    goutsum := 0;
    boutsum := 0;
    rsum := 0;
    gsum := 0;
    bsum :=0;
    yp := -radius * w;
    for i := -radius to radius do
    begin
      yi := max(0,yp) + x;

      sir := @stack[i+radius];

      sir.r := r[yi];
      sir.g := g[yi];
      sir.b := b[yi];

      rbs := r1 - abs(i);

      rsum := rsum + (r[yi]*rbs);
      gsum := gsum + (g[yi]*rbs);
      bsum := bsum + (b[yi]*rbs);

      if (i > 0)then
      begin
        rinsum := rinsum + sir.r;
        ginsum := ginsum + sir.g;
        binsum := binsum + sir.b;
      end else
      begin
        routsum := routsum + sir.r;
        goutsum := goutsum + sir.g;
        boutsum := boutsum + sir.b;
      end;

      if (i < hm) then
      begin
        yp := yp + w;
      end
    end;
    yi := x;
    stackpointer := radius;
    for y := 0 to h - 1 do
    begin
      pix[yi] := $FF000000 or (dv[rsum] shl 16) or (dv[gsum] shl 8) or dv[bsum];

      rsum := rsum - routsum;
      gsum := gsum - goutsum;
      bsum := bsum - boutsum;

      stackstart := stackpointer-radius+vdiv;
      sir := @stack[stackstart mod vdiv];

      routsum := routsum - sir.r;
      goutsum := goutsum - sir.g;
      boutsum := boutsum - sir.b;

      if (x = 0) then
      begin
        vmin[y] := min(y+r1,hm)*w;
      end;
      p := x + vmin[y];

      sir.r := r[p];
      sir.g := g[p];
      sir.b := b[p];

      rinsum := rinsum + sir.r;
      ginsum := ginsum + sir.g;
      binsum := binsum + sir.b;

      rsum := rsum + rinsum;
      gsum := gsum + ginsum;
      bsum := bsum + binsum;

      stackpointer := (stackpointer + 1) mod vdiv;
      sir := @stack[stackpointer];

      routsum := routsum + sir.r;
      goutsum := goutsum + sir.g;
      boutsum := boutsum + sir.b;

      rinsum := rinsum - sir.r;
      ginsum := ginsum - sir.g;
      binsum := binsum - sir.b;

      yi := yi + w;
    end;
  end;
  FreeMem(stack, vdiv * SizeOf(TseColor));
  FreeMem(dv, 256 * divsum * SizeOf(Integer));
  FreeMem(vmin, max(w, h) * SizeOf(Integer));
  FreeMem(r, wh * SizeOf(Integer));
  FreeMem(g, wh * SizeOf(Integer));
  FreeMem(b, wh * SizeOf(Integer));
end;





constructor TseXButton.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  //
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
  FAniIndex := -1;
  FAniIndex := ReserveIndex;
  //
  FDoubleBuffered := True;
  FAutoSize := True;
  FImageNormal := TPicture.Create;
  FImageHot := TPicture.Create;
  FImagePressed := TPicture.Create;
  Width := 70;
  Height := 70;
end;

destructor TseXButton.Destroy;
begin
  StopMultiAnimation(FAniIndex);
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  //
  FImageNormal.Free;
  FImageHot.Free;
  FImagePressed.Free;
  inherited;
end;

procedure TseXButton.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value
  then
    FAutoSize := Value;
  if FAutoSize then AdjustSize;
end;

function TseXButton.CalcDestRect: TRect;
begin
  Result := Rect(0, 0, Width, Height);
  if FImageNormal.Graphic <> nil then
    Result := Rect((Width - FImageNormal.Width) div 2, (Height - FImageNormal.Height) div 2,
     (Width - FImageNormal.Width) div 2 + FImageNormal.Width, (Height - FImageNormal.Height) div 2 + FImageNormal.Height);
end;

function TseXButton.CurGraphic: TGraphic;
begin
  Result := FImageNormal.Graphic;
  if FPressed and (FImagePressed.Graphic <> nil) and FMouseInControl then
  begin
    Result := FImagePressed.Graphic;
  end
  else
    if FMouseInControl and (FImageHot.Graphic <> nil) then
    begin
      Result := FImageHot.Graphic;
    end;
end;

procedure TseXButton.CMMouseEnter;
begin
  inherited;
  if not Enabled then Exit;
  if FAnimation = nil
  then
    begin
      FMouseInControl := True;
      RePaint;
      Exit;
    end;
  //
  StopMultiAnimation(FAniIndex);
  SourceImage.SetSize(Width, Height);
  if FTransparent then  GetParentImage(Self, SourceImage.Canvas);
  if CurGraphic <> nil then SourceImage.DrawGraphic(CurGraphic, CalcDestRect);
  FMouseInControl := true;
  DestImage.SetSize(Width, Height);
  if FTransparent then GetParentImage(Self, DestImage.Canvas);
  if CurGraphic <> nil then DestImage.DrawGraphic(CurGraphic, CalcDestRect);
  //
  StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
end;

procedure TseXButton.CMMouseLeave;
begin
  inherited;
  if not Enabled then Exit;
  if FAnimation = nil
  then
    begin
      FMouseInControl := False;
      RePaint;
      Exit;
    end;
  //
  StopMultiAnimation(FAniIndex);
  SourceImage.SetSize(Width, Height);
  if FTransparent then GetParentImage(Self, SourceImage.Canvas);
  if CurGraphic <> nil then SourceImage.DrawGraphic(CurGraphic, CalcDestRect);
  FMouseInControl := false;
  DestImage.SetSize(Width, Height);
  if FTransparent then GetParentImage(Self, DestImage.Canvas);
  if CurGraphic <> nil then DestImage.DrawGraphic(CurGraphic, CalcDestRect);
  //
  StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
end;

procedure TseXButton.Paint;
var
  C: TCanvas;
  FBuffer: TseBitMap;
begin

  if FDoubleBuffered
  then
    begin
      FBuffer := TseBitmap.Create;
      FBuffer.SetSize(Width, Height);
      GetParentImage(Self, FBuffer.Canvas);
      C := FBuffer.Canvas;
    end
  else
     C := Canvas;



  if (csDesigning in ComponentState) and (FImageNormal.Graphic = nil)
  then
    with C do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;

  if FPressed and (FImagePressed.Graphic <> nil) and FMouseInControl then
  begin
    FImagePressed.Graphic.Transparent := FTransparent;
    C.Draw((Width - FImageNormal.Width) div 2, (Height - FImageNormal.Height) div 2, FImagePressed.Graphic)
  end
  else
    if FMouseInControl and (FImageHot.Graphic <> nil) then
    begin
      FImageHot.Graphic.Transparent := FTransparent;
      C.Draw((Width - FImageNormal.Width) div 2, (Height - FImageNormal.Height) div 2, FImageHot.Graphic)
    end
    else
      if FImageNormal.Graphic <> nil then
      begin
        FImageNormal.Graphic.Transparent := FTransparent;
        C.Draw((Width - FImageNormal.Width) div 2, (Height - FImageNormal.Height) div 2, FImageNormal.Graphic);
      end;

  if FDoubleBuffered
  then
    begin
      FBuffer.Draw(Canvas, 0, 0);
      FBuffer.Free;
    end;
end;

procedure TseXButton.SetImageHot(const Value: TPicture);
begin
  FImageHot.Assign(Value);
end;

procedure TseXButton.AdjustSize;
begin
  if (FImageNormal.Graphic <> nil)
  then
    begin
      Width := FImageNormal.Graphic.Width;
      Height := FImageNormal.Graphic.Height;
    end;
end;

procedure TseXButton.SetImageNormal(const Value: TPicture);
begin
  FImageNormal.Assign(Value);
  if FAutoSize then AdjustSize;
end;

procedure TseXButton.SetImagePressed(const Value: TPicture);
begin
  FImagePressed.Assign(Value);
end;

procedure TseXButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  {$IFDEF VER150_UP}
  if ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and FMouseInControl and FPressed
  then
    Perform(CM_MOUSELEAVE, 0, 0)
  else
  if not ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and not FMouseInControl and FPressed
  then
    Perform(CM_MOUSEENTER, 0, 0);
  {$ENDIF}
end;

procedure TseXButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if not Enabled then Exit;
  if FAnimation = nil
  then
    begin
      FPressed := True;
      RePaint;
      Exit;
    end;
  StopMultiAnimation(FAniIndex);
  SourceImage.SetSize(Width, Height);
  if FTransparent  then  GetParentImage(Self, SourceImage.Canvas);
  if CurGraphic <> nil then SourceImage.DrawGraphic(CurGraphic, CalcDestRect);
  FPressed := True;
  DestImage.SetSize(Width, Height);
  if FTransparent then GetParentImage(Self, DestImage.Canvas);
  if CurGraphic <> nil then DestImage.DrawGraphic(CurGraphic, CalcDestRect);
  //
  StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
end;

procedure TseXButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if not Enabled then Exit;
  if FAnimation = nil
  then
    begin
      FPressed := False;
      RePaint;
      Exit;
    end;
  StopMultiAnimation(FAniIndex);
  SourceImage.SetSize(Width, Height);
  if FTransparent then GetParentImage(Self, SourceImage.Canvas);
  if CurGraphic <> nil then SourceImage.DrawGraphic(CurGraphic, CalcDestRect);
  FPressed := false;
  DestImage.SetSize(Width, Height);
  if FTransparent then GetParentImage(Self, DestImage.Canvas);
  if CurGraphic <> nil then DestImage.DrawGraphic(CurGraphic, CalcDestRect);
  //
  StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
end;

procedure TseXButton.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Invalidate;
  end;
end;

procedure TseXButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FAnimation) then
    FAnimation := nil;
end;

procedure TseXButton.SetDoubleBuffered;
begin
  if Value <> FDoubleBuffered
  then
    begin
      FDoubleBuffered := Value;
      if FDoubleBuffered
      then ControlStyle := ControlStyle + [csOpaque]
      else ControlStyle := ControlStyle - [csOpaque];
    end;
end;

constructor TseXLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  FStopRePaint := False;
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
  FAniIndex := -1;
  FAniIndex := ReserveIndex;
  FVistaGlowEffect := False;
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  FDoubleBuffered := False;
  FBlurColor := clBlack;
  FBlurOffset := 0;
  FBlurSize := 2;
end;

destructor TseXLabel.Destroy;
begin
  StopMultiAnimation(FAniIndex);
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  inherited;
end;

procedure TseXLabel.CMMouseEnter;
begin
  inherited;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;


procedure TseXLabel.CMMouseLeave;
begin
  inherited;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TseXLabel.SetVistaGlowEffect(Value: Boolean);
begin
  if Value <> FVistaGlowEffect
  then
    begin
      FVistaGlowEffect := Value;
      if FVistaGlowEffect then FBlurSize := 8;
      RePaint;
    end;
end;

procedure TseXLabel.SetBlurColor(Value: TColor);
begin
  if Value <> FBlurColor
  then
    begin
      FBlurColor := Value;
      RePaint;
    end;
end;

procedure TseXLabel.SetBlurSize(Value: Integer);
begin
  if (Value <> FBlurSize) and (Value > 0) and (Value < 11)
  then
    begin
      FBlurSize := Value;
      RePaint;
    end;
end;

procedure TseXLabel.SetBlurOffset(Value: Integer);
begin
  if (Value <> FBlurOffset) and (Value >= 0) and (Value < 101)
  then
    begin
      FBlurOffset := Value;
      RePaint;
    end;
end;

procedure TseXLabel.SetDoubleBuffered;
begin
  if Value <> FDoubleBuffered
  then
    begin
      FDoubleBuffered := Value;
      if FDoubleBuffered
      then ControlStyle := ControlStyle + [csOpaque]
      else ControlStyle := ControlStyle - [csOpaque];
    end;
end;

function TseXLabel.GetLabelText: string;
begin
  Result := Caption;
end;

procedure TseXLabel.WMMOVE;
begin
  inherited;
  if FDoubleBuffered then RePaint;
end;

procedure TseXLabel.DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint);
var
  Text: string;
begin
  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Windows.DrawText(Cnvs.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

procedure TseXLabel.DrawLabelToBitMap(ABitMap: TseBitmap; AText: String);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Text: string;
  Flags: Longint;
  R: TRect;
begin
  //
  ABitMap.Canvas.Font := Self.Font;
  //
  Text := AText;
  R := Rect(FBlurSize - FBlurOffset, FBlurSize - FBlurOffset,
            ABitMap.Width - FBlurSize - FBlurOffset, ABitMap.Height - FBlurSize - FBlurOffset);
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  Flags := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  GetParentImage(Self, ABitmap.Canvas);
  if FVistaGlowEffect
  then
    DrawEffectText2(ABitMap.Canvas, R, Text, Flags, 0, FBlurColor, FBlurSize)
  else
    DrawEffectText(ABitMap.Canvas, R, Text, Flags, FBlurOffset, FBlurColor, FBlurSize);
end;


procedure TseXLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Text: string;
  Flags: Longint;
  R: TRect;
  FBuffer: TseBitmap;
begin
  if FStopRePaint then Exit;
  //
  Canvas.Font := Self.Font;
  //
  Text := GetLabelText;
  R := Rect(FBlurSize - FBlurOffset, FBlurSize - FBlurOffset,
            Width - FBlurSize - FBlurOffset, Height - FBlurSize - FBlurOffset);
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  Flags := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  if FDoubleBuffered
  then
    begin
      FBuffer := TseBitmap.Create;
      FBuffer.SetSize(Width, Height);
      GetParentImage(Self, FBuffer.Canvas);
      FBuffer.Canvas.Font := Self.Font;
      if FVistaGlowEffect
      then
        DrawEffectText2(FBuffer.Canvas, R, Text, Flags, 0, FBlurColor, FBlurSize)
      else
        DrawEffectText(FBuffer.Canvas, R, Text, Flags, FBlurOffset, FBlurColor, FBlurSize);
      FBuffer.Draw(Canvas.Handle, 0, 0);
      FBuffer.Free;
    end
  else
    if FVistaGlowEffect
    then
      DrawEffectText2(Canvas, R, Text, Flags, 0, FBlurColor, FBlurSize)
    else
      DrawEffectText(Canvas, R, Text, Flags, FBlurOffset, FBlurColor, FBlurSize);
end;

procedure TseXLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TseXLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Canvas.Font := Self.Font;
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Canvas, Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[FWordWrap]);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
    Rect.Right := Rect.Right + FBlurOffset + FBlurSize * 2 + 8;
    Rect.Bottom := Rect.Bottom + FBlurOffset + FBlurSize * 2 + 8;
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TseXLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RePaint;
  end;
end;

procedure TseXLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TseXLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TseXLabel.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    RePaint;
  end;
end;

procedure TseXLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    RePaint;
  end;
end;

procedure TseXLabel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    AdjustBounds;
    RePaint;
  end;
end;

procedure TseXLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
  if (Operation = opRemove) and (AComponent = FAnimation)
  then
    FAnimation := nil;
end;

procedure TseXLabel.CMTextChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TseXLabel.CMFontChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TseXLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TseXLabel.ChangeText(ANewText: String);
var
  S: String;
begin
  if FAnimation = nil
  then
    begin
      Caption := ANewText;
      Exit;
    end;
  if FAutoSize then FAutoSize := False;
  if not FDoubleBuffered then DoubleBuffered := True;

  S := Caption;
  FStopRePaint := True;
  Caption := ANewText;
  FStopRePaint := False;
  //
  StopMultiAnimation(FAniIndex);
  //
  SourceImage.SetSize(Width, Height);
  DrawLabelToBitMap(SourceImage, S);
  DestImage.SetSize(Width, Height);
  DrawLabelToBitMap(DestImage, ANewText);
  //
  StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
end;

// TseReflectLabel

constructor TseReflectLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  FStopRePaint := False;
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
  FAniIndex := -1;
  FAniIndex := ReserveIndex;
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  FDoubleBuffered := False;
  FReflectionOffset := 0;
  FReflectionColor := clBlack;
end;

destructor TseReflectLabel.Destroy;
begin
  StopMultiAnimation(FAniIndex);
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  inherited;
end;

procedure TseReflectLabel.SetDoubleBuffered;
begin
  if Value <> FDoubleBuffered
  then
    begin
      FDoubleBuffered := Value;
      if FDoubleBuffered
      then ControlStyle := ControlStyle + [csOpaque]
      else ControlStyle := ControlStyle - [csOpaque];
    end;
end;

procedure TseReflectLabel.CMMouseEnter;
begin
  inherited;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;


procedure TseReflectLabel.CMMouseLeave;
begin
  inherited;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TseReflectLabel.SetReflectionColor(Value: TColor);
begin
  if FReflectionColor <> Value
  then
    begin
      FReflectionColor := Value;
      Repaint;
    end;
end;

procedure TseReflectLabel.SetReflectionOffset(Value: Integer);
begin
  if FReflectionOffset <> Value
  then
    begin
      FReflectionOffset := Value;
      Repaint;
    end;
end;


function TseReflectLabel.GetLabelText: string;
begin
  Result := Caption;
end;

procedure TseReflectLabel.WMMOVE;
begin
  inherited;
  if FDoubleBuffered then RePaint;
end;

procedure TseReflectLabel.DoDrawText(Cnvs: TCanvas; var Rect: TRect; Flags: Longint);
var
  Text: string;
begin
  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Windows.DrawText(Cnvs.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

procedure TseReflectLabel.DrawLabelToBitMap(ABitMap: TseBitmap; AText: String);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Text: string;
  Flags: Longint;
  R: TRect;
begin
  //
  ABitMap.Canvas.Font := Self.Font;
  //
  Text := AText;
  R := ClientRect;
  Flags := DT_EXPANDTABS or Alignments[FAlignment];
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  GetParentImage(Self, ABitmap.Canvas);
  DrawReflectionText(ABitmap.Canvas, R, Text, Flags, FReflectionOffset, FReflectionColor);
end;


procedure TseReflectLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Text: string;
  Flags: Longint;
  R: TRect;
  FBuffer: TseBitmap;
begin
  if FStopRePaint then Exit;
  //
  Canvas.Font := Self.Font;
  //
  Text := GetLabelText;
  R := ClientRect;
  Flags := DT_EXPANDTABS or Alignments[FAlignment];
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  if FDoubleBuffered
  then
    begin
      FBuffer := TseBitmap.Create;
      FBuffer.SetSize(Width, Height);
      GetParentImage(Self, FBuffer.Canvas);
      FBuffer.Canvas.Font := Self.Font;
      DrawReflectionText(FBuffer.Canvas, R, Text, Flags, FReflectionOffset,
        FReflectionColor);
      FBuffer.Draw(Canvas.Handle, 0, 0);
      FBuffer.Free;
    end
  else
    DrawReflectionText(Canvas, R, Text, Flags, FReflectionOffset, FReflectionColor);
end;

procedure TseReflectLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TseReflectLabel.AdjustBounds;
var
  DC: HDC;
  R: TRect;
  X: Integer;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Canvas.Font := Self.Font;
    R :=  ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Canvas, R, (DT_EXPANDTABS or DT_CALCRECT));
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - R.Right);
    R.Bottom := R.Bottom + RectHeight(R) + FReflectionOffset;
    SetBounds(X, Top, R.Right, R.Bottom);
  end;
end;

procedure TseReflectLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RePaint;
  end;
end;

procedure TseReflectLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TseReflectLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TseReflectLabel.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    RePaint;
  end;
end;               

procedure TseReflectLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    RePaint;
  end;
end;

procedure TseReflectLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
  if (Operation = opRemove) and (AComponent = FAnimation)
  then
    FAnimation := nil;
end;

procedure TseReflectLabel.CMTextChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TseReflectLabel.CMFontChanged(var Message: TMessage);
begin
  AdjustBounds;
  RePaint;
end;

procedure TseReflectLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TseReflectLabel.ChangeText(ANewText: String);
var
  S: String;
begin
  if FAnimation = nil
  then
    begin
      Caption := ANewText;
      Exit;
    end;
  if FAutoSize then FAutoSize := False;
  if not FDoubleBuffered then DoubleBuffered := True;
  S := Caption;
  FStopRePaint := True;
  Caption := ANewText;
  FStopRePaint := False;
  //
  StopMultiAnimation(FAniIndex);
  //
  SourceImage.SetSize(Width, Height);
  DrawLabelToBitMap(SourceImage, S);
  DestImage.SetSize(Width, Height);
  DrawLabelToBitMap(DestImage, ANewText);
  //
  StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
end;


// TseButtonLabel

constructor TseButtonLabel.Create;
begin
  inherited;
  ControlStyle := ControlStyle + [csSetCaption] - [csOpaque];
  FChecked := False;
  FCheckedMode := False;
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
  FAniIndex := -1;
  FAniIndex := ReserveIndex;
  FShowCaptionUnderLine := True;
  FGlowColor := clAqua;
  FGlowEffect := False;
  FGlowSize := 7;
  FDoubleBuffered := False;
  FWebStyle := False;
  FActiveFontColor := clBlue;
  FMargin := -1;
  FSpacing := 1;
  FImageIndex := -1;
  FActiveImageIndex := -1;
  FAnimation := nil;
  FImageList := nil;
  FLayout := seblGlyphLeft;
  Width := 100;
  Height := 50;
end;

destructor TseButtonLabel.Destroy;
begin
  StopMultiAnimation(FAniIndex);
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  inherited;
end;

procedure TseButtonLabel.SetDoubleBuffered(Value: Boolean);
begin
  FDoubleBuffered := Value;
  if FDoubleBuffered
  then ControlStyle := ControlStyle + [csOpaque]
  else ControlStyle := ControlStyle - [csOpaque];
end;

procedure TseButtonLabel.SetChecked;
begin
  FChecked := Value;
  if FCheckedMode
  then
    begin
      if (FAnimation <> nil) and not (csDesigning in ComponentState) and
         not (csLoading in ComponentState)
      then
        begin
          StopMultiAnimation(FAniIndex);
          SourceImage.SetSize(Width, Height);
          GetParentImage(Self, SourceImage.Canvas);
          CreateButtonImage(SourceImage.Canvas, FMouseIn, not FChecked);
          DestImage.SetSize(Width, Height);
          GetParentImage(Self, DestImage.Canvas);
          CreateButtonImage(DestImage.Canvas, FMouseIn, FChecked);
          StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
        end
     else
       RePaint;
     if Assigned(FOnCheckChange) then FOnCheckChange(Self);
   end;
end;

procedure TseButtonLabel.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value
  then
    begin
      FImageIndex := Value;
      RePaint;
    end;
end;

procedure TseButtonLabel.CMTextChanged;
begin
  inherited;
  RePaint;
end;

procedure TseButtonLabel.MouseDown;
begin
  FDown := True;
  if not FWebStyle and not FCheckedMode
  then
    begin
      StopMultiAnimation(FAniIndex);
      RePaint;
    end;
  inherited;
end;

procedure TseButtonLabel.MouseUp;
begin
  FDown := False;
  if FCheckedMode
  then
    begin
      if FMouseIn
      then
        Checked := not Checked;
    end
  else
   if not FWebStyle then RePaint;
  inherited;
end;

procedure TseButtonLabel.SetLayout;
begin
  if FLayout <> Value
  then
    begin
      FLayout := Value;
      RePaint;
    end;
end;

procedure TseButtonLabel.SetSpacing;
begin
  if Value <> FSpacing
  then
    begin
      FSpacing := Value;
      RePaint;
    end;
end;

procedure TseButtonLabel.SetMargin;
begin
  if (Value <> FMargin) and (Value >= -1)
  then
    begin
      FMargin := Value;
      RePaint;
    end;
end;

procedure TseButtonLabel.CMMouseEnter;
begin
  inherited;
  FMouseIn := True;
  if (csDesigning in ComponentState) or not Enabled then Exit;
  if FAnimation <> nil
  then
    begin
      StopMultiAnimation(FAniIndex);
      SourceImage.SetSize(Width, Height);
      GetParentImage(Self, SourceImage.Canvas);
      CreateButtonImage(SourceImage.Canvas, False, FChecked);
      DestImage.SetSize(Width, Height);
      GetParentImage(Self, DestImage.Canvas);
      CreateButtonImage(DestImage.Canvas, True, FChecked);
      StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
    end
  else
    RePaint;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TseButtonLabel.CMMouseLeave;
begin
  inherited;
  FMouseIn := False;
  if (csDesigning in ComponentState) or not Enabled then Exit;
  if FAnimation <> nil
  then
    begin
      StopMultiAnimation(FAniIndex);
      SourceImage.SetSize(Width, Height);
      GetParentImage(Self, SourceImage.Canvas);
      CreateButtonImage(SourceImage.Canvas, True, FChecked);
      DestImage.SetSize(Width, Height);
      GetParentImage(Self, DestImage.Canvas);
      CreateButtonImage(DestImage.Canvas, False, FChecked);
      StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
    end
  else
    RePaint;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TseButtonLabel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  {$IFDEF VER150_UP}
  if ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and FMouseIn and FDown
  then
    Perform(CM_MOUSELEAVE, 0, 0)
  else
  if not ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and not FMouseIn and FDown
  then
    Perform(CM_MOUSEENTER, 0, 0);
  {$ENDIF}
end;

procedure TseButtonLabel.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImageList)
  then FImageList := nil;
end;

procedure TseButtonLabel.SetWebStyle(Value: Boolean);
begin
  FWebStyle := Value;
  if (csDesigning in ComponentState) then
   if Value then Cursor := crHandPoint else Cursor := crDefault;
end;

procedure TseButtonLabel.CreateButtonImage;
var
  IIndex: Integer;
begin
  C.Font := Self.Font;
  if AActive
  then
    C.Font.Color := FActiveFontColor;

  if FWebStyle and FShowCaptionUnderLine
  then
    if AActive
    then C.Font.Style := C.Font.Style + [fsUnderLine]
    else C.Font.Style := C.Font.Style - [fsUnderLine];

  if FCheckedMode
  then
    begin
      if (FImageList <> nil) and (FActiveImageIndex >= 0) and
       (FActiveImageIndex < FImageList.Count) and AChecked
      then
        IIndex := FActiveImageIndex
      else
      if (FImageList <> nil) and (FImageIndex >= 0) and
        (FImageIndex < FImageList.Count)
      then
        IIndex := FImageIndex
      else
        IIndex := -1;
    end
  else
    begin
      if (FImageList <> nil) and (FActiveImageIndex >= 0) and
       (FActiveImageIndex < FImageList.Count) and AActive
      then
       IIndex := FActiveImageIndex
      else
      if (FImageList <> nil) and (FImageIndex >= 0) and
     (FImageIndex < FImageList.Count)
      then
        IIndex := FImageIndex
      else
        IIndex := -1;
    end;

 if not Enabled then C.Font.Color := clGray;

 if FGlowEffect and AActive and Enabled
 then
   DrawImageAndTextGlow(C, ClientRect, FMargin, FSpacing, FLayout,
     Caption, IIndex, FImageList,
     FDown and not FWebStyle, Enabled, False, 0, FGlowColor, FGlowSize)
 else
   DrawImageAndText(C, ClientRect, FMargin, FSpacing, FLayout,
     Caption, IIndex, FImageList,
     FDown and not FWebStyle, Enabled, False, 0);
end;

procedure TseButtonLabel.Paint;
var
  Buffer: TBitMap;
  C: TCanvas;
  IIndex: Integer;
begin
  if FDoubleBuffered
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      C := Buffer.Canvas;
    end
  else
    C := Canvas;
 //
 CreateButtonImage(C, FMouseIn, FChecked);
 //
 if FDoubleBuffered
 then
   begin
     Canvas.Draw(0, 0, Buffer);
     Buffer.Free;
   end;
end;

// TsePanel

constructor TsePanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csOpaque, csDoubleClicks, csReplicatable];
 
  ParentForm := nil;  
  FFormDrag := False;
  FAnimation := nil;
  FDragX := -1;
  FDragY := -1;
  FBGDrawType := seBGTile;
  FBGImageList := nil;
  FBGChangeAnimation := nil;
  FBGImageIndex := -1;
  Width := 150;
  Height := 150;
end;

destructor TsePanel.Destroy;
begin
  inherited;
end;

procedure TsePanel.SetFormDrag;
begin
  FFormDrag := Value;
  if not FFormDrag then FInDrag := False;
end;

procedure TsePanel.MouseMove;
var
  P: TPoint;
  FX, FY: Integer;
begin
  inherited;
  if FFormDrag and FInDrag and (ParentForm <> nil)
  then
    begin
      GetCursorPos(P);
      FX := FDragX - P.X;
      FY := FDragY - P.Y;
      with ParentForm do SetBounds(Left - FX, Top - FY, Width, Height);
      FDragX := P.X;
      FDragY := P.Y;
    end;
end;

procedure TsePanel.CMMouseEnter;
begin
  inherited;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;


procedure TsePanel.CMMouseLeave;
begin
  inherited;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TsePanel.MouseDown;
var
  P: TPoint;
begin
  inherited;
  if FFormDrag
  then
    begin
      ParentForm := GetParentForm(Self);
      FInDrag := True;
      GetCursorPos(P);
      FDragX := P.X;
      FDragY := P.Y;
    end;
end;

procedure TsePanel.MouseUp;
begin
  inherited;
  if FFormDrag then FInDrag := False;
end;

procedure TsePanel.ColorChange(AColor: TColor);
begin
  if (BGChangeAnimation <> nil)
  then
    FBGChangeAnimation.FreezeControl(Self, Rect(0, 0, Width, Height));

  Color := AColor;

  if (BGChangeAnimation <> nil)
  then
    with FBGChangeAnimation do
    begin
      try
        Execute;
      finally
        Restore;
      end;  
    end;
    
  RePaint;
end;

procedure TsePanel.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  RePaint;
end;

procedure TsePanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TsePanel.SetBGDrawType(Value: TseBGDrawType);
begin
  if FBGDrawType <> Value
  then
    begin
      FBGDrawType := Value;
      RePaint;
    end;
end;

procedure TsePanel.SetBGImageIndex(Value: Integer);
begin
  if (BGChangeAnimation <> nil) and not (csDesigning in ComponentState) and
     not (csLoading in ComponentState)
  then
    begin
      FBGChangeAnimation.FreezeControl(Self, Rect(0, 0, Width, Height));
      FBGImageIndex := Value;
      with FBGChangeAnimation do
      begin
        try
          Execute;
        finally
          Restore;
        end;
      end;
    end
  else
    FBGImageIndex := Value;
  RePaint;
end;

procedure TsePanel.Paint; 
begin
  PaintPanel(Canvas);
end;

procedure TsePanel.WMEraseBkgnd;
begin
  Msg.Result := 1;
end;

procedure TsePanel.PaintPanel(C: TCanvas);
begin
  if (FBGImageList <> nil) and (FBGImageIndex >= 0) and
     (FBGImageIndex < FBGImageList.Images.Count)  and (Width > 0) and
     (Height > 0) and not FBGImageList.Images[FBGImageIndex].Picture.Graphic.Empty
  then
    begin
      case FBGDrawType of
        seBGTile: PaintTile(C);
        seBGStretch: PaintStretch(C);
        seBGHorzStretch: PaintHorzStretch(C);
        seBGVertStretch: PaintVertStretch(C);
      end;
    end
  else
    begin
      C.Brush.Color := Self.Color;
      C.FillRect(Rect(0, 0, Width, Height));
    end;
end;

procedure TsePanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FBGImageList) then
    FBGImageList := nil;
  if (Operation = opRemove) and (AComponent = FAnimation) then
    FAnimation := nil;
  if (Operation = opRemove) and (AComponent = FBGChangeAnimation) then
    FBGChangeAnimation := nil;
end;


procedure TsePanel.PaintTile(C: TCanvas);
var
  X, Y, XCnt, YCnt: Integer;
  P: TPicture;
begin
  P := FBGImageList.Images[FBGImageIndex].Picture;
  XCnt := Width div P.Width;
  YCnt := Height div P.Height;
  for X := 0 to XCnt do
  for Y := 0 to YCnt do
    C.Draw(X * P.Width, Y * P.Height, P.Graphic);
end;

procedure TsePanel.PaintStretch(C: TCanvas);
begin
  C.StretchDraw(Rect(0, 0, Width, Height),
    FBGImageList.Images[FBGImageIndex].Picture.Graphic);
end;

procedure TsePanel.PaintHorzStretch(C: TCanvas);
var
  X, XCnt: Integer;
  P: TPicture;
  Buffer: TBitMap;
begin
  P := FBGImageList.Images[FBGImageIndex].Picture;
  Buffer := TBitMap.Create;
  Buffer.Width := P.Width;
  Buffer.Height := Height;
  Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height), P.Graphic);
  XCnt := Width div Buffer.Width;
  for X := 0 to XCnt do C.Draw(X * Buffer.Width, 0, Buffer);
  Buffer.Free;
end;

procedure TsePanel.PaintVertStretch(C: TCanvas);
var
  Y, YCnt: Integer;
  P: TPicture;
  Buffer: TBitMap;
begin
  P := FBGImageList.Images[FBGImageIndex].Picture;
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := P.Height;
  Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height), P.Graphic);
  YCnt := Height div Buffer.Height;
  for Y := 0 to YCnt do C.Draw(0, Y * Buffer.Height, Buffer);
  Buffer.Free;
end;

procedure TsePanel.ExecuteAnimation;
begin
  if FAnimation = nil then Exit;
  FAnimation.FreezeControl(Self, Rect(0, 0, Width, Height));
  if Assigned(FOnPrepareAnimation) then FOnPrepareAnimation(Self);
  with FAnimation do
  begin
    try
      Execute;
    finally
      Restore;
     end;
  end;
end;

// TseNoteBook

procedure NotebookHandlesNeeded(Notebook: TseNotebook);
var
  I: Integer;
begin
  if Notebook <> nil then
    for I := 0 to Notebook.FPageList.Count - 1 do
      with TsePage(Notebook.FPageList[I]) do
      begin
        DisableAlign;
        try
          HandleNeeded;
          ControlState := ControlState - [csAlignmentNeeded];
       finally
          EnableAlign;
          ReAlign;
        end;
      end;
end;

type

  TsePageAccess = class(TStrings)
  private
    PageList: TList;
    Notebook: TseNoteBook;
  protected
    function GetCount: Integer; override;
    function Get(Index: Integer): string; override;
    procedure Put(Index: Integer; const S: string); override;
    function GetObject(Index: Integer): TObject; override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(APageList: TList; ANotebook: TseNoteBook);
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

constructor TsePageAccess.Create(APageList: TList; ANotebook: TseNoteBook);
begin
  inherited Create;
  PageList := APageList;
  Notebook := ANotebook;
end;

function TsePageAccess.GetCount: Integer;
begin
  Result := PageList.Count;
end;

function TsePageAccess.Get(Index: Integer): string;
begin
  Result := TsePage(PageList[Index]).Caption;
end;

procedure TsePageAccess.Put(Index: Integer; const S: string);
begin
  TsePage(PageList[Index]).Caption := S;
end;

function TsePageAccess.GetObject(Index: Integer): TObject;
begin
  Result := PageList[Index];
end;

procedure TsePageAccess.SetUpdateState(Updating: Boolean);
begin
  {do nothing}
end;

procedure TsePageAccess.Clear;
var
  I: Integer;
begin
  for I := 0 to PageList.Count - 1 do
    TsePage(PageList[I]).Free;
  PageList.Clear;
end;

procedure TsePageAccess.Delete(Index: Integer);
begin
  TsePage(PageList[Index]).Free;
  PageList.Delete(Index);
  NoteBook.PageIndex := 0;

  if csDesigning in NoteBook.ComponentState then
  begin
    if (GetParentForm(NoteBook) <> nil) and
       (GetParentForm(NoteBook).Designer <> nil) then
        GetParentForm(NoteBook).Designer.Modified;
  end;
end;

procedure TsePageAccess.Insert(Index: Integer; const S: string);
var
  Page: TsePage;
begin
  Page := TsePage.Create(Notebook);
  with Page do
  begin
    Parent := Notebook;
    Caption := S;
  end;
  PageList.Insert(Index, Page);

  NoteBook.PageIndex := Index;

  if csDesigning in NoteBook.ComponentState then
  begin
    if (GetParentForm(NoteBook) <> nil) and
    (GetParentForm(NoteBook).Designer <> nil) then
      GetParentForm(NoteBook).Designer.Modified;
  end;
end;

procedure TsePageAccess.Move(CurIndex, NewIndex: Integer);
var
  AObject: TObject;
begin
  if CurIndex <> NewIndex then
  begin
    AObject := PageList[CurIndex];
    PageList[CurIndex] := PageList[NewIndex];
    PageList[NewIndex] := AObject;
  end;
end;

{ TsePage }

constructor TsePage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csAcceptsControls] + [csOpaque];
  Visible := False;
  Align := alClient;
  FBGIMageIndex := -1;
  FBGDrawType := seBGTile;
end;

destructor TsePage.Destroy;
begin
  inherited destroy;
end;

procedure TsePage.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TsePage.WMSIZE(var Message: TWMSIZE); 
begin
  inherited;
  RePaint;
end;

procedure TsePage.WMEraseBkgnd;
begin
  Msg.Result := 1;
end;

procedure TsePage.PaintBG(C: TCanvas);
var
  NB: TseNoteBook;
begin
  NB := TseNoteBook(Owner);
  if (NB.FBGImageList <> nil) and (FBGImageIndex >= 0) and
     (FBGImageIndex < NB.FBGImageList.Images.Count)  and (Width > 0) and
     (Height > 0) and not NB.FBGImageList.Images[FBGImageIndex].Picture.Graphic.Empty
  then
    begin
      case FBGDrawType of
        seBGTile: PaintTile(C);
        seBGStretch: PaintStretch(C);
        seBGHorzStretch: PaintHorzStretch(C);
        seBGVertStretch: PaintVertStretch(C);
      end;
    end
  else
    begin
      C.Brush.Color := Self.Color;
      C.FillRect(Rect(0, 0, Width, Height));
    end;
end;

procedure TsePage.PaintTile(C: TCanvas);
var
  X, Y, XCnt, YCnt: Integer;
  P: TPicture;
  NB: TseNoteBook;
begin
  NB := TseNoteBook(Owner);
  P := NB.FBGImageList.Images[FBGImageIndex].Picture;
  XCnt := Width div P.Width;
  YCnt := Height div P.Height;
  for X := 0 to XCnt do
  for Y := 0 to YCnt do
    C.Draw(X * P.Width, Y * P.Height, P.Graphic);
end;

procedure TsePage.PaintStretch(C: TCanvas);
var
  NB: TseNoteBook;
begin
  NB := TseNoteBook(Owner);
  C.StretchDraw(Rect(0, 0, Width, Height),
    NB.FBGImageList.Images[FBGImageIndex].Picture.Graphic);
end;

procedure TsePage.PaintHorzStretch(C: TCanvas);
var
  X, XCnt: Integer;
  P: TPicture;
  Buffer: TBitMap;
  NB: TseNoteBook;
begin
  NB := TseNoteBook(Owner);
  P := NB.FBGImageList.Images[FBGImageIndex].Picture;
  Buffer := TBitMap.Create;
  Buffer.Width := P.Width;
  Buffer.Height := Height;
  Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height), P.Graphic);
  XCnt := Width div Buffer.Width;
  for X := 0 to XCnt do C.Draw(X * Buffer.Width, 0, Buffer);
  Buffer.Free;
end;

procedure TsePage.PaintVertStretch(C: TCanvas);
var
  Y, YCnt: Integer;
  P: TPicture;
  Buffer: TBitMap;
  NB: TseNoteBook;
begin
  NB := TseNoteBook(Owner);
  P := NB.FBGImageList.Images[FBGImageIndex].Picture;
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := P.Height;
  Buffer.Canvas.StretchDraw(Rect(0, 0, Buffer.Width, Buffer.Height), P.Graphic);
  YCnt := Height div Buffer.Height;
  for Y := 0 to YCnt do C.Draw(0, Y * Buffer.Height, Buffer);
  Buffer.Free;
end;

procedure TsePage.SetBGDrawType(Value: TseBGDrawType);
begin
  FBGDrawType := Value;
  Invalidate;
end;

procedure TsePage.SetBGImageIndex;
begin
  FBGImageIndex := Value;
  Invalidate;
end;

procedure TsePage.Paint;
begin
  PaintBG(Canvas);
end;

procedure TsePage.ReadState(Reader: TReader);
begin
  if Reader.Parent is TseNoteBook then
    TseNoteBook(Reader.Parent).FPageList.Add(Self);
  inherited ReadState(Reader);
end;

procedure TsePage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

{ TseNoteBook }

var
  Registered: Boolean = False;

constructor TseNoteBook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FForceControlUpdate := False;
  FBGImageList := nil;
  Width := 150;
  Height := 150;
  FPageList := TList.Create;
  FAccess := TsePageAccess.Create(FPageList, Self);
  FPageIndex := -1;
  FAccess.Add('Default');
  PageIndex := 0;
  Exclude(FComponentStyle, csInheritable);
  if not Registered then
  begin
    Classes.RegisterClasses([TsePage]);
    Registered := True;
  end;
end;

destructor TseNoteBook.Destroy;
begin
  FAccess.Free;
  FPageList.Free;
  inherited Destroy;
end;

procedure TseNoteBook.WMEraseBkgnd(var Msg: TWMEraseBkgnd); 
begin
  Msg.Result := 1;
end;

procedure TseNoteBook.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FBGImageList) then
    FBGImageList := nil;
  if (Operation = opRemove) and (AComponent = FAnimation) then
    FAnimation := nil;
end;

function TseNoteBook.GetChildOwner: TComponent;
begin
  Result := Self;
end;

procedure TseNoteBook.GetChildren;
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do Proc(TControl(FPageList[I]));
end;


procedure TseNoteBook.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TseNoteBook.ReadState(Reader: TReader);
begin
  Pages.Clear;
  inherited ReadState(Reader);
  if (FPageIndex <> -1) and (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
    with TsePage(FPageList[FPageIndex]) do
    begin
      BringToFront;
      Visible := True;
      Align := alClient;
    end
  else FPageIndex := -1;
end;

procedure TseNoteBook.ShowControl(AControl: TControl);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
    if FPageList[I] = AControl then
    begin
      SetPageIndex(I);
      Exit;
    end;
  inherited ShowControl(AControl);
end;

procedure TseNoteBook.SetPages(Value: TStrings);
begin
  FAccess.Assign(Value);
end;

procedure TseNoteBook.SetPageIndex(Value: Integer);
begin
  if csLoading in ComponentState then
  begin
    FPageIndex := Value;
    Exit;
  end;

  if (FAnimation <> nil) and not (csDesigning in ComponentState)
  then
    begin
      FAnimation.ForceControlUpdate := False;
      FAnimation.FreezeControl(Self, Rect(0, 0, Width, Height));
      FAnimation.ForceControlUpdate := Self.ForceControlUpdate;
    end;

  if (Value <> FPageIndex) and (Value >= 0) and (Value < FPageList.Count) then
  begin
    if GetParentForm(Self) <> nil then
      if ContainsControl(GetParentForm(Self).ActiveControl) then
        GetParentForm(Self).ActiveControl := Self;
    with TsePage(FPageList[Value]) do
    begin
      BringToFront;
      Visible := True;
      Align := alClient;
    end;
    if (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
      TsePage(FPageList[FPageIndex]).Visible := False;
    FPageIndex := Value;
    if GetParentForm(Self) <> nil then
      if GetParentForm(Self).ActiveControl = Self then SelectFirst;
    if Assigned(FOnPageChanged) then
      FOnPageChanged(Self);
  end;

  if (FAnimation <> nil) and not (csDesigning in ComponentState)
  then
    with FAnimation do
    begin
      try
        Execute;
      finally
        Restore;
      end;
    end;
    
end;

procedure TseNoteBook.SetActivePage(const Value: string);
begin
  SetPageIndex(FAccess.IndexOf(Value));
end;

function TseNoteBook.GetPage;
begin
  Result := TsePage(FPageList[Index]);
end;

procedure TseNoteBook.InvalidatePage;
begin
  TsePage(FPageList[Index]).Invalidate;
end;

procedure TseNoteBook.Paint;
begin
  if (FPageIndex = -1) and (csDesigning in ComponentState)
  then
    with Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
end;

function TseNoteBook.GetActivePage: string;
begin
  Result := FAccess[FPageIndex];
end;

procedure TseNoteBook.Loaded;
begin
  inherited;
  NotebookHandlesNeeded(Self);
end;

// TseToolBarEx ============================================================

constructor TseToolBarExItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAniIndex := ReserveIndex;
  FHint := '';
  FImageIndex := -1;
  FActiveImageIndex := -1;
  FEnabled := True;
  IsVisible := True;
  Active := False;
  FGlowColor := clAqua;
  FReflectionBitmap := TseBitmap.Create;
  FReflectionActiveBitmap := TseBitmap.Create;
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
end;

destructor TseToolBarExItem.Destroy;
begin
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  FReflectionBitmap.Free;
  FReflectionActiveBitmap.Free;
  inherited;
end;

procedure TseToolBarExItem.InitReflectionBitmaps;
var
  IL: TsePngImageList;
begin
  FReflectionBitmap.SetSize(0, 0);
  FReflectionActiveBitmap.SetSize(0, 0);
  if AInit
  then
  if (Collection <> nil) and (TseToolBarExItems(Collection).ToolBarEx <> nil)
     and
     (TseToolBarExItems(Collection).ToolBarEx.FImages <> nil)
  then
    begin
      IL := TseToolBarExItems(Collection).ToolBarEx.FImages;
      if (FImageIndex >= 0) and (FImageIndex < IL.Count)
      then
        with TsePngImageList(IL) do
        begin
          MakeCopyFromPng(FReflectionBitmap,
          PngImages.Items[Self.FImageIndex].PngImage);
          if FEnabled
          then
            FReflectionBitmap.Reflection
          else
            FReflectionBitmap.Reflection2;
        end;
      if (FActiveImageIndex >= 0) and (FActiveImageIndex < IL.Count)
      then
        with TsePngImageList(IL) do
        begin
          MakeCopyFromPng(FReflectionActiveBitmap,
          PngImages.Items[Self.FActiveImageIndex].PngImage);
          FReflectionActiveBitmap.Reflection;
        end;
   end;
end;

procedure TseToolBarExItem.Assign(Source: TPersistent);
begin
  if Source is TseToolBarExItem then
  begin
    FImageIndex := TseToolBarExItem(Source).ImageIndex;
    FActiveImageIndex := TseToolBarExItem(Source).ActiveImageIndex;
    FEnabled := TseToolBarExItem(Source).Enabled;
    FHint := TseToolBarExItem(Source).Hint;
    FGlowColor := TseToolBarExItem(Source).GlowColor;
   end
 else
   inherited Assign(Source);
end;

procedure TseToolBarExItem.SetImageIndex(const Value: TImageIndex);
var
  TB: TseToolbarEx;
begin
  TB := TseToolBarExItems(Collection).ToolbarEx;
  FImageIndex := Value;
  InitReflectionBitmaps(TB.ShowReflecton);
  Changed(False);
end;

procedure TseToolBarExItem.SetActiveImageIndex(const Value: TImageIndex);
begin
  FActiveImageIndex := Value;
  Changed(False);
end;

procedure TseToolBarExItem.SetEnabled(Value: Boolean);
var
  TB: TseToolbarEx;
begin
  TB := TseToolBarExItems(Collection).ToolbarEx;
  FEnabled := Value;
  InitReflectionBitmaps(TB.ShowReflecton);
  Changed(False);
end;

constructor TseToolBarExItems.Create;
begin
  inherited Create(TseToolBarExItem);
  ToolBarEx := AListBox;
end;

function TseToolBarExItems.GetOwner: TPersistent;
begin
  Result := ToolBarEx;
end;

procedure  TseToolBarExItems.Update(Item: TCollectionItem);
begin
  ToolBarEx.Repaint;
end; 

function TseToolBarExItems.GetItem(Index: Integer):  TseToolBarExItem;
begin
  Result := TseToolBarExItem(inherited GetItem(Index));
end;

procedure TseToolBarExItems.SetItem(Index: Integer; Value:  TseToolBarExItem);
begin
  inherited SetItem(Index, Value);
  ToolBarEx.RePaint;
end;

function TseToolBarExItems.Add: TseToolBarExItem;
begin
  Result := TseToolBarExItem(inherited Add);
  ToolBarEx.RePaint;
end;

function TseToolBarExItems.Insert(Index: Integer): TseToolBarExItem;
begin
  Result := TseToolBarExItem(inherited Insert(Index));
  ToolBarEx.RePaint;
end;

procedure TseToolBarExItems.Delete(Index: Integer);
begin
  inherited Delete(Index);
  ToolBarEx.RePaint;
end;

procedure TseToolBarExItems.Clear;
begin
  inherited Clear;
  ToolBarEx.RePaint;
end;

constructor TseToolBarEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csAcceptsControls];
  HW := TseToolBarHintWindow.Create(Self);
  FArrowImages := nil;
  FShowItemHints := False;
  FHintFont := TFont.Create;
  FHintFont.Color := clInfoText;
  FHintColor := clInfoBk;
  FItemAnimation := nil;
  FBGBuffer := TseBitMap.Create;
  FShowGlow := True;
  FShowReflection := True;
  FItemIndex := -1;
  FHoldSelectedItem := False;
  FAutoSize := False;
  FShowHandPointCursor := False;
  FItemSpacing := 10;
  FItems := TseToolBarExItems.Create(Self);
  Height := 50;
  Width := 300;
  FImages := nil;
  MouseInItem := -1;
  OldMouseInItem := -1;
  FScrollIndex := 0;
  FScrollMax := 0;

  FScrollArrowColor := clBlack;
  FScrollArrowActiveColor := clWhite;

  Buttons[0].MouseIn := False;
  Buttons[1].MouseIn := False;

end;

destructor TseToolBarEx.Destroy;
begin
  StopAllAnimations;
  FHintFont.Free;
  HW.Free;
  FBGBuffer.Free;
  FItems.Free;
  inherited Destroy;
end;

procedure TseToolBarEx.SetHintFont(Value: TFont);
begin
  FHintFont.Assign(Value);
end;

procedure TseToolBarEx.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  if FItemAnimation <> nil then StopAllAnimations;
end;

procedure TseToolBarEx.SetItemAnimation(Value: TseAnimation);
begin
  FItemAnimation := Value;
  if (FItemAnimation <> nil) and (ItemSpacing < 20) and FShowGlow
  then ItemSpacing := 20;  
end;

procedure TseToolBarEx.Paint;
var
  Buffer: TBitmap;
  i: Integer;
begin
  CalcItemRects;
  //
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  //
  FBGBuffer.SetSize(Width, Height);
  PaintPanel(FBGBuffer.Canvas);
  if (FScrollMax <> 0) and (FImages <> nil)
  then
    DrawButtons(FBGBuffer.Canvas);
  FBGBuffer.Draw(Buffer.Canvas, 0, 0);
  if FImages <> nil
  then
    begin
      CheckScroll;
      if FItems.Count > 0
      then
        for i := 0 to FItems.Count - 1 do
         if FItems[I].IsVisible then DrawItem(Buffer.Canvas, I);
   end;
  //
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;

procedure TseToolBarEx.SetShowReflection;
var
  i: Integer;
begin
  FShowReflection := Value;
  for i := 0 to FItems.Count - 1 do FItems[I].InitReflectionBitmaps(FShowReflection);
  if FAutoSize then AdjustBounds;
  RePaint;
end;


procedure TseToolBarEx.UpdatedSelected;
begin
  TestActive(-1, -1);
end;

procedure TseToolBarEx.SetShowGlow;
begin
  if Value <> FShowGlow
  then
    begin
       FShowGlow := Value;
       if (ItemSpacing < 20) and FShowGlow and (FItemAnimation <> nil)
       then
         ItemSpacing := 20;
       if FHoldSelectedItem then RePaint;
    end;
end;

procedure TseToolBarEx.SetItemIndex;
var
  OldValue: Integer;
begin
  OldValue := FItemIndex;
  FItemIndex := Value;
  if (OldValue <> FItemIndex)
  then
    begin
      if ((FItemAnimation <> nil) and (OldValue <> -1)) and FHoldSelectedItem
      then
        begin
          Self.StartAnimation(FItems[OldValue]);
        end
      else
        RePaint;
    end;  
  if (FItemIndex >= 0) and (FItemIndex < FItems.Count) and
     not (csDesigning in ComponentState) and
     not (csLoading in ComponentState)
  then
    begin
      if Assigned(FItems[FItemIndex].OnClick)
      then
        FItems[FItemIndex].OnClick(Self);
        if (OldValue <> FItemIndex) and Assigned(FOnChange)
        then
          FOnChange(Self);
     end;
end;

procedure TseToolBarEx.AdjustBounds;
begin
  if FImages = nil
  then
    Exit
  else
  if FShowReflection
  then
    Height := 10 + FImages.Height + FImages.Height div 2 + 2
  else
    Height := 10 + FImages.Height + 15;
end;

procedure TseToolBarEx.SetAutoSize;
begin
  FAutoSize := Value;
  if FAutoSize then AdjustBounds;
end;

procedure TseToolBarEx.Loaded;
var
  i: Integer;
begin
  inherited;
  for i := 0 to FItems.Count - 1 do FItems[I].InitReflectionBitmaps(FShowReflection);
end;

procedure TseToolBarEx.SetItemSpacing;
begin
  if (Value >= 0) and (Value <> FItemSpacing)
  then
    begin
      FItemSpacing := Value;
      if (ItemSpacing < 20) and FShowGlow and (FItemAnimation <> nil)
       then
         ItemSpacing := 20;
      RePaint;
    end;
end;

function TseToolBarEx.GetVisibleCount: Integer;
var
  i, j: Integer;
begin
  j := 0;
  for i := 0 to FItems.Count - 1 do
    if FItems[i].IsVisible then Inc(j);
  Result := j;
  if Result = 0 then Result := 1;
end;

procedure TseToolBarEx.CalcItemRects;
var
  i, X, Y, Count: Integer;
begin
  if FImages = nil then Exit;
  Count := GetVisibleCount;
  X := Count * FImages.Width + (FItemSpacing * (Count - 1));
  X := Width div 2 - X div 2;
  if X < 2 then X := 2;
  Y := 10;
  for i := 0 to FItems.Count - 1 do
  with FItems[i] do
  if IsVisible then
  begin
    ItemRect := Rect(X, Y, X + FImages.Width, Y + FImages.Height);
    X := X + FImages.Width + FItemSpacing;
  end;
  if FArrowImages = nil
  then
    begin
      Buttons[0].R := Rect(2, Y + FImages.Height, 9, Height);
      Buttons[1].R := Rect(Width - 9, Y + FImages.Height, Width - 2, Height);
    end
  else
    begin
      Buttons[0].R := Rect(2, Y + FImages.Height, 2 + FArrowImages.PngWidth, Height);
      Buttons[1].R := Rect(Width - 2 - FArrowImages.PngWidth, Y + FImages.Height, Width - 2, Height);
    end;
end;

procedure TseToolBarEx.StopAllAnimations;
var
  i: Integer;
begin
  if FItemAnimation <> nil
  then
    for i := 0 to FItems.Count - 1 do StopAnimation(FItems[i]);
end;

procedure TseToolBarEx.StartAnimation(Item: TseToolBarExItem);
var
  w, h: Integer;
  Offset: Integer;
begin
  if FShowGlow then Offset := 10 else Offset := 0;
  if (FImages = nil) or (FItemAnimation = nil) then Exit;
  w := FImages.Width;
  h := FImages.Height;
  StopAnimation(Item);
  Item.SourceImage.SetSize(w + Offset * 2, FBGBuffer.Height);
  Item.DestImage.SetSize(w + Offset * 2, FBGBuffer.Height);
  Item.SourceImage.Canvas.CopyRect(Rect(0, 0,
    Item.SourceImage.Width, Item.SourceImage.Height),
    FBGBuffer.Canvas, Rect(Item.ItemRect.Left - Offset,0,
      Item.ItemRect.Right + Offset, FBGBuffer.Height));
  Item.DestImage.Canvas.CopyRect(Rect(0, 0,
    Item.SourceImage.Width, Item.SourceImage.Height),
    FBGBuffer.Canvas, Rect(Item.ItemRect.Left - Offset,0,
      Item.ItemRect.Right + Offset, FBGBuffer.Height));
  if Item.Active
  then
    begin
      PrepareItemImage(Item.SourceImage.Canvas, Item, False,
      Rect(Offset, Item.ItemRect.Top, Item.SourceImage.Width - Offset, Item.ItemRect.Bottom));
      PrepareItemImage(Item.DestImage.Canvas, Item, True,
      Rect(Offset, Item.ItemRect.Top, Item.SourceImage.Width - Offset, Item.ItemRect.Bottom));
    end
  else
    begin
      PrepareItemImage(Item.SourceImage.Canvas, Item, True,
      Rect(Offset, Item.ItemRect.Top, Item.SourceImage.Width - Offset, Item.ItemRect.Bottom));
      PrepareItemImage(Item.DestImage.Canvas, Item, False,
      Rect(Offset, Item.ItemRect.Top, Item.SourceImage.Width - Offset, Item.ItemRect.Bottom));
    end;
  StartMultiAnimation(Canvas, Item.ItemRect.Left - Offset, 0, Item.SourceImage, Item.DestImage, FItemAnimation, Item.FAniIndex);
end;

procedure TseToolBarEx.StopAnimation(Item: TseToolBarExItem);
begin
  if (FImages = nil) or (FItemAnimation = nil) then Exit;
  StopMultiAnimation(Item.FAniIndex);
end;

procedure TseToolBarEx.PrepareItemImage;
var
  C: TColor;
  R: TRect;
  B: TseBitMap;
  i, j: Integer;

begin

  if AActive and FShowGlow
  then
    begin
      i := -1;

      if (Item.ActiveImageIndex >= 0) and
         (Item.ActiveImageIndex < FImages.Count)
      then
        i := Item.ActiveImageIndex
      else
      if (Item.ImageIndex >= 0) and
         (Item.ImageIndex < FImages.Count)
      then
        i := Item.ImageIndex;

      if i = -1 then Exit;

      B := TseBitMap.Create;
      B.SetSize(Images.Width + 20, Images.Height + 20);

      MakeBlurBlank(B, FImages.PngImages.Items[i].PngImage, 10);
      //

      Blur(B, 10);

      C := Item.GlowColor;

      for i := 0 to B.Width - 1 do
        for j := 0 to B.Height - 1 do
          begin
            PseColorRec(B.PixelPtr[i, j]).Color := FromRGB(C) and
            not $FF000000 or (PseColorRec(B.PixelPtr[i, j]).R shl 24);
          end;
      //
      B.Draw(Cnvs, ARect.Left - 10, ARect.Top - 10);
      if FShowReflection
      then
        begin
          B.Reflection3;
          B.Draw(Cnvs, ARect.Left - 10, ARect.Bottom - 10);
        end;
      B.Free;
    end;
  //
  if  AActive and (Item.ActiveImageIndex >= 0) and
     (Item.ActiveImageIndex < FImages.Count)
  then
    begin
      FImages.Draw(Cnvs, ARect.Left, ARect.Top,
        Item.FActiveImageIndex, True);
      if FShowReflection and not Item.FReflectionActiveBitmap.Empty
      then
        Item.FReflectionActiveBitmap.Draw(Cnvs, ARect.Left,
        ARect.Bottom);
    end
  else
  if (Item.ImageIndex >= 0) and (Item.ImageIndex < FImages.Count)
  then
    begin
      FImages.Draw(Cnvs, ARect.Left, ARect.Top,
        Item.FImageIndex, Item.Enabled);
      if FShowReflection and not Item.FReflectionBitmap.Empty
      then
        begin
          Item.FReflectionBitmap.Draw(Cnvs, ARect.Left,
              ARect.Bottom)
        end;
    end;
end;


procedure TseToolBarEx.DrawItem;
var
  C: TColor;
  R: TRect;
  B: TseBitMap;
  i, j: Integer;
begin
  if (FItems[Index].Active or ((Index = ItemIndex) and FHoldSelectedItem)) and
      FShowGlow
  then
    begin
      i := -1;

      if (FItems[Index].ActiveImageIndex >= 0) and
         (FItems[Index].ActiveImageIndex < FImages.Count)
      then
        i := FItems[Index].ActiveImageIndex
      else
      if (FItems[Index].ImageIndex >= 0) and
         (FItems[Index].ImageIndex < FImages.Count)
      then
        i := FItems[Index].ImageIndex;

      if i = -1 then Exit;  

      B := TseBitMap.Create;
      B.SetSize(Images.Width + 20, Images.Height + 20);

      MakeBlurBlank(B, FImages.PngImages.Items[i].PngImage, 10);
      //

      Blur(B, 10);

      C := FItems[Index].GlowColor;

      for i := 0 to B.Width - 1 do
        for j := 0 to B.Height - 1 do
          begin
            PseColorRec(B.PixelPtr[i, j]).Color := FromRGB(C) and
            not $FF000000 or (PseColorRec(B.PixelPtr[i, j]).R shl 24);
          end;
      //
      B.Draw(Cnvs, FItems[Index].ItemRect.Left - 10,
        FItems[Index].ItemRect.Top - 10);
      if FShowReflection
      then
        begin
          B.Reflection3;
          B.Draw(Cnvs, FItems[Index].ItemRect.Left - 10,
          FItems[Index].ItemRect.Bottom - 10);
        end;
      B.Free;
    end;
  //
  if (FItems[Index].Active or ((Index = ItemIndex) and FHoldSelectedItem))
      and (FItems[Index].ActiveImageIndex >= 0) and
     (FItems[Index].ActiveImageIndex < FImages.Count)
  then
    begin
      FImages.Draw(Cnvs, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].FActiveImageIndex, True);
      if FShowReflection and not FItems[Index].FReflectionActiveBitmap.Empty
      then
        FItems[Index].FReflectionActiveBitmap.Draw(Cnvs, FItems[Index].ItemRect.Left,
        FItems[Index].ItemRect.Bottom);
    end
  else
  if (FItems[Index].ImageIndex >= 0) and (FItems[Index].ImageIndex < FImages.Count)
  then
    begin
      FImages.Draw(Cnvs, FItems[Index].ItemRect.Left, FItems[Index].ItemRect.Top,
        FItems[Index].FImageIndex, FItems[Index].Enabled);
      if FShowReflection and not FItems[Index].FReflectionBitmap.Empty
      then
        begin
          FItems[Index].FReflectionBitmap.Draw(Cnvs, FItems[Index].ItemRect.Left,
              FItems[Index].ItemRect.Bottom)
        end;
    end;
end;

procedure TseToolBarEx.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FImages) then FImages := nil;
  if (Operation = opRemove) and (AComponent = FArrowImages) then FArrowImages := nil;
  if (Operation = opRemove) and (AComponent = FItemAnimation) then FItemAnimation := nil;
end;


procedure TseToolBarEx.SetArrowImages(Value: TsePngImageList);
begin
  if FArrowImages <> Value
  then
    begin
      FArrowImages := Value;
      RePaint;
    end;  
end;

procedure TseToolBarEx.SetItems(Value: TseToolBarExItems);
begin
  FItems.Assign(Value);
  RePaint;
end;

procedure TseToolBarEx.SetImages(Value: TsePngImageList);
begin
  FImages := Value;
end;

function TseToolBarEx.ItemAtPos(X, Y: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if PtInRect(FItems[I].ItemRect, Point(X, Y)) and (FItems[I].Enabled) and
       (FItems[I].IsVisible)
    then
      begin
        Result := I;
        Break;
      end;  
end;

procedure TseToolBarEx.TestActive(X, Y: Integer);
var
  PH: TPoint;
begin
  MouseInItem := ItemAtPos(X, Y);
  if (MouseInItem <> OldMouseInItem)
  then
    begin
      if OldMouseInItem <> -1
      then
        begin
          if FShowItemHints then HideHint;
          FItems[OldMouseInItem].Active := False;

          if FHoldSelectedItem
          then
            begin
              if OldMouseInItem <> ItemIndex
              then
                StartAnimation(FItems[OldMouseInItem]);
            end
          else
            StartAnimation(FItems[OldMouseInItem]);

          if Assigned(FOnMouseLeaveItem)
          then
            FOnMouseLeaveItem(FItems[OldMouseInItem]);
        end;
      OldMouseInItem := MouseInItem;
      if MouseInItem <> -1
      then
        begin
          FItems[MouseInItem].Active := True;
          if FHoldSelectedItem
          then
            begin
              if OldMouseInItem <> ItemIndex
              then
                StartAnimation(FItems[MouseInItem]);
            end
          else
            StartAnimation(FItems[MouseInItem]);

          if Assigned(FOnMouseEnterItem)
          then
            FOnMouseEnterItem(FItems[MouseInItem]);
          if FShowItemHints then ShowHint(FItems[MouseInItem]);
        end;
      if FItemAnimation = nil then RePaint;
      if FShowHandPointCursor
      then
        begin
          if MouseInItem <> -1
          then
            Cursor := crHandPoint
          else
            Cursor := crDefault;
        end;
    end;
end;

procedure TseToolBarEx.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
var
  I: Integer;
begin
  inherited;
  if HW.Visible then HideHint;
  if FHoldSelectedItem and (Button = mbLeft)
  then
    begin
      I := ItemAtPos(X, Y);
      if I <> -1 then ItemIndex := I;
    end;
end;

procedure TseToolBarEx.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  inherited;
  TestActive(X, Y);
  //
  if FScrollMax <> 0
  then
    for i := 0 to 1 do
    begin
      if PtInRect(Buttons[i].R, Point(X, Y))
      then
        begin
          if not Buttons[i].MouseIn
          then
             begin
              Buttons[i].MouseIn := True;
              RePaint;
            end;
         end
       else
       if Buttons[i].MouseIn
       then
         begin
           Buttons[i].MouseIn := False;
           RePaint;
         end;
    end;
end;

procedure TseToolBarEx.CMMouseLeave;
begin
  inherited;
  TestActive(-1, -1);
  if ((Buttons[0].MouseIn) or (Buttons[1].MouseIn)) and (FScrollMax <> 0)
  then
    begin
      Buttons[0].MouseIn := False;
      Buttons[1].MouseIn := False;
      RePaint;
    end;
end;

procedure TseToolBarEx.CMMouseEnter;
begin
  inherited;
end;

procedure TseToolBarEx.MouseUp(Button: TMouseButton; Shift: TShiftState;
           X, Y: Integer); 
var
  I: Integer;
begin
  inherited;
  if Button = mbLeft
  then
    begin
      I := ItemAtPos(X, Y);
      if (I <> -1) and not FHoldSelectedItem
      then
        begin
          ItemIndex := I;
        end
      else
      if FScrollMax <> 0
      then
        begin
          if PtInRect(Buttons[0].R, Point(X, Y))
          then
            DecScroll
          else
          if PtInRect(Buttons[1].R, Point(X, Y))
          then
            IncScroll;
        end;
    end;
end;

procedure TseToolBarEx.CheckScroll;
var
  i, j, X, Y: Integer;
  W, Count: Integer;
begin
  if FImages = nil then Exit;

  Count := 0;

  X := 2;
  
  for i := 0 to FItems.Count - 1 do
  begin
    if X + FImages.Width <= Width - 2
    then
      Inc(Count);
    X := X + FImages.Width + FItemSpacing;
  end;

  if FItems.Count > Count
  then
    FScrollMax := FItems.Count - Count           
  else
    begin
      FScrollMax := 0;
      FScrollIndex := 0;
      Buttons[0].MouseIn := False;
      Buttons[1].MouseIn := False;
    end;

  if FScrollIndex <> 0
  then
    begin
      if FScrollIndex + Count > FItems.Count
      then
        Dec(FScrollIndex, FScrollIndex + Count - FItems.Count);
      if FScrollIndex < 0 then FScrollIndex := 0;
    end;

  if Count = 0
  then
    begin
      for i := 0 to FItems.Count - 1 do
        FItems[i].IsVisible := False;
    end
  else
  for i := 0 to FItems.Count - 1 do
    if FScrollMax <> 0
    then
      FItems[i].IsVisible := (i >= FScrollIndex) and (i < FScrollIndex + Count)
    else
      FItems[i].IsVisible := True;
end;

procedure TseToolBarEx.DecScroll;
begin
  if FScrollMax <> 0
  then
    begin
      Dec(FScrollIndex);
      if FScrollIndex < 0 then FScrollIndex := 0;
    end
  else
    FScrollIndex := 0;
  RePaint;
end;

procedure TseToolBarEx.IncScroll;
begin
 if FScrollMax <> 0
  then
    begin
      Inc(FScrollIndex);
      if FScrollIndex > FScrollMax then FScrollIndex := FScrollMax;
    end
  else
    FScrollIndex := 0;
  RePaint;
end;

procedure TseToolBarEx.DrawButtons;
var
  R: TRect;
  C: TColor;
  i, j, y: Integer;
begin
  if (FArrowImages <> nil) and (FArrowImages.Count >= 2)
  then
    begin
      for i := 0 to 1 do
      begin
        R := Buttons[i].R;
        if Buttons[i].MouseIn
        then
          begin
            j := i + 2;
            if j > FArrowImages.Count - 1 then j := i;
          end
        else
          j := i;
        y := R.Top + RectHeight(R) div 2 - FArrowImages.PngHeight div 2;
        FArrowImages.Draw(Cnvs, R.Left + 2, y, j, True);
      end;
    end
  else
    begin
      for i := 0 to 1 do
      begin
        R := Buttons[i].R;
        if Buttons[i].MouseIn
        then
          C := FScrollArrowActiveColor
        else
          C := FScrollArrowColor;
        DrawArrowImage(Cnvs, R, C, i + 1);
      end;
    end;  
end;


procedure TseToolBarEx.ShowHint;
var
  P: TPoint;
  R: TRect;
begin
  if not FShowItemHints then Exit;
  if Item.Hint = '' then Exit;
  if HW.Visible then HideHint;
  HW.Font := FHintFont;
  HW.Canvas.Font := FHintFont;
  HW.Color := FHintColor;
  HW.Canvas.Font.Color := FHintFont.Color;
  HW.Caption := Item.Hint;
  R := HW.CalcHintRect(Width, Item.Hint, nil);
  P := ClientToScreen(Point(0, 0));
  P.X := P.X + Item.ItemRect.Left + (Item.ItemRect.Right - Item.ItemRect.Left) div 2;
  P.X := P.X - HW.Width div 2;
  if (Align = alNone) or (Align = alTop)
  then
    P.Y := P.Y + Height
  else
    P.Y := P.Y - HW.Height;
  OffsetRect(R, P.X, P.Y);
  HW.Visible := True;
  HW.ActivateHint(R, Item.Hint);
end;

procedure TseToolBarEx.HideHint;
begin
  if not FShowItemHints then Exit;
  HW.Visible := False;
  SetWindowPos(HW.Handle, HWND_TOPMOST, 0, 0, 0,
    0, SWP_HideWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
end;

procedure TseToolBarHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_POPUP and not WS_BORDER;
  end;
end;

procedure TseToolBarHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  Windows.DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
end;

constructor TsePngImageView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque] + [csReplicatable];
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
  FAniIndex := -1;
  FAniIndex := ReserveIndex;
  FDoubleBuffered := False;
  FReflectionImage := nil;
  FReflectionEffect := False;
  FPngImageList := nil;
  FPngImageStorage := nil;
  FAutoSize := True;
  FImageIndex := -1;
  FCenter := False;
  FAnimation := nil;
  Width := 50;
  Height := 50;
end;

destructor TsePngImageView.Destroy;
begin
  StopMultiAnimation(FAniIndex);
  if FReflectionImage <> nil then DestroyReflection;
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  inherited;
end;

procedure TsePngImageView.SetDoubleBuffered(Value: Boolean);
begin
  FDoubleBuffered := Value;
  if FDoubleBuffered
  then ControlStyle := ControlStyle + [csOpaque]
  else ControlStyle := ControlStyle - [csOpaque];
end;

procedure TsePngImageView.CMEnabledChanged(var Message: TMessage);
begin
  if FReflectionEffect then CreateReflection;
  inherited;
end;

procedure TsePngImageView.PrepareImage(AImageIndex: Integer; ABitmap: TseBitMap);
var
  RefBitMap: TseBitMap;
  H, X, Y: Integer;
begin
  GetParentImage(Self, ABitMap.Canvas);
  if FReflectionEffect
  then
    begin
      RefBitMap := TseBitMap.Create;
      CreateReflectionBitmap(RefBitMap, AImageIndex);
    end
  else
    RefBitMap := nil;
  //
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (AImageIndex >= 0) and
     (AImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      if FCenter
      then
        begin
          H := FPngImageStorage.PngImages[AImageIndex].PngHeight;
          if RefBitMap <> nil then H := H + H div 2;
          Y := Height div 2 - H div 2;
          X := Width div 2 - FPngImageStorage.PngImages[AImageIndex].PngWidth div 2;
          FPngImageStorage.Draw(AImageIndex, ABitmap.Canvas, X, Y, Enabled);
          if RefBitMap <> nil
          then
            RefBitMap.Draw(ABitMap.Canvas, X, Y + FPngImageStorage.PngImages[AImageIndex].PngHeight);
        end
      else
        begin
          FPngImageStorage.Draw(AImageIndex, ABitMap.Canvas, 0, 0, Enabled);
          if RefBitMap <> nil
          then
            RefBitMap.Draw(ABitMap.Canvas,
              0, FPngImageStorage.PngImages[AImageIndex].PngHeight);
        end;
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (AImageIndex >= 0) and
     (AImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      if FCenter
      then
        begin
          H := FPngImageList.Height;
          if RefBitMap <> nil then H := H + H div 2;
          Y := Height div 2 - H div 2;
          X := Width div 2 - FPngImageList.Width div 2;
          FPngImageList.Draw(ABitMap.Canvas,  X, Y, AImageIndex, Enabled);
          if RefBitMap <> nil
          then
            RefBitMap.Draw(ABitMap.Canvas, X, Y + FPngImageList.Height);
        end
      else
        begin
          FPngImageList.Draw(ABitMap.Canvas, 0, 0, AImageIndex, Enabled);
          if RefBitMap <> nil
          then
            RefBitMap.Draw(ABitMap.Canvas, 0, FPngImageList.Height);
        end;
    end;
  //
  RefBitMap.Free;
end;

procedure TsePngImageView.CreateReflectionBitmap;
begin
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (AImageIndex >= 0) and
     (AImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      MakeCopyFromPng(AReflectionImage,
        FPngImageStorage.PngImages[AImageIndex].PngImage);
      if Enabled
      then
        AReflectionImage.Reflection
      else
        AReflectionImage.Reflection2;
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (AImageIndex >= 0) and
     (AImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      MakeCopyFromPng(AReflectionImage,
        FPngImageList.PngImages[AImageIndex].PngImage);
      if Enabled
      then
        AReflectionImage.Reflection
      else
        AReflectionImage.Reflection2;
    end;
end;

procedure TsePngImageView.CreateReflection;
begin
  DestroyReflection;
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      TseBitMap(FReflectionImage) := TseBitMap.Create;
      MakeCopyFromPng(TseBitMap(FReflectionImage),
        FPngImageStorage.PngImages[FImageIndex].PngImage);
      if Enabled
      then
        TseBitMap(FReflectionImage).Reflection
      else
        TseBitMap(FReflectionImage).Reflection2;
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      TseBitMap(FReflectionImage) := TseBitMap.Create;
      MakeCopyFromPng(TseBitMap(FReflectionImage),
        FPngImageList.PngImages[FImageIndex].PngImage);
      if Enabled
      then
        TseBitMap(FReflectionImage).Reflection
      else
        TseBitMap(FReflectionImage).Reflection2;
    end;
end;

procedure TsePngImageView.DestroyReflection;
begin
  if FReflectionImage <> nil
  then
    begin
      TseBitMap(FReflectionImage).Free;
      FReflectionImage := nil;
    end;
end;

procedure TsePngImageView.CMMouseEnter;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TsePngImageView.SetReflectionEffect;
begin
  if FReflectionEffect <> Value
  then
    begin
      FReflectionEffect := Value;
      if FReflectionEffect then CreateReflection else DestroyReflection;
      AdjustBounds;
      RePaint;
    end;
end;

procedure TsePngImageView.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TsePngImageView.Paint;
var
  H, X, Y: Integer;
  C: TCanvas;
  Buffer: TBitMap;
begin
  if FDoubleBuffered
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      C := Buffer.Canvas;
    end
  else
    C := Canvas;

  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      if FCenter
      then
        begin
          H := FPngImageStorage.PngImages[FImageIndex].PngHeight;
          if FReflectionImage <> nil then H := H + H div 2;
          Y := Height div 2 - H div 2;
          X := Width div 2 - FPngImageStorage.PngImages[FImageIndex].PngWidth div 2;
          FPngImageStorage.Draw(FImageIndex, C, X, Y, Enabled);
          if FReflectionImage <> nil
          then
            TseBitMap(FReflectionImage).Draw(C,
              X, Y + FPngImageStorage.PngImages[FImageIndex].PngHeight);
        end
      else
        begin
          FPngImageStorage.Draw(FImageIndex, C, 0, 0, Enabled);
          if FReflectionImage <> nil
          then
            TseBitMap(FReflectionImage).Draw(C,
              0, FPngImageStorage.PngImages[FImageIndex].PngHeight);
        end;
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      if FCenter
      then
        begin
          H := FPngImageList.Height;
          if FReflectionImage <> nil then H := H + H div 2;
          Y := Height div 2 - H div 2;
          X := Width div 2 - FPngImageList.Width div 2;
          FPngImageList.Draw(C,  X, Y, FImageIndex, Enabled);
          if FReflectionImage <> nil
          then
            TseBitMap(FReflectionImage).Draw(C,
              X, Y + FPngImageList.Height);
        end
      else
        begin
          FPngImageList.Draw(C, 0, 0, FImageIndex, Enabled);
          if FReflectionImage <> nil
          then
            TseBitMap(FReflectionImage).Draw(C,
              0, FPngImageList.Height);
        end;
    end;

  if csDesigning in ComponentState
  then
    with C do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;

  if FDoubleBuffered
  then
    begin
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end;
end;    

procedure TsePngImageView.Loaded;
begin
  inherited Loaded;
  if FReflectionEffect then CreateReflection;
  AdjustBounds;
end;

procedure TsePngImageView.AdjustBounds;
begin
  if FAutoSize and (FPngImageStorage <> nil) and
     (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      Width := FPngImageStorage.PngImages[FImageIndex].PngWidth;
      if FReflectionEffect
      then
        Height := FPngImageStorage.PngImages[FImageIndex].PngHeight  +
          FPngImageStorage.PngImages[FImageIndex].PngHeight div 2 + 5
      else
        Height := FPngImageStorage.PngImages[FImageIndex].PngHeight;
    end
  else
  if FAutoSize and (FPngImageList <> nil)
  then
    begin
      Width := FPngImageList.Width;
      if FReflectionEffect
      then
        Height := FPngImageList.Height  + FPngImageList.Height div 2 + 5
      else
        Height := FPngImageList.Height;
    end;
end;

procedure TsePngImageView.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TsePngImageView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPngImageList) then
    FPngImageList := nil;
  if (Operation = opRemove) and (AComponent = FPngImageStorage) then
    FPngImageStorage := nil;
end;


procedure TsePngImageView.SetImageIndex(Value: Integer);
var
  OldImageIndex: Integer;
begin
  OldImageIndex := FImageIndex;
  if Value >= -1
  then
    FImageIndex := Value;

  if FPngImageStorage <> nil
  then
    begin
      if FReflectionEffect then CreateReflection;
      if FAutoSize then AdjustBounds;
      if FAnimation = nil then RePaint;
    end
  else
  if FPngImageList <> nil
  then
    begin
      if FReflectionEffect then CreateReflection;
      if FAutoSize then AdjustBounds;
      if FAnimation = nil then RePaint;
    end;

  if (FAnimation <> nil) and not (csDesigning in ComponentState)
  then
  begin
    StopMultiAnimation(FAniIndex);
    SourceImage.SetSize(Width, Height);
    PrepareImage(OldImageIndex, SourceImage);
    DestImage.SetSize(Width, Height);
    PrepareImage(FImageIndex, DestImage);
    StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
  end;

end;

procedure TsePngImageView.SetCenter;
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    RePaint;
  end;
end;


// TsePngXButton

constructor TsePngXButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque, csReplicatable];
  FAutoSize := True;
  //
  SourceImage := TseBitmap.Create;
  DestImage := TseBitmap.Create;
  FAniIndex := -1;
  FAniIndex := ReserveIndex;
  //
  FChangeActive := False;
  FChangeDown := False;
  FMargin := -1;
  FSpacing := 1;
  FLayout := seblGlyphLeft;
  FDown := False;
  FMouseIn := False;
  FGlyphIndex := -1;
  FGlyphList := nil;
  FImageDownIndex := -1;
  FImageHotIndex := -1;
  FImageNormalIndex := -1;
  FDoubleBuffered := True;
  FPngImageList := nil;
  FPngImageStorage := nil;
  FImageIndex := -1;
  FAnimation := nil;
  Width := 50;
  Height := 50;
end;

procedure TsePngXButton.CMTextChanged;
begin
  inherited;
  RePaint;
end;

function TsePngXButton.IsTransparentPixel;
var
  P: TsePngImage;
  {$IFNDEF VER200}
  Line: se_PngImage.PByteArray;
  {$ELSE}
  Line: PByteArray;
  {$ENDIF}
  B: Byte;
begin
  Result := False;
  P := nil;
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    P := FPngImageStorage.PngImages[FImageIndex].PngImage
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (ImageIndex >= 0) and
     (ImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    P := FPngImageList.PngImages[FImageIndex].PngImage;
  if (P <> nil) and (X < P.Width) and (Y < P.Height)
  then
    begin
      Line := P.AlphaScanline[Y];
      B := Line^[X];
      Result := B = 0;
    end
  else
    Result := True;
end;

procedure TsePngXButton.SetLayout;
begin
  if FLayout <> Value
  then
    begin
      FLayout := Value;
      RePaint;
    end;
end;

procedure TsePngXButton.SetSpacing;
begin
  if Value <> FSpacing
  then
    begin
      FSpacing := Value;
      RePaint;
    end;
end;

procedure TsePngXButton.SetMargin;
begin
  if (Value <> FMargin) and (Value >= -1)
  then
    begin
      FMargin := Value;
      RePaint;
    end;
end;

procedure TsePngXButton.SetGlyphIndex;
begin
  FGlyphIndex := Value;
  RePaint;
end;

procedure TsePngXButton.DrawButtonGlyphAndText;
var
  IIndex: Integer;
begin
  C.Font := Self.Font;
  if AActive
  then
    C.Font.Color := FActiveFontColor;

  if (FGlyphList <> nil) and (FGlyphIndex >= 0) and
       (FGlyphIndex < FGlyphList.Count)
  then
    IIndex := FGlyphIndex
  else
    IIndex := -1;

  DrawImageAndText(C, ClientRect, FMargin, FSpacing, FLayout,
     Caption, IIndex, FGlyphList, False, Enabled, False, 0);
end;


destructor TsePngXButton.Destroy;
begin
  StopMultiAnimation(FAniIndex);
  SourceImage.Free;
  SourceImage := nil;
  DestImage.Free;
  DestImage := nil;
  inherited;
end;

procedure  TsePngXButton.SetImageNormalIndex;
begin
  FImageNormalIndex := Value;
  ImageIndex := FImageNormalIndex;
  RePaint;
end;

procedure TsePngXButton.SetDoubleBuffered(Value: Boolean);
begin
  FDoubleBuffered := Value;
  if FDoubleBuffered
  then ControlStyle := ControlStyle + [csOpaque]
  else ControlStyle := ControlStyle - [csOpaque];
end;

procedure TsePngXButton.PrepareImage;
var
  H, X, Y: Integer;
begin
  GetParentImage(Self, ABitMap.Canvas);
  //
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (AImageIndex >= 0) and
     (AImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      FPngImageStorage.Draw(AImageIndex, ABitMap.Canvas, 0, 0, Enabled);
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (AImageIndex >= 0) and
     (AImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      FPngImageList.Draw(ABitMap.Canvas, 0, 0, AImageIndex, Enabled);
    end;
  if (Caption <> '') or (FGlyphIndex <> -1)
  then
    DrawButtonGlyphAndText(ABitMap.Canvas, AActive);
end;

procedure TsePngXButton.CMMouseEnter;
var
  IIndex: Integer;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := True;
  if Enabled
  then
    begin
      if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
      IIndex := -1;
      if FDown then IIndex := FImageDownIndex;
      if IIndex =-1 then IIndex := FImageHotIndex;
      if IIndex =-1 then IIndex := FImageNormalIndex;
      FChangeActive := True;
      ImageIndex := IIndex;
      FChangeActive := False;
    end;
  if Enabled
  then
    if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TsePngXButton.CMMouseLeave;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  FMouseIn := False;
  if Enabled
  then
    begin
      if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
      if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
      FChangeActive := True;
      ImageIndex := FImageNormalIndex;
      FChangeActive := False;
    end;
  if Enabled
  then
    if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TsePngXButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  {$IFDEF VER150_UP}
  if ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and FMouseIn and FDown
  then
    Perform(CM_MOUSELEAVE, 0, 0)
  else
  if not ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and not FMouseIn and FDown
  then
    Perform(CM_MOUSEENTER, 0, 0);
  {$ENDIF}
end;

procedure TsePngXButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  IIndex: Integer;
begin
  inherited;
  if FAnimation <> nil then StopMultiAnimation(FAniIndex);
  FDown := True;
  IIndex := FImageDownIndex;
  if IIndex = -1 then IIndex := FImageHotIndex;
  if IIndex = -1 then IIndex := FImageNormalIndex;
  FChangeDown := True;
  ImageIndex := IIndex;
  FChangeDown := False;
end;

procedure TsePngXButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  IIndex: Integer;
begin
  inherited;
  FDown := False;
  if FMouseIn
  then
    IIndex := FImageHotIndex
  else
    IIndex := FImageNormalIndex;
  if IIndex = -1 then IIndex := FImageNormalIndex;
  if FMouseIn
  then
    begin
      FChangeDown := True;
      ImageIndex := IIndex;
      FChangeDown := False;
    end;  
end;

procedure TsePngXButton.Paint;
var
  H, X, Y: Integer;
  C: TCanvas;
  Buffer: TBitMap;
begin
  if FDoubleBuffered
  then
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := Width;
      Buffer.Height := Height;
      GetParentImage(Self, Buffer.Canvas);
      C := Buffer.Canvas;
    end
  else
    C := Canvas;

  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      FPngImageStorage.Draw(FImageIndex, C, 0, 0, Enabled);
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      FPngImageList.Draw(C, 0, 0, FImageIndex, Enabled);
    end;

  if (Caption <> '') or (FGlyphIndex <> -1)
  then
    DrawButtonGlyphAndText(C, FMouseIn);

  if csDesigning in ComponentState
  then
    with C do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;

  if FDoubleBuffered
  then
    begin
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end;
end;    

procedure TsePngXButton.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TsePngXButton.AdjustBounds;
begin
  if FAutoSize and (FPngImageStorage <> nil) and
     (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      Width := FPngImageStorage.PngImages[FImageIndex].PngWidth;
      Height := FPngImageStorage.PngImages[FImageIndex].PngHeight;
    end
  else
  if FAutoSize and (FPngImageList <> nil)
  then
    begin
      Width := FPngImageList.Width;
      Height := FPngImageList.Height;
    end;
end;

procedure TsePngXButton.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TsePngXButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPngImageList) then
    FPngImageList := nil;
  if (Operation = opRemove) and (AComponent = FPngImageStorage) then
    FPngImageStorage := nil;
  if (Operation = opRemove) and (AComponent = FGlyphList) then
    FGlyphList := nil;
end;


procedure TsePngXButton.SetImageIndex(Value: Integer);
var
  OldImageIndex: Integer;
  OldActive, NewActive: Boolean;
begin
  OldImageIndex := FImageIndex;
  if Value >= -1
  then
    FImageIndex := Value;

  if FPngImageStorage <> nil
  then
    begin
      if FAutoSize then AdjustBounds;
      if FAnimation = nil then RePaint;
    end
  else
  if FPngImageList <> nil
  then
    begin
      if FAutoSize then AdjustBounds;
      if FAnimation = nil then RePaint;
    end;

  if (FAnimation <> nil) and not (csDesigning in ComponentState)
  then
  begin
    if FChangeActive
    then
      begin
        OldActive := not FMouseIn;
        NewActive := not OldActive;
      end
    else
      begin
        OldActive := False;
        NewActive := False;
      end;
    if FChangeDown
    then
      begin
        OldActive := True;
        NewActive := True;
      end
    else
      begin
         if FChangeActive
         then
           begin
            OldActive := not FMouseIn;
            NewActive := not OldActive;
          end
       else
          begin
            OldActive := False;
            NewActive := False;
          end;
      end;
    StopMultiAnimation(FAniIndex);
    SourceImage.SetSize(Width, Height);
    PrepareImage(OldImageIndex, SourceImage, OldActive);
    DestImage.SetSize(Width, Height);
    PrepareImage(FImageIndex, DestImage, NewActive);
    StartMultiAnimation(Canvas, 0, 0, SourceImage, DestImage, FAnimation, FAniIndex);
  end;

end;


// TsePngImagePanel

constructor TsePngImagePanel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csOpaque, csDoubleClicks, csReplicatable];
  FAutoSize := False;
  FAnimation := nil;
  FPngImageList := nil;
  FPngImageStorage := nil;
  FDown := False;
  FImageIndex := -1;
  Width := 150;
  Height := 150;
end;

destructor TsePngImagePanel.Destroy;
begin
  inherited;
end;

procedure TsePngImagePanel.WMMOVE;
begin
  inherited;
  RePaint;
end;

procedure TsePngImagePanel.MouseDown;
begin
  FDown := True;
  inherited;
end;

procedure TsePngImagePanel.MouseUp;
begin
  FDown := False;
  inherited;
end;

procedure TsePngImagePanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  {$IFDEF VER150_UP}
  if ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and FMouseIn and FDown
  then
    Perform(CM_MOUSELEAVE, 0, 0)
  else
  if not ((X < 0) or (Y < 0) or (X > Width) or (Y > Height)) and not FMouseIn and FDown
  then
    Perform(CM_MOUSEENTER, 0, 0);
  {$ENDIF}
end;


procedure TsePngImagePanel.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  RePaint;
end;

procedure TsePngImagePanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TsePngImagePanel.SetImageIndex(Value: Integer);
begin
  if (ChangeImageAnimation <> nil) and not (csDesigning in ComponentState) and
     not (csLoading in ComponentState)
  then
    begin
      FChangeImageAnimation.FreezeControl(Self, Rect(0, 0, Width, Height));
      FImageIndex := Value;
      with FChangeImageAnimation do
      begin
        try
          Execute;
        finally
          Restore;
        end;
      end;
    end
  else
    FImageIndex := Value;
  RePaint;
end;

procedure TsePngImagePanel.Paint;
begin
  PaintPanel(Canvas);
end;

procedure TsePngImagePanel.WMEraseBkgnd;
begin
  Msg.Result := 1;
end;

procedure TsePngImagePanel.PaintPanel(C: TCanvas);
var
  Buffer: TBitMap;
begin
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  GetParentImage(Self, Buffer.Canvas);
  // DrawImage
  if (FPngImageStorage <> nil) and (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      FPngImageStorage.Draw(FImageIndex, Buffer.Canvas, 0, 0, Enabled);
    end
  else
  if (FPngImageList <> nil) and
     (FPngImageList.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageList.Count) and
     (FPngImageList.Width > 0) and
     (FPngImageList.Height > 0)
  then
    begin
      FPngImageList.Draw(Buffer.Canvas, 0, 0, FImageIndex, Enabled);
    end;
  //
  C.Draw(0, 0, Buffer);
  Buffer.Free;
end;

procedure TsePngImagePanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FPngImageList) then
    FPngImageList := nil;
  if (Operation = opRemove) and (AComponent = FPngImageStorage) then
    FPngImageStorage := nil;
  if (Operation = opRemove) and (AComponent = FAnimation) then
    FAnimation := nil;
  if (Operation = opRemove) and (AComponent = FChangeImageAnimation) then
    FChangeImageAnimation := nil;
end;

procedure TsePngImagePanel.ExecuteAnimation;
begin
  if FAnimation = nil then Exit;
  FAnimation.FreezeControl(Self, Rect(0, 0, Width, Height));
  if Assigned(FOnPrepareAnimation) then FOnPrepareAnimation(Self);
  with FAnimation do
  begin
    try
      Execute;
    finally
      Restore;
     end;
  end;
end;


procedure TsePngImagePanel.StartTimer;
begin
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, 1000, nil);
end;

procedure TsePngImagePanel.StopTimer;
begin
  KillTimer(Handle, 1);
end;

procedure TsePngImagePanel.WMTimer(var Message: TWMTimer); 
begin
  if FMouseIn and not CheckControls
  then
    begin
      FMouseIn := False;
      StopTimer;
      if Enabled
      then
        if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
    end;
end;

function TsePngImagePanel.CheckControls;
var
  i: Integer;
  P: TPoint;
begin
  Result := False;
  GetCursorPos(P);
  if WindowFromPoint(P) = Self.Handle
  then
    begin
      Result := True;
      Exit;
    end;
  for i := 0 to ControlCount - 1 do
  if (Controls[i] is TWinControl) and Controls[i].Visible then
  begin
    if WindowFromPoint(P) = TWinControl(Controls[i]).Handle
    then
      begin
        Result := True;
        Exit;
      end;
  end;
end;

procedure TsePngImagePanel.CMMouseEnter;
begin
  inherited;
  if not FMouseIn and CheckControls
  then
    begin
      FMouseIn := True;
      StartTimer;
      if Enabled
      then
        if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
    end;
end;

procedure TsePngImagePanel.CMMouseLeave;
begin
  inherited;
  if FMouseIn and not CheckControls
  then
    begin
      StopTimer;
      FMouseIn := False;
      if Enabled
      then
        if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
    end;
end;

procedure TsePngImagePanel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value
  then
    FAutoSize := Value;
  if FAutoSize then AdjustBounds;
end;

procedure TsePngImagePanel.AdjustBounds;
begin
  if FAutoSize and (FPngImageStorage <> nil) and
     (FPngImageStorage.PngImages.Count > 0) and
     (FImageIndex >= 0) and
     (FImageIndex < FPngImageStorage.PngImages.Count)
  then
    begin
      Width := FPngImageStorage.PngImages[FImageIndex].PngWidth;
      Height := FPngImageStorage.PngImages[FImageIndex].PngHeight;
    end
  else
  if FAutoSize and (FPngImageList <> nil)
  then
    begin
      Width := FPngImageList.Width;
      Height := FPngImageList.Height;
    end;
end;

type
  TParentForm = class(TForm);

constructor TseLayeredSplashForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Buffer := TseBitmap.Create;
  FPngImageIndex := -1;
  FFirstShow := True;
  FOnShowAnimation := False;
  FOnHideAnimation := False;
  FPngImageStorage := nil;
  FForm := nil;
  FFormVisible := False;
  try
    FForm := (Owner as TForm);
  except
    if Owner is TCustomForm then FForm := TForm(Owner) else raise;
  end;
  if FForm <> nil
  then
    with FForm do
    begin
      AutoSize := False;
      AutoScroll := False;
      BorderStyle := bsNone;
      if not (csDesigning in ComponentState)
      then
        begin
          OldWindowProc := WindowProc;
          WindowProc := NewWndProc;
          SetWindowLong(FForm.Handle,
             GWL_EXSTYLE,
             GetWindowLong(FForm.Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
        end;
    end;
end;

procedure TseLayeredSplashForm.NewWndProc(var Message: TMessage);
var
  FCallOldWndProc: Boolean;
  TickCount: DWORD;
  I, Step: Integer;
begin
  FCallOldWndProc := True;
  with Message do
    case Msg of
       WM_TIMER:
         begin
           KillTimer(FForm.Handle, 1);
           TickCount := 0;
           I := 0;
           Step := 255 div 15;
           if Step = 0 then Step := 1;
           repeat
             if (GetTickCount - TickCount > 5)
             then
               begin
                 TickCount := GetTickCount;
                 Inc(I, Step);
                 if I > 255 then I := 255;
                 UpdateLayeredSplash(I);
               end;
           until I >= 255;
        end;
       WM_SHOWWINDOW:
       begin
         if Message.WParam > 0
         then
           begin
             FFormVisible := True;
             if FOnShowAnimation
             then
               begin
                 UpdateLayeredSplash(0);
                 OldWindowProc(Message);
                 SetTimer(FForm.Handle, 1, 1, nil);
                 FCallOldWndProc := False;
               end;
           end
         else
         if FFormVisible
         then
           begin
             FFormVisible := False;
             if FOnHideAnimation
             then
               begin
                 TickCount := 0;
                 I := 255;
                 Step := 255 div 15;
                 if Step = 0 then Step := 1;
                 repeat
                 if (GetTickCount - TickCount > 5)
                 then
                   begin
                     TickCount := GetTickCount;
                     Dec(I, Step);
                     if I < 0 then I := 0;
                     UpdateLayeredSplash(I);
                   end;
                until I <= 0;
              end;
          end;
       end;
   end;
  if FCallOldWndProc then OldWindowProc(Message);
end;


destructor TseLayeredSplashForm.Destroy;
begin
  Buffer.Free;
  inherited;
  if not (csDesigning in ComponentState) and (FForm <> nil)
  then
    FForm.WindowProc := OldWindowProc;
end;

procedure TseLayeredSplashForm.Loaded;
begin
  inherited;
  CreateLayeredSplash;
end;

procedure TseLayeredSplashForm.Notification(AComponent: TComponent;
            Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FPngImageStorage) then
    FPngImageStorage := nil;
end;

procedure TseLayeredSplashForm.CreateLayeredSplash;

procedure MakeCopyFromPng(B :TseBitMap; P: TsePngImage);
var
  X, Y: Integer;
  {$IFNDEF VER200}
  Line: se_PngImage.PByteArray;
  {$ELSE}
  Line: PByteArray;
  {$ENDIF}
  C: TseColor;
  DstP: PseColor;
begin
  B.SetSize(P.Width, P.Height);
  for Y := 0 to P.Height - 1 do
   begin
     Line := P.AlphaScanline[Y];
     for X := 0 to P.Width - 1 do
     begin
       DstP := B.PixelPtr[X, Y];
       DstP^ := seColor(P.Pixels[X, Y], $FF);
       TseColorRec(DstP^).A := Line^[X];
     end;
   end;
  B.CheckRGBA;
end;

var
  Blend: TBLENDFUNCTION;
  Origin, Size, BitmapOrigin: Windows.TPoint;
  PngImage: TsePngImage;
  OldRgn, Rgn: Cardinal;
begin
  if (csDesigning in ComponentState) then Exit;
  if FForm = nil then Exit;
  //
  PngImage := nil;
  if (FPngImageStorage <> nil) and (FPngImageIndex >= 0) and
     (FPngImageIndex < FPngImageStorage.PngImages.Count)
  then
    PngImage := FPngImageStorage.PngImages[FPngImageIndex].PngImage;
  //
  if PngImage = nil then Exit else if PngImage.Empty then Exit;
  //
  Buffer.AlphaBlend := True;
  MakeCopyFromPng(Buffer, PngImage);
  FForm.SetBounds(FForm.Left, FForm.Top, Buffer.Width, Buffer.Height);
  //
  Origin := Point(FForm.Left, FForm.Top);
  BitmapOrigin := Point(0, 0);
  Size := Point(Buffer.Width, Buffer.Height);
  with Blend do
  begin
    BlendOp := AC_SRC_OVER;
    AlphaFormat := $01;
    BlendFlags := 0;
    SourceConstantAlpha := 255;
  end;
  UpdateLayeredWindow(FForm.Handle, 0, @Origin, @Size, Buffer.DC,
    @BitmapOrigin, $00000000, @Blend, ULW_ALPHA);
end;

procedure TseLayeredSplashForm.UpdateLayeredSplash(AAlphaBlendValue: Integer);
var
  Blend: TBLENDFUNCTION;
  Origin, Size, BitmapOrigin: Windows.TPoint;
  OldRgn, Rgn: Cardinal;
begin
  if (csDesigning in ComponentState) or
     (FForm = nil) or
     (Buffer.Width = 0)
  then
    Exit;
  //
  Origin := Point(FForm.Left, FForm.Top);
  BitmapOrigin := Point(0, 0);
  Size := Point(Buffer.Width, Buffer.Height);
  with Blend do
  begin
    BlendOp := AC_SRC_OVER;
    AlphaFormat := $01;
    BlendFlags := 0;
    SourceConstantAlpha := AAlphaBlendValue;
  end;
  UpdateLayeredWindow(FForm.Handle, 0, @Origin, @Size, Buffer.DC,
    @BitmapOrigin, $00000000, @Blend, ULW_ALPHA);
end;


end.
