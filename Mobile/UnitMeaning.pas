unit UnitMeaning;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Math, System.Variants, AdMob113,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Ani,
  FMX.Media, FMX.WebBrowser, IdBaseComponent, IdComponent, IdServerIOHandler,
  REST.Types, REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.TabControl, FMX.Advertising, uClassTexts,
  System.IOUtils, FMX.Gestures, System.ImageList, FMX.ImgList, System.Actions,
  FMX.ActnList, System.Sensors, System.Sensors.Components,
  uHorizontalMeaning, UnitPadrao, FMX.Skia, Skia;

type
  TNotifyEvent = procedure(Sender: TObject) of object;

  TFrmMeaning = class(TFrmPadrao)
    Lay_Bottom: TLayout;
    Rect_Next: TRoundRect;
    lbl_Next: TLabel;
    TabControl: TTabControl;
    ImgMenu: TImage;
    Lay_Top: TLayout;
    Rect_MainProgress: TRectangle;
    Rect_progress: TRectangle;
    Img_Exit: TGlyph;
    Lay_Menu: TLayout;
    AnimaMenu: TFloatAnimation;
    Rect_Menu_BackGround: TRectangle;
    Lay_Content: TLayout;
    Rect_Exit: TRectangle;
    Rect_Transition: TRectangle;
    rect_toolbar: TRectangle;
    FloatAnimationOpenForm: TFloatAnimation;
    Lay_Menu_List: TLayout;
    Rect_Menu: TRectangle;
    Rect_Menu_Top: TRectangle;
    Rect_Menu1_ChangeLanguage: TRectangle;
    Circle_Perfil: TCircle;
    Lbl_HelloUser: TLabel;
    Lbl_Title: TLabel;
    imgFlagLanguage: TGlyph;
    lbl_Menu_Change_Language: TLabel;
    Rect_Menu2_CompleteWords: TRectangle;
    Glyph2: TGlyph;
    lbl_Menu_CompleteWords: TLabel;
    Rect_Menu3_Memory: TRectangle;
    Glyph3: TGlyph;
    lbl_Menu_PracticeYourMemory: TLabel;
    AnimationMenuLateral: TFloatAnimation;
    Rect_Menu4_SelectWords: TRectangle;
    Glyph4: TGlyph;
    lbl_Menu_SelectWords: TLabel;
    Rect_Menu5_Logout: TRectangle;
    imgLogout: TGlyph;
    lbl_Menu_Logout: TLabel;
    imgConfig: TGlyph;
    Rect_CadWord: TRectangle;
    Glyph1: TGlyph;
    lbl_Menu_AddWords: TLabel;
    lbl_Contact: TLabel;
    lbl_Version: TLabel;
    GestureManager: TGestureManager;
    ActionList: TActionList;
    actNext: TAction;
    actLast: TAction;
    ImgPlay: TSkAnimatedImage;
    ImgPlay2: TImage;
    tmrExit: TTimer;
    tmrNext: TTimer;
    procedure MenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AnimaMenuFinish(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FechaMenuClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure TabControlGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure Rect_ExitClick(Sender: TObject);
    procedure AbreMenuChangeLanguage(Sender: TObject);
    procedure AbreMenuMemorize(Sender: TObject);
    procedure AbreMenuSelectWords(Sender: TObject);
    procedure AbreMenuCompleteWords(Sender: TObject);
    procedure AbreMenuLogout(Sender: TObject);
    procedure AbreMenuEditPerfil(Sender: TObject);
    procedure imgConfigTap(Sender: TObject; const Point: TPointF);
    procedure AbreMenuCadWord(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actLastExecute(Sender: TObject);
    procedure ImgPlayClick(Sender: TObject);
    procedure tmrExitTimer(Sender: TObject);
    procedure tmrNextTimer(Sender: TObject);

  private
    { Private declarations }
    FJSONValue: string;
    FMeaning: IMeaning;
    fStepBar, fStep: Single;
    FTabIndex, FOldTabIndex: Integer;
    FBannerAd, FRewarded: TAdBanner;
    FHorizontalMeaning: THorizontalMeaning;

    procedure ExibirCampos(pShow: Boolean = True);
    procedure ExibirAds(Proc: TProc; EnableRewarded: Boolean = True;
      EnableBanner: Boolean = True);
    procedure ListaDados;
    function FText: IText;
    procedure AnimationOpenFormFinish(Sender: TObject);
    function BannerClosed(Banner: TAdBannerType): TOnClosed;
    procedure LoadMenuOptions;
    procedure AbreForm(Proc: TProc); overload;
    procedure AbreForm(AUnitName: string); overload;
    procedure AbreForm; overload;
    procedure Init;

    procedure AbreMenu(AUnitName: string);
    function NeedToLoadTabs: Boolean;
    function GetStepBar: Single;
    procedure SetStepBar(const Value: Single);
    function GetStep: Single;
    procedure SetStep(const Value: Single);
    procedure DestroyBanners;
  protected
    { Protected declarations }
    procedure SetColors; override;

    property StepBar: Single read GetStepBar write SetStepBar;
    property Step: Single read GetStep write SetStep;
  public
    { Public declarations }
    procedure PressBack(Sender: TObject); overload;
    procedure PressBack(Sender: TObject; const Point: TPointF); overload;
    procedure SetMeaning(Value: IMeaning);
    procedure OnFinishThread(Sender: TObject);
  end;

var
  FrmMeaning: TFrmMeaning;

const
  cUnitAddAudio = 'UnitAddAudio';
  cUnitCadWords = 'UnitCadWords';
  cUnitCompleteWords = 'UnitCompleteWords';
  cUnitSelectWords = 'UnitSelectWords';
  cUnitEditUser = 'UnitEditUser';
  cUnitMemorize = 'UnitMemorize';
  cUnitPresentation = 'UnitPresentation';
  TIMER_EXIT = 10000;
  TIMER_NEXT = 300;

implementation

{$R *.fmx}

uses UnitCategory, UnitDM, uFunctions, UnitCadWords, UnitConstante,
  UnitAddAudio, System.JSON, UnitMemorize, Amazon.Storage.Service,
  UnitCompleteWords, UnitSelectWords, UnitLogin,
  UnitUser, UnitPresentation, uExibeAds;

procedure TFrmMeaning.FormCreate(Sender: TObject);
begin
  inherited;
  DisableBackButton := True;
  Self.StyleBook := StyleBook;
  Lay_Content.Visible := False;
  Lay_Menu.Visible := False;
  Rect_MainProgress.Visible := True;
  StepBar := 0;
  Step := 0;
  FOldTabIndex := 0;
  Rect_Menu.Margins.Left := 0 - Rect_Menu.Width;

  // dm.RectEffect(Rect_Next);
  Rect_Transition.SendToBack;
  Rect_Transition.Visible := False;
end;

procedure TFrmMeaning.FormShow(Sender: TObject);
begin
  if FMeaning.CloseApplication then
    Close;
  ExibirAds(Init, False);

end;

procedure TFrmMeaning.ExibirAds(Proc: TProc; EnableRewarded: Boolean = True;
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

      Sleep(3000);

{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
      Rect_Exit.Enabled := False;

      tmrExit.Enabled := False;
      tmrExit.Interval := TIMER_EXIT;
      tmrExit.Enabled := True;

      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          try
            if (FMeaning.EnableAds) then
            begin
              if EnableBanner then
              begin
                FBannerAd := TAdBanner.Create(Lay_Content,
                  TFunctions.AppIDBanner, TAdBannerType.Banner);
                FBannerAd.show(IsDebuging, TAlignLayout.MostBottom);
              end;

              if EnableRewarded then
              begin
                FRewarded := TAdBanner.Create(Lay_Content,
                  TFunctions.AppIDRewarded, TAdBannerType.Rewarded);
                FRewarded.show(IsDebuging);
              end;
            end;

          except
          end;

        end);
{$ENDIF}
    end);
  t.OnTerminate := OnFinishThread;
  t.Start;
end;

function TFrmMeaning.FText: IText;
begin
  Result := TText.New(FMeaning.NativeLanguage);
end;

function TFrmMeaning.GetStep: Single;
begin
  Result := StepBar * FTabIndex;
end;

function TFrmMeaning.GetStepBar: Single;
begin
  Result := (Rect_MainProgress.Width / (FHorizontalMeaning.getQuantidade));
end;

procedure TFrmMeaning.imgConfigTap(Sender: TObject; const Point: TPointF);
begin
  AbreMenuEditPerfil(Sender);
end;

procedure TFrmMeaning.AbreForm;
begin
  AbreForm(FloatAnimationOpenForm.TagString);

  FloatAnimationOpenForm.Inverse := not FloatAnimationOpenForm.Inverse;
  Rect_Transition.SendToBack;
  Rect_Transition.Visible := False;
  Lay_Bottom.Visible := not Rect_Transition.Visible;

end;

procedure TFrmMeaning.ImgPlayClick(Sender: TObject);
begin
  inherited;
  AbreForm(cUnitPresentation);
end;

procedure TFrmMeaning.Init;
begin
  Rect_progress.Width := 0;
  dm.RequestDados.Params.Clear;
  dm.RequestDados.AddParameter('Id_Usuario', FMeaning.User.Id_Usuario.ToString);
  dm.RequestDados.AddParameter('subcategory',
    FMeaning.Category.id_subcategoria.ToString);
  dm.RequestDados.AddParameter('field_subcategory',
    FMeaning.NativeLanguage.Sufix);
  dm.RequestDados.AddParameter('native_language',
    FMeaning.NativeLanguage.AsValue.ToString);
  dm.RequestDados.AddParameter('Form', '');
  // faz com que rode em thread paralela
  dm.RequestDados.ExecuteAsync(ListaDados, True, True, ErroRequest);
end;

procedure TFrmMeaning.ListaDados;
const
  cAudios = 'Audio.zip';
var
  jsonObj: TJsonObject;
begin
  jsonObj := nil;
  try
    FJSONValue := dm.RequestDados.Response.JSONValue.ToString;

    if dm.RequestDados.Response.StatusCode <> 200 then
    begin
      // pega o json do request
      jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FJSONValue),
        0) as TJsonObject;
      ExibirCampos;
      ShowMessage('Erro ao listar dados: ' + jsonObj.GetValue('erro').Value);
      exit;
    end;

    FHorizontalMeaning := THorizontalMeaning.Create(TabControl, FMeaning);
    FHorizontalMeaning.SetPress_Back(PressBack);
    FHorizontalMeaning.SetImageList(ilImages);
    // pega o json do request
    FHorizontalMeaning.setJson(FJSONValue);
    // FHorizontalMeaning.setAudioNative(dm.ClickAudioNative);
    FTabIndex := 0;
    FHorizontalMeaning.LoadFromJSON(0);

    TabControl.TabIndex := 0;
  finally
    jsonObj.DisposeOf;
  end;

