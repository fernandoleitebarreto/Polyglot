unit UnitCategory;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Generics.Collections, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, AdMob113,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Ani,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl, FMX.Edit, FMX.Layouts, System.JSON, System.NetEncoding,
  uFunctions, uClassMeaning.Intf, uClassCategory, uClassCategory.Intf,
  uClassTexts, uClassUser, uClassCountry, FMX.ImgList, uEnum, uEnum.Helper,
  Soap.EncdDecd, UnitPadrao, System.ImageList, Skia.FMX, FMX.Effects, uCircle,
  Skia;

type

  TNotifyEvent = procedure(Sender: TObject) of Object;
  TCategoryArray = array of ICategory;
  TCircleArray = array of TCircleFrame;

  TFrmCategory = class(TFrmPadrao)
    img_icone: TImage;
    img_add: TImage;
    img_uncheck: TImage;
    img_check: TImage;
    TabLanguage: TTabItem;
    rect_btn_english: TRoundRect;
    lbl_english: TLabel;
    rect_btn_french: TRoundRect;
    lbl_french: TLabel;
    rect_btn_italian: TRoundRect;
    lbl_italian: TLabel;
    rect_btn_portuguese: TRoundRect;
    lbl_portuguese: TLabel;
    rect_btn_spanish: TRoundRect;
    lbl_spanish: TLabel;
    Rect_Language: TRectangle;
    lbl_txt_selectlanguage: TLabel;
    TabCategoria: TTabItem;
    Rect_Categoria: TRectangle;
    lbl_txt_Category: TLabel;
    TabSearch: TTabItem;
    Rect_Aba3: TRectangle;
    lbl_txt_title_search: TLabel;
    imgBack3: TImage;
    Rect_Search_Top: TRectangle;
    edt_search: TEdit;
    rect_btn_search: TRoundRect;
    lbl_txt_search: TLabel;
    Img_Search: TImage;
    TabControlAba3: TTabControl;
    Lay_Bottom: TLayout;
    rect_voltar: TRectangle;
    lbl_voltar: TLabel;
    rect_proximo: TRectangle;
    lbl_proximo: TLabel;
    tbcCategory: TTabControl;
    Lay3_Advanced: TLayout;
    Lay1_Beginner: TLayout;
    Lay2_Intermediario: TLayout;
    Lay_Categ_Menu: TLayout;
    lbl_txt_Beginner: TLabel;
    lbl_txt_Intermediate: TLabel;
    lbl_txt_Advanced: TLabel;
    Rect_Barra: TRectangle;
    Lay_Ranking: TLayout;
    VertScrollBox: TVertScrollBox;
    lbl_Ranking: TLabel;
    Rect_Ranking: TRectangle;
    Lay_TabsCategory: TLayout;
    Lay_WordsAndPhrases: TLayout;
    lbl_txt_Words: TLabel;
    lbl_txt_Phrases: TLabel;
    Rectangle1: TRectangle;
    TabControl: TTabControl;
    btnLeft: TButton;
    btnRight: TButton;
    Lay_Categ_Body: TLayout;
    Img_Flag: TGlyph;
    Rect_Flag: TRectangle;
    Img_Exit: TGlyph;
    Rect_Exit: TRectangle;
    Img_Exit2: TGlyph;
    Rect_Exit2: TRectangle;

    procedure imgBack3Click(Sender: TObject);
    procedure rect_btn_searchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rect_btn_englishClick(Sender: TObject);
    procedure rect_btn_portugueseClick(Sender: TObject);
    procedure rect_btn_frenchClick(Sender: TObject);
    procedure rect_btn_spanishClick(Sender: TObject);
    procedure rect_btn_italianClick(Sender: TObject);
    procedure Rect_ExitClick(Sender: TObject);
    procedure Img_SearchClick(Sender: TObject);
    procedure rect_voltarClick(Sender: TObject);
    procedure rect_proximoClick(Sender: TObject);

    procedure lbl_txt_AdvancedClick(Sender: TObject);
    procedure lbl_txt_BeginnerClick(Sender: TObject);
    procedure lbl_txt_IntermediateClick(Sender: TObject);
    procedure lbl_txt_WordsClick(Sender: TObject);
    procedure lbl_txt_PhrasesClick(Sender: TObject);
    procedure btnRightClick(Sender: TObject);
    procedure btnLeftClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rect_FlagClick(Sender: TObject);

  private
    { Private declarations }
    FCategoryArray: TCategoryArray;
    FCircleArray: TCircleArray;
    FLayout: TLayout;
    FSemAds: Boolean;
    FCadeadoFrasesDesabilitado: Boolean;
    FIsShowing: Boolean;
    HorzScrollBox: THorzScrollBox;
    FLayoutName, FHorzScrollBoxName: string;

    procedure CategoryClick(Sender: TObject); overload;
    procedure CategoryClick(Sender: TObject; const Point: TPointF); overload;

    procedure ListarCategoria;
    procedure ProcessaCategoria;
    procedure AddCategoriaLv2(Category: ICategory; ALayout: TLayout);
    procedure Search(id_subcategoria: Integer; busca: string);
    function FText: IText;
    procedure NextTab(ATabControl: TTabControl; Index: Integer);
    procedure NextCategory(Sender: TObject; Index: Integer);
    procedure Change_Language;
    procedure ListarRanking;
    procedure ListarParametro;
    procedure ProcessaRanking;
    procedure ProcessaParametro;
    procedure ExibirCampos(pShow: Boolean = True);
    function GetCurrentHorzScroll(ATabItem: TTabItem): THorzScrollBox;
    function GetCircleFrame: TCircleFrame;
    procedure SetCircleFrame(const Value: TCircleFrame);
  protected
    { Protected declarations }
    procedure SetColors; override;
  public
    { Public declarations }
    FMeaning: IMeaning;
    property SemAds: Boolean read FSemAds;
    property CadeadoFrasesDesabilitado: Boolean read FCadeadoFrasesDesabilitado;
    procedure SaveNativeLanguage;
    procedure SetNativeLanguage(Value: TNativeLanguage); overload;
    procedure SetTab(Value: Integer);
    procedure SetMeaning(Value: IMeaning);
    procedure OnFinishThread(Sender: TObject);

    property CircleFrame: TCircleFrame read GetCircleFrame write SetCircleFrame;

  end;

