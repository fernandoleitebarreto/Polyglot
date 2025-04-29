unit UnitSelectWords;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, StrUtils, AdMob113, Math,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  FireDAC.Comp.Client, UnitDM, System.JSON, uFunctions, UnitPadrao,
  System.Generics.Collections, System.Generics.Defaults, Data.DB, uArrayUtils,
  UnitMeaning, uClassTexts, FMX.Media, System.IOUtils, uMediaPlayerThread,
  FMX.ListBox, System.ImageList, FMX.ImgList, Skia.FMX, FMX.TabControl,
  uHorizontalMeaning, System.Actions, FMX.ActnList, Skia;

const
  fmForm = fmSelectWords;
  MAX_RECTANGLES = 4;
  RECT_HEIGHT = 20;

type
  TMeaningArray = array of IMeaning;
  TArrayInteger = array of Integer;

  TFrmSelectWords = class(TFrmPadrao)
    Lay_Content: TLayout;
    lbl_Title_SelectWords: TLabel;
    lbl_Points: TLabel;
    lbl_loading: TLabel;
    MediaPlayer: TMediaPlayer;
    MediaPlayerNative: TMediaPlayer;
    FloatAnimation1: TFloatAnimation;
    Lay_Menu: TLayout;
    AnimaMenu: TFloatAnimation;
    Rect_Menu: TRectangle;
    img_Hand: TImage;
    AnimaHand: TFloatAnimation;
    Lay_Header: TLayout;
    AnimationForm: TFloatAnimation;
    Lay_Form: TLayout;
    Rect_Next: TRectangle;
    AnimaMessage: TFloatAnimation;
    Lay_Next: TLayout;
    lbl_TheWordIs: TLabel;
    lbl_WordTranslated: TLabel;
    LayTop: TLayout;
    LayBottom: TLayout;
    AnimaHand2: TFloatAnimation;
    Rect_Error: TRectangle;
    BitmapListAnimation1: TBitmapListAnimation;
    gifRight: TSkAnimatedImage;
    Rect_Finish: TRectangle;
    lbl_YouGotPoints: TLabel;
    gifCongratulations: TSkAnimatedImage;
    Lay_Bottom: TLayout;
    Rect_Word: TRectangle;
    Next_Body: TRectangle;
    Rect_PlayAgain: TRectangle;
    Rect_No: TRectangle;
    lbl_No: TLabel;
    Rect_Yes: TRectangle;
    lbl_Yes: TLabel;
    lbl_PlayAgain: TLabel;
    lbl_Congratulations: TLabel;
    SkStars: TSkAnimatedImage;
    Next_Button: TRectangle;
    lbl_Next: TLabel;
    TabControl: TTabControl;
    TabGame: TTabItem;
    TabReview: TTabItem;
    Lay_ReviewTop: TLayout;
    Img_Exit: TGlyph;
    Rect_Exit: TRectangle;
    Lbl_Review: TLabel;
    Lay_ReviewTop2: TLayout;
    lbl_ReviewLastWordsThisRound: TLabel;
    ScrollBoxReview: TScrollBox;
    ActionList: TActionList;
    actLast: TChangeTabAction;
    actNext: TChangeTabAction;
    Lay_Finish: TLayout;
    RectImgPlay: TRectangle;
    Img_Play: TGlyph;
    ImageList: TImageList;
    Lay_Word: TLayout;
    lbl_Word: TLabel;
    lbl_Language: TLabel;
    SkAudio: TSkAnimatedImage;
    tmrAudio: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure ListaDados;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnimaMenuFinish(Sender: TObject);
    procedure FechaMenu(Sender: TObject);
    procedure AnimaHandFinish(Sender: TObject);
    procedure Next_ButtonClick(Sender: TObject);
    procedure AnimationFormFinish(Sender: TObject);
    procedure AnimaHand2Finish(Sender: TObject);
    procedure Rect_WordClick(Sender: TObject);
    procedure cbbLanguageChange(Sender: TObject);
    procedure Rect_YesClick(Sender: TObject);
    procedure Rect_NoClick(Sender: TObject);
    procedure lbl_CongratulationsClick(Sender: TObject);
    procedure Rect_ExitClick(Sender: TObject);
    procedure Lay_FinishClick(Sender: TObject);
    procedure Rect_FinishClick(Sender: TObject);
    procedure SkAudioClick(Sender: TObject);
    procedure RectImgPlayClick(Sender: TObject);
    procedure tmrAudioTimer(Sender: TObject);
  private
    { Private declarations }
    FComboLanguage: TComboBox;
    FHorizontalMeaning: THorizontalMeaning;
    RECT_WIDTH: Integer;
    FMeaning: IMeaning;
    FLanguage: TNativeLanguage;
    FMeaningArray: TMeaningArray;
    FListOptions: TArray<Integer>;
    FAcertos, FErrors, FTotalPerRound: Integer;
    FBannerAd, FRewarded: TAdBanner;
    FTotalWords, FTotalComplete: TArrayInteger;
    FWordsUsed: TFDMemtable;
    function GetIndex: Integer;
    function GetAlign(I: Integer): TAlignLayout;
    function GetLayout(I: Integer): TLayout;
    procedure Init;
    procedure ExibirCampos(pShow: Boolean = True);
    procedure Carrega_Dados(strJson: string);
    procedure Carrega_Layout;
    procedure Cria_Lista_Titulo;
    procedure Cria_Lista_Item;
    procedure Cria_Item(I: Integer);
    function FText: IText;
    procedure CheckWordSave;
    procedure ShowHowToPlay;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure ClickItem(Sender: TObject);
    procedure ShowFinish;
    procedure ShowNext;
    function getSelectLanguage: TNativeLanguage;
    function IsMute: Boolean;
    procedure Reload;
    procedure ExibirAds(Proc: TProc; EnableRewarded: Boolean = True;
      EnableBanner: Boolean = True);

    function GetBannerAd: TAdBanner;
    function GetRewarded: TAdBanner;
    function GetTotalWords: Integer;
    function GetTotalComplete: Integer;
    procedure SetTotalComplete(const Value: Integer);
    function IsFinished: Boolean;
    procedure Popula_Combo(pOriginalItemIndex: Boolean = False);
    function IsRoundFinished: Boolean;
    procedure AddReview(AMeaning: IMeaning; ALanguage: TNativeLanguage);
    function GetComboLanguage: TComboBox;
    procedure ErroRequestTryAgain(Sender: TObject);

    property BannerAd: TAdBanner read GetBannerAd;
    property Rewarded: TAdBanner read GetRewarded;
    property TotalWords: Integer read GetTotalWords;
    property TotalComplete: Integer read GetTotalComplete
      write SetTotalComplete;
    property cbbLanguage: TComboBox read GetComboLanguage write FComboLanguage;
  public
    { Public declarations }
    procedure SetMeaning(Value: IMeaning);
  end;

