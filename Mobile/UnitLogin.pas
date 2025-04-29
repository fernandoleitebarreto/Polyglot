unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, ExtendParseApiUnit, FMX.Consts, FMX.Platform,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Ani,
  REST.Types, REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, FMX.TabControl, System.Actions,
  FMX.ActnList, FMX.MediaLibrary.Actions, FMX.StdActns, u99Permissions,
  System.NetEncoding, uMD5, REST.Backend.ParseProvider, System.ImageList,
  System.IOUtils, FMX.ImgList, FMX.ListBox, uClassSendCode,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf,
  uClassTexts, uClassCountry, uOpenViewURL, FMX.InAppPurchase, UnitPadrao,
  Skia.FMX, Skia, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP;

type
  TFrmLogin = class(TFrmPadrao)
    ActionList: TActionList;
    ActLogin: TChangeTabAction;
    ActConta: TChangeTabAction;
    ActCheckSMS: TChangeTabAction;
    ActSendSMSRecoverPassword: TChangeTabAction;
    ActResetPassword: TChangeTabAction;
    ActSocialMedia: TChangeTabAction;
    ActUpdateApp: TChangeTabAction;
    TabControl: TTabControl;
    FloatAnimation1: TFloatAnimation;
    TabLogin: TTabItem;
    Lay_Back_Login: TLayout;
    Rect_Back_Login: TRoundRect;
    Lay_Email_Login: TLayout;
    Rectangle1: TRoundRect;
    Image2: TImage;
    Edt_Email: TEdit;
    Lay_Password_Login: TLayout;
    Rectangle2: TRoundRect;
    Edt_Password: TEdit;
    Lay_Password2: TLayout;
    Img_HidePassword2: TImage;
    FloatAnimationPassword2: TFloatAnimation;
    Img_ShowPassword2: TImage;
    Lay_Bottom_Login: TLayout;
    lbl_CreateAccount: TLabel;
    lbl_ForgotPassword: TLabel;
    Rect_Login: TRoundRect;
    lbl_Login: TLabel;
    lbl_Title_AccessAccount: TLabel;
    TabConta: TTabItem;
    Lay_Back_New_Account: TLayout;
    Rect_Back_New_Account: TRoundRect;
    Lay_Email_Create: TLayout;
    Rectangle3: TRoundRect;
    edt_cad_email: TEdit;
    Image1: TImage;
    Lay_Password_Create: TLayout;
    Rectangle4: TRoundRect;
    edt_cad_password: TEdit;
    Lay_Password: TLayout;
    Img_HidePassword: TImage;
    FloatAnimationPassword: TFloatAnimation;
    Img_ShowPassword: TImage;
    Lay_Bottom_Create: TLayout;
    lbl_Login1: TLabel;
    Lay_Phone_Create: TLayout;
    Rectangle10: TRoundRect;
    Image9: TImage;
    edt_cad_phone: TEdit;
    cbbCountryCode: TComboBox;
    ListBoxItem1: TListBoxItem;
    Rect_CreateNewAccount: TRoundRect;
    lbl_CreateNewAccount: TLabel;
    FloatAnimation4: TFloatAnimation;
    lbl_Title_CreateNewAccount: TLabel;
    TabRecoverPassword: TTabItem;
    Lay_Back_Recover_Password: TLayout;
    Rect_Back_Recover_Password: TRoundRect;
    Lay_Phone_Recover_Password: TLayout;
    Rectangle6: TRoundRect;
    Img_phone_recoverpass: TImage;
    edt_phone_recoverpass: TEdit;
    cbbCountryCode2: TComboBox;
    ListBoxItem2: TListBoxItem;
    Lay_Recover_Password: TLayout;
    lbl_CreateAccount2: TLabel;
    lbl_Login2: TLabel;
    Rect_RecoverPassword: TRoundRect;
    lbl_RecoverPassword: TLabel;
    lbl_Title_ForgotPassword: TLabel;
    TabCheckSMS: TTabItem;
    Lay_Back_Check_SMS: TLayout;
    Rect_Back_CheckSMS: TRoundRect;
    Lay_CheckSMS: TLayout;
    Rect_CodeBackground: TRoundRect;
    Rect_Num1: TRoundRect;
    edt_Num1: TEdit;
    Rect_Num2: TRoundRect;
    edt_Num2: TEdit;
    Rect_Num3: TRoundRect;
    edt_Num3: TEdit;
    Rect_Num4: TRoundRect;
    edt_Num4: TEdit;
    Lay_Bottom_CheckSMS: TLayout;
    lbl_ResendCode: TLabel;
    lbl_Login4: TLabel;
    lbl_Title_Sent_Code: TLabel;
    Rect_VerifyCode: TRoundRect;
    lbl_VerifyCode: TLabel;
    lbl_Title_Check_SMS: TLabel;
    TabResetPassword: TTabItem;
    Lay_Back_SaveNewPassword: TLayout;
    Rect_Back_SaveNewPassword: TRoundRect;
    Lay_NewPassword_Save: TLayout;
    Rectangle7: TRoundRect;
    Edt_NewPassword: TEdit;
    Lay_NewPassword: TLayout;
    Img_HideNewPassword: TImage;
    FloatAnimationNewPassword: TFloatAnimation;
    Img_ShowNewPassword: TImage;
    Lay_ConfirmPassword_Save: TLayout;
    Rectangle8: TRoundRect;
    Edt_ConfirmPassword: TEdit;
    Lay_ConfirmPassword: TLayout;
    Img_HideConfirmPassword: TImage;
    FloatAnimationConfirmPassword: TFloatAnimation;
    Img_ShowConfirmPassword: TImage;
    Lay_Bottom_SavePassword: TLayout;
    lbl_CreateAccount3: TLabel;
    lbl_Login3: TLabel;
    Rect_SaveNewPassword: TRoundRect;
    lbl_SaveNewPassword: TLabel;
    lbl_Title_NewPassword: TLabel;
    TabUpdateApp: TTabItem;
    Layout9: TLayout;
    lbl_newversion: TLabel;
    lbl_updateapp: TLabel;
    Image3: TImage;
    img_seta: TImage;
    Rect_Update: TRoundRect;
    Rect_Background: TRoundRect;
    lbl_Visitant: TLabel;
    imgLogo: TImage;
    SkBackGround: TSkAnimatedImage;
    SkGlobe: TSkAnimatedImage;
    Rect_UpdateBackground: TRectangle;
    Lbl_Update: TLabel;
    Lay_SMSTimer: TLayout;
    SkSMSTimer: TSkAnimatedImage;
    SMSTimer: TTimer;
    Lay_Email_Recover_Password: TLayout;
    rect_email_recover_password: TRoundRect;
    img_email_recover_password: TImage;
    edt_email_recover_password: TEdit;
    lbl_Title_RecoverPassword: TLabel;
    procedure Rect_LoginClick(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Rect_CreateNewAccountClick(Sender: TObject);
    procedure Rect_RecoverPasswordClick(Sender: TObject);
    procedure ActContaExecute(Sender: TObject);
    procedure ActLoginExecute(Sender: TObject);
    procedure Rect_VerifyCodeClick(Sender: TObject);
    procedure Rect_SaveNewPasswordClick(Sender: TObject);
    procedure edt_phone_recoverpassTyping(Sender: TObject);
    procedure edt_Num1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edt_Num2KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edt_Num3KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure edt_Num4KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lbl_ResendCodeClick(Sender: TObject);
    procedure edt_cad_phoneTyping(Sender: TObject);
    procedure Img_ShowPasswordClick(Sender: TObject);
    procedure FloatAnimationPasswordFinish(Sender: TObject);
    procedure Img_ShowPassword2Click(Sender: TObject);
    procedure FloatAnimationPassword2Finish(Sender: TObject);
    procedure FloatAnimationConfirmPasswordFinish(Sender: TObject);
    procedure FloatAnimationNewPasswordFinish(Sender: TObject);
    procedure Img_ShowNewPasswordClick(Sender: TObject);
    procedure Img_ShowConfirmPasswordClick(Sender: TObject);
    procedure cbbCountryCode2Change(Sender: TObject);
    procedure cbbCountryCodeChange(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure Rect_EmailClick(Sender: TObject);
    procedure lbl_VisitantClick(Sender: TObject);
    procedure Rect_UpdateClick(Sender: TObject);
    procedure ActCheckSMSExecute(Sender: TObject);
    procedure ActSendSMSRecoverPasswordExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SMSTimerTimer(Sender: TObject);

    // procedure FloatAnimationPasswordTesteFinish(Sender: TObject);
    // procedure Img_ShowPasswordTesteClick(Sender: TObject);
  private
    { Private declarations }
    versao_server: Integer;
    FMeaning: IMeaning;
    FSendCode: TSendCode;
    FResetSavedData: Boolean;
    permissao: T99Permissions;
    procedure SendCodeToEmailSMS(AType: TSendType; AAction: TActionApp;
      ACode: string);
    procedure Init;
    procedure ErroPermissao(Sender: TObject);
    procedure ExibirCampos(pShow: Boolean = True);
    procedure AbrirPrincipal;
    procedure Change_Labels;
    procedure ProcessaLogin;
    procedure VerificaVersao;
    procedure ProcessaSMSRecoverPassword;
    procedure ProcessaSMSCreateAccount;
    procedure ProcessaEmailRecoverPassword;
    procedure ProcessaEmailCreateAccount;
    procedure VerifyCode;
    procedure SaveNewPassword;
    procedure ErroRequestLogin(Sender: TObject);
    function getPhoneNumber(origem: TActionApp): string;
    function FText: IText;
    function getNativeLanguage: TNativeLanguage;
    function getCountry(pCombo: TComboBox): TCountry;
    procedure CleanEdits;
    procedure CleanVerificationCode;
    procedure EnableTimer(Value: Boolean);
  protected
    { Protected declarations }
    procedure SetColors; override;
  public
    { Public declarations }
    procedure SetResetSavedData(const Value: Boolean);
    procedure SetNativeLanguage(Value: TNativeLanguage);
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses UnitDM, UnitMeaning, UnitCategory, uFunctions,
  SaveStateHelper, System.UIConsts, UnitConstante, System.StrUtils;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  inherited;
  FMeaning := TMeaning.New();
  TabControl.Visible := True;
  TabControl.ActiveTab := TabLogin;
  FloatAnimationPassword.Duration := 0.3;
  FloatAnimationPassword2.Duration := 0.3;
  // Versao atual do app...
  versao_server := 0;

  Self.StyleBook := StyleBook;
  FResetSavedData := False;
  Lay_Phone_Recover_Password.Visible := False;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
var
  t: TThread;
begin
  if NOT TFunctions.CheckInternet then
  begin
    Init;
    ShowMessage('Turn on the internet!');
    exit;
  end;
  Set404(False);

  t := TThread.CreateAnonymousThread(
    procedure
    begin
      if not FResetSavedData then
      begin
        ExibirCampos(False);
        LoadFormState;
        CurrentTheme := TTheme.Parse_Value(StrToIntDef(LoadState(GENERAL,
          THEME), 1));
        SetColors;
      end;

      if (Edt_Email.Text <> '') and (Edt_Password.Text <> '') then
      begin
        FMeaning.SetAutomaticLogin(True);
        // Consumir WS Login...
        dm.RequestLogin.Params.Clear;
        dm.RequestLogin.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestLogin.AddParameter('email', Edt_Email.Text);
        dm.RequestLogin.AddParameter('senha', MD5(Edt_Password.Text));
        // faz com que rode em thread paralela
        dm.RequestLogin.ExecuteAsync(ProcessaLogin, True, True,
          ErroRequestLogin);
      end
      else
      begin
        dm.RESTRequestParam.ExecuteAsync(VerificaVersao, True, True,
          ErroRequestLogin);

      end;

      {$IFDEF DEBUG}
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Edt_Email.Text := 'fernando.leitebarreto@gmail.com';
          Edt_Password.Text := '123';
        end);
      {$ENDIF}
    end);

  t.Start;
end;

procedure TFrmLogin.VerificaVersao;
var
  jsonObj: TJsonObject;
begin
  if dm.RequestLogin.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorValidLogin + ': ' +
      dm.RequestLogin.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    jsonObj := TJsonObject.ParseJSONValue
      (TEncoding.ASCII.GetBytes(dm.RESTRequestParam.Response.JSONValue.
      ToString), 0) as TJsonObject;

    versao_server := StrToIntDef(TJsonObject(jsonObj).GetValue('versao')
      .Value, 0);

    if not FMeaning.AutomaticLogin then
    begin
      Init;
      ExibirCampos;
      if Self.Tag < versao_server then
        ActUpdateApp.Execute;

    end;
  finally
    if Assigned(jsonObj) then
      jsonObj.DisposeOf;
  end;

end;

procedure TFrmLogin.Init;
begin
  // TabControl.TabPosition := TTabPosition.None;
  permissao := T99Permissions.Create;
  FSendCode := TSendCode.Create;
  EnableTimer(False);
  Change_Labels;
  TCountry.Popula_Combo(cbbCountryCode, claWhite);
  TCountry.Popula_Combo(cbbCountryCode2, claWhite);

  edt_phone_recoverpass.FilterChar := '0123456789-() ';
  edt_cad_phone.FilterChar := '0123456789-() ';
  edt_Num1.FilterChar := '0123456789';
  edt_Num2.FilterChar := '0123456789';
  edt_Num3.FilterChar := '0123456789';
  edt_Num4.FilterChar := '0123456789';

  edt_Num1.MaxLength := 1;
  edt_Num2.MaxLength := 1;
  edt_Num3.MaxLength := 1;
  edt_Num4.MaxLength := 1;
end;

function TFrmLogin.getCountry(pCombo: TComboBox): TCountry;
begin
  Result := TCountry.Parse_Value(pCombo.ListItems[pCombo.ItemIndex].Tag);
end;

function TFrmLogin.getNativeLanguage: TNativeLanguage;
begin
  if FMeaning.NativeLanguage <> nlUnknow then
    Result := FMeaning.NativeLanguage
  else
    Result := DefaultLanguage;
end;

function TFrmLogin.getPhoneNumber(origem: TActionApp): string;
begin
  Result := '';
  case origem of
    ocsActiveAccount:
      Result := getCountry(cbbCountryCode).PhoneCode + edt_cad_phone.Text;
    ocsResetPassword:
      Result := getCountry(cbbCountryCode2).PhoneCode +
        edt_phone_recoverpass.Text;
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Action');
  end;

end;

procedure TFrmLogin.cbbCountryCode2Change(Sender: TObject);
begin
  getCountry(cbbCountryCode2).EditPhone(edt_phone_recoverpass);
end;

procedure TFrmLogin.cbbCountryCodeChange(Sender: TObject);
begin
  getCountry(cbbCountryCode).EditPhone(edt_cad_phone);
end;

procedure TFrmLogin.edt_phone_recoverpassTyping(Sender: TObject);
begin
  getCountry(cbbCountryCode2).EditPhone(edt_phone_recoverpass);
end;

procedure TFrmLogin.edt_cad_phoneTyping(Sender: TObject);
begin
  getCountry(cbbCountryCode).EditPhone(edt_cad_phone);
end;

procedure TFrmLogin.edt_Num1KeyUp(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  if (Key <> vkBack) then
    edt_Num2.SetFocus;
end;

procedure TFrmLogin.edt_Num2KeyUp(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkBack) then
    edt_Num1.SetFocus
  else
    edt_Num3.SetFocus;
end;

procedure TFrmLogin.edt_Num3KeyUp(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkBack) then
    edt_Num2.SetFocus
  else
    edt_Num4.SetFocus;
end;

procedure TFrmLogin.edt_Num4KeyUp(Sender: TObject; var Key: Word;
var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkBack) then
    edt_Num3.SetFocus;
end;

procedure TFrmLogin.ExibirCampos(pShow: Boolean);
begin
  // if SkLoading.Visible = pShow then Exit;

  TThread.CreateAnonymousThread(
    procedure
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          TabControl.Visible := pShow;
          SkLoading.Visible := not pShow;
          SkLoading.Enabled := SkLoading.Visible;
          Rect_Background.Visible := pShow;
          SkBackGround.Enabled := Rect_Background.Visible;

          if TabControl.Visible and (TabControl.Opacity <> 1) then
            TabControl.Opacity := 1;

          // Application.ProcessMessages;
        end);

    end).Start;

end;

procedure TFrmLogin.AbrirPrincipal;
begin
  SaveFormState;
  if NOT Assigned(FrmCategory) then
    Application.CreateForm(TFrmCategory, FrmCategory);
  FrmCategory.SetMeaning(FMeaning);
  Application.MainForm := FrmCategory;
  FrmCategory.Show;
  Self.Close;

end;

procedure TFrmLogin.ProcessaLogin;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
  actived: Boolean;
  bitmap: TBitmap;
begin
  if dm.RequestLogin.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorValidLogin + ': ' +
      dm.RequestLogin.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestLogin.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
    actived := jsonObj.GetValue('actived').Value = '1';
    if sucesso <> 'S' then
    begin
      ExibirCampos;
      ShowMessage(erro);
      exit;
    end
    else if not actived then
    begin
      FSendCode.Email := Edt_Email.Text;

      dm.RequestSendEmailCreateAccount.Params.Clear;
      dm.RequestSendEmailCreateAccount.AddParameter('native_language',
        getNativeLanguage.AsValue.ToString);
      dm.RequestSendEmailCreateAccount.AddParameter('email', FSendCode.Email);
      // faz com que rode em thread paralela
      dm.RequestSendEmailCreateAccount.ExecuteAsync(ProcessaEmailCreateAccount,
        True, True, ErroRequestLogin);
    end
    else
    begin
      FMeaning.User.Id_Usuario := jsonObj.GetValue('Id_Usuario')
        .Value.ToInteger;
      FMeaning.User.Nome := jsonObj.GetValue('nome').Value;
      FMeaning.User.Email := jsonObj.GetValue('email').Value;
      FMeaning.User.Senha := jsonObj.GetValue('senha').Value;
      FMeaning.User.Telefone := jsonObj.GetValue('telefone').Value;
      FMeaning.User.Points := jsonObj.GetValue('points').Value.ToInteger;
      FMeaning.User.NativeLanguage := TNativeLanguage.Parse_Value
        (jsonObj.GetValue('native_language').Value.ToInteger);
      FMeaning.User.Country := TCountry.Parse_Value(jsonObj.GetValue('country')
        .Value.ToInteger);
      FMeaning.User.Foto := jsonObj.GetValue('foto').Value;
      AbrirPrincipal;
    end;
  finally
    jsonObj.DisposeOf;

  end;

end;

procedure TFrmLogin.ProcessaEmailRecoverPassword;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro, AEmail, APassword, ACode: string;
begin
  if dm.RequestSendEmailRecoverPassword.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorRecoverPasswordByEmail + ': ' +
      dm.RequestSendEmailRecoverPassword.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestSendEmailRecoverPassword.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
    ACode := jsonObj.GetValue('codeSMS').Value;
  finally
    ExibirCampos;
    jsonObj.DisposeOf;
    Rect_RecoverPassword.Enabled := True;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
    try
      SendCodeToEmailSMS(TSendType.scEmail, TActionApp.ocsResetPassword, ACode);

    except
      on E: Exception do
      begin
        ExibirCampos;
        ShowMessage(FText.getErrorRecoverPasswordByEmail + ': ' + E.Message);
        raise;
      end;
    end;
  end;
end;

procedure TFrmLogin.ProcessaSMSCreateAccount;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro, AEmail, ACode: string;
begin
  raise Exception.Create
    ('Ops.. something went wrong. Option to send SMS is not avaliable');
  if dm.RequestSendSMSCreateAccount.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorRecoverPasswordBySMS + ':' +
      dm.RequestSendSMSCreateAccount.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestSendSMSCreateAccount.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
    ACode := jsonObj.GetValue('codeSMS').Value;
  finally
    ExibirCampos;
    jsonObj.DisposeOf;
    Rect_RecoverPassword.Enabled := True;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
{$IFDEF MSWINDOWS}
    ActResetPassword.Execute;
{$ELSE}
    try
      SendCodeToEmailSMS(TSendType.scPhone, TActionApp.ocsActiveAccount, ACode);
    except
      on E: Exception do
      begin
        ExibirCampos;
        ShowMessage(FText.getErrorRecoverPasswordBySMS + ': ' + E.Message);
        raise;
      end;
    end;
{$ENDIF}
  end;

end;

procedure TFrmLogin.ProcessaSMSRecoverPassword;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro, AEmail, ACode: string;
begin
  raise Exception.Create
    ('Ops.. something went wrong. Option to send SMS is not avaliable');
  if dm.RequestSendSMSRecoverPassword.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorRecoverPasswordBySMS + ':' +
      dm.RequestSendSMSRecoverPassword.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestSendSMSRecoverPassword.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
    ACode := jsonObj.GetValue('codeSMS').Value;
  finally
    ExibirCampos;
    jsonObj.DisposeOf;
    Rect_RecoverPassword.Enabled := True;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
{$IFDEF MSWINDOWS}
    ActResetPassword.Execute;
{$ELSE}
    try
      SendCodeToEmailSMS(TSendType.scPhone, TActionApp.ocsResetPassword, ACode);
    except
      on E: Exception do
      begin
        ExibirCampos;
        ShowMessage(FText.getErrorRecoverPasswordBySMS + ': ' + E.Message);
        raise;
      end;
    end;
{$ENDIF}
  end;

end;

procedure TFrmLogin.Rect_UpdateClick(Sender: TObject);
begin
  OpenURL(TFunctions.AppURL, False);

end;

procedure TFrmLogin.ProcessaEmailCreateAccount;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro, AEmail, ACode: string;
begin
  if dm.RequestConta.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorCreateAccount + ': ' +
      dm.RequestConta.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestConta.Response.JSONValue.ToString;
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
    ACode := jsonObj.GetValue('codeSMS').Value;
  finally
    ExibirCampos;
    jsonObj.DisposeOf;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
    try
      SendCodeToEmailSMS(TSendType.scEmail, TActionApp.ocsActiveAccount, ACode);
    except
      on E: Exception do
      begin
        ExibirCampos;
        ShowMessage(FText.getErrorCreateAccount + ': ' + E.Message);
        raise;
      end;
    end;

  end;
end;

procedure TFrmLogin.FloatAnimation1Finish(Sender: TObject);
begin
  ExibirCampos(False);

  try
    try
      if FloatAnimation1.TagString = 'LOGIN' then
      begin
        // Consumir WS Login...
        dm.RequestLogin.Params.Clear;
        dm.RequestLogin.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestLogin.AddParameter('email', Edt_Email.Text); //
        dm.RequestLogin.AddParameter('senha', MD5(Edt_Password.Text)); // 123
        // faz com que rode em thread paralela
        dm.RequestLogin.ExecuteAsync(ProcessaLogin, True, True,
          ErroRequestLogin);
      end
      else if FloatAnimation1.TagString = 'SEND-EMAIL-RECOVER-PASSWORD' then
      begin
        // Consumir WS Login...
        dm.RequestSendEmailRecoverPassword.Params.Clear;
        dm.RequestSendEmailRecoverPassword.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestSendEmailRecoverPassword.AddParameter('email',
          FSendCode.Email);
        // faz com que rode em thread paralela
        dm.RequestSendEmailRecoverPassword.ExecuteAsync
          (ProcessaEmailRecoverPassword, True, True, ErroRequestLogin);
      end
      else if FloatAnimation1.TagString = 'SEND-EMAIL-CREATE-ACCOUNT' then
      begin
        // Consumir WS Login...
        dm.RequestSendEmailCreateAccount.Params.Clear;
        dm.RequestSendEmailCreateAccount.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestSendEmailCreateAccount.AddParameter('email', FSendCode.Email);
        // faz com que rode em thread paralela
        dm.RequestSendEmailCreateAccount.ExecuteAsync
          (ProcessaEmailCreateAccount, True, True, ErroRequestLogin);
      end
      else if FloatAnimation1.TagString = 'SEND-SMS-RECOVER-PASSWORD' then
      begin
        dm.RequestSendSMSRecoverPassword.Params.Clear;
        dm.RequestSendSMSRecoverPassword.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestSendSMSRecoverPassword.AddParameter('telefone',
          getPhoneNumber(ocsResetPassword));
        // faz com que rode em thread paralela
        dm.RequestSendSMSRecoverPassword.ExecuteAsync
          (ProcessaSMSRecoverPassword, True, True, ErroRequestLogin);
      end
      else if FloatAnimation1.TagString = 'SEND-SMS-CREATE-ACCOUNT' then
      begin
        dm.RequestSendSMSCreateAccount.Params.Clear;
        dm.RequestSendSMSCreateAccount.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestSendSMSCreateAccount.AddParameter('telefone',
          getPhoneNumber(ocsResetPassword));
        // faz com que rode em thread paralela
        dm.RequestSendSMSCreateAccount.ExecuteAsync(ProcessaSMSCreateAccount,
          True, True, ErroRequestLogin);
      end

      else if FloatAnimation1.TagString = 'VERIFY-CODE' then
      begin
        // Consumir WS Login...
        dm.RequestVerifyCode.Params.Clear;
        dm.RequestVerifyCode.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestVerifyCode.AddParameter('num1', edt_Num1.Text);
        dm.RequestVerifyCode.AddParameter('num2', edt_Num2.Text);
        dm.RequestVerifyCode.AddParameter('num3', edt_Num3.Text);
        dm.RequestVerifyCode.AddParameter('num4', edt_Num4.Text);
        dm.RequestVerifyCode.AddParameter('email', FSendCode.Email);
        dm.RequestVerifyCode.AddParameter('action',
          FSendCode.Action.AsValue.ToString);

        // faz com que rode em thread paralela
        dm.RequestVerifyCode.ExecuteAsync(VerifyCode, True, True,
          ErroRequestLogin);
      end
      else if FloatAnimation1.TagString = 'SAVE-NEW-PASSWORD' then
      begin
        // Consumir WS Login...
        dm.RequestSaveNewPassword.Params.Clear;
        dm.RequestSaveNewPassword.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestSaveNewPassword.AddParameter('email',
          edt_email_recover_password.Text);
        dm.RequestSaveNewPassword.AddParameter('originalpassword',
          FSendCode.Password);
        dm.RequestSaveNewPassword.AddParameter('confirmpassword',
          MD5(Edt_ConfirmPassword.Text));
        dm.RequestSaveNewPassword.AddParameter('newpassword',
          MD5(Edt_NewPassword.Text));
        dm.RequestSaveNewPassword.AddParameter('action',
          FSendCode.Action.AsValue.ToString);
        // faz com que rode em thread paralela
        dm.RequestSaveNewPassword.ExecuteAsync(SaveNewPassword, True, True,
          ErroRequestLogin);
      end
      else if FloatAnimation1.TagString = 'NEW-ACCOUNT' then
      begin
        dm.RequestConta.Params.Clear;
        dm.RequestConta.AddParameter('native_language',
          getNativeLanguage.AsValue.ToString);
        dm.RequestConta.AddParameter('email', edt_cad_email.Text);
        dm.RequestConta.AddParameter('password', MD5(edt_cad_password.Text));
        dm.RequestConta.AddParameter('phone', getPhoneNumber(ocsActiveAccount));
        dm.RequestConta.AddParameter('country', getCountry(cbbCountryCode)
          .AsValue.ToString);
        dm.RequestConta.ExecuteAsync(ProcessaEmailCreateAccount, True, True,
          ErroRequestLogin);
      end
      else
        raise Exception.Create('An action tag has not been defined: ' +
          FloatAnimation1.TagString);
    except
      on ex: Exception do
      begin
        ShowMessage('Sorry, something went wrong: ' + ex.Message);
        raise;
      end;

    end;

  finally
    // ExibirCampos;
    // Application.ProcessMessages;
  end;
end;

procedure TFrmLogin.VerifyCode;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin

  if dm.RequestVerifyCode.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorRecoverPasswordByEmail + ': ' +
      dm.RequestVerifyCode.Response.StatusText);
    exit;
  end;

  jsonObj := nil;

  try
    JSON := dm.RequestVerifyCode.Response.JSONValue.ToString;
    // pega o json do request
    jsonObj := TJsonObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSON), 0)
      as TJsonObject;

    sucesso := jsonObj.GetValue('sucesso').Value;
    erro := jsonObj.GetValue('erro').Value;
    FSendCode.Password := jsonObj.GetValue('password').Value;
  finally
    ExibirCampos;
    jsonObj.DisposeOf;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
    case FSendCode.Action of
      ocsActiveAccount:
        begin
          ShowMessage(FText.getActivedAccount);
          ActLoginExecute(nil);
        end;

      ocsResetPassword:
        begin
          ActResetPassword.Execute;
        end;
    end;

  end;
