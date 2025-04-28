unit uHorizontalMeaning;

interface

uses FMX.Layouts, FMX.Objects, FMX.Types, FMX.Graphics, System.UITypes,
  System.Classes, System.Types, System.SysUtils, FMX.Forms, FMX.StdCtrls,
  FMX.Ani, System.Actions, FMX.ActnList, FMX.Edit, System.JSON, FMX.Skia,
  System.Generics.Collections, FMX.TabControl, FMX.ImgList, System.ImageList,
  System.Net.HttpClient, FMX.Dialogs, IdHTTP, uClassMeaning.Intf, uEnum,
  System.IOUtils, FMX.Media, uEnum.Helper, uMediaPlayerThread, UnitConstante;

type

  THorizontalMeaning = class
  private
    FHeight: Single;
    FMarginPadrao: integer;
    FTabControl: TTabControl;
    FTabItem: TTabItem;
    FImageList: TImageList;
    FLay_Content: TScrollBox;
    Rect: TRectangle;
    lbl: TLabel;
    FMeaning: IMeaning;
    JsonArray: TJSONArray;
    ArrayElement: TJSonValue;
    FIsLoadingData: Boolean;
    SkAudios: array of TSkAnimatedImage;
    MediaPlayer: TMediaPlayer;
    procedure ClickAudioNative(Sender: TObject); overload;
    procedure ClickAudioNative(Sender: TObject; const Point: TPointF); overload;
    procedure LoadItem(iContItem: integer);
    procedure AddItem;
    procedure SetIsLoadingData(const Value: Boolean);
    function GetHeight(Str: string): Single;
  public
    constructor Create(Owner: TTabControl); overload;
    constructor Create(Owner: TTabControl; AMeaning: IMeaning); overload;
    destructor Destroy; override;
    procedure AddTranslations(ALanguage: TNativeLanguage);
    procedure DeleteItem;

    procedure setJson(const Value: string);
    procedure setAudioNative(
{$IFDEF MSWINDOWS}
      AClick: TExecutaClickWin = nil
{$ELSE}
      AClick: TExecutaClickMobile = nil
{$ENDIF});
    function getQuantidade: integer;
    procedure LoadFromJSON(iContItem: integer; Inverse: Boolean = False);

    procedure SetLay_Content(const Value: TScrollBox);
    procedure SetMarginPadrao(const Value: integer);

{$IFDEF MSWINDOWS}
    procedure SetPress_Back(const Value: TExecutaClickWin); overload;
{$ELSE}
    procedure SetPress_Back(const Value: TExecutaClickMobile); overload;
{$ENDIF}
    procedure SetImageList(const Value: TImageList);
    procedure SetMeaning(Value: IMeaning);

    property MarginPadrao: integer read FMarginPadrao write SetMarginPadrao;
    property Lay_Content: TScrollBox read FLay_Content write SetLay_Content;
    property IsLoadingData: Boolean read FIsLoadingData write SetIsLoadingData;
  end;

implementation

uses uFunctions, uClassThread, UnitDM;

constructor THorizontalMeaning.Create(Owner: TTabControl);
begin
  MediaPlayer := TMediaPlayer.Create(Owner);
  FTabControl := Owner;
  FMarginPadrao := 10;
  FHeight := Trunc(FTabControl.Height / High(TNativeLanguage).AsByte);
  FIsLoadingData := False;
end;

constructor THorizontalMeaning.Create(Owner: TTabControl; AMeaning: IMeaning);
begin
  Create(Owner);
  FMeaning := AMeaning;
  FIsLoadingData := False;
  Self.setAudioNative(ClickAudioNative);
end;

procedure THorizontalMeaning.ClickAudioNative(Sender: TObject);
var
  Rectangle: TRectangle absolute Sender;
  SkAudio: TSkAnimatedImage;
begin
  for SkAudio in SkAudios do
  begin
    if SkAudio.Animation.Running then
      SkAudio.Animation.Stop;
  end;
  SkAudios[Rectangle.Tag].Animation.Loop := False;
  SkAudios[Rectangle.Tag].Animation.Start;
  if Sender is TRectangle then
  begin
    TMediaPlayerThread.WaitForThread;
    TMediaPlayerThread.Create(MediaPlayer, Rectangle.TagString).Start;

  end
  else
    ShowMessage('No Audio avaliable');

end;

procedure THorizontalMeaning.ClickAudioNative(Sender: TObject;
const Point: TPointF);
begin
  ClickAudioNative(Sender);
end;

procedure THorizontalMeaning.LoadFromJSON(iContItem: integer;
Inverse: Boolean = False);
var
  I, Inicio, Fim: integer;
