{*******************************************************************}
{                                                                   }
{       SkinAdapter                                                 }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2005-2013 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}


unit bsaEmbeddedWB;

interface

uses Windows, Messages, Forms, Sysutils, Classes, Graphics, Controls, ImgList,
  Dialogs, Menus, ExtDlgs, CommCtrl, StdCtrls, ExtCtrls, ClipBrd, ComCtrls,
  Buttons, TypInfo, SyncObjs, bsSkinData, bsSkinCtrls, bsaAdapter, SHDocVw_EWB,
  ShlObj, Activex, mshtml, EwbCore, EmbeddedWB, EwbAcc;

type
  TScrollWinControl = class(TWinControl)
  protected
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    SkinData: TbsSkinData;
    constructor Create(AOwner: TComponent); override;
  end;

  TbsaEmbeddedWB = class(TEmbeddedWB)
  private
    FFrameDoc: Boolean;
    FVScrollWnd, FHScrollWnd, FSizeGrip: TScrollWinControl;
    FVScroll, FHScroll: TbsSkinScrollBar;
    FSkinData: TbsSkinData;
    //
    FOnNewProgressChange: TEWBProgressChange;
    FOnNewNavigateComplete2: TEWBNavigateComplete2;
    FOnNewBeforeNavigate2: TEWBBeforeNavigate2;
    FOnNewCommandStateChange: TEWBCommandStateChange;
    FOnNewDocumentComplete: TEWBDocumentComplete;
    //
    procedure SetSkinData(const Value: TbsSkinData);
    procedure CMVisibleChanged(var MSg: TMessage); message CM_VISIBLECHANGED;
  protected

    procedure DoBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
       Headers: OleVariant; var Cancel: WordBool);

    procedure DoCommandStateChange(Sender: TObject;
      Command: Integer; Enable: WordBool);

    procedure DoNavigateComplete2(Sender: TObject;
       const pDisp: IDispatch; var URL: OleVariant);

    procedure DoDocumentComplete(Sender: TObject;
       const pDisp: IDispatch; var URL: OleVariant);

    procedure DoProgressChange(Sender: TObject; Progress,
       ProgressMax: Integer);

    procedure DoVScrollScroll(Sender: TObject);
    procedure DoHScrollScroll(Sender: TObject);

    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;

    procedure DoOnGetHostInfo(Sender: TCustomEmbeddedWB;
        var pInfo: TDOCHOSTUIINFO);
  public
    procedure Loaded; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure UpdateScrollbars;

  published
    property Align;
    property Anchors;
    property SkinData: TbsSkinData read FSkinData write SetSkinData;

    property OnNewProgressChange:  TEWBProgressChange
      read FOnNewProgressChange write FOnNewProgressChange;

    property OnNewNavigateComplete2:  TEWBNavigateComplete2
     read FOnNewNavigateComplete2 write FOnNewNavigateComplete2;

    property OnNewBeforeNavigate2:  TEWBBeforeNavigate2
     read FOnNewBeforeNavigate2 write FOnNewBeforeNavigate2;

    property OnNewCommandStateChange:  TEWBCommandStateChange
     read FOnNewCommandStateChange write FOnNewCommandStateChange;

    property OnNewDocumentComplete:  TEWBDocumentComplete
     read FOnNewDocumentComplete write FOnNewDocumentComplete;
  end;

  procedure Register;

implementation {===============================================================}
  Uses bsUtils;


procedure Register;
begin
  RegisterComponents('BusinessSkinForm VCL', [TbsaEmbeddedWB]);
end;

constructor TbsaEmbeddedWB.Create(AOwner: TComponent);
begin
  FVScrollWnd := nil;
  FHScrollWnd := nil;

  inherited;

  UserInterfaceOptions := UserInterfaceOptions + [DontUse3DBorders];

  FFrameDoc := False;

  OnDocumentComplete := DoDocumentComplete;
  OnNavigateComplete2 := DoNavigateComplete2;
  OnCommandStateChange := DoCommandStateChange;
  OnBeforeNavigate2 := DoBeforeNavigate2;
  OnProgressChange := DoProgressChange;
  OnGetHostInfo := DoOnGetHostInfo;

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

