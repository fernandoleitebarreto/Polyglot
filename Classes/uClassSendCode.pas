unit uClassSendCode;

interface

uses
  System.SysUtils;

type

  /// <summary>
  /// <p> Classe: TActionApp</p>
  /// <p> Campos: </p>
  /// <p> 0 - Desconhecido </p>
  /// <p> 1 - Ativar Conta </p>
  /// <p> 2 - Resetar Senha </p>
  /// </summary>
  TActionApp = (ocsUnknow, ocsActiveAccount, ocsResetPassword);

  TSendType = (scUnknow, scEmail, scPhone);

  TActionAppHelper = record helper for TActionApp
    function AsByte: Byte; inline;
    function AsValue: Integer; inline;
    Class function Parse(_iCod: Integer): TActionApp; static;
    Class function Parse_Value(_iCod: Integer): TActionApp; static;
//    function Descricao(pComCodigo: boolean = True): string; inline;
  end;

  TSendCode = class
  private
    FAction: TActionApp;
    FCode: string;
    FEmail: string;
    FPassword: string;
    FPhone: string;
    FSendType: TSendType;
    procedure SetCode(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetAction(const Value: TActionApp);
    procedure SetPhone(const Value: string);
    procedure SetSendType(const Value: TSendType);
    procedure SetPassword(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    property SendType: TSendType read FSendType write SetSendType;
    property Code: string read FCode write SetCode;
    property Email: string read FEmail write SetEmail;
    property Password: string read FPassword write SetPassword;
    property Action: TActionApp read FAction write SetAction;
    property Phone: string read FPhone write SetPhone;

  end;

implementation

{ TActionAppHelper }

function TActionAppHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TActionAppHelper.AsValue: Integer;
begin
  case Self of
    ocsActiveAccount:
      Result := 1;
    ocsResetPassword:
      Result := 2;
  else
    raise Exception.CreateFmt
      ('AsValue [%d] não tratado [function TActionAppHelper.AsValue]',
      [Self.AsValue])
  end;
end;

class function TActionAppHelper.Parse(_iCod: Integer): TActionApp;
begin
  Result := TActionApp(_iCod);
end;

class function TActionAppHelper.Parse_Value(_iCod: Integer): TActionApp;
begin
  if _iCod = 1 then
    Result := ocsActiveAccount
  else if _iCod = 2 then
    Result := ocsResetPassword
  else
    raise Exception.CreateFmt
      ('Valor [%s] não tratado [function TActionAppHelper.Parse_Value]',
      [_iCod]);
end;

{
function TActionAppHelper.Descricao(pComCodigo: boolean): string;
begin
  case Self of
    ocsActiveAccount:
      Result := 'Ativar Conta';
    ocsResetPassword:
      Result := 'Resetar Senha';
  else
    raise Exception.CreateFmt
      ('Descrição [%s] não tratado [function TActionAppHelper.Descricao]',
      [AsValue.ToString]);
  end;
  if pComCodigo then
    Result := Result + Format(' (%d)', [Self.AsValue]);
end;
}

{ TCodeSMS }

constructor TSendCode.Create;
begin
  FCode := '';
  FEmail := '';
  FAction := TActionApp.ocsUnknow;
  FSendType := TSendType.scEmail;
end;

destructor TSendCode.Destroy;
begin

end;

procedure TSendCode.SetCode(const Value: string);
begin
  FCode := Value;
end;

procedure TSendCode.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TSendCode.SetAction(const Value: TActionApp);
begin
  FAction := Value;
end;

procedure TSendCode.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TSendCode.SetPhone(const Value: string);
begin
  FPhone := Value;
end;

procedure TSendCode.SetSendType(const Value: TSendType);
begin
  FSendType := Value;
end;

end.
