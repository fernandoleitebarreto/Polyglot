unit uClassSendEmail;

interface

uses
  System.SysUtils, Classes, IdSMTP, IdMessage, IdExplicitTLSClientServerBase,
  IdSSLOpenSSL, FMX.Dialogs, IdText;

type
  TEmail = class(TThread)
  private
    FSMTP: TIdSMTP;
    FMensagem: TIdMessage;
    FSSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
    FError, FHost, FUsername, FPassword, FFromAddress, FTo, FSubject, FBody: string;
    FPort: Integer;
    FFromName: string;
    procedure SetBody(const Value: string);
    procedure SetTo(const Value: string);
    procedure SetSubject(const Value: string);
  protected
    procedure Execute; override;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    function Error: string;

    property Host: string read FHost;
    property UserName: string read FUsername;
    property Password: string read FPassword;
    property FromName: string read FFromName;
    property FromAddress: string read FFromAddress;
    property Port: Integer read FPort;

    property &To: string read FTo write SetTo;
    property Subject: string read FSubject write SetSubject;
    property Body: string read FBody write SetBody;
  end;

implementation

constructor TEmail.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FError := '';
  FHost := 'smtp.gmail.com';
  FPort := 587;
  FUsername := 'contact.nbsystem@gmail.com';
  FPassword := 'eqvyetuhxwipvnvu';
  FFromName := 'Polyglot';
  FFromAddress := 'contact.nbsystem@gmail.com';

  FSSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FSMTP := TIdSMTP.Create(nil);
  FMensagem := TIdMessage.Create(nil);
end;

destructor TEmail.Destroy;
begin
//  FSMTP.Disconnect;
  FMensagem.Free;
  FSMTP.Free;
  FSSLIOHandler.Free;
  inherited;
end;

function TEmail.Error: string;
begin
  Result := FError;
end;

procedure TEmail.Execute;
begin
  inherited;
  try
    // configura o IOHandler SSL/TLS
    FSSLIOHandler.SSLOptions.Method := sslvTLSv1_2;
    FSSLIOHandler.SSLOptions.Mode := sslmClient;
    FSMTP.IOHandler := FSSLIOHandler;
    FSMTP.UseTLS := utUseExplicitTLS; //utUseExplicitTLS;
    // ou utUseImplicitTLS, dependendo do servidor SMTP que você está usando

    // configura o servidor SMTP
    FSMTP.Host := FHost;
    FSMTP.Port := FPort;
    FSMTP.AuthType := satDefault;
    FSMTP.UserName := FUsername;
    FSMTP.Password := FPassword;

    // configura a mensagem
    FMensagem.From.Name := FFromName;
    FMensagem.From.Address := FFromAddress;
    FMensagem.Recipients.Add;
    FMensagem.Recipients.Items[0].Address := FTo;
    FMensagem.Subject := FSubject;
    FMensagem.Body.Text := FBody;

    // envia o e-mail
    FSMTP.Connect;
    FSMTP.Authenticate;
    FSMTP.Send(FMensagem);
    FSMTP.Disconnect;

  except
    on E: Exception do
    begin
      FError := 'Error sending email: ' + E.Message;
    end;
  end;
end;

procedure TEmail.SetBody(const Value: string);
begin
  FBody := Value;
end;

procedure TEmail.SetSubject(const Value: string);
begin
  FSubject := Value;
end;

procedure TEmail.SetTo(const Value: string);
begin
  FTo := Value;
end;

end.
