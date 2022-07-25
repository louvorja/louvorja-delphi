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


unit bsawebbrowser;

{$I bsdefine.inc}

interface

uses Windows, Messages, Forms, Sysutils, Classes, Graphics, Controls, ImgList,
  Dialogs, Menus, ExtDlgs, CommCtrl, StdCtrls, ExtCtrls, ClipBrd, ComCtrls,
  Buttons, TypInfo, SyncObjs, bsSkinData, bsSkinCtrls, bsaAdapter, shdocvw,
  ShlObj, Activex, mshtml;

type

  PDOCHOSTUIINFO = ^TDOCHOSTUIINFO;
  TDOCHOSTUIINFO = packed record
    cbSize: ULONG;
    dwFlags: DWORD;
    dwDoubleClick: DWORD;
    pchHostCss: polestr;
    pchHostNS: polestr;
  end;

  TEnhancedWebBrowserUI = class(TPersistent)
  private
    FlatScrollBar: boolean;
    IE3DBorder: boolean;
    RightClickMenu: boolean;
    ScrollBar: boolean;
  public
    constructor Create;
  published
    property EnableScrollBars: boolean read ScrollBar write ScrollBar;
    property EnableFlatScrollBars: boolean read FlatScrollBar write
      FlatScrollBar;
    property EnableContextMenu: boolean read RightClickMenu write
      RightClickMenu;
    property Enable3DBorder: boolean read IE3DBorder write IE3DBorder;
  end;

  IDocHostUIHandler = interface(IUnknown)
    ['{bd3f23c0-d43e-11cf-893b-00aa00bdce1a}']
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
      const pcmdtReserved: IUnknown; const pdispReserved: IDispatch):
      HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject:
      IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame:
      IOleInPlaceFrame;                                              
      const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT;
      const pUIWindow: IOleInPlaceUIWindow;
      const FrameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup:
      PGUID;
      const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD):
      HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR;
      var ppchURLOut: POLESTR): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject;
      out ppDORet: IDataObject): HRESULT; stdcall;
  end;

  TScrollWinControl = class(TWinControl)
  protected
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    SkinData: TbsSkinData;
    constructor Create(AOwner: TComponent); override;
  end;

  TbsaWebBrowser = class(TWebBrowser, IDocHostUIHandler)
  private
    FFrameDoc: Boolean;
    FVScrollWnd, FHScrollWnd, FSizeGrip: TScrollWinControl;
    FVScroll, FHScroll: TbsSkinScrollBar;
    FSkinData: TbsSkinData;
    UIProperties: TEnhancedWebBrowserUI;
    //
    FOnNewProgressChange: TWebBrowserProgressChange;
    FOnNewNavigateComplete2: TWebBrowserNavigateComplete2;
    FOnNewBeforeNavigate2: TWebBrowserBeforeNavigate2;
    FOnNewCommandStateChange: TWebBrowserCommandStateChange;
    FOnNewDocumentComplete: TWebBrowserDocumentComplete;
    //
    procedure SetSkinData(const Value: TbsSkinData);
    procedure CMVisibleChanged(var MSg: TMessage); message CM_VISIBLECHANGED;
  protected

    procedure DoBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch;
      {$IFDEF VER230_UP} const {$ELSE} var {$ENDIF} URL, Flags, TargetFrameName, PostData,
       Headers: OleVariant; var Cancel: WordBool);

    procedure DoCommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);

    procedure DoNavigateComplete2(Sender: TObject;
       const pDisp: IDispatch;
       {$IFDEF VER230_UP} const {$ELSE} var {$ENDIF} URL: OleVariant);

    procedure DoDocumentComplete(Sender: TObject;
       const pDisp: IDispatch;
       {$IFDEF VER230_UP} const {$ELSE} var {$ENDIF} URL: OleVariant);

    procedure DoProgressChange(Sender: TObject; Progress,
       ProgressMax: Integer);

    procedure DoVScrollScroll(Sender: TObject);
    procedure DoHScrollScroll(Sender: TObject);

    procedure SetParent(AParent: TWinControl); override;
    procedure Loaded; override;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure UpdateScrollbars;
    function ShowContextMenu(const dwID: DWORD; const ppt: PPOINT;
      const pcmdtReserved: IUnknown; const pdispReserved: IDispatch):
      HRESULT; stdcall;
    function GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT; stdcall;
    function ShowUI(const dwID: DWORD; const pActiveObject:
      IOleInPlaceActiveObject;
      const pCommandTarget: IOleCommandTarget; const pFrame:
      IOleInPlaceFrame;
      const pDoc: IOleInPlaceUIWindow): HRESULT; stdcall;
    function HideUI: HRESULT; stdcall;
    function UpdateUI: HRESULT; stdcall;
    function EnableModeless(const fEnable: BOOL): HRESULT; stdcall;
    function OnDocWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function OnFrameWindowActivate(const fActivate: BOOL): HRESULT; stdcall;
    function ResizeBorder(const prcBorder: PRECT;
      const pUIWindow: IOleInPlaceUIWindow;
      const fRameWindow: BOOL): HRESULT; stdcall;
    function TranslateAccelerator(const lpMsg: PMSG; const pguidCmdGroup:
      PGUID;
      const nCmdID: DWORD): HRESULT; stdcall;
    function GetOptionKeyPath(var pchKey: POLESTR; const dw: DWORD):
      HRESULT; stdcall;
    function GetDropTarget(const pDropTarget: IDropTarget;
      out ppDropTarget: IDropTarget): HRESULT; stdcall;
    function GetExternal(out ppDispatch: IDispatch): HRESULT; stdcall;
    function TranslateUrl(const dwTranslate: DWORD; const pchURLIn: POLESTR;
      var ppchURLOut: POLESTR): HRESULT; stdcall;
    function FilterDataObject(const pDO: IDataObject;
      out ppDORet: IDataObject): HRESULT; stdcall;
    property UISettings: TEnhancedWebBrowserUI read UIProperties write UIProperties;      
  published
    property Align;
    property Anchors;
    property SkinData: TbsSkinData read FSkinData write SetSkinData;

    property OnNewProgressChange: TWebBrowserProgressChange
      read FOnNewProgressChange write FOnNewProgressChange;

    property OnNewNavigateComplete2: TWebBrowserNavigateComplete2
     read FOnNewNavigateComplete2 write FOnNewNavigateComplete2;

    property OnNewBeforeNavigate2: TWebBrowserBeforeNavigate2
     read FOnNewBeforeNavigate2 write FOnNewBeforeNavigate2;

    property OnNewCommandStateChange: TWebBrowserCommandStateChange
     read FOnNewCommandStateChange write FOnNewCommandStateChange;

    property OnNewDocumentComplete: TWebBrowserDocumentComplete
     read FOnNewDocumentComplete write FOnNewDocumentComplete;
  end;

  procedure Register;

