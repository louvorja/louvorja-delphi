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

unit se_effect;

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}


interface

uses
  Windows, Graphics, Classes, SysUtils, Clipbrd, Forms, ExtCtrls,
  ImgList, se_bitmap, se_utils;

resourcestring
  SProcListAlreadyExists = 'Effect procedute %s already exists in list';

const

  SRandomSelection   = '[ RANDOM ] - Random selection';
  SBitmap            = '[ BITMAP ] - Bitmap Animation';
  SFade              = '[ FADE ] - ';
  SSlide             = '[ SLIDE ] - ';
  SManual            = '[ MANUAL ] - ';


type

  TseProc = procedure;
  TseAnimationRec = class;

{ Fade Matrix }

  PseMatrixFade = ^TseMatrixFade;
  TseMatrixFade = array[0..0] of Byte;

  TseProcFade = procedure (var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);

{ Slide Matrix }

  TsePointSlide = record
    Alpha: Byte;
    X, Y: SmallInt;
  end;

  PseMatrixSlide = ^TseMatrixSlide;
  TseMatrixSlide = array[0..0] of TsePointSlide;

  TseProcSlide = procedure (var Matrix: TseMatrixSlide; Width, Height: integer; Percent: byte);

{ Manual }

  TseProcManual = procedure (SourceImage, DestImage: TseBitmap; Animation: TseAnimationRec; Percent: byte);

{ Proc kind }

  TseProcKind = (pkFade, pkSlide, pkManual);

{ ProcList Declaration }

  TseProcItem = class
  private
    FKind: TseProcKind;
    FProc: TseProc;
    FName: string;
  public
    property Kind: TseProcKind read FKind write FKind;
    property Proc: TseProc read FProc write FProc;
    property Name: string read FName write FName;
  end;

{ Animation property }

  TseRotation = (krNone, krRotate90, krRotate180, krRotate270);
  TseEffectKind = string;

  TseAnimationRec = class(TComponent)
  private
    FEnabled: boolean;
    FTime: integer;
    FResolution: integer;
    FTileCount: integer;
    FEffect: TseEffectKind;
    FRotation: TseRotation;
    FBitmap: TBitmap;
    procedure SetResolution(const Value: integer);
    procedure SetTileCount(const Value: integer);
    procedure SetTime(const Value: integer);
    procedure SetBitmap(const Value: TBitmap);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Effect: TseEffectKind read FEffect write FEffect;
    property Enabled: boolean read FEnabled write FEnabled default false;
    property Resolution: integer read FResolution write SetResolution default 1;
    property Rotation: TseRotation read FRotation write FRotation default krNone;
    property TileCount: integer read FTileCount write SetTileCount default 1;
    property Time: integer read FTime write SetTime default 400;
  end;


procedure ExecuteAnimation(ACanvas: TCanvas; AX, AY: integer; ASourceImage, ADestImage: TseBitmap; AAnimation: TseAnimationRec);
function StartMultiAnimation(ACanvas: TCanvas; AX, AY: integer; ASourceImage, ADestImage: TseBitmap; AAnimation: TseAnimationRec; AIndex: integer = -1): integer;
procedure StopMultiAnimation(AIndex: integer; DrawLastFrame: boolean = false);
function IsAnimating(AIndex: integer): boolean;

function ReserveIndex: integer;
procedure ReleaseReserved(AIndex: integer);

{$IFDEF SE_DEBUG}
var Outline: TStrings;
{$ENDIF}


const
  AlphaMask = $FF000000;
  
procedure StretchAlphaRect(var X; Width, Height, XDst, YDst, WDst, HDst,
  XSrc, YSrc, WSrc, HSrc: integer; var Alpha);


type

  TseProcList = class(TList)
  private
    function GetProcs(Index: string): TseProcItem;
  public
    procedure Clear; override;
    property Procs[Index: string]: TseProcItem read GetProcs; default;
  end;

  EProcItemError = class(Exception);

const
  ProcList: TseProcList = nil;
  EffectList: TStrings = nil;  // All effects list

function GetEffectList: TStrings;
function GetEffectListComma: string;

procedure RegisterProc(AName: string; AKind: TseProcKind; AProc: TseProc);


type

{ Timer }

  TseTimer = class
  private
    StartValue, StopValue: Int64;
    FFrequency: Int64;
    FCalibrate: Int64;
    function GetElapsed: Extended;
    procedure CalibrateWindows;
  protected
    property Calibrate: Int64 read FCalibrate;
  public
    constructor Create;
    function GetFrequency: Int64;
    procedure Start;
    procedure Stop;
    property Elapsed: Extended read GetElapsed;
  end;

procedure StartTimer(var Timer: TseTimer);
function StopTimer(var Timer: TseTimer): Single;


implementation {===============================================================}

uses math;

const

  MaxAni = 200;
  TimerInterval = 20;

var

  MultiTimer: TTimer;

type

  TseMultiAniRec = record
    Index: integer;
    MatrixWidth, MatrixHeight: integer;
    MatrixLen: integer;
    MatrixFade: PseMatrixFade;
    CopyMatrixFade: PseMatrixFade;
    MatrixSlide: PseMatrixSlide;
    Animating, Drawing, Reserved: boolean;
    CurTime: single;
    Animation: TseAnimationRec;
    DestImage, SourceImage, ResultImage: TseBitmap;
    ProcItem: TseProcItem;
    Canvas: TCanvas;
    X, Y: integer;
  end;

  TseMultiObject = class
    {$IFDEF SE_STATICEFFECTTIMER }
    T: TseTimer;
    constructor Create;
    destructor Destroy; override;
    {$ENDIF}
    procedure DoMultiTimer(Sender: TObject);
  end;


procedure CalcFrameFade(AMultiRec: TseMultiAniRec;
  Percent: byte);
var
  i, j: integer; { loop variables }
  DstRect: TRect;
