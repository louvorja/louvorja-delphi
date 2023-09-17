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

unit se_form;

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses
  Windows, Messages, Graphics, Controls, Forms, se_bitmap,
  Classes, SysUtils, se_effect, se_ani, se_utils, se_imagelist,
  se_winapi;


const

  CM_FINISHSHOWANIMATION = CM_BASE + 432;
  CM_FINISHHIDEANIMATION = CM_BASE + 433;
  CM_CANSTARTFORMANIMATION = CM_BASE + 434;
  CM_STARTFORMANIMATION = CM_BASE + 435;
  CM_STOPFORMANIMATION = CM_BASE + 436;
  SE_RESULT = $3233;
  SE_STOPANIMATION = $3234;
  SE_CANANIMATION = $3235;


type

{ TseAnimationForm }

  TseAnimationForm = class(TComponent)
  private
    FMask: TPicture;
    FMaskColor: TColor;
    FMaskMode: TseMaskMode;
    FShowAnimation: TseAnimation;
    FShowAnimationComplete: Boolean;
    FHideAnimation: TseAnimation;
    FHideAnimationComplete: Boolean;
    FDesktopImage: TseBitmap;
    FRegion: HRgn;
    FPrevWndProc: Pointer;
    FObjectInst: Pointer;
    FShowAnimationExecOnce: Boolean;
    FHideAnimationExecOnce: Boolean;
    FShowExec: Boolean;
    FHideExec: Boolean;
    procedure FormWndProc(var Msg: TMessage);
    procedure SetMask(const Value: TPicture);
    procedure SetShowAnimation(const Value: TseAnimation);
    procedure SetHideAnimation(const Value: TseAnimation);
    function CanAnimate: Boolean;
  protected
    procedure AdjustSizeByMask;

    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure PrepareRegion;
    procedure PrepareShowAnimation;
    procedure PrepareHideAnimation;
    procedure FinishShowAnimation;
    procedure FinishHideAnimation;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Region: HRgn read FRegion;

  published
    property ShowAnimationExecOnce: Boolean
      read FShowAnimationExecOnce write FShowAnimationExecOnce;
    property HideAnimationExecOnce: Boolean
      read FHideAnimationExecOnce write FHideAnimationExecOnce;
    property Mask: TPicture read FMask write SetMask;
    property MaskColor: TColor read FMaskColor write FMaskColor;
    property MaskMode: TseMaskMode read FMaskMode write FMaskMode;
    property ShowAnimation: TseAnimation read FShowAnimation write SetShowAnimation;
    property HideAnimation: TseAnimation read FHideAnimation write SetHideAnimation;
  end;

function FindAnimationForm(AForm: TCustomForm): TseAnimationForm;

implementation {===============================================================}

uses se_grab;

type

  THackForm = class(TCustomForm);

function FindAnimationForm(AForm: TCustomForm): TseAnimationForm;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to THackForm(AForm).ComponentCount - 1 do
    if THackForm(AForm).Components[i] is TseAnimationForm then
    begin
      Result := TseAnimationForm(THackForm(AForm).Components[i]);
      Exit;
    end;
end;

{ TseAnimationForm ============================================================}

constructor TseAnimationForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMask := TPicture.Create;
  FMaskColor := clBlack;
  FMaskMode := mmExclude;
  FShowAnimationExecOnce := False;
  FHideAnimationExecOnce := False;
  FShowExec := False;
  FHideExec := False;
end;

function TseAnimationForm.CanAnimate: Boolean;
var
  B: Boolean;
  CanAnimate: Integer;
begin
  if TCustomForm(Owner).BorderStyle = bsNone
  then
    begin
      Result := True;
      Exit;
    end;
  Result := not IsWindowsAero;
  if not Result
  then
    begin
      CanAnimate :=  SendMessage(TCustomForm(Owner).Handle,
          CM_CANSTARTFORMANIMATION, 0, 0);
      if (CanAnimate = SE_STOPANIMATION) or
         (CanAnimate = SE_CANANIMATION)
       then
         begin
           Result := not (CanAnimate = SE_STOPANIMATION);
         end;
    end;
end;

procedure TseAnimationForm.Loaded;
begin
  inherited Loaded;

  AdjustSizeByMask;

  if not (csDesigning in ComponentState) and (Owner is TCustomForm) then
  begin
    FObjectInst := MakeObjectInstance(FormWndProc);
    FPrevWndProc := Pointer(GetWindowLong(TCustomForm(Owner).Handle, GWL_WNDPROC));
    SetWindowLong(TWinControl(Owner).Handle, GWL_WNDPROC, LongInt(FObjectInst));
  end;
end;

destructor TseAnimationForm.Destroy;
begin
  if FRegion <> 0 then
    DeleteObject(FRegion);
  FMask.Free;
  inherited Destroy;
