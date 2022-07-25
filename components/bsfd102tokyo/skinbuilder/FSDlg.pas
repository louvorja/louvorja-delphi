unit FSDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, PropertyEditor, bsSkinCtrls, BusinessSkinForm;

type
  TFSForm = class(TForm)
    fsBoldCheck: TbsSkinCheckRadioBox;
    fsUnderLineCheck: TbsSkinCheckRadioBox;
    fsItalicCheck: TbsSkinCheckRadioBox;
    fsStrikeOutCheck: TbsSkinCheckRadioBox;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
  private
    { Private declarations }
    FProperty: TbsProperty;
  public
    { Public declarations }
    procedure Execute(P: TbsProperty);
  end;

var
  FSForm: TFSForm;

implementation
  Uses SkinBuild;

{$R *.DFM}

procedure TFSForm.Execute(P: TbsProperty);
var
  FS: TFontStyles;
begin
  FProperty := P;
  FS := GetFontStyle(FProperty.Value);
  fsBoldCheck.Checked := fsBold in FS;
  fsUnderLineCheck.Checked := fsUnderLine in FS;
  fsItalicCheck.Checked := fsItalic in FS;
  fsStrikeOutCheck.Checked := fsStrikeOut in FS;
  ShowModal;
end;

procedure TFSForm.bsSkinButton1Click(Sender: TObject);
var
  FS: TFontStyles;
begin
  FS := [];
  if fsBoldCheck.Checked then FS := FS + [fsBold];
  if fsUnderLineCheck.Checked then FS := FS + [fsUnderLine];
  if fsItalicCheck.Checked then FS := FS + [fsItalic];
  if fsStrikeOutCheck.Checked then FS := FS + [fsStrikeOut];
  FProperty.Value := SetFontStyle(FS);
  Close;
end;

procedure TFSForm.bsSkinButton2Click(Sender: TObject);
begin
  Close;
end;

end.
