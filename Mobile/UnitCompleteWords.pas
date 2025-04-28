unit UnitCompleteWords;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, AdMob113, uEnum, uEnum.Helper, uClassMeaning,
  uClassMeaning.Intf, uHorizontalMeaning,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  FireDAC.Comp.Client, UnitDM, System.JSON, uFunctions, UnitPadrao,
  System.Generics.Collections, System.Generics.Defaults, Data.DB, uArrayUtils,
  UnitMeaning, uClassTexts, FMX.Media, System.IOUtils, uMediaPlayerThread,
  FMX.ListBox, FMX.Skia, System.ImageList, FMX.ImgList, FMX.TabControl,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, FMX.Gestures,
  System.Actions, FMX.ActnList, Skia, FMX.Memo.Types, FMX.Memo;

const
  fmForm = fmCompleteWords;
  KEY_SPACE = ' ';
  MARGIN_LEFT = 5;
  MARGIN_TOP = 10;
  RECT_HEIGHT = 50;

type
  TMeaningArray = array of IMeaning;
  TArrayInteger = array of Integer;

  TFrmCompleteWords = class(TFrmPadrao)
    LayoutContent: TLayout;
    lbl_Title_CompleteWords: TLabel;
    lbl_Points: TLabel;
    lbl_loading: TLabel;
    LayoutTop: TLayout;
    FloatAnimation1: TFloatAnimation;
    Lay_Menu: TLayout;
    AnimaMenu: TFloatAnimation;
    Rect_Menu: TRectangle;
    img_Hand: TImage;
    AnimaHand: TFloatAnimation;
    lbl_Word: TLabel;
    lbl_Language: TLabel;
    LayoutHeader: TLayout;
    AnimationForm: TFloatAnimation;
    Lay_Form: TLayout;
    Rect_Next: TRectangle;
    AnimaMessage: TFloatAnimation;
    Lay_Next: TLayout;
    lbl_TheWordIs: TLabel;
    lbl_WordTranslated: TLabel;
    Next_Button: TRectangle;
    lbl_Next: TLabel;
    gifRight: TSkAnimatedImage;
    Rect_Finish: TRectangle;
    lbl_PlayAgain: TLabel;
    Rect_Word: TRectangle;
    Lay_Bottom: TLayout;
    Next_Body: TRectangle;
    Lay_Word: TLayout;
    SkAudio: TSkAnimatedImage;
    tmrAudio: TTimer;
    RectImgPlay: TRectangle;
    Img_Play: TGlyph;
    MediaPlayer: TMediaPlayer;
    MediaPlayerNative: TMediaPlayer;
    Rect_Yes: TRectangle;
    lbl_Yes: TLabel;
    Rect_No: TRectangle;
    lbl_No: TLabel;
    Rect_PlayAgain: TRectangle;
    lbl_Congratulations: TLabel;
    lbl_YouGotPoints: TLabel;
    SkStars: TSkAnimatedImage;
    gifCongratulations: TSkAnimatedImage;
    TabControl: TTabControl;
    TabGame: TTabItem;
    TabReview: TTabItem;
    Lay_ReviewTop: TLayout;
    Img_Exit: TGlyph;
    Rect_Exit: TRectangle;
    Lay_ReviewTop2: TLayout;
    lbl_ReviewLastWordsThisRound: TLabel;
    Lbl_Review: TLabel;
    ActionList: TActionList;
    actLast: TChangeTabAction;
    actNext: TChangeTabAction;
    ScrollBoxReview: TScrollBox;
    Lay_Finish: TLayout;
    procedure Rectangle1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure LayoutContentMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    // procedure LayoutContentMouseUpNew(Sender: TObject; Button: TMouseButton;
    // Shift: TShiftState; X, Y: Single);
    procedure LayoutContentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ListaDados;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnimaMenuFinish(Sender: TObject);
    procedure FechaMenu(Sender: TObject);
    procedure AnimaHandFinish(Sender: TObject);
    procedure Next_ButtonClick(Sender: TObject);
    procedure AnimationFormFinish(Sender: TObject);
    procedure Rect_WordClick(Sender: TObject);
    procedure SkAudioClick(Sender: TObject);
    procedure tmrAudioTimer(Sender: TObject);
    procedure RectImgPlayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbLanguageChange(Sender: TObject);
    procedure Rect_NoClick(Sender: TObject);
    procedure Rect_YesClick(Sender: TObject);
    procedure TabControlGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure lbl_CongratulationsClick(Sender: TObject);
    procedure Rect_ExitClick(Sender: TObject);
    procedure Lay_FinishClick(Sender: TObject);
    procedure Rect_FinishClick(Sender: TObject);
  private
    { Private declarations }
    FHorizontalMeaning: THorizontalMeaning;
    MAX_RECTANGLES: Integer;
    FStr: TArray<string>;
    RECT_WIDTH: Integer;
    FMeaning: IMeaning;
    FLanguage: TNativeLanguage;
    FMeaningArray: TMeaningArray;
    FTotalLetters, FTotalPerRound, FAcertos, FErrors: Integer;
    FBannerAd, FRewarded: TAdBanner;
    FTotalWords, FTotalComplete: TArrayInteger;
    FComboLanguage: TComboBox;
    function GetIndex: Integer;
    procedure Init;
    procedure ExibirCampos(pShow: Boolean = True);
    procedure Carrega_Dados(strJson: string);
    procedure Carrega_Layout;
    procedure Cria_Lista_Titulo;
    procedure Cria_Titulo(I: Integer);
    procedure Cria_Lista_Item;
    procedure Cria_Item(I: Integer);
    function FText: IText;
    procedure CheckWordSave;
    procedure ShowHowToPlay;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure Right(Rect: TRectangle);
    procedure Wrong(Rect: TRectangle);
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
    function IsFinished: Boolean;
    function IsRoundFinished: Boolean;
    procedure SetTotalComplete(const Value: Integer);
    procedure Popula_Combo(pOriginalItemIndex: Boolean = False);
    procedure AddReview(AMeaning: IMeaning; ALanguage: TNativeLanguage);
    // procedure LoadLog;
    function GetComboLanguage: TComboBox;
    procedure ErroRequestTryAgain(Sender: TObject);

    property BannerAd: TAdBanner read GetBannerAd;
    property Rewarded: TAdBanner read GetRewarded;
    property TotalWords: Integer read GetTotalWords;
    property TotalComplete: Integer read GetTotalComplete
      write SetTotalComplete;
    property cbbLanguage: TComboBox read GetComboLanguage write FComboLanguage;

  protected
    { Protected declarations }
    procedure SetColors; override;
  public
    { Public declarations }
    procedure SetMeaning(Value: IMeaning);
  end;

