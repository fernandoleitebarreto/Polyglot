object dm: Tdm
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 514
  Width = 773
  object RequestListarCategoria: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'ID_USUARIO'
        Value = '1'
      end
      item
        Name = 'NATIVE_LANGUAGE'
        Value = 'ENG'
      end>
    Resource = 'ListarCategoria'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 137
    Top = 300
  end
  object RequestOpcional: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'usuario'
        Value = 'HEBER'
      end>
    Resource = 'ListarOpcional'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 136
    Top = 448
  end
  object qry_config: TFDQuery
    Left = 16
    Top = 8
  end
  object RequestLogin: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
        Value = 'teste@teste.com.br'
      end
      item
        Name = 'senha'
        Value = '123'
      end>
    Resource = 'ValidaLogin'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 137
    Top = 252
  end
  object RESTClient: TRESTClient
    Authenticator = HTTPBasicAuthenticator
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://127.0.0.1:8082'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    RaiseExceptionOn500 = False
    ConnectTimeout = 10000
    SynchronizedEvents = False
    Left = 528
    Top = 8
  end
  object HTTPBasicAuthenticator: THTTPBasicAuthenticator
    Username = 'admin'
    Password = 'admin'
    Left = 312
    Top = 8
  end
  object RequestDados: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end
      item
        Name = 'senha'
      end>
    Resource = 'CarregaDados'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 480
    Top = 241
  end
  object RequestConta: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'email'
        Value = 'teste@teste.com.br'
      end
      item
        Name = 'senha'
        Value = '123'
      end>
    Resource = 'CriarConta'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 136
    Top = 201
  end
  object RequestSearch: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Resource = 'Search'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 136
    Top = 153
  end
  object RequestSendEmailRecoverPassword: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end>
    Resource = 'SendEmailRecoverPassword'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 305
    Top = 148
  end
  object RequestVerifyCode: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'num1'
      end
      item
        Name = 'num2'
      end
      item
        Name = 'num3'
      end
      item
        Name = 'num4'
      end>
    Resource = 'VerifyCode'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 305
    Top = 292
  end
  object RequestSaveNewPassword: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end
      item
        Name = 'newpassword'
      end
      item
        Name = 'confirmpassword'
      end>
    Resource = 'SaveNewPassword'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 305
    Top = 340
  end
  object RequestAddWord: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Resource = 'AddWord'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 481
    Top = 148
  end
  object RequestSendSMSRecoverPassword: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'telefone'
      end>
    Resource = 'SendSMSRecoverPassword'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 305
    Top = 244
  end
  object RequestAddAudio: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Resource = 'AddAudio'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 482
    Top = 192
  end
  object RequestWordsWithoutAudio: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end
      item
        Name = 'senha'
      end>
    Resource = 'WordsWithNoAudio'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 480
    Top = 289
  end
  object RequestMeaningProximo: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'id_word'
      end
      item
        Name = 'cod_usuario'
      end>
    Resource = 'MeaningProximo'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 480
    Top = 337
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout]
    Client = RESTLocation
    Method = rmPOST
    Params = <
      item
        Name = 'usuario'
        Value = 'Teste'
      end>
    Resource = 'ListarCategoria'
    Response = RESTResponse
    ConnectTimeout = 10000
    SynchronizedEvents = False
    Left = 137
    Top = 100
  end
  object RESTLocation: TRESTClient
    Authenticator = HTTPLocation
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://api.geonames.org/countryCodeJSON'
    Params = <>
    RaiseExceptionOn500 = False
    ConnectTimeout = 10000
    SynchronizedEvents = False
    Left = 440
    Top = 8
  end
  object HTTPLocation: THTTPBasicAuthenticator
    Username = '123456'
    Password = 'fernandoleite'
    Left = 192
    Top = 8
  end
  object RequestSetNativeLanguage: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'cod_usuario'
      end
      item
        Name = 'native_language'
      end>
    Resource = 'SetNativeLanguage'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 304
    Top = 393
  end
  object RequestGetNativeLanguage: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'cod_usuario'
      end>
    Resource = 'GetNativeLanguage'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 136
    Top = 345
  end
  object RequestFacebook: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'email'
        Value = 'teste@teste.com.br'
      end
      item
        Name = 'senha'
        Value = '123'
      end>
    Resource = 'LoginFacebook'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 136
    Top = 393
  end
  object RequestRandomDados: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end
      item
        Name = 'senha'
      end>
    Resource = 'RandomDados'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 304
    Top = 449
  end
  object RequestUptUser: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'code'
      end
      item
        Name = 'name'
      end
      item
        Name = 'email'
      end
      item
        Name = 'phone'
      end>
    Resource = 'UpdateUser'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 480
    Top = 401
  end
  object RESTResponse: TRESTResponse
    Left = 112
    Top = 8
  end
  object RequestListarRanking: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <
      item
        Name = 'usuario'
        Value = 'Teste'
      end>
    Resource = 'ListarRanking'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 481
    Top = 452
  end
  object RESTRequestParam: TRESTRequest
    AssignedValues = [rvConnectTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Resource = 'Configuracao'
    Response = RESTResponse
    ConnectTimeout = 10000
    SynchronizedEvents = False
    Left = 480
    Top = 104
  end
  object RequestSendEmailCreateAccount: TRESTRequest
    AssignedValues = [rvConnectTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end>
    Resource = 'SendEmailCreateAccount'
    Response = RESTResponse
    ConnectTimeout = 10000
    SynchronizedEvents = False
    Left = 305
    Top = 108
  end
  object RequestSendSMSCreateAccount: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'telefone'
      end>
    Resource = 'SendSMSCreateAccount'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 305
    Top = 196
  end
  object RequestDeleteAccount: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
      end
      item
        Name = 'newpassword'
      end
      item
        Name = 'confirmpassword'
      end>
    Resource = 'DeleteAccount'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 617
    Top = 105
  end
  object RequestParametro: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Resource = 'ListarParametro'
    Response = RESTResponse
    ConnectTimeout = 10000
    ReadTimeout = 10000
    SynchronizedEvents = False
    Left = 617
    Top = 161
  end
end
