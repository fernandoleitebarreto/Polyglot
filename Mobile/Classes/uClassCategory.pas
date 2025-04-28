unit uClassCategory;

interface

uses
  uEnum, uEnum.Helper, uClassCategory.Intf, System.SysUtils, UnitConstante;
//  uCircle;

type

  TCategory = class(TInterfacedObject, ICategory)
  private
//    FCircle: TCircleFrame;
    FNativeLanguage: TNativeLanguage;

    FContItem: Integer;
    FId_Categoria: Integer;
    FCateg_English: string;
    FCateg_Spanish: string;
    FCateg_French: string;
    FCateg_Italian: string;
    FCateg_Portuguese: string;

    Fdescricao_categoria: string;
    FId_Subcategoria: Integer;
    Ficone: string;
    Fword_phrase: string;
    Ftotal_complete: Integer;
    Ftotal_words: Integer;

    FITALIAN_COMPL: Integer;
    FENGLISH_COMPL: Integer;
    FSPANISH_SW: Integer;
    FFRENCH_MEM: Integer;
    FFRENCH_SW: Integer;
    FITALIAN_SW: Integer;
    FENGLISH_SW: Integer;
    FSPANISH_MEM: Integer;
    FITALIAN_MEM: Integer;
    FENGLISH_MEM: Integer;
    FPORTUGUESE_COMPL: Integer;
    FPORTUGUESE_SW: Integer;
    FFRENCH_COMPL: Integer;
    FPORTUGUESE_MEM: Integer;
    FSPANISH_COMPL: Integer;

    function ContItem: Integer;
    function Categ_English: string;
    function Categ_Spanish: string;
    function Categ_French: string;
    function Categ_Italian: string;
    function Categ_Portuguese: string;
    function descricao(ALanguage: TNativeLanguage): string;
    function descricao_categoria: string;
    function id_categoria: Integer;
    function id_subcategoria: Integer;
    function icone: string;
    function word_phrase: string;
    function total_words: Integer;
    function total_complete: Integer; overload;
    function total_complete(pGameForms: TGameForms; ALanguage: TNativeLanguage)
      : Integer; overload;
    function total_complete(pGameForms: TGameForms): Integer; overload;

    procedure IncTotal(pGameForms: TGameForms; ALanguage: TNativeLanguage);

    function percent_complete: Currency; overload;
    function percent_complete(Value: Currency): Currency; overload;
    function percent_complete(pGameForms: TGameForms;
      ALanguage: TNativeLanguage): Currency; overload;

    function ENGLISH_COMPL: Integer;
    function ENGLISH_MEM: Integer;
    function ENGLISH_SW: Integer;

    function FRENCH_COMPL: Integer;
    function FRENCH_MEM: Integer;
    function FRENCH_SW: Integer;

    function ITALIAN_COMPL: Integer;
    function ITALIAN_MEM: Integer;
    function ITALIAN_SW: Integer;

    function PORTUGUESE_COMPL: Integer;
    function PORTUGUESE_MEM: Integer;
    function PORTUGUESE_SW: Integer;

    function SPANISH_COMPL: Integer;
    function SPANISH_MEM: Integer;
    function SPANISH_SW: Integer;

//    function GetCircle: TCircleFrame;
//    procedure SetCircle(const Value: TCircleFrame);

    procedure SetContItem(const Value: Integer);
    procedure SetCateg_English(const Value: string);
    procedure SetCateg_Spanish(const Value: string);
    procedure SetCateg_French(const Value: string);
    procedure SetCateg_Italian(const Value: string);
    procedure SetCateg_Portuguese(const Value: string);
    procedure Setdescricao_categoria(const Value: string);
    procedure Seticone(const Value: string);
    procedure Setword_phrase(const Value: string);
    procedure Setid_subcategoria(const Value: Integer);
    procedure Setid_categoria(const Value: Integer);
    procedure Settotal_complete(const Value: Integer);
    procedure Settotal_words(const Value: Integer);

    procedure SetENGLISH_COMPL(const Value: Integer);
    procedure SetENGLISH_MEM(const Value: Integer);
    procedure SetENGLISH_SW(const Value: Integer);

    procedure SetFRENCH_COMPL_QTD(const Value: Integer);
    procedure SetFRENCH_MEM_QTD(const Value: Integer);
    procedure SetFRENCH_SW(const Value: Integer);

    procedure SetITALIAN_COMPL(const Value: Integer);
    procedure SetITALIAN_MEM(const Value: Integer);
    procedure SetITALIAN_SW(const Value: Integer);

    procedure SetPORTUGUESE_COMPL(const Value: Integer);
    procedure SetPORTUGUESE_MEM(const Value: Integer);
    procedure SetPORTUGUESE_SW(const Value: Integer);

    procedure SetSPANISH_COMPL(const Value: Integer);
    procedure SetSPANISH_MEM(const Value: Integer);
    procedure SetSPANISH_SW(const Value: Integer);
    procedure SetNativeLanguage(const Value: TNativeLanguage);

  public
    constructor Create;
    destructor Destroy; override;
    class function New: ICategory;
  end;