var
  FrmCategory: TFrmCategory;

implementation

{$R *.fmx}

uses UnitDM, UnitMeaning, uHorizontalMeaning, uRanking,
  UnitLogin, UnitConstante, System.IOUtils;

procedure TFrmCategory.FormCreate(Sender: TObject);
begin
  FIsShowing := True;
  TabControl.Visible := False;

  inherited;
end;

procedure TFrmCategory.FormShow(Sender: TObject);
var
  t: TThread;
begin
  inherited;
  if FMeaning.CloseApplication then
    Close;

  ExibirCampos(False);
  Set404(False);

  t := TThread.CreateAnonymousThread(
    procedure
    begin
      ListarCategoria;

      ListarRanking;

      ListarParametro;

      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
          btnLeft.Visible := False;
          btnRight.Visible := False;
{$ENDIF}
          Self.StyleBook := StyleBook;

          Img_Search.Visible := TabSearch.Visible;

        end);

    end);
  t.OnTerminate := OnFinishThread;
  t.Start;
end;

procedure TFrmCategory.OnFinishThread(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    ExibirCampos;
    TrataException(Sender, FText.getText404,
      procedure
      begin
        FormShow(Sender);
      end);
    Exit;
  end;

  ExibirCampos;
  FIsShowing := False;
  Application.ProcessMessages;
end;

procedure TFrmCategory.ProcessaRanking;
var
  JsonArray: TJSONArray;
  ArrayElement: TJSONValue;
  JSON, erro: string;
  Pos: Integer;
  LRanking: TRankingFrame;
  bmp: TBitmap;
begin
  if dm.RequestListarRanking.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    raise Exception.Create('Error listing ranking: ' +
      dm.RequestListarRanking.Response.StatusText);
  end;

  JSON := dm.RequestListarRanking.Response.JSONValue.ToString;
  JsonArray := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
    as TJSONArray;

  bmp := nil;

  try
    Pos := 1;
    for ArrayElement in JsonArray do
    begin
      LRanking := TRankingFrame.Create(VertScrollBox);
      LRanking.Parent := VertScrollBox;
      LRanking.Name := 'Ranking_' + Pos.ToString;
      LRanking.Align := TAlignLayout.MostTop;

      LRanking.img_Country.ImageIndex :=
        TCountry.Parse_Value(ArrayElement.GetValue<Integer>('COUNTRY'))
        .ImageIndex;
      LRanking.Rect_Ranking.Tag := ArrayElement.GetValue<Integer>('ID_USUARIO');
      LRanking.lblName.Text := ArrayElement.GetValue<String>('NOME');
      LRanking.lblPosition.Text := Pos.ToString;
      LRanking.lblPoints.Text := ArrayElement.GetValue<Integer>
        ('QTD_TOTAL').ToString;

      if ArrayElement.GetValue<String>('FOTO') <> '' then
      begin
        try
          bmp := TFunctions.BitmapFromBase64
            (ArrayElement.GetValue<String>('FOTO'));
          LRanking.Circle_Perfil.Fill.Bitmap.Bitmap := bmp;

        finally
          if Assigned(bmp) then
            FreeAndNil(bmp);
        end;

      end;

      Inc(Pos);
    end;
  finally
    if Assigned(JsonArray) then
      JsonArray.DisposeOf;
  end;

end;

function TFrmCategory.FText: IText;
begin
  Result := TText.New(FMeaning.NativeLanguage);
end;

function TFrmCategory.GetCurrentHorzScroll(ATabItem: TTabItem): THorzScrollBox;
begin
  FLayoutName := 'LayoutCateg' + ATabItem.TagString;
  FHorzScrollBoxName := 'HorzScrollBox' + ATabItem.TagString;

  FLayout := TLayout(ATabItem.FindComponent(FLayoutName));
  Result := THorzScrollBox(FLayout.FindComponent(FHorzScrollBoxName));

end;

procedure TFrmCategory.rect_btn_englishClick(Sender: TObject);
begin
  SetNativeLanguage(nlEnglish);
end;

procedure TFrmCategory.rect_btn_frenchClick(Sender: TObject);
begin
  SetNativeLanguage(nlFrench);
end;

procedure TFrmCategory.rect_btn_italianClick(Sender: TObject);
begin
  SetNativeLanguage(nlItalian);

end;

procedure TFrmCategory.rect_btn_portugueseClick(Sender: TObject);
begin
  SetNativeLanguage(nlPortuguese);
end;

procedure TFrmCategory.rect_btn_spanishClick(Sender: TObject);
begin
  SetNativeLanguage(nlSpanish);
end;

procedure TFrmCategory.Rect_FlagClick(Sender: TObject);
begin
  inherited;
  NextTab(TabControl, 0);
end;

procedure TFrmCategory.ListarCategoria;
begin

  dm.RequestListarCategoria.Params.Clear;
  dm.RequestListarCategoria.AddParameter('Id_Usuario',
    FMeaning.User.Id_Usuario.ToString);
  dm.RequestListarCategoria.AddParameter('native_language',
    FMeaning.NativeLanguage.AsValue.ToString);
  dm.RequestListarCategoria.Execute;

  ProcessaCategoria;
  // dm.RequestListarCategoria.ExecuteAsync(ProcessaCategoria, True, True,
  // ErroRequest);

end;

procedure TFrmCategory.ListarRanking;
begin
  dm.RequestListarRanking.Execute;
  ProcessaRanking;
  // dm.RequestListarRanking.ExecuteAsync(ProcessaRanking, True, True,
  // ErroRequest);

end;

procedure TFrmCategory.ListarParametro;
begin
  dm.RequestParametro.Execute;
  ProcessaParametro;

end;

procedure TFrmCategory.ProcessaCategoria;
var
  JSON: string;
  JsonArray: TJSONArray;
  ArrayElement: TJSONValue;
  iContItem: Integer;
  _old_category: Integer;
  TabItem: TTabItem;
  ALayout: TLayout;
  IsPhrase: Boolean;
  erro: string;

  procedure CriaCateg(categoria: ICategory);
  begin
    if _old_category <> categoria.id_categoria then
    begin
      TabItem := TTabItem.Create(tbcCategory);
      TabItem.Align := TAlignLayout.Client;
      // TabItem.Width := 200;
      TabItem.Parent := tbcCategory;
      TabItem.HitTest := True;
      TabItem.IsSelected := True;
      TabItem.StyleLookup := '';
      TabItem.Name := 'TabItem' + categoria.id_categoria.ToString;
      TabItem.TagString := categoria.id_categoria.ToString;

      ALayout := TLayout.Create(TabItem);
      ALayout.Parent := TabItem;
      ALayout.Align := TAlignLayout.Client;
      ALayout.Size.PlatformDefault := False;
      ALayout.Name := 'LayoutCateg' + categoria.id_categoria.ToString;
      TabItem.AddObject(ALayout);

      HorzScrollBox := THorzScrollBox.Create(ALayout);
      HorzScrollBox.Parent := ALayout;
      HorzScrollBox.Align := TAlignLayout.Client;
      // HorzScrollBox.Margins.Top := 15;
      HorzScrollBox.Name := 'HorzScrollBox' + categoria.id_categoria.ToString;
      HorzScrollBox.Size.PlatformDefault := False;
      HorzScrollBox.ShowScrollBars := False;
      ALayout.AddObject(HorzScrollBox);
    end;

    AddCategoriaLv2(categoria, ALayout);

    _old_category := categoria.id_categoria;
  end;

begin
  try
    erro := '';
    _old_category := 0;
    iContItem := 0;
    Lay_Ranking.Height := Trunc(Self.Height / 3);

    // var slteste := TStringList.Create;
    // slteste.Text := JsonArray.ToString;
    // slteste.savetofile('jsonArrayCategory.json');

    if dm.RequestListarCategoria.Response.StatusCode <> 200 then
    begin
      ExibirCampos;
      raise Exception.Create('Error listing categories: ' +
        dm.RequestListarCategoria.Response.StatusText);
    end;

    JSON := dm.RequestListarCategoria.Response.JSONValue.ToString;
    JsonArray := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJSONArray;

    for ArrayElement in JsonArray do
    begin
      Inc(iContItem);
      SetLength(FCategoryArray, iContItem);
      SetLength(FCircleArray, iContItem);

      FCategoryArray[iContItem - 1] := TCategory.New;
      FCategoryArray[iContItem - 1].SetContItem(iContItem);
      FCategoryArray[iContItem - 1].Setid_subcategoria
        (ArrayElement.GetValue<Integer>('ID'));
      FCategoryArray[iContItem - 1].Setid_categoria
        (ArrayElement.GetValue<Integer>('ID_CATEGORIA'));
      FCategoryArray[iContItem - 1].SetCateg_English
        (ArrayElement.GetValue<string>('CATEG_ENGLISH'));
      FCategoryArray[iContItem - 1].SetCateg_Spanish
        (ArrayElement.GetValue<string>('CATEG_SPANISH'));
      FCategoryArray[iContItem - 1].SetCateg_French
        (ArrayElement.GetValue<string>('CATEG_FRENCH'));
      FCategoryArray[iContItem - 1].SetCateg_Italian
        (ArrayElement.GetValue<string>('CATEG_ITALIAN'));
      FCategoryArray[iContItem - 1].SetCateg_Portuguese
        (ArrayElement.GetValue<string>('CATEG_PORTUGUESE'));
      FCategoryArray[iContItem - 1].Setdescricao_categoria
        (ArrayElement.GetValue<string>('DESCRICAO_CATEGORIA'));
      FCategoryArray[iContItem - 1].Setword_phrase
        (ArrayElement.GetValue<string>('WORD_PHRASE'));
      FCategoryArray[iContItem - 1].Seticone
        (ArrayElement.GetValue<string>('ICONE'));
      FCategoryArray[iContItem - 1].Settotal_words
        (ArrayElement.GetValue<Integer>('TOTAL_WORDS'));
      FCategoryArray[iContItem - 1].Settotal_complete
        (ArrayElement.GetValue<Integer>('TOTAL_COMPLETE'));

      FCategoryArray[iContItem - 1].SetENGLISH_SW
        (ArrayElement.GetValue<Integer>('SELECT_ENGLISH'));
      FCategoryArray[iContItem - 1].SetSPANISH_SW
        (ArrayElement.GetValue<Integer>('SELECT_SPANISH'));
      FCategoryArray[iContItem - 1].SetFRENCH_SW
        (ArrayElement.GetValue<Integer>('SELECT_FRENCH'));
      FCategoryArray[iContItem - 1].SetITALIAN_SW
        (ArrayElement.GetValue<Integer>('SELECT_ITALIAN'));
      FCategoryArray[iContItem - 1].SetPORTUGUESE_SW
        (ArrayElement.GetValue<Integer>('SELECT_PORTUGUESE'));

      FCategoryArray[iContItem - 1].SetENGLISH_COMPL
        (ArrayElement.GetValue<Integer>('COMPL_ENGLISH'));
      FCategoryArray[iContItem - 1].SetSPANISH_COMPL
        (ArrayElement.GetValue<Integer>('COMPL_SPANISH'));
      FCategoryArray[iContItem - 1].SetFRENCH_COMPL_QTD
        (ArrayElement.GetValue<Integer>('COMPL_FRENCH'));
      FCategoryArray[iContItem - 1].SetITALIAN_COMPL
        (ArrayElement.GetValue<Integer>('COMPL_ITALIAN'));
      FCategoryArray[iContItem - 1].SetPORTUGUESE_COMPL
        (ArrayElement.GetValue<Integer>('COMPL_PORTUGUESE'));

      FCategoryArray[iContItem - 1].SetENGLISH_MEM
        (ArrayElement.GetValue<Integer>('MEMORIZE_ENGLISH'));
      FCategoryArray[iContItem - 1].SetSPANISH_MEM
        (ArrayElement.GetValue<Integer>('MEMORIZE_SPANISH'));
      FCategoryArray[iContItem - 1].SetFRENCH_MEM_QTD
        (ArrayElement.GetValue<Integer>('MEMORIZE_FRENCH'));
      FCategoryArray[iContItem - 1].SetITALIAN_MEM
        (ArrayElement.GetValue<Integer>('MEMORIZE_ITALIAN'));
      FCategoryArray[iContItem - 1].SetPORTUGUESE_MEM
        (ArrayElement.GetValue<Integer>('MEMORIZE_PORTUGUESE'));

      CriaCateg(FCategoryArray[iContItem - 1]);
    end;

  finally
    if Assigned(JsonArray) then
      JsonArray.DisposeOf;

    if FMeaning.TypeCateg = csPhrase then
    begin
      lbl_txt_Phrases.Opacity := cOpacity1;
      lbl_txt_Words.Opacity := cOpacity05;
    end
    else
    begin
      lbl_txt_Words.Opacity := cOpacity1;
      lbl_txt_Phrases.Opacity := cOpacity05;
    end;

    // if TabCategoria.Index <> FMeaning.CurrentCategIndex then
    // begin
    case FMeaning.CurrentCategIndex of
      0, 3:
        NextCategory(lbl_txt_Beginner, FMeaning.CurrentCategIndex);
      1, 4:
        NextCategory(lbl_txt_Intermediate, FMeaning.CurrentCategIndex);
      2, 5:
        NextCategory(lbl_txt_Advanced, FMeaning.CurrentCategIndex);
    end;
    // end;
  end;
end;

procedure TFrmCategory.ProcessaParametro;
var
  jsonObj: TJsonObject;
  ArrayElement: TJSONValue;
  JSON, sucesso, erro: string;
  Pos: Integer;
  LRanking: TRankingFrame;
  bmp: TBitmap;
begin
  if dm.RequestParametro.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    raise Exception.Create('Error listing parameters: ' +
      dm.RequestParametro.Response.StatusText);
  end;

 jsonObj := nil;

  try
    JSON := dm.RequestParametro.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    FMeaning.Parametro.Version := jsonObj.GetValue('VERSION').Value;
    FMeaning.Parametro.Developer := jsonObj.GetValue('DEVELOPER').Value;
    FMeaning.Parametro.TermsConditions_ENG := jsonObj.GetValue('TERMSCONDITIONS_ENG').Value;
    FMeaning.Parametro.TermsConditions_FRN := jsonObj.GetValue('TERMSCONDITIONS_FRN').Value;
    FMeaning.Parametro.TermsConditions_ITA := jsonObj.GetValue('TERMSCONDITIONS_ITA').Value;
    FMeaning.Parametro.TermsConditions_PTB := jsonObj.GetValue('TERMSCONDITIONS_PTB').Value;
    FMeaning.Parametro.TermsConditions_SPN := jsonObj.GetValue('TERMSCONDITIONS_SPN').Value;

    FMeaning.Parametro.PrivacyPolicy_ENG := jsonObj.GetValue('PRIVACYPOLICY_ENG').Value;
    FMeaning.Parametro.PrivacyPolicy_FRN := jsonObj.GetValue('PRIVACYPOLICY_FRN').Value;
    FMeaning.Parametro.PrivacyPolicy_ITA := jsonObj.GetValue('PRIVACYPOLICY_ITA').Value;
    FMeaning.Parametro.PrivacyPolicy_PTB := jsonObj.GetValue('PRIVACYPOLICY_PTB').Value;
    FMeaning.Parametro.PrivacyPolicy_SPN := jsonObj.GetValue('PRIVACYPOLICY_SPN').Value;
  finally
    jsonObj.DisposeOf;

  end;


end;

procedure TFrmCategory.ExibirCampos(pShow: Boolean);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          SkLoading.Visible := not pShow;
          SkLoading.Enabled := SkLoading.Visible;

          if TabControl.Visible <> pShow then
            TabControl.Visible := pShow;

          if TabControl.Visible and (TabControl.Opacity <> 1) then
            TabControl.Opacity := 1;
        end);

    end).Start;