var
  FrmSelectWords: TFrmSelectWords;

implementation

uses
  UnitConstante;

{$R *.fmx}

var
  Grab: Boolean = False;
  MovingRectangle: TRectangle;
  RectWordsBottom: array of TRectangle;

function TFrmSelectWords.FText: IText;
begin
  FText := TText.New(FMeaning.NativeLanguage);
end;

function TFrmSelectWords.GetAlign(I: Integer): TAlignLayout;
const
  FArray: Array [0 .. 3] of TAlignLayout = (TAlignLayout.Left,
    TAlignLayout.Left, TAlignLayout.Right, TAlignLayout.Right);
begin
  Result := FArray[I];
end;

function TFrmSelectWords.GetLayout(I: Integer): TLayout;
begin
  if I mod 2 = 0 then
    Result := LayTop
  else
    Result := LayBottom
end;

procedure TFrmSelectWords.AddReview(AMeaning: IMeaning;
  ALanguage: TNativeLanguage);
begin
  FHorizontalMeaning.SetMeaning(AMeaning);
  FHorizontalMeaning.AddTranslations(ALanguage)

end;

procedure TFrmSelectWords.FormCreate(Sender: TObject);
begin
  inherited;
  DisableBackButton := True;
  FHorizontalMeaning := THorizontalMeaning.Create(TabControl);
  FHorizontalMeaning.SetImageList(ilImages);
  FHorizontalMeaning.SetLay_Content(ScrollBoxReview);
  TabControl.ActiveTab := TabGame;

  SkAudio.Animation.Loop := False;
  FloatAnimation1.OnFinish := FloatAnimation1Finish;
  Lay_Form.Visible := False;
  Lay_Next.Visible := False;
  Lay_Menu.Visible := False;

  FLanguage := nlUnknow;
  RECT_WIDTH := Trunc((LayTop.Width / 2)) - 10;

  FAcertos := 0;
  FErrors := 0;
  FTotalPerRound := 0;
  lbl_Word.Text := '';
  tmrAudio.Enabled := False;
  Img_Play.ImageIndex := cImageIndexMute;
  lbl_Language.Visible := Img_Play.ImageIndex = cImageIndexMute;
  lbl_Word.Visible := Img_Play.ImageIndex = cImageIndexMute;
  SkAudio.Visible := Img_Play.ImageIndex = cImageIndexUnMute;
  gifRight.LoadFromFile(TPath.Combine(TFunctions.getPathImage, 'next.json'));

  FWordsUsed := TFDMemtable.Create(nil);
  FWordsUsed.FieldDefs.Clear;
  FWordsUsed.FieldDefs.Add('COD_WORD', ftInteger);
  FWordsUsed.FieldDefs.Add('POSITION', ftInteger);
  FWordsUsed.FieldDefs.Add('QTD', ftInteger);

  FWordsUsed.IndexDefs.Clear;
  // FWordsUsed.IndexDefs.Add('QTD_IDX', 'QTD', [ixDescending]);
  FWordsUsed.IndexDefs.Add('POSITION_IDX', 'POSITION', [ixPrimary]);
  FWordsUsed.CreateDataSet;
  FWordsUsed.LogChanges := False;
