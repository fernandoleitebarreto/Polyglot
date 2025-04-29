unit UnitPresentation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  UnitPadrao, FMX.Types, FMX.Gestures, System.Actions, FMX.ActnList,
  FMX.Controls, FMX.ListBox, FMX.Effects, FMX.Ani, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Objects, FMX.ImgList, FMX.Layouts, System.ImageList,
  UnitMeaning, uHorizontalPresentation,
  uClassTexts, Skia.FMX, AdMob113, System.Math, System.Generics.Collections,
  FMX.Forms, Skia;

type
  TImageItem = (riUnknow = -1, itemClose, itemRandomDisabled,
    itemRandomEnabled);

  TImageItemHelper = record helper for TImageItem
    function AsByte: Byte; inline;
    function ImageIndex: Integer; inline;
    Class function Parse(_iCod: Integer): TImageItem; static;
  end;

  TFrmPresentation = class(TFrmPadrao)
    Lay_Top: TLayout;
    lbl_Last: TLabel;
    Lay_Bottom: TLayout;
    cbbLanguage: TComboBox;
    Lay_Content: TLayout;
    ImageList: TImageList;
    Img_Exit: TGlyph;
    Rect_Exit: TRectangle;
    ListBoxItem1: TListBoxItem;
    lbWord: TLabel;
    lbl_Translation: TLabel;
    FloatAnimation: TFloatAnimation;
    Rect_Horz_Content: TRectangle;
    lbl_Next: TLabel;
    TimerPlay: TTimer;
    Img_Random: TGlyph;
    Img_Play: TSkAnimatedImage;
    ActionList: TActionList;
    actLast: TAction;
    actNext: TAction;
    ShadowEffect1: TShadowEffect;
    GestureManager: TGestureManager;
    FloatAnimation1: TFloatAnimation;
    lbl_ClickHere: TLabel;
    Rect_Word: TRectangle;
    Rect_Transaction: TRectangle;
    Rect_Random: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure cbbLanguageChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Rect_ExitClick(Sender: TObject);
    procedure FloatAnimationFinish(Sender: TObject);
    procedure TimerPlayTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actLastExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure lbl_TranslationClick(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure Rect_TransactionClick(Sender: TObject);
    procedure Rect_WordClick(Sender: TObject);
    procedure Img_PlayClick(Sender: TObject);
    procedure Rect_RandomClick(Sender: TObject);
  private
    { Private declarations }

    FBannerAd: TAdBanner;
    FHorizontalPresentation: THorizontalPresentation;
    FJSONValue: string;
    FMeaning: IMeaning;
    ListTabs: array of Integer;
    FIndex: Integer;
    procedure RunThread(AProc: TProc);
    procedure Pause_To_Play;
    procedure Play_To_Pause;
    function FText: IText;
    function getNativeLanguage: TNativeLanguage;
    procedure ListarDados;
    procedure SetText;
    function getSelectLanguage: TNativeLanguage;
    function PlayDisabled: Boolean;
  public
    { Public declarations }
    procedure SetJson(const Value: string);
    procedure SetMeaning(Value: IMeaning);
  end;

var
  FrmPresentation: TFrmPresentation;

const
  cTime = 4000;

implementation

uses
  UnitDM, uFunctions, UnitConstante, System.IOUtils;

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.iPhone.fmx IOS}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TFrmPresentation.FormCreate(Sender: TObject);
begin
  inherited;
  DisableBackButton := True;
{$IFDEF MSWINDOWS}
  Rect_Word.OnClick := dm.ClickAudioNative;
{$ELSE}
  Rect_Word.OnTap := dm.ClickAudioNative;
{$ENDIF}
  TimerPlay.Interval := 0;
  TimerPlay.Enabled := False;
  Img_Exit.ImageIndex := itemClose.AsByte;
  Img_Random.ImageIndex := itemRandomDisabled.AsByte;
  Pause_To_Play;

end;

procedure TFrmPresentation.FormShow(Sender: TObject);
begin

  inherited;
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          if Application.MainForm = FrmMeaning then
            exit;
          try
            if (FMeaning.EnableAds) then
            begin
              if (not Assigned(FBannerAd)) then
              begin
                FBannerAd := TAdBanner.Create(Self, TFunctions.AppIDBanner,
                  TAdBannerType.Banner);
              end;
              FBannerAd.show(IsDebuging, TAlignLayout.MostBottom);
            end;

          except
          end;

        end);
    end).start();
{$ENDIF}
end;

