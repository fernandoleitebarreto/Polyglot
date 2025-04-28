unit UnitDM;

interface

uses
  System.Classes, uRESTDWDatamodule, uRESTDWAbout, uRESTDWServerEvents,
  uRESTDWJSONObject, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, cUsuario, System.JSON,
  FMX.Graphics, Soap.EncdDecd, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, System.NetEncoding,
  uRESTDWConsts, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  System.IOUtils, System.SysUtils, System.IniFiles, System.Variants,
  FMX.Dialogs, FMX.Forms, uClassUser, uClassCountry, uClassTexts, cParametro,
  uEnum, uEnum.Helper, uClassFunctions, uClassSendEmail, uConsulta, uFunctions,
  uRESTDWBasic, uRESTDWParams, FireDAC.VCLUI.Wait, DataSetConverter4D,
  DataSetConverter4D.Impl, uClassSendCode, UnitConstante, uRESTDWIdBase;

type
  Tdm = class(TServerMethodDataModule)
    DWEvents: TRESTDWServerEvents;
    // responsavel por responder as requisições para os endpoints
    conn: TFDConnection;
    QryGeral: TFDQuery;
    FDTransaction: TFDTransaction;
    RESTServicePooler: TRESTDWIdServicePooler;
    function FText(ANativeLanguage: TNativeLanguage): IText;
    procedure DWEventsEventshoraReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsConfiguracaoReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsValidaLoginReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsCriarContaReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsListarCategoriaReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsListarRankingReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsCarregaDadosReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsSearchReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsSendEmailRecoverPasswordReplyEvent(
      var Params: TRESTDWParams; const Result: TStringList);
    procedure DWEventsEventsSendEmailCreateAccountReplyEvent(
      var Params: TRESTDWParams; const Result: TStringList);
    procedure DWEventsEventsSendSMSRecoverPasswordReplyEvent(
      var Params: TRESTDWParams; const Result: TStringList);
    procedure DWEventsEventsSendSMSCreateAccountReplyEvent(
      var Params: TRESTDWParams; const Result: TStringList);
    procedure DWEventsEventsVerifyCodeReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsSaveNewPasswordReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsAddWordReplyEventByType(var Params: TRESTDWParams;
      const Result: TStringList; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWEventsEventsAddAudioReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsWordsWithNoAudioReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsMeaningProximoReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsSetNativeLanguageReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsGetNativeLanguageReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsLoginFacebookReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsRandomDadosReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWEventsEventsUpdateUserReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsDeleteAccountReplyEvent(var Params: TRESTDWParams;
      const Result: TStringList);
    procedure DWEventsEventsListarParametroReplyEventByType(
      var Params: TRESTDWParams; const Result: TStringList;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
  private
    FCount: Integer;
  public
    function LoadConfig: string;
    function SendEmail(AEmail: string): Boolean;

  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

function Tdm.LoadConfig: string;
var
  arq_ini: string;
  ini: TIniFile;
begin
  FCount := 0;
  arq_ini := ExtractFilePath(ParamStr(0)) + 'servidor.ini';

  if NOT FileExists(arq_ini) then
    raise Exception.Create('INI File not found: ' + arq_ini);

  RESTServicePooler.ServerMethodClass := Tdm;
  ini := TIniFile.Create(arq_ini);

  try
    conn.Connected := False;
    conn.Params.Clear;
    conn.Params.Values['DriverID'] := ini.ReadString('Banco de Dados',
      'DriverID', 'FB');
    conn.Params.Values['Protocol'] := 'TCPIP';
    conn.Params.Values['Database'] := ini.ReadString('Banco de Dados',
      'Database', '');
    conn.Params.Values['User_Name'] := ini.ReadString('Banco de Dados',
      'User_Name', '');
    conn.Params.Values['Password'] := ini.ReadString('Banco de Dados',
      'Password', '');
    conn.Params.Values['Server'] := ini.ReadString('Banco de Dados',
      'Server', '');
    conn.Params.Values['Port'] := ini.ReadString('Banco de Dados', 'Port', '');

    try
      conn.Transaction := FDTransaction;
      conn.Connected := True;

      if conn.Transaction.Active then
        conn.Transaction.Rollback;

      if conn.Connected then
        Result := 'OK'
      else
        Result := '';
    except
      on ex: Exception do
        raise Exception.Create('Error connecting to the database: ' +
          ex.Message);
    end;
  finally
    ini.DisposeOf;
    RESTServicePooler.Active := False;
    RESTServicePooler.Active := True;
  end;
end;

function Tdm.SendEmail(AEmail: string): Boolean;
var
  FEmail: TEmail;
begin
  try
    Inc(FCount);
    FEmail := TEmail.Create;
    FEmail.&To := AEmail;
    FEmail.Subject := 'Test' + FCount.ToString;
    FEmail.Body := 'Hello' + FCount.ToString;
    FEmail.Start;
  except
    on E: Exception do
    begin
{$IFDEF DEBUG}
      ShowMessage('Error sending email: ' + E.Message);
{$ENDIF}
      raise;
    end;
  end;
end;

procedure Tdm.DWEventsEventsAddWordReplyEventByType(var Params: TRESTDWParams;
  const Result: TStringList; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
var
  JSON: TJsonObject;
  words: IPolyglot;
  erro: string;
begin
  JSON := TJsonObject.Create;
  words := TPolyglot.New(dm.conn);
  try
    if RequestType = rtPut then
      words.Meaning.SetCodItem(Params.ItemsString['id'].AsInteger);
    words.Meaning.SetCodSubCategory(Params.ItemsString['id_subcategoria']
      .AsInteger);
    words.Meaning.SetEnglish(Params.ItemsString['english'].AsString);
    words.Meaning.SetPortuguese(Params.ItemsString['portuguese'].AsString);
    words.Meaning.SetFrench(Params.ItemsString['french'].AsString);
    words.Meaning.SetSpanish(Params.ItemsString['spanish'].AsString);
    words.Meaning.SetItalian(Params.ItemsString['italian'].AsString);
    words.Meaning.SetAudioEnglish(Params.ItemsString['audio_english'].AsString);
    words.Meaning.SetAudioPortuguese(Params.ItemsString['audio_portuguese']
      .AsString);
    words.Meaning.SetAudioFrench(Params.ItemsString['audio_french'].AsString);
    words.Meaning.SetAudioSpanish(Params.ItemsString['audio_spanish'].AsString);
    words.Meaning.SetAudioItalian(Params.ItemsString['audio_italian'].AsString);

    if RequestType = rtPost then
    begin
      if NOT words.Criar(erro, Params.ItemsString['field_subcategory'].AsString)
      then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
      end
      else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
      end;
    end
    else
    begin
      if NOT words.Editar(erro, Params.ItemsString['field_subcategory'].AsString)
      then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
      end
      else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
      end;
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsCriarContaReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    try
      usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
        (Params.ItemsString['native_language'].AsInteger);
      usuario.User.Email := Params.ItemsString['email'].AsString;
      usuario.User.Senha := Params.ItemsString['password'].AsString;
      usuario.User.Telefone := Params.ItemsString['phone'].AsString;
      usuario.User.Country := TCountry.Parse_Value
        (Params.ItemsString['country'].AsInteger);

      // Validacoes...
      if (usuario.User.Email = '') then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
          .getTextEmptyEmail);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end
      else if usuario.EmailExists(erro) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
          .getTextEmailAlreadyExists);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end
      else if (usuario.User.Senha = '') then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
          .getTextEmptyPassword);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end
      {
      else if (usuario.User.Telefone = '') then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
          .getTextEmptyPhone);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end
      else if Length(usuario.User.Telefone) < Length(usuario.User.Country.FormatPhone) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
          .getTextInvalidPhone);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end}
      else if not Params.ItemsString['foto'].AsString.IsEmpty then
      begin
        usuario.User.foto := Params.ItemsString['foto'].AsString;
      end
      else if NOT usuario.CreateAccount(erro) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end
      else if not(usuario.SendEmailAccountCreated(erro)) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
        JSON.AddPair('Id_Usuario', usuario.User.Id_Usuario.ToString);
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end
      else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
        JSON.AddPair('Id_Usuario', usuario.User.Id_Usuario.ToString);
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', usuario.User.codeSMS);
      end;
    except
      on E: Exception do
      begin
        StatusCode := 400;
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', E.Message);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('codeSMS', '');
      end;
    end;
  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;

    if Assigned(usuario) then
      usuario.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsDeleteAccountReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
  Action: TActionApp;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Email := Params.ItemsString['email'].AsString;

    if NOT usuario.ValidaLogin(Params.ItemsString['email'].AsString,
      Params.ItemsString['password'].AsString, erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      exit;
    end;

    if NOT usuario.DeleteAccount(erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
    end
    else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
      end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsCarregaDadosReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  JSON: TJsonObject;
begin

  JSON := TJsonObject.Create;
  try
    try
      if not Params.ItemsString['native_language'].AsString.IsEmpty then
      begin
        Result.Add(TPolyglot.New(dm.conn)
          .CarregaDados(Params.ItemsString['Id_Usuario'].AsInteger,
          Params.ItemsString['subcategory'].AsInteger,
          Params.ItemsString['field_subcategory'].AsString,
          TNativeLanguage.Parse_Value(Params.ItemsString['native_language']
          .AsInteger), TGameForms.Parse_Value(Params.ItemsString['Form']
          .AsString)));
      end
      else
      begin
        Result.Add(TPolyglot.New(dm.conn)
          .RandomDados(Params.ItemsString['subcategory'].AsInteger,
          Params.ItemsString['field_subcategory'].AsString));
      end;

    except
      on E: Exception do
      begin
        StatusCode := 400;
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', E.Message);
        Result.Add(JSON.ToJSON);
      end;
    end;
  finally
    if Assigned(JSON) then
      JSON.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsConfiguracaoReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  erro: string;
  Param: TFunctionParametro;
  JSON: TJsonObject;
begin
  JSON := TJsonObject.Create;
  Param := TFunctionParametro.Create(dm.conn);
  StatusCode := 200;

  try
    try
      if NOT Param.getVersion(erro) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
        JSON.AddPair('versao', '');
        JSON.AddPair('developer', '');
      end
      else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
        JSON.AddPair('versao', Param.Version);
        JSON.AddPair('developer', Param.Developer);
      end;

    except
      on E: Exception do
      begin
        StatusCode := 400;
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', E.Message);
        JSON.AddPair('versao', '');
        JSON.AddPair('developer', '');
      end;
    end;
  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsRandomDadosReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
  if RequestType = TRequestType.rtGet then
    Result.Add(TPolyglot.New(dm.conn)
      .RandomDados(Params.ItemsString['subcategory'].AsInteger,
      Params.ItemsString['field_subcategory'].AsString));

end;

procedure Tdm.DWEventsEventsLoginFacebookReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin

  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);
  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Email := Params.ItemsString['email'].AsString;
    usuario.User.Senha := Params.ItemsString['senha'].AsString;

    // Validacoes...
    if (usuario.User.Email = '') or (usuario.User.Senha = '') then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
        .getErrorLoginFacebook);
      JSON.AddPair('native_language', '0');
      JSON.AddPair('Id_Usuario', '0');
      Result.Add(JSON.ToJSON);

      exit;
    end;

    if usuario.EmailExists(erro) then
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('native_language',
        usuario.User.NativeLanguage.AsValue.ToString);
      JSON.AddPair('Id_Usuario', usuario.User.Id_Usuario.ToString);
    end
    else
    begin
      erro := '';
      if NOT usuario.CreateAccount(erro) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
        JSON.AddPair('native_language', '0');
        JSON.AddPair('Id_Usuario', '0');
      end
      else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
        JSON.AddPair('native_language', nlUnknow.AsValue.ToString);
        JSON.AddPair('Id_Usuario', usuario.User.Id_Usuario.ToString);
      end;
    end; // if usuario.EmailValido(erro) then

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsGetNativeLanguageReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    usuario.User.Email := Params.ItemsString['email'].AsString;

    if NOT usuario.VerifyNativeLanguage(erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('native_language', '0');

    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('native_language',
        usuario.User.NativeLanguage.AsValue.ToString);

    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventshoraReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
begin
  Result.Add('{"hora": "' + FormatDateTime('hh:nn:ss', now) + '"}');
end;

procedure Tdm.DWEventsEventsListarCategoriaReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  qry: TFDQuery;
  usuario: TFunctionUsuario;
  id_subcategoria: string;
  JSON: TJsonObject;
begin
  JSON := TJsonObject.Create;
  qry := TConsulta.New(dm.conn).FactoryFDQueryReadOnly;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Id_Usuario := Params.ItemsString['Id_Usuario'].AsInteger;

    id_subcategoria := 'ID_SUBCATEGORIA_' + usuario.User.NativeLanguage.Sufix;

    if usuario.User.Id_Usuario.ToString.Trim.IsEmpty then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
        .getTextInvalidUserCode);
      Result.Add(JSON.ToJSON);
    end
    else
    begin
      qry.SQL.Clear;
      qry.SQL.Add(' WITH');
      qry.SQL.Add('    LISTA_WORDS_COMPLETE AS');
      qry.SQL.Add('     (');
      qry.SQL.Add('       SELECT WC.ID_USUARIO, W2.' + id_subcategoria + ',');
      qry.SQL.Add(usuario.SQLField('WC.', True));
      qry.SQL.Add('        FROM WORDS_COMPLETE WC');
      qry.SQL.Add('        JOIN WORDS W2 on (WC.ID_WORD = W2.ID)');
      qry.SQL.Add('        GROUP BY WC.ID_USUARIO, W2.' + id_subcategoria);
      qry.SQL.Add('     ),');
      qry.SQL.Add('    LISTA_TOTAL_WORDS AS');
      qry.SQL.Add('     (');
      qry.SQL.Add('       SELECT W2.' + id_subcategoria + ',');
      qry.SQL.Add('             count(W2.ID) AS TOTAL_WORDS');
      qry.SQL.Add('        FROM WORDS W2');
      qry.SQL.Add('       GROUP BY W2.' + id_subcategoria);
      qry.SQL.Add('     ),');
      qry.SQL.Add('    LISTA_TOTAL_COMPLETE AS');
      qry.SQL.Add('     (');
      qry.SQL.Add('       SELECT WC.ID_USUARIO, W2.' + id_subcategoria + ',');
      qry.SQL.Add(TFunctionUsuario.SQLSum('WC.', usuario.User.NativeLanguage,
        'TOTAL_COMPLETE'));
      qry.SQL.Add('        FROM WORDS_COMPLETE WC');
      qry.SQL.Add('        JOIN WORDS W2 on (WC.ID_WORD = W2.ID)');
      qry.SQL.Add('       GROUP BY WC.ID_USUARIO, W2.' + id_subcategoria);
      qry.SQL.Add('     )');
      qry.SQL.Add('');
      qry.SQL.Add(' SELECT DISTINCT SC.*,');
      qry.SQL.Add(' C.DESCRICAO AS DESCRICAO_CATEGORIA,');
      qry.SQL.Add(' C.WORD_PHRASE,');
      qry.SQL.Add(' COALESCE(WC1.TOTAL_COMPLETE, 0) AS TOTAL_COMPLETE,');
      qry.SQL.Add(' COALESCE(WC2.TOTAL_WORDS, 0) AS TOTAL_WORDS,');
      qry.SQL.Add(usuario.SQLField('WC0.', False));
      qry.SQL.Add(' FROM TAB_SUBCATEGORIA SC');
      qry.SQL.Add('    JOIN TAB_CATEGORIA C ON ');
      qry.SQL.Add('       (SC.ID_CATEGORIA = C.ID AND C.IND_ATIVO = ''S'')');

      qry.SQL.Add('    LEFT JOIN LISTA_WORDS_COMPLETE WC0 ');
      qry.SQL.Add('           ON (WC0.ID_USUARIO = :ID_USUARIO ');
      qry.SQL.Add(Format('   AND WC0.%s = SC.ID)', [id_subcategoria]));

      qry.SQL.Add('    LEFT JOIN LISTA_TOTAL_COMPLETE WC1 ');
      qry.SQL.Add('           ON (WC1.ID_USUARIO = :Id_Usuario ');
      qry.SQL.Add(Format('   AND WC1.%s = SC.ID)', [id_subcategoria]));

      qry.SQL.Add('    LEFT JOIN LISTA_TOTAL_WORDS WC2');
      qry.SQL.Add(Format('    ON (WC2.%s = SC.ID)', [id_subcategoria]));

      qry.SQL.Add('    WHERE SC.IND_ATIVO = ''S''');
      qry.SQL.Add('    ORDER BY SC.ID_CATEGORIA, SC.ORDEM');

      qry.ParamByName('ID_USUARIO').AsInteger := usuario.User.Id_Usuario;

      qry.Active := True;
      Result.Add(TConverter.New.DataSet(qry).AsJSONArray.ToJSON);

    end;
  finally
    if Assigned(qry) then
      FreeAndNil(qry);

    if Assigned(usuario) then
      usuario.DisposeOf;

    if Assigned(JSON) then
      JSON.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsListarParametroReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  qry: TFDQuery;