begin
  { MatrixFade's Animation }
  with AMultiRec do
  begin
    { Clear matrix }
    if Animation.Rotation <> krNone then
    begin
      { Need use copymatrix for rotation }
      FillChar(CopyMatrixFade^, MatrixHeight * MatrixWidth, 0);
      if Animation.Rotation in [krRotate90, krRotate270] then
        TseProcFade(ProcItem.Proc)(CopyMatrixFade^, MatrixHeight, MatrixWidth, Percent)
      else
        TseProcFade(ProcItem.Proc)(CopyMatrixFade^, MatrixWidth, MatrixHeight, Percent);
    end
    else
    begin
      FillChar(MatrixFade^, MatrixHeight * MatrixWidth, 0);
      TseProcFade(ProcItem.Proc)(MatrixFade^, MatrixWidth, MatrixHeight, Percent);
    end;

    { Matrix rotation }
    if Animation.Rotation = krRotate90 then
    begin
      for i := 0 to MatrixWidth - 1 do
        for j := 0 to MatrixHeight - 1 do
          MatrixFade^[i + (MatrixHeight - j - 1) * MatrixWidth] := CopyMatrixFade^[j + i * MatrixHeight];
    end;

    if Animation.Rotation = krRotate180 then
    begin
      for i := 0 to MatrixWidth - 1 do
        for j := 0 to MatrixHeight - 1 do
          MatrixFade^[(MatrixWidth - i - 1)  + (MatrixHeight - j - 1) * MatrixWidth] := CopyMatrixFade^[i + j * MatrixWidth];
    end;

    if Animation.Rotation = krRotate270 then
    begin
      for i := 0 to MatrixWidth - 1 do
        for j := 0 to MatrixHeight - 1 do
          MatrixFade^[(MatrixWidth - i - 1) + j * MatrixWidth] := CopyMatrixFade^[j + i * MatrixHeight];
    end;

    { Apply Matrix }
    for i := 0 to Animation.TileCount - 1 do
      for j := 0 to Animation.TileCount - 1 do
      begin
        DstRect := Rect(0, 0, MatrixWidth * Animation.Resolution, MatrixHeight * Animation.Resolution);
        OffsetRect(DstRect, i * RectWidth(DstRect), j * RectHeight(DstRect));

        StretchAlphaRect(DestImage.Bits^, DestImage.Width, DestImage.Height,
          DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
          0, 0, MatrixWidth, MatrixHeight, MatrixFade^);
      end;

    { Clear alpha }
    ClearAlphaFunc(DestImage.Bits, DestImage.Width * DestImage.Height, seTransparent);

    { Blending }
    DestImage.AlphaBlend := true;
    DestImage.Draw(ResultImage, 0, 0);
  end;
end;

procedure CalcFrameSlide(AMultiRec: TseMultiAniRec;
  Percent: byte);
var
  SourceColor, DestColor: PseColor;
  MatrixValue: TsePointSlide;
  RepeatWidth, RepeatHeight: integer;
  MatrixX, MatrixY, TileX, TileY, ResX, ResY: integer; { loop variables }
  Sx, Sy: integer; { Source position }
  Dx, Dy: integer; { Dest position }
begin
  { MatrixSlide's Animation }
  with AMultiRec do
  begin
    FillChar(MatrixSlide^, MatrixLen, 0);

    { Perform matrix proc }
    if Animation.Rotation in [krRotate90, krRotate270] then
      TseProcSlide(ProcItem.Proc)(MatrixSlide^, MatrixHeight, MatrixWidth, Percent)
    else
      TseProcSlide(ProcItem.Proc)(MatrixSlide^, MatrixWidth, MatrixHeight, Percent);

    { }
    RepeatWidth := ResultImage.Width div Animation.TileCount + 1;
    RepeatHeight := ResultImage.Height div Animation.TileCount + 1;

    { Apply matrix }
    try
      for TileX := 0 to Animation.TileCount-1 do
        for TileY := 0 to Animation.TileCount-1 do
          for MatrixX := 0 to MatrixWidth - 1 do
            for MatrixY := 0 to MatrixHeight - 1 do
            begin
              for ResX := MatrixX * Animation.Resolution to (MatrixX + 1) * Animation.Resolution do
                for ResY := MatrixY * Animation.Resolution to (MatrixY + 1) * Animation.Resolution do
                begin
                  Sx := (TileX * RepeatWidth) + ResX;
                  Sy := (TileY * RepeatHeight) + ResY;

                  { Get matrix value}
                  case Animation.Rotation of
                    krRotate90:
                      begin
                        MatrixValue := MatrixSlide[MatrixY + MatrixHeight * (MatrixWidth - MatrixX - 1)];
                        Dx := (TileX * RepeatWidth) + (MatrixWidth - MatrixValue.Y - 1) * Animation.Resolution + (ResX - MatrixX * Animation.Resolution);
                        Dy := (TileY * RepeatHeight) + MatrixValue.X * Animation.Resolution + (ResY - MatrixY * Animation.Resolution);
                      end;
                    krRotate180:
                      begin
                        MatrixValue := MatrixSlide[(MatrixWidth - MatrixX - 1) + MatrixWidth * (MatrixHeight - MatrixY - 1)];
                        Dx := (TileX * RepeatWidth) + (MatrixWidth - MatrixValue.X - 1) * Animation.Resolution + (ResX - MatrixX * Animation.Resolution);
                        Dy := (TileY * RepeatHeight) + (MatrixHeight - MatrixValue.Y - 1) * Animation.Resolution + (ResY - MatrixY * Animation.Resolution);
                      end;
                    krRotate270:
                      begin
                        MatrixValue := MatrixSlide[(MatrixHeight - MatrixY - 1) + MatrixHeight * MatrixX];
                        Dx := (TileX * RepeatWidth) + MatrixValue.Y * Animation.Resolution + (ResX - MatrixX * Animation.Resolution);
                        Dy := (TileY * RepeatHeight) + (MatrixHeight - MatrixValue.X - 1) * Animation.Resolution + (ResY - MatrixY * Animation.Resolution);
                      end;
                    else
                      { None }
                      MatrixValue := MatrixSlide[MatrixX + MatrixWidth * MatrixY];
                      Dx := (TileX * RepeatWidth) + MatrixValue.X * Animation.Resolution + (ResX - MatrixX * Animation.Resolution);
                      Dy := (TileY * RepeatHeight) + MatrixValue.Y * Animation.Resolution + (ResY - MatrixY * Animation.Resolution);
                  end;

                  { Check source point use loop }
                  if Sx >= DestImage.Width then Continue;
                  if Sy >= DestImage.Height then Continue;

                  { Get color pointer }
                  SourceColor := ResultImage.PixelPtr[Sx, Sy];

                  { Check dest position (use direct value) }
                  if (Dx >= DestImage.Width) or (Dy >= DestImage.Height) or (Dx < 0) or (Dy < 0) then
                    Continue;

                  if (Dx < TileX * RepeatWidth) or (Dx > (TileX + 1) * RepeatWidth) or
                     (Dy < TileY * RepeatHeight) or (Dy > (TileY + 1) * RepeatHeight)
                  then
                    Continue;

                  { Get destination }
                  DestColor := DestImage.PixelPtr[Dx, Dy];

                  { Apply matrix }
                  if (DestColor^ and AlphaMask = 0) then
                    Continue // Transparent
                  else
                    if MatrixValue.Alpha = $FF then
                      SourceColor^ := DestColor^
                    else
                    begin
                      DestColor^ := DestColor^ and not AlphaMask;
                      DestColor^ := DestColor^ or (MatrixValue.Alpha shl 24);
                      SourceColor^ := PixelAlphaBlendFunc(DestColor^, SourceColor^);
                    end;
                end;
            end;
    finally
      EMMS;
    end;
  end;
end;

procedure CalcFrameBitmap(AMultiRec: TseMultiAniRec;
  Percent: byte);
var
  i, j, Value: integer; { loop variables }
  DstRect: TRect;
begin
  { Bitmap's Animation }
  with AMultiRec do
  begin
    { Change Matrix }
    for i := 0 to MatrixWidth - 1 do
      for j := 0 to MatrixHeight - 1 do
      begin
        { Read default value }
        if Animation.Rotation = krNone then
          Value := CopyMatrixFade^[i + j * MatrixWidth]
        else
          if Animation.Rotation = krRotate90 then
            Value := CopyMatrixFade^[j + i * MatrixHeight]
          else
            if Animation.Rotation = krRotate180 then
              Value := CopyMatrixFade^[(MatrixWidth - i - 1) + (MatrixHeight - j - 1) * MatrixWidth]
            else
              Value := CopyMatrixFade^[(MatrixHeight - j - 1) + i * MatrixHeight];

        { Calc new value }
        Inc(Value, MulDiv($1FE , Percent, 100));
        Dec(Value, $FF);

        if Value < 0 then Value := 0;
        if Value > $FF then Value := $FF;

        { Smoth level }
  //      if Value > 0 then Value := $FF;

        { Write value }
        MatrixFade^[i + j * MatrixWidth] := Value;
      end;

    { Apply Matrix }
    for i := 0 to Animation.TileCount - 1 do
      for j := 0 to Animation.TileCount - 1 do
      begin
        DstRect := Rect(0, 0, MatrixWidth * Animation.Resolution, MatrixHeight * Animation.Resolution);
        OffsetRect(DstRect, i * RectWidth(DstRect), j * RectHeight(DstRect));

        StretchAlphaRect(DestImage.Bits^, DestImage.Width, DestImage.Height,
          DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
          0, 0, MatrixWidth, MatrixHeight, MatrixFade^);
      end;

    { Clear alpha }
    ClearAlphaFunc(DestImage.Bits, DestImage.Width * DestImage.Height, seTransparent);

    { Blending }
    DestImage.AlphaBlend := true;
    DestImage.Draw(ResultImage, 0, 0);
  end;
end;

procedure CalcFrameManual(AMultiRec: TseMultiAniRec;
  Percent: byte);
begin
  { Manual Animation }
  with AMultiRec do
  begin
    { Clear alpha }
    ClearAlphaFunc(DestImage.Bits, DestImage.Width * DestImage.Height, seTransparent);
    { Calc frame }
    TseProcManual(ProcItem.Proc)(ResultImage, DestImage, Animation, Percent);
  end;
end;

var
  MultiAniArray: array [0..MaxAni] of TseMultiAniRec;

function ReserveIndex: integer;
var
  i: integer;
begin
  for i := Low(MultiAniArray) to High(MultiAniArray) do
    if (not MultiAniArray[i].Animating) and (not MultiAniArray[i].Reserved) then
    begin
      MultiAniArray[i].Reserved := true;
      Result := i;
      Exit;
    end;
  Result := -1;
end;

procedure ReleaseReserved(AIndex: integer);
begin
  MultiAniArray[AIndex].Reserved := false;
end;

function FindIndex: integer;
var
  i: integer;
begin
  for i := Low(MultiAniArray) to High(MultiAniArray) do
    if (not MultiAniArray[i].Animating) and (not MultiAniArray[i].Reserved) then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

function TimerEnabled: boolean;
var
  i: integer;
begin
  for i := Low(MultiAniArray) to High(MultiAniArray) do
    if MultiAniArray[i].Animating then
    begin
      Result := true;
      Exit;
    end;
  Result := false;
end;

function StartMultiAnimation(ACanvas: TCanvas; AX, AY: integer; ASourceImage, ADestImage: TseBitmap;
  AAnimation: TseAnimationRec; AIndex: integer = -1): integer;
var
  MaskBitmap: TBitmap;
  Mask: TseBitmap;
  i, j: integer;
begin
  if AIndex = -1 then
    Result := FindIndex
  else
    Result := AIndex;
  if Result = -1 then Exit;

  with MultiAniArray[Result] do
  begin
    SourceImage := ASourceImage;
    DestImage := ADestImage;
    Animation := AAnimation;

    if SourceImage = nil then Exit;
    if SourceImage.Width * SourceImage.Height = 0 then Exit;

    { Check }
    if DestImage = nil then Exit;
    if DestImage.Width * DestImage.Height = 0 then Exit;

    { Select Animation }
    if Animation.Effect = SRandomSelection then
    begin
      Randomize;
      ProcItem := ProcList[TseProcItem(ProcList.Items[Random(ProcList.Count)]).Name];
    end
    else
      ProcItem := ProcList[Animation.Effect];

    if Animation.Effect <> SBitmap then
      if (ProcItem = nil) or (@ProcItem.Proc = nil) then Exit;

    ResultImage := TseBitmap.Create;
    ResultImage.SetSize(SourceImage.Width, SourceImage.Height);

    { Calc size an len Matrix }
    MatrixWidth := SourceImage.Width div Animation.Resolution div Animation.TileCount + 1;
    MatrixHeight := SourceImage.Height div Animation.Resolution div Animation.TileCount + 1;

    { Create matrix }
    if Animation.Effect <> SBitmap then
      case ProcItem.Kind of
        pkFade:
          begin
            MatrixLen := MatrixWidth * MatrixHeight;
            GetMem(MatrixFade, MatrixLen);
            { Create copy for rotatation }
            if Animation.Rotation <> krNone then GetMem(CopyMatrixFade, MatrixLen);
          end;
        pkSlide:
          begin
            MatrixLen := MatrixWidth * MatrixHeight * SizeOf(TsePointSlide);
            GetMem(MatrixSlide, MatrixLen);
          end;
      end
    else
    begin
      { Bitmap Ani }
      MatrixLen := MatrixWidth * MatrixHeight;
      GetMem(MatrixFade, MatrixLen);
      GetMem(CopyMatrixFade, MatrixLen);

      { Copy from bitmap }
      MaskBitmap := TBitmap.Create;
      if Animation.Rotation in [krRotate90, krRotate270] then
      begin
        MaskBitmap.Width := MatrixHeight;
        MaskBitmap.Height := MatrixWidth;
        MaskBitmap.Canvas.StretchDraw(Rect(0, 0, MatrixHeight, MatrixWidth), Animation.Bitmap)
      end
      else
      begin
        MaskBitmap.Width := MatrixWidth;
        MaskBitmap.Height := MatrixHeight;
        MaskBitmap.Canvas.StretchDraw(Rect(0, 0, MatrixWidth, MatrixHeight), Animation.Bitmap);
      end;

      Mask := TseBitmap.Create;
      Mask.Assign(MaskBitmap);

      for i := 0 to MatrixWidth - 1 do
        for j := 0 to MatrixHeight - 1 do
        begin
          MatrixFade^[i + j * MatrixWidth] := Mask.Bits[i + j * MatrixWidth] and not $FFFFFF00;
          CopyMatrixFade^[i + j * MatrixWidth] := Mask.Bits[i + j * MatrixWidth] and not $FFFFFF00;
        end;

      Mask.Free;
      MaskBitmap.Free;
    end;

    CurTime := 0.01;
    Animating := true;
    Drawing := false;
    Canvas := ACanvas;
    X := AX;
    Y := AY;

    MultiTimer.Enabled := TimerEnabled;
  end;
end;



procedure StopMultiAnimation(AIndex: integer; DrawLastFrame: boolean = false);
begin
  if AIndex = -1 then Exit;

  with MultiAniArray[AIndex] do
  begin
    if (DestImage = nil) or (SourceImage = nil) or (ResultImage = nil) then Exit;
    if not Animating then Exit;

    {$IFDEF SE_COMPILER6_UP}
    if Canvas.HandleAllocated and DrawLastFrame then
    {$ELSE}
    if DrawLastFrame then
    {$ENDIF}
    begin
      { Calc last frame }
      DestImage.AlphaBlend := true;
      DestImage.Draw(ResultImage, 0, 0);
      { Draw dest image }
      ResultImage.Draw(Canvas, X, Y);
    end;

    { Free matrix }
    if Animation.Effect <> SBitmap then
      case ProcItem.Kind of
        pkFade:
          begin
            if Animation.Rotation <> krNone then FreeMem(CopyMatrixFade, MatrixLen);
            FreeMem(MatrixFade, MatrixLen);
          end;
        pkSlide:
          begin
            FreeMem(MatrixSlide, MatrixLen);
          end;
      end
    else
    begin
      { Bitmap Ani }
      FreeMem(CopyMatrixFade, MatrixLen);
      FreeMem(MatrixFade, MatrixLen);
    end;

    { Free image }
    ResultImage.Free;

    Animating := false;
    MultiTimer.Enabled := TimerEnabled;
  end;
end;

procedure DrawMultiAnimation(AIndex: integer);
var
  Percent: integer;
begin
  { Calc animation frame }
  with MultiAniArray[AIndex] do
  begin
    if (DestImage = nil) or (SourceImage = nil) or (ResultImage = nil) then Exit;
    if not Animating then Exit;
    CurTime := CurTime + TimerInterval;

    if Drawing then Exit;
    Drawing := true;
    try
      Percent := Round((CurTime / Animation.Time) * 100);
      if Percent >= 100 then Percent := 100;

      { Copy source to result }
      SourceImage.Draw(ResultImage, 0, 0);

      if Animation.Effect <> SBitmap then
        case ProcItem.Kind of
          pkFade:
            begin
              { Fade animation }
              CalcFrameFade(MultiAniArray[AIndex], Percent);
            end;
          pkSlide:
            begin
              { Slide animation }
              CalcFrameSlide(MultiAniArray[AIndex], Percent);
            end;
          pkManual:
            begin
              { Manual animation }
              CalcFrameManual(MultiAniArray[AIndex], Percent);
            end;
        end
      else
      begin
        { Bitmap animation }
        CalcFrameBitmap(MultiAniArray[AIndex], Percent);
      end;

      ResultImage.Draw(Canvas, X, Y);

      if Percent >= 100 then
      begin
        StopMultiAnimation(AIndex);
        Exit;
      end;
    finally
      Drawing := false;
    end;
  end;
end;

function IsAnimating(AIndex: integer): boolean;
begin
  Result := (AIndex >= 0) and MultiAniArray[AIndex].Animating;
end;

procedure ExecuteAnimation(ACanvas: TCanvas; AX, AY: integer; ASourceImage, ADestImage: TseBitmap; AAnimation: TseAnimationRec);
var
  Index: integer;
begin
  Index := StartMultiAnimation(ACanvas, AX, AY, ASourceImage, ADestImage, AAnimation);
  while IsAnimating(Index) do
    Application.ProcessMessages;
end;

{$IFDEF SE_STATICEFFECTTIMER }

constructor TseMultiObject.Create;
begin
  inherited;
  T := TseTimer.Create;
end;

destructor TseMultiObject.Destroy;
begin
  T.Free;
  inherited;
end;

{$ENDIF}

procedure TseMultiObject.DoMultiTimer(Sender: TObject);
var
  i: integer;
  {$IFNDEF SE_STATICEFFECTTIMER }
  T: TseTimer;
  {$ENDIF}
  Time: single;
begin
  {$IFNDEF SE_STATICEFFECTTIMER }
  T := TseTimer.Create;
  try
  {$ENDIF}
    StartTimer(T);

    for i := Low(MultiAniArray) to High(MultiAniArray) do
    begin
      DrawMultiAnimation(i);
    end;

    Time := StopTimer(T);
  {$IFNDEF SE_STATICEFFECTTIMER }
  finally
    T.Free;
  end;
  {$ENDIF}

  { Add time to all effects }
  for i := Low(MultiAniArray) to High(MultiAniArray) do
    MultiAniArray[i].CurTime := MultiAniArray[i].CurTime + Time;
end;

var
  MultiObject: TseMultiObject;


type

  PLongword = ^longword;

  PLongArray = ^TLongArray;
  TLongArray = array [0..0] of longword;

  PByteArray = ^TByteArray;
  TByteArray = array [0..0] of byte;
  
procedure StretchAlphaRect(var X; Width, Height, XDst, YDst, WDst, HDst,
  XSrc, YSrc, WSrc, HSrc: integer; var Alpha);
var
  C: PLongword;
  A, AP: PByte;
  CArray: PLongArray;
  AArray: PByteArray;

  R: TRect;
  SFX, SFY: integer;
  DstY, DstX, SrcX: integer;
  SX, SY: integer;
  DX, DY: integer;
  SrcRect, DstRect: TRect;
begin
  SrcRect := Rect(XSrc, YSrc, XSrc + WSrc, YSrc + HSrc);
  DstRect := Rect(XDst, YDst, XDst + WDst, YDst + HDst);

  IntersectRect(R, SrcRect, Rect(0, 0, Width, Height));
  if (RectWidth(R) <= 0) or (RectHeight(R) <= 0) then Exit;
  if (RectWidth(DstRect) <= 0) or (RectHeight(DstRect) <= 0) then Exit;
  IntersectRect(R, DstRect, Rect(0, 0, Width, Height));
  if (RectWidth(R) <= 0) or (RectHeight(R) <= 0) then Exit;

  SFX := MulDiv((R.Left - DstRect.Left) * WSrc, 65535, WDst);
  SFY := MulDiv((R.Top - DstRect.Top) * HSrc, 65535, HDst);

  DX := (WSrc shl 16) div WDst;
  DY := (HSrc shl 16) div HDst;
  SY := SFY;

  CArray := PLongArray(@X);
  AArray := PByteArray(@Alpha);

  for DstY := R.Top to R.Bottom - 1 do
  begin
    A := @AArray[SrcRect.Left + (SY shr 16 + SrcRect.Top) * RectWidth(SrcRect)];
    C := @CArray[R.Left + (DstY * Width)];
    SX := SFX;
    for DstX := R.Left to R.Right - 1 do
    begin
      SrcX := (SX shr 14 and $FFFFFFFC) shr 2;
      Inc(SX, DX);
      { Get alpha }
      AP := PByte(Integer(A) + SrcX);
      { Set Alpha }
      C^ := C^ and not AlphaMask;
      C^ := C^ or (AP^ shl 24);

      Inc(C);
    end;
    Inc(SY, DY);
  end;
end;


procedure RegisterProc(AName: string; AKind: TseProcKind; AProc: TseProc);
var
  Item: TseProcItem;
  i: integer;
begin
  if ProcList = nil then
    ProcList := TseProcList.Create;

  for i := 0 to ProcList.Count - 1 do
  begin
    { Check by name }
    if TseProcItem(ProcList.Items[i]).Name = LowerCase(AName) then
      raise EProcItemError.CreateFmt(SProcListAlreadyExists, [AName]);
    { Check by proc }
    if @TseProcItem(ProcList.Items[i]).Proc = @AProc then
      raise EProcItemError.CreateFmt(SProcListAlreadyExists, [AName]);
  end;

  Item := TseProcItem.Create;
  case AKind of
    pkFade: Item.Name := SFade + AName;
    pkSlide: Item.Name := SSlide + AName;
    pkManual: Item.Name := SManual + AName;
  end;
  Item.Kind := AKind;
  Item.Proc := AProc;

  ProcList.Add(Item);
end;

{ TseProcList }

procedure TseProcList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    TseProcItem(Items[i]).Free;

  inherited;
end;

function TseProcList.GetProcs(Index: string): TseProcItem;
var
  i: integer;
  S: string;
begin
  { Equal }
  for i := 0 to Count - 1 do
  begin
    if LowerCase(TseProcItem(Items[i]).Name) = LowerCase(Index) then
    begin
      Result := TseProcItem(Items[i]);
      Exit;
    end;
  end;

  {  }
  for i := 0 to Count - 1 do
  begin
    S := LowerCase(TseProcItem(Items[i]).Name);
    if Pos(SFade, S) > 0 then System.Delete(S, 1, Pos('-', S)+1);
    if Pos(SSlide, S) > 0 then System.Delete(S, 1, Pos('-', S)+1);
    if Pos(SManual, S) > 0 then System.Delete(S, 1, Pos('-', S)+1);

    if S = LowerCase(Index) then
    begin
      Result := TseProcItem(Items[i]);
      Exit;
    end;
  end;

  Result := nil;
end;

{ FadeMatrix routines }

procedure FadeMatrixLine(var Matrix: TseMatrixFade; Width, Height: integer; x1, y1, x2, y2: integer; Alpha: byte);
var
  i, dx, dy, Plotx, Ploty, ix, iy, max, x, y: integer;
  Plot: boolean;
begin
  dx := x2 - x1;
  dy := y2 - y1;
  ix := abs (dx);
  iy := abs (dy);
  if ix > iy then
    max := ix
  else
    max := iy;
  Plotx := x1;
  Ploty := y1;
  x := 0;
  y := 0;
  if (Plotx >= 0) and (Ploty >= 0) and (Plotx < Width) and (Ploty < Height) then
    Matrix [Plotx + Width*Ploty] := Alpha;
  for i := 0 to max do
  begin
    x := x + ix;
    y := y + iy;
    Plot := false;
    if x > max then
    begin
       Plot := true;
       x := x - max;
       if dx > 0 then
         inc (Plotx)
       else
         dec (Plotx);
    end;
    if y > max then
    begin
       Plot := true;
       y := y - max;
       if dy > 0 then
         inc (Ploty)
       else
         dec (Ploty);
     end;
     if (Plot) and (Plotx >= 0) and (Ploty >= 0) and (Plotx < Width) and (Ploty < Height) then
       Matrix[Plotx + Width*Ploty] := Alpha;
   end;
end;

procedure FadeMatrixCircle(var Matrix: TseMatrixFade; Width, Height: integer; xc, yc, radius: integer; Alpha: byte);
var
  x, y, d: integer;
  Ratio: real;
 procedure Symmetry(x, y, xc, yc : integer);
 procedure SetMatrixpixel(xp, yp : integer);
 begin
   if (xp >= 0) and (xp < width) and (yp>=0) and (yp < Height) then
     Matrix [xp + Width*yp] := Alpha;
 end;
var
  x_start, x_end, x_out : integer;
  y_start, y_end, y_out : integer;
begin
  x_start := round (x * Ratio);
  x_end := round ((x+1) * Ratio);
  y_start := round (y * Ratio);
  y_end := round ((y+1) * Ratio);
  for x_out := x_start to x_end do
  begin
    setmatrixpixel(x_out + xc, y + yc);
    setmatrixpixel(x_out + xc, -y + yc);
    setmatrixpixel(-x_out + xc,-y + yc);
    setmatrixpixel(-x_out + xc,y + yc);
  end;
  for y_out := y_start to y_end do
  begin
    setmatrixpixel(y_out + xc, x + yc);
    setmatrixpixel(y_out + xc, -x + yc);
    setmatrixpixel(-y_out + xc, -x + yc);
    setmatrixpixel(-y_out + xc, x + yc);
  end;
end;
begin
  ratio := 1;
  y := Radius;
  d := 3 - 2 * Radius;
  x := 0;
  while x < y do
  begin
    symmetry (x, y, xc, yc);
    if d < 0 then
      d := d + 4*x + 6
    else
    begin
      d := d + 4*(x-y) + 10;
      dec (y);
    end;
    inc (x);
  end;
  if x = y then
    symmetry (x, y, xc, yc);
end;

{ FadeMatrix's Effects ========================================================}

procedure FadeMatrixFade(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Value: Byte;
begin
  if Percent = 0 then Exit;

  Value := Round($FF * (Percent / 100));

  FillChar(Matrix, Width * Height, Value);
end;

procedure FadeMatrixDiagonal(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  x, y: integer;
begin

  if percent = 0 then
    exit;

  DeltaX := MulDiv((Width-1), Percent, 100) * 2;
  DeltaY := MulDiv((Height-1), Percent, 100) * 2;

  if DeltaX > DeltaY then
  begin
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, y, x, 0, MulDiv(Percent,$FF,100));
      if y < DeltaY then
        Inc (y);
    end;
  end
  else
  begin
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, y, x, 0, MulDiv(Percent,$FF,100));
      if x < DeltaX then
        Inc(x);
    end;
  end;
end;

procedure FadeMatrixDiagonalIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  x, y: integer;
begin

  if percent = 0 then
    exit;

  DeltaX := Round ((Percent/100)*(Width-1));
  DeltaY := Round ((Percent/100)*(Height-1));

  if DeltaX > DeltaY then
  begin
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, Height-y-1, x, Height-1, MulDiv(Percent,$FF,100));
      if y < DeltaY then
        Inc (y);
    end;
    y := 0;
    for x := Width - 1 downto Width - DeltaX - 1 do
    begin
      FadeMatrixLine(Matrix, Width, Height, x, 0, width-1, y, MulDiv(Percent,$FF,100));
      if y < DeltaY then
        Inc (y);
    end;
  end
  else
  begin
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, Height-y-1, x, Height-1, MulDiv(Percent,$FF,100));
      if x < DeltaX then
        Inc (x);
    end;
    x := Width - 1;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine(Matrix, Width, Height, x, 0, Width-1, y, MulDiv(Percent,$FF,100));
      if x > Width - 1 - DeltaX then
        Dec (x);
    end;
  end;
end;

procedure FadeMatrixDiagonalOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  x, y: integer;
begin
  if percent = 0 then
    exit;
  DeltaX := Round ((Percent/100)*(Width-1));
  DeltaY := Round ((Percent/100)*(Height-1));
  if DeltaX > DeltaY then
  begin
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, Y, Width - x -1, Height - 1, MulDiv(Percent,$FF,100));
      if y < DeltaY then
        Inc (y);
    end;
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine (Matrix, Width, Height, x, 0, Width, Height - y, MulDiv(Percent,$FF,100));
      if y < DeltaY then
        Inc (y);
    end;
  end
  else
  begin
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine (Matrix, Width, Height, x, 0, Width - 1, Height - y -1, MulDiv(Percent,$FF,100));
      if x < DeltaX then
        Inc (x);
    end;
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, y, Width-x-1, height-1, MulDiv(Percent,$FF,100));
      if x < DeltaX then
        Inc (x);
    end;
  end;
