program Polyglot;

uses
  {$IFDEF EurekaLog}
  EMemLeaks,
  {$ENDIF EurekaLog}
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  FMX.Types,
  u99Permissions in 'Units\u99Permissions.pas',
  uMD5 in 'Units\uMD5.pas',
  uHorizontalPresentation in 'uHorizontalPresentation.pas',
  uClassMeaning in 'Classes\uClassMeaning.pas',
  uFunctions in 'Units\uFunctions.pas',
  UnitMeaning in 'UnitMeaning.pas' {FrmMeaning},
  UnitDM in 'UnitDM.pas' {dm: TDataModule},
  UnitAddAudio in 'UnitAddAudio.pas' {FrmAddAudio},
  uClassThread in 'Classes\uClassThread.pas',
  ExtendParseApiUnit in 'Classes\ExtendParseApiUnit.pas',
  UnitLogin in 'UnitLogin.pas' {FrmLogin},
  UnitCadWords in 'UnitCadWords.pas' {FrmCadWords},
  uClassCategory in 'Classes\uClassCategory.pas',
  UnitSelectWords in 'UnitSelectWords.pas' {FrmSelectWords},
  UnitMemorize in 'UnitMemorize.pas' {FrmMemorize},
  uArrayUtils in 'Classes\uArrayUtils.pas',
  uCircle in 'uCircle.pas' {CircleFrame},
  UAndroidLocation in 'Units\UAndroidLocation.pas',
  SaveStateHelper in 'Units\SaveStateHelper.pas',
  Amazon.Storage.Service.API.Life.Cycle in 'Amazon\Amazon.Storage.Service.API.Life.Cycle.pas',
  Amazon.Storage.Service.API in 'Amazon\Amazon.Storage.Service.API.pas',
  Amazon.Storage.Service.Config in 'Amazon\Amazon.Storage.Service.Config.pas',
  Amazon.Storage.Service.Intf in 'Amazon\Amazon.Storage.Service.Intf.pas',
  Amazon.Storage.Service in 'Amazon\Amazon.Storage.Service.pas',
  Amazon.Storage.Service.Types in 'Amazon\Amazon.Storage.Service.Types.pas',
  UnitCompleteWords in 'UnitCompleteWords.pas' {FrmCompleteWords},
  UnitPadrao in 'UnitPadrao.pas' {FrmPadrao},
  UnitUser in 'UnitUser.pas' {FrmUser},
  UnitCategory in 'UnitCategory.pas' {FrmCategory},
  uRanking in 'uRanking.pas' {RankingFrame: TFrame},
  UnitPresentation in 'UnitPresentation.pas' {FrmPresentation},
  uHorizontalMeaning in 'uHorizontalMeaning.pas',
  uOpenViewUrl in 'Units\uOpenViewUrl.pas',
  FMX.GifUtils in 'Classes\FMX.GifUtils.pas',
  UnitConstante in 'UnitConstante.pas',
  FMX.InAppPurchase in '..\FMX.InAppPurchase.pas',
  Google.Controller.Analytics.Interfaces in 'GoogleAnalytics\Source\Controller\Google.Controller.Analytics.Interfaces.pas',
  Google.Controller.Analytics in 'GoogleAnalytics\Source\Controller\Google.Controller.Analytics.pas',
  Google.Model.Analytics.AppInfo in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.AppInfo.pas',
  Google.Model.Analytics.Event in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Event.pas',
  Google.Model.Analytics.Exception in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Exception.pas',
  Google.Model.Analytics.Factory.Interfaces in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Factory.Interfaces.pas',
  Google.Model.Analytics.Factory in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Factory.pas',
  Google.Model.Analytics.Interfaces in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Interfaces.pas',
  Google.Model.Analytics.Invoker in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Invoker.pas',
  Google.Model.Analytics.PageView in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.PageView.pas',
  Google.Model.Analytics.ScreenView in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.ScreenView.pas',
  Google.Model.Analytics.Session in 'GoogleAnalytics\Source\Model\Google.Model.Analytics.Session.pas',
  GoogleAnalyticsGlobal in 'GoogleAnalytics\Source\GoogleAnalyticsGlobal.pas',
  uClassInAppPurchase in 'Classes\uClassInAppPurchase.pas',
  uExibeAds in 'Classes\uExibeAds.pas',
  CCR.PrefsIniFile.Android in '..\Delphi\CCR.PrefsIniFile.Android.pas',
  CCR.PrefsIniFile.Apple in '..\Delphi\CCR.PrefsIniFile.Apple.pas',
  CCR.PrefsIniFile in '..\Delphi\CCR.PrefsIniFile.pas',
  uClassCategory.Intf in '..\Classes\uClassCategory.Intf.pas',
  uClassCountry in '..\Classes\uClassCountry.pas',
  uClassMeaning.Intf in '..\Classes\uClassMeaning.Intf.pas',
  uClassParametro in '..\Classes\uClassParametro.pas',
  uClassSendCode in '..\Classes\uClassSendCode.pas',
  uClassTexts in '..\Classes\uClassTexts.pas',
  uClassUser in '..\Classes\uClassUser.pas',
  uEnum.Helper in '..\Classes\uEnum.Helper.pas',
  uEnum in '..\Classes\uEnum.pas',
  uFormat in '..\Classes\uFormat.pas',
  uMediaPlayerThread in 'Classes\uMediaPlayerThread.pas',
  AdMob113 in 'Units\AdMob113.pas';

{$R *.res}


begin
  GlobalUseSkiaRasterWhenAvailable := True;
  GlobalUseSkia := True;
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;

end.