end;

function TFrmCategory.GetCircleFrame: TCircleFrame;
begin
  if not Assigned(FCircleArray[Length(FCircleArray) - 1]) then
  begin
    FCircleArray[Length(FCircleArray) - 1] :=
      TCircleFrame.Create(HorzScrollBox);
  end;
  Result := FCircleArray[Length(FCircleArray) - 1];
end;

procedure TFrmCategory.SetCircleFrame(const Value: TCircleFrame);
begin
  FCircleArray[Length(FCircleArray) - 1] := Value;
end;

procedure TFrmCategory.SetColors;
begin
  inherited;
  rect_btn_english.Fill.Color := CurrentTheme.ColorButton;
  rect_btn_french.Fill.Color := CurrentTheme.ColorButton;
  rect_btn_italian.Fill.Color := CurrentTheme.ColorButton;
  rect_btn_portuguese.Fill.Color := CurrentTheme.ColorButton;
  rect_btn_spanish.Fill.Color := CurrentTheme.ColorButton;
  rect_voltar.Fill.Color := CurrentTheme.ColorButton;
  rect_proximo.Fill.Color := CurrentTheme.ColorButton;

  lbl_english.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_french.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_italian.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_portuguese.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_spanish.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_voltar.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_proximo.TextSettings.FontColor := CurrentTheme.ColorFontLabel;

  lbl_txt_selectlanguage.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  lbl_txt_Category.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_txt_Beginner.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_txt_Intermediate.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_txt_Advanced.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Ranking.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_txt_Words.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_txt_Phrases.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_txt_title_search.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  edt_search.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;

