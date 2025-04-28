object dm: Tdm
  OldCreateOrder = False
  Encoding = esASCII
  Height = 598
  Width = 366
  object DWEvents: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'hora'
        EventName = 'hora'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventshoraReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Configuracao'
        EventName = 'Configuracao'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsConfiguracaoReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'ValidaLogin'
        EventName = 'ValidaLogin'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsValidaLoginReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'foto'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'CriarConta'
        EventName = 'CriarConta'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsCriarContaReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListarCategoria'
        EventName = 'ListarCategoria'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsListarCategoriaReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'codusuario'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'ListarRanking'
        EventName = 'ListarRanking'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsListarRankingReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovInteger
            ParamName = 'category'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'CarregaDados'
        EventName = 'CarregaDados'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsCarregaDadosReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'id_categoria'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'termo_busca'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'pagina'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'Search'
        EventName = 'Search'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSearchReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'telefone'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'SendSMSRecoverPassword'
        EventName = 'SendSMSRecoverPassword'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSendSMSRecoverPasswordReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'SendEmailRecoverPassword'
        EventName = 'SendEmailRecoverPassword'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSendEmailRecoverPasswordReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'num1'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'num2'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'num3'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'num4'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'VerifyCode'
        EventName = 'VerifyCode'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsVerifyCodeReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'newpassword'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'confirmpassword'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'SaveNewPassword'
        EventName = 'SaveNewPassword'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSaveNewPasswordReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'AddWord'
        EventName = 'AddWord'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsAddWordReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'AddAudio'
        EventName = 'AddAudio'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsAddAudioReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'WordsWithNoAudio'
        EventName = 'WordsWithNoAudio'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsWordsWithNoAudioReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'MeaningProximo'
        EventName = 'MeaningProximo'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsMeaningProximoReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'SetNativeLanguage'
        EventName = 'SetNativeLanguage'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsSetNativeLanguageReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'GetNativeLanguage'
        EventName = 'GetNativeLanguage'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsGetNativeLanguageReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'LoginFacebook'
        EventName = 'LoginFacebook'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsLoginFacebookReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'RandomDados'
        EventName = 'RandomDados'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsRandomDadosReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovInteger
            ParamName = 'code'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'name'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'phone'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'UpdateUser'
        EventName = 'UpdateUser'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsUpdateUserReplyEvent
      end>
    Left = 48
    Top = 96
  end
  object conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Fernando\Documents\Fernando\Polyglot\POLYGLOT.' +
        'FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 48
    Top = 24
  end
  object QryGeral: TFDQuery
    Connection = conn
    Left = 136
    Top = 24
  end
  object FDTransaction: TFDTransaction
    Left = 224
    Top = 24
  end
  object RESTServicePooler: TRESTServicePooler
    Active = False
    CORS = False
    CORS_CustomHeaders.Strings = (
      'Access-Control-Allow-Origin=*'
      
        'Access-Control-Allow-Methods=GET, POST, PATCH, PUT, DELETE, OPTI' +
        'ONS'
      
        'Access-Control-Allow-Headers=Content-Type, Origin, Accept, Autho' +
        'rization, X-CUSTOM-HEADER')
    PathTraversalRaiseError = True
    RequestTimeout = -1
    ServicePort = 8082
    ProxyOptions.Port = 8888
    AuthenticationOptions.AuthorizationOption = rdwAOBasic
    AuthenticationOptions.OptionParams.AuthDialog = True
    AuthenticationOptions.OptionParams.CustomDialogAuthMessage = 'Protected Space...'
    AuthenticationOptions.OptionParams.Custom404TitleMessage = '(404) The address you are looking for does not exist'
    AuthenticationOptions.OptionParams.Custom404BodyMessage = '404'
    AuthenticationOptions.OptionParams.Custom404FooterMessage = 'Take me back to <a href="./">Home REST Dataware'
    AuthenticationOptions.OptionParams.Username = 'admin'
    AuthenticationOptions.OptionParams.Password = 'admin'
    SSLMethod = sslvSSLv2
    SSLVersions = []
    Encoding = esUtf8
    RootPath = '/'
    SSLVerifyMode = []
    SSLVerifyDepth = 0
    ForceWelcomeAccess = False
    CriptOptions.Use = False
    CriptOptions.Key = 'RDWBASEKEY256'
    MultiCORE = False
    Left = 136
    Top = 96
  end
end
