unit IndexEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, PropertyEditor, bsSkinBoxCtrls,
  bsSkinCtrls, BusinessSkinForm;

type
  TPIndexForm = class(TForm)
    NoneCheck: TbsSkinCheckRadioBox;
    BList: TbsSkinListBox;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    procedure FormShow(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure BListListBoxClick(Sender: TObject);
  private
    { Private declarations }
    FProperty: TbsProperty;
  public
    { Public declarations }
    procedure Execute(P: TbsProperty);
  end;

var
  PIndexForm: TPIndexForm;

implementation
   Uses SkinBuild;
{$R *.DFM}

procedure TPIndexForm.Execute;
begin
  FProperty := P;
  ShowModal;
end;

procedure TPIndexForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  BList.Clear;
  for i := 0 to SBForm.SkinData.FActivePicturesNames.Count - 1 do
    BList.Items.Add(SBForm.SkinData.FActivePicturesNames[i]);
  NoneCheck.Checked := FProperty.Value = '-1';
  BList.ItemIndex := GetInteger(FProperty.Value);
  BList.SetFocus;
end;

procedure TPIndexForm.bsSkinButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TPIndexForm.bsSkinButton1Click(Sender: TObject);
begin
  if NoneCheck.Checked
  then FProperty.Value := '-1'
  else FProperty.Value := SetInteger(BList.ItemIndex);
  Close;
end;

procedure TPIndexForm.BListListBoxClick(Sender: TObject);
begin
  if BList.ItemIndex <> -1
  then
    NoneCheck.Checked := False;
end;

end.