end;

procedure TseAnimationForm.FormWndProc(var Msg: TMessage);
begin

  case Msg.Msg of
    WM_DESTROY:
      begin
        SetWindowLong(TCustomForm(Owner).Handle, GWL_WNDPROC, LongInt(FPrevWndProc));
        FreeObjectInstance(FObjectInst);
      end;

    WM_SHOWWINDOW:
      begin
        if (Msg.WParam > 0)  and not FShowExec
        then
          begin
            SendMessage(TCustomForm(Owner).Handle, CM_STARTFORMANIMATION, 0, 0);
           end;
      end;

    WM_WINDOWPOSCHANGING:
      begin
        with TWMWindowPosChanging(Msg) do
        begin
          if (WindowPos^.Flags and SWP_SHOWWINDOW <> 0) and not FShowExec
          then
          begin
            PrepareShowAnimation;
           end;
          if (WindowPos^.Flags and SWP_HIDEWINDOW <> 0) and not FHideExec
          then
          begin
            PrepareHideAnimation;
          end;
        end;
      end;
  end;

  Msg.Result := CallWindowProc(FPrevWndProc, TCustomForm(Owner).Handle, Msg.Msg, Msg.WParam, Msg.LParam);

  case Msg.Msg of
    WM_WINDOWPOSCHANGED:
      begin
        with TWMWindowPosChanging(Msg) do
        begin
          if (WindowPos^.Flags and SWP_SHOWWINDOW <> 0) and not FShowExec then
          begin
            PostMessage(TCustomForm(Owner).Handle, CM_FINISHSHOWANIMATION, 0, 0);
            if FShowAnimationExecOnce and (FShowAnimation <> nil) then FShowExec := True;
          end;
          if (WindowPos^.Flags and SWP_HIDEWINDOW <> 0) and not FHideExec
          then
          begin
            PostMessage(TCustomForm(Owner).Handle, CM_FINISHHIDEANIMATION, 0, 0);
            if FHideAnimationExecOnce and (FHideAnimation <> nil) then FHideExec := True;
          end;
        end;
      end;
    CM_FINISHSHOWANIMATION:
      begin
        FinishShowAnimation;
      end;
    CM_FINISHHIDEANIMATION:
      begin
        FinishHideAnimation;
      end;
  end;
end;

procedure TseAnimationForm.PrepareRegion;
var
  Rgn: cardinal;
begin
  if FRegion <> 0 then
    DeleteObject(FRegion);
  { Make region }
  FRegion := CreateRegionFromPicture(FMask, TCustomForm(Owner).Width, TCustomForm(Owner).Height, FMaskColor, FMaskMode);
  if FRegion <> 0 then
  begin
    Rgn := CreateRectRgn(0, 0, TCustomForm(Owner).Width, TCustomForm(Owner).Height);
    CombineRgn(Rgn, Rgn, FRegion, RGN_AND);
    SetWindowRgn(TCustomForm(Owner).Handle, Rgn, true);
  end
  else
  begin
    if not CanAnimate then Exit;
    FRegion := CreateRectRgn(0, 0, TCustomForm(Owner).Width, TCustomForm(Owner).Height);
    GetWindowRgn(TCustomForm(Owner).Handle, FRegion);
  end;
end;


procedure TseAnimationForm.PrepareShowAnimation;
var
  R: TRect;
  SaveStyle: cardinal;
  time: integer;
  Freq, Cur, New: Int64;

begin
  if (FShowAnimation = nil) then Exit;
  if FShowAnimationComplete then Exit;
  if FShowAnimation.IsControlFrozen(TControl(Owner)) then Exit;

  PrepareRegion;

  if not CanAnimate and (FRegion = 0) then
  begin
    SaveStyle := GetWindowLong(TCustomForm(Owner).Handle, GWL_EXSTYLE);
    SetWindowLong(TCustomForm(Owner).Handle, GWL_EXSTYLE, SaveStyle or WS_EX_LAYERED);
    SetLayeredWindowAttributes(TCustomForm(Owner).Handle, 0, 0, LWA_ALPHA);

    FShowAnimationComplete := true;
    showWindow(TCustomForm(Owner).Handle, SW_SHOW);

    time := 0;
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Cur);
    while time < FShowAnimation.Time do
    begin
      SetLayeredWindowAttributes(TCustomForm(Owner).Handle, 0, Round($FF * (time / FShowAnimation.Time)), LWA_ALPHA);
      Application.ProcessMessages;
      QueryPerformanceCounter(New);
      time := Round((New - Cur) / Freq * 1000);
    end;

    SetLayeredWindowAttributes(TCustomForm(Owner).Handle, 0, $FF, LWA_ALPHA);
    SetWindowLong(TWinControl(Owner).Handle, GWL_EXSTYLE, SaveStyle);
    FShowAnimationComplete := true;
    Exit;
  end;

  //

  R := GetRealBoundsRect(TControl(Owner));
  FDesktopImage := GrabDesktopToKeBitmap(R);
  OffsetRect(R, -R.Left, -R.Top);
  FShowAnimation.FreezeControl(TControl(Owner), R, FDesktopImage);
