unit fmLiturgia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BusinessSkinForm, bsSkinCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, bsSkinBoxCtrls,
  bsdbctrls, bsribbon, Data.DB, Data.Win.ADODB, bsColorCtrls, StrUtils, ShellApi,
  Vcl.DBCtrls;

type
  TfLiturgia = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    GridPanel2: TGridPanel;
    btAdd: TbsSkinButton;
    bsSkinPanel1: TbsSkinPanel;
    lblItem: TbsSkinLabel;
    txtItem: TbsSkinEdit;
    bsSkinLabel2: TbsSkinLabel;
    cbItens: TbsSkinComboBox;
    ScrollBox1: TScrollBox;
    dsHinos: TDataSource;
    qrHinos: TADOQuery;
    pnlHinos: TbsSkinPanel;
    bsRibbonDivider10: TbsRibbonDivider;
    bsSkinPanel2: TbsSkinPanel;
    opcHinosOpc1: TbsSkinRadioButton;
    pnlHinosOpc1: TbsSkinPanel;
    skLitLabel: TbsSkinStdLabel;
    bsSkinPanel4: TbsSkinPanel;
    dbLitHinoLista: TbsSkinDBLookupComboBox;
    csCor: TbsSkinColorButton;
    bsSkinLabel3: TbsSkinLabel;
    btDel: TbsSkinButton;
    pnlAnotacoes: TbsSkinPanel;
    bsRibbonDivider1: TbsRibbonDivider;
    bsSkinPanel6: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    pnlSite: TbsSkinPanel;
    bsSkinSpeedButton1: TbsSkinSpeedButton;
    edtAnotacao: TbsSkinEdit;
    bsRibbonDivider2: TbsRibbonDivider;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    urlSite: TbsSkinURLEdit;
    bsSkinSpeedButton2: TbsSkinSpeedButton;
    pnlArquivo: TbsSkinPanel;
    bsRibbonDivider3: TbsRibbonDivider;
    bsSkinPanel7: TbsSkinPanel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    edtDiretorio: TbsSkinEdit;
    bsSkinSpeedButton3: TbsSkinSpeedButton;
    bsSkinSpeedButton4: TbsSkinSpeedButton;
    edtDiretorioInfo: TbsSkinEdit;
    pnlItensAgendados: TbsSkinPanel;
    bsRibbonDivider4: TbsRibbonDivider;
    bsSkinPanel8: TbsSkinPanel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    dblItem: TDBLookupComboBox;
    bsSkinPanel5: TbsSkinPanel;
    procedure cbItensChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure executaOpcoes();
    procedure opcHinosOpc1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton1Click(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure txtItemKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bsSkinSpeedButton2Click(Sender: TObject);
    function validaURL(url: string): string;
    procedure urlSiteExit(Sender: TObject);
    procedure bsSkinSpeedButton4Click(Sender: TObject);
    procedure edtDiretorioEnter(Sender: TObject);
    procedure edtDiretorioExit(Sender: TObject);
    procedure bsSkinSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id: string;
  end;

var
  fLiturgia: TfLiturgia;

implementation

{$R *.dfm}

uses fmMenu, fmBuscaMusica, dmComponentes, fmIniciando;

procedure TfLiturgia.edtDiretorioEnter(Sender: TObject);
begin
  edtDiretorio.Text := fmIndex.verificaURL(edtDiretorio.Text, edtDiretorioInfo, true);
end;

procedure TfLiturgia.edtDiretorioExit(Sender: TObject);
begin
  edtDiretorio.Text := fmIndex.verificaURL(edtDiretorio.Text, edtDiretorioInfo, false);
end;

procedure TfLiturgia.bsSkinSpeedButton1Click(Sender: TObject);
begin
  fIniciando.AppCreateForm(TfBuscaMusica, fBuscaMusica);
  fBuscaMusica.ShowModal;
  if (fBuscaMusica.id) > 0
    then dbLitHinoLista.KeyValue := fBuscaMusica.id;
end;

procedure TfLiturgia.bsSkinSpeedButton2Click(Sender: TObject);
begin
  urlSite.text := validaURL(urlSite.text);
  fmIndex.abrirArquivo(urlSite.Text);
end;

procedure TfLiturgia.bsSkinSpeedButton3Click(Sender: TObject);
var
  dir: string;
begin
  dir := fmIndex.openDialog('pasta', '', 'Liturgia',false,edtDiretorio.Text);
  if dir <> '' then edtDiretorio.Text := dir;
  edtDiretorioExit(Sender);
end;

procedure TfLiturgia.bsSkinSpeedButton4Click(Sender: TObject);
var
  arq: string;
begin
  arq := fmIndex.openDialog('arquivo', '', 'Liturgia',false,ExtractFilePath(edtDiretorio.Text));
  if arq <> '' then edtDiretorio.Text := arq;
  edtDiretorioExit(Sender);
end;

procedure TfLiturgia.btAddClick(Sender: TObject);
var
  semana: string;
  tipo: string;
  subitem: string;
  param: string;
begin
  if (cbItens.ItemIndex < 0) then
  begin
    application.MessageBox('Escolha o tipo de item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    cbItens.SetFocus;
    Exit;
  end;

  if (txtItem.Visible) and (Trim(txtItem.Text) = '') then
  begin
    application.MessageBox('Defina o nome do item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    txtItem.SetFocus;
    Exit;
  end;

  if (pnlItensAgendados.Visible) and (trim(dblItem.KeyValue) = '') then
  begin
    application.MessageBox('Escolha o item!', fmIndex.titulo, mb_ok + MB_ICONEXCLAMATION);
    dblItem.SetFocus;
    Exit;
  end;

  semana := fmIndex.loadCol.Strings.Values['LITURGIA:SEMANA'];

  if (Trim(id) = '') then
    id := 'item_'+FormatDateTime('yyyymmddhhnnsszzz', Now);

  tipo := '';
  case cbItens.ItemIndex of
    0: tipo := 'anotacao';
    1: tipo := 'arquivo';
    2: tipo := 'categoria';
    3: tipo := 'itensagendados';
    4: tipo := 'musica';
    5: tipo := 'site';
  end;

  fmIndex.gravaParam(id, 'tipo', tipo, fmIndex.arq_liturgia);
  fmIndex.gravaParam(id, 'item', txtItem.Text, fmIndex.arq_liturgia);
  fmIndex.gravaParam(id, 'cor', ColorToString(csCor.ColorValue), fmIndex.arq_liturgia);


  if (pnlAnotacoes.Visible) then
  begin
    fmIndex.gravaParam(id, 'subitem', edtAnotacao.Text, fmIndex.arq_liturgia);
  end
  else
  if (pnlItensAgendados.Visible) then
  begin
    fmIndex.gravaParam(id, 'item', dblItem.Text, fmIndex.arq_liturgia);
    fmIndex.gravaParam(id, 'subitem', '', fmIndex.arq_liturgia);
    fmIndex.gravaParam(id, 'id', dblItem.KeyValue, fmIndex.arq_liturgia);
  end
  else
  if (pnlSite.Visible) then
  begin
    urlSite.text := validaURL(urlSite.text);
    fmIndex.gravaParam(id, 'subitem', 'Site '+urlSite.Text, fmIndex.arq_liturgia);
    fmIndex.gravaParam(id, 'url', urlSite.Text, fmIndex.arq_liturgia);
  end
  else
  if (pnlArquivo.Visible) then
  begin
    edtDiretorio.Text := trim(edtDiretorio.Text);
    if (edtDiretorioInfo.Text = 'I')
      then param := ExtractFilePath(Application.ExeName)+edtDiretorio.Text
      else param := edtDiretorio.Text;

    if (Copy(param,Length(param),1) = '\') then
    begin
      fmIndex.gravaParam(id, 'subtipo', 'dir', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'subitem', 'Pasta '+edtDiretorio.Text, fmIndex.arq_liturgia);
    end
    else if FileExists(param) then
    begin
      fmIndex.gravaParam(id, 'subtipo', 'arq', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'subitem', 'Arquivo '+edtDiretorio.Text, fmIndex.arq_liturgia);
    end
    else if DirectoryExists(param) then
    begin
      edtDiretorio.Text := edtDiretorio.Text+'\';
      fmIndex.gravaParam(id, 'subtipo', 'dir', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'subitem', 'Pasta '+edtDiretorio.Text, fmIndex.arq_liturgia);
    end
    else
    begin
      fmIndex.gravaParam(id, 'subtipo', 'arq', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'subitem', 'Arquivo '+edtDiretorio.Text, fmIndex.arq_liturgia);
    end;

    fmIndex.gravaParam(id, 'dir', edtDiretorio.Text, fmIndex.arq_liturgia);
    fmIndex.gravaParam(id, 'dir_info', edtDiretorioInfo.Text, fmIndex.arq_liturgia);
  end
  else
  if (pnlHinos.Visible) then
  begin
    if (dbLitHinoLista.KeyValue < 0)
      then opcHinosOpc1.Checked := true;

    if opcHinosOpc1.Checked then
    begin
      fmIndex.gravaParam(id, 'escolha', '1', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'musica', '-1', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'subtipo', 'escolha', fmIndex.arq_liturgia);
      subitem := 'Clique para escolher a música';
      fmIndex.gravaParam(id, 'subitem', subitem, fmIndex.arq_liturgia);
    end
    else
    begin
      fmIndex.gravaParam(id, 'escolha', '0', fmIndex.arq_liturgia);
      fmIndex.gravaParam(id, 'musica', IntToStr(dbLitHinoLista.KeyValue), fmIndex.arq_liturgia);
      if (qrHinos.FieldByName('TIPO_HASD').AsString = 'S')
        then fmIndex.gravaParam(id, 'subtipo', 'hasd', fmIndex.arq_liturgia)
      else if (qrHinos.FieldByName('TIPO_JA').AsString = 'S')
        then fmIndex.gravaParam(id, 'subtipo', 'ja', fmIndex.arq_liturgia)
      else fmIndex.gravaParam(id, 'subtipo', 'div', fmIndex.arq_liturgia);

      if (qrHinos.FieldByName('TIPO_HASD').AsString = 'S')
        then subitem := 'Hino nº '
        else subitem := 'Música ';
      subitem := subitem + qrHinos.FieldByName('NOME').AsString;
      fmIndex.gravaParam(id, 'subitem', subitem, fmIndex.arq_liturgia);
    end;
  end;


  if fmIndex.lbLiturgia.Items.IndexOf(id) < 0 then
  begin
    fmIndex.lbLiturgia.Items.Add(id);
    fmIndex.salvaItensLiturgia;
    fmIndex.carregaItemLiturgia(id,fmIndex.lbLiturgia.Items.Count);
  end
  else fmIndex.carregaItemLiturgia(id);

  close;
end;

procedure TfLiturgia.btDelClick(Sender: TObject);
begin
  if (application.MessageBox('Deseja realmente excluir este item?', fmIndex.titulo, mb_yesno + mb_iconquestion) <> 6) then Exit;
  fmIndex.apagaItemLiturgia(id);
  Close;
end;

procedure TfLiturgia.cbItensChange(Sender: TObject);
begin
  lblItem.Visible := True;
  txtItem.Visible := True;
  if cbItens.ItemIndex < 0 then Exit;

  pnlAnotacoes.Visible := (cbItens.Items[cbItens.ItemIndex] = 'Anotação');
  pnlHinos.Visible := (cbItens.Items[cbItens.ItemIndex] = 'Música');
  pnlSite.Visible := (cbItens.Items[cbItens.ItemIndex] = 'Site');
  pnlArquivo.Visible := (cbItens.Items[cbItens.ItemIndex] = 'Arquivo/Diretório');
  pnlItensAgendados.Visible := (cbItens.Items[cbItens.ItemIndex] = 'Itens Agendados');

  lblItem.Visible := not pnlItensAgendados.Visible;
  txtItem.Visible := not pnlItensAgendados.Visible;

  executaOpcoes;
end;

procedure TfLiturgia.executaOpcoes;
var
  item: string;
begin
  if (pnlHinos.Visible) then
  begin
    opcHinosOpc1Click(nil);
    qrHinos.Close;
    qrHinos.Open;
  end
  else if pnlItensAgendados.Visible then
  begin
    item := '';
    if (dblItem.KeyValue <> null) then
      item := dblItem.KeyValue;
    if not DM.cdsCategoriasItensAgendados.Active then
    begin
      DM.cdsCategoriasItensAgendados.CreateDataSet;
      DM.cdsCategoriasItensAgendados.IndexName := '';
      DM.cdsCategoriasItensAgendados.IndexFieldNames := 'NOME';
      DM.cdsCategoriasItensAgendados.LogChanges := False;
    end;

    if (FileExists(fmIndex.dir_dados + 'itensAgendadosCategorias.xml')) then
      DM.cdsCategoriasItensAgendados.LoadFromFile(fmIndex.dir_dados + 'itensAgendadosCategorias.xml');
    DM.cdsCategoriasItensAgendados.Open;
    dblItem.KeyValue := item;
  end;
end;

procedure TfLiturgia.FormActivate(Sender: TObject);
var
  tipo: string;
begin
  pnlAnotacoes.Visible := False;
  pnlHinos.Visible := False;
  pnlSite.Visible := False;
  pnlArquivo.Visible := False;
  pnlItensAgendados.Visible := False;
  ScrollBox1.Visible := True;

  if (Trim(id) = '') then
  begin
    btAdd.Caption := ' Adicionar';
    btAdd.ImageIndex := 44;
    btDel.Visible := False;
  end
  else
  begin
    btAdd.Caption := ' Salvar';
    btAdd.ImageIndex := 2;
    btDel.Visible := True;
  end;

  tipo := fmIndex.lerParam(id, 'tipo', '', fmIndex.arq_liturgia);
  if tipo = 'anotacao'
    then edtAnotacao.Text := fmIndex.lerParam(id, 'subitem', '', fmIndex.arq_liturgia)
    else edtAnotacao.Text := '';
  if tipo = 'site'
    then urlSite.Text := fmIndex.lerParam(id, 'url', '', fmIndex.arq_liturgia)
    else urlSite.Text := '';
  if tipo = 'arquivo' then
  begin
    edtDiretorio.Text := fmIndex.lerParam(id, 'dir', '', fmIndex.arq_liturgia);
    edtDiretorioInfo.Text := fmIndex.lerParam(id, 'dir_info', '', fmIndex.arq_liturgia);
  end
  else
  begin
    edtDiretorio.Text := '';
    edtDiretorioInfo.Text := '';
  end;
  if tipo = 'itensagendados'
    then dblItem.KeyValue := fmIndex.lerParam(id, 'id', '', fmIndex.arq_liturgia)
    else dblItem.KeyValue := '';
  opcHinosOpc1.Checked := (fmIndex.lerParam(id, 'escolha', '0', fmIndex.arq_liturgia) = '1');
  txtItem.Text := fmIndex.lerParam(id, 'item', '', fmIndex.arq_liturgia);
  csCor.ColorValue := StringToColor(fmIndex.lerParam(id, 'cor', '$004F0000', fmIndex.arq_liturgia));
  dbLitHinoLista.KeyValue := fmIndex.lerParam(id, 'musica', '-1', fmIndex.arq_liturgia);
  cbItens.ItemIndex := AnsiIndexStr(fmIndex.lerParam(id, 'tipo', '$004F0000', fmIndex.arq_liturgia),
                               ['anotacao', 'arquivo','categoria','itensagendados','musica','site']);

  cbItensChange(Sender);
end;

procedure TfLiturgia.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfLiturgia.opcHinosOpc1Click(Sender: TObject);
begin
  pnlHinosOpc1.Visible := not opcHinosOpc1.Checked;
end;

procedure TfLiturgia.txtItemKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.edtKeyUp(Sender,Key,Shift);
end;

procedure TfLiturgia.urlSiteExit(Sender: TObject);
begin
  urlSite.text := validaURL(urlSite.text);
end;

function TfLiturgia.validaURL(url: string): string;
begin
  if (Copy(url,1,7) <> 'http://') and
     (Copy(url,1,8) <> 'https://') and
     (Copy(url,1,6) <> 'ftp://')
    then url := 'http://'+url;

  Result := url;
end;

end.
