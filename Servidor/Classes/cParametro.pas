unit cParametro;

interface

uses System.Variants, System.SysUtils, FMX.Graphics,
  Firedac.Comp.Client, Firedac.Stan.Param, Firedac.DApt;

type
  TFunctionParametro = class
  private
    FConn: TFDConnection;
    FVersion: string;
    FDeveloper: string;
    procedure SetDeveloper(const Value: string);
    procedure SetVersion(const Value: string);

  public
    property Version: string read FVersion write SetVersion;
    property Developer: string read FDeveloper write SetDeveloper;

    constructor Create(conn: TFDConnection); overload;
    constructor Create; overload;
    destructor Destroy; override;
    function getVersion(out erro: string): Boolean;

  end;

implementation

{ TFunctionParametro }

uses uFunctions, Data.DB, uConsulta;

constructor TFunctionParametro.Create(conn: TFDConnection);
begin
  Self.Create;
  FConn := conn;
end;

constructor TFunctionParametro.Create;
begin
  FDeveloper := 'Fernando Leite Barreto';
  FVersion := '1.0.0.0';

end;

destructor TFunctionParametro.Destroy;
begin

  inherited;
end;

procedure TFunctionParametro.SetDeveloper(const Value: string);
begin
  FDeveloper := Value;
end;

procedure TFunctionParametro.SetVersion(const Value: string);
begin
  FVersion := Value;
end;

function TFunctionParametro.getVersion(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).Consulta_Dinamica
      ('SELECT FIRST 1 VERSION, DEVELOPER FROM PARAMETRO');

    if qry.RecordCount > 0 then
    begin
      Self.Version := qry.FieldByName('VERSION').AsString;
      Self.Developer := qry.FieldByName('DEVELOPER').AsString;
      Result := True;
    end
    else
    begin
      erro := 'Somethind went wrong... Version not found';
      Result := False;
    end;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Error finding version: ' + ex.Message;
      Result := False;
    end;
  end;

end;

end.
