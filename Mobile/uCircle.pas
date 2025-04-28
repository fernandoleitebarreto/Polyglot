unit uCircle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Ani, FMX.Layouts,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ImgList,
  System.ImageList, FMX.Effects, FMX.Filter.Effects, FMX.Skia, System.Skia;

type
  TCircleFrame = class(TFrame)
    LineCircle: TPie;
    Layout: TRectangle;
    Circle: TCircle;
    ImageCircle: TSkAnimatedImage;
    LblText: TLabel;
    TrackBar: TTrackBar;
    LineCircleBack: TPie;
    LayoutTag: TLayout;
    Lay_Back: TLayout;
    LblDescription: TLabel;
    LblAlphabet: TLabel;
    LetterAnimation: TFloatAnimation;
    ShadowEffect1: TShadowEffect;
    imgLock: TImage;
    procedure TrackBarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  CircleFrame: TCircleFrame;

implementation

{$R *.fmx}

uses UnitConstante, uEnum.Helper;

constructor TCircleFrame.Create(AOwner: TComponent);
begin
  inherited;
  Self.Circle.Fill.Color := CurrentTheme.ColorBackGround;
end;

procedure TCircleFrame.TrackBarChange(Sender: TObject);
begin
  LineCircle.EndAngle := 0;
  TAnimator.AnimateFloat(LineCircle, 'EndAngle', TrackBar.Value * 360 / 100, 1,
    TAnimationType.Out, TInterpolationType.Linear);
end;

end.
