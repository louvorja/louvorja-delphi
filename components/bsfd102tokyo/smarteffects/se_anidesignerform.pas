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

unit se_anidesignerform;

{$I se_define.inc}
{$T-,W-,X+,P+}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, Dialogs,
  SysUtils, se_effect, se_bitmap, se_ani;


type

{ TseAnimationDesignerForm - designer form }

  TseAnimationDesignerForm = class(TForm)
  private
    FAniCombo: TComboBox;
    FPreviewButton: TButton;
    FPreviewBox: TGroupBox;
    FPreviewPaint: TPaintBox;
    FSettingBox: TGroupBox;
    FDirectionCombo: TComboBox;
    FTimeEdit: TComboBox;
    FResEdit: TComboBox;
    FTileEdit: TComboBox;
    FBitmap: TImage;
    FBitmapDialog: TOpenDialog;
    FUpdating: boolean;

    FAnimationItem: TseAnimation;
    FSourceImage, FDestImage: TseBitmap;
    procedure BuildAniList;

    procedure DoAniComboChange(Sender: TObject);
    procedure DoPreviewPaint(Sender: TObject);
    procedure DoExecute(Sender: TObject);
    procedure DoTimeChange(Sender: TObject);
    procedure DoDirectionChange(Sender: TObject);
    procedure DoBitmapChange(Sender: TObject);
    procedure DoBitmapButtonClick(Sender: TObject);
    procedure UpdateAnimation;
    procedure UpdateControls;
    procedure SetEnabled;
  protected
  public
    constructor CreateDesigner; virtual;
    destructor Destroy; override;
  end;

procedure ShowDesignerForm(const AAnimationItem: TseAnimation);

implementation {===============================================================}

uses se_utils;

procedure ShowDesignerForm(const AAnimationItem: TseAnimation);
var
  DesignerForm: TseAnimationDesignerForm;
begin
  DesignerForm := TseAnimationDesignerForm.CreateDesigner;
  try
    DesignerForm.FAnimationItem := AAnimationItem;
    DesignerForm.Caption := 'Animation editor';
    DesignerForm.BuildAniList;
    DesignerForm.UpdateControls;
    DesignerForm.ShowModal;
  finally
    DesignerForm.Free;
  end;
end;

{ TseAnimationDesignerForm ========================================================}

constructor TseAnimationDesignerForm.CreateDesigner;
var
  R, TextR: TRect;
  B: TBitmap;
  i: integer;
