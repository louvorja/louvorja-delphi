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

unit se_imagelist;

{$I se_define.inc}
{$T-,W-,X+,P+}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  SysUtils, Classes, se_effect, se_ani, Jpeg;

type

  TseImageList = class;

{ TseImageItem }

  TseImageItem = class(TCollectionItem)
  private
    FPicture: TPicture;
    FTag: integer;
    procedure SetPicture(Value: TPicture);
  protected
    function GetDisplayName: string; override;
    procedure OnChange(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Picture: TPicture read FPicture write SetPicture;
    property Tag: integer read FTag write FTag;
  end;

{ TseImageCollection }

  TseImageCollection = class(TCollection)
  private
    FImageList: TseImageList;
    function GetItem(Index: Integer): TseImageItem;
    procedure SetItem(Index: Integer; Value: TseImageItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ImageList: TseImageList);
    function Add: TseImageItem;
    property Items[Index: Integer]: TseImageItem read GetItem write SetItem; default;
  end;

{ TseImageList class }

  TseImageList = class(TComponent)
  private
    FImages: TseImageCollection;
  protected
    procedure Change; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Images: TseImageCollection read FImages write FImages;
  end;

implementation {===============================================================}


{ TseImageItem ===============================================================}


constructor TseImageItem.Create(Collection: TCollection);
begin
  FPicture := TPicture.Create;
  FPicture.OnChange := OnChange;
  inherited;
end;

destructor TseImageItem.Destroy;
begin
  OnChange(Self);
  FPicture.OnChange := nil;
  FPicture.Free;
  inherited;
end;

procedure TseImageItem.Assign(Source: TPersistent);
begin
   if (Source is TseImageItem) then
     FPicture.Assign(TseImageItem(Source).FPicture);

  inherited Assign(Source);
end;

function TseImageItem.GetDisplayName: string;
begin
  Result := inherited GetDisplayName;
end;

procedure TseImageItem.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TseImageItem.OnChange(Sender: TObject);
begin
//  TseImageCollection(Collection).FImageList.Change;
end;


{ TseImageCollection =========================================================}


constructor TseImageCollection.Create(ImageList: TseImageList);
begin
  inherited Create(TseImageItem);
  FImageList := ImageList;
end;

function TseImageCollection.GetItem(Index: Integer): TseImageItem;
begin
  Result := TseImageItem(inherited GetItem(Index));
end;

procedure TseImageCollection.SetItem(Index: Integer; Value: TseImageItem);
begin
  inherited SetItem(Index, Value);
end;

function TseImageCollection.GetOwner: TPersistent;
begin
  Result := FImageList;
end;

procedure TseImageCollection.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
end;

function TseImageCollection.Add: TseImageItem;
begin
  Result := TseImageItem(inherited Add);
end;

{ TseImageList ===============================================================}

constructor TseImageList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImages := TseImageCollection.Create(Self);
end;

destructor TseImageList.Destroy;
begin
  FImages.Free;
  inherited Destroy;
end;

procedure TseImageList.Change;
begin
  { ImageList collection changed }
end;


end.