end;

procedure TFrmCategory.AddCategoriaLv2(Category: ICategory; ALayout: TLayout);
var
  fFile: string;
  IsPhrase: Boolean;

  function getSize: Single;
  begin
{$IFDEF MSWINDOWS}
    Result := ALayout.Height;
{$ELSE}
    Result := Trunc(ALayout.Width - 5);
{$ENDIF}
  end;

begin
  CircleFrame.Parent := HorzScrollBox;
  CircleFrame.Name := 'CircleFrame_' + Category.id_subcategoria.ToString;
  CircleFrame.Align := TAlignLayout.Left;
  CircleFrame.Height := ALayout.Height;
  CircleFrame.Layout.Height := getSize;
  CircleFrame.Layout.Width := getSize;
  CircleFrame.LblAlphabet.Font.Size := getSize / 2;

  IsPhrase := (TCategorySelected.Parse_Value(Category.word_phrase) = csPhrase);

  if (not Category.icone.IsEmpty) then
  begin
    if IsPhrase then
    begin
      fFile := TPath.Combine(TFunctions.getPathImage, Category.icone + '.json');

      if FileExists(fFile) then
      begin
        CircleFrame.ImageCircle.Enabled := False;
        CircleFrame.ImageCircle.LoadFromFile(fFile);
        CircleFrame.ImageCircle.Enabled := True;
      end;
      CircleFrame.LblAlphabet.Text := '';
    end
    else // word
      CircleFrame.LblAlphabet.Text := Category.icone;
  end;

  CircleFrame.Circle.Tag := Category.ContItem;
  if Category.percent_complete = 100 then
    CircleFrame.LineCircle.Stroke.Color := $FFEABC1B;

  CircleFrame.imgLock.Visible := False;
  // (FMeaning.User.Id_Usuario = 0) and IsPhrase;
  CircleFrame.LblAlphabet.Visible := not IsPhrase;
  // CircleFrame.ImageCircle.Visible := CircleFrame.imgLock.Visible;

  FMeaning.SetItem(CategoryClick);
  // CircleFrame.ImageCircle.OnAnimationFinished := FMeaning.OnDeactivate;