end;

procedure TFrmSelectWords.FormShow(Sender: TObject);
begin
  ExibirAds(Init, False);

end;

procedure TFrmSelectWords.Init;
begin
  // Consumir WS...
  dm.RequestDados.Params.Clear;
  dm.RequestDados.AddParameter('Id_Usuario', FMeaning.User.Id_Usuario.ToString);
  dm.RequestDados.AddParameter('subcategory',
    FMeaning.Category.id_subcategoria.ToString);
  dm.RequestDados.AddParameter('field_subcategory',
    FMeaning.NativeLanguage.Sufix);
  if getSelectLanguage <> nlAll then
    dm.RequestDados.AddParameter('native_language',
      getSelectLanguage.AsValue.ToString)
  else
    dm.RequestDados.AddParameter('native_language',
      FMeaning.NativeLanguage.AsValue.ToString);
  dm.RequestDados.AddParameter('Form', fmForm.Value);

  // faz com que rode em thread paralela
  dm.RequestDados.ExecuteAsync(ListaDados, True, True, ErroRequestTryAgain);
end;

procedure TFrmSelectWords.ErroRequestTryAgain(Sender: TObject);
var
  msg: string;
begin
  if Assigned(Sender) and (Sender is Exception) then
  begin
    ExibirCampos;
    TrataException(Sender, FText.getText404,
      procedure
      begin
        CloseApplication(Sender);
      end);
    Lbl_404TryAgain.Text := FText.getTextTryAgain;
  end;
end;

procedure TFrmSelectWords.Lay_FinishClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmSelectWords.lbl_CongratulationsClick(Sender: TObject);
begin
  inherited;
  if IsRoundFinished then
    actNext.Execute;
end;

function TFrmSelectWords.IsFinished: Boolean;
begin
  Result := (FErrors = 3) or (TotalComplete = TotalWords) or IsRoundFinished;
end;

function TFrmSelectWords.IsMute: Boolean;
begin
  Result := Img_Play.ImageIndex = cImageIndexMute;
end;

function TFrmSelectWords.IsRoundFinished: Boolean;
begin
  Result := (FTotalPerRound >= cTotalPerRound);
end;

procedure TFrmSelectWords.ListaDados;
begin
  if dm.RequestDados.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage('Erro ao listar dados: ' + dm.RequestDados.Response.StatusText);
    exit;
  end;

  Carrega_Dados(dm.RequestDados.Response.JSONValue.ToString);
  Carrega_Layout;

  ExibirCampos;
  ShowHowToPlay;
end;

procedure TFrmSelectWords.AnimaHandFinish(Sender: TObject);
begin
  AnimaHand2.Inverse := AnimaHand.Inverse;
  AnimaHand2.start;

end;

procedure TFrmSelectWords.AnimaHand2Finish(Sender: TObject);
begin
  AnimaHand.Inverse := not AnimaHand2.Inverse;
  AnimaHand.start;
end;

procedure TFrmSelectWords.AnimaMenuFinish(Sender: TObject);
begin
  Lay_Menu.Visible := not AnimaMenu.Inverse;
  img_Hand.Visible := not AnimaMenu.Inverse;

  AnimaHand.Inverse := False;
  if AnimaMenu.Inverse = True then
  begin
    AnimaHand.Stop;
  end
  else
  begin
    AnimaHand.start;
  end;

end;

procedure TFrmSelectWords.Carrega_Dados(strJson: string);
var
  JsonArray: TJsonArray;
  ArrayElement: TJSONValue;
  iContItem: Integer;
begin
  try
    iContItem := 0;
    JsonArray := TJSONObject.ParseJSONValue(strJson) as TJsonArray;
    // SortJsonArray(JsonArray);

    try
      if Assigned(JsonArray) then
      begin
        for ArrayElement in JsonArray do
        begin
          inc(iContItem);
          SetLength(FMeaningArray, iContItem);
          FMeaningArray[iContItem - 1] := TMeaning.New;
          FMeaningArray[iContItem - 1].setNativeLanguage
            (FMeaning.NativeLanguage);
          FMeaningArray[iContItem - 1].SetCodItem
            (ArrayElement.GetValue<Integer>('codItem'));
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
          FMeaningArray[iContItem - 1].SetItem(dm.ClickAudioNative);
          FMeaningArray[iContItem - 1].SetArrayLanguages
            ([nlUnknow, nlAll, FMeaning.NativeLanguage]);

          FWordsUsed.Append;
          FWordsUsed.FieldByName('COD_WORD').AsInteger :=
            ArrayElement.GetValue<Integer>('codItem');
          FWordsUsed.FieldByName('POSITION').AsInteger := iContItem - 1;
          FWordsUsed.FieldByName('QTD').AsInteger := 0;
          FWordsUsed.Post;

        end;

      end;
    finally
      TotalComplete;
      TotalWords;

      JsonArray.DisposeOf;
    end;

  except
    ShowMessage('Json array inválido');
  end;