var
  FrmCompleteWords: TFrmCompleteWords;

implementation

uses
  UnitConstante, StrUtils, System.Math;

{$R *.fmx}

var
  Grab: Boolean = False;
  Offset: TPointF;
  MovingRectangle: TRectangle;
  LayWordsTop: array of TRectangle;
  RectWordsBottom: array of TRectangle;
  RectWordsTop: array of TRectangle;

function TFrmCompleteWords.FText: IText;
begin
  FText := TText.New(FMeaning.NativeLanguage);
end;

function TFrmCompleteWords.GetIndex: Integer;
begin
  if (TotalComplete >= Length(FMeaningArray)) then
    Result := (TotalComplete) mod Length(FMeaningArray)
  else
    Result := TotalComplete;
end;

function TFrmCompleteWords.getSelectLanguage: TNativeLanguage;
begin
  Result := TNativeLanguage.Parse_Value
    (cbbLanguage.ListItems[cbbLanguage.ItemIndex].Tag);
end;

procedure TFrmCompleteWords.AddReview(AMeaning: IMeaning;
  ALanguage: TNativeLanguage);
begin
  FHorizontalMeaning.SetMeaning(AMeaning);
  FHorizontalMeaning.AddTranslations(ALanguage)

end;

procedure TFrmCompleteWords.FormCreate(Sender: TObject);
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
  lbl_Word.Text := '';
  FTotalPerRound := 0;
  FAcertos := 0;
  FErrors := 0;
  tmrAudio.Enabled := False;
  Img_Play.ImageIndex := cImageIndexMute;
  lbl_Language.Visible := Img_Play.ImageIndex = cImageIndexMute;
  lbl_Word.Visible := Img_Play.ImageIndex = cImageIndexMute;
  SkAudio.Visible := Img_Play.ImageIndex = cImageIndexUnMute;
  gifRight.LoadFromFile(TPath.Combine(TFunctions.getPathImage, 'next.json'));
