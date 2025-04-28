unit UTest;

interface

uses
  {Delphi}
  System.SysUtils, System.Types, System.UITypes, System.Classes, FMX.Types,
  FMX.Controls, FMX.Forms, FMX.StdCtrls, FMX.Layouts, FMX.Objects,

  {Skia}
  Skia, Skia.FMX,

  {Sample}
  // Sample.Form.Base,
  FMX.Controls.Presentation, UnitPadrao, FMX.Memo.Types, FMX.ScrollBox,
  FMX.Memo;

type
  TBackgroundKind = (Chess, Solid);

  TFrmTest = class(TFrmPadrao)
    sbxContent: TScrollBox;
    lblText: TLabel;
    Memo: TMemo;
    Button1: TButton;
    BtnClear: TButton;
    Memo1: TMemo;
    imgLetter: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  strict private
    { Private declarations }
    FSequence: TStringList;
    FCurrentPath: ISkPath;
    FOldPaths: TArray<ISkPath>;
    FPathBuilder: ISkPathBuilder;
    FPressed: Boolean;
  private
    FBackgroundKind: TBackgroundKind;
    FLastDiff, FMaxY, FMinY, FLastY: Single;
    IsGoingUp, IsGoingDown, IsCurving, IsLine: Boolean;
    procedure SetBackgroundKind(const Value: TBackgroundKind);
    procedure AddPosition(X, Y: Single);
    procedure CheckData(X, Y: Single);

  public
    { Public declarations }
    procedure OnDraw(ASender: TObject; const ACanvas: ISkCanvas;
      const ADest: TRectF; const AOpacity: Single);
    procedure OnMouseDown(ASender: TObject; AButton: TMouseButton;
      AShift: TShiftState; X, Y: Single);
    procedure OnMouseLeave(ASender: TObject);
    procedure OnMouseMove(ASender: TObject; AShift: TShiftState; X, Y: Single);
    procedure OnMouseUp(ASender: TObject; AButton: TMouseButton;
      AShift: TShiftState; X, Y: Single);

    property BackgroundKind: TBackgroundKind read FBackgroundKind
      write SetBackgroundKind;
  end;

var
  FrmTest: TFrmTest;

const
  cY_SIZE = 20;

implementation

uses
  FMX.Graphics;

{$R *.fmx}
{ TFreehandRender }

procedure TFrmTest.OnDraw(ASender: TObject; const ACanvas: ISkCanvas;
  const ADest: TRectF; const AOpacity: Single);
var
  LPaint: ISkPaint;
  LPath: ISkPath;
begin
  LPaint := TSkPaint.Create(TSkPaintStyle.Stroke);
  LPaint.AntiAlias := True;
  LPaint.Color := TAlphaColors.Red;
  LPaint.SetPathEffect(TSkPathEffect.MakeCorner(50));
  LPaint.StrokeCap := TSkStrokeCap.Round;
  LPaint.StrokeWidth := 4;

  for LPath in FOldPaths do
    ACanvas.DrawPath(LPath, LPaint);
  if Assigned(FPathBuilder) and not Assigned(FCurrentPath) then
    FCurrentPath := FPathBuilder.Snapshot;
  if Assigned(FCurrentPath) then
    ACanvas.DrawPath(FCurrentPath, LPaint);
end;

procedure TFrmTest.OnMouseDown(ASender: TObject; AButton: TMouseButton;
  AShift: TShiftState; X, Y: Single);
begin
  Memo1.Lines.Add('-------------------');
  FPressed := True;
  FLastDiff := 0;
  FLastY := -1;
  IsGoingDown := False;
  IsGoingUp := False;
  IsLine := False;
  IsCurving := False;
  FPathBuilder := TSkPathBuilder.Create;
  FPathBuilder.MoveTo(X, Y);
  FCurrentPath := nil;
end;

