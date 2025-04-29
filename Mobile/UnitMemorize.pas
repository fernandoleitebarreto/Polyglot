unit UnitMemorize;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, StrUtils, AdMob113,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani,
  FireDAC.Comp.Client, UnitDM, System.JSON, uFunctions,
  System.Generics.Collections, System.Generics.Defaults, Data.DB, uArrayUtils,
  UnitMeaning, uClassTexts, FMX.Media, System.IOUtils,
  FMX.ListBox,
  UnitPadrao, System.ImageList, FMX.ImgList, Skia.FMX, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, Skia;

const
  FUpDown = True;
  MAX_TITULOS = 4;
  MARGIN_LEFT = 5;
  MAX_RECTANGLES = 4;
  RECT_HEIGHT = 50;

type
  TMeaningArray = array of IMeaning;

  TFrmMemorize = class(TFrmPadrao)
    LayoutContent: TLayout;
    lbl_Title_MemoryGame: TLabel;
    lbl_SwipeWordsUp: TLabel;
    lbl_Points: TLabel;
    LayoutTop: TLayout;
    MediaPlayer: TMediaPlayer;
    FloatAnimation1: TFloatAnimation;
    Lay_Menu: TLayout;
    AnimaMenu: TFloatAnimation;
    Rect_Menu: TRectangle;
    img_Hand: TImage;
    AnimaHand: TFloatAnimation;
    Lay_Next: TLayout;
    AnimaMessage: TFloatAnimation;
    Rect_Finish: TRectangle;
    gifCongratulations: TSkAnimatedImage;
    Lay_Form: TLayout;
    AnimationForm: TFloatAnimation;
    LayoutHeader: TLayout;
    LayoutBottom: TLayout;
    Rect_PlayAgain: TRectangle;
    Rect_No: TRectangle;
    lbl_No: TLabel;
    Rect_Yes: TRectangle;
    lbl_Yes: TLabel;
    lbl_PlayAgain: TLabel;
    lbl_Congratulations: TLabel;
    lbl_YouGotPoints: TLabel;
    SkStars: TSkAnimatedImage;
    procedure Rectangle1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure LayoutContentMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Single);
    procedure LayoutContentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure ListaDados;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnimaMenuFinish(Sender: TObject);
    procedure FechaMenu(Sender: TObject);
    procedure AnimaHandFinish(Sender: TObject);
    procedure gifCongratulationsClick(Sender: TObject);
    procedure AnimationFormFinish(Sender: TObject);
    procedure FloatAnimationFinish(Sender: TObject);
    procedure Rect_FinishClick(Sender: TObject);
    procedure Lay_NextClick(Sender: TObject);
    procedure Rect_YesClick(Sender: TObject);
    procedure Rect_NoClick(Sender: TObject);
  private
    { Private declarations }
    FMeaning: IMeaning;
    FLanguage: TNativeLanguage;
    FMeaningArray: TMeaningArray;
    FTotalWords, FTotalComplete, FTotalPerRound, FAcertos, FErrors: Integer;
    FWordsUsed: TFDMemtable;
    LastWords: array [0 .. MAX_TITULOS - 1] of Integer;
    FBannerAd, FRewarded: TAdBanner;
    procedure Reload;
    procedure Init;
    procedure ExibirCampos(pShow: Boolean = True);
    procedure Carrega_Dados(strJson: string);
    procedure Carrega_Layout;
    procedure Cria_Lista_Titulo;
    function Cria_Titulo(I: Integer): Boolean;
    procedure Cria_Lista_Item;
    function Cria_Item(I: Integer): Boolean;
    function FText: IText;
    procedure CheckWordSave;
    procedure ShowHowToPLay;
    procedure ShowFinish;
    function getLayout: TLayout;
    function getWidth: Double;
    procedure ExibirAds(Proc: TProc; EnableRewarded: Boolean = True;
      EnableBanner: Boolean = True);
    function GetBannerAd: TAdBanner;
    function GetRewarded: TAdBanner;
    procedure ErroRequestTryAgain(Sender: TObject);

    property RECT_WIDTH: Double read getWidth;
    property BannerAd: TAdBanner read GetBannerAd;
    property Rewarded: TAdBanner read GetRewarded;

  protected
    { Protected declarations }
    procedure SetColors; override;
  public
    { Public declarations }
    procedure SetMeaning(Value: IMeaning);
  end;

