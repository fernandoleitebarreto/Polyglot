unit u99Permissions;

interface

uses System.Permissions, System.Types, FMX.DialogService, FMX.MediaLibrary.Actions
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;

type
  TCallbackProc = procedure(Sender: TObject) of Object;

  T99Permissions = class
  private
    CurrentRequest: string;
{$IFDEF ANDROID}
    pReadPhoneState, pCamera, pReadStorage, pWriteStorage: string; // Camera / Library
    pFineLocation, pCoarseLocation: string; // GPS
    pRecordAudio, pCallPhone, pSMS: string;
    procedure RequestPermissionsResult(Sender: TObject; const APermissions: TClassicStringDynArray;
    const AGrantResults: TClassicPermissionStatusDynArray);
{$ENDIF}
  public
    MyCallBack, MyCallBackError: TCallbackProc;
    MyCameraAction: TTakePhotoFromCameraAction;
    MyLibraryAction: TTakePhotoFromLibraryAction;

    constructor Create;
    // function VerifyCameraAccess: boolean;
    procedure Camera(ActionPhoto: TTakePhotoFromCameraAction;
      ACallBackError: TCallbackProc = nil);
    procedure Storage(ActionLibrary: TTakePhotoFromLibraryAction;
      ACallBackError: TCallbackProc = nil);
    procedure Location(ACallBack: TCallbackProc = nil;
      ACallBackError: TCallbackProc = nil);
    procedure RecordAudio(ACallBack: TCallbackProc = nil;
      ACallBackError: TCallbackProc = nil);
    procedure SMS(ACallBack: TCallbackProc = nil;
      ACallBackError: TCallbackProc = nil);
    procedure ReadPhoneState(ACallBack: TCallbackProc = nil;
      ACallBackError: TCallbackProc = nil);

  end;

implementation

// function T99Permissions.VerifyCameraAccess: boolean;
// begin
// Result := false;
//
// {$IFDEF ANDROID}
// Result := PermissionsService.IsEveryPermissionGranted
// ([pCamera, pReadStorage, pWriteStorage]);
// {$ENDIF}
// end;

constructor T99Permissions.Create();
begin
{$IFDEF ANDROID}
  pReadPhoneState := JStringToString(TJManifest_permission.JavaClass.READ_PHONE_STATE);
  pCamera := JStringToString(TJManifest_permission.JavaClass.Camera);
  pReadStorage := JStringToString
    (TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
  pWriteStorage := JStringToString
    (TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
  pCoarseLocation := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_COARSE_LOCATION);
  pFineLocation := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);
  pRecordAudio := JStringToString(TJManifest_permission.JavaClass.RECORD_AUDIO);
  pCallPhone := JStringToString(TJManifest_permission.JavaClass.CALL_PHONE);
  pSMS := JStringToString(TJManifest_permission.JavaClass.SEND_SMS);

{$ENDIF}
end;
{$IFDEF ANDROID}

procedure T99Permissions.RequestPermissionsResult(Sender: TObject;
    const APermissions: TClassicStringDynArray;
    const AGrantResults: TClassicPermissionStatusDynArray);
var
  ret: boolean;
begin
  ret := false;

  // CAMERA (CAMERA + READ_EXTERNAL_STORAGE + WRITE_EXTERNAL_STORAGE)
  if CurrentRequest = 'CAMERA' then
  begin
    if (Length(AGrantResults) = 3) and
      (AGrantResults[0] = TPermissionStatus.Granted) and
      (AGrantResults[1] = TPermissionStatus.Granted) and
      (AGrantResults[2] = TPermissionStatus.Granted) then
    begin
      ret := true;

      if Assigned(MyCameraAction) then
        MyCameraAction.Execute;
    end;
  end;

  // LIBRARY (READ_EXTERNAL_STORAGE + WRITE_EXTERNAL_STORAGE)
  if CurrentRequest = 'STORAGE' then
  begin
    if (Length(AGrantResults) = 2) and
      (AGrantResults[0] = TPermissionStatus.Granted) and
      (AGrantResults[1] = TPermissionStatus.Granted) then
    begin
      ret := true;

      if Assigned(MyLibraryAction) then
        MyLibraryAction.Execute;
    end;
  end;

  // LOCATION (ACCESS_COARSE_LOCATION + ACCESS_FINE_LOCATION)
  if CurrentRequest = 'LOCATION' then
  begin
    if (Length(AGrantResults) = 2) and
      (AGrantResults[0] = TPermissionStatus.Granted) and
      (AGrantResults[1] = TPermissionStatus.Granted) then
    begin
      ret := true;

      if Assigned(MyCallBack) then
        MyCallBack(Self);
    end;
  end;

  // RECORD_AUDIO (READ_EXTERNAL_STORAGE + WRITE_EXTERNAL_STORAGE)
  if CurrentRequest = 'RECORD_AUDIO' then
  begin
    if (Length(AGrantResults) = 3) and
      (AGrantResults[0] = TPermissionStatus.Granted) and
      (AGrantResults[1] = TPermissionStatus.Granted) and
      (AGrantResults[2] = TPermissionStatus.Granted) then
    begin
      ret := true;

      if Assigned(MyCallBack) then
        MyCallBack(Self);
    end;
  end;

  if CurrentRequest = 'SEND_SMS' then
  begin
    if (Length(AGrantResults) = 1) and
      (AGrantResults[0] = TPermissionStatus.Granted) then
    begin
      ret := true;

      if Assigned(MyCallBack) then
        MyCallBack(Self);
    end;
  end;

  if NOT ret then
  begin
    if Assigned(MyCallBackError) then
      MyCallBackError(Self);
  end;
