unit uClassTexts;

interface

uses uEnum, uEnum.Helper;

type

  IText = interface
    ['{53984B3F-8C99-4974-A144-C4A6EF16469C}']
    function getTextLoading: string;
    function getText404: string;
    function getTextTryAgain: string;

    { Languages }
    function getTextEnglish: string;
    function getTextPortuguese: string;
    function getTextFrench: string;
    function getTextSpanish: string;
    function getTextItalian: string;
    function getTextAll: string;

    { UnitLogin }
    function getTextAccessAccount: string;
    function getTextCreateAccount: string;
    function getTextForgotPassword: string;
    function getTextVisitant: string;
    function getTextLogin: string;
    function getTextPassword: string;
    function getTextName: string;
    function getTextEmail: string;
    function getTextPhone: string;
    function getAlreadyHaveAccount: string;
    function getTextSave: string;
    function getRecoverPassword: string;
    function getTextVerifyCode: string;
    function getTextTitleRecoverPassword: string;
    function getTextTitleActiveAccount: string;
    function getTextAlert_Message_SMS: string;
    function getTextAlert_Message_Email: string;
    function getTextCreateNewPassword: string;
    function getTextCurrentPassword: string;
    function getTextNewPassword: string;
    function getTextConfirmPassword: string;
    function getTextEmptyEmail: string;
    function getTextEmptyPassword: string;
    function getTextEmptyPhone: string;
    function getNewVersion: string;
    function getUpdateApp: string;
    function getTextResendCode: string;
    function getPasswordChanged: string;
    function getActivedAccount: string;
    function getErrorValidLogin: string;
    function getErrorRecoverPasswordByEmail: string;
    function getErrorRecoverPasswordBySMS: string;
    function getErrorCreateAccount: string;
    function getErrorLoginFacebook: string;
    function getErrorSavingNewPassword: string;
    function getErrorUpdatingUser: string;
    function getInvalidEmailPassword: string;
    function getInvalidPassword: string;
    function getTextEmailNotFound: string;
    function getTextEmptyNewPassword: string;
    function getTextEmptyCurrentPassword: string;
    function getTextPasswordsShouldBeEqual: string;
    function getTextPasswordsShouldBeDifferentCurrent: string;
    function getTextRecoverPassword: string;

    { UnitCategory }
    function getTextSelectNativeLanguage: string;
    function getTextCategory: string;
    function getTextSearch: string;
    function getTextTypeHere: string;
    function getTextBack: string;
    function getTextNext: string;
    function getTextBeginner: string;
    function getTextIntermediary: string;
    function getTextAdvanced: string;
    function getTextPhrases: string;
    function getTextWords: string;
    function getTextRanking: string;
    function getTextResourceNotAvaliable: string;

    { UnitMeaning }
    function getTextMenuChangeLanguage: string;
    function getTextMenuCompleteWords: string;
    function getTextMenuPracticeYourMemory: string;
    function getTextMenuSelectWords: string;
    function getTextMenuLogout: string;
    function getTextMenuAddWords: string;
    function getTextVersion: string;
    function getTextDevelopedBy: string;
    function getTextHello: string;

    { UnitAddAudio }
    function getTextTermsOfUse: string;
    function getTextClickHereAndRecord: string;
    function getTextStop: string;
    function getTextPlay: string;
    function getTextRecordWord: string;
    function getTextClickAgainToStopRecording: string;
    function getTextNoWordsToRecord: string;
    function getTextAccept: string;
    function getTextDecline: string;

    { UnitCadWords }
    function getTextRegisterWord: string;
    function getTextCancel: string;
    function getTextTypeWord(NativeLanguage: TNativeLanguage): string;

    { UnitMemorize }
    function getTextMemoryGame: string;
    function getTextSwipeWordsUp: string;

    { UnitCompleteWords }
    function getTextCompleteWords: string;

    { UnitSelectWords }
    function getTextSelectWords: string;
    function getTextHowCanISay: string;
    function getTextTheWordIs: string;

    { UnitUser }
    function getTextSettings: string;
    function getTextChangePassword: string;
    function getTextEditUser: string;
    function getTextEditPassword: string;
    function getTextSaveUser: string;
    function getTextSavePassword: string;
    function getTextTermsConditions: string;
    function getTextPrivacyPolicy: string;
    function getTextAboutApp: string;
    function getTextDeleteAccount: string;
    function getTextTheme: string;

    { UnitPresentation }
    function getTextLast: string;
    function getTextClickHereKnowTranslation: string;

    { Errors }
    function getTextErrorNoCategory: string;

    { Servidor }
    function getTextInvalidPhone: string;
    function getTextInvalidEmail: string;
    function getTextEmailAlreadyExists: string;
    function getTextInvalidUserCode: string;
    function getTextInvalidWordCode: string;
    function getTextInvalidCodeLenghtIncorrect: string;
    function getTextInvalidCodeLenghtIncorrectCreated: string;
    function getTextCodeIncorrect: string;
    function getTextInvalidForm: string;
    function getTextSubjectRecoverPassword: string;
    function getTextSubjectCreateAccount: string;
    function getTextSubjectActivedAccount: string;
    function getTextSubjectRecoveredPassword: string;
    function getTextBodyRecoverPassword: string;
    function getTextBodyCreateAccount: string;
    function getTextBodyActivedAccount: string;
    function getTextBodyRecoveredPassword: string;
    function getTextInvalidResetPasswordAction: string;

    { Games }
    function getTextPlayAgain: string;
    function getTextLetsContinue: string;
    function getTextNo: string;
    function getTextYes: string;

    function getTextYouGotPointsTryAgain: string;
    function getTextCongratulations: string;
    function getTextContinueAnotherLanguage: string;
    function getTextYouCompleteThisLanguage: string;
    function getTextYouCompleteAllWords: string;
    function getTextYouGotPoints: string;
    function getTextToReviewWords: string;
    function getTextReview: string;
    function getTextReviewLastWordsThisRound: string;
  end;

  TText = class(TInterfacedObject, IText)
  private
    FNativeLanguage: TNativeLanguage;

    function getTextLoading: string;
    function getText404: string;
    function getTextTryAgain: string;

    { Languages }
    function getTextEnglish: string;
    function getTextPortuguese: string;
    function getTextFrench: string;
    function getTextSpanish: string;
    function getTextItalian: string;
    function getTextAll: string;

    { UnitLogin }
    function getTextAccessAccount: string;
    function getTextCreateAccount: string;
    function getTextForgotPassword: string;
    function getTextVisitant: string;
    function getTextLogin: string;
    function getTextPassword: string;
    function getTextName: string;
    function getTextEmail: string;
    function getTextPhone: string;
    function getAlreadyHaveAccount: string;
    function getTextSave: string;
    function getRecoverPassword: string;
    function getTextVerifyCode: string;
    function getTextTitleRecoverPassword: string;
    function getTextTitleActiveAccount: string;
    function getTextAlert_Message_SMS: string;
    function getTextAlert_Message_Email: string;
    function getTextCreateNewPassword: string;
    function getTextCurrentPassword: string;
    function getTextNewPassword: string;
    function getTextConfirmPassword: string;
    function getTextEmptyEmail: string;
    function getTextEmptyPassword: string;
    function getTextEmptyPhone: string;
    function getNewVersion: string;
    function getUpdateApp: string;
    function getTextResendCode: string;
    function getPasswordChanged: string;
    function getActivedAccount: string;
    function getErrorValidLogin: string;
    function getErrorRecoverPasswordByEmail: string;
    function getErrorRecoverPasswordBySMS: string;
    function getErrorCreateAccount: string;
    function getErrorLoginFacebook: string;
    function getErrorSavingNewPassword: string;
    function getErrorUpdatingUser: string;
    function getInvalidEmailPassword: string;
    function getInvalidPassword: string;
    function getTextEmailNotFound: string;
    function getTextEmptyNewPassword: string;
    function getTextEmptyCurrentPassword: string;
    function getTextPasswordsShouldBeEqual: string;
    function getTextPasswordsShouldBeDifferentCurrent: string;
    function getTextRecoverPassword: string;

    { UnitCategory }
    function getTextSelectNativeLanguage: string;
    function getTextCategory: string;
    function getTextSearch: string;
    function getTextTypeHere: string;
    function getTextBack: string;
    function getTextNext: string;
    function getTextBeginner: string;
    function getTextIntermediary: string;
    function getTextAdvanced: string;
    function getTextPhrases: string;
    function getTextWords: string;
    function getTextRanking: string;
    function getTextResourceNotAvaliable: string;

    { UnitMeaning }
    function getTextMenuChangeLanguage: string;
    function getTextMenuCompleteWords: string;
    function getTextMenuPracticeYourMemory: string;
    function getTextMenuSelectWords: string;
    function getTextMenuLogout: string;
    function getTextMenuAddWords: string;
    function getTextVersion: string;
    function getTextDevelopedBy: string;
    function getTextHello: string;

    { UnitAddAudio }
    function getTextTermsOfUse: string;
    function getTextClickHereAndRecord: string;
    function getTextStop: string;
    function getTextPlay: string;
    function getTextRecordWord: string;
    function getTextClickAgainToStopRecording: string;
    function getTextNoWordsToRecord: string;
    function getTextAccept: string;
    function getTextDecline: string;

    { UnitCadWords }
    function getTextRegisterWord: string;
    function getTextCancel: string;
    function getTextTypeWord(NativeLanguage: TNativeLanguage): string;

    { UnitMemorize }
    function getTextMemoryGame: string;
    function getTextSwipeWordsUp: string;

    { UnitCompleteWords }
    function getTextCompleteWords: string;

    { UnitSelectWords }
    function getTextSelectWords: string;
    function getTextHowCanISay: string;
    function getTextTheWordIs: string;

    { UnitUser }
    function getTextSettings: string;
    function getTextChangePassword: string;
    function getTextEditUser: string;
    function getTextEditPassword: string;
    function getTextSaveUser: string;
    function getTextSavePassword: string;
    function getTextTermsConditions: string;
    function getTextPrivacyPolicy: string;
    function getTextAboutApp: string;
    function getTextDeleteAccount: string;
    function getTextTheme: string;

    { UnitPresentation }
    function getTextLast: string;
    function getTextClickHereKnowTranslation: string;

    { Errors }
    function getTextErrorNoCategory: string;

    { Servidor }
    function getTextInvalidPhone: string;
    function getTextInvalidEmail: string;
    function getTextEmailAlreadyExists: string;
    function getTextInvalidUserCode: string;
    function getTextInvalidWordCode: string;
    function getTextInvalidCodeLenghtIncorrect: string;
    function getTextInvalidCodeLenghtIncorrectCreated: string;
    function getTextCodeIncorrect: string;
    function getTextInvalidForm: string;
    function getTextSubjectRecoverPassword: string;
    function getTextSubjectCreateAccount: string;
    function getTextSubjectActivedAccount: string;
    function getTextSubjectRecoveredPassword: string;
    function getTextBodyRecoverPassword: string;
    function getTextBodyCreateAccount: string;
    function getTextBodyActivedAccount: string;
    function getTextBodyRecoveredPassword: string;
    function getTextInvalidResetPasswordAction: string;

    { Games }
    function getTextPlayAgain: string;
    function getTextLetsContinue: string;
    function getTextNo: string;
    function getTextYes: string;

    function getTextYouGotPointsTryAgain: string;
    function getTextCongratulations: string;
    function getTextContinueAnotherLanguage: string;
    function getTextYouCompleteThisLanguage: string;
    function getTextYouCompleteAllWords: string;
    function getTextYouGotPoints: string;
    function getTextToReviewWords: string;
    function getTextReview: string;
    function getTextReviewLastWordsThisRound: string;
  public

    constructor Create(NativeLanguage: TNativeLanguage);
    destructor Destroy; override;
    class function New(NativeLanguage: TNativeLanguage): IText;
  end;

