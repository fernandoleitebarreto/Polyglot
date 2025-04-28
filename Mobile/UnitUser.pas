unit UnitUser;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Generics.Collections, FMX.Types, FMX.Controls,
  FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Ani,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl, FMX.Edit, FMX.Layouts, System.JSON, System.NetEncoding,
  Soap.EncdDecd, UnitDM, FMX.ListBox, FMX.ImgList, System.ImageList,
  u99Permissions, uFunctions, UnitPadrao,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  uClassTexts, uClassSendCode, uClassCountry, FMX.MediaLibrary.Actions,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.Skia, Skia, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.MediaLibrary;

type

  TNotifyEvent = procedure(Sender: TObject) of Object;

  TFrmUser = class(TFrmPadrao)
    TabControl: TTabControl;
    TabUser: TTabItem;
    Layout_Photo: TLayout;
    Rect_Name: TRectangle;
    edt_perfil_nome: TEdit;
    Rect_Email: TRectangle;
    edt_perfil_email: TEdit;
    Rect_Phone: TRectangle;
    edt_perfil_phone: TEdit;
    TabPassword: TTabItem;
    Rect_User: TRectangle;
    lbl_Settings: TLabel;
    img_Back: TImage;
    Img_Perfil_Back: TImage;
    Lay_Password: TLayout;
    Rect_Password: TRectangle;
    edt_perfil_password: TEdit;
    Rect_New_Password: TRectangle;
    edt_perfil_new_password: TEdit;
    Layout_Bottom: TLayout;
    rect_SaveUser: TRectangle;
    lbl_SaveUser: TLabel;
    FloatAnimationSave: TFloatAnimation;
    LayoutForm: TLayout;
    TabPhoto: TTabItem;
    LayoutPhoto: TLayout;
    img_photo: TImage;
    img_library: TImage;
    ActionList: TActionList;
    ActLibrary: TTakePhotoFromLibraryAction;
    ActCamera: TTakePhotoFromCameraAction;
    lbl_perfil_email: TLabel;
    lbl_perfil_nome: TLabel;
    lbl_perfil_phone: TLabel;
    cbbCountryCode: TComboBox;
    lbCountryCode: TListBoxItem;
    lbl_perfil_new_password: TLabel;
    lbl_perfil_password: TLabel;
    Rect_Theme: TRectangle;
    cbbTheme: TComboBox;
    lbl_perfil_theme: TLabel;
    LbTheme: TListBoxItem;
    Img_ShowNewPassword: TImage;
    Img_HideNewPassword: TImage;
    FloatAnimationNewPassword: TFloatAnimation;
    Img_HidePassword: TImage;
    FloatAnimationPassword: TFloatAnimation;
    Img_ShowPassword: TImage;
    Layout1: TLayout;
    rect_SavePassword: TRectangle;
    lbl_SavePassword: TLabel;
    TabConfig: TTabItem;
    Rect_EditUser: TRectangle;
    lbl_EditUser: TLabel;
    Sk_EditUser: TSkSvg;
    Rect_PrivacyPolicy: TRectangle;
    lbl_PrivacyPolicy: TLabel;
    Sk_PrivacyPolicy: TSkSvg;
    Rect_TermsConditions: TRectangle;
    lbl_TermsConditions: TLabel;
    Sk_TermsConditions: TSkSvg;
    Rect_EditPassword: TRectangle;
    lbl_EditPassword: TLabel;
    sk_EditPassword: TSkSvg;
    Rect_DeleteAccount: TRectangle;
    lbl_DeleteAccount: TLabel;
    Sk_DeleteAccount: TSkSvg;
    TabTermsAndConditions: TTabItem;
    TabPrivacyPolicy: TTabItem;
    TabDeleteAccount: TTabItem;
    Circle_Perfil: TCircle;
    imgEdit: TGlyph;
    Layout_Data: TLayout;
    Lay_DeleteAccount: TLayout;
    Rect_ConfirmDeleteAccount: TRectangle;
    lbl_ConfirmDeleteAccount: TLabel;
    Rect_ConfirmPassword: TRectangle;
    edt_ConfirmPassword: TEdit;
    Img_HideConfirmPassword: TImage;
    FloatAnimationConfirmPassword: TFloatAnimation;
    Img_ShowConfirmPassword: TImage;
    lbl_ConfirmPassword: TLabel;
    Rect_PrivacyPolicyText: TRectangle;
    mmPrivacyPolicy: TMemo;
    Rect_TermsAndConditions: TRectangle;
    mmTermsAndConditions: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_BackClick(Sender: TObject);
    procedure FloatAnimationSaveFinish(Sender: TObject);
    procedure rect_voltarClick(Sender: TObject);
    procedure rect_SaveUserClick(Sender: TObject);
    procedure cbbCountryCodeChange(Sender: TObject);
    procedure img_libraryClick(Sender: TObject);
    procedure img_photoClick(Sender: TObject);
    procedure ActPhotoDidFinishTaking(Image: TBitmap);
    procedure Circle_PerfilClick(Sender: TObject);
    procedure cbbThemeChange(Sender: TObject);
    procedure FloatAnimationPasswordFinish(Sender: TObject);
    procedure FloatAnimationNewPasswordFinish(Sender: TObject);
    procedure Img_ShowPasswordClick(Sender: TObject);
    procedure Img_ShowNewPasswordClick(Sender: TObject);
    procedure rect_SavePasswordClick(Sender: TObject);
    procedure Rect_EditUserClick(Sender: TObject);
    procedure Rect_EditPasswordClick(Sender: TObject);
    procedure Rect_PrivacyPolicyClick(Sender: TObject);
    procedure Rect_DeleteAccountClick(Sender: TObject);
    procedure Rect_TermsConditionsClick(Sender: TObject);
    procedure Rect_ConfirmDeleteAccountClick(Sender: TObject);
    procedure Img_ShowConfirmPasswordClick(Sender: TObject);
    procedure FloatAnimationConfirmPasswordFinish(Sender: TObject);

  private
    { Private declarations }
    FMeaning: IMeaning;
    permissao: T99Permissions;
    procedure CarregarImagemNoBitmap;
    procedure ErroPermissao(Sender: TObject);
    procedure ExibirCampos(pShow: Boolean = True);
    function FText: IText;
    procedure SetTab(Index: Integer; AHeader: string);
    procedure Change_Language;
    function getPhoneNumber: string;
    function PhoneCode: string;
    procedure UpdateUser;
    procedure UpdatePassword;
    procedure DeleteAccount;
    function getCountry: TCountry;
    function getTheme: TTheme;
  protected
    { Protected declarations }
    procedure SetColors; override;
  public
    { Public declarations }
    procedure SetMeaning(Value: IMeaning);

  end;

