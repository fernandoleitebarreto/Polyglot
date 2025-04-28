unit uClassCountry;

interface

uses System.SysUtils, uEnum, FMX.Edit, FMX.ListBox, Classes,
  System.Character, System.UITypes;

type
  TCountry = (ctUnknow, ctUSA, ctBrazil, ctFrance, ctSpain, ctItaly);

  TCountryHelper = record helper for TCountry
    function AsByte: Byte; inline;
    function AsValue: Integer; inline;
    function ImageIndex: Integer; inline;
    function PhoneCode: string; inline;
    function FormatPhone: string; inline;
    procedure EditPhone(Obj: TObject);
    function Name: string; inline;
    function Description: string; inline;
    function Language: TNativeLanguage;
    /// <summary>Converte um número inteiro num Enum, esse número deve ser correspondente a posição dele no Vetor "AsByte" </summary>
    Class function Parse(_iCod: Integer): TCountry; static;
    /// <summary>Converte um texto num Enum, esse texto deve ser correspondente ao Value dele "AsValue" </summary>
    Class function Parse_Value(_iCod: Integer): TCountry; static;
    class procedure Popula_Combo(var pComboBox: TComboBox; pColor: TAlphaColor); static;
  end;

implementation

{ TCountryHelper }

uses uFormat, uFunctions, System.UIConsts, FMX.Types;

function TCountryHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TCountryHelper.AsValue: Integer;
begin
  case Self of
    ctUSA:
      Result := 1;
    ctBrazil:
      Result := 2;
    ctFrance:
      Result := 3;
    ctSpain:
      Result := 4;
    ctItaly:
      Result := 5;
  else
    raise Exception.CreateFmt
      ('Code [%d] has not been treated [function TCountryHelper.AsValue]',
      [Self.AsByte])
  end;
end;

function TCountryHelper.Description: string;
begin
  // Result := Format('%s %s', [Self.PhoneCode, Self.Name]);
  Result := Self.PhoneCode;
end;

class function TCountryHelper.Parse(_iCod: Integer): TCountry;
begin
  Result := TCountry(_iCod);
end;

class function TCountryHelper.Parse_Value(_iCod: Integer): TCountry;
begin
  if _iCod = 1 then
    Result := ctUSA
  else if _iCod = 2 then
    Result := ctBrazil
  else if _iCod = 3 then
    Result := ctFrance
  else if _iCod = 4 then
    Result := ctSpain
  else if _iCod = 5 then
    Result := ctItaly
  else
    raise Exception.CreateFmt
      ('Code [%d] has not been treated [function TCountryHelper.Parse_Value]',
      [_iCod]);
end;

function TCountryHelper.PhoneCode: string;
begin
  case Self of
    ctUSA:
      Result := '+01';
    ctBrazil:
      Result := '+55';
    ctFrance:
      Result := '+33';
    ctSpain:
      Result := '+34';
    ctItaly:
      Result := '+39';
  else
    raise Exception.CreateFmt
      ('Code [%d] has not been treated [function TCountryHelper.PhoneCode]',
      [Self.AsByte])
  end;
end;

class procedure TCountryHelper.Popula_Combo(var pComboBox: TComboBox; pColor: TAlphaColor);
var
  ListBox: TComboListBox;
  Item: TListBoxItem;
  ta: TCountry;
begin
  ListBox := pComboBox.ListBox;
  ListBox.BeginUpdate;
  try
    ListBox.Clear;
    for ta := low(TCountry) to high(TCountry) do
    begin
      if ta <> ctUnknow then
      begin
        Item := TListBoxItem.Create(ListBox);
        Item.Parent := ListBox;
        Item.ImageIndex := ta.ImageIndex;
        Item.Text := ta.Description;
        Item.TextSettings.FontColor := pColor;
        Item.TextSettings.Font.Size := 14;
        Item.StyledSettings := [TStyledSetting.Family, TStyledSetting.Size, TStyledSetting.Style, TStyledSetting.Other];
        Item.Size.PlatformDefault := False;
        Item.Tag := ta.AsValue;
        ListBox.AddObject(Item);
      end;
    end;
  finally
    ListBox.EndUpdate;
    ListBox.ItemIndex := 0;
  end;
end;

function TCountryHelper.FormatPhone: string;
begin
  case Self of
    ctUSA:
      Result := '### ### ####';
    ctBrazil:
      Result := '(##) #####-####';
    ctFrance:
      Result := '# ## ## ## ##';
    ctSpain:
      Result := '### ### ###';
    ctItaly:
      Result := '### ### ####';
  else
    raise Exception.CreateFmt
      ('Code [%d] has not been treated [procedure TCountryHelper.FormatPhone]',
      [Self.AsByte])
  end;
end;

function TCountryHelper.ImageIndex: Integer;
begin
  Result := Ord(Self) - 1;
end;

procedure TCountryHelper.EditPhone(Obj: TObject);
var
  texto: string;
begin
  if Obj is TEdit then
  begin
    texto := TFunctions.Mask(Self.FormatPhone, TFunctions.SomenteNumero(TEdit(Obj).Text));
    TEdit(Obj).Text := texto;
    TEdit(Obj).CaretPosition := TEdit(Obj).Text.Length;
  end;
end;

function TCountryHelper.Language: TNativeLanguage;
begin
  case Self of
    ctUSA:
      Result := TNativeLanguage.nlEnglish;
    ctBrazil:
      Result := TNativeLanguage.nlPortuguese;
    ctFrance:
      Result := TNativeLanguage.nlFrench;
    ctSpain:
      Result := TNativeLanguage.nlSpanish;
    ctItaly:
      Result := TNativeLanguage.nlItalian;
  else
    raise Exception.CreateFmt
      ('Code [%d] has not been treated [function TCountryHelper.Language]',
      [Self.AsByte])
  end;
end;

function TCountryHelper.Name: string;
begin
  case Self of
    ctUSA:
      Result := 'USA';
    ctBrazil:
      Result := 'Brasil';
    ctFrance:
      Result := 'France';
    ctSpain:
      Result := 'España';
    ctItaly:
      Result := 'Italia';
  else
    raise Exception.CreateFmt
      ('Code [%d] has not been treated [function TCountryHelper.Name]',
      [Self.AsByte])
  end;
end;

end.
