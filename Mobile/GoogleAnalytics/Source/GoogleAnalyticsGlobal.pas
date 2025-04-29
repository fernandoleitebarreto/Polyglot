unit GoogleAnalyticsGlobal;

interface

uses
  Google.Controller.Analytics.Interfaces, UnitConstante;

var
  _GoogleAnalytics: iControllerGoogleAnalytics;

implementation

uses
  Google.Controller.Analytics;

initialization

_GoogleAnalytics := TControllerGoogleAnalytics
  .New(GooglePropertyID);

_GoogleAnalytics.AppInfo
  .AppName(AppName)
  .AppVersion(VersaoSistema)
  .AppLicense(AppLicense)
  .AppEdition(AppEdition);

end.
