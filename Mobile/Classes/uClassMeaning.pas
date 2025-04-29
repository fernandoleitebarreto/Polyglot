unit uClassMeaning;

interface

uses uClassMeaning.Intf, uClassCategory, uClassCategory.Intf,
  uClassUser, uClassParametro, System.Types, System.Classes,
  System.IOUtils, FMX.Forms, uEnum, uEnum.Helper, uClassTexts, UnitConstante;

type
  TMeaning = class(TInterfacedObject, IMeaning)
  private
    FArrayLanguages: TNativeLanguageArray;
    FLastLanguage: TNativeLanguage;
    FUser: TUsuario;
    FParametro: TParametro;
    FTemp: TStringList;
    FCodLng: Integer;
    FCodSubCategory: Integer;
    FEnableAds: Boolean;
    FTypeCateg: TCategorySelected;
    FCategory: ICategory;
    FCodItem: Integer;
    FCurrentCategIndex: Integer;
    FCountItem: Integer;
    FPortuguese: String;
    FSpanish: String;
    FFrench: String;
    FItalian: String;
    FEnglish: String;

    FAudioPortuguese: String;
    FAudioSpanish: String;
    FAudioFrench: String;
    FAudioEnglish: String;
    FAudioItalian: String;

    FTapItem: TExecutaClickMobile;
    FClickItem: TExecutaClickWin;

    FTapBack: TExecutaClickMobile;
    FClickBack: TExecutaClickWin;

{$IFDEF MSWINDOWS}
    FDeactivate: TExecutaClickWin;
{$ELSE}
    FDeactivate: TExecutaClickMobile;
{$ENDIF}
    FAutomaticLogin: Boolean;
    FCloseApplication: Boolean;

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
    function User: TUsuario;
    function Parametro: TParametro;

    function AutomaticLogin: Boolean;
    function CloseApplication: Boolean;
    function AccessBlock: Boolean;
    function CodItem: Integer;
    function CodSubCategory: Integer;
    function CountItem: Integer;
    procedure SetCountItem(Value: Integer);
    procedure ResetValues;

    function English: String;
    function Portuguese: String;
    function French: String;
    function Spanish: String;
    function Italian: String;

    function AudioEnglish: String;
    function AudioPortuguese: String;
    function AudioFrench: String;
    function AudioSpanish: String;
    function AudioItalian: String;
    function Audio(Language: TNativeLanguage): String;

    function NativeLanguage: TNativeLanguage;
    function Category: ICategory;
    function TypeCateg: TCategorySelected;
    function Temp: TStringList;
    function EnableAds: Boolean;
    function CurrentCategIndex: Integer;
    function CodLng: Integer;
    function ArrayLanguages: TNativeLanguageArray;
    function TermsAndConditions: string;
    function PrivacyPolicy: string;

    function getFullDirectory(Language: TNativeLanguage): String;
    function getUrl_PathS3(Language: TNativeLanguage): String;
    function getDirectory(Language: TNativeLanguage): String;
    function getText(Language: TNativeLanguage): String;
    function getLanguage(Language: TNativeLanguage): String;
    function getNativeLanguage: String;
    function getTranslation(Cod: Integer = 0): TNativeLanguage;

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
    procedure SetNativeLanguage(const Value: Integer); overload;
    procedure SetNativeLanguage(const Value: TNativeLanguage); overload;
    procedure SetCategory(const Value: ICategory);
    procedure SetTypeCateg(const Value: TCategorySelected);
    procedure SetAudioNative(Value: String);
    procedure SetAudioEnglish(const Value: String);
    procedure SetAudioPortuguese(const Value: String);
    procedure SetAudioFrench(const Value: String);
    procedure SetAudioSpanish(const Value: String);
    procedure SetAudioItalian(const Value: String);
    procedure SetParametro(const Value: TParametro);
    procedure SetEnableAds(const Value: Boolean);
    procedure SetCurrentCategIndex(const Value: Integer);
    procedure SetCodLng(const Value: Integer);
    procedure SetArrayLanguages(const Value: TNativeLanguageArray);
    procedure AddLanguage(Language: TNativeLanguage);
    procedure RemoveLastLanguage;
  public
    constructor Create;
    class function New: IMeaning;
    destructor Destroy; override;

  end;

implementation

uses
  System.SysUtils, FMX.Dialogs, uFunctions;

{ TMeaning }