var
  FrmUser: TFrmUser;

const
  TabIndexMenu = 0;
  TabIndexEditUser = 1;
  TabIndexEditPassword = 2;
  TabIndexChangePhoto = 3;
  TabIndexTermsConditions = 4;
  TabIndexPrivacyPolicy = 5;
  TabIndexDeleteAccount = 6;

implementation

uses
  UMD5, UnitMeaning, System.UIConsts, UnitConstante, SaveStateHelper;

{$R *.fmx}

procedure TFrmUser.ErroPermissao(Sender: TObject);
begin
  ShowMessage('Você não possui permissão para esse recurso');
end;

procedure TFrmUser.FormCreate(Sender: TObject);
begin
  inherited;
  // Classe de permissao...
  permissao := T99Permissions.Create;
  Self.StyleBook := StyleBook;
  TCountry.Popula_Combo(cbbCountryCode, claWhite);
  TTheme.Popula_Combo(cbbTheme, claWhite);
  TabControl.GotoVisibleTab(0, TTabTransition.None);
  Img_Perfil_Back.Bitmap := nil;
  FloatAnimationPassword.Duration := 0.3;
  FloatAnimationNewPassword.Duration := 0.3;
end;

procedure TFrmUser.cbbCountryCodeChange(Sender: TObject);
begin
  getCountry.EditPhone(edt_perfil_phone);
end;