procedure TFrmTest.OnMouseLeave(ASender: TObject);
begin
  if Assigned(FPathBuilder) then
  begin
    if FCurrentPath = nil then
      FCurrentPath := FPathBuilder.Snapshot;
    FOldPaths := FOldPaths + [FCurrentPath];

    if ((FCurrentPath.Bounds.Top > FCurrentPath.Bounds.Bottom) and
       ((FCurrentPath.Bounds.Top - FCurrentPath.Bounds.Bottom) < cY_SIZE))
       or
       ((FCurrentPath.Bounds.Bottom >= FCurrentPath.Bounds.Top) and
       ((FCurrentPath.Bounds.Bottom - FCurrentPath.Bounds.Top) < cY_SIZE))
    then
    begin
      IsLine := True;
//      if (not Memo.Lines.IndexOf('IsLine') = -1) and (Memo.Lines.IndexOf('IsLine') <> Memo.Lines.Count - 1) then
//      begin
//        Memo.Lines.Delete(Memo.Lines.Count-1);
//        Memo.Lines.Add('IsLine');
//      end
//      else
        Memo.Lines.Add('IsLine');
    end;
//    Memo.Lines.Add('');
//    Memo.Lines.Add('Y-Top:' + FCurrentPath.Bounds.Top.ToString);
//    Memo.Lines.Add('Y-Bottom:' + FCurrentPath.Bounds.Bottom.ToString);
//    Memo.Lines.Add('IsGoingDown:' + BoolToStr(IsGoingDown, True));
//    Memo.Lines.Add('IsGoingUp:' + BoolToStr(IsGoingUp, True));
//    Memo.Lines.Add('IsLine:' + BoolToStr(IsLine, True));

//    Memo.Lines.Add('-------------');

    FPathBuilder := nil;
    FCurrentPath := nil;
  end;
end;

procedure TFrmTest.OnMouseMove(ASender: TObject; AShift: TShiftState;
  X, Y: Single);
begin
  if FPressed and Assigned(FPathBuilder) then
  begin
    FCurrentPath := nil;
    FPathBuilder.LineTo(X, Y);
    AddPosition(X, Y);
    CheckData(X, Y);
    (ASender as TSkPaintBox).Redraw;
  end;
end;

procedure TFrmTest.OnMouseUp(ASender: TObject; AButton: TMouseButton;
  AShift: TShiftState; X, Y: Single);
begin
  OnMouseLeave(ASender);
end;

procedure TFrmTest.SetBackgroundKind(const Value: TBackgroundKind);
begin
  FBackgroundKind := Value;
  // Just avoinding a know bug of TCanvasGpu drawing tile bitmap
  if TCanvasManager.DefaultCanvas.ClassName = 'TCanvasGpu' then
  begin
    pbxBackgroundChess.SendToBack;
    pbxBackgroundChess.Visible := FBackgroundKind = TBackgroundKind.Chess;
  end
  else
  begin
    rctBackgroundChess.SendToBack;
    rctBackgroundChess.Visible := FBackgroundKind = TBackgroundKind.Chess;
  end;
end;

procedure TFrmTest.AddPosition(X, Y: Single);
begin
  Memo1.Lines.Add('X:' + X.ToString + ' Y:' + Y.ToString + 'Dif: ' + (X-Y).ToString);
end;

procedure TFrmTest.CheckData(X, Y: Single);
var
  str: string;
