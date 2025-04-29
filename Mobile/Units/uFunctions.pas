unit uFunctions;

interface

uses
  System.SysUtils, FMX.Edit, System.MaskUtils, System.Character,
  System.Types, System.UITypes, System.Classes, System.Zip,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox, FMX.Ani, FMX.Gestures, IdURI, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI, Soap.EncdDecd, Skia, Skia.FMX,
{$IFDEF ANDROID}
  AndroidApi.JNI.JavaTypes, AndroidApi.JNI.Telephony, AndroidApi.JNIBridge,
  AndroidApi.JNI.GraphicsContentViewText, AndroidApi.JNI.Net, AndroidApi.JNI.Os,
  AndroidApi.IOUtils, AndroidApi.JNI.App, AndroidApi.Helpers,
  FMX.Platform.Android, FMX.Helpers.Android,
{$ENDIF}
  FMX.ImgList, FMX.Platform, FMX.MobilePreview, FMX.TextLayout,
  FMX.ListView.Types,
  FMX.Graphics, Data.DB, DateUtils, HTTPApp, IdHTTP,
  System.Net.HttpClient, System.NetEncoding, System.IOUtils,
  IdSSLOpenSSLHeaders, XMLDoc, XMLIntf;

type
  TFunctions = class
  public
    class function AppIDBanner: string;
    class function AppIDRewarded: string; static;
    class function Base64FromBlob(Blob: TBlobField): string;
    class function BlobFromBase64(base64: string): TMemoryStream;
    class function LoadBitmapFromBlob(Blob: TBlobField): TBitmap;
    class function GerarChave(): string;
    class function GetTextHeight(const D: TListItemText; const Width: single;
      const Text: string): Integer;
    class function BitmapFromBase64(const base64: string): TBitmap;
    class function Base64FromBitmap(Bitmap: TBitmap): string;
    class function StrToAvaliacao(avaliacao: string): double; static;
    class function StrToMoney(vl: string): double; static;
    class function StrToData(dt, formato: string): TDateTime; static;
    class function OccurrencesOfChar(const S: string; const C: char)
      : Integer; static;
    class function getPathS3: string;
    class function getPathAudio: string;
    class function getPathImage: string;
    class procedure ReadImageFromWeb(image: TBitmap; url: string); overload;
    class procedure ReadImageFromWeb(image: TImage; url: string); overload;
    class function CheckInternet: Boolean;
    class function SendSMS(msg, number: string): Boolean;
    class function AmazonConnectionInfo: TAmazonConnectionInfo;

    class function Mask(Mascara, str: string): string;
    class function FormataPeso(str: string): string; static;
    class function FormataValor(str: string): string; static;
    class function SomenteNumero(str: string): string; static;
    class function FormataData(str: string): string; static;
    class function isFilePresent(fileName: string): Boolean; static;
    class function AppURL: string;
  end;

implementation

class function TFunctions.OccurrencesOfChar(const S: string;
  const C: char): Integer;
var
  i: Integer;
begin
  Result := 0;

  for i := 1 to Length(S) do
    if S[i] = C then
      inc(Result);
end;

class function TFunctions.BitmapFromBase64(const base64: string): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
  Encoding: TBase64Encoding;
begin
  Input := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      Encoding := TBase64Encoding.Create(0);
      Encoding.Decode(Input, Output);

      Output.Position := 0;
      Result := TBitmap.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Encoding.DisposeOf;
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

(*
var
  Input: TBytes;
  Output: TMemoryStream;
  Decoder: TBase64Encoding;
begin
  Input := TNetEncoding.Base64.DecodeStringToBytes(base64);
  Output := TMemoryStream.Create;
  try
    Output.WriteBuffer(Input[0], Length(Input));
    Output.Position := 0;

    Result := TBitmap.Create;
    try
      Result.LoadFromStream(Output);
    except
      Result.Free;
      raise;
    end;
  finally
    Output.Free;
  end;

end;*)

