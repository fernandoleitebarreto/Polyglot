unit uEnum.Helper;

interface

uses
  System.SysUtils, FMX.ListBox, System.UITypes, uEnum, uClassMeaning.Intf,
  FMX.Forms;

type
  TNativeLanguageHelper = record helper for TNativeLanguage
    function IsLanguage: Boolean; inline;
    function AsByte: Byte; inline;
    function AsValue: Integer; inline;
    function ImageIndex: Integer; inline;
    /// <summary>Converte um número inteiro num Enum, esse número deve ser correspondente a posição dele no Vetor "AsByte" </summary>
    Class function Parse(_iCod: Integer): TNativeLanguage; static;
    /// <summary>Converte um texto num Enum, esse texto deve ser correspondente ao Value dele "AsValue" </summary>
    Class function Parse_Value(_iCod: Integer): TNativeLanguage; static;
    Class function SQLSum(pAliasComNomeCampo, pNomeCampo: String)
      : string; static;
    function Description: string; inline;
    function Field: string; inline;
    function Sufix: string; inline;
    class procedure Popula_Combo(var pComboBox: TComboBox; pColor: TAlphaColor;
      AMeaning: IMeaning; pGameForms: TGameForms; pEnableAll: boolean = False;
      pOriginalItemIndex: boolean = False); static;
  end;

  TCategorySelectedHelper = record helper for TCategorySelected
    function AsByte: Byte; inline;
    function Beginner: Integer; inline;
    function Intermediate: Integer; inline;
    function Advanced: Integer; inline;
    Class function Parse_Value(Value: string): TCategorySelected; static;
  end;

  TProductsHelper = record helper for TProducts
    function AsByte: Byte; inline;
    function Description: string; inline;
    function ProductID: string; inline;
  end;

  TGameFormsHelper = record helper for TGameForms
    function AsByte: Byte; inline;
    function Value: string; inline;
    function FieldDataBase(ANativeLanguage: TNativeLanguage): string; inline;
    class function Parse_Value(Value: string): TGameForms; static;
    class function IsEqual(AForm, BForm: TGameForms; DefaultValue: Integer = 0)
      : Integer; static;
  end;

  TThemeHelper = record helper for TTheme
    function AsByte: Byte; inline;
    class function Parse_Value(_iCod: Integer): TTheme; static;
    function Description: string; inline;
    function ColorBackGround: TColor; inline;
    function ColorRecLanguage: TColor; inline;
    function ColorButton: TColor; inline;
    function ColorFontLabelTop: TColor; inline;
    function ColorFontLabel: TColor; inline;
    function ColorFilled: TColor; inline;
    function ItemIndex: Integer; inline;
    function AsValue: Integer; inline;
    class procedure Popula_Combo(var pComboBox: TComboBox;
      pColor: TAlphaColor); static;
  end;

implementation

uses
  System.UIConsts, FMX.Types, UnitConstante;

{ TNativeLanguageHelper }
function TNativeLanguageHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TNativeLanguageHelper.AsValue: Integer;
begin
  case Self of
    nlEnglish:
      Result := 1;
    nlPortuguese:
      Result := 2;
    nlFrench:
      Result := 3;
    nlSpanish:
      Result := 4;
    nlItalian:
      Result := 5;
    nlAll:
      Result := 6;

  else
    Result := 0;
    // raise Exception.CreateFmt
    // ('AsValue [%d] não tratado [function TNativeLanguageHelper.AsValue]',
    // [Self.AsValue])
  end;
end;

class function TNativeLanguageHelper.Parse(_iCod: Integer): TNativeLanguage;
begin
  Result := TNativeLanguage(_iCod);
end;

class function TNativeLanguageHelper.Parse_Value(_iCod: Integer)
  : TNativeLanguage;