begin
  inherited CreateNew(Application);
  BorderStyle := TFormBorderStyle(3); { bsDialog }
  Position := poScreenCenter;
  Width := 400;
  Height := 350;

  { Create controls }

  with TLabel.Create(Self) do
  begin
    Parent := Self;
    Visible := true;
    Left := 8;
    Top := 8;
    Width := 49;
    Height := 13;
    Caption := 'Animation:';
  end;

  FAniCombo := TComboBox.Create(Self);
  with FAniCombo do
  begin
    Parent := Self;
    Visible := true;
    Left := 8;
    Top := 26;
    Width := 375;
    Height := 21;
    DropDownCount := 14;
    Style := csDropDownList;
    ItemHeight := 13;
    TabOrder := 0;
    OnChange := DoAniComboChange;
  end;

  FPreviewBox := TGroupBox.Create(Self);
  with FPreviewBox do
  begin
    Parent := Self;
    Visible := true;
    Left := 8;
    Top := 58;
    Width := 181;
    Height := 225;
    Caption := 'Preview:';
    TabOrder := 1;

    FPreviewPaint := TPaintBox.Create(Self);
    with FPreviewPaint do
    begin
      Parent := FPreviewBox;
      Visible := true;
      Left := 8;
      Top := 18;
      Width := 165;
      Height := 145;
      OnPaint := DoPreviewPaint;
    end;

    FPreviewButton := TButton.Create(Self);
    with FPreviewButton do
    begin
      Parent := FPreviewBox;
      Visible := true;
      Left := 53;
      Top := 180;
      Width := 75;
      Height := 25;
      Caption := 'Execute';
      TabOrder := 0;
      OnClick := DoExecute;
    end;
  end;

  FSettingBox := TGroupBox.Create(Self);
  with FSettingBox do
  begin
    Parent := Self;
    Visible := true;
    Left := 194;
    Top := 58;
    Width := 189;
    Height := 225;
    Caption := 'Settings:';
    TabOrder := 2;

    with TLabel.Create(Self) do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 62;
      Width := 45;
      Height := 13;
      Caption := 'Rotation:';
    end;

    with TLabel.Create(Self) do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 106;
      Width := 53;
      Height := 13;
      Caption := 'Resolution:';
    end;

    with TLabel.Create(Self) do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 18;
      Width := 48;
      Height := 13;
      Caption := 'Time (ms):';
    end;

    with TLabel.Create(Self) do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 106;
      Top := 106;
      Width := 51;
      Height := 13;
      Caption := 'Tile Count:';
    end;

    with TLabel.Create(Self) do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 152;
      Width := 48;
      Height := 13;
      Caption := 'Bitmap :';
    end;

    FDirectionCombo := TComboBox.Create(Self);
    with FDirectionCombo do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 78;
      Width := 169;
      Height := 21;
      Style := csDropDownList;
      TabOrder := 0;
      Items.Add('Default');
      Items.Add('Rotate 90');
      Items.Add('Rotate 180');
      Items.Add('Rotate 270');
      OnChange := DoDirectionChange; 
    end;

    FTimeEdit := TComboBox.Create(Self);
    with FTimeEdit do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 34;
      Width := 169;
      Height := 22;

      Style := csDropDownList;
      Items.Clear;
      for i := 3 to 100 do
        Items.Add(IntToStr(i * 50));
      ItemIndex := 10;

      TabOrder := 1;
      OnChange := DoTimeChange;
    end;

    FResEdit := TComboBox.Create(Self);
    with FResEdit do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 122;
      Width := 83;
      Height := 22;

      Style := csDropDownList;
      Items.Clear;
      for i := 1 to 20 do
        Items.Add(IntToStr(i));
      ItemIndex := 0;

      TabOrder := 2;
      OnChange := DoTimeChange;
    end;

    FTileEdit := TComboBox.Create(Self);
    with FTileEdit do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 106;
      Top := 122;
      Width := 73;
      Height := 22;

      Style := csDropDownList;
      Items.Clear;
      for i := 1 to 20 do
        Items.Add(IntToStr(i));
      ItemIndex := 0;

      TabOrder := 3;
      OnChange := DoTimeChange;
    end;

    with TButton.Create(Self) do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 10;
      Top := 174;
      Width := 54;
      Height := 22;
      Caption := 'Browse...';
      OnClick := DoBitmapButtonClick;
    end;

    FBitmap := TImage.Create(Self);
    with FBitmap do
    begin
      Parent := FSettingBox;
      Visible := true;
      Left := 69;
      Top := 152;
      Width := 110;
      Height := 62;
      Stretch := true;

      Picture.OnChange := DoBitmapChange;
    end;
  end;

  FBitmapDialog := TOpenDialog.Create(Self);
  with FBitmapDialog do
  begin
    DefaultExt := GraphicExtension(TGraphic);
    Filter := GraphicFilter(TGraphic);
  end;
  
  with TButton.Create(Self) do
  begin
    Parent := Self;
    Visible := true;
    Left := 159;
    Top := 290;
    Width := 75;
    Height := 25;
    Caption := 'Close';
    ModalResult := 1;
    TabOrder := 3;
  end;

  { Initialize properties }

  R := Rect(10, 10, FPreviewPaint.Width - 10, FPreviewPaint.Height - 10);

  B := TBitmap.Create;
  try
    B.Width := FPreviewPaint.Width;
    B.Height := FPreviewPaint.Height;

    FSourceImage := TseBitmap.Create;
    with FSourceImage do
    begin
      SetSize(FPreviewPaint.Width, FPreviewPaint.Height);

      with B.Canvas do
      begin
        Brush.Color := clWhite;
        Rectangle(0, 0, B.Width, B.Height);
        Font.Name := 'Arial';
        Font.Height := 100;
        Font.Style := [fsBold];
        Font.Color := clBlue;
        TextR := Rect(0, 0, TextWidth('A'), TextHeight('A'));
        RectCenter(TextR, R);
        TextOut(TextR.Left, TextR.Top, 'A');
      end;
      FSourceImage.DrawGraphic(B, Rect(0, 0, Width, Height));
      FSourceImage.SetAlpha($FF);
    end;

    FDestImage := TseBitmap.Create;
    with FDestImage do
    begin
      SetSize(FPreviewPaint.Width, FPreviewPaint.Height);

      with B.Canvas do
      begin
        Brush.Color := clBlue;
        Rectangle(0, 0, B.Width, B.Height);
        Font.Name := 'Arial';
        Font.Height := 100;
        Font.Style := [fsBold];
        Font.Color := clYellow;
        TextR := Rect(0, 0, TextWidth('B'), TextHeight('B'));
        RectCenter(TextR, R);
        TextOut(TextR.Left, TextR.Top, 'B');
      end;
      FDestImage.DrawGraphic(B, Rect(0, 0, Width, Height));
      FDestImage.SetAlpha($FF);
    end;
  finally
    B.Free;
  end;
