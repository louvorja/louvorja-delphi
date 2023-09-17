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

unit se_image;

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}


interface


uses
  Windows, Messages, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  SysUtils, Classes, se_ani, se_imagelist, se_bitmap, Jpeg;

type

{ TseImage }

  TseImage = class(TImage)
  private
    FAnimating: boolean;
    FSavedPicture: TPicture;
    FAnimation: TseAnimation;
    FOldPictureChange: TNotifyEvent;
    FImageIndex: integer;
    FImages: TseImageList;
    procedure SetImageIndex(const Value: integer);
    procedure DoPictureChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure Loaded; override;

    function CalcDestRect(APicture: TPicture): TRect;
    procedure ExecuteAnimation;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Invalidate; override;
  published
    property Animation: TseAnimation read FAnimation write FAnimation;
    property ImageIndex: integer read FImageIndex write SetImageIndex;
    property Images: TseImageList read FImages write FImages;
  end;

  
implementation {===============================================================}

uses se_utils, se_effect;

type

  THackControl = class(TControl);
  THackGraphicControl = class(TGraphicControl);

{ TseImage ==========================================================}

constructor TseImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImageIndex := -1;
  FSavedPicture := TPicture.Create;
  FOldPictureChange := Picture.OnChange;
  Picture.OnChange := DoPictureChange;
end;

procedure TseImage.Loaded;
begin
  inherited;
  FSavedPicture.Assign(Picture);
end;

destructor TseImage.Destroy;
begin
  Picture.OnChange := FOldPictureChange;
  FSavedPicture.Free;
  inherited Destroy;
end;

procedure TseImage.Paint;
begin
  if FAnimating then Exit;
  inherited Paint;
end;

procedure TseImage.Invalidate;
begin
  inherited Invalidate;
end;

procedure TseImage.DoPictureChange(Sender: TObject);
begin
  if Assigned(FOldPictureChange) then FOldPictureChange(Self);

  if AutoSize then Exit;
  
  if csDesigning in ComponentState then Exit;
  if csLoading in ComponentState then Exit;

  ExecuteAnimation;
end;

function TseImage.CalcDestRect(APicture: TPicture): TRect;
begin
  if Stretch then
    Result := ClientRect
  else if Center then
    Result := Bounds((Width - APicture.Width) div 2, (Height - APicture.Height) div 2,
      APicture.Width, APicture.Height)
  else
    Result := Rect(0, 0, APicture.Width, APicture.Height);
end;

procedure TseImage.ExecuteAnimation;
var
  SourceImage, DestImage: TseBitmap;
begin
  if FAnimation = nil then Exit;
  if Picture.Graphic = nil then Exit;
  if FAnimating then Exit;

  FAnimating := true;
  try
    { Empty source }
    SourceImage := TseBitmap.Create;
    SourceImage.SetSize(Width, Height);
    { Draw background }
    if not Stretch or Transparent
    then
    if (FSavedPicture.Width < Width) or
       (FSavedPicture.Width < Height) or Transparent
    then
      GetParentImage(Self, SourceImage.Canvas)
    else
      SourceImage.Clear(seColor(THackControl(Parent).Color));
    { Draw Picture }
    if FSavedPicture.Graphic <> nil then
      SourceImage.DrawGraphic(FSavedPicture.Graphic, CalcDestRect(FSavedPicture));

    DestImage := TseBitmap.Create;
    DestImage.SetSize(Width, Height);
    { Draw background }
    if not Stretch or Transparent
    then
    if (FSavedPicture.Width < Width) or
       (FSavedPicture.Width < Height) or Transparent
    then
      GetParentImage(Self, DestImage.Canvas)
    else
      DestImage.Clear(seColor(THackControl(Parent).Color));
    { Draw Picture }
    DestImage.DrawGraphic(Picture.Graphic, CalcDestRect(Picture));

    { Execute Animation }
    FAnimation.SourceImage := SourceImage;
    FAnimation.DestImage := DestImage;
    FAnimation.ExecuteImage(THackGraphicControl(Self).Canvas, 0, 0);
    FAnimation.SourceImage := nil;
    FAnimation.DestImage := nil;


    { Free resource}
    SourceImage.Free;
    DestImage.Free;

    { Save Picture }
    FSavedPicture.Assign(Picture);
  finally
    FAnimating := false;
  end;
end;

procedure TseImage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FAnimation) then
    FAnimation := nil;
  if (Operation = opRemove) and (AComponent = FImages) then
    FImages := nil;
end;

{ Properties }

procedure TseImage.SetImageIndex(const Value: integer);
var
  NewImage: TPicture;
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if (FImages <> nil) and (FImageIndex >= 0) and (FImageIndex < FImages.Images.Count) then
    begin
      NewImage := FImages.Images[FImageIndex].Picture;
      Picture.Assign(NewImage);
    end
    else
      if not (csLoading in ComponentState) then
        FImageIndex := -1;
  end;
end;

end.

