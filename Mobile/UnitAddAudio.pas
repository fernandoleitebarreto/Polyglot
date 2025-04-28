unit UnitAddAudio;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Generics.Collections, UnitPadrao,
  System.Variants, System.JSON, u99Permissions, System.Permissions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.TabControl, System.IOUtils, FMX.DialogService,
  FMX.Ani, System.Actions, FMX.ActnList,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  FMX.Media, Data.Cloud.CloudAPI, Data.Cloud.AmazonAPI, FMX.ScrollBox, FMX.Memo,
  FMX.Memo.Types, uClassTexts, System.ImageList, FMX.ImgList, FMX.Skia, Skia;

type
  TFrmAddAudio = class(TFrmPadrao)
    TabControl: TTabControl;
    FloatAnimation: TFloatAnimation;
    TabItemRecord: TTabItem;
    LayContent1: TLayout;
    imgRecord: TImage;
    lbl_Record: TLabel;
    ActionList: TActionList;
    actStartRecording: TAction;
    actStopRecording: TAction;
    actPlay: TAction;
    actStop: TAction;
    actRecord: TChangeTabAction;
    Lay_Bottom: TLayout;
    Layout2: TLayout;
    rect_salvar: TRectangle;
    Label4: TLabel;
    CircleAnimationRecording: TCircle;
    FloatAnimationRecording: TFloatAnimation;
    rect_stopplay: TRectangle;
    lbl_stopplay: TLabel;
    Lay_Top: TLayout;
    Rect_MainProgress: TRectangle;
    Rect_progress: TRectangle;
    Img_Exit: TImage;
    Lay_Words: TLayout;
    lblWord: TLabel;
    lbl_Title_RecordWord: TLabel;
    TabConfirmRecordAudio: TTabItem;
    Memo1: TMemo;
    StyleBook1: TStyleBook;
    lbl_Title_TermsOfUse: TLabel;
    Layout1: TLayout;
    Rect_Decline: TRectangle;
    lbl_Decline: TLabel;
    Rect_Accept: TRectangle;
    lbl_Accept: TLabel;
    Rectangle1: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure FloatAnimationRecordingFinish(Sender: TObject);
    procedure rect_salvarClick(Sender: TObject);
    procedure rect_stopplayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CircleAnimationRecordingClick(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actStopRecordingExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure actPlayExecute(Sender: TObject);
    procedure actStartRecordingExecute(Sender: TObject);
    procedure imgRecordClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Img_ExitClick(Sender: TObject);
    procedure Rect_AcceptClick(Sender: TObject);
  private
    { Private declarations }
    permissao: T99Permissions;
    FMeaning: IMeaning;
    MediaPlayer: TMediaPlayer;
    FMicrophone: TAudioCaptureDevice;
    JsonArray: TJSONArray;
    StepBar, Step: Single;
    FContItem: Integer;
    // {$IF DEFINED(ANDROID) OR DEFINED(IOS)}
    procedure AddAudio;
    // {$ENDIF}
    function AUDIO_FILENAME: string;
    function HasMicrophone: Boolean;
    function IsMicrophoneRecording: Boolean;
    procedure RequestPermissionsResult(Sender: TObject; const APermissions: TClassicStringDynArray;
    const AGrantResults: TClassicPermissionStatusDynArray);
    procedure DisplayRationale(Sender: TObject;
    const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    function GetAudioFileName(const AFileName: string): string;
    procedure SaveAudioLocal(diretorio: string);
    procedure SaveAudioCloud(diretorio: string);

    procedure ExibirCampos(pShow: Boolean = True);
    procedure ListaDados;
    procedure LoadFromJSON(AContItem: Integer);
    procedure ProgressBar(AContItem: Integer);
    function FText: IText;
    // procedure AddItem;
  public
    { Public declarations }
    procedure SetMeaning(const Value: IMeaning);
  end;

var
  FrmAddAudio: TFrmAddAudio;

implementation

{$R *.fmx}

uses UnitDM, uFunctions, UnitMeaning;

procedure TFrmAddAudio.FloatAnimationRecordingFinish(Sender: TObject);
begin
  CircleAnimationRecording.Visible := False;
end;

procedure TFrmAddAudio.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl.TabIndex := 0;
  MediaPlayer := TMediaPlayer.Create(nil);
  // Classe de permissao...
  permissao := T99Permissions.Create;
  FMicrophone := TCaptureDeviceManager.Current.DefaultAudioCaptureDevice;
  lblWord.Text := '';
  FContItem := -1;
  StepBar := 0;
  Step := 0;
end;

procedure TFrmAddAudio.FormShow(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      ExibirCampos(False);
    end).start();

  // Consumir WS...
  dm.RequestWordsWithoutAudio.Params.Clear;
  dm.RequestWordsWithoutAudio.AddParameter('category',
    FMeaning.Category.id_subcategoria.ToString);
  dm.RequestWordsWithoutAudio.AddParameter('field',
    FMeaning.NativeLanguage.Field);
  // faz com que rode em thread paralela
  dm.RequestWordsWithoutAudio.ExecuteAsync(ListaDados, True, True,
    ErroRequest);
  TabControl.TabIndex := 0;
end;

function TFrmAddAudio.FText: IText;
begin
  Result := TText.New(FMeaning.NativeLanguage);
end;

procedure TFrmAddAudio.ListaDados;
var
  JSON: string;
begin
  if dm.RequestWordsWithoutAudio.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage('Erro ao listar dados: ' + dm.RequestWordsWithoutAudio.Response.
      StatusText);
    exit;
  end;

  try
    try

      JSON := dm.RequestWordsWithoutAudio.Response.JSONValue.ToString;

      if not JSON.Contains('MESSAGE') then // se json vazio
      begin
        // pega o json do request
        JsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON),
          0) as TJSONArray;

        // dm.RequestWordsWithoutAudio.Response.JSONValue.GetValue<string>('NativeLanguage')

        Inc(FContItem);
        LoadFromJSON(FContItem);
      end
      else
      begin
        Rect_MainProgress.Visible := False;
        rect_stopplay.Enabled := False;
        rect_salvar.Enabled := False;
        lblWord.Text := FText.getTextNoWordsToRecord;
      end;

    except
      ShowMessage('Json array inválido');
      rect_salvar.Enabled := False;
    end;

  finally
    if rect_salvar.Enabled then
    begin
      TabControl.TabIndex := 0;
      StepBar := (Rect_MainProgress.Width / (JsonArray.Count - 1));
      Rect_progress.Width := 0;
    end;

    ExibirCampos;
  end;