function TMeaning.getDirectory(Language: TNativeLanguage): String;
begin
  case Language of
    nlEnglish:
      Result := TPath.Combine('Audio', 'ENG');
    nlPortuguese:
      Result := TPath.Combine('Audio', 'PTB');
    nlFrench:
      Result := TPath.Combine('Audio', 'FRN');
    nlSpanish:
      Result := TPath.Combine('Audio', 'SPN');
    nlItalian:
      Result := TPath.Combine('Audio', 'ITA');
  else
    raise Exception.CreateFmt('Língua %d não tratada [TMeaning.getDirectory]',
      [FUser.NativeLanguage.AsByte])
  end;

  // Result := TPath.Combine(Result, 'mp3');
end;

{$IFDEF MSWINDOWS}

function TMeaning.OnDeactivate: TExecutaClickWin;
begin
  Result := FDeactivate;
end;

procedure TMeaning.SetItem(const Value: TExecutaClickWin);
begin
  FClickItem := Value;
end;

procedure TMeaning.SetBack(const Value: TExecutaClickWin);
begin
  FClickBack := Value;
end;

procedure TMeaning.SetDeactivate(const Value: TExecutaClickWin);
begin
  FDeactivate := Value;
end;

{$ELSE}

function TMeaning.OnDeactivate: TExecutaClickMobile;
begin
  Result := FDeactivate;
end;

procedure TMeaning.SetItem(const Value: TExecutaClickMobile);
begin
  FTapItem := Value;
end;

procedure TMeaning.SetBack(const Value: TExecutaClickMobile);
begin
  FTapBack := Value;
end;

procedure TMeaning.SetDeactivate(const Value: TExecutaClickMobile);
begin
  FDeactivate := Value;
end;

{$ENDIF}

class function TMeaning.New: IMeaning;
begin
  Result := Self.Create;
end;

constructor TMeaning.Create;
begin
  FCategory := TCategory.New;
  FParametro := TParametro.Create;
  FUser := TUsuario.Create;
  FTemp := TStringList.Create;
  FEnableAds := True;
  FTypeCateg := csWord;
  FCurrentCategIndex := csWord.Beginner;
  Self.ResetValues;
end;

destructor TMeaning.Destroy;
begin
  if Assigned(FParametro) then
    FreeAndNil(FParametro);

  if Assigned(FUser) then
    FreeAndNil(FUser);

  if Assigned(FTemp) then
    FreeAndNil(FTemp);

  inherited;
end;

function TMeaning.TapBack: TExecutaClickMobile;
begin
  Result := FTapBack;
end;

function TMeaning.ClickBack: TExecutaClickWin;
begin
  Result := FClickBack;
end;

function TMeaning.TapItem: TExecutaClickMobile;
begin
  Result := FTapItem;
end;

function TMeaning.ClickItem: TExecutaClickWin;
begin
  Result := FClickItem;
end;

function TMeaning.CloseApplication: Boolean;
begin
  Result := FCloseApplication;
end;

function TMeaning.getFullDirectory(Language: TNativeLanguage): String;
begin
  Result := TPath.Combine(Self.getDirectory(Language), Self.Audio(Language));
end;

function TMeaning.getUrl_PathS3(Language: TNativeLanguage): String;
begin
  Result := TPath.Combine(TFunctions.getPathS3, getFullDirectory(Language));
end;

function TMeaning.getText(Language: TNativeLanguage): String;
begin
  case Language of
    nlEnglish:
      Result := English;
    nlPortuguese:
      Result := Portuguese;
    nlFrench:
      Result := French;
    nlSpanish:
      Result := Spanish;
    nlItalian:
      Result := Italian;
  else
    raise Exception.CreateFmt('Língua %d não tratada [TMeaning.getText]',
      [Language.AsByte])
  end;
end;

function TMeaning.getTranslation(Cod: Integer): TNativeLanguage;
  procedure GetNextLanguage;
  begin
    if FCodLng >= nlAll.AsByte then
      FCodLng := nlEnglish.AsByte
    else
      Inc(FCodLng);

  end;

begin
  if Cod > 0 then
    FCodLng := Cod;

  GetNextLanguage;

  while (TNativeLanguage.Parse(FCodLng) in FArrayLanguages) do
  begin
    GetNextLanguage;
  end;

  /// <p> 1 - English </p>
  /// <p> 2 - Portuguese </p>
  /// <p> 3 - French </p>
  /// <p> 4 - Spanish </p>
  /// <p> 5 - Italian </p>

  if FCodLng >= nlAll.AsByte then
    FCodLng := nlEnglish.AsByte;

  Result := TNativeLanguage.Parse(FCodLng);
end;

function TMeaning.ArrayLanguages: TNativeLanguageArray;
begin
  Result := FArrayLanguages;
end;

function TMeaning.AccessBlock: Boolean;
begin
  Result := FUser.Id_Usuario = 0;

end;