var
  FrmMemorize: TFrmMemorize;

implementation

uses
  UnitConstante, System.Math;

{$R *.fmx}

var
  Grab: Boolean = False;
  Offset: tpointf;
  MovingRectangle: TRectangle;
  RectWordsBottom: array of TRectangle;
  RectWordsTop: array of TRectangle;
  // FArrayColor: array [0..2] of TColor = ($FFEABC1B, $000080, $0000FF);

function TFrmMemorize.FText: IText;
begin
  FText := TText.New(FMeaning.NativeLanguage);
end;

function TFrmMemorize.getLayout: TLayout;
begin
  if FUpDown then
  begin
    if Length(RectWordsTop) - 1 < (MAX_TITULOS / 2) then
      Result := LayoutTop
    else
      Result := LayoutBottom;
  end
  else
    Result := LayoutTop;
end;

function TFrmMemorize.getWidth: Double;
begin
  if FUpDown then
    Result := Trunc(LayoutContent.Width / (MAX_TITULOS / 2)) - MARGIN_LEFT
  else
    Result := Trunc(LayoutContent.Width / MAX_TITULOS) - MARGIN_LEFT;
end;

procedure TFrmMemorize.gifCongratulationsClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmMemorize.FormCreate(Sender: TObject);
begin
  inherited;
  DisableBackButton := True;
  Lay_Menu.Visible := False;
  Lay_Next.Visible := False;
  Lay_Next.SendToBack;
  FloatAnimation1.OnFinish := FloatAnimationFinish;
  FLanguage := nlUnknow;
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

  LayoutTop.Height := RECT_HEIGHT;
  FTotalComplete := 0;
  FAcertos := 0;
  Reload;
end;

procedure TFrmMemorize.FormShow(Sender: TObject);
begin
  ExibirAds(Init, False);

end;

procedure TFrmMemorize.Init;
begin
  // Consumir WS...
  dm.RequestDados.Params.Clear;
  dm.RequestDados.AddParameter('Id_Usuario', FMeaning.User.Id_Usuario.ToString);
  dm.RequestDados.AddParameter('subcategory',
    FMeaning.Category.id_subcategoria.ToString);
  dm.RequestDados.AddParameter('field_subcategory',
    FMeaning.NativeLanguage.Sufix);
  dm.RequestDados.AddParameter('native_language',
    FMeaning.NativeLanguage.AsValue.ToString);
  dm.RequestDados.AddParameter('Form', TGameForms.fmMemorize.Value);

  // faz com que rode em thread paralela
  dm.RequestDados.ExecuteAsync(ListaDados, True, True, ErroRequestTryAgain);
end;

procedure TFrmMemorize.ErroRequestTryAgain(Sender: TObject);
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

procedure TFrmMemorize.ListaDados;
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
  ShowHowToPLay;
end;

procedure TFrmMemorize.AnimaHandFinish(Sender: TObject);
begin
  AnimaHand.start;
end;

procedure TFrmMemorize.AnimaMenuFinish(Sender: TObject);
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

procedure TFrmMemorize.Carrega_Dados(strJson: string);
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
      FTotalWords := iContItem * cQtdLanguages;
      JsonArray.DisposeOf;
    end;

  except
    ShowMessage('Json array inválido');
  end;

end;

procedure TFrmMemorize.Carrega_Layout;
var
  I: Integer;
