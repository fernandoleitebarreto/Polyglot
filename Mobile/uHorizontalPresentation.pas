unit uHorizontalPresentation;

interface

uses FMX.Layouts, FMX.Objects, FMX.Types, FMX.Graphics, System.UITypes,
  System.Classes, System.Types, System.SysUtils, FMX.Forms, FMX.StdCtrls,
  FMX.Ani, System.Actions, FMX.ActnList, FMX.Edit, System.JSON,
  System.Generics.Collections, FMX.TabControl, FMX.ImgList, System.ImageList,
  System.Net.HttpClient, FMX.Dialogs, IdHTTP, uClassMeaning, uClassMeaning.Intf,
  uEnum, UnitConstante;

type
  TMeaningArray = array of IMeaning;

  THorizontalPresentation = class
  private
    FMeaningArray: TMeaningArray;
    JsonArray: TJSONArray;
  public
    constructor Create;
    destructor Destroy; override;
    function getTotal: integer;
    function MeaningArray: TMeaningArray;
    procedure LoadFromJSON(
{$IFDEF MSWINDOWS}
      AClick: TExecutaClickWin = nil
{$ELSE}
      AClick: TExecutaClickMobile = nil
{$ENDIF}
      );
    procedure SetJson(const Value: string);
    procedure SetMeaningArray(const Value: TMeaningArray);
  end;

implementation

uses uFunctions, uClassThread, UnitDM;

constructor THorizontalPresentation.Create;
begin

end;

procedure THorizontalPresentation.LoadFromJSON(
{$IFDEF MSWINDOWS}
  AClick: TExecutaClickWin = nil
{$ELSE}
  AClick: TExecutaClickMobile = nil
{$ENDIF}
  );

var
  ArrayElement: TJSonValue;
  iContItem: integer;
begin
  iContItem := 0;

  try
    if Assigned(JsonArray) then
    begin
      for ArrayElement in JsonArray do
      begin
        Inc(iContItem);
        SetLength(FMeaningArray, iContItem);
        FMeaningArray[iContItem - 1] := TMeaning.New;
        FMeaningArray[iContItem - 1].SetCodItem
          (ArrayElement.GetValue<integer>('codItem'));
        FMeaningArray[iContItem - 1].SetEnglish
          (ArrayElement.GetValue<string>('Text.English'));
        FMeaningArray[iContItem - 1].SetFrench
          (ArrayElement.GetValue<string>('Text.French'));
        FMeaningArray[iContItem - 1].SetItalian
          (ArrayElement.GetValue<string>('Text.Italian'));
        FMeaningArray[iContItem - 1].SetPortuguese
          (ArrayElement.GetValue<string>('Text.Portuguese'));
        FMeaningArray[iContItem - 1].SetSpanish
          (ArrayElement.GetValue<string>('Text.Spanish'));

        FMeaningArray[iContItem - 1].SetAudioEnglish
          (ArrayElement.GetValue<string>('Audio.English'));
        FMeaningArray[iContItem - 1].SetAudioFrench
          (ArrayElement.GetValue<string>('Audio.French'));
        FMeaningArray[iContItem - 1].SetAudioItalian
          (ArrayElement.GetValue<string>('Audio.Italian'));
        FMeaningArray[iContItem - 1].SetAudioPortuguese
          (ArrayElement.GetValue<string>('Audio.Portuguese'));
        FMeaningArray[iContItem - 1].SetAudioSpanish
          (ArrayElement.GetValue<string>('Audio.Spanish'));

        FMeaningArray[iContItem - 1].SetItem(AClick);
        FMeaningArray[iContItem - 1].SetCountItem(iContItem);

      end; // for ArrayElement in JsonArray do

    end; // if Assigned(JsonArray) then

  except
    raise Exception.Create('Json array invalid');

  end;

end;

function THorizontalPresentation.MeaningArray: TMeaningArray;
begin
  Result := FMeaningArray;
end;

procedure THorizontalPresentation.SetJson(const Value: string);
begin
  JsonArray := TJSONObject.ParseJSONValue(Value) as TJSONArray;

end;

procedure THorizontalPresentation.SetMeaningArray(const Value: TMeaningArray);
begin
  FMeaningArray := Value;
end;

function THorizontalPresentation.getTotal: integer;
begin
  if not Assigned(JsonArray) then
    raise Exception.Create('The JsonArray has not been assigned yet!');

  Result := JsonArray.Count;
end;

destructor THorizontalPresentation.Destroy;
begin
  if Assigned(JsonArray) then
    JsonArray.DisposeOf;

  inherited;
end;

end.
