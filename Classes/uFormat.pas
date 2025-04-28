/// //////////////////////////////////////////////////////////////////////////
{
  Unit Format
  Criação: 99 Coders (Heber Stein Mazutti - heber@99coders.com.br)
  Versão: 1.2
}
/// //////////////////////////////////////////////////////////////////////////

unit uFormat;

interface

uses System.SysUtils, FMX.Edit, Classes, System.MaskUtils, System.Character,
  uFunctions;

type
  TFormato = (CNPJ, CPF, InscricaoEstadual, CNPJorCPF, TelefoneFixo, Celular,
    Personalizado, Valor, Money, CEP, Dt, Peso);

procedure Formatar(Obj: TObject; Formato: TFormato; Extra: string = '');

implementation

function FormataIE(Num, UF: string): string;
var
  Mascara: string;
begin
  Mascara := '';
  IF UF = 'AC' Then
    Mascara := '##.###.###/###-##';
  IF UF = 'AL' Then
    Mascara := '#########';
  IF UF = 'AP' Then
    Mascara := '#########';
  IF UF = 'AM' Then
    Mascara := '##.###.###-#';
  IF UF = 'BA' Then
    Mascara := '######-##';
  IF UF = 'CE' Then
    Mascara := '########-#';
  IF UF = 'DF' Then
    Mascara := '###########-##';
  IF UF = 'ES' Then
    Mascara := '#########';
  IF UF = 'GO' Then
    Mascara := '##.###.###-#';
  IF UF = 'MA' Then
    Mascara := '#########';
  IF UF = 'MT' Then
    Mascara := '##########-#';
  IF UF = 'MS' Then
    Mascara := '#########';
  IF UF = 'MG' Then
    Mascara := '###.###.###/####';
  IF UF = 'PA' Then
    Mascara := '##-######-#';
  IF UF = 'PB' Then
    Mascara := '########-#';
  IF UF = 'PR' Then
    Mascara := '########-##';
  IF UF = 'PE' Then
    Mascara := '##.#.###.#######-#';
  IF UF = 'PI' Then
    Mascara := '#########';
  IF UF = 'RJ' Then
    Mascara := '##.###.##-#';
  IF UF = 'RN' Then
    Mascara := '##.###.###-#';
  IF UF = 'RS' Then
    Mascara := '###/#######';
  IF UF = 'RO' Then
    Mascara := '###.#####-#';
  IF UF = 'RR' Then
    Mascara := '########-#';
  IF UF = 'SC' Then
    Mascara := '###.###.###';
  IF UF = 'SP' Then
    Mascara := '###.###.###.###';
  IF UF = 'SE' Then
    Mascara := '#########-#';
  IF UF = 'TO' Then
    Mascara := '###########';

  Result := TFunctions.Mask(Mascara, Num);
end;

procedure Formatar(Obj: TObject; Formato: TFormato; Extra: string = '');
var
  texto: string;
begin
  TThread.Queue(Nil,
    procedure
    begin
      if Obj is TEdit then
        texto := TEdit(Obj).Text;

      // Telefone Fixo...
      if Formato = TelefoneFixo then
        texto := TFunctions.Mask('(##) ####-####',
          TFunctions.SomenteNumero(texto));

      // Celular...
      if Formato = Celular then
        texto := TFunctions.Mask('(##) #####-####',
          TFunctions.SomenteNumero(texto));

      // CNPJ...
      if Formato = CNPJ then
        texto := TFunctions.Mask('##.###.###/####-##',
          TFunctions.SomenteNumero(texto));

      // CPF...
      if Formato = CPF then
        texto := TFunctions.Mask('###.###.###-##',
          TFunctions.SomenteNumero(texto));

      // Inscricao Estadual (IE)...
      if Formato = InscricaoEstadual then
        texto := FormataIE(TFunctions.SomenteNumero(texto), Extra);

      // CNPJ ou CPF...
      if Formato = CNPJorCPF then
        if Length(TFunctions.SomenteNumero(texto)) <= 11 then
          texto := TFunctions.Mask('###.###.###-##',
            TFunctions.SomenteNumero(texto))
        else
          texto := TFunctions.Mask('##.###.###/####-##',
            TFunctions.SomenteNumero(texto));

      // Personalizado...
      if Formato = Personalizado then
        texto := TFunctions.Mask(Extra, TFunctions.SomenteNumero(texto));

      // Valor...
      if Formato = Valor then
        texto := TFunctions.FormataValor(TFunctions.SomenteNumero(texto));

      // Money (com simbolo da moeda)...
      if Formato = Money then
      begin
        if Extra = '' then
          Extra := 'R$';

        texto := Extra + ' ' + TFunctions.FormataValor
          (TFunctions.SomenteNumero(texto));
      end;

      // CEP...
      if Formato = CEP then
        texto := TFunctions.Mask('##.###-###', TFunctions.SomenteNumero(texto));

      // Data...
      if Formato = Dt then
        texto := TFunctions.FormataData(TFunctions.SomenteNumero(texto));

      // Peso...
      if Formato = Peso then
        texto := TFunctions.FormataPeso(TFunctions.SomenteNumero(texto));

      if Obj is TEdit then
      begin
        TEdit(Obj).Text := texto;
        TEdit(Obj).CaretPosition := TEdit(Obj).Text.Length;
      end;

    end);

end;

end.
