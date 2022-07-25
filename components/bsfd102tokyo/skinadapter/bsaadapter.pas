{*******************************************************************}
{                                                                   }
{       SkinAdapter                                                 }
{       BusinessSkinForm                                            }
{       Version 5.30                                                }
{                                                                   }
{       Copyright (c) 2005-2016 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}


unit bsaadapter;

{$IFDEF WIN32}
  {$DEFINE AL_WIN}
{$ELSE}
  {$DEFINE AL_LINUX}
{$ENDIF}

{$IFDEF MSWINDOWS}
  {$DEFINE AL_WIN}
{$ENDIF}

  {$IFDEF VER170}
    {$DEFINE AL_COMPILER9}
    {$DEFINE AL_DELPHI9}
    {$DEFINE AL_DELPHI}
  {$ENDIF}
  
  {$IFDEF VER150}
    {$DEFINE AL_COMPILER7}
    {$IFDEF BCB}
      {$DEFINE AL_CBUILDER7}
      {$DEFINE AL_CBUILDER}
    {$ELSE}
      {$DEFINE AL_DELPHI7}
      {$DEFINE AL_DELPHI}
    {$ENDIF}
  {$ENDIF}

  {$IFDEF VER140}
    {$DEFINE AL_COMPILER6}
    {$IFDEF BCB}
      {$DEFINE AL_CBUILDER6}
      {$DEFINE AL_CBUILDER}
    {$ELSE}
      {$DEFINE AL_DELPHI6}
      {$DEFINE AL_DELPHI}
    {$ENDIF}
  {$ENDIF}

  {$IFDEF VER130}
    {$DEFINE AL_COMPILER5}
    {$IFDEF BCB}
      {$DEFINE AL_CBUILDER5}
      {$DEFINE AL_CBUILDER}
    {$ELSE}
      {$DEFINE AL_DELPHI5}
      {$DEFINE AL_DELPHI}
    {$ENDIF}
  {$ENDIF}

  {$IFDEF VER125}
    {$DEFINE AL_COMPILER4}
    {$DEFINE AL_CBUILDER4}
    {$DEFINE AL_CBUILDER}
  {$ENDIF}

  {$IFDEF VER120}
    {$DEFINE AL_COMPILER4}
    {$DEFINE AL_DELPHI4}
    {$DEFINE AL_DELPHI}
  {$ENDIF}

  {$IFDEF AL_DELPHI9}
    {$DEFINE AL_DELPHI9_UP}
    {$DEFINE AL_DELPHI7_UP}
    {$DEFINE AL_DELPHI6_UP}
    {$DEFINE AL_DELPHI5_UP}
    {$DEFINE AL_DELPHI4_UP}
  {$ENDIF}

  {$IFDEF AL_DELPHI7}
    {$DEFINE AL_DELPHI7_UP}
    {$DEFINE AL_DELPHI6_UP}
    {$DEFINE AL_DELPHI5_UP}
    {$DEFINE AL_DELPHI4_UP}
  {$ENDIF}

  {$IFDEF AL_DELPHI6}
    {$DEFINE AL_DELPHI6_UP}
    {$DEFINE AL_DELPHI5_UP}
    {$DEFINE AL_DELPHI4_UP}
  {$ENDIF}

  {$IFDEF AL_DELPHI5}
    {$DEFINE AL_DELPHI5_UP}
    {$DEFINE AL_DELPHI4_UP}
  {$ENDIF}

  {$IFDEF AL_DELPHI4}
    {$DEFINE AL_DELPHI4_UP}
  {$ENDIF}

  {$IFDEF AL_CBUILDER6}
    {$DEFINE AL_CBUILDER6_UP}
    {$DEFINE AL_CBUILDER5_UP}
    {$DEFINE AL_CBUILDER4_UP}
  {$ENDIF}

  {$IFDEF AL_CBUILDER5}
    {$DEFINE AL_CBUILDER5_UP}
    {$DEFINE AL_CBUILDER4_UP}
  {$ENDIF}

  {$IFDEF AL_CBUILDER4}
    {$DEFINE AL_CBUILDER4_UP}
  {$ENDIF}


{ ------------ !! COMPILER COMPATIBLE !! ------------ }

{$IFDEF AL_COMPILER9}
  {$DEFINE AL_COMPILER9_UP}
  {$DEFINE AL_COMPILER7_UP}
  {$DEFINE AL_COMPILER6_UP}
  {$DEFINE AL_COMPILER5_UP}
  {$DEFINE AL_COMPILER4_UP}
{$ENDIF}

{$IFDEF AL_COMPILER7}
  {$DEFINE AL_COMPILER7_UP}
  {$DEFINE AL_COMPILER6_UP}
  {$DEFINE AL_COMPILER5_UP}
  {$DEFINE AL_COMPILER4_UP}
{$ENDIF}

{$IFDEF AL_COMPILER6}
  {$DEFINE AL_COMPILER6_UP}
  {$DEFINE AL_COMPILER5_UP}
  {$DEFINE AL_COMPILER4_UP}
{$ENDIF}

{$IFDEF AL_COMPILER5}
  {$DEFINE AL_COMPILER5_UP}
  {$DEFINE AL_COMPILER4_UP}
{$ENDIF}

{$IFDEF AL_COMPILER4}
  {$DEFINE AL_COMPILER4_UP}
{$ENDIF}

{ ------------ !! DO NOT CHANGE DEFINES BELOW THIS LINE !! ------------ }

{$IFDEF AL_CBUILDER}
  {$ObjExportAll On}
{$ENDIF}

{$ALIGN ON}
{$BOOLEVAL OFF}
{$LONGSTRINGS ON}
{$WRITEABLECONST ON}

{ ------------ !! DO NOT CHANGE DEFINES BELOW THIS LINE !! ------------ }

{$IFNDEF AL_DEBUG}
  {$WARNINGS OFF}
  {$HINTS OFF}
{$ENDIF}

{$B-} {- Complete Boolean Evaluation }
{$R-} {- Range-Checking }
{$V-} {- Var-String Checking }
{$T-} {- Typed @ operator }
{$X+} {- Extended syntax }
{$P+} {- Open string params }
{$J+} {- Enable writeable const}

{$IFDEF AL_COMPILER7}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$WARN UNSAFE_TYPE OFF}
  {$WARN UNSAFE_CODE OFF}
  {$WARN UNSAFE_CAST OFF}
{$ENDIF}


//{$DEFINE DEVEX_SUPPORT}
//{$DEFINE LOOKUP_SUPPORT}
//{$DEFINE TNTUNICODE_SUPPORT}

interface

uses Windows, Messages, Forms, Sysutils, Classes, Graphics, Controls, ImgList,
  Dialogs, Menus, ExtDlgs, CommCtrl, StdCtrls, ExtCtrls, ClipBrd, ComCtrls,
  Buttons, TypInfo, SyncObjs,
  {$IFDEF TNTUNICODE_SUPPORT} TntComCtrls, {$ENDIF}
  BusinessSkinForm, bsSkinData, bsEffects, bsSkinCtrls, bsSkinBoxCtrls,
  bsUtils {$IFDEF DEVEX_SUPPORT}, cxControls, bsaDevExSkin{$ENDIF};

{!============================================================================!}

const
  saSkinAdapterVersion = '5.25';
  saSkinAdapterVersionPropText = 'SkinAdapter Version ' + saSkinAdapterVersion;

  // Billenium Effects messages
  BE_ID           = $41A2;
  BE_BASE         = CM_BASE + $0C4A;
  CM_BEPAINT      = BE_BASE + 0; // Paint client area to Billenium Effects' DC
  CM_BENCPAINT    = BE_BASE + 1; // Paint non client area to Billenium Effects' DC
  CM_BEFULLRENDER = BE_BASE + 2; // Paint whole control to Billenium Effects' DC
  CM_BEWAIT       = BE_BASE + 3; // Don't execute effect yet
  CM_BERUN        = BE_BASE + 4; // Execute effect now!

type
  TbsaSkinAdapterVersion = type string;

{ TbsaSkinAdapter class }

  TbsaAdapterType = (bsaUseNames, bsaUseClasses);

  TbsaSkinAdapter = class(TbsSkinComponent)
  private
    FAdapterType: TbsaAdapterType;
    //
    FLoaded: Boolean;
    FCollecting: Boolean;
    { Scrollbars }
    FScrollSubclassStr: TStrings;
    FSubclass: TComponent;
    FScrollSkinDataName: String;
    FVScrollSkinDataName: String;
    FHScrollSkinDataName: String;
    FButtonSubclassStr: TStrings;
    FSpeedButtonSubclassStr: TStrings;
    FCheckBoxSubclassStr: TStrings;
    FRadioButtonSubclassStr: TStrings;
    FUpDownBoxSubclassStr: TStrings;
    FEditSubclassStr: TStrings;
    FDateTimeSubclassStr: TStrings;
    FComboBoxSubclassStr: TStrings;
    FListViewSubclassStr: TStrings;
    FTabSubclassStr: TStrings;
    FGroupBoxSubclassStr: TStrings;
    FPanelSubclassStr: TStrings;
    FToolBarSubclassStr: TStrings;
    FCoolBarSubclassStr: TStrings;
    FProgressBarSubclassStr: TStrings;
    FTrackBarSubclassStr: TStrings;
    FStatusBarSubclassStr: TStrings;
    FButtonSkinDataName: String;
    FPanelSkinDataName: String;
    FToolbarSkinDataName: String;
    FCoolbarSkinDataName: String;
    FSpeedButtonSkinDataName: String;
    FButtonUseSkinSize: Boolean;
    FSpeedButtonUseSkinSize: Boolean;
    FAutoAddNames: Boolean;
    FAutoAddClasses: Boolean;
    FTabsBGTransparent: Boolean;
    FOnCollectForm: TNotifyEvent;
    FOnChangeSkinData: TNotifyEvent;
    FUpDownSubclassStr: TStrings;
    FLabelSubClassStr: TStrings;
    function GetVersion: string;
    procedure SetLabelSubclass(const Value: TStrings);
    procedure SetScrollSubclass(const Value: TStrings);
    procedure SetVersion(const Value: string);
    procedure SetVScrollSkinDataName(const Value: String);
    procedure SetHScrollSkinDataName(const Value: String);
    procedure SetButtonSubclass(const Value: TStrings);
    procedure SetSpeedButtonSubclass(const Value: TStrings);
    procedure SetCheckBoxSubclass(const Value: TStrings);
    procedure SetComboBoxSubclass(const Value: TStrings);
    procedure SetEditSubclass(const Value: TStrings);
    procedure SetDateTimeSubclass(const Value: TStrings);
    procedure SetListViewSubclass(const Value: TStrings);
    procedure SetTabSubclass(const Value: TStrings);
    procedure SetRadioButtonSubclass(const Value: TStrings);
    procedure SetGroupBoxSubclass(const Value: TStrings);
    procedure SetPanelSubclass(const Value: TStrings);
    procedure SetToolBarSubclass(const Value: TStrings);
    procedure SetCoolBarSubclass(const Value: TStrings);
    procedure SetProgressBarSubclass(const Value: TStrings);
    procedure SetTrackBarSubclass(const Value: TStrings);
    procedure SetStatusBarSubclass(const Value: TStrings);
    procedure SetAutoAddNames(Value: Boolean);
    procedure SetAutoAddClasses(Value: Boolean);
    {$IFDEF DEVEX_SUPPORT}
    procedure UpdateDevExControls;
    {$ENDIF}
    procedure SetAdapterType(Value: TbsaAdapterType);
    procedure SetUpDownSubclass(const Value: TStrings);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsHandleListEmpty: Boolean;
    procedure Loaded; override;
    procedure ChangeSkinData; override;
    procedure CollectForms;
    procedure ResetForms;
    procedure AddControl(C: TControl; ASubClassList: TStrings);
    procedure RemoveControl(C: TControl);
    procedure ReleaseSkin;
    procedure ApplySkin;
    procedure AddDefClasses;
  published
    property AdapterType: TbsaAdapterType read FAdapterType write SetAdapterType;
    property TabsBGTransparent: Boolean read FTabsBGTransparent write FTabsBGTransparent;
    property AutoAddNames: Boolean read FAutoAddNames write SetAutoAddNames;
    property AutoAddClasses: Boolean read FAutoAddClasses write SetAutoAddClasses;
    property SkinData;
    property LabelSubclass: TStrings read FLabelSubclassStr write SetLabelSubclass;
    property ScrollSubclass: TStrings read FScrollSubclassStr write SetScrollSubclass;
    property VScrollSkinDataName: String read FVScrollSkinDataName write SetVScrollSkinDataName;
    property HScrollSkinDataName: String read FHScrollSkinDataName write SetHScrollSkinDataName;
    property ButtonSubclass: TStrings read FButtonSubclassStr write SetButtonSubclass;
    property SpeedButtonSubclass: TStrings read FSpeedButtonSubclassStr write SetSpeedButtonSubclass;
    property CheckBoxSubclass: TStrings read FCheckBoxSubclassStr write SetCheckBoxSubclass;
    property RadioButtonSubclass: TStrings read FRadioButtonSubclassStr write SetRadioButtonSubclass;
    property UpDownSubclass: TStrings read FUpDownSubclassStr write SetUpDownSubclass;
    property EditSubclass: TStrings read FEditSubclassStr write SetEditSubclass;
    property DateTimeSubclass: TStrings read FDateTimeSubclassStr write SetDateTimeSubclass;
    property ComboBoxSubclass: TStrings read FComboBoxSubclassStr write SetComboBoxSubclass;
    property ListViewSubclass: TStrings read FListViewSubclassStr write SetListViewSubclass;
    property TabSubclass: TStrings read FTabSubclassStr write SetTabSubclass;
    property GroupBoxSubclass: TStrings read FGroupBoxSubclassStr write SetGroupBoxSubclass;
    property PanelSubclass: TStrings read FPanelSubclassStr write SetPanelSubclass;
    property ToolBarSubclass: TStrings read FToolBarSubclassStr write SetToolBarSubclass;
    property CoolBarSubclass: TStrings read FCoolBarSubclassStr write SetCoolBarSubclass;
    property ProgressBarSubclass: TStrings read FProgressBarSubclassStr write SetProgressBarSubclass;
    property TrackBarSubclass: TStrings read FTrackBarSubclassStr write SetTrackBarSubclass;
    property StatusBarSubclass: TStrings read FStatusBarSubclassStr write SetStatusBarSubclass;
    property Version: string read GetVersion write SetVersion;
    property ButtonSkinDataName: String read FButtonSkinDataName write FButtonSkinDataName;
    property SpeedButtonSkinDataName: String read FSpeedButtonSkinDataName write FSpeedButtonSkinDataName;
    property ButtonUseSkinSize: Boolean read FButtonUseSkinSize write FButtonUseSkinSize;
    property SpeedButtonUseSkinSize: Boolean read FSpeedButtonUseSkinSize write FSpeedButtonUseSkinSize;
    property PanelSkinDataName: String read FPanelSkinDataName write FPanelSkinDataName;
    property ToolBarSkinDataName: String read FToolBarSkinDataName write FToolBarSkinDataName;
    property CoolBarSkinDataName: String read FCoolBarSkinDataName write FCoolBarSkinDataName;
    property OnCollectForm: TNotifyEvent read FOnCollectForm write FOnCollectForm;
    property OnChangeSkinData: TNotifyEvent read FOnChangeSkinData write FOnChangeSkinData;
  end;


const

  CM_RECREATEWINDOW  = CM_BASE + 222;
  CM_DESTROYHOOK     = CM_BASE + 223;
  CM_DTWASDROP = CM_BASE + 224;


type
  TbsaControlHookMessageEvent = procedure (Control: TControl; var Msg: TMessage;
    DefaultProc: TWndMethod) of object;
  TbsaHookMessageEvent = procedure (Control: HWnd; var Msg: TMessage;
    DefaultProc: TWndMethod) of object;
  TbsaUnhookEvent = procedure (Constol: TControl; Handle: HWnd) of object;

  TControlClass = class of TControl;

{ TbsaHook component }

  TbsaHook = class(TComponent)
  private
    FActive: Boolean;
    FControl: TControl;
    FHandle: HWnd;
    FControlHook: TObject;
    FOnHandleMessage: TbsaHookMessageEvent;
    FOnControlHandleMessage: TbsaControlHookMessageEvent;
    FOnUnhookControl: TbsaUnhookEvent;

    function GetControl: TControl;
    function GetHookHandle: HWnd;
    procedure SetActive(Value: Boolean);
    procedure SetControl(Value: TControl);

    function DoUnhookControl: Pointer;
    function GetHandle: HWnd;
    procedure SetHandle(const Value: HWnd);
  protected
    procedure DoHandleMessage(var Msg: TMessage; DefaultProc: TWndMethod); virtual;
    property HookHandle: HWnd read GetHookHandle;
  public
    constructor Create(AControl: TControl = nil; AOnHandleMessage: TbsaControlHookMessageEvent = nil); virtual;
    constructor CreateByHandle(AControl: HWnd = 0; AOnHandleMessage: TbsaHookMessageEvent = nil); virtual;
    destructor Destroy; override;

    procedure HookControl;
    procedure UnhookControl;

    property Active: Boolean read FActive write SetActive default True;
    property Control: TControl read GetControl write SetControl;
    property Handle: HWnd read GetHandle write SetHandle;

    property OnControlHandleMessage: TbsaControlHookMessageEvent read FOnControlHandleMessage
      write FOnControlHandleMessage;
    property OnHandleMessage: TbsaHookMessageEvent read FOnHandleMessage write FOnHandleMessage;
    property OnUnhookControl: TbsaUnhookEvent read FOnUnhookControl write FOnUnhookControl;
  end;

{ TbsaHookCollection class }

  TbsaHookCollection = class(TObject)
  private
    FHookList: TList;
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure AddControl(AControl: TControl; AOnHandleMessage: TbsaControlHookMessageEvent;
      AOnUnhookControl: TbsaUnhookEvent); overload;
    procedure AddControl(AControl: HWnd; AOnHandleMessage: TbsaHookMessageEvent;
      AOnUnhookControl: TbsaUnhookEvent); overload;
    procedure RemoveControl(AControl: TControl; AUnhook: Boolean = False); overload;
    procedure RemoveControl(AControl: HWnd; AUnhook: Boolean = False); overload;

    procedure CollectControl(AOwner: TComponent; AControlClass: TControlClass;
      AOnHandleMessage: TbsaControlHookMessageEvent; AOnUnhookControl: TbsaUnhookEvent);
    procedure CollectControlByHandle(AOwner: TComponent; AControlClass: TControlClass;
      AOnHandleMessage: TbsaHookMessageEvent; AOnUnhookControl: TbsaUnhookEvent);
    procedure CollectControlByClass(AOwner: TComponent; AClass: string;
      AOnHandleMessage: TbsaHookMessageEvent; AOnUnhookControl: TbsaUnhookEvent);
    procedure CollectControlByClass2(AOwnerWindow: HWnd; AClass: string;
      AOnHandleMessage: TbsaHookMessageEvent;
      AOnControlHandleMessage: TbsaControlHookMessageEvent;
      AOnUnhookControl: TbsaUnhookEvent);
  end;

var
  SubClassManagerFree: Boolean = False;


const

  WM_POSTACTION = WM_USER + 2595;

type

{ TbsaSkinManager component }

  TbsaSkinManager = class(TComponent)
  private
    FCustomProp: TStrings;
    FHookCollection: TbsaHookCollection;
    FHotTrackTimer: TTimer;
    FMousePos, FOldMousePos: TPoint;
    FUnhooking: Boolean;
    FUnhookedList: TList;
    FAdapter: TbsaSkinAdapter;
    FCurrentSubclass: TClass;
    FHandleList: TList;
    procedure DoHotTrackTimer(Sender: TObject);
    function IsSkinAvailable: Boolean;
  protected
    procedure DoHandleMessage(Handle: HWnd; var Msg: TMessage;
      DefaultProc: TWndMethod); virtual;
    procedure DoControlMessage(Control: TControl; var Msg: TMessage;
      DefaultProc: TWndMethod); virtual;
    procedure DoUnhook(Control: TControl; Handle: HWnd);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsHandleListEmpty: Boolean;
    procedure CollectScrollControl(C: TControl);
    procedure CollectScroll(AForm: TComponent);
    procedure CollectButtonControl(C: TControl);
    procedure CollectButton(AForm: TComponent);
    procedure CollectSpeedButtonControl(C: TControl);
    procedure CollectSpeedButton(AForm: TComponent);
    procedure CollectEditControl(C: TControl);
    procedure CollectEdit(AForm: TComponent);
    procedure CollectDateTimeControl(C: TControl);
    procedure CollectDateTime(AForm: TComponent);
    procedure CollectComboBoxControl(C: TControl);
    procedure CollectComboBox(AForm: TComponent);
    procedure CollectCheckBoxControl(C: TControl);
    procedure CollectCheckBox(AForm: TComponent);
    procedure CollectRadioButtonControl(C: TControl);
    procedure CollectRadioButton(AForm: TComponent);
    procedure CollectUpDown(AForm: TComponent);
    procedure CollectUpDownControl(C: TControl);
    procedure CollectListViewControl(C: TControl);
    procedure CollectListView(AForm: TComponent);
    procedure CollectTabControl(C: TControl);
    procedure CollectTab(AForm: TComponent);
    procedure CollectPanelControl(C: TControl);
    procedure CollectPanel(AForm: TComponent);
    procedure CollectToolBarControl(C: TControl);
    procedure CollectCoolBarControl(C: TControl);
    procedure CollectProgressBarControl(C: TControl);
    procedure CollectTrackBarControl(C: TControl);
    procedure CollectStatusBarControl(C: TControl);
    procedure CollectToolBar(AForm: TComponent);
    procedure CollectCoolBar(AForm: TComponent);
    procedure CollectProgressBar(AForm: TComponent);
    procedure CollectTrackBar(AForm: TComponent);
    procedure CollectStatusBar(AForm: TComponent);
    procedure CollectLabelControl(C: TControl);
    procedure CollectLabel(AForm: TComponent);
    procedure UnCollectLabelControl(C: TControl);
    procedure UnCollectLabel(AForm: TComponent);
    procedure CollectGroupBoxControl(C: TControl);
    procedure CollectGroupBox(AForm: TComponent);
    procedure DisableSubclass;
    procedure SkinChanged;
    procedure BeforeSkinChanged;
    procedure AfterSkinChanged;
    property Adapter: TbsaSkinAdapter read FAdapter write FAdapter;
  published
  end;

  TbsaSubclass = class
  private
    FHandle: HWnd;
    FControl: TControl;
    FFocused: Boolean;
    FDefaultProc: TWndMethod;
    FPropNames: array [0..30] of string;
    FPropValues: array [0..30] of string;
    FPropCount: Integer;
    FHandled: Boolean;
    FHotTrack: Boolean;
    FOverridedPaint: Boolean;
    FOverridedEraseBkgnd: Boolean;
    FDoubleBuffered: Boolean;
    FManager: TbsaSkinManager;
    function GetValues(index: string): string;
    procedure SetValues(index: string; const Value: string);
    function GetBValues(index: string): Boolean;
    procedure SetBValues(index: string; const Value: Boolean);
    function GetHeight: Integer;
    function GetWidth: Integer;
    function GetEnabled: Boolean;
    function GetHandle: HWnd;
    function GetFocused: Boolean;
    function GetMouseInControl: Boolean;
    function GetText: WideString;
  protected
    FIgnoreStyleChanged: Boolean;
    procedure OveridedWMPaint(var Msg: TMessage);
    procedure WMPaint(var Msg: TMessage); message WM_PAINT;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TMessage); message WM_KILLFOCUS;
    procedure WMPostAction(var Msg: TMessage); message WM_POSTACTION;
    procedure WMStyleChanged(var Msg: TWMStyleChange); message WM_STYLECHANGED;
    procedure WMStyleChanging(var Msg: TWMStyleChange); message WM_STYLECHANGING;
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure WMUpdateUIState(var Msg: TMessage); message WM_UPDATEUISTATE;
    procedure Invalidate;
    procedure InvalidateFromPaint(DC: HDC);
    procedure CallDefaultProc(var Msg: TMessage);
    function GetClientRect: TRect;
    function GetBoundsRect: TRect;
    function GetBorderTopLeft: TPoint;

    function GetStringPropValue(APropName: string): WideString;

    function HaveBorder: Boolean; virtual;

    procedure SetControl(const Value: TControl); virtual;
    procedure SetHandle(const Value: HWnd); virtual;
    procedure PostAction; virtual;

    function DrawTextBiDiModeFlags(Flags: LongInt): LongInt;
    procedure Paint(Canvas: TCanvas); virtual; abstract;
    procedure PaintBorder(Canvas: TCanvas; R: TRect); virtual;
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Unskin; virtual;
    procedure SkinChange; virtual;
    procedure BeforeSkinChange; virtual;
    procedure AfterSkinChange; virtual;

    property Handled: Boolean read FHandled write FHandled;
    property Control: TControl read FControl write SetControl;
    property Handle: HWnd read GetHandle write SetHandle;
    property Text: WideString read GetText;

    property Width: Integer read GetWidth;
    property Height: Integer read GetHeight;
    property Enabled: Boolean read GetEnabled;

    property MouseInControl: Boolean read GetMouseInControl;
    property Focused: Boolean read GetFocused;
    property DefaultProc: TWndMethod read FDefaultProc write FDefaultProc;
    property Values[index: string]: string read GetValues write SetValues;
    property BValues[index: string]: Boolean read GetBValues write SetBValues;
  end;

  TbsaSubclassClass = class of TbsaSubclass;

  TbsaScrollButtonDrawState = (
    bsasbNormal,
    bsasbPressed,
    bsasbHot,
    bsasbDisabled
  );

  TbsaScrollSubclass = class(TbsaSubclass)
  private
    Picture: TBitmap;
    FKind: TScrollBarKind;
    procedure DrawBorder(ADC: HDC; AUseExternalDC: Boolean);
    procedure DrawButton(Cnvs: TCanvas; i: Integer);
  protected
    FOldPos: Integer;
    FCurPos, LVOldCurPos: single;
    VScrollWnd, HScrollWnd: TWinControl;
    VSliderState, VUpState, VDownState: TbsaScrollButtonDrawState;
    HSliderState, HUpState, HDownState: TbsaScrollButtonDrawState;
    function VScrollDisabled: Boolean;
    function HScrollDisabled: Boolean;
    function VDownButtonRect: TRect;
    function VScrollRect: TRect;
    function VSliderRect: TRect;
    function VTrackRect: TRect;
    function VUpButtonRect: TRect;
    function HDownButtonRect: TRect;
    function HScrollRect: TRect;
    function HSliderRect: TRect;
    function HTrackRect: TRect;
    function HUpButtonRect: TRect;
    procedure VDrawScroll(DC: HDC = 0);
    procedure HDrawScroll(DC: HDC = 0);
    // Billenium
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
    // SmartEffects
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
    //
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMNCLButtonDblClk(var Msg: TWMMouse); message WM_NCLBUTTONDBLCLK;
    procedure WMNCLButtonDown(var Msg: TWMMouse); message WM_NCLBUTTONDOWN;
    procedure WMNCMouseMove(var Msg: TWMNCHitMessage); message WM_NCMOUSEMOVE;
    procedure WMNCLButtonUp(var Msg: TWMMouse); message WM_NCLBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TMessage); message WM_MOUSEWHEEL;
    procedure WMVScroll(var Msg: TMessage); message WM_VSCROLL;
    procedure WMHScroll(var Msg: TMessage); message WM_HSCROLL;
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure WMKeyDown(var Msg: TMessage); message WM_KEYDOWN;
    procedure WMCAPTURECHANGED(var Msg: TMessage); message WM_CAPTURECHANGED;
    procedure WMVTChangeState(var Msg: TMessage); message WM_APP + 32;
    procedure CMVisibleChanged(var Msg: TMessage); message CM_VISIBLECHANGED;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure EMLINEINDEX(var Msg: TMessage); message EM_LINEINDEX;
    procedure WMWindowPosChanged(var Msg: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMWindowPosChanging(var Msg: TWMWindowPosChanged); message WM_WINDOWPOSCHANGING;
    procedure PaintBorder(Canvas: TCanvas; R: TRect); override;
    function IsPopupWindow: Boolean;
    procedure PaintScroll;
    procedure UpdateScroll;
    procedure Paint(Canvas: TCanvas); override;
    procedure SetHandle(const Value: HWnd); override;
    procedure SetControl(const Value: TControl); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Unskin; override;
    procedure SkinChange; override;
    procedure AfterSkinChange; override;
  end;

  TbsaSpeedButtonSubclass = class(TbsaSubclass)
  private
    FPainting: Boolean;
    FGlyph: Pointer;
  protected
    function SpeedButton: TSpeedButton;
    procedure Paint(Canvas: TCanvas); override;
    procedure SetControl(const Value: TControl); override;
    procedure SkinChange; override;
    function GetTransColor: TColor;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
  TbsaButtonSubclass = class(TbsaSubclass)
  protected
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Msg: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMKeyDown(var Msg: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TMessage); message WM_KEYUP;
    procedure CMMouseEnter(var Msg: TWMMouse); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TWMMouse); message CM_MOUSELEAVE;
    procedure Paint(Canvas: TCanvas); override;
    procedure SkinChange; override;
  public
    constructor Create; override;
  end;

  TbsaCheckBoxSubclass = class(TbsaSubclass)
  private
  protected
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Msg: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure BMSetCheck(var Msg: TMessage); message BM_SETCHECK;
    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TWMKeyUp); message WM_KEYUP;
    procedure CMMouseEnter(var Msg: TWMMouse); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TWMMouse); message CM_MOUSELEAVE;
    procedure Paint(Canvas: TCanvas); override;
  public
    constructor Create; override;
  end;

  TbsaRadioButtonSubclass = class(TbsaSubclass)
  private
  protected
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Msg: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure CMMouseEnter(var Msg: TWMMouse); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TWMMouse); message CM_MOUSELEAVE;
    procedure BMSetCheck(var Msg: TMessage); message BM_SETCHECK;
    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TWMKeyUp); message WM_KEYUP;
    procedure Paint(Canvas: TCanvas); override;
  public
    constructor Create; override;
  end;

  TbsaDateTimeSubclass = class(TbsaSubclass)
  protected
    FMouseOnButton: Boolean;
    DropedDown: Boolean;
     // Billenium
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
    procedure CMSEPaint(var Message: TMessage); message CM_SEPAINT;
    // Smart Effects
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
    //
    procedure CMMouseEnter(var Msg: TWMMouse); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TWMMouse); message CM_MOUSELEAVE;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    procedure CNCtlColorEdit(var Msg: TWMCTLCOLOREDIT); message  CN_CTLCOLOREDIT;
    procedure CNCtlColorStatic(var Msg: TWMCTLCOLORSTATIC); message CN_CTLCOLORSTATIC;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    //
    procedure WMPaint(var Msg: TMessage); message WM_PAINT;
    function GetButtonRect: TRect;
    function GetButtonRect2: TRect;
    procedure DrawBorder(ADC: HDC; AUseExternalDC: Boolean);
    procedure Paint(Canvas: TCanvas); override;
    function Kind: TDateTimeKind;
    //
    procedure SetControl(const Value: TControl); override;
    procedure SetHandle(const Value: HWnd); override;
    procedure SkinChange; override;
    //
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    //
  public
    constructor Create; override;
  end;

  TbsaEditSubclass = class(TbsaSubclass)
  protected
    // Billenium
    procedure CMBENCPaint(var Message: TMessage); message CM_BENCPAINT;
    // Smart Effects
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
    //
    procedure CNCtlColorEdit(var Msg: TWMCTLCOLOREDIT); message  CN_CTLCOLOREDIT;
    procedure CNCtlColorStatic(var Msg: TWMCTLCOLORSTATIC); message CN_CTLCOLORSTATIC;
     procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;

    procedure SetControl(const Value: TControl); override;
    procedure SetHandle(const Value: HWnd); override;
    procedure SkinChange; override;
  public
    constructor Create; override;
  end;

  TbsaComboBoxSubclass = class(TbsaSubclass)
  private
  protected
    FListHandle: Cardinal;
    FListHandleTemp: Cardinal;
    FEditHandle: Cardinal;
    FMouseOnButton: Boolean;
    procedure CNCtlColorEdit(var Msg: TWMCTLCOLOREDIT); message  CN_CTLCOLOREDIT;
    procedure CNCtlColorStatic(var Msg: TWMCTLCOLORSTATIC); message CN_CTLCOLORSTATIC;
    procedure WMPaint(var Msg: TMessage); message WM_PAINT;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    function ComboBox: TCustomComboBox;
    function DroppedDown: Boolean;
    function GetButtonRect: TRect;
    function Style: TComboBoxStyle;
    procedure DrawBorder(ADC: HDC; AUseExternalDC: Boolean);
    procedure Paint(Canvas: TCanvas); override;
    procedure DrawItemThemed(Canvas: TCanvas; Index: Integer; R: TRect; Selected: Boolean);
    procedure SetControl(const Value: TControl); override;
    procedure SetHandle(const Value: HWnd); override;
    procedure SkinChange; override;
    procedure DrawSkinItem(Cnvs: TCanvas; itemID: Integer; rcItem: TRect;
                           State: TOwnerDrawState);
    procedure WMCTLCOLORLISTBOX(var Msg: TMessage); message WM_CTLCOLORLISTBOX;
    // Smart Effects
    procedure CMSENCPaint(var Message: TMessage); message CM_SENCPAINT;
    procedure PostAction; override;
  public
    constructor Create; override;
  end;

  TbsaComboListBoxSubclass = class(TbsaSubclass)
  private
    FDown: Boolean;
    procedure DrawBorder;
    function VDownButtonRect: TRect;
    function VScrollArea: TRect;
    function VScrollRect: TRect;
    function VSliderRect: TRect;
    function VTrackRect: TRect;
    function VUpButtonRect: TRect;
    procedure VDrawScroll(DC: HDC = 0);
  protected
    FOldY: Integer;
    SkinCtrl: TbsDataSkinScrollBarControl;
    OldTopIndex: Integer;
    DownPos, MovePos: TPoint;
    DownSliderPos: Integer;
    SliderSize, InvsibleCount: Integer;
    VSliderState, VUpState, VDownState: TbsaScrollButtonDrawState;

    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMPaint(var Msg: TMessage); message WM_PAINT;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMNCLButtonDblClk(var Msg: TWMMouse); message WM_NCLBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMNCLButtonDown(var Msg: TWMMouse); message WM_NCLBUTTONDOWN;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure WMPrint(var Msg: TMessage); message WM_PRINT;
    procedure WMPrintClient(var Msg: TMessage); message WM_PRINTCLIENT;
    procedure WMNCCalcSize(var Msg: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TWMKeyUp); message WM_KEYUP;
    procedure WMChar(var Msg: TWMKeyUp); message WM_CHAR;
    procedure LBSETTOPINDEX(var Msg: TMessage); message LB_SETTOPINDEX;
    //
    procedure PaintBorder(Canvas: TCanvas; R: TRect);
    procedure PostAction; override;
    procedure SkinChange; override;
    procedure BeforeSkinChange; override;
  public
    constructor Create; override;
    procedure SetHandle(const Value: HWnd); override;
  end;

  TbsaListViewSubclass = class(TbsaScrollSubclass)
  private
    FHeaderHandle: HWnd;
    FHeaderInstance: Pointer;
    FDefHeaderProc: Pointer;
    FPressedSection, FHotSection: Integer;
    procedure PaintHeader(DC: HDC);
    procedure DrawHeaderSection(Canvas: TCanvas; R: TRect; AIndex: Integer;
      const AText: WideString; Pressed, Hot, IsBackground: Boolean);
  protected
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure HeaderWndProc(var Message: TMessage); virtual;
    function FullDrag: Boolean;
    procedure SkinChange; override;
    procedure SetControl(const Value: TControl); override;
    // Smart Effects
    procedure CMSEPaint(var Message: TMessage); message CM_SEPAINT;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TbsaTabSubclass = class(TbsaSubclass)
  private
    FLeftPressed, FRightPressed: Boolean;
    FMouseOnLeft, FMouseOnRight: Boolean;
    FHotTab: Integer;
    FDisplayRect: TRect;
    FUpDownHandle: Cardinal;
  protected
    function Images: TCustomImageList;
    function TabRect(Index: Integer): TRect;
    function TabPosition: TTabPosition;
    function TabIndex: Integer;
    function Tabs: TStrings;
    function DisplayRect: TRect;
    function IndexOfTabAt(X, Y: Integer): Integer;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMMouseMove(var Msg: TMessage); message WM_MOUSEMOVE;
    procedure WMHScroll(var Msg: TMessage); message WM_HSCROLL;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure UpdateTabs;
    function GetTabText(Index: Integer): WideString;
    procedure DrawThemedTab(Canvas: TCanvas; Index: Integer);
    procedure Paint(Canvas: TCanvas); override;
    procedure PaintBG(DC: HDC);
    procedure SkinChange; override;
    procedure PostAction; override;
    function TabImageIndex(Index: Integer): Integer;
  public
    constructor Create; override;
  end;

  TbsaUpDownSubclass = class(TbsaSubclass)
  private
    FLeftPressed, FRightPressed: Boolean;
    FMouseOnLeft, FMouseOnRight: Boolean;
  protected
    function Orientation: TUDOrientation;
    procedure WMLButtonDblClk(var Msg: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure Paint(Canvas: TCanvas); override;
  public
    constructor Create; override;
  end;

  TbsaGroupBoxSubclass = class(TbsaSubclass)
  private
    ParentBGBuffer: TBitMap;
  protected
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure WMMOVE(var Msg: TWMMOVE); message WM_MOVE;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    function GetCaptionRect(Canvas: TCanvas): TRect;
    function GetBoxRect(Canvas: TCanvas): TRect;
    procedure Paint(Canvas: TCanvas); override;
    function GetTransColor: TColor;
    procedure GetPBG;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure SkinChange; override;
  end;

  TbsaPanelSubclass = class(TbsaSubclass)
  protected
    procedure Paint(Canvas: TCanvas); override;
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    function GetTransColor: TColor;
  public
    constructor Create; override;
  end;


  TbsaTabSheetSubclass = class(TbsaSubclass)
  private
  protected
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure Paint(Canvas: TCanvas); override;
  public
    constructor Create; override;
  end;

  TbsaToolbarSubclass = class(TbsaSubclass)
  private
    FHotButton: Integer;
    FButtonDropDown: Integer;
    FImageList: TImageList;
    FMouseIn: Boolean;
    function ItemStyle(Index: Integer): Cardinal;
  protected
    function ButtonCount: Integer;
    function ButtonSize: TPoint;
    function ItemRect(Index: Integer): TRect;
    function ItemInfo(Index: Integer): TTBButtonInfo;
    procedure ApplyImageList;
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure WMNotify(var Msg: TWMNotify); message CN_NOTIFY;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure OnCloseSkinMenu(Sender: TObject);
    procedure Paint(Canvas: TCanvas); override;
    procedure DrawBackground(C: TCanvas);
    procedure DrawButtonFace(C: TCanvas; FaceRect: TRect; Active, Down, Flat, DrawMenu: Boolean);
    procedure DrawSeparator(C: TCanvas; FaceRect: TRect);
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TbsaCoolBarSubclass = class(TbsaSubclass)
  private
  protected
    procedure DrawBackground(C: TCanvas);
    function Count: Integer;
    function Band(Index: Integer): TRebarBandInfo;
    function BandText(Index: Integer): WideString;
    function BandRect(Index: Integer): TRect;
    function BandBorder(Index: Integer): TRect;
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure Paint(Canvas: TCanvas); override;
  public
    constructor Create; override;
  end;


  TbsaProgressBarSubclass = class(TbsaSubclass)
  private
    function GetBarRect: TRect;
    function BorderWidth: Integer;
    function CalcProgressRect(R: TRect): TRect;
  protected
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure Paint(Canvas: TCanvas); override;
    function Max: Integer;
    function Min: Integer;
    function Position: Integer;
    function Orientation: TProgressBarOrientation;
  public
    constructor Create; override;
  end;

  TbsaTrackBarSubclass = class(TbsaSubclass)
  protected
    FThumbPressed: Boolean;
    procedure WMCHECKPARENTBG(var Msg: TWMEraseBkgnd); message WM_CHECKPARENTBG;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure CNHScroll(var Msg: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Msg: TWMVScroll); message CN_VSCROLL;
    procedure TBMSetPos(var Msg: TMessage); message TBM_SETPOS;
    procedure Paint(Canvas: TCanvas); override;
  public
    constructor Create; override;
  end;

  TbsaStatusBarSubclass  = class(TbsaSubclass)
  private
    BSF: TComponent;
  protected
    function CanShowGrip: Boolean;
    procedure Paint(Canvas: TCanvas); override;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
  public
    constructor Create; override;
    procedure SkinChange; override;
  end;
 

procedure RegisterSubclass(AClass: TbsaSubclassClass);

var
  ScrollSubclassStrList: TStrings;
  ButtonSubclassStrList: TStrings;
  SpeedButtonSubclassStrList: TStrings;
  CheckBoxSubclassStrList: TStrings;
  UpDownSubclassStrList: TStrings;
  RadioButtonSubclassStrList: TStrings;
  EditSubclassStrList: TStrings;
  DateTimeSubclassStrList: TStrings;
  ComboBoxSubclassStrList: TStrings;
  ListViewSubclassStrList: TStrings;
  TabSubclassStrList: TStrings;
  GroupBoxSubclassStrList: TStrings;
  PanelSubclassStrList: TStrings;
  ToolBarSubclassStrList: TStrings;
  CoolBarSubclassStrList: TStrings;
  LabelSubclassStrList: TStrings;
  ProgressBarSubclassStrList: TStrings;
  TrackBarSubclassStrList: TStrings;
  StatusBarSubclassStrList: TStrings;

implementation

uses Math {$IFDEF LOOKUP_SUPPORT}, dbctrls {$ENDIF}, bsSkinMenus;

{ TbsaSkinAdapter }
type
  TParentControl = class(TWinControl);

procedure GetSkinParentImage(Control: TControl; Dest: TCanvas);
var
  I, Count, X, Y, SaveIndex: Integer;
  DC: HDC;
  R, SelfR, CtlR: TRect;
begin
  if (Control = nil) or (Control.Parent = nil) then Exit;
  Count := Control.Parent.ControlCount;
  DC := Dest.Handle;
  with Control.Parent do ControlState := ControlState + [csPaintCopy];
  try
    with Control do begin
      SelfR := Bounds(Left, Top, Width, Height);
      X := -Left; Y := -Top;
    end;
    SaveIndex := SaveDC(DC);
    try
      SetViewportOrgEx(DC, X, Y, nil);
      IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth,
        Control.Parent.ClientHeight);
       if (Control.Parent is TForm) and
          (TForm(Control.Parent).FormStyle = fsMDIForm)
       then
         begin
           SendMessage(TForm(Control.Parent).ClientHandle, WM_ERASEBKGND, DC, 0);
         end
      else
      with TParentControl(Control.Parent) do begin
        Perform(WM_ERASEBKGND, DC, 0);
        if not (Control.Parent is TForm) and not (Control.Parent is TCustomTabControl) and
           not (Control.Parent is TPanel) and not (Control.Parent is TTabSheet)
        then PaintWindow(DC);
      end;
    finally
      RestoreDC(DC, SaveIndex);
    end;

    for I := 0 to Count - 1 do begin
      if Control.Parent.Controls[I] = Control then Break
      else if (Control.Parent.Controls[I] <> nil) and
        (Control.Parent.Controls[I] is TGraphicControl) then
      begin
        with TGraphicControl(Control.Parent.Controls[I]) do begin
          CtlR := Bounds(Left, Top, Width, Height);
          if Bool(IntersectRect(R, SelfR, CtlR)) and Visible then begin
            ControlState := ControlState + [csPaintCopy];
            SaveIndex := SaveDC(DC);
            try
              SaveIndex := SaveDC(DC);
              SetViewportOrgEx(DC, Left + X, Top + Y, nil);
              IntersectClipRect(DC, 0, 0, Width, Height);
              Perform(WM_PAINT, DC, 0);
            finally
              RestoreDC(DC, SaveIndex);
              ControlState := ControlState - [csPaintCopy];
            end;
          end;
        end;
      end
    end;
  finally
    with Control.Parent do ControlState := ControlState - [csPaintCopy];
  end;
end;


procedure GetSkinParentImageRect(Control: TControl; Rct: TRect; Dest: TCanvas);
var
  I, Count, X, Y, SaveIndex: Integer;
  DC: HDC;
  R, SelfR, CtlR: TRect;
begin
  if (Control = nil) or (Control.Parent = nil) then Exit;
  Count := Control.Parent.ControlCount;
  DC := Dest.Handle;
  with Control.Parent do ControlState := ControlState + [csPaintCopy];
  try
    with Control do begin
      SelfR := Bounds(Left, Top, Width, Height);
      X := -Left - Rct.Left; Y := -Top - Rct.Top;
    end;
    { Copy parent control image }
    SaveIndex := SaveDC(DC);
    try
      SetViewportOrgEx(DC, X, Y, nil);
      IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth,
        Control.Parent.ClientHeight);
      if (Control.Parent is TForm) and
         (TForm(Control.Parent).FormStyle = fsMDIForm)
       then
         begin
           SendMessage(TForm(Control.Parent).ClientHandle, WM_ERASEBKGND, DC, 0);
         end
      else
      with TParentControl(Control.Parent) do begin
        Perform(WM_ERASEBKGND, DC, 0);
        if not (Control.Parent is TForm) and not (Control.Parent is TCustomTabControl) and
           not (Control.Parent is TPanel)
        then PaintWindow(DC);
      end;
    finally
      RestoreDC(DC, SaveIndex);
    end;
    { Copy images of graphic controls }
    for I := 0 to Count - 1 do begin
      if Control.Parent.Controls[I] = Control then Break
      else if (Control.Parent.Controls[I] <> nil) and
        (Control.Parent.Controls[I] is TGraphicControl) then
      begin
        with TGraphicControl(Control.Parent.Controls[I]) do begin
          CtlR := Bounds(Left, Top, Width, Height);
          if Bool(IntersectRect(R, SelfR, CtlR)) and Visible then begin
            ControlState := ControlState + [csPaintCopy];
            SaveIndex := SaveDC(DC);
            try
              SaveIndex := SaveDC(DC);
              SetViewportOrgEx(DC, Left + X, Top + Y, nil);
              IntersectClipRect(DC, 0, 0, Width, Height);
              Perform(WM_PAINT, DC, 0);
            finally
              RestoreDC(DC, SaveIndex);
              ControlState := ControlState - [csPaintCopy];
            end;
          end;
        end;
      end;
    end;
  finally
    with Control.Parent do ControlState := ControlState - [csPaintCopy];
  end;
end;

constructor TbsaSkinAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAdapterType := bsaUseNames;

  FTabsBGTransparent := False;

  FAutoAddNames := False;
  FAutoAddClasses := False;

  if Owner is TCustomFrame then
    raise Exception.Create(ClassName + ' can not place on TFrame');

  if not (csDesigning in ComponentState) then
    FSubclass := TbsaSkinManager.Create(Self);

  FScrollSubclassStr := TStringList.Create;
  //
  VScrollSkinDataName := 'vscrollbar';
  HScrollSkinDataName := 'hscrollbar';
  FButtonSkinDataName := 'resizebutton';
  FSpeedButtonSkinDataName := 'resizetoolbutton';
  FPanelSkinDataName := 'panel';
  FToolBarSkinDataName := 'resizetoolpanel';
  FCoolBarSkinDataName := 'panel';
  //
  ButtonUseSkinSize := False;
  SpeedButtonUseSkinSize := False;
  //
  ScrollSubclassStrList.Assign(FScrollSubclassStr);
  FButtonSubclassStr := TStringList.Create;
  FSpeedButtonSubclassStr := TStringList.Create;
  ButtonSubclassStrList.Assign(FButtonSubclassStr);
  FCheckBoxSubclassStr := TStringList.Create;
  CheckBoxSubclassStrList.Assign(FCheckBoxSubclassStr);
  FRadioButtonSubclassStr := TStringList.Create;
  RadioButtonSubclassStrList.Assign(FRadioButtonSubclassStr);
  FUpDownSubclassStr := TStringList.Create;
  UpDownSubclassStrList.Assign(FUpDownSubclassStr);
  FEditSubclassStr := TStringList.Create;
  EditSubclassStrList.Assign(FEditSubclassStr);
  FDateTimeSubclassStr := TStringList.Create;
  DateTimeSubclassStrList.Assign(FEditSubclassStr);
  FComboBoxSubclassStr := TStringList.Create;
  ComboBoxSubclassStrList.Assign(FComboBoxSubclassStr);
  FListViewSubclassStr := TStringList.Create;
  ListViewSubclassStrList.Assign(FListViewSubclassStr);
  FTabSubclassStr := TStringList.Create;
  TabSubclassStrList.Assign(FTabSubclassStr);
  FGroupBoxSubclassStr := TStringList.Create;
  GroupBoxSubclassStrList.Assign(FGroupBoxSubclassStr);
  FPanelSubclassStr := TStringList.Create;
  PanelSubclassStrList.Assign(FPanelSubclassStr);
  FToolBarSubclassStr := TStringList.Create;
  FCoolBarSubclassStr := TStringList.Create;
  FProgressBarSubclassStr := TStringList.Create;
  FTrackBarSubclassStr := TStringList.Create;
  FStatusBarSubclassStr := TStringList.Create;
  FLabelSubclassStr := TStringList.Create;
  LabelSubclassStrList.Assign(FLabelSubclassStr);
end;

destructor TbsaSkinAdapter.Destroy;
begin
  if not (csDesigning in ComponentState) then
    FSubclass.Free;

  FLoaded := False;
  FScrollSubclassStr.Free;
  FButtonSubclassStr.Free;
  FSpeedButtonSubclassStr.Free;
  FCheckBoxSubclassStr.Free;
  FRadioButtonSubclassStr.Free;
  FUpDownSubclassStr.Free;
  FEditSubclassStr.Free;
  FDateTimeSubclassStr.Free;
  FComboBoxSubclassStr.Free;
  FListViewSubclassStr.Free;
  FTabSubclassStr.Free;
  FGroupBoxSubclassStr.Free;
  FPanelSubclassStr.Free;
  FToolbarSubclassStr.Free;
  FCoolbarSubclassStr.Free;
  FProgressBarSubclassStr.Free;
  FTrackBarSubclassStr.Free;
  FStatusBarSubclassStr.Free;
  FLabelSubclassStr.Free;
  inherited Destroy;
end;

procedure TbsaSkinAdapter.ReleaseSkin;
begin
  if SkinData = nil then Exit;
  ResetForms;
  SkinData.SkinnableForm := False;
  SkinData.ClearSkin;
end;

procedure TbsaSkinAdapter.ApplySkin;
begin
  if SkinData = nil then Exit;
  if SkinData.CompressedStoredSkin <> nil then
    SkinData.CompressedStoredSkin := SkinData.CompressedStoredSkin
  else
  if SkinData.SkinList <> nil then
   SkinData.SkinIndex := SkinData.SkinIndex;
  ResetForms;
  if not SkinData.SkinnableForm then
    SkinData.SkinnableForm := True;
  CollectForms;
  ChangeSkinData;
end;

function TbsaSkinAdapter.IsHandleListEmpty: Boolean;
begin
  Result := TbsaSkinManager(FSubClass).IsHandleListEmpty;
end;

procedure TbsaSkinAdapter.SetAdapterType(Value: TbsaAdapterType);
begin
  if FAdapterType <> Value
  then
    begin
      FAdapterType := Value;
      FScrollSubclassStr.Clear;
      FButtonSubclassStr.Clear;
      FSpeedButtonSubclassStr.Clear;
      FCheckBoxSubclassStr.Clear;
      FRadioButtonSubclassStr.Clear;
      FUpdownSubclassStr.Clear;
      FEditSubclassStr.Clear;
      FDateTimeSubclassStr.Clear;
      FComboBoxSubclassStr.Clear;
      FListViewSubclassStr.Clear;
      FTabSubclassStr.Clear;
      FGroupBoxSubclassStr.Clear;
      FPanelSubclassStr.Clear;
      FToolBarSubclassStr.Clear;
      FCoolBarSubclassStr.Clear;
      FProgressBarSubclassStr.Clear;
      FTrackBarSubclassStr.Clear;
      FStatusBarSubclassStr.Clear;
      if FAdapterType = bsaUseClasses
      then
        begin
          FAutoAddNames := False;
          AutoAddClasses := True;
        end
      else
        begin
          FAutoAddNames := False;
          FAutoAddClasses := False;
        end;
    end;
end;


{$IFDEF DEVEX_SUPPORT}
type
  TMycxControl = class(TcxControl);

procedure TbsaSkinAdapter.UpdateDevExControls;
var
  F: TCustomForm;
  I: Integer;
  T: TMycxControl;
begin
  F := (Owner as TCustomForm);
  for I := 0 to F.ComponentCount - 1 do
  begin
     if F.Components[I] is TcxControl
     then
       begin
         with TMycxControl(F.Components[I]) do
         begin
           if (SizeGrip <> nil) and SizeGrip.Visible
             then SizeGrip.Invalidate;
           if (HScrollBar <> nil) and HScrollBar.Visible
             then
              if Assigned(HScrollBar.Control) Then
               HScrollBar.Control.Invalidate;
           if (VScrollBar <> nil) and VScrollBar.Visible
             then
              if Assigned(VScrollBar.Control) Then
               VScrollBar.Control.Invalidate; 
           Loaded;
           Invalidate;
         end;
       end;
  end;
end;

{$ENDIF}

procedure TbsaSkinAdapter.SetAutoAddNames(Value: Boolean);
var
  I: Integer;
  F: TCustomForm;
begin
  FAutoAddNames := Value;
  if FAdapterType <> bsaUseNames then FAutoAddNames := False;
  if FAutoAddNames and (csDesigning in ComponentState) and
     (Owner is TCustomForm)
  then
    begin
      ButtonSubclass.Clear;
      DateTimeSubclass.Clear;
      EditSubclass.Clear;
      Scrollsubclass.Clear;
      ComboBoxSubclass.Clear;
      CheckBoxSubClass.Clear;
      UpdownSubclass.Clear;
      GroupBoxSubClass.Clear;
      ListViewSubClass.Clear;
      RadioButtonSubClass.Clear;
      SpeedButtonSubClass.Clear;
      PanelSubClass.Clear;
      ToolbarSubClass.Clear;
      CoolbarSubClass.Clear;
      ProgressbarSubClass.Clear;
      TrackbarSubClass.Clear;
      StatusBarSubClass.Clear;
      TabSubClass.Clear;
      F := (Owner as TCustomForm);
      for I := 0 to F.ComponentCount-1 do
      begin
        if F.Components[I] is TScrollBox then
          ScrollSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomMemo then
          ScrollSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomRichEdit then
          ScrollSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomTreeView then
          ScrollSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomTabControl then
          TabSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TButton then
          ButtonSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TBitBtn then
          ButtonSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TEdit then
          EditSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TDateTimePicker then
          DateTimeSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomListBox then
          Scrollsubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomComboBox then
          ComboBoxSubclass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomCheckBox then
          CheckBoxSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomUpdown then
          UpdownSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomGroupBox then
          GroupBoxSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TCustomListView then
          ListViewSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TRadioButton then
         RadioButtonSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TSpeedButton then
          SpeedButtonSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TPanel then
          PanelSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TToolBar then
          ToolbarSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TCoolBar then
          CoolbarSubClass.Add(F.Components[I].Name) else
        if F.Components[I] is TProgressBar then
          ProgressbarSubClass.Add(F.Components[I].Name) else
         if F.Components[I] is TTrackBar then
          TrackbarSubClass.Add(F.Components[I].Name) else
         if F.Components[I] is TStatusBar then
          StatusbarSubClass.Add(F.Components[I].Name) else
         if F.Components[I] is Tlabel then
          LabelSubClass.Add(F.Components[I].Name);
      end
   end;
end;

procedure TbsaSkinAdapter.AddDefClasses;
begin
  ButtonSubclass.Clear;
  ButtonSubclass.Add('tbutton');
  ButtonSubclass.Add('ttntbutton');
  ButtonSubclass.Add('tbitbtn');
  ButtonSubclass.Add('ttntbitbtn');
  //
  EditSubclass.Clear;
  EditSubclass.Add('tedit');
  EditSubclass.Add('tdbedit');
  EditSubclass.Add('ttntedit');
  EditSubclass.Add('ttntdbedit');
  EditSubclass.Add('tspinedit');
  EditSubclass.Add('ttntspinedit');
  //
  DateTimeSubclass.Clear;
  DateTimeSubclass.Add('tdatetimepicker');
  //
  Scrollsubclass.Clear;
  ScrollSubclass.Add('tmemo');
  ScrollSubclass.Add('ttntmemo');
  ScrollSubclass.Add('tdbmemo');
  ScrollSubclass.Add('tlistbox');
  ScrollSubclass.Add('tdblistbox');
  ScrollSubclass.Add('tchecklistbox');
  ScrollSubclass.Add('ttntlistbox');
  ScrollSubclass.Add('trichedit');
  ScrollSubclass.Add('tdbrichedit');
  ScrollSubclass.Add('ttreeview');
  ScrollSubclass.Add('ttnttreeview');
  ScrollSubclass.Add('tstringgrid');
  ScrollSubclass.Add('tdrawgrid');
  ScrollSubclass.Add('tadvgrid');
  ScrollSubclass.Add('tdbadvgrid');
  ScrollSubclass.Add('trichview');
  ScrollSubclass.Add('trichviewedit');
  ScrollSubclass.Add('tdbrichviewedit');
  ScrollSubclass.Add('tdbrichview');
  ScrollSubclass.Add('tprofgrid');
  ScrollSubclass.Add('twwgrid');
  ScrollSubclass.Add('twwdbgrid');
  ScrollSubclass.Add('tdbgrid');
  ScrollSubclass.Add('tdbgridex');
  ScrollSubclass.Add('tscrollbox');
  ScrollSubclass.Add('ttntdbrichedit');
  ScrollSubclass.Add('ttntdbmemo');
  ScrollSubclass.Add('tvirtualtreeview');
  ScrollSubclass.Add('tvirtualstringtree');
  ScrollSubclass.Add('tvirtualdrawtree');
  //
  ComboBoxSubclass.Clear;
  ComboBoxSubclass.Add('tcombobox');
  ComboBoxSubclass.Add('ttntcombobox');
  ComboBoxSubclass.Add('tdbcombobox');
  ComboBoxSubclass.Add('ttntdbcombobox');
  ComboBoxSubclass.Add('tdblookupcombobox');
  //
  CheckBoxSubClass.Clear;
  CheckBoxSubClass.Add('tcheckbox');
  CheckBoxSubClass.Add('ttntcheckbox');
  CheckBoxSubClass.Add('tdbcheckbox');
  CheckBoxSubClass.Add('ttntdbcheckbox');
  CheckBoxSubClass.Add('twwcheckbox');
  //
  UpDownSubClass.Clear;
  UpDownSubClass.Add('tupdown');
  UpDownSubClass.Add('ttntupdown');
  //
  GroupBoxSubClass.Clear;
  GroupBoxSubClass.Add('tgroupbox');
  GroupBoxSubClass.Add('ttntgroupbox');
  GroupBoxSubClass.Add('tradiogroup');
  GroupBoxSubClass.Add('tdbradiogroup');
  GroupBoxSubClass.Add('ttntradiogroup');
  GroupBoxSubClass.Add('ttntdbradiogroup');
  //
  ListViewSubClass.Clear;
  ListViewSubClass.Add('tlistview');
  ListViewSubClass.Add('ttntlistview');
  //
  RadioButtonSubClass.Clear;
  RadioButtonSubClass.Add('tradiobutton');
  RadioButtonSubClass.Add('ttntradiobutton');
  //
  SpeedButtonSubClass.Clear;
  SpeedButtonSubClass.Add('tspeedbutton');
  SpeedButtonSubClass.Add('ttntspeedbutton');
  //
  PanelSubClass.Clear;
  PanelSubClass.Add('tpanel');
  PanelSubClass.Add('ttntpanel');
  //
  ToolBarSubClass.Clear;
  ToolBarSubClass.Add('ttoolbar');
  ToolBarSubClass.Add('ttnttoolbar');
  //
  CoolBarSubClass.Clear;
  CoolBarSubClass.Add('tcoolbar');
  //
  ProgressBarSubClass.Clear;
  ProgressBarSubClass.Add('tprogressbar');
  //
  TrackBarSubClass.Clear;
  TrackBarSubClass.Add('ttrackbar');
  //
  StatusBarSubClass.Clear;
  StatusBarSubClass.Add('tstatusbar');
  StatusBarSubClass.Add('ttntstatusbar');
  //
  LabelSubClass.Clear;
  LabelSubClass.Add('tlabel');
  LabelSubClass.Add('ttntlabel');
  //
  TabSubClass.Clear;
  TabSubClass.Add('tpagecontrol');
  TabSubClass.Add('ttabcontrol');
  TabSubClass.Add('ttntpagecontrol');
  TabSubClass.Add('ttnttabcontrol');
end;

procedure TbsaSkinAdapter.SetAutoAddClasses(Value: Boolean);
begin
  FAutoAddClasses := Value;
  if FAdapterType <> bsaUseClasses then FAutoAddClasses := False;
  if FAutoAddClasses and (csDesigning in ComponentState)
  then
    begin
      AddDefClasses;
    end;
end;


procedure TbsaSkinAdapter.Loaded;
begin
  inherited;
  ScrollSubclassStrList.Assign(FScrollSubclassStr);

  if (csDesigning in ComponentState) then
    if Owner <> nil then
      ComponentIndex := Owner.ComponentCount - 1;

  if not (csDesigning in ComponentState)
  then
    begin
      CollectForms;
      ChangeSkinData;
    end;  
  FLoaded := True;
end;

procedure TbsaSkinAdapter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
end;

procedure TbsaSkinAdapter.RemoveControl(C: TControl);
begin
  TbsaSkinManager(FSubClass).FHookCollection.RemoveControl(C, True);
end;

procedure TbsaSkinAdapter.AddControl(C: TControl; ASubClassList: TStrings);
var
  S, S2: String;
begin
  if FAdapterType = bsaUseNames
  then
     S2 := lowercase(C.Name) else S2 := lowercase(C.ClassName);
  //
  S := lowercase(ASubClassList.Text);
  if Pos(S2, S) = 0
  then
    begin
      ASubClassList.Add(S2);
    end;
  //
  S := lowercase(Self.ScrollSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectScrollControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.ButtonSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectButtonControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.SpeedButtonSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectSpeedButtonControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.CheckBoxSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectCheckBoxControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.UpDownSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectUpdownControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.RadioButtonSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectRadioButtonControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.TabSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectTabControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.GroupBoxSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectGroupBoxControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.EditSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectEditControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.ListViewSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectListViewControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.PanelSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectPanelControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.ToolBarSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectToolBarControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.CoolBarSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectCoolBarControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.ProgressBarSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectProgressBarControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.TrackBarSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectTrackBarControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.StatusBarSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectStatusBarControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.ComboBoxSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectComboBoxControl(C);
      Exit;
    end;
  //
  S := lowercase(Self.LabelSubclass.Text);
  if Pos(S2, S) <> 0
  then
    begin
      TbsaSkinManager(FSubClass).CollectLabelControl(C);
      Exit;
    end;
end;

procedure TbsaSkinAdapter.CollectForms;
var
  i, j, k: Integer;
  NC, C: TComponent;
  S: string;
  Exists: Boolean;
begin
  if csDesigning in ComponentState then Exit;
  if FCollecting then Exit;

  {$IFDEF DEVEX_SUPPORT}
  DevExSkinData := Self.SkinData;
  {$ENDIF}

  FCollecting := True;
  try
    try
      if Owner is TCustomForm then
      begin
        if Owner.Name = 'ClickHandle_567823434' then Exit;
        if Owner.Tag = 99 then Exit;
        if not TCustomForm(Owner).HandleAllocated then Exit;
        { Scrollbars }
        ScrollSubclassStrList.Assign(FScrollSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectScroll(Owner);
        { Buttons }
        ButtonSubclassStrList.Assign(FButtonSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectButton(Owner);
        { SpeedButtons }
        SpeedButtonSubclassStrList.Assign(FSpeedButtonSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectSpeedButton(Owner);
        { CheckBoxs }
        CheckBoxSubclassStrList.Assign(FCheckBoxSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectCheckBox(Owner);
        { RadioButtons }
        RadioButtonSubclassStrList.Assign(FRadioButtonSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectRadioButton(Owner);
        { UpDown }
        UpDownSubclassStrList.Assign(FUpDownSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectUpDown(Owner);
        { Edits }
        EditSubclassStrList.Assign(FEditSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectEdit(Owner);
        { DateTime }
        DateTimeSubclassStrList.Assign(FDateTimeSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectDateTime(Owner);
        { ComboBoxs }
        ComboBoxSubclassStrList.Assign(FComboBoxSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectComboBox(Owner);
        { ListViews }
        ListViewSubclassStrList.Assign(FListViewSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectListView(Owner);
        { Tabs }
        TabSubclassStrList.Assign(FTabSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectTab(Owner);
        { GroupBox }
        GroupBoxSubclassStrList.Assign(FGroupBoxSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectGroupBox(Owner);
        { Panel }
        PanelSubclassStrList.Assign(FPanelSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectPanel(Owner);
        { ToolBar }
        ToolBarSubclassStrList.Assign(FToolBarSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectToolBar(Owner);
        { CoolBar }
        CoolBarSubclassStrList.Assign(FCoolBarSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectCoolBar(Owner);
        { ProgressBar }
        ProgressBarSubclassStrList.Assign(FProgressBarSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectProgressBar(Owner);
        { TrackBar }
        TrackBarSubclassStrList.Assign(FTrackBarSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectTrackBar(Owner);
        { StatusBar }
        StatusBarSubclassStrList.Assign(FStatusBarSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectStatusBar(Owner);
        { label }
        LabelSubclassStrList.Assign(FLabelSubclassStr);
        TbsaSkinManager(FSubclass).Adapter := Self;
        TbsaSkinManager(FSubclass).CollectLabel(Owner);
      end;
    except
    end;
  finally
    FCollecting := False;
    if Assigned(FOnCollectForm) then FOnCollectForm(Self);
  end;
end;

procedure TbsaSkinAdapter.ResetForms;
begin
  if csDesigning in ComponentState then Exit;
  if FCollecting then Exit;
  TbsaSkinManager(FSubclass).DisableSubclass;
  TbsaSkinManager(FSubclass).UnCollectLabel(Owner);
end;

{ Properties }

procedure TbsaSkinAdapter.SetScrollSubclass(const Value: TStrings);
begin
  FScrollSubclassStr.Assign(Value);
  FScrollSubclassStr.Text := LowerCase(FScrollSubclassStr.Text);

  ScrollSubclassStrList.Assign(FScrollSubclassStr);
end;

function TbsaSkinAdapter.GetVersion: string;
begin
  Result := saSkinAdapterVersionPropText;
end;

procedure TbsaSkinAdapter.SetVersion(const Value: string);
begin

end;

procedure TbsaSkinAdapter.SetVScrollSkinDataName(const Value: String);
begin
  FVScrollSkinDataName := Value;
end;

procedure TbsaSkinAdapter.ChangeSkinData;
begin
  if not (csDesigning in ComponentState)
  then
    begin
      TbsaSkinManager(FSubclass).BeforeSkinChanged;
      CollectForms;
      TbsaSkinManager(FSubclass).SkinChanged;
       {$IFDEF DEVEX_SUPPORT}
       DevExSkinData := Self.SkinData;
       UpdateDevExControls;
       {$ENDIF}
      if Assigned(FOnChangeSkinData) then FOnChangeSkinData(Self);
      TbsaSkinManager(FSubclass).AfterSkinChanged;  
    end;
end;

procedure TbsaSkinAdapter.SetHScrollSkinDataName(const Value: String);
begin
  FHScrollSkinDataName := Value;
end;

procedure TbsaSkinAdapter.SetButtonSubclass(const Value: TStrings);
begin
  FButtonSubclassStr.Assign(Value);
  FButtonSubclassStr.Text := LowerCase(FButtonSubclassStr.Text);
  ButtonSubclassStrList.Assign(FButtonSubclassStr);
end;

procedure TbsaSkinAdapter.SetSpeedButtonSubclass(const Value: TStrings);
begin
  FSpeedButtonSubclassStr.Assign(Value);
  FSpeedButtonSubclassStr.Text := LowerCase(FSpeedButtonSubclassStr.Text);
  SpeedButtonSubclassStrList.Assign(FSpeedButtonSubclassStr);
end;

procedure TbsaSkinAdapter.SetUpDownSubclass(const Value: TStrings);
begin
  FUpDownSubclassStr.Assign(Value);
  FUpDownSubclassStr.Text := LowerCase(FUpDownSubclassStr.Text);
  UpDownSubclassStrList.Assign(FUpDownSubclassStr);
end;

procedure TbsaSkinAdapter.SetCheckBoxSubclass(const Value: TStrings);
begin
  FCheckBoxSubclassStr.Assign(Value);
  FCheckBoxSubclassStr.Text := LowerCase(FCheckBoxSubclassStr.Text);
  CheckBoxSubclassStrList.Assign(FCheckBoxSubclassStr);
end;

procedure TbsaSkinAdapter.SetComboBoxSubclass(const Value: TStrings);
begin
  FComboBoxSubclassStr.Assign(Value);
  FComboBoxSubclassStr.Text := LowerCase(FComboBoxSubclassStr.Text);
  ComboBoxSubclassStrList.Assign(FComboBoxSubclassStr);
end;

procedure TbsaSkinAdapter.SetRadioButtonSubclass(const Value: TStrings);
begin
  FRadioButtonSubclassStr.Assign(Value);
  FRadioButtonSubclassStr.Text := LowerCase(FRadioButtonSubclassStr.Text);
  RadioButtonSubclassStrList.Assign(FRadioButtonSubclassStr);
end;

procedure TbsaSkinAdapter.SetEditSubclass(const Value: TStrings);
begin
  FEditSubclassStr.Assign(Value);
  FEditSubclassStr.Text := LowerCase(FEditSubclassStr.Text);

  EditSubclassStrList.Assign(FEditSubclassStr);
end;

procedure TbsaSkinAdapter.SetDateTimeSubclass(const Value: TStrings);
begin
  FDateTimeSubclassStr.Assign(Value);
  FDateTimeSubclassStr.Text := LowerCase(FDateTimeSubclassStr.Text);
  DateTimeSubclassStrList.Assign(FDateTimeSubclassStr);
end;


procedure TbsaSkinAdapter.SetListViewSubclass(const Value: TStrings);
begin
  FListViewSubclassStr.Assign(Value);
  FListViewSubclassStr.Text := LowerCase(FListViewSubclassStr.Text);

  ListViewSubclassStrList.Assign(FListViewSubclassStr);
end;

procedure TbsaSkinAdapter.SetTabSubclass(const Value: TStrings);
begin
  FTabSubclassStr.Assign(Value);
  FTabSubclassStr.Text := LowerCase(FTabSubclassStr.Text);

  TabSubclassStrList.Assign(FTabSubclassStr);
end;

procedure TbsaSkinAdapter.SetGroupBoxSubclass(const Value: TStrings);
begin
  FGroupBoxSubclassStr.Assign(Value);
  FGroupBoxSubclassStr.Text := LowerCase(FGroupBoxSubclassStr.Text);

  GroupBoxSubclassStrList.Assign(FGroupBoxSubclassStr);
end;

procedure TbsaSkinAdapter.SetLabelSubclass(const Value: TStrings);
begin
  FLabelSubclassStr.Assign(Value);
  FLabelSubclassStr.Text := LowerCase(FLabelSubclassStr.Text);
  LabelSubclassStrList.Assign(FLabelSubclassStr);
end;


procedure TbsaSkinAdapter.SetPanelSubclass(const Value: TStrings);
begin
  FPanelSubclassStr.Assign(Value);
  FPanelSubclassStr.Text := LowerCase(FPanelSubclassStr.Text);
  PanelSubclassStrList.Assign(FPanelSubclassStr);
end;

procedure TbsaSkinAdapter.SetToolBarSubclass(const Value: TStrings);
begin
  FToolBarSubclassStr.Assign(Value);
  FToolBarSubclassStr.Text := LowerCase(FToolBarSubclassStr.Text);
  ToolBarSubclassStrList.Assign(FToolBarSubclassStr);
end;

procedure TbsaSkinAdapter.SetCoolBarSubclass(const Value: TStrings);
begin
  FCoolBarSubclassStr.Assign(Value);
  FCoolBarSubclassStr.Text := LowerCase(FCoolBarSubclassStr.Text);
  CoolBarSubclassStrList.Assign(FCoolBarSubclassStr);
end;

procedure TbsaSkinAdapter.SetProgressBarSubclass(const Value: TStrings);
begin
  FProgressBarSubclassStr.Assign(Value);
  FProgressBarSubclassStr.Text := LowerCase(FProgressBarSubclassStr.Text);
  ProgressBarSubclassStrList.Assign(FProgressBarSubclassStr);
end;

procedure TbsaSkinAdapter.SetTrackBarSubclass(const Value: TStrings);
begin
  FTrackBarSubclassStr.Assign(Value);
  FTrackBarSubclassStr.Text := LowerCase(FTrackBarSubclassStr.Text);
  TrackBarSubclassStrList.Assign(FTrackBarSubclassStr);
end;

procedure TbsaSkinAdapter.SetStatusBarSubclass(const Value: TStrings);
begin
  FStatusBarSubclassStr.Assign(Value);
  FStatusBarSubclassStr.Text := LowerCase(FStatusBarSubclassStr.Text);
  StatusBarSubclassStrList.Assign(FStatusBarSubclassStr);
end;


type
  THack = class(TWinControl);

{ TControlHook }

  TControlHook = class(TComponent)
  private
    FControl: TControl;
    FHandle: HWnd;
    FNewWndProc: Pointer;
    FPrevWndProc: Pointer;
    FPrevWndMethod: TWndMethod;
    FList: TList;
    FDestroying: Boolean;
    FSaveControl: TControl;
    procedure SetControl(Value: TControl);
    procedure SetHandle(const Value: HWnd);
    function GetHandle: HWnd;
  protected
    procedure HookWndProc(var AMsg: TMessage);
    procedure NotifyHooks(var Msg: TMessage);
    procedure DefaultWndProc(var AMsg: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
    procedure HookControl;
    procedure UnhookControl;
    procedure AddHook(AHook: TbsaHook);
    procedure RemoveHook(AHook: TbsaHook);
    property Control: TControl read FControl write SetControl;
    property Handle: HWnd read GetHandle write SetHandle;
  end;

{ THookList }

  THookList = class(TList)
  private
    FHandle: HWnd;
    procedure WndProc(var Msg: TMessage);
  public
    constructor Create;
    destructor Destroy; override;
    function FindControlHook(AControl: TControl): TControlHook; overload;
    function GetControlHook(AControl: TControl): TControlHook; overload;
    function FindControlHook(AControl: HWnd): TControlHook; overload;
    function GetControlHook(AControl: HWnd): TControlHook; overload;
    property Handle: HWnd read FHandle;
  end;

var
  HookList: THookList;

function GetHookList: THookList;
begin
  if HookList = nil then HookList := THookList.Create;
  Result := HookList;
end;

procedure DropHookList;
begin
  if HookList <> nil then
    HookList.Free;
  HookList := nil;
end;

{ TControlHook }

constructor TControlHook.Create;
begin
  inherited Create(nil);
  FList := TList.Create;
  FNewWndProc := MakeObjectInstance(HookWndProc);
  FPrevWndProc := nil;
  FControl := nil;
end;

destructor TControlHook.Destroy;
begin
  FDestroying := True;
  if Assigned(HookList) then
    if HookList.IndexOf(Self) >= 0 then HookList.Remove(Self);
  while FList.Count > 0 do RemoveHook(TbsaHook(FList.Last));
  FControl := nil;
  FList.Free;
  FreeObjectInstance(FNewWndProc);
  FNewWndProc := nil;
  FPrevWndMethod := nil;
  inherited Destroy;
end;

procedure TControlHook.AddHook(AHook: TbsaHook);
begin
  if FList.IndexOf(AHook) < 0 then
  begin
    FList.Add(AHook);
    AHook.FControlHook := Self;
    if Assigned(AHook.FControl) then
      Control := AHook.FControl
    else
      Handle := AHook.FHandle;
  end;
  HookControl;
end;

procedure TControlHook.RemoveHook(AHook: TbsaHook);
begin
  AHook.FControlHook := nil;
  FList.Remove(AHook);
  if FList.Count = 0 then UnhookControl;
end;

procedure TControlHook.DefaultWndProc(var AMsg: TMessage);
begin
  if Assigned(FControl) then
    with AMsg do
    begin
      if (FControl is TWinControl) and False then
      begin
        { WinControl }
        if Assigned(FPrevWndProc) then
          Result := CallWindowProc(FPrevWndProc, TWinControl(FControl).Handle, Msg, WParam, LParam)
        else
          Result := CallWindowProc(THack(FControl).DefWndProc, TWinControl(FControl).Handle, Msg, WParam, LParam);
      end
      else
      begin
        { non WinControl }
        if Assigned(FPrevWndMethod) then
          FPrevWndMethod(AMsg);
      end;
  end
  else
    if FHandle <> 0 then
      with AMsg do
      begin
        { WinControl }
        if Assigned(FPrevWndProc) then
          Result := CallWindowProc(FPrevWndProc, FHandle, Msg, WParam, LParam)
        else
          Result := CallWindowProc(THack(FControl).DefWndProc, FHandle, Msg, WParam, LParam);
      end;
end;

procedure TControlHook.NotifyHooks(var Msg: TMessage);
var
  I: Integer;
begin
  if (FList.Count > 0) and Assigned(FControl) and not (FDestroying or (csDestroying in FControl.ComponentState)) then
    for I := FList.Count - 1 downto 0 do
    begin
      try
        TbsaHook(FList[I]).DoHandleMessage(Msg, DefaultWndProc)
      except
        Application.HandleException(Self);
      end;
    end;

  if (FList.Count > 0) and (FHandle <> 0) and not (FDestroying or (csDestroying in ComponentState)) then
    for I := FList.Count - 1 downto 0 do
    begin
      try
        TbsaHook(FList[I]).DoHandleMessage(Msg, DefaultWndProc)
      except
        Application.HandleException(Self);
      end;
    end;
end;

procedure TControlHook.HookControl;
var
  P: Pointer;
begin
  if Assigned(FControl) and not ((csDesigning in FControl.ComponentState) or
    (csDestroying in ComponentState) or FDestroying) then
  begin
    if (FControl is TWinControl) and False then
    begin
      { WinControl }
      TWinControl(FControl).HandleNeeded;
      P := Pointer(GetWindowLong(TWinControl(FControl).Handle, GWL_WNDPROC));
      if (P <> FNewWndProc) then
      begin
        FPrevWndProc := P;
        SetWindowLong(TWinControl(FControl).Handle, GWL_WNDPROC, LongInt(FNewWndProc));
      end;
    end
    else
    begin
      { non WinControl }
//      if FControl.WindowProc <> HookWndProc then
      begin
        FPrevWndMethod := FControl.WindowProc;
        FControl.WindowProc := HookWndProc;
      end;
    end;
  end
  else
    if (FHandle <> 0) and not ((csDesigning in ComponentState) or
      (csDestroying in ComponentState) or FDestroying) then
    begin
      P := Pointer(GetWindowLong(FHandle, GWL_WNDPROC));
      if (P <> FNewWndProc) then
      begin
        FPrevWndProc := P;
        SetWindowLong(FHandle, GWL_WNDPROC, LongInt(FNewWndProc));
      end;
    end;
end;

procedure TControlHook.UnhookControl;
var
  P: Pointer;
  I: Integer;
begin
  if (FList.Count > 0) and Assigned(FControl) then
    for I := FList.Count - 1 downto 0 do
    begin
      TbsaHook(FList[I]).UnhookControl;
    end;
  if (FList.Count > 0) and (FHandle <> 0) then
    for I := FList.Count - 1 downto 0 do
    begin
      TbsaHook(FList[I]).UnhookControl;
    end;

  if Assigned(FControl) then
  begin
    if (FControl is TWinControl) and False then
    begin
      { WinControl }
      P := Pointer(GetWindowLong(TWinControl(FControl).Handle, GWL_WNDPROC));
      if Assigned(FPrevWndProc) and TWinControl(FControl).HandleAllocated and
        (Pointer(GetWindowLong(TWinControl(FControl).Handle, GWL_WNDPROC)) = FNewWndProc)
      then
        SetWindowLong(TWinControl(FControl).Handle, GWL_WNDPROC, LongInt(FPrevWndProc));
    end
    else
    begin
      { non WinControl }
      if Assigned(FPrevWndMethod) then
        FControl.WindowProc := FPrevWndMethod;
    end;
  end
  else
    if FHandle <> 0 then
    begin
      { WinControl }
      if Assigned(FPrevWndProc) and
        (Pointer(GetWindowLong(FHandle, GWL_WNDPROC)) = FNewWndProc)
      then
        SetWindowLong(FHandle, GWL_WNDPROC, LongInt(FPrevWndProc));
    end;
  FControl := nil;
  FHandle := 0;
  FPrevWndProc := nil;
  FPrevWndMethod := nil;
end;

procedure TControlHook.HookWndProc(var AMsg: TMessage);
begin
  if Assigned(FControl) then
  begin
    { Handle message }
    if (AMsg.Msg <> WM_QUIT) then NotifyHooks(AMsg);
    with AMsg do
    begin
      if (Msg = WM_DESTROY) then
      begin
        try
          if not (csDestroyingHandle in FControl.ControlState) then
            UnhookControl;
          DefaultWndProc(AMsg);
        finally
          NotifyHooks(AMsg);
        end;
      end;
    end;
  end
  else
    if FHandle <> 0 then
    begin
      { Handle message }
      if (AMsg.Msg <> WM_QUIT) then NotifyHooks(AMsg);
      with AMsg do
      begin
        if (Msg = WM_DESTROY) then
        begin
          try
            UnhookControl;
            DefaultWndProc(AMsg);
          finally
            NotifyHooks(AMsg);
          end;
        end;
      end;
    end;
end;

procedure TControlHook.SetControl(Value: TControl);
begin
  if Value <> FControl then
  begin
    UnhookControl;
    FControl := Value;
    if FList.Count > 0 then HookControl;
  end;
end;

procedure TControlHook.SetHandle(const Value: HWnd);
begin
  if Value <> FHandle then
  begin
    UnhookControl;
    FHandle := Value;
    if FList.Count > 0 then HookControl;
  end;
end;

function TControlHook.GetHandle: HWnd;
begin
  if FHandle <> 0 then
    Result := FHandle
  else
    if (FControl <> nil) and (FControl is TWinControl) then
      Result := TWinControl(FControl).Handle
    else
      Result := 0;
end;

{ THookList ===================================================================}

constructor THookList.Create;
begin
  inherited Create;
  FHandle := AllocateHWnd(WndProc);
end;

destructor THookList.Destroy;
begin
  while Count > 0 do TControlHook(Last).Free;
  DeallocateHWnd(FHandle);
  inherited Destroy;
end;

procedure THookList.WndProc(var Msg: TMessage);
var
  Hook: TControlHook;
begin
  try
    with Msg do
    begin
{      if Msg = CM_RECREATEWINDOW then
      begin
        Hook := TControlHook(LParam);
        if (Hook <> nil) and (IndexOf(Hook) >= 0) then
          Hook.HookControl;
      end
      else}
        if Msg = CM_DESTROYHOOK then
        begin
          Hook := TControlHook(LParam);
          if Assigned(Hook) and (IndexOf(Hook) >= 0) and
            (Hook.FList.Count = 0) then Hook.Free;
        end
        else
          Result := DefWindowProc(FHandle, Msg, wParam, lParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

function THookList.FindControlHook(AControl: TControl): TControlHook;
var
  I: Integer;
begin
  if Assigned(AControl) then
    for I := 0 to Count - 1 do
      if (TControlHook(Items[I]).Control = AControl) then
      begin
        Result := TControlHook(Items[I]);
        Exit;
      end;
  Result := nil;
end;

function THookList.FindControlHook(AControl: HWnd): TControlHook;
var
  I: Integer;
begin
  if AControl <> 0 then
    for I := 0 to Count - 1 do
      if (TControlHook(Items[I]).Handle = AControl) then
      begin
        Result := TControlHook(Items[I]);
        Exit;
      end;
  Result := nil;
end;

function THookList.GetControlHook(AControl: TControl): TControlHook;
begin
  Result := FindControlHook(AControl);
  if Result = nil then
  begin
    Result := TControlHook.Create;
    try
      Add(Result);
      Result.Control := AControl;
    except
      Result.Free;
      raise;
    end;
  end;
end;

function THookList.GetControlHook(AControl: HWnd): TControlHook;
begin
  Result := FindControlHook(AControl);
  if Result = nil then
  begin
    Result := TControlHook.Create;
    try
      Add(Result);
      Result.Handle := AControl;
    except
      Result.Free;
      raise;
    end;
  end;
end;

{ TbsaHook =====================================================================}

constructor TbsaHook.Create(AControl: TControl = nil; AOnHandleMessage: TbsaControlHookMessageEvent = nil);
begin
  inherited Create(nil);
  FActive := True;
  if not SubClassManagerFree and Assigned(AOnHandleMessage) then OnControlHandleMessage := AOnHandleMessage;
  if AControl <> nil then Control := AControl;
end;

constructor TbsaHook.CreateByHandle(AControl: HWnd;
  AOnHandleMessage: TbsaHookMessageEvent);
begin
  inherited Create(nil);
  FActive := True;
  if not SubClassManagerFree and Assigned(AOnHandleMessage) then OnHandleMessage := AOnHandleMessage;
  if FindControl(AControl) <> nil then
    Control := FindControl(AControl)
  else
    if AControl <> 0 then
      Handle := AControl;
end;

destructor TbsaHook.Destroy;
begin
  Active := False;
  Control := nil;
  inherited Destroy;
end;

procedure TbsaHook.SetActive(Value: Boolean);
begin
  if FActive <> Value then
    if Value then
      HookControl
    else
      UnhookControl;
end;

function TbsaHook.GetHookHandle: HWnd;
begin
  if Assigned(HookList) then
    Result := HookList.Handle
  else
    Result := 0;
end;

procedure TbsaHook.HookControl;
begin
  if Assigned(FControl) and not (csDestroying in ComponentState) then
    GetHookList.GetControlHook(FControl).AddHook(Self)
  else
    if (FHandle <> 0) and not (csDestroying in ComponentState) then
      GetHookList.GetControlHook(FHandle).AddHook(Self);
  FActive := True;
end;

function TbsaHook.DoUnhookControl: Pointer;
begin
  Result := FControlHook;
  if not SubClassManagerFree and Assigned(FOnUnhookControl) then
    FOnUnhookControl(FControl, FHandle);
  if Result <> nil then TControlHook(Result).RemoveHook(Self);
  FActive := False;
end;

procedure TbsaHook.UnhookControl;
begin
  DoUnhookControl;
  FActive := False;
end;

procedure TbsaHook.DoHandleMessage(var Msg: TMessage; DefaultProc: TWndMethod);
begin
  if not FActive then
  begin
    DefaultProc(Msg);
    Exit;
  end;
  if not SubClassManagerFree and Assigned(FControl) and Assigned(FOnControlHandleMessage) then
    FOnControlHandleMessage(FControl, Msg, DefaultProc);
  if not SubClassManagerFree and (FHandle <> 0) and Assigned(FOnHandleMessage) then
    FOnHandleMessage(FHandle, Msg, DefaultProc);
end;

procedure TbsaHook.SetControl(Value: TControl);
var
  SaveActive: Boolean;
  Hook: TControlHook;
begin
  if Value <> Control then
  begin
    SaveActive := FActive;
    Hook := TControlHook(DoUnhookControl);
    FControl := Value;
    if Assigned(Hook) and (Hook.FList.Count = 0) and Assigned(HookList) then
      PostMessage(HookList.Handle, CM_DESTROYHOOK, 0, LongInt(Hook));
    if SaveActive then HookControl;
  end;
end;

function TbsaHook.GetControl: TControl;
begin
  if Assigned(FControlHook) then
    Result := TControlHook(FControlHook).Control
  else
    Result := FControl;
end;

function TbsaHook.GetHandle: HWnd;
begin
  if Assigned(FControlHook) then
    Result := TControlHook(FControlHook).Handle
  else
    Result := FHandle;
end;

procedure TbsaHook.SetHandle(const Value: HWnd);
var
  SaveActive: Boolean;
  Hook: TControlHook;
begin
  if Value <> Handle then
  begin
    SaveActive := FActive;
    Hook := TControlHook(DoUnhookControl);
    FHandle := Value;
    if Assigned(Hook) and (Hook.FList.Count = 0) and Assigned(HookList) then
      PostMessage(HookList.Handle, CM_DESTROYHOOK, 0, LongInt(Hook));
    if SaveActive then HookControl;
  end;
end;

{ TbsaHookCollection =================================================================}

constructor TbsaHookCollection.Create;
begin
  inherited Create;
  FHookList := TList.Create;
end;

destructor TbsaHookCollection.Destroy;
var
  i: Integer;
begin
  for i := 0 to FHookList.Count - 1 do
  begin
    TbsaHook(FHookList[i]).Free;
  end;
  FHookList.Free;
  inherited;
end;

procedure TbsaHookCollection.RemoveControl(AControl: TControl; AUnhook: Boolean = False);
var
  i: Integer;
  H: TbsaHook;
begin
  { Chck if exists }
  for i := 0 to FHookList.Count - 1 do
    if TbsaHook(FHookList[i]).Control = AControl then
    begin
      H := TbsaHook(FHookList[i]);
      FHookList.Delete(i);
      if AUnhook then
        H.UnhookControl;
      H.FActive := False;
      H.FHandle := 0;
      H.FControl := nil;
      H.Free;
      Exit;
    end;
end;

procedure TbsaHookCollection.RemoveControl(AControl: HWnd; AUnhook: Boolean = False);
var
  i: Integer;
  H: TbsaHook;
begin
  { Chck if exists }
  for i := 0 to FHookList.Count - 1 do
    if TbsaHook(FHookList[i]).Handle = AControl then
    begin
      H := TbsaHook(FHookList[i]);
      FHookList.Delete(i);
      if AUnhook then
        H.UnhookControl;
      H.FActive := False;
      H.FHandle := 0;
      H.FControl := nil;
      H.Free;
      Exit;
    end;
end;

procedure TbsaHookCollection.AddControl(AControl: TControl;
  AOnHandleMessage: TbsaControlHookMessageEvent;
  AOnUnhookControl: TbsaUnhookEvent);
var
  H: TbsaHook;
  i: Integer;
  Msg: TMessage;
begin
  { Chck if exists }
  for i := 0 to FHookList.Count - 1 do
    if TbsaHook(FHookList[i]).Control = AControl then
    begin
      Exit;
    end;

  { Add }
  H := TbsaHook.Create(AControl, AOnHandleMessage);
  H.OnUnhookControl := AOnUnhookControl;
  FHookList.Add(H);

  if AControl is TWinControl then
    SendMessage(TWinControl(AControl).Handle, WM_NULL, 0, 0)
  else
  begin
    Msg.Msg := WM_NULL;
    H.OnControlHandleMessage(AControl, Msg, TControlHook(H.FControlHook).FPrevWndMethod);
  end;
end;

procedure TbsaHookCollection.AddControl(AControl: HWnd;
  AOnHandleMessage: TbsaHookMessageEvent;
  AOnUnhookControl: TbsaUnhookEvent);
var
  H: TbsaHook;
  i: Integer;
begin
  { Chck if exists }
  for i := 0 to FHookList.Count - 1 do
    if TbsaHook(FHookList[i]).Handle = AControl then
    begin
      Exit;
    end;
  { Add }
  H := TbsaHook.CreateByHandle(AControl, AOnHandleMessage);
  H.OnUnhookControl := AOnUnhookControl;
  FHookList.Add(H);

  SendMessage(AControl, WM_NULL, 0, 0)
end;

procedure TbsaHookCollection.CollectControl(AOwner: TComponent; AControlClass: TControlClass;
  AOnHandleMessage: TbsaControlHookMessageEvent;
  AOnUnhookControl: TbsaUnhookEvent);
var
  i: Integer;
begin
  if AOwner = nil then Exit;

  if AOwner is TCustomForm then
  begin
    for i := 0 to AOwner.ComponentCount - 1 do
    begin
      if AOwner.Components[i] is AControlClass then
      begin
        AddControl(TControl(AOwner.Components[i]), AOnHandleMessage, AOnUnhookControl);
      end;
      if AOwner.Components[i] is TWinControl then
        CollectControl(TControl(AOwner.Components[i]), AControlClass, AOnHandleMessage,
          AOnUnhookControl);
    end;
  end
  else
    if AOwner is TWinControl then
    begin
      for i := 0 to TWinControl(AOwner).ControlCount - 1 do
      begin
        if TWinControl(AOwner).Controls[i] is AControlClass then
        begin
          AddControl(TWinControl(AOwner).Controls[i], AOnHandleMessage, AOnUnhookControl);
        end;
        if TWinControl(AOwner).Controls[i] is TWinControl then
          CollectControl(TWinControl(AOwner).Controls[i], AControlClass, AOnHandleMessage,
            AOnUnhookControl);
      end;
    end
    else
      for i := 0 to AOwner.ComponentCount - 1 do
        if AOwner.Components[i] is AControlClass then
        begin
          AddControl(TControl(AOwner.Components[i]), AOnHandleMessage, AOnUnhookControl);
        end;
end;

procedure TbsaHookCollection.CollectControlByHandle(AOwner: TComponent;
  AControlClass: TControlClass;
  AOnHandleMessage: TbsaHookMessageEvent;
  AOnUnhookControl: TbsaUnhookEvent);
var
  i: Integer;
begin
  if AOwner = nil then Exit;

  for i := 0 to AOwner.ComponentCount - 1 do
    if (AOwner.Components[i] is AControlClass) and (AOwner.Components[i] is TWinControl) then
    begin
      AddControl(TWinControl(AOwner.Components[i]).Handle, AOnHandleMessage, AOnUnhookControl);
    end;
end;

var
  WList: TList = nil;

function EnumFunc(W: HWnd; NeedName: PChar): Boolean; stdcall;
var
  CName: PChar;
begin
  CName := PChar(GlobalAlloc(0, 100));
  if GetClassName(W, CName, StrLen(CName)) > 0 then
  begin
    if LowerCase(CName) = LowerCase(NeedName) then
      WList.Add(Pointer(W));
  end;
  GlobalFree(Cardinal(CName));
  Result := True;
end;

procedure TbsaHookCollection.CollectControlByClass(AOwner: TComponent;
  AClass: string;
  AOnHandleMessage: TbsaHookMessageEvent;
  AOnUnhookControl: TbsaUnhookEvent);
var
  i: Integer;
  OwnWnd: HWnd;
begin
  if AOwner = nil then Exit;
  if not (AOwner is TWinControl) then Exit;

  OwnWnd := (AOwner as TWinControl).Handle;
  if OwnWnd = 0 then Exit;

  WList := TList.Create;
  try
    EnumChildWindows(OwnWnd, @EnumFunc, Integer(PChar(AClass)));

    for i := 0 to WList.Count - 1 do
      AddControl(HWnd(WList[i]), AOnHandleMessage, AOnUnhookControl);
  finally
    WList.Free;
  end;
end;

procedure TbsaHookCollection.CollectControlByClass2(AOwnerWindow: HWnd;
  AClass: string;
  AOnHandleMessage: TbsaHookMessageEvent;
  AOnControlHandleMessage: TbsaControlHookMessageEvent;
  AOnUnhookControl: TbsaUnhookEvent);
var
  i: Integer;
  OwnWnd: HWnd;
  Ctrl: TControl;
begin
  if AOwnerWindow = 0 then Exit;
  OwnWnd := AOwnerWindow;

  WList := TList.Create;
  try
    EnumChildWindows(OwnWnd, @EnumFunc, Integer(PChar(AClass)));

    for i := 0 to WList.Count - 1 do
    begin
      Ctrl := FindControl(HWnd(WList[i]));
      if Ctrl <> nil then
        AddControl(Ctrl, AOnControlHandleMessage, AOnUnhookControl)
      else
        AddControl(HWnd(WList[i]), AOnHandleMessage, AOnUnhookControl);
    end;
  finally
    WList.Free;
  end;
end;



const

  SMouseInControl = 'mouseincontrol';
  SFocused = 'focused';
  SPressed = 'pressed';

type
  TbsaSubclassHackGraphicControl = class(TGraphicControl);
  TbsaSubclassHackControl = class(TControl);
  TbsaSubclassHackWinControl = class(TWinControl);
  TbsaSubclassHackCustomListBox = class(TCustomListBox);
  TbsaSubclassHackCustomPanel = class(TCustomPanel);
  TbsaSubclassHackCustomTabControl = class(TCustomTabControl);
  TbsaSubclassHackCustomListView = class(TCustomListView);
  TbsaSubclassHackCustomComboBox = class(TCustomComboBox);
  TbsaSubclassHackCustomLabel = class(TCustomLabel);
  TbsaSubclassHackSpeedButton = class(TSpeedButton);
  TbsaSubclassHackGroupBox = class(TCustomGroupBox);
  TbsaSubclassHackPanel = class(TCustomPanel);


type

  { Scrollbar information }
  PScrollBarInfo = ^TScrollBarInfo;
  {$EXTERNALSYM tagSCROLLBARINFO}
  tagSCROLLBARINFO = packed record
    cbSize: DWORD;
    rcScrollBar: TRect;
    dxyLineButton: Integer;
    xyThumbTop: Integer;
    xyThumbBottom: Integer;
    bogus: Integer;
    rgstate: array[0..CCHILDREN_SCROLLBAR] of DWORD;
  end;
  TScrollBarInfo = tagSCROLLBARINFO;

var
  SubclassList: TList = nil;
  RunOnWinNT: Boolean = False;
  RunOnWinNT4: Boolean = False;
  ScrollUser32Handle: THandle;
  GetScrollBarInfoFunc: function (wnd: Cardinal; idObject: LongInt; var psbi: TScrollBarInfo): BOOL; stdcall;

function IsWinNT: Boolean;
begin
  Result := RunOnWinNT;
end;

function IsWinNT4: Boolean;
begin
  Result := RunOnWinNT4;
end;

procedure SetupWinNT;
var
  VI: TOSVersionInfo;
begin
  VI.dwOSVersionInfoSize := SizeOf(VI);
  GetVersionEx(VI);

  RunOnWinNT := VI.dwPlatformId = VER_PLATFORM_WIN32_NT;
  RunOnWinNT4 := VI.dwMajorVersion = 4;
end;


procedure CreateSkinControlImage(LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
                                 B, SB: TBitmap; R: TRect;
                                 AW, AH: Integer; AStretchEffect: Boolean;
                                 ALeftStretch, ATopStretch, ARightStretch, ABottomStretch: Boolean;
                                 AUseSkinSize: Boolean; AStretchType: TbsStretchType);

function GetResizeMode: Integer;
begin
  if (RBPt.X <> 0) and (RBPt.Y <> 0)
  then
    Result := 1
  else
  if (RTPt.X <> 0) or (RTPT.Y <> 0)
  then
    Result := 2
  else
  if (LBPt.X <> 0) or (LBPt.Y <> 0)
  then
    Result := 3
  else
    Result := 0;
end;


var
  XO, YO, ResizeMode, H, W: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewClRect: TRect;
begin
  NewLTPoint := Point(0, 0);
  NewRTPoint := Point(0, 0);
  NewLBPoint := Point(0, 0);
  NewRBPoint := Point(0, 0);
  NewClRect := Rect(0, 0, 0, 0);
  XO := AW - RectWidth(R);
  YO := AH - RectHeight(R);
  ResizeMode := GetResizeMode;
  case ResizeMode of
    1:
      begin
        NewLTPoint := LtPt;
        NewRTPoint := Point(RTPt.X + XO, RTPt.Y);
        NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
        NewRBPoint := Point(RBPt.X + XO, RBPt.Y + YO);
        NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      end;
    2:
      begin
        H := RectHeight(R);
        NewRTPoint := Point(RTPt.X + XO, RTPt.Y );
        NewClRect := ClRect;
        Inc(NewClRect.Right, XO);
      end;
    3:
      begin
        W := RectWidth(R);
        NewLBPoint := Point(LBPt.X, LBPt.Y + YO);
        NewClRect := ClRect;
        Inc(NewClRect.Bottom, YO);
      end;
  end;
  case ResizeMode of
    0:
      begin
        if AUseSkinSize
        then
          begin
            B.Width := RectWidth(R);
            B.Height := RectHeight(R);
            B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), SB.Canvas, R);
          end
        else
          begin
            B.Width := AW;
            B.Height := AH;
            B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), SB.Canvas, R);
          end;
      end;
    1: CreateSkinImage(LTPt, RTPt, LBPt, RBPt, CLRect,
         NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
         B, SB, R, AW, AH, True,
         ALeftStretch, ATopStretch, ARightStretch, ABottomStretch,
         AStretchEffect, AStretchType);
    2:
      begin
        if AUseSkinSize
        then
          CreateHSkinImage(LTPt.X, RectWidth(R) - RTPt.X,
             B, SB, R, AW, AH,  AStretchEffect)
        else
          CreateStretchImage(B,  SB, R, ClRect, True);
      end;
    3:
      begin
        if AUseSkinSize
        then
          CreateVSkinImage(LTPt.Y, RectHeight(R) - LBPt.Y,
             B, SB, R, AW, AH,  AStretchEffect)
        else
          CreateStretchImage(B,  SB, R, ClRect, True);
      end;      
  end;
end;

function DrawSkinText(ACanvas: TCanvas; AText: WideString; var Bounds: TRect; Flag: Cardinal): Integer;
var
  AnsiText: string;
begin
  SetBkMode(ACanvas.Handle, TRANSPARENT);
  if IsWinNT then
    Result := Windows.DrawTextW(ACanvas.Handle, PWideChar(AText), Length(AText), Bounds, Flag)
  else
  begin
    AnsiText := WideCharToString(PWideChar(AText));
    Result := Windows.DrawText(ACanvas.Handle, PChar(AnsiText), Length(AnsiText), Bounds, Flag);
  end;
end;

procedure CalcLCoord(Layout: TbsButtonLayout; R: TRect; gw, gh, tw, th: Integer;
  Spacing, Margin: Integer; var tx, ty, gx, gy: Integer);
var
  H, W, H1, W1: Integer;
begin
 H := R.Top + RectHeight(R) div 2;
 W := R.Left + RectWidth(R) div 2;
 if Margin = -1
 then
   begin
     W1 := (tw + gw + Spacing) div 2;
     H1 := (th + gh + Spacing) div 2;
     case Layout of
       blGlyphRight:
         begin
           tx := W - W1;
           ty := H - th div 2;
           gx := W + W1 - gw;
           gy := H - gh div 2;
         end;
      blGlyphLeft:
         begin
           gx := W - W1;
           gy := H - gh div 2;
           tx := W + W1 - tw;
           ty := H - th div 2;
         end;
      blGlyphTop:
         begin
           tx := W - tw div 2;
           ty := H + H1 - th;
           gx := W - gw div 2;
           gy := H - H1;
        end;
     blGlyphBottom:
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
       blGlyphRight:
         begin
           gy := H - gh div 2;
           gx := R.Right - gw - Margin;
           tx := gx - Spacing - tw;
           ty := H - th div 2;
         end;
       blGlyphLeft:
         begin
           gy := H - gh div 2;
           gx := R.Left + Margin;
           tx := gx + gw + Spacing;
           ty := H - th div 2;
         end;
       blGlyphTop:
          begin
            gy := R.Top +  Margin;
            gx := W - gw div 2;
            ty := gy + gh + Spacing;
            tx := W - tw div 2;
          end;
      blGlyphBottom:
          begin
            gy := R.Bottom - gh - Margin;
            gx := W - gw div 2;
            ty := gy - Spacing - th;
            tx := W - tw div 2;
         end;
       end;
    end;
end;

procedure DrawGlyphAndText(Cnvs: TCanvas;
  R: TRect; Margin, Spacing: Integer; Layout: TbsButtonLayout;
  Caption: WideString; Glyph: TBitMap; NumGlyphs, GlyphNum: Integer; ADown: Boolean);
var
  gw, gh: Integer;
  tw, th: Integer;
  TX, TY, GX, GY: Integer;
  TR: TRect;
begin
  if (Glyph = nil) or Glyph.Empty
  then
    begin
      gw := 0;
      gh := 0;
    end
  else
    begin
      gw := Glyph.Width div NumGlyphs;
      gh := Glyph.Height;
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
        if (Layout = blGlyphLeft) or (Layout = blGlyphRight)
        then
          begin
            Dec(TR.Right, gw);
          end
        else
        if (Layout = blGlyphTop) or (Layout = blGlyphBottom)
        then
          begin
            Dec(TR.Bottom, gh);
          end;
        DrawSkinText(Cnvs, Caption, TR, DT_EXPANDTABS or DT_WORDBREAK or DT_CALCRECT);
        tw := RectWidth(TR);
        th := RectHeight(TR);
        Brush.Style := bsClear;
     end;
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
      DrawSkinText(Cnvs, Caption, TR, DT_EXPANDTABS or DT_VCENTER or DT_CENTER or DT_WORDBREAK);
    end;

  if (Glyph <> nil) and not Glyph.Empty then DrawGlyph(Cnvs, GX, GY, Glyph, NumGlyphs, GlyphNum);

end;

procedure RegisterSubclass(AClass: TbsaSubclassClass);
begin
  if SubclassList = nil then
    SubclassList := TList.Create;

  SubclassList.Add(AClass);
end;

function MyGetScrollBarInfo(wnd: Cardinal; idObject: LongInt; var psbi: TScrollBarInfo): BOOL;
begin
  if @GetScrollBarInfoFunc <> nil then
    Result := GetScrollBarInfoFunc(wnd, idObject, psbi)
  else
  begin
    { Win95 }
    psbi.rgstate[0] := STATE_SYSTEM_INVISIBLE;
    Result := False;
  end;
end;


{ TbsaSkinManager }

constructor TbsaSkinManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomProp := TStringList.Create;
  FHookCollection := TbsaHookCollection.Create;
  FHandleList := TList.Create;
  FHotTrackTimer := TTimer.Create(nil);
  FHotTrackTimer.Interval := 30;
  FHotTrackTimer.OnTimer := DoHotTrackTimer;
  FHotTrackTimer.Enabled := not (csDesigning in ComponentState);
  FUnhookedList := TList.Create;
end;

destructor TbsaSkinManager.Destroy;
var
  i: Integer;
begin
  SubClassManagerFree := True;
  for i := 0 to FUnhookedList.Count - 1 do
    TbsaSubclass(FUnhookedList[i]).Free;
  FreeAndNil(FUnhookedList);
  FHotTrackTimer.Free;
  FHookCollection.Free;
  FCustomProp.Free;
  for i := FHandleList.Count - 1 downto 0 do
    TbsaSubclass(FHandleList[i]).Free;
  FreeAndNil(FHandleList);
  inherited Destroy;
  SubClassManagerFree := False;
end;

procedure TbsaSkinManager.DisableSubclass;
begin
  while FHandleList.Count > 0 do
  begin
    FHookCollection.RemoveControl(TbsaSubclass(FHandleList[FHandleList.Count - 1]).Handle, True);
  end;
end;

function TbsaSkinManager.IsHandleListEmpty: Boolean;
begin
  Result := FHandleList.Count = 0;
end;

function MyFindComponent(AComp: TComponent; AName: string): TComponent;
var
  i: Integer;
begin
  Result := nil;
  if AComp = nil then Exit;

  for i := 0 to AComp.ComponentCount - 1 do
  begin
    if LowerCase(AComp.Components[i].Name) = AName then
    begin
      Result := AComp.Components[i];
      Exit;
    end;

    if AComp.Components[i].ComponentCount > 0 then
    begin
      Result := MyFindComponent(AComp.Components[i], AName);
      if Result <> nil then
        Exit;
    end;
  end;
end;

procedure TbsaSkinManager.CollectScrollControl(C: TControl);
begin
  FCurrentSubclass := TbsaScrollSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    SendMessage(TWinControl(C).Handle, WM_NCPAINT, 0, 0);
    SendMessage(TWinControl(C).Handle, WM_SIZE, 0, 0);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectScroll(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaScrollSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to ScrollSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(ScrollSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           SendMessage(TWinControl(C).Handle, WM_NCPAINT, 0, 0);
           SendMessage(TWinControl(C).Handle, WM_SIZE, 0, 0);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
          FCurrentSubclass := nil;
       end;
    end
  else
    begin
      S := lowercase(ScrollSubclassStrList.Text);
      try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectScroll(AForm.Components[i]);
             FCurrentSubclass := TbsaScrollSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               SendMessage(TWinControl(C).Handle, WM_NCPAINT, 0, 0);
               SendMessage(TWinControl(C).Handle, WM_SIZE, 0, 0);
               TWinControl(C).Invalidate;
             end;
           end;  
       end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;

procedure TbsaSkinManager.CollectButtonControl(C: TControl);
begin
  FCurrentSubclass := TbsaButtonSubclass;
  if (C <> nil) and (C is TWinControl)
  then
    begin
      FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
      TWinControl(C).Invalidate;
    end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectButton(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaButtonSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
        for i := 0 to ButtonSubclassStrList.Count - 1 do
        begin
         C := MyFindComponent(AForm, LowerCase(ButtonSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
        end;
       end;
       finally
        FCurrentSubclass := nil;
       end;
    end
  else
    begin
      S := lowercase(ButtonSubclassStrList.Text);
      try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectButton(AForm.Components[i]);
             FCurrentSubclass := TbsaButtonSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;  
       end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;

procedure TbsaSkinManager.CollectSpeedButtonControl(C: TControl);
begin
  FCurrentSubclass := TbsaSpeedButtonSubclass;
  if (C <> nil) and (C is TGraphicControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectSpeedButton(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
  FCurrentSubclass := TbsaSpeedButtonSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
        for i := 0 to SpeedButtonSubclassStrList.Count - 1 do
        begin
          C := MyFindComponent(AForm, LowerCase(SpeedButtonSubclassStrList[i]));
          if (C <> nil) and (C is TGraphicControl) then
          begin
            FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TControl(C).Invalidate;
         end;
        end;
      finally
        FCurrentSubclass := nil;
      end;
   end
 else
   begin
      S := lowercase(SpeedButtonSubclassStrList.Text);
      try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectSpeedButton(AForm.Components[i]);
             FCurrentSubclass := TbsaSpeedButtonSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TGraphicControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TControl(C).Invalidate;
             end;
           end;  
       end;
      finally
        FCurrentSubclass := nil;
      end;
   end;
end;

procedure TbsaSkinManager.CollectCheckBoxControl(C: TControl);
begin
  FCurrentSubclass := TbsaCheckBoxSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectCheckBox(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaCheckBoxSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to CheckBoxSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(CheckBoxSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(CheckBoxSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectCheckBox(AForm.Components[i]);
             FCurrentSubclass := TbsaCheckBoxSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;

procedure TbsaSkinManager.CollectUpDownControl(C: TControl);
begin
  FCurrentSubclass := TbsaUpDownSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectUpDown(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaUpDownSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to UpDownSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(UpDownSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(UpDownSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectUpDown(AForm.Components[i]);
             FCurrentSubclass := TbsaUpDownSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;

procedure TbsaSkinManager.CollectComboBoxControl(C: TControl);
begin
  FCurrentSubclass := TbsaComboBoxSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectComboBox(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaComboBoxSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to ComboBoxSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(ComboBoxSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(ComboBoxSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectComboBox(AForm.Components[i]);
             FCurrentSubclass := TbsaComboBoxSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;

procedure TbsaSkinManager.CollectEditControl(C: TControl);
begin
  FCurrentSubclass := TbsaEditSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectEdit(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaEditSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to EditSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(EditSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(EditSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectEdit(AForm.Components[i]);
             FCurrentSubclass := TbsaEditSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;

procedure TbsaSkinManager.CollectDateTimeControl(C: TControl);
begin
  FCurrentSubclass := TbsaDateTimeSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectDateTime(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaDateTimeSubclass;
 
  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to DateTimeSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(DateTimeSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(DateTimeSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectDateTime(AForm.Components[i]);
             FCurrentSubclass := TbsaDateTimeSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;

procedure TbsaSkinManager.CollectListViewControl(C: TControl);
begin
  FCurrentSubclass := TbsaListViewSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectListView(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaListViewSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to ListViewSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(ListViewSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(ListViewSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectListView(AForm.Components[i]);
             FCurrentSubclass := TbsaListViewSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;

procedure TbsaSkinManager.CollectRadioButtonControl(C: TControl);
begin
  FCurrentSubclass := TbsaRadioButtonSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectRadioButton(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaRadioButtonSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to RadioButtonSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(RadioButtonSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(RadioButtonSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectRadioButton(AForm.Components[i]);
             FCurrentSubclass := TbsaRadioButtonSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;

procedure TbsaSkinManager.CollectTabControl(C: TControl);
var
  j: Integer;
begin
  FCurrentSubclass := TbsaTabSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;  
  FCurrentSubclass := nil;
  if C is TPageControl
  then
    begin
      for j := 0 to TPageControl(C).PageCount - 1 do
      begin
        FCurrentSubclass := TbsaTabSheetSubclass;
        FHookCollection.AddControl(TPageControl(C).Pages[j], DoControlMessage, DoUnhook);
        TPageControl(C).Pages[j].Invalidate;
        FCurrentSubclass := nil;
      end;
   end;
end;

procedure TbsaSkinManager.CollectTab(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  if FAdapter.AdapterType = bsaUseNames
  then
  begin
  for i := 0 to TabSubclassStrList.Count - 1 do
  begin
    C := MyFindComponent(AForm, LowerCase(TabSubclassStrList[i]));
    if (C <> nil) and (C is TWinControl) then
    begin
      FCurrentSubclass := TbsaTabSubclass;
      try
        FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
        TWinControl(C).Invalidate;
      finally
        FCurrentSubclass := nil;
      end;

      if C is TPageControl then
      begin
        for j := 0 to TPageControl(C).PageCount - 1 do
        begin
          FCurrentSubclass := TbsaTabSheetSubclass;
          try
            FHookCollection.AddControl(TPageControl(C).Pages[j], DoControlMessage, DoUnhook);
            TPageControl(C).Pages[j].Invalidate;
          finally
            FCurrentSubclass := nil;
          end;
        end;
      end;
    end;
  end;
  end
  else
  begin
    S := lowercase(TabSubclassStrList.Text);
    try
      for i := 0 to AForm.ComponentCount - 1 do
      begin
        if AForm.Components[i] is TFrame
         then
           begin
             CollectTab(AForm.Components[i]);
             FCurrentSubclass := TbsaTabSubclass;
             Continue;
           end;
        S2 := lowercase(AForm.Components[i].ClassName);
        if Pos(S2, S) > 0
        then
          begin
            C := AForm.Components[i];
            if (C <> nil) and (C is TWinControl) then
            begin
              FCurrentSubclass := TbsaTabSubclass;
              try
                FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
                TWinControl(C).Invalidate;
              finally
                FCurrentSubclass := nil;
              end;

             if C is TPageControl then
             begin
               for j := 0 to TPageControl(C).PageCount - 1 do
               begin
                 FCurrentSubclass := TbsaTabSheetSubclass;
                 try
                   FHookCollection.AddControl(TPageControl(C).Pages[j], DoControlMessage, DoUnhook);
                   TPageControl(C).Pages[j].Invalidate;
                 finally
                   FCurrentSubclass := nil;
                 end;
               end;
             end;
           end;
         end;
       end;
    finally
      FCurrentSubclass := nil;
    end;
  end;
end;

procedure TbsaSkinManager.CollectGroupBoxControl(C: TControl);
var
  j: Integer;
begin
  FCurrentSubclass := TbsaGroupBoxSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  if C is TCustomGroupBox
  then
    begin
      for j := 0 to TGroupBox(C).ControlCount - 1 do
      if TCustomGroupBox(C).Controls[j] is TRadioButton then
      begin
        FCurrentSubclass := TbsaRadioButtonSubclass;
        FHookCollection.AddControl(TCustomGroupBox(C).Controls[j], DoControlMessage, DoUnhook);
        TCustomGroupBox(C).Controls[j].Invalidate;
        FCurrentSubclass := nil;
      end;
    end;
  FCurrentSubclass := nil;
end;


procedure TbsaSkinManager.CollectGroupBox(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  if FAdapter.AdapterType = bsaUseNames
  then
  begin
  for i := 0 to GroupBoxSubclassStrList.Count - 1 do
  begin
    C := MyFindComponent(AForm, LowerCase(GroupBoxSubclassStrList[i]));
    if (C <> nil) and (C is TWinControl) then
    begin
      FCurrentSubclass := TbsaGroupBoxSubclass;
      try
        FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
        TWinControl(C).Invalidate;
      finally
        FCurrentSubclass := nil;
      end;

      if C is TCustomGroupBox then
      begin
        for j := 0 to TGroupBox(C).ControlCount - 1 do
        if TCustomGroupBox(C).Controls[j] is TRadioButton then
        begin
          FCurrentSubclass := TbsaRadioButtonSubclass;
          try
            FHookCollection.AddControl(TCustomGroupBox(C).Controls[j], DoControlMessage, DoUnhook);
            TCustomGroupBox(C).Controls[j].Invalidate;
          finally
            FCurrentSubclass := nil;
          end;
        end;
      end;
    end;
  end;
  end
  else
  begin
    S := lowercase(GroupBoxSubclassStrList.Text);
    try
     for i := 0 to AForm.ComponentCount - 1 do
     begin
       if AForm.Components[i] is TFrame
         then
           begin
             CollectGroupBox(AForm.Components[i]);
             FCurrentSubclass := TbsaGroupBoxSubclass;
             Continue;
           end;
       S2 := lowercase(AForm.Components[i].ClassName);
       if Pos(S2, S) > 0
       then
         begin
           C := AForm.Components[i];
           if (C <> nil) and (C is TWinControl) then
           begin
             FCurrentSubclass := TbsaGroupBoxSubclass;
             try
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             finally
               FCurrentSubclass := nil;
             end;

             if C is TCustomGroupBox then
             begin
               for j := 0 to TGroupBox(C).ControlCount - 1 do
               if TCustomGroupBox(C).Controls[j] is TRadioButton then
               begin
                 FCurrentSubclass := TbsaRadioButtonSubclass;
                 try
                   FHookCollection.AddControl(TCustomGroupBox(C).Controls[j], DoControlMessage, DoUnhook);
                   TCustomGroupBox(C).Controls[j].Invalidate;
                 finally
                   FCurrentSubclass := nil;
                end;
              end;
            end;

           end;
         end;
       end;
    finally
      FCurrentSubclass := nil;
    end;
  end;
end;

procedure TbsaSkinManager.UnCollectLabelControl(C: TControl);
begin
  if (C <> nil) and (C is TLabel)
  then
  begin
    TLabel(C).Font.Color := clBtnText;
  end;
end;

procedure TbsaSkinManager.UnCollectLabel(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
   if FAdapter.AdapterType = bsaUseNames
  then
    begin
       for i := 0 to LabelSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(LabelSubclassStrList[i]));
         if (C <> nil) and (C is TLabel) then UnCollectLabelControl(TLabel(C));
       end;
     end
   else
     begin
       S := lowercase(LabelSubclassStrList.Text);
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             Collectlabel(AForm.Components[i]);
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TLabel) then UnCollectLabelControl(TLabel(C));
           end;
        end;
    end;
end;

procedure TbsaSkinManager.CollectLabelControl(C: TControl);
begin
  if (C <> nil) and (C is TLabel) and (FAdapter.SkinData <> nil)
  then
  begin
    if not TLabel(C).Transparent then TLabel(C).Transparent := True;
    TLabel(C).Font.Color := FAdapter.SkinData.SkinColors.cBtnText;
  end;
end;

procedure TbsaSkinManager.CollectLabel(AForm: TComponent);
var
  i: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
   if FAdapter.AdapterType = bsaUseNames
  then
    begin
       for i := 0 to LabelSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(LabelSubclassStrList[i]));
         if (C <> nil) and (C is TLabel) then CollectLabelControl(TLabel(C));
       end;
     end
   else
     begin
       S := lowercase(LabelSubclassStrList.Text);
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             Collectlabel(AForm.Components[i]);
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TLabel) then CollectLabelControl(TLabel(C));
           end;
        end;
    end;
end;

procedure TbsaSkinManager.CollectPanelControl(C: TControl);
begin
  FCurrentSubclass := TbsaPanelSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil; 
end;

procedure TbsaSkinManager.CollectToolBarControl(C: TControl);
begin
  FCurrentSubclass := TbsaToolBarSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;


procedure TbsaSkinManager.CollectCoolBarControl(C: TControl);
begin
  FCurrentSubclass := TbsaCoolBarSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectProgressBarControl(C: TControl);
begin
  FCurrentSubclass := TbsaProgressBarSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectTrackBarControl(C: TControl);
begin
  FCurrentSubclass := TbsaTrackBarSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;


procedure TbsaSkinManager.CollectStatusBarControl(C: TControl);
begin
  FCurrentSubclass := TbsaStatusBarSubclass;
  if (C <> nil) and (C is TWinControl) then
  begin
    FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
    TWinControl(C).Invalidate;
  end;
  FCurrentSubclass := nil;
end;

procedure TbsaSkinManager.CollectPanel(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
  
  FCurrentSubclass := TbsaPanelSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to PanelSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(PanelSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(PanelSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectPanel(AForm.Components[i]);
             FCurrentSubclass := TbsaPanelSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;


procedure TbsaSkinManager.CollectToolBar(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
  
  FCurrentSubclass := TbsaToolbarSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to ToolBarSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(ToolBarSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(ToolBarSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectToolBar(AForm.Components[i]);
             FCurrentSubclass := TbsaToolBarSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;

procedure TbsaSkinManager.CollectCoolBar(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
  
  FCurrentSubclass := TbsaCoolbarSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to CoolBarSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(CoolBarSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(CoolBarSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectCoolBar(AForm.Components[i]);
             FCurrentSubclass := TbsaCoolBarSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;

procedure TbsaSkinManager.CollectProgressBar(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
  
  FCurrentSubclass := TbsaProgressbarSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to ProgressBarSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(ProgressBarSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(ProgressBarSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectProgressBar(AForm.Components[i]);
             FCurrentSubclass := TbsaProgressBarSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;

end;


procedure TbsaSkinManager.CollectTrackBar(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;
  
  FCurrentSubclass := TbsaTrackbarSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to TrackBarSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(TrackBarSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(TrackBarSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectTrackBar(AForm.Components[i]);
             FCurrentSubclass := TbsaTrackBarSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;


procedure TbsaSkinManager.CollectStatusBar(AForm: TComponent);
var
  i, j: Integer;
  C: TComponent;
  S, S2: String;
begin
  if AForm = nil then Exit;

  FCurrentSubclass := TbsaStatusbarSubclass;

  if FAdapter.AdapterType = bsaUseNames
  then
    begin
      try
       for i := 0 to StatusBarSubclassStrList.Count - 1 do
       begin
         C := MyFindComponent(AForm, LowerCase(StatusBarSubclassStrList[i]));
         if (C <> nil) and (C is TWinControl) then
         begin
           FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
           TWinControl(C).Invalidate;
         end;
       end;
       finally
         FCurrentSubclass := nil;
       end;
     end
   else
     begin
       S := lowercase(StatusBarSubclassStrList.Text);
       try
       for i := 0 to AForm.ComponentCount - 1 do
       begin
         if AForm.Components[i] is TFrame
         then
           begin
             CollectStatusBar(AForm.Components[i]);
             FCurrentSubclass := TbsaStatusBarSubclass;
             Continue;
           end;
         S2 := lowercase(AForm.Components[i].ClassName);
         if Pos(S2, S) > 0
         then
           begin
             C := AForm.Components[i];
             if (C <> nil) and (C is TWinControl) then
             begin
               FHookCollection.AddControl(TControl(C), DoControlMessage, DoUnhook);
               TWinControl(C).Invalidate;
             end;
           end;
         end;
      finally
        FCurrentSubclass := nil;
      end;
    end;
end;

procedure TbsaSkinManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent is TControl) then
  begin
    FHookCollection.RemoveControl(TControl(AComponent), True);
  end;
  inherited;
end;

procedure TbsaSkinManager.DoUnhook(Control: TControl; Handle: HWnd);
var
  i: Integer;
  SC: TbsaSubclass;
  R: TRect;
begin
  if FUnhooking then Exit;

  if FUnhookedList = nil then
  begin
    FUnhooking := True;
    Exit;
  end;

  FUnhooking := True;
  try
    for i := FHandleList.Count - 1 downto 0 do
    begin
      SC := TbsaSubclass(FHandleList[i]);

      if (Handle <> 0) and (SC.Handle = Handle) then
      begin
        R := Rect(0, 0, 2000, 2000);
        PostMessage(Handle, WM_NCPAINT, 0, 0);
        InvalidateRect(Handle, @R, False);
        FHandleList.Delete(i);
        SC.Free;
      end;

      if (Control <> nil) and (SC.Control = Control) then
      begin
        FHandleList.Delete(i);
        SC.FControl := nil;
        if not (Control is TGraphicControl) then
          SC.Free;
      end;
    end;
  finally
    FUnhooking := False;
  end;
end;

procedure TbsaSkinManager.DoControlMessage(Control: TControl; var Msg: TMessage;
  DefaultProc: TWndMethod);
var
  i: Integer;
  SC: TbsaSubclass;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    DefaultProc(Msg);
    Exit;
  end;

  if (csDestroying in Control.ComponentState) then
  begin
    DefaultProc(Msg);
    Exit;
  end;

  if (not IsSkinAvailable and (Msg.Msg <> WM_NULL)) or (FUnhooking) or (csDestroying in Control.ComponentState) then
  begin
    { Check if exists }
    SC := nil;
    for i := 0 to FHandleList.Count - 1 do
    begin
      if TbsaSubclass(FHandleList[i]).Control = Control then
      begin
        SC := TbsaSubclass(FHandleList[i]);
        SC.Unskin;
        Break;
      end;
    end;

    DefaultProc(Msg);
    Exit;
  end;

  { Check if exists }
  SC := nil;
  for i := 0 to FHandleList.Count - 1 do
  begin
    if TbsaSubclass(FHandleList[i]).Control = Control then
    begin
      SC := TbsaSubclass(FHandleList[i]);
      Break;
    end;
  end;
  { Add if not exist }
  if (SC = nil) and (SubclassList <> nil) then
  begin
    for i := 0 to SubclassList.Count - 1 do
      if SubclassList[i] = FCurrentSubclass then
      begin
        SC := TbsaSubclassClass(SubclassList[i]).Create;
        SC.FManager := Self;
        SC.Control := Control;
        SC.DefaultProc := DefaultProc;
        FHandleList.Add(SC);
        PostMessage(SC.Handle, WM_POSTACTION, 0, 0);
        Break;
      end;
  end;
  { Handle }
  if SC <> nil then
  begin
    SC.Handled := False;
    SC.Dispatch(Msg);
    if not SC.Handled then
      DefaultProc(Msg);
  end;
end;

procedure TbsaSkinManager.DoHandleMessage(Handle: HWnd; var Msg: TMessage;
  DefaultProc: TWndMethod);
var
  i: Integer;
  SC: TbsaSubclass;
begin
  if (not IsSkinAvailable) or (FUnhooking) then
  begin
    DefaultProc(Msg);
    Exit;
  end;

  { Check if exists }
  SC := nil;
  for i := 0 to FHandleList.Count - 1 do
  begin
    if TbsaSubclass(FHandleList[i]).FHandle = Handle then
    begin
      SC := TbsaSubclass(FHandleList[i]);
      Break;
    end;
  end;
  { Add if not exist }
  if (SC = nil) and (SubclassList <> nil) then
  begin
    for i := 0 to SubclassList.Count - 1 do
      if SubclassList[i] = FCurrentSubclass then
      begin
        SC := TbsaSubclassClass(SubclassList[i]).Create;
        SC.Handle := Handle;
        SC.DefaultProc := DefaultProc;
        SC.FManager := Self;
        FHandleList.Add(SC);
        PostMessage(SC.Handle, WM_POSTACTION, 0, 0);
        Break;
      end;
  end;
  { Handle }
  if SC <> nil then
  begin
    SC.Handled := False;
    SC.Dispatch(Msg);
    if not SC.Handled then
      DefaultProc(Msg);
  end;
end;

procedure TbsaSkinManager.DoHotTrackTimer(Sender: TObject);
var
  i: Integer;
  SC: TbsaSubclass;
  R: TRect;
  OldValue: Boolean;
begin
  GetCursorPos(FMousePos);
  if (FMousePos.X <> FOldMousePos.X) or (FMousePos.X <> FOldMousePos.X) then
  begin
    for i := 0 to FHandleList.Count - 1 do
    begin
      SC := TbsaSubclass(FHandleList[i]);

      if (SC.Control <> nil) and (SC.Control is TGraphicControl) and
         (SC.Control.Parent = nil) then
      begin
        Continue;
      end;

      R := SC.GetClientRect;
      if SC.Control <> nil then
      begin
        R.TopLeft := SC.Control.ClientToScreen(R.TopLeft);
        R.BottomRight := SC.Control.ClientToScreen(R.BottomRight);
      end
      else
        if SC.Handle <> 0 then
        begin
          ClientToScreen(SC.Handle, R.TopLeft);
          ClientToScreen(SC.Handle, R.BottomRight);
        end;

      OldValue := SC.BValues[SMouseInControl];
      // check mouse in control
      if SC.Control = nil
      then
        begin
          if WindowFromPoint(FMousePos) = SC.Handle
          then
            SC.BValues[SMouseInControl] := PtInRect(R, FMousePos)
           else
            SC.BValues[SMouseInControl] := False;
        end;

      if SC.Control is TWinControl
      then
        if WindowFromPoint(FMousePos) = TWinControl(SC.Control).Handle
        then
          SC.BValues[SMouseInControl] := PtInRect(R, FMousePos)
        else
          SC.BValues[SMouseInControl] := False;

      if SC.Control is TGraphicControl
      then
        if (SC.Control.Parent <> nil) and (SC.Control.Parent is TWinControl) and
           (WindowFromPoint(FMousePos) = TWinControl(SC.Control.Parent).Handle)
        then
          SC.BValues[SMouseInControl] := PtInRect(R, FMousePos)
        else
          SC.BValues[SMouseInControl] := False;
      //
      if SC.BValues[SMouseInControl] <> OldValue then
        if SC.FHotTrack then
        begin
          SC.Invalidate;
          if SC is TbsaScrollSubclass then
            TbsaScrollSubclass(SC).PaintScroll;
        end;
    end;
    FOldMousePos := FMousePos;
  end;
end;

procedure TbsaSkinManager.BeforeSkinChanged;
var
  i: Integer;
  SC: TbsaSubclass;
begin
  for i := 0 to FHandleList.Count - 1 do
  begin
    SC := TbsaSubclass(FHandleList[i]);
    SC.BeforeSkinChange;
  end;
end;

procedure TbsaSkinManager.AfterSkinChanged;
var
  i: Integer;
  SC: TbsaSubclass;
begin
  for i := 0 to FHandleList.Count - 1 do
  begin
    SC := TbsaSubclass(FHandleList[i]);
    SC.AfterSkinChange;
  end;
end;


procedure TbsaSkinManager.SkinChanged;
var
  i: Integer;
  SC: TbsaSubclass;
begin
  for i := 0 to FHandleList.Count - 1 do
  begin
    SC := TbsaSubclass(FHandleList[i]);
    SC.SkinChange;
  end;
end;

{ TbsaSubclass =================================================================}

constructor TbsaSubclass.Create;
begin
  inherited Create;
end;

destructor TbsaSubclass.Destroy;
begin
  inherited;
end;

procedure TbsaSubclass.PostAction;
begin
end;

procedure TbsaSubclass.WMUpdateUIState(var Msg: TMessage);
begin
  Msg.Result := 0;
  Handled := True;
end;

procedure TbsaSubclass.CMSENCPaint(var Message: TMessage);
begin
  Message.Result := SE_RESULT;
  Handled := True;
end;

procedure TbsaSubclass.PaintBorder(Canvas: TCanvas; R: TRect);
var
  R1, R2: TRect;
  Picture: TBitmap;
  SkinCtrl: TbsDataSkinMemoControl;
  FIndex: Integer;
  NewClRect: TRect;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  LeftB, TopB, RightB, BottomB: TBitMap;
  OffX, OffY: Integer;
  X, Y: Integer;
begin
  if FManager = nil then Exit;
  if FManager.Adapter.SkinData = nil then Exit;
  FIndex := FManager.Adapter.SkinData.GetControlIndex('memo');
  if FIndex < 0 then Exit;

  SkinCtrl := nil;

  if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinMemoControl then
  begin
    with TbsDataSkinMemoControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) do
    begin
      if (PictureIndex <> -1) and (PictureIndex < FManager.Adapter.SkinData.FActivePictures.Count) then
      Picture := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[PictureIndex]);
    end;
  end;
  if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinMemoControl then
    SkinCtrl := TbsDataSkinMemoControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]);

  if SkinCtrl = nil then Exit;

  with SkinCtrl do
  begin
    LeftB := TBitMap.Create;
    TopB := TBitMap.Create;
    RightB := TBitMap.Create;
    BottomB := TBitMap.Create;

    OffX := Self.Width - RectWidth(SkinRect);
    OffY := Self.Height - RectHeight(SkinRect);

    NewLTPoint := LTPoint;
    NewRTPoint := Point(RTPoint.X + OffX, RTPoint.Y);
    NewLBPoint := Point(LBPoint.X, LBPoint.Y + OffY);
    NewRBPoint := Point(RBPoint.X + OffX, RBPoint.Y + OffY);
    NewClRect := Rect(ClRect.Left, ClRect.Top,
                     ClRect.Right + OffX, ClRect.Bottom + OffY);

    CreateSkinBorderImages(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
      NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
        LeftB, TopB, RightB, BottomB, Picture, SkinRect, Width, Height,
          LeftStretch, TopStretch, RightStretch, BottomStretch);

    Canvas.Draw(0, 0, TopB);
    Canvas.Draw(0, TopB.Height, LeftB);
    Canvas.Draw(Width - RightB.Width, TopB.Height, RightB);
    Canvas.Draw(0, Height - BottomB.Height, BottomB);

    TopB.Free;
    LeftB.Free;
    RightB.Free;
    BottomB.Free;
  end;
end;


procedure TbsaSubclass.InvalidateFromPaint(DC: HDC);
var
  B: TBitmap;
  C, BC: TCanvas;
  PS: TPaintStruct;
  R: TRect;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    Exit;
  end;
  C := TCanvas.Create;
  try
    if DC <> 0 then
      C.Handle := DC
    else
      if FControl <> nil then
      begin
        if FControl is TWinControl then
          C.Handle := BeginPaint(TWinControl(FControl).Handle, PS)
        else
          if FControl is TGraphicControl then
            C.Handle := TbsaSubclassHackGraphicControl(FControl).Canvas.Handle;
      end
      else
        if FHandle <> 0 then
          C.Handle := BeginPaint(FHandle, PS);

    if C.Handle <> 0 then
    begin
      if FManager.IsSkinAvailable then
      begin
        if FDoubleBuffered then
        begin
          R := GetBoundsRect;

          B := TBitmap.Create;
          B.Width := RectWidth(R);
          B.Height := RectHeight(R);

          Paint(B.Canvas);

          C.Draw(0, 0, B);

          B.Free;
        end
        else
          Paint(C);
      end;
    end;
    if (FControl is TWinControl) and (C.Handle <> 0) then
    begin
      TbsaSubclassHackWinControl(FControl).PaintControls(C.Handle, nil);
    end;
  finally
    if DC = 0 then
    begin
      if FControl <> nil then
      begin
        if FControl is TWinControl then
          EndPaint(TWinControl(FControl).Handle, PS);
      end
      else
        if FHandle <> 0 then EndPaint(FHandle, PS);
    end;
    C.Handle := 0;
    C.Free;
  end;
end;


procedure TbsaSubclass.Invalidate;
var
  C: TCanvas;
  R: TRect;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    Exit;
  end;

  R := Rect(0, 0, Width, Height);

  if Handle = 0 then
  begin
    if (FControl <> nil) and (FControl is TGraphicControl) then
    begin
      TbsaSubclassHackGraphicControl(FControl).Invalidate;
    end;
  end
  else
  begin
    SendMessage(Handle, WM_NCPAINT, 0, 0);
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TbsaSubclass.CallDefaultProc(var Msg: TMessage);
begin
  if Assigned(FDefaultProc) then
    FDefaultProc(Msg);
end;

function TbsaSubclass.GetValues(index: string): string;
var
  i: Integer;
begin
  Result := '';
  
  for i := 0 to FPropCount - 1 do
    if FPropNames[i] = index then
    begin
      Result := FPropValues[i];
      Exit;
    end;
end;

procedure TbsaSubclass.SetValues(index: string; const Value: string);
var
  i: Integer;
begin
  index := index;
  for i := 0 to FPropCount - 1 do
    if FPropNames[i] = index then
    begin
      FPropValues[i] := Value;
      Exit;
    end;

  FPropNames[FPropCount] := index;
  FPropValues[FPropCount] := Value;
  Inc(FPropCount);
end;

function TbsaSubclass.GetBValues(index: string): Boolean;
var
  V: string;
begin
  V := Values[index];
  if V = 'True' then
    Result := True
  else
    Result := False;
end;

procedure TbsaSubclass.SetBValues(index: string; const Value: Boolean);
begin
  if Value then
    Values[index] := 'True'
  else
    Values[index] := 'False';
end;

function TbsaSubclass.GetBoundsRect: TRect;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;

  if FControl <> nil then
    Result := Rect(FControl.Left, FControl.Top, FControl.Left + FControl.Width, FControl.Top + FControl.Height)
  else
    if FHandle <> 0 then
      Windows.GetWindowRect(Handle, Result)
    else
      Result := Rect(0, 0, 0, 0);
end;

function TbsaSubclass.GetClientRect: TRect;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;

  if FControl <> nil then
    Result := Rect(0, 0, FControl.Width, FControl.Height)
  else
    if FHandle <> 0 then
      Windows.GetClientRect(Handle, Result)
    else
      Result := Rect(0, 0, 0, 0);
end;

function TbsaSubclass.GetBorderTopLeft: TPoint;
var
  PWnd: HWnd;
  CP, PP: TPoint;
begin
  Result := Point(0, 0);

  PWnd := GetParent(Handle);
  CP := Point(0, 0);
  ClientToScreen(Handle, CP);

  with GetBoundsRect do
    PP := Point(Left, Top);
  ClientToScreen(PWnd, PP);

  Result := Point(CP.X - PP.X, CP.Y - PP.Y);
end;

function TbsaSubclass.GetFocused: Boolean;
begin
  Result := BValues[SFocused];
end;

function TbsaSubclass.GetMouseInControl: Boolean;
begin
  Result := BValues[SMouseInControl];
end;

function TbsaSubclass.GetStringPropValue(APropName: string): WideString;
var
  PropInfo: PPropInfo;
begin
  Result := '';
  if Control = nil then Exit;
  if (APropName = 'Caption') and (Control <> nil) then
    Result := TbsaSubclassHackControl(Control).Caption;
  {$IFDEF AL_COMPILER6_UP}
  PropInfo := GetPropInfo(Control.ClassInfo, APropName);
  if PropInfo <> nil then
  begin
    Result := GetWideStrProp(Control, PropInfo);
  end;
  {$ELSE}
  PropInfo := GetPropInfo(Control.ClassInfo, APropName);
  if PropInfo <> nil then
  begin
    Result := GetStrProp(Control, PropInfo);
  end;
  {$ENDIF}
end;

function TbsaSubclass.GetText: WideString;
var
  S: array [0..500] of WideChar;
  SS: array [0..500] of Char;
begin
  if (Handle <> 0) then
  begin
    if IsWinNT then
    begin
      GetWindowTextW(Handle, @S, 500);
      Result := S;
    end
    else
    begin
      GetWindowText(Handle, @SS, 500);
      Result := SS;
    end;
  end
  else
  begin
    Result := GetStringPropValue('Caption');
  end;
end;

function TbsaSubclass.HaveBorder: Boolean;
var
  S, ExS: Cardinal;
begin
  S := GetWindowLong(Handle, GWL_STYLE);
  ExS := GetWindowLong(Handle, GWL_EXSTYLE);
  if S and WS_BORDER = WS_BORDER then
    Result := True
  else
    Result := False;
  if ExS and WS_EX_CLIENTEDGE = WS_EX_CLIENTEDGE then
    Result := True
  else
    Result := False;
end;

procedure TbsaSubclass.WMPostAction(var Msg: TMessage);
begin
  PostAction;
  Handled := True;
end;

procedure TbsaSubclass.WMStyleChanging(var Msg: TWMStyleChange);
begin
  if FIgnoreStyleChanged then
  begin
    Msg.Result := 0;
    Handled := True;
  end;
end;

procedure TbsaSubclass.WMStyleChanged(var Msg: TWMStyleChange);
begin
  if FIgnoreStyleChanged then
  begin
    Msg.Result := 0;
    Handled := True;
  end;
end;

procedure TbsaSubclass.WMEraseBkgnd(var Msg: TMessage);
var
  C: TCanvas;
begin
  if FOverridedEraseBkgnd then
  begin
    C := TCanvas.Create;
    C.Handle := Msg.wParam;
    Paint(C);
    C.Handle := 0;
    C.Free;
    Msg.Result := 1;
    Handled := True;
  end;
end;

procedure TbsaSubclass.WMPaint(var Msg: TMessage);
begin
  if FOverridedPaint then
    OveridedWMPaint(Msg);
end;

procedure TbsaSubclass.OveridedWMPaint(var Msg: TMessage);
begin
  InvalidateFromPaint(Msg.wParam);
  Handled := True;
end;

procedure TbsaSubclass.CMEnabledChanged(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  Invalidate;
  Handled := True;
end;

procedure TbsaSubclass.CMTextChanged(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  Invalidate;
  Handled := True;
end;

procedure TbsaSubclass.WMKillFocus(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  BValues[SFocused] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaSubclass.WMSetFocus(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  BValues[SFocused] := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaSubclass.SetControl(const Value: TControl);
begin
  FControl := Value;
end;

function TbsaSubclass.GetHandle: HWnd;
begin
  if FHandle <> 0 then
    Result := FHandle
  else
    if (FControl <> nil) and (FControl is TWinControl) then
      Result := TWinControl(FControl).Handle
    else
      Result := 0;
end;

procedure TbsaSubclass.SetHandle(const Value: HWnd);
begin
  FHandle := Value;
end;

function TbsaSubclass.DrawTextBiDiModeFlags(Flags: Integer): LongInt;
begin
  if FControl <> nil then
    Result := FControl.DrawTextBiDiModeFlags(Flags)
  else
    Result := Flags;
end;

procedure TbsaSubclass.Unskin;
begin
  
end;

procedure TbsaSubclass.BeforeSkinChange;
begin
end;

procedure TbsaSubclass.AfterSkinChange; 
begin

end;

procedure TbsaSubclass.SkinChange;
begin
  Invalidate;
end;

function TbsaSubclass.GetHeight: Integer;
var
  R: TRect;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    Result := 0;
    Exit;
  end;

  if FControl <> nil then
    Result := FControl.Height
  else
    if FHandle <> 0 then
    begin
      Windows.GetClientRect(Handle, R);
      Result := R.Bottom;
    end
    else
      Result := 0;
end;

function TbsaSubclass.GetWidth: Integer;
var
  R: TRect;
begin
  if (Control <> nil) and (Control is TGraphicControl) and
     (Control.Parent = nil) then
  begin
    Result := 0;
    Exit;
  end;

  if FControl <> nil then
    Result := FControl.Width
  else
    if FHandle <> 0 then
    begin
      Windows.GetClientRect(Handle, R);
      Result := R.Right;
    end
    else
      Result := 0;
end;

function TbsaSubclass.GetEnabled: Boolean;
begin
  if FControl <> nil then
    Result := FControl.Enabled
  else
    Result := True;
end;

{ TbsaWinScroll ================================================================}

type

  TbsaWinScroll = class(TCustomControl)
  public
    FSubclass: TbsaScrollSubclass;
    FVertical: Boolean;
  private
  protected
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
  end;

function TbsaSkinManager.IsSkinAvailable: Boolean;
begin
  Result := (Adapter.SkinData <> nil) and (not Adapter.SkinData.Empty);
end;

{ TbsaWinScroll }

procedure TbsaWinScroll.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  Msg.Result := HTTRANSPARENT;
end;

procedure TbsaWinScroll.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CHILDWINDOW or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
  Params.ExStyle := Params.ExStyle or WS_EX_NOPARENTNOTIFY;
  Params.WindowClass.style := Params.WindowClass.style;
end;

procedure TbsaWinScroll.Paint;
begin
  if Width * Height = 0 then Exit;
  if FSubclass <> nil then
  begin
    if FVertical then
    begin
      with FSubclass.VScrollRect do
        MoveWindowOrg(Canvas.Handle, -Left, -Top);
      FSubclass.VDrawScroll(Canvas.Handle);
      with FSubclass.VScrollRect do
        MoveWindowOrg(Canvas.Handle, Left, Top);
    end
    else
    begin
      with FSubclass.HScrollRect do
        MoveWindowOrg(Canvas.Handle, -Left, -Top);
      FSubclass.HDrawScroll(Canvas.Handle);
      with FSubclass.HScrollRect do
        MoveWindowOrg(Canvas.Handle, Left, Top);
    end;
  end;
end;

procedure TbsaWinScroll.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

{ TbsaScrollSubclass ===========================================================}

constructor TbsaScrollSubclass.Create;
begin
  inherited;
end;

procedure TbsaScrollSubclass.EMLINEINDEX(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  PaintScroll;
end;

destructor TbsaScrollSubclass.Destroy;
begin
  inherited;
  if VScrollWnd <> nil then
  begin
    TbsaWinScroll(VScrollWnd).FSubclass := nil;
    FreeAndNil(VScrollWnd);
  end;
  if HScrollWnd <> nil then
  begin
    TbsaWinScroll(HScrollWnd).FSubclass := nil;
    FreeAndNil(HScrollWnd);
  end;
end;



function TbsaScrollSubclass.HScrollDisabled: Boolean;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  if (FManager <> nil) and (not FManager.IsSkinAvailable) then
  begin
    Result := False;
    Exit;
  end;
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_HSCROLL, BarInfo);
  if STATE_SYSTEM_UNAVAILABLE and BarInfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE then
    Result := True
  else
    Result := False;
end;

function TbsaScrollSubclass.VScrollDisabled: Boolean;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  if (FManager <> nil) and (not FManager.IsSkinAvailable) then
  begin
    Result := False;
    Exit;
  end;
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_VSCROLL, BarInfo);
  if STATE_SYSTEM_UNAVAILABLE and BarInfo.rgstate[0] = STATE_SYSTEM_UNAVAILABLE then
    Result := True
  else
    Result := False;
end;

function TbsaScrollSubclass.VScrollRect: TRect;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  if (FManager <> nil) and (not FManager.IsSkinAvailable) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_VSCROLL, BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] <> 0 then
    Result := Rect(0, 0, 0, 0)
  else
  begin
    P := BarInfo.rcScrollBar.TopLeft;
    Windows.ScreenToClient(Handle, P);
    Result.TopLeft := P;
    P := BarInfo.rcScrollBar.BottomRight;
    Windows.ScreenToClient(Handle, P);
    Result.BottomRight := P;
    with GetBorderTopLeft do
      OffsetRect(Result, X, Y);
  end;
end;

function TbsaScrollSubclass.VSliderRect: TRect;
var
  Offset: Integer;
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_VSCROLL, BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] <> 0 then
    Result := Rect(0, 0, 0, 0)
  else
  begin
    P := BarInfo.rcScrollBar.TopLeft;
    Windows.ScreenToClient(Handle, P);
    Result.TopLeft := P;
    P := BarInfo.rcScrollBar.BottomRight;
    Windows.ScreenToClient(Handle, P);
    Result.BottomRight := P;

    with GetBorderTopLeft do
      OffsetRect(Result, X, Y);

    Offset := Result.Top;
    Result.Top := Offset + BarInfo.xyThumbTop - 1;
    Result.Bottom := Offset + BarInfo.xyThumbBottom - 1;
  end;
end;

function TbsaScrollSubclass.VTrackRect: TRect;
begin
  Result := VScrollRect;
  if RectWidth(Result) > 0 then
  begin
    Result.Top := Result.Top + RectWidth(Result);
    Result.Bottom := Result.Bottom - RectWidth(Result);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TbsaScrollSubclass.VUpButtonRect: TRect;
begin
  Result := VScrollRect;
  if RectWidth(Result) > 0 then
  begin
    Result.Bottom := Result.Top + RectWidth(Result);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TbsaScrollSubclass.VDownButtonRect: TRect;
begin
  Result := VScrollRect;
  if RectWidth(Result) > 0 then
  begin
    Result.Top := Result.Bottom - RectWidth(Result);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TbsaScrollSubclass.HScrollRect: TRect;
var
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  if (FManager <> nil) and (not FManager.IsSkinAvailable) then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;

  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_HSCROLL, BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] <> 0 then
    Result := Rect(0, 0, 0, 0)
  else
  begin
    P := BarInfo.rcScrollBar.TopLeft;
    Windows.ScreenToClient(Handle, P);
    Result.TopLeft := P;
    P := BarInfo.rcScrollBar.BottomRight;
    Windows.ScreenToClient(Handle, P);
    Result.BottomRight := P;
    with GetBorderTopLeft do
      OffsetRect(Result, X, Y);
  end;
end;

function TbsaScrollSubclass.HSliderRect: TRect;
var
  Offset: Integer;
  P: TPoint;
  BarInfo: TScrollBarInfo;
begin
  BarInfo.cbSize := SizeOf(BarInfo);
  MyGetScrollBarInfo(Handle, OBJID_HSCROLL, BarInfo);
  if STATE_SYSTEM_INVISIBLE and BarInfo.rgstate[0] <> 0 then
    Result := Rect(0, 0, 0, 0)
  else
  begin
    P := BarInfo.rcScrollBar.TopLeft;
    Windows.ScreenToClient(Handle, P);
    Result.TopLeft := P;
    P := BarInfo.rcScrollBar.BottomRight;
    Windows.ScreenToClient(Handle, P);
    Result.BottomRight := P;

    with GetBorderTopLeft do
      OffsetRect(Result, X, Y);

    Offset := Result.Left;
    Result.Left := Offset + BarInfo.xyThumbTop - 1;
    Result.Right := Offset + BarInfo.xyThumbBottom - 1;
  end;
end;

function TbsaScrollSubclass.HTrackRect: TRect;
begin
  Result := HScrollRect;
  if RectWidth(Result) > 0 then
  begin
    Result.Left := Result.Left + RectHeight(Result);
    Result.Right := Result.Right - RectHeight(Result);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TbsaScrollSubclass.HUpButtonRect: TRect;
begin
  Result := HScrollRect;
  if RectHeight(Result) > 0 then
  begin
    Result.Right := Result.Left + RectHeight(Result);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

function TbsaScrollSubclass.HDownButtonRect: TRect;
begin
  Result := HScrollRect;
  if RectHeight(Result) > 0 then
  begin
    Result.Left := Result.Right - RectHeight(Result);
  end
  else
    Result := Rect(0, 0, 0, 0);
end;

const
  BUTCOUNT = 3;
  THUMB = 0;
  UPBUTTON = 1;
  DOWNBUTTON = 2;
  TRACK = 3;
  CLIENT = 4;
  SBUTTONW = 16;

procedure TbsaScrollSubclass.DrawButton;
var
  R1, R2: TRect;
  C: TColor;
  ThumbB: TBitMap;
  B1: TBitMap;
  EB1, EB2: TbsEffectBmp;
  kf: Double;
  FPageSize: Integer;
  Picture: TBitmap;
  FIndex: Integer;
  SkinCtrl: TbsDataSkinScrollBarControl;
  TrackR, R: TRect;
  B: TBitmap;
  x, ResizeMode: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewClRect: TRect;
  MinW, MinH: Integer;
  GlyphB: TBitMap;
begin
  if FManager = nil then Exit;

  FIndex := -1;
  if FManager.Adapter.SkinData <> nil then
  begin
    if FKind = sbVertical then
      FIndex := FManager.Adapter.SkinData.GetControlIndex(FManager.Adapter.VScrollSkinDataName)
    else
      FIndex := FManager.Adapter.SkinData.GetControlIndex(FManager.Adapter.HScrollSkinDataName);
  end;

  if FIndex < 0 then
  begin
    { Std drawing }
    if I = THUMB then
    begin
      if FKind = sbVertical then
      begin
        R := VSliderRect;
        OffsetRect(R, 0, 1);
        with Cnvs do
        begin
          if (VSliderState = bsasbPressed) and (MouseInControl) then
          begin
            Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
            Brush.Color := BS_BTNDOWNCOLOR;
            FillRect(R);
          end
          else
          if (VSliderState = bsasbHot) and MouseInControl then
          begin
            Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
            Brush.Color := BS_BTNACTIVECOLOR;
            FillRect(R);
          end
          else
          begin
            Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
            Brush.Color := clBtnFace;
            FillRect(R);
          end;
        end;
      end
      else
      begin
        R := HSliderRect;
        OffsetRect(R, 1, 0);
        with Cnvs do
        begin
          if (HSliderState = bsasbPressed) and (MouseInControl) then
          begin
            Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
            Brush.Color := BS_BTNDOWNCOLOR;
            FillRect(R);
          end
          else
          if (HSliderState = bsasbHot) and MouseInControl then
          begin
            Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
            Brush.Color := BS_BTNACTIVECOLOR;
            FillRect(R);
          end
          else
          begin
            Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
            Brush.Color := clBtnFace;
            FillRect(R);
          end;
        end;
      end;
    end
    else
    with Cnvs do
    begin
      R1 := NullRect;
      if FKind = sbVertical then
      begin
        case I of
          UPBUTTON:
            begin
              R := VDownButtonRect;
              if (VUpState = bsasbPressed) and MouseInControl then
              begin
                Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                Brush.Color := BS_BTNDOWNCOLOR;
                FillRect(R);
              end
              else
                if (VUpState = bsasbHot) and MouseInControl then
                begin
                  Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                  Brush.Color := BS_BTNACTIVECOLOR;
                  FillRect(R);
                end
                else
                begin
                  Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
                  Brush.Color := clBtnFace;
                  FillRect(R);
                end;
             DrawArrowImage(Cnvs, R, clBlack, 4);
            end;
          DOWNBUTTON:
            begin
              R := VUpButtonRect;
              if (VDownState = bsasbPressed) and MouseInControl then
              begin
                Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                Brush.Color := BS_BTNDOWNCOLOR;
                FillRect(R);
              end
              else
                if (VDownState = bsasbHot) and MouseInControl then
                begin
                  Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                  Brush.Color := BS_BTNACTIVECOLOR;
                  FillRect(R);
                end
                else
                begin
                  Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
                  Brush.Color := clBtnFace;
                  FillRect(R);
                end;
             DrawArrowImage(Cnvs, R, clBlack, 3);
            end
        end;
      end
      else
      begin
        case I of
          UPBUTTON:
            begin
              R := HDownButtonRect;
              if (HUpState = bsasbPressed) and MouseInControl then
              begin
                Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                Brush.Color := BS_BTNDOWNCOLOR;
                FillRect(R);
              end
              else
                if (HUpState = bsasbHot) and MouseInControl then
                begin
                  Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                  Brush.Color := BS_BTNACTIVECOLOR;
                  FillRect(R);
                end
                else
                begin
                  Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
                  Brush.Color := clBtnFace;
                  FillRect(R);
                end;
             DrawArrowImage(Cnvs, R, clBlack, 2);
            end;
          DOWNBUTTON:
            begin
              R := HUpButtonRect;
              if (HDownState = bsasbPressed) and MouseInControl then
              begin
                Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                Brush.Color := BS_BTNDOWNCOLOR;
                FillRect(R);
              end
              else
                if (HDownState = bsasbHot) and MouseInControl then
                begin
                  Frame3D(Cnvs, R, BS_BTNFRAMECOLOR, BS_BTNFRAMECOLOR, 1);
                  Brush.Color := BS_BTNACTIVECOLOR;
                  FillRect(R);
                end
                else
                begin
                  Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
                  Brush.Color := clBtnFace;
                  FillRect(R);
                end;
             DrawArrowImage(Cnvs, R, clBlack, 1);
            end
        end;
      end;
      if not IsNullRect(R1) then
        BitBlt(Cnvs.Handle, R.Left, R.Top, RectWidth(R1), RectHeight(R1), Picture.Canvas.Handle,
          R1.Left, R1.Top, SRCCOPY);
    end;

    Exit;
  end;

  FPageSize := 20;
  SkinCtrl := nil;

  if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl then
  begin
    with TbsDataSkinCustomControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) do
    begin
      if (PictureIndex <> -1) and (PictureIndex < FManager.Adapter.SkinData.FActivePictures.Count) then
        Picture := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[PictureIndex]);
    end;
  end;
  if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl then
    SkinCtrl := TbsDataSkinScrollBarControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]);

   { Offset }
  if FKind = sbVertical then
  begin
    R := VTrackRect;
    if RectWidth(SkinCtrl.SkinRect) < RectWidth(R) then
      MoveWindowOrg(Cnvs.Handle, RectWidth(R) - RectWidth(SkinCtrl.SkinRect), 0);
  end
  else
  begin
    R := HTrackRect;
    if RectHeight(SkinCtrl.SkinRect) < RectHeight(R) then
      MoveWindowOrg(Cnvs.Handle, 0, RectHeight(R) - RectHeight(SkinCtrl.SkinRect));
  end;

  if I = CLIENT then
  begin
    if FKind = sbVertical then
      R := VScrollRect
    else
      R := HScrollRect;

    with SkinCtrl do
    begin
      if IsNullRect(SkinRect)
      then
        ResizeMode := -1
      else
      if (RBPoint.X <> 0) and (RBPoint.Y <> 0)
      then
        ResizeMode := 1
      else
      if (RTPoint.X <> 0) or (RTPoint.Y <> 0)
      then
        ResizeMode := 2
      else
      if (LBPoint.X <> 0) or (LBPoint.Y <> 0)
      then
        ResizeMode := 3
      else
        ResizeMode := 0;

      if RectWidth(R) * RectHEight(R) > 0 then
      begin
        B := TBitmap.Create;
        B.Width := RectWidth(R);
        B.Height := RectHeight(R);
        R1 := SkinRect;
        case ResizeMode of
          0:
           begin
              B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Picture.Canvas, R1);
           end;
          1: CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
               NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
               B, Picture, R1, B.Width, B.Height, True,
               LeftStretch, TopStretch, RightStretch, BottomStretch,
               StretchEffect, StretchType);

          2: CreateHSkinImage(LTPoint.X, RectWidth(SkinRect) - RTPoint.X,
               B, Picture, R1, B.Width, B.Height, StretchEffect);
          3: CreateVSkinImage(LTPoint.Y, RectHeight(SkinRect) - LBPoint.Y,
                B, Picture, R1, B.Width, B.Height, StretchEffect);
        end;
        Cnvs.Draw(R.Left, R.Top, B);
        B.Free;
      end;  
    end;
  end;

  if I = THUMB then
  begin
    if FKind = sbVertical then
    begin
      if RectHeight(VTrackRect) = 0 then Exit;

      R := VSliderRect;
      if (VSliderState = bsasbPressed) and (not IsNullRect(SkinCtrl.DownThumbRect)) then
        R1 := SkinCtrl.DownThumbRect
      else
        if (VSliderState = bsasbHot) and MouseInControl  and (not IsNullRect(SkinCtrl.ActiveThumbRect)) then
          R1 := SkinCtrl.ActiveThumbRect
        else
          R1 := SkinCtrl.ThumbRect;

      TrackR := SkinCtrl.TrackArea;
      TrackR.Bottom := RectHeight(VScrollRect) - (RectHeight(SkinCtrl.SkinRect) - SkinCtrl.TrackArea.Bottom);
      OffsetRect(TrackR, VScrollRect.Left, VScrollRect.Top);

      R.Left := R.Left + SkinCtrl.TrackArea.Left + ((RectWidth(SkinCtrl.TrackArea) - RectWidth(SkinCtrl.ThumbRect)) div 2);
      R.Top := TrackR.Top + Round(((R.Top - VTrackRect.Top) / RectHeight(VTrackRect)) * RectHeight(TrackR)) + 1;
      R.Bottom := TrackR.Top + Round(((R.Bottom - VTrackRect.Top) / RectHeight(VTrackRect)) * RectHeight(TrackR)) + 1;

      MinH := RectHeight(SkinCtrl.ThumbRect);
      If SkinCtrl.ThumbMinSize > 0 then MinH := SkinCtrl.ThumbMinSize;

      if RectHeight(R) < MinH then
      begin
        X := ((R.Top + R.Bottom) div 2);
        R.Top := X - (MinH div 2);
        R.Bottom := X + (MinH div 2);
        if R.Bottom > VScrollRect.Bottom - (MinH - SkinCtrl.TrackArea.Bottom) then
        begin
          R.Bottom := VScrollRect.Bottom - (MinH - SkinCtrl.TrackArea.Bottom);
          R.Top := R.Bottom - MinH;
        end;
        if R.Top < VScrollRect.Top + SkinCtrl.TrackArea.Top then
        begin
          R.Top := VScrollRect.Top + SkinCtrl.TrackArea.Top;
          R.Bottom := R.Top + MinH;
        end;
      end;
    end
    else
    begin
      R := HSliderRect;
      if RectWidth(HTrackRect) = 0 then Exit;
      
      if (HSliderState = bsasbPressed) and (not IsNullRect(SkinCtrl.DownThumbRect)) then
        R1 := SkinCtrl.DownThumbRect
      else
        if (HSliderState = bsasbHot) and MouseInControl  and (not IsNullRect(SkinCtrl.ActiveThumbRect)) then
          R1 := SkinCtrl.ActiveThumbRect
        else
          R1 := SkinCtrl.ThumbRect;

      TrackR := SkinCtrl.TrackArea;
      TrackR.Right := RectWidth(HScrollRect) - (RectWidth(SkinCtrl.SkinRect) - SkinCtrl.TrackArea.Right);
      OffsetRect(TrackR, HScrollRect.Left, HScrollRect.Top);

      R.Top := R.Top + SkinCtrl.TrackArea.Top + ((RectHeight(SkinCtrl.TrackArea) - RectHeight(SkinCtrl.ThumbRect)) div 2);
      R.Left := TrackR.Left + Round(((R.Left - HTrackRect.Left) / RectWidth(HTrackRect)) * RectWidth(TrackR)) + 1;
      R.Right := TrackR.Left + Round(((R.Right - HTrackRect.Left) / RectWidth(HTrackRect)) * RectWidth(TrackR)) + 1;

      MinW := RectWidth(SkinCtrl.ThumbRect);
      If SkinCtrl.ThumbMinSize > 0 then MinW := SkinCtrl.ThumbMinSize;

      if RectWidth(R) < MinW then
      begin
        X := ((R.Left + R.Right) div 2);
        R.Left := X - (MinW div 2);
        R.Right := X + (MinW div 2);
        if R.Right > HScrollRect.Right - (MinW - SkinCtrl.TrackArea.Right) then
        begin
          R.Right := HScrollRect.Right - (MinW - SkinCtrl.TrackArea.Right);
          R.Left := R.Right - MinW;
        end;
        if R.Left < HScrollRect.Left + SkinCtrl.TrackArea.Left then
        begin
          R.Left := HScrollRect.Left + SkinCtrl.TrackArea.Left;
          R.Right := R.Left + MinW;
        end;
      end;
    end;

    if RectHeight(R) * RectWidth(R) > 0 then
    begin
      ThumbB := TBitMap.Create;
      ThumbB.Width := RectWidth(R);
      ThumbB.Height := RectHeight(R);
      if FPageSize = 0 then
        ThumbB.Canvas.CopyRect(Rect(0, 0, ThumbB.Width, ThumbB.Height), Picture.Canvas, R1)
      else
        case FKind of
          sbHorizontal:
            CreateHSkinImage(SkinCtrl.ThumbOffset1, SkinCtrl.ThumbOffset2, ThumbB, Picture, R1,
             ThumbB.Width, ThumbB.Height, SkinCtrl.ThumbStretchEffect);
          sbVertical:
            CreateVSkinImage(SkinCtrl.ThumbOffset1, SkinCtrl.ThumbOffset2, ThumbB, Picture, R1,
              ThumbB.Width, ThumbB.Height, SkinCtrl.ThumbStretchEffect);
        end;

       // draw glyph
       if FKind = sbVertical then
       begin
          if (VSliderState = bsasbPressed) and MouseInControl and (not IsNullRect(SkinCtrl.DownGlyphRect)) then
            R1 := SkinCtrl.DownGlyphRect
          else
            if (VSliderState = bsasbHot) and MouseInControl and (not IsNullRect(SkinCtrl.ActiveGlyphRect)) then
              R1 := SkinCtrl.ActiveGlyphRect
            else
              R1 := SkinCtrl.GlyphRect;
        end
        else
        begin
          if (HSliderState = bsasbPressed) and MouseInControl and (not IsNullRect(SkinCtrl.DownGlyphRect)) then
            R1 := SkinCtrl.DownGlyphRect
          else
            if (HSliderState = bsasbHot) and MouseInControl and (not IsNullRect(SkinCtrl.ActiveGlyphRect)) then
             R1 := SkinCtrl.ActiveGlyphRect
           else
             R1 := SkinCtrl.GlyphRect;
        end;
        if not IsNullRect(R1) then
        begin
          R2 := Rect(ThumbB.Width div 2 - RectWidth(R1) div 2,
                   ThumbB.Height div 2 - RectHeight(R1) div 2,
                   ThumbB.Width div 2 - RectWidth(R1) div 2 + RectWidth(R1),
                   ThumbB.Height div 2 - RectHeight(R1) div 2 + RectHeight(R1));
         if SkinCtrl.GlyphTransparent
         then
          begin
            GlyphB := TBitMap.Create;
            GlyphB.Width := RectWidth(R1);
            GlyphB.Height := RectHeight(R1);
            GlyphB.Canvas.CopyRect(Rect(0, 0, GlyphB.Width, GlyphB.Height),
             Picture.Canvas, R1);
            GlyphB.Transparent := True;
            GlyphB.TransparentMode := tmFixed;
            GlyphB.TransparentColor := SkinCtrl.GlyphTransparentColor;
            ThumbB.Canvas.Draw(R2.Left, R2.Top, GlyphB);
            GlyphB.Free;
          end
        else
          ThumbB.Canvas.CopyRect(R2, Picture.Canvas, R1);
      end;
      //

      if SkinCtrl.ThumbTransparent
      then
       begin
         ThumbB.Transparent := True;
         ThumbB.TransparentMode := tmFixed;
         ThumbB.TransparentColor := SkinCtrl.ThumbTransparentColor;
       end;

      Cnvs.Draw(R.Left, R.Top, ThumbB);
      ThumbB.Free;
    end;
  end
  else
  begin
    R1 := NullRect;
    if FKind = sbVertical then
    begin
      case I of
        UPBUTTON:
          begin
            if (VUpState = bsasbPressed) and MouseInControl then
            begin
              R1 := SkinCtrl.DownUpButtonRect;
              if IsNullRect(R1) then R1 := SkinCtrl.ActiveUpButtonRect;
            end
            else
              if (VUpState = bsasbHot) and MouseInControl and (not IsNullRect(SkinCtrl.ActiveUpButtonRect)) then
                R1 := SkinCtrl.ActiveUpButtonRect
              else
              begin
                R1 := SkinCtrl.UpButtonRect;
                OffsetRect(R1, SkinCtrl.SkinRect.Left, SkinCtrl.SkinRect.Top);
              end;

            R := VDownButtonRect;
            OffsetRect(R, SkinCtrl.UpButtonRect.Left, RectHeight(R) - (RectHeight(SkinCtrl.SkinRect) - SkinCtrl.UpButtonRect.Top));
          end;
        DOWNBUTTON:
          begin
            if (VDownState = bsasbPressed) and MouseInControl then
            begin
              R1 := SkinCtrl.DownDownButtonRect;
              if IsNullRect(R1) then R1 := SkinCtrl.ActiveDownButtonRect
            end
            else
              if (VDownState = bsasbHot) and MouseInControl and (not IsNullRect(SkinCtrl.ActiveUpButtonRect)) then
                R1 := SkinCtrl.ActiveDownButtonRect
              else
              begin
                R1 := SkinCtrl.DownButtonRect;
                OffsetRect(R1, SkinCtrl.SkinRect.Left, SkinCtrl.SkinRect.Top);
              end;

            R := VUpButtonRect;
            OffsetRect(R, SkinCtrl.DownButtonRect.Left, SkinCtrl.DownButtonRect.Top);
          end
      end;
    end
    else
    begin
      case I of
        UPBUTTON:
          begin
            if (HUpState = bsasbPressed) and MouseInControl then
             begin
               R1 := SkinCtrl.DownUpButtonRect;
               if IsNullRect(R1) then R1 := SkinCtrl.ActiveUpButtonRect;
             end
            else
              if (HUpState = bsasbHot) and MouseInControl and (not IsNullRect(SkinCtrl.ActiveUpButtonRect)) then
                R1 := SkinCtrl.ActiveUpButtonRect
              else
              begin
                R1 := SkinCtrl.UpButtonRect;
                OffsetRect(R1, SkinCtrl.SkinRect.Left, SkinCtrl.SkinRect.Top);
              end;

            R := HDownButtonRect;
            OffsetRect(R, RectWidth(R) - (RectWidth(SkinCtrl.SkinRect) - SkinCtrl.UpButtonRect.Left), SkinCtrl.UpButtonRect.Top);
          end;
        DOWNBUTTON:
          begin
            if (HDownState = bsasbPressed) and MouseInControl then
            begin
              R1 := SkinCtrl.DownDownButtonRect;
              if IsNullRect(R1) then R1 := SkinCtrl.ActiveDownButtonRect;
            end
            else
              if (HDownState = bsasbHot) and MouseInControl and (not IsNullRect(SkinCtrl.ActiveUpButtonRect)) then
                R1 := SkinCtrl.ActiveDownButtonRect
              else
              begin
                R1 := SkinCtrl.DownButtonRect;
                OffsetRect(R1, SkinCtrl.SkinRect.Left, SkinCtrl.SkinRect.Top);
              end;

            R := HUpButtonRect;
            OffsetRect(R, SkinCtrl.DownButtonRect.Left, SkinCtrl.DownButtonRect.Top);
          end
      end;
    end;
    if not IsNullRect(R1) then
      BitBlt(Cnvs.Handle, R.Left, R.Top, RectWidth(R1), RectHeight(R1), Picture.Canvas.Handle,
        R1.Left, R1.Top, SRCCOPY);
  end;

  { Restore Offset }
  if FKind = sbVertical then
  begin
    R := VTrackRect;
    if RectWidth(SkinCtrl.SkinRect) < RectWidth(R) then
      MoveWindowOrg(Cnvs.Handle, - (RectWidth(R) - RectWidth(SkinCtrl.SkinRect)), 0);
  end
  else
  begin
    R := HTrackRect;
    if RectHeight(SkinCtrl.SkinRect) < RectHeight(R) then
      MoveWindowOrg(Cnvs.Handle, 0, - (RectHeight(R) - RectHeight(SkinCtrl.SkinRect)));
  end;
end;

procedure TbsaScrollSubclass.VDrawScroll(DC: HDC = 0);
var
  R: TRect;
  Canvas: TCanvas;
  P: TPoint;
  i: Integer;
  X, Y: Integer;
begin
  if Handle = 0 then Exit;
  if DC = 0 then Exit;

  Canvas := TCanvas.Create;
  if DC <> 0 then
    Canvas.Handle := DC;

  if (FManager = nil) or (FManager.Adapter.SkinData = nil) then
  begin
    { Std drawing }
    if RectWidth(VScrollRect) > 0 then
    begin
      R := VScrollRect;
      with Canvas do
      begin
        Brush.Color := clBtnFace;
        FillRect(R);
      end;
      Frame3D(Canvas, R, clBtnFace, clBtnFace, 1);

      FKind := sbVertical;
      for i := 1 to BUTCOUNT - 1 do
        DrawButton(Canvas, i);
      if not VScrollDisabled then
        DrawButton(Canvas, THUMB);
    end;
  end
  else
  begin
    { Fill back }
    with FManager.Adapter.SkinData do
    begin
      Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
    { Draw Vscroll }
    if RectWidth(VScrollRect) > 0 then
    begin
      FKind := sbVertical;
      DrawButton(Canvas, CLIENT);
      for i := 1 to BUTCOUNT - 1 do
        DrawButton(Canvas, i);
      if not VScrollDisabled then
        DrawButton(Canvas, THUMB);
    end;
  end;

  Canvas.Handle := 0;
  Canvas.Free;
end;

procedure TbsaScrollSubclass.HDrawScroll(DC: HDC = 0);
var
  R: TRect;
  Canvas: TCanvas;
  P: TPoint;
  i: Integer;
  X, Y: Integer;
begin
  if Handle = 0 then Exit;
  if DC = 0 then Exit;

  Canvas := TCanvas.Create;
  Canvas.Handle := DC;

  if (FManager = nil) or (FManager.Adapter.SkinData = nil) then 
  begin
    { Std drawing }
    if RectWidth(HScrollRect) > 0 then
    begin
      R := HScrollRect;
      with Canvas do
      begin
        Brush.Color := clBtnFace;
        FillRect(R);
      end;
      Frame3D(Canvas, R, clBtnFace, clBtnFace, 1);

      FKind := sbHorizontal;
      for i := 1 to BUTCOUNT - 1 do
        DrawButton(Canvas, i);
      if not HScrollDisabled then
        DrawButton(Canvas, THUMB);
    end;
  end
  else
  begin
    { Fill back }
    with FManager.Adapter.SkinData do
    begin
      Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
      Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
    { Draw Hscroll }
    if RectHeight(HScrollRect) > 0 then
    begin
      FKind := sbHorizontal;
      DrawButton(Canvas, CLIENT);
      for i := 1 to BUTCOUNT - 1 do
        DrawButton(Canvas, i);
      if not HScrollDisabled then
        DrawButton(Canvas, THUMB);
    end;
  end;

  Canvas.Handle := 0;
  Canvas.Free;
end;

procedure TbsaScrollSubclass.DrawBorder;
var
  R: TRect;
  Canvas: TCanvas;
  P: TPoint;
begin
  if Handle = 0 then Exit;

  Canvas := TCanvas.Create;
  if not AUseExternalDC
  then Canvas.Handle := GetWindowDC(Handle)
  else Canvas.Handle := ADC;

  P := Point(0, 0);
  Windows.ClientToScreen(Handle, P);
  Windows.GetWindowRect(Handle, R);
  P.X := P.X - R.Left;
  P.Y := P.Y - R.Top;

  Windows.GetClientRect(Handle, R);
  ExcludeClipRect(Canvas.Handle, P.X, P.Y, R.Right - R.Left + P.X, R.Bottom - R.Top + P.Y);

  Windows.GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);

  PaintBorder(Canvas, R);

  SelectClipRgn(Canvas.Handle, 0);
  if not AUseExternalDC then ReleaseDC(Handle, Canvas.Handle);

  Canvas.Handle := 0;
  Canvas.Free;
end;

procedure TbsaScrollSubclass.UpdateScroll;
begin
  { Paint scrollbars }
  if (VScrollWnd <> nil) and (VScrollWnd.HandleAllocated) then
  begin
    with VScrollRect do
     if IsPopupWindow
     then
       SetWindowPos(VScrollWnd.Handle, HWND_TOPMOST,
         Control.Left + Left, Control.Top + Top,
           Right - Left, Bottom - Top, SWP_SHOWWINDOW)
     else
       SetWindowPos(VScrollWnd.Handle, HWND_TOP,
         Control.Left + Left, Control.Top + Top,
           Right - Left, Bottom - Top, SWP_SHOWWINDOW);
  end;
  if (HScrollWnd <> nil)  and (HScrollWnd.HandleAllocated) then
  begin
    with HScrollRect do
      if IsPopupWindow
      then
        SetWindowPos(HScrollWnd.Handle, HWND_TOPMOST,
          Control.Left + Left, Control.Top + Top,
            Right - Left, Bottom - Top, SWP_SHOWWINDOW)
      else
        SetWindowPos(HScrollWnd.Handle, HWND_TOP,
          Control.Left + Left, Control.Top + Top,
            Right - Left, Bottom - Top, SWP_SHOWWINDOW);
  end;
  PaintScroll;
end;

procedure TbsaScrollSubclass.PaintScroll;
begin
  { Paint scrollbars }
  if VScrollWnd <> nil then
  begin
    VScrollWnd.Invalidate;
  end;
  if HScrollWnd <> nil then
  begin
    HScrollWnd.Invalidate;
  end;
end;

function TbsaScrollSubclass.IsPopupWindow: Boolean;
begin
  Result := (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_TOOLWINDOW = WS_EX_TOOLWINDOW) or
            (GetWindowLong(Handle, GWL_STYLE) and WS_POPUP = WS_POPUP);
end;

procedure TbsaScrollSubclass.WMHScroll(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMVTChangeState(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMVScroll(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMMouseWheel(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  inherited;
  if (Self.Control.ClassName = 'TRichView') or
     (Self.Control.ClassName = 'TRichViewEdit') 
  then
    PaintScroll;
end;

procedure TbsaScrollSubclass.WMNCLButtonDblClk(var Msg: TWMMouse);
begin
  WMNCLButtonDown(Msg);
end;

procedure TbsaScrollSubclass.WMNCLButtonDown(var Msg: TWMMouse);
var
  P: TPoint;
  SF: TScrollInfo;
  VEnabled, HEnabled: Boolean;
begin
  P := Point(Msg.XPos, Msg.YPos);
  ScreenToClient(Handle, P);
  with GetBorderTopLeft do
  begin
    P.X := P.X + X;
    P.Y := P.Y + Y;
  end;

  VEnabled := not VScrollDisabled;
  HEnabled := not HScrollDisabled;

  if PtInRect(VSliderRect, P) then
  begin
    BValues['lbtndown'] := True;
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_VERT, SF);
    FCurPos := SF.nPos;
    FOldPos := Mouse.CursorPos.Y;
    VSliderState := bsasbPressed;
    Handled := True;
    PaintScroll;
    SetCapture(Handle);
    Exit;
  end;

  if PtInRect(HSliderRect, P) then
  begin
    BValues['lbtndown'] := True;
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_HORZ, SF);
    FCurPos := SF.nPos;
    FOldPos := Mouse.CursorPos.X;
    HSliderState := bsasbPressed;
    PaintScroll;
    SetCapture(Handle);
    Handled := True;
    Exit;
  end;

  if PtInRect(VDownButtonRect, P) and VEnabled  then
  begin
    VUpState := bsasbPressed;
  end;

  if PtInRect(VUpButtonRect, P) and VEnabled  then
  begin
    VDownState := bsasbPressed;
  end;

  if PtInRect(HDownButtonRect, P) and HEnabled then
  begin
    HUpState := bsasbPressed;
  end;

  if PtInRect(HUpButtonRect, P) and HEnabled  then
  begin
    HDownState := bsasbPressed;
  end;

  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMNCLButtonUp(var Msg: TWMMouse);
begin
  if VSliderState = bsasbPressed then
  begin
    BValues['lbtndown'] := False;
    VSliderState := bsasbNormal;
    PaintScroll;
    Handled := True;
    Exit;
  end;
  if HSliderState = bsasbPressed then
  begin
    BValues['lbtndown'] := False;
    HSliderState := bsasbNormal;
    PaintScroll;
    Handled := True;
    Exit;
  end;

  if VUpState = bsasbPressed then
  begin
    VUpState := bsasbNormal;
  end;
  if VDownState = bsasbPressed then
  begin
    VDownState := bsasbNormal;
  end;
  if HUpState = bsasbPressed then
  begin
    HUpState := bsasbNormal;
  end;
  if HDownState = bsasbPressed then
  begin
    HDownState := bsasbNormal;
  end;

  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMNCMouseMove(var Msg: TWMNCHitMessage);
var
  SF: TScrollInfo;
  OldCurPos: single;
  P: TPoint;
  VEnabled, HEnabled: Boolean;
begin
  P := Point(Msg.XCursor, Msg.YCursor);
  ScreenToClient(Handle, P);
  with GetBorderTopLeft do
  begin
    P.X := P.X + X;
    P.Y := P.Y + Y;
  end;

  VEnabled := not VScrollDisabled;
  HEnabled := not HScrollDisabled;

  if VSliderState <> bsasbPressed then
  begin
    if PtInRect(VSliderRect, P) then
      VSliderState := bsasbHot
    else
      VSliderState := bsasbNormal;
  end;
  if HSliderState <> bsasbPressed then
  begin
    if PtInRect(HSliderRect, P) then
      HSliderState := bsasbHot
    else
      HSliderState := bsasbNormal;
  end;

  if (VUpState <> bsasbPressed) and VEnabled then
  begin
    if PtInRect(VDownButtonRect, P) then
      VUpState := bsasbHot
    else
      VUpState := bsasbNormal;
  end;

  if (HUpState <> bsasbPressed) and HEnabled then
  begin
    if PtInRect(HDownButtonRect, P) then
      HUpState := bsasbHot
    else
      HUpState := bsasbNormal;
  end;

  if (VDownState <> bsasbPressed) and VEnabled then
  begin
    if PtInRect(VUpButtonRect, P) then
      VDownState := bsasbHot
    else
      VDownState := bsasbNormal;
  end;

  if (HDownState <> bsasbPressed) and HEnabled then
  begin
    if PtInRect(HUpButtonRect, P) then
      HDownState := bsasbHot
    else
      HDownState := bsasbNormal;
  end;

  if VSliderState = bsasbPressed then
  begin
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_VERT, SF);
    OldCurPos := FCurPos;
    FCurPos := FCurPos + (SF.nMax - SF.nMin) * ((Mouse.CursorPos.Y - FOldPos) / RectHeight(VTrackRect));
    if FCurPos < SF.nMin then FCurPos := SF.nMin;
    if FCurPos > SF.nMax then FCurPos := SF.nMax;

    FOldPos := Mouse.CursorPos.Y;
                                            
    if Control is TCustomListView then
    begin
      TCustomListView(FControl).Scroll(0, Round((FCurPos - OldCurPos)));
    end
    else
    begin
      PostMessage(Handle, WM_VSCROLL, Integer(SmallPoint(SB_THUMBPOSITION, Round(FCurPos))), 0);
    end;
    PaintScroll;
    Handled := True;
    Exit;
  end;
  if HSliderState = bsasbPressed then
  begin
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_HORZ, SF);
    OldCurPos := FCurPos;
    FCurPos := FCurPos + (SF.nMax - SF.nMin) * ((Mouse.CursorPos.X - FOldPos) / RectWidth(HTrackRect));
    if FCurPos < SF.nMin then FCurPos := SF.nMin;
    if FCurPos > SF.nMax then FCurPos := SF.nMax;

    FOldPos := Mouse.CursorPos.X;

    if Control is TCustomListView then
    begin
      TCustomListView(FControl).Scroll(Round(FCurPos - OldCurPos), 0);
    end
    else
      PostMessage(Handle, WM_HSCROLL, Integer(SmallPoint(SB_THUMBPOSITION, Round(FCurPos))), 0);
    PaintScroll;
    Handled := True;
    Exit;
  end;

  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMLButtonDown(var Msg: TWMMouse);
begin
  CallDefaultProc(TMessage(Msg));
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMLButtonUp(var Msg: TWMMouse);
begin

  if VSliderState = bsasbPressed then
  begin
    ReleaseCapture;
    BValues['lbtndown'] := False;
    VSliderState := bsasbNormal;
    PaintScroll;
    Handled := True;
    SendMessage(Handle, WM_VSCROLL, SB_ENDSCROLL, 0);
    Exit;
  end;


  if HSliderState = bsasbPressed then
  begin
    ReleaseCapture;
    BValues['lbtndown'] := False;
    HSliderState := bsasbNormal;
    PaintScroll;
    Handled := True;
    SendMessage(Handle, WM_HSCROLL, SB_ENDSCROLL, 0);
    Exit;
  end;


  if VUpState = bsasbPressed then
  begin
    VUpState := bsasbNormal;
  end;
  if VDownState = bsasbPressed then
  begin
    VDownState := bsasbNormal;
  end;
  if HUpState = bsasbPressed then
  begin
    HUpState := bsasbNormal;
  end;
  if HDownState = bsasbPressed then
  begin
    HDownState := bsasbNormal;
  end;

  CallDefaultProc(TMessage(Msg));
  BValues['lbtndown'] := False;
  PaintScroll;
  Handled := True;
end;


procedure TbsaScrollSubclass.WMMouseMove(var Msg: TWMMouse);
var
  SF: TScrollInfo;
  OldCurPos: single;
  R: TRect;
begin
  if VSliderState = bsasbPressed then
  begin
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_VERT, SF);

    if (Control is TCustomListView) then
    begin
      OldCurPos := FCurPos;
      FCurPos := FCurPos + (SF.nMax - SF.nMin) * ((Mouse.CursorPos.Y - FOldPos) / RectHeight(VTrackRect));
      if FCurPos < SF.nMin then FCurPos := SF.nMin;
      if FCurPos > SF.nMax then FCurPos := SF.nMax;
      FOldPos := Mouse.CursorPos.Y;

      if TbsaSubclassHackCustomListView(Control).ViewStyle = vsReport then
      begin
        if Abs(FCurPos - LVOldCurPos) >= 1.0 then
        begin
          ListView_GetItemRect(TCustomListView(Control).Handle, 0, R, LVIR_BOUNDS);
          TCustomListView(FControl).Scroll(0, Round((FCurPos - LVOldCurPos) * RectHeight(R)));
          LVOldCurPos := FCurPos;
        end;
      end
      else
      begin
        ListView_GetItemRect(TCustomListView(Control).Handle, 0, R, LVIR_BOUNDS);
        TCustomListView(FControl).Scroll(0, Round((FCurPos - OldCurPos)));
      end;
    end
    else
    begin
      OldCurPos := FCurPos;
      FCurPos := FCurPos + (SF.nMax - SF.nMin) * ((Mouse.CursorPos.Y - FOldPos) / RectHeight(VTrackRect));
      if FCurPos < SF.nMin then FCurPos := SF.nMin;
      if FCurPos > SF.nMax then FCurPos := SF.nMax;
      FOldPos := Mouse.CursorPos.Y;

      SetScrollPos(Handle, SB_VERT, Round(FCurPos), False);
      PostMessage(Handle, WM_VSCROLL, Integer(SmallPoint(SB_THUMBPOSITION, Round(FCurPos))), 0);
    end;
    PaintScroll;
    Handled := True;
    Exit;
  end;
  if HSliderState = bsasbPressed then
  begin
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_HORZ, SF);
    OldCurPos := FCurPos;
    FCurPos := FCurPos + (SF.nMax - SF.nMin) * ((Mouse.CursorPos.X - FOldPos) / RectWidth(HTrackRect));
    if FCurPos < SF.nMin then FCurPos := SF.nMin;
    if FCurPos > SF.nMax then FCurPos := SF.nMax;

    FOldPos := Mouse.CursorPos.X;

    if Control is TCustomListView then
    begin
      TCustomListView(FControl).Scroll(Round(FCurPos - OldCurPos), 0);
    end
    else
    begin
      SetScrollPos(Handle, SB_HORZ, Round(FCurPos), False);
      PostMessage(Handle, WM_HSCROLL, Integer(SmallPoint(SB_THUMBPOSITION, Round(FCurPos))), 0);
    end;
    PaintScroll;
    Handled := True;
    Exit;
  end;

  if (HSliderState <> bsasbPressed) and (HSliderState = bsasbHot) then
  begin
    HSliderState := bsasbNormal;
    PaintScroll;
  end;
  if (VSliderState <> bsasbPressed) and (VSliderState = bsasbHot) then
  begin
    VSliderState := bsasbNormal;
    PaintScroll;
  end;
  if (HUpState <> bsasbPressed) and (HUpState = bsasbHot) then
  begin
    HUpState := bsasbNormal;
    PaintScroll;
  end;
  if (HDownState <> bsasbPressed) and (HDownState = bsasbHot) then
  begin
    HDownState := bsasbNormal;
    PaintScroll;
  end;
  if (VUpState <> bsasbPressed) and (VUpState = bsasbHot) then
  begin
    VUpState := bsasbNormal;
    PaintScroll;
  end;
  if (VDownState <> bsasbPressed) and (VDownState = bsasbHot) then
  begin
    VDownState := bsasbNormal;
    PaintScroll;
  end;

  CallDefaultProc(TMessage(Msg));
  if BValues['lbtndown'] then
    PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMCAPTURECHANGED(var Msg: TMessage);
begin
  if VUpState = bsasbPressed then
  begin
    VUpState := bsasbNormal;
    PaintScroll;
  end;
  if VDownState = bsasbPressed then
  begin
    VDownState := bsasbNormal;
    PaintScroll;
  end;
  if HUpState = bsasbPressed then
  begin
    HUpState := bsasbNormal;
    PaintScroll;
  end;
  if HDownState = bsasbPressed then
  begin
    HDownState := bsasbNormal;
    PaintScroll;
  end;

  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;


procedure TbsaScrollSubclass.CMSENCPaint(var Message: TMessage);
begin
  inherited;
  if (Message.wParam <> 0)
  then
    begin
      DrawBorder(Message.wParam, True);
      if HScrollWnd <> nil
      then
        HScrollWnd.PaintTo(Message.wParam,
         HScrollWnd.Left - Control.Left, HScrollWnd.Top - Control.Top);
      if VScrollWnd <> nil
      then
        VScrollWnd.PaintTo(Message.wParam,
          VScrollWnd.Left - Control.Left, VScrollWnd.Top - Control.Top);
    end;
end;

procedure TbsaScrollSubclass.CMBENCPaint(var Message: TMessage);
begin
  if (Message.LParam = BE_ID)
  then
    begin
      if (Message.wParam <> 0)
      then
        DrawBorder(Message.wParam, True);
      Message.Result := BE_ID;
      Handled := True;
    end
  else
    Handled := False;
end;

procedure TbsaScrollSubclass.WMNCPaint(var Msg: TWMNCPaint);
begin
  DrawBorder(0, False);
  UpdateScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.Paint(Canvas: TCanvas);
begin
end;

procedure TbsaScrollSubclass.PaintBorder(Canvas: TCanvas; R: TRect);
var
  GripSize: Integer;
begin
  if FManager = nil then Exit;
  if FManager.Adapter.SkinData = nil then Exit;
  inherited;
  Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
  GripSize := GetSystemMetrics(SM_CXVSCROLL);
  if Self.HaveBorder
  then
    Canvas.FillRect(Rect(Width - GripSize - 2, Height - GripSize - 2, Width - 2, Height - 2))
  else
    Canvas.FillRect(Rect(Width - GripSize, Height - GripSize, Width, Height));
end;

procedure TbsaScrollSubclass.SetControl(const Value: TControl);
begin
  inherited;
  
  if VScrollWnd <> nil then FreeAndNil(VScrollWnd);
  VScrollWnd := TbsaWinScroll.CreateParented(Control.Parent.Handle);
  VScrollWnd.DoubleBuffered := True;
  TbsaWinScroll(VScrollWnd).FSubclass := Self;
  TbsaWinScroll(VScrollWnd).FVertical := True;
  with VScrollRect do
   if IsPopupWindow
   then
     SetWindowPos(VScrollWnd.Handle, HWND_TOPMOST, Control.Left + Left, Control.Top + Top, Right - Left, Bottom - Top, SWP_NOREDRAW)
   else
     SetWindowPos(VScrollWnd.Handle, HWND_TOP, Control.Left + Left, Control.Top + Top, Right - Left, Bottom - Top, SWP_NOREDRAW);
     
  if IsRectEmpty(VScrollRect) then
    ShowWindow(VScrollWnd.Handle, SW_HIDE)
  else
    ShowWindow(VScrollWnd.Handle, SW_SHOW);

  if HScrollWnd <> nil then FreeAndNil(HScrollWnd);
  HScrollWnd := TbsaWinScroll.CreateParented(Control.Parent.Handle);
  HScrollWnd.DoubleBuffered := True;
  TbsaWinScroll(HScrollWnd).FSubclass := Self;
  TbsaWinScroll(HScrollWnd).FVertical := False;
  with HScrollRect do
   if IsPopupWindow
   then
     SetWindowPos(HScrollWnd.Handle, HWND_TOPMOST, Control.Left + Left, Control.Top + Top, Right - Left, Bottom - Top, SWP_NOREDRAW)
   else
     SetWindowPos(HScrollWnd.Handle, HWND_TOP, Control.Left + Left, Control.Top + Top, Right - Left, Bottom - Top, SWP_NOREDRAW);

  if IsRectEmpty(HScrollRect) then
    ShowWindow(HScrollWnd.Handle, SW_HIDE)
  else
    ShowWindow(HScrollWnd.Handle, SW_SHOW); 
end;

procedure TbsaScrollSubclass.SetHandle(const Value: HWnd);
begin
  inherited;
end;

procedure TbsaScrollSubclass.CMMouseLeave(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  BValues[SMouseInControl] := False;
  PaintScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.CMVisibleChanged(var Msg: TMessage);
begin
  if (Control <> nil) and (Control.Visible) then
    ShowWindow(VScrollWnd.Handle, SW_SHOW);
  if (Control <> nil) and (not Control.Visible) then
    ShowWindow(VScrollWnd.Handle, SW_HIDE);
  if (Control <> nil) and (Control.Visible) then
    ShowWindow(HScrollWnd.Handle, SW_SHOW);
  if (Control <> nil) and (not Control.Visible) then
    ShowWindow(HScrollWnd.Handle, SW_HIDE);
end;

procedure TbsaScrollSubclass.WMSize(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  UpdateScroll;
  Handled := True;
end;

procedure TbsaScrollSubclass.WMKeyDown(var Msg: TMessage);
begin
  PaintScroll;
end;

procedure TbsaScrollSubclass.Unskin;
begin
  inherited;
end;

procedure TbsaScrollSubclass.AfterSkinChange; 
begin
  SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TbsaScrollSubclass.SkinChange;
begin
  inherited;
  UpdateScroll;
  PaintScroll;
  Invalidate;
  SendMessage(Handle, WM_NCPAINT, 0, 0);
end;

procedure TbsaScrollSubclass.WMWindowPosChanging(var Msg: TWMWindowPosChanged);
begin
  if (Control is TScrollBox) and IsWindowVisible(Handle) then
  begin
    UpdateScroll;
  end;
end;

procedure TbsaScrollSubclass.WMWindowPosChanged;
begin
  CallDefaultProc(TMessage(Msg));
  if Msg.WindowPos.Flags and SWP_HIDEWINDOW = SWP_HIDEWINDOW then
  begin
    if VScrollWnd <> nil then
      ShowWindow(VScrollWnd.Handle, SW_HIDE);
    if HScrollWnd <> nil then
      ShowWindow(HScrollWnd.Handle, SW_HIDE);
  end
  else
    if IsWindowVisible(Handle) then
    begin
      UpdateScroll;
      DrawBorder(0, False);
    end;
  Handled := True;
end;


{ TbsaButtonSubclass ===========================================================}

constructor TbsaButtonSubclass.Create;
begin
  inherited;
  FHotTrack := True;
  FOverridedPaint := True;
  FOverridedEraseBkgnd := True;
end;

procedure TbsaButtonSubclass.Paint(Canvas: TCanvas);

function GetGlyphNum(ANumGlyphs: Integer): Integer;
begin
  if (BValues[SPressed] and BValues[SMouseInControl]) and (ANumGlyphs > 2)
  then
    Result := 3
  else
  if (BValues[SMouseInControl]) and (ANumGlyphs > 3)
  then
    Result := 4
  else
    if not FControl.Enabled and (ANumGlyphs > 1)
    then
      Result := 2
    else
      Result := 1;
end;


var
  R, R1: TRect;
  Buffer: TBitMap;
  ButtonData: TbsDataSkinButtonControl;
  CIndex: Integer;
  Picture: TBitmap;
  C: TColor;
  R3: TRect;
begin
  if not FManager.IsSkinAvailable then Exit;
  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.ButtonSkinDataName);
    if CIndex = -1 then Exit;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ButtonData.PictureIndex]);
  end;
  //
  if (FManager.Adapter.ButtonUseSkinSize) and (Control.Height <> RectHeight(ButtonData.SkinRect)) and
     (ButtonData.RBPoint.X = 0) and (ButtonData.RBPoint.Y = 0)
  then
    begin
      Control.Height := RectHeight(ButtonData.SkinRect);
    end;
  // create button image
  with ButtonData do
  begin
    if (BValues[SPressed] and BValues[SMouseInControl]) and not IsNullRect(DownSkinRect)
       and FControl.Enabled
    then
      begin
        R := DownSkinRect;
        C := DownFontColor;
      end
    else
    if BValues[SFocused] and not IsNullRect(FocusedSkinRect)
    then
      begin
        R := FocusedSkinRect;
        C := ActiveFontColor;
      end
    else
    if (BValues[SMouseInControl] or BValues[SFocused]) and not IsNullRect(ActiveSkinRect)
       and FControl.Enabled
    then
      begin
        R := ActiveSkinRect;
        C := ActiveFontColor;
      end
    else
      begin
        if not FControl.Enabled
        then
          begin
            if not IsNullRect(DisabledSkinRect)
            then
              R := DisabledSkinRect
            else
              R := SkinRect;
            C := DisabledFontColor;
          end
        else
          begin
            R := SkinRect;
            C := FontColor;
          end;
      end;
    CreateSkinControlImage(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
                                 Buffer, Picture, R,
                                 Width, Height, StretchEffect,
                                 LeftStretch, TopStretch, RightStretch, BottomStretch,
                                 FManager.Adapter.ButtonUseSkinSize, StretchType);
  end;


  // draw focus
  if ButtonData.ShowFocus and Focused
  then
    begin
      R := ButtonData.ClRect;
      Inc(R.Right, Width - RectWidth(ButtonData.SkinRect));
      Inc(R.Bottom, Height - RectHeight(ButtonData.SkinRect));
      Buffer.Canvas.Brush.Style := bsSolid;
      Buffer.Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
      DrawSkinFocusRect(Buffer.Canvas, R);
      Buffer.Canvas.Brush.Style := bsClear;
    end;

  // draw text
  R := GetClientRect;
  Buffer.Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
  Buffer.Canvas.Font.Color := C;
  if Control is TBitBtn
  then
    with TBitBtn(Control) do
    begin
      DrawGlyphAndText(Buffer.Canvas, R, Margin, Spacing, TbsButtonLayout(Layout),
       Text, Glyph, NumGlyphs, GetGlyphNum(NumGlyphs), False);
    end
  else
    begin
      R1 := R;
      R1.Top := Buffer.Height div 2 - RectHeight(R) div 2;
      R1.Bottom := R1.Top + RectHeight(R);
      DrawGlyphAndText(Buffer.Canvas, R1, -1, 0, blGlyphLeft,
       Text, nil,  0,  0, False);
    end;
  //
  Canvas.Draw(0, 0, Buffer);
  BUffer.Free;
end;

procedure TbsaButtonSubclass.SkinChange;
var
  ButtonData: TbsDataSkinButtonControl;
  CIndex: Integer;
begin
  inherited;
  if not FManager.IsSkinAvailable then Exit;
  if FManager.Adapter.ButtonUseSkinSize
  then
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.ButtonSkinDataName);
    if CIndex = -1 then Exit;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    if (ButtonData.RBPoint.X = 0) and (ButtonData.RBPoint.Y = 0)
    then
      Control.Height := RectHeight(ButtonData.SkinRect);
  end;
end;

procedure TbsaButtonSubclass.CMMouseLeave(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SMouseInControl] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaButtonSubclass.CMMouseEnter(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SMouseInControl] := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaButtonSubclass.WMKeyDown(var Msg: TMessage);
begin
  if Msg.WParam = VK_SPACE then SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  if Msg.WParam = VK_SPACE then SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 1, 0);
  if Msg.WParam = VK_SPACE then
  begin
    BValues[SMouseinControl] := True;
    BValues[SPressed] := True;
    Invalidate;
  end;
  Handled := True;
end;

procedure TbsaButtonSubclass.WMKeyUp(var Msg: TMessage);
begin
  if Msg.WParam = VK_SPACE then SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  if Msg.WParam = VK_SPACE then SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 1, 0);
  if Msg.WParam = VK_SPACE then
  begin
    BValues[SMouseinControl] := False;
    BValues[SPressed] := False;
    Invalidate;
  end;
  Handled := True;
end;

procedure TbsaButtonSubclass.WMLButtonDblClk(var Msg: TWMMouse);
begin
  BValues[SPressed] := False;
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 1, 0);
  BValues[SPressed] := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaButtonSubclass.WMLButtonDown(var Msg: TWMMouse);
begin
  BValues[SPressed] := False;
  Invalidate;
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SPressed] := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaButtonSubclass.WMLButtonUp(var Msg: TWMMouse);
begin
  BValues[SPressed] := False;
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  ReleaseCapture;
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW, 1, 0);
  BValues[SPressed] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaButtonSubclass.WMMouseMove(var Msg: TWMMouse);
begin
  CallDefaultProc(TMessage(Msg));
  if BValues[SPressed] then Invalidate;
  Handled := True;
end;

{ TbsaCheckBoxSubclass ===========================================================}

constructor TbsaCheckBoxSubclass.Create;
begin
  inherited;
  FHotTrack := True;
  FOverridedPaint := True;
  FOverridedEraseBkgnd := True;
  FDoubleBuffered := True;
end;

procedure TbsaCheckBoxSubclass.WMMOVE(var Msg: TWMMOVE);
begin
  CallDefaultProc(TMessage(Msg));
  FControl.Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMCHECKPARENTBG(var Msg: TWMEraseBkgnd);
begin
  FControl.Invalidate;
end;

type
  TbsParentCheckBox = class(TCustomCheckBox);


procedure TbsaCheckBoxSubclass.Paint(Canvas: TCanvas);

procedure SkinDrawGrayedCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
  Buffer: TbsEffectBmp;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  Buffer := TbsEffectBmp.CreateFromhWnd(B.Handle);
  Buffer.ChangeBrightness(0.5);
  Buffer.Draw(B.Canvas.Handle, 0, 0);
  Buffer.Free;
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

var
  R, R1: TRect;
  State: TCheckBoxState;
  CIndex, IX, IY: Integer;
  CBData: TbsDataSkinCheckRadioControl;
  Picture: TBitMap;
begin
  if not FManager.IsSkinAvailable then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('checkbox');
    if CIndex = -1 then Exit;
    CBData := TbsDataSkinCheckRadioControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[CBData.PictureIndex]);
  end;
  //
  GetSkinParentImage(FControl, Canvas);
  // draw check image
  with CBData do
  begin
    if FControl.BiDiMode = bdRightToLeft
    then
      IX := Width - RectWidth(CBData.CheckImageRect)
    else
      IX := 0;
    IY := Height div 2 - RectHeight(CheckImageRect) div 2;
    if LowerCase(FControl.ClassName) = 'twwcheckbox'
    then
      State := TbsParentCheckBox(FControl).State
    else
      State := TCheckBoxState(SendMessage(Handle, BM_GETCHECK, 0, 0));
    if State = cbGrayed
    then
      begin
        if MouseInControl and not IsNullRect(ActiveCheckImageRect)
        then
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Canvas)
        else
          SkinDrawGrayedCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Canvas);
      end
    else
    if State = cbChecked
    then
      begin
        if not Enabled and not IsNullRect(UnEnabledCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, Canvas)
        else
        if MouseInControl and not IsNullRect(ActiveCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Canvas);
      end
    else
      begin
       if not Enabled and not IsNullRect(UnEnabledUnCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledUnCheckImageRect, Canvas)
        else
        if MouseInControl and not IsNullRect(ActiveUnCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveUnCheckImageRect, Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnCheckImageRect, Canvas);
      end;
  end;
  // draw text
  Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
  with Canvas.Font, CBData do
  begin
    if FControl.Enabled
    then
      Color := FrameFontColor
    else
      Color := UnEnabledFontColor;
  end;

  if FControl.BiDiMode = bdRightToLeft
  then
    R := Rect(0, 0, Width - RectWidth(CBData.CheckImageRect) - 5, Height)
  else
    R := Rect(RectWidth(CBData.CheckImageRect) + 5, 0, Width, Height);

  DrawSkinText(Canvas, Text, R, DrawTextBiDiModeFlags(DT_CALCRECT or DT_EXPANDTABS));
  R1 := R;
  R1.Top := Height div 2 - RectHeight(R) div 2;
  R1.Bottom := R1.Top + RectHeight(R);
  if FControl.BiDiMode = bdRightToLeft
  then
    begin
      R1 := Rect(Width - RectWidth(CBData.CheckImageRect) - 5 - RectWidth(R1),
                 R1.Top, Width - RectWidth(CBData.CheckImageRect) - 5, R1.Bottom);
      DrawSkinText(Canvas, Text, R1, DrawTextBiDiModeFlags(DT_RIGHT));
    end
  else
    DrawSkinText(Canvas, Text, R1, DrawTextBiDiModeFlags(DT_LEFT));
  if Focused then
  begin
    InflateRect(R1, 2, 2);
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
    DrawSkinFocusRect(Canvas, R1);
  end;
end;

procedure TbsaCheckBoxSubclass.BMSetCheck(var Msg: TMessage);
begin
  if FControl.Visible
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  if FControl.Visible
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMKeyUp(var Msg: TWMKeyUp);
begin
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  if Msg.CharCode = VK_SPACE
  then
    Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMKeyDown(var Msg: TWMKeyDown);
begin
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  if Msg.CharCode = VK_SPACE
  then
    Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMLButtonDblClk(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMLButtonDown(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SPressed] := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMLButtonUp(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SPressed] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.WMMouseMove(var Msg: TWMMouse);
begin
  CallDefaultProc(TMessage(Msg));
  if BValues[SPressed] then Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.CMMouseLeave(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SMouseInControl] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaCheckBoxSubclass.CMMouseEnter(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SMouseInControl] := True;
  Invalidate;
  Handled := True;
end;

{ TbsaRadioButtonSubclass ===========================================================}

constructor TbsaRadioButtonSubclass.Create;
begin
  inherited;
  FHotTrack := True;
  FOverridedPaint := True;
  FOverridedEraseBkgnd := True;
  FDoubleBuffered := True;
end;

procedure TbsaRadioButtonSubclass.WMMOVE(var Msg: TWMMOVE);
begin
  CallDefaultProc(TMessage(Msg));
  FControl.Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.WMCHECKPARENTBG(var Msg: TWMEraseBkgnd);
begin
  FControl.Invalidate;
end;

procedure TbsaRadioButtonSubclass.WMKeyDown(var Msg: TWMKeyDown);
begin
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  if Msg.CharCode = VK_SPACE
  then
    Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.WMKeyUp(var Msg: TWMKeyUp);
begin
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  if Msg.CharCode = VK_SPACE
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  if Msg.CharCode = VK_SPACE
  then
    Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.Paint(Canvas: TCanvas);

procedure SkinDrawCheckImage(X, Y: Integer; Cnvs: TCanvas; IR: TRect; DestCnvs: TCanvas);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Width := RectWidth(IR);
  B.Height := RectHeight(IR);
  B.Canvas.CopyRect(Rect(0, 0, B.Width, B.Height), Cnvs, IR);
  B.Transparent := True;
  DestCnvs.Draw(X, Y, B);
  B.Free;
end;

var
  R, R1: TRect;
  State: TCheckBoxState;
  CIndex, IX, IY: Integer;
  CBData: TbsDataSkinCheckRadioControl;
  Picture: TBitMap;
begin
  if not FManager.IsSkinAvailable then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('radiobox');
    if CIndex = -1 then Exit;
    CBData := TbsDataSkinCheckRadioControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[CBData.PictureIndex]);
  end;
  //
  GetSkinParentImage(FControl, Canvas);
  // draw check image
  with CBData do
  begin
    if FControl.BiDiMode = bdRightToLeft
    then
      IX := Width - RectWidth(CBData.CheckImageRect)
    else
      IX := 0;

    IY := Height div 2 - RectHeight(CheckImageRect) div 2;
    State := TCheckBoxState(SendMessage(Handle, BM_GETCHECK, 0, 0));
    if State = cbChecked
    then
      begin
        if not Enabled and not IsNullRect(UnEnabledCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledCheckImageRect, Canvas)
        else
        if MouseInControl and not IsNullRect(ActiveCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveCheckImageRect, Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, CheckImageRect, Canvas);
      end
    else
      begin
       if not Enabled and not IsNullRect(UnEnabledUnCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnEnabledUnCheckImageRect, Canvas)
        else
        if MouseInControl and not IsNullRect(ActiveUnCheckImageRect)
        then
          SkinDrawCheckImage(IX, IY, Picture.Canvas, ActiveUnCheckImageRect, Canvas)
        else
          SkinDrawCheckImage(IX, IY, Picture.Canvas, UnCheckImageRect, Canvas);
      end;
  end;
  // draw text
  Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
  with Canvas.Font, CBData do
  begin
    if FControl.Enabled
    then
      Color := FrameFontColor
    else
      Color := UnEnabledFontColor;
  end;

  if FControl.BiDiMode = bdRightToLeft
  then
    R := Rect(0, 0, Width - RectWidth(CBData.CheckImageRect) - 5, Height)
  else
    R := Rect(RectWidth(CBData.CheckImageRect) + 5, 0, Width, Height);


  DrawSkinText(Canvas, Text, R, DrawTextBiDiModeFlags(DT_CALCRECT or DT_EXPANDTABS));
  R1 := R;
  R1.Top := Height div 2 - RectHeight(R) div 2;
  R1.Bottom := R1.Top + RectHeight(R);

  if FControl.BiDiMode = bdRightToLeft
  then
    begin
      R1 := Rect(Width - RectWidth(CBData.CheckImageRect) - 5 - RectWidth(R1),
                 R1.Top, Width - RectWidth(CBData.CheckImageRect) - 5, R1.Bottom);
      DrawSkinText(Canvas, Text, R1, DrawTextBiDiModeFlags(DT_RIGHT));
    end
  else
    DrawSkinText(Canvas, Text, R1, DrawTextBiDiModeFlags(DT_LEFT));

  //
  if Focused then
  begin
    InflateRect(R1, 2, 2);
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
    DrawSkinFocusRect(Canvas, R1);
//    Canvas.DrawFocusRect(R1);
  end;
  //
end;

procedure TbsaRadioButtonSubclass.WMLButtonDblClk(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.BMSetCheck(var Msg: TMessage);
begin
  if FControl.Visible
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  if FControl.Visible
  then
    SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.WMLButtonDown(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SPressed] := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.WMLButtonUp(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SPressed] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.CMMouseLeave(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SMouseInControl] := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaRadioButtonSubclass.CMMouseEnter(var Msg: TWMMouse);
begin
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  BValues[SMouseInControl] := True;
  Invalidate;
  Handled := True;
end;


procedure TbsaRadioButtonSubclass.WMMouseMove(var Msg: TWMMouse);
begin
  CallDefaultProc(TMessage(Msg));
  if BValues[SPressed] then Invalidate;
  Handled := True;
end;

{ TbsaEditSubclass =============================================================}

constructor TbsaEditSubclass.Create;
begin
  inherited;
end;

procedure TbsaEditSubclass.SkinChange;
begin
  inherited;
  if FManager.IsSkinAvailable
  then
    with FManager.Adapter.SkinData do
    begin
      TbsaSubclassHackControl(Control).Color := FManager.Adapter.SkinData.SkinColors.cWindow;
      TbsaSubclassHackControl(Control).Font.Color := FManager.Adapter.SkinData.SkinColors.cWindowText;
    end
  else
    begin
      TbsaSubclassHackControl(Control).Color := clWindow;
      TbsaSubclassHackControl(Control).Font.Color := clWindowText;
      Windows.RedrawWindow(TWinControl(Control).Handle, nil, 0,
       RDW_FRAME or RDW_INVALIDATE);
    end;
end;

procedure TbsaEditSubclass.CMSENCPaint(var Message: TMessage);
var
  R: TRect;
  Canvas: TCanvas;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Message));
      Exit;
    end;
  if (Message.LParam = 0)
  then
  begin
    if (Message.wParam <> 0)
      then
        begin
          R := NullRect;
          Canvas := TCanvas.Create;
          if (Control <> nil) and (Control is TWinControl) then
          begin
            Canvas.Handle := Message.wParam;
             R := Control.BoundsRect;
          end
          else
          if Handle <> 0 then
          begin
            Canvas.Handle := Message.wParam;
           GetWindowRect(Handle, R);
          end;
          ExcludeClipRect(Canvas.Handle, 2, 2, Width - 2, Height - 2);
          OffsetRect(R, -R.Left, -R.Top);
          // draw border
          PaintBorder(Canvas, R);
          //
          Canvas.Handle := 0;
          Canvas.Free;
        end;
    Handled := True;
    Message.Result := SE_RESULT;
  end
  else
    Handled := False;
end;

procedure TbsaEditSubclass.CMBENCPaint(var Message: TMessage);
var
  R: TRect;
  Canvas: TCanvas;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Message));
      Exit;
    end;

  if (Message.LParam = BE_ID)
  then
  begin
    if (Message.wParam <> 0)
      then
        begin
          R := NullRect;
          Canvas := TCanvas.Create;
          if (Control <> nil) and (Control is TWinControl) then
          begin
            Canvas.Handle := Message.wParam;
             R := Control.BoundsRect;
          end
          else
          if Handle <> 0 then
          begin
            Canvas.Handle := Message.wParam;
           GetWindowRect(Handle, R);
          end;
          ExcludeClipRect(Canvas.Handle, 2, 2, Width - 2, Height - 2);
          OffsetRect(R, -R.Left, -R.Top);
          // draw border
          PaintBorder(Canvas, R);
          //          
          Canvas.Handle := 0;
          Canvas.Free;
        end;
    Handled := True;
    Message.Result := BE_ID;
  end
  else
    Handled := False;
end;

procedure TbsaEditSubclass.WMNCPaint(var Msg: TWMNCPaint);
var
  R: TRect;
  Canvas: TCanvas;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Msg));
      Exit;
    end;
  R := NullRect;
  Canvas := TCanvas.Create;
  if (Control <> nil) and (Control is TWinControl) then
  begin
    Canvas.Handle := GetWindowDC(TWinControl(Control).Handle);
    R := Control.BoundsRect;
  end
  else
    if Handle <> 0 then
    begin
      Canvas.Handle := GetWindowDC(Handle);
      GetWindowRect(Handle, R);
    end;
  ExcludeClipRect(Canvas.Handle, 2, 2, Width - 2, Height - 2);
  OffsetRect(R, -R.Left, -R.Top);
  // draw border
  PaintBorder(Canvas, R);
  //
  ReleaseDC(Handle, Canvas.Handle);
  Canvas.Handle := 0;
  Canvas.Free;
  Handled := True;
end;

procedure TbsaEditSubclass.WMEraseBkgnd(var Msg: TMessage);

begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaEditSubclass.CNCtlColorEdit(var Msg: TWMCTLCOLOREDIT);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaEditSubclass.CNCtlColorStatic(var Msg: TWMCTLCOLORSTATIC);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaEditSubclass.SetControl(const Value: TControl);
begin
  inherited;
end;

procedure TbsaEditSubclass.SetHandle(const Value: HWnd);
begin
  inherited;
end;

{ TbsaDateTimeSubClass =============================================================}

constructor TbsaDateTimeSubClass.Create;
begin
  inherited;
  FMouseOnButton := False;
  DropedDown := False;
end;

procedure TbsaDateTimeSubClass.SkinChange;
begin
  inherited;
end;

procedure TbsaDateTimeSubClass.CMSEPaint(var Message: TMessage); 
begin
  DrawBorder(Message.WParam, True);
end;

procedure TbsaDateTimeSubClass.CMSENCPaint(var Message: TMessage);
var
  R: TRect;
  Canvas: TCanvas;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Message));
      Exit;
    end;
  if (Message.LParam = 0)
  then
  begin
    if (Message.wParam <> 0)
      then
        begin
          R := NullRect;
          Canvas := TCanvas.Create;
          if (Control <> nil) and (Control is TWinControl) then
          begin
            Canvas.Handle := Message.wParam;
             R := Control.BoundsRect;
          end
          else
          if Handle <> 0 then
          begin
            Canvas.Handle := Message.wParam;
           GetWindowRect(Handle, R);
          end;
          ExcludeClipRect(Canvas.Handle, 2, 2, Width - 2, Height - 2);
          OffsetRect(R, -R.Left, -R.Top);
          //
          PaintBorder(Canvas, R);
          //
          Canvas.Handle := 0;
          Canvas.Free;
        end;
    Handled := True;
    Message.Result := SE_RESULT;
  end
  else
    Handled := False;
end;

procedure TbsaDateTimeSubClass.CMBENCPaint(var Message: TMessage);
var
  R: TRect;
  Canvas: TCanvas;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Message));
      Exit;
    end;

  if (Message.LParam = BE_ID)
  then
  begin
    if (Message.wParam <> 0)
      then
        begin
          R := NullRect;
          Canvas := TCanvas.Create;
          if (Control <> nil) and (Control is TWinControl) then
          begin
            Canvas.Handle := Message.wParam;
             R := Control.BoundsRect;
          end
          else
          if Handle <> 0 then
          begin
            Canvas.Handle := Message.wParam;
           GetWindowRect(Handle, R);
          end;
          ExcludeClipRect(Canvas.Handle, 2, 2, Width - 2, Height - 2);
          OffsetRect(R, -R.Left, -R.Top);
          //
          PaintBorder(Canvas, R);
          //
          Canvas.Handle := 0;
          Canvas.Free;
        end;
    Handled := True;
    Message.Result := BE_ID;
  end
  else
    Handled := False;
end;

function TbsaDateTimeSubclass.GetButtonRect: TRect;
begin
  Result := GetClientRect;
  InflateRect(Result, -2, -2);
  Result.Left := Result.Right - GetSystemMetrics(SM_CXVSCROLL);
end;

function TbsaDateTimeSubclass.GetButtonRect2: TRect;
begin
  Result := Rect(Width - 4 - GetSystemMetrics(SM_CXVSCROLL),
   0, Width - 4, Height - 4);
end;

procedure TbsaDateTimeSubclass.DrawBorder;
var
  Cnvs: TCanvas;
  BR, R, SR: TRect;
  C: TColor;
  Canvas: TCanvas;
  ButtonData: TbsDataSkinButtonControl;
  CIndex, X, Y: Integer;
  Picture: TBitmap;
  Buffer, Buffer2: TBitMap;
begin
  if Kind = dtkTime then Exit;
  Cnvs := TCanvas.Create;
  if not AUseExternalDC
  then
    Cnvs.Handle := GetDC(TWinControl(FControl).Handle)
  else
    Cnvs.Handle := ADC;
  // draw button
  BR := GetButtonRect;
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('combobutton');
    if CIndex = -1 then
    CIndex := GetControlIndex('editbutton');
    if CIndex = -1 then
    CIndex := GetControlIndex('resizebutton');
    if CIndex = -1 then Exit;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ButtonData.PictureIndex]);
  end;
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(BR);
  Buffer.Height := RectHeight(BR);
  with ButtonData do
  begin
    if DropedDown and not IsNullRect(DownSkinRect)
    then
      begin
        SR := DownSkinRect;
        C := DownFontColor;
      end
    else
    if FMouseOnButton and not IsNullRect(ActiveSkinRect)
    then
      begin
        SR := ActiveSkinRect;
        C := ActiveFontColor;
      end
    else
      begin
        SR := SkinRect;
        C := FontColor;
      end;
    CreateSkinControlImage(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
                           Buffer, Picture, SR,
                           Buffer.Width, Buffer.Height, StretchEffect,
                           LeftStretch, TopStretch, RightStretch, BottomStretch,
                           False, StretchType);
    if not IsNullRect(ButtonData.MenuMarkerRect)
    then
     with ButtonData do
     begin
       if Self.DropedDown and not IsNullRect(MenuMarkerDownRect)
       then SR := MenuMarkerDownRect else
         if (BValues[SMouseInControl] and FMouseOnButton) and not IsNullRect(MenuMarkerActiveRect)
           then SR := MenuMarkerActiveRect else SR := MenuMarkerRect;

       Buffer2 := TBitMap.Create;
       Buffer2.Width := RectWidth(SR);
       Buffer2.Height := RectHeight(SR);
       Buffer2.Canvas.CopyRect(Rect(0, 0, Buffer2.Width, Buffer2.Height),
        Picture.Canvas, SR);

       Buffer2.Transparent := True;
       Buffer2.TransparentMode := tmFixed;
       Buffer2.TransparentColor := MenuMarkerTransparentColor;
       X := RectWidth(BR) div 2 - RectWidth(SR) div 2;
       Y := RectHeight(BR) div 2 - RectHeight(SR) div 2 + 1;
       Buffer.Canvas.Draw(X, Y, Buffer2);
       Buffer2.Free;
     end
     else
       DrawArrowImage(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height), C, 4);
    Cnvs.Draw(BR.Left - 2, BR.Top - 2, Buffer);
    Buffer.Free;
  end;
  //
  if not AUseExternalDC
  then
    ReleaseDC(TWinControl(FControl).Handle, Cnvs.Handle);
  Cnvs.Handle := 0;
  Cnvs.Free;
end;

procedure TbsaDateTimeSubclass.Paint(Canvas: TCanvas);
begin
  DrawBorder(Canvas.Handle, False);
end;

function TbsaDateTimeSubclass.Kind: TDateTimeKind;
begin
  if GetWindowLong(TWinControl(FControl).Handle, GWL_STYLE) and
       DTS_TIMEFORMAT = DTS_TIMEFORMAT
  then
    Result := dtkTime
  else
    Result := dtkDate;
end;

procedure TbsaDateTimeSubclass.WMMouseMove(var Msg: TWMMouse);
var
  P: TPoint;
  R: TRect;
begin
  inherited;
  P := Point(Msg.XPos, Msg.YPos);
  R := GetButtonRect2;
  if PtInRect(R, P) and not FMouseOnButton
  then
    begin
      FMouseOnButton := True;
      DrawBorder(0, False);
    end
  else
  if not PtInRect(R, P) and FMouseOnButton
  then
    begin
      FMouseOnButton := False;
      DrawBorder(0, False);
    end;
end;


procedure  TbsaDateTimeSubclass.WMTimer(var Message: TWMTimer);
begin
  KillTimer(TWinControl(FControl).Handle, 1);
  SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,1, 0);
  DrawBorder(0, False);
end;

procedure TbsaDateTimeSubclass.CMMouseEnter(var Msg: TWMMouse);
begin
  inherited;
  FMouseOnButton := False;
  DrawBorder(0, False);
end;

procedure TbsaDateTimeSubclass.CMMouseLeave(var Msg: TWMMouse);
begin
  inherited;
  FMouseOnButton := False;
  DrawBorder(0, False);
end;

procedure TbsaDateTimeSubclass.CNNotify(var Message: TWMNotify);
begin
  CallDefaultProc(TMessage(Message));
  if Kind = dtkDate then
  with Message, NMHdr^ do
  begin
    Result := 0;
    case code of
     DTN_DROPDOWN:
       begin
         DropedDown := True;
         DrawBorder(0, False);
         SendMessage(TWinControl(FControl).Handle, WM_SETREDRAW,0, 0);
         SetTimer(Handle, 1, 300, nil);
       end;
      DTN_CLOSEUP:
        begin
          DropedDown := False;
          DrawBorder(0, False);
        end;
    end;
  end;
  Handled := True;
end;

procedure TbsaDateTimeSubclass.WMPaint(var Msg: TMessage);
begin
  CallDefaultProc(Msg);
  OveridedWMPaint(Msg);
  Handled := True;
end;

procedure TbsaDateTimeSubClass.WMNCPaint(var Msg: TWMNCPaint);
var
  R: TRect;
  Canvas: TCanvas;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Msg));
      Exit;
    end;  
  R := NullRect;
  Canvas := TCanvas.Create;
  if (Control <> nil) and (Control is TWinControl) then
  begin
    Canvas.Handle := GetWindowDC(TWinControl(Control).Handle);
    R := Control.BoundsRect;
  end
  else
    if Handle <> 0 then
    begin
      Canvas.Handle := GetWindowDC(Handle);
      GetWindowRect(Handle, R);
    end;
  ExcludeClipRect(Canvas.Handle, 2, 2, Width - 2, Height - 2);
  OffsetRect(R, -R.Left, -R.Top);
  // draw border
  PaintBorder(Canvas, R);
  //
  ReleaseDC(Handle, Canvas.Handle);
  Canvas.Handle := 0;
  Canvas.Free;
  Handled := True;
end;

procedure TbsaDateTimeSubClass.WMEraseBkgnd(var Msg: TMessage);

begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaDateTimeSubClass.CNCtlColorEdit(var Msg: TWMCTLCOLOREDIT);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaDateTimeSubClass.CNCtlColorStatic(var Msg: TWMCTLCOLORSTATIC);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaDateTimeSubClass.SetControl(const Value: TControl);
begin
  inherited;
end;

procedure TbsaDateTimeSubClass.SetHandle(const Value: HWnd);
begin
  inherited;
end;

{ TbsaComboBoxSubclass ========================================================}

constructor TbsaComboBoxSubclass.Create;
begin
  inherited;
  FListHandle := 0;
  FOverridedEraseBkgnd := True;
  FOverridedPaint := True;
  FHotTrack := True;
end;

procedure TbsaComboBoxSubclass.SetControl(const Value: TControl);
begin
  inherited;
end;

procedure TbsaComboBoxSubclass.SetHandle(const Value: HWnd);
begin
  inherited;
end;

procedure TbsaComboBoxSubclass.WMCTLCOLORLISTBOX(var Msg: TMessage);
begin
  if FListHandle = 0 then
  begin
    FListHandle := Msg.WParam;
    if FListHandle <> 0 then
    begin
      FManager.FCurrentSubclass := TbsaComboListBoxSubclass;
      FManager.FHookCollection.AddControl(FListHandle, FManager.DoHandleMessage, FManager.DoUnhook);
      FManager.FCurrentSubclass := nil;
    end;
  end;
  CallDefaultProc(Msg);
  Handled := True;
end;

procedure TbsaComboBoxSubclass.PostAction;
var
  CI: TComboBoxInfo;
begin
  inherited ;
  if Handle <> 0 then
  begin
    FillChar(CI, SizeOf(CI), 0);
    CI.cbSize := SizeOf(CI);
    GetComboBoxInfo(Handle, CI);
    FListHandle := CI.hwndList;
  end;
  if FListHandle <> 0 then
  begin
    FManager.FCurrentSubclass := TbsaComboListBoxSubclass;
    FManager.FHookCollection.AddControl(FListHandle, FManager.DoHandleMessage, FManager.DoUnhook);
    FManager.FCurrentSubclass := nil;
    SetWindowPos(FListHandle, 0, 0,0,0,0, SWP_FRAMECHANGED or SWP_NOACTIVATE or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

procedure TbsaComboBoxSubclass.CMSENCPaint(var Message: TMessage);
var
  C: TCanvas;
  R: TRect;
begin
  inherited;
  C := TCanvas.Create;
  C.Handle := Message.WParam;
  SendMessage(Handle, WM_PRINT, C.Handle,
    PRF_ERASEBKGND or PRF_CLIENT or PRF_NONCLIENT or PRF_CHILDREN);
  DrawBorder(C.Handle, True);
  C.Handle := 0;
  C.Free;
end;

procedure TbsaComboBoxSubclass.CNCommand(var Message: TWMCommand);
var
  R: TRect;
begin
  CallDefaultProc(TMessage(Message));
  if (Message.NotifyCode = CBN_SELENDCANCEL)
  then
    begin
      FControl.Invalidate;
    end;
  Handled := True;
end;

procedure TbsaComboBoxSubclass.SkinChange;
begin
  inherited;
  // get skin data
  if FManager.IsSkinAvailable
  then
  with FManager.Adapter.SkinData do
  begin
    TbsaSubclassHackControl(Control).Color := FManager.Adapter.SkinData.SkinColors.cWindow;
    TbsaSubclassHackControl(Control).Font.Color := FManager.Adapter.SkinData.SkinColors.cWindowText;
  end
  else
    begin
      TbsaSubclassHackControl(Control).Color := clWindow;
      TbsaSubclassHackControl(Control).Font.Color := clWindowText;
    end;
  TbsaSubclassHackControl(Control).Invalidate;
end;

function TbsaComboBoxSubclass.ComboBox: TCustomComboBox;
begin
  if Control is TCustomComboBox then
    Result := TCustomComboBox(Control)
  else
    Result := nil;
end;

function TbsaComboBoxSubclass.DroppedDown: Boolean;
begin
  {$IFDEF LOOKUP_SUPPORT}
  if FControl is TDBLookUpComboBox
  then
    with TDBLookUpComboBox(FControl) do
    begin
      Result := ListVisible
    end
  else
  {$ENDIF}
  if Control is TCustomComboBox then
    Result := TCustomComboBox(Control).DroppedDown
  else
    Result := False;
end;

function TbsaComboBoxSubclass.GetButtonRect: TRect;
begin
  Result := GetClientRect;
  InflateRect(Result, -2, -2);
  Result.Left := Result.Right - GetSystemMetrics(SM_CXVSCROLL);
end;

function TbsaComboBoxSubclass.Style: TComboBoxStyle;
begin
  if Control is TCustomComboBox then
    Result := TbsaSubclassHackCustomComboBox(Control).Style
  else
    Result := csDropDown;
end;

procedure TbsaComboBoxSubclass.DrawBorder;
var
  BR, R, SR: TRect;
  C: TColor;
  Canvas: TCanvas;
  MemoData: TbsDataSkinMemoControl;
  ButtonData: TbsDataSkinButtonControl;
  CIndex, X, Y: Integer;
  ClientColor: TColor;
  MainBuffer, Buffer, Buffer2, Picture: TBitMap;
  S: String;
begin
  R := NullRect;
  Canvas := TCanvas.Create;
  if AUseExternalDC and (Control <> nil)
  then
    begin
      Canvas.Handle := ADC;
      R := Control.BoundsRect;
    end
  else
  if (Control <> nil) and (Control is TWinControl) then
  begin
    Canvas.Handle := GetWindowDC(TWinControl(Control).Handle);
    R := Control.BoundsRect;
  end
  else
    if Handle <> 0 then
    begin
      Canvas.Handle := GetDC(Handle);
      GetWindowRect(Handle, R);
    end;
  if RectWidth(R) * RectHeight(R) = 0 then
  begin
    Canvas.Free;
    Exit;
  end;

  MainBuffer := TBitmap.Create;
  MainBuffer.Width := RectWidth(R);
  MainBuffer.Height := RectHeight(R);
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('memo');
    if CIndex = -1
    then
      begin
        Canvas.Free;
        Exit;
      end;
    MemoData := TbsDataSkinMemoControl(CtrlList[CIndex]);
  end;
  with MemoData do
  begin
    ClientColor := FManager.Adapter.SkinData.SkinColors.cWindow;
  end;
  // draw border
  R := Rect(0, 0, MainBuffer.Width, MainBuffer.Height);
  PaintBorder(MainBuffer.Canvas, R);
  with MainBuffer.Canvas do
  begin
    Brush.Color := ClientColor;
    FillRect(Rect(2, 2, R.Right - 2, R.Bottom - 2));
  end;
  // draw button
  BR := GetButtonRect;
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('combobutton');
    if CIndex = -1 then CIndex := GetControlIndex('editbutton');
    if CIndex = -1 then CIndex := GetControlIndex('resizebutton');
    if CIndex = -1
    then
      begin
        Canvas.Free;
        Exit;
      end;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ButtonData.PictureIndex]);
  end;

  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(BR);
  Buffer.Height := RectHeight(BR);

  with ButtonData do
  begin
    if DroppedDown and not IsNullRect(DownSkinRect)
    then
      begin
        SR := DownSkinRect;
        C := DownFontColor;
      end
    else
    if BValues[SMouseInControl] and FMouseOnButton
       and not IsNullRect(ActiveSkinRect)
    then
      begin
        SR := ActiveSkinRect;
        C := ActiveFontColor;
      end
    else
      begin
        SR := SkinRect;
        C := FontColor;
      end;
    CreateSkinControlImage(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
                           Buffer, Picture, SR,
                           Buffer.Width, Buffer.Height, StretchEffect,
                           LeftStretch, TopStretch, RightStretch, BottomStretch,
                           False, StretchType);

   if not IsNullRect(ButtonData.MenuMarkerRect)
   then
    with ButtonData do
    begin
      if DroppedDown and not IsNullRect(MenuMarkerDownRect)
      then SR := MenuMarkerDownRect else
        if (BValues[SMouseInControl] and FMouseOnButton) and not IsNullRect(MenuMarkerActiveRect)
          then SR := MenuMarkerActiveRect else SR := MenuMarkerRect;

      Buffer2 := TBitMap.Create;
      Buffer2.Width := RectWidth(SR);
      Buffer2.Height := RectHeight(SR);

      Buffer2.Canvas.CopyRect(Rect(0, 0, Buffer2.Width, Buffer2.Height),
       Picture.Canvas, SR);

      Buffer2.Transparent := True;
      Buffer2.TransparentMode := tmFixed;
      Buffer2.TransparentColor := MenuMarkerTransparentColor;

      X := RectWidth(BR) div 2 - RectWidth(SR) div 2;
      Y := RectHeight(BR) div 2 - RectHeight(SR) div 2 + 1;
      Buffer.Canvas.Draw(X, Y, Buffer2);
      Buffer2.Free;
    end
    else 
      DrawArrowImage(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height), C, 4);
    MainBuffer.Canvas.Draw(BR.Left, BR.Top, Buffer);
  end;
  Buffer.Free;
  {$IFDEF LOOKUP_SUPPORT}
  if FControl is TDBLookUpComboBox
  then
    begin
      R := Rect(3, 0, GetButtonRect.Left - 1, Height - 2);
      S := TDBLookUpComboBox(FControl).Text;
      DrawSkinText(MainBuffer.Canvas, S, R, DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_LEFT));
    end;
  {$ENDIF}

  if (SendMessage(Handle, CB_GETCURSEL, 0, 0) >= 0) or (Style = csDropDown) or
     (Style = csSimple)
  then
    ExcludeClipRect(Canvas.Handle, 3, 3, GetButtonRect.Left - 1, Height - 3);

  Canvas.Draw(0, 0, MainBuffer);
  MainBuffer.Free;

  if not AUseExternalDC
  then
    ReleaseDC(Handle, Canvas.Handle);

  Canvas.Handle := 0;
  Canvas.Free;
  Handled := True;
end;

procedure TbsaComboBoxSubclass.DrawItemThemed(Canvas: TCanvas;
  Index: Integer; R: TRect; Selected: Boolean);
var
  DIS: TDrawItemStruct;
begin
  FillChar(DIS, SizeOf(DIS), 0);
  DIS.hDC := Canvas.Handle;
  DIS.rcItem := R;
  DIS.itemID := Index;
  if Selected
  then
    DIS.itemState := DIS.itemState or ODS_SELECTED or ODS_FOCUS;
  SendMessage(Handle, WM_DRAWITEM, Handle, Integer(@DIS));
end;

procedure TbsaComboBoxSubclass.Paint(Canvas: TCanvas);
var
  R: TRect;
begin
  if not FManager.IsSkinAvailable then Exit;
  DrawBorder(0, False);
  if ComboBox <> nil
  then
    if not (Style in [csDropDown, csSimple]) and (ComboBox.ItemIndex >= 0) and
       not DroppedDown
    then
      begin
        R := Rect(3, 3, GetButtonRect.Left - 1, Height - 3);
        DrawItemThemed(Canvas, ComboBox.ItemIndex, R, Focused);
      end;
end;

procedure TbsaComboBoxSubclass.WMMouseMove(var Msg: TWMMouse);
var
  P: TPoint;
  R: TRect;
begin
  CallDefaultProc(TMessage(Msg));
  P := Point(Msg.XPos, Msg.YPos);
  if PtInRect(GetButtonRect, P) and not FMouseOnButton
  then
    begin
      FMouseOnButton := True;
      R := GetButtonRect;
      {$IFDEF LOOKUP_SUPPORT}
      if FControl is TDBLookUpComboBox
      then
        FControl.Invalidate
      else
      {$ENDIF}
      InvalidateRect(Handle, @R, False);
    end
  else
  if not PtInRect(GetButtonRect, P) and FMouseOnButton
  then
    begin
      FMouseOnButton := False;
      {$IFDEF LOOKUP_SUPPORT}
      if FControl is TDBLookUpComboBox
      then
        FControl.Invalidate
      else
      {$ENDIF}
      InvalidateRect(Handle, @R, False);
    end;
  Handled := True;
end;

procedure TbsaComboBoxSubclass.DrawSkinItem(Cnvs: TCanvas; itemID: Integer; rcItem: TRect;
                                                  State: TOwnerDrawState);
var
  Buffer: TBitMap;
  R: TRect;
  W, H: Integer;
  CIndex, IX, IY, IIndex, Off: Integer;
  ListBoxData: TbsDataSkinListBox;
  Picture: TBitMap;
begin
  if ComboBox = nil then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('listbox');
    if CIndex = -1 then Exit;
    ListBoxData := TbsDataSkinListBox(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ListBoxData.PictureIndex]);
  end;
  //
  Buffer := TBitMap.Create;
  with ListBoxData do
  begin
    W := RectWidth(rcItem);
    H := RectHeight(rcItem);
    Buffer.Width := W;
    Buffer.Height := H;
    R := Rect(ItemLeftOffset, 3,  RectWidth(SItemRect) - ItemRightOffset, RectHeight(SItemRect) - 3);
    if odFocused in State
    then
      CreateStretchImage(Buffer, Picture, FocusItemRect, R, True)
    else
    if odSelected in State
    then
      CreateStretchImage(Buffer, Picture, ActiveItemRect, R, True)
    else
      CreateStretchImage(Buffer, Picture, SItemRect, R, True);
    R := ItemTextRect;
    Inc(R.Right, W - RectWidth(SItemRect));
    Inc(R.Bottom, RectHeight(rcItem) - RectHeight(SItemRect));
  end;

  with Buffer.Canvas do
  begin
    //
    if Focused and ListBoxData.ShowFocus and (odFocused in State)
    then
      begin
        Brush.Style := bsSolid;
        Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
        DrawSkinFocusRect(Buffer.Canvas, Rect(0, 0, Buffer.Width, Buffer.Height));
        Brush.Style := bsClear;
     end;
    //
    Font.Assign(TbsaSubclassHackControl(Control).Font);
    if not ComboBox.Enabled
    then
      Font.Color := clGrayText
    else
    if odFocused in State
    then
      Font.Color := ListBoxData.FocusFontColor
    else
    if odSelected in State
    then
      Font.Color := ListBoxData.ActiveFontColor
    else
      Font.Color := ListBoxData.FontColor;
    Brush.Style := bsClear;
    // draw text
    if (Combobox <>  nil)
    then
      with ListBoxData do
      begin
        R := ItemTextRect;
        Inc(R.Right, W - RectWidth(SItemRect));
        Inc(R.Bottom, RectHeight(rcItem) - RectHeight(SItemRect));
        DrawSkinText(Buffer.Canvas, ComboBox.Items[itemID],
          R, DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_LEFT));
      end;
    //
  end;
  Cnvs.Draw(rcItem.Left, rcItem.Top, Buffer);
  Buffer.Free;
end;

procedure TbsaComboBoxSubclass.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
  Canvas: TCanvas;
  R: TRect;
begin
  if (TbsaSubclassHackCustomComboBox(Control).Style = csDropDown) or
     (TbsaSubclassHackCustomComboBox(Control).Style = csDropDownList) or
     (TbsaSubclassHackCustomComboBox(Control).Style = csOwnerDrawFixed)
  then
    begin
      CallDefaultProc(TMessage(Message));
      Handled := True;
      Exit;
    end;
  with Message.DrawItemStruct^ do
  begin
    State := TOwnerDrawState(LongRec(itemState).Lo);
    if itemState and ODS_COMBOBOXEDIT <> 0 then
      Include(State, odComboBoxEdit);
    if itemState and ODS_DEFAULT <> 0 then
      Include(State, odDefault);
    Canvas := TCanvas.Create;
    Canvas.Handle := hDC;
    if Integer(itemID) >= 0
    then
      begin
        DrawSkinItem(Canvas, itemID,  rcItem,  State);
      end;
    Canvas.Handle := 0;
    Canvas.Free;
  end;
  Handled := True;
end;     


procedure TbsaComboBoxSubclass.WMDrawItem(var Message: TWMDrawItem);
begin
  CallDefaultProc(TMessage(Message));
  Handled := True;
end;

procedure TbsaComboBoxSubclass.WMPaint(var Msg: TMessage);
begin
  inherited;
end;

procedure TbsaComboBoxSubclass.CNCtlColorEdit(var Msg: TWMCTLCOLOREDIT);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

procedure TbsaComboBoxSubclass.CNCtlColorStatic(var Msg: TWMCTLCOLORSTATIC);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
end;

{ TbsaComboListBoxSubclass ==========================================================}

constructor TbsaComboListBoxSubclass.Create;
begin
  inherited;
  SkinCtrl := nil;
  FOverridedEraseBkgnd := False;
  OldTopIndex := -1;
  FOldY := -1;
end;

procedure TbsaComboListBoxSubclass.SetHandle(const Value: HWnd);
begin
  inherited;
end;

procedure TbsaComboListBoxSubclass.BeforeSkinChange;
begin
  SkinCtrl := nil;
end;

procedure TbsaComboListBoxSubclass.SkinChange;
var
  FIndex: Integer;
begin
  inherited;
  SkinCtrl := nil;
  if FManager <> nil
  then
   if FManager.Adapter.SkinData <> nil then
     FIndex := FManager.Adapter.SkinData.GetControlIndex(FManager.Adapter.VScrollSkinDataName);
    if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl then
      SkinCtrl := TbsDataSkinScrollBarControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]);
end;


procedure TbsaComboListBoxSubclass.PostAction;
var
  FIndex: Integer;
begin
  inherited;
  SkinCtrl := nil;
  if FManager <> nil
  then
   if FManager.Adapter.SkinData <> nil then
     FIndex := FManager.Adapter.SkinData.GetControlIndex(FManager.Adapter.VScrollSkinDataName);
    if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl then
      SkinCtrl := TbsDataSkinScrollBarControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]);
end;

procedure TbsaComboListBoxSubclass.WMNCCalcSize(var Msg: TWMNCCalcSize);
var
  rgrc: PNCCalcSizeParams;
  WP: PWindowPos;
  m_lLeft, m_lRight, m_lTop, m_lBottom: Integer;
  S, nS: Integer;
begin
  S := GetWindowLong(Handle, GWL_STYLE);
  if ((S and WS_VSCROLL = WS_VSCROLL) or (S and WS_HSCROLL = WS_HSCROLL)) then
  begin
    nS := S and not WS_VSCROLL and not WS_HSCROLL;
    FIgnoreStyleChanged := True;
    SetWindowLong(Handle, GWL_STYLE, nS);
    CallDefaultProc(TMessage(Msg));
    SetWindowLong(Handle, GWL_STYLE, S);
    FIgnoreStyleChanged := False;
  end;

  if (Msg.CalcValidRects) then
  begin
    rgrc := Msg.CalcSize_Params;

    m_lLeft := 1;
    if S and WS_VSCROLL = WS_VSCROLL then
      m_lRight := RectWidth(VScrollRect) + 1
    else
      m_lRight := 1;
    m_lTop := 1;
    m_lBottom := 1;

    WP := rgrc.lppos;
    with rgrc^.rgrc[0] do
    begin
      left := WP^.x;
      top := WP^.y;
      right := WP^.x + WP^.cx;
      bottom := WP^.y + WP^.cy;
      left := left + m_lLeft;
      top := top + m_lTop;
      right := right - m_lRight;
      bottom := bottom - m_lBottom;
    end;
    rgrc^.rgrc[1] := rgrc^.rgrc[0];
    Msg.CalcSize_Params := rgrc;
    Msg.Result := WVR_VALIDRECTS;
  end;

  { Set handled flag }
  Msg.Result := 0;
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.PaintBorder(Canvas: TCanvas; R: TRect);
begin
  if FManager.FAdapter.SkinData <> nil
  then
    Canvas.Pen.color := FManager.FAdapter.SkinData.SkinColors.cBtnShadow
  else
    Canvas.Pen.color := clWindowFrame;
  if FManager.FAdapter.SkinData <> nil
  then
    Canvas.Brush.color := FManager.FAdapter.SkinData.SkinColors.cWindow
  else
    Canvas.Brush.color := clWindow;
  Canvas.Rectangle(r.left, r.top , r.right , r.bottom);
end;

procedure TbsaComboListBoxSubclass.WMPrint(var Msg: TMessage);
var
  S: Integer;
  C: TCanvas;
  R: TRect;
begin
  CallDefaultProc(Msg);
  if (Msg.LParam and PRF_NONCLIENT = PRF_NONCLIENT) and (Msg.wParam <> 0) then
  begin
    C := TCanvas.Create;
    C.Handle := Msg.wParam;
    { Draw border }
    S := SaveDC(C.Handle);
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    ExcludeClipRect(C.Handle, R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom - 2);
    PaintBorder(C, R);
    RestoreDC(C.Handle, S);
    { draw scroll }
    VDrawScroll(Msg.wParam);
    C.Handle := 0;
    C.Free;
  end;
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMPrintClient(var Msg: TMessage);
begin
  CallDefaultProc(Msg);
  Handled := True;
end;

function TbsaComboListBoxSubclass.VScrollArea: TRect;
begin
  if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL = 0 then
  begin
    Result := Rect(0, 0, 0, 0);
    Exit;
  end;
  Result := GetBoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  Result.Left := Result.Right - GetSystemMetrics(SM_CYVSCROLL) - 1;
end;

function TbsaComboListBoxSubclass.VScrollRect: TRect;
begin
  Result := GetBoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  InflateRect(Result, -1, -1);
  if HaveBorder then
    OffsetRect(Result, 1, 1);
  Result.Left := Result.Right - GetSystemMetrics(SM_CYVSCROLL);
end;

function TbsaComboListBoxSubclass.VSliderRect: TRect;
var
  i, vh, allh, size, j, k, c: Integer;
begin
  if not Enabled then
    Result := NullRect
  else
  begin
    Result := VScrollRect;
    Result.Top := VTrackRect.Top;
    Result.Bottom := VTrackRect.Bottom;
    size := Result.Bottom - Result.Top;
    c := SendMessage(Handle, LB_GETCOUNT, 0, 0) * size;
    if c = 0 then Exit;
    Result.Top := Result.Top +
    round((SendMessage(Handle, LB_GETTOPINDEX, 0, 0) / SendMessage(Handle, LB_GETCOUNT, 0, 0)) * size);
//  if SliderSize = 0 then
    begin
      allh := 1;
      InvsibleCount := 0;
      for i := 0 to SendMessage(Handle, LB_GETCOUNT, 0, 0) - 1 do
      begin
        allh := allh + SendMessage(Handle, LB_GETITEMHEIGHT, i, 0);
        if (allh > Height) and (InvsibleCount = 0) then
        begin
          InvsibleCount := SendMessage(Handle, LB_GETCOUNT, 0, 0) - i;
        end;
      end;
      vh := 0;
      for i := SendMessage(Handle, LB_GETTOPINDEX, 0, 0) to SendMessage(Handle, LB_GETCOUNT, 0, 0) - 1 do
      begin
        vh := vh + SendMessage(Handle, LB_GETITEMHEIGHT, i, 0);
        if vh >= Height - 2 then break;
      end;
      Result.Bottom := Result.Top + round((vh / allh) * size);
      if (i = SendMessage(Handle, LB_GETCOUNT, 0, 0) - 1) and
         (Result.Bottom <> VTrackRect.Bottom)
      then
        begin
          k := RectHeight(Result);
          Result.Bottom := VTrackRect.Bottom;
          Result.Top := Result.Bottom - k;
        end;
      SliderSize := round((vh / allh) * size);
    end;

    if SkinCtrl <> nil
    then
      begin
        j := RectHeight(Result);
        if SkinCtrl.ThumbMinSize <> 0
          then k := SkinCtrl.ThumbMinSize else k := RectHeight(SkinCtrl.ThumbRect);
        if j < k
        then
          begin
            Result := VScrollRect;
            Result.Top := VTrackRect.Top;
            Result.Bottom := VTrackRect.Bottom - (k - j) + 1;
            size := Result.Bottom - Result.Top;
            Result.Top := Result.Top + round((SendMessage(Handle, LB_GETTOPINDEX, 0, 0) / SendMessage(Handle, LB_GETCOUNT, 0, 0)) * size);
           //    if SliderSize = 0 then
           begin
             allh := 1;
             InvsibleCount := 0;
             for i := 0 to SendMessage(Handle, LB_GETCOUNT, 0, 0) - 1 do
             begin
               allh := allh + SendMessage(Handle, LB_GETITEMHEIGHT, i, 0);
               if (allh > Height) and (InvsibleCount = 0) then
               begin
                 InvsibleCount := SendMessage(Handle, LB_GETCOUNT, 0, 0) - i;
               end;
             end;
             vh := 0;
             for i := SendMessage(Handle, LB_GETTOPINDEX, 0, 0) to SendMessage(Handle, LB_GETCOUNT, 0, 0) - 1 do
             begin
               vh := vh + SendMessage(Handle, LB_GETITEMHEIGHT, i, 0);
               if vh >= Height - 2 then break;
             end;
            Result.Bottom := Result.Top + round((vh / allh) * size);
            SliderSize := round((vh / allh) * size);
            //
            Result.Bottom := Result.Top + k;
            //
          end;
        end;
      end;
      if HaveBorder then  OffsetRect(Result, 1, 1);
   end;
 end;

function TbsaComboListBoxSubclass.VTrackRect: TRect;
begin
  Result := VScrollRect;
  if RectWidth(Result) > 0 then
  begin
    if SkinCtrl <> nil
    then
      begin
        Result.Left := SkinCtrl.TrackArea.Left;
        Result.Right := Result.Right -
         (RectWidth(SkinCtrl.SkinRect) - SkinCtrl.TrackArea.Right);
        Result.Top := Result.Top + SkinCtrl.TrackArea.Top;
        Result.Bottom := Result.Bottom -
         (RectHeight(SkinCtrl.SkinRect) - SkinCtrl.TrackArea.Bottom);
       end
    else
      begin
        Result.Top := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
        Result.Bottom := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB);
      end;
  end
  else
    Result := NullRect;
end;

function TbsaComboListBoxSubclass.VUpButtonRect: TRect;
begin
  Result := VScrollRect;
  if RectWidth(Result) > 0 then
  begin
    if SkinCtrl <> nil
    then
      Result.Bottom := Result.Top + SkinCtrl.DownButtonRect.Bottom
    else
      Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
  end
  else
    Result := NullRect;
end;

function TbsaComboListBoxSubclass.VDownButtonRect: TRect;
begin
  Result := VScrollRect;
  if RectWidth(Result) > 0 then
  begin
    if SkinCtrl <> nil
    then
      Result.Top := Result.Bottom -
        (RectHeight(SkinCtrl.SkinRect) - SkinCtrl.UpButtonRect.Top)
    else
      Result.Top := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB);
  end
  else
    Result := NullRect;
end;

procedure TbsaComboListBoxSubclass.VDrawScroll(DC: HDC = 0);
var
  R, R1: TRect;
  Canvas: TCanvas;
  Buf, Buf1, Buf2, Buf3: TBitmap;
  P: TPoint;
  Picture: TBitMap;
  FIndex, X, Y: Integer;
begin
  if Handle = 0 then Exit;
  if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL = 0 then Exit;
  if RectWidth(VScrollRect) <= 0 then Exit;

  Canvas := TCanvas.Create;
  if DC <> 0 then
    Canvas.Handle := DC
  else
    Canvas.Handle := GetWindowDC(Handle);

  FIndex := -1;
  if FManager.Adapter.SkinData <> nil then
    FIndex := FManager.Adapter.SkinData.GetControlIndex(FManager.Adapter.VScrollSkinDataName);

  SkinCtrl := nil;

  if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl then
  begin
    with TbsDataSkinCustomControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) do
    begin
      if (PictureIndex <> -1) and (PictureIndex < FManager.Adapter.SkinData.FActivePictures.Count) then
        Picture := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[PictureIndex]);
    end;
  end;
  if TbsDataSkinControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]) is TbsDataSkinCustomControl then
    SkinCtrl := TbsDataSkinScrollBarControl(FManager.Adapter.SkinData.CtrlList.Items[FIndex]);

  if SkinCtrl = nil
  then
    begin
      if DC <> 0 then Canvas.Handle := 0
      else
        begin
          ReleaseDC(Handle, Canvas.Handle);
          Canvas.Handle := 0;
        end;
      Canvas.Free;
      Exit;
    end;


  Buf := TBitmap.Create;
  Buf.Width := RectWidth(VScrollRect);
  Buf.Height :=  RectHeight(VScrollRect);
  with Buf.Canvas do
  begin
    Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
    FillRect(Rect(0, 0, Buf.Width, Buf.Height));
  end;
  //
  Buf1 := TBitMap.Create;
  Buf1.Width := RectWidth(SkinCtrl.SkinRect);
  Buf1.Height := Buf.Height;
  with SkinCtrl do
  // client
  CreateVSkinImage(LTPoint.Y, RectHeight(SkinRect) - LBPoint.Y,
        Buf1, Picture, SkinRect, Buf1.Width, Buf1.Height, StretchEffect);
  // buttons
  if (VUpState = bsasbPressed)
  then
    begin
      R1 := SkinCtrl.DownDownButtonRect;
      if IsNullRect(R1) then R1 := SkinCtrl.ActiveDownButtonRect;
    end
  else
   if (VUpState = bsasbHot) and (not IsNullRect(SkinCtrl.ActiveDownButtonRect))
   then
     begin
       R1 := SkinCtrl.ActiveDownButtonRect;
     end  
   else
     begin
       R1 := NullRect;
       OffsetRect(R1, SkinCtrl.SkinRect.Left, SkinCtrl.SkinRect.Top);
     end;

  if not IsNullRect(R1)
  then
    begin
      R := SkinCtrl.DownButtonRect;
      Buf1.Canvas.CopyRect(R, Picture.Canvas, R1);
    end;

  if (VDownState = bsasbPressed)
  then
    begin
      R1 := SkinCtrl.DownUpButtonRect;
      if IsNullRect(R1) then R1 := SkinCtrl.ActiveUpButtonRect;
    end
  else
   if (VDownState = bsasbHot) and (not IsNullRect(SkinCtrl.ActiveUpButtonRect))
   then
     R1 := SkinCtrl.ActiveUpButtonRect
   else
     R1 := NullRect;

  if not IsNullRect(R1)
  then
    begin
      R := SkinCtrl.UpButtonRect;
      OffsetRect(R, 0, Buf1.Height - RectHeight(SkinCtrl.SkinRect));
      Buf1.Canvas.CopyRect(R, Picture.Canvas, R1);
    end;

  // thumb
  Buf2 := TBitmap.Create;
  Buf2.Width := RectWidth(SkinCtrl.SkinRect);
  Buf2.Height := RectHeight(VSliderRect);
  // create thumb image
  if (VSliderState = bsasbPressed)
  then
    begin
      if not IsNullRect(SkinCtrl.DownThumbRect)
      then
        R1 := SkinCtrl.DownThumbRect
      else
      if not IsNullRect(SkinCtrl.ActiveThumbRect)
      then
        R1 := SkinCtrl.ActiveThumbRect
      else
        R1 := SkinCtrl.ThumbRect;
    end
  else
   if (VSliderState = bsasbHot) and (not IsNullRect(SkinCtrl.ActiveThumbRect))
   then
     R1 := SkinCtrl.ActiveThumbRect
   else
     R1 := SkinCtrl.ThumbRect;
  CreateVSkinImage(SkinCtrl.ThumbOffset1, SkinCtrl.ThumbOffset2,
        Buf2, Picture, R1, Buf2.Width, Buf2.Height, SkinCtrl.ThumbStretchEffect);
  //  draw thumb glyph
  R1 := NullRect;
  if (VSliderState = bsasbPressed)
  then
    begin
      if not IsNullRect(SkinCtrl.DownGlyphRect)
      then
        R1 := SkinCtrl.DownGlyphRect
      else
      if not IsNullRect(SkinCtrl.ActiveGlyphRect)
      then
        R1 := SkinCtrl.ActiveGlyphRect
      else
        R1 := SkinCtrl.GlyphRect;
    end
  else
   if (VSliderState = bsasbHot)
   then
     begin
       if not IsNullRect(SkinCtrl.ActiveGlyphRect)
       then
         R1 := SkinCtrl.ActiveGlyphRect
       else
         R1 := SkinCtrl.GlyphRect;
     end  
   else
   if (VSliderState = bsasbNormal) and (not IsNullRect(SkinCtrl.GlyphRect))
   then
     R1 := SkinCtrl.GlyphRect;
  if not IsNullRect(R1) and (RectHeight(R1) < Buf2.Height + 2)
  then
    begin
      Buf3 := TBitMap.Create;
      Buf3.Width := RectWidth(R1);
      Buf3.Height := RectHeight(R1);
      Buf3.Canvas.CopyRect(Rect(0, 0, Buf3.Width, Buf3.Height),
        Picture.Canvas, R1);
      if SkinCtrl.GlyphTransparent
      then
        begin
          Buf3.Transparent := True;
          Buf3.TransparentMode := tmFixed;
          Buf3.TransparentColor := SkinCtrl.GlyphTransparentColor;
        end;
      X := Buf2.Width div 2 - Buf3.Width div 2;
      Y := Buf2.Height div 2 - Buf3.Height div 2;
      Buf2.Canvas.Draw(X, Y, Buf3);
      Buf3.Free;
    end;   
  //
  if SkinCtrl.ThumbTransparent
  then
    begin
      Buf2.Transparent := True;
      Buf2.TransparentMode := tmFixed;
      Buf2.TransparentColor := SkinCtrl.ThumbTransparentColor;
    end;
  //
  X := SkinCtrl.TrackArea.Left + RectWidth(SkinCtrl.TrackArea) div 2 -
       RectWidth(SkinCtrl.ThumbRect) div 2;
  if X < 0 then X := 0;     
  MoveWindowOrg(Buf1.Canvas.Handle, -VScrollRect.Left, -VScrollRect.Top);
  Buf1.Canvas.Draw(VSliderRect.Left + X, VSliderRect.Top, Buf2);
  MoveWindowOrg(Buf1.Canvas.Handle, VScrollRect.Left, VScrollRect.Top);
  Buf2.Free;
  //
  X := Buf.Width - Buf1.Width;
  if X < 0 then X := 0;
  Buf.Canvas.Draw(X, 0, Buf1);
  Buf1.Free;
  //
  Canvas.Draw(VScrollRect.Left, VScrollRect.Top, Buf);
  Buf.Free;

  if DC <> 0 then
    Canvas.Handle := 0
  else
  begin
    ReleaseDC(Handle, Canvas.Handle);
    Canvas.Handle := 0;
  end;
  Canvas.Free;
end;

procedure TbsaComboListBoxSubclass.DrawBorder;
var
  R: TRect;
  Canvas: TCanvas;
  SaveIdx: Integer;
  P: TPoint;
begin
  if Handle = 0 then Exit;

  Canvas := TCanvas.Create;
  Canvas.Handle := GetWindowDC(Handle);

  R := GetBoundsRect;
  if (RectWidth(R) < 5000) and (RectHeight(R) < 5000) then
  begin
    ExcludeClipRect(Canvas.Handle, 1, 1, R.Right - 1, R.Bottom - 1);
    SaveIdx := SaveDC(Canvas.Handle);
    with VSliderRect do
      ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
    PaintBorder(Canvas, R);
    RestoreDC(Canvas.Handle, SaveIdx);
    VDrawScroll(Canvas.Handle);
  end;

  ReleaseDC(Handle, Canvas.Handle);

  Canvas.Handle := 0;
  Canvas.Free;

end;

procedure TbsaComboListBoxSubclass.WMChar(var Msg: TWMKeyUp); 
var
  R: TRect;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  R := Rect(0, 0, VScrollRect.right, Height);
  RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
  VDrawScroll(0);
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMKeyDown(var Msg: TWMKeyDown);
var
  R: TRect;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  R := Rect(0, 0, VScrollRect.right, Height);
  RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
  VDrawScroll(0);
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMKeyUp(var Msg: TWMKeyUp); 
var
  R: TRect;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  CallDefaultProc(TMessage(Msg));
  SendMessage(Handle, WM_SETREDRAW, 1, 0);
  R := Rect(0, 0, VScrollRect.right, Height);
  RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
  VDrawScroll(0);
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMMouseWheel(var Msg: TWMMouseWheel);
var
  R: TRect;
  Cur1, Cur2: Integer;
begin
  if Msg.WheelDelta > 0
  then
    begin
      SendMessage(Handle, LB_SETTOPINDEX, SendMessage(Handle, LB_GETTOPINDEX, 0, 0) - 1, 0);
    end
  else
    begin
      SendMessage(Handle, LB_SETTOPINDEX, SendMessage(Handle, LB_GETTOPINDEX, 0, 0) + 1, 0);
    end;
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMNCLButtonDblClk(var Msg: TWMMouse);
var
  P: TPoint;
  R: TRect;
begin
  FDown := False;
  if PtInRect(VScrollArea, P) then
  begin
    if PtInRect(VUpButtonRect, Point(Msg.XPos, Msg.YPos)) then
    begin
      SendMessage(Handle, LB_SETTOPINDEX, SendMessage(Handle, LB_GETTOPINDEX, 0, 0) - 1, 0);
    end;
    if PtInRect(VDownButtonRect, Point(Msg.XPos, Msg.YPos)) then
    begin
      SendMessage(Handle, LB_SETTOPINDEX, SendMessage(Handle, LB_GETTOPINDEX, 0, 0) + 1, 0);
    end;
    VDrawScroll(0);
  end;
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMNCLButtonDown(var Msg: TWMMouse);
var
  P: TPoint;
begin
  SetCapture(Handle);
  P := Point(Msg.XPos, Msg.YPos);
  ScreenToClient(Handle, P);
  with P do
  begin
    Msg.XPos := X;
    Msg.YPos := Y;
  end;
  WMLButtonDown(Msg);
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMLButtonDown(var Msg: TWMMouse);
var
  R: TRect;
  P: TPoint;
begin
  FDown := True;
  P := Point(Msg.XPos, Msg.YPos);
  FOldY := Msg.YPos;
  if PtInRect(VScrollArea, P) then
  begin
    DownPos := P;
    if PtInRect(VSliderRect, P) then
    begin
      VSliderState := bsasbPressed;
      DownSliderPos := DownPos.Y - VSliderRect.Top;
      VDrawScroll(0);
    end;
    if PtInRect(VDownButtonRect, P) then
    begin
      VDownState := bsasbPressed;
      VDrawScroll(0);
    end;
    if PtInRect(VUpButtonRect, P) then
    begin
      VUpState := bsasbPressed;
      VDrawScroll(0);
    end;
    Handled := True;
  end
  else
  begin
    if (VSliderState <> bsasbNormal) or (VUpState <> bsasbNormal) or (VUpState <> bsasbNormal) then
    begin
      VSliderState := bsasbNormal;
      VUpState := bsasbNormal;
      VDownState := bsasbNormal;
      VDrawScroll(0);
    end;
  end;
  if RectWidth(VScrollArea) <> 0 then  VDrawScroll(0);
end;

procedure TbsaComboListBoxSubclass.WMMouseMove(var Msg: TWMMouse);
var
  P: TPoint;
  Newcur, Cur: Integer;
  Dist: Integer;
  i, vh, allh, size, SPos, C, VisibleCount, IH, I1, I2: Integer;
  R: TRect;
  DC: Cardinal;
begin
  P := Point(Msg.XPos, Msg.YPos);
  C := SendMessage(Handle, LB_GETCOUNT, 0, 0);
  Cur := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
  IH := SendMessage(Handle, LB_GETITEMHEIGHT, 0, 0);
  if IH = 0 then IH := 1;
  VisibleCount := Height div IH;

  MovePos := P;

  if (VSliderState = bsasbPressed)
  then
    begin
      Dist := RectHeight(VTrackRect) - RectHeight(VSliderRect);
      if Dist > 0
      then
        begin
          NewCur := round((((MovePos.y - DownSliderPos - VTrackRect.Top) / Dist) * InvsibleCount));
          if (Cur = C - VisibleCount) and (NewCur >= C - VisibleCount)
          then
            begin
            end
          else
          if (NewCur <> Cur) and (NewCur >= 0) and (NewCur < C)
          then
            SendMessage(Handle, LB_SETTOPINDEX, NewCur, 0);
         end;
      Handled := True;
      Exit;
    end
  else
  if FDown
  then
    begin
      if (P.Y > 0) and (P.Y < Height)
      then
        begin
          I := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(P.X, P.Y));
          SendMessage(Handle, LB_SETCURSEL, I, 0);
        end
      else
      if (P.Y < 0) and (P.Y < FOldY) and (C > VisibleCount)
      then 
        begin
          I := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
          I1 := I - Abs(FOldY - P.Y);
          if (I1 >= 0) and (I <> I1)
          then
            begin
              SendMessage(Handle, LB_SETTOPINDEX, I1, 0);
              SendMessage(Handle, WM_SETREDRAW, 0, 0);
              SendMessage(Handle, LB_SETCURSEL, I1, 0);
              SendMessage(Handle, WM_SETREDRAW, 1, 0);
              R := Rect(0, 0, VScrollRect.right, Height);
              RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
              VDrawScroll(0);
            end;
        end
      else
      if (P.Y > Height) and (P.Y > FOldY) and (C > VisibleCount)
      then
        begin
          I := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
          I1 := I + VisibleCount + Abs(FOldY - P.Y);
          if (I1 <= C) and (I <> I1)
          then
            begin
              SendMessage(Handle, LB_SETTOPINDEX, I + Abs(FOldY - P.Y), 0);
              SendMessage(Handle, WM_SETREDRAW, 0, 0);
              SendMessage(Handle, LB_SETCURSEL, I1, 0);
              SendMessage(Handle, WM_SETREDRAW, 1, 0);
              RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
              VDrawScroll(0);
            end;
         end;
      Handled := True;
      FOldY := P.Y;
    end;

  if PtInRect(VScrollArea, P) then
  begin
    if PtInRect(VSliderRect, P) and (VSliderState = bsasbNormal) then
    begin
      VSliderState := bsasbHot;
      VDrawScroll(0);
    end;
    if not PtInRect(VSliderRect, P) and (VSliderState = bsasbHot) then
    begin
      VSliderState := bsasbNormal;
      VDrawScroll(0);
    end;
    if PtInRect(VUpButtonRect, P) and (VUpState = bsasbNormal) then
    begin
      VUpState := bsasbHot;
      VDrawScroll(0);
    end;
    if not PtInRect(VUpButtonRect, P) and (VUpState = bsasbHot) then
    begin
      VUpState := bsasbNormal;
      VDrawScroll(0);
    end;
    if PtInRect(VDownButtonRect, P) and (VDownState = bsasbNormal) then
    begin
      VDownState := bsasbHot;
      VDrawScroll(0);
    end;
    if not PtInRect(VDownButtonRect, P) and (VDownState = bsasbHot) then
    begin
      VDownState := bsasbNormal;
      VDrawScroll(0);
    end;
    Handled := True;
  end
  else
  begin
    if (VSliderState <> bsasbNormal) or (VUpState <> bsasbNormal) or (VUpState <> bsasbNormal) then
    begin
      VSliderState := bsasbNormal;
      VUpState := bsasbNormal;
      VDownState := bsasbNormal;
      VDrawScroll(0);
    end;
  end;

end;

procedure TbsaComboListBoxSubclass.WMLButtonUp(var Msg: TWMMouse);
var
  R: TRect;
begin
  FDown := False;
  if (VSliderState = bsasbPressed) or (VDownState = bsasbPressed) or (VUpState = bsasbPressed) then
  begin
    Handled := True;
    if VSliderState = bsasbPressed then VSliderState := bsasbHot else  VSliderState := bsasbNormal;
    if VUpState = bsasbPressed then VUpState := bsasbHot else VUpState := bsasbNormal;
    if VDownState = bsasbPressed then VDownState := bsasbHot else VDownState := bsasbNormal;
    if PtInRect(VUpButtonRect, Point(Msg.XPos, Msg.YPos)) then
    begin
      SendMessage(Handle, LB_SETTOPINDEX, SendMessage(Handle, LB_GETTOPINDEX, 0, 0) - 1, 0);
      Handled := True;
    end;
    if PtInRect(VDownButtonRect, Point(Msg.XPos, Msg.YPos)) then
    begin
      SendMessage(Handle, LB_SETTOPINDEX, SendMessage(Handle, LB_GETTOPINDEX, 0, 0) + 1, 0);
      Handled := True;
    end;
    VDrawScroll(0);
  end;
end;

procedure TbsaComboListBoxSubclass.WMPaint(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  if IsWindowVisible(Handle) then VDrawScroll(0);
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.WMNCPaint(var Msg: TWMNCPaint);
begin
  if IsWindowVisible(Handle) then DrawBorder;
  Handled := True;
end;

procedure TbsaComboListBoxSubclass.LBSETTOPINDEX(var Msg: TMessage);
var
  R: TRect;
  C, CUr, IH, VisibleCount: Integer;
begin
  C := SendMessage(Handle, LB_GETCOUNT, 0, 0);
  Cur := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
  IH := SendMessage(Handle, LB_GETITEMHEIGHT, 0, 0);
  if IH = 0 then IH := 1;
  VisibleCount := Height div IH;
  if (OldTopIndex = C - VisibleCount) and (Msg.WParam >= C - VisibleCount)
  then
    begin
    end
  else
  if (Msg.WParam <> OldTopIndex) and (Msg.WParam >= 0) and (Msg.WParam < C)
  then
    begin
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
      CallDefaultProc(Msg);
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      R := Rect(0, 0, VScrollRect.right, Height);
      RedrawWindow(Handle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
      VDrawScroll(0);
    end
  else
    VDrawScroll(0);
  OldTopIndex := Msg.WParam;
  Handled := True;
end;

{ TbsaListViewSubclass =========================================================}

constructor TbsaListViewSubclass.Create;
begin
  inherited;
  FHeaderInstance := MakeObjectInstance(HeaderWndProc);
  FPressedSection := -1;
  FHeaderHandle := 0;
end;

destructor TbsaListViewSubclass.Destroy;
begin
  if FHeaderHandle <> 0 then
    SetWindowLong(FHeaderHandle, GWL_WNDPROC, LongInt(FDefHeaderProc));
  FreeObjectInstance(FHeaderInstance);
  inherited;
end;

procedure TbsaListViewSubclass.CMSEPaint(var Message: TMessage);
begin
  if FHeaderHandle <> 0 then PaintHeader(Message.WParam);
end;

procedure TbsaListViewSubclass.SkinChange;
var
  H: HWnd;
begin
  inherited;
  if FHeaderHandle <> 0
  then
    Windows.RedrawWindow(FHeaderHandle, nil, 0, RDW_ERASE or RDW_INVALIDATE)
  else
    begin
      H := GetWindow(Handle, GW_CHILD);
      if H <> 0
      then
         begin
           FHeaderHandle := H;
           FDefHeaderProc := Pointer(GetWindowLong(FHeaderHandle, GWL_WNDPROC));
           SetWindowLong(FHeaderHandle, GWL_WNDPROC, LongInt(FHeaderInstance));
           if IsWindowVisible(Handle)
           then
             Windows.RedrawWindow(FHeaderHandle, nil, 0, RDW_ERASE or RDW_INVALIDATE);
         end;
    end;
end;

procedure TbsaListViewSubclass.SetControl(const Value: TControl);
begin
  inherited;
end;

procedure TbsaListViewSubclass.WMNotify(var Message: TWMNotify);
var
  H: HWnd;
begin
  if FHeaderHandle = 0 then
  begin
    H := GetWindow(Handle, GW_CHILD);
    if H <> 0
    then
      begin
        FHeaderHandle := H;
        FDefHeaderProc := Pointer(GetWindowLong(FHeaderHandle, GWL_WNDPROC));
        SetWindowLong(FHeaderHandle, GWL_WNDPROC, LongInt(FHeaderInstance));
        if IsWindowVisible(Handle)
        then
          Windows.RedrawWindow(FHeaderHandle, nil, 0, RDW_ERASE or RDW_INVALIDATE);
      end;
  end;
  Handled := False;
end;

procedure TbsaListViewSubclass.HeaderWndProc(var Message: TMessage);
var
  SaveIndex: Integer;
  Info: THDHitTestInfo;
begin
  if not FManager.IsSkinAvailable then
  with Message do
  begin
    Result := CallWindowProc(FDefHeaderProc, FHeaderHandle, Msg, WParam, LParam);
    Exit;
  end;
  try
    with Message do
    begin
      case Msg of
        WM_LBUTTONDOWN:
          begin
            Info.Point.X := TWMMouse(Message).XPos;
            Info.Point.Y := TWMMouse(Message).YPos;
            SendMessage(FHeaderHandle, HDM_HITTEST, 0, Integer(@Info));

            if (Info.Flags and HHT_ONDIVIDER = 0) and
               (Info.Flags and HHT_ONDIVOPEN = 0)
            then
              FPressedSection := Info.Item
            else
              FPressedSection := -1;
            RedrawWindow(FHeaderHandle, 0, 0, RDW_INVALIDATE);
          end;
        WM_LBUTTONUP, WM_RBUTTONUP:
          begin
            FPressedSection := -1;
            RedrawWindow(FHeaderHandle, 0, 0, RDW_INVALIDATE);
            PaintScroll;
          end;
        WM_PAINT:
          begin
            PaintHeader(0);
            Exit;
          end;
        WM_ERASEBKGND:
          begin
            if FManager.IsSkinAvailable then
            begin
              Result := 1;
              Exit;
            end;
          end;
        WM_NCDESTROY:
          begin
            Result := CallWindowProc(FDefHeaderProc, FHeaderHandle, Msg, WParam, LParam);
            FHeaderHandle := 0;
            FDefHeaderProc := nil;
            Exit;
          end;
      end;
      Result := CallWindowProc(FDefHeaderProc, FHeaderHandle, Msg, WParam, LParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

var
  Item, SecItem: THDItem;

procedure TbsaListViewSubclass.PaintHeader(DC: HDC);
var
  Canvas: TCanvas;
  R, HeaderR: TRect;
  PS: TPaintStruct;
  HeaderDC: HDC;
  i, ColumnIndex, RightOffset: Integer;
  SectionOrder: Array of Integer;       
begin
  if DC = 0
  then
    HeaderDC := BeginPaint(FHeaderHandle, PS)
  else
    HeaderDC := DC;
  try
    Canvas := TCanvas.Create;
    Canvas.Handle := HeaderDC;
    RightOffset := 0;

    { Draw sections }
    for i := 0 to Header_GetItemCount(FHeaderHandle) - 1 do
    begin
      if FullDrag then
      begin
        SetLength(SectionOrder, Header_GetItemCount(FHeaderHandle));
        Header_GetOrderArray(FHeaderHandle, Header_GetItemCount(FHeaderHandle), PInteger(SectionOrder));
        ColumnIndex := SectionOrder[I];
        Header_GETITEMRECT(FHeaderHandle, ColumnIndex, @R)
      end
      else
      begin
        ColumnIndex := I;
        Header_GETITEMRECT(FHeaderHandle, ColumnIndex, @R);
      end;
      Header_GetItem(FHeaderHandle, ColumnIndex, Item);
      DrawHeaderSection(Canvas, R, ColumnIndex, Item.pszText,
        FPressedSection = ColumnIndex, FHotSection = ColumnIndex, False);

      if RightOffset < R.Right then RightOffset := R.Right;
    end;

    { Draw background section }
    Windows.GetWindowRect(FHeaderHandle, HeaderR);
    R := Rect(RightOffset, 0, RectWidth(HeaderR) + 2, RectHeight(HeaderR));
    if not IsRectEmpty(R) then
      DrawHeaderSection(Canvas, R, -1, '', False, False, True);

    if DC <> 0 then ReleaseDC(FHeaderHandle, DC);

    Canvas.Handle := 0;
    Canvas.Free;
  finally
    if DC = 0  then EndPaint(FHeaderHandle, PS)
  end;
end;

procedure TbsaListViewSubclass.DrawHeaderSection(Canvas: TCanvas;
  R: TRect; AIndex: Integer; const AText: WideString; Pressed, Hot, IsBackground: Boolean);


procedure CorrectTextbyWidthW(C: TCanvas; var S: WideString; W: Integer);

function GetTextWidth(Str: WideString): Integer;
var
  R: TRect;
begin
  R := Rect(0, 0, 0, 0);
  DrawSkinText(C, Str, R, DT_CALCRECT);
  Result := RectWidth(R);
end;

var
  j: Integer;
begin
  j := Length(S);
  if GetTextWidth(S) > w
  then
   begin
     repeat
       Delete(S, j, 1);
       Dec(j);
     until (GetTextWidth(S + '...') <= w) or (S = '');
    S := S + '...';
  end;
end;

var
  Flags: Cardinal;
  Buffer: TBitMap;
  HeaderData: TbsDataSkinButtonControl;
  CIndex: Integer;
  Picture: TBitmap;
  C: TColor;
  SR, R1: TRect;
  Buf: array [0..128] of Char;
  S: WideString;
begin
  if not FManager.IsSkinAvailable then  Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('resizebutton');
    if CIndex = -1 then Exit;
    HeaderData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[HeaderData.PictureIndex]);
  end;
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  //
  with HeaderData do
  begin
    if Pressed and not IsNullRect(DownSkinRect)
    then
      begin
        SR := DownSkinRect;
        C := DownFontColor;
      end
    else
      begin
        SR := SkinRect;
        C := FontColor;
      end;

    CreateSkinControlImage(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
                           Buffer, Picture, SR,
                           RectWidth(R), RectHeight(R),StretchEffect,
                           LeftStretch, TopStretch, RightStretch, BottomStretch,
                           False, StretchType);
    // draw text
    Buffer.Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
    Buffer.Canvas.Font.Color := C;
  end;
  // draw text
  if AIndex >= 0
  then
    begin
      //
      FillChar(SecItem, SizeOf(SecItem), 0);
      with SecItem do
      begin
        pszText := Buf;
        cchTextMax := SizeOf(Buf) - 1;
        Mask := HDI_TEXT;
      end;
      //
      Header_GetItem(FHeaderHandle, AIndex, SecItem);
      if AIndex < 0
      then
        Flags := DrawTextBiDiModeFlags(DT_VCENTER or DT_SINGLELINE)
      else
      if SecItem.fmt and HDF_RIGHT = HDF_RIGHT
      then
        Flags := DrawTextBiDiModeFlags(DT_RIGHT or DT_VCENTER or DT_SINGLELINE)
      else
      if SecItem.fmt and HDF_CENTER = HDF_CENTER
      then
        Flags := DrawTextBiDiModeFlags(DT_CENTER or DT_VCENTER or DT_SINGLELINE)
      else
        Flags := DrawTextBiDiModeFlags(DT_VCENTER or DT_SINGLELINE);
      R1 := Rect(0, 0, Buffer.Width, Buffer.Height);
      InflateRect(R1, -3, -3);
      S := SecItem.pszText;
      CorrectTextbyWidthW(Buffer.Canvas, S, RectWidth(R1));
      DrawSkinText(Buffer.Canvas, S, R1, Flags);
    end;
  //
  Canvas.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;

function TbsaListViewSubclass.FullDrag: Boolean;
begin
  Result := True;
end;

{ TbsaTabSubclass ==============================================================}

procedure TbsaTabSubclass.PostAction;
var
  Wnd: HWnd;
begin
  inherited;
  Wnd := FindWindowEx(Handle, 0, 'msctls_updown32', nil);
  if (Wnd <> 0) and ((FUpDownHandle = 0) or (FUpDownHandle <> Wnd)) then
  begin
    FUpDownHandle := Wnd;
    FManager.FCurrentSubclass := TbsaUpDownSubclass;
    FManager.FHookCollection.AddControl(FUpdownHandle, FManager.DoHandleMessage, FManager.DoUnhook);
    FManager.FCurrentSubclass := nil;
    Windows.RedrawWindow(Wnd, nil, 0, RDW_INVALIDATE);
  end;
end;

procedure DrawFlipVert(B: TBitMap);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Width, B1.Height);
  B1.FlipVert(B2);
  B2.Draw(B.Canvas.Handle, 0, 0);
  B1.Free;
  B2.Free;
end;

procedure DrawRotate90_1(Cnvs: TCanvas; B: TBitMap; X, Y: Integer);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_1(B2);
  B2.Draw(Cnvs.Handle, X, Y);
  B1.Free;
  B2.Free;
end;

procedure DrawRotate90_2(Cnvs: TCanvas; B: TBitMap; X, Y: Integer);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_2(B2);
  B2.Draw(Cnvs.Handle, X, Y);
  B1.Free;
  B2.Free;
end;

procedure DrawTabGlyphAndText(Cnvs: TCanvas; W, H: Integer; S: WideString;
                              IM: TCustomImageList; IMIndex: Integer;
                              AEnabled: Boolean);

var
  R, TR: TRect;
  GX, GY, GW, GH, TW, TH: Integer;
begin
  R := Rect(0, 0, 0, 0);
  DrawSkinText(Cnvs, S, R, DT_CALCRECT);
  TW := RectWidth(R) + 2;
  TH := RectHeight(R);
  GW := IM.Width;
  GH := IM.Height;
  GX := W div 2 - (GW + TW + 2) div 2;
  GY := H div 2 - GH div 2;
  TR.Left := GX + GW + 2;
  TR.Top := H div 2 - TH div 2;
  TR.Right := TR.Left + TW;
  TR.Bottom := TR.Top + TH;
  DrawSkinText(Cnvs, S, TR, DT_LEFT);
  IM.Draw(Cnvs, GX, GY, IMIndex, AEnabled);
end;

constructor TbsaTabSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FDisplayRect := Rect(0, 0, 0, 0);
end;

function TbsaTabSubclass.TabImageIndex(Index: Integer): Integer;
begin
  Result := Index;
  if Control is TCustomTabControl
  then
    Result := TbsaSubclassHackCustomTabControl(Control).GetImageIndex(Index);
end;


procedure TbsaTabSubclass.WMHScroll(var Msg: TMessage);
var
  R: TRect;
begin
  CallDefaultProc(Msg);
  if (TabPosition = tpTop) or (TabPosition = tpBottom)
  then
    begin
      if TabPosition = tpTop
      then
        R := Rect(0, 0, Width, DisplayRect.Top)
      else
        R := Rect(0, DisplayRect.Bottom, Width, Height);
      RedrawWindow(TWinControl(Control).Handle, @R, 0, RDW_INVALIDATE);
    end;  
  Handled := True;
end;

procedure TbsaTabSubclass.WMSize(var Msg: TMessage);
var
  CIndex: Integer;
  TabData: TbsDataSkinTabControl;
  i: Integer;
begin
  CallDefaultProc(Msg);
  
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('tab');
    if CIndex = -1 then Exit;
    TabData := TbsDataSkinTabControl(CtrlList[CIndex]);
  end;
  if TabData.StretchEffect
  then
    begin
      Invalidate;
      for i := 0 to TbsaSubclassHackCustomTabControl(FControl).ControlCount - 1 do
      with TbsaSubclassHackCustomTabControl(FControl) do
      begin
        if Controls[i] is TWinControl
        then
          SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0)
       else
        if Controls[i] is TGraphicControl
       then
         TGraphicControl(Controls[i]).Perform(WM_CHECKPARENTBG, 0, 0);
     end;
  end;
end;

function TbsaTabSubclass.GetTabText(Index: Integer): WideString;
var
  TCItem: TTCItemW;
  Buffer: array[0..4095] of WideChar;
begin
  if IsWinNT then
  begin
    TCItem.mask := TCIF_TEXT;
    TCItem.pszText := Buffer;
    TCItem.cchTextMax := SizeOf(Buffer);
    if SendMessageW(Handle, TCM_GETITEMW, Index, LongInt(@TCItem)) <> 0 then
      Result := Buffer
    else
      Result := '';
  end
  else
    Result := Tabs[Index];
  Handled := True;  
end;

procedure TbsaTabSubclass.DrawThemedTab(Canvas: TCanvas; Index: Integer);
var
  R, R1, TR: TRect;
  S: WideString;
  TB, BufferTB: TBitMap;
  DrawGlyph: Boolean;
  Cindex, W, H: Integer;
  TabData: TbsDataSkinTabControl;
  Picture: TBitmap;
  C: TColor;
  ImageIndex: Integer;
begin
  if Tabs = nil then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('tab');
    if CIndex = -1 then Exit;
    TabData := TbsDataSkinTabControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[TabData.PictureIndex]);
  end;
  //
  R := TabRect(Index);
  if Index = TabIndex then InflateRect(R, 1, 1);

  if (TabPosition = tpTop) or (TabPosition = tpBottom)
  then
    begin
      W := RectWidth(R);
      H := RectHeight(R);
    end
  else
    begin
      H := RectWidth(R);
      W := RectHeight(R);
    end;
  TB := TBitMap.Create;
  TB.Width := W;
  TB.Height := H;
  with TabData do
  begin
    BufferTB := TBitMap.Create;
    BufferTB.Width := W;
    BufferTB.Height := RectHeight(TabRect);
    if Index = TabIndex
    then
      begin
        if TWinControl(Control).Focused and not IsNullRect(FocusTabRect)
        then
          begin
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              BufferTB, Picture, FocusTabRect, W, H, TabStretchEffect);
            C := FocusFontColor;
          end
        else
          begin
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
            BufferTB, Picture, ActiveTabRect, W, H, TabStretchEffect);
            C := ActiveFontColor;
          end;  
      end
    else
    if (Index = FHotTab) and not IsNullRect(MouseInTabRect)
    then
      begin
        CreateHSkinImage(TabLeftOffset, TabRightOffset,
              BufferTB, Picture, MouseInTabRect, W, H,TabStretchEffect);
        C := MouseInFontColor;
      end
    else
      begin
        CreateHSkinImage(TabLeftOffset, TabRightOffset,
             BufferTB, Picture, TabRect, W, H, TabStretchEffect);
        C := FontColor;
      end;

    TB.Canvas.StretchDraw(Rect(0, 0, TB.Width, TB.Height), BufferTB);
    BufferTB.Free;
    if TabPosition = tpBottom then DrawFlipVert(TB);
  end;

  TB.Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
  TB.Canvas.Font.Color := C;
  if Index <> TabIndex
  then
    TR := Rect(0, 1, W, H)
  else
    TR := Rect(0, 0, W, H);
  // draw focus frame
  if TabData.ShowFocus and TWinControl(Control).Focused and (Index = TabIndex)
  then
    begin
      R1 := Rect(0, 0, TB.Width, TB.Height);
      InflateRect(R1, -TabData.FocusOffsetX, -TabData.FocusOffsetY);
      Dec(R1.Right);
      TB.Canvas.Brush.Style := bsSolid;
      TB.Canvas.Brush.Color := FManager.Adapter.SkinData.SkinColors.cBtnFace;
      DrawSkinFocusRect(TB.Canvas, R1);
//      TB.Canvas.DrawFocusRect(R1);
      TB.Canvas.Brush.Style := bsClear;
    end;


  // draw glyph and text
  ImageIndex := TabImageIndex(Index);

  if (Images <> nil) and (ImageIndex < Images.Count) and (ImageIndex >= 0)
  then
    begin
      DrawTabGlyphAndText(TB.Canvas, W, H, GetTabText(Index),
                          Images, ImageIndex, True);
    end
  else
    DrawSkinText(TB.Canvas, GetTabText(Index), TR, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  //
  if TabPosition = tpLeft
  then
    DrawRotate90_1(Canvas, TB, R.Left, R.Top)
  else
  if TabPosition = tpRight
  then
    DrawRotate90_2(Canvas, TB, R.Left, R.Top)
  else
    Canvas.Draw(R.Left, R.Top, TB);
   //
  TB.Free;
 end;

procedure TbsaTabSubclass.Paint(Canvas: TCanvas);

procedure PaintSkinWindow(R: TRect; TabData: TbsDataSkinTabControl; Picture: TBitMap);
var
  TOff, LOff, Roff, BOff: Integer;
  TBGOffX, TBGOffY, X, Y, XCnt, YCnt, w, h, w1, h1, rw, rh, XO, YO: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  B, Buffer2: TBitMap;
  LB, RB, TB, BB, ClB: TBitMap;
  NewClRect: TRect;
begin
  with TabData do
  begin
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  XO := RectWidth(R) - RectWidth(SkinRect);
  YO := RectHeight(R) - RectHeight(SkinRect);
  NewLTPoint := LTPoint;
  NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
  NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
  NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
  NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
  // DrawBG
  if BGPictureIndex <> -1
  then
    begin
      B := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div B.Width;
          YCnt := Height div B.Height;
          if StretchEffect and (Width > 0) and (Height > 0)
          then
            begin
              case StretchType of
                 bsstFull:
                   begin
                     Canvas.StretchDraw(Rect(0, 0, Width, Height), B);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := B.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), B);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       Canvas.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := B.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), B);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      Canvas.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
            end
         else
           for X := 0 to XCnt do
           for Y := 0 to YCnt do
            Canvas.Draw(X * B.Width, Y * B.Height, B);
        end;
      Exit;
    end;

    // draw client
    with TabData do
    begin
      ClB := TBitMap.Create;
      ClB.Width := RectWidth(ClRect);
      ClB.Height := RectHeight(ClRect);
      ClB.Canvas.CopyRect(Rect(0, 0, ClB.Width, ClB.Height),
        Picture.Canvas,
         Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      XCnt := RectWidth(R) div w;
      YCnt := RectHeight(R) div h;
      if StretchEffect and (Width > 0) and (Height > 0)
      then
        begin
          case StretchType of
             bsstFull:
               begin
                 Canvas.StretchDraw(R, ClB);
               end;
             bsstVert:
               begin
                 Buffer2 := TBitMap.Create;
                 Buffer2.Width := Width;
                 Buffer2.Height := ClB.Height;
                 Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), ClB);
                 YCnt := Height div Buffer2.Height;
                 for Y := 0 to YCnt do
                   Canvas.Draw(R.Left,  R.Top + Y * Buffer2.Height, Buffer2);
                 Buffer2.Free;
               end;
             bsstHorz:
               begin
                 Buffer2 := TBitMap.Create;
                 Buffer2.Width := ClB.Width;
                 Buffer2.Height := Height;
                 Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), ClB);
                 XCnt := Width div Buffer2.Width;
                 for X := 0 to XCnt do
                   Canvas.Draw(R.Left + X * Buffer2.Width,  R.Top, Buffer2);
                 Buffer2.Free;
               end;
            end;
          end
        else
         for X := 0 to XCnt do
         for Y := 0 to YCnt do
           Canvas.Draw(R.Left + X * w, R.Top + Y * h, ClB);
    end;
    ClB.Free;
    //
    LB := TBitMap.Create;
    TB := TBitMap.Create;
    RB := TBitMap.Create;
    BB := TBitMap.Create;
    CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
        NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
        LB, TB, RB, BB, Picture, SkinRect, RectWidth(R), RectHeight(R),
        LeftStretch, TopStretch, RightStretch, BottomStretch);
    Canvas.Draw(R.Left, R.Top, TB);
    Canvas.Draw(R.Left, R.Top + TB.Height, LB);
    Canvas.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
    Canvas.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
    LB.Free;
    TB.Free;
    RB.Free;
    BB.Free;
  end;
end;


procedure DrawTabsBG(R: TRect; TabData: TbsDataSkinTabControl; Picture: TBitMap);
var
  XCnt, YCnt: Integer;
  X, Y: Integer;
  w, h, rw, rh, XO, YO: Integer;
  Buffer: TBitMap;
begin
  if not FManager.Adapter.TabsBGTransparent
  then
    begin
      with TabData do
      begin
        w := RectWidth(TabsBGRect);
        h := RectHeight(TabsBGRect);
        rw := RectWidth(R);
        rh := RectHeight(R);
        XCnt := rw div w;
        YCnt := rh div h;
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
        begin
          if X * w + w > rw then XO := X * w + w - rw else XO := 0;
          if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
          Canvas.CopyRect(Rect(R.Left + X * w, R.Top + Y * h,
                          R.Left + X * w + w - XO, R.Top + Y * h + h - YO),
                          Picture.Canvas,
                          Rect(TabsBGRect.Left, TabsBGRect.Top,
                          TabsBGRect.Right - XO, TabsBGRect.Bottom - YO));
        end;
      end
    end
  else
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      GetSkinParentImageRect(Self.FControl, R, Buffer.Canvas);
      Canvas.Draw(R.Left, R.Top, Buffer);
      Buffer.Free;
    end;
end;


var
  R, DR: TRect;
  i, SaveIndex: Integer;
  Cindex: Integer;
  TabData: TbsDataSkinTabControl;
  Picture: TBitmap;
begin
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('tab');
    if CIndex = -1 then Exit;
    TabData := TbsDataSkinTabControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[TabData.PictureIndex]);
  end;
  SaveIndex := SaveDC(Canvas.Handle);
  R := DisplayRect;
  ExcludeClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);

  for i := 0 to Tabs.Count - 1 do
  begin
    R := TabRect(i);
    if i = 0 then Inc(R.Left, 2);
     ExcludeClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
  end;

  // draw background around tabs
  R := DisplayRect;
  case TabPosition of
    tpTop: DR := Rect(0, 0, Width, R.Top);
    tpLeft: DR := Rect(0, 0, R.Left, Height);
    tpBottom: DR := Rect(0, R.Bottom, Width, Height);
    tpRight: DR := Rect(R.Right, 0, Width, Height);
  end;
  DrawTabsBG(DR, TabData, Picture);

  RestoreDC(Canvas.Handle, SaveIndex);

  // draw background
  R := DisplayRect;
  case TabPosition of
    tpTop: R := Rect(0, R.Top - 4, Width, Height);
    tpBottom: R := Rect(0, 0, Width, R.Bottom + 2);
    tpLeft: R := Rect(R.Left - 2, 0, Width, Height);
    tpRight: R := Rect(0, 0, R.Right + 2, Height);
  end;

  PaintSkinWindow(R, TabData, Picture);
  //
  { Draw tabs }
  for i := 0 to Tabs.Count - 1 do
  begin
    if i = TabIndex then Continue;
    DrawThemedTab(Canvas, i);
  end;
  { Draw active tab }
  if TabIndex >= 0 then DrawThemedTab(Canvas, TabIndex);
end;

procedure TbsaTabSubclass.UpdateTabs;
var
  i: Integer;
  Canvas: TCanvas;
begin
  { Draw tabs }
  Canvas := TCanvas.Create;
  Canvas.Handle := GetDC(Handle);
  for i := 0 to Tabs.Count - 1 do
  begin
    DrawThemedTab(Canvas, i);
  end;
  if TabIndex <> -1 then DrawThemedTab(Canvas, TabIndex);
  ReleaseDC(Handle, Canvas.Handle);
  Canvas.Handle := 0;
  Canvas.Free;
end;

procedure TbsaTabSubclass.CMMouseLeave(var Msg: TMessage);
begin
  WMMouseMove(Msg);
  UpdateTabs;
end;

procedure TbsaTabSubclass.WMCHECKPARENTBG(var Msg: TWMEraseBkgnd);
var
  TabData: TbsDataSkinTabControl;
begin
  if FManager.Adapter.TabsBGTransparent then
  begin
    FControl.RePaint;
  end;
end;

procedure TbsaTabSubclass.WMMouseMove(var Msg: TMessage);
var
  Index: Integer;
begin
  CallDefaultProc(Msg);

  if FMouseOnLeft or FMouseOnRight then
  begin
    FMouseOnLeft := False;
    FMouseOnRight := False;
//    UpdateUpDown;
  end;


  Index := IndexOfTabAt(TSmallPoint(Msg.lParam).X, TSmallPoint(Msg.lParam).Y);
  if Index <> FHotTab then
  begin
    FHotTab := Index;
    UpdateTabs;
  end;
end;

procedure TbsaTabSubclass.PaintBG;
var
  C: TCanvas;
  TabSheetBG, Buffer2: TBitMap;
  SaveIndex, X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  Cindex: Integer;
  TabData: TbsDataSkinTabControl;
  Picture: TBitmap;
  R: TRect;
begin
  if (Width <= 0) or (Height <=0) then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('tab');
    if CIndex = -1 then Exit;
    TabData := TbsDataSkinTabControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[TabData.PictureIndex]);
  end;
  C := TCanvas.Create;
  C.Handle := DC;
  if TabData.BGPictureIndex <> -1
  then
    begin
      TabSheetBG := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[TabData.BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div TabSheetBG.Width;
          YCnt := Height div TabSheetBG.Height;
          if TabData.StretchEffect and (Width > 0) and (Height > 0)
          then
            with TabData do
            begin
              case StretchType of
                 bsstFull:
                   begin
                     C.StretchDraw(Rect(0, 0, Width, Height), TabSheetBG);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := TabSheetBG.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       C.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := TabSheetBG.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      C.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
            end
         else
           for X := 0 to XCnt do
           for Y := 0 to YCnt do
            C.Draw(X * TabSheetBG.Width, Y * TabSheetBG.Height, TabSheetBG);
        end;
      C.Free;
      Exit;
    end;

  w1 := Width;
  h1 := Height;
  R := FDisplayRect;
  if IsNullRect(R) then R := Rect(0, 0, Width, Height);
  case TabPosition of
    tpTop: R := Rect(0, R.Top - 4, Width, Height);
    tpBottom: R := Rect(0, 0, Width, R.Bottom + 2);
    tpLeft: R := Rect(R.Left - 2, 0, Width, Height);
    tpRight: R := Rect(0, 0, R.Right + 2, Height);
  end;
  with TabData do
  begin
    TabSheetBG := TBitMap.Create;
    TabSheetBG.Width := RectWidth(ClRect);
    TabSheetBG.Height := RectHeight(ClRect);
    TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
      Picture.Canvas,
       Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      XCnt := w1 div w;
      YCnt := h1 div h;
      if TabData.StretchEffect and (Width > 0) and (Height > 0)
      then
        with TabData do
          begin
            case StretchType of
              bsstFull:
                 begin
                   C.StretchDraw(R, TabSheetBG);
                 end;
              bsstVert:
                 begin
                   Buffer2 := TBitMap.Create;
                   Buffer2.Width := Width;
                   Buffer2.Height := TabSheetBG.Height;
                   Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                   YCnt := Height div Buffer2.Height;
                   for Y := 0 to YCnt do
                     C.Draw(R.Left, R.Top + Y * Buffer2.Height, Buffer2);
                   Buffer2.Free;
                 end;
              bsstHorz:
                 begin
                   Buffer2 := TBitMap.Create;
                   Buffer2.Width := TabSheetBG.Width;
                   Buffer2.Height := Height;
                   Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                   XCnt := Width div Buffer2.Width;
                   for X := 0 to XCnt do
                     C.Draw(R.Left + X * Buffer2.Width, R.Top, Buffer2);
                   Buffer2.Free;
                 end;
             end;
           end
      else
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
          C.Draw(R.Left + X * w, R.Top + Y * h, TabSheetBG);
  end;
  TabSheetBG.Free;
  C.Free;
end;

procedure TbsaTabSubclass.SkinChange;
begin
  InvalidateRect(Handle, nil, True);
  inherited;
end;

procedure TbsaTabSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  PaintBG(Msg.wParam);
  Msg.Result := 1;
  Handled := True;
end;

function TbsaTabSubclass.Images: TCustomImageList;
begin
  Result := nil;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).Images;
end;

function TbsaTabSubclass.TabRect(Index: Integer): TRect;
begin
  Result := NullRect;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).TabRect(Index);
end;

function TbsaTabSubclass.TabPosition: TTabPosition;
begin
  Result := tpTop;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).TabPosition;
end;

function TbsaTabSubclass.TabIndex: Integer;
begin
  Result := 0;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).TabIndex;
end;

function TbsaTabSubclass.Tabs: TStrings;
begin
  Result := nil;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).Tabs;
end;

function TbsaTabSubclass.DisplayRect: TRect;
begin
  Result := NullRect;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).DisplayRect;
  FDisplayRect := Result;  
end;

function TbsaTabSubclass.IndexOfTabAt(X, Y: Integer): Integer;
begin
  Result := 0;
  if Control is TCustomTabControl then
    Result := TbsaSubclassHackCustomTabControl(Control).IndexOfTabAt(X, Y);
end;

{ TbsaUpDownSubclass ===========================================================}

constructor TbsaUpDownSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FHotTrack := True;
end;

function TbsaUpDownSubclass.Orientation: TUDOrientation;
begin
  if (Control <> nil) and (Control is TUpDown) then
    Result := TUpDown(Control).Orientation
  else
    if Handle <> 0 then
    begin
      if GetWindowLong(Handle, GWL_STYLE) and UDS_HORZ = UDS_HORZ then
        Result := udHorizontal
      else
        Result := udVertical;
    end
    else
      Result := udVertical;
end;

procedure TbsaUpDownSubclass.Paint(Canvas: TCanvas);

procedure DrawResizeButton(Cnvs: TCanvas; R: TRect; AHot, APressed: Boolean; I: Integer);
var
  Buffer: TBitMap;
  CIndex: Integer;
  ButtonData: TbsDataSkinButtonControl;
  BtnSkinPicture: TBitMap;
  BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint: TPoint;
  BtnCLRect: TRect;
  BSR, ABSR, DBSR, R1: TRect;
  XO, YO: Integer;
  ArrowColor: TColor;
  SkinData: TbsSkinData;
begin
  //
  if (FManager = nil) or (FManager.FAdapter.SkinData = nil)
  then
    Exit;

  SkinData := Self.FManager.FAdapter.SkinData;
  //
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  //
  CIndex := SkinData.GetControlIndex('resizebutton');
  if CIndex = -1
  then
    begin
      Cnvs.Draw(R.Left, R.Top, Buffer);
      Buffer.Free;
      Exit;
    end
  else
    ButtonData := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);
  //
  with ButtonData do
  begin
    XO := RectWidth(R) - RectWidth(SkinRect);
    YO := RectHeight(R) - RectHeight(SkinRect);
    BtnLTPoint := LTPoint;
    BtnRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
    BtnLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
    BtnRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
    BtnClRect := Rect(CLRect.Left, ClRect.Top,
      CLRect.Right + XO, ClRect.Bottom + YO);
    BtnSkinPicture := TBitMap(SkinData.FActivePictures.Items[ButtonData.PictureIndex]);

    BSR := SkinRect;
    ABSR := ActiveSkinRect;
    DBSR := DownSkinRect;
    if IsNullRect(ABSR) then ABSR := BSR;
    if IsNullRect(DBSR) then DBSR := ABSR;
    //
    if APressed
    then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, DBSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        ArrowColor := DownFontColor;
      end
    else
    if AHot and MouseInControl then
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, ABSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        ArrowColor := ActiveFontColor;
      end
    else
      begin
        CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
        BtnLtPoint, BtnRTPoint, BtnLBPoint, BtnRBPoint, BtnCLRect,
        Buffer, BtnSkinPicture, BSR, Buffer.Width, Buffer.Height, True,
        LeftStretch, TopStretch, RightStretch, BottomStretch,
        StretchEffect, StretchType);
        ArrowColor := FontColor;
      end;
   end;
  //
  Cnvs.Draw(R.Left, R.Top, Buffer);
  //
  R1 := R;
  if APressed
  then
    begin
      Inc(R1.Left, 2);
      Inc(R1.Top, 2);
    end;
  if Orientation = udVertical
  then
    begin
      case i of
        0: DrawArrowImage(Cnvs, R1, ArrowColor, 3);
        1: DrawArrowImage(Cnvs, R1, ArrowColor, 4);
      end
    end
  else
    begin
      case i of
        1: DrawArrowImage(Cnvs, R1, ArrowColor, 1);
        0: DrawArrowImage(Cnvs, R1, ArrowColor, 2);
      end
    end;
  //
  Buffer.Free;
end;


var
  R, R1, R2: TRect;
  Buf: TBitMap;
begin
  if Orientation = udHorizontal then
  begin
    R := GetClientRect;
    Buf := TBitMap.Create;
    Buf.Width := RectWidth(R);
    Buf.Height := RectHeight(R);
    //
    R1 := R;
    R1.Right := R1.Left + RectWidth(R) div 2;
    R2 := R;
    R2.Left := R2.Left + RectWidth(R) div 2;
    DrawResizeButton(Buf.Canvas, R1, FMouseOnLeft, FLeftPressed, 1);
    DrawResizeButton(Buf.Canvas, R2, FMouseOnRight, FRightPressed, 0);
    //
    Canvas.Draw(R.Left, R.Top, Buf);
    Buf.Free;
  end
  else
  begin
    R := GetClientRect;
    Buf := TBitMap.Create;
    Buf.Width := RectWidth(R);
    Buf.Height := RectHeight(R);
    //
    R1 := R;
    R1.Bottom := R1.Top + RectHeight(R) div 2;
    R2 := R;
    R2.Top := R2.Top + RectHeight(R) div 2;
    DrawResizeButton(Buf.Canvas, R1, FMouseOnLeft, FLeftPressed, 0);
    DrawResizeButton(Buf.Canvas, R2, FMouseOnRight, FRightPressed, 1);
    //
    Canvas.Draw(R.Left, R.Top, Buf);
    Buf.Free;
  end;
end;

procedure TbsaUpDownSubclass.WMLButtonDblClk(var Msg: TWMMouse);
var
  R: TRect;
begin
  CallDefaultProc(TMessage(Msg));
  if Orientation = udHorizontal then
  begin
    R := GetClientRect;
    R.Right := R.Left + RectWidth(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FLeftPressed := True
    else
      FLeftPressed := False;

    R := GetClientRect;
    R.Left := R.Right - RectWidth(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FRightPressed := True
    else
      FRightPressed := False;
  end
  else
  begin
    R := GetClientRect;
    R.Bottom := R.Top + RectHeight(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FLeftPressed := True
    else
      FLeftPressed := False;

    R := GetClientRect;
    R.Top := R.Bottom - RectHeight(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FRightPressed := True
    else
      FRightPressed := False;
  end;
  Invalidate;
  Handled := True;
end;

procedure TbsaUpDownSubclass.WMLButtonDown(var Msg: TWMMouse);
var
  R: TRect;
begin
  CallDefaultProc(TMessage(Msg));

  if Orientation = udHorizontal then
  begin
    R := GetClientRect;
    R.Right := R.Left + RectWidth(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FLeftPressed := True
    else
      FLeftPressed := False;

    R := GetClientRect;
    R.Left := R.Right - RectWidth(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FRightPressed := True
    else
      FRightPressed := False;
  end
  else
  begin
    R := GetClientRect;
    R.Bottom := R.Top + RectHeight(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FLeftPressed := True
    else
      FLeftPressed := False;

    R := GetClientRect;
    R.Top := R.Bottom - RectHeight(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FRightPressed := True
    else
      FRightPressed := False;
  end;

  Invalidate;
  Handled := True;
end;

procedure TbsaUpDownSubclass.WMLButtonUp(var Msg: TWMMouse);
begin
  CallDefaultProc(TMessage(Msg));

  FLeftPressed := False;
  FRightPressed := False;
  Invalidate;

  Handled := True;
end;

procedure TbsaUpDownSubclass.WMMouseMove(var Msg: TWMMouse);
var
  R: TRect;
begin
  CallDefaultProc(TMessage(Msg));

  if Orientation = udHorizontal then
  begin
    R := GetClientRect;
    R.Right := R.Left + RectWidth(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FMouseOnLeft := True
    else
      FMouseOnLeft := False;

    R := GetClientRect;
    R.Left := R.Right - RectWidth(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FMouseOnRight := True
    else
      FMouseOnRight := False;
  end
  else
  begin
    R := GetClientRect;
    R.Bottom := R.Top + RectHeight(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FMouseOnLeft := True
    else
      FMouseOnLeft := False;

    R := GetClientRect;
    R.Top := R.Bottom - RectHeight(R) div 2;
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FMouseOnRight := True
    else
      FMouseOnRight := False;
  end;

  Invalidate;

  Handled := True;
end;

// TbsaSpeedButtonSubClass ======================================================

constructor TbsaSpeedButtonSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FHotTrack := True;
end;

destructor TbsaSpeedButtonSubclass.Destroy;
begin
  inherited;
end;

procedure TbsaSpeedButtonSubclass.SkinChange;
var
  ButtonData: TbsDataSkinButtonControl;
  CIndex: Integer;
begin
  inherited;
  if not FManager.IsSkinAvailable then Exit;
  if FManager.Adapter.SpeedButtonUseSkinSize
  then
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.SpeedButtonSkinDataName);
    if CIndex = -1 then Exit;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    if (ButtonData.RBPoint.X = 0) and (ButtonData.RBPoint.Y = 0)
    then
      Control.Height := RectHeight(ButtonData.SkinRect);
  end;
end;

function TbsaSpeedButtonSubclass.GetTransColor: TColor;
var
  LabelData: TbsDataSkinStdLabelControl;
  CIndex: Integer;
begin
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('stdlabel');
    if CIndex = -1
    then
      begin
        Result := clBlack;
        Exit;
      end;
    LabelData := TbsDataSkinStdLabelControl(CtrlList[CIndex]);
    Result := LabelData.FontColor;
  end;
end;

procedure TbsaSpeedButtonSubclass.Paint(Canvas: TCanvas);

function GetGlyphNum(ANumGlyphs: Integer): Integer;
begin
  if ((TbsaSubclassHackSpeedButton(SpeedButton).FState = bsDown) or
       (TbsaSubclassHackSpeedButton(SpeedButton).FState = bsExclusive)) and (ANumGlyphs > 2)
  then
    Result := 3
  else
  if (BValues[SMouseInControl]) and (ANumGlyphs > 3)
  then
    Result := 4
  else
    if not FControl.Enabled and (ANumGlyphs > 1)
    then
      Result := 2
    else
      Result := 1;
end;


var
  R, R1: TRect;
  Buffer: TBitMap;
  ButtonData: TbsDataSkinButtonControl;
  CIndex: Integer;
  Picture: TBitmap;
  C: TColor;
begin
  if not FManager.IsSkinAvailable then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.SpeedButtonSkinDataName);
    if CIndex = -1 then Exit;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ButtonData.PictureIndex]);
  end;
  //
  if (FManager.Adapter.SpeedButtonUseSkinSize) and (Control.Height <> RectHeight(ButtonData.SkinRect))
      and (ButtonData.RBPoint.X = 0) and (ButtonData.RBPoint.Y = 0)
  then
    begin
      Control.Height := RectHeight(ButtonData.SkinRect);
    end;
  //  
  Buffer := nil;
  // create button image
   with ButtonData do
  begin
    if ((TbsaSubclassHackSpeedButton(SpeedButton).FState = bsDown) or
       (TbsaSubclassHackSpeedButton(SpeedButton).FState = bsExclusive))
        and not IsNullRect(DownSkinRect) and FControl.Enabled
    then
      begin
        R := DownSkinRect;
        C := DownFontColor;
        Buffer := TBitMap.Create;
        Buffer.Width := Width;
        Buffer.Height := Height;
      end
    else
    if (BValues[SMouseInControl]) and not IsNullRect(ActiveSkinRect)
       and FControl.Enabled
    then
      begin
        R := ActiveSkinRect;
        C := ActiveFontColor;
        Buffer := TBitMap.Create;
        Buffer.Width := Width;
        Buffer.Height := Height;
      end
    else
      begin
        if not FControl.Enabled
        then
          begin
            if not IsNullRect(DisabledSkinRect)
            then
              R := DisabledSkinRect
            else
              R := SkinRect;  
            C := DisabledFontColor;
          end
        else
          begin
            R := SkinRect;
            C := FontColor;
          end;

        if not SpeedButton.Flat
        then
          begin
            Buffer := TBitMap.Create;
            Buffer.Width := Width;
            Buffer.Height := Height;
            //
            //                                                  
          end;
      end;

    if Buffer <> nil
    then
      CreateSkinControlImage(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
                             Buffer, Picture, R,
                             Width, Height, StretchEffect,
                             LeftStretch, TopStretch, RightStretch, BottomStretch,
                             FManager.Adapter.SpeedButtonUseSkinSize, StretchType);
  end;
  // draw text
  R := GetClientRect;
  if Buffer <> nil
  then
    begin
      Buffer.Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
      Buffer.Canvas.Font.Color := C;
      with SpeedButton do
       DrawGlyphAndText(Buffer.Canvas, R, Margin, Spacing, TbsButtonLayout(Layout),
        Text, Glyph, NumGlyphs, GetGlyphNum(NumGlyphs), False);
      Canvas.Draw(0, 0, Buffer);
      Buffer.Free;
    end
  else
    begin
      Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
      Canvas.Font.Color := GetTransColor;
      with SpeedButton do
        DrawGlyphAndText(Canvas, R, Margin, Spacing, TbsButtonLayout(Layout),
         Text, Glyph, NumGlyphs, GetGlyphNum(NumGlyphs), False);
    end;
end;


procedure TbsaSpeedButtonSubclass.SetControl(const Value: TControl);
begin
  inherited;
  if (Control is TSpeedButton) then
  begin
//  TSpeedButton(Control).Transparent := True;
  end;
end;

function TbsaSpeedButtonSubclass.SpeedButton: TSpeedButton;
begin
  if Control is TSpeedButton then
    Result := TSpeedButton(Control)
  else
    Result := nil;
end;

{ TbsaPanelSubclass =========================================================}

constructor TbsaPanelSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FOverridedEraseBkgnd := True;
 // FDoubleBuffered := True;
end;

procedure TbsaPanelSubclass.WMSize(var Msg: TMessage);
var
  i: Integer;
begin
  CallDefaultProc(TMessage(Msg));
  for i := 0 to TbsaSubclassHackPanel(FControl).ControlCount - 1 do
  with TbsaSubclassHackPanel(FControl) do
  begin
     if Controls[i] is TWinControl
     then
       SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0)
     else
     if Controls[i] is TGraphicControl
     then
      TGraphicControl(Controls[i]).Perform(WM_CHECKPARENTBG, 0, 0);
  end;
  Handled := True;
end;


function TbsaPanelSubclass.GetTransColor: TColor;
var
  LabelData: TbsDataSkinStdLabelControl;
  CIndex: Integer;
begin
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('stdlabel');
    if CIndex = -1
    then
      begin
        Result := clBlack;
        Exit;
      end;
    LabelData := TbsDataSkinStdLabelControl(CtrlList[CIndex]);
    Result := LabelData.FontColor;
  end;
end;

procedure TbsaPanelSubclass.Paint(Canvas: TCanvas);
const
  Alignments: array[TAlignment] of LongInt = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Picture, BG, Buffer2: TBitMap;
  XO, YO, X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  PanelData: TbsDataSkinpanelControl;
  CIndex: Integer;
  CR: TRect;
  FrameColor: TColor;
  LB, RB, TB, BB, ClB: TBitMap;
  SaveIndex: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewClRect: TRect;
begin
  if (Width <= 0) or (Height <=0) then Exit;

  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.FPanelSkinDataName);
    if CIndex = -1 then Exit;
    PanelData := TbsDataSkinPanelControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[PanelData.PictureIndex]);
  end;

  if PanelData.BGPictureIndex <> -1
  then
    begin
      BG := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[PanelData.BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div BG.Width;
          YCnt := Height div BG.Height;
          //
          if PanelData.StretchEffect
          then
            with PanelData do
            begin
              case StretchType of
                 bsstFull:
                   begin
                     Canvas.StretchDraw(Rect(0, 0, Width, Height), BG);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := BG.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), BG);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       Canvas.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := BG.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), BG);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      Canvas.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
            end
          else
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
             Canvas.Draw(X * BG.Width, Y * BG.Height, BG);
        end;

      if TbsaSubclassHackControl(Control).Caption <> ''
      then
        begin
          Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
          Canvas.Font.Color := GetTransColor;
          CR := TbsaSubclassHackControl(Control).ClientRect;
          DrawSkinText(Canvas, Text, CR,
          DT_VCENTER or DT_SINGLELINE or Alignments[TbsaSubclassHackCustomPanel(Control).Alignment]);
        end;
      Exit;
    end
  else
    with PanelData do
    begin
      if (TbsaSubclassHackCustomPanel(Control).BevelInner <> TBevelCut(0)) or
         (TbsaSubclassHackCustomPanel(Control).BevelOuter <> TBevelCut(0))
      then
        begin
          LB := TBitMap.Create;
          TB := TBitMap.Create;
          RB := TBitMap.Create;
          BB := TBitMap.Create;
          XO := Width - RectWidth(SkinRect);
          YO := Height - RectHeight(SkinRect);
          NewLTPoint := LTPoint;
          NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
          NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
          NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
          NewClRect := Rect(PanelData.CLRect.Left, PanelData.ClRect.Top, PanelData.CLRect.Right + XO, ClRect.Bottom + YO);
            CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
             NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
             LB, TB, RB, BB, Picture, SkinRect, Width, Height,
             LeftStretch, TopStretch, RightStretch, BottomStretch);
        end
        else
          NewClRect := Rect(0, 0, Width, Height);
        //
        w := RectWidth(ClRect);
        h := RectHeight(ClRect);
        w1 := RectWidth(NewClRect);
        h1 := REctHeight(NewCLRect);
        XCnt := w1 div w;
        YCnt := h1 div h;
        Clb := TBitMap.Create;
        Clb.Width := w;
        Clb.Height := h;
        Clb.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
             SkinRect.Left + ClRect.Right,
             SkinRect.Top + ClRect.Bottom));
        SaveIndex := SaveDC(Canvas.Handle);
        IntersectClipRect(Canvas.Handle, NewCLRect.Left, NewCLRect.Top, NewCLRect.Right, NewClRect.Bottom);
        if PanelData.StretchEffect
        then
          with PanelData do
          begin
            case StretchType of
                 bsstFull:
                   begin
                     Canvas.StretchDraw(Rect(0, 0, Width, Height), Clb);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := Clb.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       Canvas.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Clb.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      Canvas.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
          end
        else  
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
          begin
           Canvas.Draw(NewClRect.Left + X * w, NewClRect.Top + Y * h, Clb);
         end;
        Clb.Free;
        RestoreDC(Canvas.Handle, SaveIndex);
        if (TbsaSubclassHackCustomPanel(Control).BevelInner <> TBevelCut(0)) or
           (TbsaSubclassHackCustomPanel(Control).BevelOuter <> TBevelCut(0))
        then
          begin
            Canvas.Draw(0, 0, TB);
            Canvas.Draw(0, TB.Height, LB);
            Canvas.Draw(Width - RB.Width, TB.Height, RB);
            Canvas.Draw(0, Height - BB.Height, BB);
            LB.Free;
            TB.Free;
            RB.Free;
            BB.Free;
          end;
        // draw caption
        if Text <> ''
        then
          begin
            Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
            Canvas.Font.Color := GetTransColor;
            CR := TbsaSubclassHackControl(Control).ClientRect;
            DrawSkinText(Canvas, Text, CR,
             DT_VCENTER or DT_SINGLELINE or Alignments[TbsaSubclassHackCustomPanel(Control).Alignment]);
          end;
     end;
end;

{ TbsaGroupBoxSubclass =========================================================}

constructor TbsaGroupBoxSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FOverridedEraseBkgnd := True;
  FDoubleBuffered := True;
  ParentBGBuffer := TBitMap.Create;
  ParentBGBuffer.Width := Width;
  ParentBGBuffer.Height := Height;
  GetPBG;
end;

destructor TbsaGroupBoxSubclass.Destroy;
begin
  ParentBGBuffer.Free;
  inherited;
end;

procedure TbsaGroupBoxSubclass.SkinChange;
begin
  GetPBG;
  inherited;
end;

procedure TbsaGroupBoxSubclass.GetPBG;
begin
  if (Width > 0) and (Height > 0)
  then
    begin
      ParentBGBuffer.Width := Width;
      ParentBGBuffer.Height := Height;
      GetSkinParentImage(FControl, ParentBGBuffer.Canvas);
    end;
end;


procedure TbsaGroupBoxSubclass.WMCHECKPARENTBG(var Msg: TWMEraseBkgnd);
var
  i: Integer;
begin
  GetPBG;
  FControl.Invalidate;
  if not (FControl is TCustomRadioGroup) then
  for i := 0 to TbsaSubclassHackGroupBox(FControl).ControlCount - 1 do
   with TbsaSubclassHackGroupBox(FControl) do
   begin
     if Controls[i] is TWinControl
     then
       SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0)
     else
     if Controls[i] is TGraphicControl
     then
       TGraphicControl(Controls[i]).Perform(WM_CHECKPARENTBG, 0, 0);
   end;
end;

procedure TbsaGroupBoxSubclass.WMSize(var Msg: TMessage);
var
  i: Integer;
begin
  GetPBG;
  CallDefaultProc(Msg);
  if not (FControl is TCustomRadioGroup) then
  for i := 0 to TbsaSubclassHackGroupBox(FControl).ControlCount - 1 do
   with TbsaSubclassHackGroupBox(FControl) do
   begin
     if Controls[i] is TWinControl
     then
       SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0)
     else
     if Controls[i] is TGraphicControl
     then
       TGraphicControl(Controls[i]).Perform(WM_CHECKPARENTBG, 0, 0);
   end;
  Handled := True;
end;

procedure TbsaGroupBoxSubclass.WMMOVE(var Msg: TWMMOVE);
begin
  GetPBG;
  CallDefaultProc(TMessage(Msg));
  FControl.Invalidate;
  Handled := True;
end;

function TbsaGroupBoxSubclass.GetTransColor: TColor;
var
  LabelData: TbsDataSkinStdLabelControl;
  CIndex: Integer;
begin
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('stdlabel');
    if CIndex = -1
    then
      begin
        Result := clBlack;
        Exit;
      end;
    LabelData := TbsDataSkinStdLabelControl(CtrlList[CIndex]);
    Result := LabelData.FontColor;
  end;
end;

function TbsaGroupBoxSubclass.GetCaptionRect(Canvas: TCanvas): TRect;
const
  FCaptionMargin = 12;
begin
  if Control <> nil then
    Canvas.Font.Assign(TbsaSubclassHackWinControl(Control).Font);

  Result := Rect(FCaptionMargin, 0, FCaptionMargin + Canvas.TextWidth(Text), Canvas.TextHeight(Text));
end;

function TbsaGroupBoxSubclass.GetBoxRect(Canvas: TCanvas): TRect;
begin
  with Canvas do
  begin
    if Control <> nil then
     Canvas.Font.Assign(TbsaSubclassHackWinControl(Control).Font);

    Result := Rect(3, TextHeight(Text) div 2 + 1, Self.Width - 2, Self.Height - 2);
  end;
end;

procedure TbsaGroupBoxSubclass.Paint(Canvas: TCanvas);
var
  Picture: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  PanelData: TbsDataSkinpanelControl;
  CIndex: Integer;
  CR: TRect;
  FrameColor: TColor;
begin
  if (ParentBGBuffer.Width <> Width) or
     (ParentBGBuffer.Height <> Height)
  then
    GetPBG;   


  if (Width <= 0) or (Height <=0) then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('panel');
    if CIndex = -1 then Exit;
    PanelData := TbsDataSkinPanelControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[PanelData.PictureIndex]);
  end;

  Canvas.Draw(0, 0, ParentBGBuffer);

  // draw text
  if Text <> ''
  then
    begin
      CR := GetCaptionRect(Canvas);
      Canvas.Font.Assign(TbsaSubclassHackControl(Control).Font);
      Canvas.Font.Color := GetTransColor;
      DrawSkinText(Canvas, Text, CR, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
   end
  else
    CR := NullRect;  

  // draw frame
  with PanelData, Canvas do
  begin
    X := SkinRect.Left + RectWidth(SkinRect) div 2;
    Y :=  SkinRect.Bottom - 1;
    FrameColor := Picture.Canvas.Pixels[X, Y];
    Canvas.Pen.Color := FrameColor;
    Pen.Width := 1;
    if not IsNullRect(CR)
    then
      begin
        MoveTo(0, RectHeight(CR) div 2);
        LineTo(CR.Left - 2, RectHeight(CR) div 2) ;
        MoveTo(CR.Right + 2, RectHeight(CR) div 2);
        LineTo(Width - 1, CR.Top + RectHeight(CR) div 2);
      end
    else
      begin
        MoveTo(0, 0);
        LineTo(Width - 1, 0);
      end;
    LineTo(Width - 1, Height - 1);
    LineTo(0, Height - 1);
    LineTo(0, RectHeight(CR) div 2);
  end;

end;

{ TbsaTabSheetSubclass =========================================================}

constructor TbsaTabSheetSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FOverridedEraseBkgnd := True;
end;


procedure TbsaTabSheetSubclass.WMSize(var Msg: TMessage);
var
  CIndex: Integer;
  TabData: TbsDataSkinTabControl;
  i: Integer;
begin
  CallDefaultProc(TMessage(Msg));
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('tab');
    if CIndex = -1 then Exit;
    TabData := TbsDataSkinTabControl(CtrlList[CIndex]);
  end;
  if TabData.StretchEffect
  then
    begin
      Invalidate;
      for i := 0 to TTabSheet(FControl).ControlCount - 1 do
      with TTabSheet(FControl) do
      begin
        if Controls[i] is TWinControl
        then
          SendMessage(TWinControl(Controls[i]).Handle, WM_CHECKPARENTBG, 0, 0)
       else
        if Controls[i] is TGraphicControl
       then
         TGraphicControl(Controls[i]).Perform(WM_CHECKPARENTBG, 0, 0);
     end;
  end;
  Handled := True;
end;

procedure TbsaTabSheetSubclass.Paint(Canvas: TCanvas);
var
  Picture, TabSheetBG, Buffer2: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  TabData: TbsDataSkinTabControl;
  CIndex: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('tab');
    if CIndex = -1 then Exit;
    TabData := TbsDataSkinTabControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[TabData.PictureIndex]);
  end;

  if TabData.BGPictureIndex <> -1
  then
    begin
      TabSheetBG := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[TabData.BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div TabSheetBG.Width;
          YCnt := Height div TabSheetBG.Height;
          if TabData.StretchEffect and (Width > 0) and (Height > 0)
          then
            with TabData do
            begin
              case StretchType of
                 bsstFull:
                   begin
                     Canvas.StretchDraw(Rect(0, 0, Width, Height), TabSheetBG);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := TabSheetBG.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       Canvas.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := TabSheetBG.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      Canvas.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
            end
         else
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          Canvas.Draw(X * TabSheetBG.Width, Y * TabSheetBG.Height, TabSheetBG);
        end;
      Exit;
    end;


  w1 := Width;
  h1 := Height;
  TabSheetBG := TBitMap.Create;
  with TabData do
  begin
    TabSheetBG.Width := RectWidth(ClRect);
    TabSheetBG.Height := RectHeight(ClRect);
    TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
      Picture.Canvas,
      Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
  end;
  XCnt := w1 div w;
  YCnt := h1 div h;
  if TabData.StretchEffect and (Width > 0) and (Height > 0)
  then
    with TabData do
    begin
      case StretchType of
        bsstFull:
          begin
            Canvas.StretchDraw(Rect(0, 0, Width, Height), TabSheetBG);
          end;
        bsstVert:
          begin
            Buffer2 := TBitMap.Create;
            Buffer2.Width := Width;
            Buffer2.Height := TabSheetBG.Height;
            Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
            YCnt := Height div Buffer2.Height;
            for Y := 0 to YCnt do
              Canvas.Draw(0, Y * Buffer2.Height, Buffer2);
            Buffer2.Free;
          end;
        bsstHorz:
          begin
            Buffer2 := TBitMap.Create;
            Buffer2.Width := TabSheetBG.Width;
            Buffer2.Height := Height;
            Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), TabSheetBG);
            XCnt := Width div Buffer2.Width;
            for X := 0 to XCnt do
              Canvas.Draw(X * Buffer2.Width, 0, Buffer2);
            Buffer2.Free;
          end;
      end;
    end
  else
  for X := 0 to XCnt do
  for Y := 0 to YCnt do
    Canvas.Draw(X * w, Y * h, TabSheetBG);
  TabSheetBG.Free;
end;


{ TbsaToolbarSubclass ==========================================================}

constructor TbsaToolbarSubclass.Create;
begin
  inherited;
  FMouseIn := False;
  FOverridedPaint := True;
  FDoubleBuffered := True;
  FHotTrack := True;
  FHotButton := -1;
  FButtonDropDown := -1;
end;

destructor TbsaToolbarSubclass.Destroy;
begin
  inherited;
  if FImageList <> nil then
  begin
    FreeAndNil(FImageList);
  end;
end;

procedure TbsaToolbarSubclass.OnCloseSkinMenu(Sender: TObject);
begin
  FButtonDropDown := -1;
  Invalidate;
end;

procedure TbsaToolbarSubclass.WMNotify(var Msg: TWMNotify);
begin
  if (Msg.NMHdr.Code = TBN_DROPDOWN) and (LongWord(Msg.IDCtrl) = Handle) then
  begin
    FButtonDropDown := PNMToolBar(Msg.NMHdr).iItem;
    Invalidate;
    if (Control is TToolBar) and (FButtonDropDown >= 0) and
       (TToolBar(Control).Buttons[FButtonDropDown].DropdownMenu <> nil) and 
       (TToolBar(Control).Buttons[FButtonDropDown].DropdownMenu is TbsSkinPopupMenu)
    then
      begin
        TbsSkinPopupMenu(TToolBar(Control).Buttons[FButtonDropDown].DropdownMenu).OnMenuClose := OnCloseSkinMenu;
      end;
    CallDefaultProc(TMessage(Msg));
    if (Control is TToolBar) and (FButtonDropDown >= 0) and
       (TToolBar(Control).Buttons[FButtonDropDown].DropdownMenu <> nil) and 
       (TToolBar(Control).Buttons[FButtonDropDown].DropdownMenu is TbsSkinPopupMenu)
    then
      begin
      end
    else
      begin
        FButtonDropDown := -1;
        Invalidate;
      end;  
    Handled := True;
  end;
end;

procedure TbsaToolbarSubclass.CMMouseEnter;
begin
  CallDefaultProc(TMessage(Msg));
  FMouseIn := True;
  Invalidate;
  Handled := True;
end;

procedure TbsaToolbarSubclass.CMMouseLeave;
begin
  CallDefaultProc(TMessage(Msg));
  FMouseIn := False;
  Invalidate;
  Handled := True;
end;

procedure TbsaToolbarSubclass.WMSize(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
  Invalidate;
end;

function TbsaToolbarSubclass.ButtonCount: Integer;
begin
  Result := SendMessage(Handle, TB_BUTTONCOUNT, 0, 0);
end;

function TbsaToolbarSubclass.ButtonSize: TPoint;
var
  S: Cardinal;
begin
  S := SendMessage(Handle, TB_GETBUTTONSIZE, 0, 0);
  Result := Point(LoWord(S), HiWord(S));
end;

function TbsaToolbarSubclass.ItemRect(Index: Integer): TRect;
begin
  Result := NullRect;
  SendMessage(Handle, TB_GETITEMRECT, Index, Integer(@Result));
end;

var
  BufMan: array [0..300] of ansichar;

function TbsaToolbarSubclass.ItemInfo(Index: Integer): TTBButtonInfo;
var
  TB: TTBButton;
begin
  FillChar(TB, SizeOf(TB), 0);
  SendMessage(Handle, TB_GETBUTTON, Index, Integer(@TB));
  FillChar(Result, SizeOf(Result), 0);
  Result.cbSize := SizeOf(TTBButtonInfo);
  Result.dwMask := TBIF_STATE or TBIF_STYLE or TBIF_IMAGE or TBIF_TEXT;
  Result.pszText := @BufMan;
  Result.cchText := 300;
  SendMessage(Handle, TB_GETBUTTONINFO, TB.idCommand, Integer(@Result));
  Result.fsStyle := TB.fsStyle;
end;

function TbsaToolbarSubclass.ItemStyle(Index: Integer): Cardinal;
var
  TB: TTBButton;
begin
  SendMessage(Handle, TB_GETBUTTON, Index, Integer(@TB));
  Result := TB.fsStyle;
end;

procedure TbsaToolbarSubclass.ApplyImageList;
var
  H: Cardinal;
begin
  H := SendMessage(Handle, TB_GETIMAGELIST, 0, 0);
  if (H <> 0) and (FImageList = nil) then
  begin
    FImageList := TImageList.Create(nil);
    FImageList.ShareImages := True;
    FImageList.Handle := H;
  end;
end;

function Intensity(Color32: Cardinal): Integer;
begin
  Result := (
    (Color32 and $00FF0000) shr 16 * 61 +
    (Color32 and $0000FF00) shr 8 * 174 +
    (Color32 and $000000FF) * 21
    ) shr 8;
end;

procedure TbsaToolbarSubclass.DrawSeparator(C: TCanvas; FaceRect: TRect);
var
  R: TRect;
begin
  with FManager.Adapter.SkinData do
  begin
    R := FaceRect;
    R.Left := FaceRect.Left + RectWidth(FaceRect) div 2 - 1;
    R.Right := R.Left + 2;
    Frm3d(C, R, SkinColors.cBtnShadow, SkinColors.cBtnHighLight);
  end;
end;

procedure TbsaToolbarSubclass.DrawButtonFace(C: TCanvas; FaceRect: TRect; Active, Down, Flat, DrawMenu: Boolean);
var
  R: TRect;
  Buffer, Buffer2: TBitMap;
  ButtonData: TbsDataSkinButtonControl;
  CIndex, X, Y: Integer;
  Picture: TBitmap;
  SR: TRect;
begin
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.SpeedButtonSkinDataName);
    if CIndex = -1 then Exit;
    ButtonData := TbsDataSkinButtonControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ButtonData.PictureIndex]);
  end;
  // create button image
  with ButtonData do
  begin
    if Down and not IsNullRect(DownSkinRect)
    then
      begin
        R := DownSkinRect;
        C.Font.Color := DownFontColor;
      end
    else
    if (Active or Down) and not IsNullRect(ActiveSkinRect)
    then
      begin
        R := ActiveSkinRect;
        C.Font.Color := ActiveFontColor;
      end
    else
      begin
        R := SkinRect;
        if Flat then R := NullRect;
        C.Font.Color := FontColor;
      end;

     if not IsNullRect(R)
     then
       begin
         Buffer := TBitMap.Create;
         Buffer.Width := RectWidth(FaceRect);
         Buffer.Height := RectHeight(FaceRect);
         CreateSkinControlImage(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
                            Buffer, Picture, R,
                            Buffer.Width, Buffer.Height, StretchEffect,
                            LeftStretch, TopStretch, RightStretch, BottomStretch,
                            FManager.Adapter.SpeedButtonUseSkinSize, StretchType);
         C.Draw(FaceRect.Left, FaceRect.Top, Buffer);
         Buffer.Free;
       end;

     if DrawMenu
     then
       begin
         R := FaceRect;
         R.Left := R.Right - 13;
         if not IsNullRect(ButtonData.MenuMarkerRect)
         then
           with ButtonData do
           begin
            if Down and not IsNullRect(MenuMarkerDownRect)
            then SR := MenuMarkerDownRect else
            if Active and not IsNullRect(MenuMarkerActiveRect)
            then SR := MenuMarkerActiveRect else SR := MenuMarkerRect;

            Buffer2 := TBitMap.Create;
            Buffer2.Width := RectWidth(SR);
            Buffer2.Height := RectHeight(SR);

            Buffer2.Canvas.CopyRect(Rect(0, 0, Buffer2.Width, Buffer2.Height),
              Picture.Canvas, SR);

            Buffer2.Transparent := True;
            Buffer2.TransparentMode := tmFixed;
            Buffer2.TransparentColor := MenuMarkerTransparentColor;

            X := R.Left + RectWidth(R) div 2 - RectWidth(SR) div 2;
            Y := R.Top + RectHeight(R) div 2 - RectHeight(SR) div 2 + 1;
            C.Draw(X, Y, Buffer2);
            Buffer2.Free;
          end
        else
          DrawArrowImage(C, R, C.Font.Color, 4);
       end;
   end;
end;



procedure TbsaToolbarSubclass.DrawBackground(C: TCanvas);
const
  Alignments: array[TAlignment] of LongInt = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Picture, BG, Buffer2: TBitMap;
  XO, YO, X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  PanelData: TbsDataSkinpanelControl;
  CIndex: Integer;
  CR: TRect;
  FrameColor: TColor;
  ClB: TBitMap;
  SaveIndex: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewClRect: TRect;
begin
  if (Width <= 0) or (Height <=0) then Exit;

  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.ToolBarSkinDataName);
    if CIndex = -1 then Exit;
    PanelData := TbsDataSkinPanelControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[PanelData.PictureIndex]);
  end;

  if PanelData.BGPictureIndex <> -1
  then
    begin
      BG := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[PanelData.BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div BG.Width;
          YCnt := Height div BG.Height;
          //
          if PanelData.StretchEffect
          then
            with PanelData do
            begin
              case StretchType of
                 bsstFull:
                   begin
                     C.StretchDraw(Rect(0, 0, Width, Height), BG);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := BG.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), BG);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       C.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := BG.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), BG);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      C.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
            end
          else
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
             C.Draw(X * BG.Width, Y * BG.Height, BG);
        end;
      Exit;
    end
  else
    with PanelData do
    begin
       NewClRect := Rect(0, 0, Width, Height);
        //
        w := RectWidth(ClRect);
        h := RectHeight(ClRect);
        w1 := RectWidth(NewClRect);
        h1 := REctHeight(NewCLRect);
        XCnt := w1 div w;
        YCnt := h1 div h;
        Clb := TBitMap.Create;
        Clb.Width := w;
        Clb.Height := h;
        Clb.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
             SkinRect.Left + ClRect.Right,
             SkinRect.Top + ClRect.Bottom));
        SaveIndex := SaveDC(C.Handle);
        IntersectClipRect(C.Handle, NewCLRect.Left, NewCLRect.Top, NewCLRect.Right, NewClRect.Bottom);
        if PanelData.StretchEffect
        then
          with PanelData do
          begin
            case StretchType of
                 bsstFull:
                   begin
                     C.StretchDraw(Rect(0, 0, Width, Height), Clb);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := Clb.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       C.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Clb.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      C.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
          end
        else  
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
          begin
           C.Draw(NewClRect.Left + X * w, NewClRect.Top + Y * h, Clb);
         end;
        Clb.Free;
      RestoreDC(C.Handle, SaveIndex);
    end;
end;

procedure TbsaToolbarSubclass.Paint(Canvas: TCanvas);
const
  BTNS_WHOLEDROPDOWN  = $0080;
  seTransparent = $007F007F;
var
  i: Integer;
  R, R1, iRect, sRect: TRect;
  Info: TTBButtonInfo;
  ImageDrawed: Boolean;
  DropDownWidth: Integer;
  CustDraw: TNMTBCUSTOMDRAW;
  WStyle: Cardinal;
  x, y: Integer;
  Gray: Integer;
  B: TbsBitMap;
  Color: PbsColor;
  BDown, BActive: Boolean;
  ButtonCaption: String;
  Flat: Boolean;
begin
  DropDownWidth := 13;
  WStyle := GetWindowLong(Handle, GWL_STYLE);
  if WStyle and TBSTYLE_CUSTOMERASE = TBSTYLE_CUSTOMERASE then
  begin
    SendMessage(Handle, WM_ERASEBKGND, 0, 0);
  end;

  DrawBackground(Canvas);
  
  ApplyImageList;

  Flat := WStyle and TBSTYLE_FLAT = TBSTYLE_FLAT;
  
  for i := 0 to ButtonCount - 1 do
  begin
    R := ItemRect(i);
    Info := ItemInfo(i);
    BDown := False;
    BActive := False;
    //
    if Info.fsState and TBSTATE_HIDDEN = TBSTATE_HIDDEN
    then
      Continue;
    //
    if Info.fsState and TBSTATE_CHECKED = TBSTATE_CHECKED
    then
      begin
        BDown := True;
      end
    else
    if Info.fsState and TBSTATE_PRESSED = TBSTATE_PRESSED
    then
      BDown := True
    else
    if ((FHotButton = i) and FMouseIn) or ((FButtonDropDown = i) and (Info.fsStyle and TBSTYLE_DROPDOWN = TBSTYLE_DROPDOWN))
    then
      BActive := True;

    if Info.fsState and TBSTATE_ENABLED = 0
    then
      begin
        BActive := False;
        Canvas.Font.Color := Self.FManager.Adapter.SkinData.SkinColors.cBtnShadow;
      end;
    if (Control is TToolBar)
    then
      begin
        Canvas.Font := TToolBar(Control).Font;
        ButtonCaption := TToolBar(Control).Buttons[i].Caption;
        if not TToolBar(Control).ShowCaptions then ButtonCaption := '';
        StrPCopy(Info.pszText, ButtonCaption);
      end;
    { Face }
    ImageDrawed := True;
    if Info.fsStyle and TBSTYLE_CHECK = TBSTYLE_CHECK then
    begin
      DrawButtonFace(Canvas, R, BActive, BDown, Flat, False);
    end
    else
      if Info.fsStyle and BTNS_WHOLEDROPDOWN = BTNS_WHOLEDROPDOWN then
      begin
        DrawButtonFace(Canvas, R, BActive, BDown, Flat, True);
        R1 := R;
        R1.Left := R1.Right - DropDownWidth - 2;
        R.Right := R.Right - DropDownWidth;
      end
      else
      if Info.fsStyle and TBSTYLE_DROPDOWN = TBSTYLE_DROPDOWN then
      begin
        R1 := R;
        R1.Right := R1.Right - DropDownWidth;
        if FButtonDropDown = i
        then
          DrawButtonFace(Canvas, R1, True, False, Flat, False)
        else
          DrawButtonFace(Canvas, R1, BActive, BDown, Flat, False);
        R1 := R;
        R1.Left := R1.Right - DropDownWidth;
        if FButtonDropDown = i
        then
          DrawButtonFace(Canvas, R1, BActive, True, Flat, True)
        else
          DrawButtonFace(Canvas, R1, BActive, BDown, Flat, True);
        R.Right := R.Right - DropDownWidth;
      end
      else
        if Info.fsStyle and TBSTYLE_SEP = TBSTYLE_SEP then
        begin
          DrawSeparator(Canvas, R);
          ImageDrawed := False;
          Info.pszText := #0;
        end
        else
          if Info.fsStyle and TBSTYLE_BUTTON = TBSTYLE_BUTTON then
          begin
            DrawButtonFace(Canvas, R, BActive, BDown, Flat, False);
          end;

    { Text and Image }

    if Info.fsState and TBSTATE_ENABLED = 0
    then
      Canvas.Font.Color := Self.FManager.Adapter.SkinData.SkinColors.cBtnShadow;

    if FImageList <> nil then
    begin
      iRect.Left := R.Left + RectWidth(R) div 2 - FImageList.Width div 2;
      iRect.Top := R.Top + RectHeight(R) div 2 - FImageList.Height div 2;
      iRect.Right := iRect.Left + FImageList.Width;
      iRect.Bottom := iRect.Top + FImageList.Height;
    end
    else
      iRect := NullRect;

    if StrLen(Info.pszText) > 0 then
    begin
      if WStyle and TBSTYLE_FLAT = TBSTYLE_FLAT then
      begin
        // Text on bottom
        sRect := R;
        DrawSkinText(Canvas, Info.pszText, sRect, DT_CENTER or DT_WORDBREAK or DT_CALCRECT);
        x := RectWidth(sRect);
        y := RectHeight(sRect);
        //
        sRect.Left := R.Left + RectWidth(R) div 2 - x div 2;
        sRect.Top := R.Top + RectHeight(R) div 2 - y div 2;
        sRect.Right := sRect.Left + x;
        sRect.Bottom := sRect.Top + y;
        //
        if ImageDrawed and (Info.iImage >= 0) and (FImageList <> nil) then
        begin
          OffsetRect(sRect, 0, RectHeight(iRect) div 2);
          OffsetRect(iRect, 0, -RectHeight(sRect) div 2);
        end;
        DrawSkinText(Canvas, Info.pszText, sRect, DT_CENTER or DT_WORDBREAK);
      end
      else
        if WStyle and TBSTYLE_LIST = TBSTYLE_LIST then
        begin
          // Right text
          sRect := R;
          DrawSkinText(Canvas, Info.pszText, sRect, DT_CENTER or DT_WORDBREAK or DT_CALCRECT);
          x := RectWidth(sRect);
          y := RectHeight(sRect);
          //
          sRect.Left := R.Left + RectWidth(R) div 2 - x div 2;
          sRect.Top := R.Top + RectHeight(R) div 2 - y div 2;
          sRect.Right := sRect.Left + x;
          sRect.Bottom := sRect.Top + y;
          //
          if ImageDrawed and (Info.iImage >= 0) and (FImageList <> nil) then
          begin
            OffsetRect(sRect, RectWidth(iRect) div 2, 0);
            OffsetRect(iRect, -RectWidth(sRect) div 2, 0);
          end;
          DrawSkinText(Canvas, Info.pszText, sRect, DT_CENTER or DT_WORDBREAK);
        end;
    end;

    if ImageDrawed and (Info.iImage >= 0) and (FImageList <> nil) then
    begin
      if Info.fsState and TBSTATE_ENABLED = 0 then
      begin
        B := TbsBitmap.Create;
        B.SetSize(FImageList.Width, FImageList.Height);
        B.Clear(seTransparent);
        ImageList_Draw(FImageList.Handle, Info.iImage, B.DC, 0, 0, ILD_TRANSPARENT);
        for x := 0 to B.Width - 1 do
          for y := 0 to B.Width - 1 do
          begin
            Color := B.PixelPtr[x, y];
            if Color^ <> seTransparent then
            begin
              Gray := Intensity(Color^);
              Color^ := bsColor(Gray, Gray, Gray);
            end;
          end;
        B.Transparent := True;
        B.Draw(Canvas, iRect.Left, iRect.Top);
        B.Free;
      end
      else
        ImageList_Draw(FImageList.Handle, Info.iImage, Canvas.Handle, iRect.Left, iRect.Top, ILD_TRANSPARENT);
    end;
  end;
end;

procedure TbsaToolbarSubclass.WMMouseMove(var Msg: TWMMouse);
var
  i: Integer;
begin
  for i := 0 to ButtonCount - 1 do
  begin
    if PtInRect(ItemRect(i), Point(Msg.XPos, Msg.YPos)) then
    begin
      if FHotButton <> i then
        Invalidate;
      FHotButton := i;
      Exit;
    end;
  end;
  if FHotButton >= 0 then
  begin
    FHotButton := -1;
    Invalidate;
  end;
end;

procedure TbsaToolbarSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
  Handled := True;
end;

{ TbsaCoolBarSubclass ============================================================}

constructor TbsaCoolBarSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FDoubleBuffered := True;
end;

procedure TbsaCoolBarSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
  Handled := True;
end;

procedure TbsaCoolbarSubclass.WMSize(var Msg: TMessage);
begin
  CallDefaultProc(TMessage(Msg));
  Handled := True;
  Invalidate;
end;

function TbsaCoolBarSubclass.Count: Integer;
begin
  Result := SendMessage(Handle, RB_GETBANDCOUNT, 0, 0);
end;

function TbsaCoolBarSubclass.Band(Index: Integer): TRebarBandInfo;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.cbSize := SizeOf(Result);
  SendMessage(Handle, RB_GETBANDINFO, Index, LongInt(@Result));
end;

function TbsaCoolBarSubclass.BandText(Index: Integer): WideString;
var
  Info: TRebarBandInfo;
begin
  FillChar(Info, SizeOf(Info), 0);
  Info.cbSize := SizeOf(Info);
  Info.fMask := RBBIM_TEXT;
  Info.lpText := @BufMan;
  Info.cch := 300;
  SendMessage(Handle, RB_GETBANDINFO, Index, LongInt(@Info));
  Result := Info.lpText;
end;

function TbsaCoolBarSubclass.BandRect(Index: Integer): TRect;
begin
  Result := NullRect;
  SendMessage(Handle, RB_GETRECT, Index, LongInt(@Result));
end;

function TbsaCoolBarSubclass.BandBorder(Index: Integer): TRect;
begin
  SendMessage(Handle, RB_GETBANDBORDERS, Index, LongInt(@Result));
  if RBS_BANDBORDERS and GetWindowLong(Handle, GWL_STYLE) = 0 then
  begin
    Result.Top := 0;
    Result.Right := 0;
    Result.Bottom := 0;
  end;
end;

procedure TbsaCoolbarSubclass.DrawBackground(C: TCanvas);
const
  Alignments: array[TAlignment] of LongInt = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Picture, BG, Buffer2: TBitMap;
  XO, YO, X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  PanelData: TbsDataSkinpanelControl;
  CIndex: Integer;
  CR: TRect;
  FrameColor: TColor;
  ClB: TBitMap;
  SaveIndex: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewClRect: TRect;
begin
  if (Width <= 0) or (Height <=0) then Exit;

  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex(FManager.Adapter.CoolBarSkinDataName);
    if CIndex = -1 then Exit;
    PanelData := TbsDataSkinPanelControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[PanelData.PictureIndex]);
  end;

  if PanelData.BGPictureIndex <> -1
  then
    begin
      BG := TBitMap(FManager.Adapter.SkinData.FActivePictures.Items[PanelData.BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div BG.Width;
          YCnt := Height div BG.Height;
          //
          if PanelData.StretchEffect
          then
            with PanelData do
            begin
              case StretchType of
                 bsstFull:
                   begin
                     C.StretchDraw(Rect(0, 0, Width, Height), BG);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := BG.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), BG);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       C.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := BG.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), BG);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      C.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
            end
          else
            for X := 0 to XCnt do
            for Y := 0 to YCnt do
             C.Draw(X * BG.Width, Y * BG.Height, BG);
        end;
      Exit;
    end
  else
    with PanelData do
    begin
       NewClRect := Rect(0, 0, Width, Height);
        //
        w := RectWidth(ClRect);
        h := RectHeight(ClRect);
        w1 := RectWidth(NewClRect);
        h1 := REctHeight(NewCLRect);
        XCnt := w1 div w;
        YCnt := h1 div h;
        Clb := TBitMap.Create;
        Clb.Width := w;
        Clb.Height := h;
        Clb.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
             SkinRect.Left + ClRect.Right,
             SkinRect.Top + ClRect.Bottom));
        SaveIndex := SaveDC(C.Handle);
        IntersectClipRect(C.Handle, NewCLRect.Left, NewCLRect.Top, NewCLRect.Right, NewClRect.Bottom);
        if PanelData.StretchEffect
        then
          with PanelData do
          begin
            case StretchType of
                 bsstFull:
                   begin
                     C.StretchDraw(Rect(0, 0, Width, Height), Clb);
                   end;
                 bsstVert:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Width;
                     Buffer2.Height := Clb.Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
                     YCnt := Height div Buffer2.Height;
                     for Y := 0 to YCnt do
                       C.Draw(0, Y * Buffer2.Height, Buffer2);
                     Buffer2.Free;
                   end;
                 bsstHorz:
                   begin
                     Buffer2 := TBitMap.Create;
                     Buffer2.Width := Clb.Width;
                     Buffer2.Height := Height;
                     Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Clb);
                     XCnt := Width div Buffer2.Width;
                     for X := 0 to XCnt do
                      C.Draw(X * Buffer2.Width, 0, Buffer2);
                     Buffer2.Free;
                   end;
              end;
          end
        else  
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
          begin
           C.Draw(NewClRect.Left + X * w, NewClRect.Top + Y * h, Clb);
         end;
        Clb.Free;
      RestoreDC(C.Handle, SaveIndex);
    end;
end;

procedure TbsaCoolBarSubclass.Paint(Canvas: TCanvas);
var
  i: Integer;
  R, R1, Margin, textR: TRect;
  S: WideString;
  LightColor, DarkColor: TColor;
begin
  { Background }
  DrawBackground(Canvas);
  { Bands }
  for i := 0 to Count - 1 do
  begin
    R := BandRect(i);
    Margin := BandBorder(i);
    InflateRect(R, 1, 1);
    LightColor := FManager.Adapter.SkinData.SkinColors.cBtnHighLight;
    DarkColor := FManager.Adapter.SkinData.SkinColors.cBtnShadow;
    Frm3D(Canvas, R, LightColor, DarkColor);
    { text }
    S := BandText(i);
    if S <> '' then
    begin
      textR := Rect(R.Left + 10, R.Top, R.Left + Margin.Left, R.Bottom);
      if Control is TCoolBar
      then
        Canvas.Font := TCoolBar(Control).Font;
      Canvas.Font.Color := FManager.Adapter.SkinData.SkinColors.cBtnText;
      DrawSkinText(Canvas, S, textR, DT_VCENTER or DT_SINGLELINE)
    end;
   { gripper }
   R1 := R;
   R := Rect(R.Left + 3, R.Top + 2, R.Left + 5, R.Bottom - 2);
   Frm3D(Canvas, R, LightColor, DarkColor);
   R := R1;
   R := Rect(R.Left + 6, R.Top + 2, R.Left + 8, R.Bottom - 2);
   Frm3D(Canvas, R, LightColor, DarkColor);
  end;
end;

{ TbsaProgressBarSubclass =========================================================}
constructor TbsaProgressBarSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  FDoubleBuffered := True;
end;

procedure TbsaProgressBarSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  Handled := True;
end;

function TbsaProgressBarSubclass.GetBarRect: TRect;
begin
  Result := Rect(1, 1, Width - 3, Height - 3);
  InflateRect(Result, -BorderWidth, -BorderWidth);
end;

procedure TbsaProgressBarSubclass.WMNCPaint(var Msg: TWMNCPaint);
var
  R, R1: TRect;
  Offset: Integer;
  Canvas: TCanvas;
  BorderColor: TColor;
begin
  if not FManager.IsSkinAvailable
  then
    begin
      CallDefaultProc(TMessage(Msg));
      Exit;
    end;
  R := NullRect;
  Canvas := TCanvas.Create;
  if (Control <> nil) and (Control is TWinControl) then
  begin
    Canvas.Handle := GetWindowDC(TWinControl(Control).Handle);
    R := Control.BoundsRect;
  end
  else
    if Handle <> 0 then
    begin
      Canvas.Handle := GetWindowDC(Handle);
      GetWindowRect(Handle, R);
    end;
  //
  Offset := (Width - FControl.ClientWidth) div 2;
  ExcludeClipRect(Canvas.Handle, Offset, Offset, Width - Offset, Height - Offset);
  OffsetRect(R, -R.Left, -R.Top);
  // draw border
  BorderColor := FManager.Adapter.SkinData.SkinColors.cBtnFace;
  Canvas.Brush.Color := BorderColor;
  Canvas.FillRect(Rect(0, 0, Width, Height));
  //
  ReleaseDC(Handle, Canvas.Handle);
  Canvas.Handle := 0;
  Canvas.Free;
  Handled := True;
end;

function TbsaProgressBarSubclass.CalcProgressRect(R: TRect): TRect;
var
  kf: Double;
  Offset: Integer;
begin
  if Min = Max
  then
    Kf := 0
  else
    kf := (Position - Min) / (Max - Min);
  if Orientation = pbHorizontal
  then
    begin
      Offset := Trunc(RectWidth(R) * kf);
      R.Right := R.Left + Offset;
      Result := R;
    end
  else
    begin
      Offset := Trunc(RectHeight(R) * kf);
      R.Top := R.Bottom - Offset;
      Result := R;
    end;
end;

procedure TbsaProgressBarSubclass.Paint(Canvas: TCanvas);
var
  R, R1, PR, PArea: TRect;
  Buffer, Buffer2, Buffer3: TBitMap;
  ProgressData: TbsDataSkinGaugeControl;
  CIndex, X, BeginOffset, EndOffset: Integer;
  Picture: TBitmap;
begin
  Windows.GetClientRect(Handle, R);
  if (RectWidth(R) <= 0) or (RectHeight(R) <= 0) then Exit;
  // get skin data
  with FManager.Adapter.SkinData do
  begin
    if Orientation = pbHorizontal
    then
      CIndex := GetControlIndex('gauge')
    else
      CIndex := GetControlIndex('vgauge');
    if CIndex = -1 then Exit;
    ProgressData := TbsDataSkinGaugeControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[ProgressData.PictureIndex]);
  end;
  // draw body
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  if Orientation = pbHorizontal
  then
    begin
      X := RectHeight(ProgressData.SkinRect) div 3;
      R1 := Rect(ProgressData.LTPoint.X, X,
                ProgressData.RTPoint.X,
                RectHeight(ProgressData.SkinRect) - X);
    end
  else
    begin
      X := RectWidth(ProgressData.SkinRect) div 3;
      R1 := Rect(X, ProgressData.LTPoint.Y,
                    RectWidth(ProgressData.SkinRect) - X,
                    ProgressData.LBPoint.Y);
    end;
  if ProgressData.StretchEffect
  then
    CreateStretchImage(Buffer, Picture, ProgressData.SkinRect, R1, True)
  else
    begin
       Buffer2 := TBitMap.Create;
       if Orientation = pbHorizontal
       then
         begin
           BeginOffset := ProgressData.LTPoint.X;
           EndOffset := RectWidth(ProgressData.SkinRect) - ProgressData.RTPoint.X;

           Buffer2.Width := Buffer.Width;
           Buffer2.Height := RectHeight(ProgressData.SkinRect);
           CreateHSkinImage(BeginOffset, EndOffset,
             Buffer2, Picture, ProgressData.SkinRect, Buffer2.Width, Buffer2.Height,
            False);
            R1 := Rect(BeginOffset, X, Buffer2.Width - EndOffset, Buffer2.Height - X);
        end
      else
        begin
          BeginOffset := ProgressData.LTPoint.Y;
          EndOffset := RectHeight(ProgressData.SkinRect) - ProgressData.LBPoint.Y;
          Buffer2.Height := Buffer.Height;
          Buffer2.Width := RectWidth(ProgressData.SkinRect);
          CreateVSkinImage(BeginOffset, EndOffset,
            Buffer2, Picture, ProgressData.SkinRect, Buffer2.Width, Buffer2.Height,
               False);
          R1 := Rect(X, BeginOffset,  Buffer2.Width - X, Buffer2.Height - EndOffset);
       end;
      CreateStretchImage(Buffer, Buffer2, Rect(0, 0, Buffer2.Width, Buffer2.Height), R1, True);
      Buffer2.Free;
    end;
  // draw bar
  PArea := ProgressData.ProgressArea;
  PArea.Right := Buffer.Width - (RectWidth(ProgressData.SkinRect) - ProgressData.ProgressArea.Right);
  PArea.Bottom := Buffer.Height - (RectHeight(ProgressData.SkinRect) - ProgressData.ProgressArea.Bottom);
  PArea :=  CalcProgressRect(PArea);
  //
  if (RectWidth(PArea) > 0) and (RectHeight(PArea) > 0)
  then
    begin
      Buffer2 := TBitMap.Create;
      Buffer2.Width := RectWidth(PArea);
      Buffer2.Height := RectHeight(PArea);
      //
      if Orientation = pbHorizontal
      then
        begin
          X := RectHeight(ProgressData.ProgressRect) div 3;
          R1 := Rect(ProgressData.BeginOffset, X,
                     RectWidth(ProgressData.ProgressRect) - ProgressData.EndOffset,
                     RectHeight(ProgressData.ProgressRect) - X);
        end
      else
        begin
          X := RectWidth(ProgressData.ProgressRect) div 3;
          R1 := Rect(X, ProgressData.BeginOffset,
                     RectWidth(ProgressData.ProgressRect) - X,
                     RectHeight(ProgressData.ProgressRect) - ProgressData.EndOffset);
        end;
      if ProgressData.ProgressStretch
      then
        CreateStretchImage(Buffer2, Picture, ProgressData.ProgressRect, R1, True)
      else
        begin
          Buffer3 := TBitMap.Create;
          if Orientation = pbHorizontal
          then
            begin
              Buffer3.Width := Buffer2.Width;
              Buffer3.Height := RectHeight(ProgressData.ProgressRect);
              CreateHSkinImage(ProgressData.BeginOffset, ProgressData.EndOffset,
                Buffer3, Picture, ProgressData.ProgressRect, Buffer3.Width, Buffer3.Height,
                False);
              R1 := Rect(ProgressData.BeginOffset, X,
                    Buffer3.Width - ProgressData.EndOffset,
                    Buffer3.Height - X);
              if IsNullRect(R1) and (Buffer3.Width > 2)
              then
                begin
                  R1.Left := Buffer3.Width div 3;
                  R1.Right := Buffer3.Width - R1.Left;
                end;
            end
          else
            begin
              Buffer3.Height := Buffer2.Height;
              Buffer3.Width := RectWidth(ProgressData.ProgressRect);
              CreateVSkinImage(ProgressData.BeginOffset, ProgressData.EndOffset,
                Buffer3, Picture, ProgressData.ProgressRect, Buffer3.Width, Buffer3.Height,
                False);
              R1 := Rect(X, ProgressData.BeginOffset,
                     Buffer3.Width - X, Buffer3.Height - ProgressData.EndOffset);

              if IsNullRect(R1) and (Buffer3.Height > 2)
              then
                begin
                  R1.Top := Buffer3.Height div 3;
                  R1.Bottom := Buffer3.Height - R1.Top;
                end;
            end;

          if not IsNullRect(R1)
          then
            CreateStretchImage(Buffer2, Buffer3, Rect(0, 0, Buffer3.Width, Buffer3.Height), R1, True);
            
          Buffer3.Free;
        end;
      //
      if not IsNullRect(R1)
      then
        begin
          if ProgressData.ProgressTransparent
          then
            begin
              Buffer2.Transparent := True;
              Buffer2.TransparentMode := tmFixed;
              Buffer2.TransparentColor := ProgressData.ProgressTransparentColor;
            end;
          Buffer.Canvas.Draw(PArea.Left, PArea.Top, Buffer2);
        end;
      Buffer2.Free;
    end;
  //
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;


function TbsaProgressBarSubclass.Max: Integer;
begin
  Result := SendMessage(Handle, PBM_GetRange, 0, 0);
end;

function TbsaProgressBarSubclass.Min: Integer;
begin
  Result := SendMessage(Handle, PBM_GetRange, 1, 0);
end;

function TbsaProgressBarSubclass.Orientation: TProgressBarOrientation;
begin
  if Handle <> 0 then
    if GetWindowLong(Handle, GWL_STYLE) and PBS_VERTICAL = PBS_VERTICAL then
      Result := pbVertical
    else
      Result := pbHorizontal;
end;

function TbsaProgressBarSubclass.Position: Integer;
begin
  Result := SendMessage(Handle, PBM_GETPOS, 0, 0);
end;

function TbsaProgressBarSubclass.BorderWidth: Integer;
begin
  Result := 0;
end;

{ TbsaTrackBarSubclass ========================================================}

constructor TbsaTrackBarSubclass.Create;
begin
  inherited;
  FThumbPressed := False;
  FOverridedPaint := True;
  FDoubleBuffered := True;
end;

procedure TbsaTrackBarSubclass.WMLButtonUp(var Msg: TWMMouse);
begin
  if GetWindowLong(Handle, GWL_STYLE) and TBS_NOTHUMB = 0 then
  begin
    FThumbPressed := False;
    Invalidate;
  end;
end;

procedure TbsaTrackBarSubclass.TBMSetPos(var Msg: TMessage);
begin
  Invalidate;
end;

procedure TbsaTrackBarSubclass.WMLButtonDown(var Msg: TWMMouse);
var
  R: TRect;
begin
  if GetWindowLong(Handle, GWL_STYLE) and TBS_NOTHUMB = 0 then
  begin
    SendMessage(Handle, TBM_GETTHUMBRECT, 0, Integer(@R));
    if PtInRect(R, Point(Msg.XPos, Msg.YPos)) then
      FThumbPressed := True;
    Invalidate;
  end;
end;

procedure TbsaTrackBarSubclass.WMCHECKPARENTBG(var Msg: TWMEraseBkgnd);
begin
  FControl.Invalidate;
end;

procedure TbsaTrackBarSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
  Handled := True;
end;

procedure TbsaTrackBarSubclass.CNHScroll(var Msg: TWMHScroll);
begin
  FControl.Invalidate;
end;

procedure TbsaTrackBarSubclass.CNVScroll(var Msg: TWMVScroll);
begin
  FControl.Invalidate;
end;

procedure TbsaTrackBarSubclass.Paint(Canvas: TCanvas);
var
  S: Cardinal;
  R, R1, RatioR, thRect: TRect;
  Ratio: Single;
  i, tCount, tickStart, tickEnd, TickPos, RullerX, RullerY, RullerW, RullerH: Integer;
  B: TbsBitMap;
  SliderData: TbsDataSkinSlider;
  TrackBarData: TbsDataSkinTrackBarControl;
  SliderPicture: TBitmap;
  TrackBarPicture: TBitmap;
  CIndex: Integer;
  Buffer: TBitmap;
  
procedure DrawSkinRuler(R: TRect; Horizontal: Boolean);
var
  TmpBmp: TBitmap;
  X, Y: Integer;
begin
  TmpBmp := TBitmap.Create;
  with SliderData do
  try
    if Horizontal
    then
     begin
       TmpBmp.Width := R.Right - R.Left;
       TmpBmp.Height := RectHeight(HRulerRect);
       CreateHSkinImage(EdgeSize, EdgeSize, TmpBmp, SliderPicture, HRulerRect,
         TmpBmp.Width, TmpBmp.Height, False);
       X := R.Left;
       Y := R.Top + RectHeight(R) div 2 - TmpBmp.Height div 2;
     end
    else
      begin
        TmpBmp.Height := R.Bottom - R.Top;
        TmpBmp.Width := RectWidth(HRulerRect);
        CreateVSkinImage(EdgeSize, EdgeSize, TmpBmp, SliderPicture, VRulerRect,
          TmpBmp.Width, TmpBmp.Height, False);
       X := R.Left + RectWidth(R) div 2 - TmpBmp.Width div 2;
       Y := R.Top;
      end;
  finally
    TmpBmp.Transparent := True;
    Canvas.Draw(X, Y, TmpBmp);
    RullerX := X;
    RullerY := Y;
    RullerW := TmpBmp.Width;
    RullerH := TmpBmp.Height;
    TmpBmp.Free;
  end;
end;

procedure DrawBothThumb(R: TRect; Code: Integer); 
var
  TmpBmp: TBitmap;
  X, Y: Integer;
begin
  with TrackBarData do
  begin
    TmpBmp := TBitmap.Create;
    TmpBmp.Width := RectWidth(TrackBarData.ButtonRect);
    TmpBmp.Height := RectHeight(TrackBarData.ButtonRect);
    with TmpBmp.Canvas do
    if FThumbPressed
    then
      CopyRect(Rect(0, 0, TmpBmp.Width, TmpBmp.Height),
             TrackBarPicture.Canvas, ActiveButtonRect)
    else
      CopyRect(Rect(0, 0, TmpBmp.Width, TmpBmp.Height),
             TrackBarPicture.Canvas, ButtonRect);
    X := R.Left + RectWidth(R) div 2 - TmpBmp.Width div 2;
    Y := R.Top + RectHeight(R) div 2 - TmpBmp.Height div 2;
    case Code of
      0:
        begin
          Y := RullerY + RullerH div 2 - TmpBmp.Height div 2;
        end;
      1:
        begin
          X := RullerX + RullerW div 2 - TmpBmp.Width div 2;
        end;
    end;

    if TrackBarData.ButtonTransparent
    then
      begin
        TmpBmp.Transparent := True;
        TmpBmp.TransparentMode := tmFixed;
        TmpBmp.TransparentColor := TrackBarData.ButtonTransparentColor;
      end;
        
    Canvas.Draw(X, Y, TmpBmp);
    TmpBmp.Free;
  end;
end;

procedure DrawThumb(R: TRect; Code: Integer);

procedure FlipVert(B: TBitmap);
var
 J, J2: Integer;
 Buffer: PbsColorArray;
 B1: TbsBitmap;
 P1, P2: PbsColor;
begin
  B1 := TbsBitmap.Create;
  B1.SetSize(B.Width, B.Height);
  B1.Canvas.Draw(0, 0, B);
  J2 := B1.Height - 1;
  GetMem(Buffer, B1.Width shl 2);
  for J := 0 to B1.Height div 2 - 1 do
  begin
    P1 := B1.PixelPtr[0, J];
    P2 := B1.PixelPtr[0, J2];
    MoveLongwordFunc(P1, PbsColor(Buffer), B1.Width);
    MoveLongwordFunc(P2, P1, B1.Width);
    MoveLongwordFunc(PbsColor(Buffer), P2, B1.Width);
    Dec(J2);
  end;
  FreeMem(Buffer);
  B1.Draw(B.Canvas, 0, 0);
  B1.Free;
end;

procedure FlipHorz(B: TBitmap);
var
 X, Y: Integer;
 B1, B2: TbsBitmap;
begin
  B1 := TbsBitmap.Create;
  B1.SetSize(B.Width, B.Height);
  B1.Canvas.Draw(0, 0, B);
  B2 := TbsBitmap.Create;
  B2.SetSize(B.Width, B.Height);
  for Y := 0 to B2.Height - 1 do
  for X := 0 to B2.Width - 1 do
    B2.Pixels[B2.Width - 1 - X, Y] := B1.Pixels[X, Y];
  B2.Draw(B.Canvas, 0, 0);
  B1.Free;
  B2.Free;
end;

var
  TmpBmp: TBitmap;
  SR: TRect;
  X, Y: Integer;
  TransColor: TColor;
begin
  TmpBmp := TBitmap.Create;
  X := SliderData.HThumbRect.Left;
  Y := SliderData.HThumbRect.Bottom - 1;
  TransColor := SliderPicture.Canvas.Pixels[X, Y];
  with SliderData do
  case Code of
   0:
     begin
       SR := SliderData.HThumbRect;
       if FThumbPressed
       then
         SR.Left := SR.Left + RectWidth(SR) div 2
       else
         SR.Right := SR.Left + RectWidth(SR) div 2;
     end;
   1:
     begin
       SR := SliderData.VThumbRect;
       if FThumbPressed
       then
         SR.Left := SR.Left + RectWidth(SR) div 2
       else
         SR.Right := SR.Left + RectWidth(SR) div 2;
     end;
   2:
     begin
       SR := SliderData.HThumbRect;
       if FThumbPressed
       then
         SR.Left := SR.Left + RectWidth(SR) div 2
       else
         SR.Right := SR.Left + RectWidth(SR) div 2;
     end;
   3:
     begin
       SR := SliderData.VThumbRect;
       if FThumbPressed
       then
         SR.Left := SR.Left + RectWidth(SR) div 2
       else
         SR.Right := SR.Left + RectWidth(SR) div 2;
     end;
  end;
  TmpBmp.Width := RectWidth(SR);
  TmpBmp.Height := RectHeight(SR);
  TmpBmp.Canvas.CopyRect(Rect(0, 0, TmpBmp.Width, TmpBmp.Height),
    SliderPicture.Canvas, SR);
  X := R.Left + RectWidth(R) div 2 - TmpBmp.Width div 2;
  Y := R.Top + RectHeight(R) div 2 - TmpBmp.Height div 2;
  case Code of
    0:
      begin
        Y := RullerY + RullerH div 2 - TmpBmp.Height div 2;
      end;
    1:
      begin
        X := RullerX + RullerW div 2 - TmpBmp.Width div 2;
      end;
    2:
      begin
        Y := RullerY + RullerH div 2 - TmpBmp.Height div 2;
        FlipVert(TmpBmp);
      end;
    3:
      begin
        X := RullerX + RullerW div 2 - TmpBmp.Width div 2;
        FlipHorz(TmpBmp);
      end;
  end;
  TmpBmp.TransparentMode := tmFixed;
  TmpBmp.Transparent := True;
  TmpBmp.TransparentColor := TransColor;

  Canvas.Draw(X, Y, TmpBmp);
  TmpBmp.Free;
end;

begin
  // get skin data //
  S := GetWindowLong(Handle, GWL_STYLE);
  if not FManager.IsSkinAvailable then Exit;
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('slider');
    if CIndex = -1 then Exit;
    SliderData := TbsDataSkinSlider(CtrlList[CIndex]);
    SliderPicture := TBitMap(FActivePictures[SliderData.PictureIndex]);
    if S and TBS_VERT = 0 then
      CIndex := GetControlIndex('htrackbar')
    else
      CIndex := GetControlIndex('trackbar');
    if CIndex = -1 then Exit;
    TrackBarData := TbsDataSkinTrackBarControl(CtrlList[CIndex]);
    TrackBarPicture := TBitMap(FActivePictures[TrackBarData.PictureIndex]);
  end;

  GetSkinParentImage(FControl, Canvas);
  SendMessage(Handle, TBM_GETCHANNELRECT, 0, Integer(@R));
  
  if S and TBS_VERT = 0
  then
    begin
    end
  else
    begin
      R1 := R;
      R.Left := R1.Top;
      R.Top := R1.Left;
      R.Right := R1.Bottom;
      R.Bottom := R1.Right;
   end;
  // draw ruller
  DrawSkinRuler(R, S and TBS_VERT = 0);
  // draw ticks
  if S and TBS_NOTICKS = 0 then
  begin
    SendMessage(Handle, TBM_GETCHANNELRECT, 0, Integer(@R));
    SendMessage(Handle, TBM_GETTHUMBRECT, 0, Integer(@thRect));
    tCount := SendMessage(Handle, TBM_GETNUMTICS, 0, 0);
    Canvas.Pen.Color := SliderData.PointsColor;
    if not Enabled then
      Canvas.Pen.Color := FManager.Adapter.SkinData.SkinColors.cBtnHighLight;
    { first }
    if S and TBS_VERT = 0 then
    begin
      TickPos := R.Left + RectWidth(thRect) div 2;
      if (S and TBS_TOP = TBS_TOP) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(TickPos, R.Top - 7);
        Canvas.LineTo(TickPos, R.Top - 3);
      end;
      if (S and TBS_TOP = 0) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(TickPos, R.Bottom + 3);
        Canvas.LineTo(TickPos, R.Bottom + 7);
      end;
      tickStart := TickPos;
    end
    else
    begin
      TickPos := R.Left + RectHeight(thRect) div 2;
      if (S and TBS_TOP = TBS_TOP) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(R.Top - 7, TickPos);
        Canvas.LineTo(R.Top - 3, TickPos);
      end;
      if (S and TBS_TOP = 0) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(R.Bottom + 3, TickPos);
        Canvas.LineTo(R.Bottom + 7, TickPos);
      end;
      tickStart := TickPos;
    end;
    { last }
    if S and TBS_VERT = 0 then
    begin
      TickPos := R.Right - RectWidth(thRect) div 2;
      if (S and TBS_TOP = TBS_TOP) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(TickPos, R.Top - 7);
        Canvas.LineTo(TickPos, R.Top - 3);
      end;
      if (S and TBS_TOP = 0) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(TickPos, R.Bottom + 3);
        Canvas.LineTo(TickPos, R.Bottom + 7);
      end;
      tickEnd := TickPos;
    end
    else
    begin
      TickPos := R.Right - RectHeight(thRect) div 2;
      if (S and TBS_TOP = TBS_TOP) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(R.Top - 7, TickPos);
        Canvas.LineTo(R.Top - 3, TickPos);
      end;
      if (S and TBS_TOP = 0) or (S and TBS_BOTH = TBS_BOTH) then
      begin
        Canvas.MoveTo(R.Bottom + 3, TickPos);
        Canvas.LineTo(R.Bottom + 7, TickPos);
      end;
      tickEnd := TickPos;
    end;
    { ticks }
    for i := 1 to tCount - 1 do
    begin
      TickPos := tickStart + Round((tickEnd - tickStart) * (i/(tCount-1)));
      if S and TBS_VERT = 0 then
      begin
        if (S and TBS_TOP = TBS_TOP) or (S and TBS_BOTH = TBS_BOTH) then
        begin
          Canvas.MoveTo(TickPos, R.Top - 6);
          Canvas.LineTo(TickPos, R.Top - 3);
        end;
        if (S and TBS_TOP = 0) or (S and TBS_BOTH = TBS_BOTH) then
        begin
          Canvas.MoveTo(TickPos, R.Bottom + 3);
          Canvas.LineTo(TickPos, R.Bottom + 6);
        end;
      end
      else
      begin
        if (S and TBS_TOP = TBS_TOP) or (S and TBS_BOTH = TBS_BOTH) then
        begin
          Canvas.MoveTo(R.Top - 6, TickPos);
          Canvas.LineTo(R.Top - 3, TickPos);
        end;
        if (S and TBS_TOP = 0) or (S and TBS_BOTH = TBS_BOTH) then
        begin
          Canvas.MoveTo(R.Bottom + 3, TickPos);
          Canvas.LineTo(R.Bottom + 6, TickPos);
        end;
      end;
    end;
  end;
  // draw thumb

  if S and TBS_NOTHUMB = 0
  then
    begin
      SendMessage(Handle, TBM_GETTHUMBRECT, 0, Integer(@R));
       if S and TBS_VERT = 0
      then
        begin
          if S and TBS_BOTH = TBS_BOTH
          then
            begin
              DrawBothThumb(R, 0);
            end
          else
         if S and TBS_TOP = TBS_TOP
         then
           begin
             DrawThumb(R, 2);
           end
         else
           begin
             DrawThumb(R, 0);
           end;
        end
      else
        begin
          if S and TBS_BOTH = TBS_BOTH
          then
            begin
              DrawBothThumb(R, 1);
            end
          else
         if S and TBS_TOP = TBS_TOP
         then
           begin
             DrawThumb(R, 3);
           end
         else
           begin
             DrawThumb(R, 1);
           end;
      end;
  end;
  //  
  if Focused
  then
    begin
      Canvas.Font.Color := FManager.Adapter.SkinData.SkinColors.cBtnText;
      DrawSkinFocusRect(Canvas, Rect(0, 0, Width, Height));
    end;
end;



{ TbsaStatusBarSubclass ========================================================}

function FindBSFComponent(AForm: TCustomForm): TbsBusinessSkinForm;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AForm.ComponentCount - 1 do
   if AForm.Components[i] is TbsBusinessSkinForm
   then
     begin
       Result := TbsBusinessSkinForm(AForm.Components[i]);
       Break;
     end;
end;

constructor TbsaStatusBarSubclass.Create;
begin
  inherited;
  FOverridedPaint := True;
  BSF := nil;
end;

procedure TbsaStatusBarSubclass.SkinChange;
begin
  inherited;
  if BSF = nil then BSF := FindBSFComponent(GetParentForm(FControl));
end;

procedure TbsaStatusBarSubclass.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  CallDefaultProc(TMessage(Msg));
  if (Msg.Result = HTBOTTOMRIGHT) and not CanShowGrip
  then
    Msg.Result := HTCLIENT;
  Handled := True;
end;

function TbsaStatusBarSubclass.CanShowGrip: Boolean;
var
  F: TCustomForm;
begin
  Result := False;
  if FControl = nil then Exit;
  F := GetParentForm(FControl);
  if BSF <> nil
  then
    begin
      if FControl is TStatusBar then Result := TStatusBar(FControl).SizeGrip;
      if Result
      then
        Result := (TbsBusinessSkinForm(BSF).WindowState <> wsMaximized) and
                  not (F.BorderStyle in [bsSingle, bsDialog, bsToolWindow]);
    end;
end;

procedure TbsaStatusBarSubclass.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
  Handled := True;
end;

procedure TbsaStatusBarSubclass.Paint(Canvas: TCanvas);

procedure DrawPanel(Cnvs: TCanvas; R:TRect; Str: WideString; StrO: Integer);
var
  Buf, Picture: TBitMap;
  PanelData: TbsDataSkinLabelControl;
  CIndex, LO, RO, XO: Integer;
  TxtR, R1: TRect;
begin
  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('statuspanel');
    if CIndex = -1 then Exit;
    PanelData := TbsDataSkinLabelControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[PanelData.PictureIndex]);
  end;
  Buf := TBitMap.Create;
  Buf.Width := RectWidth(R);
  Buf.Height := RectHeight(R);
  //
  LO := PanelData.LTPoint.X;
  RO := RectWidth(PanelData.SkinRect) - PanelData.RTPoint.X;
  CreateHSkinImage(LO, RO,
  Buf, Picture, PanelData.SkinRect, Buf.Width, Buf.Height, PanelData.StretchEffect);
  //
  Buf.Canvas.Font.Assign(TbsaSubclassHackControl(FControl).Font);
  Buf.Canvas.Font.Color := PanelData.FontColor;
  XO := RectWidth(PanelData.SkinRect) - PanelData.ClRect.Right;
  TxtR := PanelData.ClRect;
  TxtR.Left := TxtR.Left + StrO;
  TxtR.Right := Buf.Width - XO;
  R1 := Rect(0, 0, 0, 0);
  DrawSkinText(Buf.Canvas, Str, R1, DT_LEFT or DT_CALCRECT);
  TxtR.Top := TxtR.Top + RectHeight(TxtR) div 2 - RectHeight(R1) div 2 - 1;
  TxtR.Bottom := TxtR.Top + RectHeight(R1);
  DrawSkinText(Buf.Canvas, Str, TxtR, DT_LEFT);
  Cnvs.Draw(R.Left, R.Top, Buf);
  Buf.Free;
end;

var
  Buffer, GripperBuffer: TBitMap;
  StatusData: TbsDataSkinPanelControl;
  Picture: TBitmap;
  Count, i, CIndex: Integer;
  Res, LO, RO, StrO: Integer;
  BSF: TbsBusinessSkinForm;
  R, R1: TRect;
  Flags: Cardinal;
  S: WideString;
begin
  if not FManager.IsSkinAvailable then Exit;
  // get skin data

  with FManager.Adapter.SkinData do
  begin
    CIndex := GetControlIndex('statusbar');
    if CIndex = -1 then Exit;
    StatusData := TbsDataSkinPanelControl(CtrlList[CIndex]);
    Picture := TBitMap(FActivePictures[StatusData.PictureIndex]);
  end;

  if FControl.Height <> RectHeight(StatusData.SkinRect)
  then
    begin
      FControl.Height := RectHeight(StatusData.SkinRect);
    end;

  Buffer := TBitMap.Create;
  Buffer.Width := FControl.Width;
  Buffer.Height := FControl.Height;
  //
  LO := StatusData.LTPoint.X;
  RO := RectWidth(StatusData.SkinRect) - StatusData.RTPoint.X;
  CreateHSkinImage(Lo, RO, Buffer, Picture, StatusData.SkinRect, Buffer.Width, Buffer.Height, StatusData.StretchEffect);
  // draw grip
  if CanShowGrip
  then
    with StatusData do
    begin
      GripperBuffer := TBitMap.Create;
      GripperBuffer.Width := RectWidth(GripperRect);
      GripperBuffer.Height := RectHeight(GripperRect);
      GripperBuffer.Canvas.CopyRect(
         Rect(0, 0, GripperBuffer.Width, GripperBuffer.Height),
         Picture.Canvas, GripperRect);
      if GripperTransparent
      then
        begin
          GripperBuffer.Transparent := True;
          GripperBuffer.TransparentMode := tmFixed;
          GripperBuffer.TransparentColor := GripperTransparentColor;
        end;
      R := GetClientRect;
      R.Left := R.Right - GripperBuffer.Width - 2;
      R.Top := FControl.Height - GripperBuffer.Height  - 2;
      R.Bottom := R.Top + GripperBuffer.Height;

      Buffer.Canvas.Draw(R.Left, R.Top, GripperBuffer);

      GripperBuffer.Free;
    end;
  // draw panels
  if SendMessage(Handle, SB_ISSIMPLE, 0, 0) > 0
  then
    begin
      R.Left := StatusData.ClRect.Left;
      R.Top := StatusData.ClRect.Top;
      R.Bottom := StatusData.ClRect.Bottom;
      if CanShowGrip
      then
        R.Right := R.Right - RectWidth(StatusData.GripperRect) - 2
      else
        R.Right := FControl.Width - StatusData.ClRect.Left;

      {$IFDEF TNTUNICODE_SUPPORT}
      S := TTntStatusBar(FControl).SimpleText;
      {$ELSE}
      S := TStatusBar(FControl).SimpleText;
      {$ENDIF}

      DrawPanel(Buffer.Canvas, R, S, 0);

    end
  else
    begin
      if Control is TStatusBar
      then
        Count := TStatusBar(Control).Panels.Count
      else
        Count := SendMessage(Handle, SB_GETPARTS, 0, 0);
      for i := 0 to Count - 1 do
      begin
        R := Rect(0, 0, 0, 0);
        SendMessage(Handle, SB_GETRECT, i, Integer(@R));
        StrO := 0;
        if i > 0
        then
          begin
            R1 := Rect(0, 0, 0, 0);
            SendMessage(Handle, SB_GETRECT, i - 1, Integer(@R1));
            StrO := R.Left - R1.Right;
            R.Left := R1.Right;
          end;

        if i = Count - 1
        then
          if CanShowGrip
          then
            R.Right := FControl.Width - RectWidth(StatusData.GripperRect) - 2
          else
            R.Right := FControl.Width - StatusData.ClRect.Left;

       {$IFDEF TNTUNICODE_SUPPORT}
        S := TTntStatusBar(FControl).Panels[i].Text;
       {$ELSE}
        S := TStatusBar(FControl).Panels[i].Text;
       {$ENDIF}

        DrawPanel(Buffer.Canvas, R, S, StrO);
      end;
    end;
  //
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;


initialization

  HookList := nil;

  RegisterSubclass(TbsaScrollSubclass);
  RegisterSubclass(TbsaButtonSubclass);
  RegisterSubclass(TbsaCheckBoxSubclass);
  RegisterSubclass(TbsaRadioButtonSubclass);
  RegisterSubclass(TbsaListViewSubclass);
  RegisterSubclass(TbsaTabSubclass);
  RegisterSubclass(TbsaEditSubclass);
  RegisterSubclass(TbsaDateTimeSubclass);
  RegisterSubclass(TbsaComboBoxSubclass);
  RegisterSubclass(TbsaComboListBoxSubclass);
  RegisterSubclass(TbsaSpeedButtonSubclass);
  RegisterSubclass(TbsaGroupBoxSubclass);
  RegisterSubclass(TbsaPanelSubclass);
  RegisterSubclass(TbsaTabSheetSubclass);
  RegisterSubclass(TbsaUpDownSubclass);
  RegisterSubclass(TbsaToolbarSubclass);
  RegisterSubclass(TbsaCoolbarSubclass);
  RegisterSubclass(TbsaProgressbarSubclass);
  RegisterSubclass(TbsaTrackbarSubclass);
  RegisterSubclass(TbsaStatusbarSubclass);

  SetupWinNT;
  ScrollUser32Handle := GetModuleHandle(user32);

  if ScrollUser32Handle > 0 then
    GetScrollBarInfoFunc := GetProcAddress(ScrollUser32Handle, 'GetScrollBarInfo');

  ScrollSubclassStrList := TStringList.Create;
  ButtonSubclassStrList := TStringList.Create;
  SpeedButtonSubclassStrList := TStringList.Create;
  CheckBoxSubclassStrList := TStringList.Create;
  UpDownSubclassStrList := TStringList.Create;
  RadioButtonSubclassStrList := TStringList.Create;
  EditSubclassStrList := TStringList.Create;
  DateTimeSubclassStrList := TStringList.Create;
  ComboBoxSubclassStrList := TStringList.Create;
  ListViewSubclassStrList := TStringList.Create;
  TabSubclassStrList := TStringList.Create;
  GroupBoxSubclassStrList := TStringList.Create;
  PanelSubclassStrList := TStringList.Create;
  ToolBarSubclassStrList := TStringList.Create;
  CoolBarSubclassStrList := TStringList.Create;
  ProgressBarSubclassStrList := TStringList.Create;
  TrackBarSubclassStrList := TStringList.Create;
  StatusBarSubclassStrList := TStringList.Create;
  LabelSubclassStrList := TStringList.Create;

finalization
  DropHookList;

  LabelSubclassStrList.Free;
  PanelSubclassStrList.Free;
  ToolBarSubclassStrList.Free;
  CoolBarSubclassStrList.Free;
  ProgressBarSubclassStrList.Free;
  TrackBarSubclassStrList.Free;
  StatusBarSubclassStrList.Free;
  GroupBoxSubclassStrList.Free;
  TabSubclassStrList.Free;
  ListViewSubclassStrList.Free;
  ComboBoxSubclassStrList.Free;
  EditSubclassStrList.Free;
  DateTimeSubclassStrList.Free;
  RadioButtonSubclassStrList.Free;
  CheckBoxSubclassStrList.Free;
  UpDownSubclassStrList.Free;
  ButtonSubclassStrList.Free;
  SpeedButtonSubclassStrList.Free;
  ScrollSubclassStrList.Free;

  GetScrollBarInfoFunc := nil;

  if SubclassList <> nil then SubclassList.Free;

end.
