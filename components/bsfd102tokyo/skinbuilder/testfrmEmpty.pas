unit testfrmEmpty;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BusinessSkinForm;

type
  TTestFormEmpty = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestFormEmpty: TTestFormEmpty;

implementation
       Uses SkinBUild;
{$R *.DFM}

procedure TTestFormEmpty.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SBForm.bsSkinHint1.SkinData := nil;
end;

end.
