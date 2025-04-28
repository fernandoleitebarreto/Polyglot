unit uClassMeaning.Intf;

interface

uses
  uClassUser, uClassParametro, uClassCategory.Intf, uEnum, System.Classes,
  UnitConstante;

type
  IMeaning = interface
    ['{BB2C4764-D9B2-42E3-BF1E-997AEFAFCA6B}']
    function AutomaticLogin: Boolean;
    function CloseApplication: Boolean;
    function AccessBlock: Boolean;
    function CodItem: Integer;
    function CodSubCategory: Integer;
    function CountItem: Integer;
    procedure SetCountItem(Value: Integer);
    procedure ResetValues;

    function User: TUsuario;
    function Parametro: TParametro;
    function Category: ICategory;
    function Portuguese: String;
    function Spanish: String;
    function French: String;
    function Italian: String;
    function English: String;
    function TypeCateg: TCategorySelected;

    function AudioPortuguese: String;
    function AudioSpanish: String;
    function AudioFrench: String;
    function AudioItalian: String;
    function AudioEnglish: String;
    function Audio(Language: TNativeLanguage): String;
    function NativeLanguage: TNativeLanguage;
    function EnableAds: Boolean;
    function CurrentCategIndex: Integer;
    function CodLng: Integer;
    function ArrayLanguages: TNativeLanguageArray;

    procedure SetAutomaticLogin(const Value: Boolean);
    procedure SetCloseApplication(const Value: Boolean);
    procedure SetTextNative(Value: String);
    procedure SetCodItem(const Value: Integer);
    procedure SetCodSubCategory(const Value: Integer);
    procedure SetEnglish(const Value: String);
    procedure SetFrench(const Value: String);
    procedure SetItalian(const Value: String);
    procedure SetPortuguese(const Value: String);
    procedure SetSpanish(const Value: String);
    procedure SetCategory(const Value: ICategory);
    procedure SetNativeLanguage(const Value: Integer); overload;
    procedure SetNativeLanguage(const Value: TNativeLanguage); overload;
    procedure SetTypeCateg(const Value: TCategorySelected);

    procedure SetAudioNative(Value: String);
    procedure SetAudioEnglish(const Value: String);
    procedure SetAudioFrench(const Value: String);
    procedure SetAudioItalian(const Value: String);
    procedure SetAudioPortuguese(const Value: String);
    procedure SetAudioSpanish(const Value: String);
    procedure SetParametro(const Value: TParametro);
    procedure SetEnableAds(const Value: Boolean);
    procedure SetCurrentCategIndex(const Value: Integer);
    procedure SetCodLng(const Value: Integer);
    procedure SetArrayLanguages(const Value: TNativeLanguageArray);
    procedure AddLanguage(Language: TNativeLanguage);
    procedure RemoveLastLanguage;

    function getFullDirectory(Language: TNativeLanguage): String;
    function getUrl_PathS3(Language: TNativeLanguage): String;
    function getText(Language: TNativeLanguage): String;
    function getLanguage(Language: TNativeLanguage): String;
    function getDirectory(Language: TNativeLanguage): String;
    function getNativeLanguage: String;
    function getTranslation(Cod: Integer = 0): TNativeLanguage;

    function Temp: TStringList;

    function TermsAndConditions: string;
    function PrivacyPolicy: string;

    function TapItem: TExecutaClickMobile;
    function TapBack: TExecutaClickMobile;
    function ClickItem: TExecutaClickWin;
    function ClickBack: TExecutaClickWin;

{$IFDEF MSWINDOWS}
    function OnDeactivate: TExecutaClickWin;
    procedure SetItem(const Value: TExecutaClickWin); overload;
    procedure SetBack(const Value: TExecutaClickWin); overload;
    procedure SetDeactivate(const Value: TExecutaClickWin);
{$ELSE}
    function OnDeactivate: TExecutaClickMobile;
    procedure SetItem(const Value: TExecutaClickMobile); overload;
    procedure SetBack(const Value: TExecutaClickMobile); overload;
    procedure SetDeactivate(const Value: TExecutaClickMobile);
{$ENDIF}
  end;

implementation

end.