end;

procedure TFrmSelectWords.Carrega_Layout;
begin
  Lay_Content.HitTest := False; // want to pick rectangles
  FloatAnimation1.Parent := nil;

  Rect_Finish.Visible := False;
  Rect_Next.Visible := False;
  Lay_Finish.Visible := False;

  Cria_Lista_Titulo;
  Cria_Lista_Item;
  if SkAudio.Visible then
    SkAudioClick(nil);

end;

procedure TFrmSelectWords.cbbLanguageChange(Sender: TObject);
begin
  inherited;
  if Length(FMeaningArray) > 0 then
    Carrega_Layout;
end;

function TFrmSelectWords.GetIndex: Integer;
begin
  if (TotalComplete >= Length(FMeaningArray)) then
    Result := (TotalComplete) mod Length(FMeaningArray)
  else
    Result := TotalComplete;

end;

procedure TFrmSelectWords.Cria_Lista_Titulo;
var
  ITitulo, iCount: Integer;
begin
  ITitulo := GetIndex;

  if getSelectLanguage <> nlAll then
    FLanguage := getSelectLanguage
  else
  begin
    FLanguage := FMeaning.getTranslation;

    iCount := 0;
    while (iCount < High(TNativeLanguage).AsValue) and
      (FLanguage in FMeaningArray[ITitulo].ArrayLanguages) do
    begin
      FLanguage := FMeaning.getTranslation;
      inc(iCount);
    end;

    if FLanguage in FMeaningArray[ITitulo].ArrayLanguages then
    begin
      exit;
    end;

    FMeaningArray[ITitulo].AddLanguage(FLanguage);

  end;

  if not FMeaningArray[ITitulo].Audio(FLanguage).IsEmpty then
  begin
    Rect_Word.TagString := FMeaningArray[ITitulo].getUrl_PathS3(FLanguage);
    dm.LoadAudio(MediaPlayer, Rect_Word.TagString)
  end;

  Rect_Word.Tag := FMeaningArray[ITitulo].CodItem;

  lbl_WordTranslated.Text := FMeaningArray[ITitulo].getText(FLanguage);
  lbl_Word.Text := FMeaningArray[ITitulo].getNativeLanguage;
  lbl_Language.Text := Format('(%s)', [FLanguage.Description]);
end;

procedure TFrmSelectWords.Cria_Lista_Item;
var
  I, IPos, IPos2, Min: Integer;
begin
  for I := Low(RectWordsBottom) to high(RectWordsBottom) do
    FreeAndNil(RectWordsBottom[I]);

  if Length(FMeaningArray) < MAX_RECTANGLES then
    Min := Length(FMeaningArray)
  else
    Min := MAX_RECTANGLES;

  SetLength(FListOptions, Min);

  for I := 0 to Min - 1 do
    FListOptions[I] := -1;

  if Length(RectWordsBottom) > 0 then
    SetLength(RectWordsBottom, 0);

  // Set the right word
  IPos := Random(Min);
  FListOptions[IPos] := GetIndex;

  IPos2 := 0;
  for I := 0 to Min - 1 do
  begin
    if I <> IPos then
    begin
      while TArrayUtils<Integer>.Contains(IPos2, FListOptions) do
        IPos2 := Random(Min);
      FListOptions[I] := IPos2;
    end;

  end;

  for I := 0 to Min - 1 do
    Cria_Item(I);

end;

procedure TFrmSelectWords.Cria_Item(I: Integer);
var
  TitleLabel: TLabel;
  ITitulo: Integer;
