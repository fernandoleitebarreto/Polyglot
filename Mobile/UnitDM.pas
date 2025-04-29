unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, REST.Types, REST.Client, FMX.TabControl,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Objects, FMX.Edit, System.UITypes, FMX.Ani, FMX.StdCtrls, IdTCPClient,
  System.JSON, System.IniFiles, System.NetEncoding, System.IOUtils, FMX.Types,
  FMX.Forms, FMX.Controls, FMX.Media, System.Types, uClassTexts, UnitConstante,
  uMediaPlayerThread;

type
  TNotifyEvent = procedure(Sender: TObject) of Object;

  Tdm = class(TDataModule)
    RequestListarCategoria: TRESTRequest;
    RequestOpcional: TRESTRequest;
    qry_config: TFDQuery;
    RequestLogin: TRESTRequest;
    RESTClient: TRESTClient;
    HTTPBasicAuthenticator: THTTPBasicAuthenticator;
    RequestDados: TRESTRequest;
    RequestConta: TRESTRequest;
    RequestSearch: TRESTRequest;
    RequestSendEmailRecoverPassword: TRESTRequest;
    RequestVerifyCode: TRESTRequest;
    RequestSaveNewPassword: TRESTRequest;
    RequestAddWord: TRESTRequest;
    RequestSendSMSRecoverPassword: TRESTRequest;
    RequestAddAudio: TRESTRequest;
    RequestWordsWithoutAudio: TRESTRequest;
    RequestMeaningProximo: TRESTRequest;
    RESTRequest1: TRESTRequest;
    RESTLocation: TRESTClient;
    HTTPLocation: THTTPBasicAuthenticator;
    RequestSetNativeLanguage: TRESTRequest;
    RequestGetNativeLanguage: TRESTRequest;
    RequestFacebook: TRESTRequest;
    RequestRandomDados: TRESTRequest;
    RequestUptUser: TRESTRequest;
    RESTResponse: TRESTResponse;
    RequestListarRanking: TRESTRequest;
    RESTRequestParam: TRESTRequest;
    RequestSendEmailCreateAccount: TRESTRequest;
    RequestSendSMSCreateAccount: TRESTRequest;
    RequestDeleteAccount: TRESTRequest;
    RequestParametro: TRESTRequest;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure RectEffect(Sender: TObject);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure OnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);

  private
    { Private declarations }
    FMediaPlayer, FDone, FError, FRight: TMediaPlayer;
    procedure LoadConfig;
    function IsAddressAvailable(const IPAddress: string; Port: Integer)
      : Boolean;

  public
    { Public declarations }
    procedure LoadAudios;
    procedure LoadAudio(AMediaPlayer: TMediaPlayer; path: string);
    procedure PlayAudio(path: string); overload;
    procedure PlayAudio(AMediaPlayer: TMediaPlayer); overload;
    procedure PlayDoneAudio;
    procedure PlayErrorAudio;
    procedure PlayRightAudio;
    procedure ClickAudioNative(Sender: TObject); overload;
    procedure ClickAudioNative(Sender: TObject; const Point: TPointF); overload;
    function ValidaLogin(usuario: string; out erro: string): Boolean;
    function Search(id_subcategoria: Integer;
      SubCategoryField, termo_busca: string; pagina: Integer;
      out jsonArray: TJSONArray; out erro: string): Boolean;
    function ListarRanking(Id_Usuario: Integer; out jsonArray: TJSONArray;
      out erro: string): Boolean;
  end;

var
  dm: Tdm;

implementation

uses
  FMX.Dialogs, FMX.DialogService, uEnum, FMX.ImgList,
  Amazon.Storage.Service.Config, Amazon.Storage.Service, IdIPWatch, uFunctions;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

function Tdm.IsAddressAvailable(const IPAddress: string; Port: Integer)
  : Boolean;
var
  TCPClient: TIdTCPClient;
begin
  TCPClient := TIdTCPClient.Create(nil);
  try
    try
      TCPClient.Host := IPAddress;
      TCPClient.Port := Port;
      TCPClient.ConnectTimeout := 2000; // Set a timeout value in milliseconds

      // Try to establish a connection
      TCPClient.Connect;

      Result := TCPClient.Connected;
    except
      Result := False;
    end;
  finally
    TCPClient.Free;
  end;
end;

procedure Tdm.LoadConfig;
var
  ini: TIniFile;
  arq_ini: string;
