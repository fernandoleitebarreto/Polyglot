object dm: Tdm
  Encoding = esASCII
  QueuedRequest = False
  Height = 598
  Width = 366
  object DWEvents: TRESTDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'hora'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventshoraReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'Configuracao'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsConfiguracaoReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
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
            ParamName = 'senha'
            Encoded = False
          end>
        DataMode = dmRAW
        EventName = 'ValidaLogin'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsValidaLoginReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
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
        DataMode = dmRAW
        EventName = 'CriarConta'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsCriarContaReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'ListarCategoria'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsListarCategoriaReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'codusuario'
            Encoded = False
          end>
        DataMode = dmRAW
        EventName = 'ListarRanking'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsListarRankingReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovInteger
            ParamName = 'category'
            Encoded = True
          end>
        DataMode = dmRAW
        EventName = 'CarregaDados'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsCarregaDadosReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
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
        DataMode = dmRAW
        EventName = 'Search'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSearchReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = False
          end>
        DataMode = dmRAW
        EventName = 'SendEmailRecoverPassword'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSendEmailRecoverPasswordReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = True
          end>
        DataMode = dmRAW
        EventName = 'SendEmailCreateAccount'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSendEmailCreateAccountReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'telefone'
            Encoded = False
          end>
        DataMode = dmRAW
        EventName = 'SendSMSRecoverPassword'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSendSMSRecoverPasswordReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'telefone'
            Encoded = False
          end>
        DataMode = dmRAW
        EventName = 'SendSMSCreateAccount'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSendSMSCreateAccountReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
          end
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
        DataMode = dmRAW
        EventName = 'VerifyCode'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsVerifyCodeReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
          item
            TypeObject = toParam
            ObjectDirection = odINOUT
            ObjectValue = ovString
            ParamName = 'native_language'
            Encoded = True
          end
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
        DataMode = dmRAW
        EventName = 'SaveNewPassword'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsSaveNewPasswordReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'AddWord'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsAddWordReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'AddAudio'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsAddAudioReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'WordsWithNoAudio'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsWordsWithNoAudioReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'MeaningProximo'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsMeaningProximoReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'SetNativeLanguage'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsSetNativeLanguageReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'GetNativeLanguage'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsGetNativeLanguageReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'LoginFacebook'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsLoginFacebookReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'RandomDados'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsRandomDadosReplyEventByType
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <
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
        DataMode = dmRAW
        EventName = 'UpdateUser'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsUpdateUserReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'DeleteAccount'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventsDeleteAccountReplyEvent
      end
      item
        Routes.All.Active = True
        Routes.All.NeedAuthorization = False
        Routes.Get.Active = False
        Routes.Get.NeedAuthorization = False
        Routes.Post.Active = False
        Routes.Post.NeedAuthorization = False
        Routes.Put.Active = False
        Routes.Put.NeedAuthorization = False
        Routes.Patch.Active = False
        Routes.Patch.NeedAuthorization = False
        Routes.Delete.Active = False
        Routes.Delete.NeedAuthorization = False
        Routes.Option.Active = False
        Routes.Option.NeedAuthorization = False
        Params = <>
        DataMode = dmRAW
        EventName = 'ListarParametro'
        BaseURL = '/'
        DefaultContentType = 'application/json'
        CallbackEvent = False
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEventsEventsListarParametroReplyEventByType
      end>
    Left = 48
    Top = 96
  end
  object conn: TFDConnection
    Params.Strings = (
      'Protocol=TCPIP'
      
        'Database=D:\Sistemas\Delphi\Apps\Polyglot\Fontes\Servidor\DB\POL' +
        'YGLOT.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=192.168.15.8'
      'Port=3050'
      'OSAuthent=No'
      'MonitorBy=Remote'
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
    Connection = conn
    Left = 224
    Top = 24
  end
  object RESTServicePooler: TRESTDWIdServicePooler
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
    ProxyOptions.ProxyPort = 8888
    Encoding = esUtf8
    RootPath = '/'
    ForceWelcomeAccess = False
    CriptOptions.Use = False
    CriptOptions.Key = 'RDWBASEKEY256'
    EncodeErrors = False
    ServerIPVersionConfig.IPv4Address = '0.0.0.0'
    ServerIPVersionConfig.IPv6Address = '::'
    SSLVerifyMode = []
    SSLVerifyDepth = 0
    SSLMode = sslmUnassigned
    SSLMethod = sslvSSLv2
    SSLVersions = []
    Left = 136
    Top = 96
  end
end
