unit AddPicDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, PropertyEditor, ExtDlgs, bsSkinCtrls,
  bsSkinBoxCtrls, BusinessSkinForm;

type
  TLoadPicForm = class(TForm)
    Panel1: TbsSkinPanel;
    LoadButton: TbsSkinButton;
    ClearButton: TbsSkinButton;
    bsSkinButton1: TbsSkinButton;
    bsSkinPanel1: TbsSkinPanel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinScrollBar2: TbsSkinScrollBar;
    bsSkinScrollBox1: TbsSkinScrollBox;
    procedure LoadButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    SelfB: TBitMap;
    B: TBitMap;
    P: TbsProperty;
    PictureName: String;
    PB: TbsSkinViewer;
    procedure PBPaint(Sender: TObject);
  end;

var
  LoadPicForm: TLoadPicForm;


  procedure Execute(AB: TBitMap; AP: TbsProperty; APictureName: String;
                    CBEnabled: Boolean);

implementation
    Uses SkinBuild, bsUtils;
{$R *.DFM}

procedure Execute;
begin
  with LoadPicForm do
  begin
    B := AB;
    P := AP;
    ClearButton.Enabled := CBEnabled;
    PictureName := APictureName;
    ShowModal;
  end;
end;


procedure TLoadPicForm.LoadButtonClick(Sender: TObject);
begin
  if SBForm.PD.Execute
  then
    begin
      PictureName := ExtractFileName(SBForm.PD.FileName);
      if P <> nil then P.Value := PictureName;
      SelfB.LoadFromFile(SBForm.PD.FileName);
      if B <> nil then B.Assign(SelfB);  
      PB.Width := SelfB.Width;
      PB.Height := SelfB.Height;
      PB.Repaint;
    end;
end;

procedure TLoadPicForm.ClearButtonClick(Sender: TObject);
begin
  if B <> nil then B.Assign(nil);
  SelfB.Assign(nil);
  PictureName := '';
  if P <> nil then P.Value := '';
  PB.Width := 0;
  PB.Height := 0;
end;

procedure TLoadPicForm.FormShow(Sender: TObject);
begin
  SelfB := TBitMap.Create;
  SelfB.Assign(B);
  if SelfB.Empty
  then
    begin
      PB.Width := 0;
      PB.Height := 0;
    end
  else
    begin
      PB.Width := SelfB.Width;
      PB.Height := SelfB.Height;
    end;
end;

procedure TLoadPicForm.FormHide(Sender: TObject);
begin
  SelfB.Free;
end;

procedure TLoadPicForm.bsSkinButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TLoadPicForm.PBPaint(Sender: TObject);
begin
  if (SelfB <> nil) and not SelfB.Empty
  then
    PB.Canvas.Draw(0, 0, SelfB);
end;

procedure TLoadPicForm.FormCreate(Sender: TObject);
begin
  PB := TbsSkinViewer.Create(Self);
  PB.Parent := bsSkinScrollBox1;
  PB.Left := 0;
  PB.Top := 0;
  PB.OnPaint := PBPaint; 
end;

end.