begin
  FWordsUsed.IndexName := 'POSITION_IDX';
  if FWordsUsed.FindKey([FListOptions[I]]) then
    ITitulo := FWordsUsed.FieldByName('POSITION').AsInteger
  else
    raise Exception.Create
      ('Error getting the index value in TFrmSelectWords.Cria_Item');

  FWordsUsed.Edit;
  if FWordsUsed.FieldByName('QTD').AsInteger < MAX_RECTANGLES then
    FWordsUsed.FieldByName('QTD').AsInteger := FWordsUsed.FieldByName('QTD')
      .AsInteger + 1;
  FWordsUsed.Post;

  SetLength(RectWordsBottom, Length(RectWordsBottom) + 1);
  RectWordsBottom[Length(RectWordsBottom) - 1] := TRectangle.Create(Self);
  RectWordsBottom[Length(RectWordsBottom) - 1].Parent := GetLayout(I);
  RectWordsBottom[Length(RectWordsBottom) - 1].OnClick := ClickItem;
  RectWordsBottom[Length(RectWordsBottom) - 1].Align := GetAlign(I);
  RectWordsBottom[Length(RectWordsBottom) - 1].Width := RECT_WIDTH;
  RectWordsBottom[Length(RectWordsBottom) - 1].Height := RECT_HEIGHT;
  RectWordsBottom[Length(RectWordsBottom) - 1].Tag :=
    FMeaningArray[ITitulo].CodItem;
  RectWordsBottom[Length(RectWordsBottom) - 1].fill.Kind := TBrushKind.Solid;
  RectWordsBottom[Length(RectWordsBottom) - 1].fill.Color :=
    CurrentTheme.ColorButton;
  RectWordsBottom[Length(RectWordsBottom) - 1].Stroke.Kind := TBrushKind.Solid;
  RectWordsBottom[Length(RectWordsBottom) - 1].Stroke.Color :=
    TAlphaColorRec.Gray;
  RectWordsBottom[Length(RectWordsBottom) - 1].TagFloat := FLanguage.AsValue;
  RectWordsBottom[Length(RectWordsBottom) - 1].XRadius := XRadius;
  RectWordsBottom[Length(RectWordsBottom) - 1].YRadius := YRadius;

  TitleLabel := TLabel.Create(Self);
  TitleLabel.Parent := RectWordsBottom[Length(RectWordsBottom) - 1];
  TitleLabel.Align := TAlignLayout.Client;
  TitleLabel.StyledSettings := [];
  TitleLabel.Font.Size := 16;
  TitleLabel.Text := FMeaningArray[ITitulo].getText(FLanguage);
  TitleLabel.TextSettings.HorzAlign := TTextAlign.Center;
  TitleLabel.TextSettings.FontColor := $FF353535; // $FFEABC1B;
  RectWordsBottom[Length(RectWordsBottom) - 1].AddObject(TitleLabel);
end;

procedure TFrmSelectWords.ExibirCampos(pShow: Boolean);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          if Application.MainForm = FrmMeaning then
            exit;

          SkLoading.Visible := not pShow;
          SkLoading.Enabled := SkLoading.Visible;
          Lay_Form.Visible := pShow;

          if Lay_Form.Visible and (Lay_Form.Opacity <> 1) then
            Lay_Form.Opacity := 1;
        end);

    end).start;
end;

procedure TFrmSelectWords.SetMeaning(Value: IMeaning);
begin
  DisableBackButton := True;
  FMeaning := Value;
  FMeaning.ResetValues;
  FMeaning.SetItem(dm.ClickAudioNative);

  Popula_Combo(False);

  lbl_Title_SelectWords.Text := FText.getTextSelectWords;
  lbl_loading.Text := FText.getTextLoading;
  lbl_TheWordIs.Text := FText.getTextTheWordIs;
  lbl_Next.Text := FText.getTextNext;
  lbl_PlayAgain.Text := FText.getTextPlayAgain;
  lbl_No.Text := FText.getTextNo;
  lbl_Yes.Text := FText.getTextYes;
end;

function TFrmSelectWords.getSelectLanguage: TNativeLanguage;
begin
  Result := TNativeLanguage.Parse_Value
    (cbbLanguage.ListItems[cbbLanguage.ItemIndex].Tag);
end;

procedure TFrmSelectWords.ShowHowToPlay;
begin
  Lay_Menu.BringToFront;
  Lay_Menu.Position.Y := Self.Height + 20;
  Lay_Menu.Visible := True;

  AnimaMenu.Inverse := False;
  AnimaMenu.StartValue := 20; // Self.Height + 20;
  AnimaMenu.StopValue := 0;
  AnimaMenu.start;

end;

procedure TFrmSelectWords.FechaMenu(Sender: TObject);
begin
  AnimaMenu.Inverse := True;
  AnimaMenu.start;
  DisableBackButton := False;
end;

