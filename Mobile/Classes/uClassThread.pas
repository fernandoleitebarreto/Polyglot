unit uClassThread;

interface

uses
  System.Classes, System.SysUtils,
  System.Threading, System.Generics.Collections;

type

  TThreadTask = class(TThread)
  private
    { Private declarations }
    FEventoExecute: TProc;
    FEventoAfterExecute: TProc;
  protected
    procedure Execute; override;
  public
    constructor Create(pEventoExecute: TProc; pEventoAfterExecute: TProc = nil);
    destructor Destroy; override;

  end;

implementation

{ TThreadTask }

constructor TThreadTask.Create(pEventoExecute, pEventoAfterExecute: TProc);
begin
  inherited Create(False);

  Self.FEventoExecute := pEventoExecute;
  Self.FEventoAfterExecute := pEventoAfterExecute;
  Self.FreeOnTerminate := True;
  // Quando terminar de rodar o Execute, já auto destroi
end;

destructor TThreadTask.Destroy;
begin

  inherited;
end;

procedure TThreadTask.Execute;
begin
  inherited;
  FEventoExecute;
  try
    Self.Synchronize(nil,
      procedure
      begin
        if (not Terminated) then
        begin
          if Assigned(FEventoAfterExecute) then
            FEventoAfterExecute;
        end; // if (not Terminated) then
      end);
  except
    on E: Exception do
    begin
      E.Message := 'Erro ao executar o Synchronize: ' + E.Message;
      raise;
    end;
  end;
end;

end.