end;

procedure TFrmCompleteWords.FormShow(Sender: TObject);
begin
  ExibirAds(Init, False);
end;

procedure TFrmCompleteWords.Init;
begin
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

procedure TFrmCompleteWords.ErroRequestTryAgain(Sender: TObject);
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

function TFrmCompleteWords.IsMute: Boolean;
begin
  Result := Img_Play.ImageIndex = cImageIndexMute;
end;

procedure TFrmCompleteWords.ListaDados;
begin

  // Consumir WS...
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

procedure TFrmCompleteWords.AnimaHandFinish(Sender: TObject);
begin
  AnimaHand.start;
end;

procedure TFrmCompleteWords.AnimaMenuFinish(Sender: TObject);
begin
  Lay_Menu.Visible := not AnimaMenu.Inverse;
  img_Hand.Visible := not AnimaMenu.Inverse;

  if AnimaMenu.Inverse = True then
  begin
    AnimaHand.Stop;
  end
  else
  begin
    AnimaHand.start;
  end;

end;

procedure TFrmCompleteWords.Carrega_Dados(strJson: string);
var
  JsonArray: TJsonArray;
  ArrayElement: TJSONValue;
  iContItem: Integer;
begin
  try
    iContItem := 0;
    JsonArray := TJSONObject.ParseJSONValue(strJson) as TJsonArray;

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

procedure TFrmCompleteWords.Carrega_Layout;
var
  I: Integer;
begin
  LayoutContent.HitTest := False; // want to pick rectangles
  FloatAnimation1.Parent := nil;

  for I := Low(RectWordsTop) to high(RectWordsTop) do
    FreeAndNil(RectWordsTop[I]);

  if Length(RectWordsTop) > 0 then
    SetLength(RectWordsTop, 0);

  for I := Low(LayWordsTop) to high(LayWordsTop) do
    FreeAndNil(LayWordsTop[I]);

  if Length(LayWordsTop) > 0 then
    SetLength(LayWordsTop, 0);

  FMeaning.SetArrayLanguages([nlUnknow, nlAll, FMeaning.NativeLanguage]);

  Rect_Finish.Visible := False;
  Rect_Next.Visible := False;

  Cria_Lista_Titulo;
  Cria_Lista_Item;

end;

procedure TFrmCompleteWords.cbbLanguageChange(Sender: TObject);
begin
  inherited;
  if Length(FMeaningArray) > 0 then
    Carrega_Layout;
end;

function TFrmCompleteWords.GetTotalComplete: Integer;
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

procedure TFrmCompleteWords.SetTotalComplete(const Value: Integer);
begin
  FTotalComplete[getSelectLanguage.AsByte] := Value;
end;

function TFrmCompleteWords.GetTotalWords: Integer;
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

procedure TFrmCompleteWords.ShowFinish;
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

procedure TFrmCompleteWords.ShowNext;
begin
  Rect_Next.Visible := True;
  Rect_Finish.Visible := False;
  dm.PlayDoneAudio;

  gifRight.Animation.Stop;
  gifRight.Animation.start;

  gifRight.Visible := True;
  gifRight.Enabled := gifRight.Visible;
end;

procedure TFrmCompleteWords.SkAudioClick(Sender: TObject);
begin
  inherited;
  SkAudio.Animation.start;
  SkAudio.Animation.Loop := True;
  tmrAudio.Enabled := True;
  TMediaPlayerThread.WaitForThread;
  TMediaPlayerThread.Create(MediaPlayerNative,
    FMeaningArray[GetIndex].getUrl_PathS3(FMeaning.NativeLanguage)).start;

end;

