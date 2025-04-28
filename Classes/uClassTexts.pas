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
      Result := 'Inglês';
    nlFrench:
      Result := 'Anglais';
    nlSpanish:
      Result := 'Inglés';
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
      Result := 'Português';
    nlFrench:
      Result := 'Portugais';
    nlSpanish:
      Result := 'Portugués';
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
      Result := 'Política de Privacidade';
    nlFrench:
      Result := 'Politique de confidentialité';
    nlSpanish:
      Result := 'Política de privacidad';
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
      Result := 'Francês';
    nlFrench:
      Result := 'Français';
    nlSpanish:
      Result := 'Francés';
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
      Result := 'Español';
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
      Result := 'Accéder à votre compte';
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
      Result := 'Créer un compte';
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
      Result := 'Mot de passe oublié ?';
    nlSpanish:
      Result := '¿Has olvidado la contraseña?';
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
      Result := 'Contraseña';
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
      Result := 'Numéro de tél';
    nlSpanish:
      Result := 'Número de móvil';
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
      Result := 'Cambiar la contraseña';
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
      Result := 'Editar Usuário';
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
      Result := 'Correo electrónico';
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
      Result := 'Parabéns, sua conta foi ativada. Faça o login e aproveite!';
    nlFrench:
      Result := 'Félicitations, votre compte a été activé. Veuillez vous connecter et profiter!';
    nlSpanish:
      Result := '¡Felicidades, su cuenta ha sido activada. Por favor, inicie sesión y disfrute!';
    nlItalian:
      Result := 'Congratulazioni, il tuo account è stato attivato. Effettua l''accesso e goditi!';
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
      Result := 'Já tem uma conta?';
    nlFrench:
      Result := 'Vous avez déjà un compte ?';
    nlSpanish:
      Result := '¿Ya tienes una cuenta?';
    nlItalian:
      Result := 'Hai già un account?';
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
      Result := 'Erreur lors de la création du compte';
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
      Result := 'Email não encontrado';
    nlFrench:
      Result := 'Email non trouvé';
    nlSpanish:
      Result := 'El correo electrónico no encontrado';
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
      Result := 'Error al iniciar sesión con Facebook';
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
      Result := 'Erreur lors de la vérification de l''e-mail pour récupérer le mot de passe';
    nlSpanish:
      Result := 'Error al verificar el correo electrónico para recuperar la contraseña';
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
      Result := 'Erreur lors de la vérification du SMS pour récupérer le mot de passe';
    nlSpanish:
      Result := 'Error al verificar SMS para recuperar contraseña';
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
      Result := 'Error al guardar la nueva contraseña';
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
      Result := 'Erro ao atualizar usuário';
    nlFrench:
      Result := 'Erreur lors de la mise à jour de l''utilisateur';
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
      Result := 'Error al validar el inicio de sesión';
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
      Result := 'Email ou senha inválida';
    nlFrench:
      Result := 'Email ou mot de passe invalide';
    nlSpanish:
      Result := 'Correo electrónico o contraseña no válidos';
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
      Result := 'Senha inválida';
    nlFrench:
      Result := 'Mot de passe incorrect';
    nlSpanish:
      Result := 'Contraseña invalida';
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
      Result := 'Récupérer mot de passe';
    nlSpanish:
      Result := 'Recuperar contraseña';
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
      Result := 'Cambiar la contraseña';
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
      Result := 'Salvar Usuário';
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
      Result := 'Cambiar la contraseña';
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
      Result := 'Informe o código para ativar sua conta';
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
      Result := 'Informe o código para recuperar sua senha';
    nlFrench:
      Result := 'Entrez le code pour récupérer votre mot de passe';
    nlSpanish:
      Result := 'Ingrese el código para recuperar su contraseña';
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
      Result := 'Seu código de verificação foi enviado por email';
    nlFrench:
      Result := 'Votre code de vérification a été envoyé par e-mail';
    nlSpanish:
      Result := 'Su código de verificación ha sido enviado por correo electrónico';
    nlItalian:
      Result := 'Il tuo codice di verifica è stato inviato via email';
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
      Result := 'Seu código de verificação foi enviado por SMS para %s';
    nlFrench:
      Result := 'Votre code de vérification a été envoyé par SMS au %s';
    nlSpanish:
      Result := 'Su código de verificación ha sido enviado por SMS al %s';
    nlItalian:
      Result := 'Il tuo codice di verifica è stato inviato via SMS al %s';
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
      Result := 'Créer un nouveau mot de passe';
    nlSpanish:
      Result := 'Crear nueva contraseña';
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
      Result := 'Nueva contraseña';
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
      Result := 'Compléter les mots';
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
      Result := 'Sélectionnez les mots';
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
      Result := 'Configurações';
    nlFrench:
      Result := 'Paramètres';
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
      Result := 'Olá';
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
      Result := 'Cómo puedo decir';
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
      Result := 'Thème';
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
      Result := 'A palavra é:';
    nlFrench:
      Result := 'Le mot est:';
    nlSpanish:
      Result := 'La palabra es:';
    nlItalian:
      Result := 'La parola è:';
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
      Result := 'Para revisar las palabras, haga clic aquí';
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
      Result := 'Confirma la contraseña';
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
      Result := 'Informe la nueva contraseña';
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
      Result := 'Proporcione la contraseña actual';
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
      Result := 'El correo electrónico está vacío';
    nlItalian:
      Result := 'L''email è vuota';
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
      Result := 'La contraseña está vacía';
    nlItalian:
      Result := 'La password è vuota';
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
      Result := 'Informer sur le téléphone';
    nlSpanish:
      Result := 'Informar al teléfono';
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
      Result := 'Selecione sua língua nativa';
    nlFrench:
      Result := 'Sélectionnez votre langue maternelle';
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
      Result := 'Catégorie';
    nlSpanish:
      Result := 'Categoría';
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
      Result := 'Écrivez ici...';
    nlSpanish:
      Result := 'Escriba aquí...';
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
      Result := 'Próximo';
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
      Result := 'Débutant';
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
          slResult.Add('Olá,');
          slResult.Add('');
          slResult.Add
            ('Gostaríamos de informar que sua conta foi ativada com sucesso!');
          slResult.Add
            ('Agora você pode aproveitar todas as funcionalidades e recursos disponíveis em nosso aplicativo.');
          slResult.Add('');
          slResult.Add
            ('Agradecemos por escolher o Polyglot e esperamos que você tenha uma excelente experiência conosco.');
          slResult.Add('');
          slResult.Add
            ('Se você tiver alguma dúvida ou precisar de ajuda, não hesite em entrar em contato conosco.');
          slResult.Add('Estamos sempre à disposição para ajudá-lo.');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');
        end;
      nlFrench:
        begin
          slResult.Add('Bonjour,');
          slResult.Add('');
          slResult.Add
            ('Nous souhaitons vous informer que votre compte a été activé avec succès !');
          slResult.Add
            ('Vous pouvez maintenant profiter de toutes les fonctionnalités et ressources disponibles dans notre application.');
          slResult.Add('');
          slResult.Add
            ('Nous vous remercions d’avoir choisi Polyglot et espérons que vous aurez une excellente expérience avec nous.');
          slResult.Add('');
          slResult.Add
            ('Si vous avez des questions ou besoin d’aide, n’hésitez pas à nous contacter.');
          slResult.Add('Nous sommes toujours disponibles pour vous aider.');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('L’équipe Polyglot');

        end;
      nlSpanish:
        begin
          slResult.Add('¡Hola,!');
          slResult.Add('');
          slResult.Add
            ('¡Nos gustaría informarle que su cuenta ha sido activada con éxito!');
          slResult.Add
            ('Ahora puede aprovechar todas las características y recursos disponibles en nuestra aplicación.');
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
            ('Desideriamo informarti che il tuo account è stato attivato con successo!');
          slResult.Add
            ('Ora puoi usufruire di tutte le funzionalità e le risorse disponibili nella nostra applicazione.');
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
            ('É com grande satisfação que lhe damos as boas-vindas ao Polyglot!');
          slResult.Add
            ('Nós da equipe estamos empolgados em ajudá-lo(a) a aprender e aprimorar suas habilidades em uma nova língua.');
          slResult.Add
            ('Nosso aplicativo foi projetado para ser fácil de usar e personalizado para suas necessidades de aprendizado.');
          slResult.Add
            ('Com o Polyglot, você terá acesso a uma ampla variedade de recursos de aprendizado, como lições interativas, exercícios de memorarização de vocabulário e frases, áudios, além de outros recursos incríveis.');
          slResult.Add
            ('Para ativar seu cadastro, informe o código abaixo no seu aplicativo para validarmos seu usuário.');
          slResult.Add('');
          slResult.Add('Código de Ativação: %s');
          slResult.Add('');
          slResult.Add
            ('Não hesite em nos contatar se tiver alguma dúvida ou precisar de ajuda. Estamos aqui para ajudá-lo(a) em cada passo da sua jornada de aprendizado.');
          slResult.Add('Obrigado(a) por se juntar à nossa comunidade!');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');
        end;

      nlFrench:
        begin
          slResult.Clear;
          slResult.Add('Cher/Chère,');
          slResult.Add('Nous sommes ravis de vous accueillir sur Polyglot !');
          slResult.Add
            ('Notre équipe est ravie de vous aider à apprendre et à améliorer vos compétences dans une nouvelle langue.');
          slResult.Add
            ('Notre application a été conçue pour être conviviale et personnalisée à vos besoins d''apprentissage.');
          slResult.Add
            ('Avec Polyglot, vous aurez accès à une large gamme de ressources d''apprentissage, telles que des leçons interactives, des exercices de mémorisation de vocabulaire et de phrases, des audios et d''autres fonctionnalités incroyables.');
          slResult.Add
            ('Pour activer votre compte, veuillez saisir le code ci-dessous dans votre application pour valider votre utilisateur.');
          slResult.Add('');
          slResult.Add('Code d''Activation : %s');
          slResult.Add('');
          slResult.Add
            ('N''hésitez pas à nous contacter si vous avez des questions ou si vous avez besoin d''aide. Nous sommes là pour vous aider à chaque étape de votre parcours d''apprentissage.');
          slResult.Add('Merci d''avoir rejoint notre communauté !');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('L''équipe Polyglot');
        end;

      nlSpanish:
        begin
          slResult.Add('¡Estimado/a!,');
          slResult.Add
            ('¡Estamos encantados de darte la bienvenida a Polyglot!');
          slResult.Add
            ('Nuestro equipo está emocionado de ayudarte a aprender y mejorar tus habilidades en un nuevo idioma.');
          slResult.Add
            ('Nuestra aplicación ha sido diseñada para ser fácil de usar y personalizada a tus necesidades de aprendizaje.');
          slResult.Add
            ('Con Polyglot, tendrás acceso a una amplia variedad de recursos de aprendizaje, como lecciones interactivas, ejercicios de memorización de vocabulario y frases, audios y otras increíbles funciones.');
          slResult.Add
            ('Para activar tu cuenta, por favor ingresa el siguiente código en tu aplicación para validar tu usuario.');
          slResult.Add('');
          slResult.Add('Código de Activación: %s');
          slResult.Add('');
          slResult.Add
            ('Por favor, no dudes en contactarnos si tienes alguna pregunta o necesitas ayuda. Estamos aquí para ayudarte en cada paso de tu viaje de aprendizaje.');
          slResult.Add('¡Gracias por unirte a nuestra comunidad!');
          slResult.Add('');
          slResult.Add('Atentamente,');
          slResult.Add('Equipo Polyglot');
        end;

      nlItalian:
        begin
          slResult.Add('Gentile,');
          slResult.Add
            ('È con grande piacere che vi diamo il benvenuto su Polyglot!');
          slResult.Add
            ('Noi del team siamo entusiasti di aiutarti a imparare e migliorare le tue abilità in una nuova lingua.');
          slResult.Add
            ('La nostra app è stata progettata per essere facile da usare e personalizzata per le tue esigenze di apprendimento.');
          slResult.Add
            ('Con Polyglot, avrai accesso a una vasta gamma di risorse didattiche, come lezioni interattive, esercizi di memorizzazione di vocaboli e frasi, audio e altre incredibili risorse.');
          slResult.Add
            ('Per attivare il tuo account, inserisci il codice qui sotto nell''applicazione per validare il tuo utente.');
          slResult.Add('');
          slResult.Add('Codice di Attivazione: %s');
          slResult.Add('');
          slResult.Add
            ('Non esitare a contattarci se hai domande o hai bisogno di aiuto. Siamo qui per aiutarti in ogni passo del tuo percorso di apprendimento.');
          slResult.Add('Grazie per unirti alla nostra comunità!');
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
            ('Gostaríamos de informar que a sua senha foi alterada com sucesso.');
          slResult.Add
            ('Lembramos que, como medida de segurança, é importante que você mantenha sua senha em sigilo e não a compartilhe com terceiros.');
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
            ('Nous souhaitons vous informer que votre mot de passe a été modifié avec succès.');
          slResult.Add
            ('Comme mesure de sécurité, il est important de garder votre mot de passe confidentiel et de ne pas le partager avec des tiers.');
          slResult.Add
            ('Si vous soupçonnez une activité suspecte sur votre compte, veuillez contacter immédiatement notre support.');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('Équipe Polyglot');
        end;
      nlSpanish:
        begin
          slResult.Add('Estimado(a),');
          slResult.Add('');
          slResult.Add
            ('Nos gustaría informarle que su contraseña ha sido cambiada exitosamente.');
          slResult.Add
            ('Como medida de seguridad, es importante que mantenga su contraseña confidencial y no la comparta con terceros.');
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
            ('Desideriamo informarla che la sua password è stata cambiata con successo.');
          slResult.Add
            ('Come misura di sicurezza, è importante mantenere la password confidenziale e non condividerla con terze parti.');
          slResult.Add
            ('Se sospetta qualsiasi attività sospetta sul suo account, si prega di contattare immediatamente il nostro supporto.');
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
            ('Recebemos uma solicitação para recuperar sua senha da sua conta Polyglot.');
          slResult.Add
            ('Para ajudá-lo(a) a redefinir sua senha, enviamos um código de recuperação.');
          slResult.Add
            ('Por favor, utilize o código abaixo para criar uma nova senha:');
          slResult.Add('');
          slResult.Add('Código de Recuperação: %s');
          slResult.Add('');
          slResult.Add
            ('Se você não solicitou a recuperação da senha, por favor, entre em contato conosco imediatamente para que possamos tomar as medidas necessárias para proteger sua conta.');
          slResult.Add('');
          slResult.Add('Atenciosamente,');
          slResult.Add('Equipe Polyglot');
        end;
      nlFrench:
        begin
          slResult.Add('Cher(ère),');
          slResult.Add('');
          slResult.Add
            ('Nous avons reçu une demande de récupération de votre mot de passe pour votre compte Polyglot.');
          slResult.Add
            ('Pour vous aider à réinitialiser votre mot de passe, nous avons envoyé un code de récupération.');
          slResult.Add
            ('Veuillez utiliser le code ci-dessous pour créer un nouveau mot de passe:');
          slResult.Add('');
          slResult.Add('Code de récupération: %s');
          slResult.Add('');
          slResult.Add
            ('Si vous n''avez pas demandé de récupération de mot de passe, veuillez nous contacter immédiatement afin que nous puissions prendre les mesures nécessaires pour protéger votre compte.');
          slResult.Add('');
          slResult.Add('Cordialement,');
          slResult.Add('L''équipe Polyglot');
        end;
      nlSpanish:
        begin
          slResult.Add('Estimado/a,');
          slResult.Add('');
          slResult.Add
            ('Hemos recibido una solicitud para recuperar su contraseña de su cuenta de Polyglot.');
          slResult.Add
            ('Para ayudarlo(a) a restablecer su contraseña, hemos enviado un código de recuperación.');
          slResult.Add
            ('Por favor, utilice el código a continuación para crear una nueva contraseña:');
          slResult.Add('');
          slResult.Add('Código de recuperación: %s');
          slResult.Add('');
          slResult.Add
            ('Si no solicitó la recuperación de la contraseña, por favor contáctenos de inmediato para que podamos tomar las medidas necesarias para proteger su cuenta.');
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
      Result := 'Intermediário';
    nlFrench:
      Result := 'Intermédiaire';
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
      Result := 'Avançado';
    nlFrench:
      Result := 'Avancé';
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
      Result := 'Nova versão disponível';
    nlFrench:
      Result := 'Nouvelle version disponible';
    nlItalian:
      Result := 'Nuova versione disponibile';
    nlSpanish:
      Result := 'Nueva versión disponible';
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
      Result := 'Senha alterada com sucesso. Faça o login novamente';
    nlFrench:
      Result := 'Le mot de passe a été changé avec succès. Reconnectez-vous';
    nlSpanish:
      Result := 'Contraseña alterada con éxito. Ingresar de nuevo';
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
      Result := 'Clique no botão abaixo para receber a nova atualização para seu aplicativo.';
    nlFrench:
      Result := 'Cliquez sur le bouton ci-dessous pour recevoir la nouvelle mise à jour de votre application.';
    nlItalian:
      Result := 'Fai clic sul pulsante qui sotto per ricevere il nuovo aggiornamento per la tua app.';
    nlSpanish:
      Result := 'Haz clic en el botón de abajo para recibir la nueva actualización de tu aplicación.';
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
      Result := 'Complétez les mots';
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
      Result := 'Pratique sua memória';
    nlFrench:
      Result := 'Pratiquez votre mémoire';
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
      Result := 'Sélectionner des mots';
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
      Result := 'Déconnexion';
    nlSpanish:
      Result := 'Cerrar sesión';
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
      Result := 'Añadir palabras';
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
      Result := 'Verificar código';
    nlFrench:
      Result := 'Vérifier le code';
    nlSpanish:
      Result := 'Verificar código';
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
      Result := 'Versão';
    nlItalian:
      Result := 'Versione';
    nlSpanish:
      Result := 'Versión';
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
      Result := 'Développé par';
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
      Result := 'Les mots de passe fournis doivent être identiques';
    nlSpanish:
      Result := 'Las contraseñas proporcionadas deben ser iguales';
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
      Result := 'Le nouveau mot de passe doit être différent de l''actuel';
    nlSpanish:
      Result := 'La nueva contraseña debe ser diferente de la actual';
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
      Result := 'Termos e Condições';
    nlFrench:
      Result := 'Termes et Conditions';
    nlSpanish:
      Result := 'Términos y Condiciones';
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
      Result := 'Haga clic aquí y grabe su voz';
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
      Result := 'Précédent';
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
      Result := 'Clique aqui para saber a tradução';
    nlFrench:
      Result := 'Cliquez ici pour connaître la traduction';
    nlSpanish:
      Result := 'Click aquí para conocer la traducción';
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
      Result := 'Essayer à Nouveau';
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
      Result := 'Arrêter';
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
      Result := 'Digite seu e-mail que enviaremos instruções para redefinir sua senha';
    nlFrench:
      Result := 'Entrez votre adresse e-mail et nous vous enverrons des instructions pour réinitialiser votre mot de passe';
    nlSpanish:
      Result := 'Introduce tu correo electrónico y te enviaremos instrucciones para restablecer tu contraseña';
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
      Result := 'Parabéns, sua conta foi ativada!';
    nlFrench:
      Result := 'Félicitations, votre compte a été activé!';
    nlSpanish:
      Result := '¡Felicidades, su cuenta ha sido activada!';
    nlItalian:
      Result := 'Congratulazioni, il tuo account è stato attivato!';
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
      Result := 'Votre mot de passe a été modifié avec succès!';
    nlSpanish:
      Result := '¡Su contraseña ha sido cambiada con éxito!';
    nlItalian:
      Result := 'La tua password è stata cambiata con successo!';
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
      Result := 'Récupérer mot de passe';
    nlSpanish:
      Result := 'Recuperar contraseña';
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
      Result := 'Clique novamente para parar a gravação';
    nlFrench:
      Result := 'Cliquez à nouveau pour arrêter l''enregistrement';
    nlSpanish:
      Result := 'Haga clic de nuevo para detener la grabación';
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
      Result := 'Não existem palavras para gravar :)';
    nlFrench:
      Result := 'Il n''y a pas de mots à enregistrer';
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
      Result := 'Contraseña actual';
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
      Result := 'Aparentemente o servidor está offline no momento. Tente novamente mais tarde';
    nlFrench:
      Result := 'Apparemment, le serveur est actuellement hors ligne. Réessayez plus tard';
    nlSpanish:
      Result := 'Aparentemente, el servidor está actualmente fuera de línea. Vuelva a intentarlo más tarde';
    nlItalian:
      Result := 'A quanto pare il server è attualmente offline. Riprovare più tardi';
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
      Result := 'À propos de l''application';
    nlSpanish:
      Result := 'Acerca de la aplicación';
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
      Result := 'Não aceitar';
    nlFrench:
      Result := 'Déclin';
    nlSpanish:
      Result := 'Disminución';
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
      Result := 'Reenviar Código';
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
      Result := 'Opção não disponível, faça o login para liberar o acesso';
    nlSpanish:
      Result := 'Opción no disponible, inicie sesión para liberar el acceso';
    nlFrench:
      Result := 'Option non disponible, veuillez vous connecter pour libérer l''accès';
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
      Result := 'Revisão';
    nlFrench:
      Result := 'Révision';
    nlSpanish:
      Result := 'Revisión';
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
      Result := 'Últimas palavras dessa rodada';
    nlFrench:
      Result := 'Derniers mots de ce tour';
    nlSpanish:
      Result := 'Últimas palabras de esta ronda';
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
      Result := 'Jogo da memória';
    nlFrench:
      Result := 'Jeux de mémoire';
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
      Result := 'Deslize as palavras até em cima da respectiva tradução';
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
      Result := 'Algo aconteceu :/ !Categoria não encontrada. Tente novamente!';
    nlFrench:
      Result := 'Quelque chose s''est mal passé :/. Catégorie introuvable. S''il vous plaît, réessayez !';
    nlSpanish:
      Result := 'Algo malo paso :/. Categoría no encontrada. ¡Inténtelo de nuevo!';
    nlItalian:
      Result := 'È successo qualcosa di sbagliato :/. Categoria non trovata. Per favore, riprova!';
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
      Result := 'Desculpe, algo deu errado. Erro: A ação solicitada não foi reconhecida como uma redefinição de senha válida.';
    nlFrench:
      Result := 'Désolé, quelque chose s''est mal passé. Erreur: L''action demandée n''a pas été reconnue comme une réinitialisation de mot de passe valide.';
    nlSpanish:
      Result := 'Lo siento, algo salió mal. Error: La acción solicitada no fue reconocida como un restablecimiento de contraseña válido.';
    nlItalian:
      Result := 'Spiacente, qualcosa è andato storto. Errore: L''azione richiesta non è stata riconosciuta come una reimpostazione della password valida.';
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
      Result := 'O código de verificação que você inseriu está incorreto. Por favor, verifique novamente e insira os 4 dígitos corretos';
    nlFrench:
      Result := 'Le code de vérification que vous avez saisi est incorrect. Veuillez vérifier à nouveau et entrer les 4 chiffres corrects';
    nlSpanish:
      Result := 'El código de verificación que ingresaste es incorrecto. Por favor, verifica nuevamente e ingresa los 4 dígitos correctos';
    nlItalian:
      Result := 'Il codice di verifica che hai inserito è incorretto. Controlla nuovamente e inserisci i 4 cifre corretti';
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
      Result := 'Algo de errado aconteceu! O código de verificação gerado está incorreto. Por favor, entre em contato com o suporte para obter assistência';
    nlFrench:
      Result := 'Quelque chose s''est mal passé. Le code de vérification généré est incorrect. Veuillez contacter le support pour obtenir de l''aide';
    nlSpanish:
      Result := 'Algo salió mal. El código de verificación generado es incorrecto. Por favor, póngase en contacto con el soporte para obtener ayuda';
    nlItalian:
      Result := 'Qualcosa è andato storto. Il codice di verifica generato è errato. Contatta il supporto per assistenza';
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
      Result := 'O código de verificação inserido está incorreto. Por favor, verifique o código que foi enviado para o seu email/SMS e tente novamente. Caso necessário, você pode solicitar o reenvio do código';
    nlFrench:
      Result := 'Le code de vérification saisi est incorrect. Veuillez réessayer. Si nécessaire, vous pouvez demander à ce que le code soit renvoyé';
    nlSpanish:
      Result := 'El código de verificación ingresado es incorrecto. Por favor, inténtelo de nuevo. Si es necesario, puede solicitar que se reenvíe el código';
    nlItalian:
      Result := 'Il codice di verifica inserito non è corretto. Si prega di riprovare. Se necessario, è possibile richiedere che il codice venga inviato nuovamente';
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
      Result := 'Email inválido';
    nlFrench:
      Result := 'Email invalide';
    nlSpanish:
      Result := 'Email inválido';
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
      Result := 'Este endereço de e-mail já está em uso. Por favor, forneça outro';
    nlFrench:
      Result := 'Cette adresse e-mail existe déjà. Veuillez en fournir une autre';
    nlSpanish:
      Result := 'Este correo electrónico ya está en uso. Por favor, proporcione otro';
    nlItalian:
      Result := 'Questo indirizzo email esiste già. Si prega di fornirne un altro';
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
      Result := 'Formulário inválido';
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
      Result := 'Telefone inválido';
    nlFrench:
      Result := 'Téléphone invalide';
    nlSpanish:
      Result := 'Teléfono inválido';
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
      Result := 'Código do usuário inválido';
    nlFrench:
      Result := 'Code utilisateur invalide';
    nlSpanish:
      Result := 'Código de usuario no válido';
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
      Result := 'Código da palavra inválido';
    nlFrench:
      Result := 'Code de mot invalide';
    nlSpanish:
      Result := 'Código de palabra no válido';
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
      Result := 'Você quer jogar de novo?';
    nlFrench:
      Result := 'Voulez-vous rejouer?';
    nlSpanish:
      Result := '¿Quieres jugar de nuevo?';
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
      Result := '¿Vamos a seguir?';
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
      Result := 'Não';
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
      Result := 'Sí';
    nlItalian:
      Result := 'Sì';
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
      Result := 'Você conseguiu %d pontos.' + sLineBreak + 'Tente novamente!';
    nlFrench:
      Result := 'Vous avez %d points.' + sLineBreak + 'Réessayer!';
    nlSpanish:
      Result := 'Obtuviste %d puntos.' + sLineBreak + '¡Intentar otra vez!';
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
      Result := 'Parabéns!';
    nlFrench:
      Result := 'Félicitations!';
    nlSpanish:
      Result := '¡Enhorabuena!';
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
      Result := '¿Seguimos con otro idioma?';
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
      Result := 'Você completou todas as palavras!';
    nlFrench:
      Result := 'Vous avez complété tous les mots !';
    nlSpanish:
      Result := '¡Has completado todas las palabras!';
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
      Result := 'Você completou este idioma!';
    nlFrench:
      Result := 'Vous avez terminé cette langue!';
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
      Result := 'Você conseguiu %d pontos';
    nlFrench:
      Result := 'Vous avez %d points';
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
