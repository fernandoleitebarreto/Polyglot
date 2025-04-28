unit UnitPadrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.ImageList, FMX.ImgList, GoogleAnalyticsGlobal, FMX.Skia,
  FMX.Objects, FMX.Edit, FMX.ListBox, FMX.StdCtrls, FMX.TabControl,
  FMX.Ani, uEnum, uEnum.Helper, Skia, FMX.Controls.Presentation, FMX.Layouts,
  UnitConstante;

type
  TFrmPadrao = class(TForm)
    SkLoading: TSkAnimatedImage;
    StyleBook: TStyleBook;
    ilCountry: TImageList;
    ilImages: TImageList;
    pbxBackgroundChess: TSkPaintBox;
    rctBackgroundChess: TRectangle;
    Rect_404: TRectangle;
    Lay_404: TLayout;
    lbl404: TLabel;
    Sk404: TSkAnimatedImage;
    Rect_404TryAgain: TRoundRect;
    Lbl_404TryAgain: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Rect_404TryAgainClick(Sender: TObject);
  private
    FTryAgainEvent: TProc;
    procedure ExibirCampos(pShow: Boolean = True); virtual;
  protected
    { Protected declarations }
    DisableBackButton: Boolean;
    procedure SetColors; virtual;
    procedure Set404(Value: Boolean);
    procedure ErroRequest(Sender: TObject);
    procedure CloseApplication(Sender: TObject);
    procedure TrataException(Sender: TObject; E: Exception); overload;
    procedure TrataException(Sender: TObject; AMessage: string;
      AClick: TProc); overload;
  end;

var
  FrmPadrao: TFrmPadrao;

implementation

uses
  UnitDM, uClassTexts;

{$R *.fmx}

procedure TFrmPadrao.CloseApplication(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SkLoading.Enabled := False;
  Sk404.Enabled := False;
end;

procedure TFrmPadrao.FormCreate(Sender: TObject);
begin
  Application.OnException := TrataException;
  Rect_404.Visible := False;
  SkLoading.Enabled := False;
  Sk404.Enabled := False;
  DisableBackButton := False;
  Self.Width := cWidth;
  Self.Height := cHeight;
  if CurrentTheme = TTheme.thUnknow then
    CurrentTheme := TTheme.thDark;
  SetColors;
{$IFNDEF DEBUG}
  _GoogleAnalytics.PageView(AppEdition, Self.Name, Self.Caption);
{$ENDIF}
  for var i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TComponent) then
    begin
      if (Components[i] is TRectangle) or (Components[i] is TLabel) then
        dm.RectEffect(Components[i])
      else if (Components[i] is TComboBox) then
        TComboBox(Components[i]).StyleLookup := 'ComboStyle'
      else if (Components[i] is TTabControl) then
        TTabControl(Components[i]).TabPosition := TTabPosition.None
      else if (Components[i] is TEdit) then
      begin
{$IFDEF MSWINDOWS}
        TEdit(Components[i]).StyleLookup := 'transparentedit';
{$ELSE}
        TEdit(Components[i]).StyleLookup := 'Edit1Style1';
{$ENDIF}
      end;

    end;
  end;

end;

procedure TFrmPadrao.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
{$IF DEFINED(ANDROID) OR DEFINED(IOS)}
  if Key = vkHardwareBack then
  begin
    // Do whatever you want to do here
    if DisableBackButton then
      Key := 0; // Set Key = 0 if you want to prevent the default action
  end;
{$ENDIF}
end;

procedure TFrmPadrao.Rect_404TryAgainClick(Sender: TObject);
begin
  FTryAgainEvent;
end;

procedure TFrmPadrao.SetColors;
begin
  Self.Fill.Color := CurrentTheme.ColorBackGround;
  Rect_404.Fill.Color := CurrentTheme.ColorBackGround;
end;

procedure TFrmPadrao.TrataException(Sender: TObject; E: Exception);
begin
  TrataException(Sender, ErrorConectingServer,
    procedure
    begin
      CloseApplication(Sender);
    end);
  // GravarMsg('=================');
  // GravarMsg('ClassName: ' + E.ClassName);
  ShowMessage('Something went wrong: ' + E.Message);

end;

procedure TFrmPadrao.TrataException(Sender: TObject; AMessage: string;
  AClick: TProc);
begin
  Set404(True);
  lbl404.Text := AMessage;
  FTryAgainEvent := AClick;
end;

procedure TFrmPadrao.Set404(Value: Boolean);
begin
  Rect_404.Visible := Value;
  Sk404.Enabled := Value;

  if Value then
  begin
    SkLoading.Visible := False;
    SkLoading.Enabled := SkLoading.Visible;
    Rect_404.BringToFront;
  end
  else
    Rect_404.SendToBack;
end;

procedure TFrmPadrao.ErroRequest(Sender: TObject);
var
  msg: string;
begin
  if Assigned(Sender) and (Sender is Exception) then
  begin
    ExibirCampos;
    TrataException(Sender, ErrorConectingServer,
    procedure
    begin
      CloseApplication(Sender);
    end);
    Lbl_404TryAgain.Text := 'Close Application';
    msg := Exception(Sender).Message;
    if msg.contains('12029') then
      ShowMessage(ErrorConectingServer)
    else
      ShowMessage(Exception(Sender).Message);
  end;

end;


procedure TFrmPadrao.ExibirCampos(pShow: Boolean);
begin
  SkLoading.Visible := not pShow;
  SkLoading.Enabled := SkLoading.Visible;
end;

end.
