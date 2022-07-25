unit fmIdentificaMonitores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfIdentificaMonitores = class(TForm)
    rotulo: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fIdentificaMonitores: TfIdentificaMonitores;

implementation

{$R *.dfm}

procedure TfIdentificaMonitores.Timer1Timer(Sender: TObject);
begin
  Close;
end;

end.