begin
  LayoutContent.HitTest := False; // want to pick rectangles
  FloatAnimation1.Parent := nil;

  for I := Low(RectWordsTop) to high(RectWordsTop) do
  begin
    FreeAndNil(RectWordsTop[I]);
  end;

  for I := 0 to MAX_TITULOS - 1 do
  begin
    LastWords[I] := -1;
  end;

  if Length(RectWordsTop) > 0 then
    SetLength(RectWordsTop, 0);

  // mantem assim
  if FTotalComplete = FTotalWords then
  begin
    AnimationForm.Inverse := False;
    AnimationForm.start;
  end
  else
  begin
    Cria_Lista_Titulo;
    Cria_Lista_Item;
  end;
end;

procedure TFrmMemorize.Cria_Lista_Titulo;
var
  I: Integer;
begin
  I := 0;
  while I < MAX_TITULOS do
  begin
    if not Cria_Titulo(I) then
      exit;

    inc(I);
  end;
end;

function TFrmMemorize.Cria_Titulo(I: Integer): Boolean;
var
  TitleLabel: TLabel;
  J: Integer;
  bNumeroValido: Boolean;

  function getIndexTitulo: Integer;
  var
    qtd: Integer;
  begin
    Result := -1;
    qtd := Ord(High(TNativeLanguage)) - 1;

    bNumeroValido := False;

    if FWordsUsed.IndexFieldNames = '' then
      FWordsUsed.IndexFieldNames := 'QTD';

    FWordsUsed.Filtered := False;
    FWordsUsed.Filter := 'QTD < ' + qtd.ToString;
    FWordsUsed.Filtered := True;
    FWordsUsed.First;

    while (not bNumeroValido) and (not FWordsUsed.Eof) do
    begin
      bNumeroValido :=
        (not TArrayUtils<Integer>.Contains(FWordsUsed.FieldByName('POSITION')
        .AsInteger, LastWords));

      if (bNumeroValido) then
        Result := FWordsUsed.FieldByName('POSITION').AsInteger
      else
        FWordsUsed.Next;
    end;

    if (Result <> -1) then
    begin
      LastWords[I] := Result;
    end;

    FWordsUsed.Filter := '';
    FWordsUsed.Filtered := False;

  end;

begin
  J := getIndexTitulo;

  Result := J > -1;

  if (Result) then
  begin
    SetLength(RectWordsTop, Length(RectWordsTop) + 1);
    RectWordsTop[Length(RectWordsTop) - 1] := TRectangle.Create(Self);
    RectWordsTop[Length(RectWordsTop) - 1].Parent := getLayout;
    RectWordsTop[Length(RectWordsTop) - 1].Width := RECT_WIDTH;
    RectWordsTop[Length(RectWordsTop) - 1].Align := TAlignLayout.Left;
    RectWordsTop[Length(RectWordsTop) - 1].Margins.Left := MARGIN_LEFT;
    RectWordsTop[Length(RectWordsTop) - 1].Height := RECT_HEIGHT;
    RectWordsTop[Length(RectWordsTop) - 1].XRadius := XRadius;
    RectWordsTop[Length(RectWordsTop) - 1].YRadius := YRadius;
    RectWordsTop[Length(RectWordsTop) - 1].Tag := FMeaningArray[J].CodItem;
    RectWordsTop[Length(RectWordsTop) - 1].fill.Color :=
      CurrentTheme.ColorButton;
    RectWordsTop[Length(RectWordsTop) - 1].Stroke.Kind := TBrushKind.None;
    RectWordsTop[Length(RectWordsTop) - 1].TagString :=
      FMeaningArray[J].getUrl_PathS3(FMeaning.NativeLanguage);
{$IFDEF MSWINDOWS}
    RectWordsTop[Length(RectWordsTop) - 1].OnClick := FMeaning.ClickItem;
{$ELSE}
    RectWordsTop[Length(RectWordsTop) - 1].OnTap := FMeaning.TapItem;
{$ENDIF}
    TitleLabel := TLabel.Create(Self);
    TitleLabel.Align := TAlignLayout.Client;
    TitleLabel.StyledSettings := [];
    TitleLabel.Font.Size := 16;
    TitleLabel.Text := FMeaningArray[J].getText
      (FMeaningArray[J].NativeLanguage);

    TitleLabel.TextSettings.HorzAlign := TTextAlign.Center;
    TitleLabel.TextSettings.FontColor := $FF353535;

    RectWordsTop[Length(RectWordsTop) - 1].AddObject(TitleLabel);
  end;