begin
{$IFDEF MSWINDOWS}
  arq_ini := ExtractFilePath(ParamStr(0)) + 'servidor.ini';

  if NOT FileExists(arq_ini) then
  begin
    ShowMessage('Arquivo INI não encontrado: ' + arq_ini);
    exit;
  end;

  ini := TIniFile.Create(arq_ini);

  try
    try
      RESTClient.BaseURL := Format('http://%s:%s',
        [ini.ReadString('Banco de Dados', 'Server', ''), cPort]);
    except
      on ex: Exception do
        raise Exception.Create('Erro ao conectar com o servidor: ' +
          ex.Message);
    end;

  finally
    ini.DisposeOf;
  end;

{$ELSE}
  RESTClient.BaseURL := Format('http://%s:%s', [cIPRemote, cPort])
{$ENDIF}
end;

procedure Tdm.ClickAudioNative(Sender: TObject);
var
  Rectangle: TRectangle absolute Sender;
begin
  if Sender is TRectangle then
    PlayAudio(Rectangle.TagString)
  else
    ShowMessage('No Audio avaliable');
end;

procedure Tdm.ClickAudioNative(Sender: TObject; const Point: TPointF);
var
  Rectangle: TRectangle absolute Sender;
begin
  if Sender is TRectangle then
  begin
    PlayAudio(Rectangle.TagString);
  end
  else
    ShowMessage('No Audio avaliable');
end;

procedure Tdm.LoadAudio(AMediaPlayer: TMediaPlayer; path: string);
begin
{$IFDEF MSWINDOWS}
  if NOT FileExists(path) then
  begin
    ShowMessage('Audio not found. Path: ' + path);
    exit;
  end;
{$ENDIF}
  try
    TThread.CreateAnonymousThread(
      procedure
      begin
        AMediaPlayer.Clear;
        AMediaPlayer.CurrentTime := 0;
        if AMediaPlayer.State = TMediaState.Playing then
          AMediaPlayer.Stop;
        AMediaPlayer.FileName := path;
      end).Start;
  except
  end;
end;

procedure Tdm.LoadAudios;
begin
{$IFNDEF MSWINDOWS}
  if FDone.FileName.IsEmpty then
    dm.LoadAudio(FDone, TPath.Combine(TFunctions.getPathAudio, 'done.mp3'));
  if FError.FileName.IsEmpty then
    dm.LoadAudio(FError, TPath.Combine(TFunctions.getPathAudio, 'error.mp3'));
  if FRight.FileName.IsEmpty then
    dm.LoadAudio(FRight, TPath.Combine(TFunctions.getPathAudio, 'right.mp3'));
{$ENDIF}
end;

procedure Tdm.PlayAudio(path: string);
begin
{$IFDEF MSWINDOWS}
  if NOT FileExists(path) then
  begin
    ShowMessage('Audio not found. Path: ' + path);
    exit;
  end;
{$ENDIF}

  TMediaPlayerThread.WaitForThread;
  TMediaPlayerThread.Create(FMediaPlayer, path).Start;
end;

procedure Tdm.PlayAudio(AMediaPlayer: TMediaPlayer);
begin
  TMediaPlayerThread.WaitForThread;
  TMediaPlayerThread.Create(AMediaPlayer).Start;

end;

function Tdm.ValidaLogin(usuario: string; out erro: string): Boolean;
var
  JSON: string;
  jsonObj: TJsonObject;
begin
  erro := '';

  with RequestLogin do
  begin
    Params.Clear;
    AddParameter('usuario', usuario); // TRESTRequestParameterKind.pkGETorPOST
    Execute;
  end;

  if RequestLogin.Response.StatusCode <> 200 then
  begin
    Result := False;
    erro := 'Erro ao validar login: ' +
      dm.RequestLogin.Response.StatusCode.ToString;
  end
  else
  begin
    JSON := RequestLogin.Response.JSONValue.ToString;
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    if jsonObj.GetValue('retorno').Value = 'OK' then
      Result := True
    else
    begin
      Result := False;
      erro := jsonObj.GetValue('retorno').Value;
    end;

    jsonObj.DisposeOf;
  end;
end;

procedure Tdm.PlayDoneAudio;
begin
  if FDone.FileName.IsEmpty then
    FDone.FileName := TPath.Combine(TFunctions.getPathAudio, 'done.mp3');
  PlayAudio(FDone);
end;

procedure Tdm.PlayErrorAudio;
begin
  if FError.FileName.IsEmpty then
    FError.FileName := TPath.Combine(TFunctions.getPathAudio, 'error.mp3');
  PlayAudio(FError);