function TFrmUser.getTheme: TTheme;
begin
  Result := TTheme.Parse_Value(cbbTheme.ItemIndex + 1);
end;

procedure TFrmUser.cbbThemeChange(Sender: TObject);
begin
  inherited;
  if CurrentTheme <> getTheme then
  begin
    CurrentTheme := getTheme;
    SaveState(GENERAL, THEME, CurrentTheme.AsValue.ToString);
    SetColors;
    if Assigned(FrmMeaning) then
    begin
      FrmMeaning.Close;
      FreeAndNil(FrmMeaning);
    end;
  end;
end;

function TFrmUser.FText: IText;
begin
  Result := TText.New(FMeaning.NativeLanguage);
end;

function TFrmUser.PhoneCode: string;
begin
  Result := getCountry.PhoneCode;
end;

procedure TFrmUser.Rect_ConfirmDeleteAccountClick(Sender: TObject);
begin
  inherited;
  if edt_ConfirmPassword.Text.Trim = '' then
  begin
    if edt_ConfirmPassword.CanFocus then
      edt_ConfirmPassword.SetFocus;
    ShowMessage(FText.getTextEmptyCurrentPassword);
    exit;
  end;

  FloatAnimationSave.TagString := 'DELETE-ACCOUNT';
  FloatAnimationSave.Start;

end;

procedure TFrmUser.Rect_DeleteAccountClick(Sender: TObject);
begin
  inherited;
  SetTab(TabIndexDeleteAccount, lbl_DeleteAccount.Text);
end;

procedure TFrmUser.Rect_EditPasswordClick(Sender: TObject);
begin
  inherited;
  SetTab(TabIndexEditPassword, lbl_EditPassword.Text);
end;

procedure TFrmUser.Rect_EditUserClick(Sender: TObject);
begin
  inherited;
  SetTab(TabIndexEditUser, lbl_EditUser.Text);
end;

procedure TFrmUser.Rect_PrivacyPolicyClick(Sender: TObject);
begin
  inherited;
  SetTab(TabIndexPrivacyPolicy, lbl_PrivacyPolicy.Text);
end;

procedure TFrmUser.Change_Language;
begin
  lbl_Settings.Text := FText.getTextSettings;
  lbl_EditUser.Text := FText.getTextEditUser;
  lbl_SaveUser.Text := FText.getTextSaveUser;
  lbl_EditPassword.Text := FText.getTextEditPassword;
  lbl_SavePassword.Text := FText.getTextSavePassword;
  lbl_TermsConditions.Text := FText.getTextTermsConditions;
  lbl_PrivacyPolicy.Text := FText.getTextPrivacyPolicy;
  lbl_DeleteAccount.Text := FText.getTextDeleteAccount;
  lbl_ConfirmDeleteAccount.Text := FText.getTextDeleteAccount;

  edt_perfil_nome.TextPrompt := FText.getTextName;
  edt_perfil_email.TextPrompt := FText.getTextEmail;
  edt_perfil_phone.TextPrompt := FText.getTextPhone;
  edt_perfil_password.TextPrompt := FText.getTextCurrentPassword;
  edt_perfil_new_password.TextPrompt := FText.getTextNewPassword;
  edt_ConfirmPassword.TextPrompt := FText.getTextCurrentPassword;

  lbl_perfil_nome.Text := FText.getTextName;
  lbl_perfil_email.Text := FText.getTextEmail;
  lbl_perfil_phone.Text := FText.getTextPhone;
  lbl_perfil_password.Text := FText.getTextCurrentPassword;
  lbl_perfil_new_password.Text := FText.getTextNewPassword;
  lbl_perfil_theme.Text := FText.getTextTheme;
  lbl_ConfirmPassword.Text := FText.getTextCurrentPassword;
end;

procedure TFrmUser.Circle_PerfilClick(Sender: TObject);
begin
  SetTab(TabIndexChangePhoto, lbl_EditUser.Text);
end;