{$IFDEF MSWINDOWS}
  CircleFrame.Circle.OnClick := FMeaning.ClickItem;
{$ELSE}
  CircleFrame.Circle.OnTap := FMeaning.TapItem;
{$ENDIF}
  CircleFrame.TrackBar.Value := Category.percent_complete;
  CircleFrame.LblText.Text := Category.descricao(FMeaning.NativeLanguage);

  if FMeaning.User.Id_Usuario > 0 then
    CircleFrame.LblDescription.Text := Category.descricao_categoria + sLineBreak
      + Format('(%.2f', [Category.percent_complete]) + '%)'
  else
    CircleFrame.LblDescription.Text := '';
end;

procedure TFrmCategory.NextTab(ATabControl: TTabControl; Index: Integer);
begin
  if FIsShowing then
    ATabControl.TabIndex := Index
  else
  begin
    ATabControl.GotoVisibleTab(Index, TTabTransition.Slide);
  end;
end;

procedure TFrmCategory.Change_Language;
var
  I, J: Integer;
begin
  Img_Flag.ImageIndex := FMeaning.NativeLanguage.ImageIndex;
  lbl_txt_Beginner.Text := FText.getTextBeginner;
  lbl_txt_Intermediate.Text := FText.getTextIntermediary;
  lbl_txt_Advanced.Text := FText.getTextAdvanced;

  lbl_txt_Phrases.Text := FText.getTextPhrases;
  lbl_txt_Words.Text := FText.getTextWords;
  lbl_Ranking.Text := FText.getTextRanking;

  lbl_txt_selectlanguage.Text := FText.getTextSelectNativeLanguage;
  lbl_txt_Category.Text := FText.getTextCategory;
  lbl_txt_title_search.Text := FText.getTextSearch;
  edt_search.TextPrompt := FText.getTextTypeHere;
  lbl_txt_search.Text := FText.getTextSearch;
  lbl_voltar.Text := FText.getTextBack;
  lbl_proximo.Text := FText.getTextNext;

  if tbcCategory.TabCount > 0 then
  begin
    for I := 0 to tbcCategory.TabCount - 1 do
    begin
      HorzScrollBox := GetCurrentHorzScroll(tbcCategory.Tabs[I]);
      for J := 0 to HorzScrollBox.ComponentCount - 1 do
      begin
        if HorzScrollBox.Components[J] is TCircleFrame then
        begin
          CircleFrame := TCircleFrame(HorzScrollBox.Components[J]);
          CircleFrame.LblText.Text := FCategoryArray[CircleFrame.Circle.Tag - 1]
            .descricao(FMeaning.NativeLanguage);
        end;
      end;
    end;
  end;