function TFrmPresentation.FText: IText;
begin
  Result := TText.New(getNativeLanguage);
end;

function TFrmPresentation.getNativeLanguage: TNativeLanguage;
const
  DefaultLanguage = nlEnglish;
begin
  if FMeaning.NativeLanguage <> nlUnknow then
    Result := FMeaning.NativeLanguage
  else
    Result := DefaultLanguage;

end;

function TFrmPresentation.getSelectLanguage: TNativeLanguage;
begin
  Result := TNativeLanguage.Parse_Value
    (cbbLanguage.ListItems[cbbLanguage.ItemIndex].Tag);
end;

procedure TFrmPresentation.Img_PlayClick(Sender: TObject);
begin
  inherited;
  if PlayDisabled then
  begin
    Play_To_Pause;
  end
  else
  begin
    Pause_To_Play;
  end;
end;

procedure TFrmPresentation.Rect_RandomClick(Sender: TObject);
var
  i, NewI: Integer;

  procedure Swap(n, m: Integer);
  var
    tmp: Integer;
  begin
    tmp := ListTabs[n];
    ListTabs[n] := ListTabs[m];
    ListTabs[m] := tmp;
  end;

begin
  inherited;

  if TImageItem.Parse(Img_Random.ImageIndex) = itemRandomDisabled then
  begin
    for i := High(ListTabs) downto 1 do
    begin
      NewI := RandomRange(0, i);
      Swap(i, NewI);
    end;

    Img_Random.ImageIndex := itemRandomEnabled.ImageIndex;
  end
  else
  begin
    TArray.Sort<Integer>(ListTabs);
    Img_Random.ImageIndex := itemRandomDisabled.ImageIndex;
  end;

end;

procedure TFrmPresentation.lbl_TranslationClick(Sender: TObject);
begin
  inherited;
  if lbl_ClickHere.Visible then
  begin
    lbl_ClickHere.Visible := False;
    lbl_Translation.Visible := True;
    FloatAnimation1.start;
    if lbl_Translation.Visible then
      dm.PlayAudio(Rect_Transaction.TagString);
  end;
end;

procedure TFrmPresentation.FloatAnimation1Finish(Sender: TObject);
begin
  inherited;
  FloatAnimation1.Stop;
end;

procedure TFrmPresentation.ListarDados;
begin
  try
    if FJSONValue.IsEmpty then
      raise Exception.Create('Error to get JSON value');

    FHorizontalPresentation := THorizontalPresentation.Create;
    FHorizontalPresentation.SetJson(FJSONValue);
    FHorizontalPresentation.LoadFromJSON(dm.ClickAudioNative);

  finally
    SetLength(ListTabs, FHorizontalPresentation.getTotal);
    for var i := 0 to Length(ListTabs) - 1 do
      ListTabs[i] := i;

    FIndex := 0;
    SetText;
  end;
end;

function TFrmPresentation.PlayDisabled: Boolean;
begin
  Result := Img_Play.Tag = 0;
end;

procedure TFrmPresentation.Play_To_Pause;
begin
  if Img_Play.Tag = 1 then
    exit;

  // RunThread(
  // procedure
  // begin
  Img_Play.Enabled := False;
  Img_Play.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
    'play_to_pause_white.json'));
  Img_Play.Enabled := True;
  Img_Play.Tag := 1;
  // end);

  TimerPlay.Enabled := False;
  TimerPlay.Interval := 1000;
  TimerPlay.Enabled := True;

end;

procedure TFrmPresentation.Pause_To_Play;
begin
  if Img_Play.Tag = 0 then
    exit;

  // RunThread(
  // procedure
  // begin
  Img_Play.Enabled := False;
  Img_Play.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
    'pause_to_play_white.json'));
  Img_Play.Enabled := True;
  Img_Play.Tag := 0;
  // end);

  TimerPlay.Enabled := False;
  TimerPlay.Interval := 0;

end;

procedure TFrmPresentation.cbbLanguageChange(Sender: TObject);
begin
  inherited;
  SetText;
end;

procedure TFrmPresentation.SetJson(const Value: string);
begin
  FJSONValue := Value;
end;