procedure TFrmUser.DeleteAccount;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin
  if dm.RequestSaveNewPassword.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage('Erro ao alterar dados: ' + dm.RequestSaveNewPassword.Response.
      StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestSaveNewPassword.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;

    ExibirCampos;
    if sucesso <> 'S' then
    begin
      ShowMessage(erro);
      exit;
    end
    else
    begin
      FMeaning.SetCloseApplication(True);
      Close;
    end;
  finally
    jsonObj.DisposeOf;
  end;

end;

procedure TFrmUser.ExibirCampos(pShow: Boolean);
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
          LayoutForm.Visible := pShow;
          if TabControl.Visible and (TabControl.Opacity <> 1) then
            TabControl.Opacity := 1;
        end);

    end).Start;

end;

procedure TFrmUser.rect_voltarClick(Sender: TObject);
begin
  TabControl.Previous(TTabTransition.Slide, TTabTransitionDirection.Normal);
end;

procedure TFrmUser.rect_SaveUserClick(Sender: TObject);
begin
  FloatAnimationSave.TagString := 'UPDATE-ACCOUNT';
  FloatAnimationSave.Start;
end;

procedure TFrmUser.Rect_TermsConditionsClick(Sender: TObject);
begin
  inherited;
  SetTab(TabIndexTermsConditions, lbl_TermsConditions.Text);
end;

procedure TFrmUser.rect_SavePasswordClick(Sender: TObject);
begin
  inherited;
  if edt_perfil_password.Text.Trim = '' then
  begin
    if edt_perfil_password.CanFocus then
      edt_perfil_password.SetFocus;
    ShowMessage(FText.getTextEmptyCurrentPassword);
    exit;
  end
  else if edt_perfil_new_password.Text.Trim = '' then
  begin
    if edt_perfil_new_password.CanFocus then
      edt_perfil_new_password.SetFocus;
    ShowMessage(FText.getTextEmptyNewPassword);
    exit;
  end;

  FloatAnimationSave.TagString := 'UPDATE-PASSWORD';
  FloatAnimationSave.Start;

end;

procedure TFrmUser.SetColors;
begin
  inherited;
  rect_SaveUser.Fill.Color := CurrentTheme.ColorButton;
  rect_SavePassword.Fill.Color := CurrentTheme.ColorButton;

  lbl_perfil_nome.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  edt_perfil_nome.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_perfil_email.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  edt_perfil_email.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_perfil_phone.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  edt_perfil_phone.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_perfil_password.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  edt_perfil_password.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_perfil_new_password.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  edt_perfil_new_password.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
end;

procedure TFrmUser.SetMeaning(Value: IMeaning);
var
  bmp: TBitmap;
begin
  bmp := nil;
  FMeaning := Value;

  edt_perfil_nome.Text := FMeaning.User.Nome;
  edt_perfil_email.Text := FMeaning.User.Email;
  cbbCountryCode.ItemIndex := FMeaning.User.Country.ImageIndex;
  edt_perfil_phone.Text := Copy(FMeaning.User.Telefone, Length(PhoneCode) + 1,
    Length(FMeaning.User.Telefone)).Trim;

  mmTermsAndConditions.Lines.Text := FMeaning.TermsAndConditions;
  mmPrivacyPolicy.Lines.Text := FMeaning.PrivacyPolicy;

  if FMeaning.User.Foto <> '' then
  begin
    bmp := TFunctions.BitmapFromBase64(FMeaning.User.Foto);
    try
      Circle_Perfil.Fill.Bitmap.Bitmap := bmp;
      Img_Perfil_Back.Bitmap := bmp;
    finally
      if Assigned(bmp) then
        FreeAndNil(bmp);
    end;
  end;

  if FMeaning.NativeLanguage <> nlUnknow then
    Change_Language;
end;

procedure TFrmUser.SetTab(Index: Integer; AHeader: string);
begin
  if NOT TabControl.Tabs[Index].Visible then
    TabControl.Tabs[Index].Visible := True;

  lbl_Settings.Text := AHeader;
  TabControl.GotoVisibleTab(Index, TTabTransition.Slide);
end;

procedure TFrmUser.img_BackClick(Sender: TObject);
begin
  if (TabControl.ActiveTab.Index = 0) then
  begin
    Close;
    exit;
  end;

  SetTab(TabIndexMenu, lbl_Settings.Text);

