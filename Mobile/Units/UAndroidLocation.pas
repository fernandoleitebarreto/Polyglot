unit UAndroidLocation;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.Layouts, FMX.ListBox, FMX.StdCtrls
{$IFDEF ANDROID}
    , Androidapi.JNI.Location, Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF};

{$IFDEF ANDROID}

type
  TLocationListener = class;

  ILocation = interface
    ['{5501C406-1ABD-4FF9-8B30-7BB93328FE3B}']
    function getLatitude: Double;
    function getLongitude: Double;
    function getAltitude: Double;
    function getCountry: String;
  end;

  TLocation = class(TInterfacedObject, ILocation)
  private
    { Private declarations }
    {
      ListBox1: TListBox;
      CheckBox1: TCheckBox;
      CheckBox2: TCheckBox;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
    }
    iter: JIterator;
    FLocationManager: JLocationManager;
    locationListener: TLocationListener;
    LocationManagerService: JObject;
    Location: JLocation;
    FGeocoder: JGeocoder;
    function getLatitude: Double;
    function getLongitude: Double;
    function getAltitude: Double;
    function getCountry: String;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;

    procedure onLocationChanged(Location: JLocation);
  end;

  TLocationListener = class(TJavaLocal, JLocationListener)
  private
    [weak]
    FParent: TLocation;
  public
    constructor Create(AParent: TLocation);
    procedure onLocationChanged(Location: JLocation); cdecl;
    procedure onProviderDisabled(provider: JString); cdecl;
    procedure onProviderEnabled(provider: JString); cdecl;
    procedure onStatusChanged(provider: JString; status: Integer;
      extras: JBundle); cdecl;
  end;
{$ENDIF}

implementation

{$IFDEF ANDROID}

uses FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.Helpers;

{ TLocationListener }

constructor TLocationListener.Create(AParent: TLocation);
begin
  inherited Create;
  FParent := AParent;
end;

procedure TLocationListener.onLocationChanged(Location: JLocation);
begin
  FParent.onLocationChanged(Location);
end;

procedure TLocationListener.onProviderDisabled(provider: JString);
begin

end;

procedure TLocationListener.onProviderEnabled(provider: JString);
begin

end;

procedure TLocationListener.onStatusChanged(provider: JString; status: Integer;
  extras: JBundle);
begin

end;

{ TLocation }

constructor TLocation.Create;
begin
  if not Assigned(FLocationManager) then
  begin
    LocationManagerService := SharedActivityContext.getSystemService
      (TJContext.JavaClass.LOCATION_SERVICE);
    FLocationManager := TJLocationManager.Wrap
      ((LocationManagerService as ILocalObject).GetObjectID);
    if not Assigned(locationListener) then
      locationListener := TLocationListener.Create(self);
    FLocationManager.requestLocationUpdates
      (TJLocationManager.JavaClass.GPS_PROVIDER, 10000, 10, locationListener,
      TJLooper.JavaClass.getMainLooper);
  end;

  iter := FLocationManager.GetAllProviders.Iterator;

  {
    ListBox1.Clear;
    while iter.hasNext do
    begin
    ListBox1.Items.Add(JStringToString(iter.next.ToString));
    end;
    CheckBox1.IsChecked := FLocationManager.isProviderEnabled
    (TJLocationManager.JavaClass.GPS_PROVIDER);
    CheckBox2.IsChecked := FLocationManager.isProviderEnabled
    (TJLocationManager.JavaClass.NETWORK_PROVIDER);

  }

  Location := FLocationManager.getLastKnownLocation
    (TJLocationManager.JavaClass.GPS_PROVIDER);

  onLocationChanged(Location);
end;

destructor TLocation.Destroy;
begin
  if Assigned(locationListener) then
    FLocationManager.removeUpdates(locationListener);
  inherited;
end;

function TLocation.getAltitude: Double;
begin
  Result := Location.getAltitude;
end;

function TLocation.getCountry: String;
// const
// api = 'http://api.geonames.org/countryCodeJSON?lat=%s&lng=%s&username=%s';
// username = 'demo';

VAR
  addresses: JAddress;
begin

  // Format(api, [self.getLatitude, self.getLongitude, username]);

  FGeocoder := TJGeocoder.Wrap((LocationManagerService as ILocalObject)
    .GetObjectID);
  addresses := FGeocoder.getFromLocation(self.getLatitude, self.getLongitude, 1)
    .get(0) as JAddress;

  // Result := addresses.getCountryName;


  // addresses.getCountryName.JStringToString(S);

end;

function TLocation.getLatitude: Double;
begin
  Result := Location.getLatitude;
end;

function TLocation.getLongitude: Double;
begin
  Result := Location.getLongitude;
end;

procedure TLocation.onLocationChanged(Location: JLocation);
begin
  Location := FLocationManager.getLastKnownLocation
    (TJLocationManager.JavaClass.GPS_PROVIDER);
end;

{$ENDIF}

end.
