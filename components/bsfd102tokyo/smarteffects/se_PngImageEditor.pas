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

unit se_PngImageEditor;

interface

{$I se_define.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, se_PngImage, Buttons, ExtCtrls;

type
  TsePNGEditorForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OD: TOpenDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    { Public declarations }
    FPngImage: TsePngImage;
  end;

var
  sePNGEditorForm: TsePNGEditorForm;

  procedure ExecutePngEditor(AEditImage: TsePngImage);

implementation

{$R *.DFM}

procedure ExecutePngEditor(AEditImage: TsePngImage);
var
  F: TsePNGEditorForm;
begin
  F := TsePNGEditorForm.Create(Application);
  F.Position := poScreenCenter;
  F.FPngImage.Assign(AEditImage);
  if F.ShowModal = mrOk
  then
    begin
      AEditImage.Assign(F.FPngImage);
    end;
  F.Free;
end;

procedure TsePNGEditorForm.FormCreate(Sender: TObject);
begin
  FPngImage := TsePngImage.Create;
end;

procedure TsePNGEditorForm.Button2Click(Sender: TObject);
begin
  FPngImage.Assign(nil);
  PaintBox1.Repaint;
  Label1.Caption := IntToStr(FPngImage.Width) + ' x ' + IntToStr(FPngImage.Height);
end;

procedure TsePNGEditorForm.Button1Click(Sender: TObject);
begin
  if OD.Execute
  then
    begin
      FPngImage.LoadFromFile(OD.FileName);
      PaintBox1.Repaint;
      Label1.Caption := IntToStr(FPngImage.Width) + ' x ' + IntToStr(FPngImage.Height);
    end;
end;

procedure TsePNGEditorForm.BitBtn1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TsePNGEditorForm.BitBtn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TsePNGEditorForm.FormDestroy(Sender: TObject);
begin
  FPngImage.Free;
  FPngImage := nil;
end;

procedure TsePNGEditorForm.PaintBox1Paint(Sender: TObject);
var
  R: TRect;
begin
  R := Rect(0, 0, PaintBox1.Width, PaintBox1.Height);
  with PaintBox1.Canvas do
  begin
    Brush.Color := clWhite;
    Brush.Style := bsSolid;
    FillRect(R);
  end;
  if (FPngImage <> nil) and not FPngImage.Empty
  then
    FPngImage.Draw(PaintBox1.Canvas, R);
end;

procedure TsePNGEditorForm.FormShow(Sender: TObject);
begin
  Label1.Caption := IntToStr(FPngImage.Width) + ' x ' + IntToStr(FPngImage.Height);
end;

end.
