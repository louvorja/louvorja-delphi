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

unit se_pngimagelist;

{$I se_define.inc}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  Windows, Classes, SysUtils, Controls, Graphics, CommCtrl, ImgList, se_PngImage,
  Messages, se_effect, se_utils,
  se_ani, se_bitmap {$IFDEF VER200},PngImage {$ENDIF};

type
  TsePngImageList = class;

  TsePngImageItem = class(TCollectionItem)
   private
    FPngImage: TsePngImage;
    FName: string;
    procedure SetPngImage(const Value: TsePngImage);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: string read FName write FName;
    property PngImage: TsePngImage read FPngImage write SetPngImage;
  end;

  TsePngImageItems = class(TCollection)
  private
    function GetItem(Index: Integer): TsePngImageItem;
    procedure SetItem(Index: Integer; Value:  TsePngImageItem);
  protected
    function GetOwner: TPersistent; override;
  public
    FPngImageList: TsePngImageList;
    constructor Create(APNGImageList: TsePngImageList);
    property Items[Index: Integer]:  TsePngImageItem read GetItem write SetItem; default;
  end;

  TsePngImageList = class(TCustomImageList)
  private
    FPngImages: TsePngImageItems;
    function GetPngWidth: Integer;
    function GetPngHeight: Integer;
    procedure SetPngWidth(Value: Integer);
    procedure SetPngHeight(Value: Integer);
    procedure SetPngImages(Value: TsePngImageItems);
  protected
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean = True); override;
    procedure InsertBitMap(Index: Integer);
    procedure DeleteBitMap(Index: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property PngImages: TsePngImageItems read FPngImages write SetPngImages;
    property PngWidth: Integer read GetPngWidth write SetPngWidth;
    property PngHeight: Integer read GetPngHeight write SetPngHeight;
  end;

   TsePngImageStorage = class;

   TsePngStorageImageItem = class(TCollectionItem)
   private
    FPngImage: TsePngImage;
    FName: string;
    procedure SetPngImage(const Value: TsePngImage);
    function GetWidth: Integer;
    function GetHeight: Integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: string read FName write FName;
    property PngImage: TsePngImage read FPngImage write SetPngImage;
    property PngWidth: Integer read GetWidth;
    property PngHeight: Integer read  GetHeight;
  end;

  TsePngStorageImageItems = class(TCollection)
  private
    function GetItem(Index: Integer): TsePngStorageImageItem;
    procedure SetItem(Index: Integer; Value:  TsePngStorageImageItem);
  protected
    function GetOwner: TPersistent; override;
  public
    FPngImageList: TsePngImageStorage;
    constructor Create(APNGImageList: TsePngImageStorage);
    property Items[Index: Integer]:  TsePngStorageImageItem read GetItem write SetItem; default;
  end;

  TsePngImageStorage = class(TComponent)
  private
    FPngImages: TsePngStorageImageItems;
    procedure SetPngImages(Value: TsePngStorageImageItems);
  public
    procedure Draw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Enabled: Boolean = True);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property PngImages: TsePngStorageImageItems read FPngImages write SetPngImages;
  end;



  
implementation

procedure TsePngImageItem.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (Dest is TsePngImageItem)
  then
    TsePngImageItem(Dest).PngImage := PngImage;
end;

constructor TsePngImageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPngImage := TsePngImage.Create;
  FName := Format('PngImage%d', [Index]);
  TsePngImageItems(Self.Collection).FPngImageList.InsertBitmap(Index);
end;

destructor TsePngImageItem.Destroy;
begin
  FPngImage.Free;
  if TsePngImageItems(Self.Collection).FPngImageList.Count > Index
  then
    TsePngImageItems(Self.Collection).FPngImageList.DeleteBitmap(Index);
  inherited Destroy;
end;

procedure TsePngImageItem.Assign(Source: TPersistent);
begin
  if Source is TsePngImageItem
  then
    begin
      PngImage.Assign(TsePngImageItem(Source).PngImage);
      Name := TsePngImageItem(Source).Name;
   end
  else
    inherited Assign(Source);
end;

function TsePngImageItem.GetDisplayName: string;
begin
  if Length(FName) = 0
  then Result := inherited GetDisplayName
  else Result := FName;
end;

procedure TsePngImageItem.SetPngImage(const Value: TsePngImage);
begin
  FPngImage.Assign(Value);
  Changed(True);
end;

constructor TsePngImageItems.Create;
begin
  inherited Create(TsePngImageItem);
  FPngImageList := APngImageList;
end;


function TsePngImageItems.GetOwner: TPersistent;
begin
  Result := FPngImageList;
end;

function TsePngImageItems.GetItem(Index: Integer): TsePngImageItem;
begin
  Result := TsePngImageItem(inherited GetItem(Index));
end;

procedure TsePngImageItems.SetItem;
begin
  inherited SetItem(Index, Value);
end;

constructor TsePngImageList.Create(AOwner: TComponent);
begin
  inherited;
  FPngImages := TsePngImageItems.Create(Self);
end;

destructor TsePngImageList.Destroy;
begin
  FPngImages.Free;
  FPngImages := nil;
  inherited;
