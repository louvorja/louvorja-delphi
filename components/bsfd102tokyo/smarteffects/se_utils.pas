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

unit se_utils;

{$I se_define.inc}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses Windows, Messages, Sysutils, Classes, Graphics, Forms, Controls,
  se_bitmap, se_winapi, ImgList;

type

  TseMaskMode = (mmExclude, mmInclude);
  TseButtonLayout = (seblGlyphLeft, seblGlyphRight, seblGlyphTop, seblGlyphBottom);

function GetClientOrigin(AControl: TControl): TPoint;

function GetRealClientRect(AControl: TControl): TRect;
function GetRealBoundsRect(AControl: TControl): TRect;

function CreateRegionFromPicture(APicture: TPicture; Width, Height: integer; MaskColor: TColor; MaskMode: TseMaskMode): HRgn;

function CreateHalftoneBrush(Color: TColor): HBRUSH;


type

  TTokenSeparators = set of char;

function GetToken(var S: string): string; overload;
function GetToken(var S: string; Separators: string): string; overload;
function GetToken(var S: string; Separators: TTokenSeparators): string; overload;

function RectToString(R: TRect): string;
function StringToRect(S: string): TRect;

function FormatStr(DC: HDC; S: WideString; Width: integer): WideString; overload;

{ Rect, Point and Polygon }

function RectWidth(R: TRect): integer;
function RectHeight(R: TRect): integer;
function RectHCenter(var R: TRect; Bounds: TRect): TRect;
function RectVCenter(var R: TRect; Bounds: TRect): TRect;
function RectCenter(var R: TRect; Bounds: TRect): TRect;
function RectOffset(ARect: TRect; Offset: integer): TRect;
function IsRectEmpty(Rect: TRect): boolean;
function CompareRect(Rect1, Rect2: TRect): boolean;
function MarginRect(ARect, AMargin: TRect): TRect;
function RectInRect(ARect, ABounds: TRect): boolean;

function PointInPolygon(const P: TPoint; const Points: array of TPoint): boolean;

{ Drawing routines }

procedure DrawFrameControlGlyph(Canvas: TCanvas; ARect: TRect; AType, AStyle: cardinal; Color: TColor);

function DrawText(ACanvas: TCanvas; AText: WideString; var Bounds: TRect; Flag: cardinal): integer; overload;
function DrawText(ACanvas: TCanvas; AText: WideString; X, Y: integer): integer; overload;
function DrawVerticalText(Canvas: TCanvas; AText: WideString; Bounds: TRect; Flag: cardinal; FromTop: boolean): integer;

function TextWidth(Canvas: TCanvas; AText: WideString; Flags: Integer = 0): integer;
function TextHeight(Canvas: TCanvas; AText: WideString): integer;

procedure MoveTo(Canvas: TCanvas; X, Y: integer);
procedure LineTo(Canvas: TCanvas; X, Y: integer; Color: TColor);

procedure DrawEdge(Canvas: TCanvas; Rect: TRect; RaisedColor, SunkenColor: TColor); overload;
procedure DrawEdge(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; RaisedColor, SunkenColor: TColor); overload;

procedure DrawRect(Canvas: TCanvas; Rect: TRect; Color: TColor); overload;
procedure DrawRect(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; Color: TColor); overload;

procedure DrawFocusRect(Canvas: TCanvas; Rect: TRect; Color: TColor);

procedure FillRect(Canvas: TCanvas; Rect: TRect; Color: TColor); overload;
procedure FillRect(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; Color: TColor); overload;
procedure FillRect(DC: HDC; ALeft, ATop, ARight, ABottom: integer; Color: TColor); overload;

procedure FillEllipse(Canvas: TCanvas; Rect: TRect; Color: TColor); overload;
procedure FillEllipse(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; Color: TColor); overload;

procedure DrawRoundRect(Canvas: TCanvas; ARect: TRect; Radius: integer; Color: TColor);
procedure FillRoundRect(Canvas: TCanvas; ARect: TRect; Radius: integer; Color: TColor);
procedure FillGradientRect(Canvas: TCanvas; ARect: TRect; BeginColor, EndColor: TColor; Vertical: boolean);
procedure FillRadialGradientRect(Canvas: TCanvas; Rect: TRect; BeginColor,
  EndColor: TColor; Pos: TPoint);
procedure FillHalftoneRect(Canvas: TCanvas; ARect: TRect; Color, HalfColor: TColor);
procedure FillAlphaRect(Canvas: TCanvas; ARect: TRect; Color: TColor; Alpha: integer);

procedure DrawPolygon(Canvas: TCanvas; Points: array of TPoint; Color: TColor);
procedure FillPolygon(Canvas: TCanvas; Points: array of TPoint; Color: TColor);
procedure FillHalftonePolygon(Canvas: TCanvas; Points: array of TPoint; Color, HalfColor: TColor);

procedure DrawIcon(Canvas: TCanvas; ARect: TRect; AIcon: TIcon); overload;
procedure DrawIcon(Canvas: TCanvas; ARect: TRect; AIcon: Cardinal); overload;
procedure DrawIcon(DC: HDC; ARect: TRect; AIcon: TIcon); overload;
procedure DrawIcon(DC: HDC; ARect: TRect; AIcon: Cardinal); overload;

procedure DrawGlyphShadow(Canvas: TCanvas; X, Y: integer; Glyph: TseBitmap; Color: TColor);
procedure DrawArrowImage(Cnvs: TCanvas; R: TRect; Color: TColor; Code: Integer);

{ Stream routines }

function ReadString(S: TStream): string;
procedure WriteString(S: TStream; Value: string);

{ Api }

function GetWndClassName(AHandle: HWnd): string;
function GetWndText(AHandle: HWnd): string;

{ Region }

function CreateRegionFromBitmap(Bitmap: TseBitmap; Left, Top: integer): HRgn;

function CreateRegionFromBitmap2(Bitmap: TseBitmap; Left, Top: integer): HRgn; // alpha version

{ Screen }
var
  CPixelFormat: TPixelFormat = pfCustom;

function GetPixelFormat: TPixelFormat;

{ System }

function GetKeyBoardDelayInterval: integer;
function GetKeyBoardSpeedInterval: integer;

{ Mouse capture }

const
  CaptureHandle: Hwnd = 0;