end;

procedure TFrmLogin.SaveNewPassword;
var
  jsonObj: TJsonObject;
  JSON, sucesso, erro: string;
begin
  // FloatAnimation2.Stop;
  // FloatAnimation3.Stop;

  if dm.RequestSaveNewPassword.Response.StatusCode <> 200 then
  begin
    ExibirCampos;
    ShowMessage(FText.getErrorSavingNewPassword + ': ' +
      dm.RequestSaveNewPassword.Response.StatusText);
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
  finally
    ExibirCampos;
    jsonObj.DisposeOf;
  end;

  if sucesso <> 'S' then
  begin
    ShowMessage(erro);
    exit;
  end
  else
  begin
    ShowMessage(FText.getPasswordChanged);
    ActLoginExecute(nil);
  end;

end;

procedure TFrmLogin.SetResetSavedData(const Value: Boolean);
begin
  FResetSavedData := Value;
end;

procedure TFrmLogin.SMSTimerTimer(Sender: TObject);
begin
  inherited;
  EnableTimer(False);

end;

procedure TFrmLogin.FormSaveState(Sender: TObject);
begin
  SaveFormState;
end;

procedure TFrmLogin.SendCodeToEmailSMS(AType: TSendType; AAction: TActionApp;
ACode: string);
begin
  FSendCode.Action := AAction;
  if AType = TSendType.scPhone then
  begin
    permissao.SMS(nil, ErroPermissao);
    FSendCode.Phone := getPhoneNumber(AAction);
    FSendCode.Code := ACode;

    raise Exception.Create('Missing implementation here');
    // TFunctions.SendCode(Format(FText.getTextBodyCreateAccount, [FcodeSMS.Code]));

    lbl_Title_Sent_Code.Text := Format(FText.getTextAlert_Message_SMS,
      [FSendCode.Phone]);

  end
  else
    lbl_Title_Sent_Code.Text := FText.getTextAlert_Message_Email;

  case FSendCode.Action of
    ocsActiveAccount:
      begin
        lbl_Title_Check_SMS.Text := FText.getTextTitleActiveAccount;
      end;

    ocsResetPassword:
      begin
        lbl_Title_Check_SMS.Text := FText.getTextTitleRecoverPassword;
      end;
  end;

  CleanVerificationCode;
  EnableTimer(True);
  ActCheckSMS.Execute;

