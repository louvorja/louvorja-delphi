unit fmMonitorSorteioNomes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, bsSkinExCtrls, bsSkinCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfMonitorSorteioNomes = class(TForm)
    pnlSorteioNM: TPanel;
    imgSorteioNM: TImage;
    lmdSorteioNM: TLabel;
    gSorteioNM: TbsSkinGauge;
    pnlSorteioNME: TbsSkinExPanel;
    lbSorteioNM: TbsSkinOfficeListBox;
    pnlSorteioNMD: TbsSkinExPanel;
    lbSorteadoNM: TbsSkinOfficeListBox;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbSorteioNMItemCheckClick(Sender: TObject);
    procedure pnlSorteioNMDClose(Sender: TObject);
    procedure pnlSorteioNMEClose(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  fMonitorSorteioNomes: TfMonitorSorteioNomes;

implementation

{$R *.dfm}

uses fmMenu;

procedure TfMonitorSorteioNomes.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if (fmIndex.ckMesmaJanela.checked = true) then Exit;
  Params.WndParent := 0;
end;

procedure TfMonitorSorteioNomes.FormActivate(Sender: TObject);
begin
  fmIndex.btExp_SorteioNM.ImageIndex := 11;
end;

procedure TfMonitorSorteioNomes.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: integer;
begin
  if (AlphaBlendValue > 0) then
  begin
    if fmIndex.ckFadeForm.Checked then
    begin
      for i := AlphaBlendValue downto 0 do
      begin
        AlphaBlendValue := i;
        sleep(1);
      end;
    end
    else AlphaBlendValue := 0;
  end;

  fmIndex.btExp_SorteioNM.ImageIndex := 10;
end;

procedure TfMonitorSorteioNomes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fmIndex.FormKeyUp(Sender, Key, Shift);
end;

procedure TfMonitorSorteioNomes.lbSorteioNMItemCheckClick(Sender: TObject);
begin
  fmIndex.lbSorteioNM.ItemIndex := lbSorteioNM.ItemIndex;
  fmIndex.lbSorteioNM.Items[lbSorteioNM.ItemIndex].Checked := lbSorteioNM.Items[lbSorteioNM.ItemIndex].Checked;
  fmIndex.lbSorteioNMItemCheckClick(Sender);
end;

procedure TfMonitorSorteioNomes.pnlSorteioNMDClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio Nomes', 'Numeros Sorteados (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExpNM.ItemChecked[1] := false;
end;

procedure TfMonitorSorteioNomes.pnlSorteioNMEClose(Sender: TObject);
begin
  fmIndex.gravaParam('Sorteio Nomes', 'Numeros Sorteio (Extendido)', '0');
  fmIndex.copiaDadosTelaExtendida();
  fmIndex.ckSorteioExpNM.ItemChecked[0] := false;
end;

end.