end;

procedure FadeMatrixDown(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  j: integer;
begin
  if percent = 0 then
    exit;
  for j := 0 to MulDiv(Percent,Height-1,100) do
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, MulDiv(Percent,$FF,100));
end;

procedure FadeMatrixIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  j: integer;
begin
  if percent = 0 then
    exit;
  for j := Height-1 downto Height - 1 - MulDiv(Percent,Height div 2,100) do
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, MulDiv(Percent,$FF,100));
  for j := 0 to MulDiv(Percent,Height div 2,100) do
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, MulDiv(Percent,$FF,100));
end;

procedure FadeMatrixOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  j: integer;
begin
  if percent = 0 then
    exit;
  for j := 0 to MulDiv(Percent,Height div 2,100) do
  begin
    FadeMatrixLine (Matrix, Width, Height, 0, Height div 2 - j, Width-1, Height div 2 - j, MulDiv(Percent,$FF,100));
    FadeMatrixLine (Matrix, Width, Height, 0, Height div 2 + j, Width-1, Height div 2 + j, MulDiv(Percent,$FF,100));
  end;
end;

procedure FadeMatrixCrossOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  Center: TPoint;
  i: integer;
begin
  if Percent = 0 then
    exit;
  DeltaX := MulDiv (Percent, Width*2, 100);
  DeltaY := MulDiv (Percent, Height*2, 100);
  Center.X := Width div 2;
  Center.Y := Height div 2;
  for i := -DeltaX div 4 to DeltaX div 4 do
    FadeMatrixLine (Matrix, Width, Height, Center.X+i, Center.Y-DeltaY,Center.X+i, Center.Y+DeltaY, MulDiv (Percent, $FF,100));
  for i := -DeltaY div 4 to DeltaY div 4 do
    FadeMatrixLine (Matrix, Width, Height, Center.X-DeltaX, Center.Y+i,Center.X+DeltaX, Center.Y+i, MulDiv (Percent, $FF,100));