// Converte um Bitmap em uma string no formato base64...
class function TFunctions.Base64FromBitmap(Bitmap: TBitmap): string;
var
  Input: TBytesStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  Input := TBytesStream.Create;
  try
    Bitmap.SaveToStream(Input);
    Input.Position := 0;
    Output := TStringStream.Create('', TEncoding.ASCII);

    try
      Encoding := TBase64Encoding.Create(0);
      Encoding.Encode(Input, Output);
      Result := Output.DataString;
    finally
      Encoding.Free;
      Output.Free;
    end;

  finally
    Input.Free;
  end;
end;

class function TFunctions.BlobFromBase64(base64: string): TMemoryStream;
var
  Input: TMemoryStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  Input := TMemoryStream.Create;
  Encoding := TBase64Encoding.Create(0);
  Output := TStringStream.Create(base64, TEncoding.ASCII);
  try
    Input.Position := 0;
    Encoding.Decode(Input, Output);
    // DecodeStream(Input, Output);
    Result := Output;
  finally
    Input.DisposeOf;
    Encoding.DisposeOf;
    Output.DisposeOf;
  end;
end;

class function TFunctions.Base64FromBlob(Blob: TBlobField): string;
var
  Input: TBytesStream;
  Output: TStringStream;
  Encoding: TBase64Encoding;
begin
  Input := TBytesStream.Create;
  Encoding := TBase64Encoding.Create(0);
  Output := TStringStream.Create('', TEncoding.ASCII);
  try
    Blob.SaveToStream(Input);
    Input.Position := 0;
    Encoding.Encode(Input, Output);
    Result := Output.DataString;

  finally
    Input.DisposeOf;
    Encoding.DisposeOf;
    Output.DisposeOf;
  end;
end;

class function TFunctions.CheckInternet: Boolean;
var
  http: THTTPClient;
begin
  Result := false;
  http := THTTPClient.Create;
  try

    try
      Result := http.Head('https://google.com').StatusCode < 400;
    except
    end;
  finally
    http.DisposeOf;
  end;
end;

class function TFunctions.AmazonConnectionInfo: TAmazonConnectionInfo;
begin
  Result := TAmazonConnectionInfo.Create(nil);
  Result.AccountName := '';
  Result.AccountKey := '';
  Result.TableEndpoint := '';
  Result.QueueEndpoint := '';
  Result.StorageEndpoint := '';
  Result.Region := amzrSAEast1;
  Result.UseDefaultEndpoints := false;
end;

// Gera um código de 15 caracteres...
class function TFunctions.GerarChave(): string;
begin
  Result := FormatDateTime('yymmddhhnnsszzz', Now);
end;

// Trata conversao de string "4.5" para avaliacao Float
class function TFunctions.SendSMS(msg, number: string): Boolean;
{$IFDEF ANDROID}
var
  Attempts: Integer;
  smsManager: JSmsManager;
  num: string;
{$ENDIF}
  function RemoveAllNonNumbers(aText: string): string;
  var
    Character: char;
  begin
    for Character in aText do
      if CharInSet(Character, ['0' .. '9', '+']) then
        Result := Result + Character;
  end;

begin
  Result := false;
{$IFDEF ANDROID}
  num := RemoveAllNonNumbers(number);
  Attempts := 0;

  if Length(num) > 0 then
  begin
    try
      while (Attempts < 5) and (not Result) do
      begin
        smsManager := TJSmsManager.JavaClass.getDefault;

        smsManager.sendTextMessage(StringToJString(num), nil,
          StringToJString(msg), nil, nil);

        Result := True;
      end;
    except
      inc(Attempts);
      if Attempts = 5 then
        raise Exception.Create('Error trying to send a SMS');
    end;
  end;
{$ENDIF}
end;

class function TFunctions.StrToAvaliacao(avaliacao: string): double;
begin
  try
    avaliacao := avaliacao.Replace('.', '');
    avaliacao := avaliacao.Replace(',', '');

    Result := StrToFloat(avaliacao) / 10;
  except
    Result := 0;
  end;
