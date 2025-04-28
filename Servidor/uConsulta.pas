unit uConsulta;

interface

uses
  System.Variants, System.SysUtils, FireDAC.Stan.Error,
  FireDAC.Stan.Param, Data.DB, System.Classes, FireDAC.Comp.Client;

type
  IConsulta = interface
    ['{BB1EE81C-5CB4-4D13-8583-2295C03BA4D3}']
    function FDTransactionFactory(AActive: Boolean = True;
      AReadOnly: Boolean = False): TFDTransaction; overload;

    function Consulta_Existencia_Registro(Str_SQL: string): Boolean; overload;
    function Consulta_Existencia_Registro(Str_SQL: string;
      const AParams: array of Variant): Boolean; overload;

    function Consulta_Dinamica(Str_SQL: string; const AParams: array of Variant;
      Active: Boolean = True; bReadOnly: Boolean = True;
      AOwner: TComponent = nil): TFDQuery; overload;
    function Consulta_Dinamica(Str_SQL: string; Active: Boolean = True;
      bReadOnly: Boolean = True; AOwner: TComponent = nil): TFDQuery; overload;
    function Consulta_Dinamica(Str_SQL: TStringList;
      const AParams: array of Variant; Active: Boolean;
      bReadOnly: Boolean = True; AOwner: TComponent = nil): TFDQuery; overload;
    function Consulta_Dinamica(Str_SQL: TStringList; Active: Boolean;
      bReadOnly: Boolean = True; AOwner: TComponent = nil): TFDQuery; overload;

    function Retorno_Dinamico(Str_SQL: string;
      TipoRetorno: TFieldType = ftString): Variant; overload;
    function Retorno_Dinamico(Str_SQL: string; const AParams: array of Variant;
      TipoRetorno: TFieldType = ftString): Variant; overload;
    function Retorno_Dinamico(Str_SQL: TStringList;
      TipoRetorno: TFieldType = ftString): Variant; overload;
    function Retorno_Dinamico(Str_SQL: TStringList;
      const AParams: array of Variant; TipoRetorno: TFieldType = ftString)
      : Variant; overload;
    function FactoryFDQuery(AReadOnly: Boolean; pDetailDelay: Integer = -1;
      AOwner: TComponent = nil): TFDQuery;
    function FactoryFDQueryReadOnly(pDetailDelay: Integer = -1;
      AOwner: TComponent = nil): TFDQuery;
  end;

  TConsulta = class(TInterfacedObject, IConsulta)
  private
    FConnection: TFDCustomConnection;
    FTransaction: TFDCustomTransaction;

    function FDTransactionFactory(AActive: Boolean = False;
      AReadOnly: Boolean = False): TFDTransaction; overload;

    function Consulta_Existencia_Registro(Str_SQL: string): Boolean; overload;
    function Consulta_Existencia_Registro(Str_SQL: string;
      const AParams: array of Variant): Boolean; overload;

    function Consulta_Dinamica(Str_SQL: string; const AParams: array of Variant;
      Active: Boolean = True; bReadOnly: Boolean = True;
      AOwner: TComponent = nil): TFDQuery; overload;
    function Consulta_Dinamica(Str_SQL: string; Active: Boolean = True;
      bReadOnly: Boolean = True; AOwner: TComponent = nil): TFDQuery; overload;
    function Consulta_Dinamica(Str_SQL: TStringList;
      const AParams: array of Variant; Active: Boolean;
      bReadOnly: Boolean = True; AOwner: TComponent = nil): TFDQuery; overload;
    function Consulta_Dinamica(Str_SQL: TStringList; Active: Boolean;
      bReadOnly: Boolean = True; AOwner: TComponent = nil): TFDQuery; overload;

    function Retorno_Dinamico(Str_SQL: string;
      TipoRetorno: TFieldType = ftString): Variant; overload;
    function Retorno_Dinamico(Str_SQL: string; const AParams: array of Variant;
      TipoRetorno: TFieldType = ftString): Variant; overload;
    function Retorno_Dinamico(Str_SQL: TStringList;
      TipoRetorno: TFieldType = ftString): Variant; overload;
    function Retorno_Dinamico(Str_SQL: TStringList;
      const AParams: array of Variant; TipoRetorno: TFieldType = ftString)
      : Variant; overload;

    function FactoryFDQuery(AReadOnly: Boolean; pDetailDelay: Integer = -1;
      AOwner: TComponent = nil): TFDQuery;
    function FactoryFDQueryReadOnly(pDetailDelay: Integer = -1;
      AOwner: TComponent = nil): TFDQuery;
  public
    constructor Create; overload;
    constructor Create(AConnection: TFDCustomConnection); overload;
    destructor Destroy; override;
    class function New: IConsulta; overload;
    class function New(AConnection: TFDCustomConnection): IConsulta; overload;

  end;