end;

procedure TFrmLogin.SetColors;
begin
  inherited;
  Rect_Login.Fill.Color := CurrentTheme.ColorButton;
  Rect_CreateNewAccount.Fill.Color := CurrentTheme.ColorButton;
  Rect_RecoverPassword.Fill.Color := CurrentTheme.ColorButton;
  Rect_SaveNewPassword.Fill.Color := CurrentTheme.ColorButton;
  Rect_Update.Fill.Color := CurrentTheme.ColorButton;
  Rect_UpdateBackground.Fill.Color := CurrentTheme.ColorBackGround;

  lbl_Login.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_CreateNewAccount.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_RecoverPassword.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_VerifyCode.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  lbl_SaveNewPassword.TextSettings.FontColor := CurrentTheme.ColorFontLabel;
  Lbl_Update.TextSettings.FontColor := CurrentTheme.ColorFontLabel;

  lbl_CreateAccount.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_ForgotPassword.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Visitant.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Title_AccessAccount.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  lbl_Login1.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Title_CreateNewAccount.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  lbl_CreateAccount2.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Login2.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Title_ForgotPassword.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  lbl_ResendCode.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Login4.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Title_RecoverPassword.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  lbl_Title_Sent_Code.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Title_Check_SMS.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_CreateAccount3.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Login3.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_Title_NewPassword.TextSettings.FontColor :=
    CurrentTheme.ColorFontLabelTop;
  lbl_newversion.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;
  lbl_updateapp.TextSettings.FontColor := CurrentTheme.ColorFontLabelTop;

