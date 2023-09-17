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

unit se_bitmap;

{$I se_define.inc}
{$O+}
{$R-}
{$Q-}

{$WARNINGS OFF}
{$HINTS OFF}

interface

uses SysUtils, Classes, Windows, Graphics, Math, Clipbrd, se_winapi;

type

  { Color type }

  PseColor = ^TseColor;
  TseColor = type cardinal;

  PseColorRec = ^TseColorRec;
  TseColorRec = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (B, G, R, A: Byte);
    end;

  PseColorRecBor = ^TseColorRecBor;
  TseColorRecBor = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (R, G, B, A: Byte);
    end;

  PseColorArray = ^TseColorArray;
  TseColorArray = array [0..0] of TseColor;

  PseColorRecArray = ^TseColorRecArray;
  TseColorRecArray = array [0..0] of TseColorRec;

  TArrayOfseColor = array of TseColor;

const

  seTransparent         = $007F007F;
  AlphaMask              = $FF000000;

  seBlack               : TseColor = $FF000000;
  seGray                : TseColor = $FF7F7F7F;
  seWhite               : TseColor = $FFFFFFFF;
  seMaroon              : TseColor = $FF7F0000;
  seGreen               : TseColor = $FF007F00;
  seOlive               : TseColor = $FF7F7F00;
  seNavy                : TseColor = $FF00007F;
  sePurple              : TseColor = $FF7F007F;
  seTeal                : TseColor = $FF007F7F;
  seRed                 : TseColor = $FFFF0000;
  seLime                : TseColor = $FF00FF00;
  seYellow              : TseColor = $FFFFFF00;
  seBlue                : TseColor = $FF0000FF;
  seFuchsia             : TseColor = $FFFF00FF;
  seAqua                : TseColor = $FF00FFFF;

  seMenu                : TseColor = $FFEDEDEE;
  seBorder              : TseColor = $FF003399;
  seWindow              : TseColor = $FFEBEBEE;
  seBtnFace             : TseColor = $FFD2D2D2;
  seBtnShadow           : TseColor = $FFA8A8A8;
  seHotHighlight        : TseColor = $FFF8C751;
  seHighlight           : TseColor = $FF64A0FF;
  seHintBack            : TseColor = $FFEBEBEE;
  seNone                : TseColor = $33333333;

  seTransparentVar	 : TseColor = seTransparent;

type

  TseBitmapLink = class;

