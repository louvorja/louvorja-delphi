program skinbuilder;

uses
  Forms,
  skinbuild in 'skinbuild.pas' {SBForm},
  ImageEditor in 'ImageEditor.pas' {IEFrm},
  FSDlg in 'FSDlg.pas' {FSForm},
  IndexEditor in 'IndexEditor.pas' {PIndexForm},
  selectcolor in 'selectcolor.pas' {SelectColorForm},
  selectcolorpic in 'selectcolorpic.pas' {SelColorPicForm},
  testfrmEmpty in 'testfrmEmpty.pas' {TestFormEmpty},
  ribbonui in 'ribbonui.pas' {RibbonForm},
  testfrmctrls in 'testfrmctrls.pas' {TestFormCtrls},
  AddPicDlg in 'AddPicDlg.pas' {LoadPicForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSBForm, SBForm);
  Application.CreateForm(TIEFrm, IEFrm);
  Application.CreateForm(TFSForm, FSForm);
  Application.CreateForm(TPIndexForm, PIndexForm);
  Application.CreateForm(TSelectColorForm, SelectColorForm);
  Application.CreateForm(TSelColorPicForm, SelColorPicForm);
  Application.CreateForm(TLoadPicForm, LoadPicForm);
  Application.Run;
end.
