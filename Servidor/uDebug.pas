unit uDebug;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.WinXCtrls;

type
  TFrmDebug = class(TForm)
    Switch: TToggleSwitch;
    Label1: TLabel;
    Button1: TButton;
    edEmail: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure SwitchClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDebug: TFrmDebug;

implementation

uses
  UnitDM;

{$R *.dfm}


procedure TFrmDebug.Button1Click(Sender: TObject);
begin
  // edEmail.Text := 'renatavilela.cont@outlook.com';
  dm.SendEmail(edEmail.Text);
end;

procedure TFrmDebug.FormCreate(Sender: TObject);
begin
  Application.CreateForm(Tdm, dm);
  dm.LoadConfig;
end;

procedure TFrmDebug.SwitchClick(Sender: TObject);
begin
  dm.RESTServicePooler.Active := Switch.State = TToggleSwitchState.tssOn;
end;

// http://localhost:8082/validalogin?email=teste@teste.com.br&senha=1234

end.