procedure TFrmPresentation.SetMeaning(Value: IMeaning);
begin
  DisableBackButton := True;
  FMeaning := Value;
  lbl_Last.Text := FText.getTextLast;
  lbl_Next.Text := FText.getTextNext;
  lbl_ClickHere.Text := FText.getTextClickHereKnowTranslation;

  TNativeLanguage.Popula_Combo(cbbLanguage, $FFB0BAC9, FMeaning,
    TGameForms.fmUnknow, False);
  ListarDados;
end;

procedure TFrmPresentation.SetText;
begin
  if PlayDisabled then
  begin
    lbl_Translation.Visible := False;
    lbl_ClickHere.Visible := True;
  end
  else
  begin
    lbl_Translation.Visible := True;
    lbl_ClickHere.Visible := False;
  end;

  // Adiciona texto da lingua materna...
  Rect_Word.TagString := FHorizontalPresentation.MeaningArray[ListTabs[FIndex]]
    .getUrl_PathS3(FMeaning.NativeLanguage);
  lbWord.Text := FHorizontalPresentation.MeaningArray[ListTabs[FIndex]]
    .getText(FMeaning.NativeLanguage);

  // Adiciona texto da lingua selecionada...
  Rect_Transaction.TagString := FHorizontalPresentation.MeaningArray
    [ListTabs[FIndex]].getUrl_PathS3(getSelectLanguage);
  lbl_Translation.Text := FHorizontalPresentation.MeaningArray[ListTabs[FIndex]]
    .getText(getSelectLanguage);

end;

procedure TFrmPresentation.TimerPlayTimer(Sender: TObject);
begin
  inherited;
  actNext.Execute;
end;

procedure TFrmPresentation.actNextExecute(Sender: TObject);
begin
  inherited;

  if (not PlayDisabled) and (TimerPlay.Interval <> cTime) then
  begin
    TimerPlay.Enabled := False;
    TimerPlay.Interval := cTime;
    TimerPlay.Enabled := True;
  end;

  if FIndex < Length(ListTabs) - 1 then
    FIndex := FIndex + 1
  else // if TImageItem.Parse(Img_Random.ImageIndex) = itemRandomEnabled then
    FIndex := 0;

  FloatAnimation.Inverse := False;
  if FloatAnimation.Running then
    FloatAnimation.Stop;
  FloatAnimation.start;

end;

procedure TFrmPresentation.actLastExecute(Sender: TObject);
begin
  inherited;
  if FIndex > 0 then
    FIndex := FIndex - 1
  else if TImageItem.Parse(Img_Random.ImageIndex) = itemRandomEnabled then
    FIndex := Length(ListTabs);

  FloatAnimation.Inverse := False;
  if FloatAnimation.Running then
    FloatAnimation.Stop;
  FloatAnimation.start;
end;

procedure TFrmPresentation.FloatAnimationFinish(Sender: TObject);
begin
  inherited;
  if not FloatAnimation.Inverse then
  begin
    SetText;

    if lbl_Translation.Visible then
      dm.PlayAudio(Rect_Transaction.TagString);

    FloatAnimation.Inverse := True;
    if FloatAnimation.Running then
      FloatAnimation.Stop;
    FloatAnimation.start;
  end;
end;

procedure TFrmPresentation.Rect_ExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPresentation.Rect_TransactionClick(Sender: TObject);
begin
  inherited;
  dm.PlayAudio(Rect_Transaction.TagString);
end;

procedure TFrmPresentation.Rect_WordClick(Sender: TObject);
begin
  inherited;
  dm.PlayAudio(Rect_Word.TagString);
end;

procedure TFrmPresentation.RunThread(AProc: TProc);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      AProc;

      // TThread.Synchronize(TThread.CurrentThread,
      // procedure
      // begin
      // end);
    end).start();

end;

procedure TFrmPresentation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Img_Play.Enabled := False;

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  if Assigned(FHorizontalPresentation) then
    FreeAndNil(FHorizontalPresentation);

  Action := TCloseAction.caFree;
  FrmPresentation := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.show;
end;

{ TRandomItemHelper }

function TImageItemHelper.AsByte: Byte;
begin
  Result := Ord(Self);
end;

function TImageItemHelper.ImageIndex: Integer;
begin
  case Self of
    itemClose:
      Result := 0;
    itemRandomDisabled:
      Result := 1;
    itemRandomEnabled:
      Result := 2;
  else
    Result := -1;
  end;
end;

class function TImageItemHelper.Parse(_iCod: Integer): TImageItem;
begin
  Result := TImageItem(_iCod);
end;

end.
