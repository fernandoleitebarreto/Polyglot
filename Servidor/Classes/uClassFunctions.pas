unit uClassFunctions;

interface

uses System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, uRESTDWServerEvents,
  System.JSON, FireDAC.DApt, FireDAC.Stan.Param, FMX.Graphics,
  uEnum, uClassMeaning.Intf, uEnum.Helper;

type

  IPolyglot = interface
    ['{324C6C0F-B1C0-464E-BCA3-89391D782CC2}']
    function Meaning: IMeaning;
    procedure SetMeaning(const Value: IMeaning);

    function AddAudio(out erro: string): Boolean;
    function Criar(out erro: string; SubCategoryField: string): Boolean;
    function Editar(out erro: string; SubCategoryField: string): Boolean;
    function CarregaDados(Usuario, SubCategory: Integer;
      SubCategoryField: string; NativeLanguage: TNativeLanguage;
      AForm: TGameForms): string;
    function RandomDados(SubCategory: Integer;
      SubCategoryField: string): string;
    function WordsWithNoAudio(Field: string; Category: Integer): string;
  end;

  TPolyglot = class(TInterfacedObject, IPolyglot)
  private
    FConn: TFDConnection;
    FMeaning: IMeaning;

    function Meaning: IMeaning;
    procedure SetMeaning(const Value: IMeaning);
    function AddAudio(out erro: string): Boolean;
    function Criar(out erro: string; SubCategoryField: string): Boolean;
    function Editar(out erro: string; SubCategoryField: string): Boolean;
    function CarregaDados(Usuario, SubCategory: Integer;
      SubCategoryField: string; NativeLanguage: TNativeLanguage;
      AForm: TGameForms): string;
    function RandomDados(SubCategory: Integer;
      SubCategoryField: string): string;
    function WordsWithNoAudio(Field: string; Category: Integer): string;
  public
    constructor Create(conn: TFDConnection);
    destructor Destroy; override;
    class function New(conn: TFDConnection): IPolyglot;
  end;

implementation

{ TPolyglot }

uses uConsulta;

constructor TPolyglot.Create(conn: TFDConnection);
begin
  FConn := conn;
//  FMeaning := TMeaning.New;
end;

destructor TPolyglot.Destroy;
begin

  inherited;
end;

class function TPolyglot.New(conn: TFDConnection): IPolyglot;
begin
  Result := Self.Create(conn);

end;

function TPolyglot.Meaning: IMeaning;
begin
  Result := FMeaning;
end;

procedure TPolyglot.SetMeaning(const Value: IMeaning);
begin
  FMeaning := Value;
end;

function TPolyglot.AddAudio(out erro: string): Boolean;
var
  qry: TFDQuery;
begin
  try
    qry := TFDQuery.Create(nil);
    qry.Connection := FConn;

    with qry do
    begin
      Active := False;
      SQL.Clear;

      SQL.Add(Format(' UPDATE WORDS SET %s = :AUDIO WHERE ID = :ID',
        ['AUDIO_' + FMeaning.NativeLanguage.Field]));

      ParamByName('ID').AsInteger := FMeaning.CodItem;
      ParamByName('AUDIO').AsString := FMeaning.Audio(FMeaning.NativeLanguage);
      ExecSQL;

      erro := '';
      Result := True;

      DisposeOf;
    end;

  except
    on ex: Exception do
    begin
      erro := 'Erro ao atualizar audio: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TPolyglot.Criar(out erro: string; SubCategoryField: string): Boolean;
var
  qry: TFDQuery;
  subcategoria: string;
