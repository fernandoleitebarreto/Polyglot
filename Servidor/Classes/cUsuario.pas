unit cUsuario;

interface

uses System.Variants, System.SysUtils, Vcl.Dialogs,
  Firedac.Comp.Client, Firedac.Stan.Param, Firedac.DApt, System.NetEncoding,
  FMX.Graphics, uClassUser, uEnum, uEnum.Helper, uClassCountry, uClassTexts,
  uClassSendEmail;

type
  TFunctionUsuario = class
  private
    FConn: TFDConnection;
    FUser: TUsuario;
    FEmail: TEmail;
    function FText: IText;
  public
    function User: TUsuario;
    constructor Create(conn: TFDConnection);
    destructor Destroy; override;
    function ValidaLogin(AEmail, ASenha: string; out erro: string)
      : Boolean; overload;
    function ValidaLogin(out erro: string): Boolean; overload;
    function EmailExists(out erro: string): Boolean;
    function TelefoneValido(out erro: string): Boolean;
    function CreateAccount(out erro: string): Boolean;
    function DeleteAccount(out erro: string): Boolean;
    function UpdateAccount(out erro: string): Boolean;
    function UpdatePassword(out erro: string): Boolean;
    function UpdateNativeLanguage(out erro: string): Boolean;
    function ClearResetPassword: Boolean;
    function GeraCodRecover: String;

    function VerifyCode(out erro: string): Boolean;
    function VerifyNativeLanguage(out erro: string): Boolean;
    class function SQLSum(pAliasComNomeCampo: String;
      ANativeLanguage: TNativeLanguage = nlUnknow; pNomeCampo: String = '')
      : string; static;
    function SQLField(pAliasComNomeCampo: String;
      bSum: Boolean = False): string;
    function SendEmailAccountCreated(out erro: string): Boolean;
    function SendEmailRecoverAccount(out erro: string): Boolean;
    function SendEmailActivedAccount(out erro: string): Boolean;
    function SendEmailResetedPassword(out erro: string): Boolean;
    function SendEmail(out erro: string): Boolean;
  end;

implementation

{ TUsuario }

uses uFunctions, Data.DB, uConsulta, System.Classes;

constructor TFunctionUsuario.Create(conn: TFDConnection);
begin
  FUser := TUsuario.Create;
  FEmail := TEmail.Create;
  // FUser.Foto := TBitmap.Create;
  FConn := conn;
end;

function TFunctionUsuario.User: TUsuario;
begin
  Result := FUser;
end;

