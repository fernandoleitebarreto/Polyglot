unit uClassInAppPurchase;

interface

uses FMX.InAppPurchase, System.Classes, UnitConstante,
  uEnum, uEnum.Helper, uClassMeaning, uClassMeaning.Intf;

type

  IClassInAppPurchase = interface
    ['{836DD7D7-F4E1-49D5-B44E-4DF4B4D358AD}']
    procedure InAppPurchaseSetupComplete(Sender: TObject);
    procedure InAppPurchasePurchaseCompleted(Sender: TObject;
      const ProductID: string; NewTransaction: Boolean);
    procedure InAppPurchaseError(Sender: TObject; ErrorKind: TFailureKind;
      const ErrorMessage: string);
    procedure InAppPurchaseProductsRequestResponse(Sender: TObject;
      const Products: TIAPProductList; const InvalidProductIDs: TStrings);
    procedure ConsumeComplete(Sender: TObject; const ProductID: string);
    procedure ConsumeFailed(Sender: TObject;
      const ProductID, ErrorMessage: string);
    procedure DesabilitarBanner(BecauseOfPurchase: Boolean);
    procedure DesabilitarCadeadoFrases(BecauseOfPurchase: Boolean);
    procedure EnabledPurchasePhraseUI(BecauseOfPurchase: Boolean);
    procedure EnabledPurchaseUI(BecauseOfPurchase: Boolean);

  end;

  TClassInAppPurchase = class(TInterfacedObject, IClassInAppPurchase)
  private
    FInAppPurchase: TInAppPurchase;
    FSemAds: Boolean;
    FCadeadoFrasesDesabilitado: Boolean;

    procedure InAppPurchaseSetupComplete(Sender: TObject);
    procedure InAppPurchasePurchaseCompleted(Sender: TObject;
      const ProductID: string; NewTransaction: Boolean);
    procedure InAppPurchaseError(Sender: TObject; ErrorKind: TFailureKind;
      const ErrorMessage: string);
    procedure InAppPurchaseProductsRequestResponse(Sender: TObject;
      const Products: TIAPProductList; const InvalidProductIDs: TStrings);
    procedure ConsumeComplete(Sender: TObject; const ProductID: string);
    procedure ConsumeFailed(Sender: TObject;
      const ProductID, ErrorMessage: string);
    procedure DesabilitarBanner(BecauseOfPurchase: Boolean);
    procedure DesabilitarCadeadoFrases(BecauseOfPurchase: Boolean);
    procedure EnabledPurchasePhraseUI(BecauseOfPurchase: Boolean);
    procedure EnabledPurchaseUI(BecauseOfPurchase: Boolean);
    function ClickItem(item: TProducts): TExecutaClickWin;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  FMX.Dialogs, System.SysUtils;

{ TClassInAppPurchase }

constructor TClassInAppPurchase.Create;
begin
  FInAppPurchase := TInAppPurchase.Create(nil);
  FInAppPurchase.ApplicationLicenseKey :=
    'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuIgCbtnyERugHxSU0+CJ/vQ41h+V2GY3MG0vfYByicDdIUlywcOzuawT7NIzLYZ2LEJ7JTBqW'
    + 'llkRh7zbpTKQ/3trkEqKivJrVatsrVfKoCaBXGvNjL8gg5KxDKATxbVJNmEzHwMpc0G+4RPnJqnaAltU4VDK4lHZG1aNaMZg3/KMKC/An4QDwJ0iPu0Wb'
    + 'lMbS3+RAQag3b2PJ3RaZ4cRT7P7PFnwZIuyFEAlRa3UKqhWQSyOaAo9D/CTqGrLAgRaUvhRTBB86010wOPsEl/2i8RIMrYluaIz48uX4vYeJf3SiC70CI'
    + 'uHLf4lcEGxeh/IexEvosSDdwK1rh4gAqRYQIDAQAB';
  FInAppPurchase.ProductIDs.Add(prPhrase.ProductID);
  FInAppPurchase.ProductIDs.Add(prNoAdsID.ProductID);
  FInAppPurchase.OnSetupComplete := InAppPurchaseSetupComplete;
  FInAppPurchase.OnProductsRequestResponse :=
    InAppPurchaseProductsRequestResponse;
  FInAppPurchase.OnError := InAppPurchaseError;
  FInAppPurchase.OnPurchaseCompleted := InAppPurchasePurchaseCompleted;
  FInAppPurchase.OnConsumeCompleted := ConsumeComplete;
  FInAppPurchase.OnConsumeFailed := ConsumeFailed;
  FInAppPurchase.SetupInAppPurchase;

  FSemAds := False;
  FCadeadoFrasesDesabilitado := False;