begin
  IsLoadingData := true;
  try
    try
      for I := Low(SkAudios) to high(SkAudios) do
        FreeAndNil(SkAudios[I]);
      SetLength(SkAudios, 0);
      for I := FTabControl.TabCount - 1 downto 0 do
        FTabControl.Delete(I);

      if Inverse then
      begin
        Fim := (cMaxTabItems * Trunc((iContItem + 1) / cMaxTabItems));
        Inicio := Fim - cMaxTabItems;

        for I := Inicio to Fim - 1 do
          LoadItem(I);
      end
      else
      begin
        Inicio := cMaxTabItems * Trunc(iContItem / cMaxTabItems);
        Fim := Inicio + cMaxTabItems;

        for I := Inicio to Fim - 1 do
          LoadItem(I);
      end;

    except
      raise Exception.CreateFmt('Json array[%d] inválido', [I]);

    end;
  finally
    // FTabControl.Visible := true;
    // FTabControl.Opacity := 1;
    IsLoadingData := False;
  end;
end;

procedure THorizontalMeaning.LoadItem(iContItem: integer);
var
  ta: TNativeLanguage;
begin
  if (iContItem < 0) then
    Exit;

  if (iContItem > getQuantidade) then
    Exit;

  ArrayElement := JsonArray.Items[iContItem];

  FMeaning.SetCountItem(iContItem);
  FMeaning.SetCodItem(ArrayElement.GetValue<integer>('codItem'));
  FMeaning.SetEnglish(ArrayElement.GetValue<string>('Text.English'));
  FMeaning.SetFrench(ArrayElement.GetValue<string>('Text.French'));
  FMeaning.SetItalian(ArrayElement.GetValue<string>('Text.Italian'));
  FMeaning.SetPortuguese(ArrayElement.GetValue<string>('Text.Portuguese'));
  FMeaning.SetSpanish(ArrayElement.GetValue<string>('Text.Spanish'));

  FMeaning.SetAudioEnglish(ArrayElement.GetValue<string>('Audio.English'));
  FMeaning.SetAudioFrench(ArrayElement.GetValue<string>('Audio.French'));
  FMeaning.SetAudioItalian(ArrayElement.GetValue<string>('Audio.Italian'));
  FMeaning.SetAudioPortuguese(ArrayElement.GetValue<string>
    ('Audio.Portuguese'));
  FMeaning.SetAudioSpanish(ArrayElement.GetValue<string>('Audio.Spanish'));

  FMeaning.getUrl_PathS3(nlEnglish);

  AddItem;
end;

procedure THorizontalMeaning.AddItem;
var
  ta: TNativeLanguage;
  // Lay_Horz_Top: TLayout;
  Rect_Horz_Top, RectAudio: TRectangle;
  // Img: TImage;
  Img: TGlyph;