end;

procedure FadeMatrixCrossIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeMatrixCrossOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      if Matrix[i+j*Width] = 0
      then
        Matrix[i+j*Width] := MulDiv (Percent, $FF,100)
      else
        Matrix[i+j*Width] := 0;
end;

procedure FadeMatrixRectOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Round (Width*1), 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Round (Height*1), 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  for i := 0 to Delta div 2 do
  begin
    Alpha := MulDiv ($FF, Percent, 100);
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y+y,Center.X-x, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y-y,Center.X+x, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y-y,Center.X+x, Center.Y+y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y+y,Center.X-x, Center.Y+y, Alpha);
  end;
end;

procedure FadeMatrixRectIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeMatrixRectOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      if Matrix[i+j*Width] = 0
      then
        Matrix[i+j*Width] := MulDiv (Percent, $FF,100)
      else
        Matrix[i+j*Width] := 0;
end;

{ Pixel Effects ==============================================================}

procedure FadeMatrixPixel(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  MatrixSize: Cardinal;
  i, j: cardinal;
  PixelisZero: boolean;
  RandomPosition: Cardinal;
begin
  if percent = 0 then Exit;

  MatrixSize := Width * Height;
  RandSeed := MatrixSize;
  j := Round(MatrixSize * (Percent / 100));
  for i := 1 to j do
  begin
    PixelisZero := false;
    while not PixelisZero do
    begin
      RandomPosition := Random(MatrixSize);
      if Matrix [RandomPosition] = 0 then
      begin
        PixelisZero := true;
        Matrix[RandomPosition] := $FF;
      end;
    end;
  end;
end;

procedure FadeMatrixPixelFade(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  MatrixSize: Cardinal;
  i, j: cardinal;
  PixelisZero: boolean;
  RandomPosition: Cardinal;
begin
  if percent = 0 then
    exit;
  MatrixSize := Width*Height;
  RandSeed := (MatrixSize);
  j := Round (MatrixSize * Percent/100);
  for i := 1 to j do
  begin
    PixelisZero := false;
    while not PixelisZero do
    begin
      RandomPosition := Random(MatrixSize);
      if matrix [RandomPosition] = 0 then
      begin
        PixelisZero := true;
        matrix [RandomPosition] := Round((Percent/100)*$FF);
      end;
    end;
  end;
end;

procedure FadeMatrixPixelLine(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  D: PseMatrixFade;
  MatrixSize: Cardinal;
  i, j: cardinal;
  PixelisZero: boolean;
  RandomPosition: Cardinal;
  DeltaX, Delta: Integer;
  DeltaP: Real;
begin
  if percent = 0 then
    exit;

  GetMem(D, Width * Height);
  FillChar(D^, Width*Height, 0);

  MatrixSize := Width*Height;
  RandSeed := (MatrixSize);
  j := Round (MatrixSize * Percent/100);

  for i := 1 to j do
  begin
    PixelisZero := false;
    while not PixelisZero do
    begin
      RandomPosition := random (MatrixSize);
      if D^ [RandomPosition] = 0 then
      begin
        PixelisZero := true;
        D^ [RandomPosition] := $FF;
      end;
    end;
  end;

  DeltaX := Round ((Percent/100)*(Width*2-1));
  DeltaP := (0.1*Width) / Percent;
  for i := 0 to DeltaX do
    for j := 0 to Height - 1 do
      begin
        if i < Width then
          begin
            Delta := Round (Percent*2-DeltaP*i);
            if Delta < 0 then
              Delta := 0;
            Delta := Round((Delta/100)*$FF);
            if Delta > $FF then
              Delta := $FF;
            if D^ [i + j*Width] <> $0 then
              Matrix [i + j*Width] :=  Delta;
          end;
    end;

  FreeMem(D, MatrixSize);
end;

{ Smooth Effects ==============================================================}

procedure FadeMatrixSmoothRectOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  DeltaP: real;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv(Percent, Round(Width*1.6), 100);
    RealY := Height / Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv(Percent, Round(Height*1.6), 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  if (Delta div 2) = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / (Delta div 2);

  for i := 0 to Delta div 2 do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine(Matrix, Width, Height, Center.X-x, Center.Y+y,Center.X-x, Center.Y-y, Alpha);
    FadeMatrixLine(Matrix, Width, Height, Center.X-x, Center.Y-y,Center.X+x, Center.Y-y, Alpha);
    FadeMatrixLine(Matrix, Width, Height, Center.X+x, Center.Y-y,Center.X+x, Center.Y+y, Alpha);
    FadeMatrixLine(Matrix, Width, Height, Center.X+x, Center.Y+y,Center.X-x, Center.Y+y, Alpha);
  end;
end;

{ Circle animations ===========================================================}

procedure FadeCircleSlideOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  delta: integer;
begin
  delta := muldiv (round(sqrt(sqr(height)+sqr(width))), percent, 100) div 2;
  for i := 0 to delta do
    FadeMatrixCircle(matrix, width, height, width div 2, height div 2, i, $FF);
end;

procedure FadeCircleFadeOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  delta: integer;
begin
  delta := muldiv (round(sqrt(sqr(height)+sqr(width))), percent, 100) div 2;
  for i := 0 to delta do
    FadeMatrixCircle (matrix, width, height, width div 2, height div 2, i, muldiv (percent, $FF, 100));
end;

procedure FadeCircleSmoothOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  Delta: integer;
  Deltap: real;
  Alpha: integer;
begin
  if percent = 0 then
    exit;
  Delta := MulDiv (Round(Sqrt(Sqr(Height)+Sqr(Width))*0.9), Percent, 100);
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2) / Delta;
  for i := 0 to Delta do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    FadeMatrixCircle(Matrix, Width, Height, Width div 2, Height div 2, i, Alpha);
  end;
end;

procedure FadeCircleSlideIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  delta,size: integer;
begin
  delta := muldiv (round(sqrt(sqr(height)+sqr(width))), percent, 100) div 2;
  size := round(sqrt(sqr(height)+sqr(width))) div 2;
  for i := delta downto 0 do
    FadeMatrixCircle (matrix, width, height, width div 2, height div 2, size-i, $FF);
end;

procedure FadeCircleFadeIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  delta,size: integer;
begin
  delta := muldiv (round(sqrt(sqr(height)+sqr(width))), percent, 100) div 2;
  size := round(sqrt(sqr(height)+sqr(width))) div 2;
  for i := delta downto 0 do
    FadeMatrixCircle (matrix, width, height, width div 2, height div 2, size-i, muldiv (percent, $FF, 100));
end;

procedure FadeCircleSmoothIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeCircleSmoothOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      Matrix[i+j*Width] := $FF - Matrix[i+j*Width];
end;

procedure FadeCircleSlide(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  Delta: integer;
begin
  Delta := muldiv (round(sqrt(sqr(Height)+sqr(Width))), Percent, 100);
  for i := Delta downto 0 do
    FadeMatrixCircle (Matrix, Width, Height, 0, Height - 1, Delta - i, $FF);
end;

procedure FadeCircleFade(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  Delta: integer;
begin
  Delta := muldiv (round(sqrt(sqr(Height)+sqr(Width))), Percent, 100);
  for i := Delta downto 0 do
    FadeMatrixCircle (Matrix, Width, Height, 0, Height - 1, Delta - i, muldiv (Percent, $FF, 100));
end;

procedure FadeCircleSmooth(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  delta: integer;
  deltap: real;
  Alpha: integer;
begin
  if Percent = 0 then
    exit;
  Delta := MulDiv (round(sqrt(sqr(Height)+sqr(Width))*1.5), Percent, 100);
  DeltaP := (Percent*2)  / Delta;
  for i := 0 to delta do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    FadeMatrixCircle (Matrix, Width, Height, 0, Height - 1, i, Alpha);
  end;
end;

{ Diamond Animation ===========================================================}

procedure FadeDiamondSlideOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Width, 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Height, 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  for i := 0 to Delta do
  begin
    Alpha := $FF;
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine(Matrix, Width, Height, Center.X, Center.Y+y, Center.X-x, Center.Y, Alpha);
    FadeMatrixLine(Matrix, Width, Height, Center.X-x, Center.Y, Center.X, Center.Y-y, Alpha);
    FadeMatrixLine(Matrix, Width, Height, Center.X, Center.Y-y, Center.X+x, Center.Y, Alpha);
    FadeMatrixLine(Matrix, Width, Height, Center.X+x, Center.Y, Center.X, Center.Y+y, Alpha);
  end;
end;

procedure FadeDiamondFadeOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Width, 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Height, 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  for i := 0 to Delta do
  begin
    Alpha := MulDiv ($FF, Percent, 100);
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, Center.X, Center.Y+y, Center.X-x, Center.Y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y, Center.X, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X, Center.Y-y, Center.X+x, Center.Y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y, Center.X, Center.Y+y, Alpha);
  end;
end;

procedure FadeDiamondSmoothOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  DeltaP: real;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Round (Width*2.5), 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Round (Height*2.5), 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  if (Delta div 2) = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / (Delta div 2);
  for i := 0 to Delta div 2 do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, Center.X, Center.Y+y, Center.X-x, Center.Y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y, Center.X, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X, Center.Y-y, Center.X+x, Center.Y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y, Center.X, Center.Y+y, Alpha);
  end;
end;

procedure FadeDiamondSlideIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeDiamondSlideOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      if Matrix[i+j*Width] = 0
      then
        Matrix[i+j*Width] := $FF
      else
        Matrix[i+j*Width] := 0;
end;

procedure FadeDiamondFadeIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j : integer;
begin
  if Percent = 0 then
    exit;
  FadeDiamondFadeOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      if Matrix[i+j*Width] = 0
      then
        Matrix[i+j*Width] := MulDiv (Percent, $FF,100)
      else
        Matrix[i+j*Width] := 0;
end;


procedure FadeDiamondSmoothIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeDiamondSmoothOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      Matrix[i+j*Width] := $FF - Matrix[i+j*Width];
end;

{ Other Animation =============================================================}

procedure FadePlasma(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  SinLut,CosLut: array[0..2047]of Integer;
  Colors: array[0..2047]of byte;
  i: integer;
  y,x: integer;
  a: integer;
  xx,yy: integer;
  Keys: array [0..12] of byte;
  PlasmaWidth: integer;
procedure FillColors(i1,i2,nKeys:Integer);
var
  c1,c2: byte;
  i,n,cs,w1,w2,x,ii: Integer;
begin
  i:=0;
  n:=i2-i1;
  Dec(nKeys);
  ii:=(nKeys shl 16)div n;
  for x:=0 to n-1 do
  begin
    cs:=i shr 16;
    c1:=Keys[cs];
    if cs<nKeys then Inc(cs);
    c2:=Keys[cs];
    w1:=((not i)and $FFFF)+1;
    w2:=i and $FFFF;
    if(w1<(ii-w1))
    then
       Colors[x] := c2
    else
      if (w2<(ii-w2))
      then
         Colors[x]:=c1
      else
        Colors[x]:=((c1*w1)+(c2*w2))shr 16;
    Inc(i,ii);
  end;
  Colors[x] := c2;
end;
begin
  PlasmaWidth := 512;
  for i:=0 to PlasmaWidth - 1 do
  begin
    SinLut[i]:=(Trunc(Sin(2*Pi*i/PlasmaWidth)*(PlasmaWidth div 2))+PlasmaWidth div 2)and (PlasmaWidth-1);
    CosLut[i]:=(Trunc(Cos(2*Pi*i/PlasmaWidth)*(PlasmaWidth div 2))+PlasmaWidth div 2)and (PlasmaWidth-1);
  end;
  Keys[0]:=255;
  Keys[1]:=255;
  Keys[2]:=0;
  Keys[3]:=0;
  Keys[4]:=255;
  Keys[5]:=255;
  Keys[6]:=0;
  Keys[7]:=0;
  Keys[8]:=255;
  Keys[9]:=255;
  Keys[10]:=0;
  Keys[11]:=0;
  Keys[12]:=255;
  FillColors(0,PlasmaWidth-1,13);
  for y:=0 to Height-1 do
    begin
      xx:=SinLut[(y)and (PlasmaWidth-1)];
      yy:=CosLut[(y)and (PlasmaWidth-1)];
      for x:=0 to Width-1 do
      begin
        a:=MulDiv (Percent*2,255,100)-Colors[(SinLut[(x+xx)and (PlasmaWidth-1)]+yy)and (PlasmaWidth-1)];
        if a < 0 then
          a := 0;
        if a > 255 then
          a := 255;
        Matrix [x+y*Width] := a;
      end;
    end;
end;

procedure FadeStream(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
type
  PVector = ^TVector;
  TVector = array[0..0] of Integer;
var
  i,j: Word;
  YMax: PVector;
  Yy: PVector;
begin
  GetMem (YMax, Width*Sizeof (integer));
  GetMem (Yy, Width*Sizeof (integer));
  RandSeed := Width*Height;
  for i:=0 to Width - 1 do
  begin
    yy^ [i]:=-Random(80);
    YMax^ [i]:=Height - 1;
  end;
  for j:=1 to 8 do
    for I:=j to Width-1-j do
      yy^ [i]:=(yy^[i-1] + yy^[i]*2 + yy^[i+1]) div 4;

  for i:=0 to MulDiv (Height+79, Percent, 100) do
  begin
    for j:=0 to Width-1 do
    begin
      if yy^ [j] <= YMax^ [j] then
      begin
        if yy^ [j] >= 0 then
          Matrix [j + Width*yy^[j]] := $FF;
        Inc (yy^ [j]);
      end
      else
      begin
        yy^ [j] := 0;
        Dec (YMax^ [j]);
      end;
    end;
  end;
  FreeMem (YMax);
  FreeMem (Yy);
end;

{ Rotate Effects ==============================================================}

procedure FadeRotateSlide(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  size: integer;
begin
  if percent = 0 then
    exit;

  size := MulDiv (height + width, percent, 100);
  for i := 0 to size do
  begin
    if i < Height then
      FadeMatrixLine(Matrix, Width, Height, 0, height-1, Width-1, height-i, $FF)
    else
      FadeMatrixLine(Matrix, Width, Height, 0, height-1, width-(size-i), 0, $FF);
  end;
end;

procedure FadeRotateFade(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  size: integer;
begin
  if percent = 0 then
    exit;

  size := MulDiv (height + width, percent, 100);
  for i := 0 to size do
  begin
    if i < Height then
      FadeMatrixLine (Matrix, Width, Height, 0, height-1, Width-1, height-i, MulDiv (Percent, $FF, 100))
    else
      FadeMatrixLine (Matrix, Width, Height, 0, height-1, width-(size-i), 0, MulDiv (Percent, $FF, 100));
  end;
end;

procedure FadeRotateSmooth(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i: integer;
  Delta: integer;
  Deltap: real;
  Alpha: Integer;
begin
  if percent = 0 then
    exit;

  Delta := MulDiv ((Height + Width)*2, percent, 100);
  DeltaP := (Percent*2)  / Delta;
  for i := 0 to Delta do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    if i < Height then
      FadeMatrixLine (Matrix, Width, Height, 0, height-1, Width-1, height-i, Alpha)
    else
      FadeMatrixLine (Matrix, Width, Height, 0, height-1, width-(i-height), 0, Alpha);
  end;
end;

{ Slide Effects ===============================================================}

procedure FadeSlideDiagonal(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  x, y: integer;
begin

  if percent = 0 then
    exit;

  DeltaX := MulDiv ((Width-1), Percent, 100) * 2;
  DeltaY := MulDiv ((Height-1), Percent, 100) * 2;

  if DeltaX > DeltaY then
  begin
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, y, x, 0, $FF);
      if y < DeltaY then
        Inc (y);
    end;
  end
  else
  begin
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, y, x, 0, $FF);
      if x < DeltaX then
        Inc(x);
    end;
  end;
end;

procedure FadeSlideDiagonalIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  x, y: integer;
begin

  if percent = 0 then
    exit;

  DeltaX := Round ((Percent/100)*(Width-1));
  DeltaY := Round ((Percent/100)*(Height-1));

  if DeltaX > DeltaY then
  begin
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, Height-y-1, x, Height-1, $FF);
      if y < DeltaY then
        Inc (y);
    end;
    y := 0;
    for x := Width - 1 downto Width - DeltaX - 1 do
    begin
      FadeMatrixLine(Matrix, Width, Height, x, 0, width-1, y, $FF);
      if y < DeltaY then
        Inc (y);
    end;
  end
  else
  begin
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine(Matrix, Width, Height, 0, Height-y-1, x, Height-1, $FF);
      if x < DeltaX then
        Inc (x);
    end;
    x := Width - 1;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine(Matrix, Width, Height, x, 0, Width-1, y, $FF);
      if x > Width - 1 - DeltaX then
        Dec (x);
    end;
  end;
end;

procedure FadeSlideDiagonalOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  x, y: integer;
begin
  if percent = 0 then
    exit;
  DeltaX := Round ((Percent/100)*(Width-1));
  DeltaY := Round ((Percent/100)*(Height-1));
  if DeltaX > DeltaY then
  begin
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, Y, Width - x -1, Height - 1, $FF);
      if y < DeltaY then
        Inc (y);
    end;
    y := 0;
    for x := 0 to DeltaX do
    begin
      FadeMatrixLine (Matrix, Width, Height, x, 0, Width, Height - y, $FF);
      if y < DeltaY then
        Inc (y);
    end;
  end
  else
  begin
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine (Matrix, Width, Height, x, 0, Width - 1, Height - y -1, $FF);
      if x < DeltaX then
        Inc (x);
    end;
    x := 0;
    for y := 0 to DeltaY do
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, y, Width-x-1, height-1, $FF);
      if x < DeltaX then
        Inc (x);
    end;
  end;
end;

procedure FadeSlideDown(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  j: integer;
begin
  if percent = 0 then
    exit;
  for j := 0 to MulDiv(Percent,Height-1,100) do
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, $FF);
end;

procedure FadeSlideIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  j: integer;
begin
  if percent = 0 then
    exit;
  for j := Height-1 downto Height - 1 - MulDiv(Percent,Height div 2,100) do
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, $FF);
  for j := 0 to MulDiv(Percent,Height div 2,100) do
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, $FF);
end;

procedure FadeSlideOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  j: integer;
begin
  if percent = 0 then
    exit;
  for j := 0 to MulDiv(Percent,Height div 2,100) do
  begin
    FadeMatrixLine (Matrix, Width, Height, 0, Height div 2 - j, Width-1, Height div 2 - j, $FF);
    FadeMatrixLine (Matrix, Width, Height, 0, Height div 2 + j, Width-1, Height div 2 + j, $FF);
  end;
end;

procedure FadeSlideCrossOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  DeltaX, DeltaY: integer;
  Center: TPoint;
  i: integer;
begin
  if Percent = 0 then
    exit;
  DeltaX := MulDiv (Percent, Width*2, 100);
  DeltaY := MulDiv (Percent, Height*2, 100);
  Center.X := Width div 2;
  Center.Y := Height div 2;
  for i := -DeltaX div 4 to DeltaX div 4 do
    FadeMatrixLine (Matrix, Width, Height, Center.X+i, Center.Y-DeltaY,Center.X+i, Center.Y+DeltaY, $FF);
  for i := -DeltaY div 4 to DeltaY div 4 do
    FadeMatrixLine (Matrix, Width, Height, Center.X-DeltaX, Center.Y+i,Center.X+DeltaX, Center.Y+i, $FF);
end;

procedure FadeSlideCrossIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeSlideCrossOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      if Matrix[i+j*Width] = 0
      then
        Matrix[i+j*Width] := $FF
      else
        Matrix[i+j*Width] := 0;
end;

procedure FadeSlideRectOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Round (Width*1), 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Round (Height*1), 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  for i := 0 to Delta div 2 do
  begin
    Alpha := $FF;
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y+y,Center.X-x, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y-y,Center.X+x, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y-y,Center.X+x, Center.Y+y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y+y,Center.X-x, Center.Y+y, Alpha);
  end;
end;

procedure FadeSlideRectIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeSlideRectOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      if Matrix[i+j*Width] = 0
      then
        Matrix[i+j*Width] := $FF
      else
        Matrix[i+j*Width] := 0;
end;

{ Smooth Effects ==============================================================}

procedure FadeSmoothDiagonal(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  DeltaP: Real;
  x, y, i: integer;
  RealX,RealY: Real;
  Alpha: integer;
begin

  if Percent = 0 then
    exit;

  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Round(Sqrt(Sqr(Height)+Sqr(Width))*2.5), 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Round(Sqrt(Sqr(Height)+Sqr(Width))*2.5), 100);
    RealX:= Width/Height;
  end;
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / Delta;

  for i := 0 to Delta do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    x := Round (RealX*i);
    y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, 0, y, x, 0, Alpha);
  end;
end;

procedure FadeSmoothDown(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: Integer;
  DeltaP: Real;
  j: Integer;
  Alpha: integer;
begin
  if Percent = 0 then
    exit;
  Delta := MulDiv (Round(Height*1.5), Percent, 100);
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / Delta;
  for j := 0 to Delta do
  begin
    Alpha := MulDiv (Round(Percent*2-j*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, Alpha);
  end;
end;

procedure FadeSmoothIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: Integer;
  DeltaP: Real;
  j: Integer;
  Alpha: integer;
begin
  if Percent = 0 then
    exit;
  Delta := MulDiv (Round(Height*0.8), Percent, 100);
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / Delta;
  for j := 0 to Delta do
  begin
    Alpha := MulDiv (Round(Percent*2-j*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    if j <= Height div 2 then
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, Height-j-1, Width-1, Height-j-1, Alpha);
      FadeMatrixLine (Matrix, Width, Height, 0, j, Width-1, j, Alpha);
    end;
  end;
end;

procedure FadeSmoothOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: Integer;
  DeltaP: Real;
  j: Integer;
  Alpha: integer;
begin
  if Percent = 0 then
    exit;
  Delta := MulDiv (Round(Height*0.8), Percent, 100);
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / Delta;
  for j := 0 to Delta do
  begin
    Alpha := MulDiv (Round(Percent*2-j*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    if j <= Height div 2 then
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, Height div 2 - j, Width-1, Height div 2 - j, Alpha);
      FadeMatrixLine (Matrix, Width, Height, 0, Height div 2 + j, Width-1, Height div 2 + j, Alpha);
    end;
  end;
end;

procedure FadeSmoothDiagonalIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta,i: integer;
  DeltaX, DeltaY: real;
  x,y: real;
  DeltaP: real;
  Size: integer;
  Alpha:integer;
begin

  if percent = 0 then
    exit;

  if Height > Width then
  begin
    DeltaY := 1;
    DeltaX := Width/Height;
    Size:=Height;
  end
  else
  begin
    DeltaX := 1;
    DeltaY := Height/Width;
    Size:=Width;
  end;
  Delta := MulDiv (round(sqrt(sqr(Height)+sqr(Width))), Percent, 100);
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / Delta;
  x := 0;
  y := 0;
  Delta := Round (Delta*2);

  for i := 0 to Delta do
  begin
    Alpha := MulDiv(Round(2*Percent-DeltaP*i/2), $FF, 100);
    if Alpha < 0 then
      Alpha := 0;
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;

    if i < Size then
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, Height-1-Round(y), Round(x), Height-1, Alpha);
      FadeMatrixLine (Matrix, Width, Height, Width-Round(x), 0, Width-1, Round(y), Alpha);
    end;

    x := x + DeltaX;
    y := y + DeltaY;
  end;
end;

procedure FadeSmoothDiagonalOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta,i: integer;
  DeltaX, DeltaY: real;
  x,y: real;
  DeltaP: real;
  Size: integer;
  Alpha:integer;
begin
  if percent = 0 then
    exit;

  if Height > Width then
  begin
    DeltaY := 1;
    DeltaX := Width/Height;
    Size:=Height;
  end
  else
  begin
    DeltaX := 1;
    DeltaY := Height/Width;
    Size:=Width;
  end;
  Delta := MulDiv (round(sqrt(sqr(Height)+sqr(Width))), Percent, 100);
  if Delta = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / Delta;
  x := 0;
  y := 0;
  Delta := Round (Delta*2);

  for i := 0 to Delta do
  begin
    Alpha := MulDiv(Round(2*Percent-DeltaP*i/2), $FF, 100);
    if Alpha < 0 then
      Alpha := 0;
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    if i < Size then
    begin
      FadeMatrixLine (Matrix, Width, Height, 0, Height-1-Round(y), Width - Round(x), 0, Alpha);
      FadeMatrixLine (Matrix, Width, Height, Round(x), Height-1, Width-1, Round(y), Alpha);
    end;

    x := x + DeltaX;
    y := y + DeltaY;

  end;
end;

procedure FadeSmoothCrossOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  DeltaP: real;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;

  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Round (Width*2.5), 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Round (Height*2.5), 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  if (Delta div 2) = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / (Delta div 2);
  for i := 0 to Delta div 2 do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x div 2, Center.Y+y,Center.X-x div 2, Center.Y+y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x div 2, Center.Y+y div 2,Center.X-x, Center.Y+y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y+y div 2,Center.X-x, Center.Y-y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y-y div 2,Center.X-x div 2, Center.Y-y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x div 2, Center.Y-y div 2,Center.X-x div 2, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x div 2, Center.Y-y,Center.X+x div 2, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x div 2, Center.Y-y,Center.X+x div 2, Center.Y-y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x div 2, Center.Y-y div 2,Center.X+x, Center.Y-y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y-y div 2,Center.X+x, Center.Y+y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y+y div 2,Center.X+x div 2, Center.Y+y div 2, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x div 2, Center.Y+y div 2,Center.X+x div 2, Center.Y+y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x div 2, Center.Y+y,Center.X-x div 2, Center.Y+y, Alpha);
  end;
end;

procedure FadeSmoothCrossIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeSmoothCrossOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      Matrix[i+j*Width] := $FF - Matrix[i+j*Width];
end;

procedure FadeSmoothRectOut(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  Delta: integer;
  Center: TPoint;
  i: integer;
  DeltaP: real;
  Alpha: integer;
  RealX,RealY: Real;
  x,y: integer;
begin
  if Percent = 0 then
    exit;
  if Width > Height then
  begin
    RealX := 1;
    Delta := MulDiv (Percent, Round (Width*1.6), 100);
    RealY := Height/Width;
  end
  else
  begin
    RealY := 1;
    Delta := MulDiv (Percent, Round (Height*1.6), 100);
    RealX:= Width/Height;
  end;
  Center.X := Width div 2;
  Center.Y := Height div 2;
  if (Delta div 2) = 0 then
    DeltaP := (Percent*2)
  else
    DeltaP := (Percent*2)  / (Delta div 2);
  for i := 0 to Delta div 2 do
  begin
    Alpha := MulDiv (Round(Percent*2-i*DeltaP), $FF, 100);
    if Alpha > $FF then
      Alpha := $FF;
    if Percent = 100 then
      Alpha := $FF;
    X := Round (RealX*i);
    Y := Round (RealY * i);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y+y,Center.X-x, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X-x, Center.Y-y,Center.X+x, Center.Y-y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y-y,Center.X+x, Center.Y+y, Alpha);
    FadeMatrixLine (Matrix, Width, Height, Center.X+x, Center.Y+y,Center.X-x, Center.Y+y, Alpha);
  end;
end;

procedure FadeSmoothRectIn(var Matrix: TseMatrixFade; Width, Height: integer; Percent: byte);
var
  i,j: integer;
begin
  if Percent = 0 then
    exit;
  FadeSmoothRectOut (Matrix, Width, Height, 100-Percent);
  for i := 0 to Width-1 do
    for j := 0 to Height-1 do
      Matrix[i+j*Width] := $FF - Matrix[i+j*Width];
end;

{ Slide Ani ==================================================================}

procedure SetSlideMatrix(var Matrix: TseMatrixSlide; Width, Height: integer; x1,y1, x2, y2: integer; A: byte);
begin
  if (x1 < Width) and (x2 < Width) and (y2 < Height) and (y1 < Height) and (x1 >= 0) and (x2 >= 0) and (y1 >= 0) and (y2 >= 0) then
  begin
    with Matrix[y1 * Width + x1] do
    begin
      X := x2;
      Y := y2;
      Alpha := $FF
    end;
  end;
end;

{ SlideMatrix's Effects ======================================================}

procedure ProcSlideInterlace(var Matrix: TseMatrixSlide; Width, Height: integer; Percent: byte);
var
  i, j: integer;
begin
  { Slider - interlaced line moving }
  if Percent = 0 then Exit;

  for i := 0 to Width - 1 do
    for j := 0 to Height - 1 do
      with Matrix[j * Width + i] do
      begin
        Alpha := $FF; //MulDiv(Percent, $FF, 100);
        if j mod 2 = 0 then
          X := i + MulDiv(100-Percent, Width, 100)
        else
          X := i - MulDiv(100-Percent, Width, 100);
        Y := j;
      end;
end;

procedure ProcSlideCrushIn(var Matrix: TseMatrixSlide; Width, Height: integer; Percent: byte);
var
  i, j: integer;
  CenterX: integer;
begin
  { ZoomIn from Center line }
  if Percent = 0 then Exit;

  CenterX := Width div 2;

  for i := 0 to CenterX do
    for j := 0 to Height - 1 do
    begin
      with Matrix[j * Width + i] do
      begin
        Alpha := $FF; //MulDiv(Percent, $FF, 100);
        X := CenterX - Round((CenterX - i) / (Percent/100));
        Y := j;
      end;
      with Matrix[j * Width + i + (Width div 2)] do
      begin
        Alpha := $FF; //MulDiv(Percent, $FF, 100);
        X := CenterX + Round(i / (Percent/100));
        Y := j;
      end;
    end;
end;

procedure ProcSlideCorner(var Matrix: TseMatrixSlide; Width, Height: integer; Percent: byte);
var
  i, j: integer;
  dx, dy : integer;
begin
  if Percent = 0 then Exit;

{С угла}
  dx := MulDiv (Width-1, Percent, 100);
  dy := MulDiv (Height-1, Percent, 100);

  for i := 0 to dx do
    for j := 0 to dy do
      SetSlideMatrix(Matrix, Width, Height, i, j, Width - dx -1 + i, Height - dy - 1 + j, $FF);
end;

{ Manual proc =================================================================}

procedure ProcManualSlide(SourceImage, DestImage: TseBitmap; Animation: TseAnimationRec; Percent: byte);
var
  Pos: integer;
begin
  if Animation.Rotation = krNone then
  begin
    Pos := MulDiv(SourceImage.Width, Percent, 100);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, Pos - SourceImage.Width, 0);
  end;

  if Animation.Rotation = krRotate90 then
  begin
    Pos := MulDiv(SourceImage.Height, Percent, 100);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, 0, SourceImage.Height - Pos);
  end;

  if Animation.Rotation = krRotate180 then
  begin
    Pos := MulDiv(SourceImage.Width, Percent, 100);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, SourceImage.Width - Pos, 0);
  end;

  if Animation.Rotation = krRotate270 then
  begin
    Pos := MulDiv(SourceImage.Height, Percent, 100);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, 0, Pos - SourceImage.Height);
  end;