end;

procedure TFrmLogin.SetNativeLanguage(Value: TNativeLanguage);
begin
  FMeaning.SetNativeLanguage(Value);
end;

procedure TFrmLogin.EnableTimer(Value: Boolean);
begin
  SMSTimer.Enabled := Value;
  SkSMSTimer.Visible := SMSTimer.Enabled;
  SkSMSTimer.Enabled := SkSMSTimer.Visible;
  lbl_ResendCode.Enabled := not Value;
  if Value then
    lbl_ResendCode.Opacity := 0.3
  else
    lbl_ResendCode.Opacity := 1;
end;

procedure TFrmLogin.CleanVerificationCode;
begin
  edt_Num1.Text := '';
  edt_Num2.Text := '';
  edt_Num3.Text := '';
  edt_Num4.Text := '';
end;

procedure TFrmLogin.Change_Labels;
begin
  lbl_Title_AccessAccount.Text := FText.getTextAccessAccount;
  lbl_CreateAccount.Text := FText.getTextCreateAccount;
  lbl_ForgotPassword.Text := FText.getTextForgotPassword;
  lbl_Visitant.Text := FText.getTextVisitant;
  lbl_Login.Text := FText.getTextLogin;
  Edt_Email.TextPrompt := FText.getTextEmail;
  Edt_Password.TextPrompt := FText.getTextPassword;
  edt_cad_email.TextPrompt := FText.getTextEmail;
  edt_cad_password.TextPrompt := FText.getTextPassword;
  edt_cad_phone.TextPrompt := FText.getTextPhone;
  edt_phone_recoverpass.TextPrompt := FText.getTextPhone;
  lbl_Login1.Text := FText.getAlreadyHaveAccount;
  lbl_CreateNewAccount.Text := FText.getTextSave;
  lbl_RecoverPassword.Text := FText.getRecoverPassword;
  lbl_VerifyCode.Text := FText.getTextVerifyCode;
  lbl_CreateAccount2.Text := FText.getTextCreateAccount;
  lbl_Login2.Text := FText.getAlreadyHaveAccount;
  lbl_Title_CreateNewAccount.Text := FText.getTextCreateAccount;
  lbl_Title_ForgotPassword.Text := FText.getTextForgotPassword;
  lbl_Title_Sent_Code.Text := FText.getTextAlert_Message_SMS;
  lbl_ResendCode.Text := FText.getTextResendCode;
  lbl_Login4.Text := FText.getTextLogin;
  lbl_Title_RecoverPassword.Text := FText.getTextRecoverPassword;

  lbl_Title_NewPassword.Text := FText.getTextCreateNewPassword;
  Edt_NewPassword.TextPrompt := FText.getTextNewPassword;
  Edt_ConfirmPassword.TextPrompt := FText.getTextConfirmPassword;
  lbl_CreateAccount3.Text := FText.getTextCreateAccount;
  lbl_Login3.Text := FText.getAlreadyHaveAccount;

  lbl_SaveNewPassword.Text := FText.getTextSave;
  lbl_newversion.Text := FText.getNewVersion;
  lbl_updateapp.Text := FText.getUpdateApp;