end;

procedure TFrmUser.img_libraryClick(Sender: TObject);
begin
{$IFNDEF MSWINDOWS}
  permissao.Storage(ActLibrary, ErroPermissao);
{$ELSE}
  CarregarImagemNoBitmap;
{$ENDIF}
end;

procedure TFrmUser.img_photoClick(Sender: TObject);
begin
{$IFNDEF MSWINDOWS}
  permissao.Camera(ActCamera, ErroPermissao);
{$ELSE}
  CarregarImagemNoBitmap;
{$ENDIF}
end;

procedure TFrmUser.Img_ShowConfirmPasswordClick(Sender: TObject);
begin
  inherited;
  FloatAnimationConfirmPassword.Inverse := not edt_ConfirmPassword.Password;
  FloatAnimationConfirmPassword.Start;

end;

procedure TFrmUser.Img_ShowNewPasswordClick(Sender: TObject);
begin
  inherited;
  FloatAnimationNewPassword.Inverse := not edt_perfil_new_password.Password;
  FloatAnimationNewPassword.Start;
end;

procedure TFrmUser.Img_ShowPasswordClick(Sender: TObject);
begin
  inherited;
  FloatAnimationPassword.Inverse := not edt_perfil_password.Password;
  FloatAnimationPassword.Start;
end;

procedure TFrmUser.FloatAnimationConfirmPasswordFinish(Sender: TObject);
begin
  inherited;
  edt_ConfirmPassword.Password := FloatAnimationConfirmPassword.Inverse = True;
end;

procedure TFrmUser.FloatAnimationNewPasswordFinish(Sender: TObject);
begin
  inherited;
  edt_perfil_new_password.Password := FloatAnimationNewPassword.Inverse = True;
end;

procedure TFrmUser.FloatAnimationPasswordFinish(Sender: TObject);
begin
  inherited;
  edt_perfil_password.Password := FloatAnimationPassword.Inverse = True;
end;

procedure TFrmUser.FloatAnimationSaveFinish(Sender: TObject);
begin
  ExibirCampos(False);
  try
    if FloatAnimationSave.TagString = 'UPDATE-ACCOUNT' then
    begin
      dm.RequestUptUser.Params.Clear;
      dm.RequestUptUser.AddParameter('native_language',
        FMeaning.NativeLanguage.AsValue.ToString);
      dm.RequestUptUser.AddParameter('code', FMeaning.User.Id_Usuario.ToString);
      dm.RequestUptUser.AddParameter('name', edt_perfil_nome.Text);
      dm.RequestUptUser.AddParameter('email', edt_perfil_email.Text);
      dm.RequestUptUser.AddParameter('phone', getPhoneNumber);

      if not Img_Perfil_Back.Bitmap.IsEmpty then
      begin
        dm.RequestUptUser.AddParameter('foto',
          TFunctions.Base64FromBitmap(Img_Perfil_Back.Bitmap));
      end
      else
        dm.RequestUptUser.AddParameter('foto', '');
      dm.RequestUptUser.ExecuteAsync(UpdateUser, True, True, ErroRequest);

    end
    else if FloatAnimationSave.TagString = 'UPDATE-PASSWORD' then
    begin
      dm.RequestSaveNewPassword.Params.Clear;
      dm.RequestSaveNewPassword.AddParameter('native_language',
        FMeaning.NativeLanguage.AsValue.ToString);
      dm.RequestSaveNewPassword.AddParameter('email', edt_perfil_email.Text);
      dm.RequestSaveNewPassword.AddParameter('originalpassword',
        MD5(edt_perfil_password.Text));
      dm.RequestSaveNewPassword.AddParameter('confirmpassword',
        MD5(edt_perfil_new_password.Text));
      dm.RequestSaveNewPassword.AddParameter('newpassword',
        MD5(edt_perfil_new_password.Text));
      dm.RequestSaveNewPassword.AddParameter('action',
        ocsResetPassword.AsValue.ToString);
      dm.RequestSaveNewPassword.ExecuteAsync(UpdatePassword, True, True,
        ErroRequest);
    end
    else if FloatAnimationSave.TagString = 'DELETE-ACCOUNT' then
    begin
      dm.RequestDeleteAccount.Params.Clear;
      dm.RequestDeleteAccount.AddParameter('native_language',
        FMeaning.NativeLanguage.AsValue.ToString);
      dm.RequestDeleteAccount.AddParameter('email', edt_perfil_email.Text);
      dm.RequestDeleteAccount.AddParameter('password',
        MD5(edt_ConfirmPassword.Text));
      dm.RequestDeleteAccount.ExecuteAsync(DeleteAccount, True, True,
        ErroRequest);
    end
    else
    begin
      raise Exception.Create('An action tag has not been defined: ' +
        FloatAnimationSave.TagString);
    end;

  except
    on ex: Exception do
    begin
      ExibirCampos;
      raise Exception.Create('Error Message: ' + ex.Message);
    end;
  end;