procedure TFrmSelectWords.ClickItem(Sender: TObject);
begin
  MovingRectangle := Sender as TRectangle;

  if MovingRectangle.Tag = Rect_Word.Tag then
  begin
    dm.PlayRightAudio;
    FloatAnimation1.Parent := MovingRectangle;
    FloatAnimation1.start;

    AnimationForm.Inverse := False;
    AnimationForm.start;

  end
  else
  begin
    dm.PlayErrorAudio;
    MovingRectangle.Stroke.Kind := TBrushKind.Solid;
    MovingRectangle.Stroke.Color := TAlphaColorRec.Red;

    if FErrors < 3 then
      inc(FErrors);

    if FErrors = 1 then
    begin
      SkStars.Animation.Stop;
      SkStars.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
        '2stars.json'));
      SkStars.Animation.start;
    end
    else if FErrors = 2 then
    begin
      SkStars.Animation.Stop;
      SkStars.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
        '1star.json'));
      SkStars.Animation.start;
    end
    else if FErrors = 3 then
    begin
      AnimationForm.Inverse := False;
      AnimationForm.start;

    end;
  end;

end;

procedure TFrmSelectWords.ShowFinish;
var
  bAllLanguagesFinished: Boolean;

  function IsAllLanguagesFinished: Boolean;
  var
    ta: TNativeLanguage;
  begin
    if getSelectLanguage = nlAll then
      Result := FTotalComplete[nlAll.AsByte] = FTotalWords[nlAll.AsByte]
    else
    begin
      Result := True;
      for ta := low(TNativeLanguage) to high(TNativeLanguage) do
      begin
        if (ta <> nlUnknow) and (ta <> nlAll) and
          (ta <> FMeaning.NativeLanguage) and
          (FTotalComplete[ta.AsByte] <> FTotalWords[ta.AsByte]) then
        begin
          Result := False;
          exit;
        end;
      end;
    end;
  end;

begin
  bAllLanguagesFinished := IsAllLanguagesFinished;
  Rect_Finish.Visible := True;
  Rect_Next.Visible := False;
  gifCongratulations.Animation.Stop;
  if FErrors = 3 then
  begin
    gifCongratulations.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
      'sad-star.json'));

    lbl_Congratulations.Text := '';
  end
  else
  begin
    gifCongratulations.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
      'happy-star.json'));

    if IsRoundFinished then
      lbl_Congratulations.Text := FText.getTextToReviewWords
    else
      lbl_Congratulations.Text := FText.getTextCongratulations;

  end;
  gifCongratulations.Animation.start;
  if (FErrors = 3) then
    lbl_YouGotPoints.Text := Format(FText.getTextYouGotPointsTryAgain,
      [FAcertos])
  else if bAllLanguagesFinished then
    lbl_YouGotPoints.Text := FText.getTextYouCompleteAllWords
  else if TotalComplete = TotalWords then
    lbl_YouGotPoints.Text := FText.getTextYouCompleteThisLanguage
  else
    lbl_YouGotPoints.Text := Format(FText.getTextYouGotPoints, [FAcertos]);

  Rect_PlayAgain.Visible := not bAllLanguagesFinished;
  Lay_Finish.Visible := bAllLanguagesFinished;

  if Rect_PlayAgain.Visible then
  begin
    if (not bAllLanguagesFinished) and (getSelectLanguage <> nlAll) then
      lbl_PlayAgain.Text := FText.getTextContinueAnotherLanguage
    else if (FErrors = 3) then
      lbl_PlayAgain.Text := FText.getTextPlayAgain
    else
      lbl_PlayAgain.Text := FText.getTextLetsContinue
  end;

  dm.PlayDoneAudio;
end;

procedure TFrmSelectWords.ShowNext;
begin
  Rect_Next.Visible := True;
  Rect_Finish.Visible := False;

  gifRight.Animation.Stop;
  gifRight.Animation.start;
  dm.PlayDoneAudio;

end;

procedure TFrmSelectWords.SkAudioClick(Sender: TObject);
begin
  inherited;
  SkAudio.Animation.start;
  SkAudio.Animation.Loop := True;
  tmrAudio.Enabled := True;
  TMediaPlayerThread.WaitForThread;
  TMediaPlayerThread.Create(MediaPlayerNative,
    FMeaningArray[GetIndex].getUrl_PathS3(FMeaning.NativeLanguage)).start;
end;

procedure TFrmSelectWords.tmrAudioTimer(Sender: TObject);
begin
  inherited;
  SkAudio.Animation.Loop := False;
  SkAudio.Animation.Stop;
  tmrAudio.Enabled := False;
end;