implementation

{ TCategory }

//function TCategory.GetCircle: TCircleFrame;
//begin
//  Result := FCircle;
//end;

function TCategory.Categ_English: string;
begin
  Result := FCateg_English;
end;

function TCategory.Categ_French: string;
begin
  Result := FCateg_French;
end;

function TCategory.Categ_Italian: string;
begin
  Result := FCateg_Italian;
end;

function TCategory.Categ_Portuguese: string;
begin
  Result := FCateg_Portuguese;
end;

function TCategory.Categ_Spanish: string;
begin
  Result := FCateg_Spanish;
end;

function TCategory.ContItem: Integer;
begin
  Result := FContItem;
end;

constructor TCategory.Create;
begin
  FNativeLanguage := nlUnknow;
  FContItem := 0;
  FId_Categoria := 0;
  FCateg_English := '';
  FCateg_Spanish := '';
  FCateg_French := '';
  FCateg_Italian := '';
  FCateg_Portuguese := '';
  Fdescricao_categoria := '';
  FId_Subcategoria := 0;

end;

function TCategory.descricao(ALanguage: TNativeLanguage): string;
begin
  case ALanguage of
    nlEnglish:
      Result := FCateg_English;
    nlPortuguese:
      Result := FCateg_Portuguese;
    nlFrench:
      Result := FCateg_French;
    nlSpanish:
      Result := FCateg_Spanish;
    nlItalian:
      Result := FCateg_Italian;
  else
    Result := FCateg_English;
  end;
end;

function TCategory.descricao_categoria: string;
begin
  Result := Fdescricao_categoria;
end;

destructor TCategory.Destroy;
begin
  inherited;
end;

function TCategory.ENGLISH_COMPL: Integer;
begin
  Result := FENGLISH_COMPL;
end;

function TCategory.ENGLISH_MEM: Integer;
begin
  Result := FENGLISH_MEM;
end;

function TCategory.ENGLISH_SW: Integer;
begin
  Result := FENGLISH_SW;
end;

function TCategory.FRENCH_COMPL: Integer;
begin
  Result := FFRENCH_COMPL;
end;

function TCategory.FRENCH_MEM: Integer;
begin
  Result := FFRENCH_MEM;
end;

function TCategory.FRENCH_SW: Integer;
begin
  Result := FFRENCH_SW;
end;

function TCategory.total_complete(pGameForms: TGameForms): Integer;
begin
  Result := 0;
  if nlEnglish <> FNativeLanguage then
    Result := Result + total_complete(pGameForms, nlEnglish);

  if nlPortuguese <> FNativeLanguage then
    Result := Result + total_complete(pGameForms, nlPortuguese);

  if nlFrench <> FNativeLanguage then
    Result := Result + total_complete(pGameForms, nlFrench);

  if nlSpanish <> FNativeLanguage then
    Result := Result + total_complete(pGameForms, nlSpanish);

  if nlItalian <> FNativeLanguage then
    Result := Result + total_complete(pGameForms, nlItalian);
end;

function TCategory.icone: string;
begin
  Result := Ficone;
end;

function TCategory.id_categoria: Integer;
begin
  Result := FId_Categoria;
end;

function TCategory.id_subcategoria: Integer;
begin
  Result := FId_Subcategoria;
end;

function TCategory.ITALIAN_COMPL: Integer;
begin
  Result := FITALIAN_COMPL;
end;

function TCategory.ITALIAN_MEM: Integer;
begin
  Result := FITALIAN_MEM;
end;

function TCategory.ITALIAN_SW: Integer;
begin
  Result := FITALIAN_SW;
end;

class function TCategory.New: ICategory;
begin
  Result := Self.Create;
end;

function TCategory.percent_complete: Currency;
var
  total: Currency;