end;

function TFrmUser.getCountry: TCountry;
begin
  Result := TCountry.Parse(cbbCountryCode.ItemIndex + 1);
end;

function TFrmUser.getPhoneNumber: string;
begin
  Result := PhoneCode + edt_perfil_phone.Text;
end;

procedure TFrmUser.ActPhotoDidFinishTaking(Image: TBitmap);
begin
  Circle_Perfil.Fill.Bitmap.Bitmap := Image;
  Img_Perfil_Back.Bitmap := Image;
  SetTab(TabIndexEditUser, lbl_EditUser.Text);

end;

procedure TFrmUser.UpdatePassword;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin
  if dm.RequestSaveNewPassword.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage('Erro ao alterar dados: ' + dm.RequestSaveNewPassword.Response.
      StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestSaveNewPassword.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;

    ExibirCampos;
    if sucesso <> 'S' then
    begin
      ShowMessage(erro);
      exit;
    end
    else
    begin
      FMeaning.User.Senha := edt_perfil_new_password.Text;
      SetTab(TabIndexMenu, lbl_Settings.Text);
    end;
  finally
    jsonObj.DisposeOf;
  end;
end;

procedure TFrmUser.CarregarImagemNoBitmap;
var
  Bitmap: TBitmap;
  OpenDialog: TOpenDialog;
begin
  try
    OpenDialog := TOpenDialog.Create(nil);
    Bitmap := TBitmap.Create;
    try
      OpenDialog.Filter := '*.bmp;*.jpg;*.png';
      if OpenDialog.Execute then
      begin
        Bitmap.LoadFromFile(OpenDialog.FileName);
        if (Bitmap.Width = 0) or (Bitmap.Height = 0) then
          raise Exception.Create('Error loading image');

        Img_Perfil_Back.Bitmap.Assign(Bitmap);
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;

  finally
    Bitmap.Free;
    OpenDialog.Free;
  end;
end;

procedure TFrmUser.UpdateUser;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin
  if dm.RequestUptUser.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorUpdatingUser + ': ' +
      dm.RequestUptUser.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestUptUser.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;

    if sucesso <> 'S' then
    begin
      ExibirCampos;
      ShowMessage(erro);
      exit;
    end
    else
    begin
      FMeaning.User.Nome := edt_perfil_nome.Text;
      FMeaning.User.Email := edt_perfil_email.Text;
      FMeaning.User.Telefone := getPhoneNumber;

      if not Img_Perfil_Back.Bitmap.IsEmpty then
      begin
        FMeaning.User.Foto := TFunctions.Base64FromBitmap
          (Img_Perfil_Back.Bitmap);
      end;

      SetTab(TabIndexMenu, lbl_Settings.Text);
    end;
  finally
    jsonObj.DisposeOf;
    ExibirCampos;
    Close;
  end;
end;

procedure TFrmUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(permissao) then
    FreeAndNil(permissao);

  Action := TCloseAction.caFree;
  FrmUser := nil;

  if NOT Assigned(FrmMeaning) then
    Application.CreateForm(TFrmMeaning, FrmMeaning);
  FrmMeaning.SetMeaning(FMeaning);
  Application.MainForm := FrmMeaning;
  FrmMeaning.Show;
end;

end.
