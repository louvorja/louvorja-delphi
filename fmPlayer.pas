unit fmPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.MPlayer;

type
  TfPlayer = class(TForm)
    Panel1: TPanel;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fPlayer: TfPlayer;

implementation

{$R *.dfm}

uses fmMenu, dmComponentes;

procedure TfPlayer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;

procedure TfPlayer.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  if (fPlayer.AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := fPlayer.AlphaBlendValue downto 0 do
      begin
        fPlayer.AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else fPlayer.AlphaBlendValue := 0;
  end;

  try
    fmIndex.MediaPlayer1.Stop;
  except
    //
  end;
  fmIndex.MediaPlayer1.Close;
  fmIndex.MediaPlayer1.FileName := '';
  fmIndex.pnlPlayer.Visible := False;
  fmIndex.lblPlayer.Caption := '';
  DM.tmrPlayer.Enabled := False;
  fmIndex.pbPlayer.Value := 0;
end;

procedure TfPlayer.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfPlayer.FormResize(Sender: TObject);
begin
  fmIndex.MediaPlayer1.DisplayRect := Panel1.ClientRect;
end;

end.