begin
  // Layout dentro do Horizontal Scroll Box, necessário para fazer o scroll com mais de um item

  if FTabControl.FindComponent('TabItem' + FMeaning.CodItem.ToString) = nil then
  begin
    FTabItem := TTabItem.Create(FTabControl);
    FTabItem.Align := TAlignLayout.Client;
    FTabItem.Parent := FTabControl;
    FTabItem.HitTest := true;
    // TabItem.IsSelected := true;
    FTabItem.Size.Width := 8;
    FTabItem.Size.Height := 8;
    FTabItem.StyleLookup := '';
    FTabItem.Text := 'TabItem' + FMeaning.CodItem.ToString;
    FTabItem.Name := FTabItem.Text;
    FTabItem.Tag := FMeaning.CodItem;
    FTabControl.AddObject(FTabItem);

    // // Retangulo Geral
    // Rect := TRectangle.Create(TabItem);
    // Rect.Parent := TabItem;
    // Rect.Align := TAlignLayout.Client;
    // Rect.Stroke.Kind := TBrushKind.None;
    // Rect.Fill.Kind := TBrushKind.None;
    // TabItem.AddObject(Rect);

    // Layout Top
    // Lay_Horz_Top := TLayout.Create(TabItem);
    // Lay_Horz_Top.Parent := TabItem;
    // Lay_Horz_Top.Align := TAlignLayout.Top;
    // Lay_Horz_Top.Size.Height := Trunc(TabItem.Height / 5);
    // // Lay_Horz_Top.Margins.Right := 20;
    // Lay_Horz_Top.Size.PlatformDefault := False;
    // TabItem.AddObject(Lay_Horz_Top);

    // Retangulo do layout top
    Rect_Horz_Top := TRectangle.Create(FTabItem);
    Rect_Horz_Top.Parent := FTabItem;
    Rect_Horz_Top.Align := TAlignLayout.Top;
    Rect_Horz_Top.Size.Height := FHeight - 10;
    Rect_Horz_Top.Stroke.Kind := TBrushKind.None;
    Rect_Horz_Top.Fill.Kind := TBrushKind.None;
    Rect_Horz_Top.Opacity := 1;
    // dm.RectEffect(Rect_Horz_Top);
    FTabItem.AddObject(Rect_Horz_Top);

    // Adiciona a Imagem do Voltar
    Img := TGlyph.Create(Rect_Horz_Top);
    // Img.Opacity := 1;
    Img.Margins.Left := FMarginPadrao;
    Img.HitTest := true;
    Img.Parent := Rect_Horz_Top;
    Img.Align := TAlignLayout.Left;
    Img.Width := 40;
    Img.Size.PlatformDefault := False;
    Img.ImageIndex := 1; // back
    Img.Images := FImageList;
    Rect_Horz_Top.AddObject(Img);

    Rect := TRectangle.Create(Img);
    Rect.Parent := Img;
    Rect.Align := TAlignLayout.Client;
    Rect.Stroke.Kind := TBrushKind.None;
    Rect.Fill.Kind := TBrushKind.None;
{$IFDEF MSWINDOWS}
    Rect.OnClick := FMeaning.ClickBack;
{$ELSE}
    Rect.OnTap := FMeaning.TapBack;
{$ENDIF}
    Img.AddObject(Rect);

    if FMeaning.NativeLanguage <> nlUnknow then
    begin
      // Adiciona texto...
      lbl := TLabel.Create(Rect_Horz_Top);
      lbl.Align := TAlignLayout.Client;
      lbl.StyledSettings := [TStyledSetting.Family];
      lbl.Margins.Left := FMarginPadrao;
      lbl.Size.Height := 97;
      lbl.Size.PlatformDefault := False;
      lbl.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
      lbl.TextSettings.Font.Size := cLabelSize;
      lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
      lbl.Text := FMeaning.getNativeLanguage;
      lbl.Visible := true;
      Rect_Horz_Top.AddObject(lbl);

      SetLength(SkAudios, Length(SkAudios) + 1);

      SkAudios[Length(SkAudios) - 1] := TSkAnimatedImage.Create(Rect_Horz_Top);
      // SkAudioNative.Parent := Rect_Horz_Top;
      SkAudios[Length(SkAudios) - 1].Tag := FMeaning.NativeLanguage.AsValue;
      SkAudios[Length(SkAudios) - 1].LoadFromFile
        (TPath.Combine(TFunctions.getPathImage, 'audio.json'));
      // CircleAudio.Opacity := 1;
      SkAudios[Length(SkAudios) - 1].HitTest := true;
      SkAudios[Length(SkAudios) - 1].Anchors :=
        [TAnchorKind.akRight, TAnchorKind.akBottom];
      // SkAudio.ImageIndex := 0; // audio
      // SkAudio.Images := FImageList;
      SkAudios[Length(SkAudios) - 1].Align := TAlignLayout.Right;
      SkAudios[Length(SkAudios) - 1].Margins.Top := 5;
      SkAudios[Length(SkAudios) - 1].Margins.Bottom := 5;
      SkAudios[Length(SkAudios) - 1].Margins.Right := FMarginPadrao;
      SkAudios[Length(SkAudios) - 1].Size.Width := 45;
      SkAudios[Length(SkAudios) - 1].Size.Height := 45;
      SkAudios[Length(SkAudios) - 1].Animation.Stop;
      Rect_Horz_Top.AddObject(SkAudios[Length(SkAudios) - 1]);

      RectAudio := TRectangle.Create(SkAudios[Length(SkAudios) - 1]);
      // RectAudio.Opacity := 1;
      RectAudio.Parent := SkAudios[Length(SkAudios) - 1];
      RectAudio.Align := TAlignLayout.Client;
      RectAudio.Stroke.Kind := TBrushKind.None;
      RectAudio.Fill.Kind := TBrushKind.None;
      // RectAudio.Tag := FMeaning.CodItem;
      RectAudio.Tag := Length(SkAudios) - 1;
      if not FMeaning.Audio(FMeaning.NativeLanguage).IsEmpty then
        RectAudio.TagString := FMeaning.getUrl_PathS3(FMeaning.NativeLanguage);
{$IFDEF MSWINDOWS}
      RectAudio.OnClick := FMeaning.ClickItem;
{$ELSE}
      RectAudio.OnTap := FMeaning.TapItem;
{$ENDIF}
      SkAudios[Length(SkAudios) - 1].AddObject(RectAudio);
    end;

    // Layout Geral
    FLay_Content := TScrollBox.Create(FTabItem);
    FLay_Content.Parent := FTabItem;
    FLay_Content.Align := TAlignLayout.Client;
    FLay_Content.Margins.Right := FMarginPadrao;
    FTabItem.AddObject(FLay_Content);
    FTabItem.RecalcSize;
  end;

  for ta := low(TNativeLanguage) to high(TNativeLanguage) do
  begin
    if ta.IsLanguage and (ta <> FMeaning.NativeLanguage) then
      AddTranslations(ta);
  end;