const
  DOCHOSTUIFLAG_SCROLL_NO = $00000008;
  DOCHOSTUIFLAG_FLAT_SCROLLBAR = $00000080;
  DOCHOSTUIFLAG_NO3DBORDER = $0004;
  DOCHOSTUIFLAG_THEME = $00040000;

implementation {===============================================================}
  Uses bsUtils;


procedure Register;
begin
  RegisterComponents('BusinessSkinForm VCL', [TbsaWebBrowser]);
end;

constructor TbsaWebBrowser.Create(AOwner: TComponent);
begin
  FVScrollWnd := nil;
  FHScrollWnd := nil;

  inherited;

  FFrameDoc := False;

  UIProperties := TEnhancedWebBrowserUI.Create;

  OnDocumentComplete := DoDocumentComplete;
  OnNavigateComplete2 := DoNavigateComplete2;
  OnCommandStateChange := DoCommandStateChange;
  OnBeforeNavigate2 := DoBeforeNavigate2;
  OnProgressChange := DoProgressChange;

  if not (csDesigning in ComponentState) then
  begin
    FVScrollWnd := TScrollWinControl.Create(Self);
    FVScrollWnd.Visible := True;

    FVScroll := TbsSkinScrollBar.Create(Self);
    FVScroll.Kind := sbVertical;
    FVScroll.SkinDataName := 'vscrollbar';
    FVScroll.Parent := FVScrollWnd;
    FVScroll.Visible := True;
    FVScroll.Align := alClient;
    FVScroll.OnChange := DoVScrollScroll;
    FVScroll.Enabled := False;

    FHScrollWnd := TScrollWinControl.Create(Self);
    FHScrollWnd.Visible := False;

    FHScroll := TbsSkinScrollBar.Create(Self);
    FHScroll.Parent := FHScrollWnd;
    FHScroll.SkinDataName := 'hscrollbar';
    FHScroll.Visible := True;
    FHScroll.Align := alClient;
    FHScroll.OnChange := DoHScrollScroll;

    FSizeGrip := TScrollWinControl.Create(Self);
    FSizeGrip.Visible := False;
  end;

  Width := 100;
  Height := 100;