procedure CaptureMouse(const Wnd: HWND);
procedure EndCapture;

{ Unicode routines }

{ Utils }

function StringToWideString(CodePage: Cardinal; const s: String): WideString;

{$IFNDEF SE_COMPILER5_UP}
procedure FreeAndNil(var Obj);
{$ENDIF}

{ System routines }

function HasMMX: Boolean;
procedure EMMS;

procedure GetParentImage(Control: TControl; Dest: TCanvas);



implementation {===============================================================}

type
  TParentControl = class(TWinControl);

procedure GetParentImage(Control: TControl; Dest: TCanvas);
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
        if not (Control.Parent is TForm) then PaintWindow(DC);
      end;
    finally
      RestoreDC(DC, SaveIndex);
    end;

    for I := 0 to Count - 1 do
    if Control.Parent.Controls[I] <> Control
    then
    begin
      if (Control.Parent.Controls[I] <> nil) and
         (Control.Parent.Controls[I] is TGraphicControl)
      then
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
    end
    else
      Break;
  finally
    with Control.Parent do ControlState := ControlState - [csPaintCopy];
  end;
end;


{ Window Routines =============================================================}

function GetClientOrigin(AControl: TControl): TPoint;
var
  ClientOrigin: TPoint;
  ControlOrigin: TPoint;
  R: TRect;
begin
  Result := Point(0, 0);

  if AControl is TWinControl then
  begin
    ClientOrigin := TWinControl(AControl).ClientToScreen(Point(0, 0));
    ControlOrigin := Point(AControl.Left, AControl.Top);
    if (AControl.Parent <> nil) then
      ControlOrigin := AControl.Parent.ClientToScreen(Point(AControl.Left, AControl.Top));

    Result.X := ClientOrigin.X - ControlOrigin.X;
    Result.Y := ClientOrigin.Y - ControlOrigin.Y;
  end;

end;

function GetRealClientRect(AControl: TControl): TRect;
begin
  Result := AControl.ClientRect;
  with GetClientOrigin(AControl) do
    OffsetRect(Result, X, Y);
end;

function GetRealBoundsRect(AControl: TControl): TRect;
begin
  Result := AControl.BoundsRect;
end;

function CreateRegionFromPicture(APicture: TPicture; Width, Height: integer; MaskColor: TColor; MaskMode: TseMaskMode): HRgn;
var
  FBitmap: TBitmap;
  X, Y: Integer;
  StartX: Integer;
  Exclude: boolean;
  Line: PseColorArray;
  Color: TseColor;
  Region: HRgn;
begin
  Result := 0;

  { Check Picture }
  if APicture.Graphic = nil then Exit;
  if (APicture.Width * APicture.Height) = 0 then Exit;

  { Create region }
  Color := seColor(MaskColor);
  Exclude := MaskMode = mmExclude;

  FBitmap := TBitmap.Create;
  try
    FBitmap.PixelFormat := pf32Bit;
    FBitmap.Width := Width;
    FBitmap.Height := Height;

    FBitmap.Canvas.Draw(0, 0, APicture.Graphic);

    for Y := 0 to FBitmap.Height - 1 do
    begin
      Line := FBitmap.Scanline[Y];
      X := 0;
      while X < FBitmap.Width do
      begin

        if Exclude then
        begin
          while (TseColorRec(Line[X]).R = TseColorRec(Color).R) and (TseColorRec(Line[X]).G = TseColorRec(Color).G) and (TseColorRec(Line[X]).B = TseColorRec(Color).B) do
          begin
            Inc(X);
            if X = FBitmap.Width then
              break;
          end;
        end
        else
        begin
          while (TseColorRec(Line[X]).R <> TseColorRec(Color).R) or (TseColorRec(Line[X]).G <> TseColorRec(Color).G) or (TseColorRec(Line[X]).B <> TseColorRec(Color).B) do
          begin
            Inc(X);
            if X = FBitmap.Width then
              break;
          end;
        end;

        if X = FBitmap.Width then
          break;

        StartX := X;
        if Exclude then
        begin
          while (TseColorRec(Line[X]).R <> TseColorRec(Color).R) or (TseColorRec(Line[X]).G <> TseColorRec(Color).G) or (TseColorRec(Line[X]).B <> TseColorRec(Color).B) do
          begin
            if X = FBitmap.Width then
              break;
            Inc(X);
          end;
        end
        else
        begin
          while (TseColorRec(Line[X]).R = TseColorRec(Color).R) and (TseColorRec(Line[X]).G = TseColorRec(Color).G) and (TseColorRec(Line[X]).B = TseColorRec(Color).B) do
          begin
            if X = FBitmap.Width then
              break;
            Inc(X);
          end;
        end;

        if Result = 0 then
          Result := CreateRectRgn(StartX, Y, X, Y + 1)
        else
        begin
          Region := CreateRectRgn(StartX, Y, X, Y + 1);
          if Region <> 0 then
          begin
            CombineRgn(Result, Result, Region, RGN_OR);
            DeleteObject(Region);
          end;
        end;
      end;
    end;
  finally
    FBitmap.Free;
  end;
end;

function CreateHalftoneBrush(Color: TColor): HBRUSH;
const
  HalfColor = clWhite;
var
  i, j: Integer;
  GrayBitmap: TBitmap;
begin
  GrayBitmap := TBitmap.Create;
  GrayBitmap.Width := 8;
  GrayBitmap.Height := 8;

  GrayBitmap.Canvas.Brush.Color := clBtnFace;
  GrayBitmap.Canvas.FillRect(Rect(0, 0, 8, 8));

  for i := 0 to 7 do
    for j := 0 to 7 do
    begin
      if Odd(i) and Odd(j) then
        GrayBitmap.Canvas.Pixels[i, j] := Color;

      if not Odd(i) and not Odd(j) then
        GrayBitmap.Canvas.Pixels[i, j] := Color;
    end;

  Result := CreatePatternBrush(GrayBitmap.Handle);

  GrayBitmap.Free;
end;

{ Api }

var
  Buf: array [0..1000] of char;
  
function GetWndClassName(AHandle: HWnd): string;
begin
  if GetClassName(AHandle, @Buf, 1000) > 0 then
    Result := Buf
  else
    Result := '';
end;