procedure TMeaning.AddLanguage(Language: TNativeLanguage);
begin
  FArrayLanguages := FArrayLanguages + [Language];
  FLastLanguage := Language;
end;

procedure TMeaning.RemoveLastLanguage;
begin
  FArrayLanguages := FArrayLanguages - [FLastLanguage];
end;

function TMeaning.getLanguage(Language: TNativeLanguage): String;
var
  FText: IText;
begin
  FText := TText.New(NativeLanguage);
  case Language of
    nlEnglish:
      Result := FText.getTextEnglish;
    nlPortuguese:
      Result := FText.getTextPortuguese;
    nlFrench:
      Result := FText.getTextFrench;
    nlSpanish:
      Result := FText.getTextSpanish;
    nlItalian:
      Result := FText.getTextItalian;
    nlAll:
      Result := FText.getTextAll;
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TMeaning.getNativeLanguage: String;
begin
  Result := Self.getText(FUser.NativeLanguage);
end;

function TMeaning.Category: ICategory;
begin
  FCategory.SetNativeLanguage(FUser.NativeLanguage);
  Result := FCategory;
end;

function TMeaning.TypeCateg: TCategorySelected;
begin
  Result := FTypeCateg;
end;

function TMeaning.NativeLanguage: TNativeLanguage;
begin
  Result := FUser.NativeLanguage;
end;

function TMeaning.CodItem: Integer;
begin
  Result := FCodItem;
end;

function TMeaning.CodLng: Integer;
begin
  Result := FCodLng;
end;

function TMeaning.CodSubCategory: Integer;
begin
  Result := FCodSubCategory;
end;

function TMeaning.CountItem: Integer;
begin
  Result := FCountItem;
end;

function TMeaning.English: String;
begin
  Result := FEnglish;
end;

function TMeaning.Parametro: TParametro;
begin
  Result := FParametro;
end;

function TMeaning.Portuguese: String;
begin
  Result := FPortuguese;
end;

function TMeaning.PrivacyPolicy: string;
begin
  case NativeLanguage of
    nlEnglish:
      Result := Parametro.PrivacyPolicy_ENG;
    nlPortuguese:
      Result := Parametro.PrivacyPolicy_PTB;
    nlFrench:
      Result := Parametro.PrivacyPolicy_FRN;
    nlSpanish:
      Result := Parametro.PrivacyPolicy_SPN;
    nlItalian:
      Result := Parametro.PrivacyPolicy_ITA;
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TMeaning.French: String;
begin
  Result := FFrench;
end;

function TMeaning.CurrentCategIndex: Integer;
begin
  Result := FCurrentCategIndex;
end;

function TMeaning.Spanish: String;
begin
  Result := FSpanish;
end;

function TMeaning.Temp: TStringList;
begin
  Result := FTemp;
end;

function TMeaning.TermsAndConditions: string;
begin
  case NativeLanguage of
    nlEnglish:
      Result := Parametro.TermsConditions_ENG;
    nlPortuguese:
      Result := Parametro.TermsConditions_PTB;
    nlFrench:
      Result := Parametro.TermsConditions_FRN;
    nlSpanish:
      Result := Parametro.TermsConditions_SPN;
    nlItalian:
      Result := Parametro.TermsConditions_ITA;
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TMeaning.User: TUsuario;
begin
  Result := FUser;
end;

function TMeaning.Italian: String;
begin
  Result := FItalian;
end;

procedure TMeaning.SetTextNative(Value: String);
begin
  case NativeLanguage of
    nlEnglish:
      SetEnglish(Value);
    nlPortuguese:
      SetPortuguese(Value);
    nlFrench:
      SetFrench(Value);
    nlSpanish:
      SetSpanish(Value);
    nlItalian:
      SetItalian(Value);
  ELSE
    raise Exception.CreateFmt('Língua %d não tratada [TMeaning.SetTextNative]',
      [NativeLanguage.AsByte])
  end;
end;

procedure TMeaning.SetTypeCateg(const Value: TCategorySelected);
begin
  FTypeCateg := Value;
end;

procedure TMeaning.SetNativeLanguage(const Value: Integer);
begin
  FUser.NativeLanguage := TNativeLanguage.Parse_Value(Value);
end;

procedure TMeaning.SetNativeLanguage(const Value: TNativeLanguage);
begin
  FUser.NativeLanguage := Value;
end;

procedure TMeaning.SetCategory(const Value: ICategory);
begin
  FCategory := Value;
end;

procedure TMeaning.SetCloseApplication(const Value: Boolean);
begin
  FCloseApplication := Value;
end;

procedure TMeaning.SetCodItem(const Value: Integer);
begin
  FCodItem := Value;
end;

procedure TMeaning.SetCodLng(const Value: Integer);
begin
  FCodLng := Value;