implementation

uses
  System.SysUtils, System.Classes;

{ TText }

constructor TText.Create(NativeLanguage: TNativeLanguage);
begin
  FNativeLanguage := NativeLanguage;
end;

destructor TText.Destroy;
begin

  inherited;
end;

{ Languages }
function TText.getTextEnglish: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'English';
    nlPortuguese:
      Result := 'Ingl�s';
    nlFrench:
      Result := 'Anglais';
    nlSpanish:
      Result := 'Ingl�s';
    nlItalian:
      Result := 'Inglese';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPortuguese: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Portuguese';
    nlPortuguese:
      Result := 'Portugu�s';
    nlFrench:
      Result := 'Portugais';
    nlSpanish:
      Result := 'Portugu�s';
    nlItalian:
      Result := 'Portoghese';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPrivacyPolicy: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Privacy Policy';
    nlPortuguese:
      Result := 'Pol�tica de Privacidade';
    nlFrench:
      Result := 'Politique de confidentialit�';
    nlSpanish:
      Result := 'Pol�tica de privacidad';
    nlItalian:
      Result := 'Politica sulla privacy';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextFrench: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'French';
    nlPortuguese:
      Result := 'Franc�s';
    nlFrench:
      Result := 'Fran�ais';
    nlSpanish:
      Result := 'Franc�s';
    nlItalian:
      Result := 'Francese';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSpanish: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Spanish';
    nlPortuguese:
      Result := 'Espanhol';
    nlFrench:
      Result := 'Espagnol';
    nlSpanish:
      Result := 'Espa�ol';
    nlItalian:
      Result := 'Spagnolo';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextItalian: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Italian';
    nlPortuguese, nlSpanish, nlItalian:
      Result := 'Italiano';
    nlFrench:
      Result := 'Italien';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextAll: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'All Languages';
    nlPortuguese:
      Result := 'Todos os Idiomas';
    nlFrench:
      Result := 'Toutes les langues';
    nlSpanish:
      Result := 'Todos los idiomas';
    nlItalian:
      Result := 'Tutte le lingue';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextLoading: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Loading';
    nlPortuguese:
      Result := 'Carregando';
    nlFrench:
      Result := 'Chargement';
    nlSpanish:
      Result := 'Cargando';
    nlItalian:
      Result := 'Caricamento in corso';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextAccessAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Access your account';
    nlPortuguese:
      Result := 'Acesse sua conta';
    nlFrench:
      Result := 'Acc�der � votre compte';
    nlSpanish:
      Result := 'Acceder a tu cuenta';
    nlItalian:
      Result := 'Accedere all''account';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCreateAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Create an account';
    nlPortuguese:
      Result := 'Criar Conta';
    nlFrench:
      Result := 'Cr�er un compte';
    nlSpanish:
      Result := 'Crear cuenta nueva';
    nlItalian:
      Result := 'Crea nuovo account';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextForgotPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Forgot password?';
    nlPortuguese:
      Result := 'Esqueceu a Senha?';
    nlFrench:
      Result := 'Mot de passe oubli� ?';
    nlSpanish:
      Result := '�Has olvidado la contrase�a?';
    nlItalian:
      Result := 'Password dimenticata?';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextVisitant: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Visitant';
    nlPortuguese:
      Result := 'Visitante';
    nlFrench:
      Result := 'Visiteur';
    nlSpanish:
      Result := 'Visitante';
    nlItalian:
      Result := 'Visitatore';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextLogin: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Log In';
    nlPortuguese:
      Result := 'Acessar Conta';
    nlFrench:
      Result := 'Connexion';
    nlSpanish:
      Result := 'Entrar';
    nlItalian:
      Result := 'Accedi';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPassword: string;
begin
  case FNativeLanguage of
    nlEnglish, nlItalian:
      Result := 'Password';
    nlPortuguese:
      Result := 'Senha';
    nlFrench:
      Result := 'Mot de passe';
    nlSpanish:
      Result := 'Contrase�a';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPhone: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Phone';
    nlPortuguese:
      Result := 'Celular';
    nlFrench:
      Result := 'Num�ro de t�l';
    nlSpanish:
      Result := 'N�mero de m�vil';
    nlItalian:
      Result := 'Numero di cellulare';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEditPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Change Password';
    nlPortuguese:
      Result := 'Mudar a Senha';
    nlFrench:
      Result := 'Changer le mot de passe';
    nlSpanish:
      Result := 'Cambiar la contrase�a';
    nlItalian:
      Result := 'Cambia Password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextEditUser: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Edit User';
    nlPortuguese:
      Result := 'Editar Usu�rio';
    nlFrench:
      Result := 'Modifier l''utilisateur';
    nlSpanish:
      Result := 'Editar Usuario';
    nlItalian:
      Result := 'Modifica utente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmail: string;