function GetWndText(AHandle: HWnd): string;
begin
  if GetWindowText(AHandle, @Buf, 1000) > 0 then
    Result := Buf
  else
    Result := '';
end;

{ Utils =======================================================================}

{$IFNDEF SE_COMPILER5_UP}
procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;
  P.Free;
end;
{$ENDIF}

{ Capture =====================================================================}

const

  CaptureCount: integer = 0;

procedure CaptureMouse(const Wnd: HWND);
begin
  if CaptureCount = 0 then
  begin
    CaptureHandle := Wnd;
    SetCapture(CaptureHandle);
  end;
  Inc(CaptureCount);
end;

procedure EndCapture;
begin
  Dec(CaptureCount);
  if CaptureCount = 0 then
  begin
    if GetCapture = CaptureHandle then
      ReleaseCapture;
    CaptureHandle := 0;
  end;
end;

{ Strings functions ===========================================================}

function GetToken(var S: string): string;
{ Return first token and remove it from S }
var
  i: byte;
  CopyS: string;
begin
  Result := '';
  CopyS := S;
  for i := 1 to Length(CopyS) do
  begin
    Delete(S, 1, 1);
    if CopyS[i] in [',', ' ', '(', ')', ';', ':', '='] then Break;
    Result := Result + CopyS[i];
  end;
  Result := Trim(Result);
  S := Trim(S);
end;

function GetToken(var S: string; Separators: string): string;
var
  i: byte;
  CopyS: string;
begin
  Result := '';
  CopyS := S;
  for i := 1 to Length(CopyS) do
  begin
    Delete(S, 1, 1);
    if Pos(CopyS[i], Separators) > 0 then Break;
    Result := Result + CopyS[i];
  end;
  Result := Trim(Result);
  S := Trim(S);
end;

function GetToken(var S: string; Separators: TTokenSeparators): string;
var
  i: byte;
  CopyS: string;
begin
  Result := '';
  CopyS := S;
  for i := 1 to Length(CopyS) do
  begin
    Delete(S, 1, 1);
    if CopyS[i] in Separators then Break;
    Result := Result + CopyS[i];
  end;
  Result := Trim(Result);
  S := Trim(S);
end;

function RectToString(R: TRect): string;
{ Convert TRect to string }
begin
  Result := '(' + IntToStr(R.Left) + ',' + IntToStr(R.Top) + ',' + IntToStr(R.Right) + ',' +
    IntToStr(R.Bottom) + ')';
end;

function StringToRect(S: string): TRect;
{ Convert string to TRect }
begin
  try
    Result.Left := StrToInt(GetToken(S));
    Result.Top := StrToInt(GetToken(S));
    Result.Right := StrToInt(GetToken(S));
    Result.Bottom := StrToInt(GetToken(S));
  except
    Result := Rect(0, 0, 0, 0);
  end;
end;

function FormatStr(DC: HDC; S: WideString; Width: integer): WideString;
var
  i: integer;
  Size: TSize;
  Ts: WideString;
begin
  Result := S;
  GetTextExtentPoint32W(DC, PWideChar(S), Length(S), Size);

  if Size.cx <= Width then Exit;

  Result := '';
  for i := 1 to Length(S) do
  begin
    Ts := Result + S[i] + '...';
    GetTextExtentPoint32W(DC, PWideChar(Ts), Length(Ts), Size);
    if Size.cx > Width then Break;
    Result := Result + S[i];
  end;
  Result := Result + '...'
end;

{ Rect and Point ==============================================================}

function RectWidth(R: TRect): integer;
begin
  Result := R.Right - R.Left;
end;

function RectHeight(R: TRect): integer;
begin
  Result := R.Bottom - R.Top;
end;

function RectVCenter(var R: TRect; Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, 0, (RectHeight(Bounds) - RectHeight(R)) div 2);
  OffsetRect(R, Bounds.Left, Bounds.Top);

  Result := R;
end;

function RectHCenter(var R: TRect; Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, (RectWidth(Bounds) - RectWidth(R)) div 2, 0);
  OffsetRect(R, Bounds.Left, Bounds.Top);

  Result := R;
end;

function RectCenter(var R: TRect; Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, (RectWidth(Bounds) - RectWidth(R)) div 2, (RectHeight(Bounds) - RectHeight(R)) div 2);
  OffsetRect(R, Bounds.Left, Bounds.Top);

  Result := R;
end;

function RectOffset(ARect: TRect; Offset: integer): TRect;
begin
  Result.Top := ARect.Top - Offset;
  Result.Left := ARect.Left - Offset;
  Result.Bottom := ARect.Bottom + Offset;
  Result.Right := ARect.Right + Offset;
end;

function IsRectEmpty(Rect: TRect): boolean;
begin
  Result := (RectWidth(Rect) <= 0) or (RectHeight(Rect) <= 0); 
end;

function MarginRect(ARect, AMargin: TRect): TRect;
var
  Dx: single;
begin
  Result := ARect;

  if (AMargin.Left > RectWidth(ARect)) or (AMargin.Right > RectWidth(ARect)) or (AMargin.Left + AMargin.Right > RectWidth(ARect)) then
  begin
    if (AMargin.Left + AMargin.Right) <> 0 then
      Dx := RectWidth(ARect) / (AMargin.Left + AMargin.Right)
    else
      Dx := 1;
    Result.Left := Result.Left + Round(AMargin.Left * Dx);
    Result.Top := Result.Top + AMargin.Top;
    Result.Right := Result.Right - Round(AMargin.Right * Dx);
    Result.Bottom := Result.Bottom - AMargin.Bottom;
  end
  else
  if (AMargin.Top > RectHeight(ARect)) or (AMargin.Bottom > RectHeight(ARect)) or (AMargin.Top + AMargin.Bottom > RectHeight(ARect)) then
  begin
    if (AMargin.Top + AMargin.Bottom) <> 0 then
      Dx := RectHeight(ARect) / (AMargin.Top + AMargin.Bottom)
    else
      Dx := 1;
    Result.Left := Result.Left + AMargin.Left;
    Result.Top := Result.Top + Round(AMargin.Top * Dx);
    Result.Right := Result.Right - AMargin.Right;
    Result.Bottom := Result.Bottom - Round(AMargin.Bottom * Dx);
  end
  else
  begin
    Result.Left := Result.Left + AMargin.Left;
    Result.Top := Result.Top + AMargin.Top;
    Result.Right := Result.Right - AMargin.Right;
    Result.Bottom := Result.Bottom - AMargin.Bottom;
  end;