end;

function TsePngImageList.GetPngWidth: Integer;
begin
  Result := Width;
end;

function TsePngImageList.GetPngHeight: Integer;
begin
  Result := Height;
end;

procedure TsePngImageList.SetPngWidth(Value: Integer);
begin
  if Width <> Value
  then
    begin
      Width := Value;
      if not (csLoading in ComponentState)
      then
        FPngImages.Clear;
    end;
end;

procedure TsePngImageList.SetPngHeight(Value: Integer);
begin
  if Height <> Value
  then
    begin
      Height := Value;
      if not (csLoading in ComponentState)
      then
      FPngImages.Clear;
    end;
end;


procedure TsePngImageList.SetPngImages(Value: TsePngImageItems);
begin
  FPngImages.Assign(Value);
end;

procedure TsePngImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean);

procedure MakeImageBlended(Image: TsePngImage; Amount: Byte = 127);

  procedure ForceAlphachannel(BitTransparency: Boolean; TransparentColor: TColor);
  var
     Assigner: TBitmap;
     Temp: TsePngImage;
     X, Y: Integer;
     {$IFNDEF VER200}
     Line: se_pngimage.PByteArray;
     {$ELSE}
     Line: PByteArray;
     {$ENDIF}
     Current: TColor;
  begin
  Temp := TsePngImage.Create;
  try
    Assigner := TBitmap.Create;
    try
      Assigner.Width := Image.Width;
      Assigner.Height := Image.Height;
      Temp.Assign(Assigner);
    finally
      Assigner.Free;
     end;
    Temp.CreateAlpha;
    for Y := 0 to Image.Height - 1
    do begin
       Line := Temp.AlphaScanline[Y];
       for X := 0 to Image.Width - 1
       do begin
          Current := Image.Pixels[X, Y];
          Temp.Pixels[X, Y] := Current;
          if BitTransparency and (Current = TransparentColor)
          then Line^[X] := 0
          else Line^[X] := Amount;
          end;
       end;
    Image.Assign(Temp);
  finally
    Temp.Free;
   end;
  end;

var
   X, Y: Integer;
   {$IFNDEF VER200}
   Line: se_pngimage.PByteArray;
   {$ELSE}
   Line: PByteArray;
   {$ENDIF}
   Forced: Boolean;
   TransparentColor: TColor;
   BitTransparency: Boolean;
begin
  {$IFNDEF VER200}
  BitTransparency := Image.TransparencyMode = bsptmBit;
  {$ELSE}
  BitTransparency := Image.TransparencyMode = ptmBit;
  {$ENDIF}
  TransparentColor := Image.TransparentColor;
  if not (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
    begin
      Forced := Image.Header.ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE];
      if Forced
      then
        ForceAlphachannel(BitTransparency, TransparentColor)
      else
        Image.CreateAlpha;
    end
  else
   Forced := False;

  if not Forced and (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
     for Y := 0 to Image.Height - 1 do
     begin
       Line := Image.AlphaScanline[Y];
       for X := 0 to Image.Width - 1 do
         if BitTransparency and (Image.Pixels[X, Y] = TransparentColor)
         then
           Line^[X] := 0
         else
           Line^[X] := Round(Line^[X] / 256 * (Amount + 1));
     end;
end;

procedure DrawPNG(Png: TsePngImage; Canvas: TCanvas; const Rect: TRect; AEnabled: Boolean);
var
  PngCopy: TsePngImage;
begin
  if not AEnabled
  then
   begin
     PngCopy := TsePngImage.Create;
     try
       PngCopy.Assign(Png);
       MakeImageBlended(PngCopy);
       PngCopy.Draw(Canvas, Rect);
     finally
       PngCopy.Free;
      end;
    end
  else
    Png.Draw(Canvas, Rect);
end;


var
  PaintRect: TRect;
  Png: TsePngImageItem;
begin
  PaintRect := Rect(X, Y, X + Width, Y + Height);
  Png := TsePngImageItem(FPngImages.Items[Index]);
  if Png <> nil
  then
    DrawPNG(Png.PngImage, Canvas, PaintRect, Enabled);
end;

procedure TsePngImageList.InsertBitMap(Index: Integer);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Monochrome := True;
  B.Width := Width;
  B.height := Height;
  Insert(Index, B, nil);
  B.Free;
end;

procedure TsePngImageList.DeleteBitMap(Index: Integer);
begin
  Delete(Index);
end;



// TbsPngImageStorage

procedure TsePngStorageImageItem.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (Dest is TsePngStorageImageItem)
  then
    TsePngStorageImageItem(Dest).PngImage := PngImage;
end;

constructor TsePngStorageImageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPngImage := TsePngImage.Create;
  FName := Format('PngImage%d', [Index]);
end;

destructor TsePngStorageImageItem.Destroy;
begin
  FPngImage.Free;
  inherited Destroy;
end;

function TsePngStorageImageItem.GetWidth: Integer;
begin
  Result := FPngImage.Width;
end;

function TsePngStorageImageItem.GetHeight: Integer;
begin
  Result := FPngImage.Height;
end;


procedure TsePngStorageImageItem.Assign(Source: TPersistent);
begin
  if Source is TsePngStorageImageItem
  then
    begin
      PngImage.Assign(TsePngStorageImageItem(Source).PngImage);
      Name := TsePngStorageImageItem(Source).Name;
   end
  else
    inherited Assign(Source);
end;

function TsePngStorageImageItem.GetDisplayName: string;
begin
  if Length(FName) = 0
  then Result := inherited GetDisplayName
  else Result := FName;
end;

procedure TsePngStorageImageItem.SetPngImage(const Value: TsePngImage);
begin
  FPngImage.Assign(Value);
  Changed(True);
end;

constructor TsePngStorageImageItems.Create;
begin
  inherited Create(TsePngStorageImageItem);
  FPngImageList := APngImageList;
end;

function TsePngStorageImageItems.GetOwner: TPersistent;
begin
  Result := FPngImageList;
end;

function TsePngStorageImageItems.GetItem(Index: Integer): TsePngStorageImageItem;
begin
  Result := TsePngStorageImageItem(inherited GetItem(Index));
end;

procedure TsePngStorageImageItems.SetItem;
begin
  inherited SetItem(Index, Value);
end;

constructor TsePngImageStorage.Create(AOwner: TComponent);
begin
  inherited;
  FPngImages := TsePngStorageImageItems.Create(Self);
end;

destructor TsePngImageStorage.Destroy;
begin
  FPngImages.Free;
  FPngImages := nil;
  inherited;
end;

procedure TsePngImageStorage.SetPngImages(Value: TsePngStorageImageItems);
begin
  FPngImages.Assign(Value);
end;

procedure TsePngImageStorage.Draw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Enabled: Boolean);