end;

procedure ProcManualSlideBack(SourceImage, DestImage: TseBitmap; Animation: TseAnimationRec; Percent: byte);
var
  Pos: integer;
  Buffer: TseBitmap;
begin
  Buffer := TseBitmap.Create;
  Buffer.Assign(DestImage);
  
  if Animation.Rotation = krNone then
  begin
    Pos := MulDiv(SourceImage.Width, Percent, 100);
    DestImage.AlphaBlend := true;
    SourceImage.Draw(Buffer, -Pos, 0);
    Buffer.Draw(SourceImage, 0, 0);
  end;

  if Animation.Rotation = krRotate90 then
  begin
    Pos := MulDiv(SourceImage.Height, Percent, 100);
    DestImage.AlphaBlend := true;
    SourceImage.Draw(Buffer, 0, -Pos);
    Buffer.Draw(SourceImage, 0, 0);
  end;

  if Animation.Rotation = krRotate180 then
  begin
    Pos := MulDiv(SourceImage.Width, Percent, 100);
    DestImage.AlphaBlend := true;
    SourceImage.Draw(Buffer, Pos, 0);
    Buffer.Draw(SourceImage, 0, 0);
  end;

  if Animation.Rotation = krRotate270 then
  begin
    Pos := MulDiv(SourceImage.Height, Percent, 100);
    DestImage.AlphaBlend := true;
    SourceImage.Draw(Buffer, 0, Pos);
    Buffer.Draw(SourceImage, 0, 0);
  end;

  Buffer.Free;