function TFunctionUsuario.VerifyCode(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  erro := '';

  if FUser.Email.Trim.IsEmpty then
    erro := FText.getTextEmptyEmail
  else
  begin
    try
      qry := TConsulta.New(FConn).Consulta_Dinamica
        ('select ID_USUARIO, COD_RESET_PASSWORD, SENHA FROM TAB_USUARIO ' +
        'WHERE EMAIL = :EMAIL', [FUser.Email]);

      if qry.RecordCount > 0 then
      begin
        if Length(FUser.CodeSMS) <> 4 then
          erro := FText.getTextInvalidCodeLenghtIncorrect
        else if Length(qry.FieldByName('COD_RESET_PASSWORD').AsString) <> 4 then
          erro := FText.getTextInvalidCodeLenghtIncorrectCreated
        else if FUser.CodeSMS <> qry.FieldByName('COD_RESET_PASSWORD').AsString
        then
          erro := FText.getTextCodeIncorrect
        else
        begin
          FUser.Id_Usuario := qry.FieldByName('Id_Usuario').AsInteger;
          FUser.Senha := qry.FieldByName('Senha').AsString;
          Result := True;
        end;
      end;

      qry.DisposeOf;

    except
      on ex: exception do
      begin
        erro := 'Erro ao recuperar código de recuperação de senha: ' +
          ex.Message;
        Result := False;
      end;
    end;
  end;
end;

function TFunctionUsuario.VerifyNativeLanguage(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  erro := '';

  if NOT FUser.Email.Trim.IsEmpty then
  begin
    try
      qry := TConsulta.New(FConn).Consulta_Dinamica
        ('select NATIVE_LANGUAGE FROM TAB_USUARIO ' + 'WHERE EMAIL = :EMAIL',
        [FUser.Email]);

      if qry.RecordCount > 0 then
      begin
        FUser.NativeLanguage := TNativeLanguage.Parse_Value
          (qry.FieldByName('NATIVE_LANGUAGE').AsInteger);
        Result := True;
      end;

      qry.DisposeOf;

    except
      on ex: exception do
      begin
        erro := 'Error to get Native Language [TUsuario.VerifyNativeLanguage]: '
          + ex.Message;
        Result := False;
      end;
    end;
  end;
end;

function TFunctionUsuario.ValidaLogin(AEmail, ASenha: string;
  out erro: string): Boolean;
var
  qry: TFDQuery;
  ms: TMemoryStream;
  ss: TStringStream;
begin
  try
    qry := TConsulta.New(FConn).Consulta_Dinamica
      ('select TU.ID_USUARIO, TU.ACTIVED, TU.NOME, TU.EMAIL, ' +
      '        TU.SENHA, TU.TELEFONE, TU.NATIVE_LANGUAGE, TU.COUNTRY, TU.FOTO, '
      + '        (SELECT ' + Self.SQLSum('WC.') +
      '           FROM WORDS_COMPLETE WC ' +
      '          WHERE WC.ID_USUARIO = TU.Id_Usuario) AS POINTS' +
      '   from TAB_USUARIO TU where TU.EMAIL = :EMAIL ' +
      '    and TU.SENHA = :SENHA', [AEmail, ASenha]);

    if not qry.IsEmpty then
    begin
      FUser.Id_Usuario := qry.FieldByName('ID_USUARIO').AsInteger;
      FUser.Actived := qry.FieldByName('ACTIVED').AsInteger;
      FUser.Nome := qry.FieldByName('NOME').AsString;
      FUser.Email := qry.FieldByName('EMAIL').AsString;
      FUser.Senha := qry.FieldByName('SENHA').AsString;
      FUser.Telefone := qry.FieldByName('TELEFONE').AsString;
      FUser.NativeLanguage := TNativeLanguage.Parse_Value
        (qry.FieldByName('NATIVE_LANGUAGE').AsInteger);
      FUser.Country := TCountry.Parse_Value(qry.FieldByName('COUNTRY')
        .AsInteger);
      FUser.Points := qry.FieldByName('POINTS').AsInteger;
      FUser.Foto := qry.FieldByName('FOTO').AsString;

      erro := '';
      Result := True;
    end
    else
    begin
      erro := FText.getInvalidEmailPassword;
      Result := False;
    end;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Something went wrong: ' + ex.Message;
      Result := False;
    end;
  end;
end;

function TFunctionUsuario.ValidaLogin(out erro: string): Boolean;
begin
  Result := ValidaLogin(FUser.Email, FUser.Senha, erro);
end;

function TFunctionUsuario.CreateAccount(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).FactoryFDQuery(True);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO TAB_USUARIO (NOME, EMAIL, SENHA, TELEFONE, FOTO,');
    qry.SQL.Add('            COD_RESET_PASSWORD, NATIVE_LANGUAGE, COUNTRY)');
    qry.SQL.Add('VALUES (:NOME, :EMAIL, :SENHA, :TELEFONE, :FOTO,');
    qry.SQL.Add('           :COD_RESET_PASSWORD, :NATIVE_LANGUAGE, :COUNTRY)');
    qry.ParamByName('NOME').AsString := 'User'+Random(9999).ToString;
    qry.ParamByName('EMAIL').AsString := FUser.Email;
    qry.ParamByName('SENHA').AsString := FUser.Senha;

    if not FUser.Telefone.IsEmpty then
      qry.ParamByName('TELEFONE').AsString := FUser.Telefone
    else
      qry.ParamByName('TELEFONE').Clear;

    if FUser.Foto <> '' then
      qry.ParamByName('FOTO').Assign(TFunctions.BitmapFromBase64(FUser.Foto))
    else
      qry.ParamByName('FOTO').Clear;

    qry.ParamByName('COD_RESET_PASSWORD').Clear;
    qry.ParamByName('NATIVE_LANGUAGE').AsInteger := nlUnknow.AsValue;
    qry.ParamByName('COUNTRY').AsInteger := FUser.Country.AsValue;

    qry.ExecSQL;

    FUser.Id_Usuario := TConsulta.New(FConn)
      .Retorno_Dinamico('SELECT MAX(Id_Usuario) AS Id_Usuario ' +
      ' FROM TAB_USUARIO WHERE EMAIL = :EMAIL', [FUser.Email], ftInteger);
    erro := '';
    Result := True;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Erro ao criar conta: ' + ex.Message;
      Result := False;
    end;
  end;
end;

function TFunctionUsuario.EmailExists(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).Consulta_Dinamica
      ('SELECT ID_USUARIO, NATIVE_LANGUAGE FROM TAB_USUARIO WHERE EMAIL = :EMAIL',
      [FUser.Email]);

    if not qry.IsEmpty then
    begin
      FUser.Id_Usuario := qry.FieldByName('ID_USUARIO').AsInteger;
      erro := '';
      Result := True;
    end
    else
    begin
      FUser.Id_Usuario := 0;
      erro := FText.getTextEmailNotFound;
      Result := False;
    end;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Erro ao validar login: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TFunctionUsuario.FText: IText;
begin
  Result := TText.New(FUser.NativeLanguage);
end;

function TFunctionUsuario.GeraCodRecover: String;
var
  qry: TFDQuery;
  erro: string;
begin
  FUser.CodeSMS := FormatFloat('0000', StrtoInt(Random(9999).ToString));

  try
    qry := TConsulta.New(FConn).FactoryFDQuery(False);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add
      ('UPDATE TAB_USUARIO SET COD_RESET_PASSWORD = :COD_RESET_PASSWORD');
    qry.SQL.Add(' WHERE EMAIL = :EMAIL');
    qry.ParamByName('EMAIL').Value := FUser.Email;
    qry.ParamByName('COD_RESET_PASSWORD').Value := FUser.CodeSMS;
    qry.ExecSQL;

    erro := '';
    Result := FUser.CodeSMS;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Erro ao gerar codigo de recuperação de senha: ' + ex.Message;
      Result := '0';
    end;
  end;

end;

function TFunctionUsuario.SQLField(pAliasComNomeCampo: String;
  bSum: Boolean = False): string;
var
  ta: TNativeLanguage;
  ga: TGameForms;
  _Script, _Field: string;
begin
  Result := '';
  for ga := low(TGameForms) to high(TGameForms) do
  begin
    if ga = fmUnknow then
      continue;

    for ta := low(TNativeLanguage) to high(TNativeLanguage) do
    begin
      if ta in [nlUnknow, nlAll] then
        continue;

      _Field := ga.FieldDataBase(ta);

      if ta = FUser.NativeLanguage then
        _Script := '0 '
      else
        _Script := Format('COALESCE(%s%s, 0)', [pAliasComNomeCampo, _Field]);

      if bSum then
        _Script := 'SUM (' + _Script + ')';

      Result := Result + _Script + ' AS ' + _Field + ',';
    end;
  end;

  if not Result.IsEmpty then
    Result := Copy(Result, 1, Length(Result) - 1);

end;

class function TFunctionUsuario.SQLSum(pAliasComNomeCampo: String;
  ANativeLanguage: TNativeLanguage = nlUnknow; pNomeCampo: String = ''): string;
var
  ta: TNativeLanguage;
  ga: TGameForms;
  _Field: string;
begin
  Result := '';
  for ga := low(TGameForms) to high(TGameForms) do
  begin
    if ga = fmUnknow then
      continue;

    for ta := low(TNativeLanguage) to high(TNativeLanguage) do
    begin
      if ta in [nlUnknow, nlAll] then
        continue;

      if ta = ANativeLanguage then
        Result := Result + ' 0 +'
      else
      begin
        _Field := ga.FieldDataBase(ta);
        Result := Result + Format(' %s%s +', [pAliasComNomeCampo, _Field]);
      end;
    end;
  end;

  if not Result.IsEmpty then
    Result := Copy(Result, 1, Length(Result) - 1);

  Result := 'SUM(' + Result + ')';

  if not pNomeCampo.IsEmpty then
    Result := Result + Format(' as %s ', [pNomeCampo]);
end;

function TFunctionUsuario.TelefoneValido(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  qry := TConsulta.New(FConn).Consulta_Dinamica
    ('SELECT Id_Usuario, EMAIL FROM TAB_USUARIO WHERE TELEFONE = :TELEFONE',
    [FUser.Telefone]);
  try
    if qry.RecordCount > 0 then
    begin
      FUser.Id_Usuario := qry.FieldByName('Id_Usuario').AsInteger;
      FUser.Email := qry.FieldByName('EMAIL').AsString;
      erro := '';
      Result := True;
    end
    else
    begin
      FUser.Id_Usuario := 0;
      erro := Format('Telefone [%s] não encontrado', [FUser.Telefone]);
      Result := False;
    end;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Erro ao validar login: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TFunctionUsuario.UpdateAccount(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).FactoryFDQuery(False);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE TAB_USUARIO SET');
    qry.SQL.Add(' NOME = :NOME,');
    qry.SQL.Add(' EMAIL = :EMAIL,');
    qry.SQL.Add(' TELEFONE = :TELEFONE,');
    qry.SQL.Add(' FOTO = :FOTO');
    qry.SQL.Add(' WHERE ID_USUARIO = :ID_USUARIO');
    qry.ParamByName('NOME').AsString := FUser.Nome;
    qry.ParamByName('EMAIL').AsString := FUser.Email;
    qry.ParamByName('TELEFONE').AsString := FUser.Telefone;
    qry.ParamByName('ID_USUARIO').AsInteger := FUser.Id_Usuario;

    if FUser.Foto <> '' then
      qry.ParamByName('FOTO').AsString := FUser.Foto
    else
      qry.ParamByName('FOTO').Clear;

    qry.ExecSQL;

    erro := '';
    Result := True;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Error to update the account: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TFunctionUsuario.UpdateNativeLanguage(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).FactoryFDQuery(False);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE TAB_USUARIO SET NATIVE_LANGUAGE = :NATIVE_LANGUAGE');
    qry.SQL.Add(' WHERE Id_Usuario = :Id_Usuario');
    qry.ParamByName('NATIVE_LANGUAGE').AsInteger :=
      FUser.NativeLanguage.AsValue;
    qry.ParamByName('Id_Usuario').AsInteger := FUser.Id_Usuario;
    qry.ExecSQL;

    erro := '';
    Result := True;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Error to set the native language: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TFunctionUsuario.UpdatePassword(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).FactoryFDQuery(False);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE TAB_USUARIO ');
    qry.SQL.Add('   SET SENHA = :SENHA,');
    qry.SQL.Add('       COD_RESET_PASSWORD = null');
    qry.SQL.Add(' WHERE EMAIL = :EMAIL');
    qry.ParamByName('EMAIL').Value := FUser.Email;
    qry.ParamByName('SENHA').Value := FUser.Senha;
    qry.ExecSQL;

    erro := '';
    Result := True;

    qry.DisposeOf;

  except
    on ex: exception do
    begin
      erro := 'Erro ao alterar senha: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TFunctionUsuario.ClearResetPassword: Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TConsulta.New(FConn).FactoryFDQuery(False);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE TAB_USUARIO ');
    qry.SQL.Add('   SET COD_RESET_PASSWORD = NULL,');
    qry.SQL.Add('       ACTIVED = 1');
    qry.SQL.Add(' WHERE EMAIL = :EMAIL');
    qry.ParamByName('EMAIL').Value := FUser.Email;
    qry.ExecSQL;
    Result := True;

    qry.DisposeOf;

  except
    Result := False;
  end;

end;

function TFunctionUsuario.SendEmail(out erro: string): Boolean;
begin
  Result := Self.EmailExists(erro);

  if erro.IsEmpty then
  begin
    FEmail.Start;
    erro := FEmail.Error;
  end;

  if erro.IsEmpty then
    Result := True;
end;

function TFunctionUsuario.SendEmailAccountCreated(out erro: string): Boolean;
begin
  FUser.CodeSMS := Self.GeraCodRecover;
  FEmail.&To := Self.User.Email;
  FEmail.Subject := FText.getTextSubjectCreateAccount;
  FEmail.Body := Format(FText.getTextBodyCreateAccount, [FUser.CodeSMS]);

  Result := SendEmail(erro);
end;

function TFunctionUsuario.SendEmailRecoverAccount(out erro: string): Boolean;
begin
  FUser.CodeSMS := Self.GeraCodRecover;
  FEmail.&To := Self.User.Email;
  FEmail.Subject := FText.getTextSubjectRecoverPassword;
  FEmail.Body := Format(FText.getTextBodyRecoverPassword, [FUser.CodeSMS]);

  Result := SendEmail(erro);
end;

function TFunctionUsuario.SendEmailActivedAccount(out erro: string): Boolean;
begin
  FEmail.&To := Self.User.Email;
  FEmail.Subject := FText.getTextSubjectActivedAccount;
  FEmail.Body := FText.getTextBodyActivedAccount;

  Result := SendEmail(erro);

end;

function TFunctionUsuario.SendEmailResetedPassword(out erro: string): Boolean;
begin
  FEmail.&To := Self.User.Email;
  FEmail.Subject := FText.getTextSubjectRecoveredPassword;
  FEmail.Body := FText.getTextBodyRecoveredPassword;

  Result := SendEmail(erro);

end;

function TFunctionUsuario.DeleteAccount(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    erro := '';
    qry := TConsulta.New(FConn).FactoryFDQuery(True);

    qry.Active := False;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM TAB_USUARIO');
    qry.SQL.Add(' WHERE EMAIL = :EMAIL');
    qry.SQL.Add('   AND SENHA = :SENHA');
    qry.SQL.Add('   AND ID_USUARIO > 1');
    qry.ParamByName('EMAIL').AsString := FUser.Email;
    qry.ParamByName('SENHA').AsString := FUser.Senha;

    qry.ExecSQL;
    qry.DisposeOf;
    Result := True;
  except
    on ex: exception do
    begin
      erro := 'Erro ao criar conta: ' + ex.Message;
      Result := False;
    end;
  end;

end;

destructor TFunctionUsuario.Destroy;
begin
  // if Assigned(FUser.Foto) then
  // FreeAndNil(FUser.Foto);

  // if Assigned(FEmail) then
  // FreeAndNil(FEmail);

  if Assigned(FUser) then
    FreeAndNil(FUser);
  inherited;
end;

end.