end;

procedure THorizontalMeaning.AddTranslations(ALanguage: TNativeLanguage);
var
  Rect_Meaning, RectLay_Content: TRectangle;
  CircleFlag: TGlyph;
  sText: string;
begin
  if FMeaning.getLanguage(ALanguage) <> '' then
  begin
    SetLength(SkAudios, Length(SkAudios) + 1);
    sText := FMeaning.getText(ALanguage);

    // Retangulo dentro do Layout Geral que irá conter os itens
    RectLay_Content := TRectangle.Create(FLay_Content);
    RectLay_Content.Parent := FLay_Content;
    RectLay_Content.Align := TAlignLayout.Top;
    RectLay_Content.Size.Height := GetHeight(sText);

    RectLay_Content.Stroke.Kind := TBrushKind.None;
    RectLay_Content.Fill.Kind := TBrushKind.None;
    RectLay_Content.Margins.Bottom := 5;
    FLay_Content.AddObject(RectLay_Content);

    // Adiciona texto da lingua materna...
    lbl := TLabel.Create(RectLay_Content);
    lbl.Align := TAlignLayout.Top;
    lbl.StyledSettings := [TStyledSetting.Family];
    lbl.Margins.Left := FMarginPadrao;
    lbl.Size.PlatformDefault := False;
    lbl.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
    // lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
    lbl.TextSettings.Font.Size := 14;
    lbl.Text := FMeaning.getLanguage(ALanguage);
    lbl.Visible := true;
    RectLay_Content.AddObject(lbl);

    // Adiciona o Retangulo Curvado
    Rect_Meaning := TRectangle.Create(RectLay_Content);
    Rect_Meaning.Parent := FLay_Content;
    Rect_Meaning.Align := TAlignLayout.Client;
    Rect_Meaning.Margins.Left := FMarginPadrao;
    Rect_Meaning.Margins.Right := 0;
    Rect_Meaning.Margins.Top := 5;
    Rect_Meaning.Margins.Bottom := 5;
    Rect_Meaning.Size.PlatformDefault := False;
    Rect_Meaning.Fill.Kind := TBrushKind.Solid;
    Rect_Meaning.Fill.Color := CurrentTheme.ColorRecLanguage;
    Rect_Meaning.Stroke.Kind := TBrushKind.None;
    Rect_Meaning.XRadius := XRadius;
    Rect_Meaning.YRadius := YRadius;
    Rect_Meaning.Tag := Length(SkAudios) - 1; // FMeaning.CodItem;
    if not FMeaning.Audio(ALanguage).IsEmpty then
      Rect_Meaning.TagString := FMeaning.getUrl_PathS3(ALanguage);