end;

procedure ProcManualPush(SourceImage, DestImage: TseBitmap; Animation: TseAnimationRec; Percent: byte);
var
  Pos: integer;
  TempImage: TseBitmap;
begin
  if Animation.Rotation = krNone then
  begin
    Pos := MulDiv(SourceImage.Width, Percent, 100);
    TempImage := TseBitmap.Create;
    TempImage.Assign(SourceImage);
    TempImage.Draw(SourceImage, Pos, 0);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, Pos - SourceImage.Width, 0);
    TempImage.Free;
  end;

  if Animation.Rotation = krRotate90 then
  begin
    Pos := MulDiv(SourceImage.Height, Percent, 100);
    SourceImage.Draw(SourceImage, 0, -Pos);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, 0, SourceImage.Height - Pos);
  end;

  if Animation.Rotation = krRotate180 then
  begin
    Pos := MulDiv(SourceImage.Width, Percent, 100);
    SourceImage.Draw(SourceImage, -Pos, 0);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, SourceImage.Width - Pos, 0);
  end;

  if Animation.Rotation = krRotate270 then
  begin
    Pos := MulDiv(SourceImage.Height, Percent, 100);
    TempImage := TseBitmap.Create;
    TempImage.Assign(SourceImage);
    TempImage.Draw(SourceImage, 0, Pos);
    DestImage.AlphaBlend := true;
    DestImage.Draw(SourceImage, 0, Pos - SourceImage.Height);
    TempImage.Free;
  end;