end;

destructor TbsaWebBrowser.Destroy;
begin
  UIProperties.Free;
  inherited;
end;

procedure TbsaWebBrowser.ChangeSkinData;
begin
  if FVScrollWnd.Visible
  then
   begin
     FVScrollWnd.RePaint;
     FVScroll.RePaint;
   end;
  if FHScrollWnd.Visible
  then
   begin
     FHScrollWnd.RePaint;
     FHScroll.RePaint;
   end;
  if FSizeGrip.Visible then FSizeGrip.RePaint;
end;

procedure TbsaWebBrowser.WMSIZE(var Message: TWMSIZE);
begin
  if Document <> nil
  then
    begin
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    end;  
  //
  inherited;
  UpdateScrollbars;
  //
  if Document <> nil
  then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(Handle, nil, 0, RDW_INVALIDATE + RDW_ALLCHILDREN + RDW_UPDATENOW);
    end;  
end;

function TbsaWebBrowser.GetOptionKeyPath(var pchKey: POLESTR;
  const dw: DWORD): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.TranslateAccelerator(const lpMsg: PMSG;
  const pguidCmdGroup: PGUID; const nCmdID: DWORD): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.TranslateUrl(const dwTranslate: DWORD;
  const pchURLIn: POLESTR; var ppchURLOut: POLESTR): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.EnableModeless(const fEnable: BOOL): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.FilterDataObject(const pDO: IDataObject;
  out ppDORet: IDataObject): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.GetDropTarget(const pDropTarget: IDropTarget;
  out ppDropTarget: IDropTarget): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.GetExternal(out ppDispatch: IDispatch): HRESULT;
begin
  result := S_OK;
end;

function TbsaWebBrowser.UpdateUI: HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.HideUI: HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.OnDocWindowActivate(
  const fActivate: BOOL): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.OnFrameWindowActivate(
  const fActivate: BOOL): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.ResizeBorder(const prcBorder: PRECT;
  const pUIWindow: IOleInPlaceUIWindow; const fRameWindow: BOOL): HRESULT;
begin
  result := S_FALSE;
end;


function TbsaWebBrowser.ShowUI(const dwID: DWORD;
  const pActiveObject: IOleInPlaceActiveObject;
  const pCommandTarget: IOleCommandTarget; const pFrame: IOleInPlaceFrame;
  const pDoc: IOleInPlaceUIWindow): HRESULT;
begin
  result := S_FALSE;
end;

function TbsaWebBrowser.ShowContextMenu(const dwID: DWORD;
  const ppt: PPOINT; const pcmdtReserved: IUnknown;
  const pdispReserved: IDispatch): HRESULT;
begin
  if UIProperties.EnableContextMenu then
    result := S_FALSE
  else
    result := S_OK;
end;

procedure TbsaWebBrowser.SetParent(AParent: TWinControl);
begin
  inherited;
  if not (csDesigning in ComponentState) and not (csDestroying in ComponentState) then
  begin
    FVScrollWnd.Parent := AParent;
    FHScrollWnd.Parent := AParent;
    FSizeGrip.Parent := AParent;
    UpdateScrollBars;
  end;
end;

procedure TbsaWebBrowser.UpdateScrollBars;
var
  R: TRect;
  OldVisible: Boolean;
  i, HPageSize, VPageSize: Integer;