end;

destructor TseAnimationDesignerForm.Destroy;
begin
  if FAnimationItem <> nil then
  begin
    FAnimationItem.SourceImage := nil;
    FAnimationItem.DestImage := nil;
  end;
  FDestImage.Free;
  FSourceImage.Free;
  inherited Destroy;
end;

procedure TseAnimationDesignerForm.UpdateAnimation;
begin
  if FUpdating then Exit;

  FAnimationItem.Effect := FAniCombo.Items[FAniCombo.ItemIndex];
  FAnimationItem.Time := StrToInt(FTimeEdit.Text);
  FAnimationItem.Rotation := TseRotation(FDirectionCombo.ItemIndex);
  FAnimationItem.Resolution := StrToInt(FResEdit.Text);
  FAnimationItem.TileCount := StrToInt(FTileEdit.Text);
  FAnimationItem.Bitmap.Assign(FBitmap.Picture);
end;

procedure TseAnimationDesignerForm.UpdateControls;
begin
  FUpdating := true;
  try
    FAniCombo.ItemIndex := FAniCombo.Items.IndexOf(FAnimationItem.Effect);
    FTimeEdit.ItemIndex := FTimeEdit.Items.IndexOf(IntToStr(FAnimationItem.Time));
    FDirectionCombo.ItemIndex := Integer(FAnimationItem.Rotation);
    FResEdit.ItemIndex := FResEdit.Items.IndexOf(IntToStr(FAnimationItem.Resolution));
    FTileEdit.ItemIndex := FTileEdit.Items.IndexOf(IntToStr(FAnimationItem.TileCount));
    FBitmap.Picture.Assign(FAnimationItem.Bitmap);

    SetEnabled;
  finally
    FUpdating := false;
  end;
end;

procedure TseAnimationDesignerForm.BuildAniList;
var
  i: integer;
begin
  { Build AniCombo }
  FAniCombo.Items.Clear;

  FAniCombo.Items.Add(SRandomSelection);
  FAniCombo.Items.Add(SBitmap);

  for i := 0 to ProcList.Count - 1 do
    FAniCombo.Items.Add(TseProcItem(ProcList.Items[i]).Name);
end;

procedure TseAnimationDesignerForm.SetEnabled;
begin
  if FAnimationItem = nil then Exit;
end;

procedure TseAnimationDesignerForm.DoAniComboChange(Sender: TObject);
begin
  if (FAnimationItem <> nil) and (FAniCombo.ItemIndex >= 0) then
  begin
    FAnimationItem.Effect := FAniCombo.Items[FAniCombo.ItemIndex];
    SetEnabled;
  end;
end;

procedure TseAnimationDesignerForm.DoPreviewPaint(Sender: TObject);
begin
  FSourceImage.Draw(FPreviewPaint.Canvas, 0, 0);
end;

procedure TseAnimationDesignerForm.DoExecute(Sender: TObject);
begin
  FPreviewButton.Enabled := false;
  try
    with FAnimationItem do
    begin
      SourceImage := FSourceImage;
      DestImage := FDestImage;

      ExecuteImage(FPreviewPaint.Canvas, 0, 0);
    end;
  finally
    FPreviewButton.Enabled := true;
  end;
end;

procedure TseAnimationDesignerForm.DoDirectionChange(Sender: TObject);
begin
  UpdateAnimation;
end;

procedure TseAnimationDesignerForm.DoTimeChange(Sender: TObject);
begin
  UpdateAnimation;
end;

procedure TseAnimationDesignerForm.DoBitmapChange(Sender: TObject);
begin
  UpdateAnimation;
end;

procedure TseAnimationDesignerForm.DoBitmapButtonClick(Sender: TObject);
begin
  if FBitmapDialog.Execute then
  begin
    FBitmap.Picture.LoadFromFile(FBitmapDialog.FileName);
    FBitmap.Invalidate;
  end;
end;

end.