end;

function RectInRect(ARect, ABounds: TRect): boolean;
begin
  Result := (ARect.Left >= ABounds.Left) and (ARect.Top >= ABounds.Top) and
    (ARect.Right <= ABounds.Right) and (ARect.Bottom <= ABounds.Bottom);
end;

function CompareRect(Rect1, Rect2: TRect): boolean;
begin
  Result := (Rect1.Left = Rect2.Left) and (Rect1.Top = Rect2.Top) and
    (Rect1.Right = Rect2.Right) and (Rect1.Bottom = Rect2.Bottom);
end;

function PointInPolygon(const P: TPoint; const Points: array of TPoint): boolean;
type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;
var
  Rgn: HRgn;
begin
  Rgn := CreatePolygonRgn(PPoints(@Points)^, High(Points) + 1, WINDING);
  try
    Result := PtInRegion(Rgn, P.X, P.Y);
  finally
    DeleteObject(Rgn);
  end;
end;

{ Drawing Routines ============================================================}

procedure DrawFrameControlGlyph(Canvas: TCanvas; ARect: TRect; AType, AStyle: cardinal; Color: TColor);
var
  B: TseBitmap;
  Pixel: PseColor;
  CColor: TseColor;
  i, j: integer;
begin
  { Draw only glyph }
  B := TseBitmap.Create;
  B.SetSize(RectWidth(ARect), RectHeight(ARect));

  CColor := seColor(Color, $FF);

  DrawFrameControl(B.DC, Rect(0, 0, B.Width, B.Height), AType, AStyle);

  for i := 0 to B.Width - 1 do
    for j := 0 to B.Height - 1 do
    begin
      Pixel := B.PixelPtr[i, j];

      if Pixel^ = 0 then
        Pixel^ := CColor
      else
        Pixel^ := seTransparent;
    end; 

  B.Transparent := true;
  B.Draw(Canvas.Handle, ARect.Left, ARect.Top);

  B.Free;
end;

function DrawText(ACanvas: TCanvas; AText: WideString; var Bounds: TRect; Flag: cardinal): integer;
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

function DrawText(ACanvas: TCanvas; AText: WideString; X, Y: integer): integer;
var
  R: TRect;
begin
  R := Rect(X, Y, X + TextWidth(ACanvas, AText), Y + TextHeight(ACanvas, AText));
  Result := DrawText(ACanvas, AText, R, 0);
end;

function DrawVerticalText(Canvas: TCanvas; AText: WideString; Bounds: TRect; Flag: cardinal; FromTop: boolean): integer;
var
  R, R1: TRect;
  VertBuf, HorzBuf: TseBitmap;
  i, j: integer;
  HorzPixel: PseColor;
  TempCanvas: TCanvas;
  SaveFont: HFont;
begin
  R := Bounds;

  VertBuf := TseBitmap.Create;
  HorzBuf := TseBitmap.Create;
  SaveFont := SelectObject(HorzBuf.DC, Canvas.Font.Handle);
  try
    HorzBuf.SetSize(RectHeight(R), RectWidth(R));
    VertBuf.SetSize(RectWidth(R), RectHeight(R));

    VertBuf.FillRect(Rect(0, 0, VertBuf.Width, VertBuf.Height), seTransparent);
    HorzBuf.FillRect(Rect(0, 0, HorzBuf.Width, HorzBuf.Height), seTransparent);

    { Draw Horizontaly }
    R1 := Rect(0, 0, HorzBuf.Width, HorzBuf.Height);
    TempCanvas := TCanvas.Create;
    TempCanvas.Handle := HorzBuf.DC;
    Result := DrawText(TempCanvas, AText, R1, Flag);
    TempCanvas.Handle := 0;
    TempCanvas.Free;

    { Rotate }
    for i := 0 to HorzBuf.Width - 1 do
      for j := 0 to HorzBuf.Height - 1 do
      begin
        HorzPixel := HorzBuf.PixelPtr[i, j];
        if HorzPixel^ = seTransparent then Continue;

        if not FromTop then
          VertBuf.Pixels[j, (VertBuf.Height - i)] := HorzPixel^
        else
          VertBuf.Pixels[(VertBuf.Width - j), i] := HorzPixel^;
      end;

    VertBuf.Transparent := true;
    VertBuf.Draw(Canvas, Bounds.Left, Bounds.Top);
  finally
    SelectObject(HorzBuf.DC, SaveFont);
    VertBuf.Free;
    HorzBuf.Free;
  end;
end;

function TextWidth(Canvas: TCanvas; AText: WideString; Flags: Integer = 0): integer;
var
  R: TRect;
  Size: TSize;
  AnsiText: string;
begin
  R := Rect(0, 0, 0, 0);

  if IsWinNT and false then
  begin
    Windows.DrawTextW(Canvas.Handle, PWideChar(AText), Length(AText), R, DT_CALCRECT or Flags);
    Result := R.Right;
  end
  else
  begin
    if Flags = 0 then
    begin
      GetTextExtentPoint32W(Canvas.Handle, PWideChar(AText), Length(AText), Size);
      Result := Size.cx;
    end
    else
    begin
      SetLength(AnsiText, Length(AText));
      WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK, PWideChar(AText), Length(AText), PAnsiChar(AnsiText), Length(AText), nil, nil);
      Windows.DrawText(Canvas.Handle, PChar(AnsiText), Length(AnsiText), R, DT_CALCRECT or Flags);
      Result := R.Right;
    end;
  end;
end;

function TextHeight(Canvas: TCanvas; AText: WideString): integer;
var
  Size: TSize;
begin
  GetTextExtentPoint32W(Canvas.Handle, PWideChar(AText), Length(AText), Size);
  Result := Size.cy;
end;

procedure MoveTo(Canvas: TCanvas; X, Y: integer);
begin
  Canvas.MoveTo(X, Y);
end;

procedure LineTo(Canvas: TCanvas; X, Y: integer; Color: TColor);
begin
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := Color;
  Canvas.LineTo(X, Y);
end;

