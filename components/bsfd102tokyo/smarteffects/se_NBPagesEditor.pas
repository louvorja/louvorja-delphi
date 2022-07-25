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

unit se_NBPagesEditor;

{$I se_define.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  se_controls, StdCtrls, ExtCtrls;

type
  TseNBPagesForm = class(TForm)
    PageListBox: TListBox;
    CaptionEdit: TEdit;
    AddButton: TButton;
    DeleteButton: TButton;
    MoveUpButton: TButton;
    MoveDownButton: TButton;
    IIndexBox: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BGDType: TComboBox;
    Label3: TLabel;
    Shape1: TShape;
    ColorDialog1: TColorDialog;
    procedure FormShow(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure PageListBoxClick(Sender: TObject);
    procedure CaptionEditChange(Sender: TObject);
    procedure MoveUpButtonClick(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure IIndexBoxChange(Sender: TObject);
    procedure BGDTypeChange(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    NB: TseNoteBook;
  public
    { Public declarations }
  end;

var
  seNBPagesForm: TseNBPagesForm;

  procedure Execute(ANoteBook: TseNoteBook);

implementation

{$R *.DFM}

procedure Execute(ANoteBook: TseNoteBook);
begin
  seNBPagesForm := TseNBPagesForm.Create(Application);
  seNBPagesForm.NB := ANoteBook;
  seNBPagesForm.ShowModal;
  seNBPagesForm.Free;
end;

procedure TseNBPagesForm.FormShow(Sender: TObject);
var
  I, J: Integer;
begin
  if NB.Pages.Count <> 0
  then
    begin
      for I := 0 to NB.Pages.Count - 1 do
      PageListBox.Items.Add(NB.Pages[I]);
      PageListBox.ItemIndex := 0;
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
    end;

  IIndexBox.Clear;

  if NB.BGImageList <> nil
  then
    for I := -1 to NB.BGImageList.Images.Count - 1 do
    begin
      IIndexBox.Items.Add(IntToStr(I));
      J := TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGImageIndex;
      IIndexBox.ItemIndex := J + 1;
    end;

  case TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGDrawType of
     seBGTile: BGDType.ItemIndex := 0;
     seBGStretch: BGDType.ItemIndex := 1;
     seBGVertStretch: BGDType.ItemIndex := 2;
     seBGHorzStretch: BGDType.ItemIndex := 3;
  end;

  Shape1.Brush.Color := TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).Color;
end;

procedure TseNBPagesForm.AddButtonClick(Sender: TObject);
begin
  NB.Pages.Add('Page' + IntToStr(NB.Pages.Count));
  PageListBox.Items.Add(NB.Pages[NB.Pages.Count - 1]);
  PageListBox.ItemIndex := NB.Pages.Count - 1;
end;

procedure TseNBPagesForm.DeleteButtonClick(Sender: TObject);
begin
  if NB.Pages.Count > 1
  then
    begin
      NB.Pages.Delete(PageListBox.ItemIndex);
      PageListBox.Items.Delete(PageListBox.ItemIndex);
    end;
end;

procedure TseNBPagesForm.PageListBoxClick(Sender: TObject);
begin
  if PageListBox.ItemIndex <> -1
  then
    begin
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
      NB.PageIndex := PageListBox.ItemIndex;
      IIndexBox.ItemIndex := TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGImageIndex + 1;
      case TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGDrawType of
        seBGTile: BGDType.ItemIndex := 0;
        seBGStretch: BGDType.ItemIndex := 1;
        seBGVertStretch: BGDType.ItemIndex := 2;
        seBGHorzStretch: BGDType.ItemIndex := 3;
      end;
      Shape1.Brush.Color := TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).Color;
    end;
end;

procedure TseNBPagesForm.CaptionEditChange(Sender: TObject);
begin
  with PageListBox do
  if ItemIndex <> -1
  then
    begin
      NB.Pages[ItemIndex] := CaptionEdit.Text;
      Items[ItemIndex] := NB.Pages[ItemIndex];
    end;
end;

procedure TseNBPagesForm.MoveUpButtonClick(Sender: TObject);
var
  I: Integer;
begin
  with PageListBox do
  if (ItemIndex <> -1) and (ItemIndex > 0)
  then
    begin
      I := ItemIndex;
      NB.Pages.Move(ItemIndex, ItemIndex - 1);
      Items.Move(ItemIndex, ItemIndex - 1);
      ItemIndex := I - 1;
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
      NB.PageIndex := ItemIndex;
    end;
end;

procedure TseNBPagesForm.MoveDownButtonClick(Sender: TObject);
var
  I: Integer;
begin
  with PageListBox do
  if (ItemIndex <> -1) and (ItemIndex < NB.Pages.Count - 1)
  then
    begin
      I := ItemIndex;
      NB.Pages.Move(ItemIndex, ItemIndex + 1);
      Items.Move(ItemIndex, ItemIndex + 1);
      ItemIndex := I + 1;
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
      NB.PageIndex := ItemIndex;
    end;
end;

procedure TseNBPagesForm.IIndexBoxChange(Sender: TObject);
var
  Form: TCustomForm;
begin
  if PageListBox.ItemIndex = -1 then Exit;
  TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGImageIndex := IIndexBox.ItemIndex - 1;
  if csDesigning in NB.ComponentState then
  begin
    Form := GetParentForm(NB);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TseNBPagesForm.BGDTypeChange(Sender: TObject);
var
  Form: TCustomForm;
begin
  if PageListBox.ItemIndex = -1 then Exit;
  case BGDType.ItemIndex of
    0: TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGDrawType := seBGTile;
    1: TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGDrawType := seBGStretch;
    2: TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGDrawType := seBGVertStretch;
    3: TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).BGDrawType := seBGHorzStretch;
  end;
  if csDesigning in NB.ComponentState then
  begin
    Form := GetParentForm(NB);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

procedure TseNBPagesForm.Shape1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Form: TCustomForm;
begin
  ColorDialog1.Color := Shape1.Brush.Color;
  if ColorDialog1.Execute
  then
    begin
      Shape1.Brush.Color := ColorDialog1.Color;
      TsePage(NB.FPageList.Items[PageListBox.ItemIndex]).Color := Shape1.Brush.Color;
      if csDesigning in NB.ComponentState then
      begin
        Form := GetParentForm(NB);
        if (Form <> nil) and (Form.Designer <> nil) then
        Form.Designer.Modified;
      end;
    end;
end;

end.