end;

procedure TFrmMeaning.SetColors;
begin
  inherited;
  Rect_Menu_Top.Fill.Color := CurrentTheme.ColorBackGround;
  Rect_Transition.Fill.Color := CurrentTheme.ColorBackGround;
  Rect_Next.Fill.Color := CurrentTheme.ColorButton;

  Lbl_Title.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  Lbl_HelloUser.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;

  lbl_Menu_SelectWords.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_Menu_PracticeYourMemory.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabel;
  lbl_Menu_CompleteWords.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_Menu_Change_Language.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabel;
  lbl_Menu_Logout.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_Menu_AddWords.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_Contact.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_Version.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
end;

procedure TFrmMeaning.SetMeaning(Value: IMeaning);
var
  bmp: TBitmap;
begin
  bmp := nil;
  DisableBackButton := True;
  FMeaning := Value;
  FMeaning.ResetValues;
  FMeaning.SetItem(dm.ClickAudioNative);

  Rect_CadWord.Visible := FMeaning.User.Id_Usuario = cCodAdmin;

  if FMeaning.User.Id_Usuario > 0 then
    Lbl_HelloUser.Text := FText.getTextHello + ' ' + FMeaning.User.Nome
  else
    Lbl_HelloUser.Text := FText.getTextHello + ' ' + FText.getTextVisitant;

  if FMeaning.User.Foto <> '' then
  begin
    try
      bmp := TFunctions.BitmapFromBase64(FMeaning.User.Foto);
      Circle_Perfil.Fill.Bitmap.Bitmap := bmp;
    finally
      if Assigned(bmp) then
        FreeAndNil(bmp);
    end;
  end;

  lbl_Next.Text := FText.getTextNext;
  lbl_Menu_Change_Language.Text := FText.getTextMenuChangeLanguage;
  lbl_Menu_CompleteWords.Text := FText.getTextMenuCompleteWords;
  lbl_Menu_PracticeYourMemory.Text := FText.getTextMenuPracticeYourMemory;
  lbl_Menu_SelectWords.Text := FText.getTextMenuSelectWords;
  lbl_Menu_Logout.Text := FText.getTextMenuLogout;
  lbl_Menu_AddWords.Text := FText.getTextMenuAddWords;
  lbl_Version.Text := FText.getTextVersion + ': ' + FMeaning.Parametro.Version;
  // lbl_Developer.Text := FText.getTextDevelopedBy + ': ' +
  // FMeaning.Parametro.Developer;