procedure DrawEdge(Canvas: TCanvas; Rect: TRect; RaisedColor, SunkenColor: TColor);
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;

  Canvas.Pen.Color := RaisedColor;
  Canvas.MoveTo(Rect.Left, Rect.Bottom - 2);
  Canvas.LineTo(Rect.Left, Rect.Top);
  Canvas.LineTo(Rect.Right - 1, Rect.Top);

  Canvas.Pen.Color := SunkenColor;
  Canvas.MoveTo(Rect.Right - 1, Rect.Top);
  Canvas.LineTo(Rect.Right - 1, Rect.Bottom - 1);
  Canvas.LineTo(Rect.Left - 1, Rect.Bottom - 1);
end;

procedure DrawEdge(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; RaisedColor, SunkenColor: TColor);
begin
  DrawEdge(Canvas, Rect(ALeft, ATop, ARight, ABottom), RaisedColor, SunkenColor);
end;

procedure DrawRect(Canvas: TCanvas; Rect: TRect; Color: TColor);
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := Color;
  with Rect do
    Canvas.Rectangle(Left, Top, Right, Bottom);
end;

procedure DrawRect(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; Color: TColor); overload;
begin
  DrawRect(Canvas, Rect(ALeft, ATop, ARight, ABottom), Color);
end;

procedure DrawFocusRect(Canvas: TCanvas; Rect: TRect; Color: TColor);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.DrawFocusRect(Rect);
end;

procedure FillRect(Canvas: TCanvas; Rect: TRect; Color: TColor);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(Rect);
end;

procedure FillRect(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; Color: TColor); overload;
begin
  FillRect(Canvas, Rect(ALeft, ATop, ARight, ABottom), Color);
end;

procedure FillRect(DC: HDC; ALeft, ATop, ARight, ABottom: integer; Color: TColor);
var
  C: TCanvas;
begin
  C := TCanvas.Create;
  C.Handle := DC;
  FillRect(C, Rect(ALeft, ATop, ARight, ABottom), Color);
  C.Handle := 0;
  C.Free;
end;

procedure FillEllipse(Canvas: TCanvas; Rect: TRect; Color: TColor);
begin
  Canvas.Pen.Style := psClear;
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.Ellipse(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
end;

procedure FillEllipse(Canvas: TCanvas; ALeft, ATop, ARight, ABottom: integer; Color: TColor);
begin
  FillEllipse(Canvas, Rect(ALeft, ATop, ARight, ABottom), Color);
end;

procedure DrawRoundRect(Canvas: TCanvas; ARect: TRect; Radius: integer; Color: TColor);
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := Color;
  Canvas.RoundRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, Radius, Radius);
end;

procedure FillRoundRect(Canvas: TCanvas; ARect: TRect; Radius: integer; Color: TColor);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.Pen.Color := Canvas.Brush.Color;
  Canvas.RoundRect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, Radius, Radius);
end;

procedure FillGradientRect(Canvas: TCanvas; ARect: TRect; BeginColor, EndColor: TColor; Vertical: boolean);
var
  RGBFrom: array[0..2] of integer;
  RGBDiff: array[0..2] of integer;
  ColorBand : TRect;
  Colors: integer;
  I: Integer;
  R,G,B: Byte;