end;

procedure Tdm.PlayRightAudio;
begin
  if FRight.FileName.IsEmpty then
    FRight.FileName := TPath.Combine(TFunctions.getPathAudio, 'right.mp3');
  PlayAudio(FRight);
end;

function Tdm.ListarRanking(Id_Usuario: Integer; out jsonArray: TJSONArray;
out erro: string): Boolean;
var
  JSON: string;
begin
  erro := '';

  try
    with RequestListarRanking do
    begin
      // Params.Clear;
      // AddParameter('Id_Usuario', ID_USUARIO.ToString,
      // TRESTRequestParameterKind.pkGETorPOST);

      Execute;
    end;
  except
    on ex: Exception do
    begin
      Result := False;
      erro := 'Erro ao listar ranking: ' + ex.Message;
      exit;
    end;
  end;

  if RequestListarRanking.Response.StatusCode <> 200 then
  begin
    Result := False;
    erro := 'Erro ao listar ranking: ' + RequestListarRanking.Response.
      StatusCode.ToString;
  end
  else
  begin
    JSON := RequestListarRanking.Response.JSONValue.ToString;
    jsonArray := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJSONArray;
    Result := True;
  end;

end;

function Tdm.Search(id_subcategoria: Integer;
SubCategoryField, termo_busca: string; pagina: Integer;
out jsonArray: TJSONArray; out erro: string): Boolean;
var
  JSON: string;
begin
  erro := '';

  try
    RequestSearch.Params.Clear;
    RequestSearch.AddParameter('id_subcategoria', id_subcategoria.ToString,
      TRESTRequestParameterKind.pkGETorPOST);
    RequestSearch.AddParameter('field_subcategory', SubCategoryField,
      TRESTRequestParameterKind.pkGETorPOST);
    RequestSearch.AddParameter('termo_busca', termo_busca,
      TRESTRequestParameterKind.pkGETorPOST);
    RequestSearch.AddParameter('pagina', pagina.ToString,
      TRESTRequestParameterKind.pkGETorPOST);
    RequestSearch.Execute;
  except
    on ex: Exception do
    begin
      Result := False;
      erro := 'Erro ao buscar palavra: ' + ex.Message;
      exit;
    end;
  end;

  if RequestSearch.Response.StatusCode <> 200 then
  begin
    Result := False;
    erro := 'Erro ao buscar palavra: ' +
      RequestSearch.Response.StatusCode.ToString;
  end
  else
  begin
    JSON := RequestSearch.Response.JSONValue.ToString;
    jsonArray := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJSONArray;
    Result := True;
  end;

end;

procedure Tdm.OnMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Single);
begin
  if Sender is TRectangle then
  begin // faz a piscada
    TRectangle(Sender).TagFloat := TRectangle(Sender).Opacity;
    TRectangle(Sender).Opacity := 0.5;
  end;
end;

procedure Tdm.OnMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Single);
begin
  if Sender is TRectangle then
  begin
    TRectangle(Sender).Opacity := TRectangle(Sender).TagFloat;
  end;
end;

procedure Tdm.OnMouseEnter(Sender: TObject);
begin
  if Sender is TLabel then
    TLabel(Sender).Opacity := 1;
end;

procedure Tdm.OnMouseLeave(Sender: TObject);
begin
  if Sender is TLabel then
    TLabel(Sender).Opacity := 0.8;
end;

procedure Tdm.RectEffect(Sender: TObject);
begin
  if Sender is TRectangle then
  begin
    TRectangle(Sender).OnMouseDown := dm.OnMouseDown;
    TRectangle(Sender).OnMouseUp := dm.OnMouseUp;
  end
  else if Sender is TLabel then
  begin
    TLabel(Sender).OnMouseEnter := dm.OnMouseEnter;
    TLabel(Sender).OnMouseLeave := dm.OnMouseLeave;
  end;

end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  FMediaPlayer := TMediaPlayer.Create(nil);
  FDone := TMediaPlayer.Create(nil);
  FError := TMediaPlayer.Create(nil);
  FRight := TMediaPlayer.Create(nil);
  LoadConfig;
  LoadAudios;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FMediaPlayer) then
    FreeAndNil(FMediaPlayer);

  if Assigned(FDone) then
    FreeAndNil(FDone);

  if Assigned(FError) then
    FreeAndNil(FError);

  if Assigned(FRight) then
    FreeAndNil(FRight);

end;

end.
