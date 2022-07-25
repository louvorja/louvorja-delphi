unit fmMusicaRetorno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TfMusicaRetorno = class(TForm)
    Panel: TPanel;
    pnlProgress: TGridPanel;
    gSlide: TbsSkinGauge;
    gSlideTotal: TbsSkinGauge;
    lblTempo: TbsSkinLabel;
    Panel2: TPanel;
    lblSlides: TbsSkinLabel;
    lblLetra_prox: TbsSkinStdLabel;
    pnlLetra: TPanel;
    lblLetra: TbsSkinStdLabel;
    lblLetra_aux: TbsSkinStdLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
    inicio: Boolean;
  end;

var
  fMusicaRetorno: TfMusicaRetorno;

implementation

{$R *.dfm}

uses fmMenu, fmMusica;

procedure TfMusicaRetorno.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') = '1') then
    Params.WndParent := 0;
end;

procedure TfMusicaRetorno.FormActivate(Sender: TObject);
begin
  if fmIndex.ckMusicaTopo.Checked then
    FormStyle := fsStayOnTop;
  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') <> '1') then
  begin
    fMusicaRetorno.AlphaBlend := True;
    fMusicaRetorno.AlphaBlendValue := 0;
  end;

  if (inicio <> true) then
  begin
    inicio := True;
    fMusicaRetorno.Tag := 1;
  end;
end;

procedure TfMusicaRetorno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fmIndex.lerParam('Musicas', 'ModoRetorno', '1') <> '1') then
  begin
    fMusicaRetorno.Tag := 0;
    fMusica.fecharSlidesRetorno := True;
    fMusica.Close;
  end
  else
  begin
    if fMusicaRetorno.Tag = 1 then
    begin
      if (application.MessageBox('Ao fechar esta tela, os slides também serão fechados! Deseja fechar os slides?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then
      begin
        Abort;
        Exit;
      end;
      fMusicaRetorno.Tag := 0;
    end;
    fMusica.fecharSlidesRetorno := True;
    fMusica.Close;
  end;
end;

procedure TfMusicaRetorno.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

end.