begin
  total := Ftotal_words * cQtdLanguages * High(TGameForms).AsByte;
  if Ftotal_complete > total then
    Result := 100
  else if Ftotal_complete > 0 then
    Result := (Ftotal_complete * 100) / (total)
  else
    Result := 0;
end;

function TCategory.percent_complete(pGameForms: TGameForms;
  ALanguage: TNativeLanguage): Currency;
begin
  Result := total_complete(pGameForms, ALanguage);
  if ALanguage = nlAll then
    Result := percent_complete(Result)
  else
  begin
    if Ftotal_words > 0 then
      Result := ((Result * 100) / Ftotal_words)
    else
      Result := 0;
  end;

end;

function TCategory.total_complete(pGameForms: TGameForms;
  ALanguage: TNativeLanguage): Integer;
begin
  case pGameForms of
    fmCompleteWords:
      begin
        case ALanguage of
          nlEnglish:
            Result := FENGLISH_COMPL;
          nlPortuguese:
            Result := FPORTUGUESE_COMPL;
          nlFrench:
            Result := FFRENCH_COMPL;
          nlSpanish:
            Result := FSPANISH_COMPL;
          nlItalian:
            Result := FITALIAN_COMPL;
          nlAll:
            Result := total_complete(pGameForms);

        else
          Result := 0;
        end;

      end;

    fmMemorize:
      begin
        case ALanguage of
          nlEnglish:
            Result := FENGLISH_MEM;
          nlPortuguese:
            Result := FPORTUGUESE_MEM;
          nlFrench:
            Result := FFRENCH_MEM;
          nlSpanish:
            Result := FSPANISH_MEM;
          nlItalian:
            Result := FITALIAN_MEM;
          nlAll:
            Result := total_complete(pGameForms);

        else
          Result := 0;
        end;

      end;
    fmSelectWords:
      begin
        case ALanguage of
          nlEnglish:
            Result := FENGLISH_SW;
          nlPortuguese:
            Result := FPORTUGUESE_SW;
          nlFrench:
            Result := FFRENCH_SW;
          nlSpanish:
            Result := FSPANISH_SW;
          nlItalian:
            Result := FITALIAN_SW;
          nlAll:
            Result := total_complete(pGameForms);

        else
          Result := 0;
        end;

      end
  else
    raise Exception.CreateFmt('Form [%d] not specifield', [pGameForms.AsByte]);
  end;

end;

function TCategory.percent_complete(Value: Currency): Currency;
var
  all_words: Currency;
begin
  all_words := Ftotal_words * (High(TNativeLanguage).AsByte - 2);
  // if Value > all_words then
  // Value := all_words;

  if Value > 0 then
    Result := (Value * 100) / all_words
  else
    Result := 0;
end;

procedure TCategory.IncTotal(pGameForms: TGameForms;
  ALanguage: TNativeLanguage);
begin
  case pGameForms of
    fmCompleteWords:
      begin
        case ALanguage of
          nlEnglish:
            Inc(FENGLISH_COMPL);
          nlPortuguese:
            Inc(FPORTUGUESE_COMPL);
          nlFrench:
            Inc(FFRENCH_COMPL);
          nlSpanish:
            Inc(FSPANISH_COMPL);
          nlItalian:
            Inc(FITALIAN_COMPL);
        else
          raise Exception.Create('Language not defined');
        end;

      end;

    fmMemorize:
      begin
        case ALanguage of
          nlEnglish:
            Inc(FENGLISH_MEM);
          nlPortuguese:
            Inc(FPORTUGUESE_MEM);
          nlFrench:
            Inc(FFRENCH_MEM);
          nlSpanish:
            Inc(FSPANISH_MEM);
          nlItalian:
            Inc(FITALIAN_MEM);
        else
          raise Exception.Create('Language not defined');
        end;

      end;
    fmSelectWords:
      begin
        case ALanguage of
          nlEnglish:
            Inc(FENGLISH_SW);
          nlPortuguese:
            Inc(FPORTUGUESE_SW);
          nlFrench:
            Inc(FFRENCH_SW);
          nlSpanish:
            Inc(FSPANISH_SW);
          nlItalian:
            Inc(FITALIAN_SW);
        else
          raise Exception.Create('Language not defined');
        end;

      end
  else
    raise Exception.CreateFmt('Form [%d] not specifield', [pGameForms.AsByte]);
  end;

end;

//procedure TCategory.SetCircle(const Value: TCircleFrame);
//begin
//  FCircle := Value;
//end;

procedure TCategory.SetCateg_English(const Value: string);
begin
  FCateg_English := Value;