begin
  if _iCod = 1 then
    Result := nlEnglish
  else if _iCod = 2 then
    Result := nlPortuguese
  else if _iCod = 3 then
    Result := nlFrench
  else if _iCod = 4 then
    Result := nlSpanish
  else if _iCod = 5 then
    Result := nlItalian
  else if _iCod = 6 then
    Result := nlAll
  else
    Result := nlEnglish;
  // raise Exception.CreateFmt
  // ('Valor [%s] não tratado [function TNativeLanguageHelper.Parse_Value]',
  // [_iCod]);
end;

class function TNativeLanguageHelper.SQLSum(pAliasComNomeCampo,
  pNomeCampo: String): string;
var
  ta: TNativeLanguage;
begin
  Result := Format(' case %s ', [pAliasComNomeCampo]);
  for ta := low(TNativeLanguage) to high(TNativeLanguage) do
  begin
    if ta <> nlUnknow then
      Result := Result + Format(' When %d then %s',
        [ta.AsValue, ta.Description.QuotedString]);
  end;
  Result := Result + Format(' end as %s ', [pNomeCampo]);
end;

function TNativeLanguageHelper.Description: string;
begin
  case Self of
    nlEnglish:
      Result := 'English';
    nlPortuguese:
      Result := 'Português';
    nlFrench:
      Result := 'Français';
    nlSpanish:
      Result := 'Español';
    nlItalian:
      Result := 'Italiano';
    nlAll:
      Result := 'All';
  else
    raise Exception.CreateFmt
      ('Descrição [%d] não tratado [function TNativeLanguageHelper.Descricao]',
      [AsByte]);
  end;

end;

function TNativeLanguageHelper.Field: string;
begin
  case Self of
    nlEnglish:
      Result := 'ENGLISH';
    nlPortuguese:
      Result := 'PORTUGUESE';
    nlFrench:
      Result := 'FRENCH';
    nlSpanish:
      Result := 'SPANISH';
    nlItalian:
      Result := 'ITALIAN';
  else
    raise Exception.CreateFmt
      ('Field [%s] não tratado [function TNativeLanguageHelper.Descricao]',
      [AsValue.ToString]);
  end;
end;

function TNativeLanguageHelper.Sufix: string;
begin
  case Self of
    nlEnglish:
      Result := 'ENG';
    nlPortuguese:
      Result := 'PTB';
    nlFrench:
      Result := 'FRN';
    nlSpanish:
      Result := 'SPN';
    nlItalian:
      Result := 'ITA';
  else
    raise Exception.CreateFmt
      ('Sufix [%s] não tratado [function TNativeLanguageHelper.Descricao]',
      [AsValue.ToString]);
  end;
end;

function TNativeLanguageHelper.ImageIndex: Integer;
begin
  case Self of
    nlEnglish:
      Result := 3;
    nlPortuguese:
      Result := 4;
    nlFrench:
      Result := 5;
    nlSpanish:
      Result := 6;
    nlItalian:
      Result := 7;
    nlAll:
      Result := 14;
  else
    Result := -1;
    // raise Exception.CreateFmt
    // ('AsValue [%d] não tratado [function TNativeLanguageHelper.AsValue]',
    // [Self.AsValue])
  end;
end;

function TNativeLanguageHelper.IsLanguage: Boolean;
begin
  Result := NOT (Self in [nlUnknow, nlAll]);
end;

class procedure TNativeLanguageHelper.Popula_Combo(var pComboBox: TComboBox;
  pColor: TAlphaColor; AMeaning: IMeaning; pGameForms: TGameForms;
  pEnableAll: boolean = False; pOriginalItemIndex: boolean = False);
var
  ListBox: TComboListBox;
  Item: TListBoxItem;
  ta: TNativeLanguage;
  _percent: Double;
  OriginalItemIndex, ItemIndex: Integer;
  ItemIndexSet: boolean;