end;

// Trata conversao de string monetaria "1.500,25" para valor Float
class function TFunctions.StrToMoney(vl: string): double;
begin
  try
    vl := vl.Replace('.', '');
    vl := vl.Replace(',', '');

    Result := StrToFloat(vl) / 100;
  except
    Result := 0;
  end;
end;

// Trata conversao de string para data
class function TFunctions.StrToData(dt, formato: string): TDateTime;
var
  dia, mes, ano, hora, min, seg: Word;
  pos_d, pos_m, pos_y, pos_h, pos_n, pos_s: Integer;
begin
  try
    if formato = '' then
      formato := 'dd/mm/yyyy';

    pos_d := Pos('d', formato);
    pos_m := Pos('m', formato);
    pos_y := Pos('y', formato);

    pos_h := Pos('h', formato);
    pos_n := Pos('n', formato);
    pos_s := Pos('s', formato);

    dia := Copy(dt, pos_d, OccurrencesOfChar(formato, 'd')).ToInteger;
    mes := Copy(dt, pos_m, OccurrencesOfChar(formato, 'm')).ToInteger;
    ano := Copy(dt, pos_y, OccurrencesOfChar(formato, 'y')).ToInteger;

    hora := Copy(dt, pos_h, OccurrencesOfChar(formato, 'h')).ToInteger;
    min := Copy(dt, pos_n, OccurrencesOfChar(formato, 'n')).ToInteger;
    seg := Copy(dt, pos_s, OccurrencesOfChar(formato, 's')).ToInteger;

    if pos_h > 0 then
      Result := EncodeDateTime(ano, mes, dia, hora, min, seg, 0)
    else
      Result := EncodeDate(ano, mes, dia)
  except
    Result := date;
  end;
end;