implementation

uses
  FireDAC.Stan.Option;

{ TConsulta }

destructor TConsulta.Destroy;
begin
  if FTransaction.Active then
    FTransaction.Rollback;

  FreeAndNil(FTransaction);

  inherited;
end;

class function TConsulta.New: IConsulta;
begin
  Result := Self.Create;
end;

constructor TConsulta.Create;
begin
  //
end;

class function TConsulta.New(AConnection: TFDCustomConnection): IConsulta;
begin
  Result := Self.Create(AConnection);
end;

constructor TConsulta.Create(AConnection: TFDCustomConnection);
begin
  FConnection := AConnection;

  FTransaction := Self.FDTransactionFactory(False);
  FConnection.Transaction := FTransaction;
end;

function TConsulta.FDTransactionFactory(AActive, AReadOnly: Boolean)
  : TFDTransaction;
begin
  Result := TFDTransaction.Create(nil);
  Result.Connection := FConnection;

  if AReadOnly then
  begin
    Result.Options.ReadOnly := True;
    Result.Options.DisconnectAction := xdRollback;
  end; // if AReadOnly then

  if AActive then
    Result.StartTransaction;
end;

function TConsulta.Consulta_Existencia_Registro(Str_SQL: string): Boolean;
begin
  Str_SQL := 'SELECT CASE WHEN EXISTS(' + Str_SQL +
    ') THEN 1 ELSE 0 END TEM_REGISTRO from rdb$database';

  Result := (Retorno_Dinamico(Str_SQL, ftInteger) > 0);
end;

function TConsulta.Consulta_Existencia_Registro(Str_SQL: string;
  const AParams: array of Variant): Boolean;
begin
  Str_SQL := 'SELECT CASE WHEN EXISTS(' + Str_SQL +
    ') THEN 1 ELSE 0 END TEM_REGISTRO from rdb$database';

  Result := (Retorno_Dinamico(Str_SQL, AParams, ftInteger) > 0);
end;

function TConsulta.Consulta_Dinamica(Str_SQL: TStringList;
  Active, bReadOnly: Boolean; AOwner: TComponent): TFDQuery;
begin
  Result := Consulta_Dinamica(Str_SQL.Text, [], Active, bReadOnly, AOwner);
end;

function TConsulta.Consulta_Dinamica(Str_SQL: string;
  Active, bReadOnly: Boolean; AOwner: TComponent): TFDQuery;
begin
  Result := Consulta_Dinamica(Str_SQL, [], Active, bReadOnly, AOwner);
end;

function TConsulta.Consulta_Dinamica(Str_SQL: TStringList;
  const AParams: array of Variant; Active, bReadOnly: Boolean;
  AOwner: TComponent): TFDQuery;
begin
  Result := Consulta_Dinamica(Str_SQL.Text, AParams, Active, bReadOnly, AOwner);
end;

function TConsulta.Consulta_Dinamica(Str_SQL: string;
  const AParams: array of Variant; Active, bReadOnly: Boolean;
  AOwner: TComponent): TFDQuery;
var
  i: Integer;
begin
  Str_SQL := Str_SQL.Trim;

  Result := FactoryFDQuery(bReadOnly, -1, AOwner);

  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Text := Str_SQL;

  if (not Str_SQL.Trim.IsEmpty) then
  begin
    try
      if (Result.ParamCount > 0) and (length(AParams) > 0) then
      begin
        if (Result.ParamCount) <> length(AParams) then
          raise exception.Create
            ('O parâmetros insuficientes para executar o SQL');

        if not Result.Prepared then
          Result.Prepare;

        for i := 0 to Result.ParamCount - 1 do
        begin
          if AParams[i] = Null then
            Result.Params[i].Clear

          else if Result.Params[i].DataType in [ftDate, ftTime] then
          begin
            if Result.Params[i].DataType = ftDate then
              Result.Params[i].AsDate := StrToDate(VarToStr(AParams[i]))
            else if Result.Params[i].DataType = ftTime then
              Result.Params[i].AsTime := StrToTime(VarToStr(AParams[i]))
            else
              Result.Params[i].asDateTime := VarToDateTime(AParams[i]);
          end
          else
            Result.Params[i].Value := AParams[i];
        end;
      end;

      // Abrir Query
      if (Active) then
        Result.Open
    except
      on E: exception do
      begin
        raise exception.Create('Error executing function Consulta_Dinamica');
      end; // on E: Exception do
    end;
  end;

