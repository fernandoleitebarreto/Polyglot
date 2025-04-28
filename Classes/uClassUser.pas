unit uClassUser;

interface

uses System.Variants, System.SysUtils,
  FMX.Graphics, uEnum, uClassCountry;

type
  TUsuario = class
  private
    FId_Usuario: Integer;
    FActived: Integer;
    FNome: String;
    FSenha: String;
    FEmail: String;
    FTelefone: String;
    FNativeLanguage: TNativeLanguage;
    FFoto: string;
    FcodeSMS: String;
    FCountry: TCountry;
    FPoints: Integer;

    procedure SetId_Usuario(const Value: Integer);
    procedure SetActived(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetNativeLanguage(const Value: TNativeLanguage);
    procedure SetCountry(const Value: TCountry);
    procedure SetFoto(const Value: string);
    procedure SetCodeSMS(const Value: String);
    procedure SetPoints(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    property Id_Usuario: Integer read FId_Usuario write SetId_Usuario;
    property Actived: Integer read FActived write SetActived;
    property Nome: String read FNome write SetNome;
    property Email: String read FEmail write SetEmail;
    property Senha: String read FSenha write SetSenha;
    property Telefone: String read FTelefone write SetTelefone;
    property NativeLanguage: TNativeLanguage read FNativeLanguage write SetNativeLanguage;
    property Country: TCountry read FCountry write SetCountry;
    property Foto: string read FFoto write SetFoto;
    property codeSMS: String read FcodeSMS write SetCodeSMS;
    property Points: Integer read FPoints write SetPoints;
  end;

implementation

{ TUsuario }

uses uFunctions, UnitDM, Data.DB;

constructor TUsuario.Create;
begin
  FActived := 0;
  FNome := '';
  FSenha := '';
  FEmail := '';
  FTelefone := '';
  FcodeSMS := '';
  FNativeLanguage := nlEnglish;
  FFoto := '';
end;

procedure TUsuario.SetActived(const Value: Integer);
begin
  FActived := Value;
end;

procedure TUsuario.SetCodeSMS(const Value: String);
begin
  FcodeSMS := Value;
end;

procedure TUsuario.SetId_Usuario(const Value: Integer);
begin
  FId_Usuario := Value;
end;

procedure TUsuario.SetCountry(const Value: TCountry);
begin
  FCountry := Value;
end;

procedure TUsuario.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TUsuario.SetFoto(const Value: string);
begin
  FFoto := Value;
end;

procedure TUsuario.SetNativeLanguage(const Value: TNativeLanguage);
begin
  FNativeLanguage := Value;
end;

procedure TUsuario.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TUsuario.SetPoints(const Value: Integer);
begin
  FPoints := Value;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TUsuario.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

destructor TUsuario.Destroy;
begin
//  if Assigned(FFoto) then
//    FreeAndNil(FFoto);

  inherited;
end;

end.