end;

type

  PIntArray = ^TIntArray;
  TIntArray = array [0..0] of integer;

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

procedure ProcManualBlur(SourceImage, DestImage: TseBitmap; Animation: TseAnimationRec; Percent: byte);
begin
  if Percent = 0 then Exit;
  SourceImage.Assign(DestImage);
  Blur(SourceImage, (100 - Percent) div 10);
end;

{ Effect list }

procedure BuildEffectList;
var
  i: integer;
begin
  EffectList := TStringList.Create;

  EffectList.Add(SRandomSelection);
  EffectList.Add(SBitmap);
  for i := 0 to ProcList.Count - 1 do
    EffectList.Add(TseProcItem(ProcList.Items[i]).Name);
end;

function GetEffectListComma: string;
begin
  if EffectList = nil then BuildEffectList;
  Result := EffectList.CommaText;
end;

function GetEffectList: TStrings; overload;
begin
  if EffectList = nil then BuildEffectList;
  Result := EffectList;
end;



{ TseTimer ====================================================================}

function RDTSC: Int64;
asm
  dw 310Fh
end;

{ TseTimer }

constructor TseTimer.Create;
begin
  inherited Create;
  CalibrateWindows;
  GetFrequency;
end;

function TseTimer.GetElapsed: Extended;
begin
  Result := (StopValue - StartValue - FCalibrate) / FFrequency;