begin
  subcategoria := 'ID_SUBCATEGORIA_' + SubCategoryField;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := FConn;

    with qry do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(' insert into WORDS (' + subcategoria +
        ', ENGLISH, SPANISH, FRENCH, ITALIAN, PORTUGUESE, AUDIO_ENGLISH, AUDIO_SPANISH,');
      SQL.Add('                    AUDIO_FRENCH, AUDIO_ITALIAN, AUDIO_PORTUGUESE)');
      SQL.Add(' values (:ID_SUBCATEGORIA, :ENGLISH, :SPANISH, :FRENCH, :ITALIAN, :PORTUGUESE, :AUDIO_ENGLISH, :AUDIO_SPANISH,');
      SQL.Add('         :AUDIO_FRENCH, :AUDIO_ITALIAN, :AUDIO_PORTUGUESE)');

      ParamByName('ID_SUBCATEGORIA').AsInteger :=
        FMeaning.Category.id_subcategoria;
      ParamByName('ENGLISH').AsString := FMeaning.English;
      ParamByName('SPANISH').AsString := FMeaning.Spanish;
      ParamByName('FRENCH').AsString := FMeaning.French;
      ParamByName('ITALIAN').AsString := FMeaning.Italian;
      ParamByName('PORTUGUESE').AsString := FMeaning.Portuguese;

      if FMeaning.AudioEnglish <> '' then
        ParamByName('AUDIO_ENGLISH').AsString := FMeaning.AudioEnglish
      else
        ParamByName('AUDIO_ENGLISH').IsNull;

      if FMeaning.AudioSpanish <> '' then
        ParamByName('AUDIO_SPANISH').AsString := FMeaning.AudioSpanish
      else
        ParamByName('AUDIO_SPANISH').IsNull;

      if FMeaning.AudioFrench <> '' then
        ParamByName('AUDIO_FRENCH').AsString := FMeaning.AudioFrench
      else
        ParamByName('AUDIO_FRENCH').IsNull;

      if FMeaning.AudioItalian <> '' then
        ParamByName('AUDIO_ITALIAN').AsString := FMeaning.AudioItalian
      else
        ParamByName('AUDIO_ITALIAN').IsNull;

      if FMeaning.AudioPortuguese <> '' then
        ParamByName('AUDIO_PORTUGUESE').AsString := FMeaning.AudioPortuguese
      else
        ParamByName('AUDIO_PORTUGUESE').IsNull;

      ExecSQL;

      erro := '';
      Result := True;

      DisposeOf;
    end;

  except
    on ex: Exception do
    begin
      erro := 'Erro ao criar nova palavra: ' + ex.Message;
      Result := False;
    end;
  end;

end;

function TPolyglot.Editar(out erro: string; SubCategoryField: string): Boolean;
var
  qry: TFDQuery;
  subcategoria: string;
begin
  subcategoria := 'ID_SUBCATEGORIA_' + SubCategoryField;
  qry := TFDQuery.Create(nil);
  try

    qry.Connection := FConn;

    with qry do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(' update WORDS ');
      SQL.Add('    set ' + subcategoria + ' = :ID_SUBCATEGORIA,');
      SQL.Add('        ENGLISH = :ENGLISH,');
      SQL.Add('        SPANISH = :SPANISH,');
      SQL.Add('        FRENCH = :FRENCH,');
      SQL.Add('        ITALIAN = :ITALIAN,');
      SQL.Add('        PORTUGUESE = :PORTUGUESE,');
      SQL.Add('        AUDIO_ENGLISH = :AUDIO_ENGLISH,');
      SQL.Add('        AUDIO_SPANISH = :AUDIO_SPANISH,');
      SQL.Add('        AUDIO_FRENCH = :AUDIO_FRENCH,');
      SQL.Add('        AUDIO_ITALIAN = :AUDIO_ITALIAN,');
      SQL.Add('        AUDIO_PORTUGUESE = :AUDIO_PORTUGUESE');
      SQL.Add(' where ID = :ID');

      ParamByName('ID_SUBCATEGORIA').AsInteger :=
        FMeaning.Category.id_subcategoria;
      ParamByName('ENGLISH').AsString := FMeaning.English;
      ParamByName('SPANISH').AsString := FMeaning.Spanish;
      ParamByName('FRENCH').AsString := FMeaning.French;
      ParamByName('ITALIAN').AsString := FMeaning.Italian;
      ParamByName('PORTUGUESE').AsString := FMeaning.Portuguese;

      if FMeaning.AudioEnglish <> '' then
        ParamByName('AUDIO_ENGLISH').AsString := FMeaning.AudioEnglish
      else
        ParamByName('AUDIO_ENGLISH').IsNull;

      if FMeaning.AudioSpanish <> '' then
        ParamByName('AUDIO_SPANISH').AsString := FMeaning.AudioSpanish
      else
        ParamByName('AUDIO_SPANISH').IsNull;

      if FMeaning.AudioFrench <> '' then
        ParamByName('AUDIO_FRENCH').AsString := FMeaning.AudioFrench
      else
        ParamByName('AUDIO_FRENCH').IsNull;

      if FMeaning.AudioItalian <> '' then
        ParamByName('AUDIO_ITALIAN').AsString := FMeaning.AudioItalian
      else
        ParamByName('AUDIO_ITALIAN').IsNull;

      if FMeaning.AudioPortuguese <> '' then
        ParamByName('AUDIO_PORTUGUESE').AsString := FMeaning.AudioPortuguese
      else
        ParamByName('AUDIO_PORTUGUESE').IsNull;

      ParamByName('ID').AsInteger := FMeaning.CodItem;

      ExecSQL;

      erro := '';
      Result := True;

      DisposeOf;
    end;

  except
    on ex: Exception do
    begin
      erro := 'Erro ao criar nova palavra: ' + ex.Message;
      Result := False;
    end;
  end;