begin
  if (csDesigning in ComponentState) then Exit;
  if (FVScrollWnd = nil) or (FHScrollWnd = nil) then Exit;

  if FFrameDoc then FVScrollWnd.Visible := False else FVScrollWnd.Visible := True;

  if (Document <> nil) and (IHtmldocument2(Document).Body <> nil)
  then
   begin
     i := Variant(Document).documentElement.ClientWidth;
     if i > 0
     then
       begin
         FHScroll.Max := Variant(Document).DocumentElement.scrollWidth;
         FVScroll.Max := Variant(Document).DocumentElement.scrollHeight;
       end
     else
       begin
         FVScroll.Max := IHtmldocument2(Document).Body.getAttribute('ScrollHeight', 0);
         FHScroll.Max := IHtmldocument2(Document).Body.getAttribute('ScrollWidth', 0);
       end;
     //
     if (FHScroll.Max > Self.Width - GetSystemMetrics(SM_CXHTHUMB)) and
        (FHScroll.Max > 0) and (FHScroll.Max <> Self.Width)
     then
       VPageSize := Self.Height - GetSystemMetrics(SM_CYVTHUMB)
     else
       VPageSize := Self.Height;
     FVScroll.SetRange(0, FVScroll.Max, FVScroll.Position, VPageSize);
     FVScroll.LargeChange := FVScroll.PageSize;
     //
     HPageSize := Self.Width - GetSystemMetrics(SM_CXHTHUMB);
     FHScroll.SetRange(0, FHScroll.Max, FHScroll.Position, HPageSize);

     FHScroll.LargeChange := FHScroll.PageSize;
     //
     FVScroll.Enabled := (VPageSize < FVScroll.Max) and
                         (FVScroll.PageSize > 0) and (FVScroll.Max > 0) and
                         (FVScroll.Max <> Self.Height);

     OldVisible := FHScrollWnd.Visible;
     FHScrollWnd.Visible := (HPageSize < FHScroll.Max) and
                            (FHScroll.PageSize < FHScroll.Max) and (FHScroll.Max > 0) and
                            (FHScroll.Max <> Self.Width);
     //
     if not OldVisible and FHScrollWnd.Visible
     then
       FHScrollWnd.BringToFront;
   end;

  if FVScrollWnd.Visible then
  begin
    R := BoundsRect;
    R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB);
    if FHScrollWnd.Visible then
      R.Bottom := R.Bottom - GetSystemMetrics(SM_CYVTHUMB);
    FVScrollWnd.BoundsRect := R;
  end;

  if FHScrollWnd.Visible then
  begin
    R := BoundsRect;
    R.Top := R.Bottom - GetSystemMetrics(SM_CYVTHUMB);
    if FVScrollWnd.Visible then
      R.Right := R.Right - GetSystemMetrics(SM_CXHTHUMB);
    FHScrollWnd.BoundsRect := R;
  end;

  OldVisible := FSizeGrip.Visible;
  FSizeGrip.Visible := FHScrollWnd.Visible and FVScrollWnd.Visible;

  if FSizeGrip.Visible
  then
    begin
      R := BoundsRect;
      R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB);
      R.Top := R.Bottom - GetSystemMetrics(SM_CYVTHUMB);
      FSizeGrip.BoundsRect := R;
      if not OldVisible then FSizeGrip.BringToFront;
    end;
end;


procedure TbsaWebBrowser.SetSkinData(const Value: TbsSkinData);
begin
  FSkinData := Value;
  if (csDesigning in ComponentState) then Exit;
  FVScroll.SkinData := Value;
  FHScroll.SkinData := Value;
  FVScrollWnd.SkinData := Value;
  FHScrollWnd.SkinData := Value;
  FSizeGrip.SkinData := Value;
end;

procedure TbsaWebBrowser.DoProgressChange(Sender: TObject; Progress,
       ProgressMax: Integer);
begin
  if (csDesigning in ComponentState) then Exit;

  UpdateScrollbars;

  if Assigned(FOnNewProgressChange)
  then
    FOnNewProgressChange(Sender, Progress,  ProgressMax);
end;

procedure TbsaWebBrowser.DoDocumentComplete;
begin
  if (csDesigning in ComponentState) then Exit;

  UpdateScrollbars;

  if Assigned(FOnNewDocumentComplete)
  then
    FOnNewDocumentComplete(Sender, pDisp, URL);
end;

procedure TbsaWebBrowser.DoNavigateComplete2;
var
  I: Integer;
  iDoc: IHtmldocument2;
  iDisp : IDispatch;
  iElement : IHTMLElement;
  S: String;
begin
  if (csDesigning in ComponentState) then Exit;
  FFrameDoc := False;
  iDoc := IHtmldocument2(Document);
  for i := 0 to iDoc.All.Get_length - 1 do
  begin
    iDisp := iDoc.Get_all.item(i, 0);
    iDisp.QueryInterface(IHTMLElement, iElement);
    if Assigned(iElement)
    then
      begin
        S := iElement.Get_tagName;
        if UpperCase(S) = 'FRAMESET'
        then
          begin
            FFrameDoc := True;
            Break;
          end;
      end;
  end;
  UpdateScrollbars;


  if Assigned(FOnNewNavigateComplete2)
  then
    FOnNewNavigateComplete2(Sender, pDisp, URL);