destructor TbsaEmbeddedWB.Destroy;
begin
  inherited;
end;

procedure TbsaEmbeddedWB.DoOnGetHostInfo(Sender: TCustomEmbeddedWB;
      var pInfo: TDOCHOSTUIINFO);
begin
  if (csDesigning in ComponentState) then Exit;
  UpdateScrollBars;
end;


procedure TbsaEmbeddedWB.ChangeSkinData;
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

procedure TbsaEmbeddedWB.WMSIZE(var Message: TWMSIZE);
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

procedure TbsaEmbeddedWB.UpdateScrollBars;
var
  R: TRect;
  OldVisible: Boolean;
  i, HPageSize, VPageSize: Integer;
begin
  if (csDesigning in ComponentState) then Exit;
  if (FVScrollWnd = nil) or (FHScrollWnd = nil) then Exit;

  if FVScrollWnd.Parent <> Self.Parent then FVScrollWnd.Parent := Self.Parent;
  if FHScrollWnd.Parent <> Self.Parent then FHScrollWnd.Parent := Self.Parent;
  if FSizeGrip.Parent <> Self.Parent then FSizeGrip.Parent := Self.Parent;
  
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


procedure TbsaEmbeddedWB.SetSkinData(const Value: TbsSkinData);
begin
  FSkinData := Value;
  if (csDesigning in ComponentState) then Exit;
  FVScroll.SkinData := Value;
  FHScroll.SkinData := Value;
  FVScrollWnd.SkinData := Value;
  FHScrollWnd.SkinData := Value;
  FSizeGrip.SkinData := Value;
end;

procedure TbsaEmbeddedWB.DoProgressChange(Sender: TObject; Progress,
       ProgressMax: Integer);
begin
  if (csDesigning in ComponentState) then Exit;

  UpdateScrollbars;

  if Assigned(FOnNewProgressChange)
  then
    FOnNewProgressChange(Sender, Progress,  ProgressMax);
end;

procedure TbsaEmbeddedWB.DoDocumentComplete;
begin
  if (csDesigning in ComponentState) then Exit;

  UpdateScrollbars;

  if Assigned(FOnNewDocumentComplete)
  then
    FOnNewDocumentComplete(Sender, pDisp, URL);
end;

procedure TbsaEmbeddedWB.DoNavigateComplete2;
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

procedure TbsaEmbeddedWB.DoVScrollScroll;
begin
  if (csDesigning in ComponentState) then Exit;
  if Document <> nil
  then
    IHTMLWindow2(IHTMLDocument2(Document).ParentWindow).Scroll(FHScroll.Position, FVScroll.Position);
end;

procedure TbsaEmbeddedWB.DoHScrollScroll;
begin
  if (csDesigning in ComponentState) then Exit;
  if Document <> nil
  then
    IHTMLWindow2(IHTMLDocument2(Document).ParentWindow).Scroll(FHScroll.Position, FVScroll.Position);
end;

procedure TbsaEmbeddedWB.CMVisibleChanged(var MSg: TMessage);
begin
  inherited ;
  if (csDesigning in ComponentState) then Exit;
  FVScrollWnd.Visible := Visible;
  FHScrollWnd.Visible := Visible;
  FSizeGrip.Visible := Visible;
end;

procedure TbsaEmbeddedWB.Loaded;
begin
  inherited;
  UpdateScrollbars;
end;

procedure TbsaEmbeddedWB.DoCommandStateChange;
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

procedure TbsaEmbeddedWB.DoBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  if (csDesigning in ComponentState) then Exit;

  UpdateScrollbars;

  if Assigned(FOnNewBeforeNavigate2)
  then
    FOnNewBeforeNavigate2(Sender, pDisp, URL, Flags, TargetFrameName, PostData,
     Headers, Cancel);
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
