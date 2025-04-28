unit uClassParametro;

interface

uses System.Variants, System.SysUtils, FMX.Graphics,
  Firedac.Comp.Client, Firedac.Stan.Param, Firedac.DApt;

type
  TParametro = class
  private
    FVersion: string;
    FDeveloper: string;
    FTermsConditions_ENG: string;
    FTermsConditions_FRN: string;
    FTermsConditions_ITA: string;
    FTermsConditions_PTB: string;
    FTermsConditions_SPN: string;

    FPrivacyPolicy_ENG: string;
    FPrivacyPolicy_FRN: string;
    FPrivacyPolicy_ITA: string;
    FPrivacyPolicy_PTB: string;
    FPrivacyPolicy_SPN: string;

    procedure SetDeveloper(const Value: string);
    procedure SetVersion(const Value: string);
    procedure SetTermsConditions_ENG(const Value: string);
    procedure SetTermsConditions_FRN(const Value: string);
    procedure SetTermsConditions_ITA(const Value: string);
    procedure SetTermsConditions_PTB(const Value: string);
    procedure SetTermsConditions_SPN(const Value: string);
    procedure SetPrivacyPolicy_ENG(const Value: string);
    procedure SetPrivacyPolicy_FRN(const Value: string);
    procedure SetPrivacyPolicy_ITA(const Value: string);
    procedure SetPrivacyPolicy_PTB(const Value: string);
    procedure SetPrivacyPolicy_SPN(const Value: string);

  public
    property Version: string read FVersion write SetVersion;
    property Developer: string read FDeveloper write SetDeveloper;
    property TermsConditions_ENG: string read FTermsConditions_ENG write SetTermsConditions_ENG;
    property TermsConditions_FRN: string read FTermsConditions_FRN write SetTermsConditions_FRN;
    property TermsConditions_ITA: string read FTermsConditions_ITA write SetTermsConditions_ITA;
    property TermsConditions_PTB: string read FTermsConditions_PTB write SetTermsConditions_PTB;
    property TermsConditions_SPN: string read FTermsConditions_SPN write SetTermsConditions_SPN;

    property PrivacyPolicy_ENG: string read FPrivacyPolicy_ENG write SetPrivacyPolicy_ENG;
    property PrivacyPolicy_FRN: string read FPrivacyPolicy_FRN write SetPrivacyPolicy_FRN;
    property PrivacyPolicy_ITA: string read FPrivacyPolicy_ITA write SetPrivacyPolicy_ITA;
    property PrivacyPolicy_PTB: string read FPrivacyPolicy_PTB write SetPrivacyPolicy_PTB;
    property PrivacyPolicy_SPN: string read FPrivacyPolicy_SPN write SetPrivacyPolicy_SPN;

    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TParametro }

uses uFunctions, UnitDM, Data.DB;

constructor TParametro.Create;
begin
//  FDeveloper := 'Fernando Leite Barreto';
//  FVersion := '1.0.0.0';

end;

destructor TParametro.Destroy;
begin

  inherited;
end;

procedure TParametro.SetDeveloper(const Value: string);
begin
  FDeveloper := Value;
end;

procedure TParametro.SetPrivacyPolicy_ENG(const Value: string);
begin
  FPrivacyPolicy_ENG := Value;
end;

procedure TParametro.SetPrivacyPolicy_FRN(const Value: string);
begin
  FPrivacyPolicy_FRN := Value;
end;

procedure TParametro.SetPrivacyPolicy_ITA(const Value: string);
begin
  FPrivacyPolicy_ITA := Value;
end;

procedure TParametro.SetPrivacyPolicy_PTB(const Value: string);
begin
  FPrivacyPolicy_PTB := Value;
end;

procedure TParametro.SetPrivacyPolicy_SPN(const Value: string);
begin
  FPrivacyPolicy_SPN := Value;
end;

procedure TParametro.SetTermsConditions_ENG(const Value: string);
begin
  FTermsConditions_ENG := Value;
end;

procedure TParametro.SetTermsConditions_FRN(const Value: string);
begin
  FTermsConditions_FRN := Value;
end;

procedure TParametro.SetTermsConditions_ITA(const Value: string);
begin
  FTermsConditions_ITA := Value;
end;

procedure TParametro.SetTermsConditions_PTB(const Value: string);
begin
  FTermsConditions_PTB := Value;
end;

procedure TParametro.SetTermsConditions_SPN(const Value: string);
begin
  FTermsConditions_SPN := Value;
end;

procedure TParametro.SetVersion(const Value: string);
begin
  FVersion := Value;
end;

end.