end;

function TPolyglot.CarregaDados(Usuario, SubCategory: Integer;
  SubCategoryField: string; NativeLanguage: TNativeLanguage;
  AForm: TGameForms): string;
var
  Obj, ObjText, ObjAudio: TJSONObject;
  erro: string;
  JSON: TStringBuilder;
  qry: TFDQuery;
begin

  JSON := TStringBuilder.Create;
  qry := TConsulta.New(FConn).FactoryFDQuery(False);

  try
    try
      qry.Active := False;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT W.*');
      qry.SQL.Add('  FROM WORDS W');

      if AForm = fmUnknow then
      begin
        qry.SQL.Add(' JOIN TAB_SUBCATEGORIA SC ON ');
        qry.SQL.Add(Format(' (SC.ID = W.ID_SUBCATEGORIA_%s ' +
          ' AND SC.IND_ATIVO = ''S'')', [SubCategoryField]));
        qry.SQL.Add(' JOIN TAB_CATEGORIA C ON ');
        qry.SQL.Add('        (SC.ID_CATEGORIA = C.ID AND C.IND_ATIVO = ''S'')');
      end;

      // if Usuario > 0 then
      // begin
      // qry.SQL.Add('  LEFT JOIN WORDS_COMPLETE WC ON ');
      // qry.SQL.Add(' (WC.ID_WORD = W.ID AND WC.ID_USUARIO = :ID_USUARIO)');
      // end;

      qry.SQL.Add(' WHERE 1=1');

      // if SubCategory > 0 then
      // begin
      qry.SQL.Add(Format('AND W.ID_SUBCATEGORIA_%s = :ID_SUBCATEGORIA',
        [SubCategoryField]));
      qry.ParamByName('ID_SUBCATEGORIA').AsInteger := SubCategory;
      // end;

      qry.SQL.Add('ORDER BY ');

      if AForm = fmUnknow then
      begin
        qry.SQL.Add(' CASE WHEN C.WORD_PHRASE = ''W'' THEN W.' +
          NativeLanguage.Field + ' END, ');
      end;
      // else
      // qry.SQL.Add(' CASE when WC.id_word IS NULL then 0 else 1 end,');
      // qry.SQL.Add(' CASE WHEN WC.' + AForm.FieldDataBase(NativeLanguage) + ' DESC,');

      qry.SQL.Add('W.ID');

      // if Usuario > 0 then
      // qry.ParamByName('ID_USUARIO').AsInteger := Usuario;

      qry.Active := True;

    except
      on ex: Exception do
      begin
        erro := 'Erro ao listar palavras: ' + ex.Message;
        raise;
      end;
    end;

    JSON.Clear;
    JSON.Append('[');
    qry.First;
    while not qry.Eof do
    begin
      Obj := TJSONObject.Create;
      try
        Obj.AddPair('codItem', TJSONNumber.Create(qry.FieldByName('Id')
          .AsInteger));

        ObjText := TJSONObject.Create;
        ObjText.AddPair('English', qry.FieldByName('English').AsString);
        ObjText.AddPair('French', qry.FieldByName('French').AsString);
        ObjText.AddPair('Italian', qry.FieldByName('Italian').AsString);
        ObjText.AddPair('Portuguese', qry.FieldByName('Portuguese').AsString);
        ObjText.AddPair('Spanish', qry.FieldByName('Spanish').AsString);

        ObjAudio := TJSONObject.Create;
        ObjAudio.AddPair('English', qry.FieldByName('Audio_English').AsString);
        ObjAudio.AddPair('French', qry.FieldByName('Audio_French').AsString);
        ObjAudio.AddPair('Italian', qry.FieldByName('Audio_Italian').AsString);
        ObjAudio.AddPair('Portuguese', qry.FieldByName('Audio_Portuguese')
          .AsString);
        ObjAudio.AddPair('Spanish', qry.FieldByName('Audio_Spanish').AsString);

        Obj.AddPair('Text', ObjText);
        Obj.AddPair('Audio', ObjAudio);
        JSON.Append(Obj.ToString);
        qry.Next;

        if not qry.Eof then
          JSON.Append(',');
      finally
        Obj.DisposeOf;
      end;

    end;

    JSON.Append(']');
    Result := JSON.ToString;
  finally
    qry.DisposeOf;
    JSON.DisposeOf;
  end;
end;

function TPolyglot.RandomDados(SubCategory: Integer;
  SubCategoryField: string): string;
var
  Obj, ObjText, ObjAudio: TJSONObject;
  erro: string;
  JSON: TStringBuilder;
  qry: TFDQuery;