end;

procedure TFrmMeaning.SetStep(const Value: Single);
begin
  fStep := Value;
end;

procedure TFrmMeaning.SetStepBar(const Value: Single);
begin
  fStepBar := Value;
end;

procedure TFrmMeaning.TabControlChange(Sender: TObject);
begin
  inherited;
  if (Lay_Top.Visible) and (not FHorizontalMeaning.IsLoadingData) then
  begin
    if FOldTabIndex < FTabIndex then
    begin
      if Rect_progress.Width < Rect_MainProgress.Width then
      begin
        TAnimator.AnimateFloat(Rect_progress, 'Width', Step, 0.3,
          TAnimationType.in, TInterpolationType.Linear);

      end;
    end
    else if FOldTabIndex > FTabIndex then
    begin
      if Rect_progress.Width > 0 then
      begin
        TAnimator.AnimateFloat(Rect_progress, 'Width', Step, 0.3,
          TAnimationType.out, TInterpolationType.Linear);

      end;
    end;
  end;
end;

procedure TFrmMeaning.AbreMenuCadWord(Sender: TObject);
begin
  AbreForm(cUnitCadWords);
end;

procedure TFrmMeaning.Rect_ExitClick(Sender: TObject);
begin
  AbreForm(
    procedure
    begin
      if not Assigned(FrmCategory) then
        Application.CreateForm(TFrmCategory, FrmCategory);
      FrmCategory.SetMeaning(FMeaning);
      FrmCategory.SetTab(1);
      Application.MainForm := FrmCategory;
      FrmCategory.show;
      Self.Close;
    end);