end;

procedure TbsaWebBrowser.DoVScrollScroll;
begin
  if (csDesigning in ComponentState) then Exit;
  if Document <> nil
  then
    IHTMLWindow2(IHTMLDocument2(Document).ParentWindow).Scroll(FHScroll.Position, FVScroll.Position);
end;

procedure TbsaWebBrowser.DoHScrollScroll;
begin
  if (csDesigning in ComponentState) then Exit;
  if Document <> nil
  then
    IHTMLWindow2(IHTMLDocument2(Document).ParentWindow).Scroll(FHScroll.Position, FVScroll.Position);
end;

procedure TbsaWebBrowser.CMVisibleChanged(var MSg: TMessage);
begin
  inherited ;
  if (csDesigning in ComponentState) then Exit;
  FVScrollWnd.Visible := Visible;
  FHScrollWnd.Visible := Visible;
  FSizeGrip.Visible := Visible;
end;

procedure TbsaWebBrowser.Loaded;
begin
  inherited;
  UpdateScrollbars;
end;

procedure TbsaWebBrowser.DoCommandStateChange;
begin

  if (csDesigning in ComponentState) then Exit;
  if (Document <> nil) and (IHtmldocument2(Document).Body <> nil)
  then
  begin
    if Variant(Document).DocumentElement.scrollTop = 0
    then
      FVScroll.Position := IHtmldocument2(Document).Body.getAttribute('ScrollTop', 0)
    else
      FVScroll.Position := Variant(Document).DocumentElement.scrollTop;
    if Variant(Document).DocumentElement.scrollLeft = 0
    then
      FHScroll.Position := IHtmldocument2(Document).Body.getAttribute('ScrollLeft', 0)
    else
      FHScroll.Position := Variant(Document).DocumentElement.scrollLeft
  end;

  UpdateScrollbars;

  if Assigned(FOnNewCommandStateChange)
  then
    FOnNewCommandStateChange(Sender, Command, Enable);
end;

procedure TbsaWebBrowser.DoBeforeNavigate2;
begin
  if (csDesigning in ComponentState) then Exit;

  UpdateScrollbars;

  if Assigned(FOnNewBeforeNavigate2)
  then
    FOnNewBeforeNavigate2(Sender, pDisp, URL, Flags, TargetFrameName, PostData,
     Headers, Cancel);
end;

function TbsaWebBrowser.GetHostInfo(var pInfo: TDOCHOSTUIINFO): HRESULT;
begin
  if (csDesigning in ComponentState)
  then
    begin
      Result := S_OK;
      Exit;
    end;

  pInfo.cbSize := SizeOf(pInfo);
  pInfo.dwFlags := 0;
  if (not UIProperties.EnableScrollBars) then
    pInfo.dwFlags := pInfo.dwFlags or DOCHOSTUIFLAG_SCROLL_NO;
  if UIProperties.EnableFlatScrollBars then
    pInfo.dwFlags := pInfo.dwFlags or DOCHOSTUIFLAG_FLAT_SCROLLBAR;
  if not UIProperties.Enable3DBorder then
    pInfo.dwFlags := pInfo.dwFlags or DOCHOSTUIFLAG_NO3DBORDER;

  pInfo.dwFlags := pInfo.dwFlags or DOCHOSTUIFLAG_THEME;

  Result := S_OK;

  UpdateScrollBars;
end;

constructor TEnhancedWebBrowserUI.Create;
begin
  ScrollBar := True;
  FlatScrollBar := False;
  IE3DBorder := False;
  RightClickMenu := True;
end;


constructor TScrollWinControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
  SkinData := nil;
end;

procedure TScrollWinControl.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  C: TCanvas;
begin
  if (SkinData = nil) or (SkinData.Empty)
  then
    inherited
  else
    begin
      C := TCanvas.Create;
      C.Handle := Msg.DC;
      with C do
      begin
        C.Brush.Color := SkinData.SkinColors.cBtnFace;
        FillRect(ClientRect);
      end;
      C.Handle := 0;
      C.Free;
    end;
end;

end.