begin
  if RectWidth(ARect) <= 0 then Exit;
  if RectHeight(ARect) <= 0 then Exit;

  Colors := 255;
  if not Vertical and (Colors > RectWidth(ARect)) then
    Colors := RectWidth(ARect);
  if Vertical and (Colors > RectHeight(ARect)) then
    Colors := RectHeight(ARect);

  BeginColor := ColorToRGB(BeginColor);
  EndColor := ColorToRGB(EndColor);

  { extract from RGB values }
  RGBFrom[0] := TseColorRecBor(BeginColor).R * $FF;
  RGBFrom[1] := TseColorRecBor(BeginColor).G * $FF;
  RGBFrom[2] := TseColorRecBor(BeginColor).B * $FF;
  { calculate difference of from and to RGB values }
  RGBDiff[0] := TseColorRecBor(EndColor).R * $FF - RGBFrom[0];
  RGBDiff[1] := TseColorRecBor(EndColor).G * $FF - RGBFrom[1];
  RGBDiff[2] := TseColorRecBor(EndColor).B * $FF - RGBFrom[2];

  Canvas.Brush.Style := bsSolid;

  ColorBand := ARect;
  for I := 0 to Colors do
  begin
    { calculate color band's top and bottom coordinates }
    if not Vertical then
    begin
      ColorBand.Left := MulDiv(I, RectWidth(ARect), Colors);
      ColorBand.Right := MulDiv(Succ(I), RectWidth(ARect), Colors);

      ColorBand.Left := ColorBand.Left + ARect.Left;
      ColorBand.Right := ColorBand.Right + ARect.Left;
    end else
    begin
      ColorBand.Top := MulDiv (I, RectHeight(ARect), Colors);
      ColorBand.Bottom := MulDiv (Succ(I), RectHeight(ARect), Colors);

      ColorBand.Top := ColorBand.Top + ARect.Top;
      ColorBand.Bottom := ColorBand.Bottom + ARect.Top;
    end;

    { calculate color band color }
    R := Round((RGBFrom[0] + ((I * RGBDiff[0]) /  Colors)) / $FF);
    G := Round((RGBFrom[1] + ((I * RGBDiff[1]) /  Colors)) / $FF);
    B := Round((RGBFrom[2] + ((I * RGBDiff[2]) /  Colors)) / $FF);

    if (i = 0) or (i = Colors) then
      IntersectRect(ColorBand, ARect, ColorBand);

    Canvas.Brush.Color := RGB(R, G, B);
    Canvas.FillRect(ColorBand);
  end;
end;

procedure FillRadialGradientRect(Canvas: TCanvas; Rect: TRect; BeginColor,
  EndColor: TColor; Pos: TPoint);
var
  RGBFrom: array[0..3] of integer;
  RGBDiff: array[0..4] of integer;
  Colors: integer;

  ColorBand: TRect;
  Len: integer;
  I: Integer;
  R,G,B: Byte;
  ClipRgn: HRgn;
begin
  if RectWidth(Rect) <= 0 then Exit;
  if RectHeight(Rect) <= 0 then Exit;

  Colors := 50;

  { extract from RGB values }
  RGBFrom[0] := TseColorRecBor(BeginColor).R * $FF;
  RGBFrom[1] := TseColorRecBor(BeginColor).G * $FF;
  RGBFrom[2] := TseColorRecBor(BeginColor).B * $FF;
  RGBFrom[3] := TseColorRecBor(BeginColor).A * $FF;
  { calculate difference of from and to RGB values }
  RGBDiff[0] := TseColorRecBor(EndColor).R * $FF - RGBFrom[0];
  RGBDiff[1] := TseColorRecBor(EndColor).G * $FF - RGBFrom[1];
  RGBDiff[2] := TseColorRecBor(EndColor).B * $FF - RGBFrom[2];
  RGBDiff[3] := TseColorRecBor(EndColor).A * $FF - RGBFrom[3];

  { set clip region }
  ClipRgn := CreateRectRgn(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  SelectClipRgn(Canvas.Handle, ClipRgn);

  try
    { calc length }
    if RectWidth(Rect) > RectHeight(Rect) then
      Len := RectWidth(Rect)
    else
      Len := RectHeight(Rect);

    for I := Colors downto 0 do
    begin
      { calculate color band color }
      R := Round((RGBFrom[0] + ((I * RGBDiff[0]) /  Colors)) / $FF);
      G := Round((RGBFrom[1] + ((I * RGBDiff[1]) /  Colors)) / $FF);
      B := Round((RGBFrom[2] + ((I * RGBDiff[2]) /  Colors)) / $FF);

      ColorBand.TopLeft := Rect.TopLeft;
      ColorBand.Right := ColorBand.Left + MulDiv(Succ(I), Len, Colors) * 2;
      ColorBand.Bottom := ColorBand.Top + MulDiv(Succ(I), Len, Colors) * 2;

      OffsetRect(ColorBand, -RectWidth(ColorBand) div 2, -RectHeight(ColorBand) div 2);

      OffsetRect(ColorBand, Round((Pos.X / 100) * RectWidth(Rect)),
        Round((Pos.X / 100) * RectHeight(Rect)));

      { paint ellipse  }
      FillEllipse(Canvas, ColorBand, RGB(R, G, B));
    end;
  finally
    SelectClipRgn(Canvas.Handle, 0);
    DeleteObject(ClipRgn);
  end;
end;

procedure FillHalftoneRect(Canvas: TCanvas; ARect: TRect; Color, HalfColor: TColor);
var
  i, j: integer;
  HalfBrush: TBrush;
  HalfBitmap: TBitmap;
begin
  if ARect.Left < 0 then ARect.Left := 0;
  if ARect.Top < 0 then ARect.Top := 0;
  if RectWidth(ARect) <= 0 then Exit;
  if RectHeight(ARect) <= 0 then Exit;

  HalfBrush := TBrush.Create;
  HalfBitmap := TBitmap.Create;
  HalfBitmap.Width := 8;
  HalfBitmap.Height := 8;

  { Create halftone bitmap }
  HalfBitmap.Canvas.Brush.Style := bsSolid;
  HalfBitmap.Canvas.Brush.Color := Color;
  HalfBitmap.Canvas.FillRect(Rect(0, 0, 8, 8));

  for i := 0 to HalfBitmap.Width - 1 do
    for j := 0 to HalfBitmap.Height - 1 do
    begin
      if Odd(i) and Odd(j) then
        HalfBitmap.Canvas.Pixels[i, j] := HalfColor;
      if not Odd(i) and not Odd(j) then
        HalfBitmap.Canvas.Pixels[i, j] := HalfColor;
    end;

  HalfBrush.Bitmap := HalfBitmap;

  Canvas.Brush := HalfBrush;
  Canvas.FillRect(ARect);

  HalfBitmap.Free;
  HalfBrush.Free;
end;

procedure FillAlphaRect(Canvas: TCanvas; ARect: TRect; Color: TColor; Alpha: integer);
var
  B: TseBitmap;
begin
  B := TseBitmap.Create;
  B.SetSize(RectWidth(ARect), RectHeight(ARect));
  B.Clear(seColor(Color, Alpha));

  B.AlphaBlend := true;
  B.Draw(Canvas, ARect.Left, ARect.Top);

  B.Free;
end;

procedure DrawPolygon(Canvas: TCanvas; Points: array of TPoint; Color: TColor);
begin
  { Draw Polygon }
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := Color;
  Canvas.Polygon(Points);
end;

procedure FillPolygon(Canvas: TCanvas; Points: array of TPoint; Color: TColor);
begin
  { Fill Polygon }
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := Color;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Color := Color;
  Canvas.Polygon(Points);
end;

procedure FillHalftonePolygon(Canvas: TCanvas; Points: array of TPoint; Color, HalfColor: TColor);
var
  i, j: integer;
  HalfBrush: TBrush;
  HalfBitmap: TBitmap;
begin
  { Fill Polygon }
  HalfBrush := TBrush.Create;
  HalfBitmap := TBitmap.Create;
  HalfBitmap.Width := 8;
  HalfBitmap.Height := 8;

  { Create halftone bitmap }
  HalfBitmap.Canvas.Brush.Style := bsSolid;
  HalfBitmap.Canvas.Brush.Color := Color;
  HalfBitmap.Canvas.FillRect(Rect(0, 0, 8, 8));

  for i := 0 to HalfBitmap.Width - 1 do
    for j := 0 to HalfBitmap.Height - 1 do
    begin
      if Odd(i) and Odd(j) then
        HalfBitmap.Canvas.Pixels[i, j] := HalfColor;
      if not Odd(i) and not Odd(j) then
        HalfBitmap.Canvas.Pixels[i, j] := HalfColor;
    end;

  HalfBrush.Bitmap := HalfBitmap;

  Canvas.Brush := HalfBrush;
  Canvas.Pen.Style := psClear;
  Canvas.Polygon(Points);

  HalfBitmap.Free;
  HalfBrush.Free;
end;

procedure DrawIcon(Canvas: TCanvas; ARect: TRect; AIcon: TIcon);
var
  R: TRect;
begin
  if AIcon = nil then Exit;

  R := Rect(0, 0, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON));
  RectCenter(R, ARect);

  DrawIconEx(Canvas.Handle, R.Left, R.Top, AIcon.Handle, 0, 0, 0, 0, DI_NORMAL);
end;

procedure DrawIcon(Canvas: TCanvas; ARect: TRect; AIcon: Cardinal); overload;
var
  R: TRect;
begin
  if AIcon = 0 then Exit;

  R := Rect(0, 0, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON));
  RectCenter(R, ARect);

  DrawIconEx(Canvas.Handle, R.Left, R.Top, AIcon, 0, 0, 0, 0, DI_NORMAL);
