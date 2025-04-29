unit UnitConstante;

interface

uses uEnum, System.Types;

var CurrentTheme: TTheme;

const
  // Google Analytics property ID.
  cImageIndexUnMute = 0;
  cImageIndexMute = 1;
  cTotalPerRound = 10;
  DefaultLanguage = nlEnglish;
  cPort = '8082';
  cIPRemote = '';
  GooglePropertyID = 'UA-check here';
  AppName = 'Polyglot';
  AppLicense = 'Comercial';
  AppEdition = 'ERP';
  VersaoSistema = '1.0.0';
  cCodAdmin = 1;
  cMaxTabItems = 10;
  IsDebuging = {$IFDEF DEBUG} True {$ELSE} False {$ENDIF};
  TimeSleep = 2000;
  cQtdLanguages = 4; { nlEnglish, nlFrench, nlSpanish,nlItalian }
  XRadius = 12;
  YRadius = 12;
  cOpacity1 = 1;
  cOpacity05 = 0.5;
  cRectHeight = 57;
  cWidth = 436;
  cHeight = 557;

{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  cLabelSize = 24;
{$ELSE}
  cLabelSize = 20;

{$ENDIF}
  ErrorConectingServer =
    'A connection with the server could not be established. ' +
    'Please try again later';

type
  TExecutaClickWin = procedure(Sender: TObject) of Object;
  TExecutaClickMobile = procedure(Sender: TObject; const Point: TPointF)
    of Object;
implementation

end.