end;

procedure TFrmMeaning.AbreMenuEditPerfil(Sender: TObject);
begin
  if FMeaning.User.Id_Usuario <= 0 then
    exit;

  AbreForm(cUnitEditUser);
end;

procedure TFrmMeaning.AbreMenuChangeLanguage(Sender: TObject);
begin
  AbreForm(
    procedure
    begin
      if not Assigned(FrmCategory) then
        Application.CreateForm(TFrmCategory, FrmCategory);
      FrmCategory.SetMeaning(FMeaning);
      FrmCategory.SetTab(0);
      Application.MainForm := FrmCategory;
      FrmCategory.show;
      FrmMeaning.Close;
    end);
end;

procedure TFrmMeaning.AbreMenuMemorize(Sender: TObject);
begin
  AbreForm(cUnitMemorize);
end;

procedure TFrmMeaning.AbreMenuSelectWords(Sender: TObject);
begin
  AbreForm(cUnitSelectWords);
end;

procedure TFrmMeaning.PressBack(Sender: TObject);
begin
  actLastExecute(Sender);
end;

procedure TFrmMeaning.PressBack(Sender: TObject; const Point: TPointF);
begin
  actLastExecute(Sender);
end;

procedure TFrmMeaning.actLastExecute(Sender: TObject);
begin
  if FTabIndex > 0 then
  begin
    FOldTabIndex := FTabIndex;
    Rect_Next.Enabled := False;
    tmrNext.Enabled := False;
    tmrNext.Interval := TIMER_NEXT;
    tmrNext.Enabled := True;

    Dec(FTabIndex);

    if Trunc(FTabIndex / cMaxTabItems) <> Trunc(FOldTabIndex / cMaxTabItems)
    then
    begin
      FHorizontalMeaning.LoadFromJSON(FTabIndex, True);
      TabControl.Last(TTabTransition.None, TTabTransitionDirection.Normal);

    end
    else
      TabControl.Previous(TTabTransition.Slide, TTabTransitionDirection.Normal);
  end;
end;

procedure TFrmMeaning.actNextExecute(Sender: TObject);
begin
  if FTabIndex < FHorizontalMeaning.getQuantidade then
  begin
    FOldTabIndex := FTabIndex;
    Rect_Next.Enabled := False;
    tmrNext.Enabled := False;
    tmrNext.Interval := TIMER_NEXT;
    tmrNext.Enabled := True;

    Inc(FTabIndex);

    if Trunc(FTabIndex / cMaxTabItems) <> Trunc(FOldTabIndex / cMaxTabItems)
    then
    begin
      FHorizontalMeaning.LoadFromJSON(FTabIndex);

      TabControl.First(TTabTransition.Slide, TTabTransitionDirection.Normal);

      TabControlChange(Sender);

    end
    else
      TabControl.Next(TTabTransition.Slide, TTabTransitionDirection.Normal);

  end;
