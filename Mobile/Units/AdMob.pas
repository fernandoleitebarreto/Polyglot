unit AdMob;

interface

uses
{$IFDEF ANDROID}
  Androidapi.JNI.AdMob, Androidapi.JNIBridge, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Widget, Androidapi.JNI.Location, Androidapi.JNI.App,
  Androidapi.JNI.Util, Androidapi.helpers, FMX.helpers.android,
  FMX.Platform.android, Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.PlayServices,
{$ENDIF}
  System.Types, System.UITypes, System.Classes, System.SysUtils, FMX.Dialogs,
  FMX.Advertising, FMX.Types;

type
  TAdBannerType = (Banner, Interstitial, Rewarded, AppOpen);
  TOnClosed = procedure(bannerType: TAdBannerType) of object;

{$IFDEF ANDROID}

  TMyAdViewListener = class(TJavaLocal, JIAdListener)
  private
    FAD: JInterstitialAd;
    FisShown: Boolean;
    FTestMode: Boolean;
    FOnClosed: TOnClosed;
    FBannerType: TAdBannerType;
    procedure SetOnClosed(const Value: TOnClosed);
  public
    property isShown: Boolean read FisShown;
    property Testmode: Boolean read FTestMode write FTestMode;
    destructor Destroy; override;
    constructor Create(AAD: JInterstitialAd);
  public
    property onBannerClosed: TOnClosed read FOnClosed write SetOnClosed;
    property bannerType: TAdBannerType read FBannerType write FBannerType;
    procedure onAdClosed; cdecl;
    procedure onAdFailedToLoad(errorCode: Integer); cdecl;
    procedure onAdLeftApplication; cdecl;
    procedure onAdOpened; cdecl;
    procedure onAdLoaded; cdecl;
  end;
{$ENDIF}

  TAdBanner = class
  private
    FTestMode: Boolean;
    FAowner: TFmxObject;
    FBannerType: TAdBannerType;
    FAdBanner: TBannerAd;
    { InterStitial }
{$IFDEF ANDROID}
    LAdViewListener: TMyAdViewListener;
    FAdMob: JInterstitialAd;
    LADRequestBuilder: JAdRequest_Builder;
    LadRequest: JAdRequest;
{$ENDIF}
    FisShown: Boolean;
    FOnClosed: TOnClosed;

    function bannerType: TAdBannerType;
    function Testmode: Boolean;
    function isShown: Boolean;
    function OnClosed: TOnClosed;

    procedure BannerAdDidFail(Sender: TObject; const Error: string);
    procedure BannerAdDidLoad(Sender: TObject);
    procedure SetOnClosed(const Value: TOnClosed);
  public
    procedure setParent(AOwner: TFmxObject);
    constructor Create(AOwner: TFmxObject; AdUnitId: String;
      bannerType: TAdBannerType);
    destructor Destroy; override;

    property onBannerClosed: TOnClosed read FOnClosed write SetOnClosed;
    procedure show(Testmode: Boolean = true;
      Aligment: TAlignLayout = TAlignLayout.Top);
    procedure hide;
  end;

implementation

procedure RaiseException(Testmode: Boolean; MessageError: String);
begin
  if not(Testmode) then
    exit;

  Log.D('RaiseException: ' + MessageError);
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      try
        if (MessageError <> '') then
          raise Exception.Create(MessageError);
      except
      end;
    end);
end;

{ TMyAdViewListener }

{$IFDEF ANDROID}


constructor TMyAdViewListener.Create(AAD: JInterstitialAd);
begin
  try
    inherited Create;
    FAD := AAD;
    FisShown := false;
    FTestMode := false;
  except
    RaiseException(Testmode, 'Sem Conexão de internet');
  end;
end;

destructor TMyAdViewListener.Destroy;
begin
  if Assigned(FAD) then
    FAD := nil;
end;

procedure TMyAdViewListener.onAdClosed;
begin
  FisShown := false;

  TThread.Synchronize(nil,
    procedure
    begin
      if (Assigned(FOnClosed)) then
        FOnClosed(bannerType);
    end);
end;