// Calcula a altura de um item TListItemText
class function TFunctions.GetTextHeight(const D: TListItemText;
  const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  // Create a TTextLayout to measure text dimensions
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      // Initialize layout parameters with those of the drawable
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    // Get layout height
    Result := Round(Layout.Height);
    // Add one em to the height
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

class function TFunctions.LoadBitmapFromBlob(Blob: TBlobField): TBitmap;
var
  ms: TMemoryStream;
begin
  Result := TBitmap.Create;
  ms := TMemoryStream.Create;
  try
    Blob.SaveToStream(ms);
    ms.Position := 0;
    Result.LoadFromStream(ms);
  finally
    ms.Free;
  end;
end;

class procedure TFunctions.ReadImageFromWeb(image: TBitmap; url: string);
var
  memStream: TMemoryStream;
  IdHTTP: TIdHTTP;
begin
  IdHTTP := TIdHTTP.Create;
  memStream := TMemoryStream.Create;
{$IFDEF ANDROID}
  IdOpenSSLSetLibPath(System.IOUtils.TPath.GetDocumentsPath);
{$ENDIF}
  try
    IdHTTP.Request.UserAgent :=
      'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
    IdHTTP.Request.Connection := 'keep-alive';
    IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
    IdHTTP.Request.Charset := 'utf-8';
    IdHTTP.Request.Pragma := 'no-cache';

    IdHTTP.Get(url, memStream);
  except
    ShowMessage('Image not found');
    memStream.Free;
    IdHTTP.Free;
    Exit;
  end;
  try
    memStream.Position := 0;
    image.LoadFromStream(memStream);
  finally
    memStream.Free;
    IdHTTP.Free;
  end;

end;

class procedure TFunctions.ReadImageFromWeb(image: TImage; url: string);
begin
  ReadImageFromWeb(image.Bitmap, url);
end;

class function TFunctions.getPathAudio: string;
begin
{$IFDEF MSWINDOWS}
  Result := TPath.Combine(GetCurrentDir, 'Audio');
{$ELSE}
  Result := TPath.GetDocumentsPath;
{$ENDIF}
end;

class function TFunctions.getPathImage: string;
begin
{$IFDEF MSWINDOWS}
  // Result := GetCurrentDir;
  Result := TPath.Combine(GetCurrentDir, 'Images');
{$ELSE}
  Result := TPath.GetDocumentsPath;
{$ENDIF}
end;

class function TFunctions.getPathS3: string;
begin
{$IFDEF MSWINDOWS}
  Result := GetCurrentDir;
{$ELSE}
  Result := 'https://polyglot.s3.us-west-004.backblazeb2.com/';
{$ENDIF}
end;

class function TFunctions.isFilePresent(fileName: string): Boolean;
var
  S4: String;
begin
  S4 := TPath.Combine(TPath.GetDocumentsPath, fileName);
  Result := FileExists(S4);
  if Result then
    ShowMessage('está no GetDocumentsPath');

  S4 := TPath.Combine(TPath.GetSharedDocumentsPath, fileName);
  Result := FileExists(S4);
  if Result then
    ShowMessage('está no GetSharedDocumentsPath');

  S4 := TPath.Combine(TPath.GetTempPath, fileName);
  Result := FileExists(S4);
  if Result then
    ShowMessage('está no GetTempPath');

  S4 := TPath.Combine(TPath.GetPublicPath, fileName);
  Result := FileExists(S4);
  if Result then
    ShowMessage('está no GetPublicPath');

end;

class function TFunctions.Mask(Mascara, str: string): string;
var
  x, p: Integer;
begin
  p := 0;
  Result := '';

  if str.IsEmpty then
    Exit;

  for x := 0 to Length(Mascara) - 1 do
  begin

    if (Mascara.Chars[x] = '#') then
    begin
      Result := Result + str.Chars[p];
      inc(p);
    end
    else
      Result := Result + Mascara.Chars[x];

    if p = Length(str) then
      break;
  end;
end;

class function TFunctions.SomenteNumero(str: string): string;
var
  x: Integer;
begin
  Result := '';
  for x := 0 to Length(str) - 1 do
    if (str.Chars[x]).IsDigit then
      Result := Result + str.Chars[x];
end;

class function TFunctions.FormataValor(str: string): string;
begin
  if str = '' then
    str := '0';

  try
    Result := FormatFloat('#,##0.00', StrToFloat(str) / 100);
  except
    Result := FormatFloat('#,##0.00', 0);
  end;
end;

class function TFunctions.FormataPeso(str: string): string;
begin
  if str.IsEmpty then
    str := '0';

  try
    Result := FormatFloat('#,##0.000', StrToFloat(str) / 1000);
  except
    Result := FormatFloat('#,##0.000', 0);
  end;
end;

class function TFunctions.FormataData(str: string): string;
begin
  str := Copy(str, 1, 8);

  if Length(str) < 8 then
    Result := TFunctions.Mask('##/##/####', str)
  else
  begin
    try
      str := TFunctions.Mask('##/##/####', str);
      strtodate(str);
      Result := str;
    except
      Result := '';
    end;
  end;
end;

class function TFunctions.AppIDBanner: string;
begin
{$IFDEF DEBUG}
  Result := 'ca-app-pub-3940256099942544/6300978111';
{$ELSE}
  Result := 'ca-app-pub-2623898784877719/5292568284';
{$ENDIF}
end;

class function TFunctions.AppIDRewarded: string;
begin
{$IFDEF DEBUG}
  Result := 'ca-app-pub-3940256099942544/5224354917';
{$ELSE}
  Result := 'ca-app-pub-2623898784877719/7261816575';
{$ENDIF}
end;

class function TFunctions.AppURL: string;
begin
{$IFDEF ANDROID}
  Result := 'https://play.google.com/store/apps/details?id=com.whatsapp';
{$ELSE}
  Result := 'https://apps.apple.com/br/app/whatsapp-messenger/id310633997';
{$ENDIF}
end;

end.

