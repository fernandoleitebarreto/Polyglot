unit uExibeAds;

interface

uses
  System.Classes, System.SysUtils, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  AdMob113, uFunctions, FMX.Layouts, UnitConstante, FMX.Types;

type
  TExibirAds = class(TThread)
  private
    { Private declarations }
    FBannerAd: TAdBanner;
    FRewarded: TAdBanner;
    FLay_Content: TLayout;
    FEnableRewarded, FEnableBanner: Boolean;
    FEventoBeforeExecute: TProc;
    FEventoAfterExecute: TProc;
  protected
    procedure Execute; override;
  public
    constructor Create(Lay_Content: TLayout; pEventoBeforeExecute: TProc;
      pEventoAfterExecute: TProc = nil; EnableRewarded: Boolean = True;
      EnableBanner: Boolean = True);
    destructor Destroy; override;

  end;

implementation

{ TExibirAds }

constructor TExibirAds.Create(Lay_Content: TLayout; pEventoBeforeExecute: TProc;
  pEventoAfterExecute: TProc = nil; EnableRewarded: Boolean = True;
  EnableBanner: Boolean = True);
begin
  inherited Create(False);

  FEventoBeforeExecute := pEventoBeforeExecute;
  FEventoAfterExecute := pEventoAfterExecute;
  FEnableRewarded := EnableRewarded;
  FEnableBanner := EnableBanner;
  FLay_Content := Lay_Content;

  // Quando terminar de rodar o Execute, já auto destroi
  Self.FreeOnTerminate := True;

end;

procedure TExibirAds.Execute;
begin
  FEventoBeforeExecute;

  try
    Self.Synchronize(nil,
      procedure
      begin
        if (not Terminated) then
        begin
          if FEnableRewarded then
          begin

            FRewarded := TAdBanner.Create(FLay_Content,
              TFunctions.AppIDRewarded, TAdBannerType.Rewarded);

            FRewarded.show(IsDebuging);

          end;

          if FEnableBanner then
          begin

            FBannerAd := TAdBanner.Create(FLay_Content, TFunctions.AppIDBanner,
              TAdBannerType.Banner);
            FBannerAd.show(IsDebuging, TAlignLayout.MostBottom);
          end;

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

destructor TExibirAds.Destroy;
begin
  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  inherited;
end;

end.
