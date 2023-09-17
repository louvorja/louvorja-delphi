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

unit se_grab;

{$I se_define.inc}
{$T-,W-,X+,P+}

{$WARNINGS OFF}
{$HINTS OFF}


interface

uses
  Windows, Messages, Graphics, Controls, Forms,
  Classes, SysUtils, se_utils, se_bitmap, se_effect;

type

  TseGrabberControlClass = class of TControl;

  TseGrabber = class(TObject)
  private
  public
    procedure GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect); virtual;
    class function GetGrabberClassType: TseGrabberControlClass; virtual;
    class function GetGrabberClassName: string; virtual;
  end;

  TseGrabberClass = class of TseGrabber;

function GrabDesktopToBitmap(ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
function GrabDesktopToKeBitmap(ARect: TRect; ABitmap: TseBitmap = nil): TseBitmap;

function GrabToBitmap(AControl: TControl; ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
function GrabToseBitmap(AControl: TControl; ARect: TRect; ABitmap: TseBitmap = nil): TseBitmap;

procedure RegisterGrabber(AGrabber: TseGrabberClass);

implementation {===============================================================}

uses se_grabclass;

type

  TWControl = TWinControl;

var
  GrabberList: TList = nil;

procedure RegisterGrabber(AGrabber: TseGrabberClass);
begin
  if GrabberList = nil then
    GrabberList := TList.Create;

  GrabberList.Add(AGrabber);
end;


{ TGrabber ====================================================================}


class function TseGrabber.GetGrabberClassName: string;
begin
  Result := '';
end;

class function TseGrabber.GetGrabberClassType: TseGrabberControlClass;
begin
  Result := nil;
end;

procedure TseGrabber.GrabToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
begin
end;


{ Main grabber routines =======================================================}

procedure GrabControlToBitmap(ABitmap: TBitmap; X, Y: integer; AControl: TControl; ARect: TRect);
var
  i: integer;
  Grabber: TseGrabber;
  IsGrabbed: boolean;
  Child: TControl;
  ChildRect: TRect;
  ChildX, ChildY: integer;
  ClipRgn: Cardinal;
begin
  { Search registered Grabber }
  IsGrabbed := false;

  { Correct ARect }
  IntersectRect(ARect, ARect, Rect(0, 0, AControl.Width, AControl.Height));
  if IsRectEmpty(ARect) then Exit;
  if not (AControl is TCustomForm) and not AControl.Visible then Exit;

  ClipRgn := CreateRectRgn(X + ARect.Left, Y +ARect.Top, X +ARect.Right, Y + ARect.Bottom);
  SelectClipRgn(ABitmap.Canvas.Handle, ClipRgn);

  { Grab }
  if (GrabberList <> nil) and (GrabberList.Count > 0) then
    for i := GrabberList.Count - 1 downto 0 do
    begin
      if (AControl is TseGrabberClass(GrabberList[i]).GetGrabberClassType) or
         (Pos(LowerCase(AControl.ClassName), TseGrabberClass(GrabberList[i]).GetGrabberClassName) > 0) then
      begin
        Grabber := TseGrabberClass(GrabberList[i]).Create;
        try
          Grabber.GrabToBitmap(ABitmap, X, Y, AControl, ARect);
        finally
          Grabber.Free;
        end;

        IsGrabbed := true;

        Break;
      end;
    end;

  { if Grabber not exists use default Win\Widget grabber routines }
  if not IsGrabbed then
  begin
    Grabber := TseWControlGrabber.Create;
    try
      Grabber.GrabToBitmap(ABitmap, X, Y, AControl, ARect);
    finally
      Grabber.Free;
    end;
  end;

  { Grab children }
  if (AControl is TWControl) and (TWControl(AControl).ControlCount > 0) then
  begin
    for i := 0 to TWControl(AControl).ControlCount - 1 do
    begin
      Child := TWControl(AControl).Controls[i];

      if Child is TGraphicControl then Continue;
      if not Child.Visible then Continue;

      ChildRect := GetRealBoundsRect(Child);
      ChildX := ChildRect.Left;
      ChildY := ChildRect.Top;
      if not (Child.Parent is TCustomForm)
      then
        IntersectRect(ChildRect, ChildRect, ARect);
      { Check ClientRect }
      IntersectRect(ChildRect, ChildRect, TWControl(AControl).ClientRect);

      with GetClientOrigin(AControl) do
      begin
        ChildX := ChildX + X;
        ChildY := ChildY + Y;
      end;

      OffsetRect(ChildRect, -ChildRect.Left, -ChildRect.Top);
      GrabControlToBitmap(ABitmap, X + ChildX, Y + ChildY, Child, ChildRect);
    end;
  end; 
  DeleteObject(ClipRgn);
  SelectClipRgn(ABitmap.Canvas.Handle, 0);
end;

{ Control grabber =============================================================}

function GrabToBitmap(AControl: TControl; ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
begin
  Result := TBitmap.Create;
  try
    Result.Width := RectWidth(ARect);
    Result.Height := RectHeight(ARect);

    if (RectWidth(ARect) <= 0) or (RectHeight(ARect) <= 0) then Exit;
    
    GrabControlToBitmap(Result, -ARect.Left, -ARect.Top, AControl, ARect);
  except
    Result.Free;
    Result := nil;
    raise ;
  end;
end;

function GrabToseBitmap(AControl: TControl; ARect: TRect; ABitmap: TseBitmap = nil): TseBitmap;
var
  TempB: TBitmap;
begin
  Result := TseBitmap.Create;
  try
    TempB := GrabToBitmap(AControl, ARect);

    if TempB <> nil then
    begin
      Result.Assign(TempB);

      TempB.Free;
    end;
  except
    Result.Free;
    Result := nil;
    raise ;
  end;
end;

{ Desktop grabber =============================================================}

function GrabDesktopToBitmap(ARect: TRect; ABitmap: TBitmap = nil): TBitmap;
var
  DC, ResultDC: HDC;
begin
  Result := TBitmap.Create;
  try
    Result.Width := RectWidth(ARect);
    Result.Height := RectHeight(ARect);
    DC := GetDC(0);
    try
      BitBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height, DC, ARect.Left, ARect.Top, SRCCOPY);
    finally
      ReleaseDC(0, DC);
    end;
  except
    Result.Free;
    Result := nil;
    raise ;
  end;
end;

function GrabDesktopToKeBitmap(ARect: TRect; ABitmap: TseBitmap = nil): TseBitmap;
var
  TempB: TBitmap;
begin
  Result := TseBitmap.Create;
  try
    TempB := GrabDesktopToBitmap(ARect);
    if TempB <> nil then
    begin
      Result.Assign(TempB);

      TempB.Free;
    end;
  except
    Result.Free;
    Result := nil;
    raise ;
  end;
end;

initialization
finalization
  if GrabberList <> nil then
    GrabberList.Free;
end.