{ TseBitmap the main class }

  TseBitmap = class(TPersistent)
  private
    FBits: PseColorArray;
    FWidth, FHeight: integer;
    FName: string;
    FBitmapInfo: TBitmapInfo;
    FHandle: HBITMAP;
    FDC: HDC;
    FCanvas: TCanvas;
    FAlphaBlend: boolean;
    FTransparent: boolean;
    FNewFormat: boolean;
    function  GetPixel(X, Y: Integer): TseColor;
    procedure SetPixel(X, Y: Integer; Value: TseColor);
    function GetPixelPtr(X, Y: Integer): PseColor;
    function GetScanLine(Y: Integer): PseColorArray;
    function GetCanvas: TCanvas;
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure CheckRGBA;
    { }
    procedure SetSize(AWidth, AHeight: Integer);
    procedure Clear(Color: TseColor);
    function Empty: boolean;
    { I/O }
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromPcxStream(Stream: TStream);
    procedure LoadFromResource(const ResFileName, ResName: string);
    { BitmapLink }
    function GetBitmapLink(Rect: TRect): TseBitmapLink; overload;
    function GetBitmapLink(Rect: string): TseBitmapLink; overload;
    { Checking }
    procedure CheckingTransparent(Color: TseColor = seTransparent); overload;
    procedure CheckingTransparent(ARect: TRect; Color: TseColor = seTransparent); overload;
    procedure CheckingAlphaBlend; overload;
    procedure CheckingAlphaBlend(ARect: TRect); overload;
    procedure SetAlpha(Alpha: byte); overload;
    procedure SetAlpha(Alpha: byte; Rect: TRect); overload;
    { Color transition }
    procedure SetBitmapHue(Hue: integer);
    procedure ChangeBitmapSat(DeltaSat: integer);
    procedure ChangeBitmapHue(DeltaHue: integer);
    procedure ChangeBitmapBrightness(DeltaBrightness: integer);
    { Manipulation }
    procedure FlipVert;
    procedure Reflection;
    procedure Reflection2;
    procedure Reflection3;
    { Paint routines }
    procedure MoveTo(X, Y: integer);
    procedure LineTo(X, Y: integer; Color: TseColor);
    procedure DrawGraphic(Graphic: TGraphic; DstRect: TRect);
    procedure FillRect(R: TRect; Color: TseColor);
    procedure FillRoundRect(R: TRect; Radius: integer; Color: TseColor);
    procedure FillHalftoneRect(R: TRect; Color, HalfColor: TseColor);
    procedure FillGradientRect(Rect: TRect; BeginColor, EndColor: TseColor; Vertical: boolean);
    procedure FillRadialGradientRect(Rect: TRect; BeginColor, EndColor: TseColor; Pos: TPoint);
    procedure FillEllipse(R: TRect; Color: TseColor);
    procedure FillPolygon(Points: array of TPoint; Color: TColor);
    procedure FillHalftonePolygon(Points: array of TPoint; Color, HalfColor: TseColor);
    procedure DrawEdge(R: TRect; RaisedColor, SunkenColor: TseColor);
    procedure DrawBevel(R: TRect; Color: TseColor; Width: integer; Down: boolean);
    procedure DrawRect(R: TRect; Color: TseColor);
    procedure DrawFocusRect(R: TRect; Color: TseColor);
    procedure DrawRoundRect(R: TRect; Radius: integer; Color: TseColor);
    procedure DrawLine(R: TRect; Color: TseColor);
    procedure DrawEllipse(R: TRect; Color: TseColor);
    procedure DrawPolygon(Points: array of TPoint; Color: TColor);
    function DrawText(AText: WideString; var Bounds: TRect; Flag: cardinal): integer; overload;
    function DrawText(AText: WideString; X, Y: integer): integer; overload;
    function DrawVerticalText(AText: WideString; Bounds: TRect; Flag: cardinal; FromTop: boolean): integer;
    function TextWidth(AText: WideString; Flags: Integer = 0): integer;
    function TextHeight(AText: WideString): integer;
    { Draw to Canvas }
    procedure Draw(DC: HDC; X, Y: integer); overload;
    procedure Draw(DC: HDC; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(DC: HDC; DstRect: TRect); overload;
    procedure Draw(DC: HDC; DstRect, SrcRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer); overload;
    procedure Draw(Canvas: TCanvas; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; DstRect: TRect); overload;
    procedure Draw(Canvas: TCanvas; DstRect, SrcRect: TRect); overload;
    { Draw to TseBitmap }
    procedure Draw(Bitmap: TseBitmap; X, Y: integer); overload;
    procedure Draw(Bitmap: TseBitmap; X, Y: integer; SrcRect: TRect); overload;
    procedure Draw(Bitmap: TseBitmap; DstRect: TRect); overload;
    procedure Draw(Bitmap: TseBitmap; DstRect, SrcRect: TRect); overload;
    { Complex Draw }
    procedure Tile(DC: HDC; DstRect, SrcRect: TRect); overload;
    procedure Tile(Canvas: TCanvas; DstRect, SrcRect: TRect); overload;
    procedure Tile(Bitmap: TseBitmap; DstRect, SrcRect: TRect); overload;
    procedure TileClip(DC: HDC; DstRect, DstClip, SrcRect: TRect); overload;
    procedure TileClip(Canvas: TCanvas; DstRect, DstClip, SrcRect: TRect); overload;
    procedure TileClip(Bitmap: TseBitmap; DstRect, DstClip, SrcRect: TRect); overload;
    { Alpha blend two bitmap }
    procedure MergeDraw(Bitmap: TseBitmap; X, Y: integer; SrcRect: TRect);
    { Low-level access}
    property Handle: HBITMAP read FHandle;
    property DC: HDC read FDC;
    property Canvas: TCanvas read GetCanvas;
    { Access properties }
    property Bits: PseColorArray read FBits;
    property Pixels[X, Y: Integer]: TseColor read GetPixel write SetPixel; default;
    property PixelPtr[X, Y: Integer]: PseColor read GetPixelPtr;
    property ScanLine[Y: Integer]: PseColorArray read GetScanLine;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
    { States }
    property AlphaBlend: boolean read FAlphaBlend write FAlphaBlend;
    property Transparent: boolean read FTransparent write FTransparent;
    { Persitent properties }
    property Name: string read FName write FName;
    property NewFormat: boolean read FNewFormat write FNewFormat;
  published
  end;

{ TseBitmapLink }

  TseBitmapLink = class(TPersistent)
  private
    FImage: TseBitmap;
    FRect: TRect;
    FName: string;
    FMaskedBorder: boolean;
    FMaskedAngles: boolean;
    FMasked: boolean;
    function GetBottom: integer;
    function GetLeft: integer;
    function GetRight: integer;
    function GetTop: integer;
    procedure SetBottom(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetRight(const Value: integer);
    procedure SetTop(const Value: integer);
    function GetAssigned: boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    procedure CheckingMasked; overload;
    procedure CheckingMasked(Margin: TRect); overload;

    procedure Draw(Canvas: TCanvas; X, Y: integer); overload;
    procedure Draw(Bitmap: TseBitmap; X, Y: integer); overload;

    property Assigned: boolean read GetAssigned;
    property Image: TseBitmap read FImage write FImage;
    property Rect: TRect read FRect write FRect;
    property Masked: boolean read FMasked write FMasked;
    property MaskedBorder: boolean read FMaskedBorder write FMaskedBorder;
    property MaskedAngles: boolean read FMaskedAngles write FMaskedAngles;
  published
    property Name: string read FName write FName;
    property Left: integer read GetLeft write SetLeft;
    property Top: integer read GetTop write SetTop;
    property Right: integer read GetRight write SetRight;
    property Bottom: integer read GetBottom write SetBottom;
  end;

{ TseBitmapList }

  TseBitmapList = class(TList)
  private
    function GetImage(index: integer): TseBitmap;
    function GetBitmapByName(index: string): TseBitmap;
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Clear; override;

    function GetBitmapLink(Image: TseBitmap; Rect: TRect): TseBitmapLink; overload;
    function GetBitmapLink(Name: string; Rect: TRect): TseBitmapLink; overload;
    function GetBitmapLink(Name, Rect: string): TseBitmapLink; overload;

    property Bitmaps[index: integer]: TseBitmap read GetImage; default;
    property BitmapByName[index: string]: TseBitmap read GetBitmapByName;
  end;

{ Color functions }

function seColor(Color: TColor; A: Byte = $FF): TseColor; overload;
function seColor(R, G, B: SmallInt; A: Byte = $FF): TseColor; overload;
function seColor(ColorRec: TseColorRec): TseColor; overload;

function seColorToColor(Color: TseColor): TColor;

function seColorToColor16(Color: TseColor): word; // 16-bit, 5-6-5
function seColorToColor15(Color: TseColor): word; // 15-bit, 5-5-5

function ChangeColor(Color: TseColor; Dr, Dg, Db: smallint; Da: smallint = 0): TseColor; overload;
function ChangeColor(Color: TseColor; Dx: smallint): TseColor; overload;
function StdChangeColor(Color: TColor; Dr, Dg, Db: smallint; Da: smallint = 0): TColor; overload;
function StdChangeColor(Color: TColor; Dx: smallint): TColor; overload;

function SunkenColor(Color: TseColor; Dr, Dg, Db: smallint; Da: smallint = 0): TseColor; overload;
function SunkenColor(Color: TseColor; Dx: smallint): TseColor; overload;
function RaisedColor(Color: TseColor; Dr, Dg, Db: smallint; Da: smallint = 0): TseColor; overload;
function RaisedColor(Color: TseColor; Dx: smallint): TseColor; overload;

function HSLtoRGB(H, S, L: Single): TseColor;
procedure RGBtoHSL(RGB: TseColor; out H, S, L: single);

function SetHue(Color: TseColor; Hue: integer): TseColor;
function ChangeSat(Color: TseColor; DeltaSat: integer): TseColor;
function ChangeHue(Color: TseColor; DeltaHue: integer): TseColor;
function ChangeBrightness(Color: TseColor; DeltaBrightness: integer): TseColor;

const

  EnableDibOperation: boolean = true; // Use dib routines from DC


{ Function prototypes }

type
  TseAlphaBlendPixel = function (Src, Dst: TseColor): TseColor;
  TseAlphaBlendLine = procedure (Src, Dst: PseColor; Count: Integer);
  TseTransparentLine = procedure (Src, Dst: PseColor; Count: Integer);

  TseMoveLongword = procedure (const Src: Pointer; Dst: Pointer; Count: Integer);

  TseFillLongword = procedure (Src: Pointer; Count: integer; Value: longword);
  TseFillLongwordRect = procedure (Src: Pointer; W, H, X1, Y1, X2, Y2: integer;
    Value: longword);

  TseFillAlpha = procedure (Src: Pointer; Count: integer; Alpha: byte);
  TseFillAlphaRect = procedure (Src: Pointer; W, H, X1, Y1, X2, Y2: integer; Alpha: byte);

  TseClearAlpha = procedure (Src: Pointer; Count: integer; Value: longword);

{ Function variables }

var
  PixelAlphaBlendFunc: TseAlphaBlendPixel;
  LineAlphaBlendFunc: TseAlphaBlendLine;
  LineTransparentFunc: TseTransparentLine;

  MoveLongwordFunc: TseMoveLongword;
  FillLongwordFunc: TseFillLongword;
  FillLongwordRectFunc: TseFillLongwordRect;

  FillAlphaFunc: TseFillAlpha;
  FillAlphaRectFunc: TseFillAlphaRect;

  ClearAlphaFunc: TseClearAlpha;

function MulDiv16(Number, Numerator, Denominator: Word): Word;

function FromRGB(Color: longword): longword;
function ToRGB(Color32: longword): longword;
procedure Blur(const Bitmap: TseBitmap; const Radius: integer);


{ Function prototypes }

type
  TseStretchToDCOpaque = procedure (DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
  TseStretchToDCTransparent = procedure(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
  TseStretchToDCAlphaBlend = procedure (DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
    SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);

  TseStretchToDibOpaque = procedure (Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TseBitmap; SrcRect: TRect);
  TseStretchToDibTransparent = procedure(Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TseBitmap; SrcRect: TRect);
  TseStretchToDibAlphaBlend = procedure (Bits: Pointer; DstRect, DstClip: TRect;
    BitsW, BitsH: integer; Src: TseBitmap; SrcRect: TRect);

  TseStretchOpaque = procedure(Dst: TseBitmap; DstRect, DstClip: TRect; Src: TseBitmap;
    SrcRect: TRect);
  TseStretchTransparent = procedure(Dst: TseBitmap; DstRect, DstClip: TRect; Src: TseBitmap;
    SrcRect: TRect);
  TseStretchAlphaBlend = procedure(Dst: TseBitmap; DstRect, DstClip: TRect; Src: TseBitmap;
    SrcRect: TRect);

  TseBltOpaque = procedure(Dst: TseBitmap; DstRect: TRect; Src: TseBitmap;
    SrcX, SrcY: Integer);
  TseBltTransparent = procedure(Dst: TseBitmap; DstRect: TRect; Src: TseBitmap;
    SrcX, SrcY: Integer);
  TseBltAlphaBlend = procedure(Dst: TseBitmap; DstRect: TRect; Src: TseBitmap;
    SrcX, SrcY: Integer);

  TseGetBitsFromDC = function(DC: HDC; var Width, Height, BitCount: integer): Pointer;

{ Function variables }

var
  { DC }
  StretchToDCOpaqueFunc: TseStretchToDCOpaque;
  StretchToDCAlphaBlendFunc: TseStretchToDCAlphaBlend;
  StretchToDCTransparentFunc: TseStretchToDCTransparent;
  { Dib }
  GetBitsFromDCFunc: TseGetBitsFromDC;
  StretchToDibOpaqueFunc: TseStretchToDibOpaque;
  StretchToDibAlphaBlendFunc: TseStretchToDibAlphaBlend;
  StretchToDibTransparentFunc: TseStretchToDibTransparent;
  { seBitmap }
  BltOpaqueFunc: TseBltOpaque;
  BltAlphaBlendFunc: TseBltAlphaBlend;
  BltTransparentFunc: TseBltTransparent;
  StretchOpaqueFunc: TseStretchOpaque;
  StretchAlphaBlendFunc: TseStretchAlphaBlend;
  StretchTransparentFunc: TseStretchTransparent;


implementation {===============================================================}

uses se_utils;

type
  TGraphicAccess = class(TGraphic);

  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

//To test the hashing implementatiotn, you should define "USE_HASH" in te_define.inc
{.$DEFINE USE_HASH}
{$IFDEF USE_HASH}

  { TStringHash }

  PPHashItem = ^PHashItem;
  PHashItem = ^THashItem;
  THashItem = record
    Next: PHashItem;
    Key: Cardinal;
    Value: Integer;
  end;

  { Based on TStringHash class by Borland }

  TIntegerHash = class
  private
    Buckets: array of PHashItem;
  protected
    function Find(const Key: Cardinal): PPHashItem;
    function HashOfInteger(const Key: Cardinal): Cardinal;
  public
    constructor Create(Size: Cardinal = 256);
    destructor Destroy; override;
    procedure Add(const Key: Cardinal; Value: Integer);
    procedure Clear;
    function ValueOf(const Key: Cardinal): Integer;
  end;

  { TFasterHashedStringList - A TStringList that uses TIntegerHash to improve the
    speed of Find. Based on Borland's implementation. }
  TFasterHashedStringList = class(TStringList)
  private
    FValueHash: TIntegerHash;
    FValueHashValid: Boolean;
    procedure UpdateValueHash;
  protected
    procedure Changed; override;
  public
    destructor Destroy; override;
    function IndexOfDC(const DC: Cardinal): Integer;
  end;

const
  BitmapList: TFasterHashedStringList = nil;

{ TIntegerHash }

procedure TIntegerHash.Add(const Key: Cardinal; Value: Integer);
var
  Hash: Integer;
  Bucket: PHashItem;
begin
  Hash := HashOfInteger(Key) mod Cardinal(Length(Buckets));
  New(Bucket);
  Bucket^.Key := Key;
  Bucket^.Value := Value;
  Bucket^.Next := Buckets[Hash];
  Buckets[Hash] := Bucket;
end;

procedure TIntegerHash.Clear;
var
  I: Integer;
  P, N: PHashItem;
begin
  for I := 0 to Length(Buckets) - 1 do
  begin
    P := Buckets[I];
    while P <> nil do
    begin
      N := P^.Next;
      Dispose(P);
      P := N;
    end;
    Buckets[I] := nil;
  end;
end;

constructor TIntegerHash.Create(Size: Cardinal);
begin
  inherited Create;
  SetLength(Buckets, Size);
end;

destructor TIntegerHash.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TIntegerHash.Find(const Key: Cardinal): PPHashItem;
var
  Hash: Integer;
begin
  Hash := HashOfInteger(Key) mod Cardinal(Length(Buckets));
  Result := @Buckets[Hash];
  while Result^ <> nil do
  begin
    if Result^.Key = Key then
      Exit
    else
      Result := @Result^.Next;
  end;
end;

function TIntegerHash.HashOfInteger(const Key: Cardinal): Cardinal;
type
  TBuffer = array[0..0] of Cardinal;
  PBuffer = ^TBuffer;
var
  P: PBuffer;
  h: Cardinal;
begin
  // start with a good "random" bit pattern so that
  // even single byte hashes are well scattered over
  // a 32-bit range
  Result := $9E3779B9;
  P := @Key;

  h := P[0];
  Inc(Result, ($9E3779B9 * h));

  // i.e. rotate the Result bit-pattern to the right to keep
  // early bits in the key from getting completely lost
  Result := (Result shr 15) or (Result shl 17);
end;

function TIntegerHash.ValueOf(const Key: Cardinal): Integer;
var
  P: PHashItem;
begin
  P := Find(Key)^;
  if P <> nil then
    Result := P^.Value
  else
    Result := -1;
end;

{ TFasterHashedStringList }

procedure TFasterHashedStringList.Changed;
begin
  inherited Changed;
  FValueHashValid := False;
end;

destructor TFasterHashedStringList.Destroy;
begin
  FValueHash.Free;
  inherited Destroy;
end;

function TFasterHashedStringList.IndexOfDC(const DC: Cardinal): Integer;
begin
   UpdateValueHash;
   Result := FValueHash.ValueOf(DC);
end;

function FastIntToStr(I: LongWord): string;
begin
  Str(I, result);
end;

function StrToCardinal(const S: string): Cardinal;
var
  I,L: Word;
begin
  I := 1;
  Result := 0;
  L:= Length(s);
  while I <= L do
  begin
    Result := Result * 10 + Ord(s[I]) - Ord('0');
    Inc(I);
  end;
end;

procedure TFasterHashedStringList.UpdateValueHash;
var
  I: Integer;
begin
  if FValueHashValid then Exit;

  if FValueHash = nil then
    FValueHash := TIntegerHash.Create
  else
    FValueHash.Clear;
  for I := 0 to Count - 1 do
    FValueHash.Add(StrToCardinal(Self[I]), I);
  FValueHashValid := True;
end;

{ BitmapList Routines }

procedure AddBitmapToList(B: TseBitmap);
begin
  if BitmapList = nil then
  begin
    BitmapList := TFasterHashedStringList.Create;
    {$IFDEF KS_COMPILER6_UP}
    BitmapList.CaseSensitive := true; // Faster acces
    {$ENDIF}
  end;
  BitmapList.AddObject(FastIntToStr(B.DC),B); //Search based on DC
end;

procedure RemoveBitmapFromList(B: TseBitmap);
var Index: Integer;
begin
  if BitmapList <> nil then
  begin
    Index := BitmapList.IndexOfDC(B.DC);
    if Index <> -1 then
      BitmapList.Delete(Index);
  end;
end;

function FindBitmapByDC(DC: HDC): TseBitmap;
var
  i: integer;
begin
  i:= BitmapList.IndexOfDC(DC);
  if i <> -1 then
    Result := TseBitmap(BitmapList.Objects[i])
  else
    Result := nil;
end;

procedure FreeBitmapList;
begin
  if BitmapList <> nil then FreeAndNil(BitmapList);
end;

{$ELSE }

const
  BitmapList: TList = nil;

{ BitmapList Routines }

procedure AddBitmapToList(B: TseBitmap);
begin
  if BitmapList = nil then BitmapList := TList.Create;
  BitmapList.Add(B);
end;

procedure RemoveBitmapFromList(B: TseBitmap);
begin
  if BitmapList <> nil then
    BitmapList.Remove(B);
end;

function FindBitmapByDC(DC: HDC): TseBitmap;
var
  i: integer;
begin
  for i := 0 to BitmapList.Count - 1 do
    if TseBitmap(BitmapList[i]).DC = DC then
    begin
      Result := TseBitmap(BitmapList[i]);
      Exit;
    end;
  Result := nil;
end;

procedure FreeBitmapList;
begin
  if BitmapList <> nil then FreeAndNil(BitmapList);
end;

{$ENDIF}

{ Color function }

function seColor(Color: TColor; A: Byte = $FF): TseColor;
var
  C: TColor;
  Tmp: cardinal;
begin
  C := ColorToRGB(Color);
  Tmp := A;
  Result := FromRGB(C) + (Tmp shl 24);
end;

function seColor(R, G, B: SmallInt; A: Byte = $FF): TseColor;
begin
  if R > $FF then R := $FF;
  if G > $FF then G := $FF;
  if B > $FF then B := $FF;
  if R < 0 then R := 0;
  if G < 0 then G := 0;
  if B < 0 then B := 0;

  TseColorRec(Result).R := R;
  TseColorRec(Result).G := G;
  TseColorRec(Result).B := B;
  TseColorRec(Result).A := A;
end;

function seColor(ColorRec: TseColorRec): TseColor;
begin
  Result := ToRGB(Longword(ColorRec));
end;

function seColorToColor(Color: TseColor): TColor;
begin
  Result := ToRGB(Color);
end;

function seColorToColor16(Color: TseColor): word; // 16-bit, 5-6-5
begin
  with TseColorRec(Color) do
    Result :=
      (R shr 3 shl 11) or  // R-5bit
      (G shr 2 shl 5) or   // G-6bit
      (B shr 3);           // B-5bit
end;

function seColorToColor15(Color: TseColor): word; // 15-bit, 5-5-5
begin
  with TseColorRec(Color) do
    Result :=
      (R shr 3 shl 10) or  // R-5bit
      (G shr 3 shl 5) or   // G-5bit
      (B shr 3);           // B-5bit
end;

{ Color space conversions }

{$Q-}
function HSLtoRGB(H, S, L: Single): TseColor;
var
  M1, M2: Single;
  R, G, B: Byte;

  function HueToColor(Hue: Single): Byte;
  var
    V: Double;
  begin
    Hue := Hue - Floor(Hue);

    if 6 * Hue < 1 then V := M1 + (M2 - M1) * Hue * 6
    else if 2 * Hue < 1 then V := M2
    else if 3 * Hue < 2 then V := M1 + (M2 - M1) * (2 / 3 - Hue) * 6
    else V := M1;
    Result := Round(255 * V);
  end;
begin
  if S = 0 then
  begin
    R := Round(255 * L);
    G := R;
    B := R;
  end
  else
  begin
    if L <= 0.5 then M2 := L * (1 + S)
    else M2 := L + S - L * S;
    M1 := 2 * L - M2;
    R := HueToColor(H + 1 / 3);
    G := HueToColor(H);
    B := HueToColor(H - 1 / 3)
  end;
  Result := seColor(R, G, B);
end;

procedure RGBtoHSL(RGB: TseColor; out H, S, L: single);
var
  R, G, B, D, Cmax, Cmin: Single;
begin
  R := TseColorRec(RGB).R / 255;
  G := TseColorRec(RGB).G / 255;
  B := TseColorRec(RGB).B / 255;
  Cmax := Max(R, Max(G, B));
  Cmin := Min(R, Min(G, B));
  L := (Cmax + Cmin) / 2;

  if Cmax = Cmin then
  begin
    H := 0;
    S := 0
  end
  else
  begin
    D := Cmax - Cmin;
    if L < 0.5 then S := D / (Cmax + Cmin)
    else S := D / (2 - Cmax - Cmin);
    if R = Cmax then H := (G - B) / D
    else
      if G = Cmax then H  := 2 + (B - R) /D
      else H := 4 + (R - G) / D;
    H := H / 6;
    if H < 0 then H := H + 1
  end;
end;

function SetHue(Color: TseColor; Hue: integer): TseColor;
var
  H, S, L: single;
  HValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  if Hue > $FF then Hue := $Ff;
  if Hue < 0 then Hue := 0;

  Result := HSLtoRGB(Hue / 255, S, L);
end;

function ChangeSat(Color: TseColor; DeltaSat: integer): TseColor;
var
  H, S, L: single;
  SValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  SValue := Round(S * 255);
  Inc(SValue, DeltaSat);

  if SValue > $FF then SValue := SValue - $FF;
  if SValue < 0 then SValue := $FF + SValue;

  Result := HSLtoRGB(H, SValue / $FF, L);
end;

function ChangeHue(Color: TseColor; DeltaHue: integer): TseColor;
var
  H, S, L: single;
  HValue: integer;
begin
  RGBtoHSL(Color, H, S, L);

  HValue := Round(H * 255);
  Inc(HValue, DeltaHue);

  if HValue > 255 then HValue := HValue - 255;
  if HValue < 0 then HValue := 255 + HValue;

  Result := HSLtoRGB(HValue / 255, S, L);
end;

function ChangeBrightness(Color: TseColor; DeltaBrightness: integer): TseColor;
var
  R, G, B: integer;
begin
  R := TseColorRec(Color).R;
  G := TseColorRec(Color).G;
  B := TseColorRec(Color).B;

  Inc(R, DeltaBrightness);
  Inc(G, DeltaBrightness);
  Inc(B, DeltaBrightness);

  Result := seColor(R, G, B);
end;

function ChangeColor(Color: TseColor; Dr, Dg, Db: smallint; Da: smallint = 0): TseColor; overload;
begin
  with TseColorRec(Color) do
    Result := seColor(R + DR, G + DG, B + DB, A + DA);
end;

function ChangeColor(Color: TseColor; Dx: smallint): TseColor; overload;
begin
  Result := ChangeColor(Color, Dx, Dx, Dx);
end;

function StdChangeColor(Color: TColor; Dr, Dg, Db: smallint; Da: smallint = 0): TColor; overload;
begin
  Color := FromRGB(ColorToRGB(Color));
  Color := ChangeColor(Color, Dr, Dg, Db);
  Result := ToRGB(Color);
end;

function StdChangeColor(Color: TColor; Dx: smallint): TColor; overload;
begin
  Result := StdChangeColor(Color, Dx, Dx, Dx);
end;

function SunkenColor(Color: TseColor; Dr, Dg, Db: smallint; Da: smallint = 0): TseColor; overload;
begin
  Result := ChangeColor(Color, -Dr, -Dg, -Db, -Da);
end;

function SunkenColor(Color: TseColor; Dx: smallint): TseColor; overload;
begin
  Result := ChangeColor(Color, -Dx);
end;

function RaisedColor(Color: TseColor; Dr, Dg, Db: smallint; Da: smallint = 0): TseColor; overload;
begin
  Result := ChangeColor(Color, Dr, Dg, Db, Da);
end;

function RaisedColor(Color: TseColor; Dx: smallint): TseColor; overload;
begin
  Result := ChangeColor(Color, Dx);
end;

{ TseBitmap ===================================================================}

constructor TseBitmap.Create;
begin
  inherited Create;
  FDC := 0;
  with FBitmapInfo.bmiHeader do
  begin
    biSize := SizeOf(TBitmapInfoHeader);
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
  end;
end;

destructor TseBitmap.Destroy;
begin
  RemoveBitmapFromList(Self);
  if FCanvas <> nil then
  begin
    FCanvas.Handle := 0;
    FreeAndNil(FCanvas);
  end;
  if FDC <> 0 then DeleteDC(FDC);
  FDC := 0;
  if FHandle <> 0 then DeleteObject(FHandle);
  FHandle := 0;
  FBits := nil;
  inherited Destroy;
end;

procedure TseBitmap.AssignTo(Dest: TPersistent);
var
  Bmp: TBitmap;

  procedure CopyToBitmap(Bmp: TBitmap);
  begin
    Bmp.PixelFormat := pf32Bit;
    Bmp.Width := FWidth;
    Bmp.Height := FHeight;
    Draw(Bmp.Canvas, 0, 0);
  end;

begin
  if Dest is TPicture then CopyToBitmap(TPicture(Dest).Bitmap)
  else if Dest is TBitmap then CopyToBitmap(TBitmap(Dest))
  else if Dest is TClipboard then
  begin
    Bmp := TBitmap.Create;
    try
      CopyToBitmap(Bmp);
      TClipboard(Dest).Assign(Bmp);
    finally
      Bmp.Free;
    end;
  end
  else inherited;
end;

procedure TseBitmap.CheckRGBA;
var
  i: Cardinal;
  C: PseColor;
begin
  if (FHeight = 0) or (FWidth = 0) then Exit;
  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if TseColorRec(C^).R > TseColorRec(C^).A
    then
     TseColorRec(C^).R := TseColorRec(C^).A;
    if TseColorRec(C^).G > TseColorRec(C^).A
    then
      TseColorRec(C^).G := TseColorRec(C^).A;
    if TseColorRec(C^).B > TseColorRec(C^).A
    then
      TseColorRec(C^).B := TseColorRec(C^).A;
    Inc(C);
  end;
end;


procedure TseBitmap.Assign(Source: TPersistent);

  procedure AssignFromBitmap(SrcBmp: TBitmap);
  begin
    SetSize(SrcBmp.Width, SrcBmp.Height);
    if Empty then Exit;
    BitBlt(FDC, 0, 0, FWidth, FHeight, SrcBmp.Canvas.Handle, 0, 0, SRCCOPY);
    SetAlpha($FF);
  end;

var
  SLine: PseColorArray;
  DstP: PseColor;
  i, j: integer;
begin
  if Source is TseBitmap then
  begin
    SetSize((Source as TseBitmap).FWidth, (Source as TseBitmap).FHeight);
    if Empty then Exit;
    MoveLongwordFunc((Source as TseBitmap).Bits, FBits, FWidth * FHeight);
    { Assign properties }
    FName := (Source as TseBitmap).FName;
    FTransparent := (Source as TseBitmap).FTransparent;
    FAlphaBlend := (Source as TseBitmap).FAlphaBlend;
  end
  else
    if Source is TBitmap then
    begin
      if ((Source as TBitmap).PixelFormat = pf32bit) and
         ((Source as TBitmap).HandleType = bmDIB) then
      with (Source as TBitmap) do
      begin
        { Alpha }
        Self.SetSize(Width, Height);
        { Copy alpha }
        for j := 0 to Height - 1 do
        begin
          SLine := Scanline[j];
          for i := 0 to Width - 1 do
          begin
            DstP := PixelPtr[i, j];
            DstP^ := SLine^[i];
          end;
        end;
        { CheckAlpha }
        CheckingAlphaBlend; 
      end
      else
      begin
        { Copy }
        AssignFromBitmap((Source as TBitmap));
        SetAlpha($FF);
      end;
    end
    else
      if Source is TGraphic then
      begin
        SetSize(TGraphic(Source).Width, TGraphic(Source).Height);
        if Empty then Exit;
        DrawGraphic(TGraphic(Source), Rect(0, 0, FWidth, FHeight));
        SetAlpha($FF);
      end
      else
        if Source is TPicture then
        begin
          with TPicture(Source) do
          begin
            if TPicture(Source).Graphic is TBitmap then
              AssignFromBitmap(TBitmap(TPicture(Source).Graphic))
            else
            begin
              // icons, metafiles etc...
              Self.SetSize(TPicture(Source).Graphic.Width, TPicture(Source).Graphic.Height);
              if Empty then Exit;
              DrawGraphic(TPicture(Source).Graphic, Rect(0, 0, FWidth, FHeight));
              SetAlpha($FF);
            end;
          end;
        end
        else  { inherited }
          inherited;
end;

procedure TseBitmap.SetSize(AWidth, AHeight: Integer);
begin
    AWidth := Abs(AWidth);
    AHeight := Abs(AHeight);
    if (AWidth = 0) or (AHeight = 0) then Exit;
    if (AWidth = FWidth) and (AHeight = FHeight) then Exit;

    { Free resource }
    if FDC <> 0 then RemoveBitmapFromList(Self);
    if FDC <> 0 then DeleteDC(FDC);
    FDC := 0;
    if FHandle <> 0 then DeleteObject(FHandle);
    FHandle := 0;
    FBits := nil;

    { Initialization }
    with FBitmapInfo.bmiHeader do
    begin
      biWidth := AWidth;
      biHeight := -AHeight;
    end;

    { Create new DIB }
    FHandle := CreateDIBSection(0, FBitmapInfo, DIB_RGB_COLORS, Pointer(FBits), 0, 0);
    if FBits = nil then
      raise Exception.Create('Can''t allocate the DIB handle');

    FDC := CreateCompatibleDC(0);
    if FDC = 0 then
    begin
      DeleteObject(FHandle);
      FHandle := 0;
      FBits := nil;
      raise Exception.Create('Can''t create compatible DC');
    end;

    if SelectObject(FDC, FHandle) = 0 then
    begin
      DeleteDC(FDC);
      DeleteObject(FHandle);
      FDC := 0;
      FHandle := 0;
      FBits := nil;
      raise Exception.Create('Can''t select an object into DC');
    end;

    { Add to BitmapList }
    AddBitmapToList(Self);
    if FCanvas <> nil then
      FCanvas.Handle := DC;

  FWidth := AWidth;
  FHeight := AHeight;
end;

function TseBitmap.Empty: boolean;
begin
  Result := FHandle = 0;
end;

procedure TseBitmap.Clear(Color: TseColor);
begin
  FillLongwordFunc(Bits, FWidth * FHeight, Color);
end;

{ I/O Routines }

procedure TseBitmap.LoadFromResource(const ResFileName, ResName: string);
var
  H: THandle;
  ResStream: TStream;
  BitmapInfo: PBitmapInfo;
  HeaderSize: integer;
  B: TBitmap;
  Bmp: HBitmap;
  HResInfo: HRSRC;
begin
  H := LoadLibraryEx(PChar(ResFileName), 0, LOAD_LIBRARY_AS_DATAFILE);
  try
    HResInfo := FindResource(H, PChar(ResName), RT_BITMAP);
    if HResInfo <> 0 then
    begin
      ResStream := TResourceStream.Create(H, ResName, RT_BITMAP);
      try
        ResStream.Read(HeaderSize, sizeof(HeaderSize));
        GetMem(BitmapInfo, HeaderSize + 12 + 256 * sizeof(TRGBQuad));
        with BitmapInfo^ do
        try
          ResStream.Read(Pointer(Longint(BitmapInfo) + sizeof(HeaderSize))^,
            HeaderSize - sizeof(HeaderSize));

          B := TBitmap.Create;
          try
            if BitmapInfo^.bmiHeader.biBitCount = 32 then
              B.LoadFromResourceName(H, ResName) // By VCL
            else
            begin
              B.Handle := LoadBitmap(H, PChar(ResName)); // By Windows
              if B.Handle = 0 then
                B.LoadFromResourceName(H, ResName) // Try by VCL
            end;

            Assign(B);
          finally
            B.Free;
          end;
        finally
          FreeMem(BitmapInfo);
        end;
      finally
        ResStream.Free;
      end;
    end;
  finally
    FreeLibrary(H);
  end;
end;

procedure TseBitmap.LoadFromStream(Stream: TStream);
var
  W, H: integer;
begin
  FName := ReadString(Stream);
  Stream.Read(W, SizeOf(Integer));
  Stream.Read(H, SizeOf(Integer));
  if (H > 0) then
  begin
    { New format since 3.4.4 }
    SetSize(W, H);
    if (FWidth = W) and (FHeight = H) then
      Stream.Read(FBits^, FWidth * FHeight * SizeOf(Longword));
  end
  else
  begin
    H := Abs(H);
    SetSize(W, H);
    if (FWidth = W) and (FHeight = H) then
      Stream.Read(FBits^, FWidth * FHeight * SizeOf(Longword));
    FlipVert;
  end;
  { Checking }
{  CheckingAlphaBlend;
  if not FAlphaBlend then CheckingTransparent;}
end;

procedure TseBitmap.SaveToStream(Stream: TStream);
var
  NewFormatHeight: integer;
begin
  WriteString(Stream, FName);
  Stream.Write(FWidth, SizeOf(Integer));
  NewFormatHeight := FHeight; { New format since 3.4.4 }
  Stream.Write(NewFormatHeight, SizeOf(Integer));
  Stream.Write(FBits^, FWidth * FHeight * SizeOf(Longword));
end;

type

  TRGB = packed record
   R, G, B: Byte;
  end;

  TPCXHeader = record
    FileID: Byte;                      // $0A for PCX files, $CD for SCR files
    Version: Byte;                     // 0: version 2.5; 2: 2.8 with palette; 3: 2.8 w/o palette; 5: version 3
    Encoding: Byte;                    // 0: uncompressed; 1: RLE encoded
    BitsPerPixel: Byte;
    XMin,
    YMin,
    XMax,
    YMax,                              // coordinates of the corners of the image
    HRes,                              // horizontal resolution in dpi
    VRes: Word;                        // vertical resolution in dpi
    ColorMap: array[0..15] of TRGB;    // color table
    Reserved,
    ColorPlanes: Byte;                 // color planes (at most 4)
    BytesPerLine,                      // number of bytes of one line of one plane
    PaletteType: Word;                 // 1: color or b&w; 2: gray scale
    Fill: array[0..57] of Byte;
  end;

procedure TseBitmap.LoadFromPcxStream(Stream: TStream);
const
  FSourceBPS: byte = 8;
  FTargetBPS: byte = 8;
var
  Header: TPCXHeader;
  Bitmap: TBitmap;

  procedure PcxDecode(var Source, Dest: Pointer; PackedSize, UnpackedSize: Integer);
  var
    Count: Integer;
    SourcePtr,
    TargetPtr: PByte;
  begin
    SourcePtr := Source;
    TargetPtr := Dest;
    while UnpackedSize > 0 do
    begin
      if (SourcePtr^ and $C0) = $C0 then
      begin
        // RLE-Code
        Count := SourcePtr^ and $3F;
        Inc(SourcePtr);
        if UnpackedSize < Count then Count := UnpackedSize;
        FillChar(TargetPtr^, Count, SourcePtr^);
        Inc(SourcePtr);
        Inc(TargetPtr, Count);
        Dec(UnpackedSize, Count);
      end
      else
      begin
        // not compressed
        TargetPtr^ := SourcePtr^;
        Inc(SourcePtr);
        Inc(TargetPtr);
        Dec(UnpackedSize);
      end;
    end;
  end;

  function PcxCreateColorPalette(Data: array of Pointer; ColorCount: Cardinal): HPALETTE;
  var
    I, MaxIn, MaxOut: Integer;
    LogPalette: TMaxLogPalette;
    RunR8: PByte;
  begin
    FillChar(LogPalette, SizeOf(LogPalette), 0);
    LogPalette.palVersion := $300;
    if ColorCount > 256 then
      LogPalette.palNumEntries := 256
    else
      LogPalette.palNumEntries := ColorCount;

    RunR8 := Data[0];

    for I := 0 to LogPalette.palNumEntries - 1 do
    begin
      LogPalette.palPalEntry[I].peRed := RunR8^;
      Inc(RunR8);
      LogPalette.palPalEntry[I].peGreen := RunR8^;
      Inc(RunR8);
      LogPalette.palPalEntry[I].peBlue := RunR8^; Inc(
      RunR8);
    end;

    MaxIn := (1 shl FSourceBPS) - 1;
    MaxOut := (1 shl FTargetBPS) - 1;
    if (FTargetBPS <= 8) and (MaxIn <> MaxOut) then
    begin
      MaxIn := (1 shl FSourceBPS) - 1;
      MaxOut := (1 shl FTargetBPS) - 1;
      if MaxIn < MaxOut then
      begin
        { palette is too small, enhance it }
        for I := MaxOut downto 0 do
        begin
          LogPalette.palPalEntry[I].peRed := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peRed;
          LogPalette.palPalEntry[I].peGreen := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peGreen;
          LogPalette.palPalEntry[I].peBlue := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peBlue;
        end;
      end
      else
      begin
        { palette contains too many entries, shorten it }
        for I := 0 to MaxOut do
        begin
          LogPalette.palPalEntry[I].peRed := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peRed;
          LogPalette.palPalEntry[I].peGreen := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peGreen;
          LogPalette.palPalEntry[I].peBlue := LogPalette.palPalEntry[MulDiv16(I, MaxIn, MaxOut)].peBlue;
        end;
      end;
      LogPalette.palNumEntries := MaxOut + 1;
    end;

    { finally create palette }
    Result := CreatePalette(PLogPalette(@LogPalette)^);
  end;
  
  procedure MakePalette;
  var
    PCXPalette: array[0..255] of TRGB;
    OldPos: Integer;
    Marker: Byte;
  begin
    if (Header.Version <> 3) or (Bitmap.PixelFormat = pf1Bit) and
       (Bitmap.PixelFormat = pf8Bit) then
    begin
      OldPos := Stream.Position;
      { 256 colors with 3 components plus one marker byte }
      Stream.Position := Stream.Size - 769;
      Stream.Read(Marker, 1);

      Stream.Read(PCXPalette[0], 768);
      Bitmap.Palette := PcxCreateColorPalette([@PCXPalette], 256);

      Stream.Position := OldPos;
    end
    else
      Bitmap.Palette := SystemPalette16;
  end;

  procedure RowConvertIndexed8(Source: array of Pointer; Target: Pointer; Count: Cardinal; Mask: Byte);
  var
    SourceRun, TargetRun: PByte;
  begin
    SourceRun := Source[0];
    TargetRun := Target;

    if (FSourceBPS = FTargetBPS) and (Mask = $FF) then
      Move(SourceRun^, TargetRun^, (Count * FSourceBPS + 7) div 8);
  end;

var
  PCXSize, Size: Cardinal;
  RawBuffer, DecodeBuffer: Pointer;
  Run: PByte;
  I: Integer;
  Line: PByte;
  Increment: Cardinal;
begin
  { Load from PCX - 8-bit indexed RLE compressed/uncompressed }
  Bitmap := TBitmap.Create;
  try
    Bitmap.Handle := 0;

    Stream.Read(Header, SizeOf(Header));
    PCXSize := Stream.Size - Stream.Position;
    with Header do
    begin
      if not (FileID in [$0A, $CD]) then Exit;

      Bitmap.PixelFormat := pf8bit;
      MakePalette;

      Bitmap.Width := XMax - XMin + 1;
      Bitmap.Height := YMax - YMin + 1;

      { adjust alignment of line }
      Increment := ColorPlanes * BytesPerLine;

      { Decompress }
      if Header.Encoding = 1 then
      begin
        { RLE }
        Size := Increment * Bitmap.Height;
        GetMem(DecodeBuffer, Size);
        GetMem(RawBuffer, PCXSize);
        try
          Stream.ReadBuffer(RawBuffer^, PCXSize);

          PcxDecode(RawBuffer, DecodeBuffer, PCXSize, Size);
        finally
          if Assigned(RawBuffer) then FreeMem(RawBuffer);
        end;
      end
      else
      begin
        GetMem(DecodeBuffer, PCXSize);
        Stream.ReadBuffer(DecodeBuffer^, PCXSize);
      end;

      try
        Run := DecodeBuffer;
        { PCX 8 bit Index }
        for I := 0 to Bitmap.Height - 1 do
        begin
          Line := Bitmap.ScanLine[I];
          RowConvertIndexed8([Run], Line, Bitmap.Width, $FF);
          Inc(Run, Increment);
        end;
      finally
        if Assigned(DecodeBuffer) then FreeMem(DecodeBuffer);
      end;
    end;

    { Assign to Self }
    Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

{ Checking routines }

const
  Quantity = 6;

procedure TseBitmap.CheckingAlphaBlend;
var
  i: Cardinal;
  C: PseColor;
begin
  FAlphaBlend := false;

  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if (TseColorRec(C^).A > 0) and (TseColorRec(C^).A < $FF) then
    begin
      FAlphaBlend := true;
      Break;
    end;

    Inc(C);
  end;
end;

procedure TseBitmap.CheckingAlphaBlend(ARect: TRect);
var
  i, j: integer;
  C: PseColor;
begin
  FAlphaBlend := false;

  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
    begin
      C := PixelPtr[i, j];
      if (TseColorRec(C^).A > 0) and (TseColorRec(C^).A < $FF) then
      begin
        FAlphaBlend := true;
        Break;
      end;
    end;
end;

procedure TseBitmap.CheckingTransparent(Color: TseColor = seTransparent);
var
  i: Cardinal;
  C: PseColor;
begin
  FTransparent := false;

  C := @FBits[0];
  for i := 0 to FWidth * FHeight - 1 do
  begin
    if (Abs(TseColorRec(C^).R - TseColorRec(Color).R) < Quantity) and
       (Abs(TseColorRec(C^).G - TseColorRec(Color).G) < Quantity) and
       (Abs(TseColorRec(C^).B - TseColorRec(Color).B) < Quantity)
    then
    begin
      C^ := seTransparent;
      FTransparent := true;
    end;

    Inc(C);
  end;
end;

procedure TseBitmap.CheckingTransparent(ARect: TRect; Color: TseColor = seTransparent);
var
  i, j: integer;
  C: PseColor;
begin
  FTransparent := false;

  for i := 0 to FWidth - 1 do
    for j := 0 to FHeight - 1 do
    begin
      C := PixelPtr[i, j];
      if (Abs(TseColorRec(C^).R - TseColorRec(Color).R) < Quantity) and
         (Abs(TseColorRec(C^).G - TseColorRec(Color).G) < Quantity) and
         (Abs(TseColorRec(C^).B - TseColorRec(Color).B) < Quantity)
      then
      begin
        C^ := seTransparent;
        FTransparent := true;
      end;
    end;
end;

procedure TseBitmap.SetAlpha(Alpha: byte);
begin
  if Empty then Exit;
  FillAlphaFunc(Bits, FWidth * FHeight, Alpha);
end;

procedure TseBitmap.SetAlpha(Alpha: byte; Rect: TRect);
begin
  if RectWidth(Rect) = 0 then Exit;
  if RectHeight(Rect) = 0 then Exit;

  if Rect.Left < 0 then Rect.Left := 0;
  if Rect.Top < 0 then Rect.Top := 0;
  if Rect.Right > FWidth then Rect.Right := FWidth;
  if Rect.Bottom > FHeight then Rect.Bottom := FHeight;
  FillAlphaRectFunc(FBits, FWidth, FHeight, Rect.Left, Rect.Top, Rect.Right-1,
    Rect.Bottom - 1, Alpha);
end;

{ Access properties }

function TseBitmap.GetScanLine(Y: Integer): PseColorArray;
begin
  Result := @Bits[Y * FWidth];
end;

function TseBitmap.GetPixelPtr(X, Y: Integer): PseColor;
begin
  Result := @Bits[X + Y * FWidth];
end;

function TseBitmap.GetPixel(X, Y: Integer): TseColor;
begin
  if (FBits <> nil) and (X >= 0) and (Y >= 0) and (X < Width) and (Y < Height) then
    Result := PixelPtr[X, Y]^
  else
    Result := 0;
end;

procedure TseBitmap.SetPixel(X, Y: Integer; Value: TseColor);
begin
  if X < 0 then Exit;
  if Y < 0 then Exit;
  if X > Width then Exit;
  if Y > Height then Exit;

  if FBits <> nil then
    PixelPtr[X, Y]^ := Value;
end;

{ BitmapLink }

function TseBitmap.GetBitmapLink(Rect: TRect): TseBitmapLink;
begin
  Result := TseBitmapLink.Create;
  Result.Image := Self;
  Result.Name := Name;
  Result.Rect := Rect;
end;

function TseBitmap.GetBitmapLink(Rect: string): TseBitmapLink;
begin
  Result := TseBitmapLink.Create;
  Result.Image := Self;
  Result.Name := Name;
  Result.Rect := StringToRect(Rect);
end;

{ Color transition ============================================================}

procedure TseBitmap.ChangeBitmapBrightness(DeltaBrightness: integer);
var
  i: Cardinal;
  Color: PseColor;
  A: byte;
begin
  if DeltaBrightness = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TseColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeBrightness(Color^, DeltaBrightness);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

procedure TseBitmap.SetBitmapHue(Hue: integer);
var
  i: Cardinal;
  Color: PseColor;
  A: byte;
begin
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TseColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := SetHue(Color^, Hue);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

procedure TseBitmap.ChangeBitmapSat(DeltaSat: integer);
var
  i: Cardinal;
  Color: PseColor;
  A: byte;
begin
  if DeltaSat = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TseColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeSat(Color^, DeltaSat);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

procedure TseBitmap.ChangeBitmapHue(DeltaHue: integer);
var
  i: Cardinal;
  Color: PseColor;
  A: byte;
begin
  if DeltaHue = 0 then Exit;
  if FWidth * FHeight = 0 then Exit;

  for i := 0 to FWidth * FHeight - 1 do
  begin
    Color := @Bits[i];
    A := TseColorRec(Color^).A;
    if (A = 0) then Continue;
    Color^ := ChangeHue(Color^, DeltaHue);
    Color^ := Color^ and not AlphaMask or (A shl 24);
  end;
end;

{ Draw to XXX =================================================================}

procedure TseBitmap.Draw(DC: HDC; X, Y: integer);
begin
  Draw(DC, X, Y, Rect(0, 0, Width, Height));
end;

procedure TseBitmap.Draw(DC: HDC; X, Y: integer; SrcRect: TRect);
begin
  Draw(DC, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

procedure TseBitmap.Draw(DC: HDC; DstRect: TRect);
begin
  Draw(DC, DstRect, Rect(0, 0, FWidth, FHeight));
end;

procedure TseBitmap.Draw(DC: HDC; DstRect, SrcRect: TRect);
var
  Dst: TseBitmap;
  P: TPoint;
  BitmapW, BitmapH, BitmapBCount: integer;
  BitmapBits: PByteArray;
begin
  Dst := FindBitmapByDC(DC);
  if Dst <> nil then
  begin
    { Adjust WindowOrg }
    GetWindowOrgEx(DC, P);
    OffsetRect(DstRect, -P.X, -P.Y);
    { Destination is KS Bitmap }
    Draw(Dst, DstRect, SrcRect);
  end
  else
  begin
(*    BitmapBits := GetBitsFromDCFunc(DC, BitmapW, BitmapH, BitmapBCount);
    if EnableDibOperation and (BitmapBits <> nil) and (BitmapBCount = 32) and (BitmapH > 0) then
    begin
      { Adjust WindowOrg }
      GetWindowOrgEx(DC, P);
      OffsetRect(DstRect, -P.X, -P.Y);
      { Draw to DIB }
      if FAlphaBlend then
        StretchToDibAlphaBlendFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
          Self, SrcRect)
      else
        if FTransparent then
          StretchToDibTransparentFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
            Self, SrcRect)
        else
          StretchToDibOpaqueFunc(BitmapBits, DstRect, DstRect, BitmapW, BitmapH,
            Self, SrcRect);
    end
    else *)
    begin
      { Draw to DC }
      if FAlphaBlend then
        StretchToDCAlphaBlendFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
          Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
      else
        if FTransparent then
          StretchToDCTransparentFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
        else
          StretchToDCOpaqueFunc(DC, DstRect.Left, DstRect.Top, RectWidth(DstRect), RectHeight(DstRect),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect));
    end;
  end;
end;

procedure TseBitmap.Draw(Canvas: TCanvas; X, Y: integer);
begin
  Draw(Canvas.Handle, X, Y);
end;

procedure TseBitmap.Draw(Canvas: TCanvas; X, Y: integer; SrcRect: TRect);
begin
  Draw(Canvas, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

procedure TseBitmap.Draw(Canvas: TCanvas; DstRect: TRect);
begin
  Draw(Canvas, DstRect, Rect(0, 0, FWidth, FHeight));
end;

procedure TseBitmap.Draw(Canvas: TCanvas; DstRect, SrcRect: TRect);
begin
  Draw(Canvas.Handle, DstRect, SrcRect);
end;

procedure TseBitmap.Draw(Bitmap: TseBitmap; X, Y: integer);
begin
  Draw(Bitmap, X, Y, Rect(0, 0, Width, Height));
end;

procedure TseBitmap.Draw(Bitmap: TseBitmap; X, Y: integer;
  SrcRect: TRect);
begin
  Draw(Bitmap, Rect(X, Y, X + RectWidth(SrcRect), Y + RectHeight(SrcRect)), SrcRect);
end;

procedure TseBitmap.Draw(Bitmap: TseBitmap; DstRect: TRect);
begin
  Draw(Bitmap, DstRect, Rect(0, 0, FWidth, FHeight));
end;

procedure TseBitmap.Draw(Bitmap: TseBitmap; DstRect, SrcRect: TRect);
begin
  if AlphaBlend then
    StretchAlphaBlendFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
  else
    if Transparent then
      StretchTransparentFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
    else
      StretchOpaqueFunc(Bitmap, DstRect, DstRect, Self, SrcRect)
end;

procedure TseBitmap.Tile(DC: HDC; DstRect, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  Dst: TseBitmap;
  BitmapW, BitmapH, BitmapBCount: integer;
  BitmapBits: PByteArray;

  procedure Draw( SrcRect: TRect);
  var
    P: TPoint;
  begin
    if Dst <> nil then
    begin
      { Adjust WindowOrg }
      GetWindowOrgEx(DC, P);
      OffsetRect(R, -P.X, -P.Y);
      { Destination is KS Bitmap }
      self.Draw(Dst, R, SrcRect);
    end
    else
    begin
      if EnableDibOperation and (BitmapBits <> nil) and (BitmapBCount = 32) and (BitmapH > 0) then
      begin
        { Adjust WindowOrg }
        GetWindowOrgEx(DC, P);
        OffsetRect(R, -P.X, -P.Y);
        { Draw to DIB }
        if FAlphaBlend then
          StretchToDibAlphaBlendFunc(BitmapBits, R, R, BitmapW, BitmapH,
            Self, SrcRect)
        else
          if FTransparent then
            StretchToDibTransparentFunc(BitmapBits, R, R, BitmapW, BitmapH,
              Self, SrcRect)
          else
            StretchToDibOpaqueFunc(BitmapBits, R, R, BitmapW, BitmapH,
              Self, SrcRect);
      end
      else
      begin
        { Draw to DC }
        if FAlphaBlend then
          StretchToDCAlphaBlendFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
            Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
        else
          if FTransparent then
            StretchToDCTransparentFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect))
          else
            StretchToDCOpaqueFunc(DC, R.Left, R.Top, RectWidth(R), RectHeight(R),
              Self, SrcRect.Left, SrcRect.Top, RectWidth(SrcRect), RectHeight(SrcRect));
      end;
    end;
  end;

begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if (W=0) or (H=0) then Exit;

  Dst := FindBitmapByDC(DC);
  if Dst=nil then
    BitmapBits := GetBitsFromDCFunc(DC, BitmapW, BitmapH, BitmapBCount);

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      R1 := SrcRect;
      if (DW <> W) or (DH <> H) then
      begin
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        Draw( R1);
      end
      else
        Draw( R1);
    end;
end;

procedure TseBitmap.Tile(Canvas: TCanvas; DstRect, SrcRect: TRect);
begin
  Tile(Canvas.Handle, DstRect, SrcRect);
end;

procedure TseBitmap.Tile(Bitmap: TseBitmap; DstRect, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        Draw(Bitmap, R, R1);
      end
      else
        Draw(Bitmap, R, SrcRect);
    end;
end;

procedure TseBitmap.TileClip(DC: HDC; DstRect, DstClip, SrcRect: TRect);
var
  i, j: integer;
  R, R1, SrcR, ClipRes: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  IsClip: boolean;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  if IsRectEmpty(DstClip) then
    IsClip := false
  else
    IsClip := true;
  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(DC, R, R1);
        end
        else
          Draw(DC, R, R1);
      end
      else
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(DC, R, SrcRect);
        end
        else
          Draw(DC, R, SrcRect);
    end;
end;

procedure TseBitmap.TileClip(Canvas: TCanvas; DstRect, DstClip, SrcRect: TRect);
begin
  TileClip(Canvas.Handle, DstRect, DstClip, SrcRect);
end;

procedure TseBitmap.TileClip(Bitmap: TseBitmap; DstRect, DstClip, SrcRect: TRect);
var
  i, j: integer;
  R, R1, ClipRes, SrcR: TRect;
  Cx, Cy: integer;
  W, H, DW, DH: integer;
  IsClip: boolean;
begin
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  if W * H = 0 then Exit;

  SrcR := Rect(0, 0, W, H);
  OffsetRect(SrcR, DstRect.Left, DstRect.Top);

  if IsRectEmpty(DstClip) then
    IsClip := false
  else
    IsClip := true;

  Cx := RectWidth(DstRect) div W;
  if RectWidth(DstRect) mod W <> 0 then Inc(Cx);
  Cy := RectHeight(DstRect) div H;
  if RectHeight(DstRect) mod H <> 0 then Inc(Cy);

  for i := 0 to Cx do
    for j := 0 to Cy do
    begin
      R := SrcR;
      OffsetRect(R, i * W, j * H);

      IntersectRect(R, R, DstRect);

      DW := RectWidth(R);
      DH := RectHeight(R);

      if (DW = 0) or (DH = 0) then Break;

      if (DW <> W) or (DH <> H) then
      begin
        R1 := SrcRect;
        R1.Right := R1.Left + DW;
        R1.Bottom := R1.Top + DH;
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(Bitmap, R, R1);
        end
        else
          Draw(Bitmap, R, R1);
      end
      else
        if IsClip then
        begin
          if IntersectRect(ClipRes, DstClip, R) then
            Draw(Bitmap, R, SrcRect);
        end
        else
          Draw(Bitmap, R, SrcRect);
    end;
end;

procedure TseBitmap.MergeDraw(Bitmap: TseBitmap; X, Y: integer; SrcRect: TRect);
var
  Index: integer;
  i, j: integer;
  B, F: PseColor;
  Alpha: byte;
begin
  if SrcRect.Left < 0 then
  begin
    X := X + Abs(SrcRect.Left);
    SrcRect.Left := 0;
  end;
  if SrcRect.Top < 0 then
  begin
    Y := Y + Abs(SrcRect.Top);
    SrcRect.Top := 0;
  end;
  if SrcRect.Right > Bitmap.FWidth then SrcRect.Right := Bitmap.FWidth;
  if SrcRect.Bottom > Bitmap.FHeight then SrcRect.Bottom := Bitmap.FHeight;
  { Draw bitmap rect to another bitmap }
  try
    for i := SrcRect.Left to SrcRect.Right-1 do
      for j := SrcRect.Top to SrcRect.Bottom-1 do
      begin
        { Get Back pixel from Bitmap }
        B := Bitmap.PixelPtr[i, j];
        { Get fore pixel }
        Index := (X + i-SrcRect.Left) + (Y + (j-SrcRect.Top)) * FWidth;
        if Index >= FWidth * FHeight then Continue;
        F := @FBits[Index];

        { Blend }
        Alpha := F^ shr 24;
        if Alpha = 0 then
          F^ := B^
        else
          if Alpha < $FF then
            F^ := PixelAlphaBlendFunc(F^, B^);
      end;
  finally
    EMMS;
  end;
end;

{ Painting Routines ===========================================================}

procedure TseBitmap.DrawGraphic(Graphic: TGraphic; DstRect: TRect);
var
  Bitmap: TBitmap;
  SL: PseColorArray;
  i, j: integer;
begin
  { Create DIB copy }
  Bitmap := TBitmap.Create;
  try
    Bitmap.PixelFormat := pf32bit;
    Bitmap.Width := FWidth;
    Bitmap.Height := FHeight;
    Bitmap.Canvas.Brush.Color := RGB(255, 0, 255);
    Bitmap.Canvas.Rectangle(-1, -1, FWidth + 1, FHeight + 1);
    Bitmap.Canvas.StretchDraw(DstRect, Graphic);

    { Copy to bitmap }
    for j := 0 to FHeight - 1 do
    begin
      SL := Bitmap.Scanline[j];
      for i := 0 to FWidth - 1 do
        if (TseColorRec(SL[i]).R = $FF) and (TseColorRec(SL[i]).G = 0) and (TseColorRec(SL[i]).B = $FF) then
          Continue
        else
          Pixels[i, j] := SL[i];
    end;
  finally
    Bitmap.Free;
  end;
end;

procedure TseBitmap.DrawBevel(R: TRect; Color: TseColor; Width: integer;
  Down: boolean);
begin

end;

procedure TseBitmap.DrawEdge(R: TRect; RaisedColor,
  SunkenColor: TseColor);
begin

end;

procedure TseBitmap.DrawEllipse(R: TRect; Color: TseColor);
begin

end;

procedure TseBitmap.DrawFocusRect(R: TRect; Color: TseColor);
begin

end;

procedure TseBitmap.DrawLine(R: TRect; Color: TseColor);
begin

end;

procedure TseBitmap.DrawPolygon(Points: array of TPoint; Color: TColor);
begin

end;

procedure TseBitmap.DrawRect(R: TRect; Color: TseColor);
begin

end;

procedure TseBitmap.DrawRoundRect(R: TRect; Radius: integer;
  Color: TseColor);
begin

end;

function TseBitmap.DrawText(AText: WideString; var Bounds: TRect;
  Flag: cardinal): integer;
begin
  Result := 0;
end;

function TseBitmap.DrawText(AText: WideString; X, Y: integer): integer;
begin
  Result := 0;
end;

function TseBitmap.DrawVerticalText(AText: WideString; Bounds: TRect;
  Flag: cardinal; FromTop: boolean): integer;
begin
  Result := 0;
end;

procedure TseBitmap.FillEllipse(R: TRect; Color: TseColor);
begin

end;

procedure TseBitmap.FillGradientRect(Rect: TRect; BeginColor,
  EndColor: TseColor; Vertical: boolean);
begin

end;

procedure TseBitmap.FillHalftonePolygon(Points: array of TPoint; Color,
  HalfColor: TseColor);
begin

end;

procedure TseBitmap.FillHalftoneRect(R: TRect; Color,
  HalfColor: TseColor);
begin

end;

procedure TseBitmap.FillPolygon(Points: array of TPoint; Color: TColor);
begin

end;

procedure TseBitmap.FillRadialGradientRect(Rect: TRect; BeginColor,
  EndColor: TseColor; Pos: TPoint);
begin

end;

procedure TseBitmap.FillRect(R: TRect; Color: TseColor);
var
  Size, j: integer;
  AlphaLine: PseColor;
begin
  if R.Left < 0 then R.Left := 0;
  if R.Top < 0 then R.Top := 0;
  if R.Right > Width then R.Right := Width;
  if R.Bottom > Height then R.Bottom := Height;
  if RectWidth(R) <= 0 then Exit;
  if RectHeight(R) <= 0 then Exit;

  if AlphaBlend then
  begin
    Size := RectWidth(R);
    GetMem(AlphaLine, SizeOf(TseColor) * Size);
    try
      FillLongwordFunc(AlphaLine, Size, Color);
      for j := R.Top to R.Bottom-1 do
        LineAlphaBlendFunc(AlphaLine, PixelPtr[R.Left, j], Size);
    finally
      FreeMem(AlphaLine, SizeOf(TseColor) * Size);
      EMMS;
    end;
  end
  else
    FillLongwordRectFunc(FBits, FWidth, FHeight, R.Left, R.Top, R.Right-1, R.Bottom - 1, Color);
end;

procedure TseBitmap.FillRoundRect(R: TRect; Radius: integer;
  Color: TseColor);
begin

end;

procedure TseBitmap.LineTo(X, Y: integer; Color: TseColor);
begin

end;

procedure TseBitmap.MoveTo(X, Y: integer);
begin

end;

function TseBitmap.TextHeight(AText: WideString): integer;
begin
  Result := 0;
end;

function TseBitmap.TextWidth(AText: WideString; Flags: Integer): integer;
begin
  Result := 0;
end;

procedure TseBitmap.Reflection3;
var
  SLine: PseColorArray;
  i, j: Integer;
  AlphaValue: Integer;
  kf, step: Double;
begin
  FlipVert;
  step := (1 / Height) *  2;
  kf := 1;
  for j := 0 to Height - 1 do
   begin
     SLine := Scanline[j];
     for i := 0 to Width - 1 do
     begin
       if TseColorRec(SLine^[i]).A <> 0
       then
         begin
           AlphaValue := Round(TseColorRec(SLine^[i]).A * kf) div 2;
           if AlphaValue < 0 then AlphaValue := 0;
           TseColorRec(SLine^[i]).A := AlphaValue;
         end;
     end;
    kf := kf - Step;
  end;
end;

procedure TseBitmap.Reflection;
var
  SLine: PseColorArray;
  i, j: Integer;
  AlphaValue: Integer;
  kf, step: Double;
begin
  FlipVert;
  step := (1 / Height) *  2;
  kf := 1;
  for j := 0 to Height - 1 do
   begin
     SLine := Scanline[j];
     for i := 0 to Width - 1 do
     begin
       if TseColorRec(SLine^[i]).A <> 0
       then
         begin
           AlphaValue := Round(TseColorRec(SLine^[i]).A * kf) div 3;
           if AlphaValue < 0 then AlphaValue := 0;
           TseColorRec(SLine^[i]).A := AlphaValue;
         end;
     end;
    kf := kf - Step;
  end;
end;

procedure TseBitmap.Reflection2;
var
  SLine: PseColorArray;
  i, j: Integer;
  AlphaValue: Integer;
  kf, step: Double;
begin
  FlipVert;
  step := (1 / Height) *  2;
  kf := 1;
  for j := 0 to Height - 1 do
   begin
     SLine := Scanline[j];
     for i := 0 to Width - 1 do
     begin
       if TseColorRec(SLine^[i]).A <> 0
       then
         begin
           AlphaValue := Round(TseColorRec(SLine^[i]).A * kf) div 4;
           if AlphaValue < 0 then AlphaValue := 0;
           TseColorRec(SLine^[i]).A := AlphaValue;
         end;
     end;
    kf := kf - Step;
  end;
end;

procedure TseBitmap.FlipVert;
var
 J, J2: Integer;
 Buffer: PseColorArray;
 P1, P2: PseColor;
begin
   J2 := Height - 1;
   GetMem(Buffer, Width shl 2);
   for J := 0 to Height div 2 - 1 do
   begin
     P1 := PixelPtr[0, J];
     P2 := PixelPtr[0, J2];
     MoveLongwordFunc(P1, PseColor(Buffer), Width);
     MoveLongwordFunc(P2, P1, Width);
     MoveLongwordFunc(PseColor(Buffer), P2, Width);
     Dec(J2);
   end;
   FreeMem(Buffer);
end;

{ TseBitmapLink ================================================================}

constructor TseBitmapLink.Create;
begin
  inherited Create;
end;

destructor TseBitmapLink.Destroy;
begin
  inherited Destroy;
end;

procedure TseBitmapLink.Assign(Source: TPersistent);
begin
  if Source is TseBitmapLink then
  begin
    FImage := (Source as TseBitmapLink).FImage;
    FRect := (Source as TseBitmapLink).FRect;
    FName := (Source as TseBitmapLink).FName;
    FMasked := (Source as TseBitmapLink).FMasked;
    FMaskedBorder := (Source as TseBitmapLink).FMaskedBorder;
    FMaskedAngles := (Source as TseBitmapLink).FMaskedAngles;
  end
  else
    inherited;
end;

procedure TseBitmapLink.LoadFromStream(Stream: TStream);
begin
  FName := ReadString(Stream);
  Stream.Read(FRect, SizeOf(FRect));
end;

procedure TseBitmapLink.SaveToStream(Stream: TStream);
begin
  WriteString(Stream, FName);
  Stream.Write(FRect, SizeOf(FRect));
end;

procedure TseBitmapLink.CheckingMasked(Margin: TRect);
var
  i, j: integer;
  P: TseColor;
  Pt: TPoint;
begin
  FMasked := false;
  FMaskedBorder := false;
  FMaskedAngles := false;

  if (Margin.Left = 0) and (Margin.Top = 0) and (Margin.Right = 0) and (Margin.Right = 0) then
  begin
    for i := Left to Right - 1 do
      for j := Top to Bottom - 1 do
      begin
        if (FImage.Bits <> nil) and (i >= 0) and (j >= 0) and (i < FImage.Width) and (j < FImage.Height) then
          P := PseColor(@FImage.Bits[i + j * FImage.Width])^
        else
          P := 0;

        if P <> seNone then
        begin
          if P = seTransparent then
          begin
            FMasked := true;
            Break;
          end;
          if TseColorRec(P).A < $FF then
          begin
            FMasked := true;
            Break;
          end;
        end;
      end;
  end
  else
  begin
    for i := Left to Right - 1 do
      for j := Top to Bottom - 1 do
      begin
        if (FImage.Bits <> nil) and (i >= 0) and (j >= 0) and (i < FImage.Width) and (j < FImage.Height) then
          P := PseColor(@FImage.Bits[i + j * FImage.Width])^
        else
          P := 0;

        if P <> seNone then
        begin
          if (P = seTransparent) or (TseColorRec(P).A < $FF) then
          begin
            Pt := Point(i - Left, j - Top);
            { Check angles }
            if PtInRect(Classes.Rect(0, 0, Margin.Left, Margin.Top), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, 0, Right, Margin.Top), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, Bottom - Margin.Bottom, Right, Bottom), Pt) then
              FMaskedAngles := true;
            if PtInRect(Classes.Rect(0, Bottom - Margin.Bottom, Margin.Left, Bottom), Pt) then
              FMaskedAngles := true;

            { Check borders }
            if PtInRect(Classes.Rect(Margin.Left, 0, Right - Margin.Right, Margin.Top), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(Margin.Left, Bottom - Margin.Bottom, Right - Margin.Right, Bottom), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(0, Margin.Top, Margin.Left, Bottom - Margin.Bottom), Pt) then
              FMaskedBorder := true;
            if PtInRect(Classes.Rect(Right - Margin.Right, Margin.Top, Right, Bottom - Margin.Bottom), Pt) then
              FMaskedBorder := true;

            if PtInRect(Classes.Rect(Margin.Left, Margin.Top, Right - Margin.Right, Bottom - Margin.Bottom), Pt) then
              FMasked := true;
          end;
        end;
      end;
  end;
end;

procedure TseBitmapLink.CheckingMasked;
begin
  CheckingMasked(Classes.Rect(0, 0, 0, 0));
end;

procedure TseBitmapLink.Draw(Bitmap: TseBitmap; X, Y: integer);
begin
  if FImage = nil then Exit;
  if FImage.Empty then Exit;
  if FRect.Right - FRect.Left <= 0 then Exit;
  if FRect.Bottom - FRect.Top <= 0 then Exit;
  { Draw bitmap link }
  FImage.Draw(Image, X, Y, FRect);
end;

procedure TseBitmapLink.Draw(Canvas: TCanvas; X, Y: integer);
begin
  if FImage = nil then Exit;
  if FImage.Empty then Exit;
  if FRect.Right - FRect.Left <= 0 then Exit;
  if FRect.Bottom - FRect.Top <= 0 then Exit;
  { Draw bitmap link }
  FImage.Draw(Canvas, X, Y, FRect);
end;

function TseBitmapLink.GetAssigned: boolean;
begin
  Result := (FImage <> nil) and ((FRect.Right - FRect.Left) * (FRect.Bottom - FRect.Top) > 0);
end;

function TseBitmapLink.GetBottom: integer;
begin
  Result := FRect.Bottom;
end;

function TseBitmapLink.GetLeft: integer;
begin
  Result := FRect.Left;
end;

function TseBitmapLink.GetRight: integer;
begin
  Result := FRect.Right;
end;

function TseBitmapLink.GetTop: integer;
begin
  Result := FRect.Top;
end;

procedure TseBitmapLink.SetBottom(const Value: integer);
begin
  FRect.Bottom := Value;
end;

procedure TseBitmapLink.SetLeft(const Value: integer);
begin
  FRect.Left := Value;
end;

procedure TseBitmapLink.SetRight(const Value: integer);
begin
  FRect.Right := Value;
end;

procedure TseBitmapLink.SetTop(const Value: integer);
begin
  FRect.Top := Value;
end;

{ TseBitmapList ===============================================================}

constructor TseBitmapList.Create;
begin
  inherited Create;
end;

destructor TseBitmapList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TseBitmapList.Clear;
var
  i: integer;
begin
  for i := 0 to Count-1 do
    TseBitmap(Items[i]).Free;
  inherited Clear;
end;

function TseBitmapList.GetImage(index: integer): TseBitmap;
begin
  if (index >= 0) and (index < Count) then
    Result := TseBitmap(Items[index])
  else
    Result := nil;
end;

function TseBitmapList.GetBitmapLink(Image: TseBitmap; Rect: TRect): TseBitmapLink;
var
  i: integer;
begin
  Result := nil;

  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if Bitmaps[i] = Image then
    begin
      Result := Bitmaps[i].GetBitmapLink(Rect);
      Exit;
    end;
end;

function TseBitmapList.GetBitmapLink(Name: string; Rect: TRect): TseBitmapLink;
var
  i: integer;
begin
  Result := nil;

  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if CompareText(Bitmaps[i].Name, Name) = 0 then
    begin
      Result := Bitmaps[i].GetBitmapLink(Rect);
      Exit;
    end;
end;

function TseBitmapList.GetBitmapLink(Name, Rect: string): TseBitmapLink;
var
  i: integer;
begin
  Result := nil;

  { Create BitmapLink }
  for i := 0 to Count - 1 do
    if CompareText(Bitmaps[i].Name, Name) = 0 then
    begin
      Result := Bitmaps[i].GetBitmapLink(Rect);
      Exit;
    end;
end;

function TseBitmapList.GetBitmapByName(index: string): TseBitmap;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to Count - 1 do
    if CompareText(Bitmaps[i].Name, index) = 0 then
    begin
      Result := Bitmaps[i];
      Exit;
    end;
end;

function TseBitmap.GetCanvas: TCanvas;
begin
  if FCanvas = nil then
  begin
    FCanvas := TCanvas.Create;
    FCanvas.Handle := DC;
  end;
  Result := FCanvas;
end;



{ Low-Level routines }

function FromRGB(Color: longword): longword;
{ TColor -> TseColor }
asm
  BSWAP   EAX
  MOV     AL, $FF
  ROR     EAX,8
end;

function ToRGB(Color32: longword): longword;
{ TseColor -> TColor }
asm
  ROL    EAX,8
  XOR    AL,AL
  BSWAP  EAX
end;

function MulDiv16(Number, Numerator, Denominator: Word): Word;
asm
  MUL DX
  DIV CX
end;

{ Non-MMX }

procedure _MoveLongword(const Src: Pointer; Dst: Pointer; Count: Integer);
asm
  PUSH    ESI
  PUSH    EDI

  MOV     ESI,EAX
  MOV     EDI,EDX
  MOV     EAX,ECX
  CMP     EDI,ESI
  JE      @exit

  REP     MOVSD
@exit:
  POP     EDI
  POP     ESI
end;

procedure _ClearAlpha(Src: Pointer; Count: integer; Value: longword);
asm
  { Clear alpha }
  PUSH   EDI

  MOV     EDI, EAX {X}
  MOV     EAX, ECX {Value}
  MOV     ECX, EDX {Count}
  TEST    ECX,ECX
  JS      @exit
  AND     EAX, $00FFFFFF
@1:
  MOV     EDX, [EDI]
  AND     EDX, $00FFFFFF
  CMP     EDX, EAX
  JNE     @2
  MOV     [EDI], EDX
@2:
  ADD     EDI, 4

  LOOP    @1

@exit:
  POP     EDI
end;

procedure _FillLongword(Src: Pointer; Count: Integer; Value: Longword);
asm
  PUSH    EDI

  MOV     EDI,EAX  // Point EDI to destination
  MOV     EAX,ECX
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

  REP     STOSD    // Fill count dwords
@exit:
  POP     EDI
end;

procedure _FillLongwordRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Value: Longword);
asm
  PUSH    EDI
  PUSH    EAX
  PUSH    EBX
  PUSH    ECX
  PUSH    EDX

  MOV     EDI, EAX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, W
  MOV     EAX, Y1
  MUL     EBX
  ADD     EAX, X1
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     EBX, X1
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  MOV     EAX, VALUE

@1:
  PUSH    EDI
  MOV     ECX, EBX
  CLD
  REP     STOSD
  POP     EDI
  POP     ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    ECX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     EDX
  POP     ECX
  POP     EBX
  POP     EAX
  POP     EDI
end;

procedure _FillAlpha(Src: Pointer; Count: Integer; Alpha: byte);
asm
  PUSH    EDI

  MOV     EDI,EAX  // Point EDI to destination
  MOV     AL, CL
  MOV     ECX,EDX
  TEST    ECX,ECX
  JS      @exit

@1:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [EDI], AL
  INC     EDI
  LOOP    @1

@exit:
  POP     EDI
end;

procedure _FillAlphaRect(Src: Pointer; W, H, X1, Y1, X2, Y2: Integer; Alpha: byte);
asm
  PUSH    EDI
  PUSH    EAX
  PUSH    EBX
  PUSH    ECX
  PUSH    EDX

  MOV     EDI, EAX
  XOR     EBX, EBX
  XOR     EAX, EAX
  MOV     EBX, W
  MOV     EAX, Y1
  MUL     EBX
  ADD     EAX, X1
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX
  ADD     EDI, EAX

  MOV     EBX, X2
  SUB     EBX, X1
  INC     EBX
  TEST    EBX,EBX
  JS      @exit

  MOV     EDX, Y2
  SUB     EDX, Y1
  INC     EDX
  TEST    EDX,EDX
  JS      @exit
  mov     al, alpha

@1:
  PUSH    EDI
  MOV     ECX, EBX

@2:
  INC     EDI
  INC     EDI
  INC     EDI
  MOV     [EDI], AL
  INC     EDI
  LOOP    @2
 
  POP     EDI
  POP     ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  ADD     EDI, ECX
  PUSH    ECX
  DEC     EDX
  CMP     EDX, 0
  JNE     @1

@exit:
  POP     EDX
  POP     ECX
  POP     EBX
  POP     EAX
  POP     EDI
end;

function _PixelAlphaBlend(F, B: TseColor): TseColor;
asm
  { Test Fa = 255  }
  CMP     EAX,$FF000000   // Fa = 255 ? => Result = EAX
  JNC     @2
  { Test Fa = 0 ? }
  TEST    EAX,$FF000000
  JZ      @1

  MOV     ECX,EAX
  SHR     ECX,24          // CL=Fa

  PUSH    EBX

  PUSH    EAX
  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  { EAX = BlendPixel.R and BlendPixel.B }
  POP     EBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  { EBX = BlendPixel.G }
  OR      EAX,EBX
  POP     EBX

  RET
@1:
  MOV     EAX,EDX
@2:
  RET
end;

procedure _LineAlphaBlend(Src, Dst: PseColor; Count: Integer);
asm
  TEST    ECX,ECX
  JS      @4

  PUSH    EBX
  PUSH    ESI
  PUSH    EDI

  MOV     ESI,EAX
  MOV     EDI,EDX


@1:
  MOV     EAX,[ESI]
  MOV     EDX,[EDI]
  TEST    EAX,$FF000000
  JZ      @3

  PUSH    ECX

  MOV     ECX,EAX
  SHR     ECX,24

  CMP     ECX,$FF
  JZ      @2

  PUSH    EAX

  AND     EAX,$00FF00FF
  IMUL    EAX,ECX
  MOV     EBX, EDX
  AND     EBX,$00FF00FF
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EAX, EBX
  AND     EAX,$FF00FF00
  SHR     EAX, 8
  {BlendPixel.R b BlendPixel.B - EAX}
  POP     EBX
  AND     EBX,$0000FF00
  AND     EDX,$0000FF00
  SHR     EBX, 8
  SHR     EDX, 8
  IMUL    EDX, ECX
  XOR     ECX,$000000FF
  IMUL    EBX, ECX
  ADD     EBX, EDX
  AND     EBX,$0000FF00
  ADD     EBX,$FF000000
  {BlendPixel.G - EBX}
  OR      EAX,EBX
  {BlendPixel - EAX}
@2:
  MOV     [EDI],EAX

  POP     ECX             // restore counter
@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     EDI
  POP     ESI
  POP     EBX
@4:
  RET
end;

procedure _LineTransparent(Src, Dst: PseColor; Count: Integer);
asm
  TEST    ECX,ECX
  JS      @4

  PUSH    ESI
  PUSH    EDI
  PUSH    EBX

  MOV     EBX, seTransparent
  MOV     ESI,EAX
  MOV     EDI,EDX

@1:
  MOV     EAX,[ESI]
  MOV     EDX, EAX

  AND     EAX, NOT ALPHAMASK
  CMP     EAX, EBX
  JE      @3

  OR      EDX, AlphaMask
  MOV     [EDI], EDX

@3:
  ADD     ESI,4
  ADD     EDI,4

  DEC     ECX
  JNZ     @1

  POP     EBX
  POP     EDI
  POP     ESI

@4:
  RET
end;

{ MMX =========================================================================}

function Mmx_PixelAlphaBlend(F, B: TseColor): TseColor;
asm
  db $0F,$6E,$C0          // MOVD    MM0, EAX
  db $0F,$6E,$D2          // MOVD    MM2, EDX
  db $0F,$EF,$DB          // PXOR    MM3, MM3
  db $0F,$60,$C3          // PUNPCKLBW MM0, MM3
  db $0F,$60,$D3          // PUNPCKLBW MM2, MM3
  db $0F,$6F,$C8          // MOVQ      MM1,MM0
  db $0F,$69,$C9          // PUNPCKHWD MM1,MM1
  db $0F,$6A,$C9          // PUNPCKHDQ MM1,MM1
  db $0F,$F9,$C2          // PSUBW   MM0,MM2
  db $0F,$D5,$C1          // PMULLW  MM0,MM1
  db $0F,$71,$F2,$08      // PSLLW   MM2, 8
  db $0F,$FD,$D0          // PADDW   MM2, MM0
  db $0F,$71,$D2,$08      // PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  db $0F,$7E,$D0          // MOVD      EAX,MM2
end;

procedure Mmx_LineAlphaBlend(Src, Dst: PseColor; Count: Integer);
asm
  TEST      ECX,ECX
  JS        @4

  PUSH      ESI
  PUSH      EDI

  MOV       ESI,EAX
  MOV       EDI,EDX
@1:
  MOV       EAX,[ESI]
  TEST      EAX,$FF000000
  JZ        @3
  CMP       EAX,$FF000000
  JNC       @2

  db $0F,$6E,$C0          // MOVD    MM0, EAX
  db $0F,$6E,$17          // MOVD    MM2, [EDI]
  db $0F,$EF,$DB          // PXOR    MM3, MM3
  db $0F,$60,$C3          // PUNPCKLBW MM0, MM3
  db $0F,$60,$D3          // PUNPCKLBW MM2, MM3
  db $0F,$6F,$C8          // MOVQ      MM1,MM0
  db $0F,$69,$C9          // PUNPCKHWD MM1,MM1
  db $0F,$6A,$C9          // PUNPCKHDQ MM1,MM1
  db $0F,$F9,$C2          // PSUBW   MM0,MM2
  db $0F,$D5,$C1          // PMULLW  MM0,MM1
  db $0F,$71,$F2,$08      // PSLLW   MM2, 8
  db $0F,$FD,$D0          // PADDW   MM2, MM0
  db $0F,$71,$D2,$08      // PSRLW   MM2,8
  db $0F,$67,$D3          // C0PACKUSWB  MM2,MM3
  db $0F,$7E,$D0          // MOVD      EAX,MM2

@2:
  MOV       [EDI],EAX
@3:
  ADD       ESI,4
  ADD       EDI,4

  DEC       ECX
  JNZ       @1

  POP       EDI
  POP       ESI
@4:
  RET
end;

{ Initialization ==============================================================}

procedure SetupLowLevel;
begin
  if HasMMX then
  begin
    { MMX }
    PixelAlphaBlendFunc := Mmx_PixelAlphaBlend;
    LineAlphaBlendFunc := Mmx_LineAlphaBlend;
    LineTransparentFunc := _LineTransparent;

    MoveLongwordFunc := _MoveLongword;
    FillLongwordFunc := _FillLongword;
    FillLongwordRectFunc := _FillLongwordRect;

    FillAlphaFunc := _FillAlpha;
    FillAlphaRectFunc := _FillAlphaRect;

    ClearAlphaFunc := _ClearAlpha;
  end
  else
  begin
    { Non-MMX }
    PixelAlphaBlendFunc := _PixelAlphaBlend;
    LineAlphaBlendFunc := _LineAlphaBlend;
    LineTransparentFunc := _LineTransparent;

    MoveLongwordFunc := _MoveLongword;
    FillLongwordFunc := _FillLongword;
    FillLongwordRectFunc := _FillLongwordRect;

    FillAlphaFunc := _FillAlpha;
    FillAlphaRectFunc := _FillAlphaRect;

    ClearAlphaFunc := _ClearAlpha;
  end;
end;



function _GetBitsFromDC(DC: HDC; var Width, Height, BitCount: integer): Pointer;
var
  Bitmap: HBITMAP;
  DIB: TDIBSection;
begin
  Result := nil;
  Width := 0;
  Height := 0;
  BitCount := 0;

  Bitmap := GetCurrentObject(DC, OBJ_BITMAP);
  if Bitmap <> 0 then
  begin
    if GetObject(Bitmap, SizeOf(DIB), @DIB) = SizeOf(DIB) then
    begin
      Result := DIB.dsBm.bmBits;
      Width := DIB.dsBmih.biWidth;
      Height := DIB.dsBmih.biHeight;
      BitCount := DIB.dsBmih.biBitCount;
    end;
  end;
end;


{ DC functions ================================================================}


procedure _StretchToDCOpaque(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
begin
  SetStretchBltMode(DstDC, COLORONCOLOR);
  StretchBlt(DstDC, DstX, DstY, DstW, DstH, SrcBmp.DC, SrcX, SrcY, SrcW, SrcH, SRCCOPY);
end;

procedure _StretchToDCAlphaBlend(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
var
  SrcRect, DstRect: TRect;
  ResBmp: TseBitmap;
begin
  { Stretch }
  SrcRect := Rect(SrcX, SrcY, SrcX + SrcW, SrcY + SrcH);
  DstRect := Rect(DstX, DstY, DstX + DstW, DstY + DstH);
  { Stretch }
  ResBmp := TseBitmap.Create;
  ResBmp.SetSize(DstW, DstH);
  { Copy from DstDC  }
  BitBlt(ResBmp.DC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Draw bitmap transparent to ResBmp }
  SrcBmp.Draw(ResBmp, Rect(0, 0, DstW, DstH), SrcRect);
  { Draw ResBmp }
  BitBlt(DstDC, DstRect.Left, DstRect.Top, DstW, DstH, ResBmp.DC, 0, 0, SRCCOPY);
  { Free resource }
  ResBmp.Free;
end;

procedure _StretchToDCTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
var
  SrcRect, DstRect: TRect;
  ResBmp: TseBitmap;
begin
  { Stretch }
  SrcRect := Rect(SrcX, SrcY, SrcX + SrcW, SrcY + SrcH);
  DstRect := Rect(DstX, DstY, DstX + DstW, DstY + DstH);
  { Stretch }
  ResBmp := TseBitmap.Create;
  ResBmp.SetSize(DstW, DstH);
  { Copy DstDC  }
  BitBlt(ResBmp.DC, 0, 0, DstW, DstH, DstDC, DstX, DstY, SRCCOPY);
  { Draw bitmap transparent to ResBmp }
  SrcBmp.Draw(ResBmp, Rect(0, 0, DstW, DstH), SrcRect);
  { Draw ResBmp }
  BitBlt(DstDC, DstRect.Left, DstRect.Top, DstW, DstH, ResBmp.DC, 0, 0, SRCCOPY);
  { Free resource }
  ResBmp.Free;
end;

procedure MsImg_StretchToDCTransparent(DstDC: HDC; DstX, DstY, DstW, DstH: Integer;
  SrcBmp: TseBitmap; SrcX, SrcY, SrcW, SrcH: Integer);
begin
  { Use Win2k, WinXP TransparentBlt }
  TransparentBltFunc(DstDC, DstX, DstY, DstW, DstH, SrcBmp.DC, SrcX, SrcY,
    SrcW, SrcH, seTransparent);
end;


{ Dib Routines ================================================================}


procedure _BltToDibOpaque(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TseBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PseColor;
  W, H, Y: Integer;
begin
  if Src = nil then Exit;
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  if SrcP = nil then Exit;
  { 32-bit -DIB }
  DstP := @PseColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    MoveLongwordFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
  end;
end;

procedure _BltToDibTransparent(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TseBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PseColor;
  W, H, Y: Integer;
begin
  if Src = nil then Exit;
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  if SrcP = nil then Exit;
  { 32-bit -DIB }
  DstP := @PseColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    LineTransparentFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
  end;
end;

procedure _BltToDibAlphaBlend(Bits: Pointer; DstX, DstY, BitsW, BitsH: integer;
  Src: TseBitmap; SrcRect: TRect); overload;
var
  SrcP, DstP: PseColor;
  W, H, Y: Integer;
begin
  if Src = nil then Exit;
  { Internal routine }
  W := RectWidth(SrcRect);
  H := RectHeight(SrcRect);
  { Source bitmap }
  SrcP := Src.PixelPtr[SrcRect.Left, SrcRect.Top];
  if SrcP = nil then Exit;
  { 32-bit -DIB }
  DstP := @PseColorArray(Bits)[DstX + (BitsH - DstY - 1) * BitsW];
  for Y := 0 to H - 1 do
  begin
    LineAlphaBlendFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Dec(DstP, BitsW);
  end;
end;

procedure _StretchToDibOpaque(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TseBitmap; SrcRect: TRect); overload;
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PseColorArray;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      _BltToDibOpaque(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      DstLine := @PseColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do DstLine[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end
        else
          MoveLongwordFunc(@DstLine[-BitsW], @DstLine[0], DstClipW);
        Dec(DstLine, BitsW);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchToDibTransparent(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TseBitmap; SrcRect: TRect); overload;
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PseColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      Assert(Bits<>nil);
      Assert(Src<>nil);
      _BltToDibTransparent(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := @PseColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineTransparentFunc(@Buffer[0], @DstLine[0], DstClipW);

        Dec(DstLine, BitsW);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchToDibAlphaBlend(Bits: Pointer; DstRect, DstClip: TRect;
  BitsW, BitsH: integer; Src: TseBitmap; SrcRect: TRect); overload;
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PseColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, BitsW, BitsH));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      _BltToDibAlphaBlend(Bits, DstClip.Left, DstClip.Top, BitsW, BitsH,
        Src, SrcRect);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Round(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := @PseColorArray(Bits)[DstClip.Left + (BitsH - DstClip.Top - 1) * BitsW];
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Round(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineAlphaBlendFunc(@Buffer[0], @DstLine[0], DstClipW);

        Dec(DstLine, BitsW);
      end;
    end;
  finally
    EMMS;
  end;
end;


{ seBitmap functions =========================================================}


procedure _BltOpaque(Dst: TseBitmap; DstRect: TRect;
  Src: TseBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PseColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP<>nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP<>nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    MoveLongwordFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure _BltTransparent(Dst: TseBitmap; DstRect: TRect;
  Src: TseBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PseColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP<>nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP<>nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    LineTransparentFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure _BltAlphaBlend(Dst: TseBitmap; DstRect: TRect;
  Src: TseBitmap; SrcX, SrcY: Integer); overload;
var
  SrcP, DstP: PseColor;
  W, DstY: Integer;
begin
  { Internal routine }
  W := DstRect.Right - DstRect.Left;
  SrcP := Src.PixelPtr[SrcX, SrcY];
  Assert(SrcP<>nil);
  DstP := Dst.PixelPtr[DstRect.Left, DstRect.Top];
  Assert(DstP<>nil);
  for DstY := DstRect.Top to DstRect.Bottom - 1 do
  begin
    LineAlphaBlendFunc(SrcP, DstP, W);
    Inc(SrcP, Src.Width);
    Inc(DstP, Dst.Width);
  end;
end;

procedure _StretchOpaque(Dst: TseBitmap; DstRect, DstClip: TRect;
  Src: TseBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PseColorArray;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltOpaqueFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      DstLine := PseColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale)
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do DstLine[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end
        else
          MoveLongwordFunc(@DstLine[-Dst.Width], @DstLine[0], DstClipW);
        Inc(DstLine, Dst.Width);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchTransparent(Dst: TseBitmap; DstRect, DstClip: TRect;
  Src: TseBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PseColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltTransparentFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := PseColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineTransparentFunc(@Buffer[0], @DstLine[0], DstClipW);

        Inc(DstLine, Dst.Width);
      end;
    end;
  finally
    EMMS;
  end;
end;

procedure _StretchAlphaBlend(Dst: TseBitmap; DstRect, DstClip: TRect;
  Src: TseBitmap; SrcRect: TRect);
var
  R: TRect;
  SrcW, SrcH, DstW, DstH, DstClipW, DstClipH: Integer;
  SrcY, OldSrcY: Integer;
  I, J: Integer;
  MapHorz: array of Integer;
  SrcLine, DstLine: PseColorArray;
  Buffer: TArrayOfseColor;
  Scale: Single;
begin
  if IsRectEmpty(SrcRect) then Exit;
  IntersectRect(DstClip, DstClip, Rect(0, 0, Dst.Width, Dst.Height));
  IntersectRect(DstClip, DstClip, DstRect);
  if IsRectEmpty(DstClip) then Exit;
  IntersectRect(R, DstClip, DstRect);
  if IsRectEmpty(R) then Exit;
  if (SrcRect.Left < 0) or (SrcRect.Top < 0) or (SrcRect.Right > Src.Width) or
    (SrcRect.Bottom > Src.Height) then Exit;

  SrcW := SrcRect.Right - SrcRect.Left;
  SrcH := SrcRect.Bottom - SrcRect.Top;
  DstW := DstRect.Right - DstRect.Left;
  DstH := DstRect.Bottom - DstRect.Top;
  DstClipW := DstClip.Right - DstClip.Left;
  DstClipH := DstClip.Bottom - DstClip.Top;
  try
    if (SrcW = DstW) and (SrcH = DstH) then
    begin
      { Copy without resampling }
      BltAlphaBlendFunc(Dst, DstClip, Src, SrcRect.Left + DstClip.Left - DstRect.Left,
        SrcRect.Top + DstClip.Top - DstRect.Top);
    end
    else
    begin
      SetLength(MapHorz, DstClipW);

      if DstW > 1 then
      begin
        Scale := (SrcW - 1) / (DstW - 1);
        for I := 0 to DstClipW - 1 do
          MapHorz[I] := Trunc(SrcRect.Left + (I + DstClip.Left - DstRect.Left) * Scale);
      end
      else
        MapHorz[0] := (SrcRect.Left + SrcRect.Right - 1) div 2;

      if DstH > 1 then Scale := (SrcH - 1) / (DstH - 1)
      else Scale := 0;

      SetLength(Buffer, DstClipW);
      DstLine := PseColorArray(Dst.PixelPtr[DstClip.Left, DstClip.Top]);
      OldSrcY := -1;
      for J := 0 to DstClipH - 1 do
      begin
        if DstH > 1 then
        begin
          EMMS;
          SrcY := Trunc(SrcRect.Top + (J + DstClip.Top - DstRect.Top) * Scale);
        end
        else
          SrcY := (SrcRect.Top + SrcRect.Bottom - 1) div 2;
        if SrcY <> OldSrcY then
        begin
          SrcLine := Src.ScanLine[SrcY];
          for I := 0 to DstClipW - 1 do Buffer[I] := SrcLine[MapHorz[I]];
          OldSrcY := SrcY;
        end;

        LineAlphaBlendFunc(@Buffer[0], @DstLine[0], DstClipW);

        Inc(DstLine, Dst.Width);
      end;
    end;
  finally
    EMMS;
  end;
end;

{ Setup functions =============================================================}

function GetCurrentColorDepth : Integer;
var
  topDC : HDC;
begin
  topDC:=GetDC(0);
  try
    Result:=GetDeviceCaps(topDC, BITSPIXEL)*GetDeviceCaps(topDC, PLANES);
  finally
    ReleaseDC(0, topDC);
  end;
end;

function IsTrueColor: boolean;
begin
  Result := GetCurrentColorDepth >= 24;
end;

procedure SetupFunctions;
begin
  StretchToDCOpaqueFunc := _StretchToDCOpaque;
  StretchToDCAlphaBlendFunc := _StretchToDCAlphaBlend;
  if IsMsImg and IsTrueColor then
    StretchToDCTransparentFunc := MsImg_StretchToDCTransparent
  else
    StretchToDCTransparentFunc := _StretchToDCTransparent;

  StretchToDibOpaqueFunc := _StretchToDibOpaque;
  StretchToDibAlphaBlendFunc := _StretchToDibAlphaBlend;
  StretchToDibTransparentFunc := _StretchToDibTransparent;

  StretchOpaqueFunc := _StretchOpaque;
  StretchAlphaBlendFunc := _StretchAlphaBlend;
  StretchTransparentFunc := _StretchTransparent;
  BltOpaqueFunc := _BltOpaque;
  BltAlphaBlendFunc := _BltAlphaBlend;
  BltTransparentFunc := _BltTransparent;

  GetBitsFromDCFunc := _GetBitsFromDC;
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

initialization
  SetupLowLevel;

  SetupFunctions;

finalization
  FreeBitmapList;

end.
