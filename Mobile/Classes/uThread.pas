unit uThread;

interface

uses
  System.Classes, System.SysUtils, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  AdMob, uFunctions, FMX.Layouts, UnitConstante, FMX.Types;

type
  TThreadSQL = class(TThread)
  private
    { Private declarations }
    FBannerAd: TAdBanner;
    FRewarded: TAdBanner;
    FLay_Content: TLayout;
    FEnableRewarded, FEnableBanner: Boolean;
    FEventoAfterExecute: TProc;
  protected
    procedure Execute; override;
  public
    constructor Create(pEventoAfterExecute: TProc; Lay_Content: TLayout;
      EnableRewarded: Boolean = True; EnableBanner: Boolean = True);
    destructor Destroy; override;

  end;

implementation

{ TThreadSQL }

constructor TThreadSQL.Create(pEventoAfterExecute: TProc; Lay_Content: TLayout;
  EnableRewarded: Boolean = True; EnableBanner: Boolean = True);
begin
  inherited Create(False);

  FEventoAfterExecute := pEventoAfterExecute;
  FEnableRewarded := EnableRewarded;
  FEnableBanner := EnableBanner;
  FLay_Content := Lay_Content;
  // Priority := TpLower;

  // Quando terminar de rodar o Execute, já auto destroi
  Self.FreeOnTerminate := True;

end;

procedure TThreadSQL.Execute;
begin
  if FEnableRewarded then
  begin

    FRewarded := TAdBanner.Create(FLay_Content, TFunctions.AppIDRewarded,
      TAdBannerType.Rewarded);

    FRewarded.show(IsDebuging);

  end;

  if FEnableBanner then
  begin

    FBannerAd := TAdBanner.Create(FLay_Content, TFunctions.AppIDBanner,
      TAdBannerType.Banner);
    FBannerAd.show(IsDebuging, TAlignLayout.MostBottom);
  end;

  try
    Self.Synchronize(nil,
      procedure
      begin
        if (not Terminated) then
        begin
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

destructor TThreadSQL.Destroy;
begin
  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  inherited;
end;

end.