end;

procedure TFrmCategory.Search(id_subcategoria: Integer; busca: string);
var
  I: Integer;
  h: THorizontalMeaning;
  JsonArray: TJSONArray;
  ArrayElement: TJSONValue;
  TabItem: TTabItem;
  ta: TNativeLanguage;
  erro: string;
begin
  // lv_Search.Items.Clear;

  if NOT dm.Search(id_subcategoria, FMeaning.NativeLanguage.Sufix, busca, 0,
    JsonArray, erro) then
  begin
    ShowMessage(erro);
    Exit;
  end;

  for I := TabControlAba3.TabCount downto 0 do
    TabControlAba3.Delete(I);

  h := THorizontalMeaning.Create(TabControl, FMeaning);

  try
    for ArrayElement in JsonArray do
    begin
      FMeaning.SetCodItem(ArrayElement.GetValue<Integer>('ID'));
      FMeaning.SetPortuguese(ArrayElement.GetValue<string>('PORTUGUESE'));
      FMeaning.SetEnglish(ArrayElement.GetValue<string>('ENGLISH'));
      FMeaning.SetSpanish(ArrayElement.GetValue<string>('SPANISH'));
      FMeaning.SetFrench(ArrayElement.GetValue<string>('FRENCH'));
      FMeaning.SetItalian(ArrayElement.GetValue<string>('ITALIAN'));

      FMeaning.SetAudioPortuguese
        (ArrayElement.GetValue<string>('AUDIO_PORTUGUESE'));
      FMeaning.SetAudioEnglish(ArrayElement.GetValue<string>('AUDIO_ENGLISH'));
      FMeaning.SetAudioSpanish(ArrayElement.GetValue<string>('AUDIO_SPANISH'));
      FMeaning.SetAudioFrench(ArrayElement.GetValue<string>('AUDIO_FRENCH'));
      FMeaning.SetAudioItalian(ArrayElement.GetValue<string>('AUDIO_ITALIAN'));