procedure TFrmCompleteWords.TabControlGesture(Sender: TObject;
const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
  case EventInfo.GestureID of
    sgiLeft:
      begin
        TabControl.Next(TTabTransition.Slide, TTabTransitionDirection.Normal);
        Handled := True;
      end;
    sgiRight:
      begin
        TabControl.Last(TTabTransition.Slide, TTabTransitionDirection.Normal);
        Handled := True;
      end;
  end;
end;

procedure TFrmCompleteWords.tmrAudioTimer(Sender: TObject);
begin
  inherited;
  SkAudio.Animation.Loop := False;
  SkAudio.Animation.Stop;
  tmrAudio.Enabled := False;
end;

procedure TFrmCompleteWords.Cria_Lista_Titulo;
var
  I, FLayCount, ITitulo, iCount: Integer;
  sWord: string;
begin
  ITitulo := GetIndex;
  try
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
      dm.LoadAudio(MediaPlayer, Rect_Word.TagString);
    end;

    sWord := FMeaningArray[ITitulo].getText(FLanguage);
    lbl_WordTranslated.Text := sWord;
    lbl_Word.Text := FMeaningArray[ITitulo].getNativeLanguage;
    lbl_Language.Text := Format('(%s)', [FMeaning.getLanguage(FLanguage)]);

    if (FMeaning.TypeCateg = csPhrase) and (sWord.Contains(KEY_SPACE)) then
    begin
      MAX_RECTANGLES := 4;
      FStr := SplitString(lbl_WordTranslated.Text, KEY_SPACE);
      FLayCount := Trunc(Length(FStr) / MAX_RECTANGLES);
    end
    else
    begin
      MAX_RECTANGLES := 8;
      SetLength(FStr, Length(lbl_WordTranslated.Text));
      for I := 0 to Length(lbl_WordTranslated.Text) - 1 do
        FStr[I] := lbl_WordTranslated.Text[I + 1];
      FLayCount := Trunc(Length(FStr) / MAX_RECTANGLES);
    end;

    RECT_WIDTH := Trunc(Lay_Form.Width / MAX_RECTANGLES) - MARGIN_LEFT;

    SetLength(LayWordsTop, FLayCount + 1);

    LayoutTop.Height := (RECT_HEIGHT + MARGIN_TOP) * (FLayCount + 1);

    for I := FLayCount downto 0 do
    begin
      LayWordsTop[I] := TRectangle.Create(Self);
      LayWordsTop[I].Parent := LayoutTop;
      LayWordsTop[I].Align := TAlignLayout.Top;
      LayWordsTop[I].Margins.Top := MARGIN_TOP;
      LayWordsTop[I].Stroke.Kind := TBrushKind.None;
      LayWordsTop[I].Fill.Kind := TBrushKind.None;
      LayWordsTop[I].XRadius := XRadius;
      LayWordsTop[I].YRadius := YRadius;
      LayoutTop.AddObject(LayWordsTop[I]);
    end;

    for I := Length(FStr) - 1 downto 0 do
      Cria_Titulo(I);
  finally
    if SkAudio.Visible then
    begin
      // Sleep(500);
      SkAudioClick(nil);
    end;
  end;

end;

procedure TFrmCompleteWords.Cria_Titulo(I: Integer);
var
  TitleLabel: TLabel;
begin
  SetLength(RectWordsTop, Length(RectWordsTop) + 1);
  RectWordsTop[Length(RectWordsTop) - 1] := TRectangle.Create(Self);
  RectWordsTop[Length(RectWordsTop) - 1].Parent :=
    LayWordsTop[Trunc(I / MAX_RECTANGLES)];
  RectWordsTop[Length(RectWordsTop) - 1].Align := TAlignLayout.MostLeft;
  RectWordsTop[Length(RectWordsTop) - 1].Margins.Left := MARGIN_LEFT;
  RectWordsTop[Length(RectWordsTop) - 1].Height := RECT_HEIGHT;
  RectWordsTop[Length(RectWordsTop) - 1].Width := RECT_WIDTH;
  RectWordsTop[Length(RectWordsTop) - 1].TagString := FStr[I];
  RectWordsTop[Length(RectWordsTop) - 1].Tag := I + 1;
  // RectWordsTop[Length(RectWordsTop) - 1].Fill.Kind := TBrushKind.None;
  RectWordsTop[Length(RectWordsTop) - 1].Fill.Kind := TBrushKind.Solid;
  RectWordsTop[Length(RectWordsTop) - 1].Fill.Color :=
    CurrentTheme.ColorRecLanguage;

  RectWordsTop[Length(RectWordsTop) - 1].Stroke.Kind := TBrushKind.Solid;
  RectWordsTop[Length(RectWordsTop) - 1].Stroke.Color := TAlphaColorRec.White;
  RectWordsTop[Length(RectWordsTop) - 1].XRadius := XRadius;
  RectWordsTop[Length(RectWordsTop) - 1].YRadius := YRadius;

  TitleLabel := TLabel.Create(Self);
  TitleLabel.Parent := RectWordsTop[Length(RectWordsTop) - 1];
  TitleLabel.Align := TAlignLayout.Client;
  TitleLabel.StyledSettings := [];
  TitleLabel.Font.Size := 16;
  TitleLabel.Text := FStr[I];
  TitleLabel.TextSettings.HorzAlign := TTextAlign.Center;
  TitleLabel.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  TitleLabel.Visible := False;
  RectWordsTop[Length(RectWordsTop) - 1].AddObject(TitleLabel);

  LayWordsTop[Trunc(I / MAX_RECTANGLES)
    ].AddObject(RectWordsTop[Length(RectWordsTop) - 1]);
end;

procedure TFrmCompleteWords.Cria_Lista_Item;
var
  I: Integer;
begin
  for I := Low(RectWordsBottom) to high(RectWordsBottom) do
    FreeAndNil(RectWordsBottom[I]);

  if Length(RectWordsBottom) > 0 then
    SetLength(RectWordsBottom, 0);

  FTotalLetters := 0;

  for I := Length(FStr) - 1 downto 0 do
    Cria_Item(I);

end;

procedure TFrmCompleteWords.Cria_Item(I: Integer);
var
  TitleLabel: TLabel;
begin
  SetLength(RectWordsBottom, Length(RectWordsBottom) + 1);
  RectWordsBottom[Length(RectWordsBottom) - 1] := TRectangle.Create(Self);
  RectWordsBottom[Length(RectWordsBottom) - 1].Parent := LayoutContent;
  RectWordsBottom[Length(RectWordsBottom) - 1].BringToFront;
  RectWordsBottom[Length(RectWordsBottom) - 1].OnMouseDown :=
    Rectangle1MouseDown;
  RectWordsBottom[Length(RectWordsBottom) - 1].OnMouseUp :=
    LayoutContentMouseUp;
  RectWordsBottom[Length(RectWordsBottom) - 1].Width := RECT_WIDTH;
  RectWordsBottom[Length(RectWordsBottom) - 1].Height := RECT_HEIGHT;
  RectWordsBottom[Length(RectWordsBottom) - 1].TagString := FStr[I];
  RectWordsBottom[Length(RectWordsBottom) - 1].Tag := I + 1;
  RectWordsBottom[Length(RectWordsBottom) - 1].Fill.Kind := TBrushKind.Solid;
  RectWordsBottom[Length(RectWordsBottom) - 1].Fill.Color :=
    CurrentTheme.ColorButton;
  RectWordsBottom[Length(RectWordsBottom) - 1].Stroke.Kind := TBrushKind.None;
  RectWordsBottom[Length(RectWordsBottom) - 1].XRadius := XRadius;
  RectWordsBottom[Length(RectWordsBottom) - 1].YRadius := YRadius;
  RectWordsBottom[Length(RectWordsBottom) - 1].Position.X :=
    Random(Trunc(LayoutContent.Width - RECT_WIDTH));
  RectWordsBottom[Length(RectWordsBottom) - 1].Position.Y :=
    RandomRange(RECT_HEIGHT + 10, Trunc(LayoutContent.Height - RECT_HEIGHT));

  TitleLabel := TLabel.Create(Self);
  TitleLabel.Parent := RectWordsBottom[Length(RectWordsBottom) - 1];
  TitleLabel.Align := TAlignLayout.Client;
  TitleLabel.StyledSettings := [];
  TitleLabel.Font.Size := 16;
  TitleLabel.Text := FStr[I];
  TitleLabel.HitTest := False;
  TitleLabel.TextSettings.HorzAlign := TTextAlign.Center;
  TitleLabel.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  RectWordsBottom[Length(RectWordsBottom) - 1].AddObject(TitleLabel);
end;

procedure TFrmCompleteWords.ExibirCampos(pShow: Boolean);
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
          Application.ProcessMessages;
        end);

    end).start;