end;

procedure TFrmMemorize.Cria_Lista_Item;
var
  I: Integer;
begin
  for I := Low(RectWordsBottom) to high(RectWordsBottom) do
    FreeAndNil(RectWordsBottom[I]);

  if Length(RectWordsBottom) > 0 then
    SetLength(RectWordsBottom, 0);

  FTotalPerRound := 0;
  I := 0;
  Rect_Finish.Visible := False;

  while I < MAX_RECTANGLES do
  begin
    Cria_Item(I);
    inc(I);
  end;
end;

function TFrmMemorize.Cria_Item(I: Integer): Boolean;
var
  TitleLabel: TLabel;
  ITitulo, codWord, iCount: Integer;
  texto: string;
begin
  ITitulo := -1;
  if I >= MAX_TITULOS then
    codWord := I - MAX_TITULOS
  else
    codWord := I;

  FWordsUsed.IndexName := 'POSITION_IDX';
  Result := FWordsUsed.FindKey([LastWords[codWord]]);
  if Result then
  begin
    ITitulo := FWordsUsed.FieldByName('POSITION').AsInteger;
    FLanguage := FMeaning.getTranslation;

    iCount := 0;
    while (iCount < High(TNativeLanguage).AsValue) and
      (FLanguage in FMeaningArray[ITitulo].ArrayLanguages) do
    begin
      FLanguage := FMeaning.getTranslation;
      inc(iCount);
    end;

    if FLanguage in FMeaningArray[ITitulo].ArrayLanguages then
      exit(False);

    FMeaningArray[ITitulo].AddLanguage(FLanguage);

    texto := FMeaningArray[ITitulo].getText(FLanguage)

  end;

  if (Result) and (texto.Trim <> '') then
  begin
    FWordsUsed.Edit;
    if FWordsUsed.FieldByName('QTD').AsInteger < MAX_RECTANGLES then
      FWordsUsed.FieldByName('QTD').AsInteger := FWordsUsed.FieldByName('QTD')
        .AsInteger + 1;
    FWordsUsed.Post;

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
    RectWordsBottom[Length(RectWordsBottom) - 1].XRadius := XRadius;
    RectWordsBottom[Length(RectWordsBottom) - 1].YRadius := YRadius;
    RectWordsBottom[Length(RectWordsBottom) - 1].Tag :=
      FMeaningArray[ITitulo].CodItem;
    RectWordsBottom[Length(RectWordsBottom) - 1].fill.Kind := TBrushKind.None;
    RectWordsBottom[Length(RectWordsBottom) - 1].Stroke.Kind :=
      TBrushKind.Solid;
    RectWordsBottom[Length(RectWordsBottom) - 1].Stroke.Color :=
      TAlphaColorRec.White;
    RectWordsBottom[Length(RectWordsBottom) - 1].Position.X :=
      Random(Trunc(LayoutContent.Width - RECT_WIDTH));
    RectWordsBottom[Length(RectWordsBottom) - 1].Position.Y :=
      RandomRange(RECT_HEIGHT + 10,
      Trunc(LayoutContent.Height - LayoutBottom.Height - RECT_HEIGHT) - 1);
    RectWordsBottom[Length(RectWordsBottom) - 1].TagString :=
      FMeaningArray[ITitulo].getUrl_PathS3(FLanguage);
    RectWordsBottom[Length(RectWordsBottom) - 1].TagFloat := FLanguage.AsValue;

