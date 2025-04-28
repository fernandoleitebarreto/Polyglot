program Servidor;

uses
  Vcl.SvcMgr,
  UnitDM in 'UnitDM.pas' {dm: TDataModule},
  uPolyglotServer in 'uPolyglotServer.pas' {PolyglotServer: TService},
  uDebug in 'uDebug.pas' {FrmDebug},
  uFunctions in '..\Mobile\Units\uFunctions.pas',
  uConsulta in 'uConsulta.pas',
  UnitConstante in '..\Mobile\UnitConstante.pas',
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
  uClassFunctions in 'Classes\uClassFunctions.pas',
  uClassSendEmail in 'Classes\uClassSendEmail.pas',
  cParametro in 'Classes\cParametro.pas',
  cUsuario in 'Classes\cUsuario.pas',
  DataSetConverter4D.Helper in '..\Delphi\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\Delphi\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\Delphi\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\Delphi\DataSetConverter4D.Util.pas';

{$R *.res}


begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TFrmDebug, FrmDebug);
  FrmDebug.ShowModal;
  Application.Run;
{$ELSE}
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TPolyglotServer, PolyglotServer);
  Application.Run;
{$ENDIF}


end.
