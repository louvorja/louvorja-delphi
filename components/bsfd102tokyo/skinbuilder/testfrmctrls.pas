unit testfrmctrls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BusinessSkinForm, bsSkinData, Menus, bsSkinMenus, bsTrayIcon, ComCtrls,
  bsSkinTabs, ExtCtrls, bsSkinBoxCtrls, bsSkinCtrls, bsSkinGrids, Mask,
  StdCtrls, ToolWin, bsSkinExCtrls, bsSkinHint;

type
  TTestFormCtrls = class(TForm)
    bsSkinControlBar1: TbsSkinControlBar;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinMenuButton3: TbsSkinMenuButton;
    bsSkinMenuButton4: TbsSkinMenuButton;
    bsSkinButton5: TbsSkinButton;
    bsSkinButton6: TbsSkinButton;
    bsSkinButton8: TbsSkinButton;
    bsSkinButton9: TbsSkinButton;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinMenuButton1: TbsSkinMenuButton;
    bsSkinMenuButton2: TbsSkinMenuButton;
    bsSkinButton4: TbsSkinButton;
    bsSkinButton10: TbsSkinButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPageControl1: TbsSkinPageControl;
    spSkinTabSheet1: TbsSkinTabSheet;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinButton1: TbsSkinButton;
    bsSkinCheckRadioBox1: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBox2: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBox3: TbsSkinCheckRadioBox;
    bsSkinTrackBar1: TbsSkinTrackBar;
    bsSkinTrackBar2: TbsSkinTrackBar;
    bsSkinGauge1: TbsSkinGauge;
    bsSkinGauge2: TbsSkinGauge;
    bsSkinLabel1: TbsSkinLabel;
    bsSkinScrollBar6: TbsSkinScrollBar;
    bsSkinScrollBar7: TbsSkinScrollBar;
    bsSkinUpDown1: TbsSkinUpDown;
    bsSkinUpDown2: TbsSkinUpDown;
    bsSkinButton3: TbsSkinButton;
    spSkinTabSheet2: TbsSkinTabSheet;
    bsSkinListBox1: TbsSkinListBox;
    bsSkinCheckListBox1: TbsSkinCheckListBox;
    bsSkinComboBox1: TbsSkinComboBox;
    bsSkinComboBox2: TbsSkinComboBox;
    bsSkinListBox2: TbsSkinListBox;
    bsSkinComboBox3: TbsSkinComboBox;
    spSkinTabSheet3: TbsSkinTabSheet;
    bsSkinRadioGroup1: TbsSkinRadioGroup;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinTabControl1: TbsSkinTabControl;
    bsSkinButton12: TbsSkinButton;
    bsSkinGroupBox1: TbsSkinGroupBox;
    EditsTabSheet: TbsSkinTabSheet;
    bsSkinStdLabel8: TbsSkinStdLabel;
    bsSkinStdLabel9: TbsSkinStdLabel;
    bsSkinEdit1: TbsSkinEdit;
    bsSkinEdit2: TbsSkinEdit;
    bsSkinSpinEdit1: TbsSkinSpinEdit;
    bsSkinMemo1: TbsSkinMemo;
    bsSkinScrollBar1: TbsSkinScrollBar;
    bsSkinMemo2: TbsSkinMemo;
    bsSkinScrollBar17: TbsSkinScrollBar;
    spSkinTabSheet4: TbsSkinTabSheet;
    bsSkinPanel10: TbsSkinPanel;
    bsSkinStatusPanel3: TbsSkinStatusPanel;
    bsSkinGauge3: TbsSkinGauge;
    bsSkinStringGrid1: TbsSkinStringGrid;
    bsSkinScrollBar15: TbsSkinScrollBar;
    bsSkinScrollBar16: TbsSkinScrollBar;
    MainMenu2: TMainMenu;
    fgg1: TMenuItem;
    dfgfgdfg1: TMenuItem;
    gdfgd1: TMenuItem;
    N44444444441: TMenuItem;
    N555555555551: TMenuItem;
    N66666666666661: TMenuItem;
    N77777777771: TMenuItem;
    N111111: TMenuItem;
    N26: TMenuItem;
    N34: TMenuItem;
    item42: TMenuItem;
    item52: TMenuItem;
    item62: TMenuItem;
    item72: TMenuItem;
    item82: TMenuItem;
    item92: TMenuItem;
    item102: TMenuItem;
    item112: TMenuItem;
    item122: TMenuItem;
    item142: TMenuItem;
    item152: TMenuItem;
    item153: TMenuItem;
    item162: TMenuItem;
    item171: TMenuItem;
    item182: TMenuItem;
    item202: TMenuItem;
    item211: TMenuItem;
    item221: TMenuItem;
    item231: TMenuItem;
    N44444444444441: TMenuItem;
    N333333333331: TMenuItem;
    testitem11: TMenuItem;
    testitem21: TMenuItem;
    testitem31: TMenuItem;
    N1: TMenuItem;
    dfg1: TMenuItem;
    gffdf1: TMenuItem;
    gd1: TMenuItem;
    dggdfgdfgfgfdg1: TMenuItem;
    N56464645641: TMenuItem;
    N53534531: TMenuItem;
    fgdfgdfg1: TMenuItem;
    dfgdfg1: TMenuItem;
    Multiitems1: TMenuItem;
    item11: TMenuItem;
    item21: TMenuItem;
    item31: TMenuItem;
    item41: TMenuItem;
    item51: TMenuItem;
    item61: TMenuItem;
    item71: TMenuItem;
    item81: TMenuItem;
    item91: TMenuItem;
    item101: TMenuItem;
    item111: TMenuItem;
    item121: TMenuItem;
    item131: TMenuItem;
    item141: TMenuItem;
    item151: TMenuItem;
    item161: TMenuItem;
    item181: TMenuItem;
    item191: TMenuItem;
    item201: TMenuItem;
    N11: TMenuItem;
    N25: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    N01: TMenuItem;
    N14: TMenuItem;
    N321: TMenuItem;
    N341: TMenuItem;
    N42: TMenuItem;
    N15: TMenuItem;
    N27: TMenuItem;
    N35: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    N72: TMenuItem;
    N82: TMenuItem;
    end1: TMenuItem;
    item431: TMenuItem;
    item441: TMenuItem;
    item451: TMenuItem;
    item461: TMenuItem;
    item471: TMenuItem;
    item481: TMenuItem;
    item491: TMenuItem;
    item501: TMenuItem;
    TestItem2: TMenuItem;
    item12: TMenuItem;
    item22: TMenuItem;
    item32: TMenuItem;
    bsSkinTabSheet6: TbsSkinTabSheet;
    bsSkinExPanel1: TbsSkinExPanel;
    bsSkinExPanel2: TbsSkinExPanel;
    bsSkinGroupBox2: TbsSkinGroupBox;
    bsSkinButton11: TbsSkinButton;
    bsSkinSlider1: TbsSkinSlider;
    bsSkinSlider2: TbsSkinSlider;
    bsSkinBevel1: TbsSkinBevel;
    bsSkinGroupBox3: TbsSkinGroupBox;
    bsSkinStatusBar1: TbsSkinStatusBar;
    bsSkinEdit3: TbsSkinEdit;
    bsSkinEdit4: TbsSkinEdit;
    bsSkinSpinEdit2: TbsSkinSpinEdit;
    bsSkinComboBox4: TbsSkinComboBox;
    bsSkinToolBar1: TbsSkinToolBar;
    bsSkinEdit5: TbsSkinEdit;
    bsSkinBevel2: TbsSkinBevel;
    bsSkinEdit6: TbsSkinEdit;
    bsSkinSpinEdit3: TbsSkinSpinEdit;
    bsSkinBevel3: TbsSkinBevel;
    bsSkinBevel4: TbsSkinBevel;
    bsSkinComboBox5: TbsSkinComboBox;
    bsSkinStatusPanel1: TbsSkinStatusPanel;
    bsSkinCheckListBox2: TbsSkinCheckListBox;
    bsSkinTabSheet1: TbsSkinTabSheet;
    bsSkinCoolBar1: TbsSkinCoolBar;
    bsSkinCoolBar2: TbsSkinCoolBar;
    bsSkinPanel6: TbsSkinPanel;
    bsSkinPanel7: TbsSkinPanel;
    bsSkinPanel4: TbsSkinPanel;
    bsSkinPanel5: TbsSkinPanel;
    bsSkinToolBar2: TbsSkinToolBar;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    bsSkinBevel5: TbsSkinBevel;
    bsSkinBevel6: TbsSkinBevel;
    bsSkinBevel7: TbsSkinBevel;
    bsSkinMenuSpeedButton1: TbsSkinMenuSpeedButton;
    bsSkinMainMenuBar1: TbsSkinMainMenuBar;
    bsSkinButton2: TbsSkinButton;
    bsSkinAnimateGauge1: TbsSkinAnimateGauge;
    Header1: TMenuItem;
    item43: TMenuItem;
    Item53: TMenuItem;
    Groupitem31: TMenuItem;
    procedure bsSkinGauge1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bsSkinPageControl1Close(Sender: TObject;
      var CanClose: Boolean);
  private
    { Private declarations }
    FAnimation: Boolean;
  public
    { Public declarations }
  end;

var
  TestFormCtrls: TTestFormCtrls;

implementation
    Uses SkinBuild;
{$R *.DFM}

procedure TTestFormCtrls.bsSkinGauge1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  bsSkinGauge1.StartProgressAnimation;
end;

procedure TTestFormCtrls.FormCreate(Sender: TObject);
begin
  FAnimation := False;
end;

procedure TTestFormCtrls.bsSkinButton2Click(Sender: TObject);
begin
  if not FAnimation
  then
    begin
      bsSkinGauge1.StartProgressAnimation;
      bsSkinGauge2.StartProgressAnimation;
      bsSkinAnimateGauge1.StartAnimation;
      FAnimation := True;
    end
  else
    begin
      bsSkinGauge1.StopProgressAnimation;
      bsSkinGauge2.StopProgressAnimation;
      bsSkinAnimateGauge1.StopAnimation;
      FAnimation := False;
    end;  
end;

procedure TTestFormCtrls.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SBForm.bsSkinHint1.SkinData := nil;
end;

procedure TTestFormCtrls.bsSkinPageControl1Close(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
end;

end.