end;

procedure TFrmCompleteWords.SetColors;
begin
  inherited;
  Next_Button.Fill.Color := CurrentTheme.ColorButton;
  Rect_No.Fill.Color := CurrentTheme.ColorButton;
  Rect_Yes.Fill.Color := CurrentTheme.ColorButton;
end;

procedure TFrmCompleteWords.SetMeaning(Value: IMeaning);
begin
  DisableBackButton := True;
  FMeaning := Value;
  FMeaning.ResetValues;
  FMeaning.SetItem(dm.ClickAudioNative);
  SetColors;
  Popula_Combo(False);

  lbl_Title_CompleteWords.Text := FText.getTextCompleteWords;
  lbl_loading.Text := FText.getTextLoading;
  lbl_TheWordIs.Text := FText.getTextTheWordIs;
  lbl_Next.Text := FText.getTextNext;
  lbl_PlayAgain.Text := FText.getTextPlayAgain;
  lbl_No.Text := FText.getTextNo;
  lbl_Yes.Text := FText.getTextYes;
  Lbl_Review.Text := FText.getTextReview;
  lbl_ReviewLastWordsThisRound.Text := FText.getTextReviewLastWordsThisRound;

end;

procedure TFrmCompleteWords.ShowHowToPlay;
begin
  Lay_Menu.Position.Y := Self.Height + 20;
  Lay_Menu.Visible := True;
  Lay_Menu.BringToFront;

  AnimaMenu.Inverse := False;
  AnimaMenu.StartValue := Self.Height + 20;
  AnimaMenu.StopValue := 0;
  AnimaMenu.start;