end;
{$ENDIF}

procedure T99Permissions.Camera(ActionPhoto: TTakePhotoFromCameraAction;
  ACallBackError: TCallbackProc = nil);
begin
{$IFDEF ANDROID}
  MyCameraAction := ActionPhoto;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'CAMERA';

  PermissionsService.RequestPermissions([pCamera, pReadStorage, pWriteStorage],
    RequestPermissionsResult);
{$ENDIF}
{$IFDEF IOS}
  MyCameraAction := ActionPhoto;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'CAMERA';

  MyCameraAction.Execute;
{$ENDIF}
{$IFDEF MSWINDOWS}
  MyCameraAction.Execute;
  // TDialogService.ShowMessage('Não suportado no Windows');
{$ENDIF}
end;

procedure T99Permissions.ReadPhoneState(ACallBack, ACallBackError: TCallbackProc);
begin
{$IFDEF ANDROID}
  PermissionsService.RequestPermissions([pReadPhoneState], nil, nil);
{$ENDIF}

end;

procedure T99Permissions.Storage(ActionLibrary: TTakePhotoFromLibraryAction;
  ACallBackError: TCallbackProc = nil);
begin
{$IFDEF ANDROID}
  MyLibraryAction := ActionLibrary;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'STORAGE';

  PermissionsService.RequestPermissions([pReadStorage, pWriteStorage],
    RequestPermissionsResult);
{$ENDIF}
{$IFDEF IOS}
  MyLibraryAction := ActionLibrary;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'STORAGE';

  ActionLibrary.Execute;
{$ENDIF}
{$IFDEF MSWINDOWS}
  // ActionLibrary.Execute;
{$ENDIF}
end;

procedure T99Permissions.Location(ACallBack: TCallbackProc = nil;
  ACallBackError: TCallbackProc = nil);
begin
{$IFDEF ANDROID}
  MyCallBack := ACallBack;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'LOCATION';

  PermissionsService.RequestPermissions([pCoarseLocation, pFineLocation],
    RequestPermissionsResult);
{$ENDIF}
{$IFDEF IOS}
  MyCallBack := ACallBack;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'LOCATION';

  if Assigned(MyCallBack) then
    MyCallBack(Self);
{$ENDIF}
{$IFDEF MSWINDOWS}
  // TDialogService.ShowMessage('Não suportado no Windows');
{$ENDIF}
end;

procedure T99Permissions.RecordAudio(ACallBack, ACallBackError: TCallbackProc);
begin
{$IFDEF ANDROID}
  MyCallBack := ACallBack;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'RECORD_AUDIO';

  PermissionsService.RequestPermissions([pRecordAudio, pReadStorage,
    pWriteStorage], RequestPermissionsResult);
{$ENDIF}
{$IFDEF IOS}
  MyCallBack := ACallBack;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'RECORD_AUDIO';

  if Assigned(MyCallBack) then
    MyCallBack(Self);
{$ENDIF}
{$IFDEF MSWINDOWS}
  // TDialogService.ShowMessage('Não suportado no Windows');
{$ENDIF}
end;

procedure T99Permissions.SMS(ACallBack, ACallBackError: TCallbackProc);
begin
{$IFDEF ANDROID}
  MyCallBack := ACallBack;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'SEND_SMS';

  PermissionsService.RequestPermissions([pSMS], RequestPermissionsResult);
{$ENDIF}
{$IFDEF IOS}
  MyCallBack := ACallBack;
  MyCallBackError := ACallBackError;
  CurrentRequest := 'SEND_SMS';

  if Assigned(MyCallBack) then
    MyCallBack(Self);
{$ENDIF}
{$IFDEF MSWINDOWS}
  // TDialogService.ShowMessage('Não suportado no Windows');
{$ENDIF}
end;

end.
