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

unit se_ani;


//{$DEFINE SE_TRIAL}

{$I se_define.inc}
{$T-,W-,X+,P+}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, se_utils,
  Classes, SysUtils, se_bitmap, se_effect,
  {$IFDEF BSF_SKIN}bsSkinData,{$ENDIF}
  {$IFDEF DSF_SKIN}SkinData,{$ENDIF}ExtCtrls;

type

  TseAnimationList = class;

  TseAnimationState = (asNormal, asExecuting);

{ TseAnimation }

  TseAnimation = class(TseAnimationRec)
  private
    FParent: TseAnimationList;
    FDestImage: TseBitmap;
    FSourceImage: TseBitmap;
    FFreezedControl: TControl;
    FFreezeRect: TRect;
    FFreezeCanvas: TCanvas;
    FOnInternalChange: TNotifyEvent;
    FState: TseAnimationState;
    FOnStart: TNotifyEvent;
    FOnFinish: TNotifyEvent;
    FForceControlUpdate: Boolean;
    procedure SetDestImage(const Value: TseBitmap);
    procedure SetSourceImage(const Value: TseBitmap);
    procedure SetState(const Value: TseAnimationState);
  protected
    procedure DoProgress(Percent: integer);
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetParentComponent(Value: TComponent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    
    procedure Assign(Source: TPersistent); override;

    function IsControlFrozen(AControl: TControl): boolean;
    procedure FreezeControl(AControl: TControl; ARect: TRect; ASourceImage: TseBitmap = nil);
    procedure FreezeControlClient(AControl: TControl; ARect: TRect; ASourceImage: TseBitmap = nil);
    procedure Restore;

    procedure Execute;

    procedure ExecuteImage(Canvas: TCanvas; X, Y: integer);

    procedure ShowDesigner;
    {$IFDEF BSF_SKIN}
    procedure ShowBSFSkinDesigner(ASkinData: TbsSkinData);
    {$ENDIF}
    {$IFDEF DSF_SKIN}
    procedure ShowDSFSkinDesigner(ASkinData: TspSkinData);
    {$ENDIF}
    
    property Parent: TseAnimationList read FParent;
    property OnInternalChange: TNotifyEvent read FOnInternalChange write FOnInternalChange;

    property SourceImage: TseBitmap read FSourceImage write SetSourceImage;
    property DestImage: TseBitmap read FDestImage write SetDestImage;
    property State: TseAnimationState read FState write SetState;
    property ForceControlUpdate: Boolean read FForceControlUpdate write FForceControlUpdate;
  published
    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnFinish: TNotifyEvent read FOnFinish write FOnFinish;
  end;

{ TseAnimationList }

  TseAnimationList = class(TComponent)
  private
    FAnimationList: TList;
    function GetItem(Index: Integer): TseAnimation;
    function GetCount: integer;
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Insert(Item: TseAnimation);
    procedure Remove(Item: TseAnimation);

    property Count: integer read GetCount;
    property Items[Index: Integer]: TseAnimation read GetItem; default;
  end;

implementation {===============================================================}

uses se_grab, se_freeze, se_anidesignerform,
     {$IFDEF BSF_SKIN}se_bsf_anidesignerform,{$ENDIF}
     {$IFDEF DSF_SKIN}se_dsf_anidesignerform,{$ENDIF}Dialogs;

const
 seVersion = '2.30';
 seVersionPropText = 'SmartEffects v. ' + seVersion;

{ TseAnimation ================================================================}


constructor TseAnimation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FForceControlUpdate := False;
end;

destructor TseAnimation.Destroy;
begin
  if FParent <> nil then
    FParent.Remove(Self);

  inherited Destroy;
end;

procedure TseAnimation.Assign(Source: TPersistent);
begin
  if (Source is TseAnimation) then
  begin
  end;

  inherited ;
end;

{$IFDEF BSF_SKIN}
procedure TseAnimation.ShowBSFSkinDesigner(ASkinData: TbsSkinData);
begin
  ShowBSFSkinDesignerForm(Self, ASkinData);
end;
{$ENDIF}

{$IFDEF DSF_SKIN}
procedure TseAnimation.ShowDSFSkinDesigner(ASkinData: TspSkinData);
begin
  ShowDSFSkinDesignerForm(Self, ASkinData);
end;
{$ENDIF}

procedure TseAnimation.ShowDesigner;
begin
  ShowDesignerForm(Self);
end;

procedure TseAnimation.DoProgress(Percent: integer);
begin

end;

type
  THackBitmap = class(TseBitmap);

procedure TseAnimation.ExecuteImage(Canvas: TCanvas; X, Y: integer);
begin
  if FSourceImage = nil then Exit;
  if FSourceImage.Width * FSourceImage.Height = 0 then Exit;
  FSourceImage.SetAlpha($FF);

  { Check }
  if (FFreezeCanvas <> nil) and (FDestImage = nil) then
  begin
    Application.ProcessMessages;
    FDestImage := GrabToseBitmap(FFreezedControl, FFreezeRect);
    FDestImage.SetAlpha($FF);
  end;

  if FDestImage = nil then Exit;
  if FDestImage.Width * FDestImage.Height = 0 then Exit;

  if Assigned(FOnStart) then
  begin
    FOnStart(Self);
    Application.ProcessMessages;
  end;

  FState := asExecuting;

  ExecuteAnimation(Canvas, X, Y, FSourceImage, FDestImage, Self);

  { Draw dest image }
  if FDestImage <> nil
  then
    FDestImage.Draw(Canvas, X, Y);
  FState := asNormal;
  if Assigned(FOnFinish) then FOnFinish(Self);
end;

procedure TseAnimation.Execute;
begin
  if FFreezedControl = nil then Exit;
  if FFreezeCanvas = nil then Exit;
  ExecuteImage(FFreezeCanvas, 0, 0);
end;

{ Main control animation routines }

function TseAnimation.IsControlFrozen(AControl: TControl): boolean;
begin
  Result := (FFreezedControl <> nil) and (FFreezeCanvas <> nil);
end;

procedure TseAnimation.FreezeControl(AControl: TControl; ARect: TRect; ASourceImage: TseBitmap = nil);
var
  ClipRect: TRect;
  Offset, ChildOrigin, ParentOrigin: TPoint;
begin
  if AControl = nil then Exit;

  if IsControlFrozen(AControl) then Exit;

  if (AControl is TGraphicControl) and (AControl.Parent <> nil) then
  begin
    { Graphics control use Parent animation }
    if AControl.Parent.Parent = nil then
      ParentOrigin := Point(AControl.Parent.Left, AControl.Parent.Top)
    else
      ParentOrigin := TWinControl(AControl.Parent.Parent).ClientToScreen(Point(AControl.Parent.Left, AControl.Parent.Top));

    ChildOrigin := TWinControl(AControl.Parent).ClientToScreen(Point(AControl.Left, AControl.Top));
    Offset.X := ChildOrigin.X - ParentOrigin.X;
    Offset.Y := ChildOrigin.Y - ParentOrigin.Y;

    OffsetRect(ARect, Offset.X, Offset.Y);
    AControl := AControl.Parent;
  end;

  FFreezedControl := AControl;
  FFreezeRect := ARect;

  { Clip FreezeRect rect }
  ClipRect := GetRealBoundsRect(AControl);
  OffsetRect(ClipRect, -ClipRect.Left, -ClipRect.Top);
  IntersectRect(FFreezeRect, FFreezeRect, ClipRect);

  { Make SourceImage screenshot }
  if ASourceImage = nil then
    FSourceImage := GrabToseBitmap(FFreezedControl, FFreezeRect)
  else
    FSourceImage := ASourceImage;

  { Freeze }
  FFreezeCanvas := FreezeControlProc(FFreezedControl, FFreezeRect, FSourceImage);
end;

procedure TseAnimation.FreezeControlClient(AControl: TControl; ARect: TRect; ASourceImage: TseBitmap = nil);
var
  ClientRect: TRect;
begin
  ClientRect := GetRealClientRect(AControl);
  with GetClientOrigin(AControl) do
    OffsetRect(ARect, X, Y);

  IntersectRect(ARect, ARect, ClientRect);

  FreezeControl(AControl, ARect, ASourceImage);
end;

procedure TseAnimation.Restore;
begin
  if FFreezedControl = nil then Exit;
  if FFreezeCanvas = nil then Exit;

  { UnFreeze control }

  if (FFreezedControl is TWinControl) and FForceControlUpdate
  then
    SendMessage(TWinControl(FFreezedControl).Handle, WM_SETREDRAW, 0, 0);

  UnFreezeControlProc(FFreezedControl, false);

  if (FFreezedControl is TWinControl) and FForceControlUpdate
  then
    SendMessage(TWinControl(FFreezedControl).Handle, WM_SETREDRAW, 1, 0);

  if (FFreezedControl is TWinControl) and FForceControlUpdate
  then
    RedrawWindow(TWinControl(FFreezedControl).Handle, nil, 0,
                 RDW_INVALIDATE or RDW_ALLCHILDREN or RDW_UPDATENOW);

  FForceControlUpdate := False;

  FFreezeCanvas := nil;
  FFreezedControl := nil;

  FSourceImage.Free;
  FSourceImage := nil;
  FDestImage.Free;
  FDestImage := nil;
end;

{ Overrides }

function TseAnimation.HasParent: Boolean;
begin
  Result := true;
end;

function TseAnimation.GetParentComponent: TComponent;
begin
  Result := FParent;
end;

procedure TseAnimation.SetParentComponent(Value: TComponent);
var
  i: integer;
begin
  if FParent <> nil then FParent.Remove(Self);

  if Value is TseAnimationList then
  begin
    (Value as TseAnimationList).Insert(Self);
  end;
end;

{ Properties }

procedure TseAnimation.SetDestImage(const Value: TseBitmap);
begin
  FDestImage := Value;
  if FDestImage <> nil then FDestImage.SetAlpha($FF);
end;

procedure TseAnimation.SetSourceImage(const Value: TseBitmap);
begin
  FSourceImage := Value;
  if FSourceImage <> nil then FSourceImage.SetAlpha($FF);
end;

procedure TseAnimation.SetName(const NewName: TComponentName);
begin
  inherited;
  if Assigned(FOnInternalChange) then
    FOnInternalChange(Self);
end;

procedure TseAnimation.SetState(const Value: TseAnimationState);
begin
  FState := Value;
end;


{ TseAnimationList ============================================================}


constructor TseAnimationList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAnimationList := TList.Create;
end;

destructor TseAnimationList.Destroy;
var
  i: integer;
begin
  for i := FAnimationList.Count - 1 downto 0 do
    Items[i].Free;

  FAnimationList.Free;
  inherited Destroy;
end;

procedure TseAnimationList.Insert(Item: TseAnimation);
begin
  Item.FParent := Self;
  FAnimationList.Add(Item);
end;

procedure TseAnimationList.Remove(Item: TseAnimation);
begin
  Item.FParent := nil;
  FAnimationList.Remove(Item);
end;

procedure TseAnimationList.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i: integer;
begin
  for i := 0 to Count-1 do
    Proc(Items[i]);
  inherited ;
end;

{ Properties }

function TseAnimationList.GetItem(Index: Integer): TseAnimation;
begin
  Result := TseAnimation(FAnimationList[Index]);
end;

function TseAnimationList.GetCount: integer;
begin
  Result := FAnimationList.Count;
end;

procedure ShowTrialVersion;
begin
  if (Pos('bds.exe', Application.ExeName) = 0) and
     (Pos('delphi32.exe', Application.ExeName) = 0) and
     (Pos('bcb.exe', Application.ExeName) = 0) 
  then
    Application.MessageBox(
     'This application use unregistered SmartEffects VCL!!!',
      'Sorry', mb_OK + mb_IconStop);
end;

initialization

  RegisterClass(TseAnimation);

{$IFDEF SE_TRIAL}
  ShowTrialVersion;
{$ENDIF}

end.