end;

procedure TFrmCompleteWords.FechaMenu(Sender: TObject);
begin
  AnimaMenu.Inverse := True;
  AnimaMenu.start;
  DisableBackButton := False;

end;

procedure TFrmCompleteWords.LayoutContentMouseMove(Sender: TObject;
Shift: TShiftState; X, Y: Single);
begin
  if Grab and (ssleft in Shift) then
  begin
    // keep from dragging off Layout
    if X > (LayoutContent.Width + Offset.X - RECT_WIDTH) then
      X := LayoutContent.Width + Offset.X - RECT_WIDTH;
    if Y > (LayoutContent.Height + Offset.Y - RECT_HEIGHT) then
      Y := LayoutContent.Height + Offset.Y - RECT_HEIGHT;
    if X < Offset.X then
      X := Offset.X;
    if Y < Offset.Y then
      Y := Offset.Y;

    MovingRectangle.Position.X := X - Offset.X;
    MovingRectangle.Position.Y := Y - Offset.Y;
  end;
end;

procedure TFrmCompleteWords.LayoutContentMouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  I: Integer;
  FRight: Boolean;

  function PointInRect(X, Y { top rect corner coords in layout1 } : Single;
  BotRect: TRectangle): Boolean;
  begin
    if (X >= BotRect.Position.X) and (X <= (BotRect.Position.X + BotRect.Width))
      and (Y >= BotRect.Position.Y) and
      (Y <= BotRect.Position.Y + BotRect.Height + TLayout(BotRect.Parent)
      .Position.Y) then
      Result := True
    else
      Result := False;
  end;

  function RectangleOnTop(TopRect, BotRect: TRectangle): Boolean;
  var
    X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single;
  begin
    // 4 corners
    // 1-------2
    // 3-------4
    Result := False;
    X1 := TopRect.Position.X;
    // these are the four corners according in layout1 coords
    Y1 := TopRect.Position.Y; // of the top moving rect
    X2 := X1 + TopRect.Width;
    Y2 := Y1;
    X3 := X1;
    Y3 := Y1 + TopRect.Height;
    X4 := X2;
    Y4 := Y3;

    // check 4 corners of top rect
    if PointInRect(X1, Y1, BotRect) or PointInRect(X2, Y2, BotRect) or
      PointInRect(X3, Y3, BotRect) or PointInRect(X4, Y4, BotRect) then
      Result := True;
  end;

