unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, uDWAbout, uRESTDWBase, uRESTDWServerEvents,
  FMX.Edit, Data.DB;

type
  TFrmPrincipal = class(TForm)
    Label1: TLabel;
    Switch: TSwitch;
    OpenDialog: TOpenDialog;
    RESTServicePooler: TRESTServicePooler;
    procedure SwitchSwitch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitDM;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  RESTServicePooler.ServerMethodClass := Tdm;
  RESTServicePooler.Active := Switch.IsChecked;
end;

procedure TFrmPrincipal.SwitchSwitch(Sender: TObject);
begin
  RESTServicePooler.Active := Switch.IsChecked;
end;

end.

// http://localhost:8082/validalogin?email=teste@teste.com.br&senha=1234