{$IFDEF MSWINDOWS}
    RectWordsBottom[Length(RectWordsBottom) - 1].OnClick := FMeaning.ClickItem;
{$ELSE}
    RectWordsBottom[Length(RectWordsBottom) - 1].OnTap := FMeaning.TapItem;
{$ENDIF}
    TitleLabel := TLabel.Create(Self);
    TitleLabel.Align := TAlignLayout.Client;
    TitleLabel.StyledSettings := [];
    TitleLabel.Font.Size := 16;
    TitleLabel.Text := texto;
    TitleLabel.TextSettings.HorzAlign := TTextAlign.Center;
    TitleLabel.TextSettings.FontColor := TAlphaColorRec.White;
    RectWordsBottom[Length(RectWordsBottom) - 1].AddObject(TitleLabel);
  end
  else
    Result := False;
end;

procedure TFrmMemorize.ExibirCampos(pShow: Boolean);
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
          begin
            Lay_Form.Opacity := 1;
          end;
        end);

    end).start;

end;

procedure TFrmMemorize.SetColors;
begin
  inherited;

end;

procedure TFrmMemorize.SetMeaning(Value: IMeaning);
begin
  DisableBackButton := True;
  FMeaning := Value;
  FMeaning.ResetValues;
  FMeaning.SetItem(dm.ClickAudioNative);
  SetColors;

  lbl_Title_MemoryGame.Text := FText.getTextMemoryGame;
  lbl_SwipeWordsUp.Text := FText.getTextSwipeWordsUp;
  lbl_PlayAgain.Text := FText.getTextPlayAgain;
  lbl_No.Text := FText.getTextNo;
  lbl_Yes.Text := FText.getTextYes;
end;

procedure TFrmMemorize.ShowHowToPLay;
begin
  Lay_Menu.BringToFront;
  Lay_Menu.Position.Y := Self.Height + 20;
  Lay_Menu.Visible := True;

  AnimaMenu.Inverse := False;
  AnimaMenu.StartValue := Self.Height + 20;
  AnimaMenu.StopValue := 0;
  AnimaMenu.start;

end;

procedure TFrmMemorize.FechaMenu(Sender: TObject);
begin
  AnimaMenu.Inverse := True;
  AnimaMenu.start;
  DisableBackButton := False;
end;