end;

procedure DrawIcon(DC: HDC; ARect: TRect; AIcon: TIcon);
var
  R: TRect;
begin
  if AIcon = nil then Exit;

  R := Rect(0, 0, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON));
  RectCenter(R, ARect);

  DrawIconEx(DC, R.Left, R.Top, AIcon.Handle, 0, 0, 0, 0, DI_NORMAL);
end;

procedure DrawIcon(DC: HDC; ARect: TRect; AIcon: Cardinal);
var
  R: TRect;
begin
  if AIcon = 0 then Exit;

  R := Rect(0, 0, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON));
  RectCenter(R, ARect);

  DrawIconEx(DC, R.Left, R.Top, AIcon, 0, 0, 0, 0, DI_NORMAL);
end;

procedure DrawGlyphShadow(Canvas: TCanvas; X, Y: integer; Glyph: TseBitmap; Color: TColor);
var
  Shadow: TseBitmap;
  i: integer;
  P: PseColor;
begin
  Shadow := TseBitmap.Create;
  try
    Shadow.Assign(Glyph);
    Shadow.AlphaBlend := true;
    Shadow.CheckingTransparent;

    for i := 0 to Shadow.Width * Shadow.Height - 1 do
    begin
      P := @Shadow.Bits[i];
      if P^ shr 24 > 0 then
        P^ := seColor(Color, 100);
    end;

    Shadow.Draw(Canvas.Handle, X, Y);
  finally
    Shadow.Free;
  end;
end;

{ Stream routines ============================================================}

function ReadString(S: TStream): string;
var
  L: Integer;
begin
  L := 0;
  S.Read(L, SizeOf(L));
  SetLength(Result, L);
  S.Read(Pointer(Result)^, L);
end;

procedure WriteString(S: TStream; Value: string);
var
  L: Integer;
begin
  L := Length(Value);
  S.Write(L, SizeOf(L));
  S.Write(Pointer(Value)^, L);
end;

{ Region routines =============================================================}

var
  Rts: array [0..5000] of TRect;

function CreateRegionDataFromBitmap(Bitmap: TseBitmap; var RgnData: PRgnData;
  Left, Top: integer): HRgn;
var
  j, i, i1: integer;
  TrColor: TseColor;
  C: PseColor;
  Count: integer;
begin
  Result := 0;

  TrColor := seTransparent;

  if Bitmap.Empty then Exit;
  if Bitmap.Width * Bitmap.Height = 0 then Exit;

  Count := 0;
  for j := 0 to Bitmap.Height-1 do
  begin
    i := -1;
    while i < Bitmap.Width do
    begin
      repeat
        Inc(i);
        C := Bitmap.PixelPtr[i, j];
        if i >= Bitmap.Width then Break;
      until not ((C^ and not AlphaMask) = TrColor);

      if i >= Bitmap.Width then Break;

      i1 := i;
      repeat
        Inc(i1);
        If (i1 >= Bitmap.Width) Then Break;
        C := Bitmap.PixelPtr[i1, j];
      until ((C^ and not AlphaMask) = TrColor);

      if i <> i1 then
      begin
        Rts[Count] := Rect(Left + i, Top + j, Left + i1, Top + j + 1);
        Inc(Count);
      end;
      i := i1;
    end;
  end;
  { Make Region data }
  Result := Count * SizeOf(TRect);
  GetMem(Rgndata, SizeOf(TRgnDataHeader) + Result);
  RgnData^.rdh.dwSize := SizeOf(TRgnDataHeader);
  RgnData^.rdh.iType := RDH_RECTANGLES;
  RgnData^.rdh.nCount := Count;
  RgnData^.rdh.nRgnSize := 0;
  RgnData^.rdh.rcBound := Rect(0, 0, Bitmap.Width, Bitmap.Height);
  { Update New Region }
  Move(Rts, RgnData^.Buffer, Result);
  Result := SizeOf(TRgnDataHeader) + Count * SizeOf(TRect);
end;

function CreateRegionFromBitmap(Bitmap: TseBitmap; Left, Top: integer): HRgn;
var
  RgnData: PRgnData;
  Size: integer;
begin
  RgnData := nil;
  Size := CreateRegionDataFromBitmap(Bitmap, RgnData, Left, Top);
  Result := ExtCreateRegion(nil, Size, RgnData^);
  if RgnData <> nil then FreeMem(RgnData, Size);
end;

{ Region routines =============================================================}

function CreateRegionDataFromBitmap2(Bitmap: TseBitmap; var RgnData: PRgnData;
  Left, Top: integer): HRgn;
var
  j, i, i1: integer;
  TrColor: TseColor;
  C: PseColor;
  Count: integer;
begin
  Result := 0;

  TrColor := seTransparent;

  if Bitmap.Empty then Exit;
  if Bitmap.Width * Bitmap.Height = 0 then Exit;

  Count := 0;
  for j := 0 to Bitmap.Height-1 do
  begin
    i := -1;
    while i < Bitmap.Width do
    begin
      repeat
        Inc(i);
        C := Bitmap.PixelPtr[i, j];
        if i >= Bitmap.Width then Break;
      until not ((C^ shr 24 = 0));

      if i >= Bitmap.Width then Break;

      i1 := i;
      repeat
        Inc(i1);
        If (i1 >= Bitmap.Width) Then Break;
        C := Bitmap.PixelPtr[i1, j];
      until ((C^ shr 24 = 0));

      if i <> i1 then
      begin
        Rts[Count] := Rect(Left + i, Top + j, Left + i1, Top + j + 1);
        Inc(Count);
      end;
      i := i1;
    end;
  end;
  { Make Region data }
  Result := Count * SizeOf(TRect);
  GetMem(Rgndata, SizeOf(TRgnDataHeader) + Result);
  RgnData^.rdh.dwSize := SizeOf(TRgnDataHeader);
  RgnData^.rdh.iType := RDH_RECTANGLES;
  RgnData^.rdh.nCount := Count;
  RgnData^.rdh.nRgnSize := 0;
  RgnData^.rdh.rcBound := Rect(0, 0, Bitmap.Width, Bitmap.Height);
  { Update New Region }
  Move(Rts, RgnData^.Buffer, Result);
  Result := SizeOf(TRgnDataHeader) + Count * SizeOf(TRect);