end;

procedure TFrmMeaning.TabControlGesture(Sender: TObject;
const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
    sgiLeft:
      begin
        actNextExecute(Sender);
        Handled := True;
      end;
    sgiRight:
      begin
        actLastExecute(Sender);
        Handled := True;
      end;
  end;
end;

procedure TFrmMeaning.AbreMenuCompleteWords(Sender: TObject);
begin
  AbreForm(cUnitCompleteWords);
end;

procedure TFrmMeaning.AbreMenuLogout(Sender: TObject);
begin
  AbreForm(
    procedure
    begin
      if NOT Assigned(FrmLogin) then
        Application.CreateForm(TFrmLogin, FrmLogin);
      FrmLogin.SetResetSavedData(True);
      FrmLogin.SetNativeLanguage(FMeaning.NativeLanguage);
      Application.MainForm := FrmLogin;
      FrmLogin.show;
      Self.Close;
    end);
end;

procedure TFrmMeaning.AnimaMenuFinish(Sender: TObject);
begin
  // Fecha Menu
  if AnimaMenu.Inverse = True then
  begin
    Lay_Menu.Visible := False;
    Rect_Menu.Margins.Left := 0 - Rect_Menu.Width;
  end
  else // Abre Menu
  begin
    LoadMenuOptions;

    AnimationMenuLateral.StartValue := Rect_Menu.Margins.Left;
    AnimationMenuLateral.StopValue := 0;
    AnimationMenuLateral.Start;

  end;

end;

procedure TFrmMeaning.MenuClick(Sender: TObject);
begin
  Lay_Menu.BringToFront;
  Lay_Menu.Position.Y := Self.Height + 20;
  Lay_Menu.Visible := True;

  AnimaMenu.Inverse := False;
  AnimaMenu.StartValue := Self.Height + 20;
  AnimaMenu.StopValue := 0;
  AnimaMenu.Start;

  // Roda icone menu para 90º
  ImgMenu.RotationAngle := 0;
  TAnimator.AnimateFloat(ImgMenu, 'RotationAngle', 90, 0.3,
    TAnimationType.InOut, TInterpolationType.Circular);
end;

function TFrmMeaning.NeedToLoadTabs: Boolean;
begin
  Result := Trunc(FTabIndex / cMaxTabItems) <>
    Trunc(FOldTabIndex / cMaxTabItems);
end;

procedure TFrmMeaning.ExibirCampos(pShow: Boolean = True);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          SkLoading.Visible := not pShow;
          SkLoading.Enabled := SkLoading.Visible;
          Lay_Content.Visible := pShow;
          if Lay_Content.Visible and (Lay_Content.Opacity <> 1) then
            Lay_Content.Opacity := 1;

        end);

    end).Start;
end;

procedure TFrmMeaning.FechaMenuClick(Sender: TObject);
begin
  // Roda icone menu para 90º
  ImgMenu.RotationAngle := 90;
  TAnimator.AnimateFloat(ImgMenu, 'RotationAngle', 0, 0.3, TAnimationType.InOut,
    TInterpolationType.Circular);

  AnimaMenu.Inverse := True;
  AnimaMenu.Start;
end;

procedure TFrmMeaning.AbreForm(Proc: TProc);
begin
  if AnimaMenu.Enabled then
  begin
    FechaMenuClick(nil);
  end;

  Proc;
end;