procedure TMyAdViewListener.onAdFailedToLoad(errorCode: Integer);
begin
  FisShown := false;

  Log.D('Intersititial/Reward-FailedToLoad = ' + errorCode.ToString);
  if (errorCode = 0) then
    RaiseException(FTestMode, 'AdUnitId inválida.' + sLineBreak +
      'ERROR_CODE_INTERNAL_ERROR' + sLineBreak + 'Código de Erro: ' +
      errorCode.ToString)
  else if (errorCode = 1) then
    RaiseException(FTestMode, 'AdUnitId inválida.' + sLineBreak +
      'ERROR_CODE_INVALID_REQUEST' + sLineBreak + 'Código de Erro: ' +
      errorCode.ToString)
  else if (errorCode = 2) then
    RaiseException(FTestMode, 'AdUnitId válida, tempo de espera esgotado.' +
      sLineBreak + 'ERROR_CODE_NETWORK_ERROR' + sLineBreak + 'Código de Erro: '
      + errorCode.ToString)
  else if (errorCode = 3)
  then { ESSE ERRO INFORMA QUE A COMUNICAÇÃO ESTÁ CORRETA COM O ADMOB, SÓ AGUARDAR AGORA ATÉ SUA CONTA SER ATIVADA }
    RaiseException(FTestMode,
      'AdUnitId válida. Aguarde até 24 horas, após a criação da promoção, para ser validada.'
      + sLineBreak + 'ERROR_CODE_NO_FILL' + sLineBreak + 'Código de Erro: ' +
      errorCode.ToString);
end;

procedure TMyAdViewListener.onAdLeftApplication;
begin

end;

procedure TMyAdViewListener.onAdLoaded;
begin
  try
    FAD.show;
    FisShown := true;
    Log.D('Intersititial/Reward-Load = Sucess');
  except
    on E: Exception do
      RaiseException(FTestMode, 'onAdLoaded error: ' + E.Message);
  end;
end;

procedure TMyAdViewListener.onAdOpened;
begin

end;

procedure TMyAdViewListener.SetOnClosed(const Value: TOnClosed);
begin
  FOnClosed := Value;
end;

{$ENDIF}
{ TAdBanner }

function TAdBanner.bannerType: TAdBannerType;
begin
  Result := Self.FBannerType;
end;

function TAdBanner.isShown: Boolean;
begin
  Result := Self.FisShown;
end;

function TAdBanner.Testmode: Boolean;
begin
  Result := Self.FTestMode;
end;

function TAdBanner.OnClosed: TOnClosed;
begin
  Result := Self.FOnClosed;

end;

procedure TAdBanner.BannerAdDidFail(Sender: TObject; const Error: string);
begin
  Log.D('BannerAdDidFail = ' + Error);
  FisShown := false;
  if (Error.Contains('0')) then
    RaiseException(FTestMode, 'AdUnitId inválida.' + sLineBreak +
      'ERROR_CODE_INTERNAL_ERROR' + sLineBreak + 'Mensagem: ' + Error)
  else if (Error.Contains('1')) then
    RaiseException(FTestMode, 'AdUnitId inválida.' + sLineBreak +
      'ERROR_CODE_INVALID_REQUEST' + sLineBreak + 'Mensagem: ' + Error)
  else if (Error.Contains('2')) then
    RaiseException(FTestMode, 'AdUnitId válida, tempo de espera esgotado.' +
      sLineBreak + 'ERROR_CODE_NETWORK_ERROR' + sLineBreak +
      'Mensagem: ' + Error)
  else if (Error.Contains('3')) then
    RaiseException(FTestMode,
      'AdUnitId válida. Aguarde até 24 horas, após a criação da promoção, para ser validada.'
      + sLineBreak + 'ERROR_CODE_NO_FILL' + sLineBreak + 'Mensagem: ' + Error);
end;

procedure TAdBanner.BannerAdDidLoad(Sender: TObject);
begin
  FisShown := true;
  Log.D('BannerAdDidLoad = Sucess');
end;

constructor TAdBanner.Create(AOwner: TFmxObject; AdUnitId: String;
bannerType: TAdBannerType);
begin
  inherited Create;
  // Log.D('Create: 01');
  FisShown := false;
  FTestMode := false;
  FAowner := AOwner;
  FBannerType := bannerType;
  if (bannerType = TAdBannerType.Banner) then
  begin
    // Log.D('Create Banner: 02');
    FAdBanner := TBannerAd.Create(AOwner);
    FAdBanner.Parent := FAowner;
    FAdBanner.AdUnitId := AdUnitId;
    FAdBanner.OnDidFail := BannerAdDidFail;
    FAdBanner.OnDidLoad := BannerAdDidLoad;
    // Log.D('Create Banner: 03');
  end
  else if (bannerType = TAdBannerType.Interstitial) then
  begin
    // Log.D('Create Interstitial: 04');
{$IFDEF ANDROID}
    FAdMob := TJInterstitialAd.JavaClass.init(MainActivity);
    FAdMob.setAdUnitId(StringToJString(AdUnitId)); { Interstitial }
{$ENDIF} {$IFDEF IOS}
    RaiseException(true,
      'Desculpe, o banner "Interstitial" não foi implementado para IOS até o momento.');
{$ENDIF}
    // Log.D('Create Interstitial: 05');
  end
  else if (bannerType = TAdBannerType.Rewarded) then
  begin
    // Log.D('Create Rewarded: 06');
{$IFDEF ANDROID}
    FAdMob := TJInterstitialAd.JavaClass.init(MainActivity);
    FAdMob.setAdUnitId(StringToJString(AdUnitId)); { Interstitial }
{$ENDIF} {$IFDEF IOS}
    RaiseException(true,
      'Desculpe, o banner "Rewarded" não foi implementado para IOS até o momento.');
{$ENDIF}
    Log.D('Create Rewarded: 07');
  end
  else if (bannerType = TAdBannerType.AppOpen) then
  begin
    // Log.D('Create App Open: 08');
{$IFDEF ANDROID}
    FAdMob := TJInterstitialAd.JavaClass.init(MainActivity);
    // Log.D('Create App Open: 09');
    FAdMob.setAdUnitId(StringToJString(AdUnitId)); { Interstitial }
{$ENDIF} {$IFDEF IOS}
    RaiseException(true,
      'Desculpe, o banner "App Open" não foi implementado para IOS até o momento.');
{$ENDIF}
    // Log.D('Create App Open: 10');
  end;

  // Log.D('Create: 11');