end;

procedure TFrmAddAudio.LoadFromJSON(AContItem: Integer);
var
  ArrayElement: TJSonValue;
begin
  rect_salvar.Enabled := AContItem < JsonArray.Count;

  if AContItem < JsonArray.Count then
  begin
    ProgressBar(AContItem);

    try
      ArrayElement := JsonArray.Items[AContItem] as TJSonValue;
      lblWord.Text := ArrayElement.GetValue<string>('native_language');
      FMeaning.SetCodItem(ArrayElement.GetValue<Integer>('CodItem'));
      FMeaning.SetAudioNative(ArrayElement.GetValue<string>('CodItem'));

    except
      ShowMessage('Json array inválido');
      raise;
    end;

  end
  else
    ShowMessage('Thanks for contribute!!');

end;

procedure TFrmAddAudio.ProgressBar(AContItem: Integer);
begin
  if AContItem < JsonArray.Count then
  begin
    if Rect_progress.Width < Rect_MainProgress.Width then
    begin
      Step := Step + StepBar;
      Rect_progress.Width := Step;

    end;
  end
  else
  begin
    if Rect_progress.Width > 0 then
    begin
      Step := Step - StepBar;
      Rect_progress.Width := Step;

    end;
  end;
end;

procedure TFrmAddAudio.Rect_AcceptClick(Sender: TObject);
begin
  actRecord.Execute;
end;

procedure TFrmAddAudio.ExibirCampos(pShow: Boolean);
begin
  SkLoading.Visible := not pShow;
  SkLoading.Enabled := SkLoading.Visible;
  TabControl.Visible := pShow;
  if pShow then
    TabControl.Opacity := 1;
  Lay_Top.Visible := pShow;
  Lay_Bottom.Visible := pShow;

end;