procedure TFrmMemorize.LayoutContentMouseMove(Sender: TObject;
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

procedure TFrmMemorize.LayoutContentMouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  I: Integer;

  function PointInRectTop(X, Y { top rect corner coords in layout1 } : Single;
  BotRect: TRectangle): Boolean;
  begin
    if (X >= BotRect.Position.X) and (X <= (BotRect.Position.X + BotRect.Width))
      and (Y >= BotRect.Position.Y) and
      (Y <= BotRect.Position.Y + BotRect.Height) then
      Result := True
    else
      Result := False;
  end;

  function PointInRectBottom(X, Y { bottom rect corner coords in layout1 }
    : Single; BotRect: TRectangle): Boolean;
  var
    RectX, RectY: Single;
  begin
    // x    y
    // 0x326-------209x326
    // |                 |
    // 0x326-------209x376
    RectX := BotRect.Position.X;
    RectY := BotRect.Position.Y + LayoutBottom.Position.Y;

    // 219x0
    if (X >= RectX) and (X <= RectX + BotRect.Width) and
      (Y >= RectY - RECT_HEIGHT) and (Y <= RectY) then
      Result := True
    else
      Result := False;
  end;

  function RectangleOnTop(MovRect, BotRect: TRectangle): Boolean;
  var
    X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single;
  begin
    Result := False;

    if (BotRect.Parent <> LayoutTop) then
      exit;

    X1 := MovRect.Position.X;
    X2 := X1 + MovRect.Width;
    X3 := X1;
    X4 := X2;

    Y1 := MovRect.Position.Y; // of the top moving rect
    Y2 := Y1;
    Y3 := Y1 + MovRect.Height;
    Y4 := Y3;

    if PointInRectTop(X1, Y1, BotRect) or PointInRectTop(X2, Y2, BotRect) or
      PointInRectTop(X3, Y3, BotRect) or PointInRectTop(X4, Y4, BotRect) then
      Result := True;
  end;

  function RectangleOnBottom(MovRect, BotRect: TRectangle): Boolean;
  var
    X1, Y1, X2, Y2, X3, Y3, X4, Y4: Single;
  begin
    Result := False;

    if (BotRect.Parent <> LayoutBottom) then
      exit;

    X1 := MovRect.Position.X;
    X2 := X1 + MovRect.Width;
    X3 := X1;
    X4 := X2;

    Y1 := MovRect.Position.Y - MovRect.Height;
    Y2 := Y1;
    Y3 := MovRect.Position.Y;
    Y4 := Y3;

    if PointInRectBottom(X1, Y1, BotRect) or PointInRectBottom(X2, Y2, BotRect)
      or PointInRectBottom(X3, Y3, BotRect) or PointInRectBottom(X4, Y4, BotRect)
    then
      Result := True;
  end;

begin
  Grab := False;
  MovingRectangle.BringToFront;
  // MouseUp automatically turns off mouse capture of Layout1

  // check to see if over another rectangle
  for I := Low(RectWordsTop) to high(RectWordsTop) do
  begin
    if (MovingRectangle <> RectWordsTop[I]) then
    begin
      if RectangleOnTop(MovingRectangle, RectWordsTop[I]) or
        RectangleOnBottom(MovingRectangle, RectWordsTop[I]) then
      begin
        if RectWordsTop[I].Tag = MovingRectangle.Tag then
        begin
          dm.PlayRightAudio;

          FloatAnimation1.Parent := MovingRectangle;
          FloatAnimation1.start;

          inc(FTotalPerRound);
          inc(FTotalComplete);
          inc(FAcertos);
          lbl_Points.Text := FAcertos.ToString + 'pts';

          dm.RequestMeaningProximo.Params.Clear;

          dm.RequestMeaningProximo.AddParameter('Language',
            MovingRectangle.TagFloat.ToString);
          dm.RequestMeaningProximo.AddParameter('id_word',
            MovingRectangle.Tag.ToString);
          dm.RequestMeaningProximo.AddParameter('Id_Usuario',
            FMeaning.User.Id_Usuario.ToString);
          dm.RequestMeaningProximo.AddParameter('screen', fmMemorize.Value);
          dm.RequestMeaningProximo.ExecuteAsync(CheckWordSave, True, True,
            ErroRequestTryAgain);
        end
        else
        begin
          dm.PlayErrorAudio;

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

        break;

      end;
    end;
  end;
  if Length(RectWordsBottom) = FTotalPerRound then
  begin
    try
      ExibirCampos(False);
      Carrega_Layout;

    finally
      ExibirCampos;
    end;
  end;

end;

procedure TFrmMemorize.Lay_NextClick(Sender: TObject);
begin
  inherited;
  if (FErrors = 3) or (FTotalComplete = FTotalWords) then
    Self.Close;
end;

procedure TFrmMemorize.AnimationFormFinish(Sender: TObject);
begin
  if AnimationForm.Inverse = False then
  begin
    Lay_Next.Visible := True;
    Lay_Next.BringToFront;
    Lay_Form.Visible := False;

    if (FErrors = 3) or (FTotalComplete = FTotalWords) then
      ShowFinish;

    AnimaMessage.Inverse := False;
    AnimaMessage.start;

  end
  else
  begin
    Lay_Next.Visible := False;
    Lay_Next.SendToBack;
    Lay_Form.Visible := True;

  end;
end;

procedure TFrmMemorize.ShowFinish;
begin
  Rect_Finish.Visible := True;
  Rect_PlayAgain.Visible := FTotalComplete < FTotalWords;
  dm.PlayDoneAudio;
  gifCongratulations.Animation.Stop;
  if FAcertos = 0 then
  begin
    lbl_Congratulations.Text := '';
    lbl_YouGotPoints.Text := Format(FText.getTextYouGotPointsTryAgain,
      [FAcertos]);
    gifCongratulations.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
      'sad-star.json'))
  end
  else
  begin
    lbl_Congratulations.Text := FText.getTextCongratulations;
    lbl_YouGotPoints.Text := Format(FText.getTextYouGotPoints, [FAcertos]);
    gifCongratulations.LoadFromFile(TPath.Combine(TFunctions.getPathImage,
      'happy-star.json'));
  end;
  gifCongratulations.Animation.start;

