unit UnitCadWords;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, REST.Types,
  System.Variants, System.JSON, u99Permissions, System.Permissions,
  System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.TabControl, System.IOUtils, FMX.DialogService, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI, FMX.Ani, System.Actions, FMX.ActnList, uEnum,
  uEnum.Helper,
  uClassMeaning, uClassMeaning.Intf, FMX.Media, uClassTexts, UnitPadrao,
  System.ImageList, FMX.ImgList, Skia.FMX, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, Skia;

type
  TFrmCadWords = class(TFrmPadrao)
    ActionList: TActionList;
    actStartRecording: TAction;
    actStopRecording: TAction;
    actPlay: TAction;
    actStop: TAction;
    actRecord: TChangeTabAction;
    actCadWord: TChangeTabAction;
    TabControl: TTabControl;
    FloatAnimation: TFloatAnimation;
    TabItemCadWord: TTabItem;
    Lay_Bottom: TLayout;
    Rect_Cancel: TRectangle;
    lbl_Cancelar: TLabel;
    Rect_Salvar: TRectangle;
    lbl_Salvar: TLabel;
    layContent: TLayout;
    LayEnglish: TLayout;
    img_english: TImage;
    edt_english: TEdit;
    img_rec_english: TImage;
    LayPortuguese: TLayout;
    img_portuguese: TImage;
    edt_Portuguese: TEdit;
    img_rec_portuguese: TImage;
    LayFrench: TLayout;
    img_french: TImage;
    edt_french: TEdit;
    img_rec_french: TImage;
    LaySpanish: TLayout;
    img_spanish: TImage;
    edt_spanish: TEdit;
    img_rec_spanish: TImage;
    LayItalian: TLayout;
    img_italian: TImage;
    edt_italian: TEdit;
    img_rec_italian: TImage;
    LayTop: TLayout;
    lbl_Title_RegisterWord: TLabel;
    Img_Search: TImage;
    TabItemRecord: TTabItem;
    LayTop1: TLayout;
    lbl_Title_RegisterWord2: TLabel;
    LayContent1: TLayout;
    Layout1: TLayout;
    rect_salvar1: TRectangle;
    lbl_Salvar1: TLabel;
    rect_stopplay: TRectangle;
    lbl_stopplay: TLabel;
    Layout2: TLayout;
    imgRecord: TImage;
    lbl_Record: TLabel;
    CircleAnimationRecording: TCircle;
    FloatAnimationRecording: TFloatAnimation;
    TabSearch: TTabItem;
    Rect_Aba3: TRectangle;
    lbl_txt_title_search: TLabel;
    imgBack3: TImage;
    Rect_Search_Top: TRectangle;
    edt_search: TEdit;
    rect_btn_search: TRectangle;
    lbl_txt_search: TLabel;
    TabControlAba3: TTabControl;
    Layout3: TLayout;
    rect_Voltar: TRectangle;
    lbl_Voltar: TLabel;
    rect_proximo: TRectangle;
    lbl_proximo: TLabel;
    procedure RecordClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rect_SalvarClick(Sender: TObject);
    procedure FloatAnimationRecordingFinish(Sender: TObject);
    procedure rect_salvar1Click(Sender: TObject);
    procedure rect_stopplayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CircleAnimationRecordingClick(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actStopRecordingExecute(Sender: TObject);
    procedure actStopExecute(Sender: TObject);
    procedure actPlayExecute(Sender: TObject);
    procedure actStartRecordingExecute(Sender: TObject);
    procedure imgRecordClick(Sender: TObject);
    procedure Rect_CancelClick(Sender: TObject);
    procedure rect_btn_searchClick(Sender: TObject);
    procedure Img_SearchClick(Sender: TObject);
    procedure imgBack3Click(Sender: TObject);
    procedure rect_VoltarClick(Sender: TObject);
    procedure rect_proximoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    permissao: T99Permissions;
    FMeaning: IMeaning;
    FOriginalNativeLanguage: TNativeLanguage;
    MediaPlayer: TMediaPlayer;
    FMicrophone: TAudioCaptureDevice;
    jsonArray: TJSONArray;
    procedure Search(id_subcategoria: Integer; busca: string);
    procedure AddWord;
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

    function Validated: Boolean;
    function FText: IText;
  public
    { Public declarations }
    procedure SetNativeLanguage(const Value: TNativeLanguage);
    procedure SetMeaning(const Value: IMeaning);
  end;

var
  FrmCadWords: TFrmCadWords;

implementation

{$R *.fmx}

uses UnitDM, uFunctions, UnitMeaning, uHorizontalMeaning, UnitConstante;

procedure TFrmCadWords.FormCreate(Sender: TObject);
begin
  inherited;
  TabControl.TabIndex := 0;
  if not Assigned(FMeaning) then
    FMeaning := TMeaning.New();
  MediaPlayer := TMediaPlayer.Create(nil);
  // Classe de permissao...
  permissao := T99Permissions.Create;
  FMicrophone := TCaptureDeviceManager.Current.DefaultAudioCaptureDevice;

  dm.RectEffect(Rect_Cancel);
  dm.RectEffect(Rect_Salvar);
end;

procedure TFrmCadWords.FormShow(Sender: TObject);
begin
  inherited;
  if (FMeaning.AccessBlock) or (FMeaning.User.Id_Usuario <> cCodAdmin) then
  begin
    Close;
    raise Exception.Create('Sorry, something went wrong.' + sLineBreak +
      'You have no access to this screen. Please, login again');
  end;

end;

function TFrmCadWords.FText: IText;
begin
  Result := TText.New(FMeaning.NativeLanguage);
end;

procedure TFrmCadWords.FloatAnimationRecordingFinish(Sender: TObject);
begin
  CircleAnimationRecording.Visible := False;
end;

procedure TFrmCadWords.Rect_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadWords.rect_VoltarClick(Sender: TObject);
begin
  inherited;
  TabControlAba3.Previous(TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmCadWords.rect_proximoClick(Sender: TObject);
begin
  inherited;
  TabControlAba3.Next(TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmCadWords.rect_salvar1Click(Sender: TObject);
begin
  try
    if FMeaning.getNativeLanguage = '' then
    begin
      ShowMessage('Type the text in ' + FMeaning.NativeLanguage.Description);
      Exit;
    end
    else
    begin
{$IFDEF MSWINDOWS}
      SaveAudioLocal(FMeaning.getUrl_PathS3(FMeaning.NativeLanguage));
{$ELSE}
      SaveAudioCloud(FMeaning.getUrl_PathS3(FMeaning.NativeLanguage));
{$ENDIF}
    end;
  finally
    actCadWord.Execute;
  end;

end;

procedure TFrmCadWords.SaveAudioLocal(diretorio: string);
begin
  ShowMessage('We can not save the audio in ' + diretorio);
end;

procedure TFrmCadWords.SaveAudioCloud(diretorio: string);
var
  StorageService: TAmazonStorageService;
  AmazonConnectionInfo: TAmazonConnectionInfo;
  img_stream: TBytesStream;
  Metadata, Header: TStringList;
  Response: TCloudResponseInfo;
begin
  if diretorio.Trim = '' then
  begin
    ShowMessage('Empty path when sending audio to Cloud!');
    Exit;
  end;

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

procedure TFrmCadWords.rect_stopplayClick(Sender: TObject);
begin
  try
    lbl_stopplay.Text := 'Stop';
    actPlay.Execute;

  finally
    lbl_stopplay.Text := 'Play';
  end;

  // if Assigned(MediaPlayer) then
  // begin
  //
  // if MediaPlayer.State = TMediaState.Playing then
  // begin
  //
  // actStop.Execute;
  // end
  // else
  // begin
  // actPlay.Execute;
  // end;
  //
  // end;

end;

procedure TFrmCadWords.RecordClick(Sender: TObject);
var
  I: Integer;
  Texto: string;
begin

  FMeaning.SetNativeLanguage(TNativeLanguage.Parse_Value(TImage(Sender).Tag));

  for I := FrmCadWords.ComponentCount - 1 downto 0 do
  begin
    if (FrmCadWords.Components[I] is TEdit) AND
      (FrmCadWords.Components[I].Tag = TImage(Sender).Tag) then
    begin
      Texto := (FrmCadWords.Components[I] as TEdit).Text;
      if Texto.Trim = '' then
        ShowMessage('Type the word first!!')
      else
      begin
        FMeaning.SetTextNative(Texto);
        FMeaning.SetAudioNative(Texto);
        actRecord.Execute;
      end;
      Exit;
    end;
  end;
end;

procedure TFrmCadWords.rect_btn_searchClick(Sender: TObject);
begin
  inherited;
  Search(FMeaning.Category.id_categoria, edt_search.Text);
end;

procedure TFrmCadWords.Search(id_subcategoria: Integer; busca: string);
var
  I, x: Integer;
  h: THorizontalMeaning;
  TabItem: TTabItem;
  ta: TNativeLanguage;
  erro: string;
begin

  if NOT dm.Search(id_subcategoria, FMeaning.NativeLanguage.Sufix, busca, 1,
    jsonArray, erro) then
  begin
    ShowMessage(erro);
    Exit;
  end;

  for I := TabControlAba3.TabCount downto 0 do
    TabControlAba3.Delete(I);

  h := THorizontalMeaning.Create(TabControl, FMeaning);

  try
    for x := 0 to jsonArray.Count - 1 do
    begin
      FMeaning.SetCodItem(jsonArray.Items[x].GetValue<Integer>('ID'));
      FMeaning.SetPortuguese(jsonArray.Items[x].GetValue<string>('PORTUGUESE'));
      FMeaning.SetEnglish(jsonArray.Items[x].GetValue<string>('ENGLISH'));
      FMeaning.SetSpanish(jsonArray.Items[x].GetValue<string>('SPANISH'));
      FMeaning.SetFrench(jsonArray.Items[x].GetValue<string>('FRENCH'));
      FMeaning.SetItalian(jsonArray.Items[x].GetValue<string>('ITALIAN'));

      FMeaning.SetAudioPortuguese(jsonArray.Items[x].GetValue<string>
        ('AUDIO_PORTUGUESE'));
      FMeaning.SetAudioEnglish(jsonArray.Items[x].GetValue<string>
        ('AUDIO_ENGLISH'));
      FMeaning.SetAudioSpanish(jsonArray.Items[x].GetValue<string>
        ('AUDIO_SPANISH'));
      FMeaning.SetAudioFrench(jsonArray.Items[x].GetValue<string>
        ('AUDIO_FRENCH'));
      FMeaning.SetAudioItalian(jsonArray.Items[x].GetValue<string>
        ('AUDIO_ITALIAN'));

      // Layout dentro do Horizontal Scroll Box, necessário para fazer o scroll com mais de um item
      TabItem := TTabItem.Create(TabControlAba3);
      TabItem.Align := TAlignLayout.Client;
      TabItem.Parent := TabControlAba3;
      TabItem.HitTest := true;
      TabItem.IsSelected := true;
      TabItem.Size.Width := 8;
      TabItem.Size.Height := 8;
      TabItem.StyleLookup := '';
      TabItem.Text := 'TabItem' + FMeaning.CodItem.ToString;
      TabItem.Tag := FMeaning.CodItem;

      // Layout Geral
      h.Lay_Content := TScrollBox.Create(TabItem);
      h.Lay_Content.Parent := TabItem;
      h.Lay_Content.Align := TAlignLayout.Client;
      h.Lay_Content.Margins.Right := 20;
      h.Lay_Content.Size.PlatformDefault := False;

      for ta := low(TNativeLanguage) to high(TNativeLanguage) do
      begin
        if (ta <> nlUnknow) and (ta <> nlAll) then
          h.AddTranslations(ta);
      end;

    end;

  finally
    h.DisposeOf;
    TabControlAba3.GotoVisibleTab(TabItemCadWord.Index, TTabTransition.None)
  end;

end;

procedure TFrmCadWords.Rect_SalvarClick(Sender: TObject);
begin
  if not Validated then
    Exit;

  dm.RequestAddWord.Params.Clear;
  if FMeaning.CodItem > 0 then
    dm.RequestAddWord.Method := TRestRequestMethod.rmPUT
  else
    dm.RequestAddWord.Method := TRestRequestMethod.rmPOST;

  if FMeaning.CodItem > 0 then
    dm.RequestAddWord.AddParameter('id', FMeaning.CodItem.ToString);
  dm.RequestAddWord.AddParameter('field_subcategory',
    FMeaning.NativeLanguage.Sufix);
  dm.RequestAddWord.AddParameter('id_subcategoria',
    FMeaning.Category.id_subcategoria.ToString);
  dm.RequestAddWord.AddParameter('english', FMeaning.English);
  dm.RequestAddWord.AddParameter('portuguese', FMeaning.Portuguese);
  dm.RequestAddWord.AddParameter('french', FMeaning.French);
  dm.RequestAddWord.AddParameter('spanish', FMeaning.Spanish);
  dm.RequestAddWord.AddParameter('italian', FMeaning.Italian);

  dm.RequestAddWord.AddParameter('audio_english', FMeaning.AudioEnglish);
  dm.RequestAddWord.AddParameter('audio_portuguese', FMeaning.AudioPortuguese);
  dm.RequestAddWord.AddParameter('audio_french', FMeaning.AudioFrench);
  dm.RequestAddWord.AddParameter('audio_spanish', FMeaning.AudioSpanish);
  dm.RequestAddWord.AddParameter('audio_italian', FMeaning.AudioItalian);

  dm.RequestAddWord.ExecuteAsync(AddWord, true, true, ErroRequest);
end;

procedure TFrmCadWords.AddWord;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin

  if dm.RequestAddWord.Response.StatusCode <> 200 then
  begin
    ShowMessage('Erro ao criar conta: ' +
      dm.RequestAddWord.Response.StatusText);
    Exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestAddWord.Response.JSONValue.ToString;
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
  finally
    jsonObj.DisposeOf;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    Exit;
  end
  else
  begin
    Close;

  end;

end;

function TFrmCadWords.AUDIO_FILENAME: string;
begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  Result := FMeaning.NativeLanguage.Description + '.3gp';
{$ELSE}
  Result := FMeaning.NativeLanguage.Description + '.mp3';
{$ENDIF}
end;

procedure TFrmCadWords.ActionListUpdate(Action: TBasicAction;
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

procedure TFrmCadWords.imgBack3Click(Sender: TObject);
var
  x: Integer;
begin
  inherited;

  if TabControlAba3.TabCount > 0 then
  begin
    x := TabControlAba3.ActiveTab.Index;

    FMeaning.SetCodItem(jsonArray.Items[x].GetValue<Integer>('ID'));
    FMeaning.SetPortuguese(jsonArray.Items[x].GetValue<string>('PORTUGUESE'));
    FMeaning.SetEnglish(jsonArray.Items[x].GetValue<string>('ENGLISH'));
    FMeaning.SetSpanish(jsonArray.Items[x].GetValue<string>('SPANISH'));
    FMeaning.SetFrench(jsonArray.Items[x].GetValue<string>('FRENCH'));
    FMeaning.SetItalian(jsonArray.Items[x].GetValue<string>('ITALIAN'));

    FMeaning.SetAudioPortuguese(jsonArray.Items[x].GetValue<string>
      ('AUDIO_PORTUGUESE'));
    FMeaning.SetAudioEnglish(jsonArray.Items[x].GetValue<string>
      ('AUDIO_ENGLISH'));
    FMeaning.SetAudioSpanish(jsonArray.Items[x].GetValue<string>
      ('AUDIO_SPANISH'));
    FMeaning.SetAudioFrench(jsonArray.Items[x].GetValue<string>
      ('AUDIO_FRENCH'));
    FMeaning.SetAudioItalian(jsonArray.Items[x].GetValue<string>
      ('AUDIO_ITALIAN'));

    edt_english.Text := FMeaning.English;
    edt_Portuguese.Text := FMeaning.Portuguese;
    edt_french.Text := FMeaning.French;
    edt_spanish.Text := FMeaning.Spanish;
    edt_italian.Text := FMeaning.Italian;
  end;

  TabControl.GotoVisibleTab(TabItemCadWord.Index, TTabTransition.Slide);

end;

procedure TFrmCadWords.imgRecordClick(Sender: TObject);
begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  actStartRecording.Execute;
{$ELSE}
  // load audio
{$ENDIF}
end;

procedure TFrmCadWords.CircleAnimationRecordingClick(Sender: TObject);
begin
  actStopRecording.Execute;

end;

procedure TFrmCadWords.actStartRecordingExecute(Sender: TObject);
const
  PermissionRecordAudio = 'android.permission.RECORD_AUDIO';
begin
  lbl_Record.Text := FText.getTextClickAgainToStopRecording;
  actStop.Execute;
  CircleAnimationRecording.Visible := true;
  FloatAnimationRecording.Start;

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

procedure TFrmCadWords.actStopRecordingExecute(Sender: TObject);
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

procedure TFrmCadWords.actStopExecute(Sender: TObject);
begin
  lbl_stopplay.Text := 'Play';
  if MediaPlayer.State = TMediaState.Playing then
    MediaPlayer.Stop;
end;

procedure TFrmCadWords.actPlayExecute(Sender: TObject);
begin
  lbl_stopplay.Text := 'Stop';

  if IsMicrophoneRecording then
    actStopRecording.Execute;

  MediaPlayer.Clear;
  MediaPlayer.FileName := GetAudioFileName(AUDIO_FILENAME);
  MediaPlayer.CurrentTime := 0;
  MediaPlayer.Play;
end;

{ GetAudioFileName resolves the audio file path for either platform. }

function TFrmCadWords.GetAudioFileName(const AFileName: string): string;
begin
  Result := TPath.Combine(TFunctions.getPathAudio, AFileName);
end;

function TFrmCadWords.Validated: Boolean;
begin
  Result := False;
  if (edt_english.Text = '') then
  begin
    ShowMessage('Type the text in English');
  end
  else if (edt_Portuguese.Text = '') then
  begin
    ShowMessage('Type the text in Portuguese');
  end
  else if (edt_french.Text = '') then
  begin
    ShowMessage('Type the text in French');
  end
  else if (edt_spanish.Text = '') then
  begin
    ShowMessage('Type the text in Spanish');
  end
  else if (edt_italian.Text = '') then
  begin
    ShowMessage('Type the text in Italian');
  end
  else
  begin
    Result := true;
    FMeaning.SetEnglish(edt_english.Text);
    FMeaning.SetPortuguese(edt_Portuguese.Text);
    FMeaning.SetFrench(edt_french.Text);
    FMeaning.SetSpanish(edt_spanish.Text);
    FMeaning.SetItalian(edt_italian.Text);
  end;
end;

procedure TFrmCadWords.SetMeaning(const Value: IMeaning);
begin
  FMeaning := Value;
  SetNativeLanguage(FMeaning.NativeLanguage);
  FMeaning.ResetValues;
  FMeaning.SetItem(dm.ClickAudioNative);

  SetColors;

  lbl_Title_RegisterWord.Text := FText.getTextRegisterWord;
  lbl_Title_RegisterWord2.Text := FText.getTextRegisterWord;
  lbl_Record.Text := FText.getTextClickHereAndRecord;
  lbl_Cancelar.Text := FText.getTextCancel;
  lbl_Salvar.Text := FText.getTextSave;
  lbl_stopplay.Text := FText.getTextPlay;

  edt_english.TextPrompt := FText.getTextTypeWord(nlEnglish);
  edt_Portuguese.TextPrompt := FText.getTextTypeWord(nlPortuguese);
  edt_french.TextPrompt := FText.getTextTypeWord(nlFrench);
  edt_spanish.TextPrompt := FText.getTextTypeWord(nlSpanish);
  edt_italian.TextPrompt := FText.getTextTypeWord(nlItalian);

end;

procedure TFrmCadWords.SetNativeLanguage(const Value: TNativeLanguage);
begin
  FOriginalNativeLanguage := Value;
end;

function TFrmCadWords.HasMicrophone: Boolean;
begin
  Result := Assigned(FMicrophone);
end;

procedure TFrmCadWords.Img_SearchClick(Sender: TObject);
begin
  inherited;
  TabControl.GotoVisibleTab(TabSearch.Index, TTabTransition.Slide);
end;

function TFrmCadWords.IsMicrophoneRecording: Boolean;
begin
  Result := HasMicrophone and
    (FMicrophone.State = TCaptureDeviceState.Capturing);
end;

procedure TFrmCadWords.RequestPermissionsResult(Sender: TObject; const APermissions: TClassicStringDynArray;
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
      TPermissionStatus.PermanentlyDenied:
        TDialogService.ShowMessage
          ('If you decide you wish to use the audio recording feature of this app, please go to app settings and enable the microphone permission');
    end;
  end
  else
    TDialogService.ShowMessage
      ('Something went wrong with the permission checking');
end;

// Optional rationale display routine to display permission requirement rationale to the user
procedure TFrmCadWords.DisplayRationale(Sender: TObject;
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

procedure TFrmCadWords.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(permissao) then
    FreeAndNil(permissao);

  if Assigned(MediaPlayer) then
    FreeAndNil(MediaPlayer);

  if Assigned(jsonArray) then
    FreeAndNil(jsonArray);

  Action := TCloseAction.caFree;
  FrmCadWords := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.Show;
end;

end.
