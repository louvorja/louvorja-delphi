unit selectcolor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, PropertyEditor, selectcolorpic,
  bsColorCtrls, bsSkinBoxCtrls, bsSkinCtrls, BusinessSkinForm;

type
  TSelectColorForm = class(TForm)
    Button1: TbsSkinButton;
    ShowShape: TShape;
    GroupBox1: TbsSkinGroupBox;
    ColorDialog: TbsSkinColorDialog;
    Select: TbsSkinButton;
    PicList: TbsSkinListBox;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure Button1Click(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    FProperty: TbsProperty;
    { Public declarations }
  end;

var
  SelectColorForm: TSelectColorForm;

  procedure ExecuteColorDialog(P: TbsProperty);

implementation
   Uses SkinBuild;
{$R *.DFM}

procedure ExecuteColorDialog(P: TbsProperty);
var
  I: Integer;
begin
  SelectColorForm.FProperty := P;
  SelectColorForm.ShowShape.Brush.Color := GetInteger(P.Value);
  // load images
  SelectColorForm.PicList.Clear;
  with SBForm.SkinData, SelectColorForm do
  begin
    if not FPicture.Empty
    then
      PicList.Items.AddObject(FPictureName, TBitMap(FPicture));
    if not FInActivePicture.Empty
    then
      PicList.Items.AddObject(FInActivePictureName, TBitMap(FInActivePicture));
    if FActivePictures.Count > 0
    then
      for I := 0 to FActivePictures.Count - 1 do
      begin
        PicList.Items.AddObject(FActivePictureSNames[I], TBitMap(FActivePictures[I]));
      end;
  end;    
  //
  SelectColorForm.ShowModal;
end;


procedure TSelectColorForm.Button1Click(Sender: TObject);
begin
  ColorDialog.Color :=  ShowShape.Brush.Color;
  if ColorDialog.Execute
  then
    ShowShape.Brush.Color := ColorDialog.Color;
end;

procedure TSelectColorForm.SelectClick(Sender: TObject);
begin
  if (PicList.Items.Count > 0) and (PicList.ItemIndex <> -1)
  then
    begin
      ExecuteColorPicDialog(TBitMap(PicList.Items.Objects[PicList.ItemIndex]));
    end;
end;

procedure TSelectColorForm.bsSkinButton1Click(Sender: TObject);
begin
  FProperty.Value := SetInteger(SelectColorForm.ShowShape.Brush.Color);
  Close;
end;

procedure TSelectColorForm.bsSkinButton2Click(Sender: TObject);
begin
  Close;
end;

end.