end;

procedure TFrmLogin.CleanEdits;
begin
  Edt_Email.Text := '';
  Edt_Password.Text := '';
  edt_cad_email.Text := '';
  edt_cad_password.Text := '';
  edt_cad_phone.Text := '';
  edt_email_recover_password.Text := '';
  edt_phone_recoverpass.Text := '';
  Edt_NewPassword.Text := '';
  Edt_ConfirmPassword.Text := '';
  CleanVerificationCode;
end;

procedure TFrmLogin.ErroPermissao(Sender: TObject);
begin
  ShowMessage('You do not have permission for this feature');
end;

procedure TFrmLogin.Img_ShowPassword2Click(Sender: TObject);
begin
  FloatAnimationPassword2.Inverse := not Edt_Password.Password;
  FloatAnimationPassword2.Start;
end;

procedure TFrmLogin.Img_ShowPasswordClick(Sender: TObject);
begin
  FloatAnimationPassword.Inverse := not edt_cad_password.Password;
  FloatAnimationPassword.Start;
end;

procedure TFrmLogin.Img_ShowNewPasswordClick(Sender: TObject);
begin
  FloatAnimationNewPassword.Inverse := not Edt_NewPassword.Password;
  FloatAnimationNewPassword.Start;
end;

procedure TFrmLogin.Img_ShowConfirmPasswordClick(Sender: TObject);
begin
  FloatAnimationConfirmPassword.Inverse := not Edt_ConfirmPassword.Password;
  FloatAnimationConfirmPassword.Start;
