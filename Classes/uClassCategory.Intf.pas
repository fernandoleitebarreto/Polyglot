unit uClassCategory.Intf;

interface

uses
  uEnum;
  //, uCircle;

type
  ICategory = interface
    ['{017404F3-6BF1-48AA-87F3-555CDB5F40A8}']
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

    function percent_complete: Currency; overload;
    function percent_complete(Value: Currency): Currency; overload;
    function percent_complete(pGameForms: TGameForms;
      ALanguage: TNativeLanguage): Currency; overload;

    procedure IncTotal(pGameForms: TGameForms; ALanguage: TNativeLanguage);

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

//    function GetCircle: TCircleFrame;
//    procedure SetCircle(const Value: TCircleFrame);
//    property Circle: TCircleFrame read GetCircle write SetCircle;
  end;

implementation

end.