procedure TFrmSelectWords.AnimationFormFinish(Sender: TObject);
begin
  if AnimationForm.Inverse = False then
  begin
    Lay_Form.Visible := False;
    Lay_Form.SendToBack;

    Lay_Next.Visible := True;
    Lay_Next.BringToFront;

    if (FErrors < 3) then // acertou
    begin
      if getSelectLanguage <> nlAll then
      begin
        dm.RequestMeaningProximo.Params.Clear;
        dm.RequestMeaningProximo.AddParameter('Language',
          MovingRectangle.TagFloat.ToString);
        dm.RequestMeaningProximo.AddParameter('id_word',
          MovingRectangle.Tag.ToString);
        dm.RequestMeaningProximo.AddParameter('Id_Usuario',
          FMeaning.User.Id_Usuario.ToString);
        dm.RequestMeaningProximo.AddParameter('screen', fmForm.Value);
        dm.RequestMeaningProximo.ExecuteAsync(CheckWordSave, True, True,
          ErroRequestTryAgain);

        if FMeaning.Category.percent_complete(fmForm, FLanguage) < 100 then
          FMeaning.Category.IncTotal(fmForm, FLanguage);
      end;

      AddReview(FMeaningArray[GetIndex], FLanguage);

      TotalComplete := TotalComplete + 1;
      inc(FAcertos);
      inc(FTotalPerRound);
      lbl_Points.Text := FAcertos.ToString + 'pts';

    end;

    if IsFinished then
      ShowFinish
    else
      ShowNext;

    AnimaMessage.Inverse := False;
    AnimaMessage.start;
  end
  else
  begin
    AnimaMessage.Inverse := True;
    AnimaMessage.start;
  end;
end;

procedure TFrmSelectWords.Next_ButtonClick(Sender: TObject);
begin
  if IsFinished then
  begin
    ShowFinish;
  end
  else
  begin
    Lay_Next.Visible := False;
    Lay_Next.SendToBack;
    Popula_Combo(True);
    Carrega_Layout;

    Lay_Form.Visible := True;
    Lay_Form.BringToFront;

    AnimationForm.Inverse := True;
    AnimationForm.start;
  end;

end;

procedure TFrmSelectWords.CheckWordSave;
var
  jsonObj: TJSONObject;
  JSON, sucesso, erro: string;
begin
  if dm.RequestMeaningProximo.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage('Error Saving Word: ' + dm.RequestMeaningProximo.Response.
      StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestMeaningProximo.Response.JSONValue.ToString;
    // pega o json do request
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
  end;

end;

procedure TFrmSelectWords.RectImgPlayClick(Sender: TObject);
begin
  inherited;
  if IsMute then
  begin
    Img_Play.ImageIndex := cImageIndexUnMute;
  end
  else
    Img_Play.ImageIndex := cImageIndexMute;

  lbl_Language.Visible := Img_Play.ImageIndex = cImageIndexMute;
  lbl_Word.Visible := Img_Play.ImageIndex = cImageIndexMute;
  SkAudio.Visible := Img_Play.ImageIndex = cImageIndexUnMute;

  if SkAudio.Visible then
    SkAudioClick(Sender);
end;

procedure TFrmSelectWords.Rect_ExitClick(Sender: TObject);
begin
  inherited;
  actLast.Execute;
end;

procedure TFrmSelectWords.Rect_FinishClick(Sender: TObject);
begin
  inherited;
  if Lay_Finish.Visible then
    Close;
end;

procedure TFrmSelectWords.Rect_NoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmSelectWords.Rect_WordClick(Sender: TObject);
begin
  dm.PlayAudio(MediaPlayer);
end;

procedure TFrmSelectWords.Rect_YesClick(Sender: TObject);
begin
  inherited;
  ExibirAds(Reload);

  Lay_Form.Visible := True;
  Lay_Form.BringToFront;

  // 0 to 1 - invisible to visible
  AnimationForm.Inverse := True;
  AnimationForm.start;
end;

procedure TFrmSelectWords.Reload;
var
  ITitulo: Integer;
begin
  if getSelectLanguage = nlAll then
    FMeaningArray[GetIndex].RemoveLastLanguage;

  if IsRoundFinished then
  begin
    FTotalPerRound := 0;
    FHorizontalMeaning.DeleteItem;
  end
  else
  begin
    FErrors := 0;

    SkStars.Animation.Stop;
    SkStars.LoadFromFile(TPath.Combine(TFunctions.getPathImage, '3stars.json'));
    SkStars.Animation.start;
  end;

  ITitulo := GetIndex;
  FWordsUsed.IndexName := 'POSITION_IDX';
  if FWordsUsed.FindKey([ITitulo]) then
  begin
    FWordsUsed.Edit;
    FWordsUsed.FieldByName('QTD').AsInteger := FWordsUsed.FieldByName('QTD')
      .AsInteger - 1;
    FWordsUsed.Post;
  end;

  Popula_Combo(getSelectLanguage = nlAll);
  Carrega_Layout;
end;

procedure TFrmSelectWords.FloatAnimation1Finish(Sender: TObject);
begin
  if MovingRectangle.Stroke.Color <> TAlphaColorRec.Red then
    MovingRectangle.SendToBack;
end;

procedure TFrmSelectWords.ExibirAds(Proc: TProc; EnableRewarded: Boolean = True;
EnableBanner: Boolean = True);
var
  t: TThread;
begin
  ExibirCampos(False);

  t := TThread.CreateAnonymousThread(
    procedure
    begin
      if Assigned(Proc) then
        Proc;

      {
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
        try
        if (FMeaning.EnableAds) then
        begin
        if EnableBanner then
        BannerAd.show(IsDebuging, TAlignLayout.MostBottom);

        if EnableRewarded then
        Rewarded.show(IsDebuging);
        end;

        except
        end;
        end); }
    end);
  t.start;