begin
  OriginalItemIndex := pComboBox.ItemIndex;
  ListBox := pComboBox.ListBox;
  ListBox.Clear;
  _percent := 0;
  ItemIndex := 0;
  ListBox.BeginUpdate;
  try
    ItemIndexSet := False;
    for ta := low(TNativeLanguage) to high(TNativeLanguage) do
    begin
      if ((ta <> nlUnknow) and (ta <> nlAll) and (ta <> AMeaning.NativeLanguage)
        ) or (pEnableAll and (ta = nlAll)) then
      begin
        Item := TListBoxItem.Create(ListBox);
        Item.Parent := ListBox;
        Item.ImageIndex := ta.ImageIndex;
        if (ta <> nlAll) and (pGameForms <> fmUnknow) and
          (AMeaning.User.Id_Usuario > 0) then
        begin
          _percent := AMeaning.Category.percent_complete(pGameForms, ta);
          if (_percent = 100) and (not ItemIndexSet) then
            Inc(ItemIndex)
          else
            ItemIndexSet := True;

          Item.Enabled := _percent < 100;
          Item.Text := Format('%s     %2.f', [AMeaning.getLanguage(ta),
            _percent]) + '%'
        end
        else
          Item.Text := AMeaning.getLanguage(ta);

        Item.TextSettings.FontColor := pColor;
        Item.TextSettings.Font.Size := 14;
        Item.StyledSettings := [TStyledSetting.Family, TStyledSetting.Size,
          TStyledSetting.Style, TStyledSetting.Other];
        Item.Size.PlatformDefault := False;

        Item.Tag := ta.AsValue;
        ListBox.AddObject(Item);
      end;

    end;
  finally
    ListBox.EndUpdate;
    ListBox.RealignContent;
    if pOriginalItemIndex then
      pComboBox.ItemIndex := OriginalItemIndex
    else if ItemIndex < (High(TNativeLanguage).AsByte - 2) then
      pComboBox.ItemIndex := ItemIndex
    else
      pComboBox.ItemIndex := (High(TNativeLanguage).AsByte - 2);
  end;

end;

{ TCategorySelectedHelper }

function TCategorySelectedHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TCategorySelectedHelper.Beginner: Integer;
begin
  case Self of
    csWord:
      Result := 3;
    csPhrase:
      Result := 0;
  else
    raise Exception.CreateFmt('Level [%d] not specifield', [Self.AsByte]);
  end;
end;

function TCategorySelectedHelper.Intermediate: Integer;
begin
  case Self of
    csWord:
      Result := 4;
    csPhrase:
      Result := 1;
  else
    raise Exception.CreateFmt('Level [%d] not specifield', [Self.AsByte]);
  end;
end;

class function TCategorySelectedHelper.Parse_Value(Value: string)
  : TCategorySelected;
begin
  if Value = 'W' then
    Result := csWord
  else if Value = 'P' then
    Result := csPhrase
  else
    Result := csUnknow;
end;

function TCategorySelectedHelper.Advanced: Integer;
begin
  case Self of
    csWord:
      Result := 5;
    csPhrase:
      Result := 2;
  else
    raise Exception.CreateFmt('Level [%d] not specifield', [Self.AsByte]);
  end;
end;

{ TProductsHelper }

function TProductsHelper.AsByte: Byte;
begin
  Result := Ord(Self);

end;

function TProductsHelper.Description: string;
begin
  case Self of
    prNoAdsID:
      Result := 'No ADS';
    prPhrase:
      Result := 'Phrases';
  else
    raise Exception.CreateFmt('Product [%d] not specifield', [Self.AsByte]);
  end;

end;

function TProductsHelper.ProductID: string;
begin
  case Self of
    prNoAdsID:
      Result := 'com.apppolyglot.polyglot.capitals.noads.demo';
    prPhrase:
      Result := 'com.apppolyglot.polyglot.capitals.freephrase.demo';
  else
    raise Exception.CreateFmt('Product [%d] not specifield', [Self.AsByte]);
  end;
end;