begin
  if FLastY = -1 then
    FLastY := Y;

  if (FLastDiff > (X-Y)) and (FLastY < Y) and (not IsGoingDown) then
  begin
    if IsLine and (Y >= FLastY-cY_SIZE) and (Y <= FLastY+cY_SIZE)  then
      Exit;

    IsLine := False;
    IsGoingDown := True;
    IsGoingUp := False;
    Memo.Lines.Add('IsGoingDown');
  end
  else if (FLastDiff < (X-Y)) and (Y < FLastY) and (not IsGoingUp) then
  begin
    if IsLine and (Y >= FLastY-cY_SIZE) and (Y <= FLastY+cY_SIZE)  then
      Exit;

    IsLine := False;
    IsGoingDown := False;
    IsGoingUp := True;
    Memo.Lines.Add('IsGoingUp');
  end
  else if ((Y >= FLastY-cY_SIZE) and (Y <= FLastY+cY_SIZE)) and
          (not IsGoingUp) and (not IsGoingDown)
  then
    begin
      IsLine := True;
    end;

  FLastY := Y;
  FLastDiff := (X-Y);

  if Y > FMaxY then
    FMaxY := Y;

  if Y < FMinY then
    FMinY := Y;

//  Memo1.Lines.Add('FLastDiff: ' + FLastDiff.ToString);
//  Memo1.Lines.Add('X-Y: ' + (X-Y).ToString);
//  Memo1.Lines.Add('(FLastDiff >= (X-Y)): ' + BoolToStr(FLastDiff >= (X-Y), True));
//  Memo1.Lines.Add('(Y < FLastY): ' + BoolToStr((Y < FLastY), True));
//  Memo1.Lines.Add('FLastY: ' + FLastY.ToString);
//  Memo1.Lines.Add('IsGoingDown:' + BoolToStr(IsGoingDown, True));
//  Memo1.Lines.Add('IsGoingUp:' + BoolToStr(IsGoingUp, True));
//  Memo1.Lines.Add('IsLine:' + BoolToStr(IsLine, True));
//  Memo1.Lines.Add('FLastY-cY_SIZE: ' + (FLastY-cY_SIZE).ToString);
//  Memo1.Lines.Add('Y: ' + Y.ToString);
//  Memo1.Lines.Add('FLastY+cY_SIZE: ' + (FLastY+cY_SIZE).ToString);
//  Memo1.Lines.Add('--------------------');
end;


procedure TFrmTest.BtnClearClick(Sender: TObject);
begin
  inherited;
  Memo.Lines.Clear;
  Memo1.Lines.Clear;
  FSequence.Clear;
  if Assigned(FOldPaths) then
    FOldPaths := nil;
  if Assigned(FPathBuilder) then
    FPathBuilder.Reset;
end;

procedure TFrmTest.Button1Click(Sender: TObject);
var
  LPath: ISkPath;
begin
  inherited;
  Memo.Lines.Clear;
  for LPath in FOldPaths do
  begin
    Memo.Lines.Add('X-Left:' + LPath.Bounds.Left.ToString);
    Memo.Lines.Add('X-Right:' + LPath.Bounds.Right.ToString);
    Memo.Lines.Add('Y-Top:' + LPath.Bounds.Top.ToString);
    Memo.Lines.Add('Y-Bottom:' + LPath.Bounds.Bottom.ToString);
    Memo.Lines.Add('');
  end;
end;

procedure TFrmTest.FormCreate(Sender: TObject);
var
  LPaintBox: TSkPaintBox;
begin
  FLastY := -1;
  IsGoingDown := False;
  IsGoingUp := False;
  IsLine := False;
  IsCurving := False;
  BackgroundKind := TBackgroundKind.Chess;
  FSequence := TStringList.Create;
  LPaintBox := TSkPaintBox.Create(nil);
  LPaintBox.Parent := sbxContent;
  LPaintBox.Align := TAlignLayout.Client;
  LPaintBox.HitTest := True;
  LPaintBox.AutoCapture := True;
  LPaintBox.OnDraw := Self.OnDraw;
  LPaintBox.OnMouseDown := Self.OnMouseDown;
  LPaintBox.OnMouseMove := Self.OnMouseMove;
  LPaintBox.OnMouseUp := Self.OnMouseUp;
  LPaintBox.OnMouseLeave := Self.OnMouseLeave;
end;

procedure TFrmTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FSequence) then
    FreeAndNil(FSequence);
end;

end.