end;

function TClassInAppPurchase.ClickItem(item: TProducts): TExecutaClickWin;
begin
  if not FCadeadoFrasesDesabilitado then
  begin
    FInAppPurchase.PurchaseProduct(item.ProductID);
    FCadeadoFrasesDesabilitado := true;
  end;

end;

procedure TClassInAppPurchase.InAppPurchaseError(Sender: TObject;
  ErrorKind: TFailureKind; const ErrorMessage: string);
begin
  raise Exception.Create('Purchasing error: ' + ErrorMessage);
end;

procedure TClassInAppPurchase.InAppPurchaseProductsRequestResponse
  (Sender: TObject; const Products: TIAPProductList;
  const InvalidProductIDs: TStrings);
var
  Product: TProduct;
begin
  for Product in Products do
  begin
    if Product.ProductID = prNoAdsID.ProductID then
      FSemAds := true;
    if Product.ProductID = prPhrase.ProductID then
      FCadeadoFrasesDesabilitado := true;
  end;

  if not FSemAds then
    DesabilitarBanner(False);
  if not FCadeadoFrasesDesabilitado then
    DesabilitarCadeadoFrases(False);

end;

procedure TClassInAppPurchase.InAppPurchasePurchaseCompleted(Sender: TObject;
  const ProductID: string; NewTransaction: Boolean);
begin
  // quando terminar compra
  if ProductID = prNoAdsID.ProductID then
  begin
    // desabilitar o banner
    DesabilitarBanner(true);
  end
  else
    ShowMessage('Habilitado banner');

  if ProductID = prPhrase.ProductID then
  begin
    // desabilitar cadeado das frases
    DesabilitarCadeadoFrases(true);
  end
  else
    ShowMessage('Habilitado cadeado das frases');
end;

procedure TClassInAppPurchase.InAppPurchaseSetupComplete(Sender: TObject);
begin
  // verifica se já foi comprado
  FInAppPurchase.QueryProducts;
  if not FInAppPurchase.IsProductPurchased(prNoAdsID.ProductID) then
    DesabilitarBanner(true)
  else
  begin
    ShowMessage('Habilitar ads');
  end;

  if FInAppPurchase.IsProductPurchased(prPhrase.ProductID) then
    DesabilitarCadeadoFrases(true)
  else
  begin
    ShowMessage('Habilitar cadeado');
  end;

end;

procedure TClassInAppPurchase.ConsumeComplete(Sender: TObject;
  const ProductID: string);
begin
  ShowMessage('Consume Complete: ' + ProductID);
end;

procedure TClassInAppPurchase.ConsumeFailed(Sender: TObject;
  const ProductID, ErrorMessage: string);
begin
  ShowMessage('Consume Failed: ' + ProductID);
end;

procedure TClassInAppPurchase.DesabilitarCadeadoFrases(BecauseOfPurchase
  : Boolean);
begin
  ShowMessage('Cadeado desabilitado');
end;

procedure TClassInAppPurchase.DesabilitarBanner(BecauseOfPurchase: Boolean);
begin
  // FMeaning.SetBannerDisabled(true);
  if BecauseOfPurchase then
    ShowMessage('Banner desabilitado');

  // FBannerAd := TAdBanner.Create(Self, TFunctions.AppID, TAdBannerType.Banner);
  // FBannerAd.Show(true, TAlignLayout.MostBottom);

end;

procedure TClassInAppPurchase.EnabledPurchasePhraseUI(BecauseOfPurchase
  : Boolean);
begin
  ShowMessage('EnabledPurchasePhraseUI');
end;

procedure TClassInAppPurchase.EnabledPurchaseUI(BecauseOfPurchase: Boolean);
begin
  ShowMessage('EnabledPurchaseUI');
end;

destructor TClassInAppPurchase.Destroy;
begin
  if Assigned(FInAppPurchase) then
    FreeAndNil(FInAppPurchase);
end;

end.