end;


// procedure TFrmLogin.Img_ShowPasswordTesteClick(Sender: TObject);
// begin
//
// FloatAnimationPasswordTeste.Inverse := not Edt_Password.Password;
// FloatAnimationPasswordTeste.Start;
// end;
//
// procedure TFrmLogin.FloatAnimationPasswordTesteFinish(Sender: TObject);
// begin
// Edt_Password.Password := FloatAnimationPasswordTeste.Inverse = True;
// Edt_CreatePassword.Password := FloatAnimationPasswordTeste.Inverse = True;
// end;

procedure TFrmLogin.FloatAnimationPassword2Finish(Sender: TObject);
begin
  Edt_Password.Password := FloatAnimationPassword2.Inverse = True;
end;

procedure TFrmLogin.FloatAnimationPasswordFinish(Sender: TObject);
begin
  edt_cad_password.Password := FloatAnimationPassword.Inverse = True;
end;

procedure TFrmLogin.FloatAnimationNewPasswordFinish(Sender: TObject);
begin
  Edt_NewPassword.Password := FloatAnimationNewPassword.Inverse = True;
end;

procedure TFrmLogin.FloatAnimationConfirmPasswordFinish(Sender: TObject);
begin
  Edt_ConfirmPassword.Password := FloatAnimationConfirmPassword.Inverse = True;