begin
  case FNativeLanguage of
    nlEnglish, nlPortuguese, nlItalian:
      Result := 'E-mail';
    nlFrench:
      Result := 'Adresse e-mail';
    nlSpanish:
      Result := 'Correo electr�nico';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getActivedAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Congratulations, your account has been activated. Please login and enjoy!';
    nlPortuguese:
      Result := 'Parab�ns, sua conta foi ativada. Fa�a o login e aproveite!';
    nlFrench:
      Result := 'F�licitations, votre compte a �t� activ�. Veuillez vous connecter et profiter!';
    nlSpanish:
      Result := '�Felicidades, su cuenta ha sido activada. Por favor, inicie sesi�n y disfrute!';
    nlItalian:
      Result := 'Congratulazioni, il tuo account � stato attivato. Effettua l''accesso e goditi!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getAlreadyHaveAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Already have an account?';
    nlPortuguese:
      Result := 'J� tem uma conta?';
    nlFrench:
      Result := 'Vous avez d�j� un compte ?';
    nlSpanish:
      Result := '�Ya tienes una cuenta?';
    nlItalian:
      Result := 'Hai gi� un account?';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getErrorCreateAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error creating account';
    nlPortuguese:
      Result := 'Erro ao criar conta';
    nlFrench:
      Result := 'Erreur lors de la cr�ation du compte';
    nlSpanish:
      Result := 'Error al crear cuenta';
    nlItalian:
      Result := 'Errore durante la creazione dell''account';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmailNotFound: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Email not found';
    nlPortuguese:
      Result := 'Email n�o encontrado';
    nlFrench:
      Result := 'Email non trouv�';
    nlSpanish:
      Result := 'El correo electr�nico no encontrado';
    nlItalian:
      Result := 'Email non trovata';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getErrorLoginFacebook: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error logging in using Facebook';
    nlPortuguese:
      Result := 'Erro ao fazer login pelo Facebook';
    nlFrench:
      Result := 'Erreur de connexion avec Facebook';
    nlSpanish:
      Result := 'Error al iniciar sesi�n con Facebook';
    nlItalian:
      Result := 'Errore durante l''accesso utilizzando Facebook';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getErrorRecoverPasswordByEmail: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error verifying email to recover password';
    nlPortuguese:
      Result := 'Erro ao verificar email para recuperar senha';
    nlFrench:
      Result := 'Erreur lors de la v�rification de l''e-mail pour r�cup�rer le mot de passe';
    nlSpanish:
      Result := 'Error al verificar el correo electr�nico para recuperar la contrase�a';
    nlItalian:
      Result := 'Errore durante la verifica dell''e-mail per recuperare la password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getErrorRecoverPasswordBySMS: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error verifying SMS to recover password';
    nlPortuguese:
      Result := 'Erro ao verificar SMS para recuperar senha';
    nlFrench:
      Result := 'Erreur lors de la v�rification du SMS pour r�cup�rer le mot de passe';
    nlSpanish:
      Result := 'Error al verificar SMS para recuperar contrase�a';
    nlItalian:
      Result := 'Errore durante la verifica degli SMS per recuperare la password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getErrorSavingNewPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error saving new password';
    nlPortuguese:
      Result := 'Erro ao salvar nova senha';
    nlFrench:
      Result := 'Erreur lors de l''enregistrement du nouveau mot de passe';
    nlSpanish:
      Result := 'Error al guardar la nueva contrase�a';
    nlItalian:
      Result := 'Errore durante il salvataggio della nuova password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getErrorUpdatingUser: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error validating login';
    nlPortuguese:
      Result := 'Erro ao atualizar usu�rio';
    nlFrench:
      Result := 'Erreur lors de la mise � jour de l''utilisateur';
    nlSpanish:
      Result := 'Error al actualizar usuario';
    nlItalian:
      Result := 'Errore durante l''aggiornamento dell''utente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getErrorValidLogin: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Error validating login';
    nlPortuguese:
      Result := 'Erro ao validar login';
    nlFrench:
      Result := 'Erreur lors de la validation de la connexion';
    nlSpanish:
      Result := 'Error al validar el inicio de sesi�n';
    nlItalian:
      Result := 'Errore durante la convalida del login';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getInvalidEmailPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid email or password';
    nlPortuguese:
      Result := 'Email ou senha inv�lida';
    nlFrench:
      Result := 'Email ou mot de passe invalide';
    nlSpanish:
      Result := 'Correo electr�nico o contrase�a no v�lidos';
    nlItalian:
      Result := 'E-mail o password non validi';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getInvalidPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid password';
    nlPortuguese:
      Result := 'Senha inv�lida';
    nlFrench:
      Result := 'Mot de passe incorrect';
    nlSpanish:
      Result := 'Contrase�a invalida';
    nlItalian:
      Result := 'Password non valida';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getRecoverPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Recover Password';
    nlPortuguese:
      Result := 'Recupere sua senha';
    nlFrench:
      Result := 'R�cup�rer mot de passe';
    nlSpanish:
      Result := 'Recuperar contrase�a';
    nlItalian:
      Result := 'Recupera la password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSave: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Save';
    nlPortuguese:
      Result := 'Salvar';
    nlFrench:
      Result := 'Sauver';
    nlSpanish:
      Result := 'Guardar';
    nlItalian:
      Result := 'Salvare';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSavePassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Change Password';
    nlPortuguese:
      Result := 'Mudar a Senha';
    nlFrench:
      Result := 'Changer le mot de passe';
    nlSpanish:
      Result := 'Cambiar la contrase�a';
    nlItalian:
      Result := 'Cambia Password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSaveUser: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Save User';
    nlPortuguese:
      Result := 'Salvar Usu�rio';
    nlFrench:
      Result := 'Enregistrer l''utilisateur';
    nlSpanish:
      Result := 'Guardar Usuario';
    nlItalian:
      Result := 'Salva Utente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextChangePassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Change Password';
    nlPortuguese:
      Result := 'Trocar senha';
    nlFrench:
      Result := 'Changer le mot de passe';
    nlSpanish:
      Result := 'Cambiar la contrase�a';
    nlItalian:
      Result := 'Cambia la password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextTitleActiveAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Enter the code to active your account';
    nlPortuguese:
      Result := 'Informe o c�digo para ativar sua conta';
    nlFrench:
      Result := '';
    nlSpanish:
      Result := '';
    nlItalian:
      Result := '';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextTitleRecoverPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Enter the code to retrieve your password';
    nlPortuguese:
      Result := 'Informe o c�digo para recuperar sua senha';
    nlFrench:
      Result := 'Entrez le code pour r�cup�rer votre mot de passe';
    nlSpanish:
      Result := 'Ingrese el c�digo para recuperar su contrase�a';
    nlItalian:
      Result := 'Inserisci il codice per recuperare la tua password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextAlert_Message_Email: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Your verification code has been sent by email';
    nlPortuguese:
      Result := 'Seu c�digo de verifica��o foi enviado por email';
    nlFrench:
      Result := 'Votre code de v�rification a �t� envoy� par e-mail';
    nlSpanish:
      Result := 'Su c�digo de verificaci�n ha sido enviado por correo electr�nico';
    nlItalian:
      Result := 'Il tuo codice di verifica � stato inviato via email';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextAlert_Message_SMS: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Your verification code has been sent by SMS to %s';
    nlPortuguese:
      Result := 'Seu c�digo de verifica��o foi enviado por SMS para %s';
    nlFrench:
      Result := 'Votre code de v�rification a �t� envoy� par SMS au %s';
    nlSpanish:
      Result := 'Su c�digo de verificaci�n ha sido enviado por SMS al %s';
    nlItalian:
      Result := 'Il tuo codice di verifica � stato inviato via SMS al %s';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCreateNewPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Create New Password';
    nlPortuguese:
      Result := 'Criar Nova Senha';
    nlFrench:
      Result := 'Cr�er un nouveau mot de passe';
    nlSpanish:
      Result := 'Crear nueva contrase�a';
    nlItalian:
      Result := 'Crea nuova password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextName: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Name';
    nlPortuguese, nlItalian:
      Result := 'Nome';
    nlFrench:
      Result := 'Nom';
    nlSpanish:
      Result := 'Nombre';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextNewPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'New Password';
    nlPortuguese:
      Result := 'Nova Senha';
    nlFrench:
      Result := 'Nouveau mot de passe';
    nlSpanish:
      Result := 'Nueva contrase�a';
    nlItalian:
      Result := 'Nuova password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCompleteWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Complete the words';
    nlPortuguese:
      Result := 'Complete as Palavras';
    nlFrench:
      Result := 'Compl�ter les mots';
    nlSpanish:
      Result := 'Completa las palabras';
    nlItalian:
      Result := 'Completa le parole';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSelectWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Select the Words';
    nlPortuguese:
      Result := 'Selecione as Palavras';
    nlFrench:
      Result := 'S�lectionnez les mots';
    nlSpanish:
      Result := 'Seleccione las palabras';
    nlItalian:
      Result := 'Seleziona le parole';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSettings: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Settings';
    nlPortuguese:
      Result := 'Configura��es';
    nlFrench:
      Result := 'Param�tres';
    nlSpanish:
      Result := 'Configuraciones';
    nlItalian:
      Result := 'Impostazioni';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextHello: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Hello';
    nlPortuguese:
      Result := 'Ol�';
    nlFrench:
      Result := 'Salut';
    nlSpanish:
      Result := 'Hola';
    nlItalian:
      Result := 'Ciao';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextHowCanISay: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'How can I say';
    nlPortuguese:
      Result := 'Como posso dizer';
    nlFrench:
      Result := 'Comment puis-je dire';
    nlSpanish:
      Result := 'C�mo puedo decir';
    nlItalian:
      Result := 'Come posso dire';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextTheme: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Theme';
    nlPortuguese, nlSpanish, nlItalian:
      Result := 'Tema';
    nlFrench:
      Result := 'Th�me';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextTheWordIs: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'The word is:';
    nlPortuguese:
      Result := 'A palavra �:';
    nlFrench:
      Result := 'Le mot est:';
    nlSpanish:
      Result := 'La palabra es:';
    nlItalian:
      Result := 'La parola �:';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextToReviewWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'To review the words, click here';
    nlPortuguese:
      Result := 'Para revisar as palavras, clique aqui';
    nlFrench:
      Result := 'Pour revoir les mots, cliquez ici';
    nlSpanish:
      Result := 'Para revisar las palabras, haga clic aqu�';
    nlItalian:
      Result := 'Per rivedere le parole, clicca qui';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextConfirmPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Confirm the password';
    nlPortuguese:
      Result := 'Confirma a Senha';
    nlFrench:
      Result := 'Confirmer le mot de passe';
    nlSpanish:
      Result := 'Confirma la contrase�a';
    nlItalian:
      Result := 'Conferma la password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmptyNewPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Inform the new password';
    nlPortuguese:
      Result := 'Informe a nova senha';
    nlFrench:
      Result := 'Fournir le nouveau mot de passe';
    nlSpanish:
      Result := 'Informe la nueva contrase�a';
    nlItalian:
      Result := 'Fornire la nuova password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmptyCurrentPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Provide the current password';
    nlPortuguese:
      Result := 'Informe a senha atual';
    nlFrench:
      Result := 'Fournir le mot de passe actuel';
    nlSpanish:
      Result := 'Proporcione la contrase�a actual';
    nlItalian:
      Result := 'Fornire la password corrente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextEmptyEmail: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Email is empty';
    nlPortuguese:
      Result := 'Informe o email';
    nlFrench:
      Result := 'L''e-mail est vide';
    nlSpanish:
      Result := 'El correo electr�nico est� vac�o';
    nlItalian:
      Result := 'L''email � vuota';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmptyPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Password is empty';
    nlPortuguese:
      Result := 'Informe a senha';
    nlFrench:
      Result := 'Le mot de passe est vide';
    nlSpanish:
      Result := 'La contrase�a est� vac�a';
    nlItalian:
      Result := 'La password � vuota';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmptyPhone: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Phone is empty';
    nlPortuguese:
      Result := 'Informe o telefone';
    nlFrench:
      Result := 'Informer sur le t�l�phone';
    nlSpanish:
      Result := 'Informar al tel�fono';
    nlItalian:
      Result := 'Informa il telefono';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSelectNativeLanguage: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Select your native language';
    nlPortuguese:
      Result := 'Selecione sua l�ngua nativa';
    nlFrench:
      Result := 'S�lectionnez votre langue maternelle';
    nlSpanish:
      Result := 'Seleccione su idioma nativo';
    nlItalian:
      Result := 'Seleziona la tua lingua madre';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCategory: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Category';
    nlPortuguese, nlItalian:
      Result := 'Categoria';
    nlFrench:
      Result := 'Cat�gorie';
    nlSpanish:
      Result := 'Categor�a';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSearch: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Search';
    nlPortuguese:
      Result := 'Pesquisar';
    nlFrench:
      Result := 'Rechercher';
    nlSpanish:
      Result := 'Buscar';
    nlItalian:
      Result := 'Ricerca';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextTypeHere: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Type Here...';
    nlPortuguese:
      Result := 'Digite Aqui...';
    nlFrench:
      Result := '�crivez ici...';
    nlSpanish:
      Result := 'Escriba aqu�...';
    nlItalian:
      Result := 'Digitare qui...';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextBack: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Back';
    nlPortuguese:
      Result := 'Voltar';
    nlFrench:
      Result := 'Revenir';
    nlSpanish:
      Result := 'Vuelve';
    nlItalian:
      Result := 'Ritorno';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextNext: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Next';
    nlPortuguese, nlSpanish:
      Result := 'Pr�ximo';
    nlFrench:
      Result := 'Suivant';
    nlItalian:
      Result := 'Prossimo';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextBeginner: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Beginner';
    nlPortuguese:
      Result := 'Iniciante';
    nlFrench:
      Result := 'D�butant';
    nlItalian, nlSpanish:
      Result := 'Principiante';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextBodyActivedAccount: string;