begin
  qry := TConsulta.New(dm.conn).FactoryFDQueryReadOnly;

  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT *');
    qry.SQL.Add('FROM PARAMETRO');
    qry.Active := True;
    if NOT qry.IsEmpty then
      Result.Add(TConverter.New.DataSet(qry).AsJSONObject.ToJSON)
    else
      Result.Add('[]');
  finally
    if Assigned(qry) then
      qry.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsListarRankingReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  qry: TFDQuery;
  JSON: TJsonObject;
begin
  qry := TConsulta.New(dm.conn).FactoryFDQueryReadOnly;

  JSON := TJsonObject.Create;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT FIRST 3 WC.ID_USUARIO,');
    qry.SQL.Add('MIN(U.NOME) AS NOME,');
    qry.SQL.Add('MIN(U.COUNTRY) AS COUNTRY,');
    qry.SQL.Add('MIN(U.FOTO) AS FOTO,');
    qry.SQL.Add(TFunctionUsuario.SQLSum('WC.', nlUnknow, 'QTD_TOTAL'));
    qry.SQL.Add('FROM WORDS_COMPLETE WC');
    qry.SQL.Add('JOIN TAB_USUARIO U ON (U.ID_USUARIO = WC.ID_USUARIO)');
    qry.SQL.Add('GROUP BY WC.ID_USUARIO');
    qry.SQL.Add('ORDER BY QTD_TOTAL DESC');

    qry.Active := True;
    if NOT qry.IsEmpty then
      Result.Add(TConverter.New.DataSet(qry).AsJSONArray.ToJSON)
    else
      Result.Add('[]');
  finally
    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(qry) then
      qry.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsMeaningProximoReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  Screen: TGameForms;
  Language: TNativeLanguage;
  id_word, Id_Usuario, _Field: string;
  qryConsulta, qry: TFDQuery;
  JSON: TJsonObject;
