unit uPolyglotServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.SvcMgr;

type
  TPolyglotServer = class(TService)
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  PolyglotServer: TPolyglotServer;

implementation

uses
  UnitDM;

{$R *.dfm}


procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  PolyglotServer.Controller(CtrlCode);
end;

function TPolyglotServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TPolyglotServer.ServiceCreate(Sender: TObject);
begin
  if not Assigned(dm) then
    Application.CreateForm(Tdm, dm);
  dm.LoadConfig;
end;

procedure TPolyglotServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  dm.RESTServicePooler.Active := False;
end;

end.