{ TGameFormsHelper }

function TGameFormsHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TGameFormsHelper.FieldDataBase(ANativeLanguage
  : TNativeLanguage): string;
begin
  Result := '';
  case Self of
    fmCompleteWords:
      Result := 'COMPL_' + ANativeLanguage.Field;
    fmMemorize:
      Result := 'MEMORIZE_' + ANativeLanguage.Field;
    fmSelectWords:
      Result := 'SELECT_' + ANativeLanguage.Field;
  else
    Result := '';
  end;
end;

class function TGameFormsHelper.IsEqual(AForm, BForm: TGameForms;
  DefaultValue: Integer = 0): Integer;
begin
  if AForm = BForm then
    Result := 1
  else
    Result := DefaultValue;
end;

class function TGameFormsHelper.Parse_Value(Value: string): TGameForms;
begin
  if Value = 'C' then
    Result := fmCompleteWords
  else if Value = 'M' then
    Result := fmMemorize
  else if Value = 'S' then
    Result := fmSelectWords
  else
    Result := fmUnknow;
end;

function TGameFormsHelper.Value: string;
begin
  case Self of
    fmCompleteWords:
      Result := 'C';
    fmMemorize:
      Result := 'M';
    fmSelectWords:
      Result := 'S';
  else
    Result := '';
  end;
end;

{ TThemeHelper }

function TThemeHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TThemeHelper.AsValue: Integer;
begin
  case Self of
    thDark:
      Result := 1;
    thLight:
      Result := 2;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ColorBackGround: TColor;
begin
  case Self of
    thDark:
      Result := $FF13192E;
    thLight:
      Result := $FF35363A;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ColorRecLanguage: TColor;
begin
  case Self of
    thDark:
      Result := $FF13213F;
    thLight:
      Result := $FF393F44;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ColorButton: TColor;
begin
  case Self of
    thDark, thLight:
      Result := $FFEABC1B;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ColorFilled: TColor;
begin
  case Self of
    thDark, thLight:
      Result := $FFD3D3D3;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ColorFontLabel: TColor;
begin
  case Self of
    thDark, thLight:
      Result := $FF353535;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ColorFontLabelTop: TColor;
begin
  case Self of
    thDark, thLight:
      Result := $FFB0BAC9;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.Description: string;
begin
  case Self of
    thDark:
      Result := 'Dark';
    thLight:
      Result := 'Light';
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

function TThemeHelper.ItemIndex: Integer;
begin
  Result := Self.AsValue - 1;
end;

class procedure TThemeHelper.Popula_Combo(var pComboBox: TComboBox;
  pColor: TAlphaColor);
var
  ListBox: TComboListBox;
  Item: TListBoxItem;
  ta: TTheme;
begin
  ListBox := pComboBox.ListBox;
  ListBox.BeginUpdate;
  try
    ListBox.Clear;
    for ta := low(TTheme) to high(TTheme) do
    begin
      if ta <> thUnknow then
      begin
        Item := TListBoxItem.Create(ListBox);
        Item.Parent := ListBox;
        Item.Text := ta.Description;
        Item.TextSettings.FontColor := pColor;
        Item.TextSettings.Font.Size := 14;
        Item.StyledSettings := [TStyledSetting.Family, TStyledSetting.Size,
          TStyledSetting.Style, TStyledSetting.Other];
        Item.Size.PlatformDefault := False;
        Item.Tag := ta.AsValue;
        ListBox.AddObject(Item);
      end;
    end;
  finally
    ListBox.EndUpdate;
    pComboBox.ItemIndex := CurrentTheme.ItemIndex;
  end;
end;

class function TThemeHelper.Parse_Value(_iCod: Integer): TTheme;
begin
  case _iCod of
    1:
      Result := thDark;
    2:
      Result := thLight;
  else
    raise Exception.Create('Sorry, something went wrong. Error: Unknown Theme');
  end;
end;

end.