var
  slResult: TStringList;
begin
  slResult := TStringList.Create;
  try
    case FNativeLanguage of
      nlEnglish:
        begin
          slResult.Add('Hello,');
          slResult.Add('');
          slResult.Add
            ('We would like to inform you that your account has been successfully activated!');
          slResult.Add
            ('Now you can take advantage of all the features and resources available in our app.');
          slResult.Add('');
          slResult.Add
            ('Thank you for choosing Polyglot, and we hope you have an excellent experience with us.');
          slResult.Add('');
          slResult.Add
            ('If you have any questions or need help, please do not hesitate to contact us.');
          slResult.Add('We are always available to assist you.');
          slResult.Add('');
          slResult.Add('Best regards,');
          slResult.Add('Polyglot Team');

        end;
      nlPortuguese:
        begin
          slResult.Add('Ol�,');
          slResult.Add('');
          slResult.Add
            ('Gostar�amos de informar que sua conta foi ativada com sucesso!');
          slResult.Add
            ('Agora voc� pode aproveitar todas as funcionalidades e recursos dispon�veis em nosso aplicativo.');
          slResult.Add('');
          slResult.Add
            ('Agradecemos por escolher o Polyglot e esperamos que voc� tenha uma excelente experi�ncia conosco.');
          slResult.Add('');
          slResult.Add
            ('Se voc� tiver alguma d�vida ou precisar de ajuda, n�o hesite em entrar em contato conosco.');
          slResult.Add('Estamos sempre � disposi��o para ajud�-lo.');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');
        end;
      nlFrench:
        begin
          slResult.Add('Bonjour,');
          slResult.Add('');
          slResult.Add
            ('Nous souhaitons vous informer que votre compte a �t� activ� avec succ�s !');
          slResult.Add
            ('Vous pouvez maintenant profiter de toutes les fonctionnalit�s et ressources disponibles dans notre application.');
          slResult.Add('');
          slResult.Add
            ('Nous vous remercions d�avoir choisi Polyglot et esp�rons que vous aurez une excellente exp�rience avec nous.');
          slResult.Add('');
          slResult.Add
            ('Si vous avez des questions ou besoin d�aide, n�h�sitez pas � nous contacter.');
          slResult.Add('Nous sommes toujours disponibles pour vous aider.');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('L��quipe Polyglot');

        end;
      nlSpanish:
        begin
          slResult.Add('�Hola,!');
          slResult.Add('');
          slResult.Add
            ('�Nos gustar�a informarle que su cuenta ha sido activada con �xito!');
          slResult.Add
            ('Ahora puede aprovechar todas las caracter�sticas y recursos disponibles en nuestra aplicaci�n.');
          slResult.Add('');
          slResult.Add
            ('Gracias por elegir Polyglot, y esperamos que tenga una excelente experiencia con nosotros.');
          slResult.Add('');
          slResult.Add
            ('Si tiene alguna pregunta o necesita ayuda, no dude en ponerse en contacto con nosotros.');
          slResult.Add('Siempre estamos disponibles para ayudarlo.');
          slResult.Add('');
          slResult.Add('Saludos cordiales,');
          slResult.Add('Equipo Polyglot');

        end;
      nlItalian:
        begin
          slResult.Add('Ciao,');
          slResult.Add('');
          slResult.Add
            ('Desideriamo informarti che il tuo account � stato attivato con successo!');
          slResult.Add
            ('Ora puoi usufruire di tutte le funzionalit� e le risorse disponibili nella nostra applicazione.');
          slResult.Add('');
          slResult.Add
            ('Grazie per aver scelto Polyglot, e speriamo che tu abbia un\''esperienza eccellente con noi.');
          slResult.Add('');
          slResult.Add
            ('Se hai domande o hai bisogno di aiuto, non esitare a contattarci.');
          slResult.Add('Siamo sempre disponibili ad assisterti.');
          slResult.Add('');
          slResult.Add('Cordiali saluti,');
          slResult.Add('Team Polyglot');
        end
    else
      raise Exception.Create
        ('Sorry, something went wrong. Error: Unknown Language');
    end;
  finally
    Result := slResult.Text;
    if Assigned(slResult) then
      FreeAndNil(slResult);
  end;
end;

function TText.getTextBodyCreateAccount: string;
var
  slResult: TStringList;
begin
  slResult := TStringList.Create;
  try
    case FNativeLanguage of
      nlEnglish:
        begin
          slResult.Add('Dear,');
          slResult.Add('We are thrilled to welcome you to Polyglot!');
          slResult.Add
            ('Our team is excited to help you learn and improve your skills in a new language.');
          slResult.Add
            ('Our app has been designed to be user-friendly and personalized to your learning needs.');
          slResult.Add
            ('With Polyglot, you will have access to a wide variety of learning resources, such as interactive lessons, vocabulary and phrase memorization exercises, audios, and other amazing features.');
          slResult.Add
            ('To activate your account, please enter the code below in your app to validate your user.');
          slResult.Add('');
          slResult.Add('Activation Code: %s');
          slResult.Add('');
          slResult.Add
            ('Please do not hesitate to contact us if you have any questions or need assistance. We are here to help you every step of the way in your learning journey.');
          slResult.Add('Thank you for joining our community!');
          slResult.Add('');
          slResult.Add('Sincerely,');
          slResult.Add('Polyglot Team');

        end;
      nlPortuguese:
        begin
          slResult.Add('Prezado(a),');
          slResult.Add
            ('� com grande satisfa��o que lhe damos as boas-vindas ao Polyglot!');
          slResult.Add
            ('N�s da equipe estamos empolgados em ajud�-lo(a) a aprender e aprimorar suas habilidades em uma nova l�ngua.');
          slResult.Add
            ('Nosso aplicativo foi projetado para ser f�cil de usar e personalizado para suas necessidades de aprendizado.');
          slResult.Add
            ('Com o Polyglot, voc� ter� acesso a uma ampla variedade de recursos de aprendizado, como li��es interativas, exerc�cios de memorariza��o de vocabul�rio e frases, �udios, al�m de outros recursos incr�veis.');
          slResult.Add
            ('Para ativar seu cadastro, informe o c�digo abaixo no seu aplicativo para validarmos seu usu�rio.');
          slResult.Add('');
          slResult.Add('C�digo de Ativa��o: %s');
          slResult.Add('');
          slResult.Add
            ('N�o hesite em nos contatar se tiver alguma d�vida ou precisar de ajuda. Estamos aqui para ajud�-lo(a) em cada passo da sua jornada de aprendizado.');
          slResult.Add('Obrigado(a) por se juntar � nossa comunidade!');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');
        end;

      nlFrench:
        begin
          slResult.Clear;
          slResult.Add('Cher/Ch�re,');
          slResult.Add('Nous sommes ravis de vous accueillir sur Polyglot !');
          slResult.Add
            ('Notre �quipe est ravie de vous aider � apprendre et � am�liorer vos comp�tences dans une nouvelle langue.');
          slResult.Add
            ('Notre application a �t� con�ue pour �tre conviviale et personnalis�e � vos besoins d''apprentissage.');
          slResult.Add
            ('Avec Polyglot, vous aurez acc�s � une large gamme de ressources d''apprentissage, telles que des le�ons interactives, des exercices de m�morisation de vocabulaire et de phrases, des audios et d''autres fonctionnalit�s incroyables.');
          slResult.Add
            ('Pour activer votre compte, veuillez saisir le code ci-dessous dans votre application pour valider votre utilisateur.');
          slResult.Add('');
          slResult.Add('Code d''Activation : %s');
          slResult.Add('');
          slResult.Add
            ('N''h�sitez pas � nous contacter si vous avez des questions ou si vous avez besoin d''aide. Nous sommes l� pour vous aider � chaque �tape de votre parcours d''apprentissage.');
          slResult.Add('Merci d''avoir rejoint notre communaut� !');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('L''�quipe Polyglot');
        end;

      nlSpanish:
        begin
          slResult.Add('�Estimado/a!,');
          slResult.Add
            ('�Estamos encantados de darte la bienvenida a Polyglot!');
          slResult.Add
            ('Nuestro equipo est� emocionado de ayudarte a aprender y mejorar tus habilidades en un nuevo idioma.');
          slResult.Add
            ('Nuestra aplicaci�n ha sido dise�ada para ser f�cil de usar y personalizada a tus necesidades de aprendizaje.');
          slResult.Add
            ('Con Polyglot, tendr�s acceso a una amplia variedad de recursos de aprendizaje, como lecciones interactivas, ejercicios de memorizaci�n de vocabulario y frases, audios y otras incre�bles funciones.');
          slResult.Add
            ('Para activar tu cuenta, por favor ingresa el siguiente c�digo en tu aplicaci�n para validar tu usuario.');
          slResult.Add('');
          slResult.Add('C�digo de Activaci�n: %s');
          slResult.Add('');
          slResult.Add
            ('Por favor, no dudes en contactarnos si tienes alguna pregunta o necesitas ayuda. Estamos aqu� para ayudarte en cada paso de tu viaje de aprendizaje.');
          slResult.Add('�Gracias por unirte a nuestra comunidad!');
          slResult.Add('');
          slResult.Add('Atentamente,');
          slResult.Add('Equipo Polyglot');
        end;

      nlItalian:
        begin
          slResult.Add('Gentile,');
          slResult.Add
            ('� con grande piacere che vi diamo il benvenuto su Polyglot!');
          slResult.Add
            ('Noi del team siamo entusiasti di aiutarti a imparare e migliorare le tue abilit� in una nuova lingua.');
          slResult.Add
            ('La nostra app � stata progettata per essere facile da usare e personalizzata per le tue esigenze di apprendimento.');
          slResult.Add
            ('Con Polyglot, avrai accesso a una vasta gamma di risorse didattiche, come lezioni interattive, esercizi di memorizzazione di vocaboli e frasi, audio e altre incredibili risorse.');
          slResult.Add
            ('Per attivare il tuo account, inserisci il codice qui sotto nell''applicazione per validare il tuo utente.');
          slResult.Add('');
          slResult.Add('Codice di Attivazione: %s');
          slResult.Add('');
          slResult.Add
            ('Non esitare a contattarci se hai domande o hai bisogno di aiuto. Siamo qui per aiutarti in ogni passo del tuo percorso di apprendimento.');
          slResult.Add('Grazie per unirti alla nostra comunit�!');
          slResult.Add('');
          slResult.Add('Cordiali saluti,');
          slResult.Add('Team Polyglot');
        end;

    else
      raise Exception.Create
        ('Sorry, something went wrong. Error: Unknown Language');
    end;
  finally
    Result := slResult.Text;
    if Assigned(slResult) then
      FreeAndNil(slResult);
  end;

end;

function TText.getTextBodyRecoveredPassword: string;
var
  slResult: TStringList;
begin
  slResult := TStringList.Create;
  try
    case FNativeLanguage of
      nlEnglish:
        begin
          slResult.Add('Dear,');
          slResult.Add('');
          slResult.Add
            ('We would like to inform you that your password has been successfully changed.');
          slResult.Add
            ('As a security measure, it is important that you keep your password confidential and do not share it with third parties.');
          slResult.Add
            ('If you suspect any suspicious activity on your account, please contact our support immediately.');
          slResult.Add('');
          slResult.Add('Sincerely,');
          slResult.Add('Polyglot Team');
        end;
      nlPortuguese:
        begin
          slResult.Add('Prezado(a),');
          slResult.Add('');
          slResult.Add
            ('Gostar�amos de informar que a sua senha foi alterada com sucesso.');
          slResult.Add
            ('Lembramos que, como medida de seguran�a, � importante que voc� mantenha sua senha em sigilo e n�o a compartilhe com terceiros.');
          slResult.Add
            ('Caso suspeite de alguma atividade suspeita em sua conta, por favor, entre em contato imediatamente com o nosso suporte.');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');

        end;
      nlFrench:
        begin
          slResult.Add('Cher(e),');
          slResult.Add('');
          slResult.Add
            ('Nous souhaitons vous informer que votre mot de passe a �t� modifi� avec succ�s.');
          slResult.Add
            ('Comme mesure de s�curit�, il est important de garder votre mot de passe confidentiel et de ne pas le partager avec des tiers.');
          slResult.Add
            ('Si vous soup�onnez une activit� suspecte sur votre compte, veuillez contacter imm�diatement notre support.');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('�quipe Polyglot');
        end;
      nlSpanish:
        begin
          slResult.Add('Estimado(a),');
          slResult.Add('');
          slResult.Add
            ('Nos gustar�a informarle que su contrase�a ha sido cambiada exitosamente.');
          slResult.Add
            ('Como medida de seguridad, es importante que mantenga su contrase�a confidencial y no la comparta con terceros.');
          slResult.Add
            ('Si sospecha de alguna actividad sospechosa en su cuenta, por favor, contacte inmediatamente con nuestro soporte.');
          slResult.Add('');
          slResult.Add('Atentamente,');
          slResult.Add('Equipo Polyglot');
        end;
      nlItalian:
        begin
          slResult.Add('Gentile,');
          slResult.Add('');
          slResult.Add
            ('Desideriamo informarla che la sua password � stata cambiata con successo.');
          slResult.Add
            ('Come misura di sicurezza, � importante mantenere la password confidenziale e non condividerla con terze parti.');
          slResult.Add
            ('Se sospetta qualsiasi attivit� sospetta sul suo account, si prega di contattare immediatamente il nostro supporto.');
          slResult.Add('');
          slResult.Add('Cordiali saluti,');
          slResult.Add('Team Polyglot');

        end;
    else
      raise Exception.Create
        ('Sorry, something went wrong. Error: Unknown Language');
    end;
  finally
    Result := slResult.Text;
    if Assigned(slResult) then
      FreeAndNil(slResult);
  end;
end;

function TText.getTextBodyRecoverPassword: string;
var
  slResult: TStringList;
begin
  slResult := TStringList.Create;
  try
    case FNativeLanguage of
      nlEnglish:
        begin
          slResult.Add('Dear,');
          slResult.Add('');
          slResult.Add
            ('We have received a request to recover your password for your Polyglot account.');
          slResult.Add
            ('To help you reset your password, we have sent a recovery code.');
          slResult.Add('Please use the code below to create a new password:');
          slResult.Add('');
          slResult.Add('Recovery Code: %s');
          slResult.Add('');
          slResult.Add
            ('If you did not request a password recovery, please contact us immediately so we can take necessary measures to protect your account.');
          slResult.Add('');
          slResult.Add('Best regards,');
          slResult.Add('Polyglot Team');
        end;
      nlPortuguese:
        begin
          slResult.Add('Prezado(a),');
          slResult.Add('');
          slResult.Add
            ('Recebemos uma solicita��o para recuperar sua senha da sua conta Polyglot.');
          slResult.Add
            ('Para ajud�-lo(a) a redefinir sua senha, enviamos um c�digo de recupera��o.');
          slResult.Add
            ('Por favor, utilize o c�digo abaixo para criar uma nova senha:');
          slResult.Add('');
          slResult.Add('C�digo de Recupera��o: %s');
          slResult.Add('');
          slResult.Add
            ('Se voc� n�o solicitou a recupera��o da senha, por favor, entre em contato conosco imediatamente para que possamos tomar as medidas necess�rias para proteger sua conta.');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');
        end;
      nlFrench:
        begin
          slResult.Add('Cher(�re),');
          slResult.Add('');
          slResult.Add
            ('Nous avons re�u une demande de r�cup�ration de votre mot de passe pour votre compte Polyglot.');
          slResult.Add
            ('Pour vous aider � r�initialiser votre mot de passe, nous avons envoy� un code de r�cup�ration.');
          slResult.Add
            ('Veuillez utiliser le code ci-dessous pour cr�er un nouveau mot de passe:');
          slResult.Add('');
          slResult.Add('Code de r�cup�ration: %s');
          slResult.Add('');
          slResult.Add
            ('Si vous n''avez pas demand� de r�cup�ration de mot de passe, veuillez nous contacter imm�diatement afin que nous puissions prendre les mesures n�cessaires pour prot�ger votre compte.');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('L''�quipe Polyglot');
        end;
      nlSpanish:
        begin
          slResult.Add('Estimado/a,');
          slResult.Add('');
          slResult.Add
            ('Hemos recibido una solicitud para recuperar su contrase�a de su cuenta de Polyglot.');
          slResult.Add
            ('Para ayudarlo(a) a restablecer su contrase�a, hemos enviado un c�digo de recuperaci�n.');
          slResult.Add
            ('Por favor, utilice el c�digo a continuaci�n para crear una nueva contrase�a:');
          slResult.Add('');
          slResult.Add('C�digo de recuperaci�n: %s');
          slResult.Add('');
          slResult.Add
            ('Si no solicit� la recuperaci�n de la contrase�a, por favor cont�ctenos de inmediato para que podamos tomar las medidas necesarias para proteger su cuenta.');
          slResult.Add('');
          slResult.Add('Atentamente,');
          slResult.Add('Equipo Polyglot');
        end;
      nlItalian:
        begin
          slResult.Add('Gentile,');
          slResult.Add('');
          slResult.Add
            ('Abbiamo ricevuto una richiesta di recupero della password per il tuo account Polyglot.');
          slResult.Add
            ('Per aiutarti a reimpostare la tua password, abbiamo inviato un codice di recupero.');
          slResult.Add
            ('Usa il codice qui sotto per creare una nuova password:');
          slResult.Add('');
          slResult.Add('Codice di recupero: %s');
          slResult.Add('');
          slResult.Add
            ('Se non hai richiesto il recupero della password, contattaci immediatamente in modo che possiamo prendere le misure necessarie per proteggere il tuo account.');
          slResult.Add('');
          slResult.Add('Cordiali saluti,');
          slResult.Add('Team Polyglot');
        end;
    else
      raise Exception.Create
        ('Sorry, something went wrong. Error: Unknown Language');
    end;

  finally
    Result := slResult.Text;
    if Assigned(slResult) then
      FreeAndNil(slResult);
  end;
end;

function TText.getTextIntermediary: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Intermediary';
    nlPortuguese:
      Result := 'Intermedi�rio';
    nlFrench:
      Result := 'Interm�diaire';
    nlItalian, nlSpanish:
      Result := 'Intermediario';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextAdvanced: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Advanced';
    nlPortuguese:
      Result := 'Avan�ado';
    nlFrench:
      Result := 'Avanc�';
    nlItalian:
      Result := 'Avanzato';
    nlSpanish:
      Result := 'Avanzado';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextPhrases: string;
begin
  case FNativeLanguage of
    nlEnglish, nlFrench:
      Result := 'Phrases';
    nlPortuguese, nlSpanish:
      Result := 'Frases';
    nlItalian:
      Result := 'Frasi';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Words';
    nlPortuguese:
      Result := 'Palavras';
    nlFrench:
      Result := 'Mots';
    nlItalian:
      Result := 'Parole';
    nlSpanish:
      Result := 'Palabras';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getNewVersion: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'New version available';
    nlPortuguese:
      Result := 'Nova vers�o dispon�vel';
    nlFrench:
      Result := 'Nouvelle version disponible';
    nlItalian:
      Result := 'Nuova versione disponibile';
    nlSpanish:
      Result := 'Nueva versi�n disponible';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getPasswordChanged: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Password changed successfully. Login again';
    nlPortuguese:
      Result := 'Senha alterada com sucesso. Fa�a o login novamente';
    nlFrench:
      Result := 'Le mot de passe a �t� chang� avec succ�s. Reconnectez-vous';
    nlSpanish:
      Result := 'Contrase�a alterada con �xito. Ingresar de nuevo';
    nlItalian:
      Result := 'Password cambiata con successo. Accedi di nuovo';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getUpdateApp: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Click the button below to receive the new update for your app.';
    nlPortuguese:
      Result := 'Clique no bot�o abaixo para receber a nova atualiza��o para seu aplicativo.';
    nlFrench:
      Result := 'Cliquez sur le bouton ci-dessous pour recevoir la nouvelle mise � jour de votre application.';
    nlItalian:
      Result := 'Fai clic sul pulsante qui sotto per ricevere il nuovo aggiornamento per la tua app.';
    nlSpanish:
      Result := 'Haz clic en el bot�n de abajo para recibir la nueva actualizaci�n de tu aplicaci�n.';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextMenuChangeLanguage: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Change the language';
    nlPortuguese:
      Result := 'Mudar o idioma';
    nlFrench:
      Result := 'Changer la langue';
    nlItalian:
      Result := 'Cambia la lingua';
    nlSpanish:
      Result := 'Cambiar el idioma';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextMenuCompleteWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Complete the Words';
    nlPortuguese:
      Result := 'Complete as palavras';
    nlFrench:
      Result := 'Compl�tez les mots';
    nlItalian:
      Result := 'Completa le parole';
    nlSpanish:
      Result := 'Completa las palabras';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextMenuPracticeYourMemory: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Practice Your Memory';
    nlPortuguese:
      Result := 'Pratique sua mem�ria';
    nlFrench:
      Result := 'Pratiquez votre m�moire';
    nlItalian:
      Result := 'Pratica la tua memoria';
    nlSpanish:
      Result := 'Practica tu memoria';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextMenuSelectWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Select the Words';
    nlPortuguese:
      Result := 'Selecione as Palavras';
    nlFrench:
      Result := 'S�lectionner des mots';
    nlItalian:
      Result := 'Seleziona Parole';
    nlSpanish:
      Result := 'Seleccionar palabras';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextMenuLogout: string;
begin
  case FNativeLanguage of
    nlEnglish, nlItalian:
      Result := 'Logout';
    nlPortuguese:
      Result := 'Sair';
    nlFrench:
      Result := 'D�connexion';
    nlSpanish:
      Result := 'Cerrar sesi�n';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextMenuAddWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Add Words';
    nlPortuguese:
      Result := 'Adicionar palavras';
    nlFrench:
      Result := 'Ajouter des mots';
    nlItalian:
      Result := 'Aggiungi parole';
    nlSpanish:
      Result := 'A�adir palabras';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextVerifyCode: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Verify code';
    nlPortuguese:
      Result := 'Verificar c�digo';
    nlFrench:
      Result := 'V�rifier le code';
    nlSpanish:
      Result := 'Verificar c�digo';
    nlItalian:
      Result := 'Verificare codice';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextVersion: string;
begin
  case FNativeLanguage of
    nlEnglish, nlFrench:
      Result := 'Version';
    nlPortuguese:
      Result := 'Vers�o';
    nlItalian:
      Result := 'Versione';
    nlSpanish:
      Result := 'Versi�n';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextDevelopedBy: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Developed by';
    nlPortuguese:
      Result := 'Desenvolvido por';
    nlFrench:
      Result := 'D�velopp� par';
    nlItalian:
      Result := 'Sviluppato da';
    nlSpanish:
      Result := 'Desarrollado por';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPasswordsShouldBeEqual: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'The passwords provided must be the same';
    nlPortuguese:
      Result := 'As senhas informadas devem ser iguais';
    nlFrench:
      Result := 'Les mots de passe fournis doivent �tre identiques';
    nlSpanish:
      Result := 'Las contrase�as proporcionadas deben ser iguales';
    nlItalian:
      Result := 'Le password fornite devono essere uguali';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextPasswordsShouldBeDifferentCurrent: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'The new password must be different from the current one';
    nlPortuguese:
      Result := 'A nova senha deve ser diferente da atual';
    nlFrench:
      Result := 'Le nouveau mot de passe doit �tre diff�rent de l''actuel';
    nlSpanish:
      Result := 'La nueva contrase�a debe ser diferente de la actual';
    nlItalian:
      Result := 'La nuova password deve essere diversa da quella attuale';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextTermsConditions: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Terms and Conditions';
    nlPortuguese:
      Result := 'Termos e Condi��es';
    nlFrench:
      Result := 'Termes et Conditions';
    nlSpanish:
      Result := 'T�rminos y Condiciones';
    nlItalian:
      Result := 'Termini e Condizioni';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextTermsOfUse: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Terms of use';
    nlPortuguese:
      Result := 'Termos de uso';
    nlFrench:
      Result := 'Conditions d''utilisation';
    nlSpanish:
      Result := 'Terminos de uso';
    nlItalian:
      Result := 'Termini di utilizzo';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextClickHereAndRecord: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Click here and record your voice';
    nlPortuguese:
      Result := 'Clique aqui e grave sua voz';
    nlFrench:
      Result := 'Cliquez ici et enregistrez votre voix';
    nlSpanish:
      Result := 'Haga clic aqu� y grabe su voz';
    nlItalian:
      Result := 'Clicca qui e registra la tua voce';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextLast: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Previous';
    nlPortuguese:
      Result := 'Anterior';
    nlFrench:
      Result := 'Pr�c�dent';
    nlSpanish:
      Result := 'Anterior';
    nlItalian:
      Result := 'Precedente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextClickHereKnowTranslation: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Click here to know the translation';
    nlPortuguese:
      Result := 'Clique aqui para saber a tradu��o';
    nlFrench:
      Result := 'Cliquez ici pour conna�tre la traduction';
    nlSpanish:
      Result := 'Click aqu� para conocer la traducci�n';
    nlItalian:
      Result := 'Clicca qui per conoscere la traduzione';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextTryAgain: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Try Again';
    nlPortuguese:
      Result := 'Tente Novamente';
    nlFrench:
      Result := 'Essayer � Nouveau';
    nlSpanish:
      Result := 'Intentar Otra Vez';
    nlItalian:
      Result := 'Riprova';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextStop: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Stop';
    nlPortuguese:
      Result := 'Parar';
    nlFrench:
      Result := 'Arr�ter';
    nlSpanish:
      Result := 'Detener';
    nlItalian:
      Result := 'Fermare';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPlay: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Play audio';
    nlPortuguese:
      Result := 'Reproduzir audio';
    nlFrench:
      Result := 'Lire le son';
    nlSpanish:
      Result := 'Reproducir audio';
    nlItalian:
      Result := 'Riproduci l''audio';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextRanking: string;
begin
  case FNativeLanguage of
    nlEnglish, nlPortuguese, nlFrench, nlSpanish, nlItalian:
      Result := 'Ranking';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextRecordWord: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Record the word';
    nlPortuguese:
      Result := 'Grave a palavra';
    nlFrench:
      Result := 'Enregistrer le mot';
    nlSpanish:
      Result := 'Graba la palabra';
    nlItalian:
      Result := 'Registra la parola';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextRecoverPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Enter your email and we will send you instructions to reset your password';
    nlPortuguese:
      Result := 'Digite seu e-mail que enviaremos instru��es para redefinir sua senha';
    nlFrench:
      Result := 'Entrez votre adresse e-mail et nous vous enverrons des instructions pour r�initialiser votre mot de passe';
    nlSpanish:
      Result := 'Introduce tu correo electr�nico y te enviaremos instrucciones para restablecer tu contrase�a';
    nlItalian:
      Result := 'Inserisci la tua email e ti invieremo le istruzioni per reimpostare la tua password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSubjectActivedAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Congratulations, your account has been activated!';
    nlPortuguese:
      Result := 'Parab�ns, sua conta foi ativada!';
    nlFrench:
      Result := 'F�licitations, votre compte a �t� activ�!';
    nlSpanish:
      Result := '�Felicidades, su cuenta ha sido activada!';
    nlItalian:
      Result := 'Congratulazioni, il tuo account � stato attivato!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSubjectCreateAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Welcome to Polyglot';
    nlPortuguese:
      Result := 'Bem-vindo ao Polyglot';
    nlFrench:
      Result := 'Bienvenue sur Polyglot';
    nlSpanish:
      Result := 'Bienvenido a Polyglot';
    nlItalian:
      Result := 'Benvenuto su Polyglot';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextSubjectRecoveredPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Your password has been successfully changed!';
    nlPortuguese:
      Result := 'Sua senha foi alterada com sucesso!';
    nlFrench:
      Result := 'Votre mot de passe a �t� modifi� avec succ�s!';
    nlSpanish:
      Result := '�Su contrase�a ha sido cambiada con �xito!';
    nlItalian:
      Result := 'La tua password � stata cambiata con successo!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSubjectRecoverPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Recover Password';
    nlPortuguese:
      Result := 'Recuperar Senha';
    nlFrench:
      Result := 'R�cup�rer mot de passe';
    nlSpanish:
      Result := 'Recuperar contrase�a';
    nlItalian:
      Result := 'Recupera la password';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextClickAgainToStopRecording: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Click Again to stop recording';
    nlPortuguese:
      Result := 'Clique novamente para parar a grava��o';
    nlFrench:
      Result := 'Cliquez � nouveau pour arr�ter l''enregistrement';
    nlSpanish:
      Result := 'Haga clic de nuevo para detener la grabaci�n';
    nlItalian:
      Result := 'Fare clic di nuovo per interrompere la registrazione';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextNoWordsToRecord: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'There are no words to record :)';
    nlPortuguese:
      Result := 'N�o existem palavras para gravar :)';
    nlFrench:
      Result := 'Il n''y a pas de mots � enregistrer';
    nlSpanish:
      Result := 'No hay palabras para grabar';
    nlItalian:
      Result := 'Non ci sono parole da registrare';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCurrentPassword: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Current Password';
    nlPortuguese:
      Result := 'Senha Atual';
    nlFrench:
      Result := 'Mot de passe actuel';
    nlSpanish:
      Result := 'Contrase�a actual';
    nlItalian:
      Result := 'Password corrente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getText404: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Apparently the server is currently offline. Try again later';
    nlPortuguese:
      Result := 'Aparentemente o servidor est� offline no momento. Tente novamente mais tarde';
    nlFrench:
      Result := 'Apparemment, le serveur est actuellement hors ligne. R�essayez plus tard';
    nlSpanish:
      Result := 'Aparentemente, el servidor est� actualmente fuera de l�nea. Vuelva a intentarlo m�s tarde';
    nlItalian:
      Result := 'A quanto pare il server � attualmente offline. Riprovare pi� tardi';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextAboutApp: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'About the Application';
    nlPortuguese:
      Result := 'Sobre o Aplicativo';
    nlFrench:
      Result := '� propos de l''application';
    nlSpanish:
      Result := 'Acerca de la aplicaci�n';
    nlItalian:
      Result := 'Informazioni sull''applicazione';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextAccept: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Accept';
    nlPortuguese:
      Result := 'Aceitar';
    nlFrench:
      Result := 'J''accepte';
    nlSpanish:
      Result := 'Aceptar';
    nlItalian:
      Result := 'Accettare';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextDecline: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Decline';
    nlPortuguese:
      Result := 'N�o aceitar';
    nlFrench:
      Result := 'D�clin';
    nlSpanish:
      Result := 'Disminuci�n';
    nlItalian:
      Result := 'Declino';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextDeleteAccount: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Delete Account';
    nlPortuguese:
      Result := 'Excluir Conta';
    nlFrench:
      Result := 'Supprimer le compte';
    nlSpanish:
      Result := 'Eliminar cuenta';
    nlItalian:
      Result := 'Elimina account';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextRegisterWord: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Register the words';
    nlPortuguese:
      Result := 'Cadastre as palavras';
    nlFrench:
      Result := 'Enregistrer les mots';
    nlSpanish:
      Result := 'Registrar las palabras';
    nlItalian:
      Result := 'Registra le parole';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextResendCode: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Resend Code';
    nlPortuguese:
      Result := 'Reenviar C�digo';
    nlSpanish:
      Result := 'Reenviar Codigo';
    nlFrench:
      Result := 'Renvoyer Code';
    nlItalian:
      Result := 'Codice di Rispedizione';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextResourceNotAvaliable: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Option not available, please login to release access';
    nlPortuguese:
      Result := 'Op��o n�o dispon�vel, fa�a o login para liberar o acesso';
    nlSpanish:
      Result := 'Opci�n no disponible, inicie sesi�n para liberar el acceso';
    nlFrench:
      Result := 'Option non disponible, veuillez vous connecter pour lib�rer l''acc�s';
    nlItalian:
      Result := 'Opzione non disponibile, effettua il login per rilasciare l''accesso';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextReview: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Review';
    nlPortuguese:
      Result := 'Revis�o';
    nlFrench:
      Result := 'R�vision';
    nlSpanish:
      Result := 'Revisi�n';
    nlItalian:
      Result := 'Revisione';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextReviewLastWordsThisRound: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Last words of this round';
    nlPortuguese:
      Result := '�ltimas palavras dessa rodada';
    nlFrench:
      Result := 'Derniers mots de ce tour';
    nlSpanish:
      Result := '�ltimas palabras de esta ronda';
    nlItalian:
      Result := 'Ultime parole di questo round';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCancel: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Cancel';
    nlPortuguese, nlSpanish:
      Result := 'Cancelar';
    nlFrench:
      Result := 'Annuler';
    nlItalian:
      Result := 'Annulla';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;

end;

function TText.getTextTypeWord(NativeLanguage: TNativeLanguage): string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Type a word in ' + NativeLanguage.Description;
    nlPortuguese:
      Result := 'Digite a palavra em ' + NativeLanguage.Description;
    nlFrench:
      Result := 'Tapez un mot en ' + NativeLanguage.Description;
    nlSpanish:
      Result := 'Escribe una palabra en ' + NativeLanguage.Description;
    nlItalian:
      Result := 'Digita una parola in ' + NativeLanguage.Description;
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextMemoryGame: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Memory Game';
    nlPortuguese:
      Result := 'Jogo da mem�ria';
    nlFrench:
      Result := 'Jeux de m�moire';
    nlSpanish:
      Result := 'Juego de memoria';
    nlItalian:
      Result := 'Gioco di memoria';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextSwipeWordsUp: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Swipe the Words Up';
    nlPortuguese:
      Result := 'Deslize as palavras at� em cima da respectiva tradu��o';
    nlFrench:
      Result := 'Glisse les mots vers le haut';
    nlSpanish:
      Result := 'Desliza las palabras hacia arriba';
    nlItalian:
      Result := 'Scorri le parole verso l''alto';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

{ Errors }
function TText.getTextErrorNoCategory: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Something wrong happened :/. Category not found. Please, try it again!';
    nlPortuguese:
      Result := 'Algo aconteceu :/ !Categoria n�o encontrada. Tente novamente!';
    nlFrench:
      Result := 'Quelque chose s''est mal pass� :/. Cat�gorie introuvable. S''il vous pla�t, r�essayez�!';
    nlSpanish:
      Result := 'Algo malo paso :/. Categor�a no encontrada. �Int�ntelo de nuevo!';
    nlItalian:
      Result := '� successo qualcosa di sbagliato :/. Categoria non trovata. Per favore, riprova!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

class function TText.New(NativeLanguage: TNativeLanguage): IText;
begin
  Result := Self.Create(NativeLanguage);
end;

function TText.getTextInvalidResetPasswordAction: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Sorry, something went wrong. Error: Action requested was not recognized as a valid password reset.';
    nlPortuguese:
      Result := 'Desculpe, algo deu errado. Erro: A a��o solicitada n�o foi reconhecida como uma redefini��o de senha v�lida.';
    nlFrench:
      Result := 'D�sol�, quelque chose s''est mal pass�. Erreur: L''action demand�e n''a pas �t� reconnue comme une r�initialisation de mot de passe valide.';
    nlSpanish:
      Result := 'Lo siento, algo sali� mal. Error: La acci�n solicitada no fue reconocida como un restablecimiento de contrase�a v�lido.';
    nlItalian:
      Result := 'Spiacente, qualcosa � andato storto. Errore: L''azione richiesta non � stata riconosciuta come una reimpostazione della password valida.';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextInvalidCodeLenghtIncorrect: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'The verification code you entered is incorrect. Please check again and enter the correct 4 digits';
    nlPortuguese:
      Result := 'O c�digo de verifica��o que voc� inseriu est� incorreto. Por favor, verifique novamente e insira os 4 d�gitos corretos';
    nlFrench:
      Result := 'Le code de v�rification que vous avez saisi est incorrect. Veuillez v�rifier � nouveau et entrer les 4 chiffres corrects';
    nlSpanish:
      Result := 'El c�digo de verificaci�n que ingresaste es incorrecto. Por favor, verifica nuevamente e ingresa los 4 d�gitos correctos';
    nlItalian:
      Result := 'Il codice di verifica che hai inserito � incorretto. Controlla nuovamente e inserisci i 4 cifre corretti';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextInvalidCodeLenghtIncorrectCreated: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Something went wrong! The generated verification code is incorrect. Please contact support for assistance';
    nlPortuguese:
      Result := 'Algo de errado aconteceu! O c�digo de verifica��o gerado est� incorreto. Por favor, entre em contato com o suporte para obter assist�ncia';
    nlFrench:
      Result := 'Quelque chose s''est mal pass�. Le code de v�rification g�n�r� est incorrect. Veuillez contacter le support pour obtenir de l''aide';
    nlSpanish:
      Result := 'Algo sali� mal. El c�digo de verificaci�n generado es incorrecto. Por favor, p�ngase en contacto con el soporte para obtener ayuda';
    nlItalian:
      Result := 'Qualcosa � andato storto. Il codice di verifica generato � errato. Contatta il supporto per assistenza';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCodeIncorrect: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'The verification code entered is incorrect. Please try again. If necessary, you can request the code to be resent';
    nlPortuguese:
      Result := 'O c�digo de verifica��o inserido est� incorreto. Por favor, verifique o c�digo que foi enviado para o seu email/SMS e tente novamente. Caso necess�rio, voc� pode solicitar o reenvio do c�digo';
    nlFrench:
      Result := 'Le code de v�rification saisi est incorrect. Veuillez r�essayer. Si n�cessaire, vous pouvez demander � ce que le code soit renvoy�';
    nlSpanish:
      Result := 'El c�digo de verificaci�n ingresado es incorrecto. Por favor, int�ntelo de nuevo. Si es necesario, puede solicitar que se reenv�e el c�digo';
    nlItalian:
      Result := 'Il codice di verifica inserito non � corretto. Si prega di riprovare. Se necessario, � possibile richiedere che il codice venga inviato nuovamente';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextInvalidEmail: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid email';
    nlPortuguese:
      Result := 'Email inv�lido';
    nlFrench:
      Result := 'Email invalide';
    nlSpanish:
      Result := 'Email inv�lido';
    nlItalian:
      Result := 'E-mail non valido';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextEmailAlreadyExists: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'This email address already exists. Please provide another one';
    nlPortuguese:
      Result := 'Este endere�o de e-mail j� est� em uso. Por favor, forne�a outro';
    nlFrench:
      Result := 'Cette adresse e-mail existe d�j�. Veuillez en fournir une autre';
    nlSpanish:
      Result := 'Este correo electr�nico ya est� en uso. Por favor, proporcione otro';
    nlItalian:
      Result := 'Questo indirizzo email esiste gi�. Si prega di fornirne un altro';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextInvalidForm: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid form';
    nlPortuguese:
      Result := 'Formul�rio inv�lido';
    nlFrench:
      Result := 'Forme non valide';
    nlSpanish:
      Result := 'Forma invalida';
    nlItalian:
      Result := 'Modulo non valido';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

// 'Form not specifield'
function TText.getTextInvalidPhone: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid phone';
    nlPortuguese:
      Result := 'Telefone inv�lido';
    nlFrench:
      Result := 'T�l�phone invalide';
    nlSpanish:
      Result := 'Tel�fono inv�lido';
    nlItalian:
      Result := 'Telefono non valido';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextInvalidUserCode: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid user code';
    nlPortuguese:
      Result := 'C�digo do usu�rio inv�lido';
    nlFrench:
      Result := 'Code utilisateur invalide';
    nlSpanish:
      Result := 'C�digo de usuario no v�lido';
    nlItalian:
      Result := 'Codice utente non valido';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextInvalidWordCode: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Invalid word code';
    nlPortuguese:
      Result := 'C�digo da palavra inv�lido';
    nlFrench:
      Result := 'Code de mot invalide';
    nlSpanish:
      Result := 'C�digo de palabra no v�lido';
    nlItalian:
      Result := 'Codice parola non valido';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextPlayAgain: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Do you wanna play again?';
    nlPortuguese:
      Result := 'Voc� quer jogar de novo?';
    nlFrench:
      Result := 'Voulez-vous rejouer?';
    nlSpanish:
      Result := '�Quieres jugar de nuevo?';
    nlItalian:
      Result := 'Vuoi giocare di nuovo?';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextLetsContinue: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Let''s continue?';
    nlPortuguese:
      Result := 'Vamos continuar?';
    nlFrench:
      Result := 'Nous allons continuer?';
    nlSpanish:
      Result := '�Vamos a seguir?';
    nlItalian:
      Result := 'Continuiamo?';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextNo: string;
begin
  case FNativeLanguage of
    nlEnglish, nlSpanish, nlItalian:
      Result := 'No';
    nlPortuguese:
      Result := 'N�o';
    nlFrench:
      Result := 'Non';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextYes: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Yes';
    nlPortuguese:
      Result := 'Sim';
    nlFrench:
      Result := 'Oui';
    nlSpanish:
      Result := 'S�';
    nlItalian:
      Result := 'S�';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextYouGotPointsTryAgain: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'You got %d points.' + sLineBreak + 'Try again!';
    nlPortuguese:
      Result := 'Voc� conseguiu %d pontos.' + sLineBreak + 'Tente novamente!';
    nlFrench:
      Result := 'Vous avez %d�points.' + sLineBreak + 'R�essayer!';
    nlSpanish:
      Result := 'Obtuviste %d puntos.' + sLineBreak + '�Intentar otra vez!';
    nlItalian:
      Result := 'Hai %d punti.' + sLineBreak + 'Riprova!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextCongratulations: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Congratulations!';
    nlPortuguese:
      Result := 'Parab�ns!';
    nlFrench:
      Result := 'F�licitations!';
    nlSpanish:
      Result := '�Enhorabuena!';
    nlItalian:
      Result := 'Congratulazioni!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextContinueAnotherLanguage: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'Let''s continue with another language?';
    nlPortuguese:
      Result := 'Vamos continuar com outro idioma?';
    nlFrench:
      Result := 'Allons-nous continuer avec une autre langue?';
    nlSpanish:
      Result := '�Seguimos con otro idioma?';
    nlItalian:
      Result := 'Continuiamo con un''altra lingua?';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextYouCompleteAllWords: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'You completed all the words!';
    nlPortuguese:
      Result := 'Voc� completou todas as palavras!';
    nlFrench:
      Result := 'Vous avez compl�t� tous les mots�!';
    nlSpanish:
      Result := '�Has completado todas las palabras!';
    nlItalian:
      Result := 'Hai completato tutte le parole!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextYouCompleteThisLanguage: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'You completed this language!';
    nlPortuguese:
      Result := 'Voc� completou este idioma!';
    nlFrench:
      Result := 'Vous avez termin� cette langue!';
    nlSpanish:
      Result := 'Has completado este idioma!';
    nlItalian:
      Result := 'Hai completato questa lingua!';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

function TText.getTextYouGotPoints: string;
begin
  case FNativeLanguage of
    nlEnglish:
      Result := 'You got %d points';
    nlPortuguese:
      Result := 'Voc� conseguiu %d pontos';
    nlFrench:
      Result := 'Vous avez %d�points';
    nlSpanish:
      Result := 'Obtuviste %d puntos';
    nlItalian:
      Result := 'Hai %d punti';
  else
    raise Exception.Create
      ('Sorry, something went wrong. Error: Unknown Language');
  end;
end;

{
  case FNativeLanguage of
  nlEnglish:
  Result := '';
  nlPortuguese:
  Result := '';
  nlFrench:
  Result := '';
  nlSpanish:
  Result := '';
  nlItalian:
  Result := '';
  else
  raise Exception.Create('Sorry, something went wrong. Error: Unknown Language');
  end;
}
end.