// procedure TFrmEditWords.AddItem;
// var
// ta: TNativeLanguage;
// CircleAudio: TCircle;
// TabItem: TTabItem;
// Lay_Horz_Top: TLayout;
// Rect: TRectangle;
// Img: TImage;
// lbl: TLabel;
// begin
// // Layout dentro do Horizontal Scroll Box, necessário para fazer o scroll com mais de um item
// TabItem := TTabItem.Create(TabControl);
// TabItem.Align := TAlignLayout.Client;
// TabItem.Parent := TabControl;
// TabItem.HitTest := True;
// TabItem.IsSelected := True;
// TabItem.Size.Width := 8;
// TabItem.Size.Height := 8;
// TabItem.StyleLookup := '';
// TabItem.Text := 'TabItem' + FMeaning.CodItem.ToString;
// TabItem.Tag := FMeaning.CodItem;
//
// // Retangulo Geral
// Rect := TRectangle.Create(TabItem);
// Rect.Parent := TabItem;
// Rect.Align := TAlignLayout.Client;
// Rect.Stroke.Kind := TBrushKind.None;
// Rect.Fill.Kind := TBrushKind.None;
// // Layout Top
// Lay_Horz_Top := TLayout.Create(TabItem);
// Lay_Horz_Top.Parent := TabItem;
// Lay_Horz_Top.Align := TAlignLayout.Top;
// Lay_Horz_Top.Size.Height := 97;
// // Lay_Horz_Top.Margins.Right := 20;
// Lay_Horz_Top.Size.PlatformDefault := False;
//
// // Retangulo do layout top
// Rect := TRectangle.Create(Lay_Horz_Top);
// Rect.Parent := Lay_Horz_Top;
// Rect.Align := TAlignLayout.Client;
// Rect.Stroke.Kind := TBrushKind.None;
// Rect.Fill.Kind := TBrushKind.None;
//
// // Adiciona a Imagem do Voltar
// Img := TImage.Create(Rect);
// Img.Parent := Rect;
// Img.Align := TAlignLayout.Left;
// Img.Width := 40;
// {$IFDEF MSWINDOWS}
// Img.MultiResBitmap.Items[0].Bitmap.LoadFromFile(TFunctions.getPathExecutable +
// '\Images\back.png');
// Img.OnClick := FMeaning.Press_Back;
// {$ELSE}
// TFunctions.ReadImageFromWeb(Img, TFunctions.getPathAWS + '/Images/back.png');
// Img.OnTap := FMeaning.Press_Back;
// {$ENDIF}
// Rect.AddObject(Img);
//
// if FMeaning.NativeLanguage <> nlUnknow then
// begin
// // Adiciona texto...
// lbl := TLabel.Create(Lay_Horz_Top);
// lbl.Align := TAlignLayout.Client;
// lbl.StyledSettings := [TStyledSetting.Family];
// lbl.Margins.Left := 15;
// lbl.Size.Height := 97;
// lbl.Size.PlatformDefault := False;
// lbl.TextSettings.FontColor := $FF999999;
// lbl.TextSettings.Font.Size := 24;
// lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
// lbl.Text := FMeaning.getNativeLanguage;
// lbl.Visible := True;
// Lay_Horz_Top.AddObject(lbl);
//
// end;
// end;

procedure TFrmAddAudio.rect_salvarClick(Sender: TObject);
begin
  // {$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  if FMeaning.getFullDirectory(FMeaning.NativeLanguage).Trim = '' then
  begin
    ShowMessage('Empty path when sending audio to Cloud!');
    exit;
  end;

  if FMicrophone.FileName.Trim = '' then
  begin
    ShowMessage('Audio is Empty! Please record the word above');
    exit;
  end;

  TabControl.Next(TTabTransition.Slide, TTabTransitionDirection.Normal);
{$IFDEF MSWINDOWS}
  SaveAudioLocal(FMeaning.getUrl_PathS3(FMeaning.NativeLanguage));
{$ELSE}
  SaveAudioCloud(FMeaning.getFullDirectory(FMeaning.NativeLanguage));
{$ENDIF}
  dm.RequestAddAudio.Params.Clear;
  dm.RequestAddAudio.AddParameter('CodItem', FMeaning.CodItem.ToString);
  dm.RequestAddAudio.AddParameter('native_language',
    FMeaning.NativeLanguage.AsValue.ToString);
  dm.RequestAddAudio.AddParameter('AudioNative',
    FMeaning.Audio(FMeaning.NativeLanguage));

  dm.RequestAddAudio.ExecuteAsync(AddAudio, True, True, ErroRequest);

  // {$ELSE}
  // Inc(FContItem);
  // LoadFromJSON(FContItem);
  // {$ENDIF}
end;

procedure TFrmAddAudio.AddAudio;
var
  jsonObj: TJSONObject;
  JSON, sucesso, erro: string;