{$IFDEF MSWINDOWS}
      FMeaning.SetItem(dm.ClickAudioNative);
{$ELSE}
      FMeaning.SetItem(dm.ClickAudioNative);
{$ENDIF}
      // Layout dentro do Horizontal Scroll Box, necessário para fazer o scroll com mais de um item
      TabItem := TTabItem.Create(TabControlAba3);
      TabItem.Align := TAlignLayout.Client;
      TabItem.Parent := TabControlAba3;
      TabItem.HitTest := True;
      TabItem.IsSelected := True;
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
    JsonArray.DisposeOf;
    h.DisposeOf;
    TabControlAba3.GotoVisibleTab(0, TTabTransition.None)
  end;

end;

procedure TFrmCategory.rect_voltarClick(Sender: TObject);
begin
  TabControlAba3.Previous(TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmCategory.rect_proximoClick(Sender: TObject);
begin
  TabControlAba3.Next(TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

function ConverteValor(vl: string): double;
begin
  try
    vl := vl.Replace(',', '').Replace('.', '');
    Result := vl.ToDouble / 100;
  except
    Result := 0;
  end;
end;

procedure TFrmCategory.rect_btn_searchClick(Sender: TObject);
begin
  Search(0, edt_search.Text);

end;

procedure TFrmCategory.SetMeaning(Value: IMeaning);
begin
  FMeaning := Value;
  SetColors;
  SetTab(0);
  if (FMeaning.User.Id_Usuario > 0) and (FMeaning.NativeLanguage <> nlUnknow)
  then
    NextTab(TabControl, 1)
  else if (FMeaning.NativeLanguage = nlUnknow) then
    FMeaning.SetNativeLanguage(DefaultLanguage);

  Change_Language;

end;

procedure TFrmCategory.SetNativeLanguage(Value: TNativeLanguage);
begin
  // NextCategory(lbl_txt_Beginner, FMeaning.TypeCateg.Beginner);
  FMeaning.SetNativeLanguage(Value);

  dm.RequestSetNativeLanguage.Params.Clear;
  dm.RequestSetNativeLanguage.AddParameter('native_language',
    FMeaning.NativeLanguage.AsValue.ToString);
  dm.RequestSetNativeLanguage.AddParameter('Id_Usuario',
    FMeaning.User.Id_Usuario.ToString);
  // faz com que rode em thread paralela
  dm.RequestSetNativeLanguage.ExecuteAsync(SaveNativeLanguage, True, True,
    ErroRequest);
end;

procedure TFrmCategory.SaveNativeLanguage;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin
  if dm.RequestSetNativeLanguage.Response.StatusCode <> 200 then
  begin
    ShowMessage('Error verifying phone/email to recover password: ' +
      dm.RequestSetNativeLanguage.Response.StatusText);
    Exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestSetNativeLanguage.Response.JSONValue.ToString;
    // pega o json do request
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
    Change_Language;
    NextTab(TabControl, 1);
  end;

end;

procedure TFrmCategory.SetTab(Value: Integer);
begin
  if NOT TabControl.Tabs[Value].Visible then
    TabControl.Tabs[Value].Visible := True;

  TabControl.GotoVisibleTab(Value, TTabTransition.None);
end;

procedure TFrmCategory.Rect_ExitClick(Sender: TObject);
begin
  if NOT Assigned(FrmLogin) then
    Application.CreateForm(TFrmLogin, FrmLogin);
  FrmLogin.SetResetSavedData(True);
  FrmLogin.SetNativeLanguage(FMeaning.NativeLanguage);
  Application.MainForm := FrmLogin;
  FrmLogin.Show;
  Self.Close;
end;

procedure TFrmCategory.imgBack3Click(Sender: TObject);
begin
  NextTab(TabControl, 1);
end;

procedure TFrmCategory.Img_SearchClick(Sender: TObject);
begin
  NextTab(TabControl, 2);
end;

procedure TFrmCategory.NextCategory(Sender: TObject; Index: Integer);
begin
  if FIsShowing then
    Rect_Barra.Position.x := TLayout(TLabel(Sender).Parent).Position.x
  else
  begin
    TAnimator.AnimateFloat(Rect_Barra, 'Position.X',
      TLayout(TLabel(Sender).Parent).Position.x, 0.25, TAnimationType.InOut,
      TInterpolationType.Linear);
  end;

  NextTab(tbcCategory, Index);
end;

procedure TFrmCategory.lbl_txt_BeginnerClick(Sender: TObject);
begin
  FMeaning.SetCurrentCategIndex(FMeaning.TypeCateg.Beginner);
  NextCategory(Sender, FMeaning.TypeCateg.Beginner);
end;

procedure TFrmCategory.lbl_txt_IntermediateClick(Sender: TObject);
begin
  FMeaning.SetCurrentCategIndex(FMeaning.TypeCateg.Intermediate);
  NextCategory(Sender, FMeaning.TypeCateg.Intermediate);
end;

procedure TFrmCategory.lbl_txt_AdvancedClick(Sender: TObject);
begin
  FMeaning.SetCurrentCategIndex(FMeaning.TypeCateg.Advanced);
  NextCategory(Sender, FMeaning.TypeCateg.Advanced);
end;

procedure TFrmCategory.lbl_txt_PhrasesClick(Sender: TObject);
begin
  lbl_txt_Phrases.Opacity := 1;
  lbl_txt_Words.Opacity := 0.3;

  FMeaning.SetTypeCateg(csPhrase);
  FMeaning.SetCurrentCategIndex(FMeaning.TypeCateg.Beginner);
  NextCategory(lbl_txt_Beginner, FMeaning.TypeCateg.Beginner);
end;

procedure TFrmCategory.lbl_txt_WordsClick(Sender: TObject);
begin
  lbl_txt_Words.Opacity := 1;
  lbl_txt_Phrases.Opacity := 0.3;

  FMeaning.SetTypeCateg(csWord);
  FMeaning.SetCurrentCategIndex(FMeaning.TypeCateg.Beginner);
  NextCategory(lbl_txt_Beginner, FMeaning.TypeCateg.Beginner);
end;

procedure TFrmCategory.CategoryClick(Sender: TObject);
begin
  if TCircle(Sender).Tag = 0 then
    ShowMessage(FText.getTextErrorNoCategory)
  else
  begin
    FMeaning.SetCategory(FCategoryArray[TCircle(Sender).Tag - 1]);

    if NOT Assigned(FrmMeaning) then
      Application.CreateForm(TFrmMeaning, FrmMeaning);
    FrmMeaning.SetMeaning(FMeaning);
    Application.MainForm := FrmMeaning;
    FrmMeaning.Show;
    Self.Close;
  end;

end;

procedure TFrmCategory.btnLeftClick(Sender: TObject);
begin
  inherited;
  HorzScrollBox := GetCurrentHorzScroll(tbcCategory.ActiveTab);

  if Assigned(HorzScrollBox) then
    HorzScrollBox.ScrollBy(100, 0);
end;

procedure TFrmCategory.btnRightClick(Sender: TObject);
begin
  inherited;
  HorzScrollBox := GetCurrentHorzScroll(tbcCategory.ActiveTab);

  if Assigned(HorzScrollBox) then
    HorzScrollBox.ScrollBy(-100, 0);
end;

procedure TFrmCategory.CategoryClick(Sender: TObject; const Point: TPointF);
begin
  Self.CategoryClick(Sender);

end;

procedure TFrmCategory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  for var I := 0 to Length(FCircleArray) - 1 do
  begin
    // FCircleArray[i].LetterAnimation.Stop;
    if Assigned(FCircleArray[I].ImageCircle) then
      FCircleArray[I].ImageCircle.Enabled := False;
  end;
  Action := TCloseAction.caFree;
  FrmCategory := nil;
end;

end.