end;

procedure TFrmMemorize.CheckWordSave;
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

procedure TFrmMemorize.Rectangle1MouseDown(Sender: TObject;
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

procedure TFrmMemorize.Rect_FinishClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmMemorize.Rect_NoClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmMemorize.Rect_YesClick(Sender: TObject);
begin
  inherited;
  try
    ExibirAds(Reload);
  finally
    Carrega_Layout;
  end;

  Lay_Form.Visible := True;
  Lay_Form.BringToFront;

  // 0 to 1 - invisible to visible
  AnimationForm.Inverse := True;
  AnimationForm.start;
end;

procedure TFrmMemorize.Reload;
var
  I, ITitulo: Integer;
begin
  FTotalComplete := FTotalComplete - FTotalPerRound;
  FTotalPerRound := 0;
  FErrors := 0;
  SkStars.Animation.Stop;
  SkStars.LoadFromFile(TPath.Combine(TFunctions.getPathImage, '3stars.json'));
  SkStars.Animation.start;

  if Assigned(FMeaning) then
  begin
    FMeaning.ResetValues;
    FMeaning.SetItem(dm.ClickAudioNative);
  end;

  FWordsUsed.First;

  if Length(FMeaningArray) > 0 then
    for I := 0 to MAX_TITULOS - 1 do
    begin
      ITitulo := LastWords[I];
      if ITitulo > -1 then
      begin
        FMeaningArray[ITitulo].RemoveLastLanguage;

        FWordsUsed.IndexName := 'POSITION_IDX';
        if FWordsUsed.FindKey([ITitulo]) then
        begin
          FWordsUsed.Edit;
          FWordsUsed.FieldByName('QTD').AsInteger :=
            FWordsUsed.FieldByName('QTD').AsInteger - 1;
          FWordsUsed.Post;
        end;
      end;
    end;
end;

procedure TFrmMemorize.FloatAnimationFinish(Sender: TObject);
begin
  if MovingRectangle.Stroke.Color <> TAlphaColorRec.Red then
    MovingRectangle.SendToBack;
end;

procedure TFrmMemorize.ExibirAds(Proc: TProc; EnableRewarded: Boolean = True;
EnableBanner: Boolean = True);
var
  t: TThread;
begin
  ExibirCampos(False);

  t := TThread.CreateAnonymousThread(
    procedure
    begin
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

function TFrmMemorize.GetBannerAd: TAdBanner;
begin
  if not Assigned(FBannerAd) then
  begin
    FBannerAd := TAdBanner.Create(Lay_Form, TFunctions.AppIDBanner,
      TAdBannerType.Banner);
    Result := FBannerAd;
  end
  else
    Result := FBannerAd;
end;

function TFrmMemorize.GetRewarded: TAdBanner;
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

procedure TFrmMemorize.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  SkStars.Enabled := False;
  gifCongratulations.Enabled := False;

  for I := Low(RectWordsBottom) to high(RectWordsBottom) do
    FreeAndNil(RectWordsBottom[I]);
  SetLength(RectWordsBottom, 0);

  for I := Low(RectWordsTop) to high(RectWordsTop) do
    FreeAndNil(RectWordsTop[I]);
  SetLength(RectWordsTop, 0);

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);

  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  if Assigned(FloatAnimation1) then
    FreeAndNil(FloatAnimation1);

  if Assigned(FWordsUsed) then
    FreeAndNil(FWordsUsed);

  Action := TCloseAction.caFree;
  FrmMemorize := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.show;

end;

end.