begin

  if dm.RequestAddAudio.Response.StatusCode <> 200 then
  begin
    ShowMessage('Erro ao adicionar audio: ' +
      dm.RequestAddAudio.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestAddAudio.Response.JSONValue.ToString;
    jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJSONObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
  finally
    jsonObj.DisposeOf;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
    Inc(FContItem);
    LoadFromJSON(FContItem);
  end;

end;

procedure TFrmAddAudio.SaveAudioLocal(diretorio: string);
begin
  ShowMessage('We can not save the audio in ' + diretorio);
end;

procedure TFrmAddAudio.SaveAudioCloud(diretorio: string);
var
  AmazonConnectionInfo: TAmazonConnectionInfo;
  StorageService: TAmazonStorageService;
  img_stream: TBytesStream;
  Metadata, Header: TStringList;
  Response: TCloudResponseInfo;
begin
  AmazonConnectionInfo := TFunctions.AmazonConnectionInfo;
  StorageService := TAmazonStorageService.Create(AmazonConnectionInfo);
  Response := TCloudResponseInfo.Create;

  Metadata := TStringList.Create;
  Metadata.Values['Obs'] := 'Teste de upload';

  Header := TStringList.Create;
{$IFDEF ANDROID}
  Header.Values['Content-Type'] := 'video/3gpp';
{$ELSE}
  Header.Values['Content-Type'] := 'audio/mp3';
{$ENDIF}
  img_stream := TBytesStream.Create;

  try
    img_stream.LoadFromFile(GetAudioFileName(AUDIO_FILENAME));

    if not StorageService.UploadObject('polyglot-files', diretorio,
      img_stream.Bytes, False, Metadata, Header, amzbaPublicReadWrite, Response)
    then
      ShowMessage('Erro ao enviar objeto: ' + Response.StatusMessage);

  finally
    if Assigned(Response) then
      Response.DisposeOf;
    if Assigned(Header) then
      Header.DisposeOf;
    if Assigned(Metadata) then
      Metadata.DisposeOf;
    if Assigned(img_stream) then
      img_stream.DisposeOf;
    if Assigned(AmazonConnectionInfo) then
      AmazonConnectionInfo.DisposeOf;
    if Assigned(StorageService) then
      StorageService.DisposeOf;
  end;

end;

procedure TFrmAddAudio.rect_stopplayClick(Sender: TObject);
begin
  try
    lbl_stopplay.Text := FText.getTextStop;
    actPlay.Execute;

  finally
    lbl_stopplay.Text := FText.getTextPlay;
  end;

end;

function TFrmAddAudio.AUDIO_FILENAME: string;
begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  Result := FMeaning.NativeLanguage.Field + '.3gp';
{$ELSE}
  Result := FMeaning.NativeLanguage.Field + '.mp3';
{$ENDIF}
end;

procedure TFrmAddAudio.ActionListUpdate(Action: TBasicAction;
var Handled: Boolean);
begin
  { Provide feedback on capture on/off }

  CircleAnimationRecording.Visible := HasMicrophone and
    (FMicrophone.State = TCaptureDeviceState.Capturing);

  { ... and enable buttons accordingly }

  actStartRecording.Enabled := not IsMicrophoneRecording and HasMicrophone;
  actStopRecording.Enabled := IsMicrophoneRecording;
  actStop.Enabled := Assigned(MediaPlayer.Media) and
    (MediaPlayer.State = TMediaState.Playing);
  actPlay.Enabled := FileExists(GetAudioFileName(AUDIO_FILENAME)) and
    (MediaPlayer.State <> TMediaState.Playing);
end;

procedure TFrmAddAudio.imgRecordClick(Sender: TObject);
begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  actStartRecording.Execute;
{$ELSE}
  // load audio
{$ENDIF}
end;

procedure TFrmAddAudio.CircleAnimationRecordingClick(Sender: TObject);
begin
  actStopRecording.Execute;

end;

procedure TFrmAddAudio.actStartRecordingExecute(Sender: TObject);
const
  PermissionRecordAudio = 'android.permission.RECORD_AUDIO';
begin
  lbl_Record.Text := FText.getTextClickAgainToStopRecording;
  actStop.Execute;
  CircleAnimationRecording.Visible := True;
  FloatAnimationRecording.start;

  { get the microphone device }
  FMicrophone := TCaptureDeviceManager.Current.DefaultAudioCaptureDevice;

  if HasMicrophone then
  begin
    { and attempt to record to 'test.caf' file }
    FMicrophone.FileName := GetAudioFileName(AUDIO_FILENAME);

    PermissionsService.RequestPermissions([PermissionRecordAudio],
      RequestPermissionsResult, DisplayRationale);
  end
  else
    ShowMessage('No microphone is available.');

end;

procedure TFrmAddAudio.actStopRecordingExecute(Sender: TObject);
begin
  lbl_Record.Text := FText.getTextClickHereAndRecord;
  CircleAnimationRecording.Visible := False;

  if IsMicrophoneRecording then
    try
      FMicrophone.StopCapture;
      FloatAnimationRecording.Stop;
    except
      TDialogService.ShowMessage
        ('Get state: Operation not supported by this device');
    end;

end;

procedure TFrmAddAudio.actStopExecute(Sender: TObject);
begin
  lbl_stopplay.Text := FText.getTextPlay;
  if MediaPlayer.State = TMediaState.Playing then
    MediaPlayer.Stop;
end;

procedure TFrmAddAudio.actPlayExecute(Sender: TObject);
begin
  lbl_stopplay.Text := FText.getTextStop;

  if IsMicrophoneRecording then
    actStopRecording.Execute;

  MediaPlayer.Clear;
  MediaPlayer.FileName := GetAudioFileName(AUDIO_FILENAME);
  MediaPlayer.CurrentTime := 0;
  MediaPlayer.Play;
end;

{ GetAudioFileName resolves the audio file path for either platform. }

function TFrmAddAudio.GetAudioFileName(const AFileName: string): string;
begin
  Result := TFunctions.getPathAudio + AFileName;

  // {$IFDEF ANDROID}
  // Result := TPath.GetTempPath + '/' + AFileName;
  // {$ELSE}
  // {$IFDEF IOS}
  // Result := TPath.GetHomePath + '/Documents/' + AFileName;
  // {$ELSE}
  // Result := TPath.Combine(TPath.GetTempPath, AFileName);
  // {$ENDIF}
  // {$ENDIF}
end;

procedure TFrmAddAudio.SetMeaning(const Value: IMeaning);
begin
  FMeaning := Value;

  lbl_Record.Text := FText.getTextClickHereAndRecord;
  lbl_stopplay.Text := FText.getTextPlay;
  lbl_Title_TermsOfUse.Text := FText.getTextTermsOfUse;
  lbl_Title_RecordWord.Text := FText.getTextRecordWord;
  lbl_Accept.Text := FText.getTextAccept;
  lbl_Decline.Text := FText.getTextDecline;

end;

function TFrmAddAudio.HasMicrophone: Boolean;
begin
  Result := Assigned(FMicrophone);
end;

procedure TFrmAddAudio.Img_ExitClick(Sender: TObject);
begin
  Close;
end;

function TFrmAddAudio.IsMicrophoneRecording: Boolean;
begin
  Result := HasMicrophone and
    (FMicrophone.State = TCaptureDeviceState.Capturing);
end;

procedure TFrmAddAudio.RequestPermissionsResult(Sender: TObject; const APermissions: TClassicStringDynArray;
    const AGrantResults: TClassicPermissionStatusDynArray);
begin
  if (Length(AGrantResults) = 1) then
  begin
    case AGrantResults[0] of
      TPermissionStatus.Granted:
        try
          FMicrophone.StartCapture;
        except
          TDialogService.ShowMessage
            ('StartCapture: Operation not supported by this device');
        end;
      TPermissionStatus.Denied:
        TDialogService.ShowMessage
          ('Cannot record audio without the relevant permission being granted');
//      TPermissionStatus.PermanentlyDenied:
//        TDialogService.ShowMessage
//          ('If you decide you wish to use the audio recording feature of this app, please go to app settings and enable the microphone permission');
    end;
  end
  else
    TDialogService.ShowMessage
      ('Something went wrong with the permission checking');
end;

// Optional rationale display routine to display permission requirement rationale to the user
procedure TFrmAddAudio.DisplayRationale(Sender: TObject;
const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
begin
  // Show an explanation to the user *asynchronously* - don't block this thread waiting for the user's response!
  // After the user sees the explanation, invoke the post-rationale routine to request the permissions
  TDialogService.ShowMessage
    ('We need to be given permission to record some audio with your microphone',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;

procedure TFrmAddAudio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(permissao) then
    FreeAndNil(permissao);

  if Assigned(MediaPlayer) then
    FreeAndNil(MediaPlayer);

  if Assigned(JsonArray) then
    FreeAndNil(JsonArray);

  Action := TCloseAction.caFree;
  FrmAddAudio := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.Show;
end;

end.