procedure MakeImageBlended(Image: TsePngImage; Amount: Byte = 127);

  procedure ForceAlphachannel(BitTransparency: Boolean; TransparentColor: TColor);
  var
     Assigner: TBitmap;
     Temp: TsePngImage;
     X, Y: Integer;
     {$IFNDEF VER200}
     Line: se_pngimage.PByteArray;
     {$ELSE}
     Line: PByteArray;
     {$ENDIF}
     Current: TColor;
  begin
  Temp := TsePngImage.Create;
  try
    Assigner := TBitmap.Create;
    try
      Assigner.Width := Image.Width;
      Assigner.Height := Image.Height;
      Temp.Assign(Assigner);
    finally
      Assigner.Free;
     end;
    Temp.CreateAlpha;
    for Y := 0 to Image.Height - 1
    do begin
       Line := Temp.AlphaScanline[Y];
       for X := 0 to Image.Width - 1
       do begin
          Current := Image.Pixels[X, Y];
          Temp.Pixels[X, Y] := Current;
          if BitTransparency and (Current = TransparentColor)
          then Line^[X] := 0
          else Line^[X] := Amount;
          end;
       end;
    Image.Assign(Temp);
  finally
    Temp.Free;
   end;
  end;

var
   X, Y: Integer;
   {$IFNDEF VER200}
   Line: se_pngimage.PByteArray;
   {$ELSE}
   Line: PByteArray;
   {$ENDIF}
   Forced: Boolean;
   TransparentColor: TColor;
   BitTransparency: Boolean;
begin
  {$IFNDEF VER200}
  BitTransparency := Image.TransparencyMode = bsptmBit;
  {$ELSE}
  BitTransparency := Image.TransparencyMode = ptmBit;
  {$ENDIF}
  TransparentColor := Image.TransparentColor;
  if not (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
    begin
      Forced := Image.Header.ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE];
      if Forced
      then
        ForceAlphachannel(BitTransparency, TransparentColor)
      else
        Image.CreateAlpha;
    end
  else
   Forced := False;

  if not Forced and (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
     for Y := 0 to Image.Height - 1 do
     begin
       Line := Image.AlphaScanline[Y];
       for X := 0 to Image.Width - 1 do
         if BitTransparency and (Image.Pixels[X, Y] = TransparentColor)
         then
           Line^[X] := 0
         else
           Line^[X] := Round(Line^[X] / 256 * (Amount + 1));
     end;
end;

procedure DrawPNG(Png: TsePngImage; Canvas: TCanvas; const Rect: TRect; AEnabled: Boolean);
var
  PngCopy: TsePngImage;
begin
  if not AEnabled
  then
   begin
     PngCopy := TsePngImage.Create;
     try
       PngCopy.Assign(Png);
       MakeImageBlended(PngCopy);
       PngCopy.Draw(Canvas, Rect);
     finally
       PngCopy.Free;
      end;
    end
  else
    Png.Draw(Canvas, Rect);
end;


var
  PaintRect: TRect;
  Png: TsePngImageItem;
begin
  PaintRect := Rect(X, Y,
    X + FPngImages.Items[Index].PngWidth,
    Y + FPngImages.Items[Index].PngHeight);
  Png := TsePngImageItem(FPngImages.Items[Index]);
  if Png <> nil
  then
    DrawPNG(Png.PngImage, Canvas, PaintRect, Enabled);
end;


end.