end;

procedure TMeaning.SetCodSubCategory(const Value: Integer);
begin
  FCodSubCategory := Value;
end;

procedure TMeaning.SetCountItem(Value: Integer);
begin
  FCountItem := Value;
end;

procedure TMeaning.SetCurrentCategIndex(const Value: Integer);
begin
  FCurrentCategIndex := Value;
end;

procedure TMeaning.SetEnglish(const Value: String);
begin
  FEnglish := Value;
end;

procedure TMeaning.SetParametro(const Value: TParametro);
begin
  FParametro := Value;
end;

procedure TMeaning.SetEnableAds(const Value: Boolean);
begin
  FEnableAds := Value;
end;

procedure TMeaning.SetPortuguese(const Value: String);
begin
  FPortuguese := Value;
end;

procedure TMeaning.SetFrench(const Value: String);
begin
  FFrench := Value;
end;

procedure TMeaning.SetSpanish(const Value: String);
begin
  FSpanish := Value;
end;

procedure TMeaning.SetItalian(const Value: String);
begin
  FItalian := Value;
end;

procedure TMeaning.SetAudioNative(Value: String);
begin
  case NativeLanguage of
    nlEnglish:
      SetAudioEnglish(NativeLanguage.Field + '_' + Value);
    nlPortuguese:
      SetAudioPortuguese(NativeLanguage.Field + '_' + Value);
    nlFrench:
      SetAudioFrench(NativeLanguage.Field + '_' + Value);
    nlSpanish:
      SetAudioSpanish(NativeLanguage.Field + '_' + Value);
    nlItalian:
      SetAudioItalian(NativeLanguage.Field + '_' + Value);
  ELSE
    raise Exception.CreateFmt('Língua %d não tratada [TMeaning.SetAudioNative]',
      [NativeLanguage.AsByte])
  end;
end;

procedure TMeaning.SetArrayLanguages(const Value: TNativeLanguageArray);
begin
  FArrayLanguages := Value;
end;

procedure TMeaning.SetAudioEnglish(const Value: String);
begin
  FAudioEnglish := Value;
end;

procedure TMeaning.SetAudioPortuguese(const Value: String);
begin
  FAudioPortuguese := Value;
end;

procedure TMeaning.SetAudioFrench(const Value: String);
begin
  FAudioFrench := Value;
end;

procedure TMeaning.SetAudioSpanish(const Value: String);
begin
  FAudioSpanish := Value;
end;

procedure TMeaning.SetAutomaticLogin(const Value: Boolean);
begin
  FAutomaticLogin := Value;
end;

procedure TMeaning.SetAudioItalian(const Value: String);
begin
  FAudioItalian := Value;
end;

// audio
function TMeaning.AudioEnglish: String;
begin
  Result := FAudioEnglish;
end;

function TMeaning.AudioPortuguese: String;
begin
  Result := FAudioPortuguese;
end;

function TMeaning.AudioFrench: String;
begin
  Result := FAudioFrench;
end;

function TMeaning.AudioSpanish: String;
begin
  Result := FAudioSpanish;
end;

function TMeaning.AutomaticLogin: Boolean;
begin
  Result := FAutomaticLogin;
end;

function TMeaning.EnableAds: Boolean;
begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  Result := FEnableAds;
{$ELSE}
  Result := False;
{$ENDIF}
end;

function TMeaning.AudioItalian: String;
begin
  Result := FAudioItalian;
end;

function TMeaning.Audio(Language: TNativeLanguage): String;
begin
  case Language of
    nlEnglish:
      Result := FAudioEnglish;
    nlPortuguese:
      Result := FAudioPortuguese;
    nlFrench:
      Result := FAudioFrench;
    nlSpanish:
      Result := FAudioSpanish;
    nlItalian:
      Result := FAudioItalian;
  else
    raise Exception.CreateFmt('Língua %d não tratada [TMeaning.AudioNative]',
      [Language.AsByte])
  end;

  if LowerCase(Copy(Result, Length(Result) - 4, 4)) <> '.mp3' then
    Result := Result + '.mp3';
end;

procedure TMeaning.ResetValues;
begin
  FCodItem := 0;
  FCodSubCategory := 0;
  FCountItem := 0;
  FPortuguese := '';
  FSpanish := '';
  FFrench := '';
  FItalian := '';
  FEnglish := '';
  FAudioPortuguese := '';
  FAudioSpanish := '';
  FAudioFrench := '';
  FAudioItalian := '';
  FAudioEnglish := '';
  FTemp.Clear;
  FCodLng := 0;
  FAutomaticLogin := False;
  FCloseApplication := False;
end;

end.