end;

destructor TAdBanner.Destroy;
begin
{$IFDEF ANDROID}
  if Assigned(LAdViewListener) then
    FreeAndNil(LAdViewListener);

  if Assigned(FAdBanner) then
    FreeAndNil(FAdBanner);

  if Assigned(LADRequestBuilder) then
    LADRequestBuilder := nil;

  if Assigned(LadRequest) then
    LadRequest := nil;

  if Assigned(FAdMob) then
    FAdMob := nil;
{$ENDIF}
  inherited;
end;

procedure TAdBanner.hide;
begin
  Log.D('hide: 01');
  if (FBannerType = TAdBannerType.Banner) then
  begin
    FAdBanner.hide;
    FAdBanner.Visible := false;
    FisShown := false;
  end
  else if (FBannerType = TAdBannerType.Interstitial) or
    (FBannerType = TAdBannerType.Rewarded) or
    (FBannerType = TAdBannerType.AppOpen) then
  begin
{$IFDEF ANDROID}
    FisShown := LAdViewListener.isShown;
{$ENDIF}
  end;
  Log.D('hide: 02');
end;

procedure TAdBanner.SetOnClosed(const Value: TOnClosed);
begin
  FOnClosed := Value;
end;

procedure TAdBanner.setParent(AOwner: TFmxObject);
begin
  FAowner := AOwner;
  if (FBannerType = TAdBannerType.Banner) then
    FAdBanner.Parent := FAowner
  else if (FBannerType = TAdBannerType.Interstitial) or
    (FBannerType = TAdBannerType.Rewarded) or
    (FBannerType = TAdBannerType.AppOpen) then
  begin
{$IFDEF ANDROID}
    FisShown := LAdViewListener.isShown;
{$ENDIF}
  end;
end;

procedure TAdBanner.show(Testmode: Boolean; Aligment: TAlignLayout);
begin
  Log.D('show: 01');
  FTestMode := Testmode;
  if (FBannerType = TAdBannerType.Interstitial) or
    (FBannerType = TAdBannerType.Rewarded) or
    (FBannerType = TAdBannerType.AppOpen) then
  begin
    Log.D('show Interstitial/Rewarded/AppOpen: 02');
{$IFDEF ANDROID}
    try
      LADRequestBuilder := TJAdRequest_Builder.Create;
      if (Testmode) then
        LADRequestBuilder.addTestDevice(MainActivity.getDeviceID);
      LadRequest := LADRequestBuilder.build();
      LAdViewListener := TMyAdViewListener.Create(FAdMob);
      LAdViewListener.Testmode := FTestMode;
      LAdViewListener.bannerType := bannerType;
      LAdViewListener.onBannerClosed := onBannerClosed;
      CallInUIThread(
        procedure
        begin
          try
            FAdMob.setAdListener(TJAdListenerAdapter.JavaClass.init
              (LAdViewListener));
            FAdMob.loadAd(LadRequest);
            Self.FisShown := LAdViewListener.isShown;
          except
          end;
        end);
    except
    end;
{$ENDIF}
    Log.D('show Interstitial/Rewarded/AppOpen: 03');
  end
  else if (FBannerType = TAdBannerType.Banner) then
  begin
    Log.D('show Banner: 04');
    FAdBanner.AdSize := TBannerAdSize.Auto;
    FAdBanner.Enabled := true;
    FAdBanner.Align := Aligment;
    FAdBanner.Testmode := Testmode;
    FAdBanner.Visible := true;
    if not(FAdBanner.IsLoaded) then
      FAdBanner.loadAd
    else
      FAdBanner.show;
    FisShown := true;
    Log.D('show Banner: 05');
  end;
  Log.D('show: 06');
end;

end.
