unit ExtendParseApiUnit;

interface

uses REST.Backend.Parseapi, System.JSON, REST.Client, REST.Types;

type

  TExtendParseApi = class(TParseApi)

  private

  public

    procedure SignupUser(const AUserName, APassword, AEmail: string;

      out ALogin: TParseApi.TLogin); overload;

    procedure PasswordReset(const AEmail: string);

  end;

implementation

// New version of signup user that has a password parameter

procedure TExtendParseApi.SignupUser(const AUserName, APassword, AEmail: string;

  out ALogin: TParseApi.TLogin);

var

  LJSON: TJSONObject;

begin

  LJSON := TJSONObject.Create;

  try

    LJSON.AddPair('email', AEmail);

    inherited SignupUser(AUserName, APassword, LJSON, ALogin);

  finally

    LJSON.Free;

  end;

end;



// curl -X POST \

// -H "X-Parse-Application-Id: cIj01OkQeJ8LUzFZjMnFyJQD6qx0OehYep0mMdak" \

// -H "X-Parse-REST-API-Key: yVVIeShrcZrdr3e4hMLodfnvLckWBZfTonCYlBsq" \

// -H "Content-Type: application/json" \

// -d '{"email":"coolguy@iloveapps.com"}' \

// https://api.parse.com/1/requestPasswordReset

procedure TExtendParseApi.PasswordReset(const AEmail: string);

var

  LJSON: TJSONObject;

begin

  Request.ResetToDefaults;

  AddAuthParameters;

  Request.Method := TRESTRequestMethod.rmPOST;

  Request.Resource := 'requestPasswordReset';

  LJSON := TJSONObject.Create;

  try

    LJSON.AddPair('email', AEmail);

    Request.AddBody(LJSON);

    Request.Execute;

    CheckForResponseError([201]);

  finally

    LJSON.Free;

  end;

end;

end.