end;

procedure TFrmLogin.lbl_VisitantClick(Sender: TObject);
begin
  FMeaning.User.Id_Usuario := 0;
  AbrirPrincipal;

end;

procedure TFrmLogin.lbl_ResendCodeClick(Sender: TObject);
begin
  try
    EnableTimer(True);

    case FSendCode.SendType of
      TSendType.scEmail:
        begin
          case FSendCode.Action of
            ocsActiveAccount:
              begin
                FloatAnimation1.TagString := 'SEND-EMAIL-CREATE-ACCOUNT';
                FloatAnimation1.Start;
              end;

            ocsResetPassword:
              begin
                FloatAnimation1.TagString := 'SEND-EMAIL-RECOVER-PASSWORD';
                FloatAnimation1.Start;
              end;
          end;
        end;

      TSendType.scPhone:
        begin
          case FSendCode.Action of
            ocsActiveAccount:
              begin
                FloatAnimation1.TagString := 'SEND-SMS-CREATE-ACCOUNT';
                FloatAnimation1.Start;
              end;

            ocsResetPassword:
              begin
                FloatAnimation1.TagString := 'SEND-SMS-RECOVER-PASSWORD';
                FloatAnimation1.Start;
              end;
          end;
        end;

    end;

  except
    on E: Exception do
    begin
      ShowMessage(FText.getErrorRecoverPasswordBySMS + ': ' + E.Message);
      raise;
    end;
  end;