begin

  JSON := TStringBuilder.Create;
  qry := TConsulta.New(FConn).FactoryFDQuery(False);

  try
    try
      qry.Active := False;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT * FROM WORDS W');
      qry.SQL.Add('WHERE W.ID > 0');

      if SubCategory > 0 then
      begin
        qry.SQL.Add(Format('AND W.ID_SUBCATEGORIA_%s = :ID_SUBCATEGORIA',
          [SubCategoryField]));
        qry.ParamByName('ID_SUBCATEGORIA').AsInteger := SubCategory;
      end;

      qry.SQL.Add('ORDER BY RAND();');

      qry.Active := True;

    except
      on ex: Exception do
      begin
        erro := 'Erro ao listar palavras: ' + ex.Message;
        Result := '';
      end;
    end;

    JSON.Clear;
    JSON.Append('[');
    qry.First;
    while not qry.Eof do
    begin
      Obj := TJSONObject.Create;
      Obj.AddPair('codItem', TJSONNumber.Create(qry.FieldByName('Id')
        .AsInteger));

      ObjText := TJSONObject.Create;
      ObjText.AddPair('English', qry.FieldByName('English').AsString);
      ObjText.AddPair('French', qry.FieldByName('French').AsString);
      ObjText.AddPair('Italian', qry.FieldByName('Italian').AsString);
      ObjText.AddPair('Portuguese', qry.FieldByName('Portuguese').AsString);
      ObjText.AddPair('Spanish', qry.FieldByName('Spanish').AsString);

      ObjAudio := TJSONObject.Create;
      ObjAudio.AddPair('English', qry.FieldByName('Audio_English').AsString);
      ObjAudio.AddPair('French', qry.FieldByName('Audio_French').AsString);
      ObjAudio.AddPair('Italian', qry.FieldByName('Audio_Italian').AsString);
      ObjAudio.AddPair('Portuguese', qry.FieldByName('Audio_Portuguese')
        .AsString);
      ObjAudio.AddPair('Spanish', qry.FieldByName('Audio_Spanish').AsString);

      Obj.AddPair('Text', ObjText);
      Obj.AddPair('Audio', ObjAudio);
      JSON.Append(Obj.ToString);
      qry.Next;

      if not qry.Eof then
        JSON.Append(',');

      Obj.DisposeOf;

    end;

    JSON.Append(']');
    Result := JSON.ToString;

  finally
    qry.DisposeOf;
    JSON.DisposeOf;
  end;
end;

function TPolyglot.WordsWithNoAudio(Field: string; Category: Integer): string;
var
  Obj: TJSONObject;
  erro: string;
  JSON: TStringBuilder;
  qry: TFDQuery;
begin
  Field := Field.Trim;

  JSON := TStringBuilder.Create;
  qry := TConsulta.New(FConn).FactoryFDQuery(True);

  try
    try

      qry.Active := False;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT id, ' + Field + ' FROM WORDS');
      qry.SQL.Add('WHERE (Audio_' + Field + ' is null');
      qry.SQL.Add('   OR Audio_' + Field + ' = '''') ');

      if Category > 0 then
      begin
        qry.SQL.Add('AND ID_SUBCATEGORIA = :ID_SUBCATEGORIA');
        qry.ParamByName('ID_SUBCATEGORIA').AsInteger := Category;
      end;

      qry.SQL.Add('ORDER BY ID ASC');

      qry.Active := True;

    except
      on ex: Exception do
      begin
        erro := 'Erro ao listar palavras: ' + ex.Message;
        Result := '';
      end;
    end;

    JSON.Clear;
    if not qry.IsEmpty then
    begin
      JSON.Append('[');
      qry.First;
      while not qry.Eof do
      begin
        // json.Append('[');
        // json.Append('  {');
        // json.Append('    "codItem":"123", ');
        // json.Append('    "NativeLanguage":"Hello1", ');
        // json.Append('  },');
        // json.Append('  {');
        // json.Append('    "codItem":"456", ');
        // json.Append('    "NativeLanguage":"Hello2", ');
        // json.Append('  }');
        // json.Append(']');
        Obj := TJSONObject.Create;
        Obj.AddPair('CodItem', TJSONNumber.Create(qry.FieldByName('Id')
          .AsInteger));
        Obj.AddPair('native_language', qry.FieldByName(Field).AsString);
        JSON.Append(Obj.ToString);
        qry.Next;

        if not qry.Eof then
          JSON.Append(',');

        Obj.DisposeOf;
      end;

      JSON.Append(']');
    end;
    Result := JSON.ToString;

  finally
    qry.DisposeOf;
    JSON.DisposeOf;
  end;

end;

end.
