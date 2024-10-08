unit fmFormatacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, bsSkinCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, bsSkinTabs, Vcl.StdCtrls, bsDialogs, bsColorCtrls,
  bsSkinBoxCtrls;

type
  TfFormatacao = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GridPanel2: TGridPanel;
    btSave: TbsSkinButton;
    bsSkinButton1: TbsSkinButton;
    tabFontes: TbsSkinTabControl;
    pnlFonte: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    fontComboBox: TbsSkinFontComboBox;
    Panel8: TPanel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    fontTamanho: TbsSkinSpinEdit;
    Panel1: TPanel;
    Panel4: TPanel;
    bsSkinStdLabel108: TbsSkinStdLabel;
    csSorteioCor: TbsSkinColorButton;
    Panel5: TPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinCheckBox1: TbsSkinCheckBox;
    bsSkinCheckBox2: TbsSkinCheckBox;
    bsSkinCheckBox3: TbsSkinCheckBox;
    pnlImagem: TPanel;
    Panel3: TPanel;
    Panel9: TPanel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    Panel2: TPanel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    lblFonte: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure tabFontesChange(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure fontComboBoxChange(Sender: TObject);
    procedure mostraFonte();
  private
    { Private declarations }
    fonteLocal: array of Tfont;
  public
    { Public declarations }
    fonte: array of Tfont;
    abas: array of string;
  end;

var
  fFormatacao: TfFormatacao;

implementation

{$R *.dfm}


procedure TfFormatacao.bsSkinButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfFormatacao.btSaveClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(fonte)-1 do
    fonte[i] := fonteLocal[i];
  Close;
end;

procedure TfFormatacao.fontComboBoxChange(Sender: TObject);
begin
  fonteLocal[tabFontes.TabIndex].Name := fontComboBox.FontName;
  mostraFonte();
end;

procedure TfFormatacao.FormActivate(Sender: TObject);
var
  i: integer;
  aba: TStringList;
begin
  aba := TStringList.Create;
  aba.Delimiter := ';';

  SetLength(fonteLocal,Length(fonte));

  tabFontes.Tabs.Clear;
  for i := 0 to Length(abas)-1 do
  begin
    if Length(fonte) >= i then
      fonteLocal[i] := fonte[i];

    aba.DelimitedText := abas[i];
    aba[1] := StringReplace(aba[1], '_', ' ', [rfIgnoreCase, rfReplaceAll]);
    tabFontes.Tabs.Add(aba[1]);
  end;
  tabFontes.TabIndex := 0;
  tabFontesChange(Sender);
end;

procedure TfFormatacao.mostraFonte;
begin
  lblFonte.Caption := fontComboBox.FontName;
  lblFonte.Font := fonteLocal[tabFontes.TabIndex];
  lblFonte.Font.Height := Trunc(Panel2.Height/100)*10;
end;

procedure TfFormatacao.tabFontesChange(Sender: TObject);
var
  aba: TStringList;
begin
  aba := TStringList.Create;
  aba.Delimiter := ';';
  aba.DelimitedText := abas[tabFontes.TabIndex];

  pnlFonte.Visible := (aba[0] = 'FONTE');
  pnlImagem.Visible := (aba[0] = 'IMG');

  if (pnlFonte.Visible) then
  begin
    pnlFonte.Align := alClient;
    fontComboBox.FontName := fonteLocal[tabFontes.TabIndex].Name;
//    fontTamanho.Value := fonteLocal[tabFontes.TabIndex].Name;
    mostraFonte();
  end
  else if (pnlImagem.Visible) then
  begin
    pnlImagem.Align := alClient;
  end;
end;

end.