begin
  Screen := TGameForms.Parse_Value(Params.ItemsString['screen'].AsString);
  Language := TNativeLanguage.Parse_Value(Params.ItemsString['Language']
    .AsInteger);
  id_word := Params.ItemsString['id_word'].AsString;
  Id_Usuario := Params.ItemsString['Id_Usuario'].AsString;

  JSON := TJsonObject.Create;
  qry := TConsulta.New(dm.conn).FactoryFDQuery(False);

  try
    if Id_Usuario.Trim.IsEmpty then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(Language).getTextInvalidUserCode);
    end
    else if (Id_Usuario = '0') then // Visitante
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
    end
    else if id_word.Trim.IsEmpty then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(Language).getTextInvalidWordCode);
    end
    else if Screen = fmUnknow then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(Language).getTextInvalidForm);
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');

      _Field := Screen.FieldDataBase(Language);

      try
        qryConsulta := TConsulta.New(dm.conn).Consulta_Dinamica
          ('select 1 from WORDS_COMPLETE ' +
          '  where ID_USUARIO = :ID_USUARIO and ID_WORD = :ID_WORD ',
          [Id_Usuario, id_word]);

        if (qryConsulta.IsEmpty) then
        begin
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add(' insert into WORDS_COMPLETE (ID_USUARIO, ID_WORD, ');
          qry.SQL.Add(Format(' %s)', [_Field]));
          qry.SQL.Add(' values (:ID_USUARIO, :ID_WORD, ');
          qry.SQL.Add(Format(' :%s)', [_Field]));
          qry.ParamByName('ID_USUARIO').AsInteger := Id_Usuario.ToInteger;
          qry.ParamByName('ID_WORD').AsInteger := id_word.ToInteger;
          qry.ParamByName(_Field).AsInteger := 1;
          qry.ExecSQL;
        end
        else
        begin
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add(' update WORDS_COMPLETE');
          qry.SQL.Add(Format(' set %s = :%s', [_Field, _Field]));
          qry.SQL.Add(' where ID_USUARIO = :ID_USUARIO');
          qry.SQL.Add('   and ID_WORD = :ID_WORD');

          qry.ParamByName('ID_USUARIO').AsInteger := Id_Usuario.ToInteger;
          qry.ParamByName('ID_WORD').AsInteger := id_word.ToInteger;
          qry.ParamByName(_Field).AsInteger := 1;
          qry.ExecSQL;
        end;
      except
        on E: Exception do
        begin
          JSON.AddPair('sucesso', 'N');
          JSON.AddPair('erro', E.Message);
        end;
      end;
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(qry) then
      qry.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsSaveNewPasswordReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
  Action: TActionApp;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    Action := TActionApp.Parse_Value(Params.ItemsString['action'].AsInteger);
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Email := Params.ItemsString['email'].AsString;

    if (Action <> ocsResetPassword) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
        .getTextInvalidResetPasswordAction);
      JSON.AddPair('email', usuario.User.Email);
      exit;
    end
    else if UpperCase(Params.ItemsString['confirmpassword'].AsString)
      <> UpperCase(Params.ItemsString['newpassword'].AsString) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
        .getTextPasswordsShouldBeEqual);
      exit;
    end;

    if NOT usuario.ValidaLogin(Params.ItemsString['email'].AsString,
      Params.ItemsString['originalpassword'].AsString, erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      exit;
    end
    else
    if UpperCase(Params.ItemsString['newpassword'].AsString)
      = UpperCase(usuario.User.Senha) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
        .getTextPasswordsShouldBeDifferentCurrent);
      exit;
    end;

    usuario.User.Senha := Params.ItemsString['newpassword'].AsString;

    if NOT usuario.UpdatePassword(erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('email', usuario.User.Email);
    end
    else if (not usuario.SendEmailResetedPassword(erro)) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('email', usuario.User.Email);
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('email', usuario.User.Email);
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsSearchReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  qry: TFDQuery;
  pg_inicio, pg_fim: Integer;
  subcategoria: string;
begin
  qry := TFDQuery.Create(nil);
  subcategoria := 'ID_SUBCATEGORIA_' + Params.ItemsString
    ['field_subcategory'].AsString;

  try
    qry.Connection := dm.conn;
    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT P.* ');
    qry.SQL.Add('  FROM WORDS P ');
    qry.SQL.Add(' WHERE P.ID > 0');

    if Params.ItemsString['ID_SUBCATEGORIA'].AsString <> '0' then
    begin
      qry.SQL.Add(Format('AND P.%s = :ID_SUBCATEGORIA', [subcategoria]));
      qry.ParamByName('ID_SUBCATEGORIA').Value := Params.ItemsString
        ['ID_SUBCATEGORIA'].AsInteger;
    end;

    if Params.ItemsString['TERMO_BUSCA'].AsString <> '' then
    begin
      qry.SQL.Add('AND (');
      qry.SQL.Add('UPPER(P.ENGLISH) LIKE :TERMO_BUSCA');
      qry.SQL.Add('OR UPPER(P.SPANISH) LIKE :TERMO_BUSCA');
      qry.SQL.Add('OR UPPER(P.FRENCH) LIKE :TERMO_BUSCA');
      qry.SQL.Add('OR UPPER(P.ITALIAN) LIKE :TERMO_BUSCA');
      qry.SQL.Add('OR UPPER(P.PORTUGUESE) LIKE :TERMO_BUSCA');
      qry.SQL.Add(')');
      qry.ParamByName('TERMO_BUSCA').AsString :=
        '%' + UpperCase(Params.ItemsString['TERMO_BUSCA'].AsString) + '%';
    end;

    qry.SQL.Add('ORDER BY P.ID');

    if Params.ItemsString['PAGINA'].AsString <> '0' then
    begin
      // inicio= (pagina - 1) * 10 + 1
      // fim= pagina * 10

      pg_inicio := (Params.ItemsString['PAGINA'].AsInteger - 1) * 10 + 1;
      pg_fim := Params.ItemsString['PAGINA'].AsInteger * 10;
      qry.SQL.Add('ROWS ' + pg_inicio.ToString + ' TO ' + pg_fim.ToString);
    end;

    qry.Active := True;
    if NOT qry.IsEmpty then
      Result.Add(TConverter.New.DataSet(qry).AsJSONArray.ToJSON)
    else
      Result.Add('[]');
  finally
    if Assigned(qry) then
      qry.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsSendEmailCreateAccountReplyEvent(
  var Params: TRESTDWParams; const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;

begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Email := Params.ItemsString['email'].AsString;

    if (not usuario.SendEmailAccountCreated(erro)) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('email', '');
      JSON.AddPair('codeSMS', '');
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('email', usuario.User.Email);
      JSON.AddPair('codeSMS', usuario.User.codeSMS);
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsSendEmailRecoverPasswordReplyEvent(
  var Params: TRESTDWParams; const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;

begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);
  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Email := Params.ItemsString['email'].AsString;

    if (usuario.SendEmailRecoverAccount(erro)) then
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('codeSMS', usuario.User.codeSMS);
    end
    else
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('codeSMS', '');
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsSendSMSCreateAccountReplyEvent(
  var Params: TRESTDWParams; const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin
  raise Exception.Create('Missing implementation');

  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Telefone := Params.ItemsString['telefone'].AsString;

    if (NOT usuario.TelefoneValido(erro)) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('email', '');
      JSON.AddPair('codeSMS', '');
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('email', usuario.User.Email);
      JSON.AddPair('codeSMS', usuario.GeraCodRecover);
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsSendSMSRecoverPasswordReplyEvent(
  var Params: TRESTDWParams; const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Telefone := Params.ItemsString['telefone'].AsString;

    if (NOT usuario.TelefoneValido(erro)) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('email', '');
      JSON.AddPair('codeSMS', '');
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('email', usuario.User.Email);
      JSON.AddPair('codeSMS', usuario.GeraCodRecover);
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsSetNativeLanguageReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin

  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);
  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Id_Usuario := Params.ItemsString['Id_Usuario']
      .AsString.ToInteger;

    if usuario.User.Id_Usuario.ToString.Trim.IsEmpty then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', FText(usuario.User.NativeLanguage)
        .getTextInvalidUserCode);
    end
    else
    begin

      try
        if NOT usuario.UpdateNativeLanguage(erro) then
        begin
          JSON.AddPair('sucesso', 'N');
          JSON.AddPair('erro', erro);
        end
        else
        begin
          JSON.AddPair('sucesso', 'S');
          JSON.AddPair('erro', '');
        end;

      except
        on ex: Exception do
        begin
          JSON.AddPair('sucesso', 'N');
          JSON.AddPair('erro', 'Error Saving Word: ' + ex.Message);
        end;
      end;
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(usuario) then
      usuario.DisposeOf;

    if Assigned(JSON) then
      JSON.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsValidaLoginReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    try
      usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
        (Params.ItemsString['NATIVE_LANGUAGE'].AsInteger);
      usuario.User.Email := Params.ItemsString['EMAIL'].AsString;
      usuario.User.Senha := Params.ItemsString['SENHA'].AsString;

      if NOT usuario.ValidaLogin(erro) then
      begin
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', erro);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('actived', '0');
        JSON.AddPair('nome', '');
        JSON.AddPair('email', '');
        JSON.AddPair('senha', '');
        JSON.AddPair('telefone', '');
        JSON.AddPair('native_language', '0');
        JSON.AddPair('country', '0');
        JSON.AddPair('foto', '');
        JSON.AddPair('points', '0');

      end
      else
      begin
        JSON.AddPair('sucesso', 'S');
        JSON.AddPair('erro', '');
        JSON.AddPair('Id_Usuario', usuario.User.Id_Usuario.ToString);
        JSON.AddPair('actived', usuario.User.Actived.ToString);
        JSON.AddPair('nome', usuario.User.Nome);
        JSON.AddPair('email', usuario.User.Email);
        JSON.AddPair('senha', usuario.User.Senha);
        JSON.AddPair('telefone', usuario.User.Telefone);
        JSON.AddPair('native_language',
          usuario.User.NativeLanguage.AsValue.ToString);
        JSON.AddPair('country', usuario.User.Country.AsValue.ToString);

        if usuario.User.foto <> '' then
          JSON.AddPair('foto', usuario.User.foto)
        else
          JSON.AddPair('foto', '');
        JSON.AddPair('points', usuario.User.Points.ToString);
      end;

    except
      on E: Exception do
      begin
        StatusCode := 400;
        JSON.AddPair('sucesso', 'N');
        JSON.AddPair('erro', E.Message);
        JSON.AddPair('Id_Usuario', '0');
        JSON.AddPair('nome', '');
        JSON.AddPair('email', '');
        JSON.AddPair('senha', '');
        JSON.AddPair('telefone', '');
        JSON.AddPair('native_language', '0');
        JSON.AddPair('country', '0');
        JSON.AddPair('foto', '');
        JSON.AddPair('points', '0');
      end;
    end;
  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventsVerifyCodeReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  code, erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
  Action: TActionApp;
begin
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);

  try
    // sleep(500);
    code := Params.ItemsString['num1'].AsString;
    code := code + Params.ItemsString['num2'].AsString;
    code := code + Params.ItemsString['num3'].AsString;
    code := code + Params.ItemsString['num4'].AsString;
    Action := TActionApp.Parse_Value(Params.ItemsString['action'].AsInteger);

    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Email := Params.ItemsString['email'].AsString;
    usuario.User.codeSMS := code;

    if NOT usuario.VerifyCode(erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('Id_Usuario', '0');
      JSON.AddPair('email', usuario.User.Email);
      JSON.AddPair('password', '');
    end
    else if (Action = ocsActiveAccount) and
      (not usuario.SendEmailActivedAccount(erro)) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
      JSON.AddPair('Id_Usuario', '0');
      JSON.AddPair('email', usuario.User.Email);
      JSON.AddPair('password', '');
    end
    else
    begin
      usuario.ClearResetPassword;
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
      JSON.AddPair('email', usuario.User.Email);
      JSON.AddPair('password', usuario.User.Senha);
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
    if Assigned(usuario) then
      usuario.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsWordsWithNoAudioReplyEventByType(
  var Params: TRESTDWParams; const Result: TStringList;
  const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
  if RequestType = TRequestType.rtGet then
    Result.Add(TPolyglot.New(dm.conn).WordsWithNoAudio
      (Params.ItemsString['field'].AsString, Params.ItemsString['category']
      .AsInteger));
end;

function Tdm.FText(ANativeLanguage: TNativeLanguage): IText;
begin
  Result := TText.New(ANativeLanguage);
end;

procedure Tdm.DWEventsEventsAddAudioReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  JSON: TJsonObject;
  words: IPolyglot;
  erro: string;
begin
  sleep(500);
  JSON := TJsonObject.Create;
  words := TPolyglot.New(dm.conn);
  try
    words.Meaning.SetCodItem(Params.ItemsString['CodItem'].AsInteger);
    words.Meaning.SetNativeLanguage
      (TNativeLanguage.Parse_Value(Params.ItemsString['native_language']
      .AsInteger));
    words.Meaning.SetAudioNative(Params.ItemsString['AudioNative'].AsString);

    if NOT words.AddAudio(erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;
  end;

end;

procedure Tdm.DWEventsEventsUpdateUserReplyEvent(var Params: TRESTDWParams;
  const Result: TStringList);
var
  erro: string;
  usuario: TFunctionUsuario;
  JSON: TJsonObject;
  foto_bmp: TBitmap;
begin
  foto_bmp := nil;
  JSON := TJsonObject.Create;
  usuario := TFunctionUsuario.Create(dm.conn);
  try
    usuario.User.NativeLanguage := TNativeLanguage.Parse_Value
      (Params.ItemsString['native_language'].AsInteger);
    usuario.User.Id_Usuario := Params.ItemsString['code'].AsInteger;
    usuario.User.Nome := Params.ItemsString['name'].AsString;
    usuario.User.Email := Params.ItemsString['email'].AsString;
    usuario.User.Telefone := Params.ItemsString['phone'].AsString;

    // Validacoes...
    if (usuario.User.Nome.Trim = '') or (usuario.User.Email.Trim = '') or
      (usuario.User.Telefone.Trim = '') then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', 'Informe todos os parâmetros');
      Result.Add(JSON.ToJSON);

      exit;
    end;

    if not Params.ItemsString['foto'].IsEmpty then
      usuario.User.foto := Params.ItemsString['foto'].Value;

    if NOT usuario.UpdateAccount(erro) then
    begin
      JSON.AddPair('sucesso', 'N');
      JSON.AddPair('erro', erro);
    end
    else
    begin
      JSON.AddPair('sucesso', 'S');
      JSON.AddPair('erro', '');
    end;

  finally
    Result.Add(JSON.ToJSON);

    if Assigned(JSON) then
      JSON.DisposeOf;

    if Assigned(foto_bmp) then
      foto_bmp.DisposeOf;

    if Assigned(usuario) then
      usuario.DisposeOf;
  end;

end;

end.