end;

procedure TFrmLogin.ActCheckSMSExecute(Sender: TObject);
begin
  ActCheckSMS.Execute;
end;

procedure TFrmLogin.ActContaExecute(Sender: TObject);
begin
  ActConta.Execute;
end;

procedure TFrmLogin.ActLoginExecute(Sender: TObject);
begin
  CleanEdits;
  ActLogin.Execute;
end;

procedure TFrmLogin.ActSendSMSRecoverPasswordExecute(Sender: TObject);
begin
  ActSendSMSRecoverPassword.Execute;
end;

procedure TFrmLogin.Rect_CreateNewAccountClick(Sender: TObject);
begin
  if edt_cad_email.Text.Trim = '' then
  begin
    if edt_cad_email.CanFocus then
      edt_cad_email.SetFocus;
    ShowMessage(FText.getTextEmptyEmail);
  end
  else if edt_cad_password.Text.Trim = '' then
  begin
    if edt_cad_password.CanFocus then
      edt_cad_password.SetFocus;
    ShowMessage(FText.getTextEmptyPassword);
  end
//  else if edt_cad_phone.Text.Trim = '' then
//  begin
//    if edt_cad_phone.CanFocus then
//      edt_cad_phone.SetFocus;
//    ShowMessage(FText.getTextEmptyPhone);
//  end
  else
  begin
    FSendCode.Email := edt_cad_email.Text;
    FloatAnimation1.TagString := 'NEW-ACCOUNT';
    FloatAnimation1.Start;
  end;
end;

procedure TFrmLogin.Rect_EmailClick(Sender: TObject);
begin
  ActLoginExecute(Sender);
end;

procedure TFrmLogin.Rect_LoginClick(Sender: TObject);
begin
  if Edt_Email.Text.Trim = '' then
  begin
    if Edt_Email.CanFocus then
      Edt_Email.SetFocus;
    ShowMessage(FText.getTextEmptyEmail);
  end
  else if Edt_Password.Text.Trim = '' then
  begin
    if Edt_Password.CanFocus then
      Edt_Password.SetFocus;
    ShowMessage(FText.getTextEmptyPassword);
  end
  else
  begin
    FloatAnimation1.TagString := 'LOGIN';
    FloatAnimation1.Start;
  end;
end;

procedure TFrmLogin.Rect_RecoverPasswordClick(Sender: TObject);
begin
  Rect_RecoverPassword.Enabled := False;
  if (edt_phone_recoverpass.Text.Trim.IsEmpty) and
    (edt_email_recover_password.Text.Trim.IsEmpty) then
  begin
    if edt_email_recover_password.CanFocus then
      edt_email_recover_password.SetFocus;
    ShowMessage(FText.getTextEmptyEmail);
  end
  else if (not edt_email_recover_password.Text.Trim.IsEmpty) then
  begin
    FSendCode.Email := edt_email_recover_password.Text;
    FloatAnimation1.TagString := 'SEND-EMAIL-RECOVER-PASSWORD';
    FloatAnimation1.Start;
  end
  else if (not edt_phone_recoverpass.Text.Trim.IsEmpty) then
  begin
    FloatAnimation1.TagString := 'SEND-SMS-RECOVER-PASSWORD';
    FloatAnimation1.Start;
  end;
end;

procedure TFrmLogin.Rect_VerifyCodeClick(Sender: TObject);
begin
  FloatAnimation1.TagString := 'VERIFY-CODE';
  FloatAnimation1.Start;
end;

procedure TFrmLogin.Rect_SaveNewPasswordClick(Sender: TObject);
begin
  if Edt_NewPassword.Text.Trim = '' then
  begin
    if Edt_NewPassword.CanFocus then
      Edt_NewPassword.SetFocus;
    ShowMessage(FText.getTextEmptyPassword);
  end
  else if Edt_ConfirmPassword.Text.Trim = '' then
  begin
    if Edt_ConfirmPassword.CanFocus then
      Edt_ConfirmPassword.SetFocus;
    ShowMessage(FText.getTextEmptyPassword);
  end
  else
  begin
    FloatAnimation1.TagString := 'SAVE-NEW-PASSWORD';
    FloatAnimation1.Start;
  end;
end;

function TFrmLogin.FText: IText;
begin
  Result := TText.New(getNativeLanguage);
end;

procedure TFrmLogin.ErroRequestLogin(Sender: TObject);
var
  msg: string;
begin
  if Assigned(Sender) and (Sender is Exception) then
  begin
    ExibirCampos;
    TrataException(Sender, FText.getText404,
      procedure
      begin
        FormShow(Sender);
      end);
    Lbl_404TryAgain.Text := FText.getTextTryAgain;
    // msg := Exception(Sender).Message;
    // if msg.contains('12029') then
    // ShowMessage(ErrorConectingServer)
    // else
    // ShowMessage(Exception(Sender).Message);
  end;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CleanEdits;

  if SkBackGround.Enabled then
    SkBackGround.Enabled := False;

  if SkSMSTimer.Enabled then
    SkSMSTimer.Enabled := False;

  if SkLoading.Enabled then
    SkLoading.Enabled := False;

  if Assigned(permissao) then
    FreeAndNil(permissao);

  if Assigned(FSendCode) then
    FreeAndNil(FSendCode);

  Action := TCloseAction.caFree;
  FrmLogin := nil;

end;

end.
