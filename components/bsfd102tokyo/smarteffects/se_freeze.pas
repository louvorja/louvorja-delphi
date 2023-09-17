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

unit se_freeze;

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses
  Windows, Messages, Graphics, Controls, Forms,
  Classes, SysUtils, se_effect, se_bitmap;

function FreezeControlProc(AControl: TControl; ARect: TRect; AFrozenImage: TseBitmap = nil): TCanvas;
procedure UnFreezeControlProc(AControl: TControl; AShow: boolean = true);

implementation {===============================================================}

uses se_form, se_grab, se_utils;

type

  THackForm = class(TCustomForm);

  TseLockControl = class(TCustomControl)
  private
    FFrozenImage: TseBitmap;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure Paint; override;
    property FrozenImage: TseBitmap read FFrozenImage write FFrozenImage;
  end;

  TseLockPopup = class(TseLockControl)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Msg: TMessage); message WM_NCPAINT;
  end;

{ TseLockControl  =============================================================}

procedure TseLockControl.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

procedure TseLockControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TseLockControl.Paint;
begin
  if FrozenImage <> nil then
    FrozenImage.Draw(Canvas, 0, 0);
end;

{ TseLockPopup ================================================================}
procedure TseLockPopup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := (Style and not (WS_CHILD or WS_GROUP or WS_TABSTOP)) or WS_POPUP;
    ExStyle := ExStyle or WS_EX_TOOLWINDOW;
  end;
end;

procedure TseLockPopup.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
end;

procedure TseLockPopup.WMNCPaint(var Msg: TMessage);
begin
  Msg.Result := 0;
end;

procedure TseLockPopup.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

{ Freeze Routines =============================================================}

type

  TFreezeItem = class(TObject)
  private
    FHookControl: Boolean;
    FControl: TControl;
    FFreezeWindow: TControl;
    FOldWindowProc: TWndMethod;
    FLeft, FTop: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewWndProc(var Message: TMessage);
    procedure HookControl;
    procedure UnHookControl;
    property Control: TControl read FControl write FControl;
    property FreezeWindow: TControl read FFreezeWindow write FFreezeWindow;
  end;

  constructor TFreezeItem.Create;
  begin
    inherited;
    FLeft := -1;
    FTop := -1;
    FControl := nil;
    FFreezeWindow := nil;
    FHookControl := False;
  end;

  destructor TFreezeItem.Destroy;
  begin
    if FHookControl then UnHookControl;
    inherited;
  end;

  procedure TFreezeItem.HookControl;
  begin
    if FControl = nil then Exit;
    FHookControl := True;
    FOldWindowProc := TWinControl(FControl).WindowProc;
    TWinControl(FControl).WindowProc := NewWndProc;
  end;

  procedure TFreezeItem.NewWndProc(var Message: TMessage);
  begin
    case Message.Msg of
      CM_VISIBLECHANGED:
        begin
          if (FFreezeWindow <> nil) and FFreezeWindow.Visible
          then
            begin
              ShowWindow(TWinControl(FFreezeWindow).Handle, SW_HIDE);
              FFreezeWindow.Visible := False;
            end;
        end;
    end;
    FOldWindowProc(Message);
    case Message.Msg of
      WM_MOVE:
        begin
          if (FFreezeWindow <> nil) and
            FFreezeWindow.Visible and (FLeft <> -1) and (FTop <> -1)
          then
            FFreezeWindow.SetBounds(FControl.Left + FLeft,
              FControl.Top + FTop, FFreezeWindow.Width, FFreezeWindow.Height);
        end;
    end;
  end;

  procedure TFreezeItem.UnHookControl;
  begin
    TWinControl(FControl).WindowProc := FOldWindowProc;
    FHookControl := False;
  end;

var
  FreezeList: TList = nil;

function FreezeControlProc(AControl: TControl; ARect: TRect; AFrozenImage: TseBitmap = nil): TCanvas;
var
  i: integer;
  Item: TFreezeItem;
  FreezeWindow: TControl;
  R: TRect;
  AniForm: TseAnimationForm;
  NewRgn, Rgn: HRGN;
begin
  Result := nil;

  { Check if control already freezed }
  for i := 0 to FreezeList.Count - 1 do
  begin
    Item := TFreezeItem(FreezeList[i]);
    if Item.Control = AControl then
      Exit;
  end;

  { Lock control update }

  if AControl.Parent <> nil then
  begin
    { Control }
    FreezeWindow := TseLockControl.Create(Application);
    with TseLockControl(FreezeWindow) do
    begin
      Visible := false;
      FrozenImage := AFrozenImage;
      Parent := AControl.Parent;
      ParentColor := false;
      ParentFont := false;

      R := ARect;
      OffsetRect(R, AControl.Left, AControl.Top);
      BoundsRect := R;

      Visible := true;
      FreezeWindow.BringToFront;
      Application.ProcessMessages;
    end
  end
  else
  begin
    { Form }
    FreezeWindow := TseLockPopup.Create(Application);
    with TseLockPopup(FreezeWindow) do
    begin
      FrozenImage := AFrozenImage;
      ParentColor := false;
      ParentFont := false;

      { Copy region }
      AniForm := FindAnimationForm(TCustomForm(AControl));
      if AniForm <> nil then
      begin
        Rgn := AniForm.Region;
        if Rgn <> 0 then
        begin
          NewRgn := CreateRectRgn(0, 0, THackForm(AControl).Width, THackForm(AControl).Height);
          CombineRgn(NewRgn, NewRgn, Rgn, RGN_AND);
          SetWindowRgn(Handle, NewRgn, false);
        end;
      end;

      { Show }
      OffsetRect(ARect, AControl.Left, AControl.Top);

      with ARect do
        SetWindowPos(Handle, HWND_TOPMOST, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOOWNERZORDER);
      RedrawWindow(Handle, nil, 0, RDW_INVALIDATE + RDW_UPDATENOW);
      Sleep(50);
    end;
  end;

  if FreezeWindow <> nil then
    Result := TseLockControl(FreezeWindow).Canvas;

  { Add Item to FreezeList }
  Item := TFreezeItem.Create;
  Item.Control := AControl;
  Item.FreezeWindow := FreezeWindow;
  if FreezeWindow is TseLockPopup then
  begin
    Item.FLeft := ARect.Left - AControl.Left;
    Item.FTop := ARect.Top - AControl.Top;
    Item.HookControl;
  end;
  FreezeList.Add(Item);
end;

procedure UnFreezeControlProc(AControl: TControl; AShow: boolean = true);
var
  Item: TFreezeItem;
  i: integer;
begin
  for i := 0 to FreezeList.Count - 1 do
  begin
    Item := TFreezeItem(FreezeList[i]);
    if Item.Control = AControl then
    begin
      FreezeList.Remove(Item);
      if AShow then
      begin
        TWinControl(Item.FControl).Show;
        SetWindowPos(TWinControl(Item.FControl).Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE);
        TWinControl(Item.FControl).Update;
      end;

      if Item.FreezeWindow is TseLockPopup then
       Item.UnHookControl;

      Item.FreezeWindow.Free;

      if AShow then
        if THackForm(Item.FControl).FormStyle <> fsStayOnTop then
          SetWindowPos(TWinControl(Item.FControl).Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_SHOWWINDOW or SWP_NOSIZE or SWP_NOMOVE);

      Item.Free;

      Break;
    end;
  end;
end;

initialization
  FreezeList := TList.Create;
finalization
  FreezeList.Free;
end.