begin
  Grab := False;
  MovingRectangle.BringToFront;
  // MouseUp automatically turns off mouse capture of Layout1

  // check to see if over another rectangle
  FRight := True;
  for I := high(RectWordsTop) downto Low(RectWordsTop) do
  begin
    if (MovingRectangle <> RectWordsTop[I]) and
      (RectWordsTop[I].Fill.Color <> CurrentTheme.ColorFilled) then
    begin
      if RectangleOnTop(MovingRectangle, RectWordsTop[I]) then
      begin
        FRight := (RectWordsTop[I].TagString = MovingRectangle.TagString);
        if FRight then
        begin
          Right(RectWordsTop[I]);
          Break;
        end;
      end;
    end;
  end;

  if not FRight then
    Wrong(MovingRectangle);

  if Length(RectWordsBottom) = FTotalLetters then
  begin
    AnimationForm.Inverse := False;
    AnimationForm.start;
  end;

end;

procedure TFrmCompleteWords.Lay_FinishClick(Sender: TObject);
begin
  inherited;
  Close;
end;

{
  procedure TFrmCompleteWords.LoadLog;
  begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add('FTotalLetters: ' + FTotalLetters.ToString);
  Memo1.Lines.Add('FTotalPerRound: ' + FTotalPerRound.ToString);
  Memo1.Lines.Add('FTotalWords: ' + FTotalWords[nlAll.AsByte].ToString);
  Memo1.Lines.Add('FTotalComplete: ' + FTotalComplete[nlAll.AsByte].ToString);
  Memo1.Lines.Add('FAcertos: ' + FAcertos.ToString);
  Memo1.Lines.Add('FErrors: ' + FErrors.ToString);
  end;
}

procedure TFrmCompleteWords.lbl_CongratulationsClick(Sender: TObject);
begin
  inherited;
  if IsRoundFinished then
    actNext.Execute;

end;

function TFrmCompleteWords.IsFinished: Boolean;
begin
  Result := (FErrors = 3) or (TotalComplete = TotalWords) or IsRoundFinished;
end;

function TFrmCompleteWords.IsRoundFinished: Boolean;
begin
  Result := (FTotalPerRound >= cTotalPerRound);
end;

procedure TFrmCompleteWords.Right(Rect: TRectangle);
begin
  dm.PlayRightAudio;
  Rect.Fill.Color := CurrentTheme.ColorFilled;
  Rect.Fill.Kind := TBrushKind.Solid;

  for var Idx := 0 to ComponentCount - 1 do
    if Components[Idx].GetParentComponent = Rect then
      TLabel(Components[Idx]).Visible := True;

  FloatAnimation1.Parent := MovingRectangle;
  FloatAnimation1.start;

  inc(FTotalLetters);
end;

procedure TFrmCompleteWords.Wrong(Rect: TRectangle);
begin
  dm.PlayErrorAudio;

  for var Idx := 0 to ComponentCount - 1 do
    if Components[Idx].GetParentComponent = Rect then
      TLabel(Components[Idx]).FontColor := TAlphaColorRec.Red;
  Rect.Stroke.Kind := TBrushKind.Solid;
  Rect.Stroke.Color := TAlphaColorRec.Red;

  if FErrors < 3 then
    inc(FErrors);

  if FErrors = 1 then
  begin
    SkStars.Animation.Stop;
    SkStars.LoadFromFile(TPath.Combine(TFunctions.getPathImage, '2stars.json'));
    SkStars.Animation.start;
  end
  else if FErrors = 2 then
  begin
    SkStars.Animation.Stop;
    SkStars.LoadFromFile(TPath.Combine(TFunctions.getPathImage, '1star.json'));
    SkStars.Animation.start;
  end
  else if FErrors = 3 then
  begin
    AnimationForm.Inverse := False;
    AnimationForm.start;

  end;
end;

procedure TFrmCompleteWords.Rect_YesClick(Sender: TObject);
begin
  inherited;

  ExibirAds(Reload);

  Lay_Form.Visible := True;
  Lay_Form.BringToFront;

  // 0 to 1 - invisible to visible
  AnimationForm.Inverse := True;
  AnimationForm.start;

end;

procedure TFrmCompleteWords.Reload;
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

  FTotalLetters := 0;

  Popula_Combo(getSelectLanguage = nlAll);
  Carrega_Layout;

  FloatAnimation1.OnFinish := FloatAnimation1Finish;