{$IFDEF MSWINDOWS}
    Rect_Meaning.OnClick := FMeaning.ClickItem;
{$ELSE}
    Rect_Meaning.OnTap := FMeaning.TapItem;
{$ENDIF}
    RectLay_Content.AddObject(Rect_Meaning);
    // dm.RectEffect(Rect_Meaning);

    if FMeaning.getUrl_PathS3(ALanguage) <> '' then
    begin
      CircleFlag := TGlyph.Create(Rect_Meaning);
      CircleFlag.Anchors := [TAnchorKind.akRight, TAnchorKind.akBottom];
      CircleFlag.ImageIndex := ALanguage.ImageIndex;
      CircleFlag.Images := FImageList;
      CircleFlag.OnTap := FMeaning.TapItem;
      CircleFlag.Align := TAlignLayout.Right;
      CircleFlag.Margins.Right := 15;
      CircleFlag.Size.Width := 25;
      CircleFlag.Size.Height := 45;
      CircleFlag.Size.PlatformDefault := False;
      Rect_Meaning.AddObject(CircleFlag);

      SkAudios[Length(SkAudios) - 1] := TSkAnimatedImage.Create(Rect_Meaning);
      // SkAudios[Length(SkAudios) - 1].Parent := Rect_Meaning;
      SkAudios[Length(SkAudios) - 1].Tag := ALanguage.AsValue;
      SkAudios[Length(SkAudios) - 1].LoadFromFile
        (TPath.Combine(TFunctions.getPathImage, 'audio.json'));
      SkAudios[Length(SkAudios) - 1].Anchors :=
        [TAnchorKind.akRight, TAnchorKind.akBottom];
      // SkAudio.ImageIndex := 0;
      // SkAudio.Images := FImageList;
      // SkAudios[ALanguage.AsValue-1].Tag := FMeaning.CodItem;
      SkAudios[Length(SkAudios) - 1].OnTap := FMeaning.TapItem;
      SkAudios[Length(SkAudios) - 1].Align := TAlignLayout.Left;
      SkAudios[Length(SkAudios) - 1].Margins.Left := 15;
      SkAudios[Length(SkAudios) - 1].Size.Width := 25;
      SkAudios[Length(SkAudios) - 1].Size.Height := 45;
      SkAudios[Length(SkAudios) - 1].Size.PlatformDefault := False;
      SkAudios[Length(SkAudios) - 1].Animation.Stop;
      Rect_Meaning.AddObject(SkAudios[Length(SkAudios) - 1]);
    end;

    lbl := TLabel.Create(Rect_Meaning);
    lbl.Parent := Rect_Meaning;
    lbl.Align := TAlignLayout.Client;
    lbl.AutoSize := true;
    lbl.StyledSettings := [TStyledSetting.Family];
    lbl.Margins.Left := FMarginPadrao;
    lbl.Size.PlatformDefault := False;
    lbl.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
    lbl.TextSettings.WordWrap := true;
    lbl.TextSettings.Font.Size := cLabelSize;

    lbl.TextSettings.Font.Style := [TFontStyle.fsBold];
    lbl.Text := sText;
    Rect_Meaning.AddObject(lbl);

  end;
end;

procedure THorizontalMeaning.setAudioNative(
{$IFDEF MSWINDOWS}
AClick: TExecutaClickWin = nil
{$ELSE}
AClick: TExecutaClickMobile = nil
{$ENDIF}
  );
begin
  FMeaning.SetItem(AClick);
end;

procedure THorizontalMeaning.SetImageList(const Value: TImageList);
begin
  FImageList := Value;
end;

procedure THorizontalMeaning.SetIsLoadingData(const Value: Boolean);
begin
  FIsLoadingData := Value;
end;

procedure THorizontalMeaning.setJson(const Value: string);
begin
  JsonArray := TJSONObject.ParseJSONValue(Value) as TJSONArray;
end;

procedure THorizontalMeaning.SetLay_Content(const Value: TScrollBox);
begin
  FLay_Content := Value;
end;

procedure THorizontalMeaning.SetMarginPadrao(const Value: integer);
begin
  FMarginPadrao := Value;
end;

procedure THorizontalMeaning.SetMeaning(Value: IMeaning);
begin
  FMeaning := Value;

end;

{$IFDEF MSWINDOWS}

procedure THorizontalMeaning.SetPress_Back(const Value: TExecutaClickWin);
begin
  FMeaning.SetBack(Value);
end;

{$ELSE}

procedure THorizontalMeaning.SetPress_Back(const Value: TExecutaClickMobile);
begin
  FMeaning.SetBack(Value);
end;

{$ENDIF}

procedure THorizontalMeaning.DeleteItem;
var
  I: integer;
  Rect: TRectangle;
begin
  for I := FLay_Content.ComponentCount - 1 downto 0 do
  begin
    if (FLay_Content.Components[I].ClassType = TRectangle) then
    begin
      Rect := TRectangle(FLay_Content.Components[I]);
      Rect.DisposeOf;
    end;
  end;
end;

destructor THorizontalMeaning.Destroy;
var
  I: integer;
begin
  for I := Low(SkAudios) to high(SkAudios) do
    FreeAndNil(SkAudios[I]);
  SetLength(SkAudios, 0);

  if Assigned(MediaPlayer) then
    FreeAndNil(MediaPlayer);

  for I := FTabControl.TabCount - 1 downto 0 do
    FTabControl.Delete(I);

  if Assigned(JsonArray) then
    JsonArray.DisposeOf;
  inherited;
end;

function THorizontalMeaning.GetHeight(Str: string): Single;
const
  cLimitStr = 31;
begin
  if Length(Str) > cLimitStr then
    Result := FHeight + (10 * Trunc((Length(Str) DIV cLimitStr) + 1))
  else
    Result := FHeight;
end;

function THorizontalMeaning.getQuantidade: integer;
begin
  if not Assigned(JsonArray) then
    raise Exception.Create('Json array não foi informado');

  Result := Pred(JsonArray.Count);
end;

end.