end;

procedure TCategory.SetCateg_French(const Value: string);
begin
  FCateg_French := Value;
end;

procedure TCategory.SetCateg_Italian(const Value: string);
begin
  FCateg_Italian := Value;
end;

procedure TCategory.SetCateg_Portuguese(const Value: string);
begin
  FCateg_Portuguese := Value;
end;

procedure TCategory.SetCateg_Spanish(const Value: string);
begin
  FCateg_Spanish := Value;
end;

procedure TCategory.SetContItem(const Value: Integer);
begin
  FContItem := Value;
end;

procedure TCategory.Setdescricao_categoria(const Value: string);
begin
  Fdescricao_categoria := Value;
end;

procedure TCategory.SetENGLISH_COMPL(const Value: Integer);
begin
  FENGLISH_COMPL := Value;
end;

procedure TCategory.SetENGLISH_MEM(const Value: Integer);
begin
  FENGLISH_MEM := Value;
end;

procedure TCategory.SetENGLISH_SW(const Value: Integer);
begin
  FENGLISH_SW := Value;
end;

procedure TCategory.SetFRENCH_COMPL_QTD(const Value: Integer);
begin
  FFRENCH_COMPL := Value;
end;

procedure TCategory.SetFRENCH_MEM_QTD(const Value: Integer);
begin
  FFRENCH_MEM := Value;
end;

procedure TCategory.SetFRENCH_SW(const Value: Integer);
begin
  FFRENCH_SW := Value;
end;

procedure TCategory.Seticone(const Value: string);
begin
  Ficone := Value;
end;

procedure TCategory.Setid_categoria(const Value: Integer);
begin
  FId_Categoria := Value;
end;

procedure TCategory.Setid_subcategoria(const Value: Integer);
begin
  FId_Subcategoria := Value;
end;

procedure TCategory.SetITALIAN_COMPL(const Value: Integer);
begin
  FITALIAN_COMPL := Value;
end;

procedure TCategory.SetITALIAN_MEM(const Value: Integer);
begin
  FITALIAN_MEM := Value;
end;

procedure TCategory.SetITALIAN_SW(const Value: Integer);
begin
  FITALIAN_SW := Value;
end;

procedure TCategory.SetNativeLanguage(const Value: TNativeLanguage);
begin
  FNativeLanguage := Value;
end;

procedure TCategory.SetPORTUGUESE_COMPL(const Value: Integer);
begin
  FPORTUGUESE_COMPL := Value;
end;

procedure TCategory.SetPORTUGUESE_MEM(const Value: Integer);
begin
  FPORTUGUESE_MEM := Value;
end;

procedure TCategory.SetPORTUGUESE_SW(const Value: Integer);
begin
  FPORTUGUESE_SW := Value;
end;

procedure TCategory.SetSPANISH_COMPL(const Value: Integer);
begin
  FSPANISH_COMPL := Value;
end;

procedure TCategory.SetSPANISH_MEM(const Value: Integer);
begin
  FSPANISH_MEM := Value;
end;

procedure TCategory.SetSPANISH_SW(const Value: Integer);
begin
  FSPANISH_SW := Value;
end;

procedure TCategory.Settotal_complete(const Value: Integer);
begin
  Ftotal_complete := Value;
end;

procedure TCategory.Settotal_words(const Value: Integer);
begin
  Ftotal_words := Value;
end;

procedure TCategory.Setword_phrase(const Value: string);
begin
  Fword_phrase := Value;
end;

function TCategory.SPANISH_COMPL: Integer;
begin
  Result := FSPANISH_COMPL;
end;

function TCategory.SPANISH_MEM: Integer;
begin
  Result := FSPANISH_MEM;
end;

function TCategory.SPANISH_SW: Integer;
begin
  Result := FSPANISH_SW;
end;

function TCategory.total_complete: Integer;
begin
  Result := Ftotal_complete;
end;

function TCategory.total_words: Integer;
begin
  Result := Ftotal_words;
end;

function TCategory.word_phrase: string;
begin
  Result := Fword_phrase;
end;

function TCategory.PORTUGUESE_COMPL: Integer;
begin
  Result := FPORTUGUESE_COMPL;
end;

function TCategory.PORTUGUESE_MEM: Integer;
begin
  Result := FPORTUGUESE_MEM;
end;

function TCategory.PORTUGUESE_SW: Integer;
begin
  Result := FPORTUGUESE_SW;
end;

end.
