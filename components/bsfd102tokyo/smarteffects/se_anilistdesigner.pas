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

unit se_anilistdesigner;

{$I se_define.inc}
{$T-,W-,X+,P+}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, Buttons,
  {$IFDEF SE_COMPILER6_UP}
    DesignIntf, DesignWindows, DesignEditors,
  {$ELSE}
    DsgnIntf, 
  {$ENDIF}
  SysUtils, se_ani;

type

{ TseAniListDesignerForm - designer form }

  TseAniListDesignerForm = class(TForm)
  private
    FAnimationList: TseAnimationList;
    FSelected: TseAnimation;

    FList: TListBox;
    FToolbar: TPanel;
    FAddButton: TSpeedButton;
    FDeleteButton: TSpeedButton;
    FDesigner: {$IFDEF SE_COMPILER6_UP} IDesigner {$ELSE} IFormDesigner {$ENDIF};
    procedure BuildAniList;
    procedure DoActivate(Sender: TObject);
    procedure DoClose(Sender: TObject; var Action: TCloseAction);
    procedure DoAddButtonClick(Sender: TObject);
    procedure DoDeleteButtonClick(Sender: TObject);
    procedure DoListClick(Sender: TObject);
    procedure DoListDblClick(Sender: TObject);
    procedure DoItemChange(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function UniqueName(Component: TComponent): String; //override;
  public
    constructor CreateDesigner; virtual;
    destructor Destroy; override;
  end;

  TseAnimationListEditor = class(TDefaultEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb (Index: Integer); override;
    function GetVerb (Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

procedure ShowAniListDesignerForm(const AAnimationList: TseAnimationList;
  const ADesigner: {$IFDEF SE_COMPILER6_UP} IDesigner {$ELSE} IFormDesigner {$ENDIF});
  
implementation {===============================================================}

uses se_anidesignerform;

procedure ShowAniListDesignerForm(const AAnimationList: TseAnimationList;
  const ADesigner: {$IFDEF SE_COMPILER6_UP} IDesigner {$ELSE} IFormDesigner {$ENDIF});
var
  i: integer;
  Form: TCustomForm;
  DesignerForm: TseAniListDesignerForm;
begin
  { Search opened }
  for i := 0 to Screen.FormCount - 1 do
  begin
    Form := Screen.Forms[i];
    if Form is TseAniListDesignerForm then
      if TseAniListDesignerForm(Form).FAnimationList = AAnimationList then
      begin
        Form.Show;
        if Form.WindowState = wsMinimized then
          Form.WindowState := wsNormal;
        Exit;
      end;
  end;
  { Show }
  DesignerForm := TseAniListDesignerForm.CreateDesigner;
  try
    DesignerForm.FDesigner := ADesigner;
    DesignerForm.FSelected := nil;
    DesignerForm.FAnimationList := AAnimationList;
    DesignerForm.Caption := 'Editing component -' + AAnimationList.Name;

    DesignerForm.BuildAniList;
    
    DesignerForm.Show;
  except
    DesignerForm.Free;
    raise;
  end;
end;

{ TseAnimationListEditor }

procedure TseAnimationListEditor.Edit;
begin
  if Assigned(Component) then
    ShowAniListDesignerForm(Component as TseAnimationList, Designer);
end;

procedure TseAnimationListEditor.ExecuteVerb (Index: Integer);
begin
  if Index = 0 then
    Edit;
end;

function TseAnimationListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TseAnimationListEditor.GetVerb (Index: Integer): String;
begin
  if Index = 0 then
    Result := 'Edit...'
  else
    Result := '';
end;


{ TseAniListDesignerForm ========================================================}


constructor TseAniListDesignerForm.CreateDesigner;
begin
  inherited CreateNew(Application);
  Position := poScreenCenter;
  BorderStyle := bsSizeable;

  Width := 220;
  Height := 300;

  OnActivate := DoActivate;
  OnClose := DoClose;

  { Create controls }

  FToolbar := TPanel.Create(Self);
  with FToolbar do
  begin
    Parent := Self;
    Visible := true;
    Align := alTop;
    Height := 30;
    BorderWidth := 4;

    FAddButton := TSpeedButton.Create(Self);
    with FAddButton do
    begin
      Parent := FToolBar;
      Align := alLeft;
      Width := 60;
      Caption := 'Insert';

      OnClick := DoAddButtonClick;
    end;

    FDeleteButton := TSpeedButton.Create(Self);
    with FDeleteButton do
    begin
      Parent := FToolBar;
      Align := alLeft;
      Width := 60;
      Caption := 'Delete';

      OnClick := DoDeleteButtonClick;
    end;
  end;

  FList := TListBox.Create(Self);
  with FList do
  begin
    Parent := Self;
    Visible := true;
    Align := alClient;

    OnClick := DoListClick;
    OnDblClick := DoListDblClick;
  end;
end;

destructor TseAniListDesignerForm.Destroy;
begin
  inherited Destroy;
end;

procedure TseAniListDesignerForm.BuildAniList;
var
  i: integer;
begin
  { Build AniCombo }
  FList.Items.Clear;

  for i := 0 to FAnimationList.Count - 1 do
  begin
    FAnimationList[i].OnInternalChange := DoItemChange;
    FList.Items.Add(FAnimationList[i].Name);
  end;
end;

{ VCL Designer Routines }

procedure TseAniListDesignerForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FAnimationList) then
    Free;
end;

function TseAniListDesignerForm.UniqueName(Component: TComponent): String;
begin
  if FDesigner <> nil then
    Result := FDesigner.UniqueName(Component.ClassName)
  else
    Result := Component.ClassName + IntToStr(Random(100)); 
end;

{ Event handlers }

procedure TseAniListDesignerForm.DoClose(Sender: TObject; var Action: TCloseAction);
begin
  if FDesigner <> nil then FDesigner.Modified;
  Action := caFree;
end;

procedure TseAniListDesignerForm.DoActivate(Sender: TObject);
begin
  { Activate}
end;

procedure TseAniListDesignerForm.DoAddButtonClick(Sender: TObject);
begin
  FSelected := TseAnimation.Create(FAnimationList.Owner);
  FSelected.Name := UniqueName(FSelected);
  
  FAnimationList.Insert(FSelected);
  BuildAniList;
  FList.ItemIndex := FList.Items.Count - 1; 
end;

procedure TseAniListDesignerForm.DoDeleteButtonClick(Sender: TObject);
var
  SaveIndex: integer;
begin
  if FSelected = nil then Exit;
  
  SaveIndex := FList.ItemIndex;

  FAnimationList.Remove(FSelected);
  FSelected.Free;
  FSelected := nil;

  BuildAniList;

  if SaveIndex > 0 then
    FList.ItemIndex := SaveIndex - 1
  else
    FList.ItemIndex := 0;

  if (FAnimationList.Count > 0) and (FList.ItemIndex >= 0) then
    FSelected := FAnimationList[FList.ItemIndex];
end;

procedure TseAniListDesignerForm.DoListClick(Sender: TObject);
begin
  FSelected := FAnimationList.Items[FList.ItemIndex];

  FDesigner.SelectComponent(FSelected);
end;

procedure TseAniListDesignerForm.DoListDblClick(Sender: TObject);
begin
  FSelected := FAnimationList.Items[FList.ItemIndex];

  ShowDesignerForm(FSelected);

  FDesigner.SelectComponent(nil);
  FDesigner.SelectComponent(FSelected);
end;

procedure TseAniListDesignerForm.DoItemChange(Sender: TObject);
var
  SaveIndex: integer;
begin
  SaveIndex := FList.ItemIndex;;
  BuildAniList;
  FList.ItemIndex := SaveIndex;
end;

end.