end;

function TseTimer.GetFrequency: Int64;
begin
  QueryPerformanceFrequency(FFrequency);
  Result:= FFrequency;
end;

procedure TseTimer.CalibrateWindows;
begin
  QueryPerformanceCounter(StartValue);
  QueryPerformanceCounter(StopValue);
  FCalibrate:= StopValue - StartValue;
end;

procedure TseTimer.Start;
begin
  QueryPerformanceCounter(StartValue);
end;

procedure TseTimer.Stop;
begin
  QueryPerformanceCounter(StopValue);
end;

{ Timer Routines ==============================================================}

procedure StartTimer(var Timer: TseTimer);
begin
  if Timer = nil then
    Timer := TseTimer.Create;

  Timer.Start;
end;

function StopTimer(var Timer: TseTimer): Single;
begin
  Result := 0.0;
  if Timer <> nil then
  begin
    Timer.Stop;
    Result := Timer.Elapsed;
  end;
end;

function StopAndFreeTimer(var Timer: TseTimer): Single;
begin
  Result := 0.0;
  if Timer <> nil then
  begin
    Timer.Stop;
    Result := Timer.Elapsed;
    Timer.Free;
    Timer := nil;
  end;
end;



{ TseAnimationRec ================================================================}

constructor TseAnimationRec.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap := TBitmap.Create;
  FEnabled := false;
  FTime := 400;
  FResolution := 1;
  FTileCount := 1;
  FEffect := SRandomSelection;
  FRotation := krNone;
end;

destructor TseAnimationRec.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TseAnimationRec.Assign(Source: TPersistent);
begin
  if Source is TseAnimationRec then
  begin
    FBitmap.Assign(TseAnimationRec(Source).Bitmap);
    FEnabled := TseAnimationRec(Source).Enabled;
    FTime := TseAnimationRec(Source).Time;
    FResolution := TseAnimationRec(Source).Resolution;
    FTileCount := TseAnimationRec(Source).TileCount;
    FEffect := TseAnimationRec(Source).Effect;
    FRotation := TseAnimationRec(Source).Rotation;
  end
  else
    inherited ;
end;

procedure TseAnimationRec.SetResolution(const Value: integer);
begin
  if FResolution <> Value then
  begin
    FResolution := Value;

    if FResolution < 1 then FResolution := 1;
    if FResolution > 10 then FResolution := 10;
  end;
end;

procedure TseAnimationRec.SetTileCount(const Value: integer);
begin
  if FTileCount <> Value then
  begin
    FTileCount := Value;

    if FTileCount < 1 then FTileCount := 1;
    if FTileCount > 20 then FTileCount := 20;
  end;
end;

procedure TseAnimationRec.SetTime(const Value: integer);
begin
  if FTime <> Value then
  begin
    FTime := Value;

    if FTime <= 50 then FTime := 50;
    if Ftime > 9000 then FTime := 9000;
  end;
end;

procedure TseAnimationRec.SetBitmap(const Value: TBitmap);
begin
  FBitmap.Assign(Value);
end;




initialization
  RegisterClass(TseAnimationRec);

  Randomize;

  FillChar(MultiAniArray, SizeOf(MultiAniArray), 0);
  MultiObject := TseMultiObject.Create;
  MultiTimer := TTimer.Create(nil);
  MultiTimer.OnTimer := MultiObject.DoMultiTimer;
  MultiTimer.Interval := TimerInterval;
  MultiTimer.Enabled := false;

  { Register ProcFade }
  RegisterProc('SmoothDiagonal', pkFade, TseProc(@FadeSmoothDiagonal));
  RegisterProc('SmoothDiagonalIn', pkFade, TseProc(@FadeSmoothDiagonalIn));
  RegisterProc('SmoothDiagonalOut', pkFade, TseProc(@FadeSmoothDiagonalOut));
  RegisterProc('SmoothDown', pkFade, TseProc(@FadeSmoothDown));
  RegisterProc('SmoothIn', pkFade, TseProc(@FadeSmoothIn));
  RegisterProc('SmoothOut', pkFade, TseProc(@FadeSmoothOut));
  RegisterProc('SmoothCrossOut', pkFade, TseProc(@FadeSmoothCrossOut));
  RegisterProc('SmoothCrossIn', pkFade, TseProc(@FadeSmoothCrossIn));
  RegisterProc('SmoothRectIn', pkFade, TseProc(@FadeSmoothRectIn));
  RegisterProc('SmoothRectOut', pkFade, TseProc(@FadeSmoothRectOut));

  RegisterProc('SlideDiagonal', pkFade, TseProc(@FadeSlideDiagonal));
  RegisterProc('SlideDiagonalIn', pkFade, TseProc(@FadeSlideDiagonalIn));
  RegisterProc('SlideDiagonalOut', pkFade, TseProc(@FadeSlideDiagonalOut));
  RegisterProc('SlideDown', pkFade, TseProc(@FadeSlideDown));
  RegisterProc('SlideIn', pkFade, TseProc(@FadeSlideIn));
  RegisterProc('SlideOut', pkFade, TseProc(@FadeSlideOut));
  RegisterProc('SlideCrossOut', pkFade, TseProc(@FadeSlideCrossOut));
  RegisterProc('SlideCrossIn', pkFade, TseProc(@FadeSlideCrossIn));
  RegisterProc('SlideRectOut', pkFade, TseProc(@FadeSlideRectOut));
  RegisterProc('SlideRectIn', pkFade, TseProc(@FadeSlideRectIn));

  RegisterProc('Fade', pkFade, TseProc(@FadeMatrixFade));
  RegisterProc('FadeDiagonal', pkFade, TseProc(@FadeMatrixDiagonal));
  RegisterProc('FadeDiagonalIn', pkFade, TseProc(@FadeMatrixDiagonalIn));
  RegisterProc('FadeDiagonalOut', pkFade, TseProc(@FadeMatrixDiagonalOut));
  RegisterProc('FadeDown', pkFade, TseProc(@FadeMatrixDown));
  RegisterProc('FadeIn', pkFade, TseProc(@FadeMatrixIn));
  RegisterProc('FadeOut', pkFade, TseProc(@FadeMatrixOut));
  RegisterProc('FadeCrossOut', pkFade, TseProc(@FadeMatrixCrossOut));
  RegisterProc('FadeCrossIn', pkFade, TseProc(@FadeMatrixCrossIn));
  RegisterProc('FadeRectOut', pkFade, TseProc(@FadeMatrixRectOut));
  RegisterProc('FadeRectIn', pkFade, TseProc(@FadeMatrixRectIn));

  RegisterProc('Pixel', pkFade, TseProc(@FadeMatrixPixel));
  RegisterProc('Pixel fade', pkFade, TseProc(@FadeMatrixPixelFade));
  RegisterProc('Pixel line', pkFade, TseProc(@FadeMatrixPixelLine));

  RegisterProc('CircleSlideOut', pkFade, TseProc(@FadeCircleSlideOut));
  RegisterProc('CircleFadeOut', pkFade, TseProc(@FadeCircleFadeOut));
  RegisterProc('CircleSmoothOut', pkFade, TseProc(@FadeCircleSmoothOut));
  RegisterProc('CircleSlideIn', pkFade, TseProc(@FadeCircleSlideIn));
  RegisterProc('CircleFadeIn', pkFade, TseProc(@FadeCircleFadeIn));
  RegisterProc('CircleSmoothIn', pkFade, TseProc(@FadeCircleSmoothIn));
  RegisterProc('CircleSlide', pkFade, TseProc(@FadeCircleSlide));
  RegisterProc('CircleFade', pkFade, TseProc(@FadeCircleFade));
  RegisterProc('CircleSmooth', pkFade, TseProc(@FadeCircleSmooth));

  RegisterProc('DiamondSlideIn', pkFade, TseProc(@FadeDiamondSlideIn));
  RegisterProc('DiamondFadeIn', pkFade, TseProc(@FadeDiamondFadeIn));
  RegisterProc('DiamondSmoothIn', pkFade, TseProc(@FadeDiamondSmoothIn));
  RegisterProc('DiamondSlideOut', pkFade, TseProc(@FadeDiamondSlideOut));
  RegisterProc('DiamondFadeOut', pkFade, TseProc(@FadeDiamondFadeOut));
  RegisterProc('DiamondSmoothOut', pkFade, TseProc(@FadeDiamondSmoothOut));

  RegisterProc('RotateSlide', pkFade, TseProc(@FadeRotateSlide));
  RegisterProc('RotateFade', pkFade, TseProc(@FadeRotateFade));
  RegisterProc('RotateSmooth', pkFade, TseProc(@FadeRotateSmooth));

  RegisterProc('Stream', pkFade, TseProc(@FadeStream));
  RegisterProc('Plasma', pkFade, TseProc(@FadePlasma));

  { Register ProcSlide }
  RegisterProc('Interlace', pkSlide, TseProc(@ProcSlideInterlace));
  RegisterProc('Corner', pkSlide, TseProc(@ProcSlideCorner));

  { Resigter Manual }
  RegisterProc('Slide', pkManual, TseProc(@ProcManualSlide));
  RegisterProc('Push', pkManual, TseProc(@ProcManualPush));
  RegisterProc('Blur', pkManual, TseProc(@ProcManualBlur));
  RegisterProc('SlideBack', pkManual, TseProc(@ProcManualSlideBack));


  { Build list }
  BuildEffectList;

finalization
  MultiTimer.Free;
  MultiObject.Free;

  if EffectList <> nil then EffectList.Free;
  EffectList := nil;
  if ProcList <> nil then ProcList.Free;
  ProcList := nil;

end.
