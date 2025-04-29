{
  Automate Save State Feature in Firemonkey
  by
  Daniele Spinetti
  published
  October 9, 2014
  http://www.danielespinetti.it/2014/10/automate-save-state-feature-in.html
  Modifications by Jim McKeeth
  http://embt.co/sprint-savestate
}
unit SaveStateHelper;

interface

uses System.IOUtils, IdGlobalProtocols, FMX.Forms, System.IniFiles,
  CCR.PrefsIniFile
{$IFDEF ANDROID}
    , FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes, idUri,
  Androidapi.IOUtils, Androidapi.Helpers,
  Androidapi.JNI.App, Androidapi.JNI.Telephony, Androidapi.JNI.Provider,
  Androidapi.JNIBridge, Androidapi.JNI, Androidapi.JNI.Dalvik
{$ENDIF ANDROID}
{$IFDEF MSWINDOWS }
    , WinAPI.ShellApi, WinAPI.Windows
{$ENDIF}
    ;

type

  TSaveStateHelper = class helper for TCustomForm
  public const
    DATA_FIELD = 'data';
    GENERAL = 'General';
    THEME = 'Theme';
    function LoadState(Header, Detail: string): string;
    procedure SaveState(Header, Detail: string; Value: string = '');
    procedure SaveFormState;
    procedure LoadFormState;
  end;

procedure LoadFormStateHelper(Self: TCustomForm);
procedure SaveFormStateHelper(Self: TCustomForm);

implementation

uses System.JSON, FMX.Types, System.Classes, System.SysUtils;

procedure LoadFormStateHelper(Self: TCustomForm);
begin
  Self.LoadFormState;
end;

procedure SaveFormStateHelper(Self: TCustomForm);
begin
  Self.SaveFormState;
end;

{ TSaveStateHelper }

procedure TSaveStateHelper.SaveState(Header, Detail: string;
  Value: string = '');
var
  Settings: TCustomIniFile;
begin
  Settings := CreateUserPreferencesIniFile;
  try
    Settings.WriteString(Header, Detail, Value);
  finally
    if Assigned(Settings) then
      Settings.Free;
  end;
end;

function TSaveStateHelper.LoadState(Header, Detail: string): string;
var
  Settings: TCustomIniFile;
begin
  Settings := CreateUserPreferencesIniFile;
  try
    Result := Settings.ReadString(Header, Detail, '');
  finally
    if Assigned(Settings) then
      Settings.Free;
  end;
end;

procedure TSaveStateHelper.LoadFormState;
var
  Settings: TCustomIniFile;
  FormJSONObject: TJSONObject;
  I: Integer;
  FMXObj: TFmxObject;
  FMXJObj: TJSONObject;
begin
  try
    Settings := CreateUserPreferencesIniFile;
    // Recover previously typed values in all control.
    FormJSONObject := TJSONObject.ParseJSONValue(Settings.ReadString('General',
      'SaveState', '{}')) as TJSONObject;

    try

      if FormJSONObject = nil then
        exit;

      for I := 0 to Self.ComponentCount - 1 do
      begin
        if not(Self.Components[I] is TFmxObject) then
          continue;
        FMXObj := Self.Components[I] as TFmxObject;
        FMXJObj := FormJSONObject.Values[FMXObj.Name] as TJSONObject;

        if FMXJObj = nil then
          continue;

        case FMXObj.Data.Kind of
          tkUnknown:
            ;
          tkInteger:
            FMXObj.Data := (FMXJObj.GetValue(DATA_FIELD) as TJSONNumber).AsInt;
          tkChar:
            ;
          tkEnumeration:
            if FMXJObj.GetValue(DATA_FIELD) is TJSONTrue then
              FMXObj.Data := true
            else
              FMXObj.Data := false;
          tkFloat:
            FMXObj.Data :=
              (FMXJObj.GetValue(DATA_FIELD) as TJSONNumber).AsDouble;
          tkString, tkUString, tkLString, tkWString:
            FMXObj.Data := (FMXJObj.GetValue(DATA_FIELD) as TJSONString).Value;
          tkSet:
            ;
          tkClass:
            ;
          tkMethod:
            ;
          tkWChar:
            ;
          tkVariant:
            ;
          tkArray:
            ;
          tkRecord:
            ;
          tkInterface:
            ;
          tkInt64:
            FMXObj.Data :=
              (FMXJObj.GetValue(DATA_FIELD) as TJSONNumber).AsInt64;
          tkDynArray:
            ;
          tkClassRef:
            ;
          tkPointer:
            ;
          tkProcedure:
            ;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create('Error Loading Data: ' + E.Message);
    end;
  finally
    if Assigned(Settings) then
      Settings.Free;
    if Assigned(FormJSONObject) then
      FormJSONObject.Free;
  end;

end;

procedure TSaveStateHelper.SaveFormState;
var
  Settings: TCustomIniFile;
  FormJSONObject: TJSONObject;
  I: Integer;
  FMXObj: TFmxObject;
  FMXJObj: TJSONObject;
begin
  FormJSONObject := TJSONObject.Create;
  try
    try
      for I := 0 to Self.ComponentCount - 1 do
      begin
        if not(Self.Components[I] is TFmxObject) then
          continue;
        FMXObj := Self.Components[I] as TFmxObject;
        FMXJObj := TJSONObject.Create;

        case FMXObj.Data.Kind of
          tkUnknown:
            ;
          tkInteger:
            FMXJObj.AddPair(DATA_FIELD,
              TJSONNumber.Create(FMXObj.Data.AsInteger));
          tkChar:
            ;
          tkEnumeration:
            if FMXObj.Data.AsBoolean then
              FMXJObj.AddPair(DATA_FIELD, TJSONTrue.Create)
            else
              FMXJObj.AddPair(DATA_FIELD, TJSONFalse.Create);
          tkFloat:
            FMXJObj.AddPair(DATA_FIELD,
              TJSONNumber.Create(FMXObj.Data.AsExtended));
          tkString, tkUString, tkLString, tkWString:
            FMXJObj.AddPair(DATA_FIELD, FMXObj.Data.AsString);
          tkSet:
            ;
          tkClass:
            ;
          tkMethod:
            ;
          tkWChar:
            ;
          tkVariant:
            ;
          tkArray:
            ;
          tkRecord:
            ;
          tkInterface:
            ;
          tkInt64:
            FMXJObj.AddPair(DATA_FIELD,
              TJSONNumber.Create(FMXObj.Data.AsInt64));
          tkDynArray:
            ;
          tkClassRef:
            ;
          tkPointer:
            ;
          tkProcedure:
            ;
        end;
        FormJSONObject.AddPair(FMXObj.Name, FMXJObj)
      end;

      Settings := CreateUserPreferencesIniFile;
      Settings.WriteString('General', 'SaveState', FormJSONObject.ToJSON);
    except
    end;
  finally
    if Assigned(Settings) then
      Settings.Free;
    if Assigned(FormJSONObject) then
      FormJSONObject.Free;
  end;

end;

end.