end;

function CreateRegionFromBitmap2(Bitmap: TseBitmap; Left, Top: integer): HRgn;
var
  RgnData: PRgnData;
  Size: integer;
begin
  RgnData := nil;
  Size := CreateRegionDataFromBitmap2(Bitmap, RgnData, Left, Top);
  Result := ExtCreateRegion(nil, Size, RgnData^);
  if RgnData <> nil then FreeMem(RgnData, Size);
end;

{ System Routines }

function GetKeyBoardDelayInterval: integer;
var
  A: DWORD;
begin
  SystemParametersInfo(SPI_GETKEYBOARDDELAY, 0, @A, 0);
  Result := (A + 1) * 200;
end;

function GetKeyBoardSpeedInterval: integer;
var
  A: DWORD;
begin
  SystemParametersInfo(SPI_GETKEYBOARDSPEED, 0, @A, 0);
  Result := Round(1000 / ((A + 1) * 2.3));
end;

{ System Routines }

var
  MMX_ACTIVE: Boolean;

function CPUID_Available: Boolean;
asm
        MOV       EDX,False
        PUSHFD
        POP       EAX
        MOV       ECX,EAX
        XOR       EAX,$00200000
        PUSH      EAX
        POPFD
        PUSHFD
        POP       EAX
        XOR       ECX,EAX
        JZ        @1
        MOV       EDX,True
@1:     PUSH      EAX
        POPFD
        MOV       EAX,EDX
end;

function CPU_Signature: Integer;
asm
        PUSH    EBX
        MOV     EAX,1
        DW      $A20F   // CPUID
        POP     EBX
end;

function CPU_Features: Integer;
asm
        PUSH    EBX
        MOV     EAX,1
        DW      $A20F   // CPUID
        POP     EBX
        MOV     EAX,EDX
end;

function HasMMX: Boolean;
begin
  Result := False;
  if not CPUID_Available then Exit;              // no CPUID available
  if CPU_Signature shr 8 and $0F < 5 then Exit;  // not a Pentium class
  if CPU_Features and $800000 = 0 then Exit;     // no MMX
  Result := True;
end;
 
procedure EMMS;
begin
  if MMX_ACTIVE then
  asm
    db $0F,$77               /// EMMS
  end;
end;

{ Unicode Routines ============================================================}

function StringToWideString(CodePage: Cardinal; const s: String): WideString;
var l: Integer;
begin
  if Length(s)=0 then
  begin
    Result := '';
    exit;
  end;
  l := MultiByteToWideChar(CodePage,MB_PRECOMPOSED or MB_USEGLYPHCHARS,
    PAnsiChar(s), Length(s), nil, 0);
  if (l = 0) and (CodePage <> CP_ACP) then
  begin
    CodePage := CP_ACP;
    l := MultiByteToWideChar(CodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS,
      PAnsiChar(s), Length(s), nil, 0);
  end;
  if l<>0 then
  begin
    SetLength(Result, l);
    MultiByteToWideChar(CodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS,
      PAnsiChar(s), Length(s), Pointer(Result), l);
  end
  else
  begin
    SetLength(Result, Length(s));
    for l := 1 to Length(Result) do
      Result[l] := '?';
  end;
end;

{ Screen ======================================================================}

function GetPixelFormat: TPixelFormat;
var
  B: TBitmap;
  Bitmap: HBITMAP;
  DIB: TDIBSection;
begin
  Result := pfCustom;

  B := TBitmap.Create;
  try
    B.Width := 4;
    B.Height := 4;
    B.HandleType := bmDIB;

    Bitmap := GetCurrentObject(B.Canvas.Handle, OBJ_BITMAP);
    if Bitmap <> 0 then
    begin
      if GetObject(Bitmap, SizeOf(DIB), @DIB) = SizeOf(DIB) then
      begin
        case DIB.dsBmih.biBitCount of
          1: Result := pf1bit;
          4: Result := pf4bit;
          8: Result := pf8bit;
          15: Result := pf15bit;
          16: Result := pf16bit;
          24: Result := pf24bit;
          32: Result := pf32bit;
        else
          Result := pfCustom;
        end;
      end;
    end;
  finally
    B.Free;
  end;

  CPixelFormat := Result;
end;

procedure DrawArrowImage(Cnvs: TCanvas; R: TRect; Color: TColor; Code: Integer);
var
  i: Integer;
  X, Y: Integer;
begin
  with Cnvs do
  begin
    Pen.Color := Color;
    case Code of
      1:
        begin
          X := R.Left + RectWidth(R) div 2 - 2;
          Y := R.Top + RectHeight(R) div 2;
          for i := 0 to 3 do
          begin
            MoveTo(X + i, Y - i);
            LineTo(X + i, Y + i + 1);
          end;
        end;
      2:
        begin
          X := R.Left + RectWidth(R) div 2 + 2;
          Y := R.Top + RectHeight(R) div 2;
          for i := 3 downto 0 do
           begin
             MoveTo(X - i, Y + i);
             LineTo(X - i, Y - i - 1);
           end;
        end;
      3:
        begin
          X := R.Left + RectWidth(R) div 2;
          Y := R.Top + RectHeight(R) div 2 - 2;
          for i := 0 to 3 do
          begin
            MoveTo(X - i, Y + i);
            LineTo(X + i + 1, Y + i);
          end;
        end;
      4:
        begin
          X := R.Left + RectWidth(R) div 2;
          Y := R.Top + RectHeight(R) div 2 + 2;
          for i := 3 downto 0 do
          begin
            MoveTo(X - i, Y - i);
            LineTo(X + i + 1, Y - i);
          end;  
        end;
    end;
  end;
end;

initialization
  GetPixelFormat;
  MMX_ACTIVE := HasMMX;
finalization

end.