end;

procedure TseAnimationForm.FinishShowAnimation;
begin
  if FShowAnimation = nil then Exit;
  if FShowAnimationComplete then Exit;
  if FShowAnimation.IsControlFrozen(TControl(Owner)) then
  begin
    FShowAnimation.Execute;
    Sleep(50);
    FShowAnimation.Restore;
    if FRegion <> 0 then
      DeleteObject(FRegion);
    SendMessage(TCustomForm(Owner).Handle, CM_STOPFORMANIMATION, 0, 0);
  end;
end;

procedure TseAnimationForm.AdjustSizeByMask;
var
  R: TRect;
begin
  if (FMask.Width <> 0) and (FMask.Height <> 0) then
  begin
    R := GetRealBoundsRect(TControl(Owner));

    TControl(Owner).Width := FMask.Width - (RectWidth(R) - TControl(Owner).Width);
    TControl(Owner).Height := FMask.Height - (RectHeight(R) - TControl(Owner).Height);
  end;
end;

procedure TseAnimationForm.PrepareHideAnimation;
var
  R: TRect;
  SaveStyle: cardinal;
  time: integer;
  Freq, Cur, New: Int64;
begin
  if not isWin2k then Exit;
  if FHideAnimation = nil then Exit;
  if FHideAnimationComplete then Exit;
  if FHideAnimation.IsControlFrozen(TControl(Owner)) then Exit;

  FHideAnimationComplete := true;

  if IsWindowsAero then
  begin
    SaveStyle := GetWindowLong(TCustomForm(Owner).Handle, GWL_EXSTYLE);
    SetWindowLong(TCustomForm(Owner).Handle, GWL_EXSTYLE, SaveStyle or WS_EX_LAYERED);
    SetLayeredWindowAttributes(TCustomForm(Owner).Handle, 0, 0, LWA_ALPHA);

    FShowAnimationComplete := true;

    time := 0;
    QueryPerformanceFrequency(Freq);
    QueryPerformanceCounter(Cur);
    while time < FShowAnimation.Time do
    begin
      SetLayeredWindowAttributes(TCustomForm(Owner).Handle, 0, $FF - Round($FF * (time / FShowAnimation.Time)), LWA_ALPHA);
      Application.ProcessMessages;
      QueryPerformanceCounter(New);
      time := Round((New - Cur) / Freq * 1000);
    end;
    ShowWindow(TCustomForm(Owner).Handle, SW_HIDE);
    SetWindowLong(TWinControl(Owner).Handle, GWL_EXSTYLE, SaveStyle);
    Exit;
  end;

  R := GetRealBoundsRect(TControl(Owner));

  PrepareRegion;

  SaveStyle := GetWindowLong(TWinControl(Owner).Handle, GWL_EXSTYLE);

  SetWindowLong(TWinControl(Owner).Handle, GWL_EXSTYLE, SaveStyle or WS_EX_LAYERED);

  try
    Sleep(50);
    FDesktopImage := GrabDesktopToKeBitmap(R);
    OffsetRect(R, -R.Left, -R.Top);
  finally
    SetWindowLong(TWinControl(Owner).Handle, GWL_EXSTYLE, SaveStyle);
  end;

  FHideAnimation.FreezeControl(TControl(Owner), R, nil);

  if FHideAnimation.IsControlFrozen(TControl(Owner)) then
  begin
    FHideAnimation.DestImage := FDesktopImage;
    FHideAnimation.Execute;
    ShowWindow(TWinControl(Owner).Handle, SW_HIDE);
    FHideAnimation.Restore;
  end;

end;

procedure TseAnimationForm.FinishHideAnimation;
begin
  FHideAnimationComplete := False;
  FShowAnimationComplete := False;
  if not CanAnimate then Exit;
  if FHideAnimation = nil then Exit;
end;

{ Properties }

procedure TseAnimationForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FShowAnimation) then
    FShowAnimation := nil;
  if (Operation = opRemove) and (AComponent = FHideAnimation) then
    FHideAnimation := nil;
end;

procedure TseAnimationForm.SetShowAnimation(const Value: TseAnimation);
begin
  FShowAnimation := Value;
end;

procedure TseAnimationForm.SetHideAnimation(const Value: TseAnimation);
begin
  FHideAnimation := Value;
end;

procedure TseAnimationForm.SetMask(const Value: TPicture);
begin
  FMask.Assign(Value);

  AdjustSizeByMask;
end;

end.




