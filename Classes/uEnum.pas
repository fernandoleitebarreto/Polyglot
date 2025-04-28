unit uEnum;

interface

uses
  System.SysUtils;

type
  /// <summary>
  /// <p> Classe: TNativeLanguage</p>
  /// <p> Campos: </p>
  /// <p> 0 - Desconhecido </p>
  /// <p> 1 - English </p>
  /// <p> 2 - Portuguese </p>
  /// <p> 3 - French </p>
  /// <p> 4 - Spanish </p>
  /// <p> 5 - Italian </p>
  /// <p> 6 - Todas </p>
  /// </summary>

  TNativeLanguage = (nlUnknow, nlEnglish, nlPortuguese, nlFrench, nlSpanish,
    nlItalian, nlAll);
  TCategorySelected = (csUnknow = 0, csWord, csPhrase);
  TProducts = (prUnknow = 0, prNoAdsID, prPhrase);
  TGameForms = (fmUnknow = 0, fmCompleteWords, fmMemorize, fmSelectWords);
  TTheme = (thUnknow = 0, thDark, thLight);

  TNativeLanguageArray = set of TNativeLanguage;


implementation


end.