end;

procedure TFrmCompleteWords.AnimationFormFinish(Sender: TObject);
begin
  // StartValue = 1
  // StopValue = 0
  // 1 to 0 - visible to invisible
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
          FLanguage.AsValue.ToString);
        dm.RequestMeaningProximo.AddParameter('id_word',
          FMeaningArray[GetIndex].CodItem.ToString);
        dm.RequestMeaningProximo.AddParameter('Id_Usuario',
          FMeaning.User.Id_Usuario.ToString);
        dm.RequestMeaningProximo.AddParameter('screen', fmForm.Value);
        dm.RequestMeaningProximo.ExecuteAsync(CheckWordSave, True, True,
          ErroRequestTryAgain);

        if FMeaning.Category.percent_complete(fmForm, FLanguage) < 100 then
        begin
          FMeaning.Category.IncTotal(fmForm, FLanguage);
        end;
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
  // LoadLog;
end;

procedure TFrmCompleteWords.Next_ButtonClick(Sender: TObject);
begin
  if IsFinished then
    ShowFinish
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

procedure TFrmCompleteWords.CheckWordSave;
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

procedure TFrmCompleteWords.Rectangle1MouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  MovingRectangle := Sender as TRectangle;
  Offset.X := X;
  Offset.Y := Y;
  // sets mouse capture to Layout1
  LayoutContent.Root.Captured := LayoutContent;
  MovingRectangle.BringToFront; // optional
  MovingRectangle.Repaint;
  Grab := True;
end;

procedure TFrmCompleteWords.RectImgPlayClick(Sender: TObject);
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

procedure TFrmCompleteWords.Rect_ExitClick(Sender: TObject);
begin
  inherited;
  actLast.Execute;
end;

procedure TFrmCompleteWords.Rect_FinishClick(Sender: TObject);
begin
  inherited;
  if Lay_Finish.Visible then
    Close;
end;

procedure TFrmCompleteWords.Rect_NoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCompleteWords.Rect_WordClick(Sender: TObject);
begin
  dm.PlayAudio(MediaPlayer);
end;

procedure TFrmCompleteWords.FloatAnimation1Finish(Sender: TObject);
begin
  if MovingRectangle.Stroke.Color <> TAlphaColorRec.Red then
    MovingRectangle.SendToBack;
end;

procedure TFrmCompleteWords.ExibirAds(Proc: TProc;
EnableRewarded: Boolean = True; EnableBanner: Boolean = True);
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

        end);
      }
    end);
  t.start;

end;

function TFrmCompleteWords.GetBannerAd: TAdBanner;
begin
  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  FBannerAd := TAdBanner.Create(Lay_Form, TFunctions.AppIDBanner,
    TAdBannerType.Banner);
  Result := FBannerAd;
end;

function TFrmCompleteWords.GetComboLanguage: TComboBox;
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

function TFrmCompleteWords.GetRewarded: TAdBanner;
begin
  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  FRewarded := TAdBanner.Create(Lay_Form, TFunctions.AppIDRewarded,
    TAdBannerType.Rewarded);
  Result := FRewarded;
end;

procedure TFrmCompleteWords.Popula_Combo(pOriginalItemIndex: Boolean = False);
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

procedure TFrmCompleteWords.FormClose(Sender: TObject;
var Action: TCloseAction);
var
  I: Integer;
begin
  SkStars.Enabled := False;
  gifCongratulations.Enabled := False;
  gifRight.Enabled := False;

  for I := Low(RectWordsBottom) to high(RectWordsBottom) do
    FreeAndNil(RectWordsBottom[I]);
  SetLength(RectWordsBottom, 0);

  for I := Low(RectWordsTop) to high(RectWordsTop) do
    FreeAndNil(RectWordsTop[I]);
  SetLength(RectWordsTop, 0);

  for I := Low(LayWordsTop) to high(LayWordsTop) do
    FreeAndNil(LayWordsTop[I]);
  SetLength(LayWordsTop, 0);

  if Assigned(FHorizontalMeaning) then
    FreeAndNil(FHorizontalMeaning);

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  Action := TCloseAction.caFree;
  FrmCompleteWords := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.show;
end;

end.
