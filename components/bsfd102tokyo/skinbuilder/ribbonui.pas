unit ribbonui;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  bsSkinCtrls, bsribbon, BusinessSkinForm, ImgList, bsPngImageList, Menus,
  bsSkinMenus;

type
  TRibbonForm = class(TForm)
    bsRibbon1: TbsRibbon;
    bsRibbonPage1: TbsRibbonPage;
    bsRibbonPage2: TbsRibbonPage;
    bsRibbonPage3: TbsRibbonPage;
    bsRibbonGroup1: TbsRibbonGroup;
    bsRibbonGroup2: TbsRibbonGroup;
    bsRibbonDivider1: TbsRibbonDivider;
    bsAppMenu1: TbsAppMenu;
    bsAppMenuPage1: TbsAppMenuPage;
    bsAppMenuPage2: TbsAppMenuPage;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsAppMenuPageListBox1: TbsAppMenuPageListBox;
    bsSkinLabel1: TbsSkinLabel;
    bsPngImageList4: TbsPngImageList;
    bsSkinPopupMenu1: TbsSkinPopupMenu;
    Item11: TMenuItem;
    Item21: TMenuItem;
    Item31: TMenuItem;
    procedure bsAppMenu1HideMenu(Sender: TObject);
    procedure bsAppMenu1ShowMenu(Sender: TObject);
    procedure bsAppMenu1Items5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RibbonForm: TRibbonForm;

implementation
  Uses SkinBuild;
{$R *.DFM}

procedure TRibbonForm.bsAppMenu1HideMenu(Sender: TObject);
begin
  bsRibbon1.SetFocus;
end;

procedure TRibbonForm.bsAppMenu1ShowMenu(Sender: TObject);
begin
  bsAppMenuPageListBox1.ItemIndex := -1;
end;

procedure TRibbonForm.bsAppMenu1Items5Click(Sender: TObject);
begin
  Close;
end;

end.
