unit uRanking;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.ImgList, FMX.Objects,
  FMX.Controls.Presentation, System.ImageList, FMX.Layouts;

type
  TRankingFrame = class(TFrame)
    Rect_Ranking: TRectangle;
    lblPosition: TLabel;
    Circle_Perfil: TCircle;
    lblName: TLabel;
    Circle_Country: TCircle;
    img_Country: TGlyph;
    lblPoints: TLabel;
    ilCountry: TImageList;
    Lay_Dados: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  RankingFrame: TRankingFrame;

implementation

{$R *.fmx}

uses UnitConstante, uEnum.Helper;

{ TRankingFrame }

constructor TRankingFrame.Create(AOwner: TComponent);
begin
  inherited;
  Rect_Ranking.Height := cRectHeight;
  Rect_Ranking.Fill.Color := CurrentTheme.ColorRecLanguage;
  Rect_Ranking.XRadius := XRadius;
  Rect_Ranking.YRadius := YRadius;
end;

end.
