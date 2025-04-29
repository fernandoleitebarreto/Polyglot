unit uMediaPlayerThread;

interface

uses
  Classes, FMX.Media;

type
  TMediaPlayerThread = class(TThread)
  private
    FMediaPlayer: TMediaPlayer;
  protected
    procedure Execute; override;
  public
    constructor Create(AMediaPlayer: TMediaPlayer;
      const AFileName: string); overload;
    constructor Create(AMediaPlayer: TMediaPlayer); overload;
    class procedure WaitForThread;
  end;

implementation

var
  FLock: TObject;

constructor TMediaPlayerThread.Create(AMediaPlayer: TMediaPlayer;
  const AFileName: string);
begin
  inherited Create(True); // Create the thread in a suspended state
  FreeOnTerminate := True; // Automatically free the thread when it finishes
  FMediaPlayer := AMediaPlayer;
  
  if FMediaPlayer.State = TMediaState.Playing then
    FMediaPlayer.Stop;

  if FMediaPlayer.FileName <> AFileName then
    FMediaPlayer.FileName := AFileName;

end;

constructor TMediaPlayerThread.Create(AMediaPlayer: TMediaPlayer);
begin
  inherited Create(True); // Create the thread in a suspended state
  FreeOnTerminate := True; // Automatically free the thread when it finishes
  FMediaPlayer := AMediaPlayer;
  
  if FMediaPlayer.State = TMediaState.Playing then
    FMediaPlayer.Stop;
end;

procedure TMediaPlayerThread.Execute;
begin
  if not TMonitor.TryEnter(FLock) then
    Exit;

  try
    if FMediaPlayer.Media <> nil then
    begin
      FMediaPlayer.CurrentTime := 0;
      FMediaPlayer.Play;
    end;
  finally
    TMonitor.Exit(FLock);
  end;
end;

class procedure TMediaPlayerThread.WaitForThread;
begin
  TMonitor.Enter(FLock);
  TMonitor.Exit(FLock);
end;

initialization

FLock := TObject.Create;

finalization

FLock.Free;

end.