end;

function TConsulta.Retorno_Dinamico(Str_SQL: TStringList;
  const AParams: array of Variant; TipoRetorno: TFieldType): Variant;
begin
  Result := Retorno_Dinamico(Str_SQL.Text, AParams, TipoRetorno);
end;

function TConsulta.Retorno_Dinamico(Str_SQL: TStringList;
  TipoRetorno: TFieldType): Variant;
begin
  Result := Retorno_Dinamico(Str_SQL.Text, [], TipoRetorno);
end;

function TConsulta.Retorno_Dinamico(Str_SQL: string;
  const AParams: array of Variant; TipoRetorno: TFieldType): Variant;
var
  QDinamica: TFDQuery;
  i: Integer;
begin
  if (TipoRetorno in [ftSmallint, ftInteger, ftFloat, ftCurrency, ftBCD,
    ftExtended]) or (TipoRetorno in [ftDate, ftDateTime, ftTime]) then
    Result := 0
  else if TipoRetorno in [ftString, ftWideString] then
    Result := ''
  else
    Result := Null;

  QDinamica := Consulta_Dinamica(Str_SQL, AParams, False, True);
  try
    try
      if QDinamica.ParamCount > 0 then
      begin
        if (QDinamica.ParamCount) <> length(AParams) then
          raise exception.Create
            ('O parâmetros insuficientes para executar o SQL');
        for i := 0 to QDinamica.ParamCount - 1 do
          QDinamica.Params[i].Value := AParams[i];
      end;

      QDinamica.Open();
      if Assigned(QDinamica) then
      begin
        if TipoRetorno in [ftSmallint, ftInteger] then
          Result := QDinamica.Fields[0].AsInteger
        else if TipoRetorno in [ftString, ftWideString] then
          Result := QDinamica.Fields[0].AsString
        else if TipoRetorno in [ftFloat, ftCurrency, ftBCD, ftExtended] then
        begin
          if TipoRetorno = ftCurrency then
            Result := QDinamica.Fields[0].AsCurrency
          else if TipoRetorno = ftExtended then
            Result := QDinamica.Fields[0].AsExtended
          else
            Result := QDinamica.Fields[0].AsFloat;
        end
        else if TipoRetorno in [ftDate, ftDateTime, ftTime] then
        begin
          if (TipoRetorno = ftDate) then
            Result := StrToDateDef(FormatDateTime('DD/MM/YYYY',
              QDinamica.Fields[0].asDateTime), 0)
          else if (TipoRetorno = ftTime) then
            Result := StrToTimeDef(FormatDateTime('HH:NN:SS:ZZZZ',
              QDinamica.Fields[0].asDateTime), 0)
          else
            Result := StrToDateTimeDef
              (FormatDateTime('DD/MM/YYYY HH:NN:SS:ZZZZ',
              QDinamica.Fields[0].asDateTime), 0);
        end
        else
          Result := QDinamica.Fields[0].Value;
      end;
    except
      on E: EFDException do
      begin
        raise exception.Create('Error executing function Retorno_Dinamico');
      end;
    end;
  finally
    if Assigned(QDinamica) then
    begin
      QDinamica.Close;
      FreeAndNil(QDinamica);
    end;
  end; // finally
end;

function TConsulta.Retorno_Dinamico(Str_SQL: string;
  TipoRetorno: TFieldType): Variant;
begin
  Result := Retorno_Dinamico(Str_SQL, [], TipoRetorno);
end;

function TConsulta.FactoryFDQueryReadOnly(pDetailDelay: Integer;
  AOwner: TComponent): TFDQuery;
begin
  Result := FactoryFDQuery(True, pDetailDelay, AOwner);
end;

function TConsulta.FactoryFDQuery(AReadOnly: Boolean; pDetailDelay: Integer;
  AOwner: TComponent): TFDQuery;
begin
  Result := TFDQuery.Create(AOwner);

  Result.Transaction := TFDCustomTransaction(FTransaction);

  if Result.Transaction.Active then
    Result.Transaction.Rollback;

  Result.Connection := Result.Transaction.Connection;

  /// Tunning para queries de somente pesquisa
  if AReadOnly then
  begin
    Result.FetchOptions.Items := [fiBlobs, fiDetails];
    Result.UpdateOptions.RequestLive := False;
    Result.UpdateOptions.EnableDelete := False;
    Result.UpdateOptions.EnableInsert := False;
    Result.UpdateOptions.EnableUpdate := False;
  end
  else
    Result.CachedUpdates := True;

  if (pDetailDelay >= 0) then
    Result.FetchOptions.DetailDelay := pDetailDelay;
end;

end.