end;

function TFrmSelectWords.GetBannerAd: TAdBanner;
begin
  if not Assigned(FBannerAd) then
  begin
    FBannerAd := TAdBanner.Create(Lay_Form, TFunctions.AppIDBanner,
      TAdBannerType.Banner);
  end;

  Result := FBannerAd;
end;

function TFrmSelectWords.GetComboLanguage: TComboBox;
begin
  if not Assigned(FComboLanguage) then
  begin
    FComboLanguage := TComboBox.Create(Self);
    FComboLanguage.Parent := Lay_Bottom;
    FComboLanguage.Align := TAlignLayout.Left;
    FComboLanguage.Images := ilImages;
    FComboLanguage.Margins.Top := 10;
    FComboLanguage.Position.Y := 14;
    FComboLanguage.Size.Width := 257;
    FComboLanguage.Size.Height := 32;
    FComboLanguage.Size.PlatformDefault := False;
    FComboLanguage.StyleLookup := 'ComboStyle';
    Lay_Bottom.AddObject(FComboLanguage);
  end;

  Result := FComboLanguage;
end;

function TFrmSelectWords.GetRewarded: TAdBanner;
begin
  if not Assigned(FRewarded) then
  begin
    FRewarded := TAdBanner.Create(Lay_Form, TFunctions.AppIDRewarded,
      TAdBannerType.Rewarded);
    Result := FRewarded;
  end
  else
    Result := FRewarded;
end;

procedure TFrmSelectWords.Popula_Combo(pOriginalItemIndex: Boolean = False);
var
  AItemIndex: Integer;
begin
  try
    AItemIndex := 0;
    if Assigned(FComboLanguage) then
    begin
      AItemIndex := FComboLanguage.ItemIndex;
      FreeAndNil(FComboLanguage);
    end;

    cbbLanguage.ItemIndex := AItemIndex;
    cbbLanguage.OnChange := nil;
    TNativeLanguage.Popula_Combo(FComboLanguage, $FFB0BAC9, FMeaning, fmForm,
      True, pOriginalItemIndex);
  finally
    cbbLanguage.OnChange := cbbLanguageChange;
  end;
end;

function TFrmSelectWords.GetTotalComplete: Integer;
var
  ta: TNativeLanguage;
  Total: Integer;
begin
  if Length(FTotalComplete) = 0 then
  begin
    SetLength(FTotalComplete, High(FMeaning.NativeLanguage).AsByte + 1);
    for ta := low(TNativeLanguage) to high(TNativeLanguage) do
    begin
      if getSelectLanguage <> nlAll then
      begin
        Total := FMeaning.Category.total_complete(fmForm, ta);
        FTotalComplete[ta.AsByte] := Total;
      end;
    end;

    FTotalComplete[nlAll.AsByte] := 0;

  end;

  Result := FTotalComplete[getSelectLanguage.AsByte];

end;

procedure TFrmSelectWords.SetTotalComplete(const Value: Integer);
begin
  FTotalComplete[getSelectLanguage.AsByte] := Value;
end;

function TFrmSelectWords.GetTotalWords: Integer;
var
  ta: TNativeLanguage;
begin
  if Length(FTotalWords) = 0 then
  begin
    if Length(FMeaningArray) = 0 then
      raise Exception.Create('Something went wrong! ' + sLineBreak +
        'Error executing function GetTotalWords');
    SetLength(FTotalWords, High(FMeaning.NativeLanguage).AsByte + 1);
    for ta := low(TNativeLanguage) to high(TNativeLanguage) do
    begin
      if ta = nlAll then
        FTotalWords[ta.AsByte] := Length(FMeaningArray) * cQtdLanguages
      else
        FTotalWords[ta.AsByte] := Length(FMeaningArray);
    end;
  end;

  Result := FTotalWords[getSelectLanguage.AsByte];

end;

procedure TFrmSelectWords.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  SkStars.Enabled := False;
  gifCongratulations.Enabled := False;
  gifRight.Enabled := False;

  for I := Low(RectWordsBottom) to high(RectWordsBottom) do
    FreeAndNil(RectWordsBottom[I]);
  SetLength(RectWordsBottom, 0);

  if Assigned(FHorizontalMeaning) then
    FHorizontalMeaning.DisposeOf;

  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  if Assigned(FWordsUsed) then
    FreeAndNil(FWordsUsed);

  Action := TCloseAction.caFree;
  FrmSelectWords := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.show;
end;

end.