procedure TFrmMeaning.AbreForm(AUnitName: string);
begin
  if FMeaning.AccessBlock then
  begin
    ShowMessage(FText.getTextResourceNotAvaliable);
    exit;
  end;

  // DestroyBanners;

  if AUnitName = cUnitPresentation then
  begin
    if not Assigned(FrmPresentation) then
      Application.CreateForm(TFrmPresentation, FrmPresentation);
    FrmPresentation.setJson(FJSONValue);
    FrmPresentation.SetMeaning(FMeaning);
    Application.MainForm := FrmPresentation;
    FrmPresentation.show;
  end
  else if AUnitName = cUnitMemorize then
  begin
    if not Assigned(FrmMemorize) then
      Application.CreateForm(TFrmMemorize, FrmMemorize);
    FrmMemorize.SetMeaning(FMeaning);
    Application.MainForm := FrmMemorize;
    FrmMemorize.show;
  end
  else if AUnitName = cUnitAddAudio then
  begin
    if not Assigned(FrmAddAudio) then
      Application.CreateForm(TFrmAddAudio, FrmAddAudio);
    FrmAddAudio.SetMeaning(FMeaning);
    Application.MainForm := FrmAddAudio;
    FrmAddAudio.show;
  end
  else if AUnitName = cUnitCadWords then
  begin
    if not Assigned(FrmCadWords) then
      Application.CreateForm(TFrmCadWords, FrmCadWords);
    FrmCadWords.SetMeaning(FMeaning);
    Application.MainForm := FrmCadWords;
    FrmCadWords.show;
  end
  else if AUnitName = cUnitCompleteWords then
  begin
    if not Assigned(FrmCompleteWords) then
      Application.CreateForm(TFrmCompleteWords, FrmCompleteWords);
    FrmCompleteWords.SetMeaning(FMeaning);
    Application.MainForm := FrmCompleteWords;
    FrmCompleteWords.show;
  end
  else if AUnitName = cUnitSelectWords then
  begin
    if not Assigned(FrmSelectWords) then
      Application.CreateForm(TFrmSelectWords, FrmSelectWords);
    FrmSelectWords.SetMeaning(FMeaning);
    Application.MainForm := FrmSelectWords;
    FrmSelectWords.show;
  end
  else if AUnitName = cUnitEditUser then
  begin
    if not Assigned(FrmUser) then
      Application.CreateForm(TFrmUser, FrmUser);
    FrmUser.SetMeaning(FMeaning);
    Application.MainForm := FrmUser;
    FrmUser.show;
  end;
end;

procedure TFrmMeaning.AbreMenu(AUnitName: string);
begin
  if AnimaMenu.Enabled then
    FechaMenuClick(nil);

  Rect_Transition.BringToFront;
  Rect_Transition.Visible := True;
  Lay_Bottom.Visible := not Rect_Transition.Visible;

  FloatAnimationOpenForm.Tag := 1;
  FloatAnimationOpenForm.TagString := AUnitName;
  FloatAnimationOpenForm.Inverse := False;
  FloatAnimationOpenForm.StartValue := Self.Height;
  FloatAnimationOpenForm.StopValue := 0;
  FloatAnimationOpenForm.Duration := 0.1;
  FloatAnimationOpenForm.Start;

  FloatAnimationOpenForm.OnFinish := AnimationOpenFormFinish;

end;

procedure TFrmMeaning.AnimationOpenFormFinish(Sender: TObject);
begin
  if FloatAnimationOpenForm.Tag = 1 then
  begin
    FloatAnimationOpenForm.Tag := 0;

{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
    TThread.CreateAnonymousThread(
      procedure
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            AbreForm;

          end);
      end).Start();
{$ELSE}
    AbreForm;
{$ENDIF}
  end;
end;

function TFrmMeaning.BannerClosed(Banner: TAdBannerType): TOnClosed;
begin
  ExibirCampos;
end;

procedure TFrmMeaning.LoadMenuOptions;
begin
  imgFlagLanguage.ImageIndex := FMeaning.NativeLanguage.ImageIndex;
end;

procedure TFrmMeaning.tmrExitTimer(Sender: TObject);
begin
  inherited;
  Rect_Exit.Enabled := True;
  DisableBackButton := False;
  tmrExit.Enabled := False;
end;

procedure TFrmMeaning.tmrNextTimer(Sender: TObject);
begin
  inherited;
  Rect_Next.Enabled := True;
  tmrNext.Enabled := False;
end;

procedure TFrmMeaning.OnFinishThread(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    ExibirCampos;
    TrataException(Sender, FText.getText404,
      procedure
      begin
        FormShow(Sender);
      end);
    exit;
  end;

  ExibirCampos;
  Application.ProcessMessages;

end;

procedure TFrmMeaning.DestroyBanners;
begin
  if Assigned(FRewarded) then
    FreeAndNil(FRewarded);

  if Assigned(FBannerAd) then
    FreeAndNil(FBannerAd);
end;

procedure TFrmMeaning.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if Assigned(FHorizontalMeaning) then
    FHorizontalMeaning.DisposeOf;

  // ImgPlay.Loop := False;
  ImgPlay.Enabled := False;
  ImgPlay.Visible := False;

  DestroyBanners;

  Action := TCloseAction.caFree;
  FrmMeaning := nil;

end;

end.
